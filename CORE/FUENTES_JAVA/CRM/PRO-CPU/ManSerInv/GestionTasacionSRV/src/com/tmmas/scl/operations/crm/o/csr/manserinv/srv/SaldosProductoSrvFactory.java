package com.tmmas.scl.operations.crm.o.csr.manserinv.srv;

import com.tmmas.scl.operations.crm.o.csr.manserinv.srv.interfaces.SaldosProductoSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.manserinv.srv.interfaces.SaldosProductoSrvIF;

public class SaldosProductoSrvFactory implements SaldosProductoSrvFactoryIF{
	public SaldosProductoSrvIF getApplicationService1() 
	{
		return new SaldosProductoSrv();
	}
}
