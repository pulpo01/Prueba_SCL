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
package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosGeneralesComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TarjetaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.DatosGeneralesDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class DatosGenerales {

	private DatosGeneralesDAO datosGeneralesDAO  = new DatosGeneralesDAO();
	private static Category cat = Category.getInstance(DatosGenerales.class);

	/**
	 * Obtiene Valor del parametro pasando como filtro el nombre del parametro mas el código de producto y código de módulo.
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws CustomerDomainException
	 */
	
	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO datosGenerales) 
	throws CustomerDomainException {
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
	 * @throws CustomerDomainException
	 */
	public String getCodigoOperadora() 
	throws CustomerDomainException {
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
	 * @throws CustomerDomainException
	 */
	public String getDescripcionOperadora() 
	throws CustomerDomainException {
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
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO getActuacionCentral(DatosGeneralesDTO datosGenerales) 
	throws CustomerDomainException {
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
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO getResultadoTransaccion(DatosGeneralesDTO datosGenerales) 
	throws CustomerDomainException {
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
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO getSecuencia(DatosGeneralesDTO datosGenerales) 
	throws CustomerDomainException {
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
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO[] getListCodigos(DatosGeneralesDTO entrada) throws CustomerDomainException{
		cat.debug("Inicio:getListCodigos()");
		DatosGeneralesDTO[] resultado = datosGeneralesDAO.getListCodigos(entrada);
		cat.debug("Fin:getListCodigos()");
		return resultado;
	}//fin getListCodigos	
	
	/**
	 * Obtiene datos del producto SCL 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO getProducto(DatosGeneralesDTO entrada) 
	throws CustomerDomainException{
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
	throws CustomerDomainException{
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
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO[] getListPaises() 
	throws CustomerDomainException{
		cat.debug("Inicio:getListCodigos()");
		DatosGeneralesDTO[] resultado = datosGeneralesDAO.getListPaises();
		cat.debug("Fin:getListCodigos()");	
		return resultado;
	}//fin getListPaises

	/**
	 * Obtiene listado de actividades
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO[] getListActividades() 
	throws CustomerDomainException{
		cat.debug("Inicio:getListActividades()");
		DatosGeneralesDTO[] resultado = datosGeneralesDAO.getListActividades();
		cat.debug("Fin:getListActividades()");	
		return resultado;
	}//fin getListActividades
	
	
	public NumeroIdentificacionDTO validarIdentificador(NumeroIdentificacionDTO entrada)  
		throws CustomerDomainException
	{
		cat.debug("Inicio:validarIdentificador()");
		NumeroIdentificacionDTO resultado = datosGeneralesDAO.validarIdentificador(entrada);
		cat.debug("Fin:validarIdentificador()");	
		return resultado;		
	}
	
	public TarjetaDTO validarTarjeta(TarjetaDTO entrada)  
		throws CustomerDomainException
	{
		cat.debug("Inicio:validarTarjeta()");
		TarjetaDTO resultado = datosGeneralesDAO.validarTarjeta(entrada);
		cat.debug("Fin:validarTarjeta()");	
		return resultado;		
	}
	//Inicio P-CSR-11002 JLGN 27-05-2011
	public DatosContrato datoslinea(DatosContrato entrada)  
		throws CustomerDomainException
	{
		cat.debug("Inicio:datoslinea()");
		DatosContrato resultado = datosGeneralesDAO.datoslinea(entrada);
		cat.debug("Fin:datoslinea()");	
		return resultado;		
	}
	//Fin P-CSR-11002 JLGN 27-05-2011

	//Fin P-CSR-11002 JLGN 27-05-2011
	//Inicio P-CSR-11002 JLGN 09-06-2011
	public DatosContrato datosPAporLinea(DatosContrato entrada)  
		throws CustomerDomainException
	{
		cat.debug("Inicio:datosPAporLinea()");
		DatosContrato resultado = datosGeneralesDAO.datosPAporLinea(entrada);
		cat.debug("Fin:datosPAporLinea()");	
		return resultado;		
	}
	//Fin P-CSR-11002 JLGN 09-06-2011
	
	//Inicio P-CSR-11002 JLGN 10-06-2011
	public DatosContrato datosSSporLinea(DatosContrato entrada)  
		throws CustomerDomainException
	{
		cat.debug("Inicio:datosSSporLinea()");
		DatosContrato resultado = datosGeneralesDAO.datosSSporLinea(entrada);
		cat.debug("Fin:datosSSporLinea()");	
		return resultado;		
	}
	//Fin P-CSR-11002 JLGN 10-06-2011
	
	//Inicio P-CSR-11002 JLGN 26-07-2011
	public DatosContrato precioTerminal(DatosContrato entrada)  
		throws CustomerDomainException
	{
		cat.debug("Inicio:datoslinea()");
		DatosContrato resultado = datosGeneralesDAO.precioTerminal(entrada);
		cat.debug("Fin:datoslinea()");	
		return resultado;		
	}
	//Fin P-CSR-11002 JLGN 26-07-2011
	
	//Inicio P-CSR-11002 JLGN 18-10-2011
	public String descripcionArticulo(String codArticulo) throws CustomerDomainException {
		cat.debug("Inicio:descripcionArticulo()");
		String resultado = datosGeneralesDAO.descripcionArticulo(codArticulo);
		cat.debug("Fin:descripcionArticulo()");	
		return resultado;		
	}
	//Fin P-CSR-11002 JLGN 18-10-2011
	//Inicio P-CSR-11002 JLGN 10-11-2011
	public void insertRutaContrato(String numVenta, String rutaContrato) throws CustomerDomainException {
		cat.debug("Inicio:insertRutaContrato()");
		datosGeneralesDAO.insertRutaContrato(numVenta, rutaContrato);
		cat.debug("Fin:insertRutaContrato()");
	}
	//Inicio P-CSR-11002 JLGN 11-11-2011
	public String obtenerRutaContrato(long numVenta) throws CustomerDomainException {
		cat.debug("Inicio:obtenerRutaContrato()");
		String resultado = datosGeneralesDAO.obtenerRutaContrato(numVenta);
		cat.debug("Fin:obtenerRutaContrato()");	
		return resultado;		
	}
	//Fin P-CSR-11002 JLGN 11-11-2011
	
	
}//fin CLASS DatosGenerales

