/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 * 
 * Esta clase carga y mantiene en memoria informacion que sera usada por varias paginas.
 */
package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;

public class ManageRequestSession {

	private static Logger logger = Logger.getLogger(ManageRequestSession.class);
	private Global global = Global.getInstance();
	
	private AbonadoDTO[] abonados;
	//private PlanTarifarioDTO[] planes;
	
	private ClienteDTO cliente = new ClienteDTO();

	public AbonadoDTO[] getAbonados() {
		return abonados;
	}

	public ClienteDTO getCliente() {
		return cliente;
	}
/*
	public PlanTarifarioDTO[] getPlanes() {
		return planes;
	}	
*/	
	public void cargaInicial(long codCliente){
		if (codCliente == this.cliente.getCodCliente()) return;
		
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);

		logger.debug("cargaInicial():start");
		//Cargar listas!!, llamar a ManageRequestBussinessDelegate
		logger.debug("cargaInicial():end");		
	}
	  
}
