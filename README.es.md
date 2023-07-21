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
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/main">
    <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?label=Last%20Commit&style=for-the-badge" alt="Commit Shield Badge" align="right">
  </a>
  <br>
    <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest"><img src="https://img.shields.io/github/downloads/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/total?style=for-the-badge" alt="Download Count Shield Badge" align="right">
  </a>
  <br>
  <br>
  <br>
  <p align="right">PORTAL 2: MULTIPLAYER MOD</p>
</h1>

### Este mod es completamente del lado del servidor. Solo el operador del servidor necesita ejecutar Portal 2 con el mod instalado. Las personas que se unan al anfitrión deben ejecutar Portal 2 sin modificaciones.

## Idiomas
[English](README.md) | ***Español*** | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md)

# Características del mod
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
  - Soporte para Linux, Windows 7 y versiones superiores
  - Opciones de juego conmutables y sistema de configuración expuesto a través de VScript y un complemento personalizado
  - Soporte para SAR (SourceAutoRecord) para speedrunning
```

# Instalación y uso

**Guía de Steam sobre cómo alojar y unirse a un juego:**
- https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280

**Última versión:**
- https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest

**Servidor de Discord para ayuda técnica (¡ASEGÚRATE DE LEER LAS PREGUNTAS FRECUENTES!), informe de errores o simplemente charlar:**
- https://discord.gg/kW3nG6GKpF


# Compilación

*Utilizamos Python 3.10 para el lanzador*

**Dependencias**
- pygame
- pyperclip
- requests
- steamid-converter

También los tenemos en un archivo para una instalación fácil `pip install -r requirements.txt`

**Compilación**

Utilizamos `pyinstaller` para crear el ejecutable, `pip install pyinstaller`
- Windows:

```
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/Languages;Languages"
```

- Linux:

```
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/Languages:Languages"
```

*Nota:*  
- Si deseas bifurcar el proyecto y realizar tus propias versiones, debes cambiar las variables en la parte superior de `src/Scripts/Updater.py` con tu propia información.


# Contribuciones

Siempre estamos felices de recibir cualquier ayuda adicional que podamos obtener para este proyecto. Específicamente, necesitamos programadores competentes en Squirrel o C++. Si crees que puedes echar una mano, ¡será de gran ayuda!

# Créditos

**Desarrolladores:**
- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste

**Contribuyentes:**
- zwexit\ (Orsell) 
- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- Luukex
- PieCreeper
- Areng