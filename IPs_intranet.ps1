Set-Location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
Set-Location ZoneMap\Domains
New-Item localhost
Set-Location localhost
New-ItemProperty . -Name * -Value 1 -Type DWORD

Set-Location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges"
New-Item Range1
Set-Location Range1
New-ItemProperty . -Name :Range -Value 192.168.3.1 -PropertyType String
New-ItemProperty . -Name file -Value 1 -PropertyType DWORD
cd ..

Set-Location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges"
New-Item Range2
Set-Location Range2
New-ItemProperty . -Name :Range -Value 192.168.3.3 -PropertyType String
New-ItemProperty . -Name file -Value 1 -PropertyType DWORD
cd ..

Set-Location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges"
New-Item Range3
Set-Location Range3
New-ItemProperty . -Name :Range -Value 192.168.3.29 -PropertyType String
New-ItemProperty . -Name file -Value 1 -PropertyType DWORD
cd ..

Set-Location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges"
New-Item Range4
Set-Location Range4
New-ItemProperty . -Name :Range -Value 192.168.3.40 -PropertyType String
New-ItemProperty . -Name file -Value 1 -PropertyType DWORD
cd ..