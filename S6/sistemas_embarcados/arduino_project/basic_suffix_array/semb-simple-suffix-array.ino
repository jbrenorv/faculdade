#include "Pair.h"
#include "BasicSuffixArray.h"

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
  while (Serial.available()) ;

  String s = "ababba";
  int n = s.length();
  int p[n+1];

  buildSuffixArray(p, s);
  printArray(p, n+1);
}

void loop() {
  // put your main code here, to run repeatedly:

}

void printArray(int* array, int arrayLength) {
  Serial.print(array[0]);
  for (int i = 1; i < arrayLength; ++i) {
    Serial.print(' ');
    Serial.print(array[i]);
  }
  Serial.println();
}

