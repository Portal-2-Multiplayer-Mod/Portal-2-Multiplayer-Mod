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

### Этот мод полностью серверный. Только организатор сервера должен запустить Portal 2 с установленным модом. Люди, которые присоединяются к организатору, должны запускать обычный Portal 2.

## Языки

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md) | **_Русский_**

## Особенности модификации

```
  - Максимальное количество игроков - 33
  - Именные метки над головами
  - Пользовательские цвета игроков
  - Команды чата (!help)
  - Система внутриигровой администрации
  - Полная поддержка совместной кампании
  - Полная поддержка одиночной кампании (нуждается в незначительной доработке)
  - Полная поддержка карт Super 8
  - Внутренняя поддержка отдельных карт из мастерской
  - Шифрование команд клиента, вызываемых через активный класс GameRules
  - Поддержка Linux, Windows 10 и выше
  - Переключаемые игровые настройки и система конфигурации, доступная через VScript и пользовательский плагин
  - Поддержка SAR (SourceAutoRecord) для прохождения на скорость
```

# Установка и использование

**Вики-руководства по установке P2:MM:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

**Скачивание последней версии:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal2-Multiplayer-Mod/releases/latest>

**Discord-сервер для технической помощи (ОБЯЗАТЕЛЬНО ПРОЧИТАЙТЕ ЧАВО!!!), сообщения об ошибках или просто спросите:**

- (в основном рассматриваются сообщения на английском) <https://discord.gg/kW3nG6GKpF>

# Сборка программы

## Зависимости

- Python 3.10
- pygame
- requests
- steamid-converter

Мы также храним их в файле для удобства установки: `pip install -r requirements.txt`

## Компиляция

Мы используем [`nuitka`](https://nuitka.net/) для компиляции программы запуска Portal 2: Multiplayer. Наряду с ним мы используем GitHub Actions для наших исполняемых файлов выпуска. [`pyinstaller`](https://pypi.org/project/pyinstaller/) и [`AppImage`](https://appimage.org/, которые изначально использовались, были упразднены в пользу `nuitka`.

### Windows

Для Windows мы используем `nuitka` для создания наших файлов `.exe`. Хотя он компилируется медленнее, чем `pyinstaller`, который использовался в старых сборках, он обеспечивает меньший размер исполняемого файла. `nutka` может быть установлена с помощью `pip`.

Ниже приведена полная команда терминала, которую мы используем в исполняемых файлах выпуска, она немного отличается от той, которую использует GitHub Actions, а ниже приведена урезанная версия без информации о версии и тому подобного:

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Linux

Как и в Windows, для компиляции исполняемых файлов Linux используется `nuitka`. Первоначально использовался `pyinstaller`, затем `Appimage`, но из-за небольшого размера исполняемого файла остановились на `nuitka`.

Ниже приведена команда терминала для компиляции под Linux с помощью `nuitka`:

```shell
python -m nuitka --onefile --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages" --linux-icon="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Примечания

- Если вы хотите Fork проекта и делать собственные выпуски, вам нужно изменить переменные в верхней части `src/Scripts/Updater.py` на свои собственные данные и обновить значения в `AppImageBuilder.yml`, а также информацию в соответствующих командах компиляции, как в случае с `nuitka`.

# Внёсшие вклад

Версия Portal 2: Multiplayer Mod `2.3.0` будет нашей окончательной версией, поэтому мы не будем делать никаких значительных обновлений после её полного выпуска. До этого мы будем работать над коммитами в ветке `dev`, прежде чем перейти к полной версии. Мы примем любые существенные изменения или возможности для P2:MM в этот период. Однако после выпуска мы не будем делать много работы или вообще выпускать новые выпуски. Единственная причина, по которой мы будем выпускать новый выпуск, - это если кто-то предоставит новый перевод, улучшение текущего перевода, исправление мелких ошибок, которые мы не заметили, или файл поддержки карты для карты из мастерской. Даже после выхода финального выпуска вы всё ещё можете сделать Fork, чтобы использовать наши наработки! Пожалуйста, не забудьте указать ссылку на этот репозиторий!

# Создатели

**Разработчики:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista (NULLderef)
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**Внёсшие вклад:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
