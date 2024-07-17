@echo off
echo ===================================================
echo               Installing Requirements
echo ===================================================
echo.

REM Check if pip is installed
pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Pip is not installed. Please install pip and run this script again.
    pause
    exit /b 1
)

echo Installing ONNX...
pip install onnx==1.14.0
if %errorlevel% neq 0 (
    echo Failed to install ONNX.
    pause
    exit /b 1
)
echo ONNX installed successfully.
echo.

echo Installing PyTorch...
pip install torch==2.3.1
if %errorlevel% neq 0 (
    echo Failed to install PyTorch.
    pause
    exit /b 1
)
echo PyTorch installed successfully.
echo.

echo Installing argparse...
pip install argparse
if %errorlevel% neq 0 (
    echo Failed to install argparse.
    pause
    exit /b 1
)
echo Argparse installed successfully.
echo.

echo ===================================================
echo        All requirements installed successfully
echo ===================================================
echo.
echo Press any key to continue...
pause

