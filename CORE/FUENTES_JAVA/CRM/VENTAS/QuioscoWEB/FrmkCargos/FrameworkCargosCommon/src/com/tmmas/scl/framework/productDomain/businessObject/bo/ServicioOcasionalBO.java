package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.ServicioOcasionalDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.ServicioOcasionalDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoServOcacionalesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoServOcacionalesPVDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;


public class ServicioOcasionalBO implements ServicioOcasionalBOIT {
	
	private ServicioOcasionalDAOIT servicioOcacionalDAO  = new ServicioOcasionalDAO();
	
	private final Logger logger = Logger.getLogger(ServicioOcasionalBO.class);
	private final Global global=Global.getInstance();
	
	/**
	 * Busca cargos asociados al Servicio Ocacional
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesDTO entrada) throws ProductException{
		PrecioCargoDTO[] resultado = null;
		logger.debug("Inicio:getCargoServOcac()");
		resultado = servicioOcacionalDAO.getCargoServOcac(entrada);
		logger.debug("Fin:getCargoServOcac()");
		return resultado;
	}//fin getCargoServOcac
	
	
	/**
	 * Busca cargos asociados al Servicio Ocacional
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesPVDTO entrada) throws ProductException{
		PrecioCargoDTO[] resultado = null;
		logger.debug("Inicio:getCargoServOcac()");
		resultado = servicioOcacionalDAO.getCargoServOcac(entrada);
		logger.debug("Fin:getCargoServOcac()");
		return resultado;
	}//fin getCargoServOcac
	/**
	 * Busca Descuentos asociados al cargo del Servicio Ocacional
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductException{
		DescuentoDTO[] resultado = null;
		logger.debug("Inicio:getDescuento()");
		String claseDescuento=entrada.getClaseDescuento();
		claseDescuento=claseDescuento==null?"":claseDescuento.trim();
		
		
		if (claseDescuento.equals(global.getValor("parametro.clase.descuento.concepto"))){
			resultado = servicioOcacionalDAO.getDescuentoCargoConcepto(entrada);
		}	
		if (claseDescuento.equals(global.getValor("parametro.clase.descuento.articulo"))){ 
			resultado = servicioOcacionalDAO.getDescuentoCargoArticulo(entrada);
			
		}
		logger.debug("Fin:getDescuento()");
		return resultado;
	}//fin getDescuentoCargo

	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException{
		logger.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = servicioOcacionalDAO.getCodigoDescuentoManual(entrada);
		logger.debug("Fin:getCodigoDescuentoManual()");
		return resultado;
	}//fin getCodigoDescuentoManual
	
	
	public boolean existeCodigoConceptoArticulo(ArticuloDTO articuloDTO)throws ProductException{
		boolean retValue=false;
		logger.debug("Inicio:existeCodigoConceptoArticulo()");
		retValue = servicioOcacionalDAO.existeCodConcepArticulo(articuloDTO);
		logger.debug("Fin:existeCodigoConceptoArticulo()");
		return retValue;
	}
	
}//fin ServicioOcacional
