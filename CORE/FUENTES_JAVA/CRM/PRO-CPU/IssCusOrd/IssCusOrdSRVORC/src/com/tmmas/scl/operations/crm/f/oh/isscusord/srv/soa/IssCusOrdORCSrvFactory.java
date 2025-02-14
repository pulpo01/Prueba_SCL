package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.soa;

import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.soa.interfaces.IssCusOrdORCSrvFactoryIT;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.soa.interfaces.IssCusOrdORCSrvIT;

public class IssCusOrdORCSrvFactory implements IssCusOrdORCSrvFactoryIT{
	public IssCusOrdORCSrvIT getApplicationService1() {
		return new IssCusOrdORCSrv();
	}
	
}
