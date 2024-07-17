import torch

def load_model(pt_file_path):
    device = torch.device('cpu')  # Define the device as CPU
    model = torch.load(pt_file_path, map_location=device)  # Map model to CPU
    return model
