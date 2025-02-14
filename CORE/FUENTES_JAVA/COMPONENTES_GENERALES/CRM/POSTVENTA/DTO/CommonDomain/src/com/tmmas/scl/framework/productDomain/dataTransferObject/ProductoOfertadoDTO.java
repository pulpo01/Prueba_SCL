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
 * 09-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosListDTO;



public class ProductoOfertadoDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private   String idProductoOfertado;
	protected String indAplica;
	protected String indPaquete;
	protected String codCategoriaPlanBasico;
	protected String desProdOfertado;
	protected String indTipoPlataforma;
	protected CargoListDTO cargoList;
	protected String codEspecProd;	
	protected String identificadorProductoOfertado;
	protected Date   fecInicioVigencia;
	protected String flgActiva;
	protected String codCategoria;
	protected Date   fecTerminoVigencia;
	protected String indCargoFacturable;
	protected String maxModificaciones;
	protected String maxContrataciones;
	protected String indCondicionContratacion;
	private NumeroListDTO listaNumeros;
	
	
	protected int cantidadDesplegado;
	protected int cantidadContratado;
	protected String periodoContratacion;
	
	
	private EspecProductoListDTO especProductoList;
	private EspecProductoDTO especificacionProducto;
	protected ReglasListaNumerosListDTO listaReglasNumeros;
	
	
	
	public Object[] toStruct_PF_PRODUCTO_OFERTADO_QT()
	{		
		
		Object[] salidaStruct={	idProductoOfertado,
								indAplica,
								identificadorProductoOfertado,
								codCategoriaPlanBasico,
								desProdOfertado,
								indTipoPlataforma,
								"".equals(codEspecProd)?null:codEspecProd,
								indPaquete,								
								fecInicioVigencia!=null?new Timestamp(fecInicioVigencia.getTime()):null,
								flgActiva,
								codCategoria,
								fecTerminoVigencia!=null?new Timestamp(fecTerminoVigencia.getTime()):null,
								maxModificaciones,
								maxContrataciones
							  };
		return salidaStruct;		
	}
	
	public Object[] toStruct_PF_CATALOGO_OFER_TD_QT()
	{
		
		Object[] salidaStruct={idProductoOfertado};
		return salidaStruct;		
	}	
	
	public ProductoOfertadoDTO()
	{
		this.fecInicioVigencia=new Date();
		this.fecTerminoVigencia=new Date();
		this.cantidadDesplegado=1;
		
	}		
	
	
	
	public NumeroListDTO getListaNumeros() {
		return listaNumeros;
	}

	public void setListaNumeros(NumeroListDTO listaNumeros) {
		this.listaNumeros = listaNumeros;
	}

	public String getIndCondicionContratacion() {
		return indCondicionContratacion;
	}

	public void setIndCondicionContratacion(String indCondicionContratacion) {
		this.indCondicionContratacion = indCondicionContratacion;
	}

	public ReglasListaNumerosListDTO getListaReglasNumeros() {
		return listaReglasNumeros;
	}

	public void setListaReglasNumeros(ReglasListaNumerosListDTO listaReglasNumeros) {
		this.listaReglasNumeros = listaReglasNumeros;
	}

	public String getMaxContrataciones() {
		return maxContrataciones;
	}

	public void setMaxContrataciones(String maxContrataciones) {
		this.maxContrataciones = maxContrataciones;
	}

	public String getMaxModificaciones() {
		return maxModificaciones;
	}

	public void setMaxModificaciones(String maxModificaciones) {
		this.maxModificaciones = maxModificaciones;
	}

	public EspecProductoDTO getEspecificacionProducto() {
		return especificacionProducto;
	}

	public void setEspecificacionProducto(EspecProductoDTO especificacionProducto) {
		this.especificacionProducto = especificacionProducto;
	}

	public String getPeriodoContratacion() {
		return periodoContratacion;
	}

	public void setPeriodoContratacion(String periodoContratacion) {
		this.periodoContratacion = periodoContratacion;
	}

	public int getCantidadContratado() {
		return cantidadContratado;
	}

	public void setCantidadContratado(int cantidadContratado) {
		this.cantidadContratado = cantidadContratado;
	}

	public int getCantidadDesplegado() {
		return cantidadDesplegado;
	}

	public void setCantidadDesplegado(int cantidadDesplegado) {
		this.cantidadDesplegado = cantidadDesplegado;
	}

	public String getIdentificadorProductoOfertado() {
		return identificadorProductoOfertado;
	}

	public void setIdentificadorProductoOfertado(
			String identificadorProductoOfertado) {
		this.identificadorProductoOfertado = identificadorProductoOfertado;
	}

	public String getCodCategoria() {
		return codCategoria;
	}

	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}

	public String getCodEspecProd() {
		return codEspecProd;
	}

	public void setCodEspecProd(String codEspecProd) {
		this.codEspecProd = codEspecProd;
	}

	public Date getFecInicioVigencia() {
		return fecInicioVigencia;
	}

	public void setFecInicioVigencia(Date fecInicioVigencia) {
		this.fecInicioVigencia = fecInicioVigencia;
	}

	public Date getFecTerminoVigencia() {
		return fecTerminoVigencia;
	}

	public void setFecTerminoVigencia(Date fecTerminoVigencia) {
		this.fecTerminoVigencia = fecTerminoVigencia;
	}

	public String getFlgActiva() {
		return flgActiva;
	}

	public void setFlgActiva(String flgActiva) {
		this.flgActiva = flgActiva;
	}

	public String getIndCargoFacturable() {
		return indCargoFacturable;
	}

	public void setIndCargoFacturable(String indCargoFacturable) {
		this.indCargoFacturable = indCargoFacturable;
	}

	public String getDesProdOfertado() {
		return desProdOfertado;
	}
	public void setDesProdOfertado(String desProdOfertado) {
		this.desProdOfertado = desProdOfertado;
	}
	public String getIndTipoPlataforma() {
		return indTipoPlataforma;
	}
	public void setIndTipoPlataforma(String indTipoPlataforma) {
		this.indTipoPlataforma = indTipoPlataforma;
	}
	public CargoListDTO getCargoList() {
		return cargoList;
	}
	public void setCargoList(CargoListDTO cargoList) {
		this.cargoList = cargoList;
	}
	public String getCodCategoriaPlanBasico() {
		return codCategoriaPlanBasico;
	}
	public void setCodCategoriaPlanBasico(String codCategoriaPlanBasico) {
		this.codCategoriaPlanBasico = codCategoriaPlanBasico;
	}	
	
	public EspecProductoListDTO getEspecProductoList() {
		return especProductoList;
	}

	public void setEspecProductoList(EspecProductoListDTO especProductoList) {
		this.especProductoList = especProductoList;
	}

	public String getIdProductoOfertado() {
		return idProductoOfertado;
	}
	public void setIdProductoOfertado(String idProductoOfertado) {
		this.idProductoOfertado = idProductoOfertado;
	}
	public String getIndAplica() {
		return indAplica;
	}
	public void setIndAplica(String indAplica) {
		this.indAplica = indAplica;
	}
	public String getIndPaquete() {
		return indPaquete;
	}
	public void setIndPaquete(String indPaquete) {
		this.indPaquete = indPaquete;
	}

}
