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

import com.tmmas.scl.wsportal.businessobject.dao.OrdenServicioDAO;
import com.tmmas.scl.wsportal.businessobject.dao.UsuarioDAO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesAgendadasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesProcesoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class OrdenServicioBO
{

	public ListadoOrdenesServicioDTO oossEjecutadasXCodCuenta(Long codCuenta) throws PortalSACException
	{
		OrdenServicioDAO oossDAO = new OrdenServicioDAO();
		return oossDAO.oossEjecutadasXCodCuenta(codCuenta);
	}

	public ListadoOrdenesServicioDTO oossEjecutadasXCodCliente(Long codCliente) throws PortalSACException
	{
		OrdenServicioDAO oossDAO = new OrdenServicioDAO();
		return oossDAO.oossEjecutadasXCodCliente(codCliente);
	}

	public ListadoOrdenesServicioDTO oossEjecutadasXNumAbonado(Long numAbonado) throws PortalSACException
	{
		OrdenServicioDAO oossDAO = new OrdenServicioDAO();
		return oossDAO.oossEjecutadasXNumAbonado(numAbonado);
	}
	
	public ListadoOrdenesAgendadasDTO obtenerOoSsAgendadas(Long numDato, Integer tipoDato) throws PortalSACException
	{
		OrdenServicioDAO oossDAO = new OrdenServicioDAO();
		return oossDAO.obtenerOoSsAgendadas(numDato, tipoDato);
	}
	
	public Boolean consultaOoSsProceso(String nomUsuario) throws PortalSACException
	{
		OrdenServicioDAO dao = new OrdenServicioDAO();
		return dao.consultaOoSsProceso(nomUsuario);
	}
	
	public ListadoOrdenesProcesoDTO obtenerOoSsProceso(String nomUsuario) throws PortalSACException
	{
		OrdenServicioDAO oossDAO = new OrdenServicioDAO();
		return oossDAO.obtenerOoSsProceso(nomUsuario);
	}

}
