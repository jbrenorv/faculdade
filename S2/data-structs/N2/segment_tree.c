#include "segment_tree.h"

int n;
int tree[4*MAXN];
int array[MAXN];

void print_array();
void _build(int,int,int);
void _update(int,int,int,int,int);
int _query(int,int,int,int,int);

int min(int a, int b) {return (a < b ? a : b);}
int max(int a, int b) {return (a < b ? b : a);}

void print_array() {
    int i;

    printf("Array: ");
    
    for (i = 0; i < n; i++)
        printf("%i ", array[i]);

    printf("\n");
}

void build() {
    int i;

    printf("\nQuantos elementos na lista? (< 400)\n>>> ");
    scanf("%i", &n);

    printf("Agora insira os elementos\n>>> ");

    for (i = 0; i < n; i++)
        scanf("%i", &array[i]);
    
    _build(1,0,n-1);
    printf("Arvore construida com sucesso!\n");
}

void query() {
    int q_left, q_right;

    printf("\nInforme os extremos do intervalo de busca. (ex.: 0 %i)\n>>> ", n-1);
    scanf("%i %i", &q_left, &q_right);
    int result = _query(1, 0, n-1, q_left, q_right);

    printf("Minimo em array[%i ... %i]: %i\n", q_left, q_right, result);
}

void update() {
    int id, value;

    printf("\nInforme o indice do valor no array e o novo valor\n>>> ");
    scanf("%i %i", &id, &value);

    array[id] = value;
    _update(1, 0, n-1, id, value);
    printf("Atualizado com sucesso!\n");
    print_array();
}

void _build(int node, int left, int right) {
    if (left > right)
        return;
    
    if (left == right) {
        tree[node] = array[left];
        return;
    }

    int mid = left + (right - left)/2;

    _build(ESQ(node), left, mid);
    _build(DIR(node), mid+1, right);

    tree[node] = min(tree[ESQ(node)], tree[DIR(node)]);
}

int _query(int node, int c_left, int c_right, int q_left, int q_right) {
    // q -> query   |   c -> current

    if (q_left > q_right)
        return INF;

    if (q_left == c_left && q_right == c_right)
        return tree[node];
    
    int mid = c_left + (c_right - c_left)/2;

    return min(
        _query(ESQ(node), c_left, mid, q_left, min(mid, q_right)), 
        _query(DIR(node), mid+1, c_right, max(q_left, mid+1), q_right)
    );
}

void _update(int node, int left, int right, int id, int value) {

    if (left == right) {
        tree[node] = value;
    
    } else {

        int mid = left + (right - left)/2;

        if (id <= mid)
            _update(ESQ(node), left, mid, id, value);
        else 
            _update(DIR(node), mid+1, right, id, value);

        tree[node] = min(tree[ESQ(node)], tree[DIR(node)]);
    }
}
