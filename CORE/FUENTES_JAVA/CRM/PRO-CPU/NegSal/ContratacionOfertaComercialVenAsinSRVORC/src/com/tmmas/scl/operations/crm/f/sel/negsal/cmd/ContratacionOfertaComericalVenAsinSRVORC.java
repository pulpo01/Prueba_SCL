package com.tmmas.scl.operations.crm.f.sel.negsal.cmd;

import java.rmi.RemoteException;

import javax.ejb.CreateException;

import org.apache.commons.lang.SerializationUtils;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.processmgr.AsyncProcessParameterObject;
import com.tmmas.cl.framework.processmgr.AsyncProcessResponseObject;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.soa.bean.ejb.session.IssCusOrdORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.soa.bean.ejb.session.IssCusOrdORCHome;
import com.tmmas.scl.operations.crm.f.sel.negsal.cmd.helper.Global;
import com.tmmas.scl.operations.crm.f.sel.negsal.cmd.orc.VentaAsincronaCmdORC;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;

public class ContratacionOfertaComericalVenAsinSRVORC extends VentaAsincronaCmdORC
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	transient static Logger cat = Logger.getLogger(ContratacionOfertaComericalVenAsinSRVORC.class);
	transient private AsyncProcessParameterObject parametros = null;

	
	public ContratacionOfertaComericalVenAsinSRVORC() {
		// TODO Auto-generated constructor stub
	}

	public ContratacionOfertaComericalVenAsinSRVORC(AsyncProcessParameterObject value) {
		super(value);		
	}

	
	public void ejecutarVenta(OfertaComercialDTO ofertaComercial) throws NegSalException 
	{
		cat.debug("ejecutarVenta():start");		
		RetornoDTO retorno= null;		
		
		try
		{		
			cat.debug("AQUI DEBE EJECUTAR PROCESO");
			retorno = this.getIssCusOrdORC().activarProductoContratado(ofertaComercial);
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IssCusOrdException[" + loge + "]");
			
			ParametroSerializableDTO param=new ParametroSerializableDTO();
			param.setEstadoProceso("ERROR");
			param.setNumProceso(ofertaComercial.getNumProceso());
			param.setIdProceso(ofertaComercial.getNumEvento());		
			param.setObjetoSerializado((byte[])SerializationUtils.serialize(ofertaComercial));	
			param.setOrigenProceso(ofertaComercial.getOrigenProceso());
			try {
				retorno=getSupOrdHanFacade().inscribeProceso(param);
				System.out.print("");
			} 
			catch(Exception e1) 
			{
				throw new NegSalException(e1);		
			}
			
			throw new NegSalException(e);
		}		
		
		cat.debug("ejecutarVenta():end");	
	
	}
	
	//----------------------------------------------------------------------------------------------
	private SupOrdHanFacade getSupOrdHanFacade() throws NegSalException 
	{
		Global global = Global.getInstance();
		
		cat.debug("getSupOrdHanFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");
		
		SupOrdHanFacadeHome supOrdHanFacadeHome = null;
		String jndi = global.getValor("jndi.SupOrdHanFacade");
		cat.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.SupOrdHanProvider");
		cat.debug("Url provider[" + url + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");
		
		try 
		{
			supOrdHanFacadeHome = (SupOrdHanFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,
							jndi, securityPrincipal, securityCredentials, SupOrdHanFacadeHome.class);
		} catch (ServiceLocatorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new NegSalException(e);
		}
		
		cat.debug("Recuperada interfaz home de Close Customer Order Order Facade...");
		SupOrdHanFacade supOrdHanFacade = null;
		try {
			supOrdHanFacade = supOrdHanFacadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");
		
			throw new NegSalException(e);
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new NegSalException(e);
		}
		
		cat.debug("getSupOrdHanFacade():end");
		return supOrdHanFacade;
	}	
	//----------------------------------------------------------------------------------------------
	
	private IssCusOrdORC getIssCusOrdORC() throws NegSalException {
		Global global = Global.getInstance();
		
		cat.debug("getIssCusOrdORC():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");
		
		IssCusOrdORCHome issCusOrdORCHome = null;
		String jndi = global.getValor("jndi.IssCusOrdORC");
		cat.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.IssCusOrdORCProvider");
		cat.debug("Url provider[" + url + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");
		
		try 
		{
			issCusOrdORCHome = (IssCusOrdORCHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,
							jndi, securityPrincipal, securityCredentials, IssCusOrdORCHome.class);
		} catch (ServiceLocatorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new NegSalException(e);
		}
		
		cat.debug("Recuperada interfaz home de Close Customer Order Order Facade...");
		IssCusOrdORC issCusOrdORC = null;
		try {
			issCusOrdORC = issCusOrdORCHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");
		
			throw new NegSalException(e);
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new NegSalException(e);
		}
		
		cat.debug("getIssCusOrdORC():end");
		return issCusOrdORC;
	}	
	
	public void onInit() throws GeneralException {
		cat.debug("onInit():start");
		
		OfertaComercialDTO ofertaComercialDTO;
		
		setRollBackManual(false);
		
		// Recupero el parametro
		parametros = getArguments();
		
		cat.debug("parametros:   "+parametros);
		
		ofertaComercialDTO = (OfertaComercialDTO)parametros.getArgumentsData();
		
		cat.debug("ofertaComercialDTO.getProductoList().toString():   "+ofertaComercialDTO.getProductoList().toString());
		
		cat.debug("onInit():end");
	
	}
	
	public AsyncProcessResponseObject start() throws GeneralException {
		cat.debug("start():start");
		
		OfertaComercialDTO ofertaComercialDTO;
		
		try {
			// Recupero el parametro
			parametros = getArguments();
			ofertaComercialDTO = (OfertaComercialDTO)parametros.getArgumentsData();
			
			cat.debug("se procede a ejecutar proceso");
			this.ejecutarVenta(ofertaComercialDTO);
			cat.debug("Proceso terminó satisfactoriamente");
		} catch (Exception e) {
			cat.debug("Error, se procede a ejecutar rollback");
			throw new GeneralException("A ocurrido un error al ejecutar la venta", e); 
		}
		
		return null;
	}

	public void ejecutarAnulacionVenta(VentaDTO venta) throws NegSalException {
		// TODO Auto-generated method stub
		
	}

	public void ejecutarDescontratar(ProductoContratadoListDTO productoContratado) throws NegSalException {
		// TODO Auto-generated method stub
		
	}

	public void ejecutarDescontratarVenta(VentaDTO venta) throws NegSalException {
		// TODO Auto-generated method stub
		
	}	
	

}
