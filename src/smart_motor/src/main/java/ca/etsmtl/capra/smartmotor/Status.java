package ca.etsmtl.capra.smartmotor;

import java.util.Observable;
import java.util.Observer;

import ca.etsmtl.capra.smartmotor.io.MotorController;

public class Status implements Observer{

	RobotDrive drive;
	
	String resultBin[] = new String[4];
	char[] status;
	
	private double thetaAjustment = 0;
	private double robotDistance;
	
	private double[] temperature;
	private double[] amps;
	double[] pos = {0,0};
	private double robotTheta;
	private long lastPositionUpdate = System.currentTimeMillis();
	
	public Status(RobotDrive robotDrive){
		
		this.drive = robotDrive;
		
		amps = new double[robotDrive.nbMoteurs];
		temperature = new double[robotDrive.nbMoteurs];
		
	}

	@Override
	public void update(Observable o, Object arg) {

		//			System.out.println("Status updated");

		double[] result =  MotorController.getInstance().getInputControl().getLastStatus();

		if((Boolean)arg == false){

			drive.init();
			drive.motorsOff = true;
		}else if(drive.motorsOff){
			drive.motorsOff = false;
			System.out.println("SmartMotor: Status: Connexion moteurs etablie");
		}

		for(int motorNb =0; motorNb < drive.nbMoteurs; motorNb++){

			//Transformation du int en String de 010
			resultBin[motorNb] = Integer.toBinaryString((int)result[motorNb]);

			//Separation du String de 010 en un tableau de char
			char[] resultBinArray = resultBin[motorNb].toCharArray();

			//Conversion en un tableau de boolean
			boolean[] resultBool = new boolean[resultBinArray.length];

			for(int bit = 0; bit < resultBinArray.length; bit++){
				if(resultBinArray[bit] == '0')
					resultBool[bit] = false;
				else
					resultBool[bit] = true;
			}

			manageFlags(motorNb, resultBinArray);

		}

		managePosition();
		manageTemp();
		manageAmp();

		//			System.out.println("Distance : " + getPosition());

	}

	private void manageTemp() {
		temperature =  MotorController.getInstance().getInputControl().getLastTemp();
	}

	private void manageAmp() {
		amps =  MotorController.getInstance().getInputControl().getLastAmp();
	}

	private void managePosition() {
		
		double[] distRL =  MotorController.getInstance().getInputControl().getWheelDistances();
		double[] lastDistRL =  MotorController.getInstance().getInputControl().getLastWheelDistances();
		
		if(distRL[0] != 0)
		{	
			if ( distRL[0] != lastDistRL[0] && distRL[1] != lastDistRL[1])
			{
				//If no new data, do not do anything
				if(!MotorController.getInstance().getInputControl().hasNewPosition()){
					return;
				}
	
				lastPositionUpdate = MotorController.getInstance().getInputControl().getLastDistanceUpdate();
				robotTheta = (distRL[1] + distRL[0]) / drive.getRobotWidth();
				robotTheta += thetaAjustment;

	
				while(robotTheta >= (2*Math.PI))
					robotTheta -= (2*Math.PI);
	
				while(robotTheta < 0)
					robotTheta += (2*Math.PI);
	
				double distanceIncrement = (-(distRL[1] - lastDistRL[1]) + (distRL[0] - lastDistRL[0])) / 2.0d;
				
				robotDistance += distanceIncrement;
				
//				System.out.println(distRL[1] + "\t" + lastDistRL[1] + "\t" + distRL[0] + "\t" + lastDistRL[0] + "\t" + robotDistance);
				
	//							System.out.println(robotDistance);
				//				System.out.println(robotTheta);
	
				pos[0] += distanceIncrement * Math.cos(robotTheta);
				pos[1] += distanceIncrement * Math.sin(robotTheta);
	
	//			lastReadPos = distRL;
//				System.out.println("X: "+ pos[0] + "   Y: " + pos[1] );
			}
		}else
			thetaAjustment = robotTheta;

		//			System.out.println("X:" + pos[0]);
		//			System.out.println("Y:" + pos[1]);


		//			System.out.println("robotDistance: " + robotDistance);
		//			System.out.println("robotTheta: " + robotTheta);

		//			System.out.println("right: " + distRL[0]);
		//			System.out.println("left: " + distRL[1]);
		//			System.out.println("RobotDrive: theta: "+ robotTheta);
		//			getTheta();


	}

	private void manageFlags(int motor, char[] status){

		this.status = status;

		if(status.length < 2)
			drive.moving = false;

		//			System.out.println("managing flags");s
		for(int flag = 0; flag < status.length; flag ++){
			//								System.out.println(status[flag]);

			if(status[flag] == '1'){
				printFlag(motor, flag);
			}

		}

	}

	private void printFlag(int motor, int flag){


		//						System.out.println("Printing flags");
		String msg = "";

		switch(flag){
		case 0: 
			//					msg = "drive ready";
			break;
		case 1: 
			//				msg = "motor off";
			break;
		case 2:
			//					msg = "moving";
			drive.moving = true;
			break;
		case 3:
			msg = "voltage fault";
			break;
		case 4: 
			msg = "over current";
			break;
		case 5: 
			msg = "excessive pos";
//			setAbsoluteSpeed4(0, 0.5);
			break;
		case 6:
			msg = "excessive pos";
			break;
		case 7: 
			msg = "speed limit";
			break;
		}

		if(!msg.equals("")){
			//Logger.getLogger(getClass()).warn("Flag on motor " + motor + ": " + msg + ".");
			//System.out.println("Flag on motor " + motor + ": " + msg + ".");
			drive.resetFlags();
		}

	}

	public double[] getAmps() {
		return amps;
	}

	public double[] getTemperature() {
		return temperature;
	}
	
	public double[] getPos(){
		return pos;
	}
	
	public void resetPos(){
		for(int i=0; i< pos.length; i++){
			pos[i] = 0;
		}
	}

	public double getRobotTheta() {
		return robotTheta;
	}

	public double getRobotDistance(){
		return robotDistance;
	}
	
	public long getLastPositionUpdate ( )
	{
		return this.lastPositionUpdate;
	}

}