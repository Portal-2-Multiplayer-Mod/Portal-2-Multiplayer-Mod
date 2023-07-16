<h1>
  <img src="/Images/P2MMBannerREADME.png" alt="P2MMBannerREADME" width="500" height="300" align="left">
  <a href="https://discord.gg/nXRygGNxyK">
    <img src="https://img.shields.io/discord/839651379034193920?color=blue&label=Discord%20%E7%A4%BE%E7%BE%A4&style=for-the-badge&logo=discord&logoWidth=20" alt="Discord Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest">
    <img src="https://img.shields.io/github/release-date/kyleraykbs/Portal2-32PlayerMod?color=red&label=%E6%9C%80%E6%96%B0%E7%89%88%E6%9C%AC&style=for-the-badge" alt="Release Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/commits/main">
    <img src="https://img.shields.io/github/last-commit/kyleraykbs/Portal2-32PlayerMod?label=%E6%9C%80%E5%BE%8C%E6%8F%90%E4%BA%A4&style=for-the-badge" alt="Commit Shield Badge" align="right">
  </a>
  <br>
    <a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest"><img src="https://img.shields.io/github/downloads/kyleraykbs/Portal2-32PlayerMod/total?label=%E4%B8%8B%E8%BC%89%E6%AC%A1%E6%95%B8&style=for-the-badge" alt="Download Count Shield Badge" align="right">
  </a>
  <br>
  <br>
  <br>
  <p align="right">PORTAL 2: 多人連線模組</p>
</h1>

### 該模組僅服務端使用。只有伺服器管理員需要安裝該模組至 Portal 2 來執行。其他玩家僅需使用原版即可進入該伺服器。

## 語言
[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | ***繁體中文***

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
- https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280

**下載最新版：**
- https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest

**加入 Discord 伺服器獲取更多技術上的幫助（確保你已經看完教學了！！！），報告 Bug 或聊天：**
- https://discord.gg/kW3nG6GKpF


# 編譯

*啟動器使用 Python 3.10*

**使用依賴**
- pygame
- pyperclip
- requests
- steamid-converter

我們已將其放入文件中以便安裝：`pip install -r requirements.txt`

**編譯**

我們使用 `pyinstaller` 來編譯為可執行文件，`pip install pyinstaller`
- Windows:

```
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/languages;languages"
```

- Linux:

```
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/languages:languages"
```

*注意：*  
- 若你想要 Fork 並作為你的項目來發布，你需要更改 `src/Scripts/Updater.py` 頂部中的變數到你的訊息。


# 做出貢獻

我們歡迎您來為本項目來提供額外幫助。具體來說我們需要精通 Squirrel 或 C++ 的程式設計師。如果你能幫我們一手，那會有很大的幫助！

# 貢獻者

**開發者：**
- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste

**貢獻者：**
- zwexit\ (Orsell) 
- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- Luukex
- PieCreeper
- Areng