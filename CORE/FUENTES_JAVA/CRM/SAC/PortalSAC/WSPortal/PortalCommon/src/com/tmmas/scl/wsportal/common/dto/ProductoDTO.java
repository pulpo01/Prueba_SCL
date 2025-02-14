/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

/*P-NIC-09004*/
public class ProductoDTO implements Serializable
{
	private static final long serialVersionUID = 2024557182960532444L;

	String codProducto;

	String desProducto;

	String importeCargoBasico;

	String codConcepto;

	String textoDetalle;

	/*
	 * Modificacion
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_001
	 * Caso de uso: CU-001 Modificar Listado Productos por Abonado/Clientes
	 * Developer: Gabriel Moraga L.
	 * Fecha: 12/07/2010
	 * 
	 */
	
	String estadoAltBaj;
	String fechAltaBD;
	String fecBajaBD;
	String fechAltaCentral;
	String fecBajaCentral;
	
	public String toString()
	{
		StringBuffer b = null;
		try
		{
			b = new StringBuffer();
			b.append("codProducto");
			b.append(" [");
			b.append(codProducto);
			b.append("] - ");
			b.append("codProducto");
			b.append(" [");
			b.append(codProducto);
			b.append("] - ");
			b.append("desProducto");
			b.append(" [");
			b.append(desProducto);
			b.append("] - ");
			b.append("importeCargoBasico");
			b.append(" [");
			b.append(importeCargoBasico);
			b.append("] - ");
			b.append("codConcepto");
			b.append(" [");
			b.append(codConcepto);
			b.append("] - ");
			b.append("estadoAltBaj");
			b.append(" [");
			b.append(estadoAltBaj);
			b.append("] - ");
			b.append("fechAltaBD");
			b.append(" [");
			b.append(fechAltaBD);
			b.append("] - ");
			b.append("fecBajaBD");
			b.append(" [");
			b.append(fecBajaBD);
			b.append("] - ");
			b.append("fechAltaCentral");
			b.append(" [");
			b.append(fechAltaCentral);
			b.append("] - ");
			b.append("fecBajaCentral");
			b.append(" [");
			b.append(fecBajaCentral);
			b.append("] - ");
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return b.toString();
	}

	public String getCodConcepto()
	{
		return codConcepto;
	}

	public void setCodConcepto(String codConcepto)
	{
		this.codConcepto = codConcepto;
	}

	public String getCodProducto()
	{
		return codProducto;
	}

	public void setCodProducto(String codProducto)
	{
		this.codProducto = codProducto;
	}

	public String getDesProducto()
	{
		return desProducto;
	}

	public void setDesProducto(String desProducto)
	{
		this.desProducto = desProducto;
	}

	public String getImporteCargoBasico()
	{
		return importeCargoBasico;
	}

	public void setImporteCargoBasico(String importeCargoBasico)
	{
		this.importeCargoBasico = importeCargoBasico;
	}

	public final String getTextoDetalle()
	{
		return textoDetalle;
	}

	public final void setTextoDetalle(String detalle)
	{
		this.textoDetalle = detalle;
	}

	public String getEstadoAltBaj() {
		return estadoAltBaj;
	}

	public void setEstadoAltBaj(String estadoAltBaj) {
		this.estadoAltBaj = estadoAltBaj;
	}

	public String getFechAltaBD() {
		return fechAltaBD;
	}

	public void setFechAltaBD(String fechAltaBD) {
		this.fechAltaBD = fechAltaBD;
	}

	public String getFecBajaBD() {
		return fecBajaBD;
	}

	public void setFecBajaBD(String fecBajaBD) {
		this.fecBajaBD = fecBajaBD;
	}

	public String getFechAltaCentral() {
		return fechAltaCentral;
	}

	public void setFechAltaCentral(String fechAltaCentral) {
		this.fechAltaCentral = fechAltaCentral;
	}

	public String getFecBajaCentral() {
		return fecBajaCentral;
	}

	public void setFecBajaCentral(String fecBajaCentral) {
		this.fecBajaCentral = fecBajaCentral;
	}
	
}
