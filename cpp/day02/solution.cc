#include <fstream>
#include <stdio.h>
#include <string>
#include <sstream>
#include <unordered_map>
#include <vector>

/**
 * Read the file into a string.
 *
 */
std::string readFile() {
  std::ifstream ifs("data.txt");
  std::string content(
    (std::istreambuf_iterator<char>(ifs) ),
    (std::istreambuf_iterator<char>() )
  );

  return content;
}

/**
 * Parse the string data that comes in.
 *
 * Because we're expecting a CSV of string data, we're going to skip the ','.
 */
std::vector<int> parseStr(std::string data) {
  std::vector<int> ret;

  std::stringstream ss(data);

  for (int i; ss >> i;) {
    ret.push_back(i);
    if (ss.peek() == ',') {
      ss.ignore();
    }
  }

  return ret;
}

/**
 * It would've helped if I read the bold text in my face to preprocess the data.
 *
 * > ... before running the program, replace 1 with the value 12 and replace
 * > 2 with the value 2.
 * My fault; next time read carefully. :(
 */
std::vector<int> preProcess(std::vector<int> data) {
  data[1] = 12;
  data[2] = 2;

  return data;
}

int main() {
  std::string str = readFile();
  std::vector<int> data = parseStr(str);
  data = preProcess(data);
  for(std::size_t i = 0; i < data.size(); i++) {
    printf("%d\n", data[i]);
  }
  std::size_t i = 0;

  while (i < data.size()) {
    int x = data[i + 1];
    int y = data[i + 2];
    int dest = data[i + 3];

    // Addition
    if (data[i] == 1) {
      data[dest] = data[x] + data[y];
      i += 4;
    }
    // Multiplication
    else if (data[i] == 2) {
      data[dest] = data[x] * data[y];
      i += 4;
    }
    // Terminate
    else if (data[i] == 99) {
      printf("%d\n", data[0]);
      break;
    }
  }

  return 0;
}
