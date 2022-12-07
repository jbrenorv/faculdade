#include "BasicSuffixArray.h"

void setup() {
  Serial.begin(9600);
  
  while (Serial.available()) ;

  char s[N+1];
  int p[N+1];

  generateRandomString(s);
  buildSuffixArray(p, s);
  printArray(p);
}

void loop() { }

void printArray(int* array) {
  Serial.print(array[0]);
  for (int i = 1; i < N; ++i) {
    Serial.print(' ');
    Serial.print(array[i]);
  }
  Serial.println();
}

void generateRandomString(char *s) {
  for (int i = 0; i < N; i++) {
    s[i] = char(((random() % 26) + 97)); // gera uma letra em [a-z]
    Serial.print(s[i]);
  }
  Serial.println();
}
