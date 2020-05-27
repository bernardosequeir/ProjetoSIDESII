package Alertas;

import java.util.LinkedList;

import Anomalias.Medicao;

public class AvaliaAlertaVariacaoTemperaturaHumidade {

	LinkedList<Medicao> lastValues = new LinkedList<Medicao>();
	
	private double d;
	private Medicao medicao;
	
	public AvaliaAlertaVariacaoTemperaturaHumidade(Medicao m) {
		this.medicao = m;
		
		avaliaAlerta();
		
		Alerta.adicionaValor(m);
	}

	
	private void avaliaAlerta() {
		if(d >= Alerta.getLimite(medicao.getTipoMedicao())) {
			//Alerta.enviaAlerta();
		} else {
			boolean crescimentoInstantaneo = (d / Alerta.getUltimoValor("tmp").getValorMedicao() - 1 > Alerta.getCrescimentoInstantaneo("tmp"));
			boolean crescimentoGradual = (d / Alerta.getPrimeiroValor("tmp").getValorMedicao() - 1 > Alerta.getCrescimentoGradual("tmp"));
			
			if(crescimentoInstantaneo || crescimentoGradual) {
				System.out.println(crescimentoInstantaneo+" "+crescimentoGradual);
				//Alerta.enviaAlerta();
			}
		}
	}

}
