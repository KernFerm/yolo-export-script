# PT to ONNX Converter

This project provides a simple yet effective tool for converting PyTorch models (`.pt`) to the ONNX format (`.onnx`). It's designed for developers and researchers who work with neural networks and need a straightforward way to transition between these two popular formats.

## Description

The PT to ONNX Converter leverages PyTorch's and ONNX's powerful libraries to automate the conversion process. It includes features such as automatic input size detection and supports various ONNX opset versions for compatibility with different frameworks and tools.

## Getting Started

### Dependencies

- [Python 3.11.6](https://github.com/KernFerm/Py3.11.6installer) 
- PyTorch 2.0.1
- ONNX 1.14.0
- argparse for command-line options

### Installing

Clone the repository and install the required Python packages:

```
git clone https://github.com/kernferm/pt-to-onnx-converter.git
cd pt-to-onnx-converter
pip install -r requirements.txt
```

### Executing Program

To convert a PyTorch model to ONNX format, run the following command:

```bash
python main.py --pt_file_path 'path/to/your/model.pt' --onnx_file_path 'path/to/save/model.onnx'
```

Ensure you replace `'path/to/your/model.pt'` and `'path/to/save/model.onnx'` with the actual paths to your PyTorch model and where you want the ONNX model saved, respectively.

## Features

- **Automatic Input Size Detection**: Automatically detects the input size of the model to facilitate the conversion process.
- **Command-line Interface**: Easy to use command-line interface for specifying input and output files.
- **Support for Various ONNX Opset Versions**: Allows specifying the ONNX opset version for compatibility with different tools and frameworks.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs or feature requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
