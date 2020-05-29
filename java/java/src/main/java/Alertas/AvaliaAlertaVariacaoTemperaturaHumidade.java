package Alertas;

import java.util.LinkedList;

import Anomalias.Medicao;

public class AvaliaAlertaVariacaoTemperaturaHumidade {

	private Medicao medicao;

	public AvaliaAlertaVariacaoTemperaturaHumidade(Medicao m) {
		this.medicao = m;
		Alerta.adicionaValor(m);
		avaliaAlerta();
	}

	
	private void avaliaAlerta() {
		Double limiteMaximo = Alerta.getLimite(medicao.getTipoMedicao());
		if (medicao.getValorMedicao() >= limiteMaximo) {
			Alerta.enviaAlerta("Incendio", medicao,Double.toString(limiteMaximo)); 
		} else {
			String tipoMedicaousada = null;
			if (medicao.getTipoMedicao().equals("tmp"))
				tipoMedicaousada = "tmp";
			else if (medicao.getTipoMedicao().equals("hum")) {
				tipoMedicaousada = "hum";

			}
			//TODO verificar se não é null por exemplo getCrescimentoGradual etc
			if (tipoMedicaousada != null) {
				boolean crescimentoInstantaneo = (medicao.getValorMedicao()
						/ Alerta.getUltimoValor(tipoMedicaousada).getValorMedicao()
						- 1 > Alerta.getCrescimentoInstantaneo(tipoMedicaousada));
				boolean crescimentoGradual = (medicao.getValorMedicao()
						/ Alerta.getPrimeiroValor(tipoMedicaousada).getValorMedicao()
						- 1 > Alerta.getCrescimentoGradual(tipoMedicaousada));

				if (crescimentoInstantaneo) {
					if (tipoMedicaousada.equals("hum"))
						Alerta.enviaAlerta("Aumento Humidade (Instantaneo)", medicao,limiteEmPercentagem(Alerta.getCrescimentoInstantaneo(tipoMedicaousada)));
					else if (tipoMedicaousada.equals("tmp"))
						Alerta.enviaAlerta("Aumento Temperatura (Instantaneo)", medicao,limiteEmPercentagem(Alerta.getCrescimentoInstantaneo(tipoMedicaousada)));
				}else if (crescimentoGradual) {
					if (tipoMedicaousada.equals("hum"))
						Alerta.enviaAlerta("Aumento Humidade (Gradual)", medicao,limiteEmPercentagem(Alerta.getCrescimentoGradual(tipoMedicaousada)));
					else if (tipoMedicaousada.equals("tmp"))
						Alerta.enviaAlerta("Aumento Temperatura  (Gradual)", medicao,limiteEmPercentagem(Alerta.getCrescimentoGradual(tipoMedicaousada)));
				}
			}
		}
	}
	
	public String limiteEmPercentagem(double limite) {
		System.out.println(Double.toString(limite * 100) + "%");
		return Double.toString(limite * 100) + "%";
		
		
	}
}