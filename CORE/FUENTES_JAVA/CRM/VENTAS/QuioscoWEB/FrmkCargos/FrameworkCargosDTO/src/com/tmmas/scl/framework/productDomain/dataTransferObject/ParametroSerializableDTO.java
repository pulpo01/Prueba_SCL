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
 * 18/08/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

public class ParametroSerializableDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idProceso;
	private String numProceso;
	private String origenProceso;
	private Date   fecProceso;
	private String estadoProceso;
	//private GenericDTO parametroObject;
	private byte[] objetoSerializado;
	
	public Object[] toStruct_PR_PROCESOS_PROD_TD_QT()
	{
		Object[] obj={	idProceso,
						numProceso,
						origenProceso,
						fecProceso!=null?new Timestamp(fecProceso.getTime()):null,
						estadoProceso						 
					  };		
		return obj;
	}
	
	
	public byte[] getObjetoSerializado() {
		return objetoSerializado;
	}


	public void setObjetoSerializado(byte[] objetoSerializado) {
		this.objetoSerializado = objetoSerializado;
	}


	public ParametroSerializableDTO()
	{
		fecProceso=new Date();
	}
	
	public String getEstadoProceso() {
		return estadoProceso;
	}
	public void setEstadoProceso(String estadoProceso) {
		this.estadoProceso = estadoProceso;
	}
	public Date getFecProceso() {
		return fecProceso;
	}
	public void setFecProceso(Date fecProceso) {
		this.fecProceso = fecProceso;
	}
	public String getIdProceso() {
		return idProceso;
	}
	public void setIdProceso(String idProceso) {
		this.idProceso = idProceso;
	}
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}
	public String getOrigenProceso() {
		return origenProceso;
	}
	public void setOrigenProceso(String origenProceso) {
		this.origenProceso = origenProceso;
	}

	
	
}
