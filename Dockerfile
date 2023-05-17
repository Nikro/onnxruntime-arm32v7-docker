FROM arm32v7/fedora:34

# QEMU.
COPY ./qemu-arm-static /usr/bin/qemu-arm-static

# Install build tools.
RUN dnf install -y cmake make gcc-c++ python3-devel openssl openssl-devel patch diffutils python3-numpy
RUN pip3 install packaging wheel

# Copy fedora installation script.
ADD . /code
RUN chmod +x /code/dockerfiles/scripts/install_fedora_arm32.sh
RUN /code/dockerfiles/scripts/install_fedora_arm32.sh

# Copy and apply the patch
WORKDIR /code
RUN patch -p1 < /code/compress_overflow.patch

# Building onnxruntime
RUN ./build.sh --allow_running_as_root --skip_submodule_sync --config Release --build_wheel --update --build --parallel --cmake_extra_defines ONNXRUNTIME_VERSION=$(cat ./VERSION_NUMBER) --cmake_extra_defines CMAKE_VERBOSE_MAKEFILE=ON
