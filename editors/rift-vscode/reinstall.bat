@echo off
setlocal enabledelayedexpansion

REM Step 1: Removes files matching *.vsix
del /s /q *.vsix

REM Step 2: Run the following commands

echo Uninstalling extension...
code --uninstall-extension morph.rift-vscode

echo Running 'npm run clean'...
npm run clean

echo Running npm i...
npm i

echo Creating VSIX package...
npx @vscode/vsce package

REM Step 1: Get the version from package.json
set "version="
for /f "tokens=2 delims=:," %%a in ('type package.json ^| findstr "version"') do (
    set "ver=%%a"
    set "ver=!ver:~2,-1!"
    if not defined version set "version=!ver!"
)

REM Step 2: Install extension using the version
echo Installing extension...
code --install-extension rift-vscode-!version!.vsix
