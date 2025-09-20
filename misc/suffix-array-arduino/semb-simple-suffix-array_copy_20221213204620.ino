/*
* [T2] Microcontrolador - Desenvolvimento de SW embarcado (PARTE 2)
* Sistemas embarcados 2022.2 - Engenharia da Computacao IFCE
* Equipe Joao Breno Rodrigues Venancio e Maria Eduarda Caetano da Silva
*
* Migrar codigo feito no linux para o Arduino UNO
*/

#include "BasicSuffixArray.h"

void setup() {
  Serial.begin(9600);

  while (Serial.available()) ;

  // para guardar o texto de entrada
  char s[n+1];
  // para guardar o suffix array resultante
  int p[n+1];

  // gera uma cadeia de caracteres de tamanho n armandando em s
  generateRandomString(s);

  // encontra o suffix array. ao final na execucao, o array p guardara os sufixos em ordem
  buildSuffixArray(p, s);

  // imprime o suffix array no monitor serial
  printArray(p);
}

void loop() {
  // put your main code here, to run repeatedly:

}

void printArray(int* array) {
  Serial.print(array[0]);
  for (int i = 1; i < n; ++i) {
    Serial.print(' ');
    Serial.print(array[i]);
  }
  Serial.println();
}

void generateRandomString(char *s) {
  for (int i = 0; i < n-1; i++) {
    s[i] = char(((random() % 26) + 97)); // gera uma letra em [a-z]
    Serial.print(s[i]);
  }
  Serial.println();
}
