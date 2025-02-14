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
 * 20/04/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.DetalleCargosSolicitudDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetalleLineaSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConversionMonetariaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.RegistroCargosDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroCargosDTO;

public class RegistroCargos {
	
	private RegistroCargosDAO registroCargosDAO  = new RegistroCargosDAO();
	private static Category cat = Category.getInstance(RegistroCargos.class);
	
	/**
	 * Registra Cargo de la venta
	 * @param cargo
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void registraCargo(RegistroCargosDTO cargo) 
		throws CustomerDomainException 
	{
		cat.debug("registraCargo():start");
		registroCargosDAO.registraCargo(cargo);
		cat.debug("registraCargo():end");
	}
	
	/**
	 * Obtiene Secuencia del Cargo
	 * @param cargo
	 * @return 
	 * @throws CustomerDomainException
	 */
	
	public RegistroCargosDTO getSecuenciaCargo(RegistroCargosDTO entrada)
		throws CustomerDomainException
	{
		RegistroCargosDTO resultado = new RegistroCargosDTO();
		cat.debug("Inicio:getSecuenciaCargo()");
		resultado =registroCargosDAO.getSecuenciaCargo(entrada);
		cat.debug("Fin:getSecuenciaCargo()");
		return resultado;
	}
	
	/**
	 * Obtiene cantidad de cargos por venta
	 * @param cargo
	 * @return 
	 * @throws CustomerDomainException
	 */
	
	public Long getCantidadCargosXVenta(Long numVenta)
		throws CustomerDomainException
	{
		cat.debug("Inicio:getCantidadCargosXVenta()");
		Long resultado =registroCargosDAO.getCantidadCargosXVenta(numVenta);
		cat.debug("Fin:getCantidadCargosXVenta()");
		return resultado;
	}
	
	/**
	 * Inserta cargos modificados producto del override 
	 * @param cargo
	 * @return 
	 * @throws CustomerDomainException
	 */
	
	public void insertaCargosOverride(DetalleCargosSolicitudDTO entrada)
		throws CustomerDomainException
	{
		cat.info("insertaCargosOverride, inicio");
		registroCargosDAO.insertaCargosOverride(entrada);
		cat.info("insertaCargosOverride, fin");		
	}

	/**
	 * Recupera los cargos sobreescritos para la venta especificada
	 * @author JIB
	 * @param numVenta
	 * @return
	 * @throws CustomerDomainException
	 */
	public DetalleCargosSolicitudDTO[] recuperaCargosOverride(Long numVenta, String codOrigenTransaccion) 
		throws CustomerDomainException 
	{
		cat.debug("Inicio: recuperaCargosOverride()");
		DetalleCargosSolicitudDTO[] r = registroCargosDAO.recuperaCargosOverride(numVenta, codOrigenTransaccion);
		cat.debug("Fin: recuperaCargosOverride()");
		return r;
	}

	
	public Float convertirMontoMonedaLocal(ConversionMonetariaDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("convertirMontoMonedaLocal:Inicio");
		Float resultado  = registroCargosDAO.convertirMontoMonedaLocal(entrada);
		cat.debug("convertirMontoMonedaLocal:Fin");
		return resultado;
	}
}
