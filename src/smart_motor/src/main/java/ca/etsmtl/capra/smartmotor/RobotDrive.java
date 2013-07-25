package ca.etsmtl.capra.smartmotor;

import ca.etsmtl.capra.smartmotor.io.MotorController;

/**
 * Classe qui gere l'utilisation de plusieurs moteurs
 * @author yohan
 *
 */
public class RobotDrive extends AbstractMotor{

	//Facteur de ralentissement lors d'une modification
	//dynamique de l'angle du vehicule
	private static final double FACT_RALENTISSEMENT = 0.4; 

	//changé a la distance d'un cercle tangeant aux deux roues, a tester.
	//Essayer .78 aussi: distance entre centre de deux cercles opposés
	private static final double ROBOT_WIDTH = 0.508;//EN METRES, largeur entre le centre des roues du robot

	private Status status;

	public SmartMotor[] motor;
	private double speed=0;
	public int nbMoteurs;
	public boolean rotating = false;
	public boolean motorsOff = true;
	
	private float globalAccel = 0;
	
	public boolean isTurnedOff(){
		return motorsOff;
	}
	
	public double getRobotWidth(){
		return ROBOT_WIDTH;
	}

	/**
	 * Constructor with the number of motors to use
	 * @param nbMoteurs The number of motors
	 */
	public RobotDrive(int nbMoteurs){

		this.nbMoteurs = nbMoteurs;
		status = new Status(this);

		//motors will range from [1] to [n]
		motor = new SmartMotor[nbMoteurs+1];
		motor[0] = null;

		for(int i = 1; i <= nbMoteurs; i++){
			motor[i] = new SmartMotor(i);
		}

	}

//	@Override
//	public void setSpeed(double speed){
//
//		setSpeedMode();
//		resetFlags();
//
//		for(int i =1; i< motor.length; i++){
//			if(i <= nbMoteurs/2)
//				motor[i].setSpeed(speed);
//			else
//				motor[i].setSpeed(-speed);
//		}
//
//		this.speed = speed;
//		//si le robot roule, on update la vitesse.  Sinon on le part pas.
//		if(moving)
//			start();
//
//	}

	public void start(){

		startMove();

	}
	
	public void setGlobalTorque(int percent){
		setTorque(percent);
	}
	
	public void setGlobalAccel(float a){
		globalAccel = a;
	}
	
	public float getGlobalAccel(){
		return globalAccel;
	}
	
	public void setIndividualSpeed(float rightSpeed, float rightAccel, float leftSpeed, float leftAccel){
		
		for(int i =1; i< motor.length; i++){
			if(i <= nbMoteurs/2){
				motor[i].setSpeed(leftSpeed);
				motor[i].setMotorAccel(leftAccel);
			}
			else{
				motor[i].setSpeed(rightSpeed);
				motor[i].setMotorAccel(rightAccel);
			}
		}
		
	}
	
	public void setPreciseSpeed(int motorNo, float speed){
		
		setSpeedMode();
		motor[motorNo].setSpeedMode();
		motor[motorNo].setMotorAccel(globalAccel);
		motor[motorNo].setSpeed(speed);
		
	}

	public void setRobotSpeed(float speed, float delta){

		if(delta > 2 || delta < 0){
			System.out.println("RobotDrive: error on speed delta");

		}else{

			this.speed = speed;
			setSpeedMode();
			resetFlags();
			
			float leftSpeed = (float) (speed * delta);
			float leftAccel = globalAccel;// * delta;
			
			float rightSpeed = -speed * (2-delta);
			float rightAccel = globalAccel;// * (2-delta);

			setIndividualSpeed(rightSpeed, rightAccel, leftSpeed, leftAccel);

			//si le robot roule, on update la vitesse.  Sinon on le part pas.
			if(moving)
				start();
		}
	}
	
	public void left(){

		setSpeedMode();

		for(int i =1; i< motor.length; i++){
			if(i <= nbMoteurs/2)
				motor[i].setSpeed(speed);
			else
				motor[i].setSpeed(FACT_RALENTISSEMENT * -speed);
		}

		start();

	}

	public void right(){

		setSpeedMode();

		for(int i =1; i< motor.length; i++){
			if(i <= nbMoteurs/2)
				motor[i].setSpeed(FACT_RALENTISSEMENT *speed);
			else
				motor[i].setSpeed(-speed);
		}

		start();

	}
	
	/**
	 * Rotate indefinetely
	 */
	public void rotate(float speed){
		
		setSpeedMode();
		resetFlags();
		setIndividualSpeed(speed, globalAccel, speed, globalAccel);
		start();
		
	}

	public void rotate(double angle){

		double changeDistance = robotAngleToWheelDistance(angle, ROBOT_WIDTH/2); //en degres
		double change = distanceToWheelAngle(changeDistance);

		double[] currentCount =  MotorController.getInstance().getInputControl().getActualEncoderCount();
		double cRight = currentCount[0];
		double cLeft = currentCount[nbMoteurs -1];

		int objectiveCountR = (int)Math.round(cRight + MotorUtility.degreeToCounts(change));
		int objectiveCountL = (int)Math.round(cLeft + MotorUtility.degreeToCounts(change)) ;

		setPosMode();
		speed = DEFAULT_SPEED;

		for(int i =1; i< motor.length; i++){
			if(i <= nbMoteurs/2)
				motor[i].changePosition(MotorUtility.countsToDegrees(objectiveCountR), speed, DEFAULT_ACCEL);
			else
				motor[i].changePosition(MotorUtility.countsToDegrees(objectiveCountL), speed, DEFAULT_ACCEL);
		}

		rotating = true;
		start();
	}

	//conversion d'un angle pour le vehicule a un angle pour le moteur
	public double robotAngleToWheelAngle(double robotAngle, double circleRadius){

		//En lien avec l'arc de cercle que doit parcourir une roue
		double circleCirconference = 2 * circleRadius * Math.PI; // C = 2*pi*r
		double circleFraction = robotAngle/360;  //fraction du cercle a parcourir
		double distance = circleFraction * circleCirconference;  //distance a parcourir, en metres

		//EN lien avec la roue
		double wheelCirconference = Math.PI * MotorUtility.WHEEL_DIAMETER; // C = 2* pi * r
		double revolutions = distance/wheelCirconference;  //nombre de tours necessaires
		double wheelDegreeChange = revolutions * 360; //Transformation du nombre de tours en degres

		//x2 parce que il faut 80 000 counts pour un tour, et non 40 000(2000 * 20) 

		return wheelDegreeChange * 2;

		//ca marchait pas pire avec un X 1.195
	}

	private double robotAngleToWheelDistance(double robotAngle, double circleRadius){
		//En lien avec l'arc de cercle que doit parcourir une roue
		double circleCirconference = 2 * circleRadius * Math.PI; // C = 2*pi*r
		double circleFraction = robotAngle/360;  //fraction du cercle a parcourir
		double distance = circleFraction * circleCirconference;  //distance a parcourir, en metres

		return distance;
	}


	private double distanceToWheelAngle(double distance){
		//EN lien avec la roue
		double wheelCirconference = Math.PI * MotorUtility.WHEEL_DIAMETER; // C = 2* pi * r
		double revolutions = distance/wheelCirconference;  //nombre de tours necessaires
		double wheelDegreeChange = revolutions * 360; //Transformation du nombre de tours en degres

		//x2 parce que il faut 80 000 counts pour un tour, et non 40 000(2000 * 20) 

		return wheelDegreeChange * 2;

		//ca marchait pas pire avec un X 1.195
	}


	public void init(){
		
		MotorController.getInstance().setWaitForEcho(false);
		
		try {
			Thread.sleep(500);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
				
		send(PORT_OPEN + TYPE + CHANNEL + PARITY + BAUD + STOP_BITS + DATA_BITS + MODE + ")"); 
		//Fermer la parenthese dans la commande

		//Reveille tout le monde
		wake();

		setEchoOff();

		//Pour chaque moteur, on envoit l'adresse en diffusion, on allume son ECHO et on le met a SLEEP
		//On passe au prochain
		for(int i = 1; i<=nbMoteurs; i++){
			send(SET_ADDR + i);
			motor[i].setEchoOn();
			motor[i].sleep();
		}

		//Reveille tout le monde
		wake();

		disableLimits();
		resetFlags();
		resetEncoders();
		
		try {
			Thread.sleep(500);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		MotorController.getInstance().setWaitForEcho(true);
	}

	public boolean openPort() {
		boolean success =  MotorController.getInstance().connect(nbMoteurs);;
		MotorController.getInstance().getInputControl().addObserver(status);
		return success;
	}

	public void closePort(){

		 MotorController.getInstance().endThreads();
	}

	@Override
	protected void send(String command){

		String toSendCommand = ADDR_DIFFUSION + command;
		//		System.out.println("RobotDrive: send():\"" + toSendCommand + "\"");
		sendToController(toSendCommand);
	}

	// ------------------------- LECTURE -----------------------

	public double[] getAmps(){
		return status.getAmps();
	}

	public double[] getTemperature(){
		return status.getTemperature();
	}

	public double[] getPosition(){

		//				System.out.println("getting pos");
		return status.getPos();
	}
	
	public double getAccel(){

//		System.out.println("accel = " + accel);
		return globalAccel;
	}
	
	public double getRobotDistance(){
		return status.getRobotDistance();
	}

	public double getTheta(){
		//		System.out.println("RobotDrive: theta: " + robotTheta);
		return status.getRobotTheta();
	}
	
	public long getLastPositionUpdate ( )
	{
		return status.getLastPositionUpdate();
	}
//	
//	public void setThetaBias(double thetaBias){
////		robotTheta = thetaBias;
//		this.thetaBias = thetaBias;
//	}

//	private double thetaBias;
	
	public void resetPosition(){
		resetEncoders();
		status.resetPos();
	}

	

	public String[] getStatus(){
		return status.resultBin;

	}

	//Division des bits dans leurs variables respectives

	//			motor[motorNb].setDriveReady(resultBool[0]);
	//			motor[motorNb].setMotorOff(resultBool[1]);
	//			motor[motorNb].setMoving(resultBool[2]);
	//			motor[motorNb].setVoltageFault(resultBool[3]);
	//			motor[motorNb].setOverCurrent(resultBool[4]);
	//			motor[motorNb].setOverTemp(resultBool[5]);

}