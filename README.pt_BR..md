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

### Este mod é completamente do lado do servidor. Somente o host precisa executar o Portal 2 com o mod instalado. As pessoas que se juntam ao host devem executar o Portal 2 padrão.

## Idiomas

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | **_Português (Brasil)_**

## Recursos de modificação

```
  - Um limite máximo de 33 jogadores
  - Etiquetas de nome
  - Cores personalizadas dos jogadores
  - Comandos de bate-papo (!help)
  - Sistema de administração no jogo
  - Suporte completo à campanha cooperativa
  - Suporte completo à campanha para um jogador (precisa de um pequeno polimento)
  - Suporte completo a mapas Super 8
  - Suporte a mapas internos para mapas selecionados do workshop
  - Criptografia de comandos do cliente invocados por meio da classe GameRules ativa
  - Suporte para Linux, Windows 10 e superior
  - Opções de jogo alternáveis e sistema de configuração exposto por meio de VScript e um plug-in personalizado
  - Suporte a SAR (SourceAutoRecord) para speedrunning
```

# Instalação e Uso

**Guias no Wiki sobre como configurar P2:MM:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

**Baixe a versão mais recente:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal2-Multiplayer-Mod/releases/latest>

**Discord Server para ajuda técnica (CERTIFIQUE-SE DE LER AS FAQ!!!), relatório de bugs ou apenas para conversar:**

- <https://discord.gg/kW3nG6GKpF>

# Criando o Launcher

## Dependências

- Python 3.10
- pygame
- requests
- steamid-converter

Também as colocamos em um arquivo para facilitar a instalação: `pip install -r requirements.txt`

## Compilação

Usamos [`nuitka`](https://nuitka.net/) para compilar o Launcher do Portal 2: Multiplayer Mod. Junto com isso, usamos GitHub Actions para nossos executáveis de lançamento. [`pyinstaller`](https://pypi.org/project/pyinstaller/) e [`AppImage`](https://appimage.org/) foram originalmente usados, mas foram descontinuados em favor do `nuitka`.

### Windows

Para Windows, usamos `nuitka` para criar nossos arquivos `.exe`. Embora seja mais lento para compilar do que o `pyinstaller`, que era usado em versões anteriores, ele fornece um tamanho de executável menor. `nuitka` pode ser instalado usando `pip`.

Abaixo está o comando completo do terminal que usamos nos executáveis de lançamento, é ligeiramente diferente do que o GitHub Actions usa, e abaixo disso está uma versão simplificada sem informações de versão e afins:

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Linux

Assim como no Windows, `nuitka` é usado para compilar os executáveis do Linux. Originalmente, era usado `pyinstaller`, depois `Appimage`, mas acabou-se optando por `nuitka` pelo tamanho pequeno do executável.

Abaixo está o comando de terminal para compilar para Linux usando `nuitka`:

```shell
python -m nuitka --onefile --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages" --linux-icon="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Observações

- Se você quiser fazer um fork do projeto e fazer seus próprios lançamentos, você precisa alterar as variáveis no topo de `src/Scripts/Updater.py` para suas próprias informações e atualizar os valores em `AppImageBuilder.yml`, bem como as informações nos comandos de compilação respectivos, como com `nuitka`.

# Plugin P2:MM

O Mod Multijogador de Portal 2 utiliza um plugin de servidor separado do Source Engine para se conectar ao Portal 2 e corrigir o jogo, permitindo que certos sistemas operem de maneira que o VScript normalmente não pode fazer. O plugin foi colocado em um repositório separado devido à natureza do desenvolvimento e ambiente de compilação de plugins do Source Engine. Você pode encontrar seu código fonte aqui: <https://github.com/OrsellGaming/Portal-2-Multiplayer-Mod-Plugin>

# Contribuições

Portal 2: Multiplayer Mod versão `2.3.0` será nossa versão definitiva, então não faremos nenhuma atualização significativa após seu lançamento completo. Antes que isso aconteça, trabalharemos em commits na branch `dev` antes de chegar à versão completa. Aceitaremos quaisquer mudanças ou funcionalidades substanciais para P2:MM durante este período. No entanto, não faremos muito trabalho após o lançamento, nem faremos novos lançamentos em geral. As únicas razões pelas quais faríamos um novo lançamento seriam quando alguém contribuísse com uma nova tradução, uma melhoria de uma tradução atual, alguma outra correção de bug menor que não pegamos ou um arquivo de suporte de mapa para um mapa de workshop. Mesmo após este lançamento final, você ainda pode fazer um fork para construir a partir do nosso trabalho! Por favor, certifique-se de dar crédito a este repositório!

# Créditos

**Desenvolvedores:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**Colaboradores:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
