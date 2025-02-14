package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc;

import java.rmi.RemoteException;
import java.util.Date;

import javax.ejb.CreateException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PaqueteContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.PerfilProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.ProductoTasacionContratadoListDTO;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.bean.ejb.session.AppPriDisRebFacade;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.bean.ejb.session.AppPriDisRebFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.isscusord.bean.ejb.session.IssCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.isscusord.bean.ejb.session.IssCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.ContratacionProductoSrvOrcIF;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.ContenedorPlanesAdicionalesDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacade;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacadeHome;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacadeHome;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session.ManCusInvFacade;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session.ManCusInvFacadeHome;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;
import com.tmmas.scl.operations.rmo.rp.issresord.bean.ejb.session.IssResOrdFacade;
import com.tmmas.scl.operations.rmo.rp.issresord.bean.ejb.session.IssResOrdFacadeHome;
import com.tmmas.scl.operations.rmo.rsar.manresinv.bean.ejb.session.ManResInvFacade;
import com.tmmas.scl.operations.rmo.rsar.manresinv.bean.ejb.session.ManResInvFacadeHome;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.bean.ejb.session.IssSerOrdFacade;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.bean.ejb.session.IssSerOrdFacadeHome;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;

public class ContratacionProductoSrvOrc implements ContratacionProductoSrvOrcIF
{
	transient static Logger cat = Logger.getLogger(ContratacionProductoSrvOrc.class);
	SessionContext context;
	
	public RetornoDTO activarProductoContratado(OfertaComercialDTO ofertaComercial) throws IssCusOrdException {
		cat.debug("activarProductoContratado():start");		
		RetornoDTO retornoPrincipal= new RetornoDTO();
		
		ProductoContratadoListDTO prodList= ofertaComercial.getProductoList()!=null?ofertaComercial.getProductoList():null;
		PaqueteContratadoListDTO paqueteList= ofertaComercial.getPaqueteList()!=null?ofertaComercial.getPaqueteList():null;
		ProductoTasacionContratadoListDTO prodTasConList= ofertaComercial.getListaProductoTasCon()!=null?ofertaComercial.getListaProductoTasCon():null;
		PerfilProvisionamientoListDTO perfilProvList=ofertaComercial.getListaPerfilProv()!=null?ofertaComercial.getListaPerfilProv():null;		
		CargoOcasionalListDTO cargosOc=ofertaComercial.getCargoOcasionalList()!=null?ofertaComercial.getCargoOcasionalList():null;
		CargoRecurrenteListDTO cargosReq=ofertaComercial.getCargoRecurrenteList()!=null?ofertaComercial.getCargoRecurrenteList():null;
		LimiteConsumoPlanAdicionalListDTO listaLimitesDeConsumo=ofertaComercial.getListaLimitesDeConsumo()!=null?ofertaComercial.getListaLimitesDeConsumo():null;
		
		ParametroSerializableDTO param=new ParametroSerializableDTO();		
		param.setNumProceso(ofertaComercial.getNumProceso());
		param.setIdProceso(ofertaComercial.getNumEvento());
		param.setOrigenProceso(ofertaComercial.getOrigenProceso());
		
		cat.debug("activarProductoContratado() NumProceso : [" + param.getNumProceso() + "]");
		cat.debug("activarProductoContratado() IdProceso: [" + param.getIdProceso() + "]");
		cat.debug("activarProductoContratado() OrigenProceso: [" + param.getOrigenProceso()+ "]");
		
		try
		{			
			param.setEstadoProceso("EN PROCESO");
			RetornoDTO editEstadoProceso=this.getSupOrdHanFacade().inscribeProceso(param);
			if(editEstadoProceso!=null && "0".equals(editEstadoProceso.getCodigo()))
			{
				cat.debug("getIssCusOrdFacade().activarProductoContratado:inicio");
				this.getIssCusOrdFacade().activarProductoContratado(prodList);
				cat.debug("getIssCusOrdFacade().activarProductoContratado:fin");
				cat.debug("getIssCusOrdFacade().activarPaqueteContratado:inicio");
				this.getIssCusOrdFacade().activarPaqueteContratado(paqueteList);
				cat.debug("getIssCusOrdFacade().activarPaqueteContratado:fin");
				cat.debug("getIssSerOrdFacade().informarProductoTasacionContratado:inicio");
				this.getIssSerOrdFacade().informarProductoTasacionContratado(prodTasConList);
				cat.debug("getIssSerOrdFacade().informarProductoTasacionContratado:fin");
				cat.debug("getIssResOrdFacade().informarPerfilProvisionamiento:inicio");
				this.getIssResOrdFacade().informarPerfilProvisionamiento(perfilProvList);
				cat.debug("getIssResOrdFacade().informarPerfilProvisionamiento:fin");
				cat.debug("getAppPriDisRebFacade().informarCargosOcasionales:inicio");
				this.getAppPriDisRebFacade().informarCargosOcasionales(cargosOc);
				cat.debug("getAppPriDisRebFacade().informarCargosOcasionales:fin");
				cat.debug("getAppPriDisRebFacade().informarCargosRecurrentes:inicio");
				this.getAppPriDisRebFacade().informarCargosRecurrentes(cargosReq);
				cat.debug("getAppPriDisRebFacade().informarCargosRecurrentes:fin");
				
				//Limite de Consumo
				cat.debug("getManCusInvFacade().informarLC:inicio");
				this.getManCusInvFacade().informarLC(listaLimitesDeConsumo);
				cat.debug("getManCusInvFacade().informarLC:fin");
				
				//envio de correo pv 120410
				cat.debug("getIssCusOrdFacade().enviarCorreo:inicio");
				this.getIssCusOrdFacade().enviarCorreo(prodList);
				cat.debug("getIssCusOrdFacade().enviarCorreo:fin");
			}
			else 
			{
				throw new IssCusOrdException("No se logro establecer el estado del proceso");
			}
			param.setEstadoProceso("PROCESADO");
			editEstadoProceso=this.getSupOrdHanFacade().inscribeProceso(param);		
		
		} catch (GeneralException e) {
			cat.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch(Exception e)
		{			
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}			
		cat.debug("activarProductoContratado():end");	
		return retornoPrincipal;
	}
	
	/**
	 * 
	 * @param prodList
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.	 
	 * @throws IssCusOrdException 
	 */	
	public RetornoDTO descontratarOfertaComercial(ProductoContratadoListDTO prodList) throws IssCusOrdException {
		cat.debug("descontratarOfertaComercial():start");		
		RetornoDTO retornoPrincipal= new RetornoDTO();
		ParametroSerializableDTO param=new ParametroSerializableDTO();
		boolean salir=false;
		
		if(prodList.getProductosContratadosDTO().length>0)
		{					
			param.setNumProceso(prodList.getProductosContratadosDTO()[0].getNumProceso());
			param.setIdProceso(prodList.getNumEvento());
			param.setOrigenProceso(prodList.getProductosContratadosDTO()[0].getOrigenProceso());
			cat.debug("descontratarOfertaComercial() NumProceso : [" + param.getNumProceso() + "]");
			cat.debug("descontratarOfertaComercial() IdProceso: [" + param.getIdProceso() + "]");
			cat.debug("descontratarOfertaComercial() OrigenProceso: [" + param.getOrigenProceso()+ "]");
		}
		else
		{
			salir=true;
		}		
		try
		{	
			if(!salir)
			{	
				param.setEstadoProceso("EN PROCESO");
				RetornoDTO editEstadoProceso=this.getSupOrdHanFacade().inscribeProceso(param);
				if(editEstadoProceso!=null && "0".equals(editEstadoProceso.getCodigo()))
				{
					cat.debug("getAppPriDisRebFacade().descontratarCargosRecurrentes:inicio [Planes Adicionales]");
					retornoPrincipal = this.getAppPriDisRebFacade().descontratarCargosRecurrentes(prodList);
					cat.debug("getAppPriDisRebFacade().descontratarCargosRecurrentes:fin [Planes Adicionales]");
					cat.debug("getIssResOrdFacade().informarPerfilProvisionamiento:inicio [Planes Adicionales]");
					retornoPrincipal = this.getIssResOrdFacade().informarPerfilProvisionamiento(prodList);
					cat.debug("getIssResOrdFacade().informarPerfilProvisionamiento:fin [Planes Adicionales]");
					cat.debug("getIssSerOrdFacade().desactivarProductoTasacionContratado:inicio [Planes Adicionales]");
					retornoPrincipal = this.getIssSerOrdFacade().desactivarProductoTasacionContratado(prodList);
					cat.debug("getIssSerOrdFacade().desactivarProductoTasacionContratado:fin [Planes Adicionales]");
					cat.debug("getIssCusOrdFacade().descontratarProductoContratado:inicio [Planes Adicionales]");
					retornoPrincipal = this.getIssCusOrdFacade().descontratarProductoContratado(prodList);
					cat.debug("getIssCusOrdFacade().descontratarProductoContratado:fin [Planes Adicionales]");
					
//					Limite de Consumo
					cat.debug("getManCusInvFacade().informarLC:inicio");
					this.getManCusInvFacade().actualizarLC(prodList);
					cat.debug("getManCusInvFacade().informarLC:fin");
				}
				else 
				{
					throw new Exception("No se pudo establecer el numero de proceso");
				}
			}
			else
			{
				throw new Exception("La lista de productos contratados viene vacia");
			}		
		} catch (GeneralException e) {
			cat.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}		
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("descontratarOfertaComercial():end");	
		return retornoPrincipal;
	}
	
	
	
	/**
	 * 
	 * @param venta
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.	 
	 * @throws IssCusOrdException 
	 */
	public RetornoDTO anulacionVenta(VentaDTO venta) throws IssCusOrdException {
		cat.debug("activarProductoContratado():start");		
		RetornoDTO retornoPrincipal= new RetornoDTO();	
		
		ProductoContratadoListDTO listaProductos=null;
		
		ParametroSerializableDTO param=new ParametroSerializableDTO();		
		param.setNumProceso(venta.getIdVenta());		
		param.setIdProceso(venta.getNumEvento());
		param.setOrigenProceso(venta.getOrigenProceso());
		
		try
		{			
			param.setEstadoProceso("EN PROCESO");
			RetornoDTO editEstadoProceso=this.getSupOrdHanFacade().inscribeProceso(param);
			if(editEstadoProceso!=null && "0".equals(editEstadoProceso.getCodigo()))
			{
				listaProductos = this.getIssCusOrdFacade().obtenerProductosContratadosVenta(venta);
				for(int i=0;i<listaProductos.getProductosContratadosDTO().length;i++)
				{
					listaProductos.getProductosContratadosDTO()[i].setFechaTerminoVigencia(new Date());
					listaProductos.getProductosContratadosDTO()[i].setNombreUsuario(venta.getNomUsuaOra());//301208
				}
				retornoPrincipal= this.getIssResOrdFacade().eliminarPerfilProvisionamiento(listaProductos);
				retornoPrincipal= this.getIssSerOrdFacade().eliminarProductoTasacionContratado(listaProductos);
				retornoPrincipal= this.getAppPriDisRebFacade().eliminarCargosFacturados(listaProductos);//finalizarCF(lPs)301208
				retornoPrincipal= this.getIssCusOrdFacade().desactivarProductoContratado(listaProductos);
			}
			else 
			{
				throw new IssCusOrdException("No se logro establecer el estado del proceso");
			}
			param.setEstadoProceso("PROCESADO");
			editEstadoProceso=this.getSupOrdHanFacade().inscribeProceso(param);		
			
		} catch (GeneralException e) {
			cat.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}		
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("activarProductoContratado():end");	
		return retornoPrincipal;
	}
	
	/**
	 * 
	 * @param venta
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.	 
	 * @throws IssCusOrdException 
	 */	
	public RetornoDTO descontratarOfertaComercialPorVenta(VentaDTO venta) throws IssCusOrdException {
		cat.debug("descontratarOfertaComercial():start");		
		RetornoDTO retornoPrincipal = new RetornoDTO();
		ProductoContratadoListDTO listaProductos = null;
		
		ParametroSerializableDTO param=new ParametroSerializableDTO();		
		param.setNumProceso(venta.getIdVenta());
		param.setIdProceso(venta.getNumEvento());
		param.setOrigenProceso(venta.getOrigenProceso());
		
		try
		{	
			
			param.setEstadoProceso("EN PROCESO");
			RetornoDTO editEstadoProceso=this.getSupOrdHanFacade().inscribeProceso(param);
			if(editEstadoProceso!=null && "0".equals(editEstadoProceso.getCodigo()))
			{
				listaProductos = this.getIssCusOrdFacade().obtenerProductosContratadosVenta(venta);
				
				for(int i=0;i<listaProductos.getProductosContratadosDTO().length;i++)
				{
					listaProductos.getProductosContratadosDTO()[i].setOrigenProcesoDescontrata(venta.getOrigenProceso());
					listaProductos.getProductosContratadosDTO()[i].setNumProcesoDescontrata(venta.getIdVenta());
					listaProductos.getProductosContratadosDTO()[i].setFechaProcesoDescontrata(new Date());	
					listaProductos.getProductosContratadosDTO()[i].setFechaTerminoVigencia(new Date());
					listaProductos.getProductosContratadosDTO()[i].setNombreUsuario(venta.getNomUsuaOra());//301208
				}				
				retornoPrincipal = this.getIssSerOrdFacade().desactivarProductoTasacionContratado(listaProductos);
				retornoPrincipal = this.getAppPriDisRebFacade().descontratarCargosRecurrentes(listaProductos);
				retornoPrincipal = this.getIssResOrdFacade().informarPerfilProvisionamiento(listaProductos);
				retornoPrincipal = this.getIssCusOrdFacade().descontratarProductoContratado(listaProductos);
			}
			else 
			{
				throw new IssCusOrdException("No se logro establecer el estado del proceso");
			}
			param.setEstadoProceso("PROCESADO");
			editEstadoProceso=this.getSupOrdHanFacade().inscribeProceso(param);		
			
		} catch (GeneralException e) {
			cat.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}		
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("descontratarOfertaComercial():end");	
		return retornoPrincipal;
		
		}
//	-----------------------------------------------------------------------------------------------------------
	
	public RetornoDTO ejecutarMantencionPlanesAdicionales(ContenedorPlanesAdicionalesDTO contenedorPlanes) throws IssCusOrdException
	{
		cat.debug("ejecutarMantencionPlanesAdicionales:start");
		RetornoDTO retorno=null;		
		try
		{
			if(contenedorPlanes == null)
			{
				cat.debug("ContratacionProductoSrvOrc ejecutarMantencionPlanesAdicionales: contenedorPlanes = null");
			}
			
			if(contenedorPlanes.getListaProductosDescontratar() != null && 
			   contenedorPlanes.getListaProductosDescontratar().getProductosContratadosDTO() != null &&				
			   contenedorPlanes.getListaProductosDescontratar().getProductosContratadosDTO().length>0)
			{
				cat.debug("descontratarOfertaComercial:inicio");
				this.descontratarOfertaComercial(contenedorPlanes.getListaProductosDescontratar());
				cat.debug("descontratarOfertaComercial:fin");
			}
			else{
				cat.debug("ContratacionProductoSrvOrc ejecutarMantencionPlanesAdicionales: contenedorPlanes.getListaProductosDescontratar() = null o lista vacia");
			}
			
			if(contenedorPlanes.getOfComercialContratar() != null)
			{
				cat.debug("activarProductoContratado:inicio");
				this.activarProductoContratado(contenedorPlanes.getOfComercialContratar());
				cat.debug("activarProductoContratado:fin");
			}
			else{
				cat.debug("ContratacionProductoSrvOrc ejecutarMantencionPlanesAdicionales: contenedorPlanes.getOfComercialContratar() = null");
			}
			
			if(contenedorPlanes.getAbonadosADesbenificiar() != null && 
					contenedorPlanes.getAbonadosADesbenificiar().getAbonadoBeneficiarioList() != null &&
					contenedorPlanes.getAbonadosADesbenificiar().getAbonadoBeneficiarioList().length>0)
			{
				cat.debug("caducaEliminaAbonadoBeneficiario:inicio");
				this.getManConFacade().caducaEliminaAbonadoBeneficiario(contenedorPlanes.getAbonadosADesbenificiar());
				cat.debug("caducaEliminaAbonadoBeneficiario:fin");
			}
			else{
				cat.debug("ContratacionProductoSrvOrc ejecutarMantencionPlanesAdicionales: contenedorPlanes.getAbonadosADesbenificiar() = null o lista vacia");
			}

			// FALTA UNA LLAMADA PARA ELIMINAR ABONADOS VETADOS			
		} catch (GeneralException e) {
			cat.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch(Exception e)
		{
			cat.debug("Exception en ejecutarMantencionPlanesAdicionales: "+StackTraceUtl.getStackTrace(e));
			throw new IssCusOrdException(e);
		}			
		cat.debug("ejecutarMantencionPlanesAdicionales:end");
		return retorno;
	}
//	-----------------------------------------------------------------------------------------------------------	
	private IssCusOrdFacade getIssCusOrdFacade() throws IssCusOrdException 
	{
		Global global = Global.getInstance();		
		cat.debug("getIssCusOrdFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");		
		IssCusOrdFacadeHome issCusOrdFacadeHome = null;
		String jndi = global.getValor("jndi.IssCusOrdFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.IssCusOrdProvider");
		cat.debug("Url provider[" + url + "]");		
		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			issCusOrdFacadeHome = (IssCusOrdFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, IssCusOrdFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de Iss Customer Order Facade...");
		IssCusOrdFacade issCusOrdFacade = null;
		try 
		{
			issCusOrdFacade = issCusOrdFacadeHome.create();
			//issCusOrdFacade.setSessionContext(this.context);
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e); 
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getIssCusOrdFacade():end");
		return issCusOrdFacade;
	}
//	-----------------------------------------------------------------------------------------------------------	
	private ManCusInvFacade getManCusInvFacade() throws ManCusInvException 
	{
		Global global = Global.getInstance();		
		cat.debug("getManCusInvFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");		
		ManCusInvFacadeHome manCusInvFacadeHome = null;
		String jndi = global.getValor("jndi.ManCusInvFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.ManCusInvProvider");
		cat.debug("Url provider[" + url + "]");		
		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			manCusInvFacadeHome = (ManCusInvFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, ManCusInvFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new ManCusInvException(e);
		}		
		cat.debug("Recuperada interfaz home de ManCusInvFacade...");
		ManCusInvFacade manCusInvFacade = null;
		try 
		{
			manCusInvFacade = manCusInvFacadeHome.create();
			//issCusOrdFacade.setSessionContext(this.context);
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e); 
			cat.debug("CreateException[" + loge + "]");		
			throw new ManCusInvException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new ManCusInvException(e);
		}		
		cat.debug("getManCusInvFacade():end");
		return manCusInvFacade;
	}	
//	-----------------------------------------------------------------------------------------------------------	
	private IssSerOrdFacade getIssSerOrdFacade() throws IssCusOrdException 
	{
		Global global = Global.getInstance();		
		cat.debug("getIssSerOrdFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");
		
		IssSerOrdFacadeHome issSerOrdFacadeHome = null;
		
		String jndi = global.getValor("jndi.IssSerOrdFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.IssSerOrdProvider");
		cat.debug("Url provider[" + url + "]");		
		
		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			issSerOrdFacadeHome = (IssSerOrdFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, IssSerOrdFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de Iss Ser Order Facade...");
		IssSerOrdFacade issSerOrdFacade = null;
		
		try 
		{
			issSerOrdFacade = issSerOrdFacadeHome.create();
		//	issSerOrdFacade.setSessionContext(this.context);
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getIssSerOrdFacade():end");
		return issSerOrdFacade;
	}
//-----------------------------------------------------------------------------------------------------------
	private IssResOrdFacade getIssResOrdFacade() throws IssCusOrdException 
	{
		Global global = Global.getInstance();		
		cat.debug("getIssResOrdFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");
		
		IssResOrdFacadeHome issResOrdFacadeHome = null;
		
		String jndi = global.getValor("jndi.IssResOrdFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.IssResOrdProvider");
		cat.debug("Url provider[" + url + "]");		
		
		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			issResOrdFacadeHome = (IssResOrdFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, IssResOrdFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de Iss Res Order Facade...");
		IssResOrdFacade IssResOrdFacade = null;
		
		try 
		{
			IssResOrdFacade = issResOrdFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getIssResOrdFacade():end");
		return IssResOrdFacade;
	}
//	-----------------------------------------------------------------------------------------------------------
	
	private ManResInvFacade getManResInvFacade() throws IssCusOrdException 
	{
		Global global = Global.getInstance();		
		cat.debug("getManResInvFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");
		
		ManResInvFacadeHome manResInvFacadeHome = null;
		
		String jndi = global.getValor("jndi.ManResInvFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.ManResInvProvider");
		cat.debug("Url provider[" + url + "]");		
		
		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			manResInvFacadeHome = (ManResInvFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, ManResInvFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de Man Res Inv Facade...");
		ManResInvFacade manResInvFacade = null;
		
		try 
		{
			manResInvFacade = manResInvFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getManResInvFacade():end");
		return manResInvFacade;
	}
//	-----------------------------------------------------------------------------------------------------------
	
	private AppPriDisRebFacade getAppPriDisRebFacade() throws IssCusOrdException 
	{
		Global global = Global.getInstance();		
		cat.debug("getAppPriDisRebFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");
		
		AppPriDisRebFacadeHome appPriDisRebFacadeHome = null;
		
		String jndi = global.getValor("jndi.AppPriDisRebFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.AppPriDisRebProvider");
		cat.debug("Url provider[" + url + "]");		
		
		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			appPriDisRebFacadeHome = (AppPriDisRebFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, AppPriDisRebFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de Apply Pricing Discounting And Rebate...");
		AppPriDisRebFacade appPriDisRebFacade = null;
		
		try 
		{
			appPriDisRebFacade = appPriDisRebFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getAppPriDisRebFacade():end");
		return appPriDisRebFacade;
	}
	
//	-----------------------------------------------------------------------------------------------------------
	private SupOrdHanFacade getSupOrdHanFacade() throws IssCusOrdException  
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
			supOrdHanFacadeHome = (SupOrdHanFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, SupOrdHanFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de Sup Order Hand Facade...");
		SupOrdHanFacade supOrdHanFacade = null;
		
		try 
		{
			supOrdHanFacade = supOrdHanFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getSupOrdHanFacade():end");
		return supOrdHanFacade;
	}
	

	public void setContext(SessionContext context) {
		this.context = context;
	}
	
//	-----------------------------------------------------------------------------------------------------------
	
	private ManConFacade getManConFacade() throws ManConException
	{
		Global global = Global.getInstance();		
		cat.debug("getManConFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		ManConFacadeHome manConFacadeHome = null;

		String jndi = global.getValor("jndi.ManConFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.ManConProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			manConFacadeHome = (ManConFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, ManConFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new ManConException(e);
		}		
		cat.debug("Recuperada interfaz home de Manage Con Facade...");
		ManConFacade manConFacade= null;

		try 
		{
			manConFacade = manConFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new ManConException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new ManConException(e);
		}		
		cat.debug("getManConFacade():end");
		return manConFacade;
	}
	
	
//	-----------------------------------------------------------------------------------------------------------	
	
	


}
