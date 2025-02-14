package com.tmmas.cl.scl.gestiondefacturacion.service.servicios;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.TerminalBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.ConceptosCobranzaBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.DocumentoBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.FacturacionBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.RegistroFacturacionBO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DatosComercialesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DocumentoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DocumentoFacturacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCicloFactInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCicloFactOutDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.bo.DatosGeneralesBO;

public class GestionDeFacturacionSrv {
	
	private CompositeConfiguration config;

	private FacturacionBO          facturacionBO         = new FacturacionBO();
	private ConceptosCobranzaBO    cobranzaBO            = new ConceptosCobranzaBO();
	private DocumentoBO            BODocumento           = new DocumentoBO();
	private RegistroFacturacionBO  bORegistroFacturacion = new RegistroFacturacionBO();
	
	
	private final Logger logger = Logger.getLogger(GestionDeFacturacionSrv.class);
	
	public GestionDeFacturacionSrv() {
		System.out.println("GestionDeFacturacionSrv(): Start");
		config = UtilProperty.getConfiguration("GestionDeFacturacionSrv.properties","com/tmmas/cl/scl/gestiondefacturacion/service/properties/GestionDeFacturacion.properties");
		System.out.println("GestionDeFacturacionSrv.log ["+config.getString("GestionDeFacturacionSrv.log")+"]");
		UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));
		logger.debug("GestionDeFacturacionSrv():End");
	}	
	
	
	public WsListCicloFactOutDTO getListadoCiclosPostPago(WsCicloFactInDTO cicloFactDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));		
		logger.debug("Inicio:getListadoCiclosPostPago()");
		WsListCicloFactOutDTO resultado = null;
		try {
			UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));
			resultado = facturacionBO.getListadoCiclosPostPago(cicloFactDTO);
			UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));		
		}
		catch (GeneralException e) {
			logger.debug("getListadoCiclosPostPago:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		} 
		catch (Exception e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getListadoCiclosPostPago()");
		return resultado;
		
	}
	
	
	public  RetornoDTO getInformacionPrecio(ArticuloDTO articuloDTO, ParametrosDescuentoDTO entrada) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));		
		logger.debug("Inicio:getInformacionPrecio()");
		RetornoDTO resultado = null;
		DescuentoDTO[] resul2;
		try {
			UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));
			resultado = cobranzaBO.getInformacionPrecio(articuloDTO);
			UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));
			
		/*	resul2 = terminalBO.getDescuentoCargo(entrada);
			
			if(resul2.length < 1){
				logger.debug("no existen descuento configurados");
				
			}else{				
				
				if (resul2[0].getTipoAplicacion().equals("1")){
					logger.debug("Desceunto por porcentaje");
					logger.debug("Valor ["+resultado.getResultadoTransaccion()+"]");
					logger.debug("Descuento ["+resul2[0].getMonto()+"]");
					float f = Float.valueOf(resultado.getResultadoTransaccion().trim()).floatValue() - (Float.valueOf(resultado.getResultadoTransaccion().trim()).floatValue()*(resul2[0].getMonto()/100));
					resultado.setResultadoTransaccion(String.valueOf(f));
					
					 logger.debug("resultado ["+resultado.getResultadoTransaccion()+"]");
				}else{					
					logger.debug("Desceunto por valor");
					logger.debug("Valor ["+resultado.getResultadoTransaccion()+"]");
					logger.debug("Descuento ["+resul2[0].getMonto()+"]");
					
					 float f = Float.valueOf(resultado.getResultadoTransaccion().trim()).floatValue() - resul2[0].getMonto();				      					
					 resultado.setResultadoTransaccion(String.valueOf(f));
					 
					 logger.debug("resultado ["+resultado.getResultadoTransaccion()+"]");
				}
			}
		*/	
		}
		catch (GeneralException e) {
			logger.debug("getInformacionPrecio:end");
			logger.debug("GeneralException");
			throw e;
		} 
		catch (Exception e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getInformacionPrecio()");
		return resultado;
	}
	
	
	public DocumentoFacturacionDTO getPromedioDocumentosFacturados(DocumentoFacturacionDTO datos) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));		
		logger.debug("Inicio:getPromedioDocumentosFacturados()");
		DocumentoFacturacionDTO resultado = null;
		try {
			UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));
			resultado = BODocumento.getPromedioDocumentosFacturados(datos);
			UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));		
		}
		catch (GeneralException e) {
			logger.debug("getPromedioDocumentosFacturados:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		} 
		catch (Exception e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getPromedioDocumentosFacturados()");
		return resultado;
		
	}
	
	public DocumentoDTO[] getListadoTipoDocumento(DatosComercialesDTO datos) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));		
		logger.debug("Inicio:getListadoTipoDocumento()");
		DocumentoDTO[] resultado = null;
		try {
			UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));
			 resultado = BODocumento.getListadoTipoDocumento(datos);
			UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));		
		}
		catch (GeneralException e) {
			logger.debug("getListadoTipoDocumento:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		} 
		catch (Exception e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getListadoTipoDocumento()");
		return resultado;
		
	}	
	
	public RegistroFacturacionDTO getCodigoPromedioFacturado(RegistroFacturacionDTO datos) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));		
		logger.debug("Inicio:getCodigoPromedioFacturado()");
		RegistroFacturacionDTO resultado = null;
		try {
			UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));
			 resultado = bORegistroFacturacion.getCodigoPromedioFacturado(datos);
			UtilLog.setLog(config.getString("GestionDeFacturacionSrv.log"));		
		}
		catch (GeneralException e) {
			logger.debug("getCodigoPromedioFacturado:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		} 
		catch (Exception e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getListadoTipoDocumento()");
		return resultado;
		
	}		
	
}
