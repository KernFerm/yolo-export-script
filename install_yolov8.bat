@echo off
setlocal enabledelayedexpansion

REM Function to check and handle errors
:check_error
if %errorlevel% neq 0 (
    echo Error occurred: %1
    call :cleanup
    exit /b %errorlevel%
)

REM Function to clean up in case of failure
:cleanup
if exist venv (
    echo Cleaning up...
    rmdir /s /q venv
)
goto :EOF

REM Function to print progress bar
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

echo Installing required Python packages for YOLOv8...

REM Check if Python is installed
echo Checking if Python is installed...
python --version >nul 2>&1
call :check_error "Python is not installed. Please install Python and try again."
echo Python is installed.

REM Create a virtual environment
echo Creating virtual environment...
python -m venv venv
call :check_error "Failed to create virtual environment."
echo Virtual environment created successfully.

REM Activate the virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat
call :check_error "Failed to activate virtual environment."
echo Virtual environment activated.

REM Upgrade pip to the latest version
echo Upgrading pip to the latest version...
pip install --upgrade pip > nul 2>&1
call :check_error "Failed to upgrade pip."

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

REM Install the required packages
echo Installing the required packages...
pip install torch>=1.9.0 torchvision>=0.10.0 torchaudio>=0.9.0 ultralytics==8.2.79 > nul 2>&1
call :check_error "Failed to install one or more packages."

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

REM Inform user to manually deactivate virtual environment
echo Installation completed. To deactivate the virtual environment, simply close this command prompt or run `deactivate` if you are in a virtual environment.

pause

endlocal
exit /b 0
