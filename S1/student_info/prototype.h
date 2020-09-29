#ifndef PROTOTYPE_H
#define PROTOTYPE_H

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <math.h>

    #define MAX 30  // maximo de alunos
    #define MAX_D 20 // maximo de disciplinas por aluno
    #define QTD_N 2 // quantidade de notas por disciplina
    #define SOMA_PESOS 5

    const char *file_name = "dados";

    typedef struct {
        char name[20];
        float grade[QTD_N], mp, af, mf;
        int creditos;
    } Discipline;

    struct Student {
        char registration[15];
        char name[20], num_diciplinas;
        int soma_creditos;
        float soma_mf_x_credito;
        Discipline discipline[MAX_D];
    } student[MAX];

    void show(), insert(), _remove(), new_discipline(int,int);
    void init(), load(), run_app(), save(), bug();
    void media(int,int), print_list();
    int menu(), find_student();
    char *situacao(int,int,int);

#endif