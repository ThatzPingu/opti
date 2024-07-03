:: Made by Quaked
:: TikTok: _Quaked_
:: Discord: https://discord.gg/xxZRvuQrzd
 
@echo off
title Fortnite Optimizer V1.0
color 9

:: (Quaked) Check for Admin Privileges.
fltmc >nul 2>&1
if not %errorlevel% == 0 (
    powershell -Command "Write-Host 'Oneclick is required to be run as *Administrator.*' -ForegroundColor White -BackgroundColor Red" 
    powershell -Command "Write-Host 'Please Click *Yes* to the following prompt!' -ForegroundColor White -BackgroundColor Red" 
    timeout 3 > nul
    PowerShell Start -Verb RunAs '%0'
    exit /b 0
)

:: (Quaked) Downloading Fortnite Optimizer Tools at Start, Includes Fortnite Configs.
set "fileURL=https://github.com/QuakedK/Downloads/raw/main/FortniteOptimizerTools.zip"
set "fileName=Fortnite Optimizer Tools.zip"
set "extractFolder=C:\Fortnite Optimizer Tools"
set "downloadsFolder=C:\"
if not exist "%downloadsFolder%\%fileName%" (
    curl -s -L "%fileURL%" -o "%downloadsFolder%\%fileName%"
    timeout 1 > nul
    mkdir "%extractFolder%" >nul 2>&1
    pushd "%extractFolder%" >nul 2>&1
    tar -xf "%downloadsFolder%\%fileName%" --strip-components=1 >nul 2>&1
    popd >nul 2>&1
    del /q "C:\Fortnite Optimizer Tools.zip" >nul 2>&1
) else (
    echo "%fileName%" already exists in "%downloadsFolder%". >nul 2>&1
)
 
:: (Quaked) Fortnite Optimizer Start Screen.
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                             ███████╗ ██████╗ ██████╗ ████████╗███╗   ██╗██╗████████╗███████╗       
echo.                             ██╔════╝██╔═══██╗██╔══██╗╚══██╔══╝████╗  ██║██║╚══██╔══╝██╔════╝       
echo.                             █████╗  ██║   ██║██████╔╝   ██║   ██╔██╗ ██║██║   ██║   █████╗         
echo.                             ██╔══╝  ██║   ██║██╔══██╗   ██║   ██║╚██╗██║██║   ██║   ██╔══╝         
echo.                             ██║     ╚██████╔╝██║  ██║   ██║   ██║ ╚████║██║   ██║   ███████╗       
echo.                             ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═══╝╚═╝   ╚═╝   ╚══════╝       
echo.                                                                       
echo.                             ██████╗ ██████╗ ████████╗██╗███╗   ███╗██╗███████╗███████╗██████╗     
echo.                            ██╔═══██╗██╔══██╗╚══██╔══╝██║████╗ ████║██║╚══███╔╝██╔════╝██╔══██╗    
echo.                            ██║   ██║██████╔╝   ██║   ██║██╔████╔██║██║  ███╔╝ █████╗  ██████╔╝    
echo.                            ██║   ██║██╔═══╝    ██║   ██║██║╚██╔╝██║██║ ███╔╝  ██╔══╝  ██╔══██╗    
echo.                            ╚██████╔╝██║        ██║   ██║██║ ╚═╝ ██║██║███████╗███████╗██║  ██║    
echo.                             ╚═════╝ ╚═╝        ╚═╝   ╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝    
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║              Version 1.0 - By Quaked               ║
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo.
echo.
echo. ╔═════════╗                                                                        
echo. ║ Loading ║                                              
echo. ╚═════════╝
timeout 2 > nul 

:: (Quaked) Restore Point.
:RP
cls
color D
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                 ██████╗ ███████╗███████╗████████╗ ██████╗ ██████╗ ███████╗
echo.                                 ██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝
echo.                                 ██████╔╝█████╗  ███████╗   ██║   ██║   ██║██████╔╝█████╗  
echo.                                 ██╔══██╗██╔══╝  ╚════██║   ██║   ██║   ██║██╔══██╗██╔══╝  
echo.                                 ██║  ██║███████╗███████║   ██║   ╚██████╔╝██║  ██║███████╗
echo.                                 ╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║   Create a restore point to undo system changes!   ║
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo.
echo.
echo.                                                                       
chcp 437 >nul
powershell -Command "Write-Host 'Recommended!' -ForegroundColor White -BackgroundColor Red"
echo Do you want to make a restore point?
set /p choice=Enter (Y/N): 
if /i "%choice%"=="Y" (
    powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\' >nul 2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\SystemRestore" /v "RPSessionInterval" /f >nul 2>&1 
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\SystemRestore" /v "DisableConfig" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1
    timeout 1 > nul 
    echo _______________________
    echo Creating restore point.
    powershell -Command "Checkpoint-Computer -Description 'OneClick V6.7 Restore Point'"
    echo Restore point successfully created.
    timeout 2 > nul 
) else if /i "%choice%"=="N" (
    echo ________________________________________________
    echo Not creating a restore point, use at discretion.
    timeout 2 > nul
) else (
    cls
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    goto :RP
)

cls
color 9
echo (Quaked) Disabling Fortnite Fullscreen Optimizations... 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe" /t REG_SZ /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE HIGHDPIAWARE" /f
echo Fortnite Fullscreen Optimizations disabled successfully.
timeout 2 > nul 

cls
color D
echo (Quaked) Setting Fortnite Graphics Preference... 
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe" /t REG_SZ /d "GpuPreference=2;" /f
echo Fortnite Graphics Preference appiled successfully.
timeout 2 > nul 

cls
color 9
echo (Quaked) Setting Fortnite Priority... 
echo.
chcp 65001 >nul 2>&1
echo ╔═════════════════════════════╗
echo ║  High Priority Recommended! ║
echo ╚═════════════════════════════╝
chcp 437 >nul
echo.
echo Choose an option:
echo 1. Normal
echo 2. Above Normal 
echo 3. High
echo 4. Skip!
set /p option="Enter option number: "
if "%option%"=="1" (
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 2 /f
echo Fortite Normal, Priority appiled successfully.
timeout 2 > nul
) else if "%option%"=="2" (
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 6 /f
echo Fortite Above Normal, Priority appiled successfully.
timeout 2 > nul
) else if "%option%"=="3" (
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
echo Fortite High, Priority appiled successfully.
timeout 2 > nul   
) else if "%option%"=="4" (
echo.
echo Skipping!
goto :SkippingPriority
timeout 1 > nul   
) 

:SkippingPriority
cls
color D
echo (Quaked) Installing Optimized Fortnite Game Config...
echo.
chcp 65001 >nul 2>&1
echo ╔═════════════════════════════╗
echo ║   Low Meshes Recommended!   ║
echo ╚═════════════════════════════╝
chcp 437 >nul
echo.
echo Choose an option:
echo 1. Low Meshes Config
echo 2. High Meshes Meshes Config 
echo 3. DX 12
echo 4. Skip!
set /p option="Enter option number: "
if "%option%"=="1" (
echo.
echo Importing Low Meshes Fortnite Game Config!
powershell -Command "Move-Item -Path 'C:\Fortnite Optimizer Tools\Fortnite Configs\Low Meshes\GameUserSettings.ini' -Destination \"$env:USERPROFILE\AppData\Local\FortniteGame\Saved\Config\WindowsClient\" -Force"
echo The operation completed successfully.
echo.
echo You might need to adjust your FPS and resolution to your liking.
timeout 999 > nul 
) else if "%option%"=="2" (
echo.
echo Importing High Meshes Fortnite Game Config!
powershell -Command "Move-Item -Path 'C:\Fortnite Optimizer Tools\Fortnite Configs\High Meshes\GameUserSettings.ini' -Destination \"$env:USERPROFILE\AppData\Local\FortniteGame\Saved\Config\WindowsClient\" -Force"
echo The operation completed successfully.
echo.
echo You might need to adjust your FPS and resolution to your liking.
timeout 2 > nul 
) else if "%option%"=="3" (
echo.
echo Importing DX12 Fortnite Game Config!
powershell -Command "Move-Item -Path 'C:\Fortnite Optimizer Tools\Fortnite Configs\DX 12\GameUserSettings.ini' -Destination \"$env:USERPROFILE\AppData\Local\FortniteGame\Saved\Config\WindowsClient\" -Force"
echo The operation completed successfully.
echo.
echo You might need to adjust your FPS and resolution to your liking.
timeout 2 > nul    
) else if "%option%"=="4" (
echo Skipping!
goto :SkippingConfig
timeout 1 > nul   
) 

:SkippingConfig
cls
color 9
echo (Quaked) Adding Fortnite Additional Command Line Arguments...
echo.
echo Opening Epic Games Launcher!
start "" "C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win32\EpicGamesLauncher.exe"
echo.
echo 1. Click your "Profile" icon, then click "Settings" and "scroll all the way down."
echo 2. Expand "Fortnite", Check "Additional Command Line Arguments"
echo 3. Paste -limitclientticks -nosplash -useallavailablecores
pause

cls
color D
echo Rebooting PC...
rd /s /q "C:\Fortnite Optimizer Tools" >nul 2>&1
timeout 1 > nul
shutdown /r /t 0 
