#include "bridges.h"

void insert(Item *, int);
void dfs(Graph *, int);
void imprime(Item *);

void init_graph(Graph *G, int V)
{
    G->V = V;
    G->adj = malloc(V * sizeof(Item *));
    
    G->pre = (int *) malloc(V * sizeof(int));
    
    G->low = (int *) malloc(V * sizeof(int));
    G->parent = (int *) malloc(V * sizeof(int));

    G->cnt = 0;
    G->num_bridges = 0;

    while (V-- > 0)
    {
        G->adj[V] = (Item *) malloc(sizeof(Item));
        G->adj[V]->next = NULL;
    }
}

void add_edge(Graph *G, int v, int w)
{
    insert(G->adj[v], w);
    insert(G->adj[w], v);
}

void insert(Item *begin, int w)
{
    Item *new;
    new = (Item *) malloc(sizeof(Item));
    new->w = w;
    new->next = begin->next;
    begin->next = new;
}

void all_bridges(Graph *G) {
    int v;

    for (v = 0; v < G->V; v++)
        G->pre[v] = -1;

    for (v = 0; v < G->V; v++)
        if (G->pre[v] == -1) {
            G->parent[v] = v;
            dfs(G, v);
        }
}

void dfs(Graph *G, int v) {
    Item *p;
    int w;
    G->pre[v] = G->cnt++;
    G->low[v] = G->pre[v];

    for (p = G->adj[v]->next; p != NULL; p = p->next) {
        if (G->pre[w = p->w] == -1) {
            G->parent[w] = v;
            dfs(G, w);

            // min{low[w] | w eh um descendente direto na arvore de DFS}
            if (G->low[v] > G->low[w]) G->low[v] = G->low[w];

            // pre[w] eh o minimo, logo nao existe arco de retorno
            if (G->low[w] == G->pre[w]) {
                G->num_bridges++;
                printf("%i-%i\n", v, w);
            }
        } 
        // min{pre[w] | existe uma back-edge v-w}
        else if (w != G->parent[v] && G->low[v] > G->pre[w])
            G->low[v] = G->pre[w];
    }
}

void show(Graph *G)
{
    int v;

    for (v = 0; v < G->V; v++)
    {
        printf("%i ( parent: %i, pre: %i , low: %i ):\t",
            v, G->parent[v], G->pre[v], G->low[v]);
        
        imprime(G->adj[v]);
    }
}

void imprime(Item *ini)
{
    Item *p;
    for (p = ini->next; p != NULL; p = p->next) {
        printf ("%d\t", p->w);
    }
    printf ("\n");
}
