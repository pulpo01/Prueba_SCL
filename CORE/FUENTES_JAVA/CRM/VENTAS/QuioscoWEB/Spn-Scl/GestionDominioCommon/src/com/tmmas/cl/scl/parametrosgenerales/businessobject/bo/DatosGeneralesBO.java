/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/03/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.parametrosgenerales.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsNumeroSerieInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsNumeroSerieOutDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dao.DatosGeneralesDAO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.EstadoCivilDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.OcupacionDTO;

public class DatosGeneralesBO {

	private DatosGeneralesDAO datosGeneralesDAO  = new DatosGeneralesDAO();
	private static Category cat = Category.getInstance(DatosGeneralesBO.class);

	/**
	 * Obtiene Valor del parametro pasando como filtro el nombre del parametro mas el código de producto y código de módulo.
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws CustomerDomainException
	 */
	
	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO datosGenerales) 
	throws GeneralException {
		DatosGeneralesDTO resultado = new DatosGeneralesDTO();
		cat.debug("Inicio:getValorParametro()");
		resultado = datosGeneralesDAO.getValorParametro(datosGenerales);
		cat.debug("Fin:getValorParametro");
		return resultado;
	}

	/**
	 * Obtiene codigo de la operadora
	 * @param N/A
	 * @return string
	 * @throws GeneralException
	 */
	public String getCodigoOperadora() 
	throws GeneralException {
		String resultado = null;
		cat.debug("Inicio:getCodigoOperadora()");
		resultado = datosGeneralesDAO.getCodigoOperadora();
		cat.debug("Fin:getCodigoOperadora");
		return resultado;
	}//fin getCodigoOperadora
	
	/**
	 * Obtiene descripción de la operadora
	 * @param N/A
	 * @return string
	 * @throws GeneralException
	 */
	public String getDescripcionOperadora() 
	throws GeneralException {
		String resultado = null;
		cat.debug("Inicio:getDescripcionOperadora()");
		resultado = datosGeneralesDAO.getDescripcionOperadora();
		cat.debug("Fin:getDescripcionOperadora");
		return resultado;
	}//fin getDescripcionOperadora


	/**
	 * Obtiene actuacion en central para la actuacion del abonado
	 * @param datosGenerales
	 * @return resultado
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO getActuacionCentral(DatosGeneralesDTO datosGenerales) 
	throws GeneralException {
		DatosGeneralesDTO resultado = new DatosGeneralesDTO();
		cat.debug("Inicio:getActuacionCentral()");
		resultado = datosGeneralesDAO.getActuacionCentral(datosGenerales);
		cat.debug("Fin:getActuacionCentral");
		return resultado;
	}//fin getActuacionCentral

	/**
	 * Obtiene resultado de la transaccion
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO getResultadoTransaccion(DatosGeneralesDTO datosGenerales) 
	throws GeneralException {
		DatosGeneralesDTO resultado = new DatosGeneralesDTO();
		cat.debug("Inicio:getResultadoTransaccion()");
		resultado = datosGeneralesDAO.getResultadoTransaccion(datosGenerales);
		cat.debug("Fin:getResultadoTransaccion");
		return resultado;
	}//fin getResultadoTransaccion
	
	/**
	 * Obtiene secuencia
	 * @param datosGenerales
	 * @return resultado
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO getSecuencia(DatosGeneralesDTO datosGenerales) 
	throws GeneralException {
		DatosGeneralesDTO resultado = new DatosGeneralesDTO();
		cat.debug("Inicio:getSecuencia()");
		resultado = datosGeneralesDAO.getSecuencia(datosGenerales);
		cat.debug("Fin:getSecuencia");
		return resultado;
	}//fin getSecuencia

	/**
	 * Obtiene lista de codigos 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO[] getListCodigos(DatosGeneralesDTO entrada) throws GeneralException{
		cat.debug("Inicio:getListCodigos()");
		DatosGeneralesDTO[] resultado = datosGeneralesDAO.getListCodigos(entrada);
		cat.debug("Fin:getListCodigos()");
		return resultado;
	}//fin getListCodigos	
	
	/**
	 * Obtiene datos del producto SCL 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO getProducto(DatosGeneralesDTO entrada) 
	throws GeneralException{
		DatosGeneralesDTO resultado = new DatosGeneralesDTO();
		cat.debug("Inicio:getProducto()");
		resultado = datosGeneralesDAO.getProducto(entrada); 
		cat.debug("Fin:getProducto()");
		return resultado;
	}//fin 	getProducto

	/**
	 * Obtiene valor de columna de la tabla GA_DATOSGENER
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DatosGeneralesDTO getDatosGener(DatosGeneralesDTO entrada) 
	throws GeneralException{
		DatosGeneralesDTO resultado = new DatosGeneralesDTO();
		cat.debug("Inicio:getDatosGener()");
		resultado = datosGeneralesDAO.getDatosGener(entrada); 
		cat.debug("Fin:getDatosGener()");
		return resultado;		
	}//fin getDatosGener

	/**
	 * Obtiene listado de paises
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO[] getListPaises() 
	throws GeneralException{
		cat.debug("Inicio:getListCodigos()");
		DatosGeneralesDTO[] resultado = datosGeneralesDAO.getListPaises();
		cat.debug("Fin:getListCodigos()");	
		return resultado;
	}//fin getListPaises

	/**
	 * Obtiene listado de actividades
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO[] getListActividades() 
	throws GeneralException{
		cat.debug("Inicio:getListActividades()");
		DatosGeneralesDTO[] resultado = datosGeneralesDAO.getListActividades();
		cat.debug("Fin:getListActividades()");	
		return resultado;
	}//fin getListActividades
	
	/**
	 * Valida Numero Identificador ingresado
	 * @param datosGeneralesDTO
	 * @return resultado
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO validaIdentificador(DatosGeneralesDTO datosGeneralesDTO) 
	throws GeneralException{
		cat.debug("Inicio:validaIdentificador()");
		DatosGeneralesDTO resultado = datosGeneralesDAO.validaIdentificador(datosGeneralesDTO);
		cat.debug("Fin:validaIdentificador()");	
		return resultado;
	}//fin getListActividades
	
	
	public WsNumeroSerieOutDTO getInformacionBodegaArticuloSerie(WsNumeroSerieInDTO wsNumeroSerieInDTO) throws GeneralException{
		WsNumeroSerieOutDTO retValue=null;
		try{
			retValue=datosGeneralesDAO.getInformacionBodegaArticuloSerie(wsNumeroSerieInDTO);
		}catch(GeneralException e){
			cat.debug("GeneralException ["+e.getStackTrace()+"]");
			throw(e);
		}
		return retValue;
	}
	
	/**
	 * Lista las ocupaciones configuradas en la BD
	 * @return
	 * @throws GeneralException
	 */
	public OcupacionDTO[] getListaOcupaciones() 
	throws GeneralException{
		OcupacionDTO[] ocupacionDTOs = null;
		try{
			ocupacionDTOs=datosGeneralesDAO.getListaOcupaciones();
		}catch(GeneralException e){
			cat.debug("GeneralException ["+e.getStackTrace()+"]");
			throw(e);
		}
		return ocupacionDTOs;
	}
	
	/**
	 * Lista las ocupaciones configuradas en la BD
	 * @return
	 * @throws GeneralException
	 */
	public EstadoCivilDTO[] getListaEstadoCivil() throws GeneralException{
		EstadoCivilDTO[] estadoCivilDTOs = null;
		try{
			estadoCivilDTOs = datosGeneralesDAO.getListaEstadoCivil();
		}catch(GeneralException e){
			cat.debug("GeneralException ["+e.getStackTrace()+"]");
			throw(e);
		}
		return estadoCivilDTOs;
	}
	
	/**
	 * Lista las ocupaciones configuradas en la BD
	 * @return
	 * @throws GeneralException
	 */
	public EstadoDTO[] getListaEstados() throws GeneralException{
		EstadoDTO[] estadoDTOs = null;
		try{
			estadoDTOs = datosGeneralesDAO.getListaEstados();
			cat.debug("variable retorno estado: "+ estadoDTOs[1].getCodigoEstado());
			cat.debug("variable retorno descripcion estado: "+ estadoDTOs[1].getDescripcionEstado());
			
		}catch(GeneralException e){
			cat.debug("GeneralException ["+e.getStackTrace()+"]");
			throw(e);
		}
		return estadoDTOs;
	}

}//fin CLASS DatosGenerales