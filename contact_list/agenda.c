#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define length_line 40

/*
    get_input()    --> Apresenta um MENU com opcoes
    header(int op) --> Formatacao de saida para dois cabecalhos
    view(int op)   --> Mostra todos os contatos
    add()          --> Adiciona um novo contato ao final da lista
    delete()       --> Deleta um contato
    err( args )    --> Captura e exibe um erro
*/

void get_input(), header(int op);
void view(int op), add(), delete();
void err(char *arq, char *func, int n);

char *file_name = "agenda";

int main(){

    system("clear");
    get_input();

    printf("\n");
    system("clear");

    return 0;
}

void get_input(){
    
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
        case '3': delete();
            break;
        
        default:
            ch = 's';
            break;
        }
        
    } while(ch != 's');

}

void view(int op){

    system("clear");

    FILE *fp;
    char name[41], num[41], ch;
    unsigned line = 1;

    if((fp = fopen(file_name, "a+")) == NULL){
        err(file_name, "view", 1);
    }

    header(0);

    while (fgets(name, length_line, fp) != NULL){

        fgets(num, length_line, fp);

        name[strlen(name)-1] = '\0';
        num[strlen(num)-1] = '\0';

        printf("|%4d%4s%20s%8s%20s%5s\n", line++, "|", name, "|", num, "|");
    }
    printf("\033[1m|-------|---------------------------|------------------------|\033[0m\n\n");
    fclose(fp);

    if( op ){
        printf("Precione \033[1;43mENTER\033[0m para voltar ao MENU. ");
        getchar(); getchar();
        system("clear");
    }
}

void add(){
    system("clear");

    FILE *fp;
    char name[41], num[41];

    if((fp = fopen(file_name, "a")) == NULL){
        err(file_name, "add", 1);
    }

    getchar();
    printf("\nNome: "); fgets(name, sizeof(name), stdin);
    printf("Numero: "); fgets(num,  sizeof(num),  stdin);

    if( !(strlen(name) < 2 || strlen(num) < 2) ){
        fputs(name, fp);
        fputs(num, fp);
    }
    
    fclose(fp);

    header(2);
    
    system("clear");
}

void delete(){
    
    view(0);

    FILE *file, *new_file;
    
    if((file = fopen(file_name, "r")) == NULL){ err(file_name, "delete", 1); }
    if((new_file = fopen("aux", "w")) == NULL){ err("aux", "delete", 4); }

    char name[41], num[41];
    unsigned line, atual_line = 1;

    printf("Informe o ID: ");
    scanf("%d", &line);

    while (fgets(name, length_line, file) != NULL){

        fgets(num, length_line, file);

        if(line != atual_line++){
            fputs(name, new_file);
            fputs(num, new_file);
        }
    }

    fclose(file);
    fclose(new_file);

    if(remove(file_name)) err(file_name, "delete", 2);
    if(rename("aux", file_name)) err("aux", "delete", 3);

    header(2);
    getchar();
    
    system("clear");
}

void header(int op){
    if(op == 1){
        printf("\n\033[1;42m--------------------------MENU--------------------------\033[0m\n\n");
        printf("> (1). ver contatos%37s\n> (2). novo contato%37s\n", "<", "<");
        printf("> (3). apagar contato%35s\n> (4). sair%45s\n", "<", "<");
        printf("\n\033[1;42m--------------------------------------------------------\033[0m\n");
    } else if(op == 0){
        printf("\n\033[1;44m|------------------------- CONTATOS -------------------------|\033[0m\n");
        printf("\033[1m|------------------------------------------------------------|\033[0m\n");
        printf("\033[1;44m|%4s%4s%20s%8s%20s%5s\033[0m\n", "ID", "|", "NOME", "|", "NUMERO", "|");
        printf("\033[1m|-------|---------------------------|------------------------|\033[0m\n");
    } else {
        printf("\nFeito!!");
        printf("\n\nPrecione \033[1;43mENTER\033[0m para voltar ao MENU. ");
        getchar();
    }
}

void err(char *arq, char *func, int n){
    
    char *erro[10] = {
        "falha ao abrir arquivo.",
        "falha ao remover arquivo.",
        "falha ao renomear arquivo",
        "falha ao criar arquivo."
    };

    printf("funcao: %s. arquivo: %s. erro: %s.\n", func, arq, erro[n-1]);
    exit(1);
}