#!/usr/bin/env bash
#
# sync-upstream.sh — 将上游更新同步到 glitch 分支
#
# 流程：
#   1. main 分支严格同步上游（保持 commit hash 一致）
#   2. 将 upstream/main 合并到 glitch 分支
#   3. 将上游对基础 CSS/SCSS 的改动同步到 *-glitch 变体文件
#
# 用法：
#   ./scripts/sync-upstream.sh          # 完整同步
#   ./scripts/sync-upstream.sh --dry-run # 仅预览，不执行
#   ./scripts/sync-upstream.sh --step1   # 仅执行步骤1（同步 main）
#   ./scripts/sync-upstream.sh --step2   # 仅执行步骤2（合并到 glitch）
#   ./scripts/sync-upstream.sh --step3   # 仅执行步骤3（同步 glitch 变体）
#
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DRY_RUN=false
STEP=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --step1)   STEP="1"; shift ;;
    --step2)   STEP="2"; shift ;;
    --step3)   STEP="3"; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# ── 基础 CSS → glitch 变体的映射 ──────────────────────────────────
# 格式: "基础文件|glitch文件"
CSS_MAP=(
  "TangerineUI.css|TangerineUI-glitch.css"
  "TangerineUI-cherry.css|TangerineUI-cherry-glitch.css"
  "TangerineUI-granite.css|TangerineUI-granite-glitch.css"
  "TangerineUI-lagoon.css|TangerineUI-lagoon-glitch.css"
  "TangerineUI-purple.css|TangerineUI-purple-glitch.css"
)

SCSS_MAP=(
  "mastodon/app/javascript/styles/tangerineui/tangerineui.scss|mastodon/app/javascript/styles/tangerineui-glitch/tangerineui-glitch.scss"
  "mastodon/app/javascript/styles/tangerineui-cherry/tangerineui-cherry.scss|mastodon/app/javascript/styles/tangerineui-cherry-glitch/tangerineui-cherry-glitch.scss"
  "mastodon/app/javascript/styles/tangerineui-granite/tangerineui-granite.scss|mastodon/app/javascript/styles/tangerineui-granite-glitch/tangerineui-granite-glitch.scss"
  "mastodon/app/javascript/styles/tangerineui-lagoon/tangerineui-lagoon.scss|mastodon/app/javascript/styles/tangerineui-lagoon-glitch/tangerineui-lagoon-glitch.scss"
  "mastodon/app/javascript/styles/tangerineui-purple/tangerineui-purple.scss|mastodon/app/javascript/styles/tangerineui-purple-glitch/tangerineui-purple-glitch.scss"
)

# ── 工具函数 ──────────────────────────────────────────────────────
info()  { echo -e "\033[1;34m[INFO]\033[0m  $*"; }
ok()    { echo -e "\033[1;32m[OK]\033[0m    $*"; }
warn()  { echo -e "\033[1;33m[WARN]\033[0m  $*"; }
err()   { echo -e "\033[1;31m[ERROR]\033[0m $*" >&2; }

run() {
  if $DRY_RUN; then
    info "(dry-run) $*"
  else
    "$@"
  fi
}

# ── 步骤 1: main 同步上游 ─────────────────────────────────────────
step1_sync_main() {
  info "步骤 1: 同步 main 分支到上游"

  cd "$REPO_ROOT"

  # 确保在 main 分支
  current=$(git branch --show-current)
  if [[ "$current" != "main" ]]; then
    warn "当前不在 main 分支（当前: $current），切换到 main"
    run git checkout main
  fi

  # 拉取上游
  run git fetch upstream

  # 检查是否有新提交
  behind=$(git rev-list --count HEAD..upstream/main 2>/dev/null || echo 0)
  if [[ "$behind" -eq 0 ]]; then
    ok "main 已经是最新，无需同步"
    return 0
  fi

  info "main 落后上游 $behind 个提交，重置到上游"
  run git reset --hard upstream/main
  ok "main 已同步到 upstream/main ($(git rev-parse --short HEAD))"
}

# ── 步骤 2: 合并到 glitch ────────────────────────────────────────
step2_merge_to_glitch() {
  info "步骤 2: 将 upstream/main 合并到 glitch 分支"

  cd "$REPO_ROOT"

  current=$(git branch --show-current)
  if [[ "$current" != "glitch" ]]; then
    run git checkout glitch
  fi

  # 检查是否需要合并
  merge_base=$(git merge-base HEAD upstream/main 2>/dev/null || echo "")
  upstream_head=$(git rev-parse upstream/main 2>/dev/null || echo "")

  if [[ "$merge_base" == "$upstream_head" ]]; then
    ok "glitch 已包含所有上游提交，无需合并"
    return 0
  fi

  ahead=$(git rev-list --count upstream/main..HEAD 2>/dev/null || echo 0)
  behind=$(git rev-list --count HEAD..upstream/main 2>/dev/null || echo 0)
  info "glitch: ahead $ahead, behind $behind"

  if $DRY_RUN; then
    info "(dry-run) 将执行: git merge upstream/main -m 'Merge upstream/main into glitch'"
  else
    # 尝试合并，如果有冲突则中止
    if git merge upstream/main -m "Merge upstream/main into glitch" 2>/dev/null; then
      ok "合并完成，无冲突"
    else
      err "合并存在冲突，请手动解决后运行: git merge --continue"
      err "或者放弃合并: git merge --abort"
      return 1
    fi
  fi
}

# ── 步骤 3: 同步 glitch 变体文件 ──────────────────────────────────
step3_sync_glitch_variants() {
  info "步骤 3: 将上游改动同步到 *-glitch 变体文件"

  cd "$REPO_ROOT"

  local changed_files=()

  # 获取 upstream/main 相对于上一个合并基准的变更文件
  local merge_base
  merge_base=$(git merge-base HEAD upstream/main~1 2>/dev/null || git rev-parse upstream/main~1 2>/dev/null || echo "")

  if [[ -z "$merge_base" ]]; then
    # 如果找不到基准，比较 upstream/main~1..upstream/main
    mapfile -t changed_files < <(git diff --name-only upstream/main~1..upstream/main 2>/dev/null || true)
  else
    mapfile -t changed_files < <(git diff --name-only "$merge_base"..upstream/main 2>/dev/null || true)
  fi

  if [[ ${#changed_files[@]} -eq 0 ]]; then
    ok "没有检测到上游变更文件，跳过步骤 3"
    return 0
  fi

  info "上游变更的文件:"
  for f in "${changed_files[@]}"; do
    echo "  - $f"
  done

  local synced=0

  # 同步 CSS 文件
  for mapping in "${CSS_MAP[@]}"; do
    IFS='|' read -r base_file glitch_file <<< "$mapping"

    # 检查基础文件是否在上游变更中
    if ! printf '%s\n' "${changed_files[@]}" | grep -qx "$base_file"; then
      continue
    fi

    if [[ ! -f "$base_file" ]]; then
      warn "基础文件不存在: $base_file"
      continue
    fi
    if [[ ! -f "$glitch_file" ]]; then
      warn "glitch 文件不存在: $glitch_file"
      continue
    fi

    info "同步: $base_file → $glitch_file"

    # 提取上游对基础文件的改动（纯增量，不覆盖 glitch 特有内容）
    # 策略：对比上游改动前后，提取新增/修改的 CSS 规则，应用到 glitch 文件
    if ! $DRY_RUN; then
      # 获取上游在这个文件中改了什么
      local diff_content
      diff_content=$(git diff upstream/main~1..upstream/main -- "$base_file" 2>/dev/null || true)

      if [[ -z "$diff_content" ]]; then
        warn "无法获取 $base_file 的差异，跳过"
        continue
      fi

      # 提取新增的行（+ 开头，去掉 + 号）
      local additions
      additions=$(echo "$diff_content" | grep '^+' | grep -v '^+++' | sed 's/^+//' || true)

      if [[ -z "$additions" ]]; then
        info "  没有新增内容，跳过"
        continue
      fi

      # 对每个新增内容，检查是否已经存在于 glitch 文件中
      local new_rules=0
      while IFS= read -r line; do
        # 跳过空行和纯注释行的检查（注释总是安全添加的）
        if [[ -z "$line" ]]; then
          continue
        fi
        # 检查这行是否已在 glitch 文件中
        if ! grep -qF "$line" "$glitch_file" 2>/dev/null; then
          ((new_rules++))
        fi
      done <<< "$additions"

      if [[ $new_rules -eq 0 ]]; then
        info "  所有改动已存在于 glitch 文件中，跳过"
        continue
      fi

      info "  发现 $new_rules 条新规则需要同步"

      # 提取 upstream 对基础文件新增的 CSS 块
      # 使用 diff 提取 @@ ... @@ 之间的新增块
      local hunk_headers
      hunk_headers=$(echo "$diff_content" | grep '^@@' || true)

      if [[ -z "$hunk_headers" ]]; then
        warn "  无法解析 diff hunk，跳过"
        continue
      fi

      # 逐个 hunk 处理
      local in_hunk=false
      local current_additions=""
      local context_before=""

      while IFS= read -r line; do
        if [[ "$line" == @@* ]]; then
          # 处理上一个 hunk 的积累
          if [[ -n "$current_additions" ]]; then
            # 在 glitch 文件中查找插入点（基于 context_before）
            _apply_hunk "$glitch_file" "$context_before" "$current_additions"
          fi
          current_additions=""
          context_before=""
          in_hunk=true
        elif $in_hunk; then
          if [[ "$line" == -* ]]; then
            # 删除的行 - 用作上下文查找
            context_before=$(echo "$line" | sed 's/^-//')
          elif [[ "$line" == +* ]]; then
            local added=$(echo "$line" | sed 's/^+//')
            current_additions+="$added"$'\n'
          elif [[ "$line" == " "* ]]; then
            context_before=$(echo "$line" | sed 's/^ //')
          fi
        fi
      done <<< "$diff_content"

      # 处理最后一个 hunk
      if [[ -n "$current_additions" ]]; then
        _apply_hunk "$glitch_file" "$context_before" "$current_additions"
      fi
    fi

    ((synced++))
  done

  # 同步 SCSS 文件
  for mapping in "${SCSS_MAP[@]}"; do
    IFS='|' read -r base_file glitch_file <<< "$mapping"

    if ! printf '%s\n' "${changed_files[@]}" | grep -qx "$base_file"; then
      continue
    fi

    if [[ ! -f "$base_file" ]] || [[ ! -f "$glitch_file" ]]; then
      continue
    fi

    info "同步 SCSS: $base_file → $glitch_file"

    if ! $DRY_RUN; then
      local diff_content
      diff_content=$(git diff upstream/main~1..upstream/main -- "$base_file" 2>/dev/null || true)

      if [[ -z "$diff_content" ]]; then
        continue
      fi

      # 对 SCSS 文件使用相同策略
      local hunk_headers
      hunk_headers=$(echo "$diff_content" | grep '^@@' || true)

      local in_hunk=false
      local current_additions=""
      local context_before=""

      while IFS= read -r line; do
        if [[ "$line" == @@* ]]; then
          if [[ -n "$current_additions" ]]; then
            _apply_hunk "$glitch_file" "$context_before" "$current_additions"
          fi
          current_additions=""
          context_before=""
          in_hunk=true
        elif $in_hunk; then
          if [[ "$line" == -* ]]; then
            context_before=$(echo "$line" | sed 's/^-//')
          elif [[ "$line" == +* ]]; then
            local added=$(echo "$line" | sed 's/^+//')
            current_additions+="$added"$'\n'
          elif [[ "$line" == " "* ]]; then
            context_before=$(echo "$line" | sed 's/^ //')
          fi
        fi
      done <<< "$diff_content"

      if [[ -n "$current_additions" ]]; then
        _apply_hunk "$glitch_file" "$context_before" "$current_additions"
      fi
    fi

    ((synced++))
  done

  if [[ $synced -eq 0 ]]; then
    ok "没有需要同步的 glitch 变体文件"
  else
    ok "已同步 $synced 个 glitch 变体文件"
  fi
}

# ── 应用 hunk 到 glitch 文件 ──────────────────────────────────────
_apply_hunk() {
  local target_file="$1"
  local context_line="$2"
  local additions="$3"

  if [[ -z "$context_line" ]] || [[ -z "$additions" ]]; then
    return 0
  fi

  # 检查是否所有新增内容都已存在
  local all_exist=true
  while IFS= read -r line; do
    if [[ -n "$line" ]] && ! grep -qF "$line" "$target_file" 2>/dev/null; then
      all_exist=false
      break
    fi
  done <<< "$additions"

  if $all_exist; then
    return 0
  fi

  # 查找 context_line 在 glitch 文件中的位置
  local line_num
  line_num=$(grep -nF "$context_line" "$target_file" 2>/dev/null | head -1 | cut -d: -f1 || echo "")

  if [[ -z "$line_num" ]]; then
    # 尝试模糊匹配（去掉多余空格）
    local fuzzy_context
    fuzzy_context=$(echo "$context_line" | sed 's/  */ /g; s/^ //; s/ $//')
    line_num=$(grep -nF "$fuzzy_context" "$target_file" 2>/dev/null | head -1 | cut -d: -f1 || echo "")
  fi

  if [[ -z "$line_num" ]]; then
    warn "  无法在 $(basename "$target_file") 中找到上下文: ${context_line:0:60}..."
    return 0
  fi

  # 在找到的行之后插入新增内容
  local insert_line=$((line_num))

  # 查找这个选择器块的结束位置（下一个 } ）
  local block_end
  block_end=$(awk -v start="$line_num" 'NR > start && /^[[:space:]]*\}/ { print NR; exit }' "$target_file" || echo "")

  if [[ -n "$block_end" ]]; then
    insert_line=$block_end
  fi

  # 构建要插入的文本（跳过已存在的行）
  local insert_text=""
  while IFS= read -r line; do
    if [[ -n "$line" ]] && ! grep -qF "$line" "$target_file" 2>/dev/null; then
      insert_text+="$line"$'\n'
    fi
  done <<< "$additions"

  if [[ -n "$insert_text" ]]; then
    # 使用 sed 在指定行后插入
    local escaped_text
    escaped_text=$(echo "$insert_text" | sed 's/[&/\]/\\&/g; s/$/\\/' | sed '$ s/\\$//')
    sed -i "${insert_line}a\\${escaped_text}" "$target_file"
    info "  在 $(basename "$target_file"):${insert_line} 后插入了新规则"
  fi
}

# ── 主流程 ────────────────────────────────────────────────────────
main() {
  info "========================================="
  info "  Tangerine-Neue Glitch 同步脚本"
  info "========================================="
  echo ""

  if $DRY_RUN; then
    warn "DRY-RUN 模式：仅预览，不执行任何修改"
    echo ""
  fi

  cd "$REPO_ROOT"

  case "${STEP:-}" in
    1) step1_sync_main ;;
    2) step2_merge_to_glitch ;;
    3) step3_sync_glitch_variants ;;
    "")
      step1_sync_main
      echo ""
      step2_merge_to_glitch
      echo ""
      step3_sync_glitch_variants
      ;;
    *) err "未知步骤: $STEP"; exit 1 ;;
  esac

  echo ""
  ok "同步完成！"
  echo ""
  info "当前状态:"
  git status --short
  echo ""
  info "分支: $(git branch --show-current)"
  info "最新提交: $(git log --oneline -1)"
}

main "$@"
