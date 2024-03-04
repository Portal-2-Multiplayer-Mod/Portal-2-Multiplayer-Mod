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

### 該模組僅服務端使用。只有伺服器管理員需要安裝該模組至 Portal 2 來執行。其他玩家僅需使用原版即可進入該伺服器。

## 語言

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | **_繁體中文_** | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md)

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
  - 支援 Linux, Windows 10 及以上系統
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

# 建立啟動器

## 使用依賴

- Python 3.10
- pygame
- requests
- steamid-converter

我們已將其放入文件中以便安裝：`pip install -r requirements.txt`

## 編譯

我們使用 `pyinstaller` 和 `AppImage` 來製作可執行文件！

### Windows:

對於窗口，我們僅使用 [pyinstaller](https://pypi.org/project/pyinstaller/) 來構建可執行文件（如果您知道更好的選項，請告訴我們）。

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux:

對於 Linux，我們改用 [AppImage](https://appimage.org/)，並製作了一個工具來協助，只需安裝 `docker` 並在根目錄下執行 `./tools/build-docker.sh`。

***警告！由於某些原因在某些 Linux 發行版中，默認情況下沒有安裝 FUSE，這是編譯和運行 AppImages 所需的。在您的發行版上安裝 FUSE 的信息可以在這裡找到：[AppImageKit 的維基](https://github.com/AppImage/AppImageKit/wiki/FUSE)***

如果你不想使用 AppImage/Docker，你仍然可以使用 pyinstaller：

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/Languages:Languages"
```

### 注意:

- 若你想要 Fork 並作為你的項目來發布，你需要更改 `src/Scripts/Updater.py` 頂部中的變數到你的訊息。

# 做出貢獻

Portal 2: 多人遊戲 Mod 版本 2.2.0 將是我們的最終版本，因此在完全發布後我們將不再進行重大更新。在此之前，我們將致力於小的更新，逐步迎來完整版本。在此期間，我們將接受 P2:MM 的任何實質性更改或功能。然而，在完全發布後，我們將不再接受任何重大更改。我們會發布新版本的唯一原因是當有人貢獻新的翻譯，改進現有翻譯，修復我們沒有發現的其他小錯誤，或為創意工坊地圖提供地圖支援檔案時。在這些情況下，我們將只發布另一個版本，並不再接受任何重大更改到這個存儲庫。然而，你仍然可以 fork 它以構建基於我們的工作！請確保給予這個存儲庫適當的榮譽！

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