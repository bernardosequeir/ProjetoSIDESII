package Alertas;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import Anomalias.Medicao;
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
	private Medicao movimento;
	private Medicao luminosidade;


	public AvaliaAlertaAssalto(Medicao movimento, Medicao luminosidade, Double ValorLuminosidade) {
		this.movimento = movimento;
		this.luminosidade = luminosidade;
	}

	public boolean verificaRonda() {
		// 1º Verificar o mov ou luz
		// 2º Ver ronda
		// 3º Profit
		if(!movimento.isAnomalo() || !luminosidade.isAnomalo()){

		}
		Connection conn = connectMysql();
		String rondaPlaneadaQ = "SELECT COUNT(*) FROM g12_museum.ronda_planeada WHERE g12_museum.ronda_planeada.dataHoraEntrada < "
				+ timestamp + " AND g12_museum.ronda_planeada.dataHoraSaida > " + timestamp;
		String rondaExtraQ = "SELECT COUNT(*) FROM g12_museum.ronda_extra WHERE g12_museum.ronda_extra.dataHoraEntrada < "
				+ timestamp + " AND g12_museum.ronda_extra.dataHoraSaida > " + timestamp;

		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("Call SP ");
		rs.next();

		while(rs.next()) {
			if(rs.getInt(1) >= 1) {
				return true;
			}
		}
		
		
	}

	// DB CONNECTIONS
	public void connectMysql() {
		/*
		 * try { Class.forName("com.mysql.jdbc.Driver").newInstance(); conn =
		 * DriverManager .getConnection(database_connection + "?user=" + database_user +
		 * "&password=" + database_password); System.out.println("passou"); s =
		 * conn.createStatement(); } catch (Exception e) {
		 * System.out.println("Server down, unable to make the connection. "); }
		 */
	}

	public static void main(String[] args) {

	}

}
