package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.FormasPagoDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FormasPagoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;
public class FormasPago {
	
	private FormasPagoDAO formaspagoDAO = new FormasPagoDAO();
	private static Category cat = Category.getInstance(FormasPago.class);
	Global global = Global.getInstance();
	
	public FormasPagoDTO[] getArrayFormasPago(ParametrosGeneralesDTO parametroOrdenCompra,RegistroVentaDTO registroventa,ClienteDTO cliente) throws CustomerDomainException{
		FormasPagoDTO[] resultado;
		cat.debug("Inicio:getArrayFormasPago()");
		resultado = formaspagoDAO.getArrayFormasPago(parametroOrdenCompra,registroventa,cliente); 
		cat.debug("Fin:getArrayFormasPago()");
		return resultado;
	}//fin getArrayFormasPago

	
}
