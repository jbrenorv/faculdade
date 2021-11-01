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

Aresta *recebe_dados(int *, int *); /////////////////////////////////////////
                                    // Recebe os dados do grafo na entrada //
                                    // e carrega as variáveis              //
                                    /////////////////////////////////////////

void cria_conjunto(int);      ////////////////
int conjunto(int);            // Union find //
void une_conjuntos(int, int); ////////////////

void kruskal(Aresta *, int, int); //////////////////////////
                                  // Algoritmo de Kruskal //
                                  //////////////////////////

int compara_arestas(const void *, const void *);
void troca(int *, int *);

int main()
{
  int n, m;
  Aresta *arestas = recebe_dados(&n, &m);

  kruskal(arestas, n, m);

  return 0;
}

Aresta *recebe_dados(int *n, int *m)
{
  int i, u, v, peso;
  scanf("%i %i", n, m);
  Aresta *arestas = (Aresta *)malloc(sizeof(Aresta) * (*m));

  for (i = 0; i < *m; i++)
  {
    scanf("%i %i %i", &u, &v, &peso);
    Aresta e = {u, v, peso};
    arestas[i] = e;
  }

  return arestas;
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

