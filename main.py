import torch
import onnx
import argparse
import os
import inspect

def load_model(pt_file_path):
    model = torch.load(pt_file_path)
    model.eval()  # Set the model to evaluation mode
    return model

def detect_input_size(model):
    try:
        # Attempt to infer input size from the model's forward method
        for module in model.modules():
            if hasattr(module, 'forward'):
                sig = inspect.signature(module.forward)
                for name, param in sig.parameters.items():
                    if param.default == param.empty and param.annotation != param.empty:
                        return (1,) + tuple(param.annotation.shape)
    except:
        pass

    # Fallback: Check the model's parameters
    for name, param in model.named_parameters():
        if param.requires_grad:
            return param.size()
    raise ValueError("Unable to detect input size from the model. Please provide it manually.")

def convert_to_onnx(model, onnx_file_path):
    input_size = detect_input_size(model)
    dummy_input = torch.randn(*input_size)
    torch.onnx.export(
        model, 
        dummy_input, 
        onnx_file_path, 
        export_params=True,  # Store the trained parameter weights inside the model file
        opset_version=11,    # The ONNX version to export the model to
        do_constant_folding=True,  # Whether to execute constant folding for optimization
        input_names=['input'],   # The model's input names
        output_names=['output'],  # The model's output names
        dynamic_axes={'input': {0: 'batch_size'}, 'output': {0: 'batch_size'}}  # Variable length axes
    )
    print(f"Model successfully converted to {onnx_file_path}")

def main():
    parser = argparse.ArgumentParser(description="Convert PyTorch model to ONNX")
    parser.add_argument("pt_file_path", type=str, help="Path to the PyTorch model (.pt) file")
    parser.add_argument("onnx_file_path", type=str, help="Path to save the converted ONNX model file")
    
    args = parser.parse_args()

    if not os.path.isfile(args.pt_file_path):
        print(f"The file {args.pt_file_path} does not exist.")
        return

    model = load_model(args.pt_file_path)
    convert_to_onnx(model, args.onnx_file_path)

if __name__ == "__main__":
    main()
