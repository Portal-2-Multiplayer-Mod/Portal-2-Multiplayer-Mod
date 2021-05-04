@echo off
del /s MultiplayerModUninstall.cmd
del /s MultiplayerMod.cmd
del /s update.bat
del /s updatepack.zip
rmdir /q /s "%cd%\updatepack"
rmdir /q /s "%cd%\MultiplayerModFiles"
cls
echo Updating...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/kyleraykbs/Portal2-32PlayerMod-Lite/raw/main/Portal2-32PlayerMod-Lite.Beta.zip', 'updatepack.zip')"
powershell -Command "Invoke-WebRequest https://github.com/kyleraykbs/Portal2-32PlayerMod-Lite/raw/main/Portal2-32PlayerMod-Lite.Beta.zip -OutFile updatepack.zip"
powershell -command Expand-Archive updatepack.zip -Force

mkdir "%cd%\MultiplayerModFiles"
xcopy /y /s "%cd%\updatepack" "%cd%"
rmdir /q /s "%cd%\updatepack"

del /s updatepack.zip
timeout 1 >nul
call "%cd%\update.bat"