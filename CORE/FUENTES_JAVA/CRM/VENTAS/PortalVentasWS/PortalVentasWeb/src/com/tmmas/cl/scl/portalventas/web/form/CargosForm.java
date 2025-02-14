package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class CargosForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private int numeroCargos;
	private String total;
	private float txtMaximoDcto;
	private float txtMinimoDcto;
	private float txtPorcMaximoDcto;
	private float txtPorcMinimoDcto;
	private int txtParamDecForm;
	private int txtParamDecBD;
	private String cargoSeleccionado;
	private String numeroSolicitudAutorizacion;
	private String textoXMLDescuento;
	private String textoXML;
	private String mensajeFacturacion;
	private String codOperadora;
	private String codOperadoraSalvador;
	private String codTipoCliente;
	private String codTipoClientePrepago;
	private String distribuir = "NO";
	private String preactivacion;
	//MA-184592
	private DatosGeneralesDTO[] activacionLineaDTO;
	
	public DatosGeneralesDTO[] getActivacionLineaDTO() {
		return activacionLineaDTO;
	}
	public void setActivacionLineaDTO(DatosGeneralesDTO[] activacionLineaDTO) {
		this.activacionLineaDTO = activacionLineaDTO;
	}
	public String getPreactivacion() {
		return preactivacion;
	}
	public void setPreactivacion(String preactivacion) {
		this.preactivacion = preactivacion;
	}
	public String getCodTipoCliente() {
		return codTipoCliente;
	}
	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}
	public String getCodTipoClientePrepago() {
		return codTipoClientePrepago;
	}
	public void setCodTipoClientePrepago(String codTipoClientePrepago) {
		this.codTipoClientePrepago = codTipoClientePrepago;
	}
	public String getCodOperadora() {
		return codOperadora;
	}
	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}
	public String getCodOperadoraSalvador() {
		return codOperadoraSalvador;
	}
	public void setCodOperadoraSalvador(String codOperadoraSalvador) {
		this.codOperadoraSalvador = codOperadoraSalvador;
	}
	public String getMensajeFacturacion() {
		return mensajeFacturacion;
	}
	public void setMensajeFacturacion(String mensajeFacturacion) {
		this.mensajeFacturacion = mensajeFacturacion;
	}
	public String getTextoXML() {
		return textoXML;
	}
	public void setTextoXML(String textoXML) {
		this.textoXML = textoXML;
	}
	public String getTextoXMLDescuento() {
		return textoXMLDescuento;
	}
	public void setTextoXMLDescuento(String textoXMLDescuento) {
		this.textoXMLDescuento = textoXMLDescuento;
	}
	public String getNumeroSolicitudAutorizacion() {
		return numeroSolicitudAutorizacion;
	}
	public void setNumeroSolicitudAutorizacion(String numeroSolicitudAutorizacion) {
		this.numeroSolicitudAutorizacion = numeroSolicitudAutorizacion;
	}
	public String getCargoSeleccionado() {
		return cargoSeleccionado;
	}
	public void setCargoSeleccionado(String cargoSeleccionado) {
		this.cargoSeleccionado = cargoSeleccionado;
	}

	public int getNumeroCargos() {
		return numeroCargos;
	}
	public void setNumeroCargos(int numeroCargos) {
		this.numeroCargos = numeroCargos;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public float getTxtMaximoDcto() {
		return txtMaximoDcto;
	}
	public void setTxtMaximoDcto(float txtMaximoDcto) {
		this.txtMaximoDcto = txtMaximoDcto;
	}
	public float getTxtMinimoDcto() {
		return txtMinimoDcto;
	}
	public void setTxtMinimoDcto(float txtMinimoDcto) {
		this.txtMinimoDcto = txtMinimoDcto;
	}
	public int getTxtParamDecBD() {
		return txtParamDecBD;
	}
	public void setTxtParamDecBD(int txtParamDecBD) {
		this.txtParamDecBD = txtParamDecBD;
	}
	public int getTxtParamDecForm() {
		return txtParamDecForm;
	}
	public void setTxtParamDecForm(int txtParamDecForm) {
		this.txtParamDecForm = txtParamDecForm;
	}
	public float getTxtPorcMaximoDcto() {
		return txtPorcMaximoDcto;
	}
	public void setTxtPorcMaximoDcto(float txtPorcMaximoDcto) {
		this.txtPorcMaximoDcto = txtPorcMaximoDcto;
	}
	public float getTxtPorcMinimoDcto() {
		return txtPorcMinimoDcto;
	}
	public void setTxtPorcMinimoDcto(float txtPorcMinimoDcto) {
		this.txtPorcMinimoDcto = txtPorcMinimoDcto;
	}
	public String getDistribuir() {
		return distribuir;
	}
	public void setDistribuir(String distribuir) {
		this.distribuir = distribuir;
	}
	
	private String preactivacionSoloLectura;
	
	public String getPreactivacionSoloLectura() {
		return preactivacionSoloLectura;
	}
	
	public void setPreactivacionSoloLectura(String preactivacionSoloLectura) {
		this.preactivacionSoloLectura = preactivacionSoloLectura;
	}
	
}
