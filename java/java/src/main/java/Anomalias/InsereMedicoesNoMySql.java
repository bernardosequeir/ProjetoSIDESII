package Anomalias;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import conn.ConnectToMySql;
import conn.MongoParaMysql;

public class InsereMedicoesNoMySql {

	private Medicao medicao;
	private Connection conn;
	private String database_password;
	private String database_user;
	private String database_connection;
	private Statement s;
	private String Sqlcommando;

	public InsereMedicoesNoMySql(Medicao medicao) {
		this.medicao = medicao;
		
	}

	/**
	 * Connects to the MySQL database
	 */
	public void connect() {
		try {
			conn = ConnectToMySql.connect();
			s = conn.createStatement();
		} catch (Exception e) {
			System.err.println("Insere Medicoes No MySQL - Server down, unable to make the connection. ");
		}
	}

	public void insereMedicoesNoMySql() {
		connect();
		if(medicao.getValorAnomalia()==0) {
			Sqlcommando = "CALL InserirMedicao('" + medicao.getValorMedicao() + "','" + medicao.getTipoMedicao() + "','" + dataHoraParaFormatoCerto() + "');";
		}else if(medicao.getValorAnomalia()==1){
			Sqlcommando = "CALL InserirMedicaoAnomala('"+medicao.getValorMedicaoAnomalo()+"','"+medicao.getTipoMedicao()+"','"+dataHoraParaFormatoCerto()+"');";
		}
		System.out.println(Sqlcommando);
		try {
			if(Sqlcommando!= null) {
				conn.createStatement().executeQuery(Sqlcommando);
			} else System.err.println("SQL command is null");
			conn.close();
		} catch (SQLException e) {
			System.err.println("could not connect do the SP InserirMedicao OR InserirMedicaoAnomala " + e);
		}
	}
	
	/**
	 * The data comes in as xx-xx-xx xx:xx:xx but without leading zeros. For example 1990-5-3 12:4:20 gets converted to 1990-05-03 12:04:20
	 * Due to the sensor's hour being an hour behind, it also add it to the correct date(GMT +1 +1 again).
	 * @return
	 */
	public String dataHoraParaFormatoCerto() {
		
		SimpleDateFormat timeFormatISO = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		try {
			 Date date = timeFormatISO.parse(medicao.getDataHoraMedicao());
			 Timestamp stamp =  new Timestamp(date.getTime());
			 SimpleDateFormat timeFormatISO2 = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
			 timeFormatISO2.setTimeZone(TimeZone.getTimeZone("GMT+1:00"));
			 return timeFormatISO2.format(stamp);
		} catch (ParseException e) {
			System.err.println("Could not parse the correct date. Original Date: " + medicao.getDataHoraMedicao());
		}
		
		return null;
	}
}