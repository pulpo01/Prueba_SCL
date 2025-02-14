package com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject;

import java.util.ArrayList;

import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoScoringDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoScoringListDTO;

public class AbonadoFrmkDTO {

	private long codCliente;
	private long idAbonado;
	private long numCelular;
	private String planTarifario;
	private String nombreAbonado;
	private ArrayList productoDisponibles;
	private ArrayList productoContratados;
	private String codPrestacion;
	private String desPrestacion;
	private ProductoScoringDTO[] productosScoring;
	private int totalPlanesScoring;
	
	public int getTotalPlanesScoring() {
		return totalPlanesScoring;
	}

	public void setTotalPlanesScoring(int totalPlanesScoring) {
		this.totalPlanesScoring = totalPlanesScoring;
	}

	public ProductoScoringDTO[] getProductosScoring() {
		return productosScoring;
	}

	public void setProductosScoring(ProductoScoringDTO[] productosScoring) {
		this.productosScoring = productosScoring;
	}

	public AbonadoFrmkDTO(long idAbonado, long numCelular, String nombreAbonado,long codCliente, String codPrestacion, String desPrestacion) {
		this.idAbonado = idAbonado;
		this.numCelular = numCelular;
		this.nombreAbonado = nombreAbonado;
		productoDisponibles = new ArrayList();
		productoContratados = new ArrayList();
		this.codPrestacion = codPrestacion;
		this.desPrestacion = desPrestacion;
		productosScoring = new ProductoScoringDTO[0];
		this.totalPlanesScoring = 0;
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

	public String getCodPrestacion() {
		return codPrestacion;
	}

	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}

	public String getDesPrestacion() {
		return desPrestacion;
	}

	public void setDesPrestacion(String desPrestacion) {
		this.desPrestacion = desPrestacion;
	}

}
