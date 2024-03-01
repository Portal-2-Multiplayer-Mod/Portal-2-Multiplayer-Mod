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
    <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/finalcleanup">
        <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/finalcleanup?style=for-the-badge&label=LAST%20COMMIT%20(FINALCLEANUP)&color=%2334a5eb"
                alt="GitHub last commit (branch)" align="right">
    </a>
    <br>
    <p align="right">PORTAL 2:</p>
    <p align="right">MULTIPLAYER MOD</p>
</h1>

### Este mod es completamente del lado del servidor. Solo el operador del servidor necesita ejecutar Portal 2 con el mod instalado. Las personas que se unan al anfitrión deben ejecutar Portal 2 sin modificaciones.

## Idiomas

[English](README.md) | **_Español_** | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md)

## Características del mod

```
  - Límite máximo de jugadores de 33
  - Etiquetas de nombres
  - Colores de jugador personalizados
  - Comandos de chat (!ayuda)
  - Sistema de administrador en el juego
  - Soporte completo para la campaña cooperativa
  - Soporte completo para la campaña para un jugador (necesita algunos ajustes)
  - Soporte completo para el mapa Super 8
  - Soporte para mapas internos de selectos talleres
  - Encriptación de comandos de cliente invocados a través de la clase GameRules activa
  - Soporte para Linux, Windows 10 y versiones superiores
  - Opciones de juego conmutables y sistema de configuración expuesto a través de VScript y un complemento personalizado
  - Soporte para SAR (SourceAutoRecord) para speedrunning
```

# Instalación y uso

**Guía de Steam sobre cómo alojar y unirse a un juego:**

- <https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280>

**Última versión:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest>

**Servidor de Discord para ayuda técnica (¡ASEGÚRATE DE LEER LAS PREGUNTAS FRECUENTES!), informe de errores o simplemente charlar:**

- <https://discord.gg/kW3nG6GKpF>

# Construyendo el Lanzador

## Dependencias

- Python 3.10
- pygame
- requests
- steamid-converter

También los tenemos en un archivo para una instalación fácil `pip install -r requirements.txt`

## Compilación

¡Usamos `pyinstaller` y `AppImage` para hacer los ejecutables!

### Windows:

Para Windows, solo usamos [pyinstaller](https://pypi.org/project/pyinstaller/) para crear el ejecutable! (si conoces mejores opciones, por favor avísanos).

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux:

Para Linux, cambiamos a utilizar [AppImage](https://appimage.org/) y creamos una herramienta para ayudar con eso, simplemente tenga `docker` instalado y ejecute `./tools/build-docker.sh` estando en el directorio raíz.

***¡ADVERTENCIA! Por alguna razón, en algunas distribuciones de Linux, FUSE no está instalado de forma predeterminada, lo cual es necesario para compilar y ejecutar AppImages. Puede encontrar información para instalar FUSE en su distribución aquí: [Wiki de AppImageKit](https://github.com/AppImage/AppImageKit/wiki/FUSE)***

Si no quieres usar AppImage/Docker, puedes seguir usando pyinstaller:

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/Languages:Languages"
```

### Nota:

- Si deseas bifurcar el proyecto y realizar tus propias versiones, debes cambiar las variables en la parte superior de `src/Scripts/Updater.py` con tu propia información.


# Contribuciones

Portal 2: Multiplayer Mod versión `2.2.0` será nuestra versión definitiva, por lo que no realizaremos ninguna actualización significativa después de que esté totalmente lanzada. Antes de que esto ocurra, trabajaremos en actualizaciones menores que conduzcan a la versión completa. Aceptaremos cualquier cambio o característica sustancial para P2:MM durante este periodo. Sin embargo, no aceptaremos más cambios significativos después de la versión completa. Las únicas razones por las que haríamos una nueva versión serían que alguien contribuyera con una nueva traducción, una mejora de una traducción actual, alguna corrección de errores menores que no hayamos detectado, o un archivo de soporte de mapas para un mapa del taller. Sólo haremos una nueva versión en esas circunstancias y ya no aceptaremos nada significativo en este repositorio. Sin embargo, ¡puedes hacer un fork para aprovechar nuestro trabajo! Por favor, ¡asegúrate de dar crédito a este repositorio!

# Créditos

**Desarrolladores:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**Contribuyentes:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
- Areng
