import os
from PIL import Image

# Get the folder name from user input
a = input("Enter the folder name: ")

# Change directory to the images folder
img_folder = a  # Change this line
os.chdir(img_folder)

# Create a new blank image to paste the images onto
bg_width = 44
bg_height = 54 * 16  # 16 images stacked vertically
bg = Image.new('RGB', (bg_width, bg_height))

# Paste each image onto the background image
for i in range(1, 17):
    img_name = f'{a}{i}.png'  # Assuming images are named like 'idle1.png', 'idle2.png', etc.
    img = Image.open(img_name)
    img = img.resize((bg_width, 54))  # Resize each image to 44x54
    y_offset = (i - 1) * 54
    bg.paste(img, (0, y_offset))

# Save the combined image
output_image_name = f'{a}_use.jpg'
bg.save(output_image_name)

# Process the combined image to generate Verilog parameters
img = bg.convert('RGB')

# Function to convert 8-bit RGB to 16-bit RGB
def rgb_to_16bit(r, g, b):
    r_5bit = (r >> 3) & 0x1F
    g_6bit = (g >> 2) & 0x3F
    b_5bit = (b >> 3) & 0x1F
    return (r_5bit << 11) | (g_6bit << 5) | b_5bit

# Open the output file
output_file = f'{a}_data.txt'
with open(output_file, 'w') as f:
    for block in range(16):  # Process each block of 54 lines
        f.write(f'parameter [15:0] step{block} [0:2375] = {{\n')
        for y in range(54):
            line_data = []
            for x in range(44):
                r, g, b = img.getpixel((x, y + block * 54))
                rgb_16bit = rgb_to_16bit(r, g, b)
                line_data.append(f"16'h{rgb_16bit:04X}")
            line = ', '.join(line_data)
            if y < 53:
                f.write(f'    {line},\n')
            else:
                f.write(f'    {line}\n')
        f.write('};\n\n')  # Close the parameter block and add a blank line

print(f"Image data has been written to {output_file}")