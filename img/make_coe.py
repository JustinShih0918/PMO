import os
from PIL import Image

# Define paths
base_path = r"D:\Justin\HardwareDesign_workspace\PMO\img\setting"
image_path = os.path.join(base_path, 'switch1.png')
output_path = os.path.join(base_path, 'switch1.coe')

def rgb_to_16bit(r, g, b):
    r_5bit = (r >> 3) & 0x1F
    g_6bit = (g >> 2) & 0x3F
    b_5bit = (b >> 3) & 0x1F
    return (r_5bit << 11) | (g_6bit << 5) | b_5bit

# Open and process image
img = Image.open(image_path).convert('RGB')  # Convert to RGB mode
width, height = 44, 54  # Set expected dimensions

# Create COE file
with open(output_path, 'w') as f:
    # Write COE header
    f.write("memory_initialization_radix=16;\n")
    f.write("memory_initialization_vector=\n")
    
    # Process each pixel
    total_pixels = width * height
    pixel_count = 0
    
    for y in range(height):
        for x in range(width):
            pixel_count += 1
            pixel = img.getpixel((x, y))
            rgb_16bit = rgb_to_16bit(*pixel)  # Unpack RGB values
            
            # Write hex value
            if pixel_count == total_pixels:
                f.write(f"{rgb_16bit:04x};")  # Last value ends with semicolon
            else:
                f.write(f"{rgb_16bit:04x},")
            
            # Add newline every 16 values for readability
            if pixel_count % 16 == 0:
                f.write("\n")

print(f"COE file created at {output_path}")