@echo off
setlocal enabledelayedexpansion

echo Installing required Python packages for YOLOv8...

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
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to upgrade pip.
    exit /b 1
)
echo Pip upgraded successfully.

REM Install the required packages
echo Installing the required packages...
pip install torch>=1.9.0 torchvision>=0.10.0 torchaudio>=0.9.0 ultralytics==8.0.0 > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to install one or more packages.
    exit /b 1
)
echo Packages installed successfully.

REM Inform the user to manually deactivate the virtual environment
echo Installation completed. To deactivate the virtual environment, simply close this command prompt or run `deactivate` if you are in a virtual environment.

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
