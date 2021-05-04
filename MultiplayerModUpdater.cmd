@echo off
cls
echo Deleting Old Files...
del /s MultiplayerModUninstall.cmd
del /s MultiplayerMod.cmd
del /s update.bat
del /s updatepack.zip
rmdir /q /s "%cd%\updatepack"
rmdir /q /s "%cd%\MultiplayerModFiles"
cls
echo Updating...
echo Preparing Download...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/kyleraykbs/Portal2-32PlayerMod-Lite/raw/main/Portal2-32PlayerMod-Lite.Beta.zip', 'updatepack.zip')"
echo Download Prepared!
echo Starting Download...
powershell -Command "Invoke-WebRequest https://github.com/kyleraykbs/Portal2-32PlayerMod-Lite/raw/main/Portal2-32PlayerMod-Lite.Beta.zip -OutFile updatepack.zip"
echo Download Finished!
echo Unzipping Update...
powershell -command Expand-Archive updatepack.zip -Force
mkdir "%cd%\MultiplayerModFiles"
xcopy /y /s "%cd%\updatepack" "%cd%"
rmdir /q /s "%cd%\updatepack"
echo Unzipped Update!
echo Cleaning Up...
del /s updatepack.zip
echo Cleaned Up!
echo Running Update Specific Code...
call "%cd%\update.bat"
echo Code Ran!
cls
exit