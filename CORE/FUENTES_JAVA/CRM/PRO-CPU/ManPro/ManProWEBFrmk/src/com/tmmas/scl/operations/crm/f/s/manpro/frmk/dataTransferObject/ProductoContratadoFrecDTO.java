package com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject;

import java.io.Serializable;
import java.util.ArrayList;

public class ProductoContratadoFrecDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idProductoContratado;
	private String idProductoOfertado;
	private long correlativo; 
	private String codigo; 
	private String descripcion;
	private String tipo;
	private String indCondicionContr;
	private ArrayList tiposNumPermitidos;
	private String modoContratacion; 
	private long numFrecuentesPermitidos;
	private long numFrecuentesIngresados;
	private long codigoPadre;
	private long codCliente;
	private long numAbonado;

	private NumeroFrecuenteDTO [] numFrecuentesIngresadosList;//datos de llegada, una lista sin agrupacion por tipo de NumeroFrecuenteDTO
	//borrar:NumeroFrecuenteTipDTOArrList
	private ArrayList NumeroFrecuenteTipDTOArrList = null;//Array list donde cada elemento indica un NumeroFrecuenteDTO [] para un tipo de numero
	private ArrayList numerosFrecuentesTipoListDTO = null;//Array de NumeroFrecuenteTipoListDTO
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public long getCorrelativo() {
		return correlativo;
	}
	public void setCorrelativo(long correlativo) {
		this.correlativo = correlativo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getIdProductoContratado() {
		return idProductoContratado;
	}
	public void setIdProductoContratado(String idProductoContratado) {
		this.idProductoContratado = idProductoContratado;
	}
	public String getModoContratacion() {
		return modoContratacion;
	}
	public void setModoContratacion(String modoContratacion) {
		this.modoContratacion = modoContratacion;
	}
	public ArrayList getNumeroFrecuenteTipDTOArrList() {
		return NumeroFrecuenteTipDTOArrList;
	}
	public void setNumeroFrecuenteTipDTOArrList(
			ArrayList numeroFrecuenteTipDTOArrList) {
		NumeroFrecuenteTipDTOArrList = numeroFrecuenteTipDTOArrList;
	}
	public ArrayList getNumerosFrecuentesTipoListDTO() {
		return numerosFrecuentesTipoListDTO;
	}
	public void setNumerosFrecuentesTipoListDTO(
			ArrayList numerosFrecuentesTipoListDTO) {
		this.numerosFrecuentesTipoListDTO = numerosFrecuentesTipoListDTO;
	}
	public long getNumFrecuentesIngresados() {
		return numFrecuentesIngresados;
	}
	public void setNumFrecuentesIngresados(long numFrecuentesIngresados) {
		this.numFrecuentesIngresados = numFrecuentesIngresados;
	}
	public NumeroFrecuenteDTO[] getNumFrecuentesIngresadosList() {
		return numFrecuentesIngresadosList;
	}
	public void setNumFrecuentesIngresadosList(
			NumeroFrecuenteDTO[] numFrecuentesIngresadosList) {
		this.numFrecuentesIngresadosList = numFrecuentesIngresadosList;
	}
	public long getNumFrecuentesPermitidos() {
		return numFrecuentesPermitidos;
	}
	public void setNumFrecuentesPermitidos(long numFrecuentesPermitidos) {
		this.numFrecuentesPermitidos = numFrecuentesPermitidos;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public ArrayList getTiposNumPermitidos() {
		return tiposNumPermitidos;
	}
	public void setTiposNumPermitidos(ArrayList tiposNumPermitidos) {
		this.tiposNumPermitidos = tiposNumPermitidos;
	}
	public long getCodigoPadre() {
		return codigoPadre;
	}
	public void setCodigoPadre(long codigoPadre) {
		this.codigoPadre = codigoPadre;
	}
	public String getIdProductoOfertado() {
		return idProductoOfertado;
	}
	public void setIdProductoOfertado(String idProductoOfertado) {
		this.idProductoOfertado = idProductoOfertado;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getIndCondicionContr() {
		return indCondicionContr;
	}
	public void setIndCondicionContr(String indCondicionContr) {
		this.indCondicionContr = indCondicionContr;
	}
}
