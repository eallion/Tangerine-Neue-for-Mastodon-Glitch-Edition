# Tangerine-Neue for Mastodon Glitch Edition

## 分支管理规则

- **main** — 严格同步上游，commit hash 与 upstream/main 保持一致，不接受任何 glitch 修改
- **glitch** — Glitch 版本开发分支，所有定制化修改只在 glitch 上

## 同步流程

上游更新时，按以下顺序同步：

1. `main` 重置到 `upstream/main`（严格一致）
2. `upstream/main` 合并到 `glitch` 分支
3. 将上游对基础 CSS/SCSS 的改动同步到 `*-glitch` 变体文件

## 自动同步脚本

```bash
./scripts/sync-upstream.sh            # 完整同步（步骤 1→2→3）
./scripts/sync-upstream.sh --dry-run  # 仅预览，不执行
./scripts/sync-upstream.sh --step1    # 仅同步 main
./scripts/sync-upstream.sh --step2    # 仅合并到 glitch
./scripts/sync-upstream.sh --step3    # 仅同步 glitch 变体文件
```

## Glitch 变体文件映射

| 基础文件 | Glitch 变体 |
|---------|------------|
| `TangerineUI.css` | `TangerineUI-glitch.css` |
| `TangerineUI-cherry.css` | `TangerineUI-cherry-glitch.css` |
| `TangerineUI-granite.css` | `TangerineUI-granite-glitch.css` |
| `TangerineUI-lagoon.css` | `TangerineUI-lagoon-glitch.css` |
| `TangerineUI-purple.css` | `TangerineUI-purple-glitch.css` |
| `mastodon/app/javascript/styles/tangerineui/tangerineui.scss` | `mastodon/app/javascript/styles/tangerineui-glitch/tangerineui-glitch.scss` |
| `mastodon/app/javascript/styles/tangerineui-cherry/tangerineui-cherry.scss` | `mastodon/app/javascript/styles/tangerineui-cherry-glitch/tangerineui-cherry-glitch.scss` |
| `mastodon/app/javascript/styles/tangerineui-granite/tangerineui-granite.scss` | `mastodon/app/javascript/styles/tangerineui-granite-glitch/tangerineui-granite-glitch.scss` |
| `mastodon/app/javascript/styles/tangerineui-lagoon/tangerineui-lagoon.scss` | `mastodon/app/javascript/styles/tangerineui-lagoon-glitch/tangerineui-lagoon-glitch.scss` |
| `mastodon/app/javascript/styles/tangerineui-purple/tangerineui-purple.scss` | `mastodon/app/javascript/styles/tangerineui-purple-glitch/tangerineui-purple-glitch.scss` |

## Glitch 文件与基础文件的差异

Glitch 变体文件与基础文件有以下结构性差异，同步时需注意：

- **色彩方案机制**：基础文件用 `[data-color-scheme="dark"]`（Mastodon 4.6），glitch 文件用 `@media (prefers-color-scheme: dark)`
- **SVG 图标**：使用不同的图标集（Phosphor 风格）
- **Logo 处理**：不同的 logo 变量和渲染方式
- **额外规则**：glitch 文件包含 `html[data-user-flavour="glitch"]` 作用域的修复样式

同步时只复制**布局、间距、功能性**的改动，不要覆盖 glitch 特有的样式差异。

## Git 远程仓库

- `origin` — 个人 fork（eallion/Tangerine-Neue-for-Mastodon-Glitch-Edition）
- `upstream` — 上游仓库（panchenko/Tangerine-Neue）

## 禁止事项

- 禁止将 glitch 修改推送到 main 分支
- 禁止直接修改 main 分支的代码
