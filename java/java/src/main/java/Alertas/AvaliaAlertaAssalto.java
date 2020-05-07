package Alertas;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

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

	// Data for the DB URL
	private static final String MAQUINA = "192.168.1.254";
	private static final String PORTA = "";
	private static final String BD_UNIX = "";
	private static final String SERVIDOR = "";
	// JDBC Driver name and database URL
	private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://" + MAQUINA + ":" + PORTA + "/" + BD_UNIX + ":informixserver="
			+ SERVIDOR;
	// Database Credentials
	private static final String USER = "";
	private static final String PASS = "";

	static double luminosidadeLuzesDesligadas = 20.0;
	static double luminosidadeLuzesLigadas = 90.0;

	public AvaliaAlertaAssalto(double d) {

	}

	// Vai ver se há uma ronda entre o valor do timestamp recebido
	public boolean verificaRonda(String timestamp) {
		boolean haRonda = false;
		Connection conn = connectMysql();
		String rondaPlaneadaQ = "SELECT COUNT(*) FROM g12_museum.ronda_planeada WHERE g12_museum.ronda_planeada.dataHoraEntrada < "
				+ timestamp + " AND g12_museum.ronda_planeada.dataHoraSaida > " + timestamp;
		String rondaExtraQ = "SELECT COUNT(*) FROM g12_museum.ronda_extra WHERE g12_museum.ronda_extra.dataHoraEntrada < "
				+ timestamp + " AND g12_museum.ronda_extra.dataHoraSaida > " + timestamp;

		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(rondaPlaneadaQ);

		while(rs.next()) {
			if(rs.getInt(1) >= 1) {
				haRonda = true;
			}
		}
		
		
	}

	// DB CONNECTIONS
	public Connection connectMysql() {
		/*
		 * try { Class.forName("com.mysql.jdbc.Driver").newInstance(); conn =
		 * DriverManager .getConnection(database_connection + "?user=" + database_user +
		 * "&password=" + database_password); System.out.println("passou"); s =
		 * conn.createStatement(); } catch (Exception e) {
		 * System.out.println("Server down, unable to make the connection. "); }
		 */
	}

}
