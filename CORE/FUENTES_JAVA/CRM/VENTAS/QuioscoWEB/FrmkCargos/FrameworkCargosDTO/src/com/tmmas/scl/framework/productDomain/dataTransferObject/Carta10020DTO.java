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
 * 03/09/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.sql.Timestamp;
import java.util.Date;

public class Carta10020DTO extends CartaGeneralDTO{
	private static final long serialVersionUID = 1L;
	private static final String NOMBRE_STRUCT = "GE_CARTA_10020_QT";
	private String codPlanTarif;
	private String desPlanTarif;
	private Date fecCiclo;
	private String numUnidades; //NUMBER (14,4) EN BD
	
	
	public String getNombreStruct() {
		return NOMBRE_STRUCT;
	}

	public Object[] toStruct() {
		Object[] obj={	getCodOOSS(),
				getTexCarta(),
				codPlanTarif,
				desPlanTarif,
				fecCiclo!=null?new Timestamp(fecCiclo.getTime()):null,
				numUnidades
			 };
		return obj;
	}

	public String getCodPlanTarif() {
		return codPlanTarif;
	}

	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}

	public String getDesPlanTarif() {
		return desPlanTarif;
	}

	public void setDesPlanTarif(String desPlanTarif) {
		this.desPlanTarif = desPlanTarif;
	}

	public Date getFecCiclo() {
		return fecCiclo;
	}

	public void setFecCiclo(Date fecCiclo) {
		this.fecCiclo = fecCiclo;
	}


	public String getNumUnidades() {
		return numUnidades;
	}

	public void setNumUnidades(String numUnidades) {
		this.numUnidades = numUnidades;
	}
}
