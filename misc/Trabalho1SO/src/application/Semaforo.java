package application;

import java.util.concurrent.Semaphore;

public class Semaforo {
	
	// quantidade de posi��es vazias no dep�sito
	public static Semaphore posVazias = null;
	
	// quantidade de posi��es preenchidas no dep�sito
	public static Semaphore posCheias = new Semaphore(0);
	
	public static Semaphore mutex = new Semaphore(1);
	
	public static void setPosVaziasSemaphore(int m) {
		posVazias = new Semaphore(m);
	}
	
}
