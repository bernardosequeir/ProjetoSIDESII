package conn;

import java.io.*;
import java.util.*;
import javax.swing.*;

import Anomalias.Medicao;
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
	static List<Medicao> valoresASerConferidos;
	static String mongo_host;
	static String mongo_database;
	static String mongo_collection;
	static String SqlCommando;
	static String database_password;
	static String database_user;
	static String database_connection;
	static Bson lastFilter = new Document("_id",-1);
	static HashMap<String, Double> valoresTabelaSistema;

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
			s = conn.createStatement();
		}			
		catch (Exception e){System.out.println("Server down, unable to make the connection. ");
		}
	}

	public static void main(String[] args) {	
		connectMysql();
		connectMongo();
		try{
			irBuscarDadosMysql();
			System.out.println("entrei aqui");
			Document doc = getUltimoValor();
			System.out.println(doc);
			while(true) {
				Document novo = getUltimoValor();
				if(!doc.equals(novo)) {
					doc = novo;
					valoresASerConferidos = getValoresMedicao(doc);
					insereMedicoes();
					//abre a liga�ao
					//corre o teste anomalia //insert cenas
					//fecha ligacao
					Thread.sleep(valoresTabelaSistema.get("IntervaloImportacaoMongo").intValue()*1000);
				}else {
					Thread.sleep(valoresTabelaSistema.get("IntervaloImportacaoMongo").intValue()*1000);
				}
			}
		}	
		catch (Exception e){System.out.println("Error quering  the database . " + e);}	

	}
	private static void irBuscarDadosMysql() throws SQLException {
		valoresTabelaSistema = new HashMap<String, Double>();
		SqlCommando = "SELECT * from sistema;";
		rs = s.executeQuery(SqlCommando);
		rs.next();
		valoresTabelaSistema.put("IntervaloImportacaoMongo",rs.getDouble("IntervaloImportacaoMongo"));
		valoresTabelaSistema.put("TempoLimiteMedicao",rs.getDouble("TempoLimiteMedicao"));
		valoresTabelaSistema.put("tamanhoDosBuffersAnomalia",rs.getDouble("tamanhoDosBuffersAnomalia"));
		valoresTabelaSistema.put("tamanhoDosBuffersAlerta",rs.getDouble("tamanhoDosBuffersAlerta"));
		valoresTabelaSistema.put("variacaoAnomalaTemperatura",rs.getDouble("variacaoAnomalaTemperatura"));
		valoresTabelaSistema.put("variacaoAnomalaHumidade",rs.getDouble("variacaoAnomalaHumidade"));
		valoresTabelaSistema.put("crescimentoInstantaneoTemperatura",rs.getDouble("crescimentoInstantaneoTemperatura"));
		valoresTabelaSistema.put("crescimentoGradualTemperatura",rs.getDouble("crescimentoGradualTemperatura"));
		valoresTabelaSistema.put("crescimentoInstantaneoHumidade",rs.getDouble("crescimentoInstantaneoHumidade"));
		valoresTabelaSistema.put("crescimentoGradualHumidade",rs.getDouble("crescimentoGradualHumidade"));
		valoresTabelaSistema.put("luminosidadeLuzesDesligadas",rs.getDouble("luminosidadeLuzesDesligadas"));
		valoresTabelaSistema.put("limiteTemperatura",rs.getDouble("limiteTemperatura"));
		valoresTabelaSistema.put("limiteHumidade",rs.getDouble("limiteHumidade"));
	}

	private static Document getUltimoValor(){
		List<Document> novosresultados = new ArrayList<Document>();
		mongocol.find().sort(lastFilter).limit(1).into(novosresultados);
		return novosresultados.get(0);
	}

	private static List<Medicao> getValoresMedicao(Document doc) {
		String[] date_split = doc.getString("dat").split("/");
		String date_fixed = date_split[2]+"-"+date_split[1]+"-"+date_split[0]+" "+doc.getString("tim");
		Medicao medicaoTemperatura = new Medicao(doc.getString("tmp"),"tmp",date_fixed);
		Medicao medicaoHumidade = new Medicao(doc.getString("hum"),"hum",date_fixed);
		Medicao medicaoLuminosidade = new Medicao(doc.getString("cell"),"lum",date_fixed);
		Medicao medicaoMovimento = new Medicao(doc.getString("sens\""),"mov",date_fixed);
		List<Medicao> medicoes = new ArrayList<Medicao>();
		medicoes.add(medicaoTemperatura);
		medicoes.add(medicaoHumidade);
		medicoes.add(medicaoLuminosidade);
		medicoes.add(medicaoMovimento);
		return medicoes;
	}

	private static void insereMedicoes(){
		//TODO falta fazer isto
		SqlCommando = "call InserirMedicao";
	}
}


