package com.tmmas.scl.framework.customerDomain.dataTransferObject;



public class ConfiguradorTareaPreliquidacionDTO extends ConfiguradorTareasDTO {
	private static final long serialVersionUID = 1L;
	private String numeroVenta;
	private String codigoCliente;
	private String modalidadVenta;
	private String codigoVendedor;
	private long codigoVendedorRaiz;
	private ProgramaDTO datosPrograma;
	
	private CargosDTO[] arraycargos;

	public String getCodigoCliente() {
		return codigoCliente;
	}

	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}

	public String getModalidadVenta() {
		return modalidadVenta;
	}

	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}

	public String getNumeroVenta() {
		return numeroVenta;
	}

	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	
	public CargosDTO[] getArrayCargos() {
		return arraycargos;
	}

	public void setArrayCargos(CargosDTO[] cargos) {
		this.arraycargos = cargos;
	}

	public String getCodigoVendedor() {
		return codigoVendedor;
	}

	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}

	public long getCodigoVendedorRaiz() {
		return codigoVendedorRaiz;
	}

	public void setCodigoVendedorRaiz(long codigoVendedorRaiz) {
		this.codigoVendedorRaiz = codigoVendedorRaiz;
	}

	public ProgramaDTO getDatosPrograma() {
		return datosPrograma;
	}

	public void setDatosPrograma(ProgramaDTO datosPrograma) {
		this.datosPrograma = datosPrograma;
	}

}
