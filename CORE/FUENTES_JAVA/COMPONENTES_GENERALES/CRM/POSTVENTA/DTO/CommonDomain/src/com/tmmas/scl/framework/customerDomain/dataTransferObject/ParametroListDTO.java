/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/08/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ParametroListDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private ParametroDTO[] parametros;

	public ParametroDTO[] getParametros() {
		return parametros;
	}

	public void setParametros(ParametroDTO[] parametros) {
		this.parametros = parametros;
	}
	
	public ParametroDTO obtieneParametro(String nomParametro){
		ParametroDTO parametro = null;
		int largo = 0;
		if (parametros != null) largo = parametros.length;
		
		for(int i=0; i<largo; i++){
			if (parametros[i].getNomParametro().equalsIgnoreCase(nomParametro)){
				parametro = parametros[i];
				break;
			}
		}
		
		return parametro;
	}
}
