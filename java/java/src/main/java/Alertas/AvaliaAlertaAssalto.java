package Alertas;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;

import Anomalias.Medicao;
import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

/**
 * 
 * @author joaof, grupo12 
 * Opens a new sql connection
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

	public AvaliaAlertaAssalto(Medicao movimento, Medicao luminosidade, Double luminosidadeLuzEscuro) {
		this.movimento = movimento;
		this.luminosidade = luminosidade;
		this.luminosidadeLuzEscuro = luminosidadeLuzEscuro;
		timestampUsedInRonda = movimento.getDataHoraMedicao();
		
		connectMysqlAssalto();
		if(existeAlerta()) enviaAlerta();
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
		return (naoEAnomalo() && valorEAlerta() && verificaRonda());
	}

	private boolean naoEAnomalo() {
		return (!movimento.isAnomalo() || !luminosidade.isAnomalo()) ;
	}

	public boolean valorEAlerta() {
		return (movimento.getValorMedicao() == 1 ||  luminosidade.getValorMedicao() > luminosidadeLuzEscuro);
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
		Medicao medicaoMov = new Medicao("0", "mov", "'2020.05.13 12:12:12'");
		Medicao medicaoLuz = new Medicao("0.0", "lum", null);
		new AvaliaAlertaAssalto(medicaoMov, medicaoLuz, 0.0);

	}

}
