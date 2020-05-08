package Alarms;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Alarm {

	public void initializeValues() {
		Connection conn = doConnections();
		
		String SqlCommando ="SELECT * FROM sistema WHERE IDSistema = 1;";
		
		try {
			Statement s = conn.createStatement();
			ResultSet rs = s.executeQuery(SqlCommando);
			
			while (rs.next()) {
	            inicializaAlarmeIncendio(rs.getDouble(2), rs.getDouble(5));
	            inicializaAlarmeHumidade();
	            inicializaAlarmeAssalto();
	        }
			
			conn.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	
	
	private void inicializaAlarmeAssalto() {
		//FireAlarm.setValoresIniciais
		
	}

	private void inicializaAlarmeHumidade() {
	
		
	}

	private void inicializaAlarmeIncendio(double double1, double double2) {

		
	}
	
	
	public boolean verificaAnomalia(Double v, Double c, Double lv) {
		
		return true;
	}

	public void setAlarm(String type) {
		//Cenas de alarme para android
	}
	
	public Connection doConnections() {
		Connection conn = null;
	    
	    String database_password = "sistema_pass";
	    String database_user = "sistema";
	    String database_connection = "jdbc:mysql://localhost/g12_museum";
	    
	    try {
	    	
	        Class.forName("com.mysql.jdbc.Driver").newInstance();
	        conn =  DriverManager.getConnection(database_connection+"?user="+database_user+"&password="+database_password);
	        System.out.println("MySQL Initializing values....");
	        
	    } catch (Exception e) {
	    	System.out.println("Server down, unable to make the connection. ");
	    }
	    
	    return conn;
	}
	
	public static void main(String[] args) {
		new Alarm().initializeValues();
	}
	
	
}
