#Check for admin
param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
		#MsgBox information
		Add-Type -AssemblyName PresentationCore,PresentationFramework
		$msgBody = "Run the script as an Administrator."
		$msgTitle = "Pngu Permission Error"
		$msgButton = 'OK'
		$msgImage = 'Error'
		$Result = [System.Windows.MessageBox]::Show($msgBody,$msgTitle,$msgButton,$msgImage)
    } else {
		if (Get-Item -Path $Env:programdata\Run-ET.log) {
			Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
		} 
		else 
		{
		Start-Process powershell.exe "set-executionpolicy remotesigned" -Verb RunAs 
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
		}
    }
    exit
}

# Window CLI size
[console]::WindowWidth=80
[console]::WindowHeight=23
[console]::BufferWidth = [console]::WindowWidth


#Window CLI-Console show/hide
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
    # Hide = 0,
    # ShowNormal = 1,
    # ShowMinimized = 2,
    # ShowMaximized = 3,
    # Maximize = 3,
    # ShowNormalNoActivate = 4,
    # Show = 5,
    # Minimize = 6,
    # ShowMinNoActivate = 7,
    # ShowNoActivate = 8,
    # Restore = 9,
    # ShowDefault = 10,
    # ForceMinimized = 11

# [Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0) | Out-Null


#Window CLI color
$Host.UI.RawUI.BackgroundColor = ($bckgrnd = 'Black')

# System Information function
$ProcessorType=Get-WMIObject win32_Processor | select Name | findstr /c:AMD /c:Intel
$ProcessorType = $ProcessorType.Replace('(R)','').Replace('(TM)','')
$licensekey=wmic path softwarelicensingservice get OA3xOriginalProductKey | findstr /c:'-'
$RAMGet=Get-WMIObject -Computername localhost -class win32_ComputerSystem | Select-Object -Expand TotalPhysicalMemory
$RAMGet=$RAMGet/1024/1024/1024

# Cleaning help files
if (Test-Path $Env:programdata\*.lbool) {Remove-Item $Env:programdata\*.lbool}
if (Test-Path $Env:programdata\ET\*.lbool) {Remove-Item $Env:programdata\ET\*.lbool}
if (Test-Path $Env:programdata\*.lbool) {Remove-Item $Env:programdata\ET\*.lbool}
if (Test-Path $Env:programdata\ET\) {
}
else
{
    #Create directory if not exists
    New-Item $Env:programdata\ET\ -ItemType Directory
}

# Using UTF-8 Encoding + special characters
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
chcp 65001

# Created by Rikey
# https://github.com/semazurek/ET-Optimizer
# https://www.paypal.com/paypalme/rikey


# Winget update aplications module
Write-Output " @echo off" > $Env:programdata\winget-et.bat
Write-Output " chcp 65001" >> $Env:programdata\winget-et.bat
Write-Output " cls" >> $Env:programdata\winget-et.bat
Write-Output " title ET Update Application (Winget)" >> $Env:programdata\winget-et.bat
Write-Output " Winget upgrade" >> $Env:programdata\winget-et.bat
Write-Output " Winget upgrade --all" >> $Env:programdata\winget-et.bat
Write-Output " Winget upgrade --all" >> $Env:programdata\winget-et.bat

# Restart Network Settings Module (Extras)
Write-Output " mode con cols=80 lines=30" > $Env:programdata\restart-network-settings.bat
Write-Output " chcp 65001" >> $Env:programdata\restart-network-settings.bat
Write-Output " cls" >> $Env:programdata\restart-network-settings.bat
Write-Output " netsh winsock reset" >> $Env:programdata\restart-network-settings.bat
Write-Output " netsh int ipv4 reset" >> $Env:programdata\restart-network-settings.bat
Write-Output " netsh int ipv6 reset" >> $Env:programdata\restart-network-settings.bat
Write-Output " ipconfig /release" >> $Env:programdata\restart-network-settings.bat
Write-Output " ipconfig /renew" >> $Env:programdata\restart-network-settings.bat
Write-Output " ipconfig /flushdns" >> $Env:programdata\restart-network-settings.bat

$versionPS="Pngu Optimizer   -   "+$ProcessorType+", "+[math]::round($RAMGet)+" GB RAM";
$versionRAW="Pngu Optimizer"
$HOST.UI.RAWUI.WINDOWTITLE = $versionRAW
[reflection.assembly]::LoadWithPartialName( 'System.Windows.Forms'); 
[reflection.assembly]::loadwithpartialname('System.Drawing'); 
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Continue if error
$ErrorActionPreference= "SilentlyContinue";

$mainforecolor="#eeeeee"
$mainbackcolor="#252525"
$menubackcolor="#323232"
$selectioncolor="#3498db"
$expercolor="#e74c3c"
function count_p {
$c_p = 0;
Foreach ($control in $panel1.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_p++;$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor)}
		Else {$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)}
   }
If ($c_p -eq 34) { $panel1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor); $B_performanceall.Visible = $false; $B_performanceoff.Visible = $true; }
Else { $panel1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor); $B_performanceall.Visible = $true; $B_performanceoff.Visible = $false; }
}
function count_v {
$c_v = 0;
Foreach ($control in $panel3.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_v++;$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor)}
		Else {$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)}
   }
If ($c_v -eq 6) { $panel3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor); $B_visualoff.Visible = $true; $B_visualall.Visible = $false; }
Else { $panel3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor); $B_visualoff.Visible = $false; $B_visualall.Visible = $true; }
}
function count_s {
$c_s = 0;
Foreach ($control in $panel2.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_s++;$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor)}
		Else {$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)}
   }
If ($c_s -eq 17) { $panel2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor); $B_privacyoff.Visible = $true; $B_privacyall.Visible = $false; }
Else { $panel2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor); $B_privacyoff.Visible = $false; $B_privacyall.Visible = $true; }
}
function count_o {
$c_o = 0;
Foreach ($control in $panel4.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_o++;$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor)}
		Else {$control.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)}
   }
If ($c_o -eq 6) { $panel4.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor); }
Else { $panel4.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor); }
}
function do_start { 
Foreach ($control in $panel1.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $panel2.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $panel3.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $panel4.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $groupBox5.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
$form.close()
}; 
$form= New-Object Windows.Forms.Form; 
$form.Size = New-Object System.Drawing.Size(895,505); 
$form.StartPosition = 'CenterScreen'; 
$form.FormBorderStyle = 'FixedDialog'; 
$form.Text = $versionPS; 
$form.AutoSizeMode = 'GrowAndShrink'; 
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$form.MinimizeBox = $false; 
$form.MaximizeBox = $false; 
$Font = New-Object System.Drawing.Font('Consolas',9,[System.Drawing.FontStyle]::Regular); 
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor)
$form.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$form.Font = $Font; 
$iconimageBytes = [Convert]::FromBase64String($base64IconString)
$ims = New-Object IO.MemoryStream($iconimageBytes, 0, $iconimageBytes.Length)
$ims.Write($iconimageBytes, 0, $iconimageBytes.Length); 
$Icon = [System.Drawing.Image]::FromStream($ims, $true)
$form.Icon = [System.Drawing.Icon]::FromHandle((new-object System.Drawing.Bitmap -argument $ims).GetHIcon())
$B_close = New-Object Windows.Forms.Button; 
$B_close.text = 'Start'; 
$B_close.FlatStyle = 'Flat'
$B_close.Location = New-Object Drawing.Point 660,400; 
$B_close.Size = New-Object Drawing.Point 120,50;
$B_close.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_close.add_click({do_start}); $form.controls.add($B_close); 
$B_checkall = New-Object Windows.Forms.Button; 
$B_checkall.text = 'Select All'; 
$B_checkall.Location = New-Object Drawing.Point 510,400; 
$B_checkall.Size = New-Object Drawing.Point 140,50;
$B_checkall.FlatStyle = 'Flat'
$B_checkall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_checkall.add_click({
Foreach ($control in $panel1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
Foreach ($control in $panel2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
Foreach ($control in $panel3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
Foreach ($control in $panel4.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.TabIndex -ne 60 -and $control.TabIndex -ne 61 -and $control.TabIndex -ne 59 -and $control.TabIndex -ne 65 -and $control.TabIndex -ne 66){
           $control.checked = $true
       }
   }
$B_checkall.Visible = $false;
$B_uncheckall.Visible = $true;
$B_performanceoff.Visible = $true;
$B_performanceall.Visible = $false;
$B_visualoff.Visible = $true;
$B_visualall.Visible = $false;
$B_privacyoff.Visible = $true;
$B_privacyall.Visible = $false;
count_p;
count_v;
count_s;
count_o;
}); 
$form.controls.add($B_checkall);
$B_uncheckall = New-Object Windows.Forms.Button; 
$B_uncheckall.text = 'Unselect All'; 
$B_uncheckall.Location = New-Object Drawing.Point 510,400; 
$B_uncheckall.Size = New-Object Drawing.Point 140,50;
$B_uncheckall.FlatStyle = 'Flat'
$B_uncheckall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_uncheckall.add_click({
Foreach ($control in $panel1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $panel2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $panel3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $panel4.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $groupBox5.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
$B_checkall.Visible = $true;
$B_uncheckall.Visible = $false;
$B_performanceoff.Visible = $false;
$B_performanceall.Visible = $true;
$B_visualoff.Visible = $false;
$B_visualall.Visible = $true;
$B_privacyoff.Visible = $false;
$B_privacyall.Visible = $true;
count_p;
count_v;
count_s;
count_o;
}); 
$form.controls.add($B_uncheckall);
$B_performanceall = New-Object Windows.Forms.Button; 
$B_performanceall.text = 'Performance'; 
$B_performanceall.Location = New-Object Drawing.Point 110,400; 
$B_performanceall.Size = New-Object Drawing.Point 130,50;
$B_performanceall.FlatStyle = 'Flat'
$B_performanceall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_performanceall.add_click({
Foreach ($control in $panel1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
count_p;
$B_performanceoff.Visible = $true;
$B_performanceall.Visible = $false;
}); 
$form.controls.add($B_performanceall); 
$B_performanceoff = New-Object Windows.Forms.Button; 
$B_performanceoff.text = 'Performance'; 
$B_performanceoff.Location = New-Object Drawing.Point 110,400; 
$B_performanceoff.Size = New-Object Drawing.Point 130,50;
$B_performanceoff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor);
$B_performanceoff.FlatStyle = 'Flat'
$B_performanceoff.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_performanceoff.add_click({
Foreach ($control in $panel1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
count_p;
$B_performanceoff.Visible = $false;
$B_performanceall.Visible = $true;
}); 
$form.controls.add($B_performanceoff); 
$B_visualall = New-Object Windows.Forms.Button; 
$B_visualall.text = 'Visual'; 
$B_visualall.Location = New-Object Drawing.Point 250,400; 
$B_visualall.Size = New-Object Drawing.Point 120,50;
$B_visualall.FlatStyle = 'Flat'
$B_visualall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_visualall.add_click({
Foreach ($control in $panel3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
$B_visualoff.Visible = $true;
$B_visualall.Visible = $false;
count_v;
}); 
$form.controls.add($B_visualall); 
$B_visualoff = New-Object Windows.Forms.Button; 
$B_visualoff.text = 'Visual'; 
$B_visualoff.Location = New-Object Drawing.Point 250,400; 
$B_visualoff.Size = New-Object Drawing.Point 120,50;
$B_visualoff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor);
$B_visualoff.FlatStyle = 'Flat'
$B_visualoff.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_visualoff.add_click({
Foreach ($control in $panel3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
$B_visualoff.Visible = $false;
$B_visualall.Visible = $true;
count_v;
}); 
$form.controls.add($B_visualoff); 
$B_privacyall = New-Object Windows.Forms.Button; 
$B_privacyall.text = 'Privacy'; 
$B_privacyall.Location = New-Object Drawing.Point 380,400; 
$B_privacyall.Size = New-Object Drawing.Point 120,50;
$B_privacyall.FlatStyle = 'Flat'
$B_privacyall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_privacyall.add_click({
Foreach ($control in $panel2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
$B_privacyoff.Visible = $true;
$B_privacyall.Visible = $false;
count_s;
}); 
$form.controls.add($B_privacyall); 
$B_privacyoff = New-Object Windows.Forms.Button; 
$B_privacyoff.text = 'Privacy'; 
$B_privacyoff.Location = New-Object Drawing.Point 380,400; 
$B_privacyoff.Size = New-Object Drawing.Point 120,50;
$B_privacyoff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($selectioncolor);
$B_privacyoff.FlatStyle = 'Flat'
$B_privacyoff.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_privacyoff.add_click({
Foreach ($control in $panel2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
$B_privacyoff.Visible = $false;
$B_privacyall.Visible = $true;
count_s;
}); 
$form.controls.add($B_privacyoff);
$B_uncheckall.Visible = $false;
$B_performanceall.Visible = $false;
$B_visualall.Visible = $false;
$B_privacyall.Visible = $false;
count_p;
count_v;
count_s;
count_o;
$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = '10,30' 
$groupBox1.size = '570,180'
$groupBox1.text = 'Performance Tweaks (34)'
$groupBox1.Visible = $true
$groupBox1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$form.controls.Add($groupBox1) 
$groupBox1.add_click({count_p})
$panel1 = New-Object System.Windows.Forms.Panel
$panel1.Dock = DockStyle.Fill
$panel1.AutoScroll = $true
$panel1.VerticalScroll.Enabled = $false
$panel1.VerticalScroll.Visible = $false
$panel1.size = '576,153'
$panel1.FlatStyle = 'Flat'
$panel1.Location = '10,20'
$groupbox1.controls.Add($panel1) 
$groupBox2 = New-Object System.Windows.Forms.GroupBox
$groupBox2.Location = '585,30' 
$groupBox2.size = '285,180'
$groupBox2.text = 'Privacy (17)'
$groupBox2.Visible = $true
$groupBox2.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$form.Controls.Add($groupBox2) 
$groupBox2.add_click({count_s})
$panel2 = New-Object System.Windows.Forms.Panel
$panel2.Dock = DockStyle.Fill
$panel2.AutoScroll = $true
$panel2.VerticalScroll.Enabled = $false
$panel2.VerticalScroll.Visible = $false
$panel2.size = '291,153'
$panel2.FlatStyle = 'Flat'
$panel2.Location = '10,20'
$groupBox2.controls.Add($panel2) 
$groupBox3 = New-Object System.Windows.Forms.GroupBox
$groupBox3.Location = '10,210' 
$groupBox3.size = '285,180'
$groupBox3.text = 'Visual Tweaks (6)'
$groupBox3.Visible = $true
$groupBox3.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$form.Controls.Add($groupBox3) 
$groupBox3.add_click({count_v})
$panel3 = New-Object System.Windows.Forms.Panel
$panel3.Dock = DockStyle.Fill
$panel3.AutoScroll = $true
$panel3.VerticalScroll.Enabled = $false
$panel3.VerticalScroll.Visible = $false
$panel3.size = '291,153'
$panel3.FlatStyle = 'Flat'
$panel3.Location = '10,20'
$groupBox3.controls.Add($panel3) 
$groupBox4 = New-Object System.Windows.Forms.GroupBox
$groupBox4.Location = '302,210' 
$groupBox4.size = '278,180'
$groupBox4.text = 'Other (6)'
$groupBox4.Visible = $true
$groupBox4.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox4.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$form.Controls.Add($groupBox4) 
$panel4 = New-Object System.Windows.Forms.Panel
$panel4.Dock = DockStyle.Fill
$panel4.AutoScroll = $true
$panel4.VerticalScroll.Enabled = $false
$panel4.VerticalScroll.Visible = $false
$panel4.size = '284,153'
$panel4.FlatStyle = 'Flat'
$panel4.Location = '10,20'
$groupBox4.controls.Add($panel4) 
$groupBox5 = New-Object System.Windows.Forms.GroupBox
$groupBox5.Location = '585,210' 
$groupBox5.size = '285,180'
$groupBox5.text = 'Expert Mode (4)'
$groupBox5.Visible = $true
$groupBox5.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox5.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($expercolor)
$form.Controls.Add($groupBox5) 
$groupBox5.add_MouseHover({
$tooltipg5 = New-Object System.Windows.Forms.ToolTip
$tooltipg5.SetToolTip($groupBox5, 'Non recommended or unstable. May need to be done in safe mode.')
})
$chck1 = New-Object Windows.Forms.Checkbox; 
$chck1.Location = New-Object Drawing.Point 0,5; 
$chck1.Size = New-Object Drawing.Point 270,25; 
$chck1.Text = 'Disable Edge WebWidget'; 
$chck1.TabIndex = 0;
$chck1.Checked = $true; 
$chck1.Font = $Font; 
$panel1.controls.add($chck1); 
$chck1.add_click({count_p})
$chck2 = New-Object Windows.Forms.Checkbox; 
$chck2.Location = New-Object Drawing.Point 0,30; 
$chck2.Size = New-Object Drawing.Point 270,25; 
$chck2.Text = 'Power Option to Ultimate Performance'; 
$chck2.TabIndex = 1; 
$chck2.Checked = $true; 
$chck2.Font = $Font;
$panel1.controls.add($chck2); 
$chck2.add_MouseHover({
$tooltip2 = New-Object System.Windows.Forms.ToolTip
$tooltip2.SetToolTip($chck2, 'Setting power option to high/ultimate for best CPU performance')
})
$chck2.add_click({count_p})
$chck4 = New-Object Windows.Forms.Checkbox; 
$chck4.Location = New-Object Drawing.Point 0,55; 
$chck4.Size = New-Object Drawing.Point 270,25; 
$chck4.Text = 'Dual Boot Timeout 3sec'; 
$chck4.TabIndex = 3; 
$chck4.Checked = $true; 
$chck4.Font = $Font;
$panel1.controls.add($chck4); 
$chck4.add_click({count_p})
$chck5 = New-Object Windows.Forms.Checkbox; 
$chck5.Location = New-Object Drawing.Point 0,80; 
$chck5.Size = New-Object Drawing.Point 270,25; 
$chck5.Text = 'Disable Hibernation/Fast Startup'; 
$chck5.TabIndex = 4; 
$chck5.Checked = $true; 
$chck5.Font = $Font;
$panel1.controls.add($chck5); 
$chck5.add_MouseHover({
$tooltip5 = New-Object System.Windows.Forms.ToolTip
$tooltip5.SetToolTip($chck5, 'Disable Hibernation/Fast startup in Windows to free RAM from hiberfil.sys')
})
$chck5.add_click({count_p})
$chck6 = New-Object Windows.Forms.Checkbox; 
$chck6.Location = New-Object Drawing.Point 0,105; 
$chck6.Size = New-Object Drawing.Point 280,25; 
$chck6.Text = 'Disable Windows Insider Experiments'; 
$chck6.TabIndex = 5; 
$chck6.Checked = $true; 
$chck6.Font = $Font;
$panel1.controls.add($chck6); 
$chck6.add_click({count_p})
$chck7 = New-Object Windows.Forms.Checkbox; 
$chck7.Location = New-Object Drawing.Point 0,130; 
$chck7.Size = New-Object Drawing.Point 270,25; 
$chck7.Text = 'Disable App Launch Tracking'; 
$chck7.TabIndex = 6; 
$chck7.Checked = $true; 
$chck7.Font = $Font;
$panel1.controls.add($chck7); 
$chck7.add_click({count_p})
$chck8 = New-Object Windows.Forms.Checkbox; 
$chck8.Location = New-Object Drawing.Point 0,155; 
$chck8.Size = New-Object Drawing.Point 275,25; 
$chck8.Text = 'Disable Powerthrottling (Intel 6gen+)'; 
$chck8.TabIndex = 7; 
$chck8.Checked = $true; 
$chck8.Font = $Font;
$panel1.controls.add($chck8); 
$chck8.add_click({count_p})
$chck9 = New-Object Windows.Forms.Checkbox; 
$chck9.Location = New-Object Drawing.Point 0,180; 
$chck9.Size = New-Object Drawing.Point 275,25; 
$chck9.Text = 'Turn Off Background Apps'; 
$chck9.TabIndex = 8; 
$chck9.Checked = $true; 
$chck9.Font = $Font;
$panel1.controls.add($chck9); 
$chck9.add_click({count_p})
$chck10 = New-Object Windows.Forms.Checkbox; 
$chck10.Location = New-Object Drawing.Point 0,205; 
$chck10.Size = New-Object Drawing.Point 270,25; 
$chck10.Text = 'Disable Sticky Keys Prompt'; 
$chck10.TabIndex = 9; 
$chck10.Checked = $true; 
$chck10.Font = $Font;
$panel1.controls.add($chck10); 
$chck10.add_click({count_p})
$chck11 = New-Object Windows.Forms.Checkbox; 
$chck11.Location = New-Object Drawing.Point 0,230; 
$chck11.Size = New-Object Drawing.Point 270,25; 
$chck11.Text = 'Disable Activity History'; 
$chck11.TabIndex = 10; 
$chck11.Checked = $true; 
$chck11.Font = $Font;
$panel1.controls.add($chck11); 
$chck11.add_click({count_p})
$chck12 = New-Object Windows.Forms.Checkbox; 
$chck12.Location = New-Object Drawing.Point 0,255; 
$chck12.Size = New-Object Drawing.Point 280,25; 
$chck12.Text = 'Disable Updates for MS Store Apps'; 
$chck12.TabIndex = 11; 
$chck12.Checked = $true; 
$chck12.Font = $Font;
$panel1.controls.add($chck12); 
$chck12.add_MouseHover({
$tooltip12 = New-Object System.Windows.Forms.ToolTip
$tooltip12.SetToolTip($chck12, 'Disable Automatic Updates for Microsoft Store apps')
})
$chck12.add_click({count_p})
$chck13 = New-Object Windows.Forms.Checkbox; 
$chck13.Location = New-Object Drawing.Point 0,280; 
$chck13.Size = New-Object Drawing.Point 270,25; 
$chck13.Text = 'SmartScreen Filter for Apps: Disable'; 
$chck13.TabIndex = 12; 
$chck13.Checked = $true; 
$chck13.Font = $Font;
$panel1.controls.add($chck13); 
$chck13.add_click({count_p})
$chck14 = New-Object Windows.Forms.Checkbox; 
$chck14.Location = New-Object Drawing.Point 0,305; 
$chck14.Size = New-Object Drawing.Point 270,25; 
$chck14.Text = 'Let Websites Provide Locally'; 
$chck14.TabIndex = 13; 
$chck14.Checked = $true; 
$chck14.Font = $Font;
$panel1.controls.add($chck14); 
$chck14.add_click({count_p})
$chck15 = New-Object Windows.Forms.Checkbox; 
$chck15.Location = New-Object Drawing.Point 0,330; 
$chck15.Size = New-Object Drawing.Point 270,25; 
$chck15.Text = 'Fix Microsoft Edge Settings'; 
$chck15.TabIndex = 14; 
$chck15.Checked = $true; 
$chck15.Font = $Font;
$panel1.controls.add($chck15); 
$chck15.add_click({count_p})
$chck64 = New-Object Windows.Forms.Checkbox; 
$chck64.Location = New-Object Drawing.Point 0,355; 
$chck64.Size = New-Object Drawing.Point 270,25; 
$chck64.Text = 'Disable Nagle''s Alg. (Delayed ACKs)'; 
$chck64.TabIndex = 63; 
$chck64.Checked = $true; 
$chck64.Font = $Font;
$panel1.controls.add($chck64); 
$chck64.add_click({count_p})
$chck65 = New-Object Windows.Forms.Checkbox; 
$chck65.Location = New-Object Drawing.Point 0,380; 
$chck65.Size = New-Object Drawing.Point 270,25; 
$chck65.Text = 'CPU Priority Tweaks'; 
$chck65.TabIndex = 64; 
$chck65.Checked = $true; 
$chck65.Font = $Font;
$panel1.controls.add($chck65); 
$chck65.add_click({count_p})
$chck16 = New-Object Windows.Forms.Checkbox; 
$chck16.Location = New-Object Drawing.Point 285,05; 
$chck16.Size = New-Object Drawing.Point 270,25; 
$chck16.Text = 'Disable Location Sensor'; 
$chck16.TabIndex = 15; 
$chck16.Checked = $true; 
$chck16.Font = $Font;
$panel1.controls.add($chck16); 
$chck16.add_click({count_p})
$chck17 = New-Object Windows.Forms.Checkbox; 
$chck17.Location = New-Object Drawing.Point 285,30; 
$chck17.Size = New-Object Drawing.Point 270,25; 
$chck17.Text = 'Disable WiFi HotSpot Auto-Sharing'; 
$chck17.TabIndex = 16; 
$chck17.Checked = $true; 
$chck17.Font = $Font;
$panel1.controls.add($chck17); 
$chck17.add_click({count_p})
$chck18 = New-Object Windows.Forms.Checkbox; 
$chck18.Location = New-Object Drawing.Point 285,55; 
$chck18.Size = New-Object Drawing.Point 270,25; 
$chck18.Text = 'Disable Shared HotSpot Connect'; 
$chck18.TabIndex = 17; 
$chck18.Checked = $true; 
$chck18.Font = $Font;
$panel1.controls.add($chck18); 
$chck18.add_click({count_p})
$chck19 = New-Object Windows.Forms.Checkbox; 
$chck19.Location = New-Object Drawing.Point 285,80; 
$chck19.Size = New-Object Drawing.Point 270,25; 
$chck19.Text = 'Updates Notify to Schedule Restart'; 
$chck19.TabIndex = 18; 
$chck19.Checked = $true; 
$chck19.Font = $Font;
$panel1.controls.add($chck19); 
$chck19.add_MouseHover({
$tooltip19 = New-Object System.Windows.Forms.ToolTip
$tooltip19.SetToolTip($chck19, 'Change Windows Updates to: Notify to schedule restart')
})
$chck19.add_click({count_p})
$chck20 = New-Object Windows.Forms.Checkbox; 
$chck20.Location = New-Object Drawing.Point 285,105; 
$chck20.Size = New-Object Drawing.Point 270,25; 
$chck20.Text = 'P2P Update Setting to LAN (local)'; 
$chck20.TabIndex = 19; 
$chck20.Checked = $true; 
$chck20.Font = $Font;
$panel1.controls.add($chck20); 
$chck20.add_MouseHover({
$tooltip20 = New-Object System.Windows.Forms.ToolTip
$tooltip20.SetToolTip($chck20, 'Disable P2P Update downloads outside of local network')
})
$chck20.add_click({count_p})
$chck21 = New-Object Windows.Forms.Checkbox; 
$chck21.Location = New-Object Drawing.Point 285,130; 
$chck21.Size = New-Object Drawing.Point 270,25; 
$chck21.Text = 'Set Lower Shutdown Time (2sec)'; 
$chck21.TabIndex = 20; 
$chck21.Checked = $true; 
$chck21.Font = $Font;
$panel1.controls.add($chck21); 
$chck21.add_click({count_p})
$chck22 = New-Object Windows.Forms.Checkbox; 
$chck22.Location = New-Object Drawing.Point 285,155; 
$chck22.Size = New-Object Drawing.Point 270,25; 
$chck22.Text = 'Remove Old Device Drivers'; 
$chck22.TabIndex = 21; 
$chck22.Checked = $true; 
$chck22.Font = $Font;
$panel1.controls.add($chck22); 
$chck22.add_click({count_p})
$chck23 = New-Object Windows.Forms.Checkbox; 
$chck23.Location = New-Object Drawing.Point 285,180; 
$chck23.Size = New-Object Drawing.Point 270,25; 
$chck23.Text = 'Disable Get Even More Out of...'; 
$chck23.TabIndex = 22; 
$chck23.Checked = $true; 
$chck23.Font = $Font;
$panel1.controls.add($chck23); 
$chck23.add_MouseHover({
$tooltip23 = New-Object System.Windows.Forms.ToolTip
$tooltip23.SetToolTip($chck23, 'Disable Get Even More Out of Windows Screen')
})
$chck23.add_click({count_p})
$chck24 = New-Object Windows.Forms.Checkbox; 
$chck24.Location = New-Object Drawing.Point 285,205; 
$chck24.Size = New-Object Drawing.Point 270,25; 
$chck24.Text = 'Disable Installing Suggested Apps'; 
$chck24.TabIndex = 23; 
$chck24.Checked = $true; 
$chck24.Font = $Font;
$panel1.controls.add($chck24); 
$chck24.add_MouseHover({
$tooltip24 = New-Object System.Windows.Forms.ToolTip
$tooltip24.SetToolTip($chck23, 'Disable automatically installing suggested apps')
})
$chck24.add_click({count_p})
$chck25 = New-Object Windows.Forms.Checkbox; 
$chck25.Location = New-Object Drawing.Point 285,230; 
$chck25.Size = New-Object Drawing.Point 270,25; 
$chck25.Text = 'Disable Start Menu Ads/Suggestions'; 
$chck25.TabIndex = 24; 
$chck25.Checked = $true; 
$chck25.Font = $Font;
$panel1.controls.add($chck25); 
$chck25.add_click({count_p})
$chck26 = New-Object Windows.Forms.Checkbox; 
$chck26.Location = New-Object Drawing.Point 285,255; 
$chck26.Size = New-Object Drawing.Point 274,25; 
$chck26.Text = 'Disable Suggest Apps WindowsInk'; 
$chck26.TabIndex = 25; 
$chck26.Checked = $true; 
$chck26.Font = $Font;
$panel1.controls.add($chck26); 
$chck26.add_click({count_p})
$chck27 = New-Object Windows.Forms.Checkbox; 
$chck27.Location = New-Object Drawing.Point 285,280; 
$chck27.Size = New-Object Drawing.Point 270,25; 
$chck27.Text = 'Disable Unnecessary Components'; 
$chck27.TabIndex = 26; 
$chck27.Checked = $true; 
$chck27.Font = $Font;
$panel1.controls.add($chck27); 
$chck27.add_MouseHover({
$tooltip27 = New-Object System.Windows.Forms.ToolTip
$tooltip27.SetToolTip($chck27, 'PrintToPDFServices, Printing-XPSServices, Xps-Viewer')
})
$chck27.add_click({count_p})
$chck28 = New-Object Windows.Forms.Checkbox; 
$chck28.Location = New-Object Drawing.Point 285,305; 
$chck28.Size = New-Object Drawing.Point 270,25; 
$chck28.Text = 'Defender Scheduled Scan Nerf'; 
$chck28.TabIndex = 27; 
$chck28.Checked = $true; 
$chck28.Font = $Font;
$panel1.controls.add($chck28); 
$chck28.add_MouseHover({
$tooltip28 = New-Object System.Windows.Forms.ToolTip
$tooltip28.SetToolTip($chck28, 'Setting Windows Defender Scheduled Scan from highest to normal privileges')
})
$chck28.add_click({count_p})
$chck29 = New-Object Windows.Forms.Checkbox; 
$chck29.Location = New-Object Drawing.Point 285,330; 
$chck29.Size = New-Object Drawing.Point 270,25; 
$chck29.Text = 'Disable Process Mitigation'; 
$chck29.TabIndex = 28; 
$chck29.Checked = $true; 
$chck29.Font = $Font;
$panel1.controls.add($chck29); 
$chck29.add_MouseHover({
$tooltip29 = New-Object System.Windows.Forms.ToolTip
$tooltip29.SetToolTip($chck29, 'Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit')
})
$chck29.add_click({count_p})
$chck30 = New-Object Windows.Forms.Checkbox; 
$chck30.Location = New-Object Drawing.Point 285,355; 
$chck30.Size = New-Object Drawing.Point 270,25; 
$chck30.Text = 'Defragment Indexing Service File'; 
$chck30.TabIndex = 29; 
$chck30.Checked = $true; 
$chck30.Font = $Font;
$panel1.controls.add($chck30); 
$chck30.add_MouseHover({
$tooltip30 = New-Object System.Windows.Forms.ToolTip
$tooltip30.SetToolTip($chck30, 'Defragmenting the Indexing Service database file')
}) 
$chck30.add_click({count_p})
$chck66 = New-Object Windows.Forms.Checkbox; 
$chck66.Location = New-Object Drawing.Point 10,100; 
$chck66.Size = New-Object Drawing.Point 270,25; 
$chck66.Text = 'Disable Spectre/Meltdown Protection'; 
$chck66.TabIndex = 65; 
$chck66.Checked = $false; 
$chck66.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($expercolor)
$chck66.Font = $Font;
$groupBox5.controls.add($chck66); 
$chck66.add_MouseHover({
$tooltip66 = New-Object System.Windows.Forms.ToolTip
$tooltip66.SetToolTip($chck66, 'These are important secure patches although it decrease system performance.')
})



$chck31 = New-Object Windows.Forms.Checkbox; 
$chck31.Location = New-Object Drawing.Point 0,5; 
$chck31.Size = New-Object Drawing.Point 270,25; 
$chck31.Text = 'Disable Telemetry Scheduled Tasks'; 
$chck31.TabIndex = 30; 
$chck31.Checked = $true; 
$chck31.Font = $Font;
$panel2.controls.add($chck31); 
$chck31.add_click({count_s})
$chck32 = New-Object Windows.Forms.Checkbox; 
$chck32.Location = New-Object Drawing.Point 0,30; 
$chck32.Size = New-Object Drawing.Point 270,25; 
$chck32.Text = 'Remove Telemetry/Data Collection'; 
$chck32.TabIndex = 31; 
$chck32.Checked = $true; 
$chck32.Font = $Font;
$panel2.controls.add($chck32); 
$chck32.add_click({count_s})
$chck33 = New-Object Windows.Forms.Checkbox; 
$chck33.Location = New-Object Drawing.Point 0,55; 
$chck33.Size = New-Object Drawing.Point 270,25; 
$chck33.Text = 'Disable PowerShell Telemetry'; 
$chck33.TabIndex = 32; 
$chck33.Checked = $true; 
$chck33.Font = $Font;
$panel2.controls.add($chck33); 
$chck33.add_click({count_s})
$chck34 = New-Object Windows.Forms.Checkbox; 
$chck34.Location = New-Object Drawing.Point 0,80; 
$chck34.Size = New-Object Drawing.Point 270,25; 
$chck34.Text = 'Disable Skype Telemetry'; 
$chck34.TabIndex = 33; 
$chck34.Checked = $true; 
$chck34.Font = $Font;
$panel2.controls.add($chck34); 
$chck34.add_click({count_s})
$chck35 = New-Object Windows.Forms.Checkbox; 
$chck35.Location = New-Object Drawing.Point 0,105; 
$chck35.Size = New-Object Drawing.Point 270,25; 
$chck35.Text = 'Disable Media Player Usage Reports'; 
$chck35.TabIndex = 34; 
$chck35.Checked = $true; 
$chck35.Font = $Font;
$panel2.controls.add($chck35); 
$chck35.add_click({count_s})
$chck36 = New-Object Windows.Forms.Checkbox; 
$chck36.Location = New-Object Drawing.Point 0,130; 
$chck36.Size = New-Object Drawing.Point 270,25; 
$chck36.Text = 'Disable Mozilla Telemetry'; 
$chck36.TabIndex = 35; 
$chck36.Checked = $true; 
$chck36.Font = $Font;
$panel2.controls.add($chck36); 
$chck36.add_click({count_s})
$chck37 = New-Object Windows.Forms.Checkbox; 
$chck37.Location = New-Object Drawing.Point 0,155; 
$chck37.Size = New-Object Drawing.Point 270,25; 
$chck37.Text = 'Disable Apps Use My Advertising ID'; 
$chck37.TabIndex = 36; 
$chck37.Checked = $true; 
$chck37.Font = $Font;
$panel2.controls.add($chck37); 
$chck37.add_click({count_s})
$chck38 = New-Object Windows.Forms.Checkbox; 
$chck38.Location = New-Object Drawing.Point 0,180; 
$chck38.Size = New-Object Drawing.Point 270,25; 
$chck38.Text = 'Disable Send Info About How I Write'; 
$chck38.TabIndex = 37; 
$chck38.Checked = $true; 
$chck38.Font = $Font;
$panel2.controls.add($chck38); 
$chck38.add_click({count_s})
$chck39 = New-Object Windows.Forms.Checkbox; 
$chck39.Location = New-Object Drawing.Point 0,205; 
$chck39.Size = New-Object Drawing.Point 270,25; 
$chck39.Text = 'Disable Handwriting Recognition'; 
$chck39.TabIndex = 38; 
$chck39.Checked = $true; 
$chck39.Font = $Font;
$panel2.controls.add($chck39); 
$chck39.add_click({count_s})
$chck40 = New-Object Windows.Forms.Checkbox; 
$chck40.Location = New-Object Drawing.Point 0,230; 
$chck40.Size = New-Object Drawing.Point 270,25; 
$chck40.Text = 'Disable Watson Malware Reports'; 
$chck40.TabIndex = 39; 
$chck40.Checked = $true; 
$chck40.Font = $Font;
$panel2.controls.add($chck40); 
$chck40.add_click({count_s})
$chck41 = New-Object Windows.Forms.Checkbox; 
$chck41.Location = New-Object Drawing.Point 0,255; 
$chck41.Size = New-Object Drawing.Point 270,25; 
$chck41.Text = 'Disable Malware Diagnostic Data'; 
$chck41.TabIndex = 40; 
$chck41.Checked = $true; 
$chck41.Font = $Font;
$panel2.controls.add($chck41); 
$chck41.add_click({count_s})
$chck42 = New-Object Windows.Forms.Checkbox; 
$chck42.Location = New-Object Drawing.Point 0,280; 
$chck42.Size = New-Object Drawing.Point 270,25; 
$chck42.Text = 'Disable Reporting to MS MAPS'; 
$chck42.TabIndex = 41; 
$chck42.Checked = $true; 
$chck42.Font = $Font;
$panel2.controls.add($chck42); 
$chck42.add_click({count_s})
$chck43 = New-Object Windows.Forms.Checkbox; 
$chck43.Location = New-Object Drawing.Point 0,305; 
$chck43.Size = New-Object Drawing.Point 270,25; 
$chck43.Text = 'Disable Spynet Defender Reporting'; 
$chck43.TabIndex = 42; 
$chck43.Checked = $true; 
$chck43.Font = $Font;
$panel2.controls.add($chck43); 
$chck43.add_click({count_s})
$chck44 = New-Object Windows.Forms.Checkbox; 
$chck44.Location = New-Object Drawing.Point 0,330; 
$chck44.Size = New-Object Drawing.Point 270,25; 
$chck44.Text = 'Do Not Send Malware Samples'; 
$chck44.TabIndex = 43; 
$chck44.Checked = $true; 
$chck44.Font = $Font;
$panel2.controls.add($chck44); 
$chck44.add_click({count_s})
$chck45 = New-Object Windows.Forms.Checkbox; 
$chck45.Location = New-Object Drawing.Point 0,355; 
$chck45.Size = New-Object Drawing.Point 270,25; 
$chck45.Text = 'Disable Sending Typing Samples'; 
$chck45.TabIndex = 44; 
$chck45.Checked = $true; 
$chck45.Font = $Font;
$panel2.controls.add($chck45); 
$chck45.add_click({count_s})
$chck46 = New-Object Windows.Forms.Checkbox; 
$chck46.Location = New-Object Drawing.Point 0,380; 
$chck46.Size = New-Object Drawing.Point 270,25; 
$chck46.Text = 'Disable Sending Contacts to MS'; 
$chck46.TabIndex = 45; 
$chck46.Checked = $true; 
$chck46.Font = $Font;
$panel2.controls.add($chck46); 
$chck46.add_click({count_s})
$chck47 = New-Object Windows.Forms.Checkbox; 
$chck47.Location = New-Object Drawing.Point 0,405; 
$chck47.Size = New-Object Drawing.Point 270,25; 
$chck47.Text = 'Disable Cortana'; 
$chck47.TabIndex = 46; 
$chck47.Checked = $true; 
$chck47.Font = $Font;
$panel2.controls.add($chck47); 
$chck47.add_click({count_s})
$chck48 = New-Object Windows.Forms.Checkbox; 
$chck48.Location = New-Object Drawing.Point 0,5; 
$chck48.Size = New-Object Drawing.Point 270,25; 
$chck48.Text = 'Show File Extensions in Explorer'; 
$chck48.TabIndex = 47; 
$chck48.Checked = $true; 
$chck48.Font = $Font;
$panel3.controls.add($chck48); 
$chck48.add_click({count_v})
$chck49 = New-Object Windows.Forms.Checkbox; 
$chck49.Location = New-Object Drawing.Point 0,30; 
$chck49.Size = New-Object Drawing.Point 270,25; 
$chck49.Text = 'Disable Transparency on Taskbar'; 
$chck49.TabIndex = 48; 
$chck49.Checked = $true; 
$chck49.Font = $Font;
$panel3.controls.add($chck49); 
$chck49.add_click({count_v})
$chck50 = New-Object Windows.Forms.Checkbox; 
$chck50.Location = New-Object Drawing.Point 0,55; 
$chck50.Size = New-Object Drawing.Point 270,25; 
$chck50.Text = 'Disable Windows Animations'; 
$chck50.TabIndex = 49; 
$chck50.Checked = $true; 
$chck50.Font = $Font;
$panel3.controls.add($chck50); 
$chck50.add_click({count_v})
$chck51 = New-Object Windows.Forms.Checkbox; 
$chck51.Location = New-Object Drawing.Point 0,80; 
$chck51.Size = New-Object Drawing.Point 270,25; 
$chck51.Text = 'Disable MRU lists (jump lists)'; 
$chck51.TabIndex = 50; 
$chck51.Checked = $true; 
$chck51.Font = $Font;
$panel3.controls.add($chck51); 
$chck51.add_click({count_v})
$chck52 = New-Object Windows.Forms.Checkbox; 
$chck52.Location = New-Object Drawing.Point 0,105; 
$chck52.Size = New-Object Drawing.Point 270,25; 
$chck52.Text = 'Set Search Box to Icon Only'; 
$chck52.TabIndex = 51; 
$chck52.Checked = $true; 
$chck52.Font = $Font;
$panel3.controls.add($chck52);
$chck52.add_click({count_v})
$chck53 = New-Object Windows.Forms.Checkbox; 
$chck53.Location = New-Object Drawing.Point 0,130; 
$chck53.Size = New-Object Drawing.Point 270,25; 
$chck53.Text = 'Explorer on Start on This PC'; 
$chck53.TabIndex = 52; 
$chck53.Checked = $true; 
$chck53.Font = $Font;
$panel3.controls.add($chck53); 
$chck53.add_click({count_v})
$chck54 = New-Object Windows.Forms.Checkbox; 
$chck54.Location = New-Object Drawing.Point 0,05; 
$chck54.Size = New-Object Drawing.Point 250,25; 
$chck54.Text = 'Remove Windows Game Bar/DVR'; 
$chck54.TabIndex = 53; 
$chck54.Checked = $true; 
$chck54.Font = $Font;
$panel4.controls.add($chck54);  
$chck54.add_click({count_o})
$chck55 = New-Object Windows.Forms.Checkbox; 
$chck55.Location = New-Object Drawing.Point 0,405; 
$chck55.Size = New-Object Drawing.Point 270,25; 
$chck55.Text = 'Enable Service Tweaks'; 
$chck55.TabIndex = 54; 
$chck55.Checked = $true; 
$chck55.Font = $Font;
$panel1.controls.add($chck55); 
$chck55.add_MouseHover({
$tooltip55 = New-Object System.Windows.Forms.ToolTip
$tooltip55.SetToolTip($chck55, 'More details on github.com/semazurek ')
})
$chck55.add_click({count_p})
$chck56 = New-Object Windows.Forms.Checkbox; 
$chck56.Location = New-Object Drawing.Point 285,380; 
$chck56.Size = New-Object Drawing.Point 270,25; 
$chck56.Text = 'Remove Bloatware (Preinstalled)'; 
$chck56.TabIndex = 55; 
$chck56.Checked = $true; 
$chck56.Font = $Font;
$panel1.controls.add($chck56);
$chck56.add_MouseHover({
$tooltip56 = New-Object System.Windows.Forms.ToolTip
$tooltip56.SetToolTip($chck56, 'More details on github.com/semazurek ')
})
$chck56.add_click({count_p})
$chck57 = New-Object Windows.Forms.Checkbox; 
$chck57.Location = New-Object Drawing.Point 285,405; 
$chck57.Size = New-Object Drawing.Point 270,25; 
$chck57.Text = 'Disable Unnecessary Startup Apps'; 
$chck57.TabIndex = 56; 
$chck57.Checked = $true; 
$chck57.Font = $Font;
$panel1.controls.add($chck57); 
$chck57.add_MouseHover({
$tooltip57 = New-Object System.Windows.Forms.ToolTip
$tooltip57.SetToolTip($chck57, "Java Update Checker x64 `n Mini Partition Tool Wizard Updater `n Teams Machine Installer `n Cisco Meeting Daemon `n Adobe Reader Speed Launcher `n CCleaner Smart Cleaning/Monitor `n Spotify Web Helper `n Gaijin.Net Updater `n Microsoft Teams Update `n Google Update `n Microsoft Edge Update `n BitTorrent Bleep `n Skype `n Adobe Update Startup Utility `n iTunes Helper `n CyberLink Update Utility `n MSI Live Update `n Wondershare Helper Compact `n Cisco AnyConnect Secure Mobility Agent `n Wargaming.net Game Center `n Skype for Desktop `n Gog Galaxy `n Epic Games Launcher `n Origin `n Steam `n Opera Browser Assistant `n uTorrent `n Skype for Business `n Google Chrome Installer `n Microsoft Edge Installer `n Discord Update `n Blitz")
})
$chck57.add_click({count_p})
$chck58 = New-Object Windows.Forms.Checkbox; 
$chck58.Location = New-Object Drawing.Point 0,30; 
$chck58.Size = New-Object Drawing.Point 250,25; 
$chck58.Text = 'Clean Temp/Cache/Prefetch/Logs'; 
$chck58.TabIndex = 57; 
$chck58.Checked = $true; 
$chck58.Font = $Font;
$panel4.controls.add($chck58); 
$chck58.add_click({count_o})
$chck59 = New-Object Windows.Forms.Checkbox; 
$chck59.Location = New-Object Drawing.Point 0,130; 
$chck59.Size = New-Object Drawing.Point 250,25; 
$chck59.Text = 'Remove News and Interests/Widgets'; 
$chck59.TabIndex = 58; 
$chck59.Checked = $false; 
$chck59.Font = $Font;
$panel4.controls.add($chck59); 
$chck59.add_click({count_o})
$chck60 = New-Object Windows.Forms.Checkbox; 
$chck60.Location = New-Object Drawing.Point 10,75; 
$chck60.Size = New-Object Drawing.Point 270,25; 
$chck60.Text = 'Remove Microsoft OneDrive'; 
$chck60.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($expercolor)
$chck60.TabIndex = 59; 
$chck60.Checked = $false; 
$chck60.Font = $Font;
$groupBox5.controls.add($chck60); 
$chck61 = New-Object Windows.Forms.Checkbox; 
$chck61.Location = New-Object Drawing.Point 10,25; 
$chck61.Size = New-Object Drawing.Point 270,25; 
$chck61.Text = 'Disable Xbox Services'; 
$chck61.TabIndex = 60; 
$chck61.Checked = $false;
$chck61.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($expercolor) 
$chck61.Font = $Font;
$groupBox5.controls.add($chck61); 
$chck62 = New-Object Windows.Forms.Checkbox; 
$chck62.Location = New-Object Drawing.Point 10,50; 
$chck62.Size = New-Object Drawing.Point 270,25; 
$chck62.Text = 'Enable Fast/Secure DNS (1.1.1.1)'; 
$chck62.TabIndex = 61; 
$chck62.Checked = $false; 
$chck62.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($expercolor)
$chck62.Font = $Font;
$groupBox5.controls.add($chck62); 
$chck63 = New-Object Windows.Forms.Checkbox; 
$chck63.Location = New-Object Drawing.Point 0,80; 
$chck63.Size = New-Object Drawing.Point 250,25; 
$chck63.Text = 'Scan for Adware (AdwCleaner)'; 
$chck63.TabIndex = 62; 
$chck63.Checked = $false; 
$chck63.Font = $Font;
$panel4.controls.add($chck63); 
$chck63.add_click({count_o})

$chck68 = New-Object Windows.Forms.Checkbox; 
$chck68.Location = New-Object Drawing.Point 0,105; 
$chck68.Size = New-Object Drawing.Point 250,25; 
$chck68.Text = 'Clean WinSxS Folder'; 
$chck68.TabIndex = 67; 
$chck68.Checked = $false;
$chck68.Font = $Font;
$panel4.controls.add($chck68); 
$chck68.add_click({count_o})
$chck3 = New-Object Windows.Forms.Checkbox; 
$chck3.Location = New-Object Drawing.Point 0,55;
$chck3.Size = New-Object Drawing.Point 250,25; 
$chck3.Text = 'Split Threshold for Svchost'; 
$chck3.TabIndex = 2; 
$chck3.Checked = $true;
$chck3.Font = $Font;
$panel4.controls.add($chck3); 
$chck3.add_click({count_o})
count_p;
count_v;
count_s;
count_o;

function About {
$aboutForm = New-Object System.Windows.Forms.Form; 
$aboutFormExit = New-Object System.Windows.Forms.Button; 
$aboutFormNameLabel = New-Object System.Windows.Forms.Label; 
$aboutFormText = New-Object System.Windows.Forms.Label; 
$aboutFormText2 = New-Object System.Windows.Forms.Label; 
$aboutForm.MinimizeBox = $false; 
$aboutForm.MaximizeBox = $false; 
$aboutForm.TopMost = $true; 
$aboutForm.FlatStyle = 'Flat'
$aboutForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor)
$aboutForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$aboutForm.AutoSizeMode = 'GrowAndShrink'; 
$aboutForm.FormBorderStyle = 'FixedDialog'; 
$aboutForm.AcceptButton = $aboutFormExit; 
$aboutForm.CancelButton = $aboutFormExit; 
$aboutForm.ClientSize = '350, 110'; 
$aboutForm.ControlBox = $false; 
$aboutForm.ShowInTaskBar = $false; 
$aboutForm.StartPosition = 'CenterParent'; 
$aboutForm.Text = 'About'; 
$aboutForm.Add_Load($aboutForm_Load); 
$aboutFormNameLabel.Font = New-Object Drawing.Font('Consolas', 9, [System.Drawing.FontStyle]::Bold); 
$aboutFormNameLabel.Location = '110, 10'; 
$aboutFormNameLabel.Size = '200, 18'; 
$aboutFormNameLabel.Text = '   Pngu Optimizer'; 
$aboutForm.Controls.Add($aboutFormNameLabel); 
$aboutFormText.Location = '100, 30'; 
$aboutFormText.Size = '300, 20'; $aboutFormText.Text = '         '; 
$aboutForm.Controls.Add($aboutFormText); 
$aboutFormText2.Location = '100, 50'; 
$aboutFormText2.Size = '300, 20';  
$aboutFormText2.Text = '      GitHub.com/ThatzPingu'; 
$aboutForm.Controls.Add($aboutFormText2); 
$aboutFormExit.Location = '138, 75'; 
$aboutFormExit.Text = 'OK'; 
$aboutFormExit.FlatStyle = 'Flat'
$aboutForm.Icon = [System.Drawing.Icon]::FromHandle((new-object System.Drawing.Bitmap -argument $ims).GetHIcon())
$aboutForm.Controls.Add($aboutFormExit); 
[void]$aboutForm.ShowDialog()
}; 
function Extras {
$extraForm = New-Object System.Windows.Forms.Form; 
$extraFormB1 = New-Object System.Windows.Forms.Button; 
$extraFormB2 = New-Object System.Windows.Forms.Button; 
$extraFormB3 = New-Object System.Windows.Forms.Button; 
$extraFormB4 = New-Object System.Windows.Forms.Button; 
$extraFormB5 = New-Object System.Windows.Forms.Button; 
$extraFormB6 = New-Object System.Windows.Forms.Button; 
$extraFormB7 = New-Object System.Windows.Forms.Button; 
$extraFormB8 = New-Object System.Windows.Forms.Button; 
$extraFormB9 = New-Object System.Windows.Forms.Button; 
$extraFormB10 = New-Object System.Windows.Forms.Button; 
$extraFormB11 = New-Object System.Windows.Forms.Button; 
$extraFormB12 = New-Object System.Windows.Forms.Button; 
$extraFormB13 = New-Object System.Windows.Forms.Button; 
$extraFormB14 = New-Object System.Windows.Forms.Button; 
$extraForm.MinimizeBox = $false; 
$extraForm.MaximizeBox = $false; 
$extraForm.TopMost = $true; 
$extraForm.AutoSizeMode = 'GrowAndShrink'; 
$extraForm.FormBorderStyle = 'FixedDialog'; 
$extraForm.AcceptButton = $extraFormExit; 
$extraForm.CancelButton = $extraFormExit; 
$extraForm.ClientSize = '200, 450'; 
$extraForm.ShowInTaskBar = $false; 
$extraForm.FlatStyle = 'Flat'
$extraForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml($mainbackcolor)
$extraForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor)
$extraForm.Location = (30,30);
$extraForm.Text = 'Extras'; 
$extraForm.Font = $font;
$extraFormB1.Location = '25, 15'; 
$extraFormB1.Size = New-Object Drawing.Point 150,25;
$extraFormB1.Text = 'Disk Defragmenter'; 
$extraFormB1.add_click({dfrgui.exe});
$extraFormB1.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB1); 
$extraFormB1.add_MouseHover({
$tooltipEB1 = New-Object System.Windows.Forms.ToolTip
$tooltipEB1.SetToolTip($extraFormB1, 'Optimize your drives to help your computer run more efficienlty.')
})
$extraFormB2.Location = '25, 45'; 
$extraFormB2.Size = New-Object Drawing.Point 150,25;
$extraFormB2.Text = 'Cleanmgr'; 
$extraFormB2.add_click({cleanmgr.exe});
$extraFormB2.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB2); 
$extraFormB2.add_MouseHover({
$tooltipEB2 = New-Object System.Windows.Forms.ToolTip
$tooltipEB2.SetToolTip($extraFormB2, 'Clears unnecessary files from your computer hard disk.')
})
$extraFormB3.Location = '25, 75'; 
$extraFormB3.Size = New-Object Drawing.Point 150,25;
$extraFormB3.Text = 'Msconfig'; 
$extraFormB3.add_click({msconfig});
$extraFormB3.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB3); 
$extraFormB3.add_MouseHover({
$tooltipEB3 = New-Object System.Windows.Forms.ToolTip
$tooltipEB3.SetToolTip($extraFormB3, 'Utility designed to troubleshoot and configure Windows startup process.')
})
$extraFormB4.Location = '25, 105'; 
$extraFormB4.Size = New-Object Drawing.Point 150,25;
$extraFormB4.Text = 'Control Panel'; 
$extraFormB4.add_click({control.exe});
$extraFormB4.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB4); 
$extraFormB5.Location = '25, 135'; 
$extraFormB5.Size = New-Object Drawing.Point 150,25;
$extraFormB5.Text = 'Device Manager'; 
$extraFormB5.add_click({devmgmt.msc});
$extraFormB5.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB5); 
$extraFormB6.Location = '25, 165'; 
$extraFormB6.Size = New-Object Drawing.Point 150,25;
$extraFormB6.Text = 'UAC Settings'; 
$extraFormB6.add_click({UserAccountControlSettings.exe});
$extraFormB6.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB6); 
$extraFormB7.Location = '25, 195'; 
$extraFormB7.Size = New-Object Drawing.Point 150,25;
$extraFormB7.Text = 'Msinfo32'; 
$extraFormB7.add_click({msinfo32});
$extraFormB7.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB7); 
$extraFormB7.add_MouseHover({
$tooltipEB7 = New-Object System.Windows.Forms.ToolTip
$tooltipEB7.SetToolTip($extraFormB7, 'This tool gathers information about your computer.')
})
$extraFormB8.Location = '25, 225'; 
$extraFormB8.Size = New-Object Drawing.Point 150,25;
$extraFormB8.Text = 'Services'; 
$extraFormB8.add_click({services.msc});
$extraFormB8.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB8); 
$extraFormB9.Location = '25, 255'; 
$extraFormB9.Size = New-Object Drawing.Point 150,25;
$extraFormB9.Text = 'Remote Desktop'; 
$extraFormB9.add_click({mstsc});
$extraFormB9.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB9); 
$extraFormB10.Location = '25, 285'; 
$extraFormB10.Size = New-Object Drawing.Point 150,25;
$extraFormB10.Text = 'Event Viewer'; 
$extraFormB10.add_click({eventvwr.msc});
$extraFormB10.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB10); 
$extraFormB11.Location = '25, 315'; 
$extraFormB11.Size = New-Object Drawing.Point 150,25;
$extraFormB11.Text = 'Reset Network'; 
$extraFormB11.add_click({start C:\ProgramData\restart-network-settings.bat});
$extraFormB11.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB11); 
$extraFormB11.add_MouseHover({
$tooltipEB11 = New-Object System.Windows.Forms.ToolTip
$tooltipEB11.SetToolTip($extraFormB11, 'This option will reset any internet settings on your device.')
})
$extraFormB12.Location = '25, 345'; 
$extraFormB12.Size = New-Object Drawing.Point 150,25; 
$extraFormB12.Text = 'Update Applications (Winget)'; 
$extraFormB12.add_click({start C:\ProgramData\winget-et.bat}); 
$extraFormB12.FlatStyle = 'Flat' 
$extraForm.Controls.Add($extraFormB12); 
$extraFormB12.add_MouseHover({
$tooltipEB12 = New-Object System.Windows.Forms.ToolTip
$tooltipEB12.SetToolTip($extraFormB12, 'Update Applications (winget upgrade --all)')
})
$extraFormB13.Location = '25, 375'; 
$extraFormB13.Size = New-Object Drawing.Point 150,25; 
$extraFormB13.Text = 'Windows License Key';
$extraFormB13.add_click({echo Windows_License_Key: $licensekey > C:\ProgramData\verwin.txt;start notepad C:\ProgramData\verwin.txt}); 
$extraFormB13.FlatStyle = 'Flat' 
$extraForm.Controls.Add($extraFormB13); 
$extraFormB14.Location = '25, 405'; 
$extraFormB14.Size = New-Object Drawing.Point 150,25; 
$extraFormB14.Text = 'Reboot to BIOS';
$extraFormB14.add_click({shutdown /r /fw /t 1}); 
$extraFormB14.FlatStyle = 'Flat' 
$extraForm.Controls.Add($extraFormB14);
[void]$extraForm.ShowDialog()
}; 
function addMenuItem { param([ref]$ParentItem, [string]$ItemName='', [string]$ItemText='', [scriptblock]$ScriptBlock=$null ) [System.Windows.Forms.ToolStripMenuItem]$private:menuItem=` New-Object System.Windows.Forms.ToolStripMenuItem;
$private:menuItem.Name =$ItemName; 
$private:menuItem.Text =$ItemText; 
if ($ScriptBlock -ne $null) { $private:menuItem.add_Click(([System.EventHandler]$handler=` $ScriptBlock));}; 
if (($ParentItem.Value) -is [System.Windows.Forms.MenuStrip]) { ($ParentItem.Value).Items.Add($private:menuItem);} return $private:menuItem; }; 
function Backup{[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 1) | Out-Null;Enable-ComputerRestore -Drive C:; Checkpoint-Computer -Description "Pngu-RestorePoint" -RestorePointType "MODIFY_SETTINGS"; [Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0) | Out-Null}; 
[System.Windows.Forms.MenuStrip]$mainMenu=New-Object System.Windows.Forms.MenuStrip; $form.Controls.Add($mainMenu); 
$mainMenu.BackColor = [System.Drawing.ColorTranslator]::FromHtml($menubackcolor);
$mainMenu.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($mainforecolor);
[scriptblock]$exit= {$form.Close()}; 
[scriptblock]$backup= {Backup}; 
[scriptblock]$restore= {rstrui.exe}; 
[scriptblock]$about= {About}; 
[scriptblock]$donate= {start https://www.paypal.com/paypalme/rikey}; 
[scriptblock]$extras= {Extras}; 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Backup' -ScriptBlock $backup); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Restore' -ScriptBlock $restore); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Extras' -ScriptBlock $extras);
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'About' -ScriptBlock $about);  
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Donate' -ScriptBlock $donate);  
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Exit' -ScriptBlock $exit); 

# Hello World
cls
$versionShort = $versionRAW.substring(9)
Write-Host '';Write-Host '';Write-Host '';Write-Host '';
Write-Host '                            ___                '         
Write-Host '                           / _ \___  ___ ___ __'
Write-Host '                          / ___/ _ \/ _ `/ // /'
Write-Host '                         /_/  /_//_/\_, /\_,_/ '
Write-Host '                                   /___/       '
Write-Host ''
Write-Host '                          [-] Created by: pngu                      '
Write-Host ''
Write-Host '                        - Always have a backup plan. - '
Write-Host '';Write-Host '';Write-Host '';Write-Host '';Write-Host ''
Write-Output "The script has already been initialized once" > $Env:programdata\Run-ET.log
[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0) | Out-Null
$form.ShowDialog();

# Counter of tasks
$counter=1
# All options to use: 67
$alltodo = (Get-ChildItem -Path $Env:programdata\ET\ | Measure-Object).Count

# VisualTweaks

function chck48 {
if (Test-Path $Env:programdata\ET\chck48.lbool) {Remove-Item $Env:programdata\ET\chck48.lbool}
:: Show file extensions in Explorer
$counter++;
Write-Host ' [Setting] Show file extensions in Explorer ' -F blue -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f | Out-Null
engine;
};

function chck49 {
if (Test-Path $Env:programdata\ET\chck49.lbool) {Remove-Item $Env:programdata\ET\chck49.lbool}
:: Disable Transparency in taskbar, menu start etc
$counter++;
Write-Host ' [Setting] Disable Transparency in taskbar/menu start ' -F blue -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f | Out-Null
engine;
};

function chck50 {
if (Test-Path $Env:programdata\ET\chck50.lbool) {Remove-Item $Env:programdata\ET\chck50.lbool}
::  Disable windows animations, menu Start animations.
$counter++;
Write-Host ' [Disable] Windows animations, menu Start animations ' -F darkgray -B black
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting  /t REG_DWORD /d 3 /f | Out-Null

REG ADD "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012078010000000 /f | Out-Null
REG ADD "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f | Out-Null

REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation" /v DefaultApplied  /t REG_DWORD /d 0 /f | Out-Null
engine;
};

function chck51 {
if (Test-Path $Env:programdata\ET\chck51.lbool) {Remove-Item $Env:programdata\ET\chck51.lbool}
# Disable MRU lists (jump lists) of XAML apps in Start Menu
$counter++;
Write-Host ' [Disable] MRU lists (jump lists) of XAML apps in Start Menu ' -F darkgray -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f | Out-Null
engine;
};

function chck52 {
if (Test-Path $Env:programdata\ET\chck52.lbool) {Remove-Item $Env:programdata\ET\chck52.lbool}
#  Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for 
# 0 = hide completely, 1 = show only icon, 2 = show long search box
$counter++;
Write-Host ' [Setting] Hide the search box from taskbar. ' -F blue -B black
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f | Out-Null
engine;
};

function chck53 {
if (Test-Path $Env:programdata\ET\chck53.lbool) {Remove-Item $Env:programdata\ET\chck53.lbool}
# Windows Explorer to start on This PC instead of Quick Access 
$counter++;
Write-Host ' [Setting] Windows Explorer to start on This PC instead of Quick Access ' -F blue -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f | Out-Null
engine;
};


# PerformanceTweaks

function chck1{
cmd /c if exist %programdata%\ET\chck1.lbool del %programdata%\ET\chck1.lbool
# Disable Edge WebWidget
$counter++;
Write-Host ' [Disable] Edge WebWidget ' -F darkgray -B black
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v WebWidgetAllowed /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck2{
cmd /c if exist %programdata%\ET\chck2.lbool del %programdata%\ET\chck2.lbool
# Setting power option to high/ultimate performance
$counter++;
Write-Host ' [Setting] Power option to ultimate performance ' -F blue -B black
cmd /c powercfg -setactive scheme_min | Out-Null
cmd /c powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
cmd /c powercfg /S ceb6bfc7-d55c-4d56-ae37-ff264aade12d | Out-Null
cmd /c powercfg /X standby-timeout-ac 0 | Out-Null
cmd /c powercfg /X standby-timeout-dc 0 | Out-Null

powercfg -setactive scheme_min | Out-Null
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
powercfg /S ceb6bfc7-d55c-4d56-ae37-ff264aade12d | Out-Null
powercfg /X standby-timeout-ac 0 | Out-Null
powercfg /X standby-timeout-dc 0 | Out-Null

engine;};

function chck4{
cmd /c if exist %programdata%\ET\chck4.lbool del %programdata%\ET\chck4.lbool
# Dual boot timeout 3sec
$counter++;
Write-Host ' [Setting] Dual boot timeout 3sec ' -F blue -B black
bcdedit /set timeout 3 | Out-Null
bcdedit /timeout 3 | Out-Null
engine;};

function chck5{
cmd /c if exist %programdata%\ET\chck5.lbool del %programdata%\ET\chck5.lbool
# Disable Hibernation/Fast startup in Windows to free RAM from "C:\hiberfil.sys"
$counter++;
Write-Host ' [Disable] Hibernation/Fast startup in Windows ' -F darkgray -B black
powercfg -hibernate off | Out-Null
engine;};

function chck6{
cmd /c if exist %programdata%\ET\chck6.lbool del %programdata%\ET\chck6.lbool
# Disable windows insider experiments
$counter++;
Write-Host ' [Disable] Windows Insider experiments ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t "REG_DWORD" /d "0" /f | Out-Null
engine;};

function chck7{
cmd /c if exist %programdata%\ET\chck7.lbool del %programdata%\ET\chck7.lbool
# Disable app launch tracking
$counter++;
Write-Host ' [Disable] App launch tracking ' -F darkgray -B black
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /d "0" /t REG_DWORD /f | Out-Null
engine;};

function chck8{
cmd /c if exist %programdata%\ET\chck8.lbool del %programdata%\ET\chck8.lbool
# Disable powerthrottling (Intel 6gen and higher)
$counter++;
Write-Host ' [Disable] Powerthrottling (Intel 6gen and higher) ' -F darkgray -B black
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f | Out-Null
engine;};

function chck9{
cmd /c if exist %programdata%\ET\chck9.lbool del %programdata%\ET\chck9.lbool
# Turn Off Background Apps
$counter++;
Write-Host ' [Setting] Turn Off Background Apps ' -F blue -B black
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled  /t REG_DWORD /d 1 /f | Out-Null
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck10{
cmd /c if exist %programdata%\ET\chck10.lbool del %programdata%\ET\chck10.lbool
# Disable Sticky Keys prompt
$counter++;
Write-Host ' [Disable] Sticky Keys prompt ' -F darkgray -B black
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d 506 /f | Out-Null
engine;};

function chck11{
cmd /c if exist %programdata%\ET\chck11.lbool del %programdata%\ET\chck11.lbool
# Disable Activity History
$counter++;
Write-Host ' [Disable] Activity History ' -F darkgray -B black
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck12{
cmd /c if exist %programdata%\ET\chck12.lbool del %programdata%\ET\chck12.lbool
# Disable Automatic Updates for Microsoft Store apps
$counter++;
Write-Host ' [Disable] Automatic Updates for Microsoft Store apps ' -F darkgray -B black
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f | Out-Null
engine;};

function chck13{
cmd /c if exist %programdata%\ET\chck13.lbool del %programdata%\ET\chck13.lbool
# SmartScreen Filter for Store Apps: Disable
$counter++;
Write-Host ' [Disable] SmartScreen Filter for Store Apps ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck14{
cmd /c if exist %programdata%\ET\chck14.lbool del %programdata%\ET\chck14.lbool
# Let websites provide locally...
$counter++;
Write-Host ' [Setting] Let websites provide locally ' -F blue -B black
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f | Out-Null
engine;};

function chck15{
cmd /c if exist %programdata%\ET\chck15.lbool del %programdata%\ET\chck15.lbool
# Microsoft Edge settings
$counter++;
Write-Host ' [Setting] Microsoft Edge settings for privacy ' -F blue -B black
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v DoNotTrack /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" /v ShowSearchSuggestionsGlobal /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" /v FPEnabled /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck64{
cmd /c if exist %programdata%\ET\chck64.lbool del %programdata%\ET\chck64.lbool
#	Disable Nagle's Algorithm (Delayed ACKs)
$counter++;
Write-Host ' [Disable] Nagle''s Algorithm (Delayed ACKs) ' -F darkgray -B black
$errpref = $ErrorActionPreference 
#save actual preference
$ErrorActionPreference = "silentlycontinue"
$NetworkIDS = @(
(Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\*").PSChildName
)
foreach ($NetworkID in $NetworkIDS) {
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$NetworkID" -Name "TcpAckFrequency" -Type DWord -Value 1
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$NetworkID" -Name "TCPNoDelay" -Type DWord -Value 1
}
$ErrorActionPreference = $errpref 
#restore previous preference
engine;};

function chck65{
cmd /c if exist %programdata%\ET\chck65.lbool del %programdata%\ET\chck65.lbool
#CPU Tweaks
$counter++;
Write-Host ' [Setting] CPU Priority Tweaks ' -F blue -B black

# Thread Priority
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\usbxhci\Parameters" /v ThreadPriority /t REG_DWORD /d 31 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v ThreadPriority /t REG_DWORD /d 31 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" /v ThreadPriority /t REG_DWORD /d 31 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v ThreadPriority /t REG_DWORD /d 31 /f | Out-Null

#All Logical Cores Enabled
$NOLP = wmic cpu get NumberOfLogicalProcessors | findstr /r "[0-9]"

cmd /c "bcdedit /set {current} numproc $NOLP" | Out-Null

# AMD/Intel CPU Priority
if (wmic cpu get name | findstr /r "Intel") {

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Affinity /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f | Out-Null
}
else
{
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f | Out-Null
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f | Out-Null
}
engine;};

function chck66{
cmd /c if exist %programdata%\ET\chck66.lbool del %programdata%\ET\chck66.lbool
#	Disable Spectre/Meltdown Protection
$counter++;
Write-Host ' [Disable] Spectre/Meltdown Protection' -F darkgray -B black
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f | Out-Null
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f | Out-Null
engine;};

function chck16{
cmd /c if exist %programdata%\ET\chck16.lbool del %programdata%\ET\chck16.lbool
# Disable location sensor
$counter++;
Write-Host ' [Disable] Location sensor ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck17{
cmd /c if exist %programdata%\ET\chck17.lbool del %programdata%\ET\chck17.lbool
# WiFi Sense: HotSpot Sharing: Disable
$counter++;
Write-Host ' [Disable] WiFi Sense: HotSpot Sharing ' -F darkgray -B black
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck18{
cmd /c if exist %programdata%\ET\chck18.lbool del %programdata%\ET\chck18.lbool
# WiFi Sense: Shared HotSpot Auto-Connect: Disable
$counter++;
Write-Host ' [Disable] WiFi Sense: Shared HotSpot Auto-Connect ' -F darkgray -B black
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck19{
cmd /c if exist %programdata%\ET\chck19.lbool del %programdata%\ET\chck19.lbool
# Change Windows Updates to "Notify to schedule restart"
$counter++;
Write-Host ' [Setting] Windows Updates to Notify to schedule restart ' -F blue -B black
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f | Out-Null
engine;};

function chck20{
cmd /c if exist %programdata%\ET\chck20.lbool del %programdata%\ET\chck20.lbool
# Disable P2P Update downloads outside of local network
$counter++;
Write-Host ' [Disable] P2P Update downloads outside of local network ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck21{
cmd /c if exist %programdata%\ET\chck21.lbool del %programdata%\ET\chck21.lbool
# Setting Lower Shutdown time
$counter++;
Write-Host ' [Setting] Lower Shutdown time ' -F blue -B black
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f | Out-Null
engine;};

function chck22{
cmd /c if exist %programdata%\ET\chck22.lbool del %programdata%\ET\chck22.lbool
# Remove Old Device Drivers
$counter++;
Write-Host ' [Remove] Old Device Drivers ' -F red -B black
SET DEVMGR_SHOW_NONPRESENT_DEVICES=1
engine;};

function chck23{
cmd /c if exist %programdata%\ET\chck23.lbool del %programdata%\ET\chck23.lbool
# Disable Get Even More Out of Windows Screen /W10
$counter++;
Write-Host ' [Disable] Get Even More Out of Windows Screen ' -F darkgray -B black
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck24{
cmd /c if exist %programdata%\ET\chck24.lbool del %programdata%\ET\chck24.lbool
# Disable automatically installing suggested apps /W10
$counter++;
Write-Host ' [Disable] Automatically installing suggested apps ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKLM\Software\Policies\Microsoft\PushToInstall" /v "DisablePushToInstall" /t REG_DWORD /d "1" /f | Out-Null
cmd /c reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" /f >NUL 2>nul
cmd /c reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f >NUL 2>nul
engine;};

function chck25{
cmd /c if exist %programdata%\ET\chck25.lbool del %programdata%\ET\chck25.lbool
# Disable Start Menu Ads/Suggestions /W10
$counter++;
Write-Host ' [Disable] Start Menu Ads/Suggestions ' -F darkgray -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck26{
cmd /c if exist %programdata%\ET\chck26.lbool del %programdata%\ET\chck26.lbool
# Disable Allowing Suggested Apps In WindowsInk Workspace
$counter++;
Write-Host ' [Disable] Allowing Suggested Apps In WindowsInk Workspace ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WindowsInkWorkspace\AllowSuggestedAppsInWindowsInkWorkspace" /v "value" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck27{
cmd /c if exist %programdata%\ET\chck27.lbool del %programdata%\ET\chck27.lbool
# Disables several unnecessary components
$counter++;
Write-Host ' [Disable] Unnecessary components ' -F darkgray -B black
$components = @('Printing-PrintToPDFServices-Features','Printing-XPSServices-Features','Xps-Foundation-Xps-Viewer')
foreach ($a in $components) {
disable-windowsoptionalfeature -online -featureName  -NoRestart | Out-Null
}
engine;};

function chck28{
cmd /c if exist %programdata%\ET\chck28.lbool del %programdata%\ET\chck28.lbool
# Setting Windows Defender Scheduled Scan from highest to normal privileges (CPU % high usage)
$counter++;
Write-Host ' [Setting] Windows Defender Scheduled Scan from highest to normal privileges ' -F blue -B black
cmd /c schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /RL LIMITED | Out-Null
engine;};

function chck29{
cmd /c if exist %programdata%\ET\chck29.lbool del %programdata%\ET\chck29.lbool
# Disabling Process Mitigation
# Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit
$counter++;
Write-Host ' [Disable] Process Mitigation ' -F darkgray -B black
Set-ProcessMitigation -System -Disable CFG
engine;};

function chck30{
cmd /c if exist %programdata%\ET\chck30.lbool del %programdata%\ET\chck30.lbool
# Defragmenting the File Indexing Service database file
$counter++;
Write-Host ' [Setting] Defragment Database Indexing Service File ' -F blue -B black 
net stop wsearch /y | Out-Null
esentutl /d C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb | Out-Null
net start wsearch | Out-Null
engine;};

#Telemetry

function chck31{
cmd /c if exist %programdata%\ET\chck31.lbool del %programdata%\ET\chck31.lbool
# SCHEDULED TASKS tweaks (Updates, Telemetry etc)
$counter++;
Write-Host ' [Disable] SCHEDULED TASKS tweaks (Updates, Telemetry etc) ' -F darkgray -B black
cmd /c schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvent" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /Disable | Out-Null
cmd /c schtasks /Change /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /Disable | Out-Null
cmd /c schtasks /Change /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable | Out-Null
cmd /c schtasks /Change /TN "NIUpdateServiceStartupTask" /Disable | Out-Null
cmd /c schtasks /Change /TN "CCleaner Update" /Disable | Out-Null
cmd /c schtasks /Change /TN "CCleanerSkipUAC - %username%" /Disable | Out-Null
cmd /c schtasks /Change /TN "Adobe Acrobat Update Task" /Disable | Out-Null
cmd /c schtasks /Change /TN "AMDLinkUpdate" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Office\Office Automatic Updates 2.0" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Office\Office Feature Updates" /Disable | Out-Null
cmd /c schtasks /Change /TN "Microsoft\Office\Office Feature Updates Logon" /Disable | Out-Null
cmd /c schtasks /Change /TN "GoogleUpdateTaskMachineCore" /Disable | Out-Null
cmd /c schtasks /Change /TN "GoogleUpdateTaskMachineUA" /Disable | Out-Null
schtasks /DELETE /TN "AMDInstallLauncher" /f | Out-Null
schtasks /DELETE /TN "AMDLinkUpdate" /f | Out-Null
schtasks /DELETE /TN "AMDRyzenMasterSDKTask" /f | Out-Null
schtasks /DELETE /TN "DUpdaterTask" /f | Out-Null
schtasks /DELETE /TN "ModifyLinkUpdate" /f | Out-Null
engine;};

function chck32{
cmd /c if exist %programdata%\ET\chck32.lbool del %programdata%\ET\chck32.lbool
# Remove Telemetry & Data Collection 
$counter++;
Write-Host ' [Disable] Telemetry/Data Collection ' -F darkgray -B black 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SYSTEM\ControlSet001\Services\dmwappushservice" /v "Start" /t REG_DWORD /d 4 /f | Out-Null
reg add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\17.0\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" /v "VerboseLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" /v "EnableCalendarLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\17.0\Word\Options" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" /v "EnableLogging" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\17.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" /v "Enabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\15.0\Common" /v "QMEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common" /v "QMEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Office\17.0\Common" /v "QMEnabled" /t REG_DWORD /d 0 /f | Out-Null
# VStudio Code Telemetry
cmd /c sc stop VSStandardCollectorService150 | Out-Null
cmd /c sc config VSStandardCollectorService150 start= disabled  | Out-Null
reg add "HKLM\Software\Wow6432Node\Microsoft\VSCommon\14.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Wow6432Node\Microsoft\VSCommon\15.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Wow6432Node\Microsoft\VSCommon\16.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Wow6432Node\Microsoft\VSCommon\17.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\VSCommon\14.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\VSCommon\15.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\VSCommon\16.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\VSCommon\17.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\Software\Microsoft\VisualStudio\Telemetry" /v "TurnOffSwitch" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\Software\Policies\Microsoft\VisualStudio\Feedback" /v "DisableFeedbackDialog" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\Software\Policies\Microsoft\VisualStudio\Feedback" /v "DisableEmailInput" /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\Software\Policies\Microsoft\VisualStudio\Feedback" /v "DisableScreenshotCapture" /t REG_DWORD /d 1 /f | Out-Null
# Chrome Software Reporter Tool
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "MetricsReportingEnabled" /t REG_SZ /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "ChromeCleanupEnabled" /t REG_SZ /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "ChromeCleanupReportingEnabled" /t REG_SZ /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "MetricsReportingEnabled" /t REG_SZ /d 0 /f | Out-Null
# CCleaner Health Check / Monitoring etc
cmd /c taskkill /f /im ccleaner.exe | Out-Null
cmd /c taskkill /f /im ccleaner64.exe | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "HomeScreen" /t REG_SZ /d 2 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "Monitoring" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "HelpImproveCCleaner" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "SystemMonitoring" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "UpdateAuto" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "UpdateCheck" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "CheckTrialOffer" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "(Cfg)HealthCheck" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "(Cfg)QuickClean" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "(Cfg)QuickCleanIpm" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "(Cfg)SoftwareUpdater" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Piriform\CCleaner" /v "(Cfg)SoftwareUpdaterIpm" /t REG_DWORD /d 0 /f | Out-Null

engine;};

function chck33{
cmd /c if exist %programdata%\ET\chck33.lbool del %programdata%\ET\chck33.lbool
# Disable PowerShell Telemetry
$counter++;
Write-Host ' [Disable] PowerShell Telemetry ' -F darkgray -B black
setx POWERSHELL_TELEMETRY_OPTOUT 1 | Out-Null
engine;};

function chck34{
cmd /c if exist %programdata%\ET\chck34.lbool del %programdata%\ET\chck34.lbool
# Disable Skype Telemetry
$counter++;
Write-Host ' [Disable] Skype Telemetry ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "TraceLevelThreshold" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype" /v "EnableTracing" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "EnableTracing" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype" /v "WPPFilePath" /t REG_SZ /d "%%SYSTEMDRIVE%%\TEMP\Tracing\WPPMedia" /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW" /v "WPPFilePath" /t REG_SZ /d "%%SYSTEMDRIVE%%\TEMP\WPPMedia" /f | Out-Null
engine;};

function chck35{
cmd /c if exist %programdata%\ET\chck35.lbool del %programdata%\ET\chck35.lbool
# Disable windows media player usage reports
$counter++;
Write-Host ' [Disable] Windows media player usage reports ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f | Out-Null
engine;};

function chck36{
cmd /c if exist %programdata%\ET\chck36.lbool del %programdata%\ET\chck36.lbool
# Disable mozilla telemetry
$counter++;
Write-Host ' [Disable] Mozilla telemetry ' -F darkgray -B black
reg add HKLM\SOFTWARE\Policies\Mozilla\Firefox /v "DisableTelemetry" /t REG_DWORD /d "2" /f | Out-Null
engine;};

function chck37{
cmd /c if exist %programdata%\ET\chck37.lbool del %programdata%\ET\chck37.lbool
# Settings -> Privacy -> General -> Let apps use my advertising ID...
$counter++;
Write-Host ' [Disable] Let apps use my advertising ID ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\AdvertisingInfo" /v "Value" /t REG_DWORD /d "0" /f | Out-Null
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f | Out-Null
engine;};

function chck38{
cmd /c if exist %programdata%\ET\chck38.lbool del %programdata%\ET\chck38.lbool
# Send Microsoft info about how I write to help us improve typing and writing in the future
$counter++;
Write-Host ' [Disable] Send Microsoft info about how I write ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck39{
cmd /c if exist %programdata%\ET\chck39.lbool del %programdata%\ET\chck39.lbool
# Handwriting recognition personalization
$counter++;
Write-Host ' [Disable] Handwriting recognition personalization ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f | Out-Null
engine;};

function chck40{
cmd /c if exist %programdata%\ET\chck40.lbool del %programdata%\ET\chck40.lbool
# Disable watson malware reports
$counter++;
Write-Host ' [Disable] Watson malware reports ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericReports" /t REG_DWORD /d "2" /f | Out-Null
engine;};

function chck41{
cmd /c if exist %programdata%\ET\chck41.lbool del %programdata%\ET\chck41.lbool
# Disable malware diagnostic data 
$counter++;
Write-Host ' [Disable] Malware diagnostic data ' -F darkgray -B black 
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "2" /f | Out-Null
engine;};

function chck42{
cmd /c if exist %programdata%\ET\chck42.lbool del %programdata%\ET\chck42.lbool
# Disable  setting override for reporting to Microsoft MAPS
$counter++;
Write-Host ' [Disable] Setting override for reporting to Microsoft MAPS ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck43{
cmd /c if exist %programdata%\ET\chck43.lbool del %programdata%\ET\chck43.lbool
# Disable spynet Defender reporting
$counter++;
Write-Host ' [Disable] Spynet Defender reporting ' -F darkgray -B black
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck44{
cmd /c if exist %programdata%\ET\chck44.lbool del %programdata%\ET\chck44.lbool
# Do not send malware samples for further analysis
$counter++;
Write-Host ' [Setting] Do not send malware samples for further analysis ' -F blue -B black
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f | Out-Null
engine;};

function chck45{
cmd /c if exist %programdata%\ET\chck45.lbool del %programdata%\ET\chck45.lbool
# Prevents sending speech, inking and typing samples to MS (so Cortana can learn to recognise you)
$counter++;
Write-Host ' [Disable] Sending speech, inking and typing samples to MS ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck46{
cmd /c if exist %programdata%\ET\chck46.lbool del %programdata%\ET\chck46.lbool
# Prevents sending contacts to MS (so Cortana can compare speech etc samples)
$counter++;
Write-Host ' [Disable] Sending contacts to MS ' -F darkgray -B black
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f | Out-Null
engine;};

function chck47{
cmd /c if exist %programdata%\ET\chck47.lbool del %programdata%\ET\chck47.lbool
# Immobilise Cortana 
$counter++;
Write-Host ' [Disable] Cortana ' -F darkgray -B black
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f | Out-Null
engine;};

#WindowsGameBar

function chck54{
cmd /c if exist %programdata%\ET\chck54.lbool del %programdata%\ET\chck54.lbool
# Removing Windows Game Bar 
$counter++;
Write-Host ' [Remove] Windows Game Bar ' -F red -B black
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f | Out-Null
Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage
Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage
Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage
engine;};

#RemoveWidgets

function chck59{
cmd /c if exist %programdata%\ET\chck59.lbool del %programdata%\ET\chck59.lbool
# Remove News and Interests/Widgets from Win 11 (even if not shown on taskbar, that takes RAM/CPU running in background)
$counter++;
Write-Host ' [Remove] News and Interests/Widgets' -F red -B black
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f | Out-Null

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f | Out-Null
winget uninstall "windows web experience pack" --accept-source-agreements | Out-Null

engine;};

#Services

function chck55{
cmd /c if exist %programdata%\ET\chck55.lbool del %programdata%\ET\chck55.lbool
# Disable
$counter++;
Write-Host ' [Setting] Services to: Disable Mode ' -F blue -B black
$toDisable = @('DiagTrack','diagnosticshub.standardcollector.service','dmwappushservice','RemoteRegistry','RemoteAccess','SCardSvr','SCPolicySvc','fax','WerSvc','NvTelemetryContainer','gadjservice','AdobeARMservice','PSI_SVC_2','lfsvc','WalletService','RetailDemo','SEMgrSvc','diagsvc','AJRouter','amdfendr','amdfendrmgr')
foreach ($b in $toDisable) {
   cmd /c sc stop $b | Out-Null
   cmd /c sc config $b start= disabled | Out-Null
}
#Disable Network Diagnostic Usage Service
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d 4 /f | Out-Null

# Manuall
Write-Host ' [Setting] Services to: Manuall Mode ' -F blue -B black
$toManuall = @('BITS','SamSs','TapiSrv','seclogon','wuauserv','PhoneSvc','lmhosts','iphlpsvc','gupdate','gupdatem','edgeupdate','edgeupdatem','MapsBroker','PnkBstrA','brave','bravem','asus','asusm','adobeupdateservice','adobeflashplayerupdatesvc','WSearch')
foreach ($c in $toManuall) {
   cmd /c sc config $c start= demand | Out-Null
}
engine;};

:Bloatware

function chck56{
cmd /c if exist %programdata%\ET\chck56.lbool del %programdata%\ET\chck56.lbool
# Remove Bloatware Apps (Preinstalled) 108 apps
Write-Host ' [Remove] Bloatware Apps ' -F red -B black
$counter++;
$listofbloatware = @('3DBuilder','Automate','Appconnector','Microsoft3DViewer','MicrosoftPowerBIForWindows','MicrosoftPowerBIForWindows','Print3D','XboxApp','GetHelp','WindowsFeedbackHub','BingFoodAndDrink','BingHealthAndFitness','BingTravel','WindowsReadingList','MixedReality.Portal','ScreenSketch','YourPhone','PicsArt-PhotoStudio','EclipseManager','PolarrPhotoEditorAcademicEdition','Wunderlist','LinkedInforWindows','AutodeskSketchBook','Twitter','DisneyMagicKingdoms','MarchofEmpires','ActiproSoftwareLLC','Plex','iHeartRadio','FarmVille2CountryEscape','Duolingo','CyberLinkMediaSuiteEssentials','DolbyAccess','DrawboardPDF','FitbitCoach','Flipboard','Asphalt8Airborne','Keeper','BingNews','COOKINGFEVER','PandoraMediaInc','CaesarsSlotsFreeCasino','Shazam','PhototasticCollage','TuneInRadio','WinZipUniversal','XING','RoyalRevolt2','CandyCrushSodaSaga','BubbleWitch3Saga','CandyCrushSaga','Getstarted','bing','MicrosoftOfficeHub','OneNote','WindowsPhone','SkypeApp','windowscommunicationsapps','WindowsMaps','Sway','CommsPhone','ConnectivityStore','Hotspot','Sketchable','Clipchamp','Prime','TikTok','ToDo','Family','NewVoiceNote','SamsungNotes','SamsungFlux','StudioPlus','SamsungWelcome','SamsungQuickSearch','SamsungPCCleaner','SamsungCloudBluetoothSync','PCGallery','OnlineSupportSService','HPJumpStarts','HPPCHardwareDiagnosticsWindows','HPPowerManager','HPPrivacySettings','HPSupportAssistant','HPSureShieldAI','HPSystemInformation','HPQuickDrop','HPWorkWell','myHP','HPDesktopSupportUtilities','HPQuickTouch','HPEasyClean','HPSystemInformation','MicrosoftTeams','ACGMediaPlayer','AdobePhotoshopExpress','HiddenCity','Hulu','Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe','Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe','MicrosoftSolitaireCollection','MicrosoftStickyNotes','Microsoft.People','Microsoft.Wallet','MinecraftUWP','Todos','Viber','bingsports')
foreach ($d in $listofbloatware) {

PowerShell -Command "Get-AppxPackage -allusers *$d* | Remove-AppxPackage" | Out-Null
}

engine;};

#StartUp

function chck57{
cmd /c if exist %programdata%\ET\chck57.lbool del %programdata%\ET\chck57.lbool
# Disabling unnecessary applications at startup
$counter++;
Write-Host ' [Disable] Unnecessary applications at startup ' -F darkgray -B black

# Java Update Checker x64
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "SunJavaUpdateSched" /f | Out-Null
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SunJavaUpdateSched" /f | Out-Null


# Mini Partition Tool Wizard Updater
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MTPW" /f | Out-Null

# Teams Machine Installer
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "TeamsMachineInstaller" /f | Out-Null
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TeamsMachineInstaller" /f | Out-Null


# Cisco Meeting Daemon
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CiscoMeetingDaemon" /f | Out-Null

# Adobe Reader Speed Launcher
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Adobe Reader Speed Launcher" /f | Out-Null
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Adobe Reader Speed Launcher" /f | Out-Null


# CCleaner Smart Cleaning/Monitor
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CCleaner Smart Cleaning" /f | Out-Null
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "CCleaner Monitor" /f | Out-Null

# Spotify Web Helper
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Spotify Web Helper" /f | Out-Null

# Gaijin.Net Updater
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Gaijin.Net Updater" /f | Out-Null

# Microsoft Teams Update
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "com.squirrel.Teams.Teams" /f | Out-Null

# Google Update
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Google Update" /f | Out-Null

# BitTorrent Bleep
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "BitTorrent Bleep" /f | Out-Null

# Skype
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Skype" /f | Out-Null

# Adobe Update Startup Utility
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "adobeAAMUpdater-1.0" /f | Out-Null
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "AdobeAAMUpdater" /f | Out-Null

# iTunes Helper
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "iTunesHelper" /f | Out-Null

# CyberLink Update Utility
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "UpdatePPShortCut" /f >NUL 2>nul

# MSI Live Update
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Live Update" /f | Out-Null
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "Live Update" /f | Out-Null


# Wondershare Helper Compact
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Wondershare Helper Compact" /f | Out-Null
cmd /c reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "Wondershare Helper Compact" /f | Out-Null


# Cisco AnyConnect Secure Mobility Agent
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Cisco AnyConnect Secure Mobility Agent for Windows" /f | Out-Null
cmd /c reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Cisco AnyConnect Secure Mobility Agent for Windows" /f | Out-Null


# Opera Browser Assistant (Update/Tray)
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Opera Browser Assistant" /f | Out-Null

# Steam Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Steam" /f | Out-Null

# Origin Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EADM" /f | Out-Null

# Epic Games Launcher Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "EpicGamesLauncher" /f | Out-Null

# Gog Galaxy Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "GogGalaxy" /f | Out-Null

# Skype for Desktop Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Skype for Desktop" /f | Out-Null

# Wargaming.net Game Center
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Wargaming.net Game Center" /f | Out-Null

# uTorrent Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "ut" /f | Out-Null

# Lync - Skype for Business Autorun
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Lync" /f | Out-Null

# Google Chrome Installer (Update)
cmd /c reg delete "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components" /v "Google Chrome" /f | Out-Null

# Microsoft Edge Installer (Update)
cmd /c reg delete "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components" /v "Microsoft Edge" /f | Out-Null
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch_E9C49D8E9BDC4095F482C844743B9E82" /f | Out-Null
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch_D3AB3F7FBB44621987441AECEC1156AD" /f | Out-Null
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f | Out-Null
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Microsoft Edge Update" /f | Out-Null
cmd /c reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch_31CF12C7FD715D87B15C2DF57BBF8D3E" /f | Out-Null

# Discord Update
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Discord" /f | Out-Null

# Ubisoft Game Launcher
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Ubisoft Game Launcher" /f | Out-Null

# Bliz - Autorun (League of Legends Tool)
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "com.blitz.app" /f | Out-Null

engine;};

#Cleaning

function chck58{
cmd /c if exist %programdata%\ET\chck58.lbool del %programdata%\ET\chck58.lbool
# TEMP/Logs/Cache/Prefetch/Updates Cleaning
$counter++;
Write-Host ' [Clean] Temp ' -F yellow -B black
Get-ChildItem -Path $env:TEMP -Include *.* -Exclude *.bat, *.lbool -File -Recurse | foreach { $_.Delete()} | Out-Null
cmd /c Del /S /F /Q %Windir%\Temp | Out-Null

Write-Host ' [Clean] Windows Prefetch/Cache/Logs ' -F yellow -B black
cmd /c Del /S /F /Q %windir%\Prefetch | Out-Null

cmd /c Del %AppData%\vstelemetry | Out-Null
cmd /c Del %LocalAppData%\Microsoft\VSApplicationInsights /F /Q /S | Out-Null
cmd /c Del %ProgramData%\Microsoft\VSApplicationInsights  /F /Q /S | Out-Null
cmd /c Del %Temp%\Microsoft\VSApplicationInsights  /F /Q /S | Out-Null
cmd /c Del %Temp%\VSFaultInfo  /F /Q /S | Out-Null
cmd /c Del %Temp%\VSFeedbackPerfWatsonData  /F /Q /S | Out-Null
cmd /c Del %Temp%\VSFeedbackVSRTCLogs  /F /Q /S | Out-Null
cmd /c Del %Temp%\VSRemoteControl  /F /Q /S | Out-Null
cmd /c Del %Temp%\VSTelem /F /Q /S | Out-Null
cmd /c Del %Temp%\VSTelem.Out /F /Q /S | Out-Null

cmd /c Del %localappdata%\Yarn\Cache /F /Q /S | Out-Null

cmd /c Del %appdata%\Microsoft\Teams\Cache /F /Q /S | Out-Null

cmd /c Del %programdata%\GOG.com\Galaxy\webcache /F /Q /S | Out-Null
cmd /c Del %programdata%\GOG.com\Galaxy\logs /F /Q /S | Out-Null

cmd /c Del %localappdata%\Microsoft\Windows\WebCache /F /Q /S | Out-Null

cmd /c Del "%SystemDrive%\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\Directx.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\SchedLgU.txt" /F /Q | Out-Null
cmd /c Del "%WinDir%\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\security\logs\*.old" /F /Q | Out-Null
cmd /c Del "%WinDir%\security\logs\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\Debug\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\Debug\UserMode\*.bak" /F /Q | Out-Null
cmd /c Del "%WinDir%\Debug\UserMode\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\*.bak" /F /Q | Out-Null
cmd /c Del "%WinDir%\system32\wbem\Logs\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\OEWABLog.txt" /F /Q | Out-Null
cmd /c Del "%WinDir%\setuplog.txt" /F /Q | Out-Null
cmd /c Del "%WinDir%\Logs\DISM\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\*.log.txt" /F /Q | Out-Null
cmd /c Del "%WinDir%\APPLOG\*.*" /F /Q | Out-Null
cmd /c Del "%WinDir%\system32\wbem\Logs\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\system32\wbem\Logs\*.lo_" /F /Q | Out-Null
cmd /c Del "%WinDir%\Logs\DPX\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\ServiceProfiles\NetworkService\AppData\Local\Temp\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\Logs\*.log" /F /Q | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Windows\WindowsUpdate.log" /F /Q | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Windows\WebCache\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\Panther\cbs.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\Panther\DDACLSys.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\repair\setup.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\Panther\UnattendGC\diagerr.xml" /F /Q | Out-Null
cmd /c Del "%WinDir%\Panther\UnattendGC\diagwrn.xml" /F /Q | Out-Null
cmd /c Del "%WinDir%\inf\setupapi.offline.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\inf\setupapi.app.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\debug\WIA\*.log" /F /Q | Out-Null
cmd /c Del "%SystemDrive%\PerfLogs\System\Diagnostics\*.*" /F /Q | Out-Null
cmd /c Del "%WinDir%\Logs\CBS\*.cab" /F /Q  | Out-Null
cmd /c Del "%WinDir%\Logs\CBS\*.cab" /F /Q | Out-Null
cmd /c Del "%WinDir%\Logs\WindowsBackup\*.etl" /F /Q | Out-Null
cmd /c Del "%WinDir%\System32\LogFiles\HTTPERR\*.*" /F /Q | Out-Null
cmd /c Del "%WinDir%\SysNative\SleepStudy\*.etl" /F /Q | Out-Null
cmd /c Del "%WinDir%\SysNative\SleepStudy\ScreenOn\*.etl" /F /Q | Out-Null
cmd /c Del "%WinDir%\System32\SleepStudy\*.etl" /F /Q | Out-Null
cmd /c Del "%WinDir%\System32\SleepStudy\ScreenOn\*.etl" /F /Q | Out-Null
cmd /c Del "%WinDir%\Logs" /F /Q | Out-Null
cmd /c Del "%WinDir%\DISM" /F /Q | Out-Null
cmd /c Del "%WinDir%\System32\catroot2\*.chk" /F /Q | Out-Null
cmd /c Del "%WinDir%\System32\catroot2\*.log" /F /Q | Out-Null
cmd /c Del "%WinDir%\System32\catroot2\.jrs" /F /Q | Out-Null
cmd /c Del "%WinDir%\System32\catroot2\*.txt" /F /Q | Out-Null

# Cleaning Disk - cleanmgr
start cleanmgr.exe /autoclean

Write-Host ' [Clean] Games Platforms Cache/Logs ' -F yellow -B black

cmd /c Del %localappdata%\EpicGamesLauncher\Saved\Logs /F /Q /S | Out-Null
cmd /c Del %localappdata%\CrashReportClient\Saved\Logs /F /Q /S | Out-Null

cmd /c Del "%localappdata%\Steam\htmlcache\Code Cache" /F /Q /S | Out-Null
cmd /c Del %localappdata%\Steam\htmlcache\GPUCache /F /Q /S | Out-Null
cmd /c Del %localappdata%\Steam\htmlcache\Cache /F /Q /S | Out-Null

cmd /c Del %AppData%\Origin\Telemetry /F /Q /S | Out-Null
cmd /c Del %AppData%\Origin\Logs /F /Q /S | Out-Null
cmd /c Del %AppData%\Origin\NucleusCache /F /Q /S | Out-Null
cmd /c Del %AppData%\Origin\ConsolidatedCache /F /Q /S | Out-Null
cmd /c Del %AppData%\Origin\CatalogCache /F /Q /S | Out-Null
cmd /c Del %localAppData%\Origin\ThinSetup /F /Q /S | Out-Null
cmd /c Del %AppData%\Origin\Telemetry /F /Q /S | Out-Null
cmd /c Del %localAppData%\Origin\Logs /F /Q /S | Out-Null

cmd /c Del %localAppData%\Battle.net\Cache /F /Q /S | Out-Null
cmd /c Del %AppData%\Battle.net\Logs /F /Q /S | Out-Null
cmd /c Del %AppData%\Battle.net\Errors /F /Q /S | Out-Null

Write-Host ' [Clean] Web Browsers Cache/Logs ' -F yellow -B black

cmd /c Del "%LocalAppData%\Google\Chrome\User Data\Default\Cache" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Google\Chrome\User Data\Default\Media Cache" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Google\Chrome\User Data\Default\GPUCache" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Google\Chrome\User Data\Default\Storage\ext" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Google\Chrome\User Data\Default\Service Worker" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Google\Chrome\User Data\ShaderCache" /F /Q /S | Out-Null


cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\Default\Media Cache" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\Default\GPUCache" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\Default\Storage\ext" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\Default\Service Worker" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge\User Data\ShaderCache" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Cache" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Media Cache" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\GPUCache" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Storage\ext" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\Default\Service Worker" /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Edge SxS\User Data\ShaderCache" /F /Q /S | Out-Null

cmd /c Del "%LocalAppData%\Opera Software\Opera Stable\cache" /F /Q /S | Out-Null
cmd /c Del "%AppData%\Opera Software\Opera Stable\GPUCache" /F /Q /S | Out-Null
cmd /c Del "%AppData%\Opera Software\Opera Stable\ShaderCache" /F /Q /S | Out-Null
cmd /c Del "%AppData%\Opera Software\Opera Stable\Jump List Icons" /F /Q /S | Out-Null
cmd /c Del "%AppData%\Opera Software\Opera Stable\Jump List IconsOld\Jump List Icons" /F /Q /S | Out-Null

cmd /c Del "%LocalAppData%\Vivaldi\User Data\Default\Cache" /F /Q /S | Out-Null

Write-Host ' [Clean] Windows Defender Cache/Logs ' -F yellow -B black

cmd /c Del "%ProgramData%\Microsoft\Windows Defender\Network Inspection System\Support\*.log" /F /Q /S | Out-Null
cmd /c Del "%ProgramData%\Microsoft\Windows Defender\Scans\History\CacheManager" /F /Q /S | Out-Null
cmd /c Del "%ProgramData%\Microsoft\Windows Defender\Scans\History\ReportLatency\Latency" /F /Q /S | Out-Null
cmd /c Del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Service\*.log" /F /Q /S | Out-Null
cmd /c Del "%ProgramData%\Microsoft\Windows Defender\Scans\MetaStore" /F /Q /S | Out-Null
cmd /c Del "%ProgramData%\Microsoft\Windows Defender\Support" /F /Q /S | Out-Null
cmd /c Del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Results\Quick" /F /Q /S | Out-Null
cmd /c Del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Results\Resource" /F /Q /S | Out-Null

Write-Host ' [Clean] Windows Font Cache ' -F yellow -B black

cmd /c net stop FontCache | Out-Null
cmd /c net stop FontCache3.0.0.0 | Out-Null
cmd /c Del "%WinDir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat" /F /Q /S | Out-Null
cmd /c Del "%WinDir%\SysNative\FNTCACHE.DAT" /F /Q /S | Out-Null
cmd /c Del "%WinDir%\System32\FNTCACHE.DAT" /F /Q /S | Out-Null
cmd /c net start FontCache | Out-Null
cmd /c net start FontCache3.0.0.0 | Out-Null

Write-Host ' [Clean] Windows Icon Cache ' -F yellow -B black

%WinDir%\SysNative\ie4uinit.exe -show | Out-Null
%WinDir%\System32\ie4uinit.exe -show | Out-Null
cmd /c Del %LocalAppData%\IconCache.db /F /Q /S | Out-Null
cmd /c Del "%LocalAppData%\Microsoft\Windows\Explorer\iconcache_*.db" /F /Q /S | Out-Null
engine;};

# Remove OneDrive
function chck60{
cmd /c if exist %programdata%\ET\chck60.lbool del %programdata%\ET\chck60.lbool
$counter++;
Write-Host ' [Remove] Microsoft OneDrive ' -F red -B black
cmd /c taskkill /F /IM "OneDrive.exe" | Out-Null
cmd /c $env:systemroot\SysWOW64\OneDriveSetup.exe /uninstall | Out-Null
cmd /c $env:systemroot\System32\OneDriveSetup.exe /uninstall | Out-Null

Get-AppxPackage -allusers *Microsoft.OneDriveSync* | Remove-AppxPackage

cmd /c rd "%UserProfile%\OneDrive" /Q /S | Out-Null
cmd /c rd "%LocalAppData%\Microsoft\OneDrive" /Q /S | Out-Null
cmd /c rd "%ProgramData%\Microsoft OneDrive" /Q /S | Out-Null
cmd /c rd "%systemdrive%\OneDriveTemp" /Q /S | Out-Null

::Remove OneDrive leftovers in explorer left side panel
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f | Out-Null
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f | Out-Null
cmd /c reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f | Out-Null
engine;};

# Disable Xbx Services (Minecraft Luncher wont login into MS)
function chck61{
cmd /c if exist %programdata%\ET\chck61.lbool del %programdata%\ET\chck61.lbool
$counter++;
Write-Host ' [Disable] Xbox Services ' -F darkgray -B black
cmd /c sc config XblAuthManager start= disabled | Out-Null
cmd /c sc config XboxNetApiSvc start= disabled | Out-Null
cmd /c sc config XblGameSave start= disabled | Out-Null
engine;};

# Safe/Fast DNS 1.1.1.1
function chck62{
cmd /c if exist %programdata%\ET\chck62.lbool del %programdata%\ET\chck62.lbool
$counter++;
Write-Host ' [Setting] Fast/Secure DNS 1.1.1.1 ' -F blue -B black
ipconfig /flushdns | Out-Null

# Custom DNS can couse problems with connection mostly becouse of Internet Service Provider (blocking custom DNS)
# or could not connect into website (extremely rare case)

netsh interface ipv4 add dnsservers "Ethernet" address=1.1.1.1 index=1 | Out-Null
netsh interface ipv4 add dnsservers "Ethernet" address=8.8.8.8 index=2 | Out-Null

netsh interface ipv4 add dnsservers "Wi-Fi" address=1.1.1.1 index=1 | Out-Null
netsh interface ipv4 add dnsservers "Wi-Fi" address=8.8.8.8 index=2 | Out-Null
engine;};

# Scan of Adware/Malware
function chck63 {
cmd /c if exist %programdata%\ET\chck63.lbool del %programdata%\ET\chck63.lbool
$counter++;
Write-Host ' [Scanning] AdwCleaner ' -F darkgreen -B black
wget https://downloads.malwarebytes.com/file/adwcleaner -o $Env:programdata\adwcleaner.exe | Out-Null
cmd /c if exist $Env:programdata\adwcleaner.exe start /WAIT $Env:programdata\adwcleaner.exe /eula /clean /noreboot | Out-Null

del $Env:programdata\adwcleaner.exe | Out-Null

engine;};

#Clean Database of WinSxS
function chck68{
cmd /c if exist %programdata%\ET\chck68.lbool del %programdata%\ET\chck68.lbool
$counter++;
Write-Host ' [Clean] WinSxS Folder ' -F yellow -B black
DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase | Out-Null

engine;};

#Set Split Threshold for Svchost
function chck3{
cmd /c if exist %programdata%\ET\chck3.lbool del %programdata%\ET\chck3.lbool
$counter++;
Write-Host ' [Setting] Split Threshold for Svchost ' -F blue -B black
$NomRAM = wmic computersystem get totalphysicalmemory | findstr /r "[0-9]"

# Default Hexa:380000

# Convert into KB from Bytes and add into SvcHost registry
$clcrm = ([regex]::Match((Get-content 'NumRAM.txt'), '\d+')).Value; $clcrm=$clcrm/1024; 
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control /v SvcHostSplitThresholdInKB /t REG_DWORD /d $clcrm /f | Out-Null

cmd /c if exist NumRAM.txt del NumRAM.txt

engine;};

#Quit if no files .lbool or other errors
function error_exit { exit };

# Main Start Hamster-Engine (that amount of "if" is AWESOME)
	function engine 
	{	
	$percentcomplete = $counter/$alltodo*100
	$showpercent = [math]::Round($percentcomplete)
    Write-Progress -Activity "Script in Progress" -Status "$showpercent% Complete:" -PercentComplete $showpercent
			if (Get-Item -Path $Env:programdata\ET\chck1.lbool) {chck1;} 
			if (Get-Item -Path $Env:programdata\ET\chck2.lbool) {chck2;} 
			if (Get-Item -Path $Env:programdata\ET\chck3.lbool) {chck3;} 
			if (Get-Item -Path $Env:programdata\ET\chck4.lbool) {chck4;} 
			if (Get-Item -Path $Env:programdata\ET\chck5.lbool) {chck5;} 
			if (Get-Item -Path $Env:programdata\ET\chck6.lbool) {chck6;} 
			if (Get-Item -Path $Env:programdata\ET\chck7.lbool) {chck7;} 
			if (Get-Item -Path $Env:programdata\ET\chck8.lbool) {chck8;} 
			if (Get-Item -Path $Env:programdata\ET\chck9.lbool) {chck9;} 
			if (Get-Item -Path $Env:programdata\ET\chck10.lbool) {chck10;} 
			if (Get-Item -Path $Env:programdata\ET\chck11.lbool) {chck11;} 
			if (Get-Item -Path $Env:programdata\ET\chck12.lbool) {chck12;} 
			if (Get-Item -Path $Env:programdata\ET\chck13.lbool) {chck13;} 
			if (Get-Item -Path $Env:programdata\ET\chck14.lbool) {chck14;} 
			if (Get-Item -Path $Env:programdata\ET\chck15.lbool) {chck15;} 
			if (Get-Item -Path $Env:programdata\ET\chck16.lbool) {chck16;} 
			if (Get-Item -Path $Env:programdata\ET\chck17.lbool) {chck17;} 
			if (Get-Item -Path $Env:programdata\ET\chck18.lbool) {chck18;} 
			if (Get-Item -Path $Env:programdata\ET\chck18.lbool) {chck18;} 
			if (Get-Item -Path $Env:programdata\ET\chck19.lbool) {chck19;} 
			if (Get-Item -Path $Env:programdata\ET\chck20.lbool) {chck20;} 
			if (Get-Item -Path $Env:programdata\ET\chck21.lbool) {chck21;} 
			if (Get-Item -Path $Env:programdata\ET\chck22.lbool) {chck22;} 
			if (Get-Item -Path $Env:programdata\ET\chck23.lbool) {chck23;} 
			if (Get-Item -Path $Env:programdata\ET\chck24.lbool) {chck24;} 
			if (Get-Item -Path $Env:programdata\ET\chck25.lbool) {chck25;} 
			if (Get-Item -Path $Env:programdata\ET\chck26.lbool) {chck26;} 
			if (Get-Item -Path $Env:programdata\ET\chck27.lbool) {chck27;} 
			if (Get-Item -Path $Env:programdata\ET\chck28.lbool) {chck28;} 
			if (Get-Item -Path $Env:programdata\ET\chck29.lbool) {chck29;} 
			if (Get-Item -Path $Env:programdata\ET\chck30.lbool) {chck30;} 
			if (Get-Item -Path $Env:programdata\ET\chck31.lbool) {chck31;} 
			if (Get-Item -Path $Env:programdata\ET\chck32.lbool) {chck32;} 
			if (Get-Item -Path $Env:programdata\ET\chck33.lbool) {chck33;} 
			if (Get-Item -Path $Env:programdata\ET\chck34.lbool) {chck34;} 
			if (Get-Item -Path $Env:programdata\ET\chck35.lbool) {chck35;} 
			if (Get-Item -Path $Env:programdata\ET\chck36.lbool) {chck36;} 
			if (Get-Item -Path $Env:programdata\ET\chck37.lbool) {chck37;} 
			if (Get-Item -Path $Env:programdata\ET\chck38.lbool) {chck38;} 
			if (Get-Item -Path $Env:programdata\ET\chck39.lbool) {chck39;} 
			if (Get-Item -Path $Env:programdata\ET\chck40.lbool) {chck40;} 
			if (Get-Item -Path $Env:programdata\ET\chck41.lbool) {chck41;} 
			if (Get-Item -Path $Env:programdata\ET\chck42.lbool) {chck42;} 
			if (Get-Item -Path $Env:programdata\ET\chck43.lbool) {chck43;} 
			if (Get-Item -Path $Env:programdata\ET\chck44.lbool) {chck44;} 
			if (Get-Item -Path $Env:programdata\ET\chck45.lbool) {chck45;} 
			if (Get-Item -Path $Env:programdata\ET\chck46.lbool) {chck46;} 
			if (Get-Item -Path $Env:programdata\ET\chck47.lbool) {chck47;} 
			if (Get-Item -Path $Env:programdata\ET\chck48.lbool) {chck48;} 
			if (Get-Item -Path $Env:programdata\ET\chck49.lbool) {chck49;} 
			if (Get-Item -Path $Env:programdata\ET\chck50.lbool) {chck50;} 
			if (Get-Item -Path $Env:programdata\ET\chck51.lbool) {chck51;} 
			if (Get-Item -Path $Env:programdata\ET\chck52.lbool) {chck52;} 
			if (Get-Item -Path $Env:programdata\ET\chck53.lbool) {chck53;} 
			if (Get-Item -Path $Env:programdata\ET\chck54.lbool) {chck54;} 
			if (Get-Item -Path $Env:programdata\ET\chck55.lbool) {chck55;} 
			if (Get-Item -Path $Env:programdata\ET\chck56.lbool) {chck56;} 
			if (Get-Item -Path $Env:programdata\ET\chck57.lbool) {chck57;} 
			if (Get-Item -Path $Env:programdata\ET\chck58.lbool) {chck58;} 
			if (Get-Item -Path $Env:programdata\ET\chck59.lbool) {chck59;} 
			if (Get-Item -Path $Env:programdata\ET\chck60.lbool) {chck60;} 
			if (Get-Item -Path $Env:programdata\ET\chck61.lbool) {chck61;} 
			if (Get-Item -Path $Env:programdata\ET\chck62.lbool) {chck62;} 
			if (Get-Item -Path $Env:programdata\ET\chck63.lbool) {chck63;} 
			if (Get-Item -Path $Env:programdata\ET\chck64.lbool) {chck64;} 
			if (Get-Item -Path $Env:programdata\ET\chck65.lbool) {chck65;} 
			if (Get-Item -Path $Env:programdata\ET\chck66.lbool) {chck66;} 
			if (Get-Item -Path $Env:programdata\ET\chck67.lbool) {} 
			if (Get-Item -Path $Env:programdata\ET\chck68.lbool) {chck68;} 
			if (Get-Item -Path $Env:programdata\ET\chck69.lbool) {} 
	};

cls
if (-not(Test-Path $Env:programdata\ET\*.lbool)) { error_exit; }
[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 1) | Out-Null

engine;

#Done
if (Get-Item -Path $Env:programdata\restart-network-settings.bat) {Remove-Item $Env:programdata\restart-network-settings.bat}
if (Get-Item -Path $Env:programdata\winget-et.bat) {Remove-Item $Env:programdata\winget-et.bat}

Write-Host "";Write-Host "";
Write-Host ""
Write-Host ""
Write-Host "               Everything has been done. Reboot is recommended."
Write-Host ""
Write-Host ""
Write-Host "";Write-Host "";

#MsgBox information
Add-Type -AssemblyName PresentationCore,PresentationFramework
$msgBody = "Everything has been done. Reboot is recommended."
$msgTitle = $versionRAW
$msgButton = 'OK'
$msgImage = 'Information'
$Result = [System.Windows.MessageBox]::Show($msgBody,$msgTitle,$msgButton,$msgImage)
