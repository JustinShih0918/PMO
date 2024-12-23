import os
from PIL import Image

# Define paths
base_path = r"D:\Justin\HardwareDesign_workspace\PMO\img\numbers\ver1"
image_path = os.path.join(base_path, 'output.jpg')  # Changed from output.png to output.jpg

# RGB to 16-bit conversion function
def rgb_to_16bit(r, g, b):
    r_5bit = (r >> 3) & 0x1F
    g_6bit = (g >> 2) & 0x3F
    b_5bit = (b >> 3) & 0x1F
    return (r_5bit << 11) | (g_6bit << 5) | b_5bit

# Open the image
img = Image.open(image_path)

# Open the output file
output_file = os.path.join(base_path, 'number_data.txt')
with open(output_file, 'w') as f:
    for block in range(10):  # Process each block of 54 lines
        f.write(f'parameter [15:0] step{block} [0:879] = {{\n')
        for y in range(16):
            line_data = []
            for x in range(55):
                r, g, b = img.getpixel((x, y + block * 16))
                rgb_16bit = rgb_to_16bit(r, g, b)
                line_data.append(f"16'h{rgb_16bit:04X}")
            line = ', '.join(line_data)
            if y < 15:
                f.write(f'    {line},\n')
            else:
                f.write(f'    {line}\n')
        f.write('};\n\n')

print(f"Image data has been written to {output_file}")