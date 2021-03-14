#ifndef BRIDGES_H
#define BRIDGES_H

#include <stdlib.h>
#include <stdio.h>

struct list
{
    int w;
    struct list *next;
};

//Lista encadeada para matriz de adjacencia
typedef struct list Item;

struct graph
{
    int V;
    Item **adj;
    
    // para guardar o tempo de entrada de cada vertice na dfs
    int *pre;
    
    // para cada vertice v, guarda min{pre[w] | existe um caminho v..w ... }
    int *low;
    int *parent;
    
    // auxiliar para determinar os tempos de entrada
    int cnt;
    int num_bridges;
};

typedef struct graph Graph;

//recebe um ponteiro para Graph e a quantidade de vertices
extern void init_graph(Graph *, int);

//Recebe inteiros u e v e adiciona a aresta u-v
extern void add_edge(Graph *, int, int);

//Procura por pontes e mostra caso existam
extern void all_bridges(Graph *);

//Impreme a vizinhaca de cada vertice do grafo
extern void show(Graph *);
#endif