package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.RangoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.RangoNumeroDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeroPilotoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class RangoNumero {
		
	    private RangoNumeroDAO rangoNumeroDAO  = new RangoNumeroDAO();
		
		private static Category cat = Category.getInstance(RangoNumero.class);
		Global global = Global.getInstance();
		
		/**
		 * Obtiene rango de numeros disponibles a asociar
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */		
		public RangoDTO[] obtieneRangosDisponibles(Integer codCentral)
			throws ProductDomainException
		{
			cat.debug("Inicio:obtieneRangosDisponibles()");
			RangoDTO[] resultado = rangoNumeroDAO.obtieneRangosDisponibles(codCentral);
			cat.debug("Fin:obtieneRangosDisponibles()");
			return resultado;
		}//fin obtieneRangosDisponibles		
		
		/**
		 * Inserta rango asociado a numero piloto
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */		
		public void insertaRangoAsociadoNroPiloto(NumeroPilotoDTO rango) 
			throws ProductDomainException
		{
			cat.debug("Inicio:insertaRangoAsociadoNroPiloto()");
			rangoNumeroDAO.insertaRangoAsociadoNroPiloto(rango);
			cat.debug("Fin:insertaRangoAsociadoNroPiloto()");			
		}//fin insertaRangoAsociadoNroPiloto
		
		/**
		 * Elimina rango asociado a numero piloto
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */		
		public void eliminarRangos(Long entrada)
			throws ProductDomainException
		{
			cat.debug("Inicio:eliminarRangos()");
			rangoNumeroDAO.eliminarRangos(entrada);
			cat.debug("Fin:eliminarRangos()");			
		}//fin eliminarRangos	
		
}//fin RangoNumero
