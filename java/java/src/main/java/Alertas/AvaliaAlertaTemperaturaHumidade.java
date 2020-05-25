package Alertas;

import java.util.LinkedList;

import Anomalias.Medicao;

public class AvaliaAlertaTemperaturaHumidade {

	LinkedList<Medicao> lastValues = new LinkedList<Medicao>();
	
	private double d;
	private String tipoMedicao;
	
	public AvaliaAlertaTemperaturaHumidade(Medicao m) {
		this.tipoMedicao = m.getTipoMedicao();
		
		avaliaAlerta();
		
		Alerta.adicionaValor(d);
	}

	
	private void avaliaAlerta() {
		if(d >= Alerta.getLimite(tipoMedicao)) {
			//Alerta.enviaAlerta();
		} else {
			boolean crescimentoInstantaneo = (d / Alerta.getUltimoValor("tmp") - 1 > Alerta.getCrescimentoInstantaneo("tmp"));
			boolean crescimentoGradual = (d / Alerta.getPrimeiroValor("tmp") - 1 > Alerta.getCrescimentoGradual("tmp"));
			
			if(crescimentoInstantaneo || crescimentoGradual) {
				System.out.println(crescimentoInstantaneo+" "+crescimentoGradual);
				//Alerta.enviaAlerta();
			}
		}
	}

}
