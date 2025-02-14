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

import com.tmmas.scl.wsportal.businessobject.dao.AtencionPackageDAO;
import com.tmmas.scl.wsportal.common.dto.AbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO;
import com.tmmas.scl.wsportal.common.dto.ResgistroAtencionDTO;
import com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class AtencionPackageBO{

	
	AtencionPackageDAO AtPkgDAO = new AtencionPackageDAO();
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: obtenerDatosAbonado
	 * Return: AbonadoDTO
	 * Descripcion: Obtiene los datos de un abonado
	 * throws: PortalSACException
	 * 
	 */
	
	public AbonadoDTO obtenerDatosAbonado(Long numAbonado) throws PortalSACException{
		return AtPkgDAO.obtenerDatosAbonado(numAbonado);
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: consultaAtencion
	 * Return: ListaAtencionClienteDTO
	 * Descripcion: Obtiene las atenciones de los clientes
	 * throws: PortalSACException
	 * 
	 */
	
	public ListaAtencionClienteDTO consultaAtencion() throws PortalSACException{
		return AtPkgDAO.consultaAtencion();
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: IngresoAtencion
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta una gestion de atencion
	 * throws: PortalSACException
	 * 
	 */

	public ResulTransaccionDTO ingresoAtencion(ResgistroAtencionDTO resgistroAtencionDTO) throws PortalSACException{
		return AtPkgDAO.ingresoAtencion(resgistroAtencionDTO);
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario 
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: ObtenerListDatosAbonados
	 * Return: ListadoAbonadosDTO
	 * Descripcion: Obtiene los datos de de los abonados asociados a un cliente
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoAbonadosDTO obtenerListDatosAbonados(Long codCliente) throws PortalSACException{
		return AtPkgDAO.obtenerListDatosAbonados(codCliente);
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: consultaCuenta
	 * Return: ListadoAbonadosDTO
	 * Descripcion: Obtiene los abonados asociados a una cuenta
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoAbonadosDTO consultaCuenta(Long codCuenta) throws PortalSACException{
		return AtPkgDAO.consultaCuenta(codCuenta);
	}
}
