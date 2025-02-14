/**
 * 
 */
package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaCarrierPasilloLDIDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

/**
 * @author JIB
 */
public class ClienteCarrierPasilloLDIForm extends ActionForm {

	private static final long serialVersionUID = -3210821838101937786L;

	private AltaCarrierPasilloLDIDTO altaCarrierPasilloLDIDTO = new AltaCarrierPasilloLDIDTO();

	private DatosGeneralesDTO[] arrayTipoCliente;

	private String direccionFacturacion;

	private FormularioDireccionDTO formularioDireccionDTO;

	private String mensaje;
	
	private String largoNumTelefonoExterno;
	
	private LstPTaPlanTarifarioOutDTO[] arrayPlanTarifario;
	
	private String mensajeError;

	public final AltaCarrierPasilloLDIDTO getAltaCarrierPasilloLDIDTO() {
		return altaCarrierPasilloLDIDTO;
	}

	public String getApellido1() {
		return altaCarrierPasilloLDIDTO.getApellido1();
	}

	public String getApellido2() {
		return altaCarrierPasilloLDIDTO.getApellido2();
	}

	public DatosGeneralesDTO[] getArrayTipoCliente() {
		return arrayTipoCliente;
	}

	public String getCodTipoCliente() {
		return altaCarrierPasilloLDIDTO.getCodTipoCliente();
	}

	public String getDireccionFacturacion() {
		return direccionFacturacion;
	}

	public FormularioDireccionDTO getFormularioDireccionDTO() {
		return formularioDireccionDTO;
	}

	public String getMensaje() {
		return mensaje;
	}

	public String getNombreEmpresa() {
		return altaCarrierPasilloLDIDTO.getNombreEmpresa();
	}

	public String getNombres() {
		return altaCarrierPasilloLDIDTO.getNombres();
	}

	public String getNumCelularExterno() {
		return altaCarrierPasilloLDIDTO.getNumCelularExterno();
	}

	public String getRazonSocial() {
		return altaCarrierPasilloLDIDTO.getRazonSocial();
	}

	public void limpiar() {
		this.setCodTipoCliente("2");
		this.setApellido1(null);
		this.setApellido2(null);
		this.setDireccionFacturacion(null);
		this.setMensaje(null);
		this.setNombres(null);
		this.setNombreEmpresa(null);
		this.setNumCelularExterno(null);
		this.setRazonSocial(null);
	}

	public final void setAltaCarrierPasilloLDIDTO(AltaCarrierPasilloLDIDTO altaCarrierPasilloLDIDTO) {
		this.altaCarrierPasilloLDIDTO = altaCarrierPasilloLDIDTO;
	}

	public void setApellido1(String apellido1) {
		altaCarrierPasilloLDIDTO.setApellido1(apellido1);
	}

	public void setApellido2(String apellido2) {
		altaCarrierPasilloLDIDTO.setApellido2(apellido2);
	}

	public void setArrayTipoCliente(DatosGeneralesDTO[] arrayTipoCliente) {
		this.arrayTipoCliente = arrayTipoCliente;
	}

	public void setCodTipoCliente(String codTipoCliente) {
		altaCarrierPasilloLDIDTO.setCodTipoCliente(codTipoCliente);
	}

	public void setDireccionFacturacion(String direccionFacturacion) {
		this.direccionFacturacion = direccionFacturacion;
	}

	public void setFormularioDireccionDTO(FormularioDireccionDTO formularioDireccionDTO) {
		this.formularioDireccionDTO = formularioDireccionDTO;
	}

	public void setMensaje(String mensajeAccion) {
		this.mensaje = mensajeAccion;
	}

	public void setNombreEmpresa(String nombreEmpresa) {
		altaCarrierPasilloLDIDTO.setNombreEmpresa(nombreEmpresa);
	}

	public void setNombres(String nombres) {
		altaCarrierPasilloLDIDTO.setNombres(nombres);
	}

	public void setNumCelularExterno(String numCelularExterno) {
		altaCarrierPasilloLDIDTO.setNumCelularExterno(numCelularExterno);
	}

	public void setRazonSocial(String razonSocial) {
		altaCarrierPasilloLDIDTO.setRazonSocial(razonSocial);
	}

	public String getCodVendedor() {
		return altaCarrierPasilloLDIDTO.getCodVendedor();
	}

	public void setCodVendedor(String codVendedor) {
		altaCarrierPasilloLDIDTO.setCodVendedor(codVendedor);
	}

	public String getCodTipComis() {
		return altaCarrierPasilloLDIDTO.getCodTipComis();
	}

	public void setCodTipComis(String codTipComis) {
		altaCarrierPasilloLDIDTO.setCodTipComis(codTipComis);
	}

	public String getCodOficina() {
		return altaCarrierPasilloLDIDTO.getCodOficina();
	}

	public void setCodOficina(String codOficina) {
		altaCarrierPasilloLDIDTO.setCodOficina(codOficina);
	}

	public final String getLargoNumTelefonoExterno() {
		return largoNumTelefonoExterno;
	}

	public final void setLargoNumTelefonoExterno(String largoNumTelefonoExterno) {
		this.largoNumTelefonoExterno = largoNumTelefonoExterno;
	}

	public final LstPTaPlanTarifarioOutDTO[] getArrayPlanTarifario() {
		return arrayPlanTarifario;
	}

	public final void setArrayPlanTarifario(LstPTaPlanTarifarioOutDTO[] arrayPlanTarifario) {
		this.arrayPlanTarifario = arrayPlanTarifario;
	}
	
	public String getCodigoPlanTarifario() {
		return altaCarrierPasilloLDIDTO.getCodigoPlanTarifario();
	}

	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		altaCarrierPasilloLDIDTO.setCodigoPlanTarifario(codigoPlanTarifario);
	}

	public final String getMensajeError() {
		return mensajeError;
	}

	public final void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}

	
}
