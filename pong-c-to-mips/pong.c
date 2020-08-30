/************************************************
LAOC1 - PROVA 3
Aluno: Thiago Lima Bahia Santos
Matricula: 20183000302
Descricao do programa: Pong
Data: 29/11/19
************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#define SCREEN_I 48			//Tamanho i da janela
#define SCREEN_J 64			//Tamanho j da janela
#define BAR_SIZE 20	
#define BALL_SIZE 1	
#define SET_SLEEP 65000

typedef struct{
    int x, y;				//Define o centro do objeto em x e y
    int size;				//Define o tamanho do objeto
    char c;				//Define o caractere do objeto
} Objeto;

char Pong[SCREEN_I][SCREEN_J];

/* Procedimento funcionando corretamente. Apenas não utilizado.
void RandomizaInicioJogador(Objeto *j){

		srand(time(NULL));
		do {
			(*j).y = rand() % SCREEN_I;
		} while ( ((*j).y < (BAR_SIZE / 2) + 1) ||  ((*j).y > SCREEN_I - (BAR_SIZE / 2) - 2) );

}
*/

void InicializaJogador(Objeto *j, int x, char c) {

	(*j).x = x;
	(*j).y = SCREEN_I / 2; //Inicia jogador ao centro
	(*j).size = BAR_SIZE;
	(*j).c = c;

}

void PosicionaJogador(Objeto j) {

	int i;

	for (i = j.y; i <= j.y + (BAR_SIZE / 2); i++)
		Pong[i][j.x] = j.c;

	for (i = j.y; i >= j.y - (BAR_SIZE / 2); i--)
		Pong[i][j.x] = j.c;

}

int EscolheMovimentoJogador(Objeto j, int *mov) {

	//Verifica se o Jogador colidiu com o limite superior
	if ( j.y - ( j.size / 2 ) + 1 <= 2 )
		*mov = 0; //Se mov = 0, movimenta o Jogador para baixo

	//Verifica se o Jogador colidiu com o limite inferior
	if ( j.y + ( j.size / 2 ) - 1 >= SCREEN_I - 3 )
		*mov = 1; //Se mov = 1, movimenta o Jogador para cima		

}

void MovimentaJogador(Objeto *j, int mov) {

	if (mov == 1)
		(*j).y--; //Movimenta o Jogador selecionado para cima
	else
		(*j).y++; //Movimenta o Jogador selecionado para baixo

}

void RandomizaInicioBola(Objeto *b) {

	srand(time(NULL));
	(*b).y = ( (SCREEN_I / 2) + (rand() % BAR_SIZE) * (rand() % 2) * (-1) );

}

void InicializaBola(Objeto *b, int x, char c) {

	(*b).x = x;
	RandomizaInicioBola(b);
	(*b).size = BALL_SIZE;
	(*b).c = c;

}

void PosicionaBola(Objeto *b) {

	Pong[(*b).y][(*b).x] = (*b).c;

}

void MovimentaBola(Objeto *b, int *x, int *y) {

	//Verifica se a Bola colidiu com o limite superior
	if((*b).y <= 1)
		*y *= -1;

	//Verifica se a Bola colidiu com o limite inferior
	if ((*b).y >= SCREEN_I - 2)
		*y *= -1;

	(*b).x += *x; //Movimenta a bola em x
	(*b).y += *y; //Movimenta a bola em y

}

void Rebate(Objeto *j, Objeto *b, int *x) {

	//Verifica se a Bola colidiu com o Jogador A
	if ( ( (*b).x - 1 == (*j).x ) &&
		((*b).y <= (*j).y + ((*j).size / 2)) &&
		((*b).y >= (*j).y - ((*j).size / 2)) )
			*x *= -1;

	//Verifica se a Bola colidiu com o Jogador B
	if ( ( (*b).x + 1 == (*j).x ) &&
		((*b).y <= (*j).y + ((*j).size / 2)) &&
		((*b).y >= (*j).y - ((*j).size / 2)) )
			*x *= -1;		

}

int VerificaPontuacao(Objeto b, int *s1, int *s2) {

	if (b.x >= SCREEN_J - 1) {
		(*s1)++;
		return 1;
	}	

	if (b.x <= 0) {
		(*s2)++;
		return 1;
	}

	return 0;

}

void ImprimePontuacao(int s1, int s2){
    printf("   JOGADOR 1: %.2d\t\tx\t\tJOGADOR 2: %.2d\n", s1, s2);
}

void InicializaPong() {

	int i, j;

    for (i = 0; i < SCREEN_I; i++) {
    	Pong[i][0] = '|';
    	Pong[i][SCREEN_J-1] = '|';
    }

    for (i = 0; i < SCREEN_J; i++) {
    	Pong[0][i] = '=';
    	Pong[SCREEN_I-1][i] = '=';    	
    }

    for (i = 1; i < SCREEN_I-1; i++)
        for (j = 1; j < SCREEN_J-1; j++)
            Pong[i][j] = ' ';

}

void AtualizaPong(Objeto j1, Objeto j2, Objeto b) {

	InicializaPong();
	PosicionaJogador(j1);
	PosicionaJogador(j2);
	PosicionaBola(&b);

}

void ImprimePong(){

	int i, j;

    for (i = 0; i < SCREEN_I; i++) {
        for (j = 0; j < SCREEN_J; j++) {
            printf("%c", Pong[i][j]);
        }
        printf("\n");
    }

}

int main() {

	Objeto Jogador1, Jogador2, Bola;
	int MovJog1, ScoreJog1 = 0, MovJog2, ScoreJog2 = 0;
	int BolaX = 1, BolaY = 1;

	//Inicializa Jogador1, Jogador2 e a Bola
	InicializaJogador(&Jogador1, 1, ']');
	InicializaJogador(&Jogador2, SCREEN_J - 2, '[');
	InicializaBola(&Bola, SCREEN_J / 2, 'O');

	//Define a direção inicial da movimentação dos Jogadores
	srand(time(NULL));
	MovJog1 = rand() % 2; //Se (1) move para baixo, se (0) move para cima

	//Alterna a movimentação do Jogador 2 em função da movimentação do Jogador 1
	if (MovJog1 == 1)
		MovJog2 = 0;
	else
		MovJog2 = 1;

	//Loop infinito
	while (1) {
		printf("\t\t\tPONG NO TERMINAL\n");
		//Atualiza as posições do Jogador 1, Jogador 2 e da Bola
		AtualizaPong(Jogador1, Jogador2, Bola);
		ImprimePong(); //Imprime o Jogo atualizado
		ImprimePontuacao(ScoreJog1, ScoreJog2); //Imprime a Pontuação do Jogo atualizada
		//Define o próximo movimento dos Jogadores
		EscolheMovimentoJogador(Jogador1, &MovJog1);
		EscolheMovimentoJogador(Jogador2, &MovJog2);
		//Realiza a movimentação dos Jogadores
		MovimentaJogador(&Jogador1, MovJog1);
		MovimentaJogador(&Jogador2, MovJog2);
		//Movimenta a Bola
		MovimentaBola(&Bola, &BolaX, &BolaY);
		//Verifica se houve Pontuação de algum Jogador
		if (VerificaPontuacao(Bola, &ScoreJog1, &ScoreJog2)) {				
			InicializaBola(&Bola, SCREEN_J / 2, 'O'); //Reinicia a Bola
			BolaX *= -1;
		}
		//Verifica se o Jogador 1 conseguiu rebater a Bola
		Rebate(&Jogador1, &Bola, &BolaX);
		//Verifica se o Jogador 2 conseguiu rebater a Bola
		Rebate(&Jogador2, &Bola, &BolaX);
		usleep(SET_SLEEP); //Diminui a velocidade de execução do Loop
		printf("\033c"); //Reseta
	}

	return 0;

}
