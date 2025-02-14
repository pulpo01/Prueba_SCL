package com.tmmas.scl.operations.crm.o.csr.supordhan.srv.anu;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.anu.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.anu.interfaces.GestionAnulaOOSSSrvIF;

public class GestionAnulaOOSSSrv implements GestionAnulaOOSSSrvIF {

	private final Logger logger = Logger.getLogger(GestionAnulaOOSSSrv.class);
	private Global global = Global.getInstance();
	
	private OrdenServicioBOFactoryIT factoryBO1 = new OrdenServicioBOFactory();
	private OrdenServicioIT ordenServicioBO = factoryBO1.getBusinessObject1();
	
	public GestionAnulaOOSSSrv(){
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
	}
	
	
	public IOOSSDTO anulaOossPendPlan(IOOSSDTO ordenServicio) throws SupOrdHanException{
		IOOSSDTO respuesta = null;
		try {
			logger.debug("anulaOossPendPlan():start");
			respuesta = ordenServicioBO.anulaOossPendPlan(ordenServicio);
			logger.debug("anulaOossPendPlan():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;	
	}
}
