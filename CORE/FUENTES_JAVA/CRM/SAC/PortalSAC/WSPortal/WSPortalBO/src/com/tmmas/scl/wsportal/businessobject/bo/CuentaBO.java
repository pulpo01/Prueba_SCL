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

import com.tmmas.scl.wsportal.businessobject.dao.CuentaDAO;
import com.tmmas.scl.wsportal.common.dto.DetalleCuentaDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class CuentaBO
{

	public ListadoCuentasDTO cuentasXCodigo(Long codCuenta) throws PortalSACException
	{
		CuentaDAO cuentaDAO = new CuentaDAO();
		return cuentaDAO.cuentasXCodigo(codCuenta);
	}

	public ListadoCuentasDTO cuentasXNombre(String descCuenta) throws PortalSACException
	{
		CuentaDAO cuentaDAO = new CuentaDAO();
		return cuentaDAO.cuentasXNombre(descCuenta);
	}

	public ListadoCuentasDTO cuentasXNumIdent(String numIdent) throws PortalSACException
	{
		CuentaDAO cuentaDAO = new CuentaDAO();
		return cuentaDAO.cuentasXNumIdent(numIdent);
	}

	public DetalleCuentaDTO getDetalleCuenta(Long codCuenta) throws PortalSACException
	{
		CuentaDAO cuentaDAO = new CuentaDAO();
		return cuentaDAO.getDetalleCuenta(codCuenta);
	}

}
