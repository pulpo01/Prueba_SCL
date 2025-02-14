package com.tmmas.scl.framework.ProductDomain.bo;


import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.NumeracionCelularBOIT;
import com.tmmas.scl.framework.ProductDomain.dao.DatosGeneralesDAO;
import com.tmmas.scl.framework.ProductDomain.dao.NumeracionCelularDAO;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.DatosGeneralesDAOIT;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.NumeracionCelularDAOIT;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CategoriaTributariaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosNumeracionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.NumeracionCelularDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RegistroVentaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularRangoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosVerificaPlanComercialDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;

public class NumeracionCelularBO implements NumeracionCelularBOIT{


	private NumeracionCelularDAOIT NumeracionCelularDAO = new NumeracionCelularDAO();
	private final Logger logger = Logger.getLogger(NumeracionCelularBO.class);

	// --------------------------------------------------------------------------------------------------------------
	
	public void reponerNumeracion(NumeracionCelularDTO numeracionCelularVO) throws ProductException {

		try {
			logger.debug("reponerNumeracion():start");
			NumeracionCelularDAO.reponerNumeracion(numeracionCelularVO);
			logger.debug("reponerNumeracion():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		

	} // reponerNumeracion

	// --------------------------------------------------------------------------------------------------------------
	
	public SeleccionNumeroCelularDTO[] obtenerNumeracionReservada(DatosNumeracionDTO datosNumeracionDTO) throws ProductException {

		SeleccionNumeroCelularDTO[] arrayNumerosReservados = null;
		try {
			logger.debug("obtenerNumeracionReservada():start");
			arrayNumerosReservados = NumeracionCelularDAO.obtenerNumeracionReservada(datosNumeracionDTO);
			logger.debug("obtenerNumeracionReservada():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		
		return arrayNumerosReservados;

	} // obtenerNumeracionReservada
	
	// --------------------------------------------------------------------------------------------------------------
	
	public String[] obtieneCategoria(DatosNumeracionDTO datosNumeracionVO)  throws ProductException	 {

		String[] arregloCategorias = null;
		try {
			logger.debug("obtieneCategoria():start");
			arregloCategorias = NumeracionCelularDAO.obtieneCategoria(datosNumeracionVO);
			logger.debug("obtieneCategoria():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		
		return arregloCategorias;

	} // obtieneCategoria

	// --------------------------------------------------------------------------------------------------------------
	
	public DatosNumeracionDTO obtieneNumeracionAutomatica(DatosNumeracionDTO obtieneCategoria)  throws ProductException	{ 	
	
	DatosNumeracionDTO resultado = null;
		try {
			logger.debug("obtieneNumeracionAutomatica():start");
			resultado = NumeracionCelularDAO.obtieneNumeracionAutomatica(obtieneCategoria);
			logger.debug("obtieneNumeracionAutomatica():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		
		return resultado;

	} // obtieneNumeracionAutomatica

// --------------------------------------------------------------------------------------------------------------
	
	public SeleccionNumeroCelularRangoDTO[] obtenerNumeracionRango(DatosNumeracionDTO datosNumeracionVO)  throws ProductException	{ 	
	
		SeleccionNumeroCelularRangoDTO[]  resultado = null;
		try {
			logger.debug("obtenerNumeracionRango():start");
			resultado = NumeracionCelularDAO.obtenerNumeracionRango(datosNumeracionVO);
			logger.debug("obtenerNumeracionRango():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		
		return resultado;

	} // obtenerNumeracionRango

// --------------------------------------------------------------------------------------------------------------
	
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReutilizable(DatosNumeracionDTO datosNumeracionVO)  throws ProductException	{ 	
	
		SeleccionNumeroCelularDTO[]  resultado = null;
		try {
			logger.debug("obtieneNumeracionReutilizable():start");
			resultado = NumeracionCelularDAO.obtieneNumeracionReutilizable(datosNumeracionVO);
			logger.debug("obtieneNumeracionReutilizable():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		
		return resultado;

	} // obtieneNumeracionReutilizable

// --------------------------------------------------------------------------------------------------------------
	
	public void reservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) throws ProductException	{ 	
		
		try {
			logger.debug("reservaNumeroCelular():start");
			NumeracionCelularDAO.reservaNumeroCelular(numeracionCelularVO);
			logger.debug("reservaNumeroCelular():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		

	} // reservaNumeroCelular

// --------------------------------------------------------------------------------------------------------------	
	public void insertarNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO) throws ProductException	{
		
		try {
			logger.debug("insertarNumeroCelularReservado():start");
			NumeracionCelularDAO.insertarNumeroCelularReservado(numeracionCelularVO);
			logger.debug("insertarNumeroCelularReservado():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		

	} // insertarNumeroCelularReservado

// --------------------------------------------------------------------------------------------------------------	

	public void desReservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) throws ProductException	{
		
		try {
			logger.debug("desReservaNumeroCelular():start");
			NumeracionCelularDAO.insertarNumeroCelularReservado(numeracionCelularVO);
			logger.debug("desReservaNumeroCelular():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		

	} // desReservaNumeroCelular

// --------------------------------------------------------------------------------------------------------------	

	public void actualizaNroFax(long numAbonado, String numeroFax)  throws ProductException	{
		
		try {
			logger.debug("actualizaNroFax():start");
			NumeracionCelularDAO.actualizaNroFax(numAbonado, numeroFax);
			logger.debug("actualizaNroFax():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		

	} // actualizaNroFax

// --------------------------------------------------------------------------------------------------------------	
 
}
