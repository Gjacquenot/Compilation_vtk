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
        meson

RUN wget https://www.vtk.org/files/release/9.0/VTK-9.0.3.tar.gz -O vtk_src.tar.gz \
 && mkdir -p vtk_src \
 && tar -xzf vtk_src.tar.gz --strip 1 -C vtk_src \
 && mkdir -p vtk_build \
 && cd vtk_build \
 && cmake ../vtk_src \
    -D CMAKE_BUILD_TYPE=Release \
    -D BUILD_SHARED_LIBS=OFF \
    -D VTK_WRAP_PYTHON=OFF \
    -D VTK_WRAP_JAVA=OFF \
    -D VTK_USE_X=OFF \
    -D VTK_OPENGL_HAS_OSMESA=ON \
    -D VTK_DEFAULT_RENDER_WINDOW_OFFSCREEN=ON \
    -D OPENGL_gl_LIBRARY=/usr/lib/libglapi.so \
    -D OSMESA_INCLUDE_DIR=/usr/include \
    -D OSMESA_LIBRARY=/usr/lib/libOSMesa.so \
    -D CMAKE_INSTALL_PREFIX=/usr \
 && make  \
 && cd .. \
 && rm -rf vtk_src.tar.gz \
 && cd vtk_src \
 && cd .. \
 && rm -rf vtk_src \
 && rm -rf vtk_build
