package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.ServicioOcasionalDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoServOcacionalesDTO;

public class ServicioOcacional {
	private ServicioOcasionalDAO servicioOcacionalDAO  = new ServicioOcasionalDAO();
	private static Category cat = Category.getInstance(ServicioSuplementario.class);
	
	/**
	 * Busca cargos asociados al Servicio Ocacional
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesDTO entrada)
		throws ProductDomainException
	{
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
	 * @throws ProductDomainException
	 */
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) 
		throws ProductDomainException
	{
		DescuentoDTO[] resultado = null;
		cat.debug("Inicio:getDescuento()");
		if (entrada.getClaseDescuento().equals(entrada.getClaseDescuento()))
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
	 * @throws ProductDomainException
	 */
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = servicioOcacionalDAO.getCodigoDescuentoManual(entrada);
		cat.debug("Fin:getCodigoDescuentoManual()");
		return resultado;
	}//fin getCodigoDescuentoManual
	
}//fin ServicioOcacional
