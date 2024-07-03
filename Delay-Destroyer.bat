:: Made by Quaked
:: TikTok: _Quaked_
:: Discord: https://discord.gg/xxZRvuQrzd
:: Code Inspiration: Khorvie, Calypto.
 
@echo off
title Delay Destroyer V1.0
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

:: (Quaked) Check for Windows Defender.
sc query "WinDefend" | find "STATE" | find "RUNNING" >nul
if not errorlevel 1 (
    powershell -Command "Write-Host 'Windows Defender is Enabled, it''s recommended you *disable* it.' -ForegroundColor White -BackgroundColor Red"
    powershell -Command "Write-Host 'Please Click Virus & Threat Protect, Then Manage Settings and Turn Off *Real Time Protection*' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    explorer.exe ms-settings:windowsdefender
    pause
)

:: (Quaked) Downloading Delay Destroyer Tools at Start, Includes Timer Res, Power Plans and VC Redist.
set "fileURL=https://github.com/QuakedK/Downloads/raw/main/DelayDestroyerTools.zip"
set "fileName=Delay Destroyer Tools.zip"
set "extractFolder=C:\Delay Destroyer Tools"
set "downloadsFolder=C:\"
if not exist "%downloadsFolder%\%fileName%" (
    curl -s -L "%fileURL%" -o "%downloadsFolder%\%fileName%"
    timeout 1 > nul
    mkdir "%extractFolder%" > nul
    pushd "%extractFolder%"
    tar -xf "%downloadsFolder%\%fileName%" --strip-components=1
    popd
    del /q "C:\Delay Destroyer Tools.zip" >nul 2>&1
) else (
    echo "%fileName%" already exists in "%downloadsFolder%". >nul 2>&1
)
 
:: (Quaked) Delay Destroyer.
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
echo.                                        ██████╗ ███████╗██╗      █████╗ ██╗   ██╗                                  
echo.                                        ██╔══██╗██╔════╝██║     ██╔══██╗╚██╗ ██╔╝                                  
echo.                                        ██║  ██║█████╗  ██║     ███████║ ╚████╔╝                                   
echo.                                        ██║  ██║██╔══╝  ██║     ██╔══██║  ╚██╔╝                                    
echo.                                        ██████╔╝███████╗███████╗██║  ██║   ██║                                     
echo.                                        ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝                                     
echo.                                                                           
echo.                       ██████╗ ███████╗███████╗████████╗██████╗  ██████╗ ██╗   ██╗███████╗██████╗ 
echo.                       ██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔══██╗██╔═══██╗╚██╗ ██╔╝██╔════╝██╔══██╗
echo.                       ██║  ██║█████╗  ███████╗   ██║   ██████╔╝██║   ██║ ╚████╔╝ █████╗  ██████╔╝
echo.                       ██║  ██║██╔══╝  ╚════██║   ██║   ██╔══██╗██║   ██║  ╚██╔╝  ██╔══╝  ██╔══██╗
echo.                       ██████╔╝███████╗███████║   ██║   ██║  ██║╚██████╔╝   ██║   ███████╗██║  ██║
echo.                       ╚═════╝ ╚══════╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝
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
echo (Quaked) Grouping Svchost Processes, based on RAM capacity in KB...
for /f %%a in ('powershell -Command "(Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb"') do set "ram_kb=%%a"
powershell -Command "Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control' -Name 'SvcHostSplitThresholdInKB' -Type DWord -Value %ram_kb% -Force
echo The operation completed successfully.
echo Svchost Processes grouped successfully.
timeout 1 > nul

cls
color D
echo (Quaked) Applying System Clock Settings...
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes
echo System Clock Settings appiled successfully.
timeout 1 > nul

cls
color 9
echo (Quaked) Setting Priority Separation... 
echo.
chcp 65001 >nul 2>&1
echo ╔═════════════════════════════╗
echo ║    22 and 46 Recommended!   ║
echo ╚═════════════════════════════╝
chcp 437 >nul
echo.
echo Choose an option:
echo 1. 20 Decimal 
echo 2. 22 Decimal 
echo 3. 24 Decimal
echo 4. 26 Decimal
echo 5. 46 Decimal
echo 6. Skip!
set /p option="Enter option number: "
if "%option%"=="1" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x00000014 /f
echo 20 Decimal aka 14 Hexadecimal, Priority Separation appiled successfully.
timeout 2 > nul
) else if "%option%"=="2" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x00000016 /f
echo 22 Decimal aka 16 Hexadecimal, Priority Separation appiled successfully.
timeout 2 > nul
) else if "%option%"=="3" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x00000018 /f
echo 24 Decimal aka 18 Hexadecimal, Priority Separation appiled successfully.
timeout 2 > nul
) else if "%option%"=="4" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x1a /f
echo 26 Decimal aka 1A Hexadecimal, Priority Separation appiled successfully.
timeout 2 > nul
) else if "%option%"=="5" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x2a /f
echo 46 Decimal aka 2A Hexadecimal, Priority Separation appiled successfully.
timeout 2 > nul   
) else if "%option%"=="6" (
echo Skipping!
goto :SkippingPriority
timeout 1 > nul   
) 

:SkippingPriority
cls
color D
echo (Quaked) Installing Visual C++ 2015-2022 Redistributable...
echo.
:: Check if Visual C++ 2015-2022 Redistributable (x64) is installed
reg query "HKLM\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64" > nul 2>&1
if %errorlevel% == 0 (
    echo Visual C++ 2015-2022 Redistributable is installed
    timeout 2 > nul
    goto :TimerRes
) else (
    echo Visual C++ 2015-2022 Redistributable is not installed
    timeout 2 > nul
    goto :VCRuntime
)
pause

:VCRuntime
:: Download VC++ Redistributable
set "fileURL=https://github.com/QuakedK/Downloads/raw/main/VC_redist.x64.exe"
set "fileName=VC_redist.x64.exe"
mkdir "C:\Oneclick Tools\VC Redist" >nul 2>&1
set "downloadsFolder=C:\Oneclick Tools\VC Redist"
chcp 65001 >nul 2>&1
echo.
echo ╔═════════════════════════════╗
echo ║                             ║
echo ║    Downloading resources    ║
echo ║                             ║
echo ╚═════════════════════════════╝
chcp 437 >nul
curl -s -L "%fileURL%" -o "%downloadsFolder%\%fileName%"

:: Check if the file was downloaded successfully
if exist "%downloadsFolder%\%fileName%" (
    echo File downloaded successfully.
    echo.
    echo Starting Visual C++ 2015-2022 Redistributable...
    start "" "%downloadsFolder%\%fileName%"
    echo.
    echo Please install the redistributable package to continue.
    echo Once installed, click "Install" to proceed or close to cancel...
    echo.
    pause
) else (
    echo Failed to download the file.
    timeout 2 > nul
    goto :VCRuntime
)

:TimerRes
cls
color 9
setlocal enabledelayedexpansion
:: Check Windows version and add additional registry key if Windows 11 detected
for /f "tokens=3" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuild" 2^>nul ^| findstr "REG_SZ"') do (
    set "build=%%A"
)

if defined build (
    echo Detected build number: !build! >nul 2>&1
    set /a build_num=!build! 
    if !build_num! gtr 0 (
        if !build_num! lss 22000 (
            echo Windows 11 not detected. >nul 2>&1
        ) else (
            echo Windows 11 was detected. >nul 2>&1
            reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\kernel" /v "GlobalTimerResolutionRequests" /t REG_DWORD /d "1" /f >nul 2>&1
        )
    ) else (
        echo Failed to convert the build number to an integer. >nul 2>&1
    )
) else (
    echo Failed to retrieve the build number. >nul 2>&1
)
endlocal

echo (Quaked) Installing and Setting up TimerResolution... 
echo.
chcp 65001 >nul 2>&1
echo ╔═════════════════════════════╗
echo ║    0.504ms and 0.507ms      ║
echo ║        Recommended!         ║
echo ╚═════════════════════════════╝
chcp 437 >nul
echo. 
echo Choose an option:
echo 1. Timer Res 0.500ms  
echo 2. Timer Res 0.502ms  
echo 3. Timer Res 0.504ms
echo 4. Timer Res 0.507ms
echo 5. Skip!                                                                   
set /p option="Enter option number: "
if "%option%"=="1" (
  echo.
  echo Adding TimerResolution to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Delay Destroyer Tools\Timer Resolution\SetTimerResolution.exe --resolution 5000 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Delay Destroyer Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5000 --no-console
  echo Timer Res is now active in the background!
  timeout 2 > nul
) else if "%option%"=="2" (
  echo.
  echo Adding TimerResolution to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Delay Destroyer Tools\Timer Resolution\SetTimerResolution.exe --resolution 5020 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Delay Destroyer Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5020 --no-console
  echo Timer Res is now active in the background!
  timeout 2 > nul 
) else if "%option%"=="3" (
  echo.
  echo Adding TimerResolution to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Delay Destroyer Tools\Timer Resolution\SetTimerResolution.exe --resolution 5040 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Delay Destroyer Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5040 --no-console
  echo Timer Res is now active in the background!
  timeout 2 > nul 
) else if "%option%"=="4" (
  echo.
  echo Adding TimerResolution to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Delay Destroyer Tools\Timer Resolution\SetTimerResolution.exe --resolution 5070 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Delay Destroyer Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5070 --no-console
  echo Timer Res is now active in the background!
  timeout 2 > nul 
) else if "%option%"=="5" (
  echo.
  echo Skipping!
  goto :SkippingTimer
  timeout 1 > nul 
) 

cls
color D
echo (Khorive, Inspired) Tweaking NDIS...

setlocal
echo Detecting Network Adapter.

for /f "skip=1 delims=" %%a in ('wmic nic where "NetConnectionStatus=2" get NetConnectionID /value 2^>nul') do (
    for /f "tokens=2 delims==" %%b in ("%%a") do (
        set "adapter_name=%%b"
    )
)

if defined adapter_name (
    echo Your current network adapter is: %adapter_name%

    echo Enabling Interrupt Moderation and setting Interrupt Moderation Rate to medium.
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Interrupt Moderation' | Set-NetAdapterAdvancedProperty -RegistryValue 1" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Interrupt Moderation Rate' | Set-NetAdapterAdvancedProperty -RegistryValue 125" >nul 2>&1

    echo Setting NetworkThrottlingIndex to 10.
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 10 /f
    echo NDIS Tweaks appiled successfully.
    timeout 1 > nul
) else (
    echo Unable to detect your current network adapter.
    echo Skipping.
    timeout 1 > nul
)
endlocal

:DMT
cls
color D
echo Do you want to Run (Calypto, Inspired) Device Manager Tweaks?
echo.
chcp 437 >nul
powershell -Command "Write-Host '(Not Recommended) Can cause bluescreens and other issues, so be cautious.' -ForegroundColor White -BackgroundColor Red"
echo.
set /p choice=Enter (Y/N): 
if /i "%choice%"=="Y" (
    timeout 1 > nul
    cls
    goto :DeviceManagerTweaks
) else if /i "%choice%"=="N" ( 
    timeout 1 > nul
    cls
    goto :SkipDeviceManager
) else (
    cls
    chcp 437 >nul
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    goto :DMT
)

:DeviceManagerTweaks
echo (Calypto, Inspired) Tweaking and Disabling things in Device Manager...
echo.
setlocal enabledelayedexpansion

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Microsoft GS Wavetable Synth*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!"

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*NDIS Virtual Network Adapter Enumerator*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!"

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Composite Bus Enumerator*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!"

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Microsoft Virtual Drive Enumerator*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!"

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Remote Desktop Device Redirector Bus*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Mircosoft RRAS Root Enumerator*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Mircosoft Print to PDF*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Root Print Queue*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" 

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Intel(R) Management Engine Interface #1*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Intel(R) SPI (Flash) Controller - 7AA4*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Intel(R) SMBus - 7AA3*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*UMBus Root Bus Enumerator*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!"

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Microsoft Hypervisor Service*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!"

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Microsoft Device Association Root Enumerator*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!"

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Microsoft Hyper-V Vitualization Infrastucture Driver*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!"

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Bluetooth Device (RFCOMM Protocol TDI)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

REM Get instance ID of the device directly from PowerShell
for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Intel(R) Wireless Bluetooth(R)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Microsoft Bluetooth Enumerator*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Microsoft Bluetooth LE Enumerator*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Bluetooth Device (Personal Area Network)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*NVIDIA High Definition Audio*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

:DWifiD
cls
echo Do you want to Disable Wifi Devices?
echo.
chcp 437 >nul
powershell -Command "Write-Host 'It Will Break Wifi' -ForegroundColor White -BackgroundColor Red"
echo.
echo Are you sure? (Y/N)
set /p option="Enter option number: "
if /i "%option%"=="Y" (
    echo.
    echo Now Disabling Wif Devices...
    timeout 2 > nul
    cls
    goto :WifiDevice
) else if /i "%option%"=="N" (
    echo.
    echo Skipping Wifi Device Manager Tweaks...
    timeout 2 > nul
    cls
    goto :SkipDeviceManager
) else (
    cls
    chcp 437 >nul
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    goto :DWifiD
)

:WifiDevice
echo (Quaked) Disabling Wifi Devices!
echo.
for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*Intel(R) Wi-Fi*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" 

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*WAN Miniport (IKEv2)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*WAN Miniport (IP)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*WAN Miniport (IPv6)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*WAN Miniport (L2TP)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*WAN Miniport (Network Monitor)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*WAN Miniport (PPPOE)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*WAN Miniport (PPTP)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '*WAN Miniport (SSTP)*' | Select-Object -ExpandProperty InstanceId"`) do (
    set "instanceID=%%A"
)

pnputil /disable-device "!instanceID!" >nul 2>&1

echo Device Manager Tweaks appiled successfully.
timeout 1 > nul

cls
color 9
:SkipDeviceManager
echo (Quaked) Installing and Setting up Power Plan!
echo.
chcp 65001 >nul 2>&1
echo ╔═════════════════════════════╗    
echo ║ Quaked Ultimate Performance ║
echo ║        Recommended!          ║
echo ╚═════════════════════════════╝
chcp 437 >nul
echo. 
echo Choose an option:
echo 1. Quaked Ultimate Performance 
echo 2. Quaked Ultimate Performance Idle Off  
echo 3. Skip!
set /p option="Enter option number: "
if "%option%"=="1" (
  echo.
  powercfg -import "C:\Delay Destroyer Tools\Power Plan\Quaked Ultimate Performance.pow"
  timeout 2 > nul
  goto :Activatecpl
) else if "%option%"=="2" (
  echo. 
  powercfg -import "C:\Delay Destroyer Tools\Power Plan\Quaked Ultimate Performance Idle Off.pow"
  timeout 2 > nul
  goto :Activatecpl
) else if "%option%"=="3" (
  echo.
  echo Skipping!
  goto :EndPower
  timeout 1 > nul 
) else (
  cls
  chcp 437 >nul
  powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
  timeout 2 > nul
  goto :SkipDeviceManager
) 

:Activatecpl
setlocal enabledelayedexpansion

REM Check if Quaked Ultimate Performance power plan exists
for /f "tokens=2 delims=:(" %%i in ('powercfg /list ^| findstr /C:"Quaked Ultimate Performance"') do (
    set plan_guid=%%i
)

REM Check if Quaked Ultimate Performance Idle Off power plan exists
for /f "tokens=2 delims=:(" %%i in ('powercfg /list ^| findstr /C:"Quaked Ultimate Performance Idle Off"') do (
    set idle_off_guid=%%i
)

REM Activate the existing plan
if defined plan_guid (
    powercfg /setactive %plan_guid% >nul 2>&1
    powercfg /setactive %idle_off_guid% >nul 2>&1
    echo Activated Quaked Power Plan.
    timeout 2 > nul
    goto:CheckPower    
)

:CheckPower
cls
powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a >nul 2>&1
echo Opening Power Plan Selection to Confirm...
powercfg.cpl
echo You might have to refresh to see any changes!
echo Please select the power plan...
echo.
echo Did the Power Plan import correctly?
echo (Y/N)
echo.
set /p option="Enter option number: "
if /i "%option%"=="Y" (
    taskkill /F /FI "WINDOWTITLE eq Power Options" >nul 2>&1
    goto :Cstate
) else if /i "%option%"=="N" (
    powercfg -restoredefaultschemes
    powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    echo.
    echo.
    echo Now select High Performance!
    echo You might have to refresh to see any changes!
    taskkill /F /FI "WINDOWTITLE eq Power Options" >nul 2>&1
    powercfg.cpl
    echo.
    pause
) else (
    cls
    chcp 437 >nul
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    goto :CheckPower
)

:Cstate
cls
echo Disabling C States...
powercfg -setacvalueindex scheme_current SUB_SLEEP AWAYMODE 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
powercfg -setacvalueindex scheme_current SUB_SLEEP ALLOWSTANDBY 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
powercfg -setacvalueindex scheme_current SUB_SLEEP HYBRIDSLEEP 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
timeout 1 > nul

cls
echo Disabling Core Parking...
powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
timeout 1 > nul

cls
echo Disabling Throttle States...
powercfg -setacvalueindex scheme_current sub_processor THROTTLING 0 >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f >nul 2>&1
timeout 1 > nul

:EndPower
cls
color D
echo All Latency Tweaks applied successfully.
echo.
echo Closing in 2 seconds!
timeout 2 > nul
exit

