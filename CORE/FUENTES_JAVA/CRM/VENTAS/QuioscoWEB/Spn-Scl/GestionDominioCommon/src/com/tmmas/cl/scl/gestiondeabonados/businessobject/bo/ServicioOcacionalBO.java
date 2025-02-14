package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.ServicioOcasionalDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosCargoServOcacionalesDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;

public class ServicioOcacionalBO {
	private ServicioOcasionalDAO servicioOcacionalDAO  = new ServicioOcasionalDAO();
	private static Category cat = Category.getInstance(ServicioSuplementarioBO.class);
	
	/**
	 * Busca cargos asociados al Servicio Ocacional
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesDTO entrada) throws GeneralException{
		PrecioCargoDTO[] resultado = null;
		cat.debug("Inicio:getCargoServOcac()");
		resultado = servicioOcacionalDAO.getCargoServOcac(entrada);
		cat.debug("Fin:getCargoServOcac()");
		return resultado;
	}//fin getCargoServOcac
	
	/**
	 * Busca Descuentos asociados al cargo del Servicio Ocacional
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws GeneralException{
		DescuentoDTO[] resultado = null;
		cat.debug("Inicio:getDescuento()");
		if (entrada.getClaseDescuento().equals(entrada.getClaseDescuentoArticulo()))
			resultado = servicioOcacionalDAO.getDescuentoCargoArticulo(entrada);
		else
			resultado = servicioOcacionalDAO.getDescuentoCargoConcepto(entrada);
		cat.debug("Fin:getDescuento()");
		return resultado;
	}//fin getDescuentoCargo

	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = servicioOcacionalDAO.getCodigoDescuentoManual(entrada);
		cat.debug("Fin:getCodigoDescuentoManual()");
		return resultado;
	}//fin getCodigoDescuentoManual
	
}//fin ServicioOcacional
