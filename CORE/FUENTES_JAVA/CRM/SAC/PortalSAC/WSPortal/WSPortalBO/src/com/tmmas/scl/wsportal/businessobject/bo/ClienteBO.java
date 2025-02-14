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

import com.tmmas.scl.wsportal.businessobject.dao.ClienteDAO;
import com.tmmas.scl.wsportal.common.dto.DetalleClienteDTO;
import com.tmmas.scl.wsportal.common.dto.DeudaClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoUmtsAbonadosDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class ClienteBO
{

	public ListadoClientesDTO clientesXCuenta(Long codCuenta) throws PortalSACException
	{
		ClienteDAO clienteDAO = new ClienteDAO();
		return clienteDAO.clientesXCuenta(codCuenta);
	}

	public ListadoClientesDTO clientesXNombre(String nombre) throws PortalSACException
	{
		ClienteDAO clienteDAO = new ClienteDAO();
		return clienteDAO.clientesXNombre(nombre);
	}

	public ListadoClientesDTO clientesXCodCliente(Long codCliente) throws PortalSACException
	{
		ClienteDAO clienteDAO = new ClienteDAO();
		return clienteDAO.clientesXCodCliente(codCliente);
	}

	public DetalleClienteDTO getDetalleCliente(Long codCliente) throws PortalSACException
	{
		ClienteDAO clienteDAO = new ClienteDAO();
		return clienteDAO.getDetalleCliente(codCliente);
	}

	public DeudaClienteDTO getDeudaCliente(Long codCliente) throws PortalSACException
	{
		ClienteDAO clienteDAO = new ClienteDAO();
		return clienteDAO.getDeudaCliente(codCliente);
	}

	public ListadoDocCtaCteClienteDTO getDocsFactCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		ClienteDAO clienteDAO = new ClienteDAO();
		return clienteDAO.getDocsFactCliente(codCliente, fecInicio, fecFin);
	}

	public ListadoDocCtaCteClienteDTO getDocsCtaCteCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		ClienteDAO clienteDAO = new ClienteDAO();
		return clienteDAO.getDocsCtaCteCliente(codCliente, fecInicio, fecFin);
	}

	public ListadoDocCtaCteClienteDTO getDocsPagosCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		ClienteDAO clienteDAO = new ClienteDAO();
		return clienteDAO.getDocsPagosCliente(codCliente, fecInicio, fecFin);
	}

	public ListadoDocCtaCteClienteDTO getDocsAjustesCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		ClienteDAO clienteDAO = new ClienteDAO();
		return clienteDAO.getDocsAjustesCliente(codCliente, fecInicio, fecFin);
	}

	public ListadoUmtsAbonadosDTO umtsAbonadosXCodCliente(Long codCliente) throws PortalSACException
	{
		ClienteDAO dao = new ClienteDAO();
		return dao.umtsAbonadosXCodCliente(codCliente);
	}

}
