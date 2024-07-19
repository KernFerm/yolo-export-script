# YOLO Model Export Script

This repository contains a script to load and export YOLO models using the Ultralytics library. The script can detect and utilize NVIDIA and AMD GPUs to accelerate the process. The supported export formats include `ONNX`, `TorchScript`, `CoreML`, `TFLite`, and `TFJS`.

## Features

- **GPU Detection**: Automatically detects and uses NVIDIA and AMD GPUs if available.
- **Multiple Export Formats**: Supports exporting the YOLO model to various formats.
- **Robust Error Handling**: Includes comprehensive error handling and logging.
- **`YOLO V5 & YOLO V8 Only`**

## Prerequisites

- Python 3.7 or later
- PyTorch
- Ultralytics YOLO


# Logging for YOLO Model Export Script

This script is configured to use logging to provide detailed information about its execution process.

## Logging Configuration

The script uses the `logging` module to log messages with the following configuration:

```
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)
```

- Log Level: The logging level is set to `INFO`. This means that the script will log messages with a severity level of `INFO` or higher (e.g., `ERROR`).
- Log Format: The log messages will include the timestamp, log level, and message content.

## Logged Events
- The script logs various events throughout its execution, including:

1. **Loading the Model:**
- Logs the start of the model loading process.
- Logs the successful loading of the model.

```
2024-07-17 12:00:00 - INFO - Loading model from best.pt
2024-07-17 12:00:01 - INFO - Model loaded successfully
```

2. **Exporting the Model:**
- Logs the start of the model export process.
- Logs the successful export of the model.

```
2024-07-17 12:00:02 - INFO - Exporting model to onnx format
2024-07-17 12:00:03 - INFO - Model exported successfully
```

## Detecting GPU:
- Logs the detection of NVIDIA or AMD GPUs, or the use of CPU if no compatible GPU is detected.

```
2024-07-17 12:00:04 - INFO - NVIDIA GPU detected.
```

## Error Logging
- The script includes error handling to log exceptions for various error scenarios:

1. **File Not Found:**
- Logs an error if the specified model file does not exist.

```
2024-07-17 12:00:00 - ERROR - The model file best.pt does not exist.
```

2. **Unsupported Export Format:**
- Logs an error if the specified export format is not supported.

```
2024-07-17 12:00:01 - ERROR - Unsupported export format: invalid_format. Supported formats are: onnx, torchscript, coreml, tflite, tfjs
```

3. **Model Loading Error:**
- Logs any exceptions that occur during model loading.

```
2024-07-17 12:00:02 - ERROR - Error loading model: [Exception details]
```

4. **Model Exporting Error:**
- Logs any exceptions that occur during model export.

```
2024-07-17 12:00:03 - ERROR - Error exporting model: [Exception details]
```

5. **General Errors:**
- Logs any other exceptions that occur during script execution.

```
2024-07-17 12:00:04 - ERROR - Failed to complete the operation: [Exception details]
```

## Viewing Logs
- To view the logs, simply run the script, and the log messages will be printed to the console. This helps in debugging and understanding the script's execution flow.


## Installation

1. Clone this repository:
   ```
   git clone https://github.com/kernferm/yolo-export-script.git
   cd yolo-export-script
   ```
2. Install the required Python packages:
   ```
   pip install torch torchvision torchaudio ultralytics
   ```
- If you have an AMD GPU and want to use ROCm:

   ```
   pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/rocm5.0
   ```
## Usage 

- Run the convert.py script with the following arguments:

`--model-path:` Path to the YOLO model file (e.g., `best.pt`).
`--export-format:` Export format (default: `onnx`). Supported formats: `onnx`, `torchscript`, `corem`l, `tflite`, `tfjs`.

## Example

```
python convert.py --model-path best.pt --export-format onnx
```

## Script Description

```
import argparse
import logging
from ultralytics import YOLO
import os
import torch

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

SUPPORTED_FORMATS = ['onnx', 'torchscript', 'coreml', 'tflite', 'tfjs']

def validate_export_format(export_format):
    if export_format not in SUPPORTED_FORMATS:
        raise ValueError(f"Unsupported export format: {export_format}. Supported formats are: {', '.join(SUPPORTED_FORMATS)}")

def load_model(model_path):
    if not os.path.exists(model_path):
        raise FileNotFoundError(f"The model file {model_path} does not exist.")
    try:
        logger.info(f"Loading model from {model_path}")
        model = YOLO(model_path)
        logger.info("Model loaded successfully")
        return model
    except Exception as e:
        logger.error(f"Error loading model: {e}")
        raise

def export_model(model, export_format):
    try:
        logger.info(f"Exporting model to {export_format} format")
        model.export(format=export_format)
        logger.info("Model exported successfully")
    except Exception as e:
        logger.error(f"Error exporting model: {e}")
        raise

def detect_gpu():
    if torch.cuda.is_available():
        logger.info("NVIDIA GPU detected.")
        return torch.device('cuda')
    elif torch.backends.mps.is_available():
        logger.info("AMD GPU detected (via MPS).")
        return torch.device('mps')
    elif torch.has_mps:
        logger.info("AMD GPU detected (via ROCm).")
        return torch.device('mps')
    else:
        logger.info("No compatible GPU detected. Using CPU.")
        return torch.device('cpu')

def main():
    parser = argparse.ArgumentParser(description="Load and export YOLO model")
    parser.add_argument('--model-path', type=str, required=True, help="Path to the YOLO model file (e.g., 'best.pt')")
    parser.add_argument('--export-format', type=str, default='onnx', help=f"Export format (default: 'onnx'). Supported formats: {', '.join(SUPPORTED_FORMATS)}")

    args = parser.parse_args()

    try:
        validate_export_format(args.export_format)
        device = detect_gpu()
        model = load_model(args.model_path)
        model.to(device)
        export_model(model, args.export_format)
    except FileNotFoundError as fnf_error:
        logger.error(fnf_error)
    except ValueError as val_error:
        logger.error(val_error)
    except Exception as e:
        logger.error(f"Failed to complete the operation: {e}")

if __name__ == "__main__":
```


## Contributors

- @hamsterdog6 , thank you for the tiny snippet you provide to make this project come alive

```
from ultralytics import YOLO

Load a model
model = YOLO('best.pt')

Export the model
model.export(format='onnx')
```

## LICENSE

- `MIT` [License Agreement](https://github.com/KernFerm/yolo-export-script/blob/main/LICENSE)
