package conn;

import java.io.*;
import java.util.*;
import javax.swing.*;

import Alertas.AvaliaAlertaAssalto;
import Anomalias.AvaliaAnomalias;
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
	private Connection conn;
	private Statement s;
	private ResultSet rs;
	private MongoClient mongoClient;
	private MongoDatabase db;
	private MongoCollection<Document> mongocol;
	private String mongo_host;
	private String mongo_database;
	private String mongo_collection;
	private String SqlCommando;
	private String database_password;
	private String database_user;
	private String database_connection;
	private static HashMap<String, Double> valoresTabelaSistema;
	private HashMap<String, Medicao> valoresASerConferidos;
	private AvaliaAnomalias avaliaAnomaliasTemperatura;
	private AvaliaAnomalias avaliaAnomaliasHumidade;
	private Document ultimaMedicao;
	private final Bson lastFilter = new Document("_id", -1);

	public void connectMongo() {
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

	public static HashMap<String, Double> getValoresTabelaSistema() {
		return valoresTabelaSistema;
	}

	public static void main(String[] args) {
		MongoParaMysql mongoParaMysql = new MongoParaMysql();
		mongoParaMysql.run();
	}

	private void run() {
		// connectMysql();

		connectMongo();
		irBuscarDadosMysql();
		criaBuffersAnomalia();
		ultimaMedicao = getUltimoValor(); // Primeira medição do mongo

		while (true) {
			verificaValoresNovos();
		}

	}

	private void verificaValoresNovos() {
		Document novo = getUltimoValor();
		if (!ultimaMedicao.equals(novo)) {
			ultimaMedicao = novo;
			valoresASerConferidos = getValoresMedicao(ultimaMedicao);
			// tabela hash ja esta certa
			verificarAssalto();
			avaliaAnomaliasTemperatura.adicionarValores(valoresASerConferidos.get("tmp"));
			avaliaAnomaliasHumidade.adicionarValores(valoresASerConferidos.get("hum"));
			try {
				Thread.sleep(valoresTabelaSistema.get("IntervaloImportacaoMongo").intValue() * 1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			try {
				Thread.sleep(valoresTabelaSistema.get("IntervaloImportacaoMongo").intValue() * 1000);
			} catch (InterruptedException e) {
				System.err.println("Thread sleep was interrupted - outside of our control: " + e);
			}
		}
	}

	private void verificarAssalto() {
		Medicao movimento = valoresASerConferidos.get("mov");
		Medicao luminosidade = valoresASerConferidos.get("lum");
		new AvaliaAlertaAssalto(movimento, luminosidade, valoresTabelaSistema.get("luminosidadeLuzesDesligadas"));
	}

	private void criaBuffersAnomalia() {
		avaliaAnomaliasTemperatura = new AvaliaAnomalias(
				valoresTabelaSistema.get("tamanhoDosBuffersAnomalia").intValue(),
				valoresTabelaSistema.get("variacaoAnomalaTemperatura"));
		avaliaAnomaliasHumidade = new AvaliaAnomalias(valoresTabelaSistema.get("tamanhoDosBuffersAnomalia").intValue(),
				valoresTabelaSistema.get("variacaoAnomalaHumidade"));
	}

	// TODO null e default? testar com valores vazios e com valorees ja na tabela
	private void irBuscarDadosMysql() {
		conn = ConnectToMySql.connect();
		try {
			s = conn.createStatement();
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		valoresTabelaSistema = new HashMap<String, Double>();
		SqlCommando = "SELECT * from sistema;";
		// TODO tratar tabela sistema vazia de uma forma melhor?
		// TODO verificar se tabela sistema nao tem valores estupidos, possivelmente no
		// mysql
		try {
			rs = s.executeQuery(SqlCommando);
			rs.next();
			valoresTabelaSistema.put("IntervaloImportacaoMongo", rs.getDouble("IntervaloImportacaoMongo"));
			valoresTabelaSistema.put("TempoLimiteMedicao", rs.getDouble("TempoLimiteMedicao"));
			valoresTabelaSistema.put("tamanhoDosBuffersAnomalia", rs.getDouble("tamanhoDosBuffersAnomalia"));
			valoresTabelaSistema.put("tamanhoDosBuffersAlerta", rs.getDouble("tamanhoDosBuffersAlerta"));
			valoresTabelaSistema.put("variacaoAnomalaTemperatura", rs.getDouble("variacaoAnomalaTemperatura"));
			valoresTabelaSistema.put("variacaoAnomalaHumidade", rs.getDouble("variacaoAnomalaHumidade"));
			valoresTabelaSistema.put("crescimentoInstantaneoTemperatura",
					rs.getDouble("crescimentoInstantaneoTemperatura"));
			valoresTabelaSistema.put("crescimentoGradualTemperatura", rs.getDouble("crescimentoGradualTemperatura"));
			valoresTabelaSistema.put("crescimentoInstantaneoHumidade", rs.getDouble("crescimentoInstantaneoHumidade"));
			valoresTabelaSistema.put("crescimentoGradualHumidade", rs.getDouble("crescimentoGradualHumidade"));
			valoresTabelaSistema.put("luminosidadeLuzesDesligadas", rs.getDouble("luminosidadeLuzesDesligadas"));
			valoresTabelaSistema.put("limiteTemperatura", rs.getDouble("limiteTemperatura"));
			valoresTabelaSistema.put("limiteHumidade", rs.getDouble("limiteHumidade"));

		} catch (SQLException e) {
			try {
				rs = s.executeQuery("CALL InsereTabelaSistemaValoresDefault();");
				irBuscarDadosMysql();
			} catch (SQLException e1) {
				System.err.println("Could not call the SP InsereTabelaSistemaValoresDefault - maybe it is deleted or it is modified" + e1);
			}
		}
		try {
			conn.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

	}

	private Document getUltimoValor() {
		List<Document> novosresultados = new ArrayList<Document>();
		mongocol.find().sort(lastFilter).limit(1).into(novosresultados);

		return novosresultados.get(0);
	}

	private HashMap<String, Medicao> getValoresMedicao(Document doc) {
		String[] date_split = doc.getString("dat").split("/");
		String date_fixed = date_split[2] + "-" + date_split[1] + "-" + date_split[0] + " " + doc.getString("tim");
		try {
			// TODO decidir o que acontece aqui
			if (doc.getString("tmp") == null || doc.getString("hum") == null || doc.getString("cell") == null
					|| doc.getString("mov") == null)
				System.err.println("This system is not ready to deal with sensors that doesn't contain one or more of the following fields: lum, hum, cell, mov");

			Medicao medicaoTemperatura = new Medicao(doc.getString("tmp"), "tmp", date_fixed);
			Medicao medicaoHumidade = new Medicao(doc.getString("hum"), "hum", date_fixed);
			Medicao medicaoLuminosidade = new Medicao(doc.getString("cell"), "lum", date_fixed);
			Medicao medicaoMovimento = new Medicao(doc.getString("mov"), "mov", date_fixed);
			HashMap<String, Medicao> medicoes = new HashMap<String, Medicao>();
			medicoes.put("tmp", medicaoTemperatura);
			medicoes.put("hum", medicaoHumidade);
			medicoes.put("lum", medicaoLuminosidade);
			medicoes.put("mov", medicaoMovimento);
			System.out.println(doc.toString());
			return medicoes;
		} catch (Exception e) {
			System.err.println("String parsing fail (\"tmp\" did not get converted correctly as \"tmp\")" + e);
			
		}
		return null;

	}

}