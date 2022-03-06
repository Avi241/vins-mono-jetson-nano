sudo apt-get remove libeigen3-dev 
cd ~/Downloads/
wget -O eigen.zip https://gitlab.com/libeigen/eigen/-/archive/3.3.7/eigen-3.3.7.zip #check version
unzip eigen.zip
mkdir eigen-build && cd eigen-build
cmake ../eigen-3.3.7/ && sudo make install
pkg-config --modversion eigen3 # Check Eigen Version
cd ~/Downloads/
sudo apt-get install -y cmake libgoogle-glog-dev libatlas-base-dev libsuitesparse-dev
wget http://ceres-solver.org/ceres-solver-2.0.0.tar.gz
tar zxf ceres-solver-1.14.0.tar.gz
mkdir ceres-bin
mkdir solver && cd ceres-bin
cmake ../ceres-solver-1.14.0 -DEXPORT_BUILD_DIR=ON -DCMAKE_INSTALL_PREFIX="../solver" 
make -j3 # 6 : number of cores
sudo make install
sudo apt-get purge libopencv* python-opencv 
sudo apt-get update
sudo apt-get install -y build-essential pkg-config
sudo apt-get install -y cmake libavcodec-dev libavformat-dev libavutil-dev \
    libglew-dev libgtk2.0-dev libgtk-3-dev libjpeg-dev libpng-dev libpostproc-dev \
    libswscale-dev libtbb-dev libtiff5-dev libv4l-dev libxvidcore-dev \
    libx264-dev qt5-default zlib1g-dev libgl1 libglvnd-dev pkg-config \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev mesa-utils     

sudo apt-get install python2.7-dev python3-dev python-numpy python3-numpy
cd ~/Downloads/
wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.1.zip # check version
unzip opencv.zip
cd opencv-3.4.1/ && mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D WITH_CUDA=ON \
        -D CUDA_ARCH_BIN=6.2 \
        -D CUDA_ARCH_PTX="" \
        -D ENABLE_FAST_MATH=ON \
        -D CUDA_FAST_MATH=ON \
        -D WITH_CUBLAS=ON \
        -D WITH_LIBV4L=ON \
        -D WITH_GSTREAMER=ON \
        -D WITH_GSTREAMER_0_10=OFF \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D CUDA_NVCC_FLAGS="--expt-relaxed-constexpr" \
        -D WITH_TBB=ON \
         ../
make -j3  # running in single core is good to resolve the compilation issues         
sudo make install
cd ../../ && sudo rm -rf opencv-3.4.1 # optional (can save 10GB Disk Space)
pkg-config --modversion opencv # Check opencv Version
cd ~/Downloads/
git clone https://github.com/Avi241/vins-mono-jetson-nano.git
cd vins-mono-jetson-nano/
chmod a+x installROS.sh setupCatkinWorkspace.sh
./installROS.sh 
./setupCatkinWorkspace.sh
cd ~/catkin_ws/src && git clone https://github.com/Avi241/vision_opencv
cd .. && catkin_make -j3
cd ~/catkin_ws/src && git clone https://github.com/HKUST-Aerial-Robotics/VINS-Mono
sudo apt-get install ros-melodic-tf
sudo apt-get install ros-melodic-image-transport
sudo apt-get install ros-melodic-rviz
cd ~/catkin_ws/
source devel/setup.bash
catkin_make -j3
