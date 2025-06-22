#include "Log.h"
#include <iostream>

void InitLog() {
  Log("Initializing Log");
}

void Log(const char* message) {
  std::cout << message << std::endl;
}
