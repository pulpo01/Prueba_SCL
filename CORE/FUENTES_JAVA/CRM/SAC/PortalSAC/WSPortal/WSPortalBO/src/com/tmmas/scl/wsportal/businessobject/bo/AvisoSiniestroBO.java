package com.tmmas.scl.wsportal.businessobject.bo;

import com.tmmas.scl.wsportal.businessobject.dao.AvisoSiniestroDAO;
import com.tmmas.scl.wsportal.common.dto.ListadoCausasSiniestroDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoTiposSiniestroDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoTiposSuspensionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class AvisoSiniestroBO
{
	public ListadoTiposSuspensionDTO consultaTiposSuspension() throws PortalSACException
	{
		AvisoSiniestroDAO dao = new AvisoSiniestroDAO();
		return dao.consultaTiposSuspension();
	}
	
	public ListadoTiposSiniestroDTO consultaTiposSiniestro() throws PortalSACException
	{
		AvisoSiniestroDAO dao = new AvisoSiniestroDAO();
		return dao.consultaTiposSiniestro();
	}
	
	public ListadoCausasSiniestroDTO consultaCausasSiniestro() throws PortalSACException
	{
		AvisoSiniestroDAO dao = new AvisoSiniestroDAO();
		return dao.consultaCausasSiniestro();
	}

}
