package com.tmmas.scl.operations.crm.bean.ejb.helper;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;

public class TokenSingleton implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private static final int SEGUNDOS_SIN_PROPERTIES = 60;
	private int SEGUNDOS_PROPERTIES;
	private static TokenSingleton instance = null;
	private Map tokens = null;
	private Global global=Global.getInstance();
	private String segundosToken = "";

	private TokenSingleton(){
		this.segundosToken = global.getValor("duracion.validacion.token");
		tokens = null;
		tokens = new TreeMap();
	}

	/*
	 * Borra los tokens que hayan expirado en tiempo
	 */
	private void purgaTokens(){
		Map tokens2 = new TreeMap();
		Set s = this.tokens.keySet();
		Iterator it = s.iterator();
		Calendar calendario = Calendar.getInstance();
		Date fechaActual =  new Date();
		calendario.setTime(fechaActual);
		//int segundos;
		try{
			this.SEGUNDOS_PROPERTIES = Integer.parseInt(segundosToken);
		}
		catch (Exception e) {
			this.SEGUNDOS_PROPERTIES = SEGUNDOS_SIN_PROPERTIES;
		}
		calendario.add(Calendar.SECOND, - this.SEGUNDOS_PROPERTIES);
		fechaActual = calendario.getTime();

		
		
		while (it.hasNext()){
			String aux = (String)it.next();
			Date valor = (Date) this.tokens.get(aux);
			if (valor.after(fechaActual)){
				tokens2.put(aux, valor);
			}
		}
		this.tokens.clear();
		this.tokens = tokens2;
	}

	public static synchronized TokenSingleton getInstance(){
		if (TokenSingleton.instance == null){
			TokenSingleton.instance = new TokenSingleton();
		}
		return TokenSingleton.instance;
	}

	/*
	 * Agrega el token al mapa
	 */
	public String getToken(String numAbonado, String codigoOOSS){
		SimpleDateFormat formato = new SimpleDateFormat("ddMMyyyyHHmmss");
		Date ahora = new Date();
		String timestamp = formato.format(ahora);

		this.tokens.put(numAbonado+"-"+codigoOOSS, ahora);

		return numAbonado+"-"+codigoOOSS+"-"+timestamp;
	}

	/*
	 * Valida que el token exista en el mapa
	 */
	public RetornoDTO validaToken(String numAbonado,String codigoOOSS, String token){
		this.purgaTokens();
		Date valor = (Date) this.tokens.get(numAbonado+"-"+codigoOOSS);
		SimpleDateFormat formato = new SimpleDateFormat("ddMMyyyyHHmmss");
		RetornoDTO retorno = new RetornoDTO();
		if (valor == null){
			retorno.setCodigo("-1");
			retorno.setDescripcion("La validación de abonado no existe o expiró");
		}
		else{
			String timeTokens = formato.format(valor);
			if (token.startsWith(numAbonado+"-"+codigoOOSS)){
				String timestamp = token.replaceFirst(numAbonado+"-"+codigoOOSS+"-", "");


				if (timeTokens.equalsIgnoreCase(timestamp)){
					retorno.setCodigo("0");
					retorno.setDescripcion("OK");
				}
				else{
					retorno.setCodigo("-1");
					retorno.setDescripcion("El token no es correcto");
				}				
			}
			else{
				retorno.setCodigo("-1");
				retorno.setDescripcion("El token no corresponde al abonado");
			}
		}
		return retorno;
	}


}
