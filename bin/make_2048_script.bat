@echo off
set DIR=%~dp0
cd "%DIR%.."
call %DIR%compile_scripts.bat -i bin\cube2048\scripts -o bin\cube2048\res\scripts.zip -m zip

echo.
echo DONE
echo.
