/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class CambioPlanTarifDTO implements Serializable
{

	private static final long serialVersionUID = 3933198060615843032L;

	String desPlanTarifOrigen;

	String desPlanTarifDestino;

	String usuario;

	String fechaDesde;
	
	String comentario;

	/**
	 * @return the desPlanTarifDestino
	 */
	public String getDesPlanTarifDestino()
	{
		return desPlanTarifDestino;
	}

	/**
	 * @param desPlanTarifDestino the desPlanTarifDestino to set
	 */
	public void setDesPlanTarifDestino(String desPlanTarifDestino)
	{
		this.desPlanTarifDestino = desPlanTarifDestino;
	}

	/**
	 * @return the desPlanTarifOrigen
	 */
	public String getDesPlanTarifOrigen()
	{
		return desPlanTarifOrigen;
	}

	/**
	 * @param desPlanTarifOrigen the desPlanTarifOrigen to set
	 */
	public void setDesPlanTarifOrigen(String desPlanTarifOrigen)
	{
		this.desPlanTarifOrigen = desPlanTarifOrigen;
	}

	/**
	 * @return the fechaDesde
	 */
	public String getFechaDesde()
	{
		return fechaDesde;
	}

	/**
	 * @param fechaDesde the fechaDesde to set
	 */
	public void setFechaDesde(String fechaDesde)
	{
		this.fechaDesde = fechaDesde;
	}

	/**
	 * @return the usuario
	 */
	public String getUsuario()
	{
		return usuario;
	}

	/**
	 * @param usuario the usuario to set
	 */
	public void setUsuario(String usuario)
	{
		this.usuario = usuario;
	}

	public final String getComentario()
	{
		return comentario;
	}

	public final void setComentario(String comentario)
	{
		this.comentario = comentario;
	}

}
