#include "segment_tree.h"
#include "bridges.h"

void menu_seg_tree() {
    int option;

    build();

    while (1) {
    
        printf("\n----MENU SEG TREE----\n1 - update\n2 - query\n3 - exit\n>>> ");
        scanf("%i", &option);

        if (option == 1)
            update();
        else if (option == 2)
            query();
        else break;
    }
}

void menu_bridges() {
    printf("\nCriando grafo...\n");
    Graph *G = malloc(sizeof(Graph));
    
    printf("Inicializando...\n");
    init_graph(G, 11);
    
    printf("Adicionando arestas...\n");
    add_edge(G, 3, 8);
    add_edge(G, 2, 3);
    add_edge(G, 0, 2);
    add_edge(G, 0, 3);
    add_edge(G, 2, 8);
    add_edge(G, 1, 8);
    add_edge(G, 8, 10);

    add_edge(G, 10, 4);
    add_edge(G, 10, 7);
    add_edge(G, 4, 9);
    add_edge(G, 9, 5);
    add_edge(G, 9, 6);
    add_edge(G, 5, 6);
    add_edge(G, 4, 7);

    printf("Procurando pontes...\n\n");
    all_bridges(G);

    printf("%i ponte(s) encontrada(s)\n%i vertices processados\n",
        G->num_bridges, G->cnt);

    printf("\nGrafo:\n");
    show(G);
}

void menu() {
    
    int option;

    while (1) {
    
        printf("\n----MENU----\n1 - Segment Tree\n2 - Bridges\n3 - exit\n>>> ");
        scanf("%i", &option);

        if (option == 1)
            menu_seg_tree();
        else if (option == 2)
            menu_bridges();
        else break;
    }
}

int main() {

    menu();

    return 0;
}