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
	private String valorMedicaoAnomalo;

	public String getDataHoraMedicao() {
		return dataHoraMedicao;
	}

	public Medicao(String valorMedicao, String tipoMedicao, String dataHoraMedicao) {
		checkTipo(valorMedicao);
		if ((tipoMedicao.equals("hum") || tipoMedicao.equals("lum")) && !possivelAnomalia) {
			checkPositivo(valorMedicao);
		}
		if (tipoMedicao.equals("mov") && !possivelAnomalia) {
			checkMovimento(valorMedicao);
		}
		this.tipoMedicao = tipoMedicao;
		this.dataHoraMedicao = dataHoraMedicao;
	}

	private void checkPositivo(String valorMedicao) {
		if (this.valorMedicao < 0.0) {
			this.valorMedicaoAnomalo = valorMedicao;
			possivelAnomalia = true;
		}
	}

	private void checkMovimento(String valorMedicao) {
		if (Double.compare(this.valorMedicao, 0.0)!=0 && Double.compare(this.valorMedicao, 1.0)!=0) {
			this.valorMedicaoAnomalo = valorMedicao;
			possivelAnomalia = true;
		}
	}

	private void checkTipo(String valorMedicao) {
		System.out.println(valorMedicao);
		try {
				this.valorMedicao = Double.valueOf(valorMedicao);
		} catch (Exception e) {
			valorMedicaoAnomalo = valorMedicao;
			possivelAnomalia = true;
		}
	}

	public String getValorMedicaoAnomalo() {
		System.out.println(valorMedicaoAnomalo);
		return valorMedicaoAnomalo;
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
