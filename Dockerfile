FROM debian:bullseye-slim
RUN apt-get update -yq \
 && apt-get install \
        --yes \
        --no-install-recommends \
        ca-certificates \
        git \
        cmake \
        make \
        gcc \
        g++ \
        wget \
        meson python3 python3-setuptools python3-mako

RUN wget https://gitlab.freedesktop.org/mesa/mesa/-/archive/mesa-21.1.8/mesa-mesa-21.1.8.tar.gz -O mesa_src.tar.gz \
 && mkdir -p mesa_src \
 && tar -xzf mesa_src.tar.gz --strip 1 -C mesa_src \
 && mkdir -p mesa_build \
 && cd mesa_build \
 && meson ../mesa_src

RUN wget https://www.vtk.org/files/release/9.0/VTK-9.0.3.tar.gz -O vtk_src.tar.gz \
 && mkdir -p vtk_src \
 && tar -xzf vtk_src.tar.gz --strip 1 -C vtk_src \
 && mkdir -p vtk_build \
 && cd vtk_build \
 && cmake ../vtk_src \
    -D CMAKE_BUILD_TYPE=Release \
    -D BUILD_SHARED_LIBS:BOOL=OFF \
    -D VTK_BUILD_EXAMPLES:BOOL=OFF \
    -D VTK_ENABLE_WRAPPING:BOOL=OFF \
    -D VTK_WRAP_PYTHON:BOOL=OFF \
    -D VTK_WRAP_JAVA:BOOL=OFF \
    -D VTK_USE_X:BOOL=OFF \
    -D VTK_OPENGL_HAS_OSMESA:BOOL=ON \
    -D VTK_DEFAULT_RENDER_WINDOW_OFFSCREEN:BOOL=ON \
    -D OPENGL_gl_LIBRARY=/usr/lib/libglapi.so \
    -D OSMESA_INCLUDE_DIR=/usr/include \
    -D OSMESA_LIBRARY=/usr/lib/libOSMesa.so \
    -D CMAKE_INSTALL_PREFIX=/usr \
 && make -j \
 && cd .. \
 && rm -rf vtk_src.tar.gz \
 && cd vtk_src \
 && cd .. \
 && rm -rf vtk_src \
 && rm -rf vtk_build
