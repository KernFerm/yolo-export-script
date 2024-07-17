import torch    # PyTorch library
import torchvision  # PyTorch vision library

# Check if CUDA or ROCm is available and set the device accordingly
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f'Using device: {device}')

# Load the PyTorch model architecture
model = torchvision.models.resnet18(pretrained=False)  # Use the appropriate architecture

# Load the model state dictionary from the .pt file
model.load_state_dict(torch.load("path/to/your/model_checkpoint.pt", map_location=device))

# Move the model to the device
model.to(device)

# Set the model to evaluation mode
model.eval()    # Set the model to evaluation mode

# Define example input tensor (adjust size and shape according to your model)
dummy_input = torch.randn(1, 3, 320, 320).to(device)   # Example input tensor

# Export the model to ONNX format
torch.onnx.export(model,                     # PyTorch model    
                  dummy_input,               # Example input tensor (dummy input)
                  "path/to/your/output/model.onnx",  # Output ONNX file path    
                  export_params=True,       # Export model parameters   
                  opset_version=11,         # ONNX opset version            
                  do_constant_folding=True, # Optimize constant folding 
                  input_names=['input'],    # Input names                  
                  output_names=['output'])  # Output names

