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

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | **_简体中文_** | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md) | [한국어 (Korean)](README.ko.md)

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

我们使用 [`nuitka`](https://nuitka.net/) 来编译 Portal 2：Multiplayer Mod 启动器。我们还使用 GitHub Actions 来发布我们的可执行文件。[`pyinstaller`](https://pypi.org/project/pyinstaller/) 和 [`AppImage`](https://appimage.org/) 最初被使用，但现在已经被弃用，改用 `nuitka`。

### Windows

对于 Windows，我们使用 `nuitka` 来创建我们的 `.exe` 文件。虽然编译速度比旧版本中使用的 `pyinstaller` 慢，但它提供了更小的可执行文件大小。`nuitka` 可以通过 `pip` 安装。

下面是我们在发布可执行文件中使用的完整终端命令，它与 GitHub Actions 使用的略有不同，下面是一个简化版本，没有版本信息等：

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Linux

和 Windows 一样，`nuitka` 用于编译 Linux 可执行文件。最初使用的是 `pyinstaller`，然后是 `Appimage`，但由于可执行文件体积小，最终选择了 `nuitka`。

以下是使用 `nuitka` 编译 Linux 的终端命令：

```shell
python -m nuitka --onefile --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages" --linux-icon="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### 注意

- 如果你想分叉这个项目并进行你自己的发布，你需要将 `src/Scripts/Updater.py` 顶部的变量更改为你自己的信息，并更新 `AppImageBuilder.yml` 中的值，以及在相应编译命令中的信息，如 `nuitka`。

# P2:MM 插件

Portal 2: Multiplayer Mod 使用了一个独立的 Source Engine 服务器插件, 以便连接到 Portal 2 并修补游戏, 使某些系统可以运行 VScript 通常无法做到的操作. 由于 Source Engine 插件的开发和编译环境的特性, 该插件已放置在一个单独的存储库中. 您可以在这里找到其源代码: <https://github.com/OrsellGaming/Portal-2-Multiplayer-Mod-Plugin>

# 贡献

Portal 2：多人模组版本 `2.3.0` 将是我们的最终版本，所以在完全发布后我们不会进行任何重大更新。在这之前，我们将在 `dev` 分支上进行提交，然后再发布完整版本。在此期间，我们将接受对 P2:MM 的任何重大更改或功能。然而，在发布之后我们不会进行太多工作，也不会进行新的发布。我们进行新发布的唯一原因是有人贡献了新的翻译，改进了当前的翻译，或者是我们没有发现的一些其他小错误修复，或是一个工坊地图的支持文件。即使在这个最终版本发布后，您仍然可以分叉它来基于我们的工作进行构建！请确保您给这个仓库以信用！

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
