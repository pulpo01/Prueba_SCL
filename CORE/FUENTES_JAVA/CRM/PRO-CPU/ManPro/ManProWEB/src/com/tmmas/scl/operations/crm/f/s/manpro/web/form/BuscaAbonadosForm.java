package com.tmmas.scl.operations.crm.f.s.manpro.web.form;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class BuscaAbonadosForm extends ActionForm{
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List listadoAbonado = null;

	private String numAbonado;
	private String numCelular;
	private String nombreAbonado;
	private String idCliente;
	

	public String getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(String idCliente) {
		this.idCliente = idCliente;
	}

	public String getNombreAbonado() {
		return nombreAbonado;
	}

	public void setNombreAbonado(String nombreAbonado) {
		this.nombreAbonado = nombreAbonado;
	}

	public String getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}

	public String getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}

	public void setListadoAbonado(List listadoAbonado) {
	    this.listadoAbonado = listadoAbonado;
	}

  public List getListadoAbonado() {
    return listadoAbonado;
  }

  // Reset form fields.
  public void reset(ActionMapping mapping, HttpServletRequest request)
  {
		this.numAbonado = null;
		this.numCelular = null;
		this.nombreAbonado = null;
		this.idCliente = null;
  }

  // Validate form data.
  public ActionErrors validate(ActionMapping mapping,
    HttpServletRequest request)
  {
    ActionErrors errors = new ActionErrors();


    return errors;
  }

  // Validate format of social security number.
  private static boolean isValidSsNum(String ssNum) {
    if (ssNum.length() < 11) {
      return false;
    }

    for (int i = 0; i < 11; i++) {
      if (i == 3 || i == 6) {
        if (ssNum.charAt(i) != '-') {
          return false;
        }
      } else if ("0123456789".indexOf(ssNum.charAt(i)) == -1) {
        return false;
      }
    }

    return true;
  }


}
