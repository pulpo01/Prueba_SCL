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

/**
 * @author mwn40031
 *
 */
public class ParametroDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4796642791154808476L;

	private String codEvento;

	private String nomUsuario;

	public static final String COD_EVENTO = "codEvento";

	public static final String NOM_USUARIO_SCL = "nomUsuarioSCL";

	public ParametroDTO()
	{

	}

	public String toString()
	{
		String toReturn = "";
		toReturn += "getCodEvento [" + this.getCodEvento() + "] - ";
		toReturn += "getNomUsuario [" + this.getNomUsuario() + "] - ";

		for (int i = 0; i < this.listadoEntidadesParametroDTO.length; i++)
		{
			EntidadParametroDTO dto = listadoEntidadesParametroDTO[i];
			toReturn += dto.getTipEntidad() + " [" + dto.getValEntidad() + "] - ";
		}

		return toReturn;
	}

	public ParametroDTO(EntidadParametroDTO[] listadoEntidadesParametroDTO, String nomUsuarioSCL, String codEvento)
	{
		this.codEvento = codEvento;
		this.nomUsuario = nomUsuarioSCL;
		this.listadoEntidadesParametroDTO = listadoEntidadesParametroDTO;
	}

	private EntidadParametroDTO[] listadoEntidadesParametroDTO;

	public void setListadoEntidadesAuditoriaDTO(EntidadParametroDTO[] listadoEntidadesAuditoriaDTO)
	{
		this.listadoEntidadesParametroDTO = listadoEntidadesAuditoriaDTO;
	}

	public EntidadParametroDTO[] getListadoEntidadesAuditoriaDTO()
	{
		return listadoEntidadesParametroDTO;
	}

	public void setNomUsuario(String nomUsuario)
	{
		this.nomUsuario = nomUsuario;
	}

	public String getNomUsuario()
	{
		return nomUsuario;
	}

	public void setCodEvento(String codEvento)
	{
		this.codEvento = codEvento;
	}

	public String getCodEvento()
	{
		return codEvento;
	}
}
