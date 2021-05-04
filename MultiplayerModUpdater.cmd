@echo off
echo Checking OS Version...
rem detect os version and store it in a variable called "version"
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" (cls) else (goto outdatedOS)
cls
echo Deleting Old Files...
del /s MultiplayerModUninstall.cmd
del /s MultiplayerMod.cmd
del /s update.bat
del /s updatepack.zip
rmdir /q /s "%cd%\updatepack"
rmdir /q /s "%cd%\MultiplayerModFiles"
cls
echo Check Passed! 
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
:outdatedOS
color 4
echo ERROR: Check Failed!!!
echo ERROR: The updater doesnt support Windows 7 please check https://github.com/kyleraykbs/Portal2-32PlayerMod-Lite/releases/latest for the latest update
echo Press Any Key
pause >nul
exit