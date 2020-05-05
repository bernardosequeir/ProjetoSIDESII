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

public class MongoParaMysql {
	static Connection conn;
	static Statement s;
	static ResultSet rs;
	static MongoClient mongoClient;
	static MongoDatabase db;
	static MongoCollection<Document> mongocol;
	static List<String> valoresASerConferidos; 
	static String mongo_host;
	static String mongo_database;
	static String mongo_collection;
	static String SqlCommando;
	static String database_password;
	static String database_user;
	static String database_connection;
	//static String InsereMedicaoTempCAnom ="INSERT INTO medicaosensores (idMedicao, ValorMedicao, TipoSensor, DataHoraMedicao, PossivelAnomalia) VALUES (default, '"+valoresASerConferidos.get(0)+"', 'tmp', '"+valoresASerConferidos.get(2)+"', '1');";
	//static String InsereMedicaoTempSAnom ="INSERT INTO medicaosensores (idMedicao, ValorMedicao, TipoSensor, DataHoraMedicao, PossivelAnomalia) VALUES (default, '"+valoresASerConferidos.get(0)+"', 'tmp', '"+valoresASerConferidos.get(2)+"', '0');";
	//static String InsereMedicaoHumCAnom ="INSERT INTO medicaosensores (idMedicao, ValorMedicao, TipoSensor, DataHoraMedicao, PossivelAnomalia) VALUES (default, '"+valoresASerConferidos.get(1)+"', 'hum', '"+valoresASerConferidos.get(2)+"', '1');";
	//static String InsereMedicaoHumSAnom ="INSERT INTO medicaosensores (idMedicao, ValorMedicao, TipoSensor, DataHoraMedicao, PossivelAnomalia) VALUES (default, '"+valoresASerConferidos.get(1)+"', 'hum', '"+valoresASerConferidos.get(2)+"', '0');";
	//static String InsereMedicaoLuzCAnom ="INSERT INTO medicaosensores (idMedicao, ValorMedicao, TipoSensor, DataHoraMedicao, PossivelAnomalia) VALUES (default, '"+valoresASerConferidos.get(4)+"', 'luz', '"+valoresASerConferidos.get(2)+"', '1');";
	//static String InsereMedicaoLuzSAnom ="INSERT INTO medicaosensores (idMedicao, ValorMedicao, TipoSensor, DataHoraMedicao, PossivelAnomalia) VALUES (default, '"+valoresASerConferidos.get(4)+"', 'luz', '"+valoresASerConferidos.get(2)+"', '0');";
	static Bson lastFilter = new Document("_id",-1); 

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
			s = conn.createStatement();
		}			
		catch (Exception e){System.out.println("Server down, unable to make the connection. ");
		}
	}

	public static void main(String[] args) {	
		connectMysql();
		connectMongo();
		irBuscarDadosMysql();
		try{ 
			System.out.println("entrei aqui");
			Document doc = getUltimoValor();
			System.out.println(doc);
			while(true) {
				Document novo = getUltimoValor();
				System.out.println(novo);
				if(!doc.equals(novo)) {
					doc = novo;
					valoresASerConferidos = getValoresMedicao(doc);
					SqlCommando = "INSERT INTO medicaosensores (idMedicao, ValorMedicao, TipoSensor, DataHoraMedicao, PossivelAnomalia) VALUES (default, '"+valoresASerConferidos.get(0)+"', 'tmp', '"+valoresASerConferidos.get(2)+"', '1');";
					s.executeUpdate(SqlCommando);
					Thread.sleep(1000);
				}else {
					Thread.sleep(1000);
				}
			}
			
		}	
		catch (Exception e){System.out.println("Error quering  the database . " + e);}	

	}
	private static void irBuscarDadosMysql() {
		
	}

	private static Document getUltimoValor(){
		List<Document> novosresultados = new ArrayList<Document>();
		mongocol.find().sort(lastFilter).limit(1).into(novosresultados);
		return novosresultados.get(0);
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


