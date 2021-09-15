FROM debian:bullseye-slim
RUN apt-get update -yq \
 && apt-get install \
        --yes \
        --no-install-recommends \
        ca-certificates \
        git \
        cmake \
        gcc \
        g++ \
        wget

RUN wget https://www.vtk.org/files/release/9.0/VTK-9.0.3.tar.gz -O vtk_src.tar.gz \
 && mkdir -p vtk_src \
 && tar -xzf vtk_src.tar.gz --strip 1 -C vtk_src \
 && mkdir -p vtk_build \
 && cd vtk_build \
 && cmake ../vtk_src \
 && make  \
 && cd .. \
 && rm -rf vtk_src.tar.gz \
 && cd vtk_src \
 && cd .. \
 && rm -rf vtk_src \
 && rm -rf vtk_build
