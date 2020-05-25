package Alertas;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedList;

import Anomalias.InsereMedicoesNoMySql;
import Anomalias.Medicao;
import com.sun.java.swing.plaf.motif.MotifEditorPaneUI;


public class Alerta {

	private Medicao medicao;
	
	
	public Alerta(HashMap valoresTabelaSistema, Medicao medicao) {
		this.medicao = medicao;
	}
	static LinkedList<Medicao> ultimosValoresTemperatura = new LinkedList<Medicao>();
	static LinkedList<Medicao> ultimosValoresHumidade = new LinkedList<Medicao>();
	static LinkedList<Medicao> ultimosValoresLuminosidade = new LinkedList<Medicao>();

	private static int tamanhoBuffer = 5;

	// Variaveis de temperatura
	private static double limiteTemperatura = 50;
	private static double crescimentoInstantaneoTemperatura = 0.15;
	private static double crescimentoGradualTemperatura = 0.25;

	// Variaveis de humidade

	// Variaveis de assalto

	public static void adicionaValor(Medicao m) {
		if (m.getTipoMedicao().equals("tmp")) {
			if (ultimosValoresTemperatura.size() == tamanhoBuffer) {
				ultimosValoresTemperatura.poll();
			}
			ultimosValoresTemperatura.add(m);
		} else if (m.getTipoMedicao().equals("hum")) {
			if (ultimosValoresHumidade.size() == tamanhoBuffer) {
				ultimosValoresHumidade.poll();
			}
			ultimosValoresHumidade.add(m);
		} else if (m.getTipoMedicao().equals("lum")){
			if (ultimosValoresLuminosidade.size() == tamanhoBuffer) {
				ultimosValoresLuminosidade.poll();
			}
			ultimosValoresLuminosidade.add(m);
		}

	}

	public static void defineTamanhoBuffer(int n) {
		tamanhoBuffer = n;
	}

	public static void defineValoresTemperatura(double limiteTemperatura, double crescimentoInstantaneo,
			double crescimentoGradual) {
		limiteTemperatura = limiteTemperatura;
		crescimentoInstantaneo = crescimentoInstantaneo;
		crescimentoGradual = crescimentoGradual;
	}

	public static double getLimiteTemperatura() {
		return limiteTemperatura;
	}

	public static Medicao getUltimoValor(String tipo) {
		Medicao m;
		if (tipo.equals("tmp")) {
			if (ultimosValoresTemperatura.size() != 0) {
				m = ultimosValoresTemperatura.getLast();
			}
			return null;
		}
		else if (tipo.equals("hum")) {
			if (ultimosValoresHumidade.size() != 0) {
				m = ultimosValoresHumidade.getLast();
			}
			return null;
		}
		else if (tipo.equals("lum")) {
			if (ultimosValoresHumidade.size() != 0) {
				m = ultimosValoresHumidade.getLast();
			}
			return null;
		}
		return null;
	}

	public static Medicao getPrimeiroValor(String tipo) {
		Medicao m;
		if (tipo.equals("tmp")) {
			if (ultimosValoresTemperatura.size() != 0) {
				m = ultimosValoresTemperatura.getFirst();
			}
			return null;
		}
		else if (tipo.equals("hum")) {
			if (ultimosValoresHumidade.size() != 0) {
				m = ultimosValoresHumidade.getFirst();
			}
			return null;
		}
		else if (tipo.equals("lum")) {
			if (ultimosValoresHumidade.size() != 0) {
				m = ultimosValoresHumidade.getFirst();
			}
			return null;
		}
		return null;
	}

	public static double getCrescimentoInstantaneo(String string) {
		int tipo = 0;
		if (tipo == 0) {
			return crescimentoInstantaneoTemperatura;
		}
		if (tipo == 1) {
			return -1.0;
		}
		if (tipo == 2) {
			return -1.0;
		}
		return tipo;
	}

	public static double getCrescimentoGradual(String string) {
		int tipo = 0;
		if (tipo == 0) {
			return crescimentoGradualTemperatura;
		}
		if (tipo == 1) {
			return -1.0;
		}
		if (tipo == 2) {
			return -1.0;
		}
		return tipo;
	}

	public static void enviaAlerta(Connection conn, String descricao, Medicao medicao) {
		try {
			Statement st = conn.createStatement();
			String Sqlcommando = "CALL InserirAlerta(NULL, '" + new InsereMedicoesNoMySql(medicao).dataHoraParaFormatoCerto() +  "','"+medicao.getTipoMedicao()+  "','"+ medicao.getValorMedicao()+  "',NULL,'"+descricao+"',0,NULL);";
			ResultSet rs = st.executeQuery(Sqlcommando);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static double getLimite(String tipoMedicao) {
		// TODO Auto-generated method stub
		return 0;
	}
}
