package Anomalias;

public class Medicao {

	private double valorMedicao;
	private String tipoMedicao;
	private String dataHoraMedicao;
	private boolean possivelAnomalia = false;

	public String getDataHoraMedicao() {
		return dataHoraMedicao;
	}

	public Medicao(String valorMedicao, String tipoMedicao, String dataHoraMedicao) {
		checkTipo();
		checkData();
		if ((tipoMedicao.equals("hum") || tipoMedicao.equals("lum")) && !possivelAnomalia) {
			checkPositivo();
		}
		if (tipoMedicao.equals("mov") && !possivelAnomalia) {
			checkMovimento();
		}
		this.tipoMedicao = tipoMedicao;
		this.dataHoraMedicao = dataHoraMedicao;
	}

	private void checkPositivo() {
		if (valorMedicao < 0) {
			possivelAnomalia = true;
		}
	}

	private void checkMovimento() {
		if (valorMedicao != 0.0 || valorMedicao != 1.0) {
			possivelAnomalia = true;
		}
	}

	private void checkData() {
		// TODO Implementar um método no mongo to mysql que devolve a data do último doc
		// inserido e compara com a deste
	}

	private void checkTipo() {
		try {
			valorMedicao = Double.parseDouble(tipoMedicao);
		} catch (Exception e) {
			possivelAnomalia = true;
		}
	}

	public double getValorMedicao() {
		return valorMedicao;
	}

	public String getTipoMedicao() {
		return tipoMedicao;
	}

	public boolean isAnomalo() {
		return possivelAnomalia;
	}

	public int getValorAnomalia() {
		if (isAnomalo())
			return 1;
			return 0;
	}
}
