package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;

public class ProdContratadoOfertadoDTO implements Serializable, Cloneable  {

	private static final long serialVersionUID = 1L;
	
	private String codProducto;
	private String nombre ;
	private String comportamiento ;
	private String indCondicionContratacion ;
	private String maximo ;
	private Long idProdContratado;
	private Long idProdOfertado;
	private NumeroListDTO listaNumeros;
	private String indAutoAfinidad;
	private int permitidos;
	private int maxModificaciones;
	private int cantModificaciones;
	
	
	public int getCantModificaciones() {
		return cantModificaciones;
	}
	public void setCantModificaciones(int cantModificaciones) {
		this.cantModificaciones = cantModificaciones;
	}
	public int getMaxModificaciones() {
		return maxModificaciones;
	}
	public void setMaxModificaciones(int maxModificaciones) {
		this.maxModificaciones = maxModificaciones;
	}
	public int getPermitidos() {
		return permitidos;
	}
	public void setPermitidos(int permitidos) {
		this.permitidos = permitidos;
	}
	public String getIndAutoAfinidad() {
		return indAutoAfinidad;
	}
	public void setIndAutoAfinidad(String indAutoAfinidad) {
		this.indAutoAfinidad = indAutoAfinidad;
	}
	public Long getIdProdContratado() {
		return idProdContratado;
	}
	public void setIdProdContratado(Long idProdContratado) {
		this.idProdContratado = idProdContratado;
	}
	public Long getIdProdOfertado() {
		return idProdOfertado;
	}
	public void setIdProdOfertado(Long idProdOfertado) {
		this.idProdOfertado = idProdOfertado;
	}
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public String getComportamiento() {
		return comportamiento;
	}
	public void setComportamiento(String comportamiento) {
		this.comportamiento = comportamiento;
	}
	public String getIndCondicionContratacion() {
		return indCondicionContratacion;
	}
	public void setIndCondicionContratacion(String indCondicionContratacion) {
		this.indCondicionContratacion = indCondicionContratacion;
	}
	public String getMaximo() {
		return maximo;
	}
	public void setMaximo(String maximo) {
		this.maximo = maximo;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public NumeroListDTO getListaNumeros() {
		return listaNumeros;
	}
	public void setListaNumeros(NumeroListDTO listaNumeros) {
		this.listaNumeros = listaNumeros;
	}
	
    //	 * Método para clonar
    // * De protegido pasa a público

    public Object clone() throws CloneNotSupportedException { 
          // * Llamamos al clone de Object
          Object o=super.clone();
          // * Como ha hecho una copia bit a bit del estado
          //   es suficiente
          return o;
    }


	
	
	

}
