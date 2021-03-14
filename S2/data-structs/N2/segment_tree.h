#ifndef SEGMENT_TREE_H
#define SEGMENT_TREE_H

#include <stdio.h>

#define MAXN 400
#define INF 100000
#define DIR(node) (2*node +1)
#define ESQ(node) (2*node)

extern int n;
extern int tree[4*MAXN];
extern int array[MAXN];

extern void build();
extern void update();
extern void query();
extern int min(int,int);
extern int max(int,int);

#endif