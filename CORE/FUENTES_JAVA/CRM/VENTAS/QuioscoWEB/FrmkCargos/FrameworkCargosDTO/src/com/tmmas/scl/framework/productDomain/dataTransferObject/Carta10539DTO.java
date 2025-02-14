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

public class Carta10539DTO extends CartaGeneralDTO{
	private static final long serialVersionUID = 1L;
	private static final String NOMBRE_STRUCT = "GE_CARTA_10539_QT";
	private String desPlanTarif;
	private String codPlanTarif;
	private String cargoFijo;
	private String numCelular;
	
	public String getNombreStruct() {
		return NOMBRE_STRUCT;
	}

	public Object[] toStruct() {
		Object[] obj={ desPlanTarif,
				codPlanTarif,
				cargoFijo,
				numCelular,
				getCodOOSS(),
				getTexCarta()
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

	public String getCargoFijo() {
		return cargoFijo;
	}

	public void setCargoFijo(String cargoFijo) {
		this.cargoFijo = cargoFijo;
	}

	public String getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
}
