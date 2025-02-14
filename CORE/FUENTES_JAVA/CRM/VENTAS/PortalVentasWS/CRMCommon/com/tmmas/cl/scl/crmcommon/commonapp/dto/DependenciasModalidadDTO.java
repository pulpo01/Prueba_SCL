package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class DependenciasModalidadDTO 
	implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private AgenteVenta agente;
	private ParametrosComercialesVendExtDTO parametrosComerciales;
	private Producto productos;
	private ConceptoVenta Modalidad;
	
	public DependenciasModalidadDTO(AgenteVenta agente, ParametrosComercialesVendExtDTO parametrosComerciales, 
			Producto productos, ConceptoVenta modalidad) 
	{
		super();
		this.agente = agente;
		this.parametrosComerciales = parametrosComerciales;
		this.productos = productos;
		Modalidad = modalidad;
	}

	public AgenteVenta getAgente() {
		return agente;
	}

	public void setAgente(AgenteVenta agente) {
		this.agente = agente;
	}

	public ParametrosComercialesVendExtDTO getParametrosComerciales() {
		return parametrosComerciales;
	}

	public void setParametrosComerciales(
			ParametrosComercialesVendExtDTO parametrosComerciales) {
		this.parametrosComerciales = parametrosComerciales;
	}

	public Producto getProductos() {
		return productos;
	}

	public void setProductos(Producto productos) {
		this.productos = productos;
	}

	public ConceptoVenta getModalidad() {
		return Modalidad;
	}

	public void setModalidad(ConceptoVenta modalidad) {
		Modalidad = modalidad;
	}
}
