package conn;

import java.io.*;
import java.util.*;
import javax.swing.*;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

import java.sql.*;

public class JavaMysql {
	static Connection conn;
	static Statement s;
	static ResultSet rs;
	static MongoClient mongoClient;
	static MongoDatabase db;
	static MongoCollection<Document> mongocol;
	static String mongo_host = new String();
	static String mongo_database = new String();
	static String mongo_collection = new String();
	static String SqlCommando = new String();
	static String database_password= new String();
	static String database_user= new String();
	static String database_connection= new String();
	

	public static void connectMongo() {
		Properties p = new Properties();
		try {
			p.load(new FileInputStream("cloudToMongo.ini"));
			mongo_host = p.getProperty("mongo_host");
			mongo_database = p.getProperty("mongo_database");
			mongo_collection = p.getProperty("mongo_collection");
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		mongoClient = new MongoClient(new MongoClientURI(mongo_host));
		db = mongoClient.getDatabase(mongo_database);
		mongocol = db.getCollection(mongo_collection);
	}

	public static void connectMysql() {
		
		database_password = "";
		database_user = "root";
		database_connection = "jdbc:mysql://localhost/g12_museum";
		try{ 	
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn =  DriverManager.getConnection(database_connection+"?user="+database_user+"&password="+database_password);
			System.out.println("passou");
		}			
		catch (Exception e){System.out.println("Server down, unable to make the connection. ");
		}
	}

	public static void main(String[] args) {	
		connectMysql();
		connectMongo();
		try{ 
			System.out.println("entrei aqui");
			SqlCommando = "Select DataHoraMedicao from medicaosensores order by idMedicao limit 1";
			s = conn.createStatement();
			rs = s.executeQuery(SqlCommando);
			rs.next();
			System.out.println(rs.getString(1));
			String[] DateandHour = rs.getString(1).split(" ");
			for (String s: DateandHour) {
				System.out.println(s);				
			}
			List<Document> novosresultados = new ArrayList<Document>();
			Bson lastFilter = new Document("_id",-1); 
			mongocol.find().sort(lastFilter).limit(1).into(novosresultados);
			int i = 0;
			Document doc = novosresultados.get(0);
			System.out.println(doc);
			while(i <1000) {
				List<Document> novos = new ArrayList<Document>();
				mongocol.find().sort(lastFilter).limit(1).into(novos);
				Document novo = novos.get(0);
				if(!doc.equals(novo)) {
					System.out.println("tenho novo");
					System.out.println(novo);
					doc = novo;
					List<String> valoresASerConferidos = getValoresMedicao(doc);
					SqlCommando = "INSERT INTO medicaosensores (idMedicao, ValorMedicao, TipoSensor, DataHoraMedicao, PossivelAnomalia) VALUES (default, '"+valoresASerConferidos.get(0)+"', 'tmp', '"+valoresASerConferidos.get(2)+"', '1');";
					s.executeUpdate(SqlCommando);
					Thread.sleep(1000);
				}else {
					System.out.println("ja tenho");
					Thread.sleep(1000);
				}
				i++;
			}
			s.close();
		}	
		catch (Exception e){System.out.println("Error quering  the database . " + e);}	

	}

	private static List<String> getValoresMedicao(Document doc) {
		List<String> valores = new ArrayList<String>();
		valores.add(doc.getString("tmp"));
		valores.add(doc.getString("hum"));
		String[] date_split = doc.getString("dat").split("/");
		String date_fixed = date_split[2]+"-"+date_split[1]+"-"+date_split[0];
		valores.add(date_fixed+" "+doc.getString("tim"));
		valores.add(doc.getString("cell"));
		valores.add(doc.getString("mov\""));
		valores.add(doc.getString("sens\""));
		for(String s: valores) {
			System.out.println(s);
		}
		return valores;
	}

}


