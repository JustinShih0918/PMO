from PIL import Image

# Load the image
image_path = 'idle/idle_use.jpg'
img = Image.open(image_path)

# Resize the image to 132x162*16
img = img.resize((132, 162 * 16))

# Convert the image to RGB
img = img.convert('RGB')

# Function to convert 8-bit RGB to 6-bit RGB
def rgb_to_18bit(r, g, b):
    r_6bit = (r >> 2) & 0x3F
    g_6bit = (g >> 2) & 0x3F
    b_6bit = (b >> 2) & 0x3F
    return (r_6bit << 12) | (g_6bit << 6) | b_6bit

# Open the output file
output_file = 'image_data.txt'
with open(output_file, 'w') as f:
    for block in range(16):  # Process each block of 162 lines
        for y in range(162):
            line_data = []
            for x in range(132):
                r, g, b = img.getpixel((x, y + block * 162))
                rgb_18bit = rgb_to_18bit(r, g, b)
                line_data.append(f"16'd{rgb_18bit:05X}")
            f.write(", ".join(line_data) + ",\n")
        f.write("\n")  # Add a blank line to separate blocks

print(f"Image data has been written to {output_file}")