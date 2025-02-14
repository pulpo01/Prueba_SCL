package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.HomeLineaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.HomeLineaDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dao.TerminalDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoTerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class HomeLinea {
		
	    private HomeLineaDAO homeLineaDAO  = new HomeLineaDAO();
		
		private static Category cat = Category.getInstance(HomeLinea.class);
		Global global = Global.getInstance();
		
		/**
		 * Obtiene home de linea cuando la simcard es numerada
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */		
		public HomeLineaDTO getHomeLineaCelNumerado(HomeLineaDTO entrada)
			throws ProductDomainException
		{
			cat.debug("Inicio:getCodigoDescuentoManual()");
			HomeLineaDTO resultado = homeLineaDAO.getHomeLineaCelNumerado(entrada);
			cat.debug("Fin:getCodigoDescuentoManual()");
			return resultado;
		}//fin getCodigoDescuentoManual
		
		/**
		 * Obtiene home de linea cuando la simcard NO es numerada
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */		
		public HomeLineaDTO getHomeLineaCelNoNumerado(HomeLineaDTO entrada)
			throws ProductDomainException
		{
			cat.debug("Inicio:getCodigoDescuentoManual()");
			HomeLineaDTO resultado = homeLineaDAO.getHomeLineaCelNoNumerado(entrada);
			cat.debug("Fin:getCodigoDescuentoManual()");
			return resultado;
		}//fin getCodigoDescuentoManual

		
		
}//fin Terminal
