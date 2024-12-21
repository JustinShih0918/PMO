import os
os.chdir('img/idle')  # Colab 換路徑使用

from PIL import Image
bg = Image.new('RGB',(32, 512), '#000000') # 產生一張 32*512 的全黑圖片
for i in range(1,17):
    img = Image.open(f'idle{i}.png')  # 開啟圖片
    x = (i-1)
    bg.paste(img,(0, x*32))   # 貼上圖片

bg.save('oxxostudio.jpg')