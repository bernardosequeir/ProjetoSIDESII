package Anomalias;

public class AvaliaAnomalias {
	
	/*
	 * ValorMedicao
	 * TipoSensor
	 * dataHoraMedicao
	 * possivelAnomalia
	 * 
	 * */
	
	private double[][] temperaturas;
	private double[][] humidades;
	private double[][] luminosidades;
	
	public AvaliaAnomalias(double[] temperaturas, double[] humidades, double[] luminosidades) {
		this.temperaturas[] = temperaturas;
		this.humidades = humidades;
		this.luminosidades = luminosidades;
		
		avaliaAnomaliaNasTemperaturas(temperaturas);
		avaliaAnomaliaNasHumidades(humidades);
		avaliaAnomaliaNasLuminosidades(luminosidades);
	}

	private void avaliaAnomaliaNasLuminosidades(double[] l) {
		
		
	}

	private void avaliaAnomaliaNasHumidades(double[] h) {
		// TODO Auto-generated method stub
		
	}

	private void avaliaAnomaliaNasTemperaturas(double[] t) {
		double sum = 0.0;
		
		for(int i = 0; i < t.length; i++) {
			sum += t[i];
		}
		
		double m = (sum / (double) t.length);
		System.out.println("Temp avg: " + m);
		System.out.println("Temp SD: " + calculateSD(t));
		
	}

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
		double[] temperaturas = {10.0, 12.0, 14.0, 16.0, 20.0};
		double[] humidades = {10.0, 12.0, 70.0, 16.0, 20.0};
		double[] luminosidades = {10.0, 12.0, 70.0, 16.0, 20.0};
		
		new AvaliaAnomalias(temperaturas, humidades, luminosidades);
	}
	
 }
