package Anomalias;

public class Medicao {
	
	private double valorMedicao;
	private String tipoMedicao;
	private String dataHoraMedicao;
	private int possivelAnomalia = 0;
	

	public Medicao(String valorMedicao, String tipoMedicao, String dataHoraMedicao) {
		checkTipo();
		checkData();
		if((tipoMedicao.equals("hum")||tipoMedicao.equals("lum")) && possivelAnomalia==0){
			checkPositivo();
		}
		if(tipoMedicao.equals("mov") && possivelAnomalia ==0){
			checkMovimento();
		}
		this.tipoMedicao = tipoMedicao;
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
				this.valorMedicao = Double.parseDouble(tipoMedicao);
			} catch (Exception e) {
				this.possivelAnomalia = 1;
			}
	}


	public double getValorMedicao() {
		return valorMedicao;
	}
	public String getTipoMedicao(){
		return tipoMedicao;
	}
}
