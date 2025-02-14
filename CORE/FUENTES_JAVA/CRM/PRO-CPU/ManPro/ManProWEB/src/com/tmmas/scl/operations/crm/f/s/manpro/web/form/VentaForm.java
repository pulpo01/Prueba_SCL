package com.tmmas.scl.operations.crm.f.s.manpro.web.form;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.InterBitaForm;

public class VentaForm  extends ActionForm implements InterBitaForm{

	private static final long serialVersionUID = 0L;
	private String numVenta;
	private long codCliente;
	private ArrayList listadoAbonadoDelCliente;
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}
	  // Reset form fields.
    public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		this.numVenta = null;
		this.codCliente = 0;
	}
	
	// Validate form data.
	public ActionErrors validate(ActionMapping mapping,
	HttpServletRequest request)
	{
	   ActionErrors errors = new ActionErrors();
	   return errors;
	}
	public void setListadoAbonado(ArrayList listadoAbonado) {
		// TODO Auto-generated method stub
		this.listadoAbonadoDelCliente=listadoAbonado;
	}
	public int getAccion() {
		// TODO Auto-generated method stub
		return 0;
	}
	public String getPagina() {
		// TODO Auto-generated method stub
		return null;
	}
	public void setAccion(int accion) {
		// TODO Auto-generated method stub
		
	}
	public void setPagina(String pagina) {
		// TODO Auto-generated method stub
		
	}

}
