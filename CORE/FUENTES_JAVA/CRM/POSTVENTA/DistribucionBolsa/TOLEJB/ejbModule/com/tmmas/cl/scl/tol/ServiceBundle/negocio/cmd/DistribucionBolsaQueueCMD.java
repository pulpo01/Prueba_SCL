package com.tmmas.cl.scl.tol.ServiceBundle.negocio.cmd;

import java.rmi.RemoteException;

import javax.ejb.CreateException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.FrameworkException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.processmgr.AsyncProcessResponse;
import com.tmmas.cl.framework.processmgr.GenericCommand;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ParametroProcesoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.ejb.session.TOLFacade;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.ejb.session.TOLFacadeHome;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.util.Global;

public class DistribucionBolsaQueueCMD extends GenericCommand{
	private static final long serialVersionUID = 1L;
	transient private static Category cat = Category.getInstance(DistribucionBolsaQueueCMD.class);
	
	private ParametroProcesoDTO proceso;
	private int intento;

	
	public DistribucionBolsaQueueCMD(ParametroProcesoDTO proceso)
	{
		this.proceso = proceso;
	}
	
	public void onInit() throws FrameworkException {
		
		cat.debug("onInit:Star");
		
		cat.debug("onInit:end");
		
	}
	
	private TOLFacade getTOLFacade() throws TOLException {
		cat.debug("getTOLFacade():start");
		Global global = Global.getInstance();

		TOLFacadeHome facadeHome = null;
		String jndi = global.getValor("jndi.TOLfacade");
		cat.debug("Buscando servicio[" + jndi + "]");
		String url = global.getValor("url.provider");
		cat.debug("Url provider[" + url + "]");

		try {
			facadeHome = (TOLFacadeHome) ServiceLocator.getInstance()
					.getRemoteHome(url, jndi, TOLFacadeHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			cat.debug("ServiceLocatorException", e);
			throw new TOLException(e);
		}

		cat.debug("Recuperada interfaz home de TOL Order facade...");
		TOLFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			cat.debug("CreateException", e);
			throw new TOLException(e);

		} catch (RemoteException e) {
			cat.debug("RemoteException", e);
			throw new TOLException(e);
		}

		cat.debug("getTOLFacade()():end");
		return facade;
	}
	
	public AsyncProcessResponse start() throws FrameworkException 
	{
		DistribucionBolsaDTO distribucion;
		
		cat.debug("start:Star");
		
		intento++;
		cat.debug("start:Intento [" + intento + "]");
		
		proceso.setError_tecnico("");
		proceso.setNum_reintentos(intento);
		
		try {
			cat.debug("Registro Inicialdo ejecucion en BD");
			proceso.setNum_reintentos(intento);
			actualizaProceso("En proceso", 2);
			
			distribucion = (DistribucionBolsaDTO)proceso.getParametro();
			cat.debug("se procese a ejecutar proceso");
			getTOLFacade().createStorageAndFreeUnitStock(distribucion);
			
			cat.debug("Proceso terminó satisfactoriamente, actualizo estado de proceso");
			actualizaProceso("Fin OK ", 3);
			
		} catch (Exception e) {
			proceso.setError_tecnico(buscaGlosa(e));
			actualizaProceso("Fin Error", 4);
			cat.debug("Error, se procesede a ejecutar roolback");
			throw new FrameworkException("A ocurrido un error al instalar el servicio suplementario", e); 
		}

		return null;
	}
	

	private void actualizaProceso(String glosa, int estado) 
	{
		proceso.setObservacion(glosa);
		proceso.setEstado(estado);
		try {
			getTOLFacade().actualizaProceso(proceso);
		} catch (Exception e) {
			cat.debug("Error al actualizar el proceso :" + proceso.getNumeroProceso() + " a :" + glosa, e);
		}
	
	}
}

