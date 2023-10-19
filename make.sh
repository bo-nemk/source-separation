source /dependencies/onnxruntime/cmake/external/emsdk/emsdk_env.sh
mkdir __build
cd __build
cp ../model.onnx .
em++ \
    -std=c++20 \
    -I/toolchain/include \
    -L/toolchain/lib \
    -O3 \
    -lonnxruntime_webassembly \
    -sNO_DISABLE_EXCEPTION_CATCHING \
    -sNO_EXIT_RUNTIME=1 \
    -sALLOW_MEMORY_GROWTH \
    -sWASM=1 \
    -sEXPORT_NAME=OnnxModule \
    -sFORCE_FILESYSTEM=1 \
    -o output.js \
    -s EXPORTED_FUNCTIONS="['_runOnnxModel']" \
    -DINCLUDE_ONNX \
    -DINCLUDE_WAV \
    --preload-file model.onnx \
    ../app.cpp
