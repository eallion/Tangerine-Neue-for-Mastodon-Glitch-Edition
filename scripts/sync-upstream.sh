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

  if $DRY_RUN; then
    info "(dry-run) 将运行: node scripts/sync-glitch-variants.mjs"
    return 0
  fi

  node "$REPO_ROOT/scripts/sync-glitch-variants.mjs"
  ok "glitch 变体文件已同步完成"
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
