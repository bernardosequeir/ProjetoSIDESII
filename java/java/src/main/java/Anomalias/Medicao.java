package Anomalias;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Medicao {

	private double valorMedicao;
	private String tipoMedicao;
	private String dataHoraMedicao;
	private String dataHoraFormatado;
	private boolean possivelAnomalia = false;

	public String getDataHoraMedicao() {
		return dataHoraMedicao;
	}

	public Medicao(String valorMedicao, String tipoMedicao, String dataHoraMedicao) {
		checkTipo(valorMedicao);
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
		if (valorMedicao < 0.0) {
			possivelAnomalia = true;
		}
	}

	private void checkMovimento() {
		if (Double.compare(valorMedicao, 0.0)!=0 && Double.compare(valorMedicao, 1.0)!=0) {
			possivelAnomalia = true;
		}
	}

	private void checkTipo(String valorMedicao) {
		System.out.println(valorMedicao);
		try {
				this.valorMedicao = Double.valueOf(valorMedicao);
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
