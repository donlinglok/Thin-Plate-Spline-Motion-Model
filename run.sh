python setting.py

rm -rf frames
mkdir frames
ffmpeg -i generated.mp4 frames/out%03d.png
#rm frames.zip
#zip -r frames.zip frames/

rm -rf fixed
mkdir fixed

#installing the dependencies
# Install pytorch
# pip install torch torchvision


# Install basicsr - https://github.com/xinntao/BasicSR
# We use BasicSR for both training and inference. 
# Set BASICSR_EXT=True to compile the cuda extensions in the BasicSR - It may take several minutes to compile, please be patient.
#BASICSR_EXT=True pip install basicsr


# Install facexlib - https://github.com/xinntao/facexlib
# We use face detection and face restoration helper in the facexlib package
# pip install facexlib
# mkdir -p /usr/local/lib/python3.7/dist-packages/facexlib/weights  # for pre-trained models


# rm -rf GFPGAN
# git clone https://github.com/TencentARC/GFPGAN.git
cd GFPGAN

# install extra requirements
# pip install -r requirements.txt

# python setup.py develop

# # If you want to enhance the background (non-face) regions with Real-ESRGAN,
# # you also need to install the realesrgan package
# pip install realesrgan


# #loading the pretrained GAN Models
# wget https://github.com/TencentARC/GFPGAN/releases/download/v0.1.0/GFPGANv1.pth -P experiments/pretrained_models


python inference_gfpgan.py -i ../frames -o ../fixed --aligned

cd ..

#rm fixed.zip
#zip -r fixed.zip fixed/restored_faces

ffmpeg -framerate 20 -i 'fixed/restored_faces/out%3d_00.png' \
  -c:v libx264 -pix_fmt yuv420p out.mp4