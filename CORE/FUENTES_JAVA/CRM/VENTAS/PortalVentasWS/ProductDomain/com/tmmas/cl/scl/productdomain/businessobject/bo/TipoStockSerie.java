package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoStockValidoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.TipoStockSerieDAO;

public class TipoStockSerie {
	
	private TipoStockSerieDAO tipoStockSerieDAO  = new TipoStockSerieDAO();
	private static Category cat = Category.getInstance(TipoStockSerie.class);
	
	public ResultadoValidacionLogisticaDTO validaTipoStockSerie(TipoStockValidoDTO datosStockSerie)throws ProductDomainException{
		ResultadoValidacionLogisticaDTO resultado = null;
		cat.debug("Inicio:validaTipoStockSerie()");
		resultado = tipoStockSerieDAO.getTipoStockSerieValido(datosStockSerie); 
		if (resultado.getResultadoBase() == 1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0){
			resultado.setResultado(false);
		}
		cat.debug("Fin:validaTipoStockSerie()");
		return resultado;
	}

}
