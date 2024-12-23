import os

# Define base path
base_path = r"D:\Justin\HardwareDesign_workspace\PMO\img\numbers\ver1"
os.chdir(base_path)

from PIL import Image
bg = Image.new('RGB',(55, 16*10), '#000000')  # 產生一張 32*512 的全黑圖片
for i in range(0,10):
    img = Image.open(f'{i}.png')  # 開啟圖片
    img = img.resize((55, 16))  # 重新設定大小
    x = (i)
    bg.paste(img,(0, x*16))   # 貼上圖片

# Save with full path
output_path = os.path.join(base_path, 'output.jpg')
bg.save(output_path)