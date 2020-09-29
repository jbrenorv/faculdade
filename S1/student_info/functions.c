#include "prototype.h"

void init(){
    int a;
    for(a = 0; a < MAX; a++) {
        *student[a].name = '\0'; // nome vazio indica posicao desocupada
    }
}

// traz para o vetor os dados presentes no arquivo
void load(){
    FILE *fp;
    int i;

    if((fp = fopen(file_name, "a+b")) == NULL) bug();

    for(i = 0; i < MAX; i++){
        if(fread(&student[i], sizeof(struct Student), 1, fp) != 1){
            if(feof(fp)) break;
            bug();
        }
    }
    fclose(fp);
}

void run_app(){
    int choice;

    while(1) {
        system("clear");
        choice = menu();

        switch(choice){
            case 0: insert(); break;
            case 1: show(); break;
            case 2: _remove(); break;
            case 3: new_discipline(-1, 1); break;

            default: return;
        }
    }
}

void insert() {
    system("clear");
    int a, m, cnt, num;

    printf("Quantos alunos deseja adicionar?\n>>> ");
    scanf("%i", &m);

    cnt = a = 0;
    while (cnt < m && a < MAX) {
        if(!(*student[a].name)){
            printf("Nome\n>>> ");
            scanf("%s", student[a].name);
            printf("Matricula\n>>> ");
            scanf("%s", student[a].registration);

            student[a].num_diciplinas = 0;
            student[a].soma_creditos = 0;
            student[a].soma_mf_x_credito = 0.0;

            new_discipline(a, 0);

            cnt++;
        }
        a++;
    }
    save();

    printf("(1) Novo aluno\n(0) Voltar ao MENU\n>>> ");
    scanf("%i", &a);

    if ( a ) insert();
}

void show(){
    int aux;
    char back;
    print_list();

    printf("Verificar aluno especifico? (1)sim (0)nao\n>>> ");
    scanf("%i", &aux);

    while (aux) {
        int c, a = find_student();
        int num_d = student[a].num_diciplinas;

        if(a != -1){
            printf("\n\033[1m+-----------------------------+-------------------------------------------------+\033[0m");
            
            printf("\n\033[1m|%9s%10s%11s%9s%6.2f%35s\033[0m\n", 
                "Aluno: ", student[a].name, "|",
                "IRA = ", ((student[a].soma_mf_x_credito)/student[a].soma_creditos), "|"
            );
            
            printf("\033[1m+--------------+-----+--------+--------+--------+--------+--------+-------------+\033[0m");
            
            printf("\n|%12s%3s%3s%3s%6s%3s%6s%3s%6s%3s%6s%3s%6s%3s%11s%3s\n",
                "Disciplina", "|", "Cr", "|", "N1", "|", "N2", "|", 
                "MP", "|", "AF", "|", "MF", "|", "Situacao", "|"
            );
            
            printf("\033[1m+--------------+-----+--------+--------+--------+--------+--------+-------------+\033[0m\n");
            
            for (c = 0; c < num_d; c++){
                printf("|%12s%3s%3d%3s%6.2f%3s%6.2f%3s%6.2f%3s%6s%3s%6.2f%3s%22s%3s\n",
                    student[a].discipline[c].name, "|",
                    student[a].discipline[c].creditos, "|",
                    student[a].discipline[c].grade[0], "|",
                    student[a].discipline[c].grade[1], "|",
                    student[a].discipline[c].mp, "|",
                    situacao(a, c, 1), "|",
                    student[a].discipline[c].mf, "|",
                    situacao(a, c, 0), "|"
                );
            }
            
            printf("\033[1m+--------------+-----+--------+--------+--------+--------+--------+-------------+\033[0m\n\n");

        } else printf("\nAluno nao encontrado.\n\n");
        
        printf("(1) Ver outro aluno\n(0) Voltar ao MENU\n>>> ");
        scanf("%i", &aux);
    }

    system("clear");
}

char * situacao(int a, int c, int op) {
    if (op) {
        if (student[a].discipline[c].af != -1) {
            char *campo = malloc(6 * sizeof(char));
            sprintf(campo, "%.2f", student[a].discipline[c].af);
            return campo;
        }
        
        return "----";
    }

    if (student[a].discipline[c].af != -1 && student[a].discipline[c].mf >= 5.0)
        return "\033[1;33mAprovado\033[0m";
        
    if (student[a].discipline[c].mf >= 7.0)
        return "\033[1;32mAprovado\033[0m";

    return "\033[1;31mReprovado\033[0m";
}

void _remove(){
    print_list();

    int a = find_student();
    if(a != -1){
        *student[a].name = '\0';
        save();
    }
}

void new_discipline(int a, int op){
    int num, aux, i, c;
    float nota;
    
    if (op) {
        print_list();
        a = find_student();

        if(a == -1) {
            printf("Aluno nao encontrado.\n");
            return;
        }
    }

    aux = student[a].num_diciplinas;

    printf("Quantas disciplinas?\n>>> ");
    scanf("%i", &num);

    if((num + aux) > MAX_D) num = (MAX_D - aux);
    if(num < 0) num = 0;

    student[a].num_diciplinas += num;

    for (c = aux; c < (aux +num); c++) {
        printf("Nome da disciplina\n>>> ");
        scanf("%s", student[a].discipline[c].name);
        printf("Creditos\n>>> ");
        scanf("%i", &student[a].discipline[c].creditos);

        for (i = 0; i < QTD_N; i++) {
            printf("%s > %s > N%d: ", 
                student[a].name, student[a].discipline[c].name, i+1);
            
            scanf("%f", &nota);
            student[a].discipline[c].grade[i] = nota;
        }
        media(a, c);

        if (student[a].discipline[c].mp < 7.0 && student[a].discipline[c].mp >= 3.0) {
            printf("%s > %s > AF: ", student[a].name, student[a].discipline[c].name);
            scanf("%f", &nota);
            student[a].discipline[c].af = (nota < 0 || nota > 10) ? 0 : nota;
            student[a].discipline[c].mf = (student[a].discipline[c].mp + nota)/2;
        } else {
            student[a].discipline[c].mf = student[a].discipline[c].mp;
            student[a].discipline[c].af = -1;
        }

        student[a].soma_creditos += student[a].discipline[c].creditos;
        student[a].soma_mf_x_credito += (student[a].discipline[c].mf*student[a].discipline[c].creditos);
    }

    if(op) save();
}

void save(){
    FILE *fp;
    int a;

    if((fp = fopen(file_name, "wb")) == NULL) 
        bug();

    for(a = 0; a < MAX; a++){
        if(*student[a].name){
            if(fwrite(&student[a], sizeof(struct Student), 1, fp) != 1) 
                bug();
        }
    }

    fclose(fp);
    printf("Sucesso!\n\n");
}

void print_list(){
    system("clear");
    int a;

    printf("\n\033[1m+----------------+-----------------+\033[0m\n");
    printf("|%14s%3s%15s%3s\n",
        "Aluno", "|", "Matricula", "|"
    );
    printf("\033[1m+----------------+-----------------+\033[0m\n");

    for(a = 0; a < MAX; a++) {
        if(*student[a].name){
            printf("|%14s%3s%15s%3s\n",
                student[a].name, "|",
                student[a].registration, "|"
            );
        }
    }
    printf("\033[1m+----------------+-----------------+\033[0m\n\n");
}

int find_student(){
    char registration[15];
    int a;

    printf("Matricula\n>>> ");
    scanf("%s", registration);

    for(a = 0; a < MAX; a++){
        if(*student[a].name){
            if(!(strcmp(student[a].registration, registration))){
                
                return a;
            }
        }
    }
    return -1;
}

void media(int a, int c) {
    int i;
    float soma = 0;

    for (i = 0; i < QTD_N; i++) {
        soma += ((i+2)*(student[a].discipline[c].grade[i]));
    }

    student[a].discipline[c].mp = soma/SOMA_PESOS;

}

int menu(){
    int choice;

    printf("Digite o numero de uma opcoe para seleciona-la\n");
    printf("  (0) Novo aluno(s)\n");
    printf("  (1) Exibir dados\n");
    printf("  (2) Remover aluno\n");
    printf("  (3) Nova disciplina\n");
    printf("  (4) Sair\n>>> ");

    scanf("%i", &choice);
    return choice;
}

void bug(){
    printf("Ocorreu um erro no trato de arquivos!\n");
    exit(1);
}
