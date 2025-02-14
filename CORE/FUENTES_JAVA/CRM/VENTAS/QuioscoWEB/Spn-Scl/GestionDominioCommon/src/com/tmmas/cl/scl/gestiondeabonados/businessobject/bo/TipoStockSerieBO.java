package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.TipoStockSerieDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TipoStockValidoDTO;

public class TipoStockSerieBO {
	
	private TipoStockSerieDAO tipoStockSerieDAO  = new TipoStockSerieDAO();
	private static Category cat = Category.getInstance(TipoStockSerieBO.class);
	
	public ResultadoValidacionLogisticaDTO validaTipoStockSerie(TipoStockValidoDTO datosStockSerie)throws GeneralException{
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
