import torch
import torch.onnx
import argparse

def load_model(pt_file_path):
    device = torch.device('cpu')
    model = torch.load(pt_file_path, map_location=device)
    if isinstance(model, dict):  # Check if the loaded model is a state_dict
        model = torch.nn.Module()  # Create a generic module
        model.load_state_dict(model)  # Load the state dictionary into the module
    return model

def detect_input_size(model):
    for name, param in model.named_parameters():
        if 'weight' in name and len(param.size()) > 1:
            return param.size()

def convert_to_onnx(model, onnx_file_path):
    input_size = detect_input_size(model)
    dummy_input = torch.randn(1, *input_size[1:])
    torch.onnx.export(model, dummy_input, onnx_file_path)

def main():
    parser = argparse.ArgumentParser(description="Convert PyTorch model to ONNX")
    parser.add_argument('pt_file_path', type=str, help='Path to the PyTorch model file')
    parser.add_argument('onnx_file_path', type=str, help='Path to save the ONNX model file')
    args = parser.parse_args()

    model = load_model(args.pt_file_path)
    convert_to_onnx(model, args.onnx_file_path)

if __name__ == '__main__':
    main()
