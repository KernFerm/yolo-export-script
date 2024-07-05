@echo off
echo Checking for Python installation...
python --version
if %errorlevel% neq 0 (
    echo Python is not installed. Please install Python and try again.
    exit /b 1
)

echo Checking for pip installation...
pip --version
if %errorlevel% neq 0 (
    echo Pip is not installed. Installing pip...
    python -m ensurepip --upgrade
)

echo Installing torch==2.0.1...
pip install torch==2.0.1

echo Installing torchvision==0.15.2...
pip install torchvision==0.15.2

echo Installing onnx==1.14.0...
pip install onnx==1.14.0

echo Installation complete.
pause
