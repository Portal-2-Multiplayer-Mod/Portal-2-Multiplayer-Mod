@echo off
set /p mpmodver=<mpmodver.data
cls
echo Checking OS Version...
rem detect os version and store it in a variable called "version"
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" (cls) else (goto outdatedOS)
cls
echo [31mDon't[0m close the [94mUpdater[0m until it finishes
echo [33mWARNING:[0m [93mIf you run the updater alot it doesnt mean there are new updates it just means your redownloading it[0m
echo [Current Version: [95m%mpmodver%[0m]
echo.
echo Press [92m[ENTER][0m to start the update!
pause>nul
echo Deleting Old Files...
del /s MultiplayerModUninstall.cmd
del /s MultiplayerMod.cmd
del /s update.bat
del /s updatepack.zip
rmdir /q /s "%cd%\updatepack"
rmdir /q /s "%cd%\MultiplayerModFiles"
cls
echo Check Passed Running Windows 10! 
echo Updating...
echo Preparing Download...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/kyleraykbs/Portal2-32PlayerMod-Lite/raw/main/Portal2-32PlayerMod-Lite.Beta.rel.zip', 'updatepack.zip')"
echo Download Prepared!
echo Starting Download...
powershell -Command "Invoke-WebRequest https://github.com/kyleraykbs/Portal2-32PlayerMod-Lite/raw/main/Portal2-32PlayerMod-Lite.Beta.rel.zip -OutFile updatepack.zip"
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
del /s update.bat
cls
echo Updater has [92mCompleted[0m!
echo [[93mCurrent Version:[0m [95m%mpmodver%[0m]
echo.
echo Press [92m[ENTER][0m to [91mclose[0m!
pause >nul
exit
:outdatedOS
color 4
echo ERROR: Check Failed!!!
echo ERROR: The updater doesnt support Windows 7 please check 
echo https://github.com/kyleraykbs/Portal2-32PlayerMod-Lite/releases/latest for the latest update
echo Press Any Key
pause >nul
exit