#include "tech-oplib/src/oplib.hpp"
#include <chrono>
#include <emscripten.h>
#include <iostream>

extern "C" {
EMSCRIPTEN_KEEPALIVE
int runOnnxModel() {
  auto model = Op::Onnx::Model("model.onnx");
  auto in = Op::vecs(44100);
  auto vocals = Op::vecs(44100);
  auto remainder = Op::vecs(44100);
  Op::Wav::read("in.wav", in);
  Op::Wav::write<Op::Wav::F32>("vocals.wav", 44100, in);
  Op::Wav::write<Op::Wav::F32>("remainder.wav", 44100, in);

  auto beg = std::chrono::high_resolution_clock::now();
  for (std::size_t i = 0; i < 10; i++) {
    model.run();
  }

  auto end = std::chrono::high_resolution_clock::now();
  auto dur = std::chrono::duration_cast<std::chrono::milliseconds>(end - beg);
  std::cout << "Duration ::" << dur.count() << " milliseconds." << std::endl;
  return 0;
}
}
