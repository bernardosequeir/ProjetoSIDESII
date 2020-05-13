package Alertas;

import java.util.LinkedList;

public class AvaliaAlertaTemperatura {

	LinkedList<Medicao> lastValues = new LinkedList<Medicao>();
	
	private double d;
	
	public AvaliaAlertaTemperatura(Medicao m,double limite) {
		this.d = d;
		
		avaliaAlerta();
		
		Alertas.adicionaValor(d);
	}

	private void avaliaAlerta() {
		if(d >= Alertas.getLimiteTemperatura()) {
			enviaAlertaIncendio();
		} else {
			boolean crescimentoInstantaneo = (d / Alertas.getUltimoValor("tmp") - 1 > Alertas.getCrescimentoInstantaneo("tmp"));
			boolean crescimentoGradual = (d / Alertas.getPrimeiroValor("tmp") - 1 > Alertas.getCrescimentoGradual("tmp"));
			
			if(crescimentoInstantaneo || crescimentoGradual) {
				System.out.println(crescimentoInstantaneo+" "+crescimentoGradual);
				enviaAlertaPossivelIncendio();
			}
		}
	}

	private void enviaAlertaPossivelIncendio() {
		System.out.println("POSSIVEL INCENDIO");
		
	}

	private void enviaAlertaIncendio() {
		System.out.println("INCENDIO");
		
	}

}
