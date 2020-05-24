package Alertas;

import java.util.LinkedList;

import Anomalias.Medicao;

public class AvaliaAlertaTemperaturaHumidade {

	LinkedList<Medicao> lastValues = new LinkedList<Medicao>();
	
	private double d;
	
	public AvaliaAlertaTemperaturaHumidade(Medicao m) {
		this.d = d;
		
		avaliaAlerta();
		
		Alerta.adicionaValor(d);
	}

	private void avaliaAlerta() {
		if(d >= Alerta.getLimiteTemperatura()) {
			enviaAlerta();
		} else {
			boolean crescimentoInstantaneo = (d / Alerta.getUltimoValor("tmp") - 1 > Alerta.getCrescimentoInstantaneo("tmp"));
			boolean crescimentoGradual = (d / Alerta.getPrimeiroValor("tmp") - 1 > Alerta.getCrescimentoGradual("tmp"));
			
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
