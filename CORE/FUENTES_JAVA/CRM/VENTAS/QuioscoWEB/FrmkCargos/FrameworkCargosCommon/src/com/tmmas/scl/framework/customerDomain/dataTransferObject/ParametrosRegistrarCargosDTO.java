package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ParametrosRegistrarCargosDTO extends ObtencionCargosDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long codCliente;
	private long numVenta; 
    private long numTransaccionVenta;
    private String planComercialCliente;
    private String codOficinaVendedor;
    private String categTributaria;
    private long codDocumento;
    private String tipoFoliacion;
    private String codModalidadPago;
    private boolean facturaACiclo;
    private long codVendedor;
    private long codVendedorRaiz;
    private long codCiclo;
    private AtributosMigracionDTO atributosMigracionDTO;
    private String usuario;
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public AtributosMigracionDTO getAtributosMigracionDTO() {
		return atributosMigracionDTO;
	}
	public void setAtributosMigracionDTO(AtributosMigracionDTO atributosMigracionDTO) {
		this.atributosMigracionDTO = atributosMigracionDTO;
	}
	public long getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(long codCiclo) {
		this.codCiclo = codCiclo;
	}
	public String getCategTributaria() {
		return categTributaria;
	}
	public void setCategTributaria(String categTributaria) {
		this.categTributaria = categTributaria;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodDocumento() {
		return codDocumento;
	}
	public void setCodDocumento(long codDocumento) {
		this.codDocumento = codDocumento;
	}
	public String getCodModalidadPago() {
		return codModalidadPago;
	}
	public void setCodModalidadPago(String codModalidadPago) {
		this.codModalidadPago = codModalidadPago;
	}
	public String getCodOficinaVendedor() {
		return codOficinaVendedor;
	}
	public void setCodOficinaVendedor(String codOficinaVendedor) {
		this.codOficinaVendedor = codOficinaVendedor;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public long getCodVendedorRaiz() {
		return codVendedorRaiz;
	}
	public void setCodVendedorRaiz(long codVendedorRaiz) {
		this.codVendedorRaiz = codVendedorRaiz;
	}
	public boolean isFacturaACiclo() {
		return facturaACiclo;
	}
	public void setFacturaACiclo(boolean facturaACiclo) {
		this.facturaACiclo = facturaACiclo;
	}
	public long getNumTransaccionVenta() {
		return numTransaccionVenta;
	}
	public void setNumTransaccionVenta(long numTransaccionVenta) {
		this.numTransaccionVenta = numTransaccionVenta;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	public String getPlanComercialCliente() {
		return planComercialCliente;
	}
	public void setPlanComercialCliente(String planComercialCliente) {
		this.planComercialCliente = planComercialCliente;
	}
	public String getTipoFoliacion() {
		return tipoFoliacion;
	}
	public void setTipoFoliacion(String tipoFoliacion) {
		this.tipoFoliacion = tipoFoliacion;
	}
}
