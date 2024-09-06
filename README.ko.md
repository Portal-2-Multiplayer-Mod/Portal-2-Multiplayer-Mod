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

### 이 모드는 완전히 서버 측에서 실행됩니다. 호스트만 Portal 2와 모드가 설치된 상태에서 실행하면 됩니다. 호스트에 참여하는 사람들은 기본 Portal 2를 실행해야 합니다.


## 언어

**_English_** | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md) | [한국어 (Korean)](README.ko.md)

## 모드 기능

```
  - 최대 33명의 플레이어 지원
  - 이름 태그
  - 사용자 정의 플레이어 색상
  - 채팅 명령어 (!help)
  - 게임 내 관리자 시스템
  - 완전한 협동 캠페인 지원
  - 완전한 싱글플레이어 캠페인 지원 (소폭 다듬기 필요)
  - 완전한 Super 8 맵 지원
  - 선택된 워크샵 맵에 대한 자체 맵 지원
  - 활성 GameRules 클래스를 통해 호출된 클라이언트 명령어의 암호화
  - 리눅스, Windows 10 이상 지원
  - VScript 및 사용자 정의 플러그인을 통한 전환 가능한 게임 옵션 및 구성 시스템
  - 스피드러닝을 위한 SAR (SourceAutoRecord) 지원
```

# 설치 및 사용

**P2:MM설정 방법에 대한 위키 가이드:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

**최신 버전 다운로드:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal2-Multiplayer-Mod/releases/latest>

**기술 지원을 위한 Discord 서버 (FAQ를 꼭 읽어보세요!!!), 버그 보고 또는 대화:**

- <https://discord.gg/kW3nG6GKpF>

# 런처 빌드

## 의존성

- Python 3.10
- pygame
- requests
- steamid-converter

설치를 쉽게 할 수 있는 파일도 있습니다: `pip install -r requirements.txt`

## 컴파일

우리는 Portal 2: Multiplayer Mod 런처를 컴파일하기 위해 [`nuitka`](https://nuitka.net/)를 사용합니다. 또한 릴리스 실행 파일을 위해 GitHub Actions를 사용합니다. [`pyinstaller`](https://pypi.org/project/pyinstaller/)와 [`AppImage`](https://appimage.org/)는 원래 사용되었으나 현재는 `nuitka`로 대체되었습니다.

### Windows

Windows에서는 `nuitka`를 사용하여 `.exe` 파일을 생성합니다. 이전 빌드에서 사용된 `pyinstaller`보다 컴파일 속도는 느리지만, 실행 파일 크기가 더 작습니다. `nuitka`는 `pip`를 통해 설치할 수 있습니다.

릴리스 실행 파일에 사용하는 전체 터미널 명령어는 다음과 같습니다. 이는 GitHub Actions에서 사용하는 명령어와 약간 다르며, 아래는 버전 정보 등이 포함되지 않은 축소 버전입니다:

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Linux

Windows와 마찬가지로, Linux에서도 `nuitka`를 사용하여 실행 파일을 컴파일합니다. 원래는 `pyinstaller`와 `Appimage`를 사용했으나, 실행 파일 크기가 작아서 `nuitka`로 변경되었습니다.

Linux용 `nuitka`를 사용한 컴파일 명령어는 다음과 같습니다:

```shell
python -m nuitka --onefile --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages" --linux-icon="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### 노트

- 프로젝트를 포크하고 자체 릴리스를 하려면 `src/Scripts/Updater.py`의 상단에 있는 변수들을 자신의 정보로 변경하고, `AppImageBuilder.yml`의 값을 업데이트해야 하며, `nuitka`와 같은 컴파일 명령어에서도 해당 정보를 업데이트해야 합니다.

# 기여

Portal 2: Multiplayer Mod 버전 `2.3.0`이 최종 버전이 될 것이며, 이 버전이 완전히 출시된 후에는 중요한 업데이트를 진행하지 않을 것입니다.
이 버전 출시 전에는 `dev` 브랜치에서 커밋 작업을 진행하며, 이 기간 동안 P2에 대한 중요한 변경 사항이나 기능을 수용할 것입니다. 

그러나 출시 이후에는 거의 작업을 하지 않거나 새로운 릴리스를 하지 않을 예정입니다. 
새로운 릴리스를 하게 될 유일한 이유는 새로운 번역 기여, 기존 번역의 개선, 우리가 놓친 작은 버그 수정, 또는 워크샵 맵에 대한 맵 지원 파일이 추가될 경우입니다. 
최종 릴리스 이후에도 여러분은 이 프로젝트를 fork하여 우리 작업을 기반으로 개발할 수 있습니다!

이 저장소에 대한 크레딧을 꼭 명시해 주세요!

# 크레딧

**개발자들:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista (NULLderef)
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**기여자들:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper