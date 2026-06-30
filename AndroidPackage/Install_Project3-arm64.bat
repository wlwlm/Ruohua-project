@echo off
setlocal
pushd "%~dp0"

if NOT "%UE_SDKS_ROOT%"=="" call "%UE_SDKS_ROOT%\HostWin64\Android\SetupEnvironmentVars.bat"

set "ADB=adb"
if not "%ANDROID_HOME%"=="" set "ADB=%ANDROID_HOME%\platform-tools\adb.exe"
set "AFS=%~dp0win-x64\UnrealAndroidFileTool.exe"

if not exist "%AFS%" (
    echo Missing required tool: %AFS%
    goto Error
)

set "DEVICE="
if not "%~1"=="" set "DEVICE=-s %~1"
for /f "delims=" %%A in ('"%ADB%" %DEVICE% shell "echo $EXTERNAL_STORAGE"') do @set STORAGE=%%A
@echo.
@echo Uninstalling existing application. Failures here can almost always be ignored.
"%ADB%" %DEVICE% uninstall com.YourCompany.Project3
@echo.
@echo Installing existing application. Failures here indicate a problem with the device (connection or storage permissions) and are fatal.
"%ADB%" %DEVICE% install Project3-arm64.apk
@if "%ERRORLEVEL%" NEQ "0" goto Error
"%ADB%" %DEVICE% shell pm list packages com.YourCompany.Project3
"%ADB%" %DEVICE% shell pm grant com.YourCompany.Project3 android.permission.FOREGROUND_SERVICE >nul 2>&1
"%ADB%" %DEVICE% shell pm grant com.YourCompany.Project3 android.permission.FOREGROUND_SERVICE_DATA_SYNC >nul 2>&1
"%ADB%" %DEVICE% shell pm grant com.YourCompany.Project3 android.permission.POST_NOTIFICATIONS >nul 2>&1
"%ADB%" %DEVICE% shell rm -r %STORAGE%/UnrealGame/Project3
"%ADB%" %DEVICE% shell rm -r %STORAGE%/UnrealGame/UECommandLine.txt
"%ADB%" %DEVICE% shell rm -r %STORAGE%/obb/com.YourCompany.Project3
"%ADB%" %DEVICE% shell rm -r %STORAGE%/Android/obb/com.YourCompany.Project3
"%ADB%" %DEVICE% shell rm -r %STORAGE%/Download/obb/com.YourCompany.Project3
@echo.
@echo Installing new data. Failures here indicate storage problems (missing SD card or bad permissions) and are fatal.
"%AFS%" %DEVICE% -p com.YourCompany.Project3 -k 5E57FE0A43802EC22E0A02A3832DFD40 push main.1.com.YourCompany.Project3.obb "^mainobb"
if "%ERRORLEVEL%" NEQ "0" goto Error
"%AFS%" %DEVICE% -p com.YourCompany.Project3 -k 5E57FE0A43802EC22E0A02A3832DFD40 stop-all

@echo.
@echo Grant READ_EXTERNAL_STORAGE and WRITE_EXTERNAL_STORAGE to the apk for reading OBB file or game file in external storage.
"%ADB%" %DEVICE% shell pm grant com.YourCompany.Project3 android.permission.READ_EXTERNAL_STORAGE >nul 2>&1
"%ADB%" %DEVICE% shell pm grant com.YourCompany.Project3 android.permission.WRITE_EXTERNAL_STORAGE >nul 2>&1

@echo.
@echo Installation successful
popd
exit /b 0
:Error
@echo.
@echo There was an error installing the game or the obb file. Look above for more info.
@echo.
@echo Things to try:
@echo Check that the device is listed with "adb devices" from a command prompt.
@echo Make sure all Developer options look normal on the device
@echo Check that the device has an SD card.
@pause
popd
exit /b 1
