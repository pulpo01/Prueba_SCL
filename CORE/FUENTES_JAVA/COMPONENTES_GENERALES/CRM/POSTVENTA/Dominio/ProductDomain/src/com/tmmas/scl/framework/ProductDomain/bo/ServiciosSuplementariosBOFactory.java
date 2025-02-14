package com.tmmas.scl.framework.ProductDomain.bo;

import com.tmmas.scl.framework.ProductDomain.bo.interfaces.ServiciosSuplementariosBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.ServiciosSuplementariosBOIT;

public class ServiciosSuplementariosBOFactory implements ServiciosSuplementariosBOFactoryIT{

	public ServiciosSuplementariosBOIT getBusinessObject1() {
		return new ServiciosSuplementariosBO();
	}
}

