<h1>
 <picture>
  <source media="(prefers-color-scheme: dark)" srcset="./art/Logo_Wide_Dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./art/Logo_Wide.png?raw=true">
  <img alt="Tangerine UI for Mastodon" src="./art/Logo_Wide.png?raw=true" height="110">
 </picture>
</h1>

Tangerine Neue 是 Mastodon Web UI 的自定义主题，提供五种配色：🍊 柑橘、🪻 紫色、🍒 樱桃、🐠 碧蓝 和 🪨 花岗岩。它是 [**Tangerine UI for Mastodon**](https://github.com/nileane/TangerineUI-for-Mastodon) 的一个分支（原作者 [@nileane](https://nileane.fr/@nileane)），在原始项目 [停止维护](https://nileane.fr/@TangerineUI/116776620945959421) 后继续开发。

## 0. 开始之前

所有原始设计和绝大部分工作归功于 [@nileane](https://nileane.fr/@nileane)。如果喜欢，[请给她打赏](https://ko-fi.com/nileane)！

当前维护者：[@matt_birchler@mastodon.social](https://mastodon.social/@matt_birchler)。

## 1. 目录

1. [**目录**](#1-目录)
2. [**概览**](#2-概览)  
   2.a [配色变体](#2a-配色变体)  
   2.b [功能特性](#2b-功能特性)  
   2.c [使用 Tangerine UI 的实例列表](#2c-使用-tangerine-ui-的实例列表)
3. [**兼容性**](#3-兼容性)
4. [**Mastodon 管理员安装指南**](#4-mastodon-管理员安装指南)  
   4.a [作为可选主题安装 \[推荐\]](#4a-作为可选主题安装推荐)  
   4.b [作为唯一主题安装](#4b-作为唯一主题安装)
5. [**普通用户安装指南**](#5-普通用户安装指南非管理员)
6. [**无障碍**](#6-无障碍)
7. [**开发**](#7-开发)
8. [**致谢**](#8-致谢)

## 2. 概览

### 2.a 配色变体

**🍊 柑橘**  
Tangerine Neue 的默认变体，顾名思义，看起来像柑橘。

<img width="1784" alt="TangerineUI-tangerine" src="./art/Screenshots/TangerineUI-tangerine.png">  
&nbsp;

**🪻 紫色**  
适合喜欢柑橘但想保留 Mastodon 经典紫色的你。

<img width="1784" alt="TangerineUI-purple" src="./art/Screenshots/TangerineUI-purple.png">  
&nbsp;

**🍒 樱桃**  
如果你忍不住舔屏幕，我可不对后果负责。

<img width="1784" alt="TangerineUI-cherry" src="./art/Screenshots/TangerineUI-cherry.png">  
&nbsp;

**🐠 碧蓝**  
柔和的蓝绿色调，夜晚散发出霓虹感。

<img width="1784" alt="TangerineUI-lagoon" src="./art/Screenshots/TangerineUI-lagoon.png">  
&nbsp;

**🪨 花岗岩**  
实话实说，这就是男士专属的 Tangerine，抱歉啦。

<img width="1784" alt="TangerineUI-granite" src="./art/Screenshots/TangerineUI-granite.png">  
&nbsp;

### 2.b 功能特性

🧑‍🔬 **支持高级网页界面**  
Tangerine Neue 的所有变体都支持 Mastodon 的多列布局。

<img width="1840" alt="Mastodon 高级网页界面搭配 Tangerine Neue" src="https://github.com/nileane/TangerineUI-for-Mastodon/assets/914451/bfa74219-bfef-46ec-9742-78165593e2a6">

🚀 **有趣的动画**  
火箭会飞！

<img width="600" alt="点击转发按钮，火箭图标就像要起飞一样。点击收藏按钮，它会弹跳。点击书签按钮，它会垂直抖动。" src="https://github.com/nileane/TangerineUI-for-Mastodon/assets/914451/31d41d04-6ef1-4ef0-80c3-b4b445ee98a1">

<br>🌚 **深色模式**  
Tangerine Neue 会根据你的系统或浏览器偏好自动切换浅色/深色模式。[^1]
[^1]: Tangerine Neue 使用 [`prefers-color-scheme`](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme) CSS 媒体特性来检测你是否通过操作系统或用户代理设置请求了浅色或深色主题。

💬 **私信的独特外观**  
在 Mastodon 上，私信很容易与普通嘟文混淆。Tangerine Neue 赋予私信独特的外观，让它在时间线中脱颖而出，避免尴尬的错误。

👁️ **紧凑时间线**  
头像侧边对齐，边距合理压缩，对话线索更易阅读。

✴️ **Phosphor 图标**  
Tangerine Neue 精选了漂亮的 [Phosphor](https://phosphoricons.com) 图标家族。

🔍 **Emoji 放大查看**  
自定义 emoji 很棒，但过于细节丰富的 emoji 可能难以辨认。Tangerine Neue 允许你悬停 emoji 来放大查看。

✳️ **更多功能**  
Tangerine Neue 精心设计，注重细节。欢迎探索它为 Mastodon UI 带来的所有变化，如有任何反馈或 [问题报告](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/issues)，请随时 [联系我](https://mastodon.social/@matt_birchler)。 :)

### 2.c 使用 Tangerine UI 的实例列表

> 由于 Tangerine Neue 还很新，此列表仅显示已知安装了 Tangerine UI（而非 Tangerine Neue 本身）的实例。未来将更新为包含 Tangerine Neue 实例。

以下是已知安装了 Tangerine UI（作为唯一主题或可选主题）的 Mastodon 实例列表。[^2]
[^2]: 如果你是管理员且已在你的实例上安装了 Tangerine UI，**欢迎将你的实例添加到这个列表中**。（提交 Pull Request，或直接 [私信我](https://mastodon.social/@matt_birchler)）

| **实例**                                                 | **用户数** | **安装方式**   | **默认主题？**        |
| -------------------------------------------------------- | ---------- | -------------- | --------------------- |
| [hachyderm.io](https://hachyderm.io)                     | 8.5K+      | 可选主题        | 否                    |
| [piaille.fr](https://piaille.fr)                         | 8.5K+      | 可选主题        | 否                    |
| [social.vivaldi.net](https://social.vivaldi.net)         | 7K+        | 可选主题        | 否                    |
| [norden.social](https://norden.social)                   | 3K+        | 可选主题        | 否                    |
| [wxw.moe](https://wxw.moe)                               | 3K+        | 可选主题        | 否                    |
| [c.im](https://c.im)                                     | 2K+        | 可选主题        | 否                    |
| [ani.work](https://ani.work)                             | 2K+        | 可选主题        | 是（樱桃变体）       |
| [masto.es](https://masto.es)                             | 1.5K+      | 可选主题        | 否                    |
| [eldritch.cafe](https://eldritch.cafe)                   | 1K+        | 可选主题        | 否                    |
| [framapiaf.org](https://framapiaf.org)                   | 1K+        | 可选主题        | 否                    |
| [social.lol](https://social.lol)                         | 850+       | 可选主题        | 是（柑橘变体）       |
| [toot.wales](https://toot.wales)                         | 650+       | 可选主题        | 是（柑橘变体）       |
| [shelter.moe](https://shelter.moe)                       | 300+       | 可选主题        | 是（柑橘变体）       |
| [vmst.io](https://vmst.io)                               | 250+       | 可选主题        | 否                    |
| [mountains.social](https://mountains.social)             | 150+       | 可选主题        | 否                    |
| [tooter.social](https://tooter.social)                   | 150+       | 可选主题        | 否                    |
| [c7.io](https://c7.io)                                   | 100+       | 可选主题        | 是（柑橘变体）       |
| [convo.casa](https://convo.casa)                         | 100+       | 可选主题        | 否                    |
| [dmv.community](https://dmv.community)                   | 100+       | 可选主题        | 否                    |
| [mastodon.com.pl](https://mastodon.com.pl)               | 100+       | 可选主题        | 否                    |
| [town.voyager.blue](https://town.voyager.blue)           | 100+       | 可选主题        | 是（自定义变体）     |
| [pipou.academy](https://pipou.academy)                   | 80+        | 可选主题        | 否                    |
| [duk.space](https://duk.space)                           | 80+        | 可选主题        | 否                    |
| [pointless.chat](https://pointless.chat)                 | 70+        | 可选主题        | 是（柑橘变体）       |
| [toki.social](https://toki.social)                       | 70+        | 可选主题        | 否                    |
| [bolha.one](https://bolha.one)                           | 60+        | 可选主题        | 是（柑橘变体）       |
| [indiepocalypse.social](https://indiepocalypse.social)   | 50+        | 可选主题        | 否                    |
| [acg.mn](https://acg.mn)                                 | 30+        | 可选主题        | 否                    |
| [yttrx.com](https://yttrx.com)                           | 30+        | 可选主题        | 是（碧蓝变体）       |
| [asso.lgbt](https://asso.lgbt)                           | 20+        | 唯一主题        | 是（樱桃变体）       |
| [zeppelin.flights](https://zeppelin.flights)             | 20+        | 唯一主题        | 是（柑橘变体）       |
| [fedinerds.social](https://fedinerds.social)             | 10+        | 可选主题        | 否                    |
| [i1.no](https://i1.no)                                   | 10+        | 唯一主题        | 是（碧蓝变体）       |
| [ngmx.com](https://ngmx.com)                             | 10+        | 可选主题        | 否                    |
| [varese.social](https://varese.social)                   | 10+        | 可选主题        | 否                    |
| [catharsis.cafe](https://catharsis.cafe)                 | 5+         | 可选主题        | 是（柑橘变体）       |
| [erica.moe](https://erica.moe)                           | 5+         | 可选主题        | 是（紫色变体）       |
| [nileane.fr](https://nileane.fr)                         | 5+         | 唯一主题        | 是（柑橘变体）       |
| [social.nah.re](https://social.nah.re)                   | 5+         | 可选主题        | 否                    |
| [m.somincola.org](https://m.somincola.org)               | 5+         | 可选主题        | 是（紫色变体）       |
| [fedi.cyberwitches.club](https://fedi.cyberwitches.club) | 1+         | 唯一主题        | 是（樱桃变体）       |
| [e5n.cc](https://e5n.cc)                                 | 1+         | 可选主题        | 否                    |
| [isfeeling.social](https://isfeeling.social)             | 1+         | 唯一主题        | 是（紫色变体）       |
| [mastodon.projetretro.io](https://mastodon.projetretro.io)| 1+        | 可选主题        | 否                    |
| [m.heine.xyz](https://m.heine.xyz)                       | 1+         | 可选主题        | 是（柑橘变体）       |

## 3. 兼容性

根据 Mastodon 版本选择对应的主题：

| Mastodon 版本          | 使用说明                                                                                                                                    |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| **4.6 及更高版本**     | ✅ [**Tangerine Neue**](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/releases/latest) — 当前积极维护的主题[^3][^4]                     |
| **4.5._x_**            | [**Tangerine UI for Mastodon**](https://github.com/nileane/TangerineUI-for-Mastodon) — 原始主题；升级到 4.6+ 前使用                                     |
| **4.3._x_ – 4.4._x_**  | 🚫 不支持任何版本的主题                                                                                                                          |
| **4.1._x_ – 4.2._x_**  | 仅支持 [**Tangerine UI Legacy (v1.9)**](https://github.com/nileane/TangerineUI-for-Mastodon/tree/legacy)[^5][^6]                                   |
| **4.0._x_ 及更早版本** | 🚫 不支持任何版本的主题                                                                                                                          |

[^3]: Tangerine Neue (v2._x_) 也兼容运行基于当前 Mastodon 稳定版的 **Glitch-soc** 实例，在这些实例上需要[作为可选主题安装](#4-mastodon-管理员安装指南)。
[^4]: 运行 Mastodon 夜间版/alpha/beta 版本的实例不受官方支持。如果你在不稳定的 Mastodon 版本上使用 Tangerine Neue，欢迎[报告](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/issues)出现的 UI 问题。一般来说，由于维护者本人使用 mastodon.social，主题会跟随该实例运行的版本进行更新。
[^5]: Tangerine UI Legacy (v1.9) 不支持高级网页界面（多列布局），启用后会自动回退到 Mastodon 默认外观。
[^6]: Tangerine UI Legacy (v1.9) 不提供樱桃（Cherry）变体。

## 4. Mastodon 管理员安装指南

有两种方式在 Mastodon 实例上安装 Tangerine Neue：

- 作为**可选**主题 \[推荐\]
- 作为**唯一**主题

### 4.a 作为可选主题安装 [推荐]

按照以下说明将 Tangerine Neue 安装为 Mastodon 实例的可选主题。  
你的用户将能在网页外观设置中选择 Tangerine Neue。  
你也可以将 Tangerine Neue 设为所有人（包括未登录访客）的默认主题。

<details>
<summary><strong>⚙️ 使用内置脚本安装</strong></summary>

本仓库提供了一个基础安装脚本。  
可用于首次安装 Tangerine Neue，也可用于自动更新。

以 `mastodon` 用户身份运行以下命令，使用[内置脚本](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/install.sh.sample)安装：

1. **克隆** Tangerine Neue 仓库
```sh
git clone https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon.git ./TangerineUI
cd TangerineUI
```

2. **复制**安装脚本示例。
```sh
cp install.sh.sample install.sh
```

确保 `install.sh` 顶部的 Mastodon 目录路径正确：
  * 修改以 `MASTODON=` 开头的行，调整为你 Mastodon 安装目录的路径。
  * `TANGERINEUI=` 路径会自动从脚本所在位置检测，通常无需修改。

3. **运行**安装脚本。
```sh
./install.sh
```

可选参数：

* 使用 `--skip-confirm` 跳过所有确认提示：
```sh
./install.sh --skip-confirm
```

* 使用 `--main` 从主分支拉取最新提交安装。  
（默认情况下，脚本会安装 [最新稳定版](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/releases/latest)。）
```sh
./install.sh --main
```

* 如果正在 **Glitch-soc** 实例上安装，使用 `--glitch`（复制 glitch 皮肤并跳过 `themes.yml`）：
```sh
./install.sh --glitch
```

4. **重启** Mastodon 实例使改动生效。

现在你的用户应该可以在站点主题中选择 '*Tangerine Neue*'、'*Tangerine Neue (Purple)*'、'*Tangerine Neue (Cherry)*'、'*Tangerine Neue (Lagoon)*' 或 '*Tangerine Neue (Granite)*'：

![截图：在 Mastodon 外观设置中选择 Tangerine Neue 作为主题。](https://github.com/nileane/TangerineUI-for-Mastodon/assets/914451/8cce803c-099b-4f25-8e39-e1c0da3aa6dc)

管理员现在也可以在管理面板中将 Tangerine Neue 设为实例默认主题（访问 https://*domain*/admin/settings/appearance）：

![截图：在管理面板中选择 Tangerine Neue 作为 Mastodon 实例的默认主题。](https://github.com/nileane/TangerineUI-for-Mastodon/assets/914451/05fcbb53-54de-40e4-89bd-199107116dfc)

</details>

<details>
<summary><strong>⚙️ 手动安装</strong></summary>

1. **克隆** Tangerine Neue 仓库，并获取 [最新稳定版](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/releases/latest)：
```sh
git clone https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon.git ./TangerineUI
cd TangerineUI
git checkout $(git describe --tags $(git rev-list --tags --max-count=1))
```

2. **复制**文件：将 Tangerine Neue 仓库中的 `mastodon/app/javascript/styles/` 文件复制到你的 Mastodon 主题目录 `app/javascript/styles/`：
```sh
# 将 $LIVE 替换为你的 Mastodon 安装路径
cp -r ./mastodon/app/javascript/styles/* $LIVE/app/javascript/styles
```

3. **添加本地化名称**：将 Tangerine Neue 仓库中 `mastodon/config/locales/tangerineui.yml` 文件复制到你的 Mastodon 区域设置目录。这将为 Tangerine Neue 的每种变体提供多语言名称。[^7]
[^7]: 对于未包含的区域设置，Mastodon 会自动回退到英文名称。
```sh
# 将 $LIVE 替换为你的 Mastodon 安装路径
cp -r ./mastodon/config/locales/tangerineui.yml $LIVE/config/locales
```

4. **将 Tangerine Neue 添加到 `themes.yml`**。编辑 Mastodon 安装目录下的 `config/themes.yml` 文件，添加 5 行新配置：

```yml
default: styles/application.scss
contrast: styles/contrast.scss
mastodon-light: styles/mastodon-light.scss
tangerineui: styles/tangerineui.scss
tangerineui-purple: styles/tangerineui-purple.scss
tangerineui-cherry: styles/tangerineui-cherry.scss
tangerineui-lagoon: styles/tangerineui-lagoon.scss
tangerineui-granite: styles/tangerineui-granite.scss
```

5. **编译**资源：
```sh
# 将 $LIVE 替换为你的 Mastodon 安装路径
cd $LIVE
RAILS_ENV=production bundle exec rails assets:precompile
```

6. **重启** Mastodon 实例使改动生效。

现在你的用户应该可以在站点主题中选择 '*Tangerine Neue*'、'*Tangerine Neue (Purple)*'、'*Tangerine Neue (Cherry)*'、'*Tangerine Neue (Lagoon)*' 或 '*Tangerine Neue (Granite)*'：

![截图：在 Mastodon 外观设置中选择 Tangerine Neue 作为主题。](https://github.com/nileane/TangerineUI-for-Mastodon/assets/914451/8cce803c-099b-4f25-8e39-e1c0da3aa6dc)

管理员现在也可以在管理面板中将 Tangerine Neue 设为实例默认主题（访问 https://*domain*/admin/settings/appearance）：

![截图：在管理面板中选择 Tangerine Neue 作为 Mastodon 实例的默认主题。](https://github.com/nileane/TangerineUI-for-Mastodon/assets/914451/05fcbb53-54de-40e4-89bd-199107116dfc)

</details>

<details>
<summary>⚙️ 在 <strong>Glitch-soc 实例</strong>上安装</summary>

Tangerine Neue 支持 Glitch-soc 的功能和布局，可安装为 Vanilla 和 Glitch Edition 两种 flavour 的皮肤：

1. **克隆** Tangerine Neue 仓库，并获取 [最新稳定版](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/releases/latest)：
```sh
git clone https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon.git ./TangerineUI
cd TangerineUI
git checkout $(git describe --tags $(git rev-list --tags --max-count=1))
```

2. **复制** `mastodon/app/javascript/styles/` 中的文件到你的 Mastodon 主题目录 `app/javascript/styles/`：
```sh
# 将 $LIVE 替换为你的 Mastodon Glitch-soc 安装路径
cp -r ./mastodon/app/javascript/styles/* $LIVE/app/javascript/styles
```

3. **复制** `mastodon/app/javascript/skins/vanilla/` 中的文件到你的 Glitch-soc 皮肤目录 `app/javascript/skins/vanilla/`：
```sh
# 将 $LIVE 替换为你的 Mastodon Glitch-soc 安装路径
cp -r ./mastodon/app/javascript/skins/vanilla/* $LIVE/app/javascript/skins/vanilla
```

4. **编译**资源：
```sh
RAILS_ENV=production bundle exec rails assets:precompile
```

5. **重启**实例使改动生效。

你的用户现在可以在设置中的 Flavours → Vanilla Mastodon → Skin 下选择 Tangerine Neue 了。

![Glitch-soc 设置：Flavours → Vanilla Mastodon → Skin](https://github.com/nileane/TangerineUI-for-Mastodon/assets/914451/abd931ab-685a-4d55-aa24-cb6356a19a7c)

> **🧩 Tangerine Neue 现已支持 Glitch Edition flavour。**  
> 如需在 Glitch Edition flavour 下使用，还需复制 glitch 皮肤：
> 
> ```sh
> cp -r ./mastodon/app/javascript/skins/glitch/* $LIVE/app/javascript/skins/glitch
> ```
> 
> 之后用户便可在 *Flavours* → *Glitch Edition* → Skin 下选择 Tangerine Neue。

</details>

### 4.b 作为唯一主题安装

1. **检查你的 Mastodon 版本**。确保 Tangerine Neue 兼容你的 Mastodon 实例，请先参考[兼容性](#3-兼容性)部分。

2. 复制 🍊 [`TangerineUI.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI.css) 的内容粘贴到管理面板的 '***自定义 CSS***' 字段（访问 https://*domain*/admin/settings/appearance）。
   * 🪻 紫色变体请改用 [`TangerineUI-purple.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-purple.css)。
   * 🍒 樱桃变体请改用 [`TangerineUI-cherry.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-cherry.css)。
   * 🐠 碧蓝变体请改用 [`TangerineUI-lagoon.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-lagoon.css)。
   * 🪨 花岗岩变体请改用 [`TangerineUI-granite.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-granite.css)。
   * 🧩 在 **Glitch-soc** 实例上，请改用 `-glitch.css` 变体（如 🐠 [`TangerineUI-lagoon-glitch.css`]），以获得完整的 Glitch Edition flavour 支持。

> [!WARNING]
> **使用 '*自定义 CSS*' 字段应用 Tangerine Neue 将阻止实例上所有用户在外观设置中选择其他主题**（参见[无障碍](#6-无障碍)）。  
> 请确保你的用户对此达成共识。否则，请返回上一节（[4.a](#4a-作为可选主题安装推荐)）以可选主题方式安装。

## 5. 普通用户安装指南（非管理员）

即使你不是实例管理员，也可以通过浏览器扩展使用 Tangerine Neue：

1. **检查你的 Mastodon 版本**。确保 Tangerine Neue 兼容你的 Mastodon 实例，请先参考[兼容性](#3-兼容性)部分。
2. **安装浏览器扩展**，允许你在网页上注入 CSS，例如 [Stylus](https://add0n.com/stylus.html) 或 [Live CSS Editor](https://github.com/webextensions/live-css-editor)。
3. 复制 🍊 [`TangerineUI.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI.css) 的内容粘贴到扩展编辑器中。
   * 🪻 紫色变体请改用 [`TangerineUI-purple.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-purple.css)。
   * 🍒 樱桃变体请改用 [`TangerineUI-cherry.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-cherry.css)。
   * 🐠 碧蓝变体请改用 [`TangerineUI-lagoon.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-lagoon.css)。
   * 🪨 花岗岩变体请改用 [`TangerineUI-granite.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-granite.css)。

> [!IMPORTANT]
> 如果你在使用 Glitch-soc 实例，必须切换到 Vanilla Mastodon flavour 才能正常使用 Tangerine Neue：在实例设置中进入 *Flavours* → *Vanilla Mastodon* → 选择 '*Default*' 皮肤。

> 如果你希望保留 Glitch Edition flavour，请使用 `-glitch.css` 变体：
>
> 🍊 [`TangerineUI-glitch.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-glitch.css)
> 🪻 [`TangerineUI-purple-glitch.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-purple-glitch.css)
> 🍒 [`TangerineUI-cherry-glitch.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-cherry-glitch.css)
> 🐠 [`TangerineUI-lagoon-glitch.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-lagoon-glitch.css)
> 🪨 [`TangerineUI-granite-glitch.css`](https://github.com/mattbirchler/Tangerine-Neue-for-Mastodon/blob/main/TangerineUI-granite-glitch.css)

### 使用 UserScript 浏览器扩展

如果你偏好使用 UserScript 浏览器扩展，[@Write](https://github.com/Write) 维护了一个开箱即用的 UserScript，可在任何 Mastodon 实例上加载 Tangerine Neue。

* 查看 [TangerineUI-Userscript 仓库](https://github.com/Write/TangerineUI-Userscript) 获取说明。

## 6. 无障碍

在将 [Tangerine Neue 设为唯一主题](#4b-作为唯一主题安装)之前，请考虑部分用户可能依赖 Mastodon 的高对比度主题。因此，除非你运行的是单用户实例，我强烈建议[以可选/可回退方式安装](#4a-作为可选主题安装推荐)。

Tangerine Neue 确实支持高对比度（Mastodon 的高对比度设置或用户设备设置），但部分用户可能仍偏好使用默认的 Mastodon 高对比度主题。

## 7. 开发

五个 `TangerineUI*.css` 文件（以及 `mastodon/` 下的 `.scss` 安装副本）是**自动生成的**，请勿直接编辑。源代码位于 `src/`：

- `src/template.css` — 共享主题；各变体的值以 `{{占位符}}` 形式出现。
- `src/variants.mjs` — 每个变体的调色板、Logo、高对比度品牌色和元数据。

编辑上述任一文件后，运行 `node src/build.mjs`（无需依赖，仅需 Node）重新生成全部 10 个文件，然后提交。CI 会运行构建并在提交的输出过期时报告失败。

## 8. 致谢

Tangerine UI 的 Logo 最初由 [Younis @younishd](https://younishd.fr) 设计。🍊！

如开头所述，Tangerine UI 最初由 [Niléane](https://nileane.fr/@nileane) 设计。