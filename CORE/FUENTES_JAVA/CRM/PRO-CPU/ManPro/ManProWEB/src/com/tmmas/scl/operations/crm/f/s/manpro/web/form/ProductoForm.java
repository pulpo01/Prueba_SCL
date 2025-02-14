package com.tmmas.scl.operations.crm.f.s.manpro.web.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.AbonadoFrmkDTO;

public class ProductoForm  extends ActionForm{

	private static final long serialVersionUID = 1L;
	private String codigo;
	private String comportamiento;
	private String idProducto;
	private String codPadrePaq;
	private String productoDescripcion;
	private String codigoProducto;
	private String numeroMaximo;
	private String tipoCobro;
	private String codigoLC;
	private String idEspecProvision;
	
	public String getIdEspecProvision() {
		return idEspecProvision;
	}

	public void setIdEspecProvision(String idEspecProvision) {
		this.idEspecProvision = idEspecProvision;
	}

	public String getTipoCobro() {
		return tipoCobro;
	}

	public void setTipoCobro(String tipoCobro) {
		this.tipoCobro = tipoCobro;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		
	}
	
	public ActionErrors validate( 
	      ActionMapping mapping, HttpServletRequest request ) {
	      ActionErrors errors = new ActionErrors();	      
	      return errors;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getComportamiento() {
		return comportamiento;
	}

	public void setComportamiento(String comportamiento) {
		this.comportamiento = comportamiento;
	}

	public String getIdProducto() {
		// TODO Auto-generated method stub
		return idProducto;
	}

	public String getCodPadrePaq() {
		return codPadrePaq;
	}

	public void setCodPadrePaq(String codPadrePaq) {
		this.codPadrePaq = codPadrePaq;
	}

	public void setIdProducto(String idProducto) {
		this.idProducto = idProducto;
	}

	public String getCodigoProducto() {
		return codigoProducto;
	}

	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}

	public String getProductoDescripcion() {
		return productoDescripcion;
	}

	public void setProductoDescripcion(String productoDescripcion) {
		this.productoDescripcion = productoDescripcion;
	}

	public String getNumeroMaximo() {
		return numeroMaximo;
	}

	public void setNumeroMaximo(String numeroMaximo) {
		this.numeroMaximo = numeroMaximo;
	}

	public String getCodigoLC() {
		return codigoLC;
	}

	public void setCodigoLC(String codigoLC) {
		this.codigoLC = codigoLC;
	}

	

	
}
