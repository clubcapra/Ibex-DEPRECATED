package ca.etsmtl.capra.smartmotor.io;

import java.util.Observable;

import ca.etsmtl.capra.smartmotor.MotorUtility;

public class InputControl extends Observable {

	public static final String[] requests = { "RPA", "RW" };
	public static final String[] extra_requests = { "Rt", "Ri" };
	public static final int READ_DELAY_MILLI = 1;

	private int nbMoteurs;

	private int corrupted = 0;

	private double[] lastStatus;
	private double[] lastEncoderCount;
	private double[] lastTemp;;
	private double[] lastAmp;
	
	private long lastDistanceUpdate = 0;

	private double[] distanceRightLeft = { 0, 0 };
	private double[] lastDistanceRightLeft = { 0, 0 };

	public int getNbMotors() {
		return nbMoteurs;
	}

	public InputControl(int nbMoteurs) {

		this.nbMoteurs = nbMoteurs;

		lastStatus = new double[nbMoteurs];
		lastEncoderCount = new double[nbMoteurs];
		lastTemp = new double[nbMoteurs];
		lastAmp = new double[nbMoteurs];
	}

	/**
	 * Processes a single character to parse the input from the motors
	 * 
	 * @param c
	 *            the character to check
	 */
	public void processInput(String command, String data, long time) {

		String[] motorInfo = new String[nbMoteurs];

		// Filter out everything before the space (reply starts after space
		// char) and take off last char (an End of line kind of thing)
		String content = data.substring(data.indexOf(' ') + 1,
				data.lastIndexOf('\r') + 1);

		// Si les donnes sont corrompues on ne les traite pas
		if (!content.matches("([-]?[0-9]+\\r)+")) {
			corrupted++;
			//Logger.getLogger(this.getClass()).warn(
			//		"Corrupted message received from motors: " + data);
			return;
		}

		// System.out.println("-------------");
		// System.out.println(data);

		// System.out.println("got new reading: " + command.toString());
		String tempData = "";
		int motor = 0;
		for (char c : content.toCharArray()) {

			// \r = fin d'input d'un moteur
			if (c == '\r') {
				motorInfo[motor] = tempData; // on met ce qu'on avait
												// ramasse en memoire
				tempData = "";
				motor++;
			} else {
				tempData += c;
			}
		}

		double[] resultatInt = new double[nbMoteurs]; // pour les resultats
														// de la requete, en
														// int

		// on convertit les donnees String en chiffre
		for (int i = 0; i < nbMoteurs; i++) {

			// Si donnee non lue, on passe au prochain
			if (motorInfo[i] == null)
				continue;

			if (!motorInfo[i].equals("")) {
				try {
					resultatInt[i] = Integer.parseInt(motorInfo[i]);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		// on inverse le tableau vu que les donnees sont retournees a
		// l'envers
		resultatInt = inverseTableau(resultatInt);

		if (command.equals("RPA")) {
			lastEncoderCount = resultatInt;
			updateDistances(time);

			// System.out.println("Time since last pos update(ms): " +
			// (System.currentTimeMillis() - lastTimeRead));
			lastTimeRead = System.currentTimeMillis();
			
		} else if (command.equals("RW")) {
			lastStatus = resultatInt;
		} else if (command.equals("Rt")) {
			lastTemp = resultatInt;
		} else if (command.equals("Ri")) {
			lastAmp = resultatInt;
		}
		
		setChanged();
		notifyObservers(true);
	}

	private long lastTimeRead;

	private double[] inverseTableau(double[] tab) {

		int length = tab.length; // egal typiquement 4
		double tabInv[] = new double[length];
		double a;

		for (int i = 0; i < length; i++) {
			a = tab[i];
			// System.out.println(a);
			tabInv[length - 1 - i] = a; // remplissage de la fin au debut
		}

		return tabInv;
	}

	public double[] getLastTemp() {
		return lastTemp;
	}

	public double[] getLastAmp() {
		return lastAmp;
	}

	public double[] getLastStatus() {
		return lastStatus;
	}

	public double[] getActualEncoderCount() {
		return lastEncoderCount;
	}

	public double[] getWheelDistances() {
		return distanceRightLeft;
	}

	public double[] getLastWheelDistances() {
		return lastDistanceRightLeft;
	}

	public long getLastDistanceUpdate ( )
	{
		return this.lastDistanceUpdate;
	}
	
	private void updateDistances(long time) {

		// pour droite et gauche
		double[] newCountRL = { 0, 0 };

		// moyenne a droite et a gauche
		newCountRL[0] = (lastEncoderCount[0]);
		newCountRL[1] = (lastEncoderCount[nbMoteurs - 1]);

		lastDistanceRightLeft[0] = distanceRightLeft[0];
		lastDistanceRightLeft[1] = distanceRightLeft[1];

		distanceRightLeft[0] = MotorUtility.countsToDistance(newCountRL[0]);
		distanceRightLeft[1] = MotorUtility.countsToDistance(newCountRL[1]);
		
		hasNewPosition = true;
		
		lastDistanceUpdate = time;

		// System.out.println("Right: " + distanceRightLeft[0]);
		// System.out.println("Left: " + distanceRightLeft[1]);
	}

	public void warnNoData() {
		setChanged();
		notifyObservers(false);
	}

	private boolean hasNewPosition = false;

	public boolean hasNewPosition() {

		boolean retVal = hasNewPosition;
		hasNewPosition = false;
		return retVal;
	}
}