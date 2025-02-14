package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;

public class ProductoOfertadoDTO implements Serializable {

	/**
	 *	© 2010 - TM-mAs
	 */
	private static final long serialVersionUID = -2253152935804100993L;

	String codCategoria;

	private long codProductoOfertado;

	String desProdOfertado;

	String idProdOfertado;

	Integer maxContrataciones;

	String tipoComportamiento;
	
	//inicio INC-155400 JMO/05-11-2010
	String tipoRelacionPA;
	//fin INC-155400 JMO/05-11-2010
	
	private long cantidad;

	private long codCliente;
	
	//Inicio P-CSR-11002 JLGN 01-07-2011
	String montoImporte;
	
	//Inicio P-CSR-11002 JLGN 26-10-2011
	String desMoneda;
	
	public String getDesMoneda() {
		return desMoneda;
	}

	public void setDesMoneda(String desMoneda) {
		this.desMoneda = desMoneda;
	}
	//Fin P-CSR-11002 JLGN 26-10-2011

	//Inicio P-CSR-11002 JLGN 01-07-2011
	public String getMontoImporte() {
		return montoImporte;
	}

	public void setMontoImporte(String montoImporte) {
		this.montoImporte = montoImporte;
	}
	//Fin P-CSR-11002 JLGN 01-07-2011

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public long getCantidad() {
		return cantidad;
	}

	public void setCantidad(long cantidad) {
		this.cantidad = cantidad;
	}

	public String getCodCategoria() {
		return codCategoria;
	}

	public long getCodProductoOfertado() {
		return codProductoOfertado;
	}

	public String getDesProdOfertado() {
		return desProdOfertado;
	}

	public String getIdProdOfertado() {
		return idProdOfertado;
	}

	public Integer getMaxContrataciones() {
		return maxContrataciones;
	}

	public String getTipoComportamiento() {
		return tipoComportamiento;
	}

	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}

	public void setCodProductoOfertado(long codProductoOfertado) {
		this.codProductoOfertado = codProductoOfertado;
	}

	public void setDesProdOfertado(String desProdOfertado) {
		this.desProdOfertado = desProdOfertado;
	}

	public void setIdProdOfertado(String idProdOfertado) {
		this.idProdOfertado = idProdOfertado;
	}

	public void setMaxContrataciones(Integer maxContrataciones) {
		this.maxContrataciones = maxContrataciones;
	}

	public void setTipoComportamiento(String tipoComportamiento) {
		this.tipoComportamiento = tipoComportamiento;
	}

	//inicio JMO/05-11-2010 INC-155400
	public String getTipoRelacionPA() {
		return tipoRelacionPA;
	}

	public void setTipoRelacionPA(String tipoRelacionPA) {
		this.tipoRelacionPA = tipoRelacionPA;
	}
	//fin JMO/05-11-2010 INC-155400

	public String toString() {
		final String nl = "\n";
		StringBuffer b = new StringBuffer();
		b.append("ProductoOfertadoDTO ( ").append(super.toString()).append(nl);
		b.append("cantidad = ").append(this.cantidad).append(nl);
		b.append("codCategoria = ").append(this.codCategoria).append(nl);
		b.append("codCliente = ").append(this.codCliente).append(nl);
		b.append("codProductoOfertado = ").append(this.codProductoOfertado).append(nl);
		b.append("desProdOfertado = ").append(this.desProdOfertado).append(nl);
		b.append("idProdOfertado = ").append(this.idProdOfertado).append(nl);
		b.append("maxContrataciones = ").append(this.maxContrataciones).append(nl);
		b.append("tipoComportamiento = ").append(this.tipoComportamiento).append(nl);
		b.append("tipoRelacionPA = ").append(this.tipoRelacionPA).append(nl);// JMO/05-11-2010 INC-155400
		b.append("montoImporte = ").append(this.montoImporte).append(nl);//P-CSR-11002 JLGN 01-07-2011
		b.append(" )");
		return b.toString();
	}

}