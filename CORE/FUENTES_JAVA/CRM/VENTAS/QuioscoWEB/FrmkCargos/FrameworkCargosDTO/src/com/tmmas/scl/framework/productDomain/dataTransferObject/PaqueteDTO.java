/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 10-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class PaqueteDTO extends ProductoOfertadoDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idPaquete;
	private String codProdPadre;
	private String codProdHijo;	
	private ProductoOfertadoListDTO productoList;
	private int cantidad;
		
	public Object[] toStruct_PF_PAQUETE_OFERTADO_TO_QT()
	{		
		Object[] obj={	codProdPadre,
						codProdHijo,
						new Integer(cantidad)			
					 };		
		return obj;
	}
	
	public PaqueteDTO()
	{
		super();
	}
	
	public PaqueteDTO(ProductoOfertadoDTO productoOfertado)
	{
		super();
		this.setIdPaquete(productoOfertado.getIdProductoOfertado());
		this.setIdProductoOfertado(productoOfertado.getIdProductoOfertado());
		this.setCodProdPadre(productoOfertado.getIdProductoOfertado());
		this.cantidad=productoOfertado.getCantidadDesplegado();
		this.cargoList=productoOfertado.getCargoList();		
		
		indAplica=productoOfertado.getIndAplica();
		indPaquete="1";
		codCategoriaPlanBasico=productoOfertado.getCodCategoriaPlanBasico();
		desProdOfertado=productoOfertado.getDesProdOfertado();
		indTipoPlataforma=productoOfertado.getIndTipoPlataforma();		
		codEspecProd=productoOfertado.getCodEspecProd();	
		identificadorProductoOfertado=productoOfertado.getIdentificadorProductoOfertado();
		fecInicioVigencia=productoOfertado.getFecInicioVigencia();
	    flgActiva=productoOfertado.getFlgActiva();
		codCategoria=productoOfertado.getCodCategoria();
		fecTerminoVigencia=productoOfertado.getFecTerminoVigencia();
		indCargoFacturable=productoOfertado.getIndCargoFacturable();
		maxModificaciones=productoOfertado.getMaxModificaciones();
		maxContrataciones=productoOfertado.getMaxContrataciones();		
		
		cantidadDesplegado=productoOfertado.getCantidadDesplegado();
		cantidadContratado=productoOfertado.getCantidadContratado();
		periodoContratacion=productoOfertado.getPeriodoContratacion();
		indCondicionContratacion=productoOfertado.getIndCondicionContratacion();
	}
	
	public String getCodProdHijo() {
		return codProdHijo;
	}
	public void setCodProdHijo(String codProdHijo) {
		this.codProdHijo = codProdHijo;		
	}
	public String getCodProdPadre() {		
		return codProdPadre;
	}
	public void setCodProdPadre(String codProdPadre) {
		this.codProdPadre = codProdPadre;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public String getIdPaquete() {
		return idPaquete;
	}
	public void setIdPaquete(String idPaquete) {
		this.idPaquete = idPaquete;
	}
	public ProductoOfertadoListDTO getProductoList() {
		return productoList;
	}
	public void setProductoList(ProductoOfertadoListDTO productoList) {
		this.productoList = productoList;
	}
	
	
	public String toString()
	{
		StringBuffer dto=new StringBuffer();
		dto.append("[idPaquete]["+idPaquete+"]\n");
		dto.append("[codProdPadre]["+codProdPadre+"]\n");
		dto.append("[codProdHijo]["+codProdHijo+"]\n");
		dto.append("[cantidad]["+cantidad+"]\n");
		dto.append("[productoList]["+productoList.toString()+"]\n");		
		return dto.toString();
	}
	
}
