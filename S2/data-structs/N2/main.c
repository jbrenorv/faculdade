#include "segment_tree.h"
#include "bridges.h"

void menu();
void menu_seg_tree();
void menu_bridges();

int main()
{
    menu();
    return 0;
}

void menu_seg_tree()
{
    __uint8_t option;
    build();

    while (1)
    {
        printf("\n---------MENU---------\n\n1\t- Update\n2\t- Query\n3 (any)\t- Exit\n\n>>> ");
        scanf("%hhi", &option);

        if (option == T_UPDATE)
            update();
        else if (option == T_QUERY)
            query();
        else break;
    }
}

void menu_bridges()
{
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

void menu()
{
    
    __uint8_t option;

    while (1)
    {
        printf("\n---------MENU---------\n\n1\t- Segment Tree\n2\t- Bridges\n3 (any)\t- Exit\n\n>>> ");
        scanf("%hhi", &option);

        if (option == SEG_TREE)
            menu_seg_tree();    
        else if (option == BRIDGES)
            menu_bridges();
        else break;
    }
}
