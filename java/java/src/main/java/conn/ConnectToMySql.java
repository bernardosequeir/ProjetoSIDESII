package conn;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.swing.JOptionPane;

public class ConnectToMySql {

	
	public static Connection connect() {

		Properties p = new Properties();
        try {
            p.load(new FileInputStream("cloudToMongo.ini"));
            String database_password = p.getProperty("database_password");
           String  database_user = p.getProperty("database_user");
           String database_connection = p.getProperty("database_connection");
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection conn = DriverManager
					.getConnection(database_connection + "?user=" + database_user + "&password=" + database_password);
			return conn;
		} catch (SQLException e) {
			System.err.println("Could not connect to MySQL " + e);
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return null;
	}
	
	
}
