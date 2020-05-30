
package conn;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import java.time.format.DateTimeFormatter;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.LocalDate;
import org.eclipse.paho.client.mqttv3.MqttException;
import java.awt.Component;
import javax.swing.JOptionPane;
import java.io.InputStream;
import java.io.FileInputStream;
import java.util.Properties;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttCallback;

public class SimulateSensor implements MqttCallback {
	static MqttClient mqttclient;
	static String cloud_server;
	static String cloud_topic;

	public static void main(final String[] array) {
		try {
			final Properties properties = new Properties();
			properties.load(new FileInputStream("SimulateSensor.ini"));
			SimulateSensor.cloud_server = properties.getProperty("cloud_server");
			SimulateSensor.cloud_topic = properties.getProperty("cloud_topic");
		} catch (Exception obj) {
			System.out.println("Error reading SimulateSensor.ini file " + obj);
			JOptionPane.showMessageDialog(null, "The SimulateSensor.ini file wasn't found.", "Mongo To Cloud", 0);
		}
		new SimulateSensor().connecCloud();
		new SimulateSensor().writeSensor();
	}

	public void connecCloud() {
		try {
			(SimulateSensor.mqttclient = new MqttClient(SimulateSensor.cloud_server,
					"SimulateSensor" + SimulateSensor.cloud_topic)).connect();
			SimulateSensor.mqttclient.setCallback((MqttCallback) this);
			SimulateSensor.mqttclient.subscribe(SimulateSensor.cloud_topic);
		} catch (MqttException ex) {
			ex.printStackTrace();
		}
	}

	public void writeSensor() {
		final String s = new String();
		LocalDate.now();
		LocalTime.now();
		
			double d = 18.0;
			String string1 = "{\"tmp\":\"" + 20.0 + "\",\"hum\":\"" + 35.0 + "\",\"dat\":\""
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + "\",\"tim\":\""
					+ LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\",\"cell\":\"" + 20
					+ "\",\"mov\":\"" + 0 + "\",\"sens\":\"eth\"}";

			publishSensor(string1);
			string1 = "{\"tmp\":\"" + 20.0 + "\",\"hum\":\"" + 35.0 + "\",\"dat\":\""
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + "\",\"tim\":\""
					+ LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\",\"cell\":\"" + 20
					+ "\",\"mov\":\"" + 0 + "\",\"sens\":\"eth\"}";

			publishSensor(string1);
			string1 = "{\"tmp\":\"" + 20.0 + "\",\"hum\":\"" + 35.0 + "\",\"dat\":\""
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + "\",\"tim\":\""
					+ LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\",\"cell\":\"" + 20
					+ "\",\"mov\":\"" + 0 + "\",\"sens\":\"eth\"}";

			publishSensor(string1);
			string1 = "{\"tmp\":\"" + 21.0 + "\",\"hum\":\"" + 35.0 + "\",\"dat\":\""
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + "\",\"tim\":\""
					+ LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\",\"cell\":\"" + 20
					+ "\",\"mov\":\"" + 0 + "\",\"sens\":\"eth\"}";

			publishSensor(string1);
			string1 = "{\"tmp\":\"" + 22.0 + "\",\"hum\":\"" + 35.0 + "\",\"dat\":\""
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + "\",\"tim\":\""
					+ LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\",\"cell\":\"" + 20
					+ "\",\"mov\":\"" + 0 + "\",\"sens\":\"eth\"}";

			publishSensor(string1);
			string1 = "{\"tmp\":\"" + 22.0 + "\",\"hum\":\"" + 35.0 + "\",\"dat\":\""
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + "\",\"tim\":\""
					+ LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\",\"cell\":\"" + 20
					+ "\",\"mov\":\"" + 0 + "\",\"sens\":\"eth\"}";

			publishSensor(string1);
			string1 = "{\"tmp\":\"" + 23.0 + "\",\"hum\":\"" + 35.0 + "\",\"dat\":\""
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + "\",\"tim\":\""
					+ LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\",\"cell\":\"" + 20
					+ "\",\"mov\":\"" + 0 + "\",\"sens\":\"eth\"}";

			publishSensor(string1);
			string1 = "{\"tmp\":\"" + 24.0 + "\",\"hum\":\"" + 35.0 + "\",\"dat\":\""
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + "\",\"tim\":\""
					+ LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\",\"cell\":\"" + 20
					+ "\",\"mov\":\"" + 0 + "\",\"sens\":\"eth\"}";

			publishSensor(string1);
			string1 = "{\"tmp\":\"" + 28.0 + "\",\"hum\":\"" + 35.0 + "\",\"dat\":\""
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + "\",\"tim\":\""
					+ LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\",\"cell\":\"" + 20
					+ "\",\"mov\":\"" + 0 + "\",\"sens\":\"eth\"}";

			publishSensor(string1);
			string1 = "{\"tmp\":\"" + 32.0 + "\",\"hum\":\"" + 35.0 + "\",\"dat\":\""
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + "\",\"tim\":\""
					+ LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\",\"cell\":\"" + 20
					+ "\",\"mov\":\"" + 0 + "\",\"sens\":\"eth\"}";

			publishSensor(string1);
			
			
		
	}

	public void publishSensor(final String s) {
		try {
			final MqttMessage mqttMessage = new MqttMessage();
			mqttMessage.setPayload(s.getBytes());
			SimulateSensor.mqttclient.publish(SimulateSensor.cloud_topic, mqttMessage);
		} catch (MqttException ex) {
			ex.printStackTrace();
		}
	}

	public void connectionLost(final Throwable t) {
	}

	public void deliveryComplete(final IMqttDeliveryToken mqttDeliveryToken) {
	}

	public void messageArrived(final String s, final MqttMessage mqttMessage) {
	}

	static {
		SimulateSensor.cloud_server = new String();
		SimulateSensor.cloud_topic = new String();
	}
}