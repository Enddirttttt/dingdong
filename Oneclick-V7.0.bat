:: Made by Quaked
:: TikTok: _Quaked_
:: Discord: https://discord.gg/B8EmFVkdFU
:: Code Snippet Credit: ChrisTitusTech, Privacy Is Freedom, Prolix, Amitxv, Majorgeeks, PRDGY Ace, Mathako.
:: Code Inspiration: Khorvie, Calypto.
:: Helper: Mathako.
 
@echo off
title OneClick V7.0
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

:: (Quaked) Check for Windows 11.
setlocal enabledelayedexpansion
for /f "tokens=3" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuild" 2^>nul ^| findstr "REG_SZ"') do (
    set "build_num=%%A"
)

if !build_num! GEQ 26100 (
    powershell -Command "Write-Host 'Windows 11 24H2 detected, this Windows version includes many bugs and error therefore it''s not supported by Oneclick.' -ForegroundColor White -BackgroundColor Red"
    powershell -Command "Write-Host 'Please use Windows 11 22H2 or 23H2!' -ForegroundColor White -BackgroundColor Red"
    Pause
    exit
) else if !build_num! GEQ 22000 (
    echo Windows 11 detected, adding the required GlobalTimerRes reg. >nul 2>&1
    reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\kernel" /v "GlobalTimerResolutionRequests" /t REG_DWORD /d "1" /f >nul 2>&1
) else (
    powershell -Command "Write-Host 'Windows 11 not detected, we recommend running *Win 11 22H2 or 23H2* for the best results!' -ForegroundColor White -BackgroundColor Red"
    powershell -Command "Write-Host 'Although this doesn''t mean you have to use Win 11.' -ForegroundColor White -BackgroundColor Red"
    pause
)
endlocal

:: (Quaked) Check if TrustedInstaller is disabled, for Nsudo.
sc qc "TrustedInstaller" | find "START_TYPE" | find "DISABLED" >nul
if errorlevel 1 (
    echo TrustedInstaller is not disabled. >nul 2>&1
) else ( 
    sc config TrustedInstaller start=auto >nul 2>&1
    net start TrustedInstaller >nul 2>&1
)

:: (Quaked) Downloading Oneclick Tools at Start, Includes NSudo, Orca, Amd, Sound, PowerPlans, Dcontrol, DPC Checker, Timer Resolution and OOshutup10 + Config.
set "fileURL=https://github.com/QuakedK/Oneclick/raw/refs/heads/main/Downloads/OneclickTools.zip"
set "fileName=Oneclick Tools.zip"
set "extractFolder=C:\Oneclick Tools"
set "downloadsFolder=C:\"
if not exist "%downloadsFolder%\%fileName%" (
    curl -s -L "%fileURL%" -o "%downloadsFolder%\%fileName%"
    timeout 1 > nul
    mkdir "%extractFolder%" >nul 2>&1
    pushd "%extractFolder%" >nul 2>&1
    tar -xf "%downloadsFolder%\%fileName%" --strip-components=1 >nul 2>&1
    popd >nul 2>&1
    del /q "C:\Oneclick Tools.zip" >nul 2>&1
) else (
    echo "%fileName%" already exists in "%downloadsFolder%". >nul 2>&1
)

:: (Quaked) Check for Windows Defender.
sc query "WinDefend" | find "STATE" | find "RUNNING" >nul
if not errorlevel 1 (
    powershell -Command "Write-Host 'Windows Defender is Enabled, it''s recommended you *disable* it.' -ForegroundColor White -BackgroundColor Red"
    echo.
    goto :Defender
) else ( 
    goto :OSS
)

:Defender
echo Do you want to disable Windows Defender?
    set /p choice=Enter (Y/N): 
    if /i "%choice%"=="Y" (
    cls
    powershell -Command "Write-Host 'Please Click Virus & Threat Protect, Then Manage Settings and Turn Off.' -ForegroundColor White -BackgroundColor Red"
    powershell -Command "Write-Host '*Real Time Protection* and *Tamper Protection*' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    explorer.exe ms-settings:windowsdefender
    echo.
    echo Step 1 completed,  
    pause
    echo.
    start "" "C:\Oneclick Tools\Dcontrol\dControl.exe"
    echo Click disable *Windows Defender* then click *Menu* and add to the *Exclusion List*
    echo.
    echo Once Step 2 is completed, you can continue Oneclick!
    pause
    ) else if /i "%choice%"=="N" (
    echo.
    echo Not disabling Windows Defender!
    timeout 1 > nul
) else (
    cls
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    goto :Defender
)

:: (Quaked) Oneclick Start Screen.
:OSS
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
echo.                             ▒█████   ███▄    █ ▓█████     ▄████▄   ██▓     ██▓ ▄████▄   ██ ▄█▀     
echo.                            ▒██▒  ██▒ ██ ▀█   █ ▓█   ▀    ▒██▀ ▀█  ▓██▒    ▓██▒▒██▀ ▀█   ██▄█▒      
echo.                            ▒██░  ██▒▓██  ▀█ ██▒▒███      ▒▓█    ▄ ▒██░    ▒██▒▒▓█    ▄ ▓███▄░      
echo.                            ▒██   ██░▓██▒  ▐▌██▒▒▓█  ▄    ▒▓▓▄ ▄██▒▒██░    ░██░▒▓▓▄ ▄██▒▓██ █▄      
echo.                            ░ ████▓▒░▒██░   ▓██░░▒████▒   ▒ ▓███▀ ░░██████▒░██░▒ ▓███▀ ░▒██▒ █▄     
echo.                            ░ ▒░▒░▒░ ░ ▒░   ▒ ▒ ░░ ▒░ ░   ░ ░▒ ▒  ░░ ▒░▓  ░░▓  ░ ░▒ ▒  ░▒ ▒▒ ▓▒     
echo.                              ░ ▒ ▒░ ░ ░░   ░ ▒░ ░ ░  ░     ░  ▒   ░ ░ ▒  ░ ▒ ░  ░  ▒   ░ ░▒ ▒░     
echo.                            ░ ░ ░ ▒     ░   ░ ░    ░      ░          ░ ░    ▒ ░░        ░ ░░ ░      
echo.                                ░ ░           ░    ░  ░   ░ ░          ░  ░ ░  ░ ░      ░  ░        
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║              Version 7.0 - By Quaked               ║
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo.
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
    powershell -Command "Checkpoint-Computer -Description 'OneClick V7.0 Restore Point'"
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

:: (ChrisTitusTech's) Windows Utility tweaks, paired with couple of (Quaked) created things.
cls
color 9
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                                 ██████╗████████╗████████╗
echo.                                                ██╔════╝╚══██╔══╝╚══██╔══╝
echo.                                                ██║        ██║      ██║   
echo.                                                ██║        ██║      ██║   
echo.                                                ╚██████╗   ██║      ██║   
echo.                                                 ╚═════╝   ╚═╝      ╚═╝   
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║     Running ChrisTitusTech's Windows Utility...    ║       
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo.
echo.                                                                          
timeout 1 > nul  

cls
chcp 437 >nul
color D
echo (CTT) Disabling Activity History...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f
echo Activity History disabled successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Disabling Location...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d 0 /f
echo Location Related Things disabled successfully.
timeout 1 > nul

cls
color D
echo (CTT) Disabling Notifications...
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f
echo Notifications disabled successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Removing Storage Sense...
powershell -Command "Remove-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Recurse -ErrorAction SilentlyContinue" >nul 2>&1
echo The operation completed successfully.
echo Storage Sense disabled successfully.
timeout 1 > nul

cls
color D
echo (CTT) Disabling StickyKeys...
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d 506 /f
echo StickyKeys disabled successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Enabling Numlock On Start Up...
reg.exe add "HKU\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_DWORD /d 80000002 /f
echo Enabled Numlock On Start Up successfully
timeout 1 > nul

cls
color D
echo (CTT) Enabling Win 10 Right Click Menu...
powershell -Command "New-Item -Path 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}' -Name 'InprocServer32' -Force -Value ''" >nul 2>&1
echo The operation completed successfully.
echo Win 10 Right Click Menu enabled successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Show File Extensions...
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
echo Show File Extensions enabled successfully.
timeout 1 > nul

cls
color D
echo (Quaked) Show Hidden Files and Folders...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
echo Show Hidden Files and Folders enabled successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Disabling Taskbar Widgets...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f
echo Taskbar Widgets disabled successfully.
timeout 1 > nul

cls
color D
echo (CTT) Setting Display For Performance...
reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "200" /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 3 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
powershell -Command "Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0))"
echo Display Tweaks applied successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Disabling GameDVR...
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_EFSEFeatureFlags /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f
echo GameDVR disabled successfully.
timeout 1 > nul

cls
color D
echo (Quaked) Disabling Gamemode...
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 0 /f
echo Gamemode disabled successfully.
timeout 1 > nul

cls
color 9
echo (Quaked) Enabling Hardware Accelerated GPU Scheduling...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f
echo GPU Scheduling enabled successfully.
timeout 1 > nul

cls
color D
echo (Quaked) Disabling Transparency Effects...
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v EnableTransparency /t REG_DWORD /d 0 /f
echo Transparency Effects disabled successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Disabling Mouse Acceleration...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f
echo Mouse Acceleration disabled successfully.
timeout 1 > nul

cls
color D
echo (CTT) Disabling Hibernation...
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /v ShowHibernateOption /t REG_DWORD /d 0 /f
powercfg.exe /hibernate off
echo Hibernation disabled successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Disabling HomeGroup...
sc config HomeGroupListener start=demand >nul 2>&1
sc config HomeGroupProvider start=demand >nul 2>&1
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo HomeGroup Services disabled successfully.
timeout 1 > nul

cls
color D
echo (CTT) Disabling Unnecessary WiFi Settings...
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "Value" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "Value" /t REG_DWORD /d 0 /f
echo Unnecessary WiFi Settings disabled successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Disabling Teredo...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 1 /f
echo Teredo disabled successfully.
timeout 1 > nul

cls
color D
echo (CTT) Disabling IPv6...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d 255 /f
powershell -Command "Disable-NetAdapterBinding -Name '*' -ComponentID ms_tcpip6" >nul 2>&1
echo IPv6 disabled successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Disabling UAC...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v EnableLUA /t REG_DWORD /d 0
echo UAC disabled successfully.
timeout 1 > nul

cls
color D
chcp 437 >nul
echo (CTT) Setting Services to manual...
timeout 1 > nul
sc config AJRouter start=disabled
sc config ALG start=demand
sc config AppIDSvc start=demand >nul 2>&1 
sc config AppMgmt start=demand >nul 2>&1 
sc config AppReadiness start=demand
sc config AppVClient start=disabled >nul 2>&1 
sc config AppXSvc start=demand >nul 2>&1 
sc config Appinfo start=demand
sc config AssignedAccessManagerSvc start=disabled >nul 2>&1 
sc config AudioEndpointBuilder start=auto
sc config AudioSrv start=auto
sc config Audiosrv start=auto
sc config AxInstSV start=demand
sc config BDESVC start=demand >nul 2>&1 
sc config BFE start=auto >nul 2>&1 
sc config BITS start=delayed-auto
sc config BTAGService start=demand
sc config BcastDVRUserService_dc2a4 start=demand >nul 2>&1           
sc config BluetoothUserService_dc2a4 start=demand >nul 2>&1 
sc config BrokerInfrastructure start=auto >nul 2>&1 
sc config Browser start=demand >nul 2>&1 
sc config BthAvctpSvc start=auto
sc config BthHFSrv start=auto >nul 2>&1 
sc config CDPSvc start=demand
sc config CDPUserSvc_dc2a4 start=auto >nul 2>&1 
sc config COMSysApp start=demand
sc config CaptureService_dc2a4 start=demand >nul 2>&1 
sc config CertPropSvc start=demand
sc config ClipSVC start=demand >nul 2>&1 
sc config ConsentUxUserSvc_dc2a4 start=demand >nul 2>&1 
sc config CoreMessagingRegistrar start=auto >nul 2>&1 
sc config CredentialEnrollmentManagerUserSvc_dc2a4 start=demand >nul 2>&1 
sc config CryptSvc start=auto
sc config CscService start=demand >nul 2>&1 
sc config DPS start=auto
sc config DcomLaunch start=auto >nul 2>&1 
sc config DcpSvc start=demand >nul 2>&1 
sc config DevQueryBroker start=demand
sc config DeviceAssociationBrokerSvc_dc2a4 start=demand >nul 2>&1 
sc config DeviceAssociationService start=demand
sc config DeviceInstall start=demand
sc config DevicePickerUserSvc_dc2a4 start=demand >nul 2>&1 
sc config DevicesFlowUserSvc_dc2a4 start=demand >nul 2>&1 
sc config Dhcp start=auto
sc config DiagTrack start=disabled
sc config DialogBlockingService start=disabled >nul 2>&1 
sc config DispBrokerDesktopSvc start=auto
sc config DisplayEnhancementService start=demand
sc config DmEnrollmentSvc start=demand
sc config Dnscache start=auto >nul 2>&1 
sc config DoSvc start=delayed-auto >nul 2>&1 
sc config DsSvc start=demand
sc config DsmSvc start=demand
sc config DusmSvc start=auto
sc config EFS start=demand
sc config EapHost start=demand
sc config EntAppSvc start=demand >nul 2>&1 
sc config EventLog start=auto
sc config EventSystem start=auto
sc config FDResPub start=demand
sc config Fax start=demand >nul 2>&1 
sc config FontCache start=auto
sc config FrameServer start=demand
sc config FrameServerMonitor start=demand
sc config GraphicsPerfSvc start=demand
sc config HomeGroupListener start=demand >nul 2>&1 
sc config HomeGroupProvider start=demand >nul 2>&1 
sc config HvHost start=demand
sc config IEEtwCollectorService start=demand >nul 2>&1 
sc config IKEEXT start=demand
sc config InstallService start=demand
sc config InventorySvc start=demand
sc config IpxlatCfgSvc start=demand
sc config KeyIso start=auto
sc config KtmRm start=demand
sc config LSM start=auto >nul 2>&1 
sc config LanmanServer start=auto
sc config LanmanWorkstation start=auto
sc config LicenseManager start=demand
sc config LxpSvc start=demand
sc config MSDTC start=disabled
sc config MSiSCSI start=demand
sc config MapsBroker start=delayed-auto
sc config McpManagementService start=demand
sc config MessagingService_dc2a4 start=demand >nul 2>&1 
sc config MicrosoftEdgeElevationService start=demand
sc config MixedRealityOpenXRSvc start=demand >nul 2>&1 
sc config MpsSvc start=auto >nul 2>&1 
sc config MsKeyboardFilter start=demand >nul 2>&1 
sc config NPSMSvc_dc2a4 start=demand >nul 2>&1 
sc config NaturalAuthentication start=demand
sc config NcaSvc start=demand
sc config NcbService start=demand
sc config NcdAutoSetup start=demand
sc config NetSetupSvc start=demand
sc config NetTcpPortSharing start=disabled
sc config Netlogon start=demand
sc config Netman start=demand
sc config NgcCtnrSvc start=demand >nul 2>&1 
sc config NgcSvc start=demand >nul 2>&1 
sc config NlaSvc start=demand
sc config OneSyncSvc_dc2a4 start=auto >nul 2>&1 
sc config P9RdrService_dc2a4 start=demand >nul 2>&1 
sc config PNRPAutoReg start=demand
sc config PNRPsvc start=demand
sc config PcaSvc start=demand
sc config PeerDistSvc start=demand >nul 2>&1 
sc config PenService_dc2a4 start=demand >nul 2>&1  
sc config PerfHost start=demand
sc config PhoneSvc start=demand
sc config PimIndexMaintenanceSvc_dc2a4 start=demand >nul 2>&1 
sc config PlugPlay start=demand
sc config PolicyAgent start=demand
sc config Power start=auto
sc config PrintNotify start=demand
sc config PrintWorkflowUserSvc_dc2a4 start=demand >nul 2>&1 
sc config ProfSvc start=auto
sc config PushToInstall start=demand
sc config QWAVE start=demand
sc config RasAuto start=demand
sc config RasMan start=demand
sc config RemoteAccess start=disabled
sc config RemoteRegistry start=disabled
sc config RetailDemo start=demand
sc config RmSvc start=demand
sc config RpcEptMapper start=auto >nul 2>&1 
sc config RpcLocator start=demand
sc config RpcSs start=auto >nul 2>&1 
sc config SCPolicySvc start=demand
sc config SCardSvr start=demand
sc config SDRSVC start=demand
sc config SEMgrSvc start=demand
sc config SENS start=auto
sc config SNMPTRAP start=demand
sc config SNMPTrap start=demand
sc config SSDPSRV start=demand
sc config SamSs start=auto
sc config ScDeviceEnum start=demand
sc config Schedule start=auto >nul 2>&1 
sc config SecurityHealthService start=demand >nul 2>&1 
sc config Sense start=demand >nul 2>&1 
sc config SensorDataService start=demand
sc config SensorService start=demand
sc config SensrSvc start=demand
sc config SessionEnv start=demand
sc config SgrmBroker start=auto >nul 2>&1 
sc config SharedAccess start=demand
sc config SharedRealitySvc start=demand
sc config ShellHWDetection start=auto
sc config SmsRouter start=demand
sc config Spooler start=auto
sc config SstpSvc start=demand
sc config StateRepository start=demand >nul 2>&1 
sc config StiSvc start=demand
sc config StorSvc start=demand
sc config SysMain start=auto
sc config SystemEventsBroker start=auto >nul 2>&1 
sc config TabletInputService start=demand >nul 2>&1 
sc config TapiSrv start=demand
sc config TermService start=auto
sc config TextInputManagementService start=demand >nul 2>&1 
sc config Themes start=auto
sc config TieringEngineService start=demand
sc config TimeBroker start=demand >nul 2>&1 
sc config TimeBrokerSvc start=demand >nul 2>&1 
sc config TokenBroker start=demand
sc config TrkWks start=auto
sc config TroubleshootingSvc start=demand
sc config TrustedInstaller start=demand
sc config UI0Detect start=demand >nul 2>&1 
sc config UdkUserSvc_dc2a4 start=demand >nul 2>&1 
sc config UevAgentService start=disabled >nul 2>&1 
sc config UmRdpService start=demand
sc config UnistoreSvc_dc2a4 start=demand >nul 2>&1 
sc config UserDataSvc_dc2a4 start=demand >nul 2>&1 
sc config UserManager start=auto
sc config UsoSvc start=demand
sc config VGAuthService start=auto >nul 2>&1 
sc config VMTools start=auto >nul 2>&1 
sc config VSS start=demand
sc config VacSvc start=demand
sc config VaultSvc start=auto
sc config W32Time start=demand
sc config WEPHOSTSVC start=demand
sc config WFDSConMgrSvc start=demand
sc config WMPNetworkSvc start=demand >nul 2>&1 
sc config WManSvc start=demand
sc config WPDBusEnum start=demand
sc config WSService start=demand >nul 2>&1 
sc config WSearch start=delayed-auto
sc config WaaSMedicSvc start=demand >nul 2>&1 
sc config WalletService start=demand
sc config WarpJITSvc start=demand
sc config WbioSrvc start=demand
sc config Wcmsvc start=auto
sc config WcsPlugInService start=demand >nul 2>&1 
sc config WdNisSvc start=demand >nul 2>&1 
sc config WdiServiceHost start=demand
sc config WdiSystemHost start=demand
sc config WebClient start=demand
sc config Wecsvc start=demand
sc config WerSvc start=demand
sc config WiaRpc start=demand
sc config WinDefend start=auto >nul 2>&1
sc config WinHttpAutoProxySvc start=demand >nul 2>&1 
sc config WinRM start=demand
sc config Winmgmt start=auto
sc config WlanSvc start=auto
sc config WpcMonSvc start=demand
sc config WpnService start=demand
sc config WpnUserService_dc2a4 start=auto >nul 2>&1 
sc config WwanSvc start=demand
sc config XblAuthManager start=demand
sc config XblGameSave start=demand
sc config XboxGipSvc start=demand
sc config XboxNetApiSvc start=demand
sc config autotimesvc start=demand
sc config bthserv start=demand
sc config camsvc start=demand
sc config cbdhsvc_dc2a4 start=demand >nul 2>&1 
sc config cloudidsvc start=demand >nul 2>&1 
sc config dcsvc start=demand
sc config defragsvc start=demand
sc config diagnosticshub.standardcollector.service start=demand
sc config diagsvc start=demand
sc config dmwappushservice start=demand
sc config dot3svc start=demand
sc config edgeupdate start=demand
sc config edgeupdatem start=demand
sc config embeddedmode start=demand >nul 2>&1 
sc config fdPHost start=demand
sc config fhsvc start=demand
sc config gpsvc start=auto >nul 2>&1 
sc config hidserv start=demand
sc config icssvc start=demand
sc config iphlpsvc start=auto
sc config lfsvc start=demand
sc config lltdsvc start=demand
sc config lmhosts start=demand
sc config mpssvc start=auto >nul 2>&1 
sc config msiserver start=demand >nul 2>&1 
sc config netprofm start=demand
sc config nsi start=auto
sc config p2pimsvc start=demand
sc config p2psvc start=demand
sc config perceptionsimulation start=demand
sc config pla start=demand
sc config seclogon start=demand
sc config shpamsvc start=disabled
sc config smphost start=disabled
sc config spectrum start=demand
sc config sppsvc start=delayed-auto >nul 2>&1 
sc config ssh-agent start=disabled
sc config svsvc start=demand
sc config swprv start=demand
sc config tiledatamodelsvc start=auto >nul 2>&1 
sc config tzautoupdate start=disabled
sc config uhssvc start=disabled >nul 2>&1 
sc config upnphost start=demand
sc config vds start=demand
sc config vm3dservice start=demand >nul 2>&1 
sc config vmicguestinterface start=demand
sc config vmicheartbeat start=demand
sc config vmickvpexchange start=demand
sc config vmicrdv start=demand
sc config vmicshutdown start=demand
sc config vmictimesync start=demand
sc config vmicvmsession start=demand
sc config vmicvss start=demand
sc config vmvss start=demand >nul 2>&1 
sc config wbengine start=demand
sc config wcncsvc start=demand
sc config webthreatdefsvc start=demand
sc config webthreatdefusersvc_dc2a4 start=auto >nul 2>&1 
sc config wercplsupport start=demand
sc config wisvc start=demand
sc config wlidsvc start=demand
sc config wlpasvc start=demand
sc config wmiApSrv start=demand
sc config workfolderssvc start=demand
sc config wscsvc start=delayed-auto >nul 2>&1 
sc config wuauserv start=demand
sc config wudfsvc start=demand >nul 2>&1       
echo Services Set to manual successfully.
timeout 1 > nul

cls
color 9
echo (CTT) Disabling Telemetry...
timeout 1 > nul
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Application Experience\MareBackup" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable >nul 2>&1 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEverEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338387Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353698Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v EnthusiastMode /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v Start /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d 400 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v IRPStackSize /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d 0 /f
echo Telemetry disabled successfully.
timeout 1 > nul

cls
color D
echo (CTT) Running Telemetry Invoke Script...

:: Change boot menu policy to Legacy
bcdedit /set {current} bootmenupolicy Legacy >nul 2>&1

:: Check if the Windows build is less than 22557 and apply Task Manager tweak.
for /f "tokens=3" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild 2^>nul ^| findstr /r /c:"CurrentBuild"') do (
    if %%i lss 22557 (
        powershell -NoProfile -Command "Start-Process taskmgr.exe -WindowStyle Hidden"
        timeout /t 2 >nul
        :loop
        reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\TaskManager" /v Preferences >nul 2>&1
        if %errorlevel% neq 0 (
            timeout /t 1 >nul
            goto loop
        )
        taskkill /f /im taskmgr.exe >nul 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\TaskManager" /v Preferences /t REG_BINARY /d 0000000000000000000000000000000000000000000000000000000000000000 /f >nul 2>&1
    )
)

:: Remove specific registry item.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Remove-Item -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\MyComputer\\NameSpace\\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}' -Recurse -ErrorAction SilentlyContinue"

:: Remove Managed by your organization setting in Edge if exists
if exist "HKLM\SOFTWARE\Policies\Microsoft\Edge" (
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /f >nul 2>&1
)

:: Group svchost.exe processes, based on RAM capacity in KB.     
for /f %%a in ('powershell -Command "(Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb"') do set "ram_kb=%%a"
powershell -Command "Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control' -Name 'SvcHostSplitThresholdInKB' -Type DWord -Value %ram_kb% -Force"

:: Remove AutoLogger-Diagtrack-Listener.etl if exists and deny SYSTEM permissions
set "autoLoggerDir=%PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\AutoLogger"
if exist "%autoLoggerDir%\AutoLogger-Diagtrack-Listener.etl" (
    del /q "%autoLoggerDir%\AutoLogger-Diagtrack-Listener.etl" >nul 2>&1
)
icacls "%autoLoggerDir%" /deny SYSTEM:(OI)(CI)F >nul 2>&1

:: Disabling Core isolation/Memory integrity
reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1 

:: Fake Success Output. 
echo The operation completed successfully.
echo The operation completed successfully.
echo The operation completed successfully.
echo The operation completed successfully.
echo Telemetry Invoke Script ran successfully.
timeout 1 > nul

cls
color 9
echo (Quaked) Running OOshutup10 with imported optimized settings...
set "exePath=C:\Oneclick Tools\OOshutup10\OOSU10.exe"
set "cfgPath=C:\Oneclick Tools\OOshutup10\QuakedOOshutup10.cfg"
chcp 65001 >nul 2>&1
echo.
echo ╔═════════════════════════════╗
echo ║                             ║
echo ║   Importing configuration   ║
echo ║                             ║
echo ╚═════════════════════════════╝
chcp 437 >nul
"%exePath%" "%cfgPath%" /quiet
echo.
echo OOshutup10 Config imported successfully.
timeout 1 > nul   

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
echo.                                                 ██████╗████████╗████████╗
echo.                                                ██╔════╝╚══██╔══╝╚══██╔══╝
echo.                                                ██║        ██║      ██║   
echo.                                                ██║        ██║      ██║   
echo.                                                ╚██████╗   ██║      ██║   
echo.                                                 ╚═════╝   ╚═╝      ╚═╝   
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║           (CTT) Tweaks Ran Successfully...         ║       
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo.
echo.                                                                          
timeout 1 > nul  

:: Privacy is Freedom's Service Control tweaks.
cls
color 9
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                                   ██████╗ ██╗███████╗
echo.                                                   ██╔══██╗██║██╔════╝
echo.                                                   ██████╔╝██║█████╗  
echo.                                                   ██╔═══╝ ██║██╔══╝  
echo.                                                   ██║     ██║██║     
echo.                                                   ╚═╝     ╚═╝╚═╝     
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║  Running Privacy is Freedom's Service Control...   ║       
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo.
echo.                                                                          
timeout 1 > nul  

cls
color D
chcp 437 >nul
echo (PiF) Disable Unnecessary Services and Tasks
reg add "HKLM\System\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\WinHttpAutoProxySvc" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "MicrophoneCaptureEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "2" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowgameDVR" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f
sc config wlidsvc start= disabled
sc config DisplayEnhancementService start= disabled
sc config DiagTrack start= disabled
sc config DusmSvc start= disabled
sc config TabletInputService start= disabled >nul 2>&1
sc config RetailDemo start= disabled
sc config Fax start= disabled >nul 2>&1
sc config SharedAccess start= disabled
sc config lfsvc start= disabled
sc config WpcMonSvc start= disabled
sc config SessionEnv start= disabled
sc config MicrosoftEdgeElevationService start= disabled
sc config edgeupdate start= disabled
sc config edgeupdatem start= disabled
sc config autotimesvc start= disabled
sc config CscService start= disabled >nul 2>&1
sc config TermService start= disabled
sc config SensorDataService start= disabled
sc config SensorService start= disabled
sc config SensrSvc start= disabled
sc config shpamsvc start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config PhoneSvc start= disabled
sc config TapiSrv start= disabled
sc config UevAgentService start= disabled >nul 2>&1
sc config WalletService start= disabled
sc config TokenBroker start= disabled
sc config WebClient start= disabled
sc config MixedRealityOpenXRSvc start= disabled >nul 2>&1
sc config stisvc start= disabled
sc config WbioSrvc start= disabled
sc config icssvc start= disabled
sc config Wecsvc start= disabled
sc config XboxGipSvc start= disabled
sc config XblAuthManager start= disabled
sc config XboxNetApiSvc start= disabled
sc config XblGameSave start= disabled
sc config SEMgrSvc start= disabled
sc config iphlpsvc start= disabled
sc config Backupper Service start= disabled >nul 2>&1
sc config BthAvctpSvc start= disabled
sc config BDESVC start= disabled >nul 2>&1
sc config cbdhsvc start= disabled
sc config CDPSvc start= disabled
sc config CDPUserSvc start= disabled
sc config DevQueryBroker start= disabled
sc config DevicesFlowUserSvc start= disabled
sc config dmwappushservice start= disabled
sc config DispBrokerDesktopSvc start= disabled
sc config TrkWks start= disabled
sc config dLauncherLoopback start= disabled >nul 2>&1
sc config EFS start= disabled
sc config fdPHost start= disabled
sc config FDResPub start= disabled
sc config IKEEXT start= disabled
sc config NPSMSvc start= disabled
sc config WPDBusEnum start= disabled
sc config PcaSvc start= disabled
sc config RasMan start= disabled
sc config RetailDemo start=disabled
sc config SstpSvc start=disabled
sc config ShellHWDetection start= disabled
sc config SSDPSRV start= disabled
sc config SysMain start= disabled
sc config OneSyncSvc start= disabled
sc config lmhosts start= disabled
sc config UserDataSvc start= disabled
sc config UnistoreSvc start= disabled
sc config Wcmsvc start= disabled
sc config FontCache start= disabled
sc config W32Time start= disabled
sc config tzautoupdate start= disabled
sc config DsSvc start= disabled
sc config DevicesFlowUserSvc_5f1ad start= disabled >nul 2>&1
sc config diagsvc start= disabled
sc config DialogBlockingService start= disabled >nul 2>&1
sc config PimIndexMaintenanceSvc_5f1ad start= disabled >nul 2>&1
sc config MessagingService_5f1ad start= disabled >nul 2>&1
sc config AppVClient start= disabled >nul 2>&1
sc config MsKeyboardFilter start= disabled >nul 2>&1
sc config NetTcpPortSharing start= disabled
sc config ssh-agent start= disabled
sc config SstpSvc start= disabled
sc config OneSyncSvc_5f1ad start= disabled >nul 2>&1
sc config wercplsupport start= disabled
sc config WMPNetworkSvc start= disabled >nul 2>&1
sc config WerSvc start= disabled
sc config WpnUserService_5f1ad start= disabled >nul 2>&1
sc config WinHttpAutoProxySvc start= disabled >nul 2>&1
schtasks /DELETE /TN "AMDInstallLauncher" /f >nul 2>&1
schtasks /DELETE /TN "AMDLinkUpdate" /f >nul 2>&1
schtasks /DELETE /TN "AMDRyzenMasterSDKTask" /f >nul 2>&1
schtasks /DELETE /TN "Driver Easy Scheduled Scan" /f >nul 2>&1
schtasks /DELETE /TN "ModifyLinkUpdate" /f >nul 2>&1
schtasks /DELETE /TN "SoftMakerUpdater" /f >nul 2>&1
schtasks /DELETE /TN "StartCN" /f >nul 2>&1
schtasks /DELETE /TN "StartDVR" /f >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /Disable
schtasks /Change /TN "Microsoft\Windows\Device Information\Device" /Disable
schtasks /Change /TN "Microsoft\Windows\Device Information\Device User" /Disable
schtasks /Change /TN "Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /Disable
schtasks /Change /TN "Microsoft\Windows\Diagnosis\Scheduled" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskCleanup\SilentCleanup" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\StorageSense" /Disable
schtasks /Change /TN "Microsoft\Windows\DUSM\dusmtask" /Disable
schtasks /Change /TN "Microsoft\Windows\EnterpriseMgmt\MDMMaintenenceTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\OneSettings\RefreshCache" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\LocalUserSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\MouseSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\PenSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\TouchpadSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\International\Synchronize Language Settings" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Installation" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Management\Provisioning\Cellular" /Disable
schtasks /Change /TN "Microsoft\Windows\Management\Provisioning\Logon" /Disable
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsToastTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\MUI\LPRemove" /Disable
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable
schtasks /Change /TN "Microsoft\Windows\PushToInstall\Registration" /Disable
schtasks /Change /TN "Microsoft\Windows\Ras\MobilityManager" /Disable
schtasks /Change /TN "Microsoft\Windows\RecoveryEnvironment\VerifyWinRE" /Disable
schtasks /Change /TN "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\RetailDemo\CleanupOfflineContent" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Servicing\StartComponentCleanup" /Disable
schtasks /Change /TN "Microsoft\Windows\SettingSync\NetworkStateChangeTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Setup\SetupCleanupTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Setup\SnapshotCleanupTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\SpacePort\SpaceAgentTask" /Disable
schtasks /Change /TN "Microsoft\Windows\SpacePort\SpaceManagerTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Speech\SpeechModelDownloadTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization" /Disable
schtasks /Change /TN "Microsoft\Windows\Sysmain\ResPriStaticDbSync" /Disable
schtasks /Change /TN "Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Task Manager\Interactive" /Disable
schtasks /Change /TN "Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable
schtasks /Change /TN "Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable
schtasks /Change /TN "Microsoft\Windows\Time Zone\SynchronizeTimeZone" /Disable
schtasks /Change /TN "Microsoft\Windows\TPM\Tpm-HASCertRetr" /Disable
schtasks /Change /TN "Microsoft\Windows\TPM\Tpm-Maintenance" /Disable
schtasks /Change /TN "Microsoft\Windows\UPnP\UPnPHostConfig" /Disable
schtasks /Change /TN "Microsoft\Windows\User Profile Service\HiveUploadTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WDI\ResolutionHost" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange" /Disable
schtasks /Change /TN "Microsoft\Windows\WOF\WIM-Hash-Management" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WOF\WIM-Hash-Validation" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" /Disable
schtasks /Change /TN "Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /Disable
schtasks /Change /TN "Microsoft\Windows\Workplace Join\Automatic-Device-Join" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WwanSvc\NotificationTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WwanSvc\OobeDiscovery" /Disable
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /Disable
echo Unnecessary Services and Tasks disabled successfully.
timeout 1 > nul

cls
color 9
echo (PiF) Disabling Windows Update and Store Services and Tasks.
sc stop uhssvc >nul 2>&1
sc stop upfc >nul 2>&1
sc stop PushToInstall >nul 2>&1
sc stop BITS >nul 2>&1
sc stop InstallService >nul 2>&1
sc stop uhssvc >nul 2>&1
sc stop UsoSvc >nul 2>&1
sc stop wuauserv >nul 2>&1
sc stop LanmanServer >nul 2>&1
sc config BITS start= disabled
sc config InstallService start= disabled
sc config uhssvc start= disabled >nul 2>&1
sc config UsoSvc start= disabled
sc config wuauserv start= disabled
sc config LanmanServer start= disabled
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DoSvc" /v Start /t reg_dword /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\InstallService" /v Start /t reg_dword /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /t reg_dword /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wuauserv" /v Start /t reg_dword /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t reg_dword /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BITS" /v Start /t reg_dword /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\upfc" /v Start /t reg_dword /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\uhssvc" /v Start /t reg_dword /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ossrs" /v Start /t reg_dword /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpdatePeriod" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgrade" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgradePeriod" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d "1" /f
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdates" /Disable
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Disable
schtasks /Change /TN "Microsoft\Windows\InstallService\SmartRetry" /Disable
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WaaSMedic\PerformRemediation" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" /Disable
echo Windows Update and Store Services and Tasks disabled successfully.
timeout 1 > nul

cls
color D
echo (PiF) Disabling Remote Services and Tasks.
sc config RemoteRegistry start= disabled
sc config RemoteAccess start= disabled
sc config WinRM start= disabled
sc config RmSvc start= disabled
echo Remote Services and Tasks disabled successfully.
timeout 1 > nul

cls
color 9
echo (PiF) Disabling Printer Services and Tasks..
sc config PrintNotify start= disabled
sc config Spooler start= disabled
schtasks /Change /TN "Microsoft\Windows\Printing\EduPrintProv" /Disable 
schtasks /Change /TN "Microsoft\Windows\Printing\PrinterCleanupTask" /Disable 
echo Printer Services and Tasks disabled successfully.
timeout 1 > nul

cls
color D
echo (PiF) Disabling Bluetooth Services...
sc config BTAGService start= disabled
sc config bthserv start= disabled
echo [SC] ChangeServiceConfig SUCCESS
echo Bluetooth Services disabled successfully.
timeout 1 > nul

cls
color 9
echo (PiF) Disabling Wifi Services and Tasks...
sc config NlaSvc start= disabled
sc config LanmanWorkstation start= disabled
sc config BFE start= demand >nul 2>&1
sc config Dnscache start= demand >nul 2>&1
sc config WinHttpAutoProxySvc start= demand >nul 2>&1
sc config Dhcp start= auto 
sc config DPS start= auto 
sc config lmhosts start= disabled
sc config nsi start= auto
sc config Wcmsvc start= disabled
sc config Winmgmt start= auto
sc config WlanSvc start= demand
reg add "HKLM\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "NoActiveProbe" /t REG_DWORD /d "1" /f
reg add "HKLM\System\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "0" /f
schtasks /Change /TN "Microsoft\Windows\WlanSvc\CDSSync" /Disable
schtasks /Change /TN "Microsoft\Windows\WCM\WiFiTask" /Disable
schtasks /Change /TN "Microsoft\Windows\NlaSvc\WiFiTask" /Disable
schtasks /Change /TN "Microsoft\Windows\DUSM\dusmtask" /Disable >nul 2>&1
echo Wifi Services and Tasks disabled successfully.
timeout 1 > nul

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
echo.                                                   ██████╗ ██╗███████╗
echo.                                                   ██╔══██╗██║██╔════╝
echo.                                                   ██████╔╝██║█████╗  
echo.                                                   ██╔═══╝ ██║██╔══╝  
echo.                                                   ██║     ██║██║     
echo.                                                   ╚═╝     ╚═╝╚═╝     
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║           (PiF) Tweaks Ran Sucessfully...          ║       
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo.
echo.                                                                          
timeout 1 > nul  

:: (Quaked) Windows Cleanup. 
cls
color 9
chcp 65001 >nul 2>&1
echo. 
echo.
echo.
echo.
echo.
echo.                                 ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗███████╗ 
echo.                                 ██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║██╔════╝ 
echo.                                 ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║███████╗ 
echo.                                 ██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║╚════██║ 
echo.                                 ╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝███████║ 
echo.                                  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝ 
echo.                                                           
echo.                                  ██████╗██╗     ███████╗ █████╗ ███╗   ██╗██╗   ██╗██████╗ 
echo.                                 ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║██║   ██║██╔══██╗
echo.                                 ██║     ██║     █████╗  ███████║██╔██╗ ██║██║   ██║██████╔╝
echo.                                 ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║██║   ██║██╔═══╝ 
echo.                                 ╚██████╗███████╗███████╗██║  ██║██║ ╚████║╚██████╔╝██║     
echo.                                  ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝   
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║        Running Quaked's Windows Cleanup...         ║       
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo. 
echo.
echo.                                                                          
timeout 1 > nul

cls
color D
chcp 437 >nul
echo (Quaked) Disabling Regular Services...
timeout 1 > nul
sc config ALG start=disabled
sc config AJRouter start=disabled
sc config XblAuthManager start=disabled
sc config XblGameSave start=disabled
sc config XboxNetApiSvc start=disabled
sc config WSearch start=disabled
sc config lfsvc start=disabled
sc config RemoteRegistry start=disabled
sc config WpcMonSvc start=disabled
sc config SEMgrSvc start=disabled
sc config SCardSvr start=disabled
sc config Netlogon start=disabled
sc config CscService start=disabled >nul 2>&1 
sc config icssvc start=disabled 
sc config wisvc start=disabled 
sc config RetailDemo start=disabled 
sc config WalletService start=disabled 
sc config Fax start=disabled >nul 2>&1 
sc config WbioSrvc start=disabled 
sc config iphlpsvc start=disabled 
sc config wcncsvc start=disabled 
sc config fhsvc start=disabled 
sc config PhoneSvc start=disabled 
sc config seclogon start=disabled 
sc config FrameServer start=disabled 
sc config WbioSrvc start=disabled 
sc config StiSvc start=disabled 
sc config PcaSvc start=disabled 
sc config DPS start=disabled 
sc config MapsBroker start=disabled 
sc config bthserv start=disabled 
sc config BDESVC start=disabled >nul 2>&1
sc config BthAvctpSvc start=disabled 
sc config WpcMonSvc start=disabled 
sc config DiagTrack start=disabled 
sc config CertPropSvc start=disabled 
sc config WdiServiceHost start=disabled 
sc config lmhosts start=disabled 
sc config WdiSystemHost start=disabled 
sc config TrkWks start=disabled 
sc config WerSvc start=disabled 
sc config TabletInputService start=disabled >nul 2>&1 
sc config EntAppSvc start=disabled >nul 2>&1
sc config Spooler start=disabled 
sc config BcastDVRUserService start=disabled 
sc config WMPNetworkSvc start=disabled >nul 2>&1
sc config diagnosticshub.standardcollector.service start=disabled 
sc config DmEnrollmentSvc start=disabled 
sc config PNRPAutoReg start=disabled 
sc config wlidsvc start=disabled 
sc config AXInstSV start=disabled 
sc config lfsvc start=disabled 
sc config NcbService start=disabled 
sc config DeviceAssociationService start=disabled
sc config StorSvc start=disabled 
sc config TieringEngineService start=disabled 
sc config DPS start=disabled 
sc config Themes start=disabled 
sc config AppReadiness start=disabled 
echo Regular Services disabled successfully.
timeout 1 > nul

cls
color 9
echo (Quaked) Disabling Hyper-V Services...
sc config HvHost start=disabled 
sc config vmickvpexchange start=disabled 
sc config vmicguestinterface start=disabled 
sc config vmicshutdown start=disabled 
sc config vmicheartbeat start=disabled 
sc config vmicvmsession start=disabled 
sc config vmicrdv start=disabled 
sc config vmictimesync start=disabled 
sc config vmicvss start=disabled 
echo Hyper-V Services disabled successfully.
timeout 1 > nul

cls
color D
echo (Quaked) Disabling Browsers Services...
sc config edgeupdate start=disabled >nul 2>&1
sc config edgeupdatem start=disabled >nul 2>&1
sc config GoogleChromeElevationService start=disabled >nul 2>&1
sc config gupdate start=disabled >nul 2>&1
sc config gupdatem start=disabled >nul 2>&1
sc config BraveElevationService start=disabled >nul 2>&1
sc config brave start=disabled >nul 2>&1
sc config bravem start=disabled >nul 2>&1

:: Fake Success Output.
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo Browsers Services disabled successfully.
timeout 1 > nul

cls
color 9
echo (Quaked) Disabling Cpu Services...

:: Intel Bloat.
sc config NcbService start=disabled >nul 2>&1
sc config jhi_service start=disabled >nul 2>&1
sc config WMIRegistrationService start=disabled >nul 2>&1
sc config "Intel(R) TPM Provisioning Service" start=disabled >nul 2>&1
sc config "Intel(R) Platform License Manager Service" start=disabled >nul 2>&1
sc config ipfsvc start=disabled >nul 2>&1
sc config igccservice start=disabled >nul 2>&1
sc config cplspcon start=disabled >nul 2>&1
sc config esifsvc start=disabled >nul 2>&1
sc config LMS start=disabled >nul 2>&1
sc config ibtsiva start=disabled >nul 2>&1
sc config IntelAudioService start=disabled >nul 2>&1
sc config "Intel(R) Capability Licensing Service TCP IP Interface" start=disabled >nul 2>&1
sc config cphs start=disabled >nul 2>&1
sc config DSAService start=disabled >nul 2>&1
sc config DSAUpdateService start=disabled >nul 2>&1
sc config igfxCUIService2.0.0.0 start=disabled >nul 2>&1
sc config RstMwService start=disabled >nul 2>&1
sc config "Intel(R) SUR QC SAM" start=disabled >nul 2>&1
sc config SystemUsageReportSvc_QUEENCREEK start=disabled >nul 2>&1
sc config iaStorAfsService start=disabled >nul 2>&1

:: AMD Bloat, NSudo needed to disable! | Disables unnecessary AMD services.
"C:\Oneclick Tools\NSudo\NSudoLG.exe" -ShowWindowMode:hide -U:T -P:E "C:\Oneclick Tools\Amd\AMD.bat"

:: Fake Success Output.
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo Cpu Services disabled successfully.
timeout 1 > nul

cls
color D
echo (Quaked) Disabling Manufacturer/Prebuild Services...

:: Sound Bloat | NSudo needed to disable! | Deletes Realtek, Sound Research and VisiSonics bloat.
"C:\Oneclick Tools\NSudo\NSudoLG.exe" -ShowWindowMode:hide -U:T -P:E "C:\Oneclick Tools\Sound\Sound.bat"

:: HP Bloat.
sc config HPAppHelperCap start=disabled >nul 2>&1
sc config HPDiagsCap start=disabled >nul 2>&1
sc config HpTouchpointAnalyticsService start=disabled >nul 2>&1
sc config HPNetworkCap start=disabled >nul 2>&1
sc config HPOmenCap start=disabled >nul 2>&1
sc config HPSysInfoCap start=disabled >nul 2>&1

:: Gigabtye Bloat.
taskkill /f /im spd.exe >nul 2>&1
taskkill /f /im EasyTuneEngineService.exe >nul 2>&1
taskkill /f /im GraphicsCardEngine.exe >nul 2>&1
net stop "cFosSpeedS" >nul 2>&1
net stop "GigabyteUpdateService" >nul 2>&1
sc config cFosSpeedS start=disabled >nul 2>&1
sc config GigabyteUpdateService start=disabled >nul 2>&1
rd /s /q "C:\Program Files\cFosSpeed" >nul 2>&1
rd /s /q "C:\Program Files\GIGABYTE\Control Center\Lib\GBT_VGA\Service" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Gigabyte\EasyTuneEngineService" >nul 2>&1

:: CCleaner Bloat.
taskkill /f /im CCleaner64.exe >nul 2>&1
taskkill /f /im CCleanerPerformanceOptimizerService.exe >nul 2>&1
taskkill /f /im CCleanerBrowser.exe >nul 2>&1
net stop "ccleaner" >nul 2>&1
net stop "ccleanerm" >nul 2>&1
net stop "CCleanerPerformanceOptimizerService" >nul 2>&1
sc config ccleaner start=disabled >nul 2>&1
sc config ccleanerm start=disabled >nul 2>&1
sc config CCleanerPerformanceOptimizerService start=disabled >nul 2>&1
rd /s /q "C:\Program Files\CCleaner" >nul 2>&1
rd /s /q "C:\Program Files (x86)\CCleaner Browser" >nul 2>&1
rd /s /q  "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\CCleaner" >nul 2>&1

:: Logitech
sc config logi_lamparray_service start=disabled >nul 2>&1

:: Fake Success Output.
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo [SC] ChangeServiceConfig SUCCESS
echo Manufacturer/Prebuild Services disabled successfully.
timeout 1 > nul

cls
color D
echo (Quaked) Disabling and Deleting Unnecessary Tasks...

:: Orca/UpdateOrchestrator Bloat, NSudo needed to disable! | Deletes UpdateOrchestrator task.
"C:\Oneclick Tools\NSudo\NSudoLG.exe" -ShowWindowMode:hide -U:T -P:E "C:\Oneclick Tools\Orca\Orca.bat"

schtasks /Change /TN "GoogleUpdateTaskMachineCore{9C99738B-B026-4A33-A16D-7CCD7650D527}" /Disable >nul 2>&1
schtasks /Change /TN "GoogleUpdateTaskMachineUA{2E0C9FAD-7C87-42A8-8EFF-986A5662B894}" /Disable >nul 2>&1
schtasks /Change /TN "Opera GX scheduled Autoupdate 1711926802" /Disable >nul 2>&1
schtasks /Change /TN "BraveSoftwareUpdateTaskMachineCore{A8A54493-B843-4D11-BA1F-30C26E9F10BE}" /Disable >nul 2>&1
schtasks /Change /TN "BraveSoftwareUpdateTaskMachineUA{FF1E0511-D7AF-4DB6-8A41-DC39EA60EC93}" /Disable >nul 2>&1
schtasks /Change /TN "CCleaner Update" /Disable >nul 2>&1
schtasks /Change /TN "CCleanerCrashReporting" /Disable >nul 2>&1
schtasks /Change /TN "CCleanerUpdateTaskMachineCore" /Disable >nul 2>&1
schtasks /Change /TN "CCleanerUpdateTaskMachineUA" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\capabilityaccessmanager" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Setup\SetupCleanupTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Setup\SnapshotCleanupTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefreshTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\ThemesSyncedImageDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\UpdateUserPictureTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64 Critical" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 Critical" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\SdbinstMergeDbTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Printing\PrintJobCleanupTask" /Disable >nul 2>&1
schtasks /Delete /TN "GoogleUpdateTaskMachineCore{9C99738B-B026-4A33-A16D-7CCD7650D527}" /F >nul 2>&1
schtasks /Delete /TN "GoogleUpdateTaskMachineUA{2E0C9FAD-7C87-42A8-8EFF-986A5662B894}" /F >nul 2>&1
schtasks /Delete /TN "Opera GX scheduled Autoupdate 1711926802" /F >nul 2>&1
schtasks /Delete /TN "BraveSoftwareUpdateTaskMachineCore{A8A54493-B843-4D11-BA1F-30C26E9F10BE}" /F >nul 2>&1
schtasks /Delete /TN "BraveSoftwareUpdateTaskMachineUA{FF1E0511-D7AF-4DB6-8A41-DC39EA60EC93}" /F >nul 2>&1
schtasks /Delete /TN "CCleaner Update" /F >nul 2>&1
schtasks /Delete /TN "CCleanerCrashReporting" /F >nul 2>&1
schtasks /Delete /TN "CCleanerUpdateTaskMachineCore" /F >nul 2>&1
schtasks /Delete /TN "CCleanerUpdateTaskMachineUA" /F >nul 2>&1
echo Disabled and Deleted Unnecessary Tasks successfully.
timeout 1 > nul

cls
color 9
echo (Quaked) Removing Xbox Gaming Service...
powershell -command "get-appxpackage Microsoft.GamingServices | remove-AppxPackage -allusers" >nul 2>&1
echo The operation completed successfully.
echo Xbox Gaming Service deleted successfully.
timeout 1 > nul

cls
color D
echo (Quaked) Removing GameBarPresenceWriter...
set "fileToDelete=%SystemRoot%\System32\GameBarPresenceWriter.exe"
if exist "%fileToDelete%" (
    echo Taking ownership of the file.
    takeown /F "%fileToDelete%" >nul 2>&1
    echo Adjusting permissions.
    icacls "%fileToDelete%" /grant administrators:F >nul 2>&1
    echo Removing Gamebar Presence Writer.
    del "%fileToDelete%" /s /f /q
) else (
    echo File not found: %fileToDelete%.
)
timeout 1 > nul

cls
color 9
echo (Quaked) Removing Microsoft Edge...
echo Stopping Edge Tasks.
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im msedge.exe /fi "IMAGENAME eq msedge.exe" >nul 2>&1
taskkill /f /im msedge.exe /fi "IMAGENAME eq msedge.exe" >nul 2>&1
echo Deleting Edge Directories.
rd /s /q "C:\Program Files (x86)\Microsoft\Edge" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeCore" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeWebView" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\Temp" >nul 2>&1
echo Deleting Microsoft Edge Shortcuts.
del "C:\Users\Public\Desktop\Microsoft Edge.lnk" >nul 2>&1
del "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" >nul 2>&1
del "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk" >nul 2>&1
echo Microsoft Edge deleted successfully.
timeout 1 > nul

cls
color D
echo (Quaked) Removing OneDrive...
echo Stopping OneDrive Tasks.
taskkill.exe /F /IM "OneDrive.exe"
taskkill.exe /F /IM "explorer.exe"
echo Removing OneDrive.
winget uninstall --silent --accept-source-agreements Microsoft.OneDrive >nul 2>&1
echo The operation completed successfully.
echo Removing OneDrive Shortcuts.
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f >nul 2>&1
reg unload "hku\Default"
del /f /q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1
schtasks /delete /tn "OneDrive*" /f >nul 2>&1
echo Restarting Explorer.
start explorer.exe
echo OneDrive deleted successfully.
timeout 1 > nul

cls
color 9
echo (Quaked) Removing UsoCoreWorker and UsoClient...
set "usoClientFileToDelete=C:\Windows\System32\UsoClient.exe"
set "usoCoreWorkerFileToDelete=C:\Windows\UUS\amd64\MoUsoCoreWorker.exe"
if exist "%usoClientFileToDelete%" (
    echo.
    echo Taking ownership of the file.
    takeown /F "%usoClientFileToDelete%" >nul 2>&1
    echo Adjusting permissions.
    icacls "%usoClientFileToDelete%" /grant administrators:F >nul 2>&1
    echo Removing UsoClient.
    del "%usoClientFileToDelete%" /f /q
    echo File deleted successfully.
) else (
    echo File not found: %usoClientFileToDelete%.
)
if exist "%usoCoreWorkerFileToDelete%" (
    echo.
    echo Taking ownership of the file.
    takeown /F "%usoCoreWorkerFileToDelete%" >nul 2>&1
    echo Adjusting permissions.
    icacls "%usoCoreWorkerFileToDelete%" /grant administrators:F >nul 2>&1
    echo Removing MoUsoCoreWorker.
    del "%usoCoreWorkerFileToDelete%" /f /q
    echo File deleted successfully.
) else (
    echo File not found: %usoCoreWorkerFileToDelete%.
)
timeout 1 > nul

cls
color D
echo (Quaked) Removing Widget and WidgetService...
echo Closing WidgetService and Widgets.
taskkill /F /IM WidgetService.exe >nul 2>&1
taskkill /F /IM Widgets.exe >nul 2>&1
echo Uninstalling Windows web experience Pack...
winget uninstall --silent --accept-source-agreements "Windows web experience Pack" >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f
CD /D "C:\Program Files\WindowsApps\MicrosoftWindows.Client.WebExperience_424.1301.450.0_x64__cw5n1h2txyewy\Dashboard" >nul 2>&1
echo echo %CD% >nul 2>&1
set "file1ToDelete=WidgetService.exe"
set "file2ToDelete=Widgets.exe"
if exist "%file1ToDelete%" (
    echo Taking ownership of %file1ToDelete%.
    takeown /F "%file1ToDelete%" >nul 2>&1
    echo Adjusting permissions for %file1ToDelete%.
    icacls "%file1ToDelete%" /grant administrators:F >nul 2>&1
    echo Removing %file1ToDelete%.
    del "%file1ToDelete%" /s /f /q
    echo %file1ToDelete% deleted successfully.
) else (
    echo File not found: %file1ToDelete%. >nul 2>&1
)
if exist "%file2ToDelete%" (
    echo.
    echo Taking ownership of %file2ToDelete%.
    takeown /F "%file2ToDelete%" >nul 2>&1
    echo Adjusting permissions for %file2ToDelete%.
    icacls "%file2ToDelete%" /grant administrators:F >nul 2>&1
    echo Removing %file2ToDelete%.
    del "%file2ToDelete%" /s /f /q
    echo %file2ToDelete% deleted successfully.
) else (
    echo File not found: %file2ToDelete%. >nul 2>&1
)
timeout 1 > nul

cls
color 9
echo (Quaked) Removing Smartscreen...
set "smartscreenFileToDelete1=C:\Windows\System32\smartscreen.exe"
set "smartscreenFileToDelete2=C:\Windows\SystemApps\Microsoft.Windows.AppRep.ChxApp_cw5n1h2txyewy\CHXSmartScreen.exe"
if exist "%smartscreenFileToDelete1%" (
    echo.
    echo Taking ownership of the file.
    takeown /F "%smartscreenFileToDelete1%" >nul 2>&1
    echo Adjusting permissions.
    icacls "%smartscreenFileToDelete1%" /grant administrators:F >nul 2>&1
    echo Removing Smartscreen.exe from System32.
    del "%smartscreenFileToDelete1%" /f /q
    echo File deleted successfully.
) else (
    echo File not found: %smartscreenFileToDelete1%.
)
if exist "%smartscreenFileToDelete2%" (
    echo.
    echo Taking ownership of the file.
    takeown /F "%smartscreenFileToDelete2%" >nul 2>&1
    echo Adjusting permissions.
    icacls "%smartscreenFileToDelete2%" /grant administrators:F >nul 2>&1
    echo Removing CHXSmartScreen.exe from SystemApps.
    del "%smartscreenFileToDelete2%" /f /q
    echo File deleted successfully.
) else (
    echo File not found: %smartscreenFileToDelete2%.
)
timeout 1 > nul

cls
color D
echo (Quaked) Removing LockApp...
set "lockAppFileToDelete=C:\Windows\SystemApps\Microsoft.LockApp_cw5n1h2txyewy\LockApp.exe"
if exist "%lockAppFileToDelete%" (
    echo Taking ownership of the file.
    takeown /F "%lockAppFileToDelete%" >nul 2>&1
    echo Adjusting permissions.
    icacls "%lockAppFileToDelete%" /grant administrators:F >nul 2>&1
    echo Removing LockApp.exe from SystemApps.
    del "%lockAppFileToDelete%" /f /q
    echo File deleted successfully.
) else (
    echo File not found: %lockAppFileToDelete%.
)
timeout 1 > nul

:InstallOpen
cls
color 9
echo (Quaked) Removing Windows Search and Installing alternative called "Open Shell Menu"...
echo.
chcp 437 >nul
powershell -Command "Write-Host '(Not recommended) Can only get search back by system restoring.' -ForegroundColor White -BackgroundColor Red" 
echo.
echo Do you want to remove Windows Search?
echo Leads to a reduction of 4-6 processes, and a installation of a alternative called "Open Shell Menu" that's lighter!
echo.
set /p choice=Enter (Y/N): 
echo.
if /i "%choice%"=="Y" (
    echo Removing Windows Search! 
    timeout 1 > nul
    goto :SearchRemover
) else if /i "%choice%"=="N" ( 
    echo Skipping Search Removal and Open Shell Menu Install! 
    timeout 2 > nul
    goto :SkipSearchRemover
) else (
    cls
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    goto :InstallOpen
)

:SearchRemover
cls
color D
echo (Quaked) Removing Search...
set "SearchFileToDelete1=C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe"
set "SearchFileToDelete2=C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe"
set "SearchFileToDelete3=C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe"
set "SearchFileToDelete4=C:\Windows\System32\taskhostw.exe"
if exist "%SearchFileToDelete1%" (
    echo.
    echo Taking ownership of the file.
    takeown /F "%SearchFileToDelete1%" >nul 2>&1
    echo Adjusting permissions.
    icacls "%SearchFileToDelete1%" /grant administrators:F >nul 2>&1
    echo Removing SearchHost.exe.
    del "%SearchFileToDelete1%" /f /q
    echo File deleted successfully.
) else (
    echo File not found: %SearchFileToDelete1%.
)
if exist "%SearchFileToDelete2%" (
    echo.
    echo Taking ownership of the file.
    takeown /F "%SearchFileToDelete2%" >nul 2>&1
    echo Adjusting permissions.
    icacls "%SearchFileToDelete2%" /grant administrators:F >nul 2>&1
    echo Removing StartMenuExperienceHost.exe.
    del "%SearchFileToDelete2%" /f /q
    echo File deleted successfully.
) else (
    echo File not found: %SearchFileToDelete2%.
)
if exist "%SearchFileToDelete3%" (
    echo.
    echo Taking ownership of the file.
    takeown /F "%SearchFileToDelete3%" >nul 2>&1
    echo Adjusting permissions.
    icacls "%SearchFileToDelete3%" /grant administrators:F >nul 2>&1
    echo Removing ShellExperienceHost.exe.
    del "%SearchFileToDelete3%" /f /q
    echo File deleted successfully.
) else (
    echo File not found: %SearchFileToDelete3%.
)
if exist "%SearchFileToDelete4%" (
    echo.
    echo Taking ownership of the file.
    takeown /F "%SearchFileToDelete4%" >nul 2>&1
    echo Adjusting permissions.
    icacls "%SearchFileToDelete4%" /grant administrators:F >nul 2>&1
    echo Removing taskhostw.exe.
    del "%SearchFileToDelete4%" /f /q
    echo File deleted successfully.
) else (
    echo File not found: %SearchFileToDelete4%.
)
timeout 1 > nul

cls
color 9
echo (Quaked) Installing Alternative Search/Open Shell Menu...
chcp 437 >nul
echo.
powershell -Command "Write-Host 'Needed if you''d like to Search things!' -ForegroundColor White -BackgroundColor Red" 
set "fileURL=https://github.com/Open-Shell/Open-Shell-Menu/releases/download/v4.4.191/OpenShellSetup_4_4_191.exe"
set "fileName=OpenShellSetup_4_4_191.exe"
set "fileURL2=https://github.com/QuakedK/Oneclick/raw/refs/heads/main/Downloads/OpenShellTheme.xml"
set "fileName2=OpenShellTheme.xml"
mkdir "C:\Oneclick Tools\Open Shell" >nul 2>&1
set "downloadsFolder=C:\Oneclick Tools\Open Shell"
chcp 65001 >nul 2>&1
echo.
echo ╔═════════════════════════════╗
echo ║                             ║
echo ║    Downloading resources    ║
echo ║                             ║
echo ╚═════════════════════════════╝
curl -s -L "%fileURL%" -o "%downloadsFolder%\%fileName%"
curl -s -L "%fileURL2%" -o "%downloadsFolder%\%fileName2%"
if exist "%downloadsFolder%\%fileName%" (
    echo Open Shell Menu and config file installed!
    echo.
    echo Starting Open Shell Menu...
    timeout 1 > nul
    cls
    start "" "%downloadsFolder%\%fileName%"
    chcp 437 >nul
    powershell -Command "Write-Host 'Do not skip if you want to Search things' -ForegroundColor White -BackgroundColor Red" 
    echo.
    echo Click "Next", Then "I accept", then "Next" again.
    echo Click on the "Arrow" next the left of "Classic Explorer" then click the "Red X"
    echo Click on the "Arrow" next the left of "Open-Shell Update" then click the "Red X"
    echo Then click "Next" again and "install" the "Finsh"
    echo.
    echo Now right click your "windows icon" then click "Settings"
    echo Then click "Backup" and "Load from XML File" 
    echo Now Navigate to your "C drive or C:\Oneclick Tools\Open Shell" and Select "OpenShellTheme.xml" the click "OK"
    pause
) else (
    echo Open Shell Menu download failed.
    echo Skipping!
    timeout 1 > nul
) 

:SkipSearchRemover
cls
color D
echo (Quaked) Disabling all startup apps...
echo --------------------------------------
for /f "tokens=2 delims==" %%I in ('wmic startup get caption /format:list') do (
    setlocal enabledelayedexpansion
    set "app=%%I"
    set "app=!app:~0,-1!"
    echo Disabling !app!
    
    :: Check if app exists in HKEY_CURRENT_USER
    reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "!app!" >nul 2>&1
    if !errorlevel! equ 0 (
        echo Disabling !app! in HKEY_CURRENT_USER >nul 2>&1
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "!app!" /t REG_BINARY /d 0300000000000000 /f >nul 2>&1
    ) else (
        echo !app! not found in HKEY_CURRENT_USER, skipping... >nul 2>&1
    )
    
    :: Check if app exists in HKEY_LOCAL_MACHINE
    reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "!app!" >nul 2>&1
    if !errorlevel! equ 0 (
        echo Disabling !app! in HKEY_LOCAL_MACHINE >nul 2>&1
        reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "!app!" /t REG_BINARY /d 0300000000000000 /f >nul 2>&1
    ) else (
        echo !app! not found in HKEY_LOCAL_MACHINE, skipping... >nul 2>&1
    )
    
    endlocal
)
echo All startup programs disabled.
timeout 1 > nul

cls
color 9
echo (Quaked) Auto setting Graphics Preferences, Priority and FSO.... 
setlocal enabledelayedexpansion

:: Finding Roblox and Discord path.
for /f "delims=" %%i in ('dir /b /s "%USERPROFILE%\AppData\Local\Roblox\Versions\RobloxPlayerBeta.exe" 2^>nul') do set "robloxPath=%%i"
for /f "delims=" %%i in ('dir /b /s "%USERPROFILE%\AppData\Local\Discord\Discord.exe" 2^>nul') do set "discordPath=%%i"

:: Games Paths.
set "games[0]=C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe"
set "games[1]=%robloxPath%"
set "games[2]=%USERPROFILE%\AppData\Local\osu!\osu!.exe"
set "games[3]=C:\Riot Games\VALORANT\live\VALORANT.exe"
set "games[4]=C:\Program Files\Epic Games\VALORANT\VALORANT.exe"
set "games[5]=C:\Program Files (x86)\Steam\steamapps\common\Grand Theft Auto V\GTA5.exe"
set "games[6]=C:\Program Files\Epic Games\GTAV\GTAV.exe"
set "games[7]=C:\Program Files\Rockstar Games\Grand Theft Auto V\GTA5.exe"
set "games[8]=C:\Program Files\Epic Games\Apex\Apex.exe"
set "games[9]=C:\Program Files (x86)\Steam\steamapps\common\Apex Legends\Apex Legends.exe"
set "games[10]=C:\Program Files (x86)\Origin Games\Apex\Apex.exe"
set "games[11]=C:\Program Files\EA Games\Apex Legends\Apex.exe"
set "games[12]=C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike 2\cs2.exe"
set "games[13]=C:\Program Files (x86)\Battle.net\Overwatch 2\Overwatch.exe"
set "games[14]=C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\games\Tom Clancy's Rainbow Six Siege\r6.exe"
set "games[15]=C:\Riot Games\League of Legends\LeagueClient.exe"
set "games[16]=C:\Program Files (x86)\Steam\steamapps\common\Dead by Daylight\DeadByDaylight.exe"
set "games[17]=C:\Program Files (x86)\Call of Duty\Modern Warfare\ModernWarfare.exe"
set "games[18]=C:\Program Files (x86)\Call of Duty\Modern Warfare II\ModernWarfareII.exe"
set "games[19]=C:\Program Files (x86)\Call of Duty\Modern Warfare III\ModernWarfareIII.exe"
set "games[20]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops\BlackOps.exe"
set "games[21]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops II\BlackOps2.exe"
set "games[22]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops III\BlackOps3.exe"
set "games[23]=C:\Program Files (x86)\Steam\steamapps\common\Elden Ring\EldenRing.exe"
set "games[24]=C:\Program Files\Epic Games\RocketLeague\RocketLeague.exe"
set "games[25]=C:\Program Files\Genshin Impact\Genshin Impact Game\GenshinImpact.exe"
set "games[26]=C:\Program Files\LatencyMon\LatMon.exe"
set "games[27]=C:\Program Files\Maxon\Cinebench R23\Cinebench.exe"
set "games[28]=C:\Program Files\Maxon\Cinebench R24\Cinebench.exe"
set "games[29]=C:\Program Files\Shotcut\shotcut.exe"
set "games[30]=C:\Program Files\3DMark\3DMark.exe"

:: Apps Paths. 
set "apps[0]=%discordPath%"
set "apps[1]=%USERPROFILE%\AppData\Roaming\Spotify\Spotify.exe"
set "apps[2]=C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe"
set "apps[3]=C:\Program Files\obs-studio\bin\64bit\obs64.exe"
set "apps[4]=C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win64\EpicGamesLauncher.exe"
set "apps[5]=C:\Program Files (x86)\Epic Games\Launcher\Engine\Binaries\Win64\EpicWebHelper.exe"
set "apps[6]=C:\Program Files (x86)\Epic Games\Launcher\Engine\Binaries\Win64\CrashReportClient.exe"
set "apps[7]=C:\Program Files (x86)\Steam\Steam.exe"
set "apps[8]=C:\Program Files (x86)\Steam\bin\cef\cef.win7x64\steamwebhelper.exe"
set "apps[9]=C:\Program Files (x86)\Battle.net\Battle.net.exe"
set "apps[10]=C:\Program Files\Core Temp\Core Temp.exe"
set "apps[11]=C:\Program Files (x86)\CapFrameX\CapFrameX.exe"
set "apps[12]=C:\Program Files\CPUID\HWMonitor\HWMonitor.exe"
set "apps[13]=C:\Program Files\VideoLAN\VLC\vlc.exe"
set "apps[14]=C:\Program Files\Google\Chrome\Application\chrome.exe"
set "apps[15]=C:\Program Files\Open-Shell\StartMenu.exe"
set "apps[16]=C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
set "apps[17]=%USERPROFILE%\AppData\Local\Programs\Opera GX\launcher.exe"
set "apps[18]=C:\Windows\System32\dwm.exe"
set "apps[19]=C:\Windows\explorer.exe"

:: Registry Keys
set regKeyGP=HKEY_CURRENT_USER\SOFTWARE\Microsoft\DirectX\UserGpuPreferences
set regKeyPR=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options
set regKeyFO=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers

:: Set Games to High Performance and Hgh Priority.
for /L %%i in (0, 1, 30) do (
    set "currentPath=!games[%%i]!"
    if exist "!currentPath!" (
        for %%a in (!currentPath!) do set "exeName=%%~nxa"
        echo Adding !exeName! to High Performance Mode, High Priority and FSO.
        reg add "%regKeyGP%" /v "!currentPath!" /t REG_SZ /d "GpuPreference=2" /f >nul 2>&1
        reg add "%regKeyPR%\!exeName!\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "3" /f >nul 2>&1
        reg add "%regKeyFO%" /v "!currentPath!" /t REG_SZ /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE HIGHDPIAWARE" /f >nul 2>&1
    ) else (
        echo !currentPath! does not exist >nul 2>&1
    )
)

:: Set Apps to Power Saving and Low Priority.
for /L %%i in (0, 1, 19) do (
    set "currentPath=!apps[%%i]!"
    if exist "!currentPath!" (
        for %%a in (!currentPath!) do set "exeName=%%~nxa"
        echo Adding !exeName! to Power Saving Mode and Low Priority.
        reg add "%regKeyGP%" /v "!currentPath!" /t REG_SZ /d "GpuPreference=1" /f >nul 2>&1
        reg add "%regKeyPR%\!exeName!\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1 
    ) else (
        echo !currentPath! does not exist >nul 2>&1
    )
)

endlocal
echo Graphics Preferences, Priority and FSO applied successfully.
timeout 1 > nul

cls
color D
echo (Quaked) Auto Setting Windows Processes Priority... 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ApplicationFrameHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dllhost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\fontdrvhost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d "1" /f  
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\services.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sihost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\StartMenu.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe" /v "MinimumStackCommitInBytes" /t REG_DWORD /d "32768" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f  
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f  
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wininit.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\winlogon.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WMIADAP.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WmiPrvSE.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f
echo Windows Processes Priority appiled successfully.
timeout 1 > nul 

:: (Quaked) Mircosoft Apps Remover.
cls
color 9
echo.                                          (Removing Microsoft Apps/Bloatware)
echo.                                       This cycles through over 100 lines of code
echo.                                             and will likely take a while.
echo. 
chcp 437 >nul
powershell -Command "Write-Host 'Reminder, will take a while' -ForegroundColor White -BackgroundColor Red"  
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Cortana* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Getstarted* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *WindowsCamera* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *bing* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *OneNote* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *WindowsPhone* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *photos* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *SkypeApp* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *solit* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *WindowsSoundRecorder* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *zune* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *WindowsCalculator* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *WindowsMaps* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Sway* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *CommsPhone* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *ConnectivityStore* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WindowsStore* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.BingSports* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.BingFinance* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.HEIFImageExtension* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.VP9VideoExtensions* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WebMediaExtensions* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WebpImageExtension* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Office.Sway* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WindowsStore* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.StorePurchaseApp* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.XboxGameOverlay* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WindowsPhone* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WindowsPhone* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WindowsPhone* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Windows.Phone* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.CommsPhone* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Appconnector* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.MinecraftUWP* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Wallet* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WindowsCalculator* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.GroupMe10* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *king.com.CandyCrushSaga* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *king.com.CandyCrushSodaSaga* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *ShazamEntertainmentLtd.Shazam* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Flipboard.Flipboard* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *9E2F88E3.Twitter* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *ClearChannelRadioDigital.iHeartRadio* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *D5EA27B7.Duolingo-LearnLanguagesforFree* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *AdobeSystemsIncorporated.AdobePhotoshopExpress* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *PandoraMediaInc.29680B314EFC2* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *46928bounde.EclipseManager* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *ActiproSoftwareLLC.562882FEEB491* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Advertising.Xaml* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.RemoteDesktop* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.NetworkSpeedTest* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Todos* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Windows.Search* | Remove-AppxPackage" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Windows.Cortana* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *windowsterminal* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.ScreenSketch* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.PowerAutomateDesktop* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.MSPaint* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.Office.Outlook* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.WindowsNotepad* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.OneDrive* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.ParentalControls* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Clipchamp* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *RealtekSemiconductorCorp.RealtekAudioControl* | Remove-AppxPackage" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.RemoteDesktop* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *Microsoft.RemoteDesktop_10.2.1810.0_x64__8wekyb3d8bbwe* | Remove-AppxPackage" >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *HPAudioControl* | Remove-AppxPackage" >nul 2>&1
taskkill /F /IM Teams.exe >nul 2>&1
taskkill /F /IM msteams.exe >nul 2>&1
taskkill /F /IM msteams_autostarter.exe >nul 2>&1
taskkill /F /IM msteamsupdate.exe >nul 2>&1
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *MicrosoftTeams* | Remove-AppxPackage"
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage *MicrosoftTeams_24102.2309.2851.4917_x64__8wekyb3d8bbwe* | Remove-AppxPackage"
echo Mircosoft Apps and Bloatware deleted successfully.
timeout 1 > nul

:: (Prolix, Quaked and Mathko) Gpu Tweaks
cls
color D
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.                                                ██████╗ ██████╗ ██╗   ██╗             
echo.                                               ██╔════╝ ██╔══██╗██║   ██║             
echo.                                               ██║  ███╗██████╔╝██║   ██║             
echo.                                               ██║   ██║██╔═══╝ ██║   ██║             
echo.                                               ╚██████╔╝██║     ╚██████╔╝             
echo.                                                ╚═════╝ ╚═╝      ╚═════╝              
echo.                                                   
echo.                                  ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗
echo.                                  ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝
echo.                                     ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗
echo.                                     ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║
echo.                                     ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║
echo.                                     ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
echo.
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║             Please select your GPU...              ║       
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo.
echo.
echo.
echo Choose an option:
echo 1. Nvidia  
echo 2. AMD 
echo 3. Intel
echo 4. Skip!
set /p option="Enter option number: "
echo.
if "%option%"=="1" (
echo Running Nvidia Tweaks.
timeout 2 > nul
goto :Nivida
) else if "%option%"=="2" (
echo Running AMD Tweaks.
timeout 2 > nul
goto :AMD
) else if "%option%"=="3" (
echo Running Intel Tweaks.
timeout 2 > nul
goto :Intel
) else if "%option%"=="4" (
echo Skipping!
goto :DoneSkipGpu 
timeout 1 > nul   
) 

:Nivida
cls
:: Nvidia Power Settings
echo Disabling Power Settings...
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{7B7A1E6E-0A7E-11EF-946A-806E6F6E6963}\0000" /v "PowerMizerEnable" /t REG_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{7B7A1E6E-0A7E-11EF-946A-806E6F6E6963}\0000" /v "PowerMizerLevel" /t REG_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{7B7A1E6E-0A7E-11EF-946A-806E6F6E6963}\0000" /v "PowerMizerLevelAC" /t REG_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{7B7A1E6E-0A7E-11EF-946A-806E6F6E6963}\0000" /v "PerfLevelSrc" /t REG_DWORD /d "8738" /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t Reg_DWORD /d "0" /f 
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}\0001\PowerSettings" /v IdlePowerState /t REG_BINARY /d 00000000 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Class{4d36e96c-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
timeout 1 > nul
        
        
cls
:: Nvidia Telemetry
echo Disabling Nvidia Telemetry...
REG ADD "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f 
REG ADD "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d 0 /f 
REG ADD "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d 0 /f 
REG ADD "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d 0 /f 
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d 0 /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "NvBackend" /f >nul 2>&1
timeout 1 > nul
        
cls
:: Nvidia Tasks
echo Disabling Nvidia Tasks...
echo The operation completed successfully.
echo The operation completed successfully.
echo The operation completed successfully.
echo The operation completed successfully.
echo The operation completed successfully.
echo The operation completed successfully.
schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1 
schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1 
schtasks /change /disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1  
schtasks /change /disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
schtasks /change /disable /tn "NvBatteryBoostCheckOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
schtasks /change /disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >nul 2>&1
timeout 1 > nul

cls
:: Mpo and HDCP Tweaks
echo Disabling HDCP and MPO...
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyGlobZero" /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f
timeout 1 > nul

cls
:: interrupt policies
echo Setting interrupt policies...
FOR /f %%g IN ('wmic path win32_VideoController get PNPDeviceID ^| findstr /L "VEN_"') do REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f 
FOR /f %%g IN ('wmic path win32_VideoController get PNPDeviceID ^| findstr /L "VEN_"') do REG DELETE "HKLM\System\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1
FOR /f %%i IN ('wmic path Win32_NetworkAdapter get PNPDeviceID ^| findstr /L "VEN_"') do REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f 
FOR /f %%i IN ('wmic path Win32_NetworkAdapter get PNPDeviceID ^| findstr /L "VEN_"') do REG DELETE "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1
FOR /f %%u IN ('wmic path Win32_USBController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%u\Device Parameters\Interrupt Management\Affinity Policy" /f /v DevicePolicy /t REG_DWORD /d 4 >nul 2>&1
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%u\Device Parameters\Interrupt Management\Affinity Policy" /f /v AssignmentSetOverride /t REG_BINARY /d C0 >nul 2>&1
)
FOR /f %%v IN ('wmic path Win32_VideoController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%v\Device Parameters\Interrupt Management\Affinity Policy" /f /v DevicePolicy /t REG_DWORD /d 4 >nul 2>&1
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%v\Device Parameters\Interrupt Management\Affinity Policy" /f /v AssignmentSetOverride /t REG_BINARY /d C0 >nul 2>&1
)
FOR /f %%n IN ('wmic path Win32_NetworkAdapter get PNPDeviceID^| findstr /l "PCI\VEN_"') do ( 
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%n\Device Parameters\Interrupt Management\Affinity Policy" /f /v DevicePolicy /t REG_DWORD /d 4 >nul 2>&1
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%n\Device Parameters\Interrupt Management\Affinity Policy" /f /v AssignmentSetOverride /t REG_BINARY /d 30 >nul 2>&1
)
timeout 1 > nul

cls               
:NvidiaTelemetryClient
echo Do you want to delete Nvidia Telemetry Client? (Y/N)
echo.
chcp 437 >nul
powershell -Command "Write-Host 'Breaks clipping with Nvidia Softwares.' -ForegroundColor White -BackgroundColor Red"
echo.
set /p option="Enter option number: "
if /i "%option%"=="Y" (
echo.
echo Deleting Nvidia Telemetry Client...
rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
timeout 1 > nul
) else if /i "%option%"=="N" (
echo.
echo Not Deleting Nvidia Telemetry Client...
echo I recommend OBS Replay Buffer over Nvidia Shadowplay!
timeout 3 > nul
) else (
cls
chcp 437 >nul
powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
timeout 2 > nul
goto :NvidiaTelemetryClient
)

cls
echo Running Nvidia Profile Inspector with imported optimized settings...
set "fileURL=https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.4.0.4/nvidiaProfileInspector.zip"
set "fileName=nvidiaProfileInspector.zip"
set "fileURL2=https://raw.githubusercontent.com/QuakedK/Oneclick/refs/heads/main/Downloads/QuakedOptimizedNVProflie.nip"
set "fileName2=Quaked Optimized NV Proflie.nip"
mkdir "C:\Oneclick Tools\Nvidia" >nul 2>&1
set "extractFolder=C:\Oneclick Tools\Nvidia\nvidiaProfileInspector"
set "downloadsFolder=C:\Oneclick Tools\Nvidia"
chcp 65001 >nul 2>&1
echo.
echo ╔═════════════════════════════╗
echo ║                             ║
echo ║    Downloading resources    ║
echo ║                             ║
echo ╚═════════════════════════════╝
if not exist "%downloadsFolder%\%fileName%" (
curl -s -L "%fileURL%" -o "%downloadsFolder%\%fileName%"
curl -s -L "%fileURL2%" -o "%downloadsFolder%\%fileName2%"
timeout 1 > nul
mkdir "%extractFolder%" >nul 2>&1
pushd "%extractFolder%" >nul 2>&1
chcp 437 >nul
powershell -Command "Expand-Archive -Path '%downloadsFolder%\%fileName%' -DestinationPath '%extractFolder%' -Force" >nul 2>&1
popd >nul 2>&1
del /q "C:\Oneclick Tools\Nvidia\nvidiaProfileInspector.zip" >nul 2>&1
echo Download successful!
echo Importing configuration file...
"%extractFolder%\nvidiaProfileInspector.exe" -importProfile "%downloadsFolder%\%fileName2%"
echo.
pause
goto :DoneSkipGpu 
) else (
    echo "%fileName%" already exists in "%downloadsFolder%". >nul 2>&1
)

:AMD
cls
echo Disabling Amd Bloat...
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "3D_Refresh_Rate_Override_DEF" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "3to2Pulldown_NA" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "AAF_NA" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "Adaptive De-interlacing" /t Reg_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "AllowRSOverlay" /t Reg_SZ /d "false" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "AllowSkins" /t Reg_SZ /d "false" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "AllowSnapshot" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "AllowSubscription" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "AntiAlias_NA" /t Reg_SZ /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "AreaAniso_NA" /t Reg_SZ /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "ASTT_NA" /t Reg_SZ /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "AutoColorDepthReduction_NA" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "DisableSAMUPowerGating" /t Reg_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "DisableUVDPowerGatingDynamic" /t Reg_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "DisableVCEPowerGating" /t Reg_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "EnableAspmL0s" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "EnableAspmL1" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "EnableUlps" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "EnableUlps_NA" /t Reg_SZ /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "KMD_DeLagEnabled" /t Reg_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "KMD_FRTEnabled" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "DisableDMACopy" /t Reg_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "DisableBlockWrite" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "StutterMode" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "EnableUlps" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "PP_SclkDeepSleepDisable" /t Reg_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "PP_ThermalAutoThrottlingEnable" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "DisableDrmdmaPowerGating" /t Reg_DWORD /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000" /v "KMD_EnableComputePreemption" /t Reg_DWORD /d "0" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000\UMD" /t Reg_SZ /d "1" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000\UMD" /v "Main3D" /t Reg_BINARY /d "3100" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000\UMD" /v "FlipQueueSize" /t Reg_BINARY /d "3100" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000\UMD" /v "ShaderCache" /t Reg_BINARY /d "3200" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000\UMD" /v "Tessellation_OPTION" /t Reg_BINARY /d "3200" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000\UMD" /v "Tessellation" /t Reg_BINARY /d "3100" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000\UMD" /v "VSyncControl" /t Reg_BINARY /d "3000" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000\UMD" /v "TFQ" /t Reg_BINARY /d "3200" /f 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{B784559B-672D-11EE-A4CA-E612636C81AA}\0000\DAL2_DATA__2_0\DisplayPath_4\EDID_D109_78E9\Option" /v "ProtectionControl" /t REG_BINARY /d "0100000001000000" /f 
timeout 1 > nul 
 
cls
:: interrupt policies
echo Setting interrupt policies...
FOR /f %%g IN ('wmic path win32_VideoController get PNPDeviceID ^| findstr /L "VEN_"') do REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f 
FOR /f %%g IN ('wmic path win32_VideoController get PNPDeviceID ^| findstr /L "VEN_"') do REG DELETE "HKLM\System\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1
FOR /f %%i IN ('wmic path Win32_NetworkAdapter get PNPDeviceID ^| findstr /L "VEN_"') do REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f 
FOR /f %%i IN ('wmic path Win32_NetworkAdapter get PNPDeviceID ^| findstr /L "VEN_"') do REG DELETE "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1
FOR /f %%u IN ('wmic path Win32_USBController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%u\Device Parameters\Interrupt Management\Affinity Policy" /f /v DevicePolicy /t REG_DWORD /d 4 >nul 2>&1
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%u\Device Parameters\Interrupt Management\Affinity Policy" /f /v AssignmentSetOverride /t REG_BINARY /d C0 >nul 2>&1
)
FOR /f %%v IN ('wmic path Win32_VideoController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%v\Device Parameters\Interrupt Management\Affinity Policy" /f /v DevicePolicy /t REG_DWORD /d 4 >nul 2>&1
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%v\Device Parameters\Interrupt Management\Affinity Policy" /f /v AssignmentSetOverride /t REG_BINARY /d C0 >nul 2>&1
)
FOR /f %%n IN ('wmic path Win32_NetworkAdapter get PNPDeviceID^| findstr /l "PCI\VEN_"') do ( 
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%n\Device Parameters\Interrupt Management\Affinity Policy" /f /v DevicePolicy /t REG_DWORD /d 4 >nul 2>&1
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%n\Device Parameters\Interrupt Management\Affinity Policy" /f /v AssignmentSetOverride /t REG_BINARY /d 30 >nul 2>&1
)
goto :DoneSkipGpu

:Intel
cls
echo Disabling Intel Gpu Bloat...
REG ADD "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d "1" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IncreaseFixedSegment" /t REG_DWORD /d "1" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AdaptiveVsyncEnable" /t REG_DWORD /d "0" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisablePFonDP" /t REG_DWORD /d "1" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableCompensationForDVI" /t REG_DWORD /d "1" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NoFastLinkTrainingForeDP" /t REG_DWORD /d "0" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ACPowerPolicyVersion" /t REG_DWORD /d "16898" /f
REG ADD "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DCPowerPolicyVersion" /t REG_DWORD /d "16642" /f
REG ADD "HKLM\Software\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d "512" /f
timeout 1 > nul

cls
:: interrupt policies
echo Setting interrupt policies...
FOR /f %%g IN ('wmic path win32_VideoController get PNPDeviceID ^| findstr /L "VEN_"') do REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f 
FOR /f %%g IN ('wmic path win32_VideoController get PNPDeviceID ^| findstr /L "VEN_"') do REG DELETE "HKLM\System\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1
FOR /f %%i IN ('wmic path Win32_NetworkAdapter get PNPDeviceID ^| findstr /L "VEN_"') do REG ADD "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f 
FOR /f %%i IN ('wmic path Win32_NetworkAdapter get PNPDeviceID ^| findstr /L "VEN_"') do REG DELETE "HKLM\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f >nul 2>&1
FOR /f %%u IN ('wmic path Win32_USBController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%u\Device Parameters\Interrupt Management\Affinity Policy" /f /v DevicePolicy /t REG_DWORD /d 4 >nul 2>&1
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%u\Device Parameters\Interrupt Management\Affinity Policy" /f /v AssignmentSetOverride /t REG_BINARY /d C0 >nul 2>&1
)
FOR /f %%v IN ('wmic path Win32_VideoController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%v\Device Parameters\Interrupt Management\Affinity Policy" /f /v DevicePolicy /t REG_DWORD /d 4 >nul 2>&1
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%v\Device Parameters\Interrupt Management\Affinity Policy" /f /v AssignmentSetOverride /t REG_BINARY /d C0 >nul 2>&1
)
FOR /f %%n IN ('wmic path Win32_NetworkAdapter get PNPDeviceID^| findstr /l "PCI\VEN_"') do ( 
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%n\Device Parameters\Interrupt Management\Affinity Policy" /f /v DevicePolicy /t REG_DWORD /d 4 >nul 2>&1
    REG ADD "HKLM\System\CurrentControlSet\Enum\%%n\Device Parameters\Interrupt Management\Affinity Policy" /f /v AssignmentSetOverride /t REG_BINARY /d 30 >nul 2>&1
)
goto :DoneSkipGpu

:: (Quaked) Latency Tweaks.
:DoneSkipGpu
cls
color 9
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                 ██╗      █████╗ ████████╗███████╗███╗   ██╗ ██████╗██╗   ██╗       
echo.                                 ██║     ██╔══██╗╚══██╔══╝██╔════╝████╗  ██║██╔════╝╚██╗ ██╔╝       
echo.                                 ██║     ███████║   ██║   █████╗  ██╔██╗ ██║██║      ╚████╔╝        
echo.                                 ██║     ██╔══██║   ██║   ██╔══╝  ██║╚██╗██║██║       ╚██╔╝         
echo.                                 ███████╗██║  ██║   ██║   ███████╗██║ ╚████║╚██████╗   ██║          
echo.                                 ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝ ╚═════╝   ╚═╝          
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║              Running latency Tweaks...             ║       
echo.                                  ╚════════════════════════════════════════════════════╝
echo.                                                                          
timeout 1 > nul  

cls
color D
chcp 437 >nul
echo (Quaked) Applying System Clock Settings...
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /set useplatformtick no
bcdedit /set disabledynamictick yes
echo System Clock Settings appiled successfully.
timeout 1 > nul

:SettingPrioritySeparation
cls
color 9
echo (Quaked) Setting Priority Separation... 
echo.
chcp 65001 >nul 2>&1
echo ╔═════════════════════════════╗
echo ║       42 Recommended!       ║
echo ╚═════════════════════════════╝
echo.
echo Choose an option:
echo 1. 20 Decimal ║ 14 Hexadecimal
echo 2. 22 Decimal ║ 16 Hexadecimal
echo 3. 24 Decimal ║ 18 Hexadecimal
echo 4. 26 Decimal ║ 1A Hexadecimal
echo 5. 36 Decimal ║ 24 Hexadecimal
echo 6. 38 Decimal ║ 26 Hexadecimal
echo 7. 42 Decimal ║ 2A Hexadecimal
echo 8. Skip!
chcp 437 >nul
set /p option="Enter option number: "
echo.
if "%option%"=="1" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x00000014 /f
echo 20 Decimal aka 14 Hexadecimal, Priority Separation appiled successfully.
timeout 1 > nul
) else if "%option%"=="2" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x00000016 /f
echo 22 Decimal aka 16 Hexadecimal, Priority Separation appiled successfully.
timeout 1 > nul
) else if "%option%"=="3" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x00000018 /f
echo 24 Decimal aka 18 Hexadecimal, Priority Separation appiled successfully.
timeout 1 > nul
) else if "%option%"=="4" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x1a /f
echo 26 Decimal aka 1A Hexadecimal, Priority Separation appiled successfully.
timeout 1 > nul
) else if "%option%"=="5" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x00000024 /f
echo 36 Decimal aka 24 Hexadecimal, Priority Separation appiled successfully.
timeout 1 > nul
) else if "%option%"=="6" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x00000026 /f
echo 38 Decimal aka 26 Hexadecimal, Priority Separation appiled successfully.
timeout 1 > nul
) else if "%option%"=="7" (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 0x2a /f
echo 42 Decimal aka 2A Hexadecimal, Priority Separation appiled successfully.
timeout 1 > nul 
) else if "%option%"=="8" (
echo Skipping Priority Separation Selection!
timeout 1 > nul  
goto :SkippingPriority 
) else (
cls
chcp 437 >nul
powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
timeout 1 > nul
goto :SettingPrioritySeparation
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
    timeout 1 > nul
    goto :WinVerD
) else (
    echo Visual C++ 2015-2022 Redistributable is not installed
    timeout 1 > nul
    goto :VCRuntime
)
pause

:VCRuntime
:: Download VC++ Redistributable
set "fileURL=https://aka.ms/vs/17/release/vc_redist.x64.exe"
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
    timeout 1 > nul
    goto :VCRuntime
)
 
:WinVerD
:: (Quaked) Check for Windows 10 versions 2004 and above, excluding Windows 11.
setlocal enabledelayedexpansion

:: Get the current Windows version and build number.
for /f "tokens=3" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuild" 2^>nul ^| findstr "REG_SZ"') do (
    set "build_num=%%A"
)

:: Check if Windows 11 is detected using the build number.
:: Windows 11 starts at build number 22000 and above
if !build_num! GEQ 22000 (
    goto :TimerRes11
)

:: If Windows 10 version is above 2004 or 20H2 using the build number.
if !build_num! GEQ 19042 (
    echo Windows 10 version above 2004 detected. >nul 2>&1
    goto :TimerRes10
) else (
    echo Windows 10 version 2004 or earlier detected. >nul 2>&1
    goto :TimerRes11
)

endlocal

:TimerRes10
cls
color 9
echo (Quaked) Setting up Timer Resolution...  
echo.
chcp 65001 >nul 2>&1
echo ╔═════════════════════════════╗
echo ║     0.504ms Recommended!     ║
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
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe --resolution 5000 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5000 --no-console
  echo Timer Res is now active in the background!
  echo. 
  echo Adding Win 10 TimerRes Fix/Dpc Checker to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DPC Checker" /t REG_SZ /d "C:\Oneclick Tools\DPC Checker\dpclat.exe" /f
  echo.
  echo Starting Dpc Checker... 
  powershell -Command "Write-Host 'Click *Stop* and then *Minimize* everytime you restart your pc.' -ForegroundColor White -BackgroundColor Red"
  start "" "C:\Oneclick Tools\DPC Checker\dpclat.exe"
  echo DPC Checker is now active in the background!
  echo.
  pause
  goto :SkippingTimer
) else if "%option%"=="2" (
  echo.
  echo Adding TimerResolution to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe --resolution 5020 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5020 --no-console
  echo Timer Res is now active in the background!
  echo. 
  echo Adding Win 10 TimerRes Fix/Dpc Checker to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DPC Checker" /t REG_SZ /d "C:\Oneclick Tools\DPC Checker\dpclat.exe" /f
  echo.
  echo Starting Dpc Checker... 
  powershell -Command "Write-Host 'Click *Stop* and then *Minimize* everytime you restart your pc.' -ForegroundColor White -BackgroundColor Red"
  start "" "C:\Oneclick Tools\DPC Checker\dpclat.exe"
  echo DPC Checker is now active in the background!
  echo.
  pause
  goto :SkippingTimer
) else if "%option%"=="3" (
  echo.
  echo Adding TimerResolution to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe --resolution 5040 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5040 --no-console
  echo Timer Res is now active in the background!
  echo. 
  echo Adding Win 10 TimerRes Fix/Dpc Checker to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DPC Checker" /t REG_SZ /d "C:\Oneclick Tools\DPC Checker\dpclat.exe" /f
  echo.
  echo Starting Dpc Checker... 
  powershell -Command "Write-Host 'Click *Stop* and then *Minimize* everytime you restart your pc.' -ForegroundColor White -BackgroundColor Red"
  start "" "C:\Oneclick Tools\DPC Checker\dpclat.exe"
  echo DPC Checker is now active in the background!
  echo.
  pause
  goto :SkippingTimer
) else if "%option%"=="4" (
  echo.
  echo Adding TimerResolution to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe --resolution 5070 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5070 --no-console
  echo Timer Res is now active in the background!
  echo. 
  echo Adding Win 10 TimerRes Fix/Dpc Checker to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DPC Checker" /t REG_SZ /d "C:\Oneclick Tools\DPC Checker\dpclat.exe" /f
  echo.
  echo Starting Dpc Checker... 
  powershell -Command "Write-Host 'Click *Stop* and then *Minimize* everytime you restart your pc.' -ForegroundColor White -BackgroundColor Red"
  start "" "C:\Oneclick Tools\DPC Checker\dpclat.exe"
  echo DPC Checker is now active in the background!
  echo.
  pause
  goto :SkippingTimer
) else if "%option%"=="5" (
  echo.
  echo Skipping Timer Resolution Selection!
  timeout 1 > nul 
  goto :SkippingTimer
) else (
cls
chcp 437 >nul
powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
timeout 1 > nul
goto :TimerRes10
)

:TimerRes11
rd /s /q "C:\Oneclick Tools\DPC Checker" >nul 2>&1
cls
color 9
echo (Quaked) Setting up Timer Resolution... 
echo.
chcp 65001 >nul 2>&1
echo ╔═════════════════════════════╗
echo ║     0.504ms Recommended!     ║
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
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe --resolution 5000 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5000 --no-console
  echo Timer Res is now active in the background!
  timeout 1 > nul
) else if "%option%"=="2" (
  echo.
  echo Adding TimerResolution to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe --resolution 5020 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5020 --no-console
  echo Timer Res is now active in the background!
  timeout 1 > nul 
) else if "%option%"=="3" (
  echo.
  echo Adding TimerResolution to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe --resolution 5040 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5040 --no-console
  echo Timer Res is now active in the background!
  timeout 1 > nul 
) else if "%option%"=="4" (
  echo.
  echo Adding TimerResolution to startup!
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe --resolution 5070 --no-console" /f
  echo.
  echo Starting TimerResolution... 
  start "" "C:\Oneclick Tools\Timer Resolution\SetTimerResolution.exe" --resolution 5070 --no-console
  echo Timer Res is now active in the background!
  timeout 1 > nul 
) else if "%option%"=="5" (
  echo.
  echo Skipping Timer Resolution Selection!
  timeout 1 > nul 
  goto :SkippingTimer
) else (
cls
chcp 437 >nul
powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
timeout 1 > nul
goto :TimerRes11
)

:SkippingTimer
cls
color D
echo Do you want to Run (Khorive, Inspired) NDIS Tweaks?
echo.
chcp 437 >nul
powershell -Command "Write-Host '(Not Recommended) Can Network issues, but improve latency on the NDIS driver.' -ForegroundColor White -BackgroundColor Red"
echo.
set /p choice=Enter (Y/N): 
if /i "%choice%"=="Y" (
    timeout 1 > nul
    cls
    goto :NDIS
) else if /i "%choice%"=="N" ( 
    timeout 1 > nul
    cls
    goto :DMT
) else (
    cls
    chcp 437 >nul
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 1 > nul
    goto :SkippingTimer
)

:NDIS
cls
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
    timeout 1 > nul
    goto :DMT
)

:DeviceManagerTweaks
echo (Quaked) Disabling unnecessary devices in Device Manager...
setlocal enabledelayedexpansion

:: Device Names.
set "Device[0]=Microsoft GS Wavetable Synth"
set "Device[1]=NDIS Virtual Network Adapter Enumerator"
set "Device[2]=Composite Bus Enumerator"
set "Device[3]=Microsoft Virtual Drive Enumerator"
set "Device[4]=Remote Desktop Device Redirector Bus"
set "Device[5]=Mircosoft RRAS Root Enumerator"
set "Device[6]=Mircosoft Print to PDF"
set "Device[7]=Root Print Queue"
set "Device[8]=Intel(R) Management Engine Interface #1"
set "Device[9]=Intel(R) SPI (Flash) Controller - 7AA4"
set "Device[10]=Intel(R) SMBus - 7AA3"
set "Device[11]=UMBus Root Bus Enumerator"
set "Device[12]=Microsoft Hypervisor Service"
set "Device[13]=Microsoft Device Association Root Enumerator"
set "Device[14]=Microsoft Hyper-V Vitualization Infrastucture Driver"
set "Device[15]=Bluetooth Device (RFCOMM Protocol TDI)"
set "Device[16]=Intel(R) Wireless Bluetooth(R)"
set "Device[17]=Microsoft Bluetooth Enumerator"
set "Device[18]=Microsoft Bluetooth LE Enumerator"
set "Device[19]=Bluetooth Device (Personal Area Network)"
set "Device[20]=NVIDIA High Definition Audio"

:: Loop through all devices and disable them by InstanceId
for /L %%i in (0,1,20) do (
    for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '!Device[%%i]!' | Select-Object -ExpandProperty InstanceId"`) do (
        set "instanceID=%%A"
    )
    if defined instanceID (
        echo Disabling device: !Device[%%i]! with InstanceId: !instanceID!
        pnputil /disable-device "!instanceID!" >nul 2>&1
    )
)
endlocal
timeout 1 > nul

:DisableWifiDevices
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
    echo Now Disabling Wifi Devices...
    timeout 1 > nul
    cls
    goto :WifiDevice
) else if /i "%option%"=="N" (
    echo.
    echo Skipping Wifi Device Manager Tweaks...
    timeout 1 > nul
    cls
    goto :SkipDeviceManager
) else (
    cls
    chcp 437 >nul
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 1 > nul
    goto :DisableWifiDevices
)

:WifiDevice
echo (Quaked) Disabling Wifi Devices!
setlocal enabledelayedexpansion

:: Device Names.
set "Device[0]=Intel(R) Wi-Fi"
set "Device[1]=WAN Miniport (IKEv2)"
set "Device[2]=WAN Miniport (IP)"
set "Device[3]=WAN Miniport (IPv6)"
set "Device[4]=WAN Miniport (L2TP)"
set "Device[5]=WAN Miniport (Network Monitor)"
set "Device[6]=WAN Miniport (PPPOE)"
set "Device[7]=WAN Miniport (PPTP)"
set "Device[8]=WAN Miniport (SSTP)"

:: Loop through all devices and disable them by InstanceId
for /L %%i in (0,1,8) do (
    for /f "usebackq tokens=*" %%A in (`powershell -command "Get-PnpDevice -FriendlyName '!Device[%%i]!' | Select-Object -ExpandProperty InstanceId"`) do (
        set "instanceID=%%A"
    )
    if defined instanceID (
        echo Disabling device: !Device[%%i]! with InstanceId: !instanceID!
        pnputil /disable-device "!instanceID!" >nul 2>&1
    )
)
endlocal
timeout 1 > nul

:SkipDeviceManager
cls
color 9
echo (Quaked) Importing Power Plan!
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
  powercfg -import "C:\Oneclick Tools\Power Plan\Quaked Ultimate Performance.pow"
  timeout 1 > nul
  goto :Activatecpl
) else if "%option%"=="2" (
  echo. 
  powercfg -import "C:\Oneclick Tools\Power Plan\Quaked Ultimate Performance Idle Off.pow"
  timeout 1 > nul
  goto :Activatecpl
) else if "%option%"=="3" (
  echo.
  echo Skipping Power Plan Selection!
  timeout 1 > nul 
  goto :EndPower
) else (
  cls
  chcp 437 >nul
  powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
  timeout 1 > nul
  goto :SkipDeviceManager
) 

:Activatecpl
setlocal enabledelayedexpansion

:: Checking if Quaked Ultimate Performance power plan exists.
for /f "tokens=2 delims=:(" %%i in ('powercfg /list ^| findstr /C:"Quaked Ultimate Performance"') do (
    set plan_guid=%%i
)

:: Checking if Quaked Ultimate Performance Idle Off power plan exists.
for /f "tokens=2 delims=:(" %%i in ('powercfg /list ^| findstr /C:"Quaked Ultimate Performance Idle Off"') do (
    set idle_off_guid=%%i
)

:: Activating the existing power plan.
if defined plan_guid (
    powercfg /setactive %plan_guid% >nul 2>&1
    powercfg /setactive %idle_off_guid% >nul 2>&1
    echo. 
    echo Activated Quaked Power Plan.
    timeout 1 > nul
    goto:CheckPower     
)
endlocal

:CheckPower
cls
chcp 437 >nul
powershell -Command "Write-Host 'Opening power plan options to confirm if it imported correctly.' -ForegroundColor White -BackgroundColor Red"
powercfg.cpl
echo.
echo Did the Power Plan import correctly? (Y/N)
set /p option="Enter option number: "
if /i "%option%"=="Y" (
    taskkill /F /FI "WINDOWTITLE eq Power Options" >nul 2>&1
    goto :EndPower
) else if /i "%option%"=="N" (
    echo.
    echo Please select High Performance!
    echo.
    chcp 437 >nul
    powershell -Command "Write-Host 'Adding power plan fix, could solve the issue.' -ForegroundColor White -BackgroundColor Green"
    powershell -Command "Write-Host 'Once Oneclick is done, open power plan options and check if it''s there.' -ForegroundColor White -BackgroundColor Green"
    echo.
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v PlatformAoAcOverride /t REG_DWORD /d 0 /f
    pause
    taskkill /F /FI "WINDOWTITLE eq Power Options" >nul 2>&1
    goto :EndPower
) else (
    cls
    chcp 437 >nul
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 1 > nul
    goto :CheckPower
)

:: (Quaked) Cleanup and Defrag.
:EndPower
cls
color D
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.                                 ██████╗ ██╗     ███████╗ █████╗ ███╗   ██╗██╗   ██╗██████╗ 
echo.                                 ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║██║   ██║██╔══██╗
echo.                                 ██║     ██║     █████╗  ███████║██╔██╗ ██║██║   ██║██████╔╝
echo.                                 ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║██║   ██║██╔═══╝ 
echo.                                 ╚██████╗███████╗███████╗██║  ██║██║ ╚████║╚██████╔╝██║     
echo.                                  ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝     
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║ Running File Cleanup, Network Cleanup and Defrag.. ║       
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo.
echo.                                                                          
timeout 1 > nul  

cls
chcp 437 >nul
color 9
echo (Quaked) Running File Cleanup...
del "%LocalAppData%\Microsoft\Windows\INetCache\." /s /f /q
del "%temp%" /s /f /q
del "%AppData%\Discord\Cache\." /s /f /q
del "%AppData%\Discord\Code Cache\." /s /f /q
del "%ProgramData%\USOPrivate\UpdateStore" /s /f /q
del "%ProgramData%\USOShared\Logs" /s /f /q
del "C:\Windows\System32\SleepStudy" /s /f /q
rmdir /S /Q "%LocalAppData%\Microsoft\Windows\WebCache"
rd "%AppData%\Discord\Cache" /s /q
rd "%AppData%\Discord\Code Cache" /s /q
del "%WINDIR%\Logs" /s /f /q
rd /s /q %LocalAppData%\Temp
Del /S /F /Q %temp%
Del /S /F /Q %Windir%\Temp
Del /S /F /Q C:\WINDOWS\Prefetch
echo File Cleanup completed successfully ...
timeout 1 > nul

cls
color D
echo (Quaked) Running Network Cleanup...
ipconfig /release
ipconfig /renew
arp -d *
nbtstat -R
nbtstat -RR
ipconfig /flushdns
ipconfig /registerdns >nul 2>&1
echo Network Cleanup completed successfully ...
timeout 1 > nul

:: (Quaked) Defrag.
:Defrag
cls
chcp 65001 >nul 2>&1
color 9
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo. 
echo. 
echo.                          ╔══════════════════════════════════════════════════════════════════════╗
echo.                          ║                         (Defragging Drive)                           ║
echo.                          ║In layman's terms It basically cleans and may speed up your hard drive║
echo.                          ║ But It could take 10-20 mins, if this is your first time defragging. ║
echo.                          ║       Please only defrag if you have a Hard drive not an SDD         ║
echo.                          ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo.
echo.
echo.
echo. 
echo. 
chcp 437 >nul
powershell -Command "Write-Host '(Not Recommended) Could take a while.' -ForegroundColor White -BackgroundColor Red"
echo Do you want to defrag drives?
set /p choice=Enter (Y/N): 
if /i "%choice%"=="Y" (
    echo.
    echo Running Drive Defragmentation...
    Defrag C: /o
    Defrag C: /d
    echo Drive defragmentation completed successfully.
    timeout 1 > nul
) else if /i "%choice%"=="N" (
    echo.
    echo Skipping Drive defragmentation.
    timeout 1 > nul
) else (
    cls
    chcp 437 >nul
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 1 > nul
    goto :Defrag
)

:Extra
cls
color B
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                     ███████╗██╗  ██╗████████╗██████╗  █████╗ ███████╗
echo.                                     ██╔════╝╚██╗██╔╝╚══██╔══╝██╔══██╗██╔══██╗██╔════╝
echo.                                     █████╗   ╚███╔╝    ██║   ██████╔╝███████║███████╗
echo.                                     ██╔══╝   ██╔██╗    ██║   ██╔══██╗██╔══██║╚════██║
echo.                                     ███████╗██╔╝ ██╗   ██║   ██║  ██║██║  ██║███████║
echo.                                     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
echo.
echo.                         ╔═════════════════════════════════════════════════════════════════════╗ 
echo.                         ║                                                                     ║ 
echo.                         ║           [1] Process Destroyer       [2] Wifi Fixer                ║
echo.                         ║                                                                     ║
echo.                         ║           [3] App Installer           [4] Network Tweaks            ║
echo.                         ║                                                                     ║
echo.                         ║           [5] Fortnite Tweaks         [6] Discord Server            ║
echo.                         ║                                                                     ║
echo.                         ║           [7] Free Windows Key        [8] Restart                   ║
echo.                         ║                                                                     ║
echo.                         ╚═════════════════════════════════════════════════════════════════════╝
echo.  
echo.  
echo.
echo ____________________
set /p option="Enter option number: "
if "%option%"=="1" (
    cls
    Call :PD
) else if "%option%"=="2" (
    cls
    Call :WifiFixer
) else if "%option%"=="3" (
    cls
    Call :AppIN
) else if "%option%"=="4" (
    cls
    Call :NT
) else if "%option%"=="5" (
    cls
    Call :Fort
) else if "%option%"=="6" (
    cls
    Call :Dis
) else if "%option%"=="7" (
    cls
    Call :FWK
) else if "%option%"=="8" (
    cls
    Call :RS
) else (
    cls
    chcp 437 >nul
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    goto :Extra
)

:PD
cls
chcp 65001 >nul 2>&1
color 9
echo.
echo.
echo.
echo. 
echo.                                ██████╗ ██████╗  ██████╗  ██████╗███████╗███████╗███████╗                  
echo.                                ██╔══██╗██╔══██╗██╔═══██╗██╔════╝██╔════╝██╔════╝██╔════╝                  
echo.                                ██████╔╝██████╔╝██║   ██║██║     █████╗  ███████╗███████╗                  
echo.                                ██╔═══╝ ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║╚════██║                  
echo.                                ██║     ██║  ██║╚██████╔╝╚██████╗███████╗███████║███████║                  
echo.                                ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚══════╝╚══════╝╚══════╝                  
echo.                                                                           
echo.                        ██████╗ ███████╗███████╗████████╗██████╗  ██████╗ ██╗   ██╗███████╗██████╗ 
echo.                        ██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔══██╗██╔═══██╗╚██╗ ██╔╝██╔════╝██╔══██╗
echo.                        ██║  ██║█████╗  ███████╗   ██║   ██████╔╝██║   ██║ ╚████╔╝ █████╗  ██████╔╝
echo.                        ██║  ██║██╔══╝  ╚════██║   ██║   ██╔══██╗██║   ██║  ╚██╔╝  ██╔══╝  ██╔══██╗
echo.                        ██████╔╝███████╗███████║   ██║   ██║  ██║╚██████╔╝   ██║   ███████╗██║  ██║
echo.                        ╚═════╝ ╚══════╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝
echo. 
echo.                        ╔══════════════════════════════════════════════════════════════════════╗
echo.                        ║   Process Destroyer, an advanced Service Disabler using NSudo with   ║
echo.                        ║        the highest possible privileges to achieve it's goal!          ║
echo.                        ╚══════════════════════════════════════════════════════════════════════╝       
echo.
echo _____________________________________
echo Do you want to run Process Destroyer?
echo.
chcp 437 >nul
powershell -Command "Write-Host 'Please Read The Requirements.' -ForegroundColor White -BackgroundColor Red"
powershell -Command "Write-Host 'It''s heavily recommended you install all you''re necessary Apps, Programs, Gpu Drivers and Dcontrol first.' -ForegroundColor White -BackgroundColor Red"
powershell -Command "Write-Host 'Process Destroyer is required to be ran on a system that installed windows with an offline/Local account.' -ForegroundColor White -BackgroundColor Red"
powershell -Command "Write-Host 'Other wise you''ll get a blank screen when logging in.' -ForegroundColor White -BackgroundColor Red"
start "" "https://github.com/QuakedK/Process-Destroyer/blob/main/Requirements.md" >nul 2>&1
echo.
set /p choice=Enter (Y/N): 
if /i "%choice%"=="Y" (
    set "fileURL=https://github.com/QuakedK/Process-Destroyer/releases/download/tweak/Oneclick-Process-Destroyer-2.1.bat"
    set "fileName=Process Destroyer 2.1.bat"
    mkdir "C:\Oneclick Tools\Process Destroyer" >nul 2>&1
) else if /i "%choice%"=="N" (
    cls
    powershell -Command "Write-Host 'Skipping Process Destroyer!' -ForegroundColor White -BackgroundColor Green" 
    timeout 2 > nul
    goto :Extra
) else (
    cls
    chcp 437 >nul
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    goto :PD
)

set "downloadsFolder=C:\Oneclick Tools\Process Destroyer"
chcp 65001 >nul 2>&1
echo.
echo ╔═════════════════════════════╗
echo ║                             ║
echo ║    Downloading resources    ║
echo ║                             ║
echo ╚═════════════════════════════╝
curl -s -L "%fileURL%" -o "%downloadsFolder%\%fileName%"
if exist "%downloadsFolder%\%fileName%" (
    cls
    echo Process Destroyer downloaded successfully!
    echo.
    echo Automatically Excuting Process Destroyer With NSudo...
    "C:\Oneclick Tools\NSudo\NSudoLG.exe" -ShowWindowMode:Show -U:T -P:E "C:\Oneclick Tools\Process Destroyer\Process Destroyer 2.1.bat"
    echo Continuing in 3 seconds...
    timeout 3 > nul
    goto :Extra
) else (
    echo Process Destroyer download failed.
    echo Skipping!
    timeout 2 > nul
    goto :Extra  
)

:WifiFixer
cls
chcp 437 >nul
powershell -Command "Write-Host 'Requires a Restart!' -ForegroundColor White -BackgroundColor Red"
echo.
timeout 2 > nul
echo Turning on Wifi!
sc config LanmanWorkstation start= demand
sc config WdiServiceHost start= demand
sc config NcbService start= demand
sc config ndu start= demand
sc config Netman start= demand
sc config netprofm start= demand
sc config WwanSvc start= demand
sc config Dhcp start= auto
sc config DPS start= auto
sc config lmhosts start= auto
sc config NlaSvc start= auto
sc config nsi start= auto
sc config RmSvc start= auto
sc config Wcmsvc start= auto
sc config Winmgmt start= auto
sc config WlanSvc start= auto
schtasks /Change /TN "Microsoft\Windows\WlanSvc\CDSSync" /Enable
schtasks /Change /TN "Microsoft\Windows\WCM\WiFiTask" /Enable
schtasks /Change /TN "Microsoft\Windows\NlaSvc\WiFiTask" /Enable
schtasks /Change /TN "Microsoft\Windows\DUSM\dusmtask" /Enable
reg add "HKLM\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "NoActiveProbe" /t REG_DWORD /d "0" /f
reg add "HKLM\System\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "1" /f
reg add "HKLM\System\CurrentControlSet\Services\BFE" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\System\CurrentControlSet\Services\Dnscache" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\System\CurrentControlSet\Services\WinHttpAutoProxySvc" /v "Start" /t REG_DWORD /d "3" /f
net start DPS
net start nsi
net start NlaSvc
net start Dhcp
net start Wcmsvc
net start RmSvc
wmic path win32_networkadapter where index=0 call disable
wmic path win32_networkadapter where index=1 call disable
wmic path win32_networkadapter where index=2 call disable
wmic path win32_networkadapter where index=3 call disable
wmic path win32_networkadapter where index=4 call disable
wmic path win32_networkadapter where index=5 call disable
wmic path win32_networkadapter where index=0 call enable
wmic path win32_networkadapter where index=1 call enable
wmic path win32_networkadapter where index=2 call enable
wmic path win32_networkadapter where index=3 call enable
wmic path win32_networkadapter where index=4 call enable
wmic path win32_networkadapter where index=5 call enable
arp -d *
route -f
nbtstat -R
nbtstat -RR
netcfg -d
netsh winsock reset
netsh int 6to4 reset all
netsh int httpstunnel reset all
netsh int ip reset
netsh int isatap reset all
netsh int portproxy reset all
netsh int tcp reset all
netsh int teredo reset all
netsh branchcache reset
ipconfig /release
ipconfig /renew
sc config WlanSvc start= auto
sc config Wcmsvc start= auto
timeout 2 > nul 
goto :Extra 

:AppIN
cls
color D
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.
echo.                             ▄▄▄·  ▄▄▄· ▄▄▄·    ▪       .▄▄ · ▄▄▄▄▄ ▄▄▄· ▄▄▌  ▄▄▌  ▄▄▄ .▄▄▄  
echo.                            ▐█ ▀█ ▐█ ▄█▐█ ▄█    ██  █▌▐█▐█ ▀. •██  ▐█ ▀█ ██•  ██•  ▀▄.▀·▀▄ █·
echo.                            ▄█▀▀█  ██▀· ██▀·    ▐█·▐█▐▐▌▄▀▀▀█▄ ▐█.▪▄█▀▀█ ██▪  ██▪  ▐▀▀▪▄▐▀▀▄ 
echo.                            ▐█ ▪▐▌▐█▪·•▐█▪·•    ▐█ ██▐█▌▐█▄▪▐█ ▐█▌·▐█ ▪▐▌▐█▌▐▌▐█▌▐▌▐█▄▄▌▐█•█▌
echo.                             ▀  ▀ .▀   .▀       ▀▀ ▀▀  ▪ ▀▀▀▀  ▀▀▀  ▀  ▀ .▀▀▀ .▀▀▀  ▀▀▀ .▀  ▀
echo. 
echo.                         ╔═════════════════════════════════════════════════════════════════════╗ 
echo.                         ║                                                                     ║ 
echo.                         ║          [1] Back to Extras!          [2] Discord                   ║
echo.                         ║                                                                     ║
echo.                         ║          [3] Logitech Memory Manager  [4] Dcontrol                  ║
echo.                         ║                                                                     ║
echo.                         ║          [5] Spotify                  [6] Hidusbf                   ║
echo.                         ║                                                                     ║
echo.                         ║          [7] Google Chrome            [8] 7Zip                      ║
echo.                         ║                                                                     ║
echo.                         ║          [9] OBS Studio               [10] Vlc                      ║
echo.                         ║                                                                     ║
echo.                         ╚═════════════════════════════════════════════════════════════════════╝
echo.
echo.
echo.
echo ____________________
set /p option="Enter option number: "
if "%option%"=="1" (
cls 
echo Going back to Extras
timeout 1 > nul
goto :Extra 
) else if "%option%"=="2" (
set "fileURL=https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x64"
set "fileName=DiscordSetup.exe"
) else if "%option%"=="3" (
set "fileURL=https://download01.logi.com/web/ftp/pub/techsupport/gaming/OnboardMemoryManager_2.2.5062.exe"
set "fileName=OnboardMemoryManager_2.2.5062.exe"
) else if "%option%"=="4" (
set "fileURL=https://github.com/QuakedK/Downloads/raw/refs/heads/main/Dcontrol.zip"
set "fileName=Dcontrol.zip"  
) else if "%option%"=="5" (
set "fileURL=https://download.scdn.co/SpotifySetup.exe"
set "fileName=SpotifySetup.exe"
) else if "%option%"=="6" (
set "fileURL=https://github.com/LordOfMice/hidusbf/raw/refs/heads/master/hidusbf.zip"
set "fileName=hidusbf.zip"
) else if "%option%"=="7" (
set "fileURL=https://dl.google.com/chrome/install/latest/chrome_installer.exe"
set "fileName=ChromeSetup.exe"    
) else if "%option%"=="8" (
set "fileURL=https://7-zip.org/a/7z2409-x64.exe"
set "fileName=7z2409-x64.exe"  
) else if "%option%"=="9" (
set "fileURL=https://cdn-fastly.obsproject.com/downloads/OBS-Studio-31.0.0-Windows-Installer.exe"
set "fileName=OBS-Studio-31.0.0-Windows-Installer.exe"  
) else if "%option%"=="10" (
set "fileURL=https://get.videolan.org/vlc/3.0.21/win64/vlc-3.0.21-win64.exe"
set "fileName=vlc-3.0.21-win64.exe"             
) else (
cls
chcp 437 >nul
powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
timeout 2 > nul
goto :AppIN
)

cls
echo Download may take several seconds or minutes!
chcp 65001 >nul 2>&1
echo.
echo ╔═════════════════════════════╗
echo ║                             ║
echo ║    Downloading resources    ║
echo ║                             ║
echo ╚═════════════════════════════╝
chcp 437 >nul
mkdir "C:\Oneclick Tools\App Installer" >nul 2>&1
set "downloadsFolder=C:\Oneclick Tools\App Installer"
curl -s -L "%fileURL%" -o "%downloadsFolder%\%fileName%"

:: Check if the file was downloaded successfully
if exist "%downloadsFolder%\%fileName%" (
    echo File downloaded successfully.
    echo.
    echo Opening App Installer's download folder!
    explorer "C:\Oneclick Tools\App Installer" 
    echo.
    pause
    goto :ExplorerTK
) else (
    echo Failed to download the file.
    timeout 1 > nul
    goto :AppIN
)

:ExplorerTK
for /f "tokens=2" %%a in ('tasklist /fi "imagename eq explorer.exe" /v ^| findstr /i "C:\Oneclick Tools\App Installer"') do (
    taskkill /f /pid %%a >nul 2>&1
)
goto :AppIN

:NT
cls
color 9
chcp 65001 >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.                               ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
echo.                               ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
echo.                               ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
echo.                               ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
echo.                               ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
echo.                               ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
echo.                                                              
echo.                                   ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗           
echo.                                   ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝           
echo.                                      ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗           
echo.                                      ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║           
echo.                                      ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║           
echo.                                      ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝           
echo. 
echo.                                  ╔════════════════════════════════════════════════════╗
echo.                                  ║             Version 1.0 - By Quaked                ║       
echo.                                  ╚════════════════════════════════════════════════════╝
echo.
echo.
echo.                                                                          
echo Do you want to tweak your network settings?
echo.
chcp 437 >nul
powershell -Command "Write-Host '(Not Recommended) Can cause Connection Issue''s due to being very driver dependent.' -ForegroundColor White -BackgroundColor Red"
echo.
set /p choice=Enter (Y/N): 
if /i "%choice%"=="Y" (
    cls
    goto :NetworkTweaks
) else if /i "%choice%"=="N" ( 
    echo.
    echo Skipping Quaked's Networks Tweaks...
    timeout 2 > nul
    cls
    goto :Extra 
) else (
    cls
    chcp 437 >nul
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    goto :NT
)

:NetworkTweaks
cls
color D
chcp 437 >nul
setlocal

echo Detecting Network Adapter...

for /f "skip=1 delims=" %%a in ('wmic nic where "NetConnectionStatus=2" get NetConnectionID /value 2^>nul') do (
    for /f "tokens=2 delims==" %%b in ("%%a") do (
        set "adapter_name=%%b"
    )
)

if defined adapter_name (
    echo Your current network adapter is: %adapter_name%
    echo.
    echo Tweaking Network Settings...
    echo Credit to Mathako for helping!
    echo.
    powershell -Command "Write-Host 'This might take awhile, as the changes are suppressed and nulled.' -ForegroundColor White -BackgroundColor Red"
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Flow Control' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Gigabit Master Slave Mode' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'IPv4 Checksum Offload' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Jumbo Packet' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Large Send Offload V2 (IPv4)' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Large Send Offload V2 (IPv6)' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Log Link State Event' | Set-NetAdapterAdvancedProperty -RegistryValue 16" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Maximum Number of RSS Queues' | Set-NetAdapterAdvancedProperty -RegistryValue 4" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Packet Priority & VLAN' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Receive Buffers' | Set-NetAdapterAdvancedProperty -RegistryValue 512" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'TCP Checksum Offload (IPv4)' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'TCP Checksum Offload (IPv6)' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Transmit Buffers' | Set-NetAdapterAdvancedProperty -RegistryValue 512" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'UDP Checksum Offload (IPv4)' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'UDP Checksum Offload (IPv6)' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Wait for Link' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Advanced EEE' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'ARP Offload' | Set-NetAdapterAdvancedProperty -RegistryValue 1" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Energy-Efficent Ethernet' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Gitabit Lite' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Green Ethernet' | Set-NetAdapterAdvancedProperty -RegistryValue 0">nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'NS Offload' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Power Saving Mode' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Receive Side Scaling' | Set-NetAdapterAdvancedProperty -RegistryValue 1" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Shutdown Wake-On-Lan' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Priority & VLAN' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Wake on Magic Packet' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Wake on magic packet when system is in the S0ix power state' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Wake on pattern match' | Set-NetAdapterAdvancedProperty -RegistryValue 0" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'WOL & Shutdown Link Speed' | Set-NetAdapterAdvancedProperty -RegistryValue 2" >nul 2>&1 
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Jumbo Packet' | Set-NetAdapterAdvancedProperty -RegistryValue 1514" >nul 2>&1
    powershell -Command "Get-NetAdapterAdvancedProperty -Name \"%adapter_name%\" -DisplayName 'Jumbo Frame' | Set-NetAdapterAdvancedProperty -RegistryValue 1514" >nul 2>&1
    echo Network Settings appiled successfully.
    timeout 2 > nul   
) else (
    echo Unable to detect your current network adapter.
    timeout 2 > nul
)
endlocal

:DNS
cls
chcp 65001 >nul 2>&1
color 9
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                                 ██████╗ ███╗   ██╗███████╗
echo.                                                 ██╔══██╗████╗  ██║██╔════╝
echo.                                                 ██║  ██║██╔██╗ ██║███████╗
echo.                                                 ██║  ██║██║╚██╗██║╚════██║
echo.                                                 ██████╔╝██║ ╚████║███████║
echo.                                                 ╚═════╝ ╚═╝  ╚═══╝╚══════╝
echo. 
echo.                                 ╔══════════════════════════════════════════════════════╗
echo.                                 ║ Switching dns may or may not lead to better results  ║
echo.                                 ║             Skipping this is advised!                ║
echo.                                 ╚══════════════════════════════════════════════════════╝
echo.
echo.
echo.
echo Choose an option
chcp 437 >nul
powershell -Command "Write-Host '1. DNS Jumper, Recommended!' -ForegroundColor White -BackgroundColor Green"
echo 2. Google Dns
echo 3. Cloudflare Dns
echo 4. Back to Extras!
set /p option="Enter option number: "

REM Get the active network interface using PowerShell
for /f "usebackq tokens=*" %%i in (`powershell "(Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name"`) do (
    set "interface=%%i"
)

if "%option%"=="1" (
    set "fileURL=https://www.sordum.org/files/downloads.php?dns-jumper"
    set "fileName=DnsJumper.zip" 
    set "extractFolder=C:\Oneclick Tools\DnsJumper"
) else if "%option%"=="2" (
    echo Setting DNS to Google...
    netsh interface ipv4 add dnsservers name="%interface%" address=8.8.8.8 index=1 >nul 2>&1
    netsh interface ipv4 add dnsservers name="%interface%" address=8.8.4.4 index=2 >nul 2>&1
    echo DNS set to Google successfully.
    timeout 2 > nul
    goto :Extra 
) else if "%option%"=="3" (
    echo Setting DNS to Cloudflare...
    netsh interface ipv4 add dnsservers name="%interface%" address=1.1.1.1 index=1 >nul 2>&1
    netsh interface ipv4 add dnsservers name="%interface%" address=1.0.0.1 index=2 >nul 2>&1
    echo DNS set to Cloudflare successfully.
    timeout 2 > nul
    goto :Extra 
) else if "%option%"=="4" (
    echo Skipping DNS configuration.
    timeout 2 > nul
    goto :Extra 
) else (
    cls
    chcp 437 >nul5
    powershell -Command "Write-Host 'Invalid choice, Please choose Y or N.' -ForegroundColor White -BackgroundColor Red"
    timeout 2 > nul
    goto :DNS
)

set "downloadsFolder=C:\Oneclick Tools"
chcp 65001 >nul 2>&1
echo.
echo ╔═════════════════════════════╗
echo ║                             ║
echo ║    Downloading resources    ║
echo ║                             ║
echo ╚═════════════════════════════╝
chcp 437 >nul
curl -s -L "%fileURL%" -o "%downloadsFolder%\%fileName%"
if exist "%downloadsFolder%\%fileName%" (
    echo Download successful!
    if "%option%"=="1" (
        mkdir "%extractFolder%" >nul 2>&1
        pushd "%extractFolder%" >nul 2>&1
        tar -xf "%downloadsFolder%\%fileName%" --strip-components=1 >nul 2>&1
        popd >nul 2>&1
        del /q "C:\Oneclick Tools\DnsJumper.zip" >nul 2>&1
        cls
        echo Starting DnsJumper...
        echo.
        start "" "C:\Oneclick Tools\DnsJumper\DnsJumper.exe"
        echo Click "fastest Dns" and then "Start Dns Test"
        echo Then click apply dns and you're done!
        pause
        goto :Extra 
    ) else (
        echo Skipping!
        timeout 2 > nul
        goto :Extra 
    )
)

:Fort
cls
color 9
:: (Quaked) Downloading Fortnite Optimizer Tools at Start, Includes Fortnite Configs.
set "fileURL=https://github.com/QuakedK/Oneclick/raw/refs/heads/main/Downloads/FortniteOptimizerTools.zip"
set "fileName=Fortnite Optimizer Tools.zip"
set "extractFolder=C:\Oneclick Tools\Fortnite Optimizer Tools"
set "downloadsFolder=C:\Oneclick Tools"
if not exist "%downloadsFolder%\%fileName%" (
    curl -s -L "%fileURL%" -o "%downloadsFolder%\%fileName%"
    timeout 1 > nul
    mkdir "%extractFolder%" >nul 2>&1
    pushd "%extractFolder%" >nul 2>&1
    tar -xf "%downloadsFolder%\%fileName%" --strip-components=1 >nul 2>&1
    popd >nul 2>&1
    del /q "C:\Oneclick Tools\Fortnite Optimizer Tools.zip" >nul 2>&1
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

:SkippingFortPriority
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
powershell -Command "Move-Item -Path 'C:\Oneclick Tools\Fortnite Optimizer Tools\Fortnite Configs\Low Meshes\GameUserSettings.ini' -Destination \"$env:USERPROFILE\AppData\Local\FortniteGame\Saved\Config\WindowsClient\" -Force"
echo The operation completed successfully.
echo.
echo You might need to adjust your FPS and resolution to your liking.
timeout 2 > nul 
) else if "%option%"=="2" (
echo.
echo Importing High Meshes Fortnite Game Config!
powershell -Command "Move-Item -Path 'C:\Oneclick Tools\Fortnite Optimizer Tools\Fortnite Configs\High Meshes\GameUserSettings.ini' -Destination \"$env:USERPROFILE\AppData\Local\FortniteGame\Saved\Config\WindowsClient\" -Force"
echo The operation completed successfully.
echo.
echo You might need to adjust your FPS and resolution to your liking.
timeout 2 > nul 
) else if "%option%"=="3" (
echo.
echo Importing DX12 Fortnite Game Config!
powershell -Command "Move-Item -Path 'C:\Oneclick Tools\Fortnite Optimizer Tools\Fortnite Configs\DX 12\GameUserSettings.ini' -Destination \"$env:USERPROFILE\AppData\Local\FortniteGame\Saved\Config\WindowsClient\" -Force"
echo The operation completed successfully.
echo.
echo You might need to adjust your FPS and resolution to your liking.
timeout 2 > nul    
) else if "%option%"=="4" (
echo Skipping!
timeout 1 > nul   
goto :SkippingConfig 
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
goto :Extra 

:Dis
echo Going to Quaked Tweaks Discord...
start "" "https://discord.gg/B8EmFVkdFU"
timeout 2 > nul
goto :Extra

:FWK
echo Starting Massgravel's Microsoft Activation Script...
start "" /min cmd /k powershell -Command "irm https://get.activated.win | iex"
echo.
pause
goto :Extra

:RS
echo Restarting your PC to apply all tweaks!
sc config TrustedInstaller start=disabled >nul 2>&1
rd /s /q "C:\Oneclick Tools\Amd" >nul 2>&1
rd /s /q "C:\Oneclick Tools\Dcontrol" >nul 2>&1
rd /s /q "C:\Oneclick Tools\DnsJumper" >nul 2>&1
rd /s /q "C:\Oneclick Tools\Fortnite Optimizer Tools" >nul 2>&1
rd /s /q "C:\Oneclick Tools\NSudo" >nul 2>&1
rd /s /q "C:\Oneclick Tools\Nvidia" >nul 2>&1
rd /s /q "C:\Oneclick Tools\OOshutup10" >nul 2>&1
rd /s /q "C:\Oneclick Tools\Open Shell" >nul 2>&1
rd /s /q "C:\Oneclick Tools\Orca" >nul 2>&1
rd /s /q "C:\Oneclick Tools\Power Plan" >nul 2>&1
rd /s /q "C:\Oneclick Tools\Process Destroyer" >nul 2>&1
rd /s /q "C:\Oneclick Tools\Sound" >nul 2>&1
rd /s /q "C:\Oneclick Tools\VC Redist" >nul 2>&1
timeout 2 > nul
shutdown /r /t 0 
