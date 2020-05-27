package Alertas;

import java.util.LinkedList;

import Anomalias.Medicao;

public class AvaliaAlertaVariacaoTemperaturaHumidade {

	private Medicao medicao;
	
	public AvaliaAlertaVariacaoTemperaturaHumidade(Medicao m) {
		this.medicao = m;
		
		avaliaAlerta();
		
		Alerta.adicionaValor(m);
	}

<<<<<<< HEAD
	
=======
>>>>>>> parent of b57f342... Somethings not right
	private void avaliaAlerta() {
		if(medicao.getValorMedicao() >= Alerta.getLimite(medicao.getTipoMedicao())) {
			Alerta.enviaAlerta("Incendio", medicao);
		} else {
			boolean crescimentoInstantaneo = (medicao.getValorMedicao() / Alerta.getUltimoValor("tmp").getValorMedicao() - 1 > Alerta.getCrescimentoInstantaneo("tmp"));
			boolean crescimentoGradual = (medicao.getValorMedicao() / Alerta.getPrimeiroValor("tmp").getValorMedicao() - 1 > Alerta.getCrescimentoGradual("tmp"));
			
			if(crescimentoInstantaneo || crescimentoGradual) {
				System.out.println(crescimentoInstantaneo+" "+crescimentoGradual);
				Alerta.enviaAlerta("Aumento Temperatura", medicao);
			}
		}
	}

}
