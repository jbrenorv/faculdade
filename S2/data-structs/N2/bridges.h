#ifndef BRIDGES_H
#define BRIDGES_H

#include <stdlib.h>
#include <stdio.h>

#define BRIDGES 2

typedef struct list Item;
typedef struct graph Graph;

struct list
{
    int w;
    struct list *next;
};

struct graph
{
    Item **adj;
    int V, cnt, num_bridges;
    int *pre, *low, *parent;
};

/**
 * init_graph   - inicializa o grafo
 * add_edge     - adiciona uma aresta
 * all_bridges  - procura por pontes
 * show         - exibe o grafo com detalhes
*/

extern void init_graph(Graph *, int);
extern void add_edge(Graph *, int, int);
extern void all_bridges(Graph *);
extern void show(Graph *);

#endif
