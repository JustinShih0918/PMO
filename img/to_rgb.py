from PIL import Image
import sys

image_path = 'idle/idle_use.jpg'  # Replace with your image file name

img = Image.open(image_path)

# Resize the image to 44x(54*16)
img = img.resize((44, 54 * 16))

# Convert the image to RGB
img = img.convert('RGB')

# Function to convert 8-bit RGB to 16-bit RGB (5 bits for red, 6 bits for green, 5 bits for blue)
def rgb_to_16bit(r, g, b):
    r_5bit = (r >> 3) & 0x1F
    g_6bit = (g >> 2) & 0x3F
    b_5bit = (b >> 3) & 0x1F
    return (r_5bit << 11) | (g_6bit << 5) | b_5bit

# Open the output file
output_file = 'image_data.txt'
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