package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces;

import javax.ejb.SessionContext;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.ContenedorPlanesAdicionalesDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;

public interface ContratacionProductoSrvOrcIF 
{
	public RetornoDTO activarProductoContratado(OfertaComercialDTO ofertaComercial) throws IssCusOrdException;
	public RetornoDTO anulacionVenta(VentaDTO venta) throws IssCusOrdException;
	public RetornoDTO descontratarOfertaComercial(ProductoContratadoListDTO prodList) throws IssCusOrdException;
	public RetornoDTO descontratarOfertaComercialPorVenta(VentaDTO venta) throws IssCusOrdException;
	public RetornoDTO ejecutarMantencionPlanesAdicionales(ContenedorPlanesAdicionalesDTO contenedorPlanes) throws IssCusOrdException;
	public void setContext(SessionContext context);
}
