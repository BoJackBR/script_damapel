Set-Location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies"
New-Item ActiveDesktop, Explorer, System
cd .\ActiveDesktop
New-ItemProperty . -Name NoChangingWallPaper -Value 1 -PropertyType DWORD
cd ..
cd .\Explorer
New-ItemProperty . -Name NoDriveTypeAutoRun -Value 145 -PropertyType DWORD
cd ..
cd .\System
New-ItemProperty . -Name Wallpaper -Value C:\damapel\wallpaper.jpg -PropertyType String
New-ItemProperty . -Name WallpaperStyle -Value 4 -PropertyType String
