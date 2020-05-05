package Alertas;

import java.util.LinkedList;

public class Alertas {

	static LinkedList<Double> ultimosValoresTemperatura = new LinkedList<Double>();
	static LinkedList<Double> ultimosValoresHumidade = new LinkedList<Double>();
	static LinkedList<Double> ultimosValoresLuminosidade = new LinkedList<Double>();

	private static int tamanhoBuffer = 5;
	
	//Variaveis de temperatura
	private static double limiteTemperatura = 50;
	private static double crescimentoInstantaneoTemperatura = 0.15;
	private static double crescimentoGradualTemperatura = 0.25;
	
	//Variaveis de humidade
	
	//Variaveis de assalto

	public static void adicionaValor(double val) {
		int tipo = 0;
		switch (tipo) {
			case 0:
				if (ultimosValoresTemperatura.size() == tamanhoBuffer) {
					ultimosValoresTemperatura.poll();
					ultimosValoresTemperatura.add(val);

				} else {
					ultimosValoresTemperatura.add(val);

				}
				break;
			case 1:
	
				break;
			case 2:
	
				break;

		default:
			break;
		}
		
	}

	public static void defineTamanhoBuffer(int n) {
		tamanhoBuffer = n;
	}
	
	public static void defineValoresTemperatura(double limiteTemperatura, double crescimentoInstantaneo, double crescimentoGradual) {
		limiteTemperatura = limiteTemperatura;
		crescimentoInstantaneo = crescimentoInstantaneo;
		crescimentoGradual = crescimentoGradual;
	}

	public static double getLimiteTemperatura() {
		return limiteTemperatura;
	}

	public static double getUltimoValor(String string) {
		int tipo = 0;
		switch (tipo) {
			case 0:
				double n = -1.0;
				if(ultimosValoresTemperatura.size() != 0) {
					n = ultimosValoresTemperatura.getLast();
				}
				return n;
				
			case 1:
	
				return -1.0;
			case 2:
	
				return -1.0;

			default:
				break;
		}
		return tipo;
	}

	public static double getPrimeiroValor(String string) {
		int tipo = 0;
		switch (tipo) {
			case 0:
				double n = -1.0;
				if(ultimosValoresTemperatura.size() != 0.0) {
					n = ultimosValoresTemperatura.getFirst();
				}
				return n;
				
			case 1:
	
				return -1.0;
			case 2:
	
				return -1.0;

			default:
				break;
		}
		return tipo;
	}
	
	public static double getCrescimentoInstantaneo(String string) {
		int tipo = 0;
		switch (tipo) {
			case 0:
				return crescimentoInstantaneoTemperatura;
				
			case 1:
	
				return -1.0;
			case 2:
	
				return -1.0;

			default:
				break;
		}
		return tipo;
	}

	public static double getCrescimentoGradual(String string) {
		int tipo = 0;
		switch (tipo) {
			case 0:
				return crescimentoGradualTemperatura;
				
			case 1:
	
				return -1.0;
			case 2:
	
				return -1.0;

			default:
				break;
		}
		return tipo;
	}
}
