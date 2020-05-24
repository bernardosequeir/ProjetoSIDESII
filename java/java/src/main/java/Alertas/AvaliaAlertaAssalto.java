package Alertas;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;

import Anomalias.InsereAnomaliasNoMySql;
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

	public AvaliaAlertaAssalto(Medicao movimento, Medicao luminosidade, Double luminosidadeLuzEscuro) {
		this.movimento = movimento;
		this.luminosidade = luminosidade;
		this.luminosidadeLuzEscuro = luminosidadeLuzEscuro;
		timestampUsedInRonda = movimento.getDataHoraMedicao();

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
			System.out.println("Server down, unable to make the connection. ");
		}
	}

	public boolean existeAlerta() {
		return valorEAlerta() && !verificaRonda();
	}

	public boolean valorEAlerta() {
		if (movimento.isAnomalo() && luminosidade.isAnomalo()) {
			new InsereAnomaliasNoMySql(movimento,conn);
			new InsereAnomaliasNoMySql(luminosidade,conn);
			return false;
		}
		else if (movimento.isAnomalo()) {
			new InsereAnomaliasNoMySql(movimento,conn);
			if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro) {
				tipoAlerta = "lum";
				return true;
			}
		} else if (luminosidade.isAnomalo()) {
			new InsereAnomaliasNoMySql(luminosidade,conn);
			if (movimento.getValorMedicao() == 1) {
				tipoAlerta = "mov";
				return true;
			}
		} else if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro && movimento.getValorMedicao() == 1) {
			tipoAlerta = "both";
			return true;
		}
		if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro) {
			tipoAlerta = "lum";
			return true;
		} else if (movimento.getValorMedicao() == 1) {
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
				Sqlcommando = "CALL InserirAlerta(" + timestampUsedInRonda + ", mov ,"+ valorAlarmeAInserir + ", null, null,null)";
				rs = st.executeQuery(Sqlcommando);
			}
			else if(tipoAlerta.equals("lum")) {
				Sqlcommando = "CALL InserirAlerta(" + timestampUsedInRonda + ", lum ,"+ valorAlarmeAInserir + ", null, null,null)";
				rs = st.executeQuery(Sqlcommando);
			} else if(tipoAlerta.equals("both")){
				Sqlcommando = "CALL InserirAlerta(" + timestampUsedInRonda + ", mov ,"+ valorAlarmeAInserir + ", null, null,null)";
				rs = st.executeQuery(Sqlcommando);
				Sqlcommando = "CALL InserirAlerta(" + timestampUsedInRonda + ", lum ,"+ valorAlarmeAInserir + ", null, null,null)";
				rs = st.executeQuery(Sqlcommando);
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
			String Sqlcommando = "CALL VerificaSeExisteRonda(" + timestampUsedInRonda + ")";

			ResultSet rs = st.executeQuery(Sqlcommando);
			rs.next();
			int result = rs.getInt("existeronda");
			if (result == 0) {
				System.out.println("Nao existe ronda");
				return false;
			} else {
				System.out.println("RONDA");
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;

	}

	public static void main(String[] args) {
		Medicao medicaoLuz = new Medicao("1", "mov", "'2020.05.13 12:12:12'");
		Medicao medicaoMov = new Medicao("1", "lum", "'2020.05.13 12:12:12'");
		new AvaliaAlertaAssalto(medicaoMov, medicaoLuz, 0.0);

	}

}
