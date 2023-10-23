#define INCLUDE_WAV
#define INCLUDE_ONNX
#define INCLUDE_SIGNAL

#include "tech-oplib/app.cpp"
#include "tech-oplib/src/oplib.hpp"
#include <chrono>
#include <emscripten.h>
#include <iostream>

extern "C" {
EMSCRIPTEN_KEEPALIVE
int runOnnxModel() {
  std::cout << "Starting from C++..." << std::endl;
  std::cout << "fuck fuck fuck" << std::endl;
  run("in.wav", "vocals.wav", "remainder.wav");
  std::cout << "Starting from C++ OK" << std::endl;
  return 0;
}
}
