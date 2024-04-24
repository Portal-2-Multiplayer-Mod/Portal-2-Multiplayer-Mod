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

Usamos o `pyinstaller` e o `AppImage` para criar os executáveis!

### Windows:

Para o Windows, usamos apenas o [pyinstaller](https://pypi.org/project/pyinstaller/) para compilar o executável (se você souber de opções melhores, informe-nos).

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux:

Para o Linux, mudamos para o uso do [AppImage] (https://appimage.org/) e criamos uma ferramenta para ajudar com isso, basta ter o `docker` instalado e executar `./tools/build-docker.sh` no diretório raiz.

***AVISO! Por alguma razão, em algumas distribuições Linux, o FUSE não é instalado por padrão, o que é necessário para compilar e executar AppImages. As informações sobre a instalação do FUSE em sua distribuição podem ser encontradas aqui: [AppImageKit's Wiki](https://github.com/AppImage/AppImageKit/wiki/FUSE)***

Se não quiser usar o AppImage/docker, você ainda pode usar o pyinstaller:

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/Languages:Languages"
```

### Observações:

- Se você quiser fazer um fork do projeto e fazer suas próprias versões, precisará alterar as variáveis na parte superior de `src/Scripts/Updater.py` para suas próprias informações e atualizar os valores em `AppImageBuilder.yml`

# Plugin P2:MM

O Mod Multijogador de Portal 2 utiliza um plugin de servidor separado do Source Engine para se conectar ao Portal 2 e corrigir o jogo, permitindo que certos sistemas operem de maneira que o VScript normalmente não pode fazer. O plugin foi colocado em um repositório separado devido à natureza do desenvolvimento e ambiente de compilação de plugins do Source Engine. Você pode encontrar seu código fonte aqui: <https://github.com/OrsellGaming/Portal-2-Multiplayer-Mod-Plugin>

# Contribuições

A versão `2.3.0` do Portal 2: Multiplayer Mod será nossa versão definitiva, portanto, não faremos nenhuma atualização significativa depois que ela for totalmente lançada. Antes que isso aconteça, trabalharemos em pequenas atualizações que levarão à versão completa. Aceitaremos quaisquer alterações ou recursos substanciais para o P2:MM durante esse período. No entanto, não aceitaremos mais alterações significativas após o lançamento completo. Os únicos motivos pelos quais faríamos um novo lançamento seriam quando alguém contribuísse com uma nova tradução, um aprimoramento de uma tradução atual, alguma correção de bug menor que não tenhamos detectado ou um arquivo de suporte de mapa para um mapa de oficina. Só faremos outra versão nessas circunstâncias e não aceitaremos mais nada significativo nesse repositório. No entanto, você ainda pode fazer um fork para aproveitar o nosso trabalho! Certifique-se de dar crédito a este repositório!

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
- Areng