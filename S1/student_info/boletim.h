#ifndef _BOLETIM_H
#define _BOLETIM_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MAX 30          // maximo de alunos
#define MAX_D 20        // maximo de disciplinas por aluno
#define QTD_N 2         // quantidade de notas por disciplina
#define SOMA_PESOS 5

typedef struct discipline Discipline;

struct discipline
{
    char name[20];
    float grade[QTD_N], mp, af, mf;
    int creditos;
};

struct Student
{
    char registration[15];
    char name[20], num_diciplinas;
    int soma_creditos;
    float soma_mf_x_credito;
    Discipline discipline[MAX_D];
} student[MAX];

void new_discipline(int,int);
char *situacao(int,int,int);
void media(int,int);
int find_student();
void print_list();
void _remove();
void run_app();
void insert();
void show();
void init();
void load();
void save();
void bug();
int menu();

#endif