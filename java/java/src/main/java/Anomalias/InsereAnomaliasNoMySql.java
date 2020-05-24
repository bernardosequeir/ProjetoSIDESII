package Anomalias;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class InsereAnomaliasNoMySql {

	
	private Medicao medicao;
	private Connection conn;
	public InsereAnomaliasNoMySql(Medicao medicao, Connection conn) {
		this.medicao = medicao;
		this.conn=conn;
		insereMedicoesNoMySql();
	}
	
	public void insereMedicoesNoMySql() {
		String Sqlcommando = "INSERT INTO `medicao_sensores_anomalos` (`NULL`, `ValorMedicao`, `TipoSensor`, `DataHoraMedicao`) VALUES ('NULL', '"+ medicao.getValorMedicao()+ "', '"+medicao.getTipoMedicao() + "', '"+medicao.getDataHoraMedicao()+"');";
		try {
			conn.createStatement().executeQuery(Sqlcommando);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
