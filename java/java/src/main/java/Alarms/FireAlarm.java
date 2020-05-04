package Alarms;

import java.util.LinkedList;
import java.util.Queue;

public class FireAlarm extends Alarm {

	static LinkedList<Double> ultimosValoresComAnomalias = new LinkedList<Double>();
	static LinkedList<Double> lastValues = new LinkedList<Double>();
	
	static Double crescimentoInstantaneo = 0.05;
	static Double TotalGrowth_MinLimiar = 10.0;
	static Double TotalGrowth_MaxLimiar = 20.0;
	
	private Double temp;
	
	public FireAlarm (Double temp) {
		this.temp = temp;
		System.out.println(temp);
		System.out.println(lastValues.toString());
		addCurrentTemperature(temp);
		analiseValues();
	}
	
	
	
	public void analiseValues() {
		
		
		
		if(getCurrentGrowth() > crescimentoInstantaneo) {	
			sendFireAlert();
		} else if (getTotalGrowth() > TotalGrowth_MinLimiar && getTotalGrowth() < TotalGrowth_MaxLimiar) {
			sendPossibleFireAlert();
		}
	}
	
	public void addCurrentTemperature(Double temp) {

		
		
		if(lastValues.size() == 10) {
			lastValues.poll();
			lastValues.add(temp);
			
		} else {
			lastValues.add(temp);
			
		}
	
	}
	
	public Double getCurrentGrowth() {
		double m = this.temp;
		double n;
		
		if(lastValues.size() > 1) {
			n = lastValues.get(lastValues.size() - 2);
			System.out.println("last value: " + n);
		} else {
			return 0.0;
		}
		System.out.println("Current growth: " + (m - n));
		return m - n;
	}
	
	public Double getTotalGrowth() {
		double m = this.temp;
		double n = lastValues.getFirst();
		
		System.out.println("Total growth: " + (m - n));
		return m - n;
	}
	
	public void sendPossibleFireAlert() {
		System.err.println("POSSIBLE FIRE ALERT");
	}
	
	public void sendFireAlert() {
		System.err.println("FIRE ALERT");
	}
	
	public static void main(String[] args) {
		
		for (int i = 0; i < 3; i++) {
			new FireAlarm (20.0 + i*6);
		}
		
		/*
		while(true) {
			new FireAnaliser(10.0);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}*/
	}
	
	
}
