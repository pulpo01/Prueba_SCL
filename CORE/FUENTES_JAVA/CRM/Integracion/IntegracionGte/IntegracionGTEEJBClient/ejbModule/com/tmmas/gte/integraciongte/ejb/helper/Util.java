package com.tmmas.gte.integraciongte.ejb.helper;

public class Util {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	public boolean esLong(String numero){
		boolean valido = false;
		try {
			  long numeroLong = Long.parseLong(numero);  
			  System.out.println("numeroLong :" + numeroLong);
			  valido = true;
		} catch (Exception e) {
			  valido = false;
		}
		return valido;
	}
	
	public boolean esInt(String numero){
		boolean valido = false;
		try {
			  int numeroInt = Integer.parseInt(numero);  
			  System.out.println("numeroInt :" + numeroInt);
			  valido = true;
		} catch (Exception e) {
			  valido = false;
		}
		return valido; 
	}
	
	public boolean esDouble(String numero){
		boolean valido = false;
		try {
			  double numeroDouble = Double.parseDouble(numero);  
			  System.out.println("numeroDouble :" + numeroDouble);
			  valido = true;
		} catch (Exception e) {
			  valido = false;
		}
		return valido; 
	}
	
	public boolean esFloat(String numero){
		boolean valido = false;
		try {
			  float numeroFloat  = Float.parseFloat(numero);  
			  System.out.println("numeroFloat :" + numeroFloat);
			  valido = true;
		} catch (Exception e) {
			  valido = false;
		}
		return valido; 
	}

	
}
