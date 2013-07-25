package ca.etsmtl.capra.smartmotor;

import java.util.Scanner;


public class MotorUtility {
	
	private static final double RESOLUTION = 4000; //Nombre d'encoder counts du moteur pour un tour complet
	private static final double COUNTS_RPM = 542.29383; //Nombre de counts par seconde par rpm
	private static final double COUNTS_RPS = 32537.628; //Nombre de counts par seconde par rps
	private static final double COUNTS_REVS = 16.15444; //Nombre de counts par sec carre par revoloution par seconde carre (Pour l'acceleration)
	private static final double COUNTS_SEC = 4069; //Nombre de counts pour une seconde d'attente
	private static final double GEAR_RATIO = 40; //GEAR_RATIO tours du moteurs font tourner la roue de 1 tour
	public static final double WHEEL_DIAMETER = 0.305; //Diametre de la roue, EN METRE
	public static final double DISTANCE_PER_COUNT = Math.PI * WHEEL_DIAMETER * ((360/RESOLUTION)/360) /GEAR_RATIO;
	
	/**
	 * Converts from int to boolean. 
	 * @param i the int to use
	 * @return true if i is 1, false otherwise
	 */
	public static boolean intToBool(int i){
		if(i==1)
			return true;
		else
			return false;
	}
	
	//------------------- AFFICHAGE ET INPUT -------------------
	
	//Affichage et recuperation de l'input de l'utilisateur. A modifier si l'application n'est plus en ligne de commande
	public static String recupInput(){
		Scanner clavier = new Scanner(System.in);
		return clavier.next();
	}
	
	public static void affiche(String s){
		System.out.println(s);
	}
	
	//---------------------- CONVERSIONS ----------------------
	
	public static double countsToDegrees(double counts){
		return counts * (360/RESOLUTION) / GEAR_RATIO;
	}
	
	public static double countsToDistance(double counts){
		return DISTANCE_PER_COUNT * counts; 
	}
		
	public static double secToCounts(double sec){
		return sec * COUNTS_SEC;
	}
	
	public static double degreeToCounts(double angle){
		return angle / (360 / RESOLUTION) * GEAR_RATIO;
	}
	
	
	public static int rpmToCounts(double rpm){
		//ajouter conversion en m/s
		return (int)Math.round(rpm * COUNTS_RPM * GEAR_RATIO);
	}
	
	public static double msToRpm(double ms){
		//rpm = (60 * speed) / (PI * Diamtere)
		return (60 * ms) /(WHEEL_DIAMETER * Math.PI);
	}
	
	public static double rpsToCounts(double rps){
		return rps * COUNTS_RPS;
	}
	
	//pour l'accel
	public static int revsToCounts(double revs){ //revs = revolution par seconde au carre
		return (int)(revs * COUNTS_REVS);
	}
	
	//revolution par sec au carre a metre par seconde au carre
	public static double revs2ToMs2(double revs2){
		double w =  revs2 / GEAR_RATIO * WHEEL_DIAMETER * Math.PI;//acceleration angulaire ( w = revs2 * 2 * pi * r)
		double ms2 = w * WHEEL_DIAMETER / 2; //acceleration lineraire (a = w * r)
		return ms2;
	}
	
	public static double ms2ToRevs2(double ms2){
		double w = ms2 / (WHEEL_DIAMETER / 2); // w = a / r
		double revs2 = w / (Math.PI * WHEEL_DIAMETER);
		return revs2;
	}	
}