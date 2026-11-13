@echo off
setlocal
cd /d "%~dp0"

echo ========================================
echo         WindowStream EXE Builder
echo ========================================
echo.

where python >nul 2>nul
if errorlevel 1 (
    echo Python was not found. Install Python 3.10 or newer and try again.
    pause
    exit /b 1
)

echo Installing runtime and build dependencies...
python -m pip install --upgrade pip
if errorlevel 1 goto :error

python -m pip install -r requirements.txt
if errorlevel 1 goto :error

python -m pip install pyinstaller
if errorlevel 1 goto :error

echo.
echo Building WindowStream.exe...
python -m PyInstaller --noconfirm --clean --onefile --windowed --name WindowStream --collect-all windows_capture --hidden-import win32timezone window_stream.py
if errorlevel 1 goto :error

echo.
echo Build complete.
echo Your EXE is here:
echo %CD%\dist\WindowStream.exe
echo.
echo Copy the EXE into its own folder alongside its settings.json file.
pause
exit /b 0

:error
echo.
echo Build failed. Check the error messages above.
pause
exit /b 1
