#include "agenda.h"

const char *file_name = "contatos";

void run_app()
{
    system("clear");   
    char ch;
    
    do
    {
        header(MENU);
        printf("\nInforme o numero da opcao desejada: ");
        ch = getchar();

        switch (ch)
        {
            case '1':
                view(FROM_MENU);
                break;
            case '2':
                add();
                break;
            case '3':
                erase();
                break;
            default:
                ch = 's';
                break;
        }
    } while(ch != 's');
}

void add()
{
    system("clear");

    FILE *fp;
    char name[41], num[41];

    if((fp = fopen(file_name, "a")) == NULL){
        err(file_name, "add", ABRIR);
    }

    getchar();
    printf("\nNome: ");
    fgets(name, sizeof(name), stdin);
    printf("Numero: ");
    fgets(num,  sizeof(num),  stdin);

    if (!(strlen(name) < 2 || strlen(num) < 2))
    {
        fputs(name, fp);
        fputs(num, fp);
    }
    
    fclose(fp);
    header(DONE);
    system("clear");
}

void erase()
{
    view(FROM_ERASE);
    FILE *file, *new_file;
    
    if ((file = fopen(file_name, "r")) == NULL)
        err(file_name, "delete", ABRIR);
    if ((new_file = fopen("aux", "w")) == NULL)
        err("aux", "delete", CRIAR);

    char name[41], num[41];
    unsigned line, atual_line = 1;

    printf("Informe o ID: ");
    scanf("%d", &line);

    while (fgets(name, LENGTH_LINE, file) != NULL)
    {
        fgets(num, LENGTH_LINE, file);

        if(line != atual_line++)
        {
            fputs(name, new_file);
            fputs(num, new_file);
        }
    }

    fclose(file);
    fclose(new_file);

    if(remove(file_name))
        err(file_name, "delete", REMOVER);
    if(rename("aux", file_name))
        err("aux", "delete", RENOMEAR);

    header(DONE);
    getchar();
    system("clear");
}

void view(ViewOp op)
{
    system("clear");

    FILE *fp;
    char name[41], num[41], ch;
    unsigned line = 1;

    if((fp = fopen(file_name, "a+")) == NULL)
        err(file_name, "view", ABRIR);

    header(LISTA);

    while (fgets(name, LENGTH_LINE, fp) != NULL)
    {
        fgets(num, LENGTH_LINE, fp);

        name[strlen(name)-1] = '\0';
        num[strlen(num)-1] = '\0';

        printf("|%4d%4s%20s%8s%20s%5s\n", line++, "|", name, "|", num, "|");
    }

    printf("\033[1m|-------|---------------------------|------------------------|\033[0m\n\n");
    fclose(fp);

    if( op )
    {
        printf("Precione \033[1;43mENTER\033[0m para voltar ao MENU. ");
        getchar(); getchar();
        system("clear");
    }
}

void header(HeaderOp op)
{
    if(op == MENU)
    {
        printf("\n\033[1;42m--------------------------MENU--------------------------\033[0m\n\n");
        printf("> (1). ver contatos%37s\n> (2). novo contato%37s\n", "<", "<");
        printf("> (3). apagar contato%35s\n> (4). sair%45s\n", "<", "<");
        printf("\n\033[1;42m--------------------------------------------------------\033[0m\n");
    }
    else if(op == LISTA)
    {
        printf("\n\033[1;44m|------------------------- CONTATOS -------------------------|\033[0m\n");
        printf("\033[1m|------------------------------------------------------------|\033[0m\n");
        printf("\033[1;44m|%4s%4s%20s%8s%20s%5s\033[0m\n", "ID", "|", "NOME", "|", "NUMERO", "|");
        printf("\033[1m|-------|---------------------------|------------------------|\033[0m\n");
    }
    else
    {
        printf("\nFeito!!");
        printf("\n\nPrecione \033[1;43mENTER\033[0m para voltar ao MENU. ");
        getchar();
    }
}

void err(const char *arq, char *func, ErroAo erro)
{
    char *tipo_erro[10] = {
        "falha ao abrir arquivo.",
        "falha ao remover arquivo.",
        "falha ao renomear arquivo",
        "falha ao criar arquivo."
    };

    printf("funcao: %s. arquivo: %s. erro: %s.\n", func, arq, tipo_erro[erro]);
    exit(1);
}
