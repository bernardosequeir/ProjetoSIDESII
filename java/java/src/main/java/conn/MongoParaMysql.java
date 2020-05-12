package conn;

import java.io.*;
import java.util.*;
import javax.swing.*;

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
    private HashMap<String, Double> valoresTabelaSistema;
    private HashMap<String,Medicao> valoresASerConferidos;
    private AvaliaAnomalias avaliaAnomaliasTemperatura;
    private AvaliaAnomalias avaliaAnomaliasHumidade;
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

    public void connectMysql() {

        database_password = "";
        database_user = "root";
        database_connection = "jdbc:mysql://localhost/g12_museum";
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection(database_connection + "?user=" + database_user + "&password=" + database_password);
            s = conn.createStatement();
        } catch (Exception e) {
            System.out.println("Server down, unable to make the connection. ");
        }
    }

    public static void main(String[] args) {
        MongoParaMysql mongoParaMysql = new MongoParaMysql();
        mongoParaMysql.run();
    }

    private void run() {
        connectMysql();
        connectMongo();
        try {
            irBuscarDadosMysql();
            setUpBuffers();
            Document doc = getUltimoValor();
            System.out.println(doc);
            while (true) {
                Document novo = getUltimoValor();
                if (!doc.equals(novo)) {
                    doc = novo;
                    valoresASerConferidos = getValoresMedicao(doc);
                    insereMedicoes();
                    avaliaAnomaliasTemperatura.addicionarValores(valoresASerConferidos.get("tmp"));
                    avaliaAnomaliasHumidade.addicionarValores(valoresASerConferidos.get("hum"));
                    //abre a liga�ao
                    //corre o teste anomalia //insert cenas
                    //fecha ligacao
                    Thread.sleep(valoresTabelaSistema.get("IntervaloImportacaoMongo").intValue() * 1000);
                } else {
                    Thread.sleep(valoresTabelaSistema.get("IntervaloImportacaoMongo").intValue() * 1000);
                }
            }
        } catch (Exception e) {
            System.out.println("Error quering  the database . " + e);
        }

    }

    private void setUpBuffers() {
        avaliaAnomaliasTemperatura = new AvaliaAnomalias(valoresTabelaSistema.get("tamanhoDosBuffersAnomalia").intValue(),valoresTabelaSistema.get("variacaoAnomalaTemperatura"));
        avaliaAnomaliasHumidade = new AvaliaAnomalias(valoresTabelaSistema.get("tamanhoDosBuffersAnomalia").intValue(),valoresTabelaSistema.get("variacaoAnomalaHumidade"));
    }

    private void irBuscarDadosMysql() throws SQLException {
        valoresTabelaSistema = new HashMap<String, Double>();
        SqlCommando = "SELECT * from sistema;";
        rs = s.executeQuery(SqlCommando);
        rs.next();
        valoresTabelaSistema.put("IntervaloImportacaoMongo", rs.getDouble("IntervaloImportacaoMongo"));
        valoresTabelaSistema.put("TempoLimiteMedicao", rs.getDouble("TempoLimiteMedicao"));
        valoresTabelaSistema.put("tamanhoDosBuffersAnomalia", rs.getDouble("tamanhoDosBuffersAnomalia"));
        valoresTabelaSistema.put("tamanhoDosBuffersAlerta", rs.getDouble("tamanhoDosBuffersAlerta"));
        valoresTabelaSistema.put("variacaoAnomalaTemperatura", rs.getDouble("variacaoAnomalaTemperatura"));
        valoresTabelaSistema.put("variacaoAnomalaHumidade", rs.getDouble("variacaoAnomalaHumidade"));
        valoresTabelaSistema.put("crescimentoInstantaneoTemperatura", rs.getDouble("crescimentoInstantaneoTemperatura"));
        valoresTabelaSistema.put("crescimentoGradualTemperatura", rs.getDouble("crescimentoGradualTemperatura"));
        valoresTabelaSistema.put("crescimentoInstantaneoHumidade", rs.getDouble("crescimentoInstantaneoHumidade"));
        valoresTabelaSistema.put("crescimentoGradualHumidade", rs.getDouble("crescimentoGradualHumidade"));
        valoresTabelaSistema.put("luminosidadeLuzesDesligadas", rs.getDouble("luminosidadeLuzesDesligadas"));
        valoresTabelaSistema.put("limiteTemperatura", rs.getDouble("limiteTemperatura"));
        valoresTabelaSistema.put("limiteHumidade", rs.getDouble("limiteHumidade"));
    }

    private Document getUltimoValor() {
        List<Document> novosresultados = new ArrayList<Document>();
        mongocol.find().sort(lastFilter).limit(1).into(novosresultados);
        return novosresultados.get(0);
    }

    private HashMap<String,Medicao> getValoresMedicao(Document doc) {
        String[] date_split = doc.getString("dat").split("/");
        String date_fixed = date_split[2] + "-" + date_split[1] + "-" + date_split[0] + " " + doc.getString("tim");
        Medicao medicaoTemperatura = new Medicao(doc.getString("tmp"), "tmp", date_fixed);
        Medicao medicaoHumidade = new Medicao(doc.getString("hum"), "hum", date_fixed);
        Medicao medicaoLuminosidade = new Medicao(doc.getString("cell"), "lum", date_fixed);
        Medicao medicaoMovimento = new Medicao(doc.getString("sens\""), "mov", date_fixed);
        HashMap<String,Medicao> medicoes = new HashMap<String, Medicao>();
        medicoes.put("tmp",medicaoTemperatura);
        medicoes.put("hum",medicaoHumidade);
        medicoes.put("lum",medicaoLuminosidade);
        medicoes.put("mov",medicaoMovimento);
        return medicoes;
    }

    private void insereMedicoes() {

        //TODO falta fazer isto
        SqlCommando = "call InserirMedicao";

    }
}


