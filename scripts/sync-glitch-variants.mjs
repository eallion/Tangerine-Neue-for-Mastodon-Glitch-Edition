#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';

const REPO_ROOT = path.resolve(import.meta.dirname, '..');

const VARIANTS = [
  { suffix: '', scssDir: 'tangerineui-glitch', name: 'Tangerine UI (Glitch)' },
  { suffix: '-cherry', scssDir: 'tangerineui-cherry-glitch', name: 'Tangerine UI Cherry (Glitch)' },
  { suffix: '-granite', scssDir: 'tangerineui-granite-glitch', name: 'Tangerine UI Granite (Glitch)' },
  { suffix: '-lagoon', scssDir: 'tangerineui-lagoon-glitch', name: 'Tangerine UI Lagoon (Glitch)' },
  { suffix: '-purple', scssDir: 'tangerineui-purple-glitch', name: 'Tangerine UI Purple (Glitch)' },
];

const ANCHOR = 'body.app-body  {';

// 读取已更新好的 TangerineUI-glitch.css 作为基准
const primaryGlitchPath = path.join(REPO_ROOT, 'TangerineUI-glitch.css');
if (!fs.existsSync(primaryGlitchPath)) {
  console.error(`Error: ${primaryGlitchPath} not found`);
  process.exit(1);
}

const primaryContent = fs.readFileSync(primaryGlitchPath, 'utf8');
const anchorIndex = primaryContent.indexOf(ANCHOR);
if (anchorIndex === -1) {
  console.error(`Error: Anchor "${ANCHOR}" not found in ${primaryGlitchPath}`);
  process.exit(1);
}

const sharedRules = primaryContent.slice(anchorIndex);

console.log(`[INFO] Extracting shared rules from TangerineUI-glitch.css (${sharedRules.length} chars, ~${sharedRules.split('\n').length} lines)`);

for (const v of VARIANTS) {
  const cssFile = path.join(REPO_ROOT, `TangerineUI${v.suffix}-glitch.css`);
  if (!fs.existsSync(cssFile)) {
    console.warn(`[WARN] File not found: ${cssFile}`);
    continue;
  }

  const existingContent = fs.readFileSync(cssFile, 'utf8');
  const existingAnchorIndex = existingContent.indexOf(ANCHOR);
  if (existingAnchorIndex === -1) {
    console.error(`[ERROR] Anchor "${ANCHOR}" not found in ${cssFile}`);
    continue;
  }

  // 保留前部的变量声明，并更新版本号为 v2.6.5
  let header = existingContent.slice(0, existingAnchorIndex);
  header = header.replace(/--version:\s*"[^"]+";/, '--version: "v2.6.5";');

  const finalContent = header + sharedRules;

  // 1. 写回根目录 CSS
  fs.writeFileSync(cssFile, finalContent, 'utf8');

  // 2. 写回 mastodon/app/javascript/styles/...
  const scssDirPath = path.join(REPO_ROOT, 'mastodon', 'app', 'javascript', 'styles', v.scssDir);
  fs.mkdirSync(scssDirPath, { recursive: true });
  fs.writeFileSync(path.join(scssDirPath, `${v.scssDir}.scss`), finalContent, 'utf8');

  // 3. 顶级 entry scss
  const entryScss = path.join(REPO_ROOT, 'mastodon', 'app', 'javascript', 'styles', `${v.scssDir}.scss`);
  fs.writeFileSync(entryScss, `@use 'application';\n@use '${v.scssDir}/${v.scssDir}';\n`, 'utf8');

  // 4. Glitch skin 目录与配置
  const skinDirPath = path.join(REPO_ROOT, 'mastodon', 'app', 'javascript', 'skins', 'glitch', v.scssDir);
  fs.mkdirSync(skinDirPath, { recursive: true });
  fs.writeFileSync(path.join(skinDirPath, 'common.scss'), `@use '@/styles/${v.scssDir}';\n`, 'utf8');
  fs.writeFileSync(path.join(skinDirPath, 'names.yml'), `en:\n  skins:\n    glitch:\n      ${v.scssDir}: ${v.name}\n`, 'utf8');

  console.log(`[OK] Synced ${cssFile} & ${scssDirPath}/${v.scssDir}.scss`);
}

console.log('[OK] All glitch variants synced successfully!');
