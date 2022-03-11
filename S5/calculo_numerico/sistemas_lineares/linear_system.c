#include "linear_system.h"
#include <stdio.h>
#include <stdlib.h>

LinearSystem *make_linear_system_from_file(char *filename)
{
  FILE *file;
  if ((file = fopen(filename, "r")) == NULL)
  {
    printf("Nao foi possivel abrir o arquivo %s\n", filename);
    return NULL;
  }

  int n;
  int number_of_values_read = fscanf(file, "%i", &n);
  if (number_of_values_read <= 0)
  {
    printf("Arquivo com conteudo estruturado incorretamente\n");
    return NULL;
  }

  LinearSystem *linear_system = (LinearSystem *)malloc(sizeof(LinearSystem));
  linear_system->n = n;
  linear_system->extended_matrix = (float *)malloc((n + 2) * (n + 1) * sizeof(float));
  if (linear_system->extended_matrix == NULL)
  {
    printf("Nao foi possivel alocar memoria\n");
    return NULL;
  }

  int i = 0;
  while (i < (n + 1) * n)
  {
    number_of_values_read = fscanf(file, "%f", &(linear_system->extended_matrix[i]));
    if (number_of_values_read <= 0)
    {
      printf("Arquivo com conteudo estruturado incorretamente\n");
      return NULL;
    }
    i++;
  }

  return linear_system;
}

void solve_linear_system_ut(LinearSystem *linear_system);
