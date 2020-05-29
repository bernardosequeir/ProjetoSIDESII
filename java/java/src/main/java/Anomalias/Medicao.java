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

	public Medicao(String valorMedicao, String tipoMedicao, String dataHoraMedicao) {
		if (tipoMedicao.equals("tmp") || tipoMedicao.equals("hum") || tipoMedicao.equals("lum")
				|| tipoMedicao.equals("mov")) {
			this.dataHoraMedicao = this.dataHoraParaFormatoCerto(dataHoraMedicao);
			verificaSeEDouble(valorMedicao);
			verificaSeDataEValida(valorMedicao);
			if ((tipoMedicao.equals("hum") || tipoMedicao.equals("lum")) && !possivelAnomalia) {
				verificaSeEPositivo(valorMedicao);
			}
			if (tipoMedicao.equals("mov") && !possivelAnomalia) {
				verificaSeMovimentoEAnomalia(valorMedicao);
			}
			this.tipoMedicao = tipoMedicao;
		} else {
			System.err.println("TipoMedicao is invalid - only tmp, hum, lum and mov are allowed");
		}
	}


	/**
	 * Checks whether the valorMedicao already in double form(which is confirmed
	 * previously to be a double) is not negative.
	 * 
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

	private void verificaSeDataEValida( String valorMedicao) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		try {
			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String formatDateTime = now.format(formatter);
			Date dataAgora = dateFormat.parse(formatDateTime);
			Date parsedDate = dateFormat.parse(this.dataHoraMedicao);
			if (dataAgora.getTime() - parsedDate.getTime() > MongoParaMysql.getTempoLimiteMedicao() * 60 * 1000) {
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

	/**
	 * The data comes in as xx-xx-xx xx:xx:xx but without leading zeros. For example 1990-5-3 12:4:20 gets converted to 1990-05-03 12:04:20
	 * Due to the sensor's hour being an hour behind, it also add it to the correct date(GMT +1 +1 again).
	 * @return
	 */
	
	public String dataHoraParaFormatoCerto(String dataHoraMedicao) {

		String timezone = null;
		SimpleDateFormat timeFormatISO = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		try {
			Properties p = new Properties();
			p.load(new FileInputStream("cloudToMongo.ini"));
			String sensor = p.getProperty("cloud_topic");
			Date date = timeFormatISO.parse(dataHoraMedicao);
			Timestamp stamp = new Timestamp(date.getTime());
			SimpleDateFormat timeFormatISO2 = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
			if (sensor.equals("/sid_lab_2019_2") || sensor.equals("sid_lab_2020"))
				timezone = "GMT+2";
			else if (sensor.equals("grupo12"))
				timezone = "GMT+1";
			else System.err.println("Tipo de Sensor não definido - não é nem /sid_lab_2020 nem /sid_lab_2019_2 nem grupo12. Mudar código no dataHoraParaFormatoCerto na classe Medicao ");
			timeFormatISO2.setTimeZone(TimeZone.getTimeZone(timezone));
			return timeFormatISO2.format(stamp);
		} catch (ParseException e) {
			System.err.println("Unable to parse/find the date: " + dataHoraMedicao + " " + e);
		} catch (FileNotFoundException e) {
			System.err.println("Unable to find cloudToMongo.ini " + e);
		} catch (IOException e) {
			System.err.println("I/O exception when reading cloudToMongo.ini ");
		}

		return null;
	}
}