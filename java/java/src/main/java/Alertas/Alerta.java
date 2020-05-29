package Alertas;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

	private static LinkedList<Medicao> ultimosValoresTemperatura = new LinkedList<Medicao>();
	private static LinkedList<Medicao> ultimosValoresHumidade = new LinkedList<Medicao>();
	private static LinkedList<Medicao> ultimosValoresLuminosidade = new LinkedList<Medicao>();
	private static String ultimaAlertaMovimento = null;
	private static String ultimaAlertaLuminosidade = null;
	private static Date fimRondaEmCurso = null;
	private static String ultimoAlarmeLimiteTemperatura = null;
	private static String ultimoAlarmeCrescimentoTemperatura = null;
	private static String ultimoAlarmeLimiteHumidade = null;
	private static String ultimoAlarmeCrescimentoHumidade= null;
	
	
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

public static Double buscarIntervaloEntreAlertas() {
	return valoresTabelaSistema.get("TempoEntreAlertas");
}

	public static void buscarValoresTabelaSistema() {
		valoresTabelaSistema = MongoParaMysql.getValoresTabelaSistema();
	}

	public static Double getLimite(String tipoMedicao) {

		if (tipoMedicao.equals("tmp"))
			return valoresTabelaSistema.get("limiteTemperatura");
		else if (tipoMedicao.equals("hum"))
			return valoresTabelaSistema.get("limiteHumidade");
		return null;
	}
	
	

	


	public static boolean  verificarSeMandaAlerta(String dataAntiga, String dataNova) {
		try {
			if(dataAntiga==null){
				return true;
			}
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd kk:mm:ss");
			Date dataAntigaFormatada = sdf.parse(dataAntiga);
			Date dataNovaFormatada = sdf.parse(dataNova);
			if( dataNovaFormatada.getTime() - dataAntigaFormatada.getTime() > buscarIntervaloEntreAlertas() * 60 *1000) {
				return true;
			}

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
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

	public static Double getCrescimentoInstantaneo(String tipoMedicao) {
		
		if (tipoMedicao.equals("tmp"))
			return valoresTabelaSistema.get("crescimentoInstantaneoTemperatura");
		else if (tipoMedicao.equals("hum"))
			return valoresTabelaSistema.get("crescimentoInstantaneoHumidade");
		else {
			System.err.println("Cannot get CrescimentoInstaneo");
			return null;
		}
	}

	public static Double getCrescimentoGradual(String tipoMedicao) {
		if (tipoMedicao.equals("tmp"))
			return valoresTabelaSistema.get("crescimentoGradualTemperatura");
		else if (tipoMedicao.equals("hum"))
			return valoresTabelaSistema.get("crescimentoGradualHumidade");
		else {
			System.err.println("Cannot get CrescimentoInstaneo");
			return null;
		}
	}

	public static void enviaAlerta(String descricao, Medicao medicao, String limite) {
		try {
			Connection conn = ConnectToMySql.connect();
			Statement st = conn.createStatement();
			String Sqlcommando = "CALL InserirAlerta( '"
					+ medicao.getDataHoraMedicao() + "','" + medicao.getTipoMedicao()
					+ "','" + medicao.getValorMedicao() + "','"+limite +"','" + descricao + "',0,'');";
			
			ResultSet rs = st.executeQuery(Sqlcommando);
			conn.close();
		} catch (SQLException e) {
			System.err.println("SP inserir alerta falhou " + e);
		}
	}
	//TODO substituir e por e.print...

	public static String getUltimaDataMovimento() {
		return ultimaAlertaMovimento;
	}
	public static String getUltimaDataLuminosidade() {
		return ultimaAlertaLuminosidade;
	}
	public static void setUltimaDataMovimento(String ultimaData) {
		ultimaAlertaMovimento = ultimaData;
	}
	public static void setUltimaDataLuminosidade(String ultimaData) {
		ultimaAlertaLuminosidade = ultimaData;
	}
	public static Date getFimRondaEmCurso() {
		return fimRondaEmCurso;
	}
	public static void setFimRondaEmCurso(Date ultimaData) {
		fimRondaEmCurso = ultimaData;
	}
	public static String getUltimoAlarmeLimiteTemperatura() {
		return ultimoAlarmeLimiteTemperatura;
	}
	public static void setUltimoAlarmeLimiteTemperatura(String ultimoAlarmeLimiteTemperatura) {
		Alerta.ultimoAlarmeLimiteTemperatura = ultimoAlarmeLimiteTemperatura;
	}
	public static String getUltimoAlarmeCrescimentoTemperatura() {
		return ultimoAlarmeCrescimentoTemperatura;
	}
	public static void setUltimoAlarmeCrescimentoTemperatura(String ultimoAlarmeCrescimentoTemperatura) {
		Alerta.ultimoAlarmeCrescimentoTemperatura = ultimoAlarmeCrescimentoTemperatura;
	}
	public static String getUltimoAlarmeLimiteHumidade() {
		return ultimoAlarmeLimiteHumidade;
	}
	public static void setUltimoAlarmeLimiteHumidade(String ultimoAlarmeLimiteHumidade) {
		Alerta.ultimoAlarmeLimiteHumidade = ultimoAlarmeLimiteHumidade;
	}
	public static String getUltimoAlarmeCrescimentoHumidade() {
		return ultimoAlarmeCrescimentoHumidade;
	}
	public static void setUltimoAlarmeCrescimentoHumidade(String ultimoAlarmeCrescimentoHumidade) {
		Alerta.ultimoAlarmeCrescimentoHumidade = ultimoAlarmeCrescimentoHumidade;
	}
}