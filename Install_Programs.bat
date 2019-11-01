::Script para instalar os programas padrões usado na Damapel de forma automatica e silenciosa, sem a necessidade de interação do administrador.
::Desenvolvido por Wellington Rodrigues - well.rodrigues9@gmail.com
::Out/2019 - Versão 1.0


@echo off
color 5F
title T.I. DAMAPEL - Instalacao dos Programas
mode 85,20

::VERIFICA PRIMEIRO SE O ARQUIVO ESTA SENDO EXECUTADO COMO ADMINISTADOR
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
::CRIA UMA PASTA NA UNIDADE C:
mkdir c:\files
:: ACESSO A REDE ONDE ESTA OS ARQUIVOS PARA SEREM INSTALADOS
pushd \\192.168.3.3\dados\Programas
:: COPIAS OS ARQUIVOS PARA O DIR. C:\FILES
echo Copiando arquivos
echo -
echo -
xcopy *.* c:\files\
cls
echo Copia Concluida
cd c:\files
:://///////////////////////////////////////////////////////////////////
:: AQUI COMEÇA A INSTALAÇÃO DOS PROGRAMAS PRINCIPAIS USADO NA DAMAPEL::
:://///////////////////////////////////////////////////////////////////

::JAVA 8 UPDATE 201 x86 - INSTALAÇÃO SEM AUTO UPDATE
echo Instalando Java 8 update 201
start /wait jre-8u201-windows-i586.exe INSTALL_SILENT=1 AUTO_UPDATE=0 REBOOT=0
cls

:: AGENTE S4
echo Instalando Agente S4
start /wait AgenteS4.exe /VERYSILENT
cls

:: FIREFOX 64bit
echo Instalando Firefox 
start /wait Firefox.exe /S
cls

:: GOOGLE CHROME x64
echo Instalando Google Chrome 
start /wait ChromeSetup.exe /silent /install
cls

:: LIBREOFFICE 6.2.6 x64
echo Instalando LibreOffice 6.2.7 
start /wait LibreOffice_6.2.7_Win_x64.msi /qn /norestart ALLUSERS=1 CREATEDESKTOPLINK=0
cls

:: FOXIT READER VERSÃO 9
echo Instalando Foxit Reader 
start /wait foxit_reader.exe /VERYSILENT DESKTOP_SHORTCUT="0" AUTO_UPDATE="0" MAKEDEFAULT="1" VIEWINBROWSER="1" /NORESTART
cls

:: SPARK 2.8.3
echo Instalando Spark 
start /wait spark_2_8_3.exe -q
cls

:: WINRAR x64
echo Instalando WinRAR
start /wait WinRAR.exe /S
cls

:: WINDOWS LIVE MAIL 2012
echo Instalando Windows Live Mail 
start /wait wlsetup-all_pt-br /silent /NoToolbarCEIP /NoCEIP / NoHomepage /NoLaunch /NoSearch /AppSelect:Mail
cls

:: CCLEANER 5.6.2
echo Instalando CCleaner 
start /wait ccsetup562 /S
cls

:: VNC SERVER 5.2.3 - NECESSITA DO SERIAL DEPOIS PARA FUNCIONAR CORRETAMENTE
echo Instalando VNC Server 
start /wait VNC-5.2.3-Windows.exe /verysilent SERVER_REGISTER_AS_SERVICE=1 SERVER_ADD_FIREWALL_EXCEPTION=1 SERVER_ALLOW_SAS=1 SET_USEVNCAUTHENTICATION=1 VALUE_OF_USEVNCAUTHENTICATION=1 SET_PASSWORD=1 VALUE_OF_PASSWORD=1011
cls

:: AGENTE SPICEWORKS
echo Instalando Spiceworks Agent 
start /wait SpiceworksTLSAgent.msi SPICEWORKS_SERVER="192.168.3.29" SPICEWORKS_AUTH_KEY="gWarGw8+XQblGZyAJnxXWXNS1E4=" SPICEWORKS_PORT=9676 /qb /norestart
cls


echo.
echo Instalando Fonts
powershell -Command "Set-ExecutionPolicy Unrestricted"
powershell -File "C:\files\fonts\install_fonts.ps1"
echo.
echo Fontes instaladas

:: DELETA A PASTA FILES E ATALHOS DO FOXIT E CCLEANER
set d=C:\Users\Public\Desktop
rd /s /q c:\files && cd %d%
del "Foxit Reader.lnk", CCleaner.lnk

cls
echo Instalacao Concluida...
pause>nul
exit /b