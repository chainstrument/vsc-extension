@echo off
setlocal enabledelayedexpansion




REM Initialisation de la liste des extensions à installer
set "extensionsToInstall="

REM Lecture des extensions à partir du fichier
for /f "usebackq delims=" %%a in ("liste.txt") do (
    if not %%a == "# vsc-extension" (
        set "extensionsToInstall=!extensionsToInstall! %%a"
    )
)


REM Installation des extensions
for %%a in (%extensionsToInstall%) do (
    set "extensionName=%%a"
    echo %%a
    set "extensionInstalled="

    for /f "tokens=* delims=" %%b in ('code --list-extensions') do (
        if /i "!extensionName!"=="%%b" (
            set "extensionInstalled=true"
        ) 
    )

    if defined extensionInstalled (
        echo !extensionName! est déjà installé.
    ) else (
        echo Installation de !extensionName!... >> temp.txt
        start /w code --install-extension !extensionName! --force /S
    )  
)

echo "---- Fin -----"
pause
