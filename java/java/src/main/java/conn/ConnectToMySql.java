package conn;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
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
			Statement s = conn.createStatement();
			return conn;
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, "Could not connect to MySQL", "Connecting to MySQL ",
					JOptionPane.ERROR_MESSAGE);
		}
		return null;
	}
	
	
}
