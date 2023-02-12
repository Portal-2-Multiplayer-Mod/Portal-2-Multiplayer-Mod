<h1>
  <img src="/Images/P2MMBannerREADME.png" alt="P2MMBannerREADME" width="500" height="300" align="left">
  <a href="https://discord.gg/nXRygGNxyK">
    <img src="https://img.shields.io/discord/839651379034193920?color=blue&label=Discord%20%E7%94%A8%E6%88%B7&style=for-the-badge&logo=discord&logoWidth=20" alt="Discord Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest">
    <img src="https://img.shields.io/github/release-date/kyleraykbs/Portal2-32PlayerMod?color=red&label=%E6%9C%80%E6%96%B0%E7%89%88%E6%9C%AC&style=for-the-badge" alt="Release Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/commits/main">
    <img src="https://img.shields.io/github/last-commit/kyleraykbs/Portal2-32PlayerMod?label=%E6%9C%80%E5%90%8E%E6%8F%90%E4%BA%A4&style=for-the-badge" alt="Commit Shield Badge" align="right">
  </a>
  <br>
    <a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest"><img src="https://img.shields.io/github/downloads/kyleraykbs/Portal2-32PlayerMod/total?label=%E4%B8%8B%E8%BD%BD%E6%AC%A1%E6%95%B0&style=for-the-badge" alt="Download Count Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/qwertyquerty/pypresence">
    <img src="https://img.shields.io/badge/using-pypresence-00bb88.svg?style=for-the-badge&logo=discord&logoWidth=20&label=%E6%AD%A3%E4%BD%BF%E7%94%A8" alt="P2MM uses Pypresence for Discord Rich Presence" align="right">
  </a>
  <br>
  <br>
  <p align="right">PORTAL 2: 多人联机模组</p>
</h1>

### 该模组仅服务端使用。只有服务器管理员需要安装该模组至 Portal 2 来运行。其他玩家仅需使用原版即可进入该服务器。

### 特别感谢 Krzyhau 允许我们使用速通模组中的代码。

## 语言
[English](README.md) | [Español](README.es.md) | [Polski](README.pl.md) | 简体中文 | [繁體中文](README.zh-TW.md)

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
  - 支持 Linux, Windows 7 及以上系统
  - 通过 VScript 和自定义插件提供可切换的游戏选项以及配置系统
  - 为速通提供 SAR（起源自动录制）支持
  - 如果你能开起来的话，原生支持专用服务器 :)
  - 多种游戏模式 (原版、速通、futbol（足球）和死亡竞赛)
```

## 未来计划加入的功能
- 支持 Steam Deck/SteamOS 3.0
- Discord API 一键邀请加入
- 为创意工坊提供更多地图的支持

# 安装及使用

**Steam 教程页 - 如何建立服务器以及加入游戏（英文）：**
- https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280

**下载最新版：**
- https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest

**加入 Discord 服务器获取更多技术上的帮助（确保你已经看完教程了！！！），报告 Bug 或聊天：**
- https://discord.gg/kW3nG6GKpF


# 编译

*启动器使用 Python 3.10*

**使用依赖**
- pygame
- pyperclip
- pypresence
- requests
- steamid-converter

我们已将其放入文件中以便安装：`pip install -r requirements.txt`

**编译**

我们使用 `pyinstaller` 来编译为可执行文件
- Windows:

```
pyinstaller "src/MainWindow.py" -F -i "src/GUI/assets/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/languages;languages"
```

- Linux:

```
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/languages:languages"
```

*注意：*  
- 若你想要 Fork 并作为你的项目来发布，你需要更改 `src/Scripts/Updater.py` 顶部中的变量到你的信息。


# 做出贡献

我们欢迎您来为本项目来提供额外帮助。具体来说我们需要精通 Squirrel 或 C++ 的程序员。如果你能帮我们一手，那会有很大的帮助！

# 贡献者

**开发者：**
- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- zwexit (Orsell) 

**贡献者：**
- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- Luukex
- PieCreeper
- Areng
- Krzyhau
