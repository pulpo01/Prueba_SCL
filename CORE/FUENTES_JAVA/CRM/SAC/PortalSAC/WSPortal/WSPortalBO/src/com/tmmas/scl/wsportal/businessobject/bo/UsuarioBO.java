/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.businessobject.bo;

import com.tmmas.scl.wsportal.businessobject.dao.UsuarioDAO;
import com.tmmas.scl.wsportal.common.dto.ListadoConsultasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoGruposDTO;
import com.tmmas.scl.wsportal.common.dto.MenuDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class UsuarioBO
{
	public MenuDTO cargaValidaOSUsuario(String nombreUsuario) throws PortalSACException
	{
		UsuarioDAO validacionUsuarioDAO = new UsuarioDAO();
		return validacionUsuarioDAO.cargaValidaOSUsuario(nombreUsuario);
	}

	public ListadoGruposDTO gruposXNomUsuario(String nomUsuario) throws PortalSACException
	{
		UsuarioDAO dao = new UsuarioDAO();
		return dao.gruposXNomUsuario(nomUsuario);
	}
	
	public Boolean esPrimerLogin(String nomUsuario) throws PortalSACException
	{
		UsuarioDAO dao = new UsuarioDAO();
		return dao.esPrimerLogin(nomUsuario);
	}

	public ListadoConsultasDTO consultasXCodGrupo(String codGrupo, String codPrograma, String numVersion)
			throws PortalSACException
	{
		UsuarioDAO dao = new UsuarioDAO();
		return dao.consultasXCodGrupo(codGrupo, codPrograma, numVersion);
	}
}