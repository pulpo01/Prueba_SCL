package com.tmmas.scl.framework.ProductDomain.bo;

import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SeriesBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SeriesBOIT;


public class SeriesBOFactory implements SeriesBOFactoryIT{

	public SeriesBOIT getBusinessObject1() {
		return new SeriesBO();
	}
}
