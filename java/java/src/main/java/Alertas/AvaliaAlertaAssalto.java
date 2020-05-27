package Alertas;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import Anomalias.InsereMedicoesNoMySql;
import Anomalias.Medicao;
import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

/**
 * 
 * @author joaof, grupo12 Opens a new sql connection
 *
 */
public class AvaliaAlertaAssalto {

	/*
	 * O que é que ele precisa: - Duas medição - luminosidade e movimento - Se há
	 * ronda atual ou ronda extra
	 *
	 *
	 * Luminosidade variou? Se !ronda && movimento = assalto
	 * 
	 *
	 */
	private Medicao movimento;
	private Medicao luminosidade;
	private String database_password;
	private String database_user;
	private String database_connection;
	private Connection conn;
	private Statement s;
	private ResultSet rs;
	private String timestampUsedInRonda;
	private Double luminosidadeLuzEscuro;
	private String movimentoOuLuminosidade;
	private String valorAlarmeAInserir;
	private String tipoAlerta;
	private Time fimRondaEmCurso = Time.valueOf("00:00:00");

	public AvaliaAlertaAssalto(Medicao movimento, Medicao luminosidade, Double luminosidadeLuzEscuro) {

		this.movimento = movimento;
		this.luminosidade = luminosidade;
		this.luminosidadeLuzEscuro = luminosidadeLuzEscuro;
		timestampUsedInRonda = new InsereMedicoesNoMySql(movimento).dataHoraParaFormatoCerto();

		connectMysqlAssalto();

		if (existeAlerta())
			insereTabelaAlerta();

	}

	/**
	 * Connects to the MySQL database
	 */
	public void connectMysqlAssalto() {

		database_password = "teste123";
		database_user = "root";
		database_connection = "jdbc:mysql://localhost/g12_museum";
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager
					.getConnection(database_connection + "?user=" + database_user + "&password=" + database_password);
			s = conn.createStatement();
		} catch (Exception e) {
			System.out.println("Avalia Alerta Assalto - Server down, unable to make the connection. ");
		}
	}

	public boolean existeAlerta() {
		return valorEAlerta() && !existeRonda();
	}

	public boolean valorEAlerta() {
		// nao sao anomalos
		new InsereMedicoesNoMySql(movimento);
		new InsereMedicoesNoMySql(luminosidade);
		if (movimento.isAnomalo() && luminosidade.isAnomalo()) {
			return false;
		} else 
		// insere sabendo se sao anomalos ou nao
		
		if (movimento.isAnomalo()) {
			if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro) {
				System.out.println("luminosidade.getValorMedicao() > luminosidadeLuzEscuro");
				tipoAlerta = "lum";
				return true;
			}
		} else if (luminosidade.isAnomalo()) {
			if (movimento.getValorMedicao() == 1.00) {
				tipoAlerta = "mov";
				return true;
			}
		} else if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro && movimento.getValorMedicao() == 1.00) {
			tipoAlerta = "both";
			return true;
		} else 
		if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro) {
			tipoAlerta = "lum";
			return true;
		} else if (movimento.getValorMedicao() == 1.00) {
			tipoAlerta = "mov";
			return true;
		}
		return false;

	}

	public void insereTabelaAlerta() {

		try {
			if (tipoAlerta.equals("mov")) {
				Alerta.enviaAlerta("Possivel Assalto", movimento);
			} else if (tipoAlerta.equals("lum")) {
				Alerta.enviaAlerta("Possivel Assalto", luminosidade);
			} else if (tipoAlerta.equals("both")) {
				Alerta.enviaAlerta("Possivel Assalto", movimento);
				Alerta.enviaAlerta("Possivel Assalto", luminosidade);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean existeRonda()  {
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
			Date parsedDate;
			parsedDate = dateFormat.parse(new InsereMedicoesNoMySql(movimento).dataHoraParaFormatoCerto());
			Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
			if (fimRondaEmCurso.after(timestamp))
				return true;
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// isto vai ter um problema que eu não consigo pensar nele, mas se rondas
		// tiverem mais de 24h rip(nao importante)
		// e se o cliente quiser aceitar tudo no medicoes_sensores e se o sensor estiver
		// avariado rip tambem, ou seja se sensor estiver a mandar data errada e valor
		// certo e só assim por acaso é um incendio rip
		// Rondas planeadas com mais de 24h vai ser um grande rip, espero que nunca
		// aconteca
		Statement st;
		try {
			System.out.println("comeca a verificar ronda");
			st = conn.createStatement();
			String Sqlcommando = "CALL VerificaSeExisteRonda('" + timestampUsedInRonda + "')";
		    DateFormat sdf = new SimpleDateFormat("hh:mm:ss");
		    Date date = sdf.parse("00:00:00");
			ResultSet rs = st.executeQuery(Sqlcommando);
			rs.next();
			Time result = rs.getTime("existeronda");
			if (result.equals(date)) {
				System.out.println("não está em ronda");
				return false;
			} else {
				System.out.println("esta em ronda");
				fimRondaEmCurso = result;
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;

	}

}