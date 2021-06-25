#include <stdio.h>		// printf, scanf
#include <string.h>		// memset
#include <stdlib.h>		// malloc
#include <time.h>		// clock, CLOCKS_PER_SEC
#define MAX 4001		// <!> deve ser maior que todos os pesos e valores <!>
#define INF 1e+8		// entenda infinito como inatingível

typedef struct b_tree
{
	int d;
	
	struct b_tree *pega;
	struct b_tree *pass;
} b_tree;

struct
{
	int p, v;
} itens[MAX];

int n, c_max;
int pd[MAX][MAX];

int mochila(int i, int c, b_tree *no)
{
	if (c < 0)
		return -INF;
	
	if (i >= n)
		return 0;
	
	if (pd[i][c] != -1)
		return pd[i][c];
	
	no->pega = (b_tree *) malloc(sizeof(b_tree));
	no->pass = (b_tree *) malloc(sizeof(b_tree));
	
	int pega = itens[i].v + mochila(i+1, c - itens[i].p, no->pega);
	int pass = mochila(i+1, c, no->pass);
	
	if (pega > pass)
	{
		no->d = 1;
		return pd[i][c] = pega;
	}
	
	no->d = 0;
	return pd[i][c] = pass;
}

void print_mochila(int i, b_tree *no)
{
	if (no == NULL || i >= n)
		return;
	
	if (no->d)
	{
		printf("PEGO: item: %i, valor: %i, peso: %i\t <<---\n", i,
																itens[i].v,
																itens[i].p);
		print_mochila(i+1, no->pega);
		return;
	}
	
	printf("PASS: item: %i, valor: %i, peso: %i\n", i,
													itens[i].v,
													itens[i].p);
	print_mochila(i+1, no->pass);
}

int main()
{
	long tempo;
	memset(pd, -1, MAX*MAX*sizeof(int));
	
	scanf("%i %i", &n, &c_max);
	
	for (int i = 0; i < n; i++)
		scanf("%i %i", &itens[i].p, &itens[i].v);
	
	b_tree *bt = (b_tree *) malloc(sizeof(b_tree));
	
	tempo = clock();
	int ans = mochila(0, c_max, bt);
	
	print_mochila(0, bt);
	printf("total: %i\ntempo: %lf ms\n", ans, 
		(double) (clock() - tempo) / CLOCKS_PER_SEC * 1000);
	
	return 0;
}

