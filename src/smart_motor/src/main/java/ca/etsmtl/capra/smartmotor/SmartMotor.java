package ca.etsmtl.capra.smartmotor;

public class SmartMotor extends AbstractMotor{

	private int address;		//Addresse du moteur, entre 1 et 120

	public SmartMotor(int address){
		this.address = address;
	}
	
	// --------------------- ADDRESSAGE (DAISY CHAINING RS-232) --------------------------
	
	/**
	 * Sets the address of a motor to the desired motor in the chain
	 * @param noMoteur the number of the motor in the chain
	 */
	public void setAddress(int noMoteur){
		
		//commande de la forme 1SADDR1
		//Le premier chiffre représente le no du moteur dans la liste
		//Le second chiffre représente l'adresse qu'on désire lui donner
		String com = "SADDR" + noMoteur;
		address = noMoteur;
		
		send(com);
		
	}
	
	//------------- ENVOI DE COMMANDES ----------------------
	
	@Override
	/**
	 * Calls the sendCommand method
	 * @param com The command
	 */
	protected void send(String com){
		
		//Conversion de l'adresse(ex 1) en caractere, genre 128(dec) ou 0x80(hex)
		char add = (char) (128 + address);
		
		String toSendCommand =  add + com;
		sendToController(toSendCommand);
	}

	
}