package com.tmmas.cl.scl.BillingProductCharge.ProdPriceCharge.businesobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.BillingProductCharge.ProdPriceCharge.businesobject.dao.ProdPriceChargeDAO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CargosRecCliAboDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.BillingProductChargeException;


public class ProdPriceCharge {
	private ProdPriceChargeDAO dao  = new ProdPriceChargeDAO();
	private static Category cat = Category.getInstance(ProdPriceCharge.class);
	
	
	public void installBillingProductCharge(CargosRecCliAboDTO list) 
		throws BillingProductChargeException 
	{
		cat.info("installBillingProductCharge():start");
		dao.installBillingProductCharge(list);
		cat.info("Se ejecutó servicio installBillingProductCharge correctamente, se procederá a ejecutar uninstallBillingProductCharge");
		dao.uninstallBillingProductCharge(list);
		cat.info("installBillingProductCharge():end");
	}
}
