package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Category;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.VendedorIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.VendedorDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.VendedorDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;


public class Vendedor implements VendedorIT {
	private VendedorDAOIT vendedorDAO = new VendedorDAO();
	
	private static Category cat = Category.getInstance(Vendedor.class);
	Global global = Global.getInstance();

	public VendedorDTO getVendedor(VendedorDTO vendedor) throws CustomerBillException {
		VendedorDTO resultado = new VendedorDTO();
		cat.debug("getVendedor():start");
		resultado = vendedorDAO.getVendedor(vendedor);
		cat.debug("getVendedor():end");
		return resultado;
	}//fin getVendedor
	
	/*public DatosValidacionDTO vendedorNumeroReservado(ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		DatosValidacionDTO resultado = new DatosValidacionDTO();
		cat.debug("vendedorNumeroReservado():start");
		resultado = vendedorDAO.getVendedorNumero(entradaValidacionVentas);
		cat.debug("vendedorNumeroReservado():end");
		return resultado;
	}*/
	
	/*public ResultadoValidacionVentaDTO vendedorExisteEnBodegaSimcard(ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
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
	}//fin vendedorExisteEnBodegaSimcard*/

	/*public ResultadoValidacionVentaDTO vendedorExisteEnBodegaTerminal(ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
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
	}//fin vendedorExisteEnBodegaTerminal*/

	/*public void bloquearDesbloquearVendedor(VendedorDTO vendedor) throws CustomerDomainException {
		cat.debug("Inicio:vendedorExisteEnBodegaTerminal()");
		vendedorDAO.setBloqueaDesbloqueaVendedor(vendedor);
		cat.debug("Fin:vendedorExisteEnBodegaTerminal()");
	}//fin bloquearDesbloquearVendedor*/
	
	/*public ResultadoValidacionVentaDTO validaCodigoVendedor(VendedorDTO vendedordto) throws CustomerDomainException {
		cat.debug("Inicio:validaCodigoVendedor()");
		ResultadoValidacionVentaDTO resultadovalidacion = vendedorDAO.validaCodigoVendedor(vendedordto);
		cat.debug("Fin:validaCodigoVendedor()");
		return resultadovalidacion;
	}//fin validaCodigoVendedor*/

	public VendedorDTO verificaVendedorEsExterno (VendedorDTO vendedor) throws CustomerBillException {
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
	public VendedorDTO getRangoDescuento(VendedorDTO vendedor) throws CustomerBillException{
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
	/*public VendedorDTO[] getListTiposComisionistas() 
	throws CustomerDomainException{
		cat.debug("Inicio:getListTiposComisionistas()");
		VendedorDTO[] resultado = vendedorDAO.getListTiposComisionistas();
		cat.debug("Fin:getListTiposComisionistas()");
		return resultado;		
	}//fin getListTiposComisionistas*/
	
}//fin class Vendedor
