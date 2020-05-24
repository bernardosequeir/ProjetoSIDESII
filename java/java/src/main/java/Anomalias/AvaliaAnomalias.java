package Anomalias;

import java.util.ArrayList;
import java.util.List;

import Alertas.Alerta;
import Alertas.AvaliaAlertaAssalto;
import Alertas.AvaliaAlertaTemperaturaHumidade;

public class AvaliaAnomalias {
	private int tamanhoBuffer;
	private double ultimaMedicaoValida = 0.0;
	private double variacaoMaxima;
	private ArrayList<Medicao> medicoes;
	private Alerta alerta;

	public AvaliaAnomalias(int tamanhoBuffer, double variacaoMaxima) {
		this.alerta = alerta;
		this.tamanhoBuffer = tamanhoBuffer;
		this.variacaoMaxima = variacaoMaxima;
		medicoes = new ArrayList<Medicao>();
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
						new InsereMedicoesNoMySql(lista.get(i));
						break;
					}
					
					j++;
					
				}
				
				if(!anomalia) {
					ultimaMedicaoValida = lista.get(i).getValorMedicao();
					avaliaPossivelAlertaEInsereMedicaoNoMysql(lista.get(i));
				}
				
			} else {
				ultimaMedicaoValida = lista.get(i).getValorMedicao();
				avaliaPossivelAlertaEInsereMedicaoNoMysql(lista.get(i));
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
	private void avaliaPossivelAlertaEInsereMedicaoNoMysql(Medicao m) {
		new InsereMedicoesNoMySql(m);
		new AvaliaAlertaTemperaturaHumidade(m);
	}
	
 }
