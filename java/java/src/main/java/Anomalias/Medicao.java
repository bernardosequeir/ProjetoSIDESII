package Anomalias;

import conn.MongoParaMysql;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.TimeZone;

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
			checkData(dataHoraMedicao, valorMedicao);
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
	private void checkData(String dataHoraMedicao, String valorMedicao){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		try {
			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String formatDateTime = now.format(formatter);
			Date dataAgora = dateFormat.parse(formatDateTime);
			Date parsedDate = dateFormat.parse(dataHoraParaFormatoCerto(dataHoraMedicao));
			if(dataAgora.getTime() - parsedDate.getTime() > MongoParaMysql.getTempoLimiteMedicao() * 60 * 1000){
				System.out.println("antiga " + parsedDate.getTime() + dataAgora.getTime());
				this.valorMedicaoAnomalo = valorMedicao;
			 	marcarComoAnomalia();
			 }
		} catch (ParseException e) {
			e.printStackTrace();
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

	public String dataHoraParaFormatoCerto(String dataHoraMedicao) {

		SimpleDateFormat timeFormatISO = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		try {
			Date date = timeFormatISO.parse(dataHoraMedicao);
			Timestamp stamp =  new Timestamp(date.getTime());
			SimpleDateFormat timeFormatISO2 = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
			timeFormatISO2.setTimeZone(TimeZone.getTimeZone("GMT+1:00"));
			return timeFormatISO2.format(stamp);
		} catch (ParseException e) {
			System.err.println("Unable to parse/find the date: " + dataHoraMedicao + " " + e);
		}

		return null;
	}
}