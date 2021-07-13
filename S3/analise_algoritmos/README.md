# N2 IAA 2021.1 -  João Breno Rodrigues Venancio

## Questão 1
No algoritmo a seguir, |v| denota o valor absoluto de v.<br><br>

<b>Algoritmo:</b> Busca aproximada<br>
<b>Entrada:</b> Uma lista L de N inteiros em ordem não decrescente indexados a partir do 0 e um inteiro X<br>
<b>Saída:</b> Um elemento Y de L mais próximo de X<br>

```
inicio = 0
fim = N-1

enquanto inicio <= fim faca:
	meio = (inicio + fim) / 2		// divisao inteira
	
	se (meio = 0 ou |L[meio] - x| <= |L[meio-1] - x|) e (meio = N-1 ou |L[meio] - x| <= |L[meio+1] - x|):
		devolva L[meio]
	
	se L[meio] > x:
		fim = meio-1
	se nao:
		inicio = meio+1
```

No pior caso, o elemento procurado está em um dos extremos da lista e a complexidade temporal será<br>
de Θ(logn). No melhor caso, o elemento procurado está precisamente no meio da lista e ele é encontrado<br>
em O(1). O espaço requerido é O(1), pois é necessário apenas 4 variáveis escalares, incluindo N.<br>

## Questão 2
<b>Algoritmo:</b> Subcolecao de soma fixa EE<br>
<b>Entrada:</b> C = {c1, c2, ..., cn} e um valor x<br>
<b>Saída:</b> SIM, se existe uma subcolecao de C com soma igual a x e NAO caso contrario<br>
```
para i = 0 até 2^N - 1 faca:
	se soma_subcolecao(C, i) = x:
		devolva SIM

devolva NAO
```

<b>Procedimento:</b> Soma subcolecao<br>
<b>Entrada:</b> C = {C1, C2, ..., Cn} e um valor i que codifica uma subcolecao de C<br>
<b>Saída:</b> A soma dos elementos da subcolecao codificada por i<br>

```
soma = 0
para j = 0 até N-1 faca:
	se i % 2 = 1
		soma = soma + Cj
	i = i / 2					// divisão inteira

devolva soma
```

O pior caso ocorre quando não existe nenhuma subcoleção que satisfaça. Nesse caso,<br>
a complexidade temporal é Θ(n2^n). Já o melhor caso ocorre quando x = 0. Neste caso, o<br>
algoritmo só faz uma iteração, pois para i = 0, o procedimento <i>Soma subcolecao</i> retorna 0,<br>
o que deve ser entendido como uma subcoleção vazia. O espaço requerido é da ordem de O(1)<br>

## Questão 3
Subcolecao de soma fixa (SSF)<br>

É fácil observar que este problema é decomponível, pois podemos decompor a instancia<br>
SSF({C1, ..., Cn}, x) nas instancias menores SSF({C1, ..., Cn-1}, x) e, se Cn <= x, SSF({C1, ..., Cn-1}, x - Cn).<br>
Além disso ele é de subestrutura ótima, pois a partir da solução das subinstancias obtidas com a decomposição,<br>
é possivel encontrar a solução da instancia original, uma vez que:<br><br>

SSF({C1, ..., Cn}, x) = SSF({C1, ..., Cn-1}, x) ou (Cn <= x e SSF({C1, ..., Cn-1}, x - Cn))<br><br>

Como base, uma instância com n = 0 tem solução SIM se, e somente se, x = 0.<br>

Vamos fazer uso dessa obsevação no algoritmo a seguir.<br>
Vamos manter uma tabela T para armazenar as soluções das subinstancias e, inicialmente, preenchemos a primeira linha<br>
e primeira coluna de T com as soluções triviais e, para 0 < i <= n e 0 < j <= x, T[i, j] guardará a solução da instancia<br>
SSF({C1, ..., Ci}, j). De tal sorte que, ao final da execução do algoritmo, T[n, x] será a resposta para a instancia<br>
SSF({C1, ..., Cn}, x) procurada.<br>

<b>Algoritmo:</b> Subcolecao de soma fixa PD<br>
<b>Entrada:</b> C = {C1, C2, ..., Cn} e um valor x<br>
<b>Saída:</b> SIM, se existe uma subcolecao de C com soma igual a x e NAO caso contrario<br>
```
T := Tabela de n+1 linhas e x+1 colunas

para i = 0 até n faca:
	T[i, 0] = SIM

para j = 1 até x faca:
	T[0, j] = NAO

	para i = 1 até n faca:
		b = T[i - 1, j]

		se b = 0 e Ci ≤ j
			b = T[i - 1, j - Ci]

		T[i, j] = b

devolva T[n, x]
```
O tempo e espaço requerido pelo algoritmo são da ordem do tamanho da tabela T e, portanto, pertencem a Θ(nx)<br>

## Questão 4


Enumeração | x1 | x2 | x3 | x4 | x5 | x6 | x7 | x8 | x9 | x10 | x11 | x12 | x13 | x14 | x15 | x16 | x17 | x18 | x19 | x20 | Valor | Peso
-----------|----|----|----|----|----|----|----|----|----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-------|------
1 		   | 1  | 1  | 1  | 1  | 0  | 0  | 0  | 0  | 1  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1018  | 983
2          | 1  | 1  | 1  | 1  | 0  | 0  | 0  | 0  | 0  | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 972   | 938
3          | 1  | 1  | 1  | 1  | 0  | 0  | 0  | 0  | 0  | 0   | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 995   | 963
4          | 1  | 1  | 1  | 1  | 0  | 0  | 0  | 0  | 0  | 0   | 0   | 0   | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1009  | 978
5          | 1  | 1  | 1  | 1  | 0  | 0  | 0  | 0  | 0  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 866   | 833
6          | 1  | 1  | 1  | 0  | 1  | 0  | 0  | 0  | 1  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1027  | 993
7          | 1  | 1  | 1  | 0  | 1  | 0  | 0  | 0  | 0  | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 981   | 948
8          | 1  | 1  | 1  | 0  | 1  | 0  | 0  | 0  | 0  | 0   | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1004  | 973
9          | 1  | 1  | 1  | 0  | 1  | 0  | 0  | 0  | 0  | 0   | 0   | 0   | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1018  | 988
10         | 1  | 1  | 1  | 0  | 1  | 0  | 0  | 0  | 0  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 875   | 843
11         | 1  | 1  | 1  | 0  | 0  | 1  | 0  | 0  | 1  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1030  | 998
12         | 1  | 1  | 1  | 0  | 0  | 1  | 0  | 0  | 0  | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 984   | 953
13         | 1  | 1  | 1  | 0  | 0  | 0  | 1  | 1  | 0  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1000  | 968
14         | 1  | 1  | 1  | 0  | 0  | 0  | 1  | 0  | 1  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 979   | 948
15         | 1  | 1  | 1  | 0  | 0  | 0  | 0  | 1  | 1  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 938   | 908
16         | 1  | 1  | 0  | 1  | 1  | 0  | 0  | 0  | 0  | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 993   | 961
17         | 1  | 1  | 0  | 1  | 0  | 1  | 0  | 0  | 0  | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 996   | 966
18         | 1  | 1  | 0  | 1  | 0  | 0  | 1  | 1  | 0  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1012  | 981
19         | 1  | 1  | 0  | 1  | 0  | 0  | 0  | 1  | 1  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 950   | 921
20         | 1  | 1  | 0  | 0  | 1  | 1  | 0  | 0  | 0  | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1005  | 976
21         | 1  | 0  | 1  | 1  | 1  | 0  | 0  | 0  | 0  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 974   | 940
22         | 1  | 0  | 1  | 1  | 0  | 1  | 0  | 0  | 0  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 977   | 945
23         | 1  | 0  | 1  | 1  | 0  | 0  | 1  | 0  | 0  | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | `1032`  | 1000
24         | 1  | 0  | 1  | 0  | 1  | 1  | 0  | 0  | 0  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 986   | 955
25         | 1  | 0  | 0  | 1  | 1  | 1  | 0  | 0  | 0  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 998   | 968
26         | 0  | 1  | 1  | 1  | 1  | 0  | 0  | 0  | 0  | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1016  | 985
27         | 0  | 1  | 0  | 1  | 1  | 1  | 0  | 0  | 0  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 934   | 908
28         | 0  | 0  | 1  | 1  | 1  | 1  | 0  | 0  | 0  | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1021  | 992

## Questão 5

A estratégia será percorrer a maior distância possível até que, para chegar no posto seguinte,<br>
seja necessário abastecer no posto atual.<br>

<b>Algoritmo:</b> Numero mínimo de abastecimentos<br>
<b>Entrada:</b> Q = {Q0, Q1, ..., Qn} o ponto de partida e as localizações dos postos e um valor D, a autonomia do veiculo.<br>
<b>Saída:</b> O número mínimo de abastecimentos para ir de Q0 à Qn<br>
```
abastecimentos = 0
distancia_percorrida = 0

para i = 1 até n-1 faca:
	distancia_percorrida = distancia_percorrida + (Q[i] - Q[i-1]);

	// preciso abastecer neste posto?
	se (distancia_percorrida + (Q[i+1] - Q[i])) > D:
		abastecimentos = abastecimentos + 1;
		distancia_percorrida = 0;

devolva abastecimentos
```

O algoritmo sempre requer tempo Θ(n) e espaço O(1).
