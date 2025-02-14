/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.businessobject.bo;

import com.tmmas.scl.wsportal.businessobject.dao.DireccionDAO;
import com.tmmas.scl.wsportal.common.dto.DatosDireccionClienteINDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.DireccionPorClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCamposDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCiudadesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoComunasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDireccionesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoEstadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoProvinciasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoPueblosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoRegionesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoTiposCalleDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoZipCodeDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class DireccionBO
{

	public DetalleDireccionDTO getDetalleDireccion(Long codDireccion, String CodTipDireccion) throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.getDetalleDireccion(codDireccion, CodTipDireccion);
	}
	
	public DireccionPorClienteDTO obtenerDatosDireccionCliente(DatosDireccionClienteINDTO pIn) throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerDatosDireccionCliente(pIn);
	}
	
	public ListadoCamposDireccionDTO obtenerCamposDireccion() throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerCamposDireccion();
	}

	public ListadoDireccionesDTO direccionesXCodCliente(Long codCliente) throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.direccionesXCodCliente(codCliente);
	}

	public ListadoRegionesDTO obtenerRegiones() throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerRegiones();
	}

	public ListadoProvinciasDTO obtenerProvincias(String codRegion) throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerProvincias(codRegion);
	}

	public ListadoComunasDTO obtenerComunas(String codRegion, String codProvincia, String codCiudad)
			throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerComunas(codRegion, codProvincia, codCiudad);
	}

	public ListadoCiudadesDTO obtenerCiudades(String codRegion, String codProvincia) throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerCiudades(codRegion, codProvincia);
	}
	
	public ListadoEstadosDTO obtenerEstados() throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerEstados();
	}

	public ListadoPueblosDTO obtenerPueblos(String codEstado) throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerPueblos(codEstado);
	}
	
	public ListadoTiposCalleDTO obtenerTiposCalle() throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerTiposCalle();
	}
	
	public ListadoZipCodeDTO obtenerZipCode(String codZone) throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerZipCode(codZone);
	}
	
	public String obtenerParametroZipCode() throws PortalSACException
	{
		DireccionDAO direccionDAO = new DireccionDAO();
		return direccionDAO.obtenerParametroZipCode();
	}
}
