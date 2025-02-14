package com.tmmas.cl.scl.socketps.bo.helper;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.socketps.common.dto.HeaderPSDTO;
import com.tmmas.cl.scl.socketps.common.dto.RespuestaPSDTO;

public class ParsearSocketPS {
	private final Logger logger = Logger.getLogger(ParsearSocketPS.class);

	private Global global = Global.getInstance();

	public StringBuffer armarComando(HeaderPSDTO header) {
		StringBuffer msg = new StringBuffer();
		String sis = null;
		String usuario = null;
		String os = null;
		String prioridad = null;
		String ttl = null;
		String sep = null;
		String sepIgual = null;
		String orden = null;
		String parNombre[] = null;
		String parValor[] = null;

		String log = global.getValor("bo.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("armarComando():start");

		//Setea el separador del DTO HeaderPSDTO  o de las properties
		if (header.getSeparador() != null)
			sep = header.getSeparador();
		else
			sep = global.getValor("param.separador");
		logger.debug("sep[" + sep + "]");

		//Obtiene el separador entre campo y valor. Ejemplo. =
		sepIgual = global.getValor("param.igual");
		logger.debug("sepIgual[" + sepIgual + "]");

		//Obtiene el sis del DTO HeaderPSDTO o de las properties
		if (header.getSis() != null)
			sis = header.getSis();
		else
			sis = global.getValor("param.sis");
		logger.debug("sis[" + sis + "]");

		//Obtiene el usuario del DTO HeaderPSDTO o de las properties
		if (header.getUsuario() != null)
			usuario = header.getUsuario();
		else
			usuario = global.getValor("param.usr");
		logger.debug("usuario[" + usuario + "]");

		//Obtiene el os del DTO HeaderPSDTO o de las properties
		if (header.getOs() != null)
			os = header.getOs();
		else
			os = global.getValor("param.os");
		logger.debug("os[" + os + "]");

		//Obtiene la prioridad del DTO HeaderPSDTO o de las properties
		if (header.getPrioridad() != null)
			prioridad = header.getPrioridad();
		else
			prioridad = global.getValor("param.prioridad");
		logger.debug("prioridad[" + prioridad + "]");

		//Obtiene el ttl del DTO HeaderPSDTO o de las properties
		if (header.getTtl() != null)
			ttl = header.getTtl();
		else
			ttl = global.getValor("param.ttl");
		logger.debug("ttl[" + ttl + "]");

		//Obtiene la orden
		orden = header.getOrden();
		logger.debug("orden[" + orden + "]");

		//Obtiene el nombre de los parametros de entrada
		parNombre = header.getParametrosNombre();
		
		//Obtiene el valor de los parametros de entrada
		parValor = header.getParametrosValor();
		
		
		//Arma la estructura de parametros campo1=valor1, campo2=valor2,...campon=valorn
		StringBuffer parametros = new StringBuffer();
		if (parNombre != null && parValor != null) {
			parametros.append(sep);
			for (int i = 0; i < parNombre.length; i++) {
				// Crea parametro, parametro = valor
				parametros.append(parNombre[i] + sepIgual + parValor[i]);
				if (i != parNombre.length - 1 ) {
					// Añade el separador, parametro = valor, parametro =
					// valor....
					parametros.append(sep);
				}
			}
		}

		logger.debug("parametros[" + parametros + "]");
		
		//Arma el header del comando hasta el campo orden
		msg.append(sis + sep + usuario + sep + os + sep + prioridad + sep + ttl
				+ sep + orden);

		logger.debug("header[" + msg + "]");

		//Añade a el header del comando los parametros
		msg.append(parametros);

		//Genera el comando
		logger.debug("comando[" + msg + "]");
		logger.debug("armarComando():end");
		return msg;
	}

	public RespuestaPSDTO armarRespuestaEstandar(String str) {
		logger.debug("armarRespuestaEstandar():start");
		// String str = "TICKET=1581550,OS=1002,STATUS=OK,SUBERROR=";
		//Separa los elementos de la tira por "sep",creando un arreglo
		RespuestaPSDTO respuesta = new RespuestaPSDTO();
		String regExpComa = global.getValor("param.separador");
		logger.debug("regExpComa[" + regExpComa + "]");

		String arr[] = Pattern.compile(regExpComa).split(str);

		//Busca el campo TICKET
		String regExpTicket = global.getValor("reg.exp.ticket");
		logger.debug("regExpTicket[" + regExpTicket + "]");
		String valor = buscarMatch(arr, regExpTicket);
		logger.debug("valorTicket[" + valor + "]");
		respuesta.setTicket(valor);

		//Busca el campo OS
		String regExpOs = global.getValor("reg.exp.os");
		logger.debug("regExpOs[" + regExpOs + "]");
		valor = buscarMatch(arr, regExpOs);
		logger.debug("valorOs[" + valor + "]");
		respuesta.setOs(valor);

		//Busca el campo STATUS
		String regExpStatus = global.getValor("reg.exp.status");
		logger.debug("regExpStatus[" + regExpStatus + "]");
		valor = buscarMatch(arr, regExpStatus);
		logger.debug("valorStatus[" + valor + "]");
		respuesta.setStatus(valor);

		//Busca el campo SUBERROR
		String regExpSubError = global.getValor("reg.exp.suberror");
		logger.debug("regExpSubError[" + regExpSubError + "]");
		valor = buscarMatch(arr, regExpSubError);
		logger.debug("valorSubError[" + valor + "]");
		respuesta.setSubError(valor);
		logger.debug("armarRespuestaEstandar():end");
		return respuesta;
	}

	private String buscarMatch(String[] arr, String regExp) {
		logger.debug("buscarMatch():start");
		//OS=1002 STATUS=OK SUBERROR=
		//Suponiendo que cada campo valor esta en arreglo
		//Obtiene el valor asociado para ese campo. El valor del lado derecho despues del signo =
		String valor = "";
		for (int i = 0; i < arr.length; i++) {
			logger.debug("arr[" + i + "]=[" + arr[i] + "]");
			valor = getMatch(arr[i], regExp);
			if (!valor.equalsIgnoreCase("")) break;
		}
		logger.debug("valor[" + valor + "]");
		logger.debug("buscarMatch():end");
		return valor;
	}

	private String getMatch(String str, String regExp) {
		logger.debug("getMatch():start");
		logger.debug("str[" + str + "]");
		//Campo = valor
		//Verifica si el campo matchea con regExp y de ser asi, devuelve
		//el lado derecho, osea, su valor.
		String valor = "";
		Pattern pattern = Pattern.compile(regExp);
		Matcher matchedPattern = pattern.matcher(str);
		while (matchedPattern.find()) {
			logger.debug("Pattern encontrado en start:"
					+ matchedPattern.start() + " end:" + matchedPattern.end());
			logger.debug(str.substring(matchedPattern.start(), matchedPattern
					.end()));
			
			//Procede a realizar split
			String separadorIgual = global.getValor("param.igual");
			String arr[] = str.split(separadorIgual);
			try {
				valor = arr[1];
			} catch (Exception e) {
				logger.debug("Exception:", e);
				valor = " ";
			}
			logger.debug("valor[" + valor + "]");
			break;
		}
		logger.debug("getMatch():end");
		return valor;
	}
	

	
	public String armarRespuestaDetail(String str, String regExp) {
		logger.debug("armarRespuestaDetail():start");
		/**
		>\KVESUBERROR=,STATUS=OK,OS=1002,TICKET=1581552,DETAIL=DATOS\=SALDO\\\=5.8400\,OPER\=saldo\,TIPO\=T1
		**/
		String valor = "";
		String detail = "";
		boolean encontrado = false;
		
		logger.debug("respuesta[" + str + "]");
		//Expresion regular para el servicio
		logger.debug("regExp[" + regExp + "]");
		
		//Separa los elementos de la tira por "sep"
		String regExpComa = global.getValor("param.separador");
		logger.debug("regExpComa[" + regExpComa + "]");
		
		//Crea un arreglo con los elementos
		String arr[] = Pattern.compile(regExpComa).split(str);
		
		String regExpDetail = global.getValor("reg.exp.detail");
		logger.debug("regExpDetail[" + regExpDetail + "]");		
		
		//Realiza la busqueda del campo detail en el arreglo
		for (int i = 0; i < arr.length; i++) {
			logger.debug("arr[" + i + "]=[" + arr[i] + "]");
			encontrado = esMatch(arr[i], regExpDetail);
			if (encontrado) {
				detail = arr[i];
				break;
			}
		}
		//Detail generado. Ejemplos
		//DETAIL=DATOS\=PLAN\\\=BP\
		//DETAIL=DATOS\=SALDO\\\=5.8400\
		logger.debug("detail[" + detail + "]");
		
		logger.debug("regExp[" + regExp + "]");
		//Busca segun patron dentro de detail, ejemplo el saldo, el plan, etc.
		//PLAN\\\=BP
		//SALDO\\\=5.8400
		
		//Obtiene el match de detail. Por ejemplo PLAN\\\=BP
		String match = getEsMatch(detail, regExp);
		
		//Separa el valor del match a buscar dentro de PLAN\\\=BP, esto es, BP
		valor = getMatch(match, regExp);
		
		logger.debug("valor[" + valor + "]");
		logger.debug("armarRespuestaDetail():end");
		return valor;
	}

	
	
	private boolean esMatch(String str, String regExp) {
		logger.debug("esMatch():start");
		boolean respuesta = false;
		Pattern pattern = Pattern.compile(regExp);
		Matcher matchedPattern = pattern.matcher(str);
		while (matchedPattern.find()) {
			logger.debug("Pattern encontrado en start:"
					+ matchedPattern.start() + " end:" + matchedPattern.end());
			String strMatch = str.substring(matchedPattern.start(), matchedPattern
					.end());
			logger.debug("strMatch[" + strMatch + "]");
			respuesta = true;
			break;
		}
		logger.debug("esMatch():end");
		return respuesta;
	}
	
	private String getEsMatch(String str, String regExp) {
		logger.debug("getEsMatch():start");
		String respuesta = "";
		Pattern pattern = Pattern.compile(regExp);
		Matcher matchedPattern = pattern.matcher(str);
		while (matchedPattern.find()) {
			logger.debug("Pattern encontrado en start:"
					+ matchedPattern.start() + " end:" + matchedPattern.end());
			String strMatch = str.substring(matchedPattern.start(), matchedPattern
					.end());
			logger.debug("strMatch[" + strMatch + "]");
			respuesta = strMatch;
			break;
		}
		logger.debug("getEsMatch():end");
		return respuesta;
	}	
	
	private String[] getEsMatchValues(String str, String regExp) {
		logger.debug("getEsMatchValues():start");
		String respuesta = "";
		Pattern pattern = Pattern.compile(regExp);
		Matcher matchedPattern = pattern.matcher(str);
		int i = 0;
		ArrayList lista = new ArrayList();
		while (matchedPattern.find()) {
			logger.debug("Pattern encontrado en start:"
					+ matchedPattern.start() + " end:" + matchedPattern.end());
			String strMatch = str.substring(matchedPattern.start(), matchedPattern
					.end());
			logger.debug("strMatch[" + strMatch + "]");
			
			respuesta = strMatch;
			//No se añade el pattern
			if (i != 0) {
				logger.debug("Añadiendo respuesta[" + respuesta + "]");
				lista.add(respuesta);
			}else {
				logger.debug("No se añade el patron[" + regExp + "]");
			}
			i++;
		}
		String[] listaStr = (String[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), String.class);
		logger.debug("getEsMatchValues():end");
		return listaStr;
	}
	
	
	public String[] armarRespuestaValues(String str, String regExp) {
		logger.debug("armarRespuestaValues():start");
		/**
		>\KVESUBERROR=,STATUS=OK,OS=1002,TICKET=1581553,DETAIL=DATOS\=NUM_ITEMS\\\=1\\\,HAY_MAS\\\=0083\,OPER\=frecuente\,TABLA\=NAMES\\\=CODLISTA\\\\\\\,CODHAB\\\\\\\,MAXITEM\\\,VALUES\\\=LI01\\\\\\\\\\\\\\\,LI01\\\\\\\\\\\\\\\,5\\\\\\\,\\\,__sd_type\\\=TBL\\\,__sd_type_i\\\=TAA\,TIPO\=T1
		**/
		String valores[] = null;
		String values = "";
		boolean encontrado = false;
		
		logger.debug("respuesta[" + str + "]");
		//Expresion regular para el servicio
		logger.debug("regExp[" + regExp + "]");
		
		//Separa los elementos de la tira por "sep"
		String regExpComa = global.getValor("param.separador");
		logger.debug("regExpComa[" + regExpComa + "]");
		
		//Crea un arreglo con los elementos
		String arr[] = Pattern.compile(regExpComa).split(str);
		
		String regExpValues = global.getValor("reg.exp.values");
		logger.debug("regExpValues[" + regExpValues + "]");		
		
		//Realiza la busqueda del campo values en el arreglo
		for (int i = 0; i < arr.length; i++) {
			logger.debug("arr[" + i + "]=[" + arr[i] + "]");
			encontrado = esMatch(arr[i], regExpValues);
			if (encontrado) {
				values = arr[i];
				break;
			}
		}
		//Valor generado. Ejemplos
		//VALUES\\\=LI01\\\\\\\\\\\\\\\
		logger.debug("values[" + values + "]");
		
		logger.debug("regExp[" + regExp + "]");
		//Busca segun patron dentro de lista, ejemplo
		//LI01
		
		//Obtiene el match de la lista. Por ejemplo LI01
		valores = getEsMatchValues(values, regExp);
		logger.debug("armarRespuestaValues():end");
		return valores;
	}	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
