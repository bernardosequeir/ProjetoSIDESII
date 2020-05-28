package Alertas;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedList;

import Anomalias.InsereMedicoesNoMySql;
import Anomalias.Medicao;
import conn.ConnectToMySql;
import conn.MongoParaMysql;

import com.sun.java.swing.plaf.motif.MotifEditorPaneUI;

public class Alerta {

	private Medicao medicao;
	private static HashMap<String, Double> valoresTabelaSistema;
	private static boolean primeiraMedicao = true;

	public Alerta(HashMap valoresTabelaSistema, Medicao medicao) {
		this.medicao = medicao;
	}

	static LinkedList<Medicao> ultimosValoresTemperatura = new LinkedList<Medicao>();
	static LinkedList<Medicao> ultimosValoresHumidade = new LinkedList<Medicao>();
	static LinkedList<Medicao> ultimosValoresLuminosidade = new LinkedList<Medicao>();
	
	
	public static int irBuscarBuffersAlerta() {
		return valoresTabelaSistema.get("tamanhoDosBuffersAlerta").intValue();
		
	}
	public static void adicionaValor(Medicao m) {
		if(primeiraMedicao){
			System.out.println("Fui buscar valores");
			buscarValoresTabelaSistema();
			System.out.println(valoresTabelaSistema);
			primeiraMedicao = false;
		} 
		if (m.getTipoMedicao().equals("tmp")) {
			System.out.println("entrou tmp");
			if (ultimosValoresTemperatura.size() == irBuscarBuffersAlerta()) {
				System.out.println("entrou buffers cheios");
				ultimosValoresTemperatura.poll();
			}
			else {
				System.out.println("entrou buffers nao cheios");
				ultimosValoresTemperatura.add(m);
			}
		} else if (m.getTipoMedicao().equals("hum")) {
			if (ultimosValoresHumidade.size() == irBuscarBuffersAlerta()) {
				ultimosValoresHumidade.poll();
			}
			else ultimosValoresHumidade.add(m);
		} else if (m.getTipoMedicao().equals("lum")) {
			if (ultimosValoresLuminosidade.size() == irBuscarBuffersAlerta()) {
				ultimosValoresLuminosidade.poll();
			}
			else ultimosValoresLuminosidade.add(m);
		}

	}



	public static void buscarValoresTabelaSistema() {
		valoresTabelaSistema = MongoParaMysql.getValoresTabelaSistema();
	}

	public static double getLimite(String tipoMedicao) {

		if (tipoMedicao.equals("tmp"))
			return valoresTabelaSistema.get("limiteTemperatura");
		else if (tipoMedicao.equals("hum"))
			return valoresTabelaSistema.get("limiteHumidade");
		//TODO verificar se é 0.0 antes
		return 0.0;
	}
	
	

	




	public static Medicao getUltimoValor(String tipoMedicao) {
		if (tipoMedicao.equals("tmp")) {
			if (ultimosValoresTemperatura.size() != 0) {
				return ultimosValoresTemperatura.getLast();
			}
			return null;
		} else if (tipoMedicao.equals("hum")) {
			if (ultimosValoresHumidade.size() != 0) {
				return  ultimosValoresHumidade.getLast();
			}
			return null;
		} else if (tipoMedicao.equals("lum")) {
			if (ultimosValoresHumidade.size() != 0) {
				return ultimosValoresHumidade.getLast();
			}
			return null;
		}
		return null;
	}

	//TODO tratar destes null's
	public static Medicao getPrimeiroValor(String tipoMedicao) {
		if (tipoMedicao.equals("tmp")) {
			if (ultimosValoresTemperatura.size() != 0) {
				return ultimosValoresTemperatura.getFirst();
			}
			return null;
		} else if (tipoMedicao.equals("hum")) {
			if (ultimosValoresHumidade.size() != 0) {
				return ultimosValoresHumidade.getFirst();
			}
			return null;
		} else if (tipoMedicao.equals("lum")) {
			if (ultimosValoresHumidade.size() != 0) {
				return ultimosValoresHumidade.getFirst();
			}
			return null;
		}
		return null;
	}

	public static double getCrescimentoInstantaneo(String tipoMedicao) {

		if (tipoMedicao.equals("tmp"))
			return valoresTabelaSistema.get("crescimentoInstantaneoTemperatura");
		else if (tipoMedicao.equals("hum"))
			return valoresTabelaSistema.get("crescimentoInstantaneoHumidade");
		//TODO verificar se é 0.0 antes
		return 0.0;
	}

	public static double getCrescimentoGradual(String tipoMedicao) {
		if (tipoMedicao.equals("tmp"))
			return valoresTabelaSistema.get("crescimentoGradualTemperatura");
		else if (tipoMedicao.equals("hum"))
			return valoresTabelaSistema.get("crescimentoGradualHumidade");
		//TODO verificar se é 0.0 antes
		return 0.0;
	}

	public static void enviaAlerta(String descricao, Medicao medicao, String limite) {
		try {
			Connection conn = ConnectToMySql.connect();
			Statement st = conn.createStatement();
			String Sqlcommando = "CALL InserirAlerta( '"
					+ new InsereMedicoesNoMySql(medicao).dataHoraParaFormatoCerto() + "','" + medicao.getTipoMedicao()
					+ "','" + medicao.getValorMedicao() + "','"+limite +"','" + descricao + "',0,'');";
			
			ResultSet rs = st.executeQuery(Sqlcommando);
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}