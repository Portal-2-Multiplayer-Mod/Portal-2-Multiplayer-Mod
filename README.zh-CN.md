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
  <p align="right">PORTAL 2:</p>
  <p align="right">MULTIPLAYER MOD</p>
</h1>

### 该模组仅服务端使用。只有服务器管理员需要安装该模组至 Portal 2 来运行。其他玩家仅需使用原版即可进入该服务器。

## 语言

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | **_简体中文_** | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md)

## 模组功能

```
  - 最大玩家上限增至 33 人
  - 名称标签
  - 自定义玩家颜色
  - 聊天框命令 (!help)
  - 游戏内管理系统
  - 支持合作模式
  - 支持单人模式（但仍需多加打磨） 
  - 支持 Super 8 地图
  - 内部地图支持选择创意工坊地图
  - 通过活动 GameRules 类调用客户端命令加密
  - 支持 Linux, Windows 10 及以上系统
  - 通过 VScript 和自定义插件提供可切换的游戏选项以及配置系统
  - 为速通提供 SAR（起源自动录制）支持
```

# 安装与使用

**关于如何设置P2:MM的Wiki指南：**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

**下载最新版：**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest>

**加入 Discord 服务器获取更多技术上的帮助（确保你已经看完教程了！！！），报告 Bug 或聊天：**

- <https://discord.gg/kW3nG6GKpF>

# 构建启动器

## 使用依赖

- Python 3.10
- pygame
- requests
- steamid-converter

我们已将其放入文件中以便安装：`pip install -r requirements.txt`

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

# 做出贡献

Portal 2：多人遊戲模擬器 2.2.0 版」將會是我們的終極版本，因此在正式發行後，我們將不會進行任何重大更新。在此之前，我們會先進行小規模更新，然後再推出正式版本。在此期间，我们将接受 P2:MM 的任何实质性更改或功能。但是，在正式版发布后，我们将不再接受任何重大更改。我们发布新版本的唯一原因是有人提供了新的翻译、对当前翻译的改进、其他一些我们没有发现的小错误修复，或者为工作室地图提供了地图支持文件。我们只会在这些情况下发布新版本，不会再接受任何重要的内容。不过，您仍然可以将其分叉，以利用我们的工作成果！请务必注明本软件源的出处！

# 贡献者

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

**贡献者：**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
