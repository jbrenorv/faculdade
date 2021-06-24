## Pequenos desafios em Assembly com NASM no Ubuntu
### Instalação do NASM
```
$ sudo apt install nasm
```
### Gerando o executável e executando
```
$ make
$ ./<nome-do-executavel>
```

### Insertion Sort
Para este programa compilar no seu Linux, garanta que a seguinte lib esteja instalada:
```
$ sudo apt-get install gcc-multilib
```

Após compilar e executar, você pode excluir os arquivos gerados. Isso inclui o executável:
```
$ make clean
```
