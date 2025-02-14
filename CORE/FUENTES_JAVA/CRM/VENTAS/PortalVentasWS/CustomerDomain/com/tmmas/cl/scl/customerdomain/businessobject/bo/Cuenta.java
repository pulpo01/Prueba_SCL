package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.CuentaDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaCuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CuentaDTO;

public class Cuenta extends Customer
{

	private CuentaDAO cuentaDAO = new CuentaDAO();

	private static Category cat = Category.getInstance(Cuenta.class);

	public CuentaDTO getCuenta(CuentaDTO cuentaDTO) throws CustomerDomainException
	{
		cat.debug("Inicio:getCuenta()");
		CuentaDTO resultado = cuentaDAO.getCuenta(cuentaDTO);
		cat.debug("Fin:getCuenta()");
		return resultado;
	}// fin datosCuenta

	/**
	 * Retorna todos los datos de la cuenta por numero de identificacion
	 * 
	 * @param cuenta
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CuentaDTO getCuentaNumIdent(CuentaDTO cuenta) throws CustomerDomainException
	{
		cat.debug("Inicio:getCuentaNumIdent()");
		CuentaDTO resultado = new CuentaDTO();
		resultado = cuentaDAO.getCuentaNumIdent(cuenta);
		cat.debug("Fin:getCuentaNumIdent()");
		return resultado;
	}// fin getCuentaNumIdent

	public CuentaDTO getSubCuenta(CuentaDTO entrada) throws CustomerDomainException
	{
		CuentaDTO resultado = new CuentaDTO();
		cat.debug("Inicio:getSubCuenta()");
		resultado = cuentaDAO.getSubCuenta(entrada);
		cat.debug("Fin:getSubCuenta()");
		return resultado;
	}

	/**
	 * Verifica si existe la subcuenta para la cuenta que viene como parámetro
	 * 
	 * @param N/A
	 * @return CuentaDTO
	 * @throws CustomerDomainException
	 */

	public CuentaDTO existeSubCuenta(CuentaDTO cuentaDTO) throws CustomerDomainException
	{
		cat.debug("Inicio:existeSubCuenta()");
		CuentaDTO resultado = cuentaDAO.existeSubCuenta(cuentaDTO);
		cat.debug("Fin:existeSubCuenta()");
		return resultado;
	}// fin existeSubCuenta

	/**
	 * Obtiene listado de clasificacion cuenta
	 * 
	 * @param N/A
	 * @return CuentaDTO[]
	 * @throws CustomerDomainException
	 */
	public CuentaDTO[] getListClasificacionCuenta() throws CustomerDomainException
	{
		cat.debug("Inicio:getListClasificacionCuenta()");
		CuentaDTO[] resultado = cuentaDAO.getListClasificacionCuenta();
		cat.debug("Fin:getListClasificacionCuenta()");
		return resultado;
	}// fin getListClasificacionCuenta

	/**
	 * Obtiene listado de cuenta de acuerdo a criterios de búsqueda
	 * 
	 * @param CuentaDTO
	 * @return CuentaDTO[]
	 * @throws CustomerDomainException
	 */
	public CuentaDTO[] getListadoCuenta(CuentaDTO criterioBusquedaCuenta) throws CustomerDomainException
	{
		cat.debug("Inicio:getListadoCuenta()");
		CuentaDTO[] resultado = cuentaDAO.getListadoCuenta(criterioBusquedaCuenta);
		cat.debug("Fin:getListadoCuenta()");
		return resultado;
	}// fin getListadoCuenta

	/**
	 * 
	 * @param CuentaDTO
	 * @return CuentaDTO[]
	 * @throws CustomerDomainException
	 */
	public CuentaDTO[] getCuentas(BusquedaCuentaDTO cuentaDTO) throws CustomerDomainException
	{
		cat.debug("Inicio");
		CuentaDTO[] resultado = cuentaDAO.getCuentas(cuentaDTO);
		cat.debug("Fin");
		return resultado;
	}

	/**
	 * Inserta cuenta
	 * 
	 * @param cuenta
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insCuenta(CuentaDTO cuenta) throws CustomerDomainException
	{
		cat.debug("Inicio:insCuenta()");
		cuentaDAO.insCuenta(cuenta);
		cat.debug("Fin:insCuenta()");
	}// fin insCuenta

	/**
	 * Inserta SubCuenta
	 * 
	 * @param SubCuenta
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insSubCuenta(CuentaDTO cuenta) throws CustomerDomainException
	{
		cat.debug("Inicio:insSubCuenta()");
		cuentaDAO.insSubCuenta(cuenta);
		cat.debug("Fin:insSubCuenta()");
	}// fin insSubCuenta

	/**
	 * Retorna todos los datos de la cuenta
	 * 
	 * @param cuenta
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CuentaDTO getCuentaAll(CuentaDTO cuenta) throws CustomerDomainException
	{
		cat.debug("Inicio:getCuentaAll()");
		CuentaDTO resultado = new CuentaDTO();
		resultado = cuentaDAO.getCuentaAll(cuenta);
		cat.debug("Fin:getCuentaAll()");
		return resultado;
	}// fin getCuentaAll

	/**
	 * Obtiene la categoria de la cuenta
	 * 
	 * @param cuenta
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CuentaDTO getCategoriaCuenta(CuentaDTO cuenta) throws CustomerDomainException
	{
		cat.debug("Inicio:getCategoriaCuenta()");
		CuentaDTO resultado = new CuentaDTO();
		resultado = cuentaDAO.getCategoriaCuenta(cuenta);
		cat.debug("Fin:getCategoriaCuenta()");
		return resultado;
	}// fin getCategoriaCuenta

	/**
	 * Actualiza datos de la cuenta
	 * 
	 * @param SubCuenta
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void actualizaCuenta(CuentaDTO cuenta) throws CustomerDomainException
	{
		cat.debug("Inicio:actualizaCuenta()");
		cuentaDAO.actualizaCuenta(cuenta);
		cat.debug("Fin:actualizaCuenta()");
	}// fin actualizaCuenta

	/**
	 * Elimina cuentas potenciales
	 * 
	 * @param SubCuenta
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void eliminaCuentasPotenciales(CuentaDTO cuenta) throws CustomerDomainException
	{
		cat.debug("Inicio:actualizaCuenta()");
		cuentaDAO.eliminaCuentasPotenciales(cuenta);
		cat.debug("Fin:actualizaCuenta()");
	}// fin eliminaCuentasPotenciales

}// fin Cuenta
