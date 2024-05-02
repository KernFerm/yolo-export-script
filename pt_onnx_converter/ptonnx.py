import torch    # PyTorch library
import torchvision  # PyTorch vision library

# Load the PyTorch model
model = torchvision.models.resnet18(pretrained=True)    # Load the pretrained model

# Set the model to evaluation mode
model.eval()    # Set the model to evaluation mode

# Define example input tensor (adjust size and shape according to your model)
dummy_input = torch.randn(1, 3, 320, 320)   # Example input tensor

# Export the model to ONNX format
torch.onnx.export(model,                     # PyTorch model    
                  dummy_input,               # Example input tensor (dummy input)
                  "path/to/your/output/model.onnx",  # Output ONNX file path    
                  export_params=True,       # Export model parameters   
                  opset_version=11,         # ONNX opset version            
                  do_constant_folding=True, # Optimize constant folding 
                  input_names=['input'],    # Input names                  
                  output_names=['output'])  # Output names          
