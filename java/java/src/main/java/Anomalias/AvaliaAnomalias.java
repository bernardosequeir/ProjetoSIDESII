package Anomalias;

import java.util.ArrayList;
import java.util.List;

import Alertas.AvaliaAlertaAssalto;
import Alertas.AvaliaAlertaHumidade;
import Alertas.AvaliaAlertaTemperatura;

public class AvaliaAnomalias {
	private int tamanhoBuffer;
	private double ultimaMedicaoValida = 0.0;
	private double variacaoMaxima;
	private ArrayList<Medicao> medicoes;

	public AvaliaAnomalias(int tamanhoBuffer, double variacaoMaxima) {
		this.tamanhoBuffer = tamanhoBuffer;
		this.variacaoMaxima = variacaoMaxima;
		medicoes = new ArrayList<Medicao>();
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
		if(ultimaMedicaoValida == 0.0) {
			ultimaMedicaoValida = lista.get(0).getValorMedicao();
		}
		
		//Vai verificar cada valor do array
		for(int i = 0; i < lista.size(); i++) {
			anomalia = false;
			
			//Caso este valor tenha um crescimento acima do normal relativamente ao ultimo valor valido, entra porque pode ser uma possivel anomalia
			if(Math.abs( (lista.get(i).getValorMedicao()/ultimaMedicaoValida) - 1 ) >= ultimaMedicaoValida) {
				
				int j = i + 1;
				
				while((j < lista.size()) && !anomalia) {
					
					if(Math.abs( (lista.get(j - 1).getValorMedicao()/lista.get(j).getValorMedicao()) - 1.00 ) >= variacaoMaxima) {
						anomalia = true;
						new InsereAnomaliasNoMySql(lista.get(i));
						break;
					}
					
					j++;
					
				}
				
				if(!anomalia) {
					ultimaMedicaoValida = lista.get(i).getValorMedicao();
					avaliaPossivelAlerta(lista.get(i));
				}
				
			} else {
				ultimaMedicaoValida = lista.get(i).getValorMedicao();
				avaliaPossivelAlerta(lista.get(i));
			}
			
		}
		
	}

	public void addicionarValores(Medicao m){
		while(medicoes.size() < tamanhoBuffer){
			medicoes.add(m);
		}
		if(medicoes.size() == tamanhoBuffer)
		{
			testaAnomalia(medicoes);
		}
	}
	private void avaliaPossivelAlerta(Medicao m) {
		if (m.getTipoMedicao().equals("tmp")){
			//mando para AvaliaAlertaTemperatura
		} else if (m.getTipoMedicao().equals("hum")){
			//mando para AvaliaAlertaHumidade
		}
	}
	
 }
