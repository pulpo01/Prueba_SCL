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

import com.tmmas.scl.wsportal.businessobject.dao.LimiteConsumoDAO;
import com.tmmas.scl.wsportal.common.dto.ListadoDetalleLlamadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoLimiteConsumoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoPagosLimiteConsumoDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class LimiteConsumoBO
{

	public ListadoLimiteConsumoDTO limiteConsumoXClienteAbonado(Long codCliente, Long numAbonado)
			throws PortalSACException
	{
		LimiteConsumoDAO limiteConsumoDAO = new LimiteConsumoDAO();
		return limiteConsumoDAO.limiteConsumoXClienteAbonado(codCliente, numAbonado);
	}

	public ListadoPagosLimiteConsumoDTO pagoLimiteConsumoXClienteAbonado(Long codCliente, Long numAbonado)
			throws PortalSACException
	{
		LimiteConsumoDAO limiteConsumoDAO = new LimiteConsumoDAO();
		return limiteConsumoDAO.pagoLimiteConsumoXClienteAbonado(codCliente, numAbonado);
	}

	public ListadoDetalleLlamadosDTO detalleLlamadas(Long codCliente, Long numAbonado, Long codCiclo, String tipoLlamada)
			throws PortalSACException
	{
		LimiteConsumoDAO limiteConsumoDAO = new LimiteConsumoDAO();
		return limiteConsumoDAO.detalleLlamadas(codCliente, numAbonado, codCiclo, tipoLlamada);
	}

}
