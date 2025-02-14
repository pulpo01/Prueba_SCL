package com.tmmas.cl.scl.commonbusinessentities.dto.ws;
 
import java.io.Serializable;
public class LstPTaPlanTarifarioInDTO implements Serializable{
	private static final long serialVersionUID = 1L;
   	private String  tipoProducto;
   	private String  tipoPlan;
   	private String  tipIdent;
   	private String  numIdent;
   	private String  apellidoCliente;
   	private Long    ingresos;
   	private Long    codVendedor;
   	private Long    codVendealer;
   	private String  nomUsuarioEvaluacion;
   	private String  codTipPrestacion;
   	private String claPlanTarif;
   	private int indRenovacion;
   	//Inicio P-CSR-11002 JLGN 13-05-2011
   	private String codClasificacion;   	
   	
   	public String getCodClasificacion() {
		return codClasificacion;
	}
	public void setCodClasificacion(String codClasificacion) {
		this.codClasificacion = codClasificacion;
	}
	//Fin P-CSR-11002 JLGN 13-05-2011
	public int getIndRenovacion() {
		return indRenovacion;
	}
	public void setIndRenovacion(int indRenovacion) {
		this.indRenovacion = indRenovacion;
	}
	public String getClaPlanTarif() {
		return claPlanTarif;
	}
	public void setClaPlanTarif(String claPlanTarif) {
		this.claPlanTarif = claPlanTarif;
	}
	public String getCodTipPrestacion() {
		return codTipPrestacion;
	}
	public void setCodTipPrestacion(String codTipPrestacion) {
		this.codTipPrestacion = codTipPrestacion;
	}
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
	public String getTipIdent() {
		return tipIdent;
	}
	public void setTipIdent(String tipIdent) {
		this.tipIdent = tipIdent;
	}
	public String getTipoPlan() {
		return tipoPlan;
	}
	public void setTipoPlan(String tipoPlan) {
		this.tipoPlan = tipoPlan;
	}
	public String getTipoProducto() {
		return tipoProducto;
	}
	public void setTipoProducto(String tipoProducto) {
		this.tipoProducto = tipoProducto;
	}
	/**
	 * @return the apellidoCliente
	 */
	public String getApellidoCliente() {
		return apellidoCliente;
	}
	/**
	 * @param apellidoCliente the apellidoCliente to set
	 */
	public void setApellidoCliente(String apellidoCliente) {
		this.apellidoCliente = apellidoCliente;
	}
	/**
	 * @return the codVendealer
	 */
	public Long getCodVendealer() {
		return codVendealer;
	}
	/**
	 * @param codVendealer the codVendealer to set
	 */
	public void setCodVendealer(Long codVendealer) {
		this.codVendealer = codVendealer;
	}
	/**
	 * @return the codVendedor
	 */
	public Long getCodVendedor() {
		return codVendedor;
	}
	/**
	 * @param codVendedor the codVendedor to set
	 */
	public void setCodVendedor(Long codVendedor) {
		this.codVendedor = codVendedor;
	}
	/**
	 * @return the ingresos
	 */
	public Long getIngresos() {
		return ingresos;
	}
	/**
	 * @param ingresos the ingresos to set
	 */
	public void setIngresos(Long ingresos) {
		this.ingresos = ingresos;
	}
	/**
	 * @return the nomUsuarioEvaluacion
	 */
	public String getNomUsuarioEvaluacion() {
		return nomUsuarioEvaluacion;
	}
	/**
	 * @param nomUsuarioEvaluacion the nomUsuarioEvaluacion to set
	 */
	public void setNomUsuarioEvaluacion(String nomUsuarioEvaluacion) {
		this.nomUsuarioEvaluacion = nomUsuarioEvaluacion;
	}
   	
	
}//fin class LstPTaPlanTarifarioInDTO

