package ca.etsmtl.capra.smartmotor.io;
import gnu.io.SerialPort;

import java.io.IOException;

import ca.etsmtl.capra.serialmanager.PortDealer;
import ca.etsmtl.capra.serialmanager.SerialConnection;
import ca.etsmtl.capra.serialmanager.SerialDevices;


public class MotorController implements SerialConnection {

	private InputControl inputControl;
	private SerialCom serialCom;
	
	private SerialPort serialPort;

	//Singleton
	private static MotorController instance;
	private MotorController(){
	}
	
	public static MotorController getInstance(){
		if(instance == null)
			instance = new MotorController();
		
		return instance;
	}

	public void endThreads(){
		serialCom.stop();
		
		disconnect();
	}

	public void write(String command){
		serialCom.write(command);
	}
	
	double[] newCountRL = {0,0};

	@Override
	public SerialDevices getDeviceType() {
		return SerialDevices.MOTORS;
	}	
	
	public void setWaitForEcho(boolean val){
		serialCom.setWaitForEcho(val);
	}

	public boolean connect(int nbMotors){
		
		inputControl = new InputControl(nbMotors);
		serialCom = new SerialCom(inputControl);
		
		try {
			serialPort = PortDealer.getInstance().requestPort(this);
		} catch (IOException e1) {
			e1.printStackTrace();
			return false;
		}

		if(serialPort == null)
			return false;

		serialCom.connect(serialPort);
		Thread threadRequests = new Thread(serialCom);
		threadRequests.start();
	
		return true;
	}

	public void disconnect(){
		try {
			PortDealer.getInstance().requestDisconnect(this);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public InputControl getInputControl(){
		return inputControl;
	}

}