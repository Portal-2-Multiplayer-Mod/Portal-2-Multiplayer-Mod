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

### Este mod es completamente del lado del servidor. Solo el operador del servidor necesita ejecutar Portal 2 con el mod instalado. Las personas que se unan al anfitrión deben ejecutar Portal 2 sin modificaciones.

## Idiomas

[English](README.md) | **_Español_** | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md) | [Русский](README.ru.md) 

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

# Instalación y Uso

**Guías en el Wiki sobre cómo configurar P2:MM:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

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

También los tenemos en un archivo para una instalación fácil: `pip install -r requirements.txt`

## Compilación

Usamos [`nuitka`](https://nuitka.net/) para compilar el lanzador de Portal 2: Multiplayer Mod. Junto con ello, usamos GitHub Actions para nuestros ejecutables de lanzamiento. [`pyinstaller`](https://pypi.org/project/pyinstaller/) y [`AppImage`](https://appimage.org/) se usaron originalmente, pero se han dejado de usar en favor de `nuitka`.

### Windows

Para Windows usamos `nuitka` para crear nuestros archivos `.exe`. Aunque es más lento de compilar que `pyinstaller`, que se usaba en versiones anteriores, proporciona un tamaño de ejecutable más pequeño. `nuitka` se puede instalar usando `pip`.

A continuación se muestra el comando completo de terminal que usamos en los ejecutables de lanzamiento, es ligeramente diferente de lo que usa GitHub Actions, y debajo de eso hay una versión simplificada sin información de versión y demás:

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="El lanzador para P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Linux

Al igual que en Windows, se utiliza `nuitka` para compilar los ejecutables de Linux. Originalmente se usaba `pyinstaller`, luego `Appimage`, pero se optó por `nuitka` por el tamaño reducido del ejecutable.

A continuación se muestra el comando de terminal para compilar para Linux usando `nuitka`:

```shell
python -m nuitka --onefile --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages" --linux-icon="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Nota

- Si deseas bifurcar el proyecto y hacer tus propios lanzamientos, necesitas cambiar las variables en la parte superior de `src/Scripts/Updater.py` con tu propia información y actualizar los valores en `AppImageBuilder.yml`, así como la información en los comandos de compilación respectivos, como con `nuitka`.


# Contribuciones

Portal 2: Multiplayer Mod versión `2.3.0` será nuestra versión definitiva, por lo que no haremos actualizaciones significativas después de su lanzamiento completo. Antes de que esto ocurra, trabajaremos en los commits en la rama `dev` antes de llegar a la versión completa. Aceptaremos cualquier cambio o característica sustancial para P2:MM durante este período. Sin embargo, no haremos mucho trabajo después del lanzamiento ni realizaremos nuevas versiones en general. Las únicas razones por las que haríamos una nueva versión serían cuando alguien contribuya con una nueva traducción, una mejora de una traducción actual, alguna otra corrección de errores menores que no detectamos, o un archivo de soporte de mapa para un mapa de taller. ¡Incluso después de este lanzamiento final, todavía puedes hacer un fork para construir a partir de nuestro trabajo! ¡Por favor, asegúrate de dar crédito a este repositorio!

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
