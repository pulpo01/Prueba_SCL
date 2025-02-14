package com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.orc;

import java.rmi.RemoteException;
import java.util.Date;

import javax.ejb.CreateException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.processmgr.AsyncProcessParameterObject;
import com.tmmas.cl.framework.processmgr.AsyncProcessResponseObject;
import com.tmmas.cl.framework.processmgr.GenericCommandObject;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EstadoProcesoOOSSDTO;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.orc.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.OrdenServicioBaseDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroOrdenServicioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;


public abstract class OrdenServicioAsincronoCmdORC extends GenericCommandObject {

	private static final long serialVersionUID = 1L;
	
	transient static Logger cat = Logger.getLogger(OrdenServicioAsincronoCmdORC.class);
	transient private AsyncProcessParameterObject parametros = null;
	
	public OrdenServicioAsincronoCmdORC() {
		// TODO Auto-generated constructor stub
	}

	public OrdenServicioAsincronoCmdORC(AsyncProcessParameterObject value) {
		super(value);
		// TODO Auto-generated constructor stub
	}

	public void onInit() throws GeneralException {
		cat.debug("onInit():start");
		cat.debug("onInit():end");
	}
	
	
	public AsyncProcessResponseObject start() throws GeneralException {
		cat.debug("start():start");

		OrdenServicioBaseDTO paramOServicio;

		try {
			// Recupero el parametro
			parametros = getArguments();
			paramOServicio = (OrdenServicioBaseDTO)parametros.getArgumentsData();
			
			EstadoProcesoOOSSDTO estadoProcesoIni=new EstadoProcesoOOSSDTO();
			estadoProcesoIni.setEstado("EN_PROCESO");
			estadoProcesoIni.setFechaActualizacion(new Date());
			estadoProcesoIni.setNumProceso(paramOServicio.getEstadoProcesoOOSS().getNumProceso());
			cat.debug("estadoProcesoIni.getEstado()[" + estadoProcesoIni.getEstado() + "]");
			cat.debug("estadoProcesoIni.getFechaActualizacion()[" + estadoProcesoIni.getFechaActualizacion() + "]");
			cat.debug("estadoProcesoIni.getNumProceso()[" + estadoProcesoIni.getNumProceso() + "]");
			cat.debug("notificar():inicio");
			notificar(estadoProcesoIni);
			cat.debug("notificar():fin");
						
			cat.debug("se procede a ejecutar proceso");
			ejecutarOrdenServicio(paramOServicio);
			cat.debug("Proceso terminó satisfactoriamente");
			
			EstadoProcesoOOSSDTO estadoProcesoFin = new EstadoProcesoOOSSDTO();
			estadoProcesoFin.setEstado("PROCESADO");
			estadoProcesoFin.setFechaActualizacion(new Date());
			estadoProcesoFin.setNumProceso(paramOServicio.getEstadoProcesoOOSS().getNumProceso());
			cat.debug("estadoProcesoFin.getEstado()[" + estadoProcesoFin.getEstado() + "]");
			cat.debug("estadoProcesoFin.getFechaActualizacion()[" + estadoProcesoFin.getFechaActualizacion() + "]");
			cat.debug("estadoProcesoFin.getNumProceso()[" + estadoProcesoFin.getNumProceso() + "]");
			cat.debug("notificar():inicio");
			notificar(estadoProcesoFin);
			cat.debug("notificar():fin");
			
			
			
		} catch (Exception e) {
			setRollBackManual(true);
			cat.debug("Error, se procede a ejecutar rollback");
			throw new GeneralException("Ha ocurrido un error al ejecutar orden de servicio", e); 
		}
		cat.debug("start():end");
		return null;

	}
	

	public EstadoProcesoOOSSDTO notificar(EstadoProcesoOOSSDTO estadoProcesoOOSS) throws CloCusOrdException, RemoteException, IssCusOrdException, GeneralException{
		EstadoProcesoOOSSDTO retorno=null;
		cat.debug("notificar():inicio");
		try{
			retorno=getCloCusOrdFacade().actualizarEstado(estadoProcesoOOSS);
		}catch (CloCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CloCusOrdException[" + loge + "]");
			throw e;
		}catch (RemoteException e){
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw e;
		}
		cat.debug("notificar():fin");
		return retorno;
	}
	
	
	private CloCusOrdFacade getCloCusOrdFacade() throws IssCusOrdException, CloCusOrdException
	{
		Global global = Global.getInstance();		
		cat.debug("getCloCusOrdFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		CloCusOrdFacadeHome cloCusOrdFacadeHome = null;

		String jndi = global.getValor("jndi.CloCusOrdFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.CloCusOrdProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			cloCusOrdFacadeHome = (CloCusOrdFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, CloCusOrdFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new CloCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de CloCusOrdFacade...");
		CloCusOrdFacade cloCusOrdFacade = null;

		try 
		{
			cloCusOrdFacade = cloCusOrdFacadeHome.create();
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
		cat.debug("getCloCusOrdFacade():end");
		return cloCusOrdFacade;
	}
	
	

	public abstract void ejecutarOrdenServicio(OrdenServicioBaseDTO objeto) throws GeneralException;
	
	
}
