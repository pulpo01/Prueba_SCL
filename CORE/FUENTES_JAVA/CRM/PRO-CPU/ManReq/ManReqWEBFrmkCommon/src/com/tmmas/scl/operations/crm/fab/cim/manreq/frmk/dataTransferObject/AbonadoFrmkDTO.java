package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.util.ArrayList;

public class AbonadoFrmkDTO {

	private long codCliente;
	private long idAbonado;
	private long numCelular;
	private String planTarifario;
	private String nombreAbonado;
	private ArrayList productoDisponibles;
	private ArrayList productoContratados;
	private ArrayList limiteConsumoProductos;
	
	public ArrayList getLimiteConsumoProductos() {
		return limiteConsumoProductos;
	}

	public void setLimiteConsumoProductos(ArrayList limiteConsumoProductos) {
		this.limiteConsumoProductos = limiteConsumoProductos;
	}

	private int hayAutoAfinCont;
	
	public AbonadoFrmkDTO(long idAbonado, long numCelular, String nombreAbonado,long codCliente) {
		this.idAbonado = idAbonado;
		this.numCelular = numCelular;
		this.nombreAbonado = nombreAbonado;
		productoDisponibles = new ArrayList();
		productoContratados = new ArrayList();
		limiteConsumoProductos = new ArrayList();
	}

	public long getIdAbonado() {
		return idAbonado;
	}
	public void seIdAbonado(long idAbonado) {
		this.idAbonado = idAbonado;
	}
	public String getNombreAbonado() {
		return nombreAbonado;
	}
	public void setNombreAbonado(String nombreAbonado) {
		this.nombreAbonado = nombreAbonado;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getPlanTarifario() {
		return planTarifario;
	}
	public void setPlanTarifario(String planTarifario) {
		this.planTarifario = planTarifario;
	}

	public ArrayList getProductoContratados() {
		return productoContratados;
	}

	public void setProductoContratados(ArrayList productoContratado) {
		this.productoContratados = productoContratado;
	}

	public ArrayList getProductoDisponibles() {
		return productoDisponibles;
	}

	public void setProductoDisponibles(ArrayList productoDisponibles) {
		this.productoDisponibles = productoDisponibles;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public void setIdAbonado(long idAbonado) {
		this.idAbonado = idAbonado;
	}

	public int getHayAutoAfinCont() {
		return hayAutoAfinCont;
	}

	public void setHayAutoAfinCont(int hayAutoAfinCont) {
		this.hayAutoAfinCont = hayAutoAfinCont;
	}

}
