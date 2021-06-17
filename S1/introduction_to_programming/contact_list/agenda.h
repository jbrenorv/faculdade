#ifndef _AGENDA_H
#define _AGENDA_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LENGTH_LINE 40

typedef enum header_op HeaderOp; 
typedef enum view_op ViewOp;
typedef enum erro_ao ErroAo;

enum view_op {
    FROM_ERASE, FROM_MENU
};

enum erro_ao {
    ABRIR, REMOVER, RENOMEAR, CRIAR
};

enum header_op {
    LISTA, MENU, DONE
};

/**
 * header(int op) --> Formatacao de saida para dois cabecalhos
 * view(int op)   --> Mostra todos os contatos
 * add()          --> Adiciona um novo contato ao final da lista
 * err( args )    --> Captura e exibe um erro
*/

void err(const char *, char *, ErroAo);
void header(HeaderOp);
void view(ViewOp);
void run_app();
void erase();
void add();

#endif
