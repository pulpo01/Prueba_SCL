package com.tmmas.scl.operations.crm.o.csr.supordhan.srv.anu;

import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.anu.interfaces.GestionAnulaOOSSSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.anu.interfaces.GestionAnulaOOSSSrvIF;

public class GestionAnulaOOSSSrvFactory implements GestionAnulaOOSSSrvFactoryIF {

	public GestionAnulaOOSSSrvIF getApplicationService1() {
		return new GestionAnulaOOSSSrv();
	}

}
