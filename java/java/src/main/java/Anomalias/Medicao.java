package Anomalias;

import conn.MongoParaMysql;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Properties;
import java.util.TimeZone;

public class Medicao {

	private double valorMedicao;
	private String tipoMedicao;
	private String dataHoraMedicao;
	private boolean possivelAnomalia = false;
	private String valorMedicaoAnomalo;

	public String getDataHoraMedicao() {
		return dataHoraMedicao;
	}

	public Medicao(String valorMedicao, String tipoMedicao, String dataHoraMedicao)  {
		if (tipoMedicao.equals("tmp") || tipoMedicao.equals("hum") || tipoMedicao.equals("lum")
				|| tipoMedicao.equals("mov")) {
			verificaSeEDouble(valorMedicao);
			verificaSeDataEValida(dataHoraMedicao, valorMedicao);
			if ((tipoMedicao.equals("hum") || tipoMedicao.equals("lum")) && !possivelAnomalia) {
				verificaSeEPositivo(valorMedicao);
			} 
			if (tipoMedicao.equals("mov") && !possivelAnomalia) {
				verificaSeMovimentoEAnomalia(valorMedicao);
			}
			this.tipoMedicao = tipoMedicao;
			this.dataHoraMedicao = dataHoraMedicao;
		} else {
			System.err.println("TipoMedicao is invalid - only tmp, hum, lum and mov are allowed");
		}
	}
	/**
	 * Checks whether the valorMedicao already in double form(which is confirmed previously to be a double) is not negative. 
	 * @param valorMedicao
	 */
	private void verificaSeEPositivo(String valorMedicao) {
		if (this.valorMedicao < 0.0) {
			this.valorMedicaoAnomalo = valorMedicao;
			marcarComoAnomalia(valorMedicao);
		}
	}

	private void verificaSeMovimentoEAnomalia(String valorMedicao) {
		if (Double.compare(this.valorMedicao, 0.0) != 0 && Double.compare(this.valorMedicao, 1.0) != 0) {
			marcarComoAnomalia(valorMedicao);
		}
	}


	private void verificaSeEDouble(String valorMedicao) {
		System.out.println(valorMedicao);
		try {
			this.valorMedicao = Double.valueOf(valorMedicao);
		} catch (Exception e) {
			marcarComoAnomalia(valorMedicao);
		}
	}
	
	private void verificaSeDataEValida(String dataHoraMedicao, String valorMedicao){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		try {
			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String formatDateTime = now.format(formatter);
			Date dataAgora = dateFormat.parse(formatDateTime);
			Date parsedDate = dateFormat.parse(dataHoraParaFormatoCerto(dataHoraMedicao));
			if(dataAgora.getTime() - parsedDate.getTime() > MongoParaMysql.getTempoLimiteMedicao() * 60 * 1000){
				System.out.println("antiga " + parsedDate.getTime() + dataAgora.getTime());
			 	marcarComoAnomalia(valorMedicao);
			 }
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
	public void marcarComoAnomalia(String valorMedicao) {
		this.valorMedicaoAnomalo = valorMedicao;
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

	public void setPossivelAnomalia(boolean possivelAnomalia) {
		this.possivelAnomalia = possivelAnomalia;
	}

	public int getValorAnomalia() {
		if (isAnomalo()) {
			this.valorMedicaoAnomalo = String.valueOf(valorMedicao);
			return 1;
		}
		return 0;
	}

	//TODO este codigo esta repetido

	
	public String dataHoraParaFormatoCerto(String dataHoraMedicao) {

		String timezone;
		SimpleDateFormat timeFormatISO = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		try {
			Properties p = new Properties();
			p.load(new FileInputStream("cloudToMongo.ini"));
			timezone = p.getProperty("timezone");
			Date date = timeFormatISO.parse(dataHoraMedicao);
			Timestamp stamp =  new Timestamp(date.getTime());
			SimpleDateFormat timeFormatISO2 = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
			timeFormatISO2.setTimeZone(TimeZone.getTimeZone(timezone));
			return timeFormatISO2.format(stamp);
		} catch (ParseException e) {
			System.err.println("Unable to parse/find the date: " + dataHoraMedicao + " " + e);
		} catch (FileNotFoundException e) {
			System.err.println("Unable to find cloudToMongo.ini " + e);
		} catch (IOException e) {
			System.err.println("I/O exception when reading cloudToMongo.ini " +e);
		}

		return null;
	}
}