

public class Medicao {
	
	private double valorMedicao;
	private String tipoSensor;
	private String dataHoraMedicao;
	private int possivelAnomalia;
	

	public Medicao(String valorMedicao, String tipoSensor, String dataHoraMedicao, String possivelAnomalia) {
		this.valorMedicao = Double.parseDouble(valorMedicao);
		this.tipoSensor = tipoSensor;
		this.dataHoraMedicao = dataHoraMedicao;
		this.possivelAnomalia = Integer.parseInt(possivelAnomalia);
	}


	public double getValorMedicao() {
		return valorMedicao;
	}	
}
