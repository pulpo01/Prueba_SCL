package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.ord;

import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.ord.interfaces.GestionPromocionOrdenSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.ord.interfaces.GestionPromocionOrdenSrvIF;

public class GestionPromocionOrdenSrvFactory implements GestionPromocionOrdenSrvFactoryIF {

	public GestionPromocionOrdenSrvIF getApplicationService1() {
		return new GestionPromocionOrdenSrv();
	}

}
