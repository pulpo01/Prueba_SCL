package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc;

import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.ContratacionProductoSrvOrcFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.ContratacionProductoSrvOrcIF;

public class ContratacionProductoSrvOrcFactory implements ContratacionProductoSrvOrcFactoryIF
{

	public ContratacionProductoSrvOrcIF getApplicationService1() {		
		return new ContratacionProductoSrvOrc();
	}	

}
