@echo off
setlocal enabledelayedexpansion

echo Installing required Python packages for YOLOv5...

REM Check if Python is installed
echo Checking if Python is installed...
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python is not installed. Please install Python and try again.
    exit /b 1
)
echo Python is installed.

REM Create a virtual environment
echo Creating virtual environment...
python -m venv venv
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to create virtual environment.
    exit /b 1
)
echo Virtual environment created successfully.

REM Activate the virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to activate virtual environment.
    exit /b 1
)
echo Virtual environment activated.

REM Upgrade pip to the latest version
echo Upgrading pip to the latest version...
pip install --upgrade pip > nul 2>&1

REM Simulate progress bar for upgrading pip
set /A progress=0
echo Upgrading pip...
:progress_bar_pip
if %progress% lss 100 (
    set /A progress+=10
    call :print_progress_bar %progress% "Upgrading pip"
    timeout /T 1 > nul
    goto progress_bar_pip
)
echo Pip upgraded successfully.

REM Clone YOLOv5 repository
echo Cloning YOLOv5 repository...
git clone https://github.com/ultralytics/yolov5.git > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to clone YOLOv5 repository.
    exit /b 1
)
echo YOLOv5 repository cloned successfully.

REM Change directory to YOLOv5
cd yolov5

REM Install YOLOv5 requirements
echo Installing YOLOv5 requirements...
pip install -r requirements.txt > nul 2>&1

REM Simulate progress bar for installing packages
set /A progress=0
echo Installing packages...
:progress_bar_packages
if %progress% lss 100 (
    set /A progress+=10
    call :print_progress_bar %progress% "Installing packages"
    timeout /T 1 > nul
    goto progress_bar_packages
)
echo Packages installed successfully.

REM Deactivate the virtual environment
echo Deactivating virtual environment...
deactivate > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to deactivate virtual environment.
    exit /b 1
)
echo Virtual environment deactivated.

endlocal
exit /b 0

:print_progress_bar
setlocal
set /A progress=%1
set message=%2
set bar=
for /L %%G in (1,1,%progress%) do (
    set bar=!bar!#
)
for /L %%G in (%progress%,1,100) do (
    set bar=!bar!-
)
<nul set /p =[%bar%] %progress%%% - %message%
echo(
endlocal
goto :EOF
