package com.tmmas.scl.framework.ProductDomain.bo;


import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.ProductDomain.dao.DatosGeneralesDAO;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.DatosGeneralesDAOIT;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CategoriaTributariaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
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
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;

public class DatosGeneralesBO implements DatosGeneralesBOIT{


	private DatosGeneralesDAOIT DatosGeneralesDAO = new DatosGeneralesDAO();
	private final Logger logger = Logger.getLogger(DatosGeneralesBO.class);

	public TipoDeContratoDTO[] obtenerTiposDeContrato (SesionDTO sesion) throws ProductException {

		TipoDeContratoDTO[] respuesta = null;
		try {
			logger.debug("obtenerTiposDeContrato():start");
			respuesta = DatosGeneralesDAO.obtenerTiposDeContrato(sesion);
			logger.debug("obtenerTiposDeContrato():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;			

	}

	public CausaCamSerieDTO[] obtenerCausaCambioSerie () throws ProductException{

		CausaCamSerieDTO[] respuesta = null;
		try {
			logger.debug("obtenerCausaCambioSerie():start");
			respuesta = DatosGeneralesDAO.obtenerCausaCambioSerie();
			logger.debug("obtenerCausaCambioSerie():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;			

	}		

	public BodegaDTO[] obtenerBodegas (SesionDTO sesion) throws ProductException {

		BodegaDTO[] respuesta = null;
		try {
			logger.debug("obtenerBodegas():start");
			respuesta = DatosGeneralesDAO.obtenerBodegas(sesion);
			logger.debug("obtenerBodegas():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;			

	}

	public TecnologiaDTO[] obtenerTecnologia () throws ProductException {		

		TecnologiaDTO[] respuesta = null;
		try {
			logger.debug("obtenerTecnologia():start");
			respuesta = DatosGeneralesDAO.obtenerTecnologia();
			logger.debug("obtenerTecnologia():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;					
	}	

	public UsoArticuloDTO[] obtenerUsos () throws ProductException {

		UsoArticuloDTO[] respuesta = null;
		try {
			logger.debug("obtenerusos():start");
			respuesta = DatosGeneralesDAO.obtenerUsos();
			logger.debug("obtenerusos():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;					
	}	

	public MesesProrrogasDTO[] obtenerMesesProrroga () throws ProductException {

		MesesProrrogasDTO[] respuesta = null;
		try {
			logger.debug("obtenerMesesProrroga():start");
			respuesta = DatosGeneralesDAO.obtenerMesesProrroga();
			logger.debug("obtenerMesesProrroga():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;					
	}	

	public ModalidadPagoDTO[] obtenerModalidadPagoSimcard (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException {	
		ModalidadPagoDTO[] respuesta = null;
		try {
			logger.debug("obtenerModalidadPagoSimcard():start");
			respuesta = DatosGeneralesDAO.obtenerModalidadPagoSimcard(Sesion, CausaCamSerie);
			logger.debug("obtenerModalidadPago():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;		
	}	

	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException{

		ModalidadPagoDTO[] respuesta = null;
		try {
			logger.debug("obtenerModalidadPago():start");
			respuesta = DatosGeneralesDAO.obtenerModalidadPago(Sesion, CausaCamSerie);
			logger.debug("obtenerModalidadPago():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;		
	}

	public TipoTerminalDTO[] obtenerTipoterminal (TecnologiaDTO Tecnologia) throws ProductException {

		TipoTerminalDTO[] respuesta = null;
		try {
			logger.debug("obtenerTipoterminal():start");
			respuesta = DatosGeneralesDAO.obtenerTipoterminal(Tecnologia);
			logger.debug("obtenerTipoterminal():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;			

	}		

	public CuotaDTO[] obtenerCuotas (SesionDTO Sesion, ModalidadPagoDTO ModalidadPago) throws ProductException{
		CuotaDTO[] respuesta = null;
		try {
			logger.debug("obtenerCuotas():start");
			respuesta = DatosGeneralesDAO.obtenerCuotas(Sesion, ModalidadPago);
			logger.debug("obtenerCuotas():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;			

	}		

	public CategoriaTributariaDTO[] obtenerCatTributaria (SesionDTO Sesion) throws ProductException{
		CategoriaTributariaDTO[] respuesta = null;
		try {
			logger.debug("obtenerCatTributaria():start");
			respuesta = DatosGeneralesDAO.obtenerCatTributaria(Sesion);
			logger.debug("obtenerCatTributaria():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;			
	}

	public UsosVentaDTO[] obtenerUsosVenta () throws ProductException
	{
		UsosVentaDTO[] respuesta = null;
		try {
			logger.debug("obtenerUsosVenta():start");
			respuesta = DatosGeneralesDAO.obtenerUsosVenta();
			logger.debug("obtenerUsosVenta():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;			
	}		

	public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws ProductException {
		CentralDTO[] respuesta = null;
		try {
			logger.debug("obtenerCentralTecnologiaHlr():start");
			respuesta = DatosGeneralesDAO.obtenerCentralTecnologiaHlr(serie, tecnologia);
			logger.debug("obtenerCentralTecnologiaHlr():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;		
	}

	public void validaCausaCamSerie (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException{
		try {
			logger.debug("validaCausaCamSerie():start");
			DatosGeneralesDAO.validaCausaCamSerie(Sesion, CausaCamSerie);
			logger.debug("obtenerCentralTecnologiaHlr():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
	}
	
	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO Restricciones) throws ProductException {
		MensajeRetornoDTO respuesta = null;			
		try {							
			logger.debug("EjecutarRestriccion():start");
			respuesta = new MensajeRetornoDTO();
			respuesta = DatosGeneralesDAO.ejecutaRestrccion(Restricciones);
			logger.debug("EjecutarRestriccion():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;
	}	
	
	public void verificaPlancomercial(SesionDTO sesion, CausaCamSerieDTO causaCamSerie, ModalidadPagoDTO modalidadPago, UsoArticuloDTO usoArticulo, TipoTerminalDTO tipoTerminal, SerieDTO Serie) throws ProductException {			
		try {							
			logger.debug("verificaPlancomercial():start");		
			DatosGeneralesDAO.verificaPlancomercial(sesion, causaCamSerie, modalidadPago, usoArticulo, tipoTerminal, Serie);
			logger.debug("verificaPlancomercial():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		
	}
	
	public ArticuloDTO[] obtenerListaArticulos (ArticuloDTO articuloDTO) throws ProductException {
		ArticuloDTO[] retValue = null;
		try {
			logger.debug("obtenerListaArticulos():start");
			retValue = DatosGeneralesDAO.obtenerListaArticulos(articuloDTO);
			logger.debug("obtenerListaArticulos():end");
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

	public RetornoDTO verificaPlanComercialTerminal(ParametrosVerificaPlanComercialDTO parametros) throws ProductException {
		RetornoDTO retValue = null;
		try {
			logger.debug("verificaPlanComercialTerminal():start");
			retValue = DatosGeneralesDAO.verificaPlanComercialTerminal(parametros);
			logger.debug("verificaPlanComercialTerminal():end");
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
	
	public RetornoDTO verificaConcFactGarantia(ParametroDTO parametrosDTO )throws GeneralException{
		RetornoDTO retValue = null;
		try {
			logger.debug("verificaConcFactGarantia():start");
			retValue = DatosGeneralesDAO.verificaConcFactGarantia(parametrosDTO);
			logger.debug("verificaConcFactGarantia():end");
		} catch (GeneralException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
		return retValue;
	}
	
	public RetornoDTO validaSeleccionCausa(ParametrosCambioSerieDTO parametrosCambioSerieDTO )throws GeneralException{
		RetornoDTO retValue = null;
		try {
			logger.debug("validaSeleccionCausa():start");
			retValue = DatosGeneralesDAO.validaSeleccionCausa(parametrosCambioSerieDTO);
			logger.debug("validaSeleccionCausa():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
		return retValue;
	}
	
	public OperadoraLocalDTO obtenerOperadoraLocal()throws GeneralException{
		OperadoraLocalDTO retValue = null;
		try {
			logger.debug("obtenerOperadoraLocal():start");
			retValue = DatosGeneralesDAO.obtenerOperadoraLocal();
			logger.debug("obtenerOperadoraLocal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
		return retValue;
	}

	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws GeneralException	{
		ParametrosGeneralesDTO retValue = null;
		try {
			logger.debug("getParametroGeneral():start");
			retValue = DatosGeneralesDAO.getParametroGeneral(entrada);
			logger.debug("getParametroGeneral():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
		return retValue;
	}
	
	
	public DatosCentralDTO obtenerDatosCentral(int codCentral) throws ProductException {
		DatosCentralDTO retValue = null;
		try {
			logger.debug("obtenerDatosCentral():start");
			retValue = DatosGeneralesDAO.obtenerDatosCentral(codCentral);
			logger.debug("obtenerDatosCentral():end");
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
	
	public String consultarSeguroAbonado(Long numAbonado) throws ProductException{
		String retValue = null;
		try {
			logger.debug("consultarSeguroAbonado():start");
			retValue = DatosGeneralesDAO.consultarSeguroAbonado(numAbonado);
			logger.debug("consultarSeguroAbonado():end");
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
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	public String verificaNumeroDesviado(String numeroDesviado) throws GeneralException{
		String validacionNumero;
		try {
			logger.debug("verificaNumeroDesviado():start");
			validacionNumero = DatosGeneralesDAO.verificaNumeroDesviado(numeroDesviado);
			logger.debug("verificaNumeroDesviado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return validacionNumero;
	}
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL
	
	//INICIO CSR-11002 PAH
	public void cambioUsoSeries(ParametrosVerificaPlanComercialDTO parametros) throws ProductException{
		try {
			logger.debug("cambioUsoSeries():start");
			DatosGeneralesDAO.cambioUsoSeries(parametros);
			logger.debug("cambioUsoSeries():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
	}
	//FIN CSR-11002 PAH

}
