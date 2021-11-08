/********************************************************************/
// Projeto criado no MPL IDE utilizando o compilador C18 para uma		//
// calculadora que executa as quatro operacoes aritmeticas basicas	//
/********************************************************************/

#include <p18f4520.h>

#define INVALIDO 255

#define barramento LATC
#define d1 LATDbits.LATD0
#define d2 LATDbits.LATD1
#define d3 LATDbits.LATD2
#define d4 LATDbits.LATD3
#define d5 LATDbits.LATD4
#define d6 LATDbits.LATD5

/**************************************************/
#define c1 PORTBbits.RB3	// KEYPAD_SMALLCALC    	//
#define c2 PORTBbits.RB2	//											//
#define c3 PORTBbits.RB1	// l1 7			8		9		/		//
#define c4 PORTBbits.RB0	// l2 4			5  	6		* 	//
#define l4 LATBbits.LATB4 // l3 1			2 	3		-		//
#define l3 LATBbits.LATB5 // l4 ON/C 	0		=		+		//
#define l2 LATBbits.LATB6 // 	  c1 		c2 	c3 	c4	//
#define l1 LATBbits.LATB7 //											//
/**************************************************/

/*******************************/
unsigned const char ADD = "+"; //
unsigned const char SUB = "-"; //
unsigned const char MUL = "*"; //
unsigned const char DIV = "/"; //
/*******************************/

/*******************************/
unsigned const char IGL = "="; //
unsigned const char CLS = "c"; //
/*******************************/

long a;
long b;
unsigned char operando;
unsigned char digits[7] = {10, 10, 10, 10, 10, 10};
const long p_10[] = {1, 10, 100};

unsigned const char converte_7seg[] = {
		//-gfedcba
		0b00111111,
		0b00000110,
		0b01011011,
		0b01001111,
		0b01100110,
		0b01101101,
		0b01111101,
		0b00000111,
		0b01111111,
		0b01101111,
		0b00000000, // apagado
		0b01000000, // menos un�rio
};

/************************************************/
// Delay de 5ms																	//
// Tempo para tornar n�tido para o olho humano	//
// o que esta sendo mostrado no display					//
/************************************************/
void delay_varredura(void) // 5ms
{
	unsigned int i;
	for (i = 0; i < 700; i++)
	{
	}
}

/******************************************************/
// Varre o display (7SEG-MPx6-CC do Proteus ISIS 7)		//
// para exibir todos os d�gitos												//
/******************************************************/
void varre_display(void)
{
	barramento = converte_7seg[digits[5]];
	d1 = 0;
	delay_varredura();
	d1 = 1;

	barramento = converte_7seg[digits[4]];
	d2 = 0;
	delay_varredura();
	d2 = 1;

	barramento = converte_7seg[digits[3]];
	d3 = 0;
	delay_varredura();
	d3 = 1;

	barramento = converte_7seg[digits[2]];
	d4 = 0;
	delay_varredura();
	d4 = 1;

	barramento = converte_7seg[digits[1]];
	d5 = 0;
	delay_varredura();
	d5 = 1;

	barramento = converte_7seg[digits[0]];
	d6 = 0;
	delay_varredura();
	d6 = 1;
}

/**********************************************************/
// Varre o teclado (KEYPAD_SMALLCALC do Proteus ISIS 7)		//
// para identificar se uma tecla foi precionada						//
// Se nenhuma tecla for precionada, retorna INVALIDO=255	//
/**********************************************************/
unsigned char varre_teclado()
{
	l1 = 0;
	l2 = 1;
	l3 = 1;
	l4 = 1;
	if (!c1)
	{
		while (!c1)
		{
		}
		return 7;
	}
	if (!c2)
	{
		while (!c2)
		{
		}
		return 8;
	}
	if (!c3)
	{
		while (!c3)
		{
		}
		return 9;
	}
	if (!c4)
	{
		while (!c4)
		{
		}
		return DIV;
	}

	l1 = 1;
	l2 = 0;
	l3 = 1;
	l4 = 1;
	if (!c1)
	{
		while (!c1)
		{
		}
		return 4;
	}
	if (!c2)
	{
		while (!c2)
		{
		}
		return 5;
	}
	if (!c3)
	{
		while (!c3)
		{
		}
		return 6;
	}
	if (!c4)
	{
		while (!c4)
		{
		}
		return MUL;
	}

	l1 = 1;
	l2 = 1;
	l3 = 0;
	l4 = 1;
	if (!c1)
	{
		while (!c1)
		{
		}
		return 1;
	}
	if (!c2)
	{
		while (!c2)
		{
		}
		return 2;
	}
	if (!c3)
	{
		while (!c3)
		{
		}
		return 3;
	}
	if (!c4)
	{
		while (!c4)
		{
		}
		return SUB;
	}

	l1 = 1;
	l2 = 1;
	l3 = 1;
	l4 = 0;
	if (!c1)
	{
		while (!c1)
		{
		}
		return CLS;
	}
	if (!c2)
	{
		while (!c2)
		{
		}
		return 0;
	}
	if (!c3)
	{
		while (!c3)
		{
		}
		return IGL;
	}
	if (!c4)
	{
		while (!c4)
		{
		}
		return ADD;
	}

	return INVALIDO;
}

/**********************************************/
// Retorna verdadeiro se uc for um operando		//
// Os operandos s�o: + - * /									//
/**********************************************/
unsigned char eh_operando(unsigned char uc)
{
	return (uc == ADD || uc == SUB || uc == MUL || uc == DIV);
}

/****************************************/
// Apaga todos os d�gitos do display		//
/****************************************/
void limpa_display(void)
{
	digits[0] = 10;
	digits[1] = 10;
	digits[2] = 10;
	digits[3] = 10;
	digits[4] = 10;
	digits[5] = 10;
}

/**********************************************/
// Desloca os valores do array de digitos e		//
// atribui d � posi��o 0											//
/**********************************************/
void insere_digito(unsigned char d)
{
	unsigned char i;
	for (i = 5; i > 0; i--)
	{
		if (digits[i - 1] != 10)
		{
			digits[i] = digits[i - 1];
		}
	}
	digits[0] = d;
}

/**********************************************/
// Espera o primeiro n�mero e coloca em a			//
// Esta fun��o retorna quando h� pelo menos		//
// um d�gito e o operando � fornecido					//
/**********************************************/
void espera_primeiro_numero(void)
{
	unsigned char tecla;
	unsigned char i = 0;

	while (i < 3)
	{
		varre_display();
		tecla = varre_teclado();
		if (tecla != INVALIDO && tecla != IGL)
		{
			if (tecla == CLS)
			{
				i = 0;
				limpa_display();
			}
			else if (eh_operando(tecla))
			{
				if (i == 0)
				{
					continue;
				}
				else
				{
					operando = tecla;
					break;
				}
			}
			else
			{
				i++;
				insere_digito(tecla);
			}
		}
	}
	while (operando == INVALIDO)
	{
		varre_display();
		tecla = varre_teclado();
		if (eh_operando(tecla))
		{
			operando = tecla;
		}
	}
	for (i = 0; i < 3; i++)
	{
		if (digits[i] == 10)
		{
			continue;
		}
		a += (digits[i] * p_10[i]);
	}
	limpa_display();
}

/**********************************************/
// Espera o segundo n�mero e coloca em b			//
// Esta fun��o retorna quando h� pelo menos		//
// um d�gito e a tecla = � precionada					//
/**********************************************/
void espera_segundo__numero(void)
{
	unsigned char tecla;
	unsigned char i = 0;

	while (i < 3)
	{
		varre_display();
		tecla = varre_teclado();
		if (tecla != INVALIDO && !eh_operando(tecla))
		{
			if (tecla == CLS)
			{
				i = 0;
				limpa_display();
			}
			else if (tecla == IGL)
			{
				if (i == 0)
				{
					continue;
				}
				else
				{
					break;
				}
			}
			else
			{
				i++;
				insere_digito(tecla);
			}
		}
	}
	while (tecla != IGL)
	{
		varre_display();
		tecla = varre_teclado();
	}
	for (i = 0; i < 3; i++)
	{
		if (digits[i] == 10)
		{
			continue;
		}
		b += (digits[i] * p_10[i]);
	}
	limpa_display();
}

/************************************************************/
// Calcula o resultado de a(operando)b e mostra no display	//
/************************************************************/
void calcula______resultado(void)
{
	long result = 0;
	unsigned char i = 0;
	unsigned char sinal = 0;

	if (operando == ADD)
	{
		result = a + b;
	}
	if (operando == SUB)
	{
		if (a < b)
		{
			sinal = 1;
			result = b - a;
		}
		else
		{
			result = a - b;
		}
	}
	if (operando == MUL)
	{
		result = a * b;
	}
	if (operando == DIV && b != 0)
	{
		result = a / b;
	}

	if (result)
	{
		while (result != 0)
		{
			digits[i] = result % 10;
			result = result / 10;
			i++;
		}
	}
	else
	{
		digits[0] = 0;
	}

	if (sinal)
	{
		digits[i] = 11;
	}
}

/****************************************/
// Espera a tecla ON/C ser precionada		//
/****************************************/
void espera_limpar__display(void)
{
	unsigned char tecla;
	while (tecla != CLS)
	{
		varre_display();
		tecla = varre_teclado();
	}
	limpa_display();
}

void main(void)
{
	TRISC = 0b00000000;
	TRISD = 0b00000000;
	TRISB = 0b00001111;
	ADCON1 = 0b00001111;
	LATD = 0b11111111;

	while (1)
	{
		operando = INVALIDO;
		a = 0;
		b = 0;

		espera_primeiro_numero();
		espera_segundo__numero();
		calcula______resultado();
		espera_limpar__display();
	}
}
