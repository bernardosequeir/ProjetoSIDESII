package Alertas;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import Anomalias.InsereMedicoesNoMySql;
import Anomalias.Medicao;
import conn.ConnectToMySql;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

/**
 * 
 * @author joaof, bernardosequeir grupo12 Opens a new sql connection
 *
 */
public class AvaliaAlertaAssalto {

	/*
	 * O que é que ele precisa: - Duas medição - luminosidade e movimento - Se há
	 * ronda atual ou ronda extra
	 *
	 *
	 * Luminosidade variou? Se !ronda && movimento = assalto
	 * 
	 *
	 */
	private Medicao movimento;
	private Medicao luminosidade;
	private Connection conn;
	private String timestampUsedInRonda;
	private Double luminosidadeLuzEscuro;
	private String tipoAlerta;
	
	public AvaliaAlertaAssalto(Medicao movimento, Medicao luminosidade, Double luminosidadeLuzEscuro) {

		this.movimento = movimento;
		this.luminosidade = luminosidade;
		this.luminosidadeLuzEscuro = luminosidadeLuzEscuro;
		timestampUsedInRonda = movimento.getDataHoraMedicao();
		if (existeAlerta())
			insereTabelaAlerta();

	}

	
	public void connectMysqlAssalto() {
		conn = ConnectToMySql.connect();
	}

	public boolean existeAlerta() {
		return valorEAlerta() && !existeRonda();
	}

	public boolean valorEAlerta() {
		// nao sao anomalos
		new InsereMedicoesNoMySql(movimento).insereMedicoesNoMySql();
		new InsereMedicoesNoMySql(luminosidade).insereMedicoesNoMySql();
		if (movimento.isAnomalo() && luminosidade.isAnomalo()) {
			return false;
		} else
		// insere sabendo se sao anomalos ou nao

		if (movimento.isAnomalo()) {
			if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro) {
				System.out.println("luminosidade.getValorMedicao() > luminosidadeLuzEscuro");
				tipoAlerta = "lum";
				return true;
			}
		} else if (luminosidade.isAnomalo()) {
			if (movimento.getValorMedicao() == 1.00) {
				tipoAlerta = "mov";
				return true;
			}
		} else if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro && movimento.getValorMedicao() == 1.00) {
			tipoAlerta = "both";
			return true;
		} else if (luminosidade.getValorMedicao() > luminosidadeLuzEscuro) {
			tipoAlerta = "lum";
			return true;
		} else if (movimento.getValorMedicao() == 1.00) {
			tipoAlerta = "mov";
			return true;
		}
		return false;

	}

	public void insereTabelaAlerta() {
		System.out.println("entrei no insere Alerta Assalto");
		try {

			if (tipoAlerta.equals("mov")) {
				if (Alerta.verificarSeMandaAlerta(Alerta.getUltimaDataMovimento(),
						movimento.getDataHoraMedicao())) {
					System.out.println("data é mais");
					Alerta.enviaAlerta("Possivel Assalto", movimento, "1");
					Alerta.setUltimaDataMovimento(movimento.getDataHoraMedicao());
				}
			} else if (tipoAlerta.equals("lum")) {
				if (Alerta.verificarSeMandaAlerta(Alerta.getUltimaDataLuminosidade(),
						luminosidade.getDataHoraMedicao())) {
					Alerta.setUltimaDataLuminosidade(luminosidade.getDataHoraMedicao());
					Alerta.enviaAlerta("Possivel Assalto", luminosidade, Double.toString(luminosidadeLuzEscuro));
				}
			} else if (tipoAlerta.equals("both")) {
				if (Alerta.verificarSeMandaAlerta(Alerta.getUltimaDataLuminosidade(),
						luminosidade.getDataHoraMedicao())) {
					Alerta.setUltimaDataLuminosidade(luminosidade.getDataHoraMedicao());
					Alerta.enviaAlerta("Possivel Assalto", luminosidade, Double.toString(luminosidadeLuzEscuro));
				}
				if (Alerta.verificarSeMandaAlerta(Alerta.getUltimaDataMovimento(),
						movimento.getDataHoraMedicao())) {
					Alerta.setUltimaDataMovimento(movimento.getDataHoraMedicao());
					Alerta.enviaAlerta("Possivel Assalto", movimento, "1");
				}

			}

		} catch (Exception e) {
			System.err.println(
					"Enviar alerta falhou ou tipoAlerta não foi definido. TipoAlerta: " + tipoAlerta + " " + "e");
		}
	}

	public boolean existeRonda() {
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
			Date parsedDate = dateFormat.parse(movimento.getDataHoraMedicao());
			Time time = new Time(parsedDate.getTime());
			Time fimRondaEmCurso = Alerta.getFimRondaEmCurso();
			System.out.println(fimRondaEmCurso);
			if(fimRondaEmCurso != null){
				System.out.println("entra no check do time");
				System.out.println(time);
				if (fimRondaEmCurso.after(time)) {
					return true;
				}
			}

		} catch (ParseException e1) {
			System.err.println("Could not parse the date from Movimento. Data Movimento:  "
					+ movimento.getDataHoraMedicao() + " " + e1);
		}

		// isto vai ter um problema que eu não consigo pensar nele, mas se rondas
		// tiverem mais de 24h rip(nao importante)
		// e se o cliente quiser aceitar tudo no medicoes_sensores e se o sensor estiver
		// avariado rip tambem, ou seja se sensor estiver a mandar data errada e valor
		// certo e só assim por acaso é um incendio rip
		// Rondas planeadas com mais de 24h vai ser um grande rip, espero que nunca
		// aconteca
		Statement st;
		try {
			connectMysqlAssalto();
			System.out.println("comeca a verificar ronda");
			st = conn.createStatement();
			System.out.println("timestampUsedInRonda" + timestampUsedInRonda);
			String Sqlcommando = "CALL VerificaSeExisteRonda('" + timestampUsedInRonda + "')";
			ResultSet rs = st.executeQuery(Sqlcommando);
			rs.next();
			Time result = rs.getTime("fimRondaActual");
			conn.close();
			if (result != null) {
				System.out.println("tá a haver uma ronda actual ");
				Alerta.setFimRondaEmCurso(result);
				return true;
			} else {
				System.out.println("nao ha nenhuma ronda a acontecer ");
				return false;
			}
		} catch (SQLException e) {
			System.err.println("SP VerificaSeExisteRonda failed. " + e);
		}
		return false;

	}

}