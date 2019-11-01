::Script para instalar os programas padrões usado na Damapel de forma automatica e silenciosa, sem a necessidade de interação do administrador.
::Desenvolvido por Wellington Rodrigues - well.rodrigues9@gmail.com

@echo off
color 5F
title T.I. DAMAPEL - Instalacao dos Programas
mode 85,20

::Verifica primeiro se o arquivo está sendo executado como administrador
fsutil dirty query %systemdrive% >nul 2>&1 || (
echo ==== ERROR ====
echo Clique com o botao direito neste arquivo e selecione 'Executar como administrador'
goto Done
)

set NoDateTime=1
call :Script_install

:Done
echo.
echo.
echo Pressione qualquer tecla para sair...
pause >nul
exit /b

:Script_install
::Libera a politica de permissão para o powershell ser executado no sistema
powershell -Command "Set-ExecutionPolicy Unrestricted"

::Adiciona os IPs da rede e localhost para não ter problemas nas instalações dos programas
powershell -File "C:\files\IPs_intranet.ps1"

mkdir c:\files
::Acesso a rede onde está os arquivos para serem instalados 
pushd \\192.168.3.3\dados\
echo Copiando arquivos
echo.
echo.
xcopy Programas C:\files\ /E
echo Copia Concluida
cd c:\files

::///////////////////////////////////////////////////////
::Instalação dos programas principais usados na DAMAPEL//
::///////////////////////////////////////////////////////

::JAVA 8 UPDATE 201 - INSTALAÇÃO SEM AUTO UPDATE
echo Instalando Java 8 update 201
start /wait jre-8u201-windows-i586.exe INSTALL_SILENT=1 AUTO_UPDATE=0 REBOOT=0
 
:: AGENTE S4
echo Instalando Agente S4
start /wait AgenteS4.exe /VERYSILENT
 
:: FIREFOX
echo Instalando Firefox 
start /wait Firefox.exe /S
 
:: GOOGLE CHROME
echo Instalando Google Chrome 
start /wait ChromeSetup.exe /silent /install
 
:: LIBREOFFICE 6.2.6
echo Instalando LibreOffice 6.2.7 
start /wait LibreOffice_6.2.7_Win_x64.msi /qn /norestart ALLUSERS=1 CREATEDESKTOPLINK=0
 
:: FOXIT READER VERSÃO 9
echo Instalando Foxit Reader 
start /wait foxit_reader.exe /VERYSILENT DESKTOP_SHORTCUT="0" AUTO_UPDATE="0" MAKEDEFAULT="1" VIEWINBROWSER="1" /NORESTART
 
:: SPARK 2.8.3
echo Instalando Spark 
start /wait spark_2_8_3.exe -q
 
:: WINRAR
echo Instalando WinRAR
start /wait WinRAR.exe /S
 
:: WINDOWS LIVE MAIL 2012
echo Instalando Windows Live Mail 
start /wait wlsetup-all_pt-br /silent /NoToolbarCEIP /NoCEIP / NoHomepage /NoLaunch /NoSearch /AppSelect:Mail
 
:: CCLEANER 5.6.2
echo Instalando CCleaner 
start /wait ccsetup562 /S
 
:: VNC SERVER 5.2.3 - NECESSITA DO SERIAL DEPOIS PARA FUNCIONAR CORRETAMENTE
echo Instalando VNC Server 
start /wait VNC-5.2.3-Windows.exe /verysilent SERVER_REGISTER_AS_SERVICE=1 SERVER_ADD_FIREWALL_EXCEPTION=1 SERVER_ALLOW_SAS=1 SET_USEVNCAUTHENTICATION=1 VALUE_OF_USEVNCAUTHENTICATION=1 SET_PASSWORD=1 VALUE_OF_PASSWORD=1011
 
:: AGENTE SPICEWORKS
echo Instalando Spiceworks Agent 
start /wait SpiceworksTLSAgent.msi SPICEWORKS_SERVER="192.168.3.29" SPICEWORKS_AUTH_KEY="gWarGw8+XQblGZyAJnxXWXNS1E4=" SPICEWORKS_PORT=9676 /qb /norestart
 echo Programas instalados com sucesso.
echo.

::Instalação das fontes padrões DAMAPEL
echo.
echo Instalando Fontes
powershell -File "C:\files\install_fonts.ps1"
echo.
echo Fontes instaladas com sucesso

:: Deleta a pasta files e atalhos do foxit e ccleaner
xcopy C:\files\vnc-key.txt %userprofile%\Desktop
C:
set d=C:\Users\Public\Desktop
rd /s /q c:\files
cd %d%
del "Foxit Reader.lnk", CCleaner.lnk

echo Instalacao Concluida
echo Pressione qualquer tecla para sair...
pause>nul
exit /b