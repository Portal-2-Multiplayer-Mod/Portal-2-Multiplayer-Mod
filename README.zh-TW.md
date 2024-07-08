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

我們使用 [`nuitka`](https://nuitka.net/) 來編譯 Portal 2：Multiplayer Mod 啟動器。我們還使用 GitHub Actions 來發布我們的可執行文件。[`pyinstaller`](https://pypi.org/project/pyinstaller/) 和 [`AppImage`](https://appimage.org/) 最初被使用，但現在已經被棄用，改用 `nuitka`。

### Windows

對於 Windows，我們使用 `nuitka` 來創建我們的 `.exe` 文件。雖然編譯速度比舊版本中使用的 `pyinstaller` 慢，但它提供了更小的可執行文件大小。`nuitka` 可以通過 `pip` 安裝。

下面是我們在發佈可執行文件中使用的完整終端命令，它與 GitHub Actions 使用的略有不同，下面是簡化版本，沒有版本信息等：

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Linux

就像在 Windows 一样，`nuitka` 用于编译 Linux 可执行文件。最初使用的是 `pyinstaller`，后来是 `Appimage`，但由于可执行文件体积小，最终选择了 `nuitka`。

以下是使用 `nuitka` 编译 Linux 的终端命令：

```shell
python -m nuitka --onefile --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages" --linux-icon="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### 注意

- 如果你想分叉這個項目並進行你自己的發佈，你需要將 `src/Scripts/Updater.py` 頂部的變量更改為你自己的信息，並更新 `AppImageBuilder.yml` 中的值，以及在相應編譯命令中的信息，如 `nuitka`。

# P2:MM 插件

Portal 2: Multiplayer Mod 使用了一个独立的 Source Engine 服务器插件，以便连接到 Portal 2 并修补游戏，使某些系统可以运行 VScript 通常无法做到的操作。由于 Source Engine 插件的开发和编译环境的特性，该插件已放置在一个单独的存储库中。您可以在这里找到其源代码：<https://github.com/OrsellGaming/Portal-2-Multiplayer-Mod-Plugin>

# 贡献

Portal 2：多人模組版本 `2.3.0` 將是我們的最終版本，所以在完全發布後我們不會進行任何重大更新。在這之前，我們將在 `dev` 分支上進行提交，然後再發布完整版本。在此期間，我們將接受對 P2:MM 的任何重大更改或功能。然而，在發布之後我們不會進行太多工作，也不會進行新的發布。我們進行新發布的唯一原因是有人貢獻了新的翻譯，改進了當前的翻譯，或者是我們沒有發現的一些其他小錯誤修復，或是一個工坊地圖的支持文件。即使在這個最終版本發布後，您仍然可以分叉它來基於我們的工作進行構建！請確保您給這個倉庫以信用！

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
