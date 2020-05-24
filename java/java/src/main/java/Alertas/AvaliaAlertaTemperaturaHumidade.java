package Alertas;

import java.util.LinkedList;

import Anomalias.Medicao;

public class AvaliaAlertaTemperaturaHumidade {

	LinkedList<Medicao> lastValues = new LinkedList<Medicao>();
	
	private double d;
	
	public AvaliaAlertaTemperaturaHumidade(Medicao m) {
		this.d = d;
		
		avaliaAlerta();
		
		Alertas.adicionaValor(d);
	}

	private void avaliaAlerta() {
		if(d >= Alertas.getLimiteTemperatura()) {
			enviaAlerta();
		} else {
			boolean crescimentoInstantaneo = (d / Alertas.getUltimoValor("tmp") - 1 > Alertas.getCrescimentoInstantaneo("tmp"));
			boolean crescimentoGradual = (d / Alertas.getPrimeiroValor("tmp") - 1 > Alertas.getCrescimentoGradual("tmp"));
			
			if(crescimentoInstantaneo || crescimentoGradual) {
				System.out.println(crescimentoInstantaneo+" "+crescimentoGradual);
				enviaAlerta();
			}
		}
	}

	private void enviaAlertaPossivel() {
		System.out.println("POSSIVEL INCENDIO");
		
	}

	private void enviaAlerta() {
		System.out.println("INCENDIO");
		
	}

}
