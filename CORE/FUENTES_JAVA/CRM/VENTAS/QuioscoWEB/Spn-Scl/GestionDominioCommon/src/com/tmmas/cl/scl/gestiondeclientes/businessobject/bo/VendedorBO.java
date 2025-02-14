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
 * 19/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DatosValidacionDTO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.VendedorDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ArticuloResDesInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.BodegaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloImeiInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloImeiOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloResDesOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloVendedorOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCausalesVentasOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoComisionistaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsOficinaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsVendedorStockInDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;


public class VendedorBO  {
	private VendedorDAO vendedorDAO  = new VendedorDAO();
	private final Logger logger = Logger.getLogger(VendedorBO.class);
	Global global = Global.getInstance();

	public VendedorDTO getVendedor(VendedorDTO vendedor) throws GeneralException {
		VendedorDTO resultado = new VendedorDTO();
		logger.debug("getVendedor():start");
		resultado = vendedorDAO.getVendedor(vendedor);
		logger.debug("getVendedor():end");
		return resultado;
	}//fin getVendedor
	
	public DatosValidacionDTO vendedorNumeroReservado(ParametrosValidacionVentasDTO entradaValidacionVentas) throws GeneralException {
		DatosValidacionDTO resultado = new DatosValidacionDTO();
		logger.debug("vendedorNumeroReservado():start");
		resultado = vendedorDAO.getVendedorNumero(entradaValidacionVentas);
		logger.debug("vendedorNumeroReservado():end");
		return resultado;
	}
	
	public ResultadoValidacionVentaDTO vendedorExisteEnBodegaSimcard(ParametrosValidacionVentasDTO entradaValidacionVentas) throws GeneralException {
		ResultadoValidacionVentaDTO resultado = null;
		logger.debug("Inicio:vendedorExisteEnBodegaSimcard()");
		resultado = vendedorDAO.getExisteVendedorEnBodegaSimcard(entradaValidacionVentas);
		if (resultado.getResultadoBase() ==1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase()==0){
			resultado.setResultado(false);
		}
		
		logger.debug("Fin:vendedorExisteEnBodegaSimcard()");
		return resultado;
	}//fin vendedorExisteEnBodegaSimcard

	public ResultadoValidacionVentaDTO vendedorExisteEnBodegaTerminal(ParametrosValidacionVentasDTO entradaValidacionVentas) throws GeneralException {
		ResultadoValidacionVentaDTO resultado = null;
		logger.debug("Inicio:vendedorExisteEnBodegaTerminal()");
		resultado = vendedorDAO.getExisteVendedorEnBodegaTerminal(entradaValidacionVentas);
		if (resultado.getResultadoBase() == 1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0){
			resultado.setResultado(false);
		}
		logger.debug("Fin:vendedorExisteEnBodegaTerminal()");
		return resultado;
	}//fin vendedorExisteEnBodegaTerminal

	public void bloquearDesbloquearVendedor(VendedorDTO vendedor) throws GeneralException {
		logger.debug("Inicio:bloquearDesbloquearVendedor()");
		vendedorDAO.setBloqueaDesbloqueaVendedor(vendedor);
		logger.debug("Fin:bloquearDesbloquearVendedor()");
	}//fin bloquearDesbloquearVendedor
	
	public ResultadoValidacionVentaDTO validaCodigoVendedor(VendedorDTO vendedordto) throws GeneralException {
		logger.debug("Inicio:validaCodigoVendedor()");
		ResultadoValidacionVentaDTO resultadovalidacion = vendedorDAO.validaCodigoVendedor(vendedordto);
		logger.debug("Fin:validaCodigoVendedor()");
		return resultadovalidacion;
	}//fin validaCodigoVendedor

	public VendedorDTO verificaVendedorEsExterno (VendedorDTO vendedor) throws GeneralException {
		VendedorDTO resultado = new VendedorDTO();
		logger.debug("verificaVendedorEsExterno():start");
		resultado = vendedorDAO.verificaVendedorEsExterno(vendedor);
		logger.debug("verificaVendedorEsExterno():end");
		return resultado;
	}//fin getVendedor
	
	
	/**
	 * Obtiene rango de descuentos asignados al vendedor
	 * @param vendedor
	 * @return vendedor
	 * @throws GeneralException
	 */
	public VendedorDTO getRangoDescuento(VendedorDTO vendedor) throws GeneralException{
		logger.debug("getRangoDescuento():start");
		vendedorDAO.getRangoDescuento(vendedor);
		logger.debug("getRangoDescuento():end");
		return vendedor;
	}//fin getRangoDescuento
	
	public WsListadoCausalesVentasOutDTO getListadoMotivosDescuentosManuales(String CodigoUso) throws GeneralException{
		WsListadoCausalesVentasOutDTO resultado=null;
		try{
			logger.debug("Inicio:getListadoMotivosDescuentosManuales()");
			resultado = vendedorDAO.getListadoMotivosDescuentosManuales(CodigoUso);
			logger.debug("Fin:getListadoMotivosDescuentosManuales()");
			return resultado;		
		}catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
	}//fin getListadoMotivosDescuentosManuales
	
	/**
	 * Obtiene listado de tipos de comisionistas
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws GeneralException
	 */
	public VendedorDTO[] getListTiposComisionistas() 
	throws GeneralException{
		logger.debug("Inicio:getListTiposComisionistas()");
		VendedorDTO[] resultado = vendedorDAO.getListTiposComisionistas();
		logger.debug("Fin:getListTiposComisionistas()");
		return resultado;		
	}//fin getListTiposComisionistas

	/**
	 * Verifica si el home del vendedor corresponde al home del celular
	 * @param vendedor
	 * @return VendedorDTO
	 * @throws GeneralException
	 */	
	public VendedorDTO validaHomeVendCel(VendedorDTO vendedor) 
	throws GeneralException{
		logger.debug("Inicio:validaHomeVendCel()");
		VendedorDTO resultado = vendedorDAO.validaHomeVendCel(vendedor);
		logger.debug("Fin:validaHomeVendCel()");
		return resultado;		
	}//fin validaHomeVendCel
	
	/**
	 * Busca listado de vendedores asociados a una oficina y un tipo
	 * comisionista
	 * @param vendedor
	 * @return resultado
	 * @throws GeneralException
	 */	
	public VendedorDTO[] getListadoVendedores(VendedorDTO vendedor) 
	throws GeneralException{
		logger.debug("Inicio:getListadoVendedores()");
		VendedorDTO[] resultado = vendedorDAO.getListadoVendedores(vendedor);
		logger.debug("Fin:getListadoVendedores()");
		return resultado;		
	}//fin getListadoVendedores
	
	/**
	 * Busca listado de vendedores dealer asociados 
	 * a un dealer (vendedor externo)
	 * @param vendedor
	 * @return resultado
	 * @throws GeneralException
	 */	
	public VendedorDTO[] getListadoVendedoresDealer(VendedorDTO vendedor) 
	throws GeneralException{
		logger.debug("Inicio:getListadoVendedoresDealer()");
		VendedorDTO[] resultado = vendedorDAO.getListadoVendedoresDealer(vendedor);
		logger.debug("Fin:getListadoVendedoresDealer()");
		return resultado;		
	}//fin getListadoVendedoresDealer
	
	/**
	 * Busca listado de vendedores asociados a una oficina y un tipo
	 * comisionista
	 * @param vendedor
	 * @return resultado
	 * @throws GeneralException
	 */	
	public VendedorDTO[] getListadoVendedoresXOficina(VendedorDTO vendedor) 
		throws GeneralException
	{
		logger.debug("Inicio:getListadoVendedoresXOficina()");
		VendedorDTO[] resultado = vendedorDAO.getListadoVendedoresXOficina(vendedor);
		logger.debug("Fin:getListadoVendedoresXOficina()");
		return resultado;		
	}//fin getListadoVendedores
	
	/**
	 * Busca listado de articulos asociados a un vendedor
	 * @param vendedor
	 * @return resultado
	 * @throws GeneralException
	 */	
	public WsArticuloVendedorOutDTO[] getArticulosPorVendedor(WsVendedorStockInDTO vendedorStockDTO) 
		throws GeneralException
	{
		WsArticuloVendedorOutDTO[] retValue=null;
		try{
			logger.debug("Inicio:getArticulosPorVendedor()");
			String indInterno=vendedorStockDTO.getIndInterno();
			if ("0".equals(indInterno)){
				long codVendedorRaiz=0;
				codVendedorRaiz=vendedorDAO.getCodVendedorRaizPorCodVendedor(vendedorStockDTO);
				vendedorStockDTO.setCodVendedor(codVendedorRaiz);
				retValue = vendedorDAO.getArticulosPorVendedor(vendedorStockDTO);
			}else if ("1".equals(indInterno)){
				retValue = vendedorDAO.getArticulosPorVendedor(vendedorStockDTO);
			}else{
				logger.debug("codigo de error ["+3+"] \\nMensaje [Error el indicador de interno debe ser 0 o 1]");
				throw new GeneralException("3",0,"Error el indicador de interno debe ser 0 o 1");
			}
			logger.debug("Fin:getArticulosPorVendedor()");
		}
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;		
	}//fin getListadoVendedores
	
	/**
	 * Busca Obtener Articulo Por Imei
	 * @param vendedor
	 * @return resultado
	 * @throws GeneralException
	 */	
	public WsArticuloImeiOutDTO getArticuloPorImei(WsArticuloImeiInDTO inWSLstNumSerieDTO)
	throws GeneralException
	{
		WsArticuloImeiOutDTO retValue=null;
		try{
			logger.debug("Inicio:getArticuloPorImei()");
			retValue = vendedorDAO.getArticuloPorImei(inWSLstNumSerieDTO);
			logger.debug("Fin:getArticuloPorImei()");
		}
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;		
	}//fin getArticuloPorImei	
	
	public VendedorDTO[] getListadoVendedoresXOficinaEIndicador(VendedorDTO vendedorDTO)throws GeneralException{
		VendedorDTO[] resultado=null;
		try{
			logger.debug("Inicio:getListadoVendedoresXOficina()");
			resultado = vendedorDAO.getListadoVendedoresXOficinaEIndicador(vendedorDTO);
			logger.debug("Fin:getListadoVendedoresXOficina()");
			return resultado;		
		}catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}//fin getListadoVendedores
	
	public VendedorDTO[] getListadoVendedoresXTipo(VendedorDTO vendedorDTO) throws GeneralException{
		VendedorDTO[] resultado=null;
		try{
			logger.debug("Inicio:getListadoVendedoresXTipo()");
			resultado = vendedorDAO.getListadoVendedoresXTipo(vendedorDTO);
			logger.debug("Fin:getListadoVendedoresXTipo()");
			return resultado;		
		}catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}//fin getListadoVendedoresXTipo
	
	public WsListTipoComisionistaOutDTO getListadoComisionistasXOficina(WsOficinaInDTO wsOficinaInDTO) throws GeneralException{
		WsListTipoComisionistaOutDTO resultado=null;
		try{
			logger.debug("Inicio:getListadoComisionistasXOficina()");
			resultado = vendedorDAO.getListadoComisionistasXOficina(wsOficinaInDTO);
			logger.debug("Fin:getListadoComisionistasXOficina()");
			return resultado;		
		}catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
	}
	
	public WsArticuloResDesOutDTO reservaDesreserva(ArticuloResDesInDTO articuloDTO) throws GeneralException{
		WsArticuloResDesOutDTO resultado=null;
		try{
			logger.debug("Inicio:reservaDesreserva()");
			resultado = vendedorDAO.reservaDesreserva(articuloDTO);
			logger.debug("Fin:reservaDesreserva()");
			return resultado;
		}catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
	}
	
	
	public BodegaDTO[] getBodegasPorVendedor(String codigoVendedor) throws GeneralException{	
		BodegaDTO[] resultado=null;
		try{
			logger.debug("Inicio:getBodegasPorVendedor()");
			resultado = vendedorDAO.getBodegasPorVendedor(codigoVendedor);
			logger.debug("Fin:getBodegasPorVendedor()");
			return resultado;
		}catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
	}
		
}//fin class Vendedor
