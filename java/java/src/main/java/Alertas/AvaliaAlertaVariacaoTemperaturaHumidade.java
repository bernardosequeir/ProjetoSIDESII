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

	//TODO tratar do null
	private void avaliaAlerta() {
		if (medicao.getValorMedicao() >= Alerta.getLimite(medicao.getTipoMedicao())) {
			Alerta.enviaAlerta("Incendio", medicao);
		} else {
			String tipoMedicaousada = null;
			if (medicao.getTipoMedicao().equals("tmp"))
				tipoMedicaousada = "tmp";
			else if (medicao.getTipoMedicao().equals("hum")) {
				tipoMedicaousada = "hum";

			}
			if (tipoMedicaousada != null) {
				boolean crescimentoInstantaneo = (medicao.getValorMedicao()
						/ Alerta.getUltimoValor(tipoMedicaousada).getValorMedicao()
						- 1 > Alerta.getCrescimentoInstantaneo(tipoMedicaousada));
				boolean crescimentoGradual = (medicao.getValorMedicao()
						/ Alerta.getPrimeiroValor(tipoMedicaousada).getValorMedicao()
						- 1 > Alerta.getCrescimentoGradual(tipoMedicaousada));

				if (crescimentoInstantaneo || crescimentoGradual) {
					System.out.println(crescimentoInstantaneo + " " + crescimentoGradual);
					if (tipoMedicaousada.equals("hum"))
						Alerta.enviaAlerta("Aumento Humidade", medicao);
					else if (tipoMedicaousada.equals("tmp"))
						Alerta.enviaAlerta("Aumento Temperatura", medicao);
				}
			}
		}
	}
}