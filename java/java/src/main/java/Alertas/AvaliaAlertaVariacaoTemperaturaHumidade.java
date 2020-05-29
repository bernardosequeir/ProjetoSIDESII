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
			if (medicao.getTipoMedicao().equals("hum")) {
				if (Alerta.verificarSeMandaAlerta(Alerta.getUltimoAlarmeLimiteHumidade(),
						medicao.getDataHoraMedicao())) {
					Alerta.enviaAlerta("Limite ultrapassado", medicao, Double.toString(limiteMaximo));
					Alerta.setUltimoAlarmeLimiteHumidade(medicao.getDataHoraMedicao());
				}
			}
			else if (medicao.getTipoMedicao().equals("tmp")) {
				if (Alerta.verificarSeMandaAlerta(Alerta.getUltimoAlarmeLimiteTemperatura(),
						medicao.getDataHoraMedicao())) {
					Alerta.enviaAlerta("Limite ultrapassado", medicao, Double.toString(limiteMaximo));
					Alerta.setUltimoAlarmeLimiteTemperatura(medicao.getDataHoraMedicao());
				}
			}
		} else {
			String tipoMedicaousada = null;
			if (medicao.getTipoMedicao().equals("tmp"))
				tipoMedicaousada = "tmp";
			else if (medicao.getTipoMedicao().equals("hum")) {
				tipoMedicaousada = "hum";

			}
			// TODO verificar se não é null por exemplo getCrescimentoGradual etc
			if (tipoMedicaousada != null) {
				boolean crescimentoInstantaneo = (medicao.getValorMedicao()
						/ Alerta.getUltimoValor(tipoMedicaousada).getValorMedicao()
						- 1 > Alerta.getCrescimentoInstantaneo(tipoMedicaousada));
				boolean crescimentoGradual = (medicao.getValorMedicao()
						/ Alerta.getPrimeiroValor(tipoMedicaousada).getValorMedicao()
						- 1 > Alerta.getCrescimentoGradual(tipoMedicaousada));

				if (crescimentoInstantaneo) {
					if (tipoMedicaousada.equals("hum")) {
						if (Alerta.verificarSeMandaAlerta(Alerta.getUltimoAlarmeCrescimentoHumidade(),
								medicao.getDataHoraMedicao())
								&& Alerta.verificarSeMandaAlerta(Alerta.getUltimoAlarmeLimiteHumidade(),
										medicao.getDataHoraMedicao())) {
							Alerta.enviaAlerta("Aumento Humidade (Instantaneo)", medicao,
									limiteEmPercentagem(Alerta.getCrescimentoInstantaneo(tipoMedicaousada)));
							Alerta.setUltimoAlarmeCrescimentoHumidade(medicao.getDataHoraMedicao());
							System.out.println("entrada em " + medicao.getDataHoraMedicao());
						}
					} else if (tipoMedicaousada.equals("tmp")) {
						if (Alerta.verificarSeMandaAlerta(Alerta.getUltimoAlarmeCrescimentoTemperatura(),
								medicao.getDataHoraMedicao())
								&& Alerta.verificarSeMandaAlerta(Alerta.getUltimoAlarmeLimiteTemperatura(),
										medicao.getDataHoraMedicao())) {

							Alerta.enviaAlerta("Aumento Temperatura (Instantaneo)", medicao,
									limiteEmPercentagem(Alerta.getCrescimentoInstantaneo(tipoMedicaousada)));
							Alerta.setUltimoAlarmeCrescimentoTemperatura(medicao.getDataHoraMedicao());
							System.out.println("entrada em " + medicao.getDataHoraMedicao());
						}
					} else if (crescimentoGradual) {
						if (tipoMedicaousada.equals("hum")) {
							if (Alerta.verificarSeMandaAlerta(Alerta.getUltimoAlarmeCrescimentoHumidade(),
									medicao.getDataHoraMedicao())
									&& Alerta.verificarSeMandaAlerta(Alerta.getUltimoAlarmeLimiteHumidade(),
											medicao.getDataHoraMedicao())) {
								Alerta.enviaAlerta("Aumento Humidade (Gradual)", medicao,
										limiteEmPercentagem(Alerta.getCrescimentoGradual(tipoMedicaousada)));
								Alerta.setUltimoAlarmeCrescimentoHumidade(medicao.getDataHoraMedicao());
							} else if (tipoMedicaousada.equals("tmp")) {
								if (Alerta.verificarSeMandaAlerta(Alerta.getUltimoAlarmeCrescimentoTemperatura(),
										medicao.getDataHoraMedicao())
										&& Alerta.verificarSeMandaAlerta(Alerta.getUltimoAlarmeLimiteTemperatura(),
												medicao.getDataHoraMedicao())) {
									Alerta.enviaAlerta("Aumento Temperatura  (Gradual)", medicao,
											limiteEmPercentagem(Alerta.getCrescimentoGradual(tipoMedicaousada)));
									Alerta.setUltimoAlarmeCrescimentoTemperatura(medicao.getDataHoraMedicao());
								}
							}
						}
					}
				}
			}
		}
	}

	public String limiteEmPercentagem(double limite) {
		System.out.println(Double.toString(limite * 100) + "%");
		return Double.toString(limite * 100) + "%";

	}
}