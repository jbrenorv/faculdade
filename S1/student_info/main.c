#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MAX 15  // maximo de alunos
#define QTD_D 2 // quantidade de disciplinas
#define QTD_N 2 // quantidade de notas por disciplina

const char *file_name = "dados";

typedef struct {
    char name[20];
    float grade[QTD_N];
    float media, dp;
} Discipline;

struct Student {
    char registration[15];
    char name[20];
    char phone[12];
    int birth[3];
    Discipline discipline[QTD_D];
} student[MAX];

void show(), insert(), _remove();
void init(), load(), run_app(), save(), bug();
void desvio(int), media(int), print_list();
int menu(), find_student();

int main() {

    init();
    load();
    run_app();

    return 0;
}

void init(){
    int i;
    for(i = 0; i < MAX; i++)
        *student[i].name = '\0';
}

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
    int choice = menu();
    
    switch(choice){
        case 0: insert(); break;
        case 1: show(); break;
        case 2: _remove(); break;

        default: return;
    }
    
    run_app();
}

void insert() {
    int a, c, i, m, cnt;
    float nota;

    printf("Quantos alunos deseja adicionar? ");
    scanf("%i", &m);

    cnt = a = 0;
    while (cnt < m && a < MAX) {
        if(!(*student[a].name)){
            printf("nome: ");
            scanf("%s", student[a].name);
            printf("matricula: ");
            scanf("%s", student[a].registration);
            printf("fone: ");
            scanf("%s", student[a].phone);
            printf("data de nascimento:\ndia: ");
            scanf("%i", &student[a].birth[0]);
            printf("mes: ");
            scanf("%i", &student[a].birth[1]);
            printf("ano: ");
            scanf("%i", &student[a].birth[2]);
            
            for (c = 0; c < QTD_D; c++) {
                printf("Informe o nome da disciplina %d: ", c+1);
                scanf("%s", student[a].discipline[c].name);
                
                for (i = 0; i < QTD_N; i++) {
                    printf("Informe a %da nota do aluno %s na disciplina %s: ", 
                            i+1, student[a].name, student[a].discipline[c].name);
                    
                    scanf("%f", &nota);
                    student[a].discipline[c].grade[i] = nota;
                }
            }
            media(a);
            desvio(a);
            cnt++;
        }
        a++;
    }
    save();
}

void show(){
    int aux;
    printf("\n\033[1m------------------------------------------------------------------\033[0m\n\n");
    print_list();

    printf("Verificar aluno especifico? (1)sim (0)nao: ");
    scanf("%i", &aux);

    if(aux){
        int c, s;
        int a = find_student();
        
        if(a != -1){
            printf("\n|%12s%3s%6s%3s%6s%3s%6s%3s%6s%3s%11s%3s\n",
                "Disciplina", "|", "N1", "|", "N2", "|", 
                "Media", "|", "DP", "|", "Situacao", "|"
            );
            for (c = 0; c < QTD_D; c++){
                s = student[a].discipline[c].media < 7.0 ? 0 : 1;
                printf("|%12s%3s%6.2f%3s%6.2f%3s%6.2f%3s%6.2f%3s%22s%3s\n",
                    student[a].discipline[c].name, "|",
                    student[a].discipline[c].grade[0], "|",
                    student[a].discipline[c].grade[1], "|",
                    student[a].discipline[c].media, "|",
                    student[a].discipline[c].dp, "|",
                    (s ? "\033[1;32mAprovado\033[0m" : "\033[1;31mReprovado\033[0m"), "|"
                );
            }
        } else printf("\nAluno nao encontrado.\n");
    }
    printf("\n\033[1m------------------------------------------------------------------\033[0m\n\n");
}

void print_list(){
    int a;

    printf("|%14s%3s%15s%3s%9s%6s%12s%3s\n",
        "Aluno", "|", "Matricula", "|", "fone", "|", "Nascimento", "|"
    );

    for(a = 0; a < MAX; a++) {
        if(*student[a].name){
            printf("|%14s%3s%15s%3s%12s%3s%4d/%2d/%4d%3s\n",
                student[a].name, "|",
                student[a].registration, "|",
                student[a].phone, "|",
                student[a].birth[0],
                student[a].birth[1],
                student[a].birth[2], "|"
            );
        }
    }
    printf("\n");
}

void _remove(){
    int a = find_student();
    if(a != -1){
        *student[a].name = '\0';
        save();
    }
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

int find_student(){
    char registration[15], name[20];
    int a;

    printf("nome: ");
    scanf("%s", name);
    printf("matricula: ");
    scanf("%s", registration);

    for(a = 0; a < MAX; a++){
        if(*student[a].name){
            if(!(strcmp(student[a].name, name)) &&
               !(strcmp(student[a].registration, registration))){
                
                return a;
            }
        }
    }
    return -1;
}

int menu(){
    int choice;

    printf("Digite o numero de uma opcoe para seleciona-la\n");
    printf("  (0) Inserir aluno(s)\n");
    printf("  (1) Mostrar dados de um aluno\n");
    printf("  (2) Remover dados de um aluno\n");
    printf("  (3) Sair\n");

    scanf("%i", &choice);
    return choice;
}

void bug(){
    printf("Ocorreu um bug no trato de arquivos!\n");
    exit(1);
}

void media(int id) {
    int c, i;
    float soma = 0, media;

    for (c = 0; c < QTD_D; c++) {
        for (i = 0; i < QTD_N; i++) {
            soma += student[id].discipline[c].grade[i];
        }
        media = soma/QTD_N;
        student[id].discipline[c].media = media;
        soma = 0;
    }
}

void desvio(int id){
    int c, i;
    float soma = 0, nota, media;

    for (c = 0; c < QTD_D; c++) {
        for (i = 0; i < QTD_N; i++) {
            nota = student[id].discipline[c].grade[i];
            media = student[id].discipline[c].media;
            
            soma += ((nota - media)*(nota - media));
        }
        soma /= (QTD_N-1);
        student[id].discipline[c].dp = sqrt(soma);
        soma = 0;
    }
}
