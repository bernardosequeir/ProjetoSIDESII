package Anomalias;

import java.util.ArrayList;
import java.util.List;

import Alertas.AvaliaAlertaAssalto;
import Alertas.AvaliaAlertaHumidade;
import Alertas.AvaliaAlertaTemperatura;

public class AvaliaAnomalias {
	private int tamanhoBuffer;
	private double ultimaTemperaturaValida = 0.0;
	private double ultimaHumidadeValida = 0.0;
	private double variacaoMaximaTemperatura;
	private double variacaoMaximaHumidade;
	private ArrayList<Medicao> temperaturas = new ArrayList<Medicao>();
	private ArrayList<Medicao> humidades = new ArrayList<Medicao>();

	public AvaliaAnomalias(int tamanhoBuffer, double variacaoMaximaTemperatura, double variacaoMaximaHumidade) {
		this.tamanhoBuffer = tamanhoBuffer;
	}

	public static void main(String[] args) {
		double[] temperaturas1 = {0.0, 0.0, 1.0, 1.0, 0.0};
		double[] temperaturas2 = {0.0, 0.0, 0.0, 0.0, 0.0};

		double[] humidades = {10.0, 20.0, 30.0, 50.0, 70.0};
		double[] luminosidades = {75.0, 80.0, 80.0, 16.0, 20.0};
		
		// AvaliaAnomalias(temperaturas, humidades, luminosidades);
		//new AvaliaAnomalias(5,0.8,0.8).testaAnomalia(temperaturas1);
		//new AvaliaAnomalias(5,0.8,0.8).testaAnomalia(temperaturas2);

	}

	private void testaAnomalia(List<Medicao> lista) {
		boolean anomalia = false;
		
		//Caso seja o primeiro buffer em verificação, ele compara o primeiro valor com ele mesmo dado que não há um ultimo valor valido.
		if(ultimaTemperaturaValida == 0.0) {
			ultimaTemperaturaValida = lista.get(0).getValorMedicao();
		}
		
		//Vai verificar cada valor do array
		for(int i = 0; i < lista.size(); i++) {
			anomalia = false;
			
			//Caso este valor tenha um crescimento acima do normal relativamente ao ultimo valor valido, entra porque pode ser uma possivel anomalia
			if(Math.abs( (lista.get(i).getValorMedicao()/ultimaTemperaturaValida) - 1 ) >= variacaoMaximaTemperatura) {
				
				int j = i + 1;
				
				while((j < lista.size()) && !anomalia) {
					
					if(Math.abs( (lista.get(j - 1).getValorMedicao()/lista.get(j).getValorMedicao()) - 1.00 ) >= variacaoMaximaTemperatura) {
						anomalia = true;
						System.out.println(lista.get(i).getValorMedicao() + "x");
						break;
					}
					
					j++;
					
				}
				
				if(!anomalia) {
					ultimaTemperaturaValida = lista.get(i).getValorMedicao();
					avaliaPossivelAlerta(lista.get(i).getValorMedicao());
				}
				
			} else {
				ultimaTemperaturaValida = lista.get(i).getValorMedicao();
				avaliaPossivelAlerta(lista.get(i).getValorMedicao());
			}
			
		}
		
	}

	public void addicionarValores(Medicao m){
		while(temperaturas.size() < tamanhoBuffer){
			temperaturas.add(m);
		}
		if(temperaturas.size() == tamanhoBuffer)
		{
			testaAnomalia(temperaturas);
		}
	}
	private void avaliaPossivelAlerta(double d) {
		System.out.println(d);
		int tipo = 0;
		
		switch (tipo) {
			case 0:
				new AvaliaAlertaTemperatura(d);
				break;
				
			case 1:
				new AvaliaAlertaHumidade(d);
				break;
				
			case 2:
				new AvaliaAlertaAssalto(d);
				
			default:
				break;
		}
	}
	
 }
