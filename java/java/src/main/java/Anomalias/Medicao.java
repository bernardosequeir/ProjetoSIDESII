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

	//TODO verificar datas
	public Medicao(String valorMedicao, String tipoMedicao, String dataHoraMedicao) throws Exception {
		if (tipoMedicao.equals("tmp") || tipoMedicao.equals("hum") || tipoMedicao.equals("lum")
				|| tipoMedicao.equals("mov")) {
			//TODO isto pode ser tudo reescrito
			checkTipo(valorMedicao);
			if ((tipoMedicao.equals("hum") || tipoMedicao.equals("lum")) && !possivelAnomalia) {
				checkPositivo(valorMedicao);
			} 
			if (tipoMedicao.equals("mov") && !possivelAnomalia) {
				checkMovimento(valorMedicao);
			}
			this.tipoMedicao = tipoMedicao;
			this.dataHoraMedicao = dataHoraMedicao;
		} else {
			throw new Exception("TipoMedicao is invalid - only tmp, hum, lum and mov are allowed");
		}
	}

	/**
	 * Checks whether the valorMedicao already in double form(which is confirmed previously to be a double) is not negative. 
	 * @param valorMedicao
	 */
	private void checkPositivo(String valorMedicao) {
		if (this.valorMedicao < 0.0) {
			this.valorMedicaoAnomalo = valorMedicao;
			marcarComoAnomalia();
		}
	}

	private void checkMovimento(String valorMedicao) {
		if (Double.compare(this.valorMedicao, 0.0) != 0 && Double.compare(this.valorMedicao, 1.0) != 0) {
			this.valorMedicaoAnomalo = valorMedicao;
			marcarComoAnomalia();
		}
	}

	//TODO reescrever metodo
	private void checkTipo(String valorMedicao) {
		System.out.println(valorMedicao);
		try {
			this.valorMedicao = Double.valueOf(valorMedicao);
		} catch (Exception e) {
			valorMedicaoAnomalo = valorMedicao;
			marcarComoAnomalia();
		}
	}

	public void marcarComoAnomalia() {
		possivelAnomalia = true;
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