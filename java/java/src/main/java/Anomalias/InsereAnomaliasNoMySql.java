package Anomalias;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class InsereAnomaliasNoMySql {

	
	private Medicao medicao;
	private Connection conn;
	private String database_password;
	private String database_user;
	private String database_connection;
	private Statement s;
	private ResultSet rs;
	public InsereAnomaliasNoMySql(Medicao medicao) {
		this.medicao = medicao;
		connect();
		insereMedicoesNoMySql();
	}
	
	/**
	 * Connects to the MySQL database
	 */
	public void connect() {

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

	public void insereMedicoesNoMySql() {
		String Sqlcommando = "INSERT INTO `medicao_sensores_anomalos` (`NULL`, `ValorMedicao`, `TipoSensor`, `DataHoraMedicao`) VALUES ('NULL', '"+ medicao.getValorMedicao()+ "', '"+medicao.getTipoMedicao() + "', '"+medicao.getDataHoraMedicao()+"');";
		try {
			conn.createStatement().executeQuery(Sqlcommando);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
