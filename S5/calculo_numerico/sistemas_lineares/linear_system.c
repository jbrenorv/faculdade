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
  linear_system->M = (float **)malloc((n + 1) * sizeof(float));
  if (linear_system->M == NULL)
  {
    printf("Nao foi possivel alocar memoria\n");
    return NULL;
  }

  for (int i = 0; i < n; i++)
  {
    linear_system->M[i] = (float *)malloc((n + 2) * sizeof(float));
    if (linear_system->M[i] == NULL)
    {
      printf("Nao foi possivel alocar memoria\n");
      return NULL;
    }

    for (int j = 0; j < (n + 1); j++)
    {
      number_of_values_read = fscanf(file, "%f", &(linear_system->M[i][j]));
      if (number_of_values_read <= 0)
      {
        printf("Arquivo com conteudo estruturado incorretamente\n");
        return NULL;
      }
    }
  }

  return linear_system;
}

void gauss_method(LinearSystem *ls)
{
  int i, j, k;
  for (i = 0; i < (ls->n - 1); i++)
  {
    if (ls->M[i][i] == 0)
    {
      j = i + 1;
      while (j < ls->n && ls->M[j][i] == 0)
        j++;
      if (j < ls->n)
      {
        float *aux = ls->M[i];
        ls->M[i] = ls->M[j];
        ls->M[j] = aux;
      }
    }

    if (ls->M[i][i] != 0)
    {
      for (j = i + 1; j < ls->n; j++)
      {
        float mult = -ls->M[j][i] / ls->M[i][i];
        ls->M[j][i] = 0;
        for (k = i + 1; k < (ls->n + 1); k++)
        {
          ls->M[j][k] = ls->M[j][k] + mult * ls->M[i][k];
        }
      }
    }
  }
}

void show_extended_coefficient_matrix(LinearSystem *ls)
{
  int i, j;
  for (i = 0; i < ls->n; i++)
  {
    for (j = 0; j < (ls->n + 1); j++)
    {
      printf("%.2f\t", ls->M[i][j]);
    }
    printf("\n");
  }
  printf("\n");
}

void solve_linear_system_ut(LinearSystem *ls)
{
  int i, j;

  if (ls->X != NULL)
  {
    return;
  }

  ls->X = (float *)malloc((ls->n + 1) * sizeof(float));

  for (i = (ls->n - 1); i >= 0; i--)
  {
    float sum = 0;
    for (j = (i + 1); j < ls->n; j++)
    {
      sum = sum + ls->M[i][j] * ls->X[j];
    }

    if (ls->M[i][i] == 0)
    {
      if (ls->M[i][ls->n] == sum)
      {
        ls->X[i] = 0;
        ls->type = Undetermined;
      }
      else
      {
        ls->type = Incompatible;
        return;
      }
    }
    else
    {
      ls->X[i] = (ls->M[i][ls->n] - sum) / ls->M[i][i];
    }
  }
}

void show_solution(LinearSystem *ls)
{
  int i;
  for (i = 0; i < ls->n; i++)
  {
    printf("%.2f ", ls->X[i]);
  }
  printf("\n\n");
}
