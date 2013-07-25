package ca.etsmtl.capra.smartmotor.io;

import gnu.io.SerialPort;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.concurrent.atomic.AtomicBoolean;

public class SerialCom implements Runnable {

	public static final int ECHO_TIMEOUT = 50; // time in ms to wait for echo
												// before skipping data
	
	public static final int ROBOT_TIMEOUT = 500; // time in ms to wait before
													// considering robot is
													// offline
	
	public static final int EXTRA_INFO_DELAY = 5000; // time in ms to wait
														// between requests of
														// temperature and
														// current

	private OutputStream outStream;
	private InputStream inStream;
	private SerialPort serialPort;

	private AtomicBoolean finished = new AtomicBoolean();
	private long lastInputTime;

	private InputControl inputControl;

	public SerialCom(InputControl inputControl) {
		this.inputControl = inputControl;
	}

	public void write(String command) {
		innerWrite(command);
	}

	private boolean waitForEcho = false;

	public void setWaitForEcho(boolean val) {
		// System.out.println("settting echo to " + val);
		waitForEcho = val;
	}

	@Override
	public void run() {
		System.out.println("SmartMotor: Writer started.");
		finished.set(false);
		long lastRequestTime = -1;
		long lastExtraRequestTime = -1;

		while (!finished.get()) {

			if ((System.currentTimeMillis() - lastRequestTime >= InputControl.READ_DELAY_MILLI || lastRequestTime == -1)
					&& waitForEcho) {

				sendRequests();
				lastRequestTime = System.currentTimeMillis();
			} else {
				try {
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}

			if ((System.currentTimeMillis() - lastExtraRequestTime >= EXTRA_INFO_DELAY || lastExtraRequestTime == -1)
					&& waitForEcho) {

				sendExtraRequests();
				lastExtraRequestTime = System.currentTimeMillis();
			}
		}
	}

	public void sendRequests() {
		char start = 0x80;
		char end = 0x20;

		for (String command : InputControl.requests) {
			innerWrite(start + command + end);
		}
	}

	public void sendExtraRequests() {
		char start = 0x80;
		char end = 0x20;

		for (String command : InputControl.extra_requests) {
			innerWrite(start + command + end);
		}
	}

	private synchronized void innerWrite(String command) {
		// Envoi de la commande
		// System.out.println("Writing :" + command);

		try {
			outStream.write(command.getBytes());
			outStream.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}

		// si c'est une de requete
		for (String request : InputControl.requests) {
			if (command.contains(request)) {
				waitForEcho(command);
			}
		}
		
		// si c'est une de requete
		for (String request : InputControl.extra_requests) {
			if (command.contains(request)) {
				waitForEcho(command);
			}
		}
	}

	private String waitForEcho(String awaitedData) {
		// System.out.println(awaitedData);

		StringBuffer stringBuffer = new StringBuffer();
		int motor = 0;

		int readByte = 0;
		byte[] readBuffer = new byte[400]; // Pour lire le buffer du port serie

		boolean gotEcho = false;
		String data;

		String awaitedString = alphaOnly(awaitedData);

		boolean awaitingInput = false;
		long startEchoTime = System.currentTimeMillis();
		while (!gotEcho) {

			int availableBytes = 0;
			try {
				availableBytes = inStream.available();

				if (availableBytes > 0) {
					readByte = inStream.read(readBuffer);
					lastInputTime = System.currentTimeMillis();
				} else {
					try {
						Thread.sleep(0, 500);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}

			} catch (IOException e1) {

				System.out
						.println("MotorDebugger: SerialCom: unable to read from port "
								+ serialPort.getName()
								+ ".  Restart probably required");
			}

			// S'il y a de l'info disponible
			if (availableBytes > 0) {
				// on passe l'info, un charactere a la fois
				for (int i = 0; i < readByte; i++) {

					// On convertit la donnee en char
					char c = (char) readBuffer[i];
					stringBuffer.append(c);

					data = stringBuffer.toString();

					// Si c'Est la f«in d'une commande
					// if (c >= 65000) {
					if (c == ' ') {

						// Si c'est la bonne commande
						if (data.contains(awaitedString)) {
							// si c'est un retour de requete
							for (String request : InputControl.requests) {
								if (awaitedString.contains(request)) {
									awaitingInput = true;
									stringBuffer.delete(0,
											stringBuffer.length());
								}
							}
							
							for (String request : InputControl.extra_requests) {
								if (awaitedString.contains(request)) {
									awaitingInput = true;
									stringBuffer.delete(0,
											stringBuffer.length());
								}
							}

							// Si ce n'est pas un retour de requete
							if (awaitingInput == false) {
								gotEcho = true;
								// System.out.println("Got echo for command:"
								// + awaitedString);
							}

						} else { // Si c'est pas la bonne commande
							stringBuffer.delete(0, stringBuffer.length());
						}
					}

					// Si on est en mode de reception
					if (awaitingInput == true && c == '\r') {
						if (motor >= inputControl.getNbMotors() - 1) {
							// System.out.println("Got full input:"
							// + awaitedString);
							gotEcho = true;
							awaitingInput = false;
							inputControl.processInput(awaitedString, data, startEchoTime);
							stringBuffer.delete(0, stringBuffer.length());

						} else {
							motor++;
						}
					}
				}
			}

			if (System.currentTimeMillis() - startEchoTime > ECHO_TIMEOUT) {
				gotEcho = true;
				// TODO add timeout log here
				// System.out.println("SerialCom timed out waiting for " +
				// awaitedString);
			}

			if (System.currentTimeMillis() - lastInputTime > ROBOT_TIMEOUT) {
				inputControl.warnNoData();
			}
		}

		return stringBuffer.toString();
	}

	public String alphaOnly(String in) {
		StringBuffer sb = new StringBuffer();
		for (char c : in.toCharArray()) {
			if (Character.isLetter(c))
				sb.append(c);
		}
		return sb.toString();
	}

	public void connect(SerialPort port) {
		serialPort = port;

		try {
			outStream = serialPort.getOutputStream();
			inStream = serialPort.getInputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void stop() {
		finished.set(true);
		try {
			Thread.sleep(100);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		}
		try {
			inStream.close();
			outStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}