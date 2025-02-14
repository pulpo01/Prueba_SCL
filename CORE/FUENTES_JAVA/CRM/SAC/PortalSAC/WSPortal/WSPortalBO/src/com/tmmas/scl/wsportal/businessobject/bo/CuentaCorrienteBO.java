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

import com.tmmas.scl.wsportal.businessobject.dao.CuentaCorrienteDAO;
import com.tmmas.scl.wsportal.common.dto.ListadoCuentasCorrientesDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class CuentaCorrienteBO
{

	public ListadoCuentasCorrientesDTO ccXCodCliente(Long codCliente) throws PortalSACException
	{
		CuentaCorrienteDAO ccDAO = new CuentaCorrienteDAO();
		return ccDAO.ccXCodCliente(codCliente);
	}

}
