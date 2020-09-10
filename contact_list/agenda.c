#include <stdio.h>
#include <stdlib.h>

#include "functions.h"

/*
    get_input()    --> Apresenta um MENU com opcoes
    header(int op) --> Formatacao de saida para dois cabecalhos
    view(int op)   --> Mostra todos os contatos
    add()          --> Adiciona um novo contato ao final da lista
    delete()       --> Deleta um contato
    err( args )    --> Captura e exibe um erro
*/

void run_app(void);

int main(void){

    run_app();
    system("clear");

    return 0;
}

void run_app(){

    system("clear");
    
    char ch;
    
    do{
        header(1);
        printf("\nInforme o numero da opcao desejada: ");
        ch = getchar();

        switch (ch){
        
        case '1': view(1);
            break;
        case '2': add();
            break;
        case '3': erase();
            break;
        
        default:
            ch = 's';
            break;
        }
        
    } while(ch != 's');

}
