<h1>
  <img src="https://github.com/Portal-2-Multiplayer-Mod/P2MM-ART/blob/e56d8c209eb3f143bb0607dc1e59730e517ecca6/Banners/P2MMBannerREADME.png" alt="P2MMBannerREADME" width="500" height="300" align="left">
  <a href="https://discord.gg/nXRygGNxyK">
    <img src="https://img.shields.io/discord/839651379034193920?color=blue&label=Discord%20Users&style=for-the-badge&logo=discord&logoWidth=20" alt="Discord Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest">
    <img src="https://img.shields.io/github/release-date/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?color=red&label=Latest%20Release&style=for-the-badge" alt="Release Shield Badge" align="right">
  </a>
  <br>
    <img src="https://img.shields.io/github/downloads/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/total?style=for-the-badge&label=TOTAL%20DOWNLOAD%20COUNT" alt="Download Count Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/main">
    <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?label=LAST%20COMMIT%20(MAIN)&style=for-the-badge" alt="Commit Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/finalcleanup">
    <img alt="GitHub last commit (branch)" src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/finalcleanup?style=for-the-badge&label=LAST%20COMMIT%20(FINALCLEANUP)&color=%2334a5eb" align="right">
  </a>
  <br>
  <br>
  <br>
  <p align="right">PORTAL 2: MULTIPLAYER MOD</p>
</h1>

### 該模組僅服務端使用。只有伺服器管理員需要安裝該模組至 Portal 2 來執行。其他玩家僅需使用原版即可進入該伺服器。

## 語言

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | **_繁體中文_** | [Italiano](README.it.md) | [Français](README.fr.md)

## 模組功能

```
  - 最大玩家上限增至 33 人
  - 名稱標籤
  - 自訂玩家顏色
  - 聊天框指令 (!help)
  - 遊戲內管理系統
  - 支援合作模式
  - 支援單人模式（但仍需多加打磨） 
  - 支援 Super 8 地圖
  - 內部地圖支援選擇創意工坊地圖
  - 透過活動 GameRules 類呼叫用戶端指令加密
  - 支援 Linux, Windows 7 及以上系統
  - 通過 VScript 和自訂外掛程式提供可切換的遊戲選項以及配置系統
  - 為速通提供 SAR（起源自動錄製）支援
```

# 安裝及使用

**Steam 教學頁 - 如何建立伺服器以及加入遊戲（英文）：**

- <https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280>

**下載最新版：**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest>

**加入 Discord 伺服器獲取更多技術上的幫助（確保你已經看完教學了！！！），報告 Bug 或聊天：**

- <https://discord.gg/kW3nG6GKpF>


# 編譯

*啟動器使用 Python 3.10*

**使用依賴**

- pygame
- pyperclip
- requests
- steamid-converter

我們已將其放入文件中以便安裝：`pip install -r requirements.txt`

**編譯**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest>

**加入 Discord 伺服器獲取更多技術上的幫助（確保你已經看完教學了！！！），報告 Bug 或聊天：**

- <https://discord.gg/kW3nG6GKpF>


# 編譯

*啟動器使用 Python 3.10*

**使用依賴**

- pygame
- pyperclip
- requests
- steamid-converter

我們已將其放入文件中以便安裝：`pip install -r requirements.txt`

**編譯**

我們使用 `pyinstaller` 和 `AppImage` 來製作可執行文件！

### Windows:

對於窗口，我們僅使用 [pyinstaller](https://pypi.org/project/pyinstaller/) 來構建可執行文件（如果您知道更好的選項，請告訴我們）

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/Languages;Languages"
```

### Linux:

對於 Linux，我們切換到使用 [AppImage](https://appimage.org/)，我們製作了一個工具來幫助這個問題，只需安裝 docker 並運行 `tools/build-docker.sh`。

***警告！由於某些原因在某些 Linux 發行版中，默認情況下沒有安裝 FUSE，這是編譯和運行 AppImages 所需的。在您的發行版上安裝 FUSE 的信息可以在這裡找到：[AppImageKit 的維基](https://github.com/AppImage/AppImageKit/wiki/FUSE)***

如果你不想使用 AppImage/Docker，你仍然可以使用 pyinstaller：

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/Languages:Languages"
```

### 注意:

- 若你想要 Fork 並作為你的項目來發布，你需要更改 `src/Scripts/Updater.py` 頂部中的變數到你的訊息。


# 做出貢獻

自 2.2.0 發布起，所有將接受貢獻的內容都是錯誤修復，影響啟動器和/或在 Portal 2 中運行模組時的使用問題，以及啟動器的翻譯。任何重大更改都將被拒絕，因為我們嘗試努力進行 3.0 重寫，而不是繼續在 2.0 系列上進行工作。不過，歡迎您幫助我們處理 [3.0 重寫存儲庫](https://github.com/Portal-2-Multiplayer-Mod/P2MM-Entanglement)！在那裡，我們需要 Python 和 C ++ 程序員。

# 貢獻者

**開發者：**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**貢獻者：**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
- Areng