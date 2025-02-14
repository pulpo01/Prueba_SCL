package com.tmmas.scl.operations.crm.f.oh.comord.srv;

import org.apache.log4j.Logger;

import com.tmmas.scl.operations.crm.f.oh.comord.srv.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.comord.srv.interfaces.ComOrdSrvIF;

public class ComOrdSrv implements ComOrdSrvIF {

	private final Logger logger = Logger.getLogger(ComOrdSrv.class);
	
	//private OrdenServicioBOFactoryIT factoryBO1 = new OrdenServicioBOFactory();
	//private OrdenServicioIT clienteBO = factoryBO1.getBusinessObject1();
	private Global global = Global.getInstance();	


}
