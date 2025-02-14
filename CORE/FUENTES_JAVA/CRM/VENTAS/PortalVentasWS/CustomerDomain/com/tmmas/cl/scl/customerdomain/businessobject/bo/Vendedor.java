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

package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.VendedorDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorOutDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class Vendedor  {
	private VendedorDAO vendedorDAO  = new VendedorDAO();
	private static Category cat = Category.getInstance(Vendedor.class);
	Global global = Global.getInstance();

	public VendedorDTO getVendedor(VendedorDTO vendedor) throws CustomerDomainException {
		VendedorDTO resultado = new VendedorDTO();
		cat.debug("getVendedor():start");
		resultado = vendedorDAO.getVendedor(vendedor);
		cat.debug("getVendedor():end");
		return resultado;
	}//fin getVendedor
	
	public DatosValidacionDTO vendedorNumeroReservado(ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		DatosValidacionDTO resultado = new DatosValidacionDTO();
		cat.debug("vendedorNumeroReservado():start");
		resultado = vendedorDAO.getVendedorNumero(entradaValidacionVentas);
		cat.debug("vendedorNumeroReservado():end");
		return resultado;
	}
	
	public ResultadoValidacionVentaDTO vendedorExisteEnBodegaSimcard(ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = null;
		cat.debug("Inicio:vendedorExisteEnBodegaSimcard()");
		resultado = vendedorDAO.getExisteVendedorEnBodegaSimcard(entradaValidacionVentas);
		if (resultado.getResultadoBase() ==1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase()==0){
			resultado.setResultado(false);
		}
		
		cat.debug("Fin:vendedorExisteEnBodegaSimcard()");
		return resultado;
	}//fin vendedorExisteEnBodegaSimcard

	public ResultadoValidacionVentaDTO vendedorExisteEnBodegaTerminal(ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = null;
		cat.debug("Inicio:vendedorExisteEnBodegaTerminal()");
		resultado = vendedorDAO.getExisteVendedorEnBodegaTerminal(entradaValidacionVentas);
		if (resultado.getResultadoBase() == 1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0){
			resultado.setResultado(false);
		}
		cat.debug("Fin:vendedorExisteEnBodegaTerminal()");
		return resultado;
	}//fin vendedorExisteEnBodegaTerminal

	public void bloquearDesbloquearVendedor(VendedorDTO vendedor) throws CustomerDomainException {
		cat.debug("Inicio:vendedorExisteEnBodegaTerminal()");
		vendedorDAO.setBloqueaDesbloqueaVendedor(vendedor);
		cat.debug("Fin:vendedorExisteEnBodegaTerminal()");
	}//fin bloquearDesbloquearVendedor
	
	public ResultadoValidacionVentaDTO validaCodigoVendedor(VendedorDTO vendedordto) throws CustomerDomainException {
		cat.debug("Inicio:validaCodigoVendedor()");
		ResultadoValidacionVentaDTO resultadovalidacion = vendedorDAO.validaCodigoVendedor(vendedordto);
		cat.debug("Fin:validaCodigoVendedor()");
		return resultadovalidacion;
	}//fin validaCodigoVendedor

	public VendedorDTO verificaVendedorEsExterno (VendedorDTO vendedor) throws CustomerDomainException {
		VendedorDTO resultado = new VendedorDTO();
		cat.debug("verificaVendedorEsExterno():start");
		resultado = vendedorDAO.verificaVendedorEsExterno(vendedor);
		cat.debug("verificaVendedorEsExterno():end");
		return resultado;
	}//fin getVendedor
	
	
	/**
	 * Obtiene rango de descuentos asignados al vendedor
	 * @param vendedor
	 * @return vendedor
	 * @throws CustomerDomainException
	 */
	public VendedorDTO getRangoDescuento(VendedorDTO vendedor) throws CustomerDomainException{
		cat.debug("getRangoDescuento():start");
		vendedorDAO.getRangoDescuento(vendedor);
		cat.debug("getRangoDescuento():end");
		return vendedor;
	}//fin getRangoDescuento
	
	/**
	 * Obtiene listado de tipos de comisionistas
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws CustomerDomainException
	 */
	public VendedorDTO[] getListTiposComisionistas() 
	throws CustomerDomainException{
		cat.debug("Inicio:getListTiposComisionistas()");
		VendedorDTO[] resultado = vendedorDAO.getListTiposComisionistas();
		cat.debug("Fin:getListTiposComisionistas()");
		return resultado;		
	}//fin getListTiposComisionistas
	
	/**
	 * Verifica si el home del vendedor corresponde al home del celular
	 * @param vendedor
	 * @return VendedorDTO
	 * @throws CustomerDomainException
	 */	
	public VendedorDTO validaHomeVendCel(VendedorDTO vendedor) 
	throws CustomerDomainException{
		cat.debug("Inicio:validaHomeVendCel()");
		VendedorDTO resultado = vendedorDAO.validaHomeVendCel(vendedor);
		cat.debug("Fin:validaHomeVendCel()");
		return resultado;		
	}//fin validaHomeVendCel

	/**
	 * Verifica si el home del vendedor corresponde al home del celular
	 * @param vendedor
	 * @return VendedorDTO
	 * @throws CustomerDomainException
	 */	
	public VendedorOutDTO lstVendedor(VendedorDTO vendedor) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:validaHomeVendCel()");
		VendedorOutDTO resultado = vendedorDAO.lstVendedor(vendedor);
		cat.debug("Fin:validaHomeVendCel()");
		return resultado;		
	}//fin validaHomeVendCel
	
	/**
	 * Busca listado de vendedores asociados a una oficina y un tipo
	 * comisionista
	 * @param vendedor
	 * @return resultado
	 * @throws CustomerDomainException
	 */	
	public VendedorDTO[] getListadoVendedores(VendedorDTO vendedor) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListadoVendedores()");
		VendedorDTO[] resultado = vendedorDAO.getListadoVendedores(vendedor);
		cat.debug("Fin:getListadoVendedores()");
		return resultado;		
	}//fin getListadoVendedores
	
	/**
	 * Busca listado de vendedores dealer asociados 
	 * a un dealer (vendedor externo)
	 * @param vendedor
	 * @return resultado
	 * @throws CustomerDomainException
	 */	
	public VendedorDTO[] getListadoVendedoresDealer(VendedorDTO vendedor) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListadoVendedoresDealer()");
		VendedorDTO[] resultado = vendedorDAO.getListadoVendedoresDealer(vendedor);
		cat.debug("Fin:getListadoVendedoresDealer()");
		return resultado;		
	}//fin getListadoVendedoresDealer
	
	/**
	 * Busca listado de vendedores asociados a una oficina y un tipo
	 * comisionista
	 * @param vendedor
	 * @return resultado
	 * @throws CustomerDomainException
	 */	
	public VendedorDTO[] getListadoVendedoresXOficina(VendedorDTO vendedor) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListadoVendedoresXOficina()");
		VendedorDTO[] resultado = vendedorDAO.getListadoVendedoresXOficina(vendedor);
		cat.debug("Fin:getListadoVendedoresXOficina()");
		return resultado;		
	}//fin getListadoVendedores
	
	/**
	 * Busca listado de vendedores asociados a una oficina y un tipo
	 * comisionista
	 * @param vendedor
	 * @return resultado
	 * @throws CustomerDomainException
	 */	
	public VendedorDTO buscarVendedor(VendedorDTO vendedor) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:buscarVendedor()");
		VendedorDTO resultado = vendedorDAO.buscarVendedor(vendedor);
		cat.debug("Fin:buscarVendedor()");
		return resultado;		
	}//fin buscarVendedor

	/**
	 * @param codVendedor
	 * @return
	 * @throws CustomerDomainException
	 * @see com.tmmas.cl.scl.customerdomain.businessobject.dao.VendedorDAO#validaVendedorLN(java.lang.String)
	 */
	public Boolean validaVendedorLN(String codVendedor) throws CustomerDomainException {
		cat.debug("Inicio");
		Boolean r = vendedorDAO.validaVendedorLN(codVendedor);
		cat.debug("Fin");
		return r;
	} // validaVendedorLN

	/**
	 * @param codVendedorDealer
	 * @return
	 * @throws CustomerDomainException
	 * @see com.tmmas.cl.scl.customerdomain.businessobject.dao.VendedorDAO#validaVendedorDealerLN(java.lang.String)
	 */
	public Boolean validaVendedorDealerLN(String codVendedorDealer) throws CustomerDomainException {
		cat.debug("Inicio");
		Boolean r = vendedorDAO.validaVendedorDealerLN(codVendedorDealer);
		cat.debug("Fin");
		return r;
	}
	
}//fin class Vendedor


