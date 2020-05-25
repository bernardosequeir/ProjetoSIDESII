package Alertas;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedList;

import Anomalias.InsereMedicoesNoMySql;
import Anomalias.Medicao;


public class Alerta {

	private Medicao medicao;
	
	
	public Alerta(HashMap valoresTabelaSistema, Medicao medicao) {
		this.medicao = medicao;
	}
	static LinkedList<Double> ultimosValoresTemperatura = new LinkedList<Double>();
	static LinkedList<Double> ultimosValoresHumidade = new LinkedList<Double>();
	static LinkedList<Double> ultimosValoresLuminosidade = new LinkedList<Double>();

	private static int tamanhoBuffer = 5;

	// Variaveis de temperatura
	private static double limiteTemperatura = 50;
	private static double crescimentoInstantaneoTemperatura = 0.15;
	private static double crescimentoGradualTemperatura = 0.25;

	// Variaveis de humidade

	// Variaveis de assalto

	public static void adicionaValor(double val) {
		int tipo = 0;
		if (tipo == 0) {
			if (ultimosValoresTemperatura.size() == tamanhoBuffer) {
				ultimosValoresTemperatura.poll();
				ultimosValoresTemperatura.add(val);

			} else {
				ultimosValoresTemperatura.add(val);

			}
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

	public static double getUltimoValor(String string) {
		int tipo = 0;
		if (tipo == 0) {
			double n = -1.0;
			if (ultimosValoresTemperatura.size() != 0) {
				n = ultimosValoresTemperatura.getLast();
			}
			return n;
		}
		if (tipo == 1) {
			return -1.0;
		}
		if (tipo == 2) {
			return -1.0;
		}
		return tipo;
	}

	public static double getPrimeiroValor(String string) {
		int tipo = 0;
		if (tipo == 0) {
			double n = -1.0;
			if (ultimosValoresTemperatura.size() != 0.0) {
				n = ultimosValoresTemperatura.getFirst();
			}
			return n;
		}
		if (tipo == 1) {
			return -1.0;
		}
		if (tipo == 2) {
			return -1.0;
		}

		return tipo;
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