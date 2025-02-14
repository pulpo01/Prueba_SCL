package com.tmmas.scl.wsseguridad.dto;


import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.bancarios.EjecucionCambioDatosBancariosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.generales.EjecucionCambioDatosGeneralesClienteDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.numeroIdentificacion.EjecucionCambioDatosIdentificacionClienteDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.personales.EjecucionCambioDatosPersonalesClienteDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.tributario.EjecucionCambioDatosTributariosClienteDTO;

/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA. Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile Todos los derechos reservados.
 * 
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA. Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia con los t&eacute;rminos de derechos de
 * licencias que sean adquiridos con TM-mAs.
 * 
 * Fecha ------------------- Autor ------------------------- Cambios ---------- 07/07/2008 Héctor Hermosilla Versión Inicial
 * 
 * 
 * 
 * 
 * @author Héctor Hermosilla
 * @version 1.0
 */

public class EjecucionCambioDatosClienteSACDTO {
	private String comentario;

	/**
	 * 
	 */
	private static final long serialVersionUID = -804588659602338075L;

	private EjecucionCambioDatosGeneralesClienteDTO ejecucionCambioDatosGeneralesClienteDTO;
	private EjecucionCambioDatosPersonalesClienteDTO ejecucionCambioDatosPersonalesClienteDTO;
	private EjecucionCambioDatosTributariosClienteDTO ejecucionCambioDatosTributariosClienteDTO;
	private EjecucionCambioDatosBancariosDTO ejecucionCambioDatosBancariosDTO;
	private EjecucionCambioDatosIdentificacionClienteDTO ejecucionCambioDatosIdentificacionClienteDTO;
	
	private long nroOOSS;
	private String codError;
	private String desError;
	private String numTransaccion;
	private String nomUsuarioSCL;

	public EjecucionCambioDatosBancariosDTO getEjecucionCambioDatosBancariosDTO() {
		return ejecucionCambioDatosBancariosDTO;
	}

	public void setEjecucionCambioDatosBancariosDTO(EjecucionCambioDatosBancariosDTO ejecucionCambioDatosBancariosDTO) {
		this.ejecucionCambioDatosBancariosDTO = ejecucionCambioDatosBancariosDTO;
	}

	public EjecucionCambioDatosGeneralesClienteDTO getEjecucionCambioDatosGeneralesClienteDTO() {
		return ejecucionCambioDatosGeneralesClienteDTO;
	}

	public void setEjecucionCambioDatosGeneralesClienteDTO(EjecucionCambioDatosGeneralesClienteDTO ejecucionCambioDatosGeneralesClienteDTO) {
		this.ejecucionCambioDatosGeneralesClienteDTO = ejecucionCambioDatosGeneralesClienteDTO;
	}

	public EjecucionCambioDatosPersonalesClienteDTO getEjecucionCambioDatosPersonalesClienteDTO() {
		return ejecucionCambioDatosPersonalesClienteDTO;
	}

	public void setEjecucionCambioDatosPersonalesClienteDTO(EjecucionCambioDatosPersonalesClienteDTO ejecucionCambioDatosPersonalesClienteDTO) {
		this.ejecucionCambioDatosPersonalesClienteDTO = ejecucionCambioDatosPersonalesClienteDTO;
	}

	public EjecucionCambioDatosTributariosClienteDTO getEjecucionCambioDatosTributariosClienteDTO() {
		return ejecucionCambioDatosTributariosClienteDTO;
	}

	public void setEjecucionCambioDatosTributariosClienteDTO(EjecucionCambioDatosTributariosClienteDTO ejecucionCambioDatosTributariosClienteDTO) {
		this.ejecucionCambioDatosTributariosClienteDTO = ejecucionCambioDatosTributariosClienteDTO;
	}

	public EjecucionCambioDatosIdentificacionClienteDTO getEjecucionCambioDatosIdentificacionClienteDTO() {
		return ejecucionCambioDatosIdentificacionClienteDTO;
	}

	public void setEjecucionCambioDatosIdentificacionClienteDTO(EjecucionCambioDatosIdentificacionClienteDTO ejecucionCambioDatosIdentificacionClienteDTO) {
		this.ejecucionCambioDatosIdentificacionClienteDTO = ejecucionCambioDatosIdentificacionClienteDTO;
	}

	/**
	 * @return the comentario
	 */
	public String getComentario() {
		return comentario;
	}

	/**
	 * @param comentario 
	 * the comentario to set
	 */
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	public String getCodError() {
		return codError;
	}

	public void setCodError(String codError) {
		this.codError = codError;
	}

	public String getDesError() {
		return desError;
	}

	public void setDesError(String desError) {
		this.desError = desError;
	}

	public String getNomUsuarioSCL() {
		return nomUsuarioSCL;
	}

	public void setNomUsuarioSCL(String nomUsuarioSCL) {
		this.nomUsuarioSCL = nomUsuarioSCL;
	}

	public long getNroOOSS() {
		return nroOOSS;
	}

	public void setNroOOSS(long nroOOSS) {
		this.nroOOSS = nroOOSS;
	}

	public String getNumTransaccion() {
		return numTransaccion;
	}

	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
	}

}
