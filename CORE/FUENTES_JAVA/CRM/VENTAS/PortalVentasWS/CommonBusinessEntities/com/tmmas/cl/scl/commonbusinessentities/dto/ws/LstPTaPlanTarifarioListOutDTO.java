package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;
import java.util.Date;


public class LstPTaPlanTarifarioListOutDTO implements Serializable{
	private static final long serialVersionUID = 1L;

	private String numSol;
	private LstPTaPlanTarifarioOutDTO allLstPTaPlanTarifarioOutDTO[];
	private Long codError;
	private String msgError;
	private Long codEvento;
	private String NombreCliente;
	private String Apellido1;
	private String Apellido2;
	private String nomUsuarioEvaluacion;
	private Long montoLimite;
	private Date FecIngresoSolicitud;
	
	
	
	

		/**
	 * @return the montoLimite
	 */
	public Long getMontoLimite() {
		return montoLimite;
	}

	/**
	 * @param montoLimite the montoLimite to set
	 */
	public void setMontoLimite(Long montoLimite) {
		this.montoLimite = montoLimite;
	}

		/**
	 * @return the nomUsuarioEvaluacion
	 */
	public String getNomUsuarioEvaluacion() {
		return nomUsuarioEvaluacion;
	}

	/**
	 * @param nomUsuarioEvaluacion the nomUsuarioEvaluacion to set
	 */
	public void setNomUsuarioEvaluacion(String nomUsuarioEvaluacion) {
		this.nomUsuarioEvaluacion = nomUsuarioEvaluacion;
	}

	public String getApellido1() {
		return Apellido1;
	}

	public void setApellido1(String apellido1) {
		Apellido1 = apellido1;
	}

	public String getApellido2() {
		return Apellido2;
	}

	public void setApellido2(String apellido2) {
		Apellido2 = apellido2;
	}

	public String getNombreCliente() {
		return NombreCliente;
	}

	public void setNombreCliente(String nombreCliente) {
		NombreCliente = nombreCliente;
	}

	public String getNumSol() {
		return numSol;
	}

	public void setNumSol(String numSol) {
		this.numSol = numSol;
	}

	public LstPTaPlanTarifarioOutDTO[] getallLstPTaPlanTarifarioOutDTO() {
		return allLstPTaPlanTarifarioOutDTO;
	}

	public void setallLstPTaPlanTarifarioOutDTO(LstPTaPlanTarifarioOutDTO iAllLstPTaPlanTarifarioOutDTO[]) {
		this.allLstPTaPlanTarifarioOutDTO = iAllLstPTaPlanTarifarioOutDTO;
	}
	
	public Long getCodEvento() {
		return codEvento;
	}

	public void setCodEvento(Long codEvento) {
		this.codEvento = codEvento;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public Long getCodError() {
		return codError;
	}
	public void setCodError(Long codError) {
		this.codError = codError;
	}

	/**
	 * @return the fecIngresoSolicitud
	 */
	public Date getFecIngresoSolicitud() {
		return FecIngresoSolicitud;
	}

	/**
	 * @param fecIngresoSolicitud the fecIngresoSolicitud to set
	 */
	public void setFecIngresoSolicitud(Date fecIngresoSolicitud) {
		FecIngresoSolicitud = fecIngresoSolicitud;
	}	
	
}//fin class LstPTaPlanTarifarioOutDTO