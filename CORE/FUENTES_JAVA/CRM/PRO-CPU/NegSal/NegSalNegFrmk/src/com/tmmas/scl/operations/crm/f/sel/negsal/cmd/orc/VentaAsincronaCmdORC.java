package com.tmmas.scl.operations.crm.f.sel.negsal.cmd.orc;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.processmgr.AsyncProcessParameterObject;
import com.tmmas.cl.framework.processmgr.AsyncProcessResponseObject;
import com.tmmas.cl.framework.processmgr.GenericCommandObject;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;

public abstract class VentaAsincronaCmdORC extends GenericCommandObject
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	transient static Logger cat = Logger.getLogger(VentaAsincronaCmdORC.class);
	
	public VentaAsincronaCmdORC()
	{
		
	}
	
	public VentaAsincronaCmdORC(AsyncProcessParameterObject param)
	{
		super(param);
	}
	
	
	public void onInit() throws GeneralException {
		cat.debug("onInit():start");
		cat.debug("onInit():end");
	}
	
	public void onFault() throws GeneralException {
		cat.debug("onFault():start");
		cat.debug("onFault():end");
    }
	
	public void onClose() throws GeneralException {
		cat.debug("onClose():start");
		cat.debug("onClose():end");
	}
	
	public AsyncProcessResponseObject start() throws GeneralException {
		cat.debug("start():start");	
		
		return null;
	}	

	public abstract void ejecutarVenta(OfertaComercialDTO ofertaComercial) throws NegSalException;	
	public abstract void ejecutarAnulacionVenta(VentaDTO venta) throws NegSalException;
	public abstract void ejecutarDescontratar(ProductoContratadoListDTO productoContratado) throws NegSalException;
	public abstract void ejecutarDescontratarVenta(VentaDTO venta) throws NegSalException;
	
}
