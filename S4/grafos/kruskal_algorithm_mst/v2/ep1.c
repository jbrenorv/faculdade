/**
 * INTEGRANTES
 * 
 * João Breno Rodrigues Venancio
 * Francisco Davi Camilo Ribeiro
 * Francisco Diego Melo do Nascimento
 * Francisco Antônio Sampaio Fontenele
 * 
 * O PROGRAMA
 * Recebe um grafo conexo, não direcionado e com arestas de peso não negativo. 
 * Retorna o custo e as arestas da árvore geradora de custo mínimo deste grafo
*/

#include <stdio.h>
#include <stdlib.h>

int *pai, *rank;

typedef struct    //////////////////////////////////
{                 // Estrutura para aresta (u, v) //
  int u, v, peso; // com peso [peso]              //
} Aresta;         //////////////////////////////////

void cria_conjunto(int);      ////////////////
int conjunto(int);            // Union find //
void une_conjuntos(int, int); ////////////////

void kruskal(Aresta *, int, int); ////////////////////////////////////
                                  // Algoritmo de Kruskal           //
                                  // Entrada: a lista de arestas,   //
                                  //          o numero de vertices  //
                                  //          e o numero de arestas //
                                  ////////////////////////////////////

int compara_arestas(const void *, const void *);
void troca(int *, int *);

int main(int argc, char **argv)
{
  int i;          // contador, for
  int n, m;       // n: numero de vertices ; m: numero de arestas
  int u, v, peso; // aresta (u, v, w)

  char *file_name;
  FILE *file;

  Aresta *arestas;

  if (argc > 1)
  {
    file_name = argv[1];

    if ((file = fopen(file_name, "r")) != NULL)
    {
      fscanf(file, "%i %i", &n, &m);
      arestas = (Aresta *)malloc(m * sizeof(Aresta));

      for (i = 0; i < m; i++)
      {
        fscanf(file, "%i %i %i", &u, &v, &peso);
        Aresta e = {u, v, peso};
        arestas[i] = e;
      }

      fclose(file);
      kruskal(arestas, n, m);
    }
    else
    {
      printf("Falha ao tentar abrir arquivo.\n");
    }
  }
  else
  {
    printf("Nome do arquivo não fornecido.\n");
  }

  return 0;
}

void troca(int *a, int *b)
{
  int aux = *a;
  *a = *b;
  *b = aux;
}

void cria_conjunto(int v)
{
  pai[v] = v;
  rank[v] = 0;
}

int conjunto(int v)
{
  if (v == pai[v])
    return v;
  return pai[v] = conjunto(pai[v]);
}

void une_conjuntos(int a, int b)
{
  a = conjunto(a);
  b = conjunto(b);

  if (a != b)
  {
    if (rank[a] < rank[b])
      troca(&a, &b);

    pai[b] = a;

    if (rank[a] == rank[b])
      rank[a]++;
  }
}

int compara_arestas(const void *a, const void *b)
{
  return (((Aresta *)a)->peso - ((Aresta *)b)->peso);
}

void kruskal(Aresta *arestas, int n, int m)
{
  printf("Árvore geradora de custo mínimo:");
  int i, custo = 0;

  pai = (int *)malloc((n + 1) * sizeof(int));
  rank = (int *)malloc((n + 1) * sizeof(int));

  for (i = 0; i <= n; i++)
    cria_conjunto(i);

  qsort(arestas, m, sizeof(Aresta), compara_arestas);

  for (i = 0; i < m; i++)
  {
    if (conjunto(arestas[i].u) != conjunto(arestas[i].v))
    {
      custo += arestas[i].peso;
      une_conjuntos(arestas[i].u, arestas[i].v);

      printf(" (%i, %i)", arestas[i].u, arestas[i].v);
    }
  }

  printf("\nCusto: %i\n", custo);
}

