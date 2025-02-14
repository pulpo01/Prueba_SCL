package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc;

import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.LimiteConsumoSrvOrcFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.LimiteConsumoSrvOrcIF;

public class LimiteConsumoSrvOrcFactory implements LimiteConsumoSrvOrcFactoryIF{

	public LimiteConsumoSrvOrcIF getApplicationService1() {		
		return new LimiteConsumoSrvOrc();
	}	

}
