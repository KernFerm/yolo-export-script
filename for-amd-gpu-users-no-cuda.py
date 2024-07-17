# add this if you have no cuda aka nvidia for AMD gpu users to use cpu - put below in top part of main.py 

# you will see how to place it, make sure to remove the old part with the new and remember to remove any duplicate import statements, if necessary.

import torch

def load_model(pt_file_path):
    device = torch.device('cpu')  # Define the device as CPU
    model = torch.load(pt_file_path, map_location=device)  # Map model to CPU
    return model
