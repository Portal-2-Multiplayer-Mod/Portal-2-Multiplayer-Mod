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

### 这个模组完全是服务器端的。只有主机需要安装了这个模组的 Portal 2。加入主机的人应该运行原版 Portal 2。

## 语言

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | **_简体中文_** | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md)

## 模组功能

- 最多支持 33 名玩家
- 名称标签
- 自定义玩家颜色
- 聊天命令 (!help)
- 游戏内管理员系统
- 完全合作剧情支持
- 完全单人剧情支持 (需要轻微打磨)
- 完全支持 Super 8 地图
- 内部地图支持选定的创意工坊地图
- 加密客户端通过活动 GameRules 类触发的命令
- 支持 Linux、Windows 10 及以上版本
- 通过 VScript 和自定义插件暴露的可切换游戏选项和配置系统
- 支持 SAR (SourceAutoRecord) 用于速通

# 安装与使用

**维基指南如何设置 P2:MM:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

**下载最新版本:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal2-Multiplayer-Mod/releases/latest>

**Discord 服务器提供技术帮助 (确保您阅读了常见问题解答!), 错误报告或仅聊天:**

- <https://discord.gg/kW3nG6GKpF>

# 构建启动器

## 依赖项

- Python 3.10
- pygame
- requests
- steamid-converter

我们还在一个文件中提供了它们以便轻松安装: `pip install -r requirements.txt`

## 编译

我们使用[`nuitka`](https://nuitka.net/), [`pyinstaller`](https://pypi.org/project/pyinstaller/), 和 [`AppImage`](https://appimage.org/) 来制作可执行文件。

### Windows:

对于 Windows，我们使用 `nuitka` 来创建我们的 `.exe` 文件。虽然编译速度比以前使用的 `pyinstaller` 慢，但它提供了更小的可执行文件大小，并且不会触发 Windows Defender。`pyinstaller` 仅应在 `nuitka` 无法正常工作时作为备份使用。两者都可以使用 `pip install` 进行安装。

下面是我们用来编译启动器的完整终端命令，下面是没有版本信息等的简化版本：

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

以下是使用 `pyinstaller` 编译的终端命令：

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm-icon.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux:

对于 Linux，我们转而使用 `AppImage` 并创建了一个工具来帮助这个过程，只需安装 `docker` 并在根目录下运行 `./tools/build-docker.sh` 即可。

_**警告！由于某种原因，在某些 Linux 发行版上，默认情况下未安装 FUSE，这对于编译和运行 AppImages 都是必需的。有关在您的发行版上安装 FUSE 的信息，请参阅这里：[AppImageKit 的 Wiki](https://github.com/AppImage/AppImageKit/wiki/FUSE)**_

如果您不想使用 `AppImage/docker`，仍然可以使用 `pyinstaller`：

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/Languages:Languages"
```

### 注意:

- 如果你想分叉这个项目并进行你自己的发布，你需要将 `src/Scripts/Updater.py` 顶部的变量更改为你自己的信息，并更新 `AppImageBuilder.yml` 中的值，以及在相应编译命令中的信息，如 `nuitka`。

# P2:MM 插件

Portal 2: Multiplayer Mod 使用了一个独立的 Source Engine 服务器插件, 以便连接到 Portal 2 并修补游戏, 使某些系统可以运行 VScript 通常无法做到的操作. 由于 Source Engine 插件的开发和编译环境的特性, 该插件已放置在一个单独的存储库中. 您可以在这里找到其源代码: <https://github.com/OrsellGaming/Portal-2-Multiplayer-Mod-Plugin>

# 贡献

Portal 2: Multiplayer Mod 版本 `2.3.0` 将是我们的最终版本，因此在它完全发布后我们不会再进行任何重大更新。在此之前，我们将致力于一些小的更新，直到完整版本发布。在此期间，我们会接受任何重大更改或功能添加到 P2:MM。然而，发布后我们不会进行太多工作，也不会有新的版本发布。我们唯一会发布新版本的原因是有人贡献了新的翻译、改进了现有翻译、修复了一些我们没发现的小错误，或者为工作坊地图提供了支持文件。即使在这个最终版本之后，你仍然可以基于我们的工作进行分叉！请确保你给这个仓库注明出处！

# 鸣谢

**开发人员:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**贡献者:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
