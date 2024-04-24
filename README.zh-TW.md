<h1>
  <img src="https://github.com/Portal-2-Multiplayer-Mod/P2MM-ART/blob/e56d8c209eb3f143bb0607dc1e59730e517ecca6/Banners/P2MMBannerREADME.png?raw=true" alt="P2MMBannerREADME" width="472" height="290" align="left">
  <a href="https://discord.gg/nXRygGNxyK" target="_blank">
      <img src="https://img.shields.io/discord/839651379034193920?color=blue&label=Discord%20Users&style=for-the-badge&logo=discord&logoWidth=20"
              alt="Discord Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest">
      <img src="https://img.shields.io/github/release-date/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?color=red&label=Latest%20Release&style=for-the-badge"
              alt="Release Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <img src="https://img.shields.io/github/downloads/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/total?style=for-the-badge&label=TOTAL%20DOWNLOAD%20COUNT"
          alt="Download Count Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/main">
      <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?label=LAST%20COMMIT%20(MAIN)&style=for-the-badge"
              alt="Commit Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/dev">
      <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/dev?style=for-the-badge&label=LAST%20COMMIT%20(DEV)&color=%2334a5eb"
              alt="GitHub last commit (branch)" align="right">
  </a>
  <br>
  <br>
  <p align="right">PORTAL 2:</p>
  <p align="right">MULTIPLAYER MOD</p>
</h1>

### 該模組僅服務端使用。只有伺服器管理員需要安裝該模組至 Portal 2 來執行。其他玩家僅需使用原版即可進入該伺服器。

## 語言

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | **_繁體中文_** | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md)

## 模組功能

```
  - 最多支持 33 名玩家
  - 名称标签
  - 自定义玩家颜色
  - 聊天命令（!help）
  - 游戏内管理员系统
  - 完全合作剧情支持
  - 完全单人剧情支持（需要轻微打磨）
  - 完全支持 Super 8 地图
  - 内部地图支持选定的创意工坊地图
  - 加密客户端通过活动 GameRules 类触发的命令
  - 支持 Linux、Windows 10 及以上版本
  - 通过 VScript 和自定义插件暴露的可切换游戏选项和配置系统
  - 支持 SAR（SourceAutoRecord）用于速通
```

# 安装与使用

**有关设置 P2:MM 的维基指南：**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

**下载最新版本：**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal2-Multiplayer-Mod/releases/latest>

**Discord 服务器提供技术帮助（确保您阅读了常见问题解答！）、错误报告或仅聊天：**

- <https://discord.gg/kW3nG6GKpF>

# 构建启动器

## 依赖项

- Python 3.10
- pygame
- requests
- steamid-converter

我们还在一个文件中提供了它们以便轻松安装：`pip install -r requirements.txt`

## 編譯

我们使用 `pyinstaller` 和 `AppImage` 来制作可执行文件！

### Windows：

对于 Windows，我们仅使用 [pyinstaller](https://pypi.org/project/pyinstaller/) 来构建可执行文件（如果您知道更好的选项，请告诉我们）。

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux：

对于 Linux，我们转而使用 [AppImage](https://appimage.org/) 并制作了一个工具来帮助，只需安装 `docker` 并在根目录中运行 `./tools/build-docker.sh`。

***警告！由于某种原因，在某些 Linux 发行版上，默认未安装 FUSE，而这是编译和运行 AppImages 所需的。您可以在此处找到有关在您的发行版上安装 FUSE 的信息：[AppImageKit's Wiki](https://github.com/AppImage/AppImageKit/wiki/FUSE)***

如果您不想使用 AppImage/docker，仍然可以使用 pyinstaller：

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/Languages:Languages"
```

### 注意：

- 如果您想分叉该项目并进行自己的发布，您需要更改 `src/Scripts/Updater.py` 顶部的变量以符合您自己的信息，并更新 `AppImageBuilder.yml` 中的值。

# P2:MM 插件

Portal 2: Multiplayer Mod 使用了一个独立的 Source Engine 服务器插件，以便连接到 Portal 2 并修补游戏，使某些系统可以运行 VScript 通常无法做到的操作。由于 Source Engine 插件的开发和编译环境的特性，该插件已放置在一个单独的存储库中。您可以在这里找到其源代码：<https://github.com/OrsellGaming/Portal-2-Multiplayer-Mod-Plugin>

# 贡献

Portal 2: Multiplayer Mod 版本 `2.3.0` 将是我们的最终版本，因此我们不会在完全发布后进行任何重大更新。在此之前，我们将致力于向完整版本迈进的小更新。在此期间，我们将接受对 P2:MM 的任何实质性变更或功能。然而，在完全发布之后，我们将不再接受任何重大更改。我们将只会在有人贡献新的翻译、改进当前翻译、其他我们未发现的小 bug 修复或创意工坊地图的地图支持文件时才会发布新版本。我们只会在这些情况下发布新版本，并不再接受任何重大更改。但是，您仍然可以分叉它以构建基于我们工作的项目！请确保您给予本存储库适当的信用！

# 鸣谢

**开发人员：**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**贡献者：**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
- Areng
