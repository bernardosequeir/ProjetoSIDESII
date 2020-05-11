package Anomalias;

public class Medicao {
	
	private double valorMedicao;
	private String tipoSensor;
	private String dataHoraMedicao;
	private int possivelAnomalia = 0;
	

	public Medicao(String valorMedicao, String tipoSensor, String dataHoraMedicao) {
		checkTipo();
		checkData();
		if((tipoSensor.equals("hum")||tipoSensor.equals("lum")) && possivelAnomalia==0){
			checkPositivo();
		}
		if(tipoSensor.equals("mov") && possivelAnomalia ==0){
			checkMovimento();
		}
		this.tipoSensor = tipoSensor;
		this.dataHoraMedicao = dataHoraMedicao;
	}

	private void checkPositivo() {
		if(valorMedicao<0){
			possivelAnomalia = 1;
		}
	}

	private void checkMovimento(){
		if(valorMedicao != 0.0 || valorMedicao != 1.0){
			possivelAnomalia = 1;
		}
	}


	private void checkData() {
		//TODO Implementar um método no mongo to mysql que devolve a data do último doc inserido e compara com a deste
	}

	private void checkTipo() {
			try {
				this.valorMedicao = Double.parseDouble(tipoSensor);
			} catch (Exception e) {
				this.possivelAnomalia = 1;
			}
	}


	public double getValorMedicao() {
		return valorMedicao;
	}	
}
