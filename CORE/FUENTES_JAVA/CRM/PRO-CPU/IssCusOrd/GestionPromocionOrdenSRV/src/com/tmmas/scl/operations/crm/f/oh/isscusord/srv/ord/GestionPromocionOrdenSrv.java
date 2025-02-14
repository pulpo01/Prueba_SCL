package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.ord;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productPromotionABE.businessObject.bo.PromocionBOFactory;
import com.tmmas.scl.framework.productDomain.productPromotionABE.businessObject.bo.interfaces.PromocionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productPromotionABE.businessObject.bo.interfaces.PromocionIT;
import com.tmmas.scl.framework.productDomain.productPromotionABE.dataTransferObject.EliminaPromocionDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.ord.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.ord.interfaces.GestionPromocionOrdenSrvIF;

public class GestionPromocionOrdenSrv implements GestionPromocionOrdenSrvIF {

	private final Logger logger = Logger.getLogger(GestionPromocionOrdenSrv.class);
	
	private PromocionBOFactoryIT factoryBO1 = new PromocionBOFactory();
	private PromocionIT promocionBO = factoryBO1.getBusinessObject1();
	private Global global = Global.getInstance();
	
	public RetornoDTO eliminarPromocion(EliminaPromocionDTO param)
			throws IssCusOrdException {
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarPromocion():start");
			retorno = promocionBO.eliminarPromocion(param);
			logger.debug("eliminarPromocion():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}

}
