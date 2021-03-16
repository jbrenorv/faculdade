#ifndef SEGMENT_TREE_H
#define SEGMENT_TREE_H

#include <stdio.h>

#define T_UPDATE    1
#define T_QUERY     2
#define SEG_TREE    1
#define MAXN        400
#define INF         100000
#define DIR(node)   (2*node +1)
#define ESQ(node)   (2*node)
#define MAX(a,b)    ((a>b) ? a : b)
#define MIN(a,b)    ((a<b) ? a : b)

int n;
int tree[4*MAXN];
int array[MAXN];

extern void build();
extern void update();
extern void query();
extern int min(int,int);
extern int max(int,int);

#endif
