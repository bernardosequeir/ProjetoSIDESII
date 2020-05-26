package Alertas;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
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
	 * O que � que ele precisa: - Duas medi��o - luminosidade e movimento - Se h�
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

	

	public AvaliaAlertaAssalto(Medicao movimento, Medicao luminosidade, Double luminosidadeLuzEscuro) {
		
		this.movimento = movimento;
		this.luminosidade = luminosidade;
		this.luminosidadeLuzEscuro = luminosidadeLuzEscuro;
		timestampUsedInRonda = new InsereMedicoesNoMySql(movimento).dataHoraParaFormatoCerto();

		connectMysqlAssalto();
		if (existeAlerta())
			enviaAlerta();
	}

	private void enviaAlerta() {
		// TODO Auto-generated method stub
		System.out.println("ENVIAR ALERTA");

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
		return valorEAlerta() && !verificaRonda();
	}

	public boolean valorEAlerta() {
		if (movimento.isAnomalo() && luminosidade.isAnomalo()) {
			new InsereMedicoesNoMySql(movimento);
			new InsereMedicoesNoMySql(luminosidade);
			return false;
		}
		else if (movimento.isAnomalo()) {
			new InsereMedicoesNoMySql(movimento);
			if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro) {
				tipoAlerta = "lum";
				return true;
			}
		} else if (luminosidade.isAnomalo()) {
			new InsereMedicoesNoMySql(luminosidade);
			if (movimento.getValorMedicao() == 1.00) {
				tipoAlerta = "mov";
				return true;
			}
		} else if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro && movimento.getValorMedicao() == 1.00) {
			tipoAlerta = "both";
			return true;
		}
		if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro) {
			tipoAlerta = "lum";
			return true;
		} else if (movimento.getValorMedicao() == 1.00) {
			tipoAlerta = "mov";
			return true;
		}
		return false;

	}

	public boolean insereTabelaAlerta() {

		Statement st;
		try {
			st = conn.createStatement();
			String Sqlcommando = null;
			if(tipoAlerta.equals("mov")) {
				Alerta.enviaAlerta("Possivel Assalto",movimento);
			}
			else if(tipoAlerta.equals("lum")) {
				Alerta.enviaAlerta("Possivel Assalto",luminosidade);
			} else if(tipoAlerta.equals("both")){
				Alerta.enviaAlerta("Possivel Assalto",movimento);
				Alerta.enviaAlerta("Possivel Assalto",luminosidade);
			}
			
			rs.next();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean verificaRonda() {

		Statement st;
		try {
			st = conn.createStatement();
			String Sqlcommando = "CALL VerificaSeExisteRonda('" + timestampUsedInRonda + "')";
			ResultSet rs = st.executeQuery(Sqlcommando);
			rs.next();
			int result = rs.getInt("existeronda");
			if (result == 0) {
				return false;
			} else {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;

	}

	

}
