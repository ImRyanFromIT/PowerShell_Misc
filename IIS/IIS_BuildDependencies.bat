@echo off
echo Installing Chocolatey
powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
:: Section 2: Package Installs
echo ========================================================================
echo Installing Hugo
choco install hugo --confirm
echo ========================================================================
echo Installing Go
choco install golang -y
echo ========================================================================
echo Installing NodeJs
choco install nodejs -y
echo ========================================================================
choco install git.install -y
