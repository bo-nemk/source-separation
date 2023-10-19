FROM debian:bookworm-slim
WORKDIR /dependencies
RUN apt-get update
RUN apt-get install python3 python3-pip git -y
RUN python3 -m pip install cmake ninja --break-system-packages
RUN git clone --recursive https://github.com/Microsoft/onnxruntime
WORKDIR /dependencies/onnxruntime
RUN git submodule sync --recursive
RUN git submodule update --init --recursive
RUN ./build.sh --config Release --build_wasm_static_lib \
    --skip_tests \
    --disable_wasm_exception_catching \
    --disable_rtti \
    --enable_wasm_threads \
    --enable_wasm_simd \
    --allow_running_as_root
RUN chmod +x /dependencies/onnxruntime/cmake/external/emsdk/emsdk_env.sh

RUN mkdir -p /toolchain/include/
RUN cp -r /dependencies/onnxruntime/include/onnxruntime/core/session/* /toolchain/include/
RUN mkdir -p /toolchain/lib/
RUN cp -r /dependencies/onnxruntime/build/Linux/Release/* /toolchain/lib/
WORKDIR /workspace
RUN echo "source /dependencies/onnxruntime/cmake/external/emsdk/emsdk_env.sh" >> /root/.bashrc
ENTRYPOINT "/bin/bash" "-c" "$0 $@"
