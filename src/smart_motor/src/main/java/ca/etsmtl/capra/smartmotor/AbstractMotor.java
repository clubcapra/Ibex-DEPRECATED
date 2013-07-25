package ca.etsmtl.capra.smartmotor;

import java.util.ArrayList;

import ca.etsmtl.capra.smartmotor.io.MotorController;

public abstract class AbstractMotor {
	
	//Donnees changeables
	 protected static final double DEFAULT_ACCEL = 6; //Acceleration par default, en m/s2
	 public static final double DEFAULT_SPEED = 0.4;  //En m/s
	 protected static final double MAX_SPEED = 3; //En m/s, par securite
	
	 //Adressage
	 protected static final String SET_ADDR = "SADDR";
	 protected static final char ADDR_DIFFUSION = 128; // = 0x80
	
	//Commandes pour setter les modes
	 private static final String M_POS = "MP"; //Position
	 protected static final String M_VEL = "MV"; //Velocite
	 private static final String M_TOR = "MT"; //Torque
	
	//commandes specifiques a la position
	 private static final String P_SET_ABS = "PT="; //mode position absolue
	 //private static final String P_SET_REL = "DT="; //mode position relative (marche pas, DT semble relié a l'accel)
	
	//commandes de controle generales
	 private static final String WAIT = "WAIT="; 	//Pour mettre pause 
	 private static final String ECHO = "ECHO"; 	//Active le output du moteur
	 private static final String ECHO_OFF = "ECHO_OFF";
	 
	 private static final String WAKE = "WAKE";	//Sort du SLEEP
	 private static final String SLEEP = "SLEEP"; //Attend la commande WAKE pour faire de quoi
	 
	 protected static final String SET_ACCEL = "AT="; 	//Acceleration
	 private static final String SET_VEL = "VT="; 	//Velocite
	 private static final String SET_ORIGIN = "O=0"; //Setter la position presente comme la position d'orignie du shaft
	 private static final String SET_TORQUE = "T="; 	//Torque
	 private static final String GO = "G"; 			//go and start move
	 private static final String STOP = "X";		//Stop moving

	 //commandes limites
	 private static final String LIM_SOFT_OFF = "SLD"; 
	 private static final String LIM_HARD_OFF_L = "EIGN(2)";
	 private static final String LIM_HARD_OFF_R = "EIGN(3)";
	 
	 //Flags
	 private static final String RESET_FLAGS = "ZS";
	 
	 
	 //Port settings
	 protected static final String TYPE = "RS2,"; 	//avec une virgule a la fin
	 protected static final String CHANNEL = "0,";	 //avec une virgule a la fin
	 protected static final String PARITY = "N,"; 	//avec une virgule a la fin
	 protected static final String BAUD = "19200,";	 //avec une virgule a la fin
	 protected static final String STOP_BITS = "1,";	 //avec une virgule a la fin
	 protected static final String DATA_BITS = "8,"; 	//avec une virgule a la fin
	 protected static final String MODE = "C";		 //SANS virgule
	 protected static final String PORT_OPEN = "OHCN("; //avec parenthèse
	 
	 
	//Variables globales
	protected Mode mode; 			//Mode present
	protected double speed = 0; // en ms
	public boolean moving = false; 
	
	
	
	//-----------DEBUG ------------------
	/**
	 * Loop for a manual control of the motor
	 */
	public void manualControl(){
		
		String com;
		
		MotorUtility.affiche("Envoie manuel de commandes.  Entrez 'Q' pour quitter.");
		
		do{
			
			MotorUtility.affiche("Entrez une commande: ");
			com = MotorUtility.recupInput();
			if(!com.equals("Q"))
				this.send(com);
		
		}while(!com.equals("Q"));
		
		MotorUtility.affiche("Fin du controle manuel.");
	}
	
	
	 //--------------LIMITES ET FLAGS -------------------
	 
	 
		/**
		 * Turns of all hardware and software limits
		 */
		protected void disableLimits(){
			
			ArrayList<String> com = new ArrayList<String>();
			
			com.add(LIM_HARD_OFF_L);
			com.add(LIM_HARD_OFF_R);
			com.add(LIM_SOFT_OFF);
			com.add("EL=32000");
			
			send(com);
		}
		
		/**
		 * Resets all flags
		 */
		public void resetFlags(){
			send(RESET_FLAGS);
		}
	 
	 //---------------- ENVOI ET LECTURE DE COMMANDES -------------
		
	protected abstract void send(String com);
	
	
	/**
	 * Sends a command to all motors
	 * @param com The command to send
	 */
	public void sendToController(String com){
		
		//Un espace
		char space = 0x20;
		
		String command = com + space;
		
//		System.out.println("AbstractMotor: Sending to controller: \""+ command + "\"");
		
		
		 MotorController.getInstance().write(command);
		
		//temporaire
		//System.out.println(command);
		
	}
	
	protected void send(ArrayList<String> commands){
		for(String command : commands)
			send(command);
	}
	
	// ---------------------- GÉNÉRAL ------------------
	
	/**
	 * Pause the motor for a certain time
	 * @param time The time to wait - in seconds
	 */
	public void pause(double time){
		
		send(WAIT + MotorUtility.secToCounts(time));
		
	}
	
	protected void setEchoOn(){
		send(ECHO);
	}
	
	protected void setEchoOff(){
		send(ECHO_OFF);
	}
	
	protected void sleep(){
		send(SLEEP);
	}
	
	protected void wake(){
		send(WAKE);
	}
	
	/**
	 * Set acceleration of the motor
	 * @param accel The desired acceleration in rev/s^2
	 */
	public void setMotorAccel(double accel){
//		this.accel = MotorUtility.ms2ToRevs2(accel);
		send(SET_ACCEL + MotorUtility.revsToCounts(accel));
	}
	
	// ----------------------------- MODE POSITION ------------------------
	
	//La vitesse augementera avec une acceleration A jusqu'a une vitesse V
	//puis diminuera avec l'acceleration A pour atteindre la position P
	
	public void setPosMode(){
		send(M_POS);
	}
	
	/**
	 * Absolute move to the desired position
	 * @param position The final position in degrees
	 * @param speed The max velocity that will be obtained, in rpm
	 * @param accel The acceleration to use to speed up and slow down, in rev/sec^2
	 */
	protected void moveToPosition(double position, double speed, double accel){

		ArrayList<String> com = new ArrayList<String>();
		
		this.speed = speed;
		
		com.add(SET_ACCEL + MotorUtility.revsToCounts(accel));
		com.add(SET_VEL + MotorUtility.rpmToCounts(speed));
		com.add(P_SET_ABS + MotorUtility.degreeToCounts(position));
		com.add(GO);
		
		mode = Mode.POSITION;
		this.send(com);
	}
	
	/**
	 * Relative move from the current position
	 * @param position The difference between the current position and the final position in degrees (positive is clockwise) 
	 * @param speed The max velocity that will be obtained, in rpm
	 * @param accel The acceleration to use to speed up and slow down, in rev/sec^2
	 */
	public void changePosition(double angle, double speed, double accel){
		
		String com;
		
//		com.add(SET_ORIGIN);
//		com.add(SET_ACCEL + MotorUtility.revsToCounts(accel));
//		com.add(SET_VEL + MotorUtility.rpmToCounts(MotorUtility.msToRpm(speed)));
		
		setMotorAccel(accel);
		setSpeed(speed);
		
		com = P_SET_ABS + (int)MotorUtility.degreeToCounts(angle); //P_SET_REL marche pas..
		
		this.send(com);
	}
	
	protected void resetEncoders(){
		send(SET_ORIGIN);
	}
		
	// ----------------------------- MODE VELOCITY -----------------------
		
	//La vitesse augementera avec une acceleration A jusqu'a une vitesse V
		
	public void setSpeedMode(){
		
		mode = Mode.VELOCITY;
		
		send(M_VEL);
		setMotorAccel(DEFAULT_ACCEL);
	}
	
	/**
	 * Set the rotation speed to the desired value
	 * @param speed The desired speed in rpm
	 */
	protected void setSpeed(double speed){
		
		if(Math.abs(speed) > MAX_SPEED)
			System.out.println("Erreur: Vitesse max=" + MAX_SPEED);
		else{
			String com = "";
			
			com = SET_VEL + MotorUtility.rpmToCounts(MotorUtility.msToRpm(speed));
			
			this.speed = speed;
			mode = Mode.VELOCITY;
			
//			System.out.println("setting speed: " + com);
			send(com);
		}
		
	}
	
	public double getSpeed(){
		return speed;
	}
	
	public void stop(){
		send(STOP);
//		moving = false;
	}
	
	public void startMove(){
		send(GO);
		
//		moving = true;
	}
	
	public boolean isMoving(){
		return moving;
	}
	
	
	

	// ---------------------------- GESTION DES MODES ------------------------
	
	
	public enum Mode{
		TORQUE, POSITION, VELOCITY;
	}
	
	protected Mode getMode(){
		return mode;
	}
	
	// ------------------------------ MODE TORQUE ----------------------
	
	public void setTorqueMode(){
		
		send(M_TOR);
		mode = Mode.TORQUE;
		
	}
	
	/**
	 * Set the desire torque
	 * @param pourcent The desired percentage of torque (-100 to 100)
	 */
	protected void setTorque(double pourcent){
		
		ArrayList<String> com = new ArrayList<String>();
		
		//Gestion d'un pourcentage invalide
		if (pourcent >= 100)
			throw new IllegalArgumentException("torque must be under 100");

		if (pourcent <= -100)
			throw new IllegalArgumentException("Torque must be over -100");
		
		//conversion en valeur comprehensible pour le moteur et envoi de la commande
		if(Math.abs(pourcent) <= 100){
			com.add(M_TOR);
			com.add(SET_TORQUE + (int)(pourcent/100 * 1023));
			
			mode = Mode.TORQUE;
			send(com);
		}
		
	}

	 
}