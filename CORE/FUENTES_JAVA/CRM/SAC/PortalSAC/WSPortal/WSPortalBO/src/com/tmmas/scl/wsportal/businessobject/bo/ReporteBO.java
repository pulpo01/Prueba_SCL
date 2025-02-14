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

import com.tmmas.scl.wsportal.businessobject.dao.ReporteDAO;
import com.tmmas.scl.wsportal.common.dto.ListaCausalCambioDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReporteCamEquiGenDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReporteIngrStatusEquiDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReportePresEquiIntDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class ReporteBO{

	ReporteDAO reporteDAO = new ReporteDAO();
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 -F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-045 Generar Reporte de cambios de equipo generados
	 * Developer: Gabriel Moraga L.
	 * Fecha: 24/08/2010
	 * Metodo: obtenerReporteCambioEquiGene
	 * Return: ListadoReporteCamEquiGenDTO
	 * Descripcion: Obtiene informacion por rango de fechas y causal de cambio de equipo
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoReporteCamEquiGenDTO obtenerReporteCambioEquiGene(String fechaDesde, String fechaHasta, String codCausalCam) throws PortalSACException{
		return reporteDAO.obtenerReporteCambioEquiGene(fechaDesde, fechaHasta, codCausalCam);
	}
	

	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 - F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-046 Generar Reporte de ingreso de equipos y status del equipo
	 * Developer: Gabriel Moraga L.
	 * Fecha: 25/08/2010
	 * Metodo: obtenerReporteIngrStatusEqui
	 * Return: ListadoReporteIngrStatusEquiDTO
	 * Descripcion: Obtiene informacion por rango de fechas
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoReporteIngrStatusEquiDTO obtenerReporteIngrStatusEqui(String fechaDesde, String fechaHasta) throws PortalSACException{
		return reporteDAO.obtenerReporteIngrStatusEqui(fechaDesde, fechaHasta);
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 - F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-047 Generar Reporte de préstamos de equipos internos
	 * Developer: Gabriel Moraga L.
	 * Fecha: 25/08/2010
	 * Metodo: obtenerReportePresEquiInt
	 * Return: ListadoReportePresEquiIntDTO
	 * Descripcion: Obtiene informacion por rango de fechas
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoReportePresEquiIntDTO obtenerReportePresEquiInt(String fechaDesde, String fechaHasta) throws PortalSACException{
		return reporteDAO.obtenerReportePresEquiInt(fechaDesde, fechaHasta);
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 -F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-045 Generar Reporte de cambios de equipo generados
	 * Developer: Gabriel Moraga L.
	 * Fecha: 27/08/2010
	 * Metodo: obtenerCausalCambio
	 * Return: ListaCausalCambioDTO
	 * Descripcion: Obtiene las causales de cambio
	 * throws: PortalSACException
	 * 
	 */
	
	public ListaCausalCambioDTO obtenerCausalCambio() throws PortalSACException{
		return reporteDAO.obtenerCausalCambio();
	}
	
}
