package Anomalias;

import java.util.ArrayList;

public class AvaliaAnomalias {
	
	private ArrayList<Medicao> temperaturas = new ArrayList<Medicao>();
	private ArrayList<Medicao> humidades = new ArrayList<Medicao>();
	private ArrayList<Medicao> luminosidades = new ArrayList<Medicao>();
	
	public AvaliaAnomalias(/*ArrayList<Medicao> temperaturas, ArrayList<Medicao> humidades, ArrayList<Medicao> luminosidades*/) {
		this.temperaturas = temperaturas;
		this.humidades = humidades;
		this.luminosidades = luminosidades;
		
		//avaliaAnomaliaNasTemperaturas(temperaturas);
		avaliaAnomaliaNasHumidades(humidades);
		avaliaAnomaliaNasLuminosidades(luminosidades);
	}

	private void avaliaAnomaliaNasLuminosidades(ArrayList<Medicao> l) {
		
		
	}

	private void avaliaAnomaliaNasHumidades(ArrayList<Medicao> h) {
		// TODO Auto-generated method stub
		
	}

	/*private void avaliaAnomaliaNasTemperaturas(ArrayList<Medicao> t) {
		double sum = 0.0;
		
		for(int i = 0; i < t.size(); i++) {
			sum += t[i];
		}
		
		double m = (sum / (double) t.length);
		System.out.println("Temp avg: " + m);
		System.out.println("Temp SD: " + calculateSD();
		
	}*/

	public static double calculateSD(double numArray[]) {
        double sum = 0.0, standardDeviation = 0.0;
        int length = numArray.length;

        for(double num : numArray) {
            sum += num;
        }

        double mean = sum/length;

        for(double num: numArray) {
            standardDeviation += Math.pow(num - mean, 2);
        }

        return Math.sqrt(standardDeviation/length);
    }
	
	public static void main(String[] args) {
		double[] temperaturas = {10.0, 12.0, 14.0, 16.0, 70.0};
		double[] humidades = {10.0, 12.0, 70.0, 16.0, 20.0};
		double[] luminosidades = {10.0, 12.0, 70.0, 16.0, 20.0};
		
		//new AvaliaAnomalias(temperaturas, humidades, luminosidades);
		new AvaliaAnomalias().testaAnomalia(temperaturas);
	}
	
	static double ultimaTemperaturaValida = 0.0;
	static double variacaoMaxima = 0.25;

	private void testaAnomalia(double[] t) {
		boolean anomalia = false;
		
		//Caso seja o primeiro buffer em verifica��o, ele compara o primeiro valor com ele mesmo dado que n�o h� um ultimo valor valido.
		if(ultimaTemperaturaValida == 0.0) {
			ultimaTemperaturaValida = t[0];
		}
		
		//Vai verificar cada valor do array
		for(int i = 0; i < t.length; i++) {
			anomalia = false;
			
			//Caso este valor tenha um crescimento acima do normal relativamente ao ultimo valor valido, entra porque pode ser uma possivel anomalia
			if(Math.abs( (t[i]/ultimaTemperaturaValida) - 1 ) >= variacaoMaxima) {
				
				int j = i + 1;
				
				while((j < t.length) && !anomalia) {
					
					if(Math.abs( (t[j]/t[j-1]) - 1.00 ) >= variacaoMaxima) {
						anomalia = true;
						System.err.println(t[i]);
						break;
					}
					
					j++;
					
				}
				
				if(!anomalia) {
					ultimaTemperaturaValida = t[i];
					System.out.println(t[i]);
				}
				
			} else {	
				
				ultimaTemperaturaValida = t[i];
				System.out.println(t[i]);
				
			}
			
		}
		
	}
	
 }
