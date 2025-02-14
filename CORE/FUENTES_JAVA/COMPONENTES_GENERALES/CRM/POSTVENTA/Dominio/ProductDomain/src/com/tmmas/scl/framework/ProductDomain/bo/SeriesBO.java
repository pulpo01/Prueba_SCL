package com.tmmas.scl.framework.ProductDomain.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SeriesBOIT;
import com.tmmas.scl.framework.ProductDomain.dao.SeriesDAO;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.SeriesDAOIT;
import com.tmmas.scl.framework.ProductDomain.dto.ArticuloInDTO;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;


public class SeriesBO implements SeriesBOIT{

	private SeriesDAOIT SeriesDAO = new SeriesDAO();
	private final Logger logger = Logger.getLogger(SeriesBO.class);


   // RRG
   public RetornoDTO validaSerieExterna (SerieDTO serie) throws ProductException {
		RetornoDTO retValue=null;
		try {
			logger.debug("validaSerieExterna():start");
			retValue=SeriesDAO.validaSerieExterna(serie);
			logger.debug("validaSerieExterna():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}	
		return retValue;
	}
   // RRG


	public RetornoDTO reservaSimcard (SerieDTO serie) throws ProductException {
		RetornoDTO retValue=null;
		try {
			logger.debug("obtenerTiposDeContrato():start");
			retValue=SeriesDAO.reservaSimcard(serie);
			logger.debug("obtenerTiposDeContrato():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}	
		return retValue;
	}
	
	public RetornoDTO desReservaSimcard (SerieDTO serie) throws ProductException {

		RetornoDTO retValue=null;
		try {
			logger.debug("obtenerTiposDeContrato():start");
			retValue=SeriesDAO.desReservaSimcard(serie);
			logger.debug("obtenerTiposDeContrato():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}				
		return retValue;
	}	
	
	public void validaBodegaSerie (UsoArticuloDTO  usoArticulos, TipoTerminalDTO tipoTerminal, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion, SerieDTO serie) throws ProductException {

		try {
			logger.debug("validaBodegaSerie():start");
			SeriesDAO.validaBodegaSerie(usoArticulos, tipoTerminal, usuarioAbonado, sesion, serie);
			logger.debug("validaBodegaSerie():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}				
	}	
	
	public SerieDTO recInfoSerie (SerieDTO serie) throws ProductException {
		
		SerieDTO respuesta ;
		try {
			logger.debug("recInfoSerie():start");
			respuesta = SeriesDAO.recInfoSerie(serie);
			logger.debug("recInfoSerie():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception [", e);
			throw new ProductException(e);
		}
		return respuesta;
	}
	public void registraCambioSimcard(UsuarioAbonadoDTO usuarioAbonado, SerieDTO serie, UsoArticuloDTO usoArticulo, CuotaDTO cuota, SesionDTO sesion, ModalidadPagoDTO modalidadPago, BodegaDTO bodega, String actabo, String codModulo, CausaCamSerieDTO causaCamSerie) throws ProductException{
		
		try {
			logger.debug("registraCambioSimcard():start");
			SeriesDAO.registraCambioSimcard(usuarioAbonado, serie, usoArticulo, cuota, sesion, modalidadPago, bodega, actabo, codModulo, causaCamSerie);
			logger.debug("registraCambioSimcard():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}								
	}

	// ----------------------------------------------------------------------------------
	
	public String registraCambioDeSerie(ParametrosCambioSerieDTO parametros,SaldoDTO saldo)  throws ProductException  {

		String respuesta ;
		
		try {
			logger.debug("registraCambioDeSerie():start");
			respuesta = SeriesDAO.registraCambioDeSerie(parametros,saldo);
			logger.debug("registraCambioDeSerie():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}	
		
		return respuesta;
		
	} // registraCambioDeSerie

	// ----------------------------------------------------------------------------------
	
	public ArticuloInDTO[] obtieneArticulos(ArticuloInDTO articuloDTO) throws ProductException {
		ArticuloInDTO[] articuloInDTOs = null;
		try {
			logger.debug("obtieneArticulos():start");
			articuloInDTOs = SeriesDAO.obtieneArticulos(articuloDTO);
			logger.debug("obtieneArticulos():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return articuloInDTOs;
	}

	// ----------------------------------------------------------------------------------
	
	public BodegaDTO[] obtieneBodega(BodegaDTO bodegaDTO) throws ProductException {
		BodegaDTO[] bodegaDTOs = null;
		try {
			logger.debug("obtieneBodega():start");
			bodegaDTOs = SeriesDAO.obtieneBodega(bodegaDTO);
			logger.debug("obtieneBodega():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return bodegaDTOs;
	}

	// ----------------------------------------------------------------------------------
	
	public SerieDTO[] obtieneSerie(SerieDTO serieDTO) throws ProductException {
		SerieDTO[] serieDTOs = null;
		try {
			logger.debug("obtieneSerie():start");
			serieDTOs =  SeriesDAO.obtieneSerie(serieDTO);
			logger.debug("obtieneSerie():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}	
		return serieDTOs;
	}

	// ----------------------------------------------------------------------------------
	
	public SerieDTO[] obtieneSeries(SerieDTO serieDTO) throws ProductException {
		SerieDTO[] serieDTOs = null;
		try {
			logger.debug("obtieneSeries():start");
			serieDTOs = SeriesDAO.obtieneSeries(serieDTO);
			logger.debug("obtieneSeries():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}	
		return serieDTOs;
	}

	// ----------------------------------------------------------------------------------
	
	public RetornoDTO validaSerieExternaEquipo (SerieDTO serie) throws ProductException {
		RetornoDTO retValue=null;
		try {
			logger.debug("validaSerieExternaEquipo():start");
			retValue=SeriesDAO.validaSerieExternaEquipo(serie);
			logger.debug("validaSerieExternaEquipo():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}	
		return retValue;
	}
	
	// ----------------------------------------------------------------------------------
	//INICIO 177697 PAH	
	public SerieDTO[] obtieneSeriesSinUso(SerieDTO serieDTO) throws ProductException {
		SerieDTO[] serieDTOs = null;
		try {
			logger.debug("obtieneSeriesSinUso():start");
			serieDTOs = SeriesDAO.obtieneSeriesSinUso(serieDTO);
			logger.debug("obtieneSeriesSinUso():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}	
		return serieDTOs;
	}
	//FIN 177697 PAH	
}
