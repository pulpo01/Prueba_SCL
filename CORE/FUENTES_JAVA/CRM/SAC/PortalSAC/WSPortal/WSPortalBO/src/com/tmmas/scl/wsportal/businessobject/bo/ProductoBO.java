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

import com.tmmas.scl.wsportal.businessobject.dao.ProductoDAO;
import com.tmmas.scl.wsportal.common.dto.DetallePlanTarifarioDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCambiosPlanTarifDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoNumerosFrecuentesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class ProductoBO
{

	public ListadoCambiosPlanTarifDTO cambiosPlanCliente(Long numOS) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.cambiosPlanCliente(numOS);
	}

	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPospago(Long numOS) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.cambiosPlanAbonadoPospago(numOS);
	}
	
	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPrepago(Long numOS) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.cambiosPlanAbonadoPrepago(numOS);
	}
	
	public DetallePlanTarifarioDTO detallePlanTarifario(String codPlanTarifario) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.detallePlanTarifario(codPlanTarifario);
	}

	public ListadoNumerosFrecuentesDTO numerosFrecuentesXPlan(Long numAbonado) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.numerosFrecuentesXPlan(numAbonado);
	}

	public ListadoProductosDTO planesXCodCliente(Long codCliente) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.planesXCodCliente(codCliente);
	}

	public ListadoProductosDTO planesXNumAbonado(Long numAbonado) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.planesXNumAbonado(numAbonado);
	}

	public ListadoProductosDTO productosXCodCliente(Long codCliente) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.productosXCodCliente(codCliente);
	}

	public ListadoProductosDTO productosXNumAbonado(Long numAbonado) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.productosXNumAbonado(numAbonado);
	}
	
	public ListadoProductosDTO ssXCodCliente(Long codCliente) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.ssXCodCliente(codCliente);
	}

	public ListadoServSuplementariosDTO ssXDefectoXCodCliente(Long codCliente) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.ssXDefectoXCodCliente(codCliente);
	}

	public ListadoServSuplementariosDTO ssXDefectoXNumAbonado(Long numAbonado) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.ssXDefectoXNumAbonado(numAbonado);
	}

	public ListadoProductosDTO ssXNumAbonado(Long numAbonado) throws PortalSACException
	{
		ProductoDAO dao = new ProductoDAO();
		return dao.ssXNumAbonado(numAbonado);
	}

}