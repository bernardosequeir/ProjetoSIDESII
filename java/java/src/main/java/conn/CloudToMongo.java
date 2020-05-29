package conn;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

import com.mongodb.*;
import com.mongodb.util.JSON;

import java.util.*;
import java.util.Vector;
import java.io.File;
import java.io.*;
import javax.swing.*;

public class CloudToMongo implements MqttCallback {
	MqttClient mqttclient;
	static MongoClient mongoClient;
	static DB db;
	static DBCollection mongocol;
	static String cloud_server = new String();
	static String cloud_topic = new String();
	static String mongo_host = new String();
	static String mongo_database = new String();
	static String mongo_collection = new String();

	public static void main(String[] args) {
		try {
			Properties p = new Properties();
			p.load(new FileInputStream("cloudToMongo.ini"));
			cloud_server = p.getProperty("cloud_server");
			cloud_topic = p.getProperty("cloud_topic");
			mongo_host = p.getProperty("mongo_host");
			mongo_database = p.getProperty("mongo_database");
			mongo_collection = p.getProperty("mongo_collection");
		} catch (Exception e) {

			System.err.println("Error reading CloudToMongo.ini file " + e);
		}
		
		new CloudToMongo().connectMQTTBroker();
		new CloudToMongo().connectMongo();
	}

	public void connectMQTTBroker() {
		int i;
		try {
			i = new Random().nextInt(100000);
			mqttclient = new MqttClient(cloud_server, "CloudToMongo_" + String.valueOf(i) + "_" + cloud_topic);
			mqttclient.connect();
			mqttclient.setCallback(this);
			mqttclient.subscribe(cloud_topic);
		} catch (MqttException e) {
			System.err.println("Could not connect to MQTT brocker. Cloud topic is: " + cloud_topic + e);
		}
	}

	public void connectMongo() {
		try {
		mongoClient = new MongoClient(new MongoClientURI(mongo_host));
		db = mongoClient.getDB(mongo_database);
		mongocol = db.getCollection(mongo_collection);
		} catch (Exception e) {
			System.err.println("Failed to start MongoClient with Mongo host " + mongo_host + e);
		}
	}

	public void messageArrived(String topic, MqttMessage c) throws Exception {
		try {
			DBObject document_json;

			document_json = (DBObject) JSON.parse(clean(c.toString()));
			System.out.println(clean(c.toString()));
			mongocol.insert(document_json, WriteConcern.MAJORITY);
		} catch (Exception e) {
			System.err.println("Failed to get a Mongo Document " + e);
		}
	}

	public void connectionLost(Throwable cause) {
	}

	public void deliveryComplete(IMqttDeliveryToken token) {
	}

	public String clean(String message) {
		//message.replace("\"\"", "\"");
		//message = message.replace("\"s", "\",s");  //comentar até mais ou menos 6 da tarde
		try {
			return message.replaceAll("\", " , ",\"");
		} catch (NullPointerException e){
			System.err.println("Mongo got a null Document " + e);
		}
		return null;

	}

}