package com.tmmas.cl.scl.altacliente.presentacion.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.MensajePromocionalDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OperadoraDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.RegistroFacturacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioReferenciaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class AltaClienteInicioForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String flagCtrlClasifColor = "0";
	private String flagCtrlClasifCrediticia = "0";
	private String flagCtrlClasifSegmento = "0";
	private String flagCtrlClasifCategoria = "0";
	private String flagCtrlClasifCalificacion = "0";
	private String flagCtrlClasifSegmentoActivo = "1";
	private String flagDatosParticular ="0";
	private String flagDatosEmpresa="0";
	
	private String tipoCliente;
	private DatosGeneralesDTO[] arrayTipoCliente;
	private ClasificacionDTO[] arrayClasificacion;
	private String codColor;
	private ValorClasificacionDTO[]	arrayColor;
	private String codSegmento;
	private String codSegmentoSeleccionado;
	private String codCrediticia;
	private ValorClasificacionDTO[] arrayCrediticia;
	private String codCrediticiaExcepcionado;
	private String categoriaCliente;
	private ValorClasificacionDTO[] arrayCategoriaCliente;
	private String codCalificacion;
	private ValorClasificacionDTO[] arrayCalificacion;
	
	//datos generales
	private String tipoIdentificacion1;
	//P-CSR-11002 JLGN 22-08-2011
	private String tipoIdentificacion1Seleccionado;
	private IdentificadorCivilComDTO[] arrayIdentificador1;
	private String numeroIdentificacion1;
	private String tipoIdentificacion2;
	private String tipoIdentificacion2Seleccionado;
	private IdentificadorCivilComDTO[] arrayIdentificador2;
	private String numeroIdentificacion2;
	private String cicloFact;
	private String codCicloSeleccionado;
	private String registroFacturacion;
	private String paramIndFacturaElectronica;
	private RegistroFacturacionComDTO[] arrayRegFact;
	private String correo;
	private String mensajesPromocionales;
	//P-CSR-11002 JLGN 05-08-2011
	private MensajePromocionalDTO[] arrayMensajesPromocionales;
	private String operadoraAnterior;
	private OperadoraDTO[] arrayOperadora;
	private String telefono;
	private String codOperadora;
	private String codOperadoraSalvador;
	
	//referencias del cliente
	private FormularioReferenciaClienteDTO[] arrayRefClienteAlta;
	
	//usuario legal
	private String tipoIdentificacionUsuarioLegal;
	private IdentificadorCivilComDTO[] arrayIdentificadorCliente;
	private String numeroIdentificacionUsuarioLegal;
	private String nombresUsuarioLegal;
	private String apellido1UsuarioLegal;
	private String apellido2UsuarioLegal;
	
	//usuario autorizado
	private String tipoIdentificacionUsuarioAut;
	private String numeroIdentificacionUsuarioAut;
	private String nombresUsuarioAut;
	private String apellido1UsuarioAut;
	private String apellido2UsuarioAut;
	
	private String largoNumCelular;
	
	private String moduloOrigen;
	private String codModuloSolicitudVenta;
	
	//Inicio P-CSR-11002 JLGN 25-04-2011
	private String envioFacturaFisica;
	private String cuentaFacebook;
	private String cuentaTwitter;
	private String flagTipCliente;
	private String passValidacion;	

	public String getPassValidacion() {
		return passValidacion;
	}
	public void setPassValidacion(String passValidacion) {
		this.passValidacion = passValidacion;
	}
	public String getFlagTipCliente() {
		return flagTipCliente;
	}
	public void setFlagTipCliente(String flagTipCliente) {
		this.flagTipCliente = flagTipCliente;
	}
	public String getEnvioFacturaFisica() {
		return envioFacturaFisica;
	}
	public void setEnvioFacturaFisica(String envioFacturaFisica) {
		this.envioFacturaFisica = envioFacturaFisica;
	}
	public String getCuentaFacebook() {
		return cuentaFacebook;
	}
	public void setCuentaFacebook(String cuentaFacebook) {
		this.cuentaFacebook = cuentaFacebook;
	}
	public String getCuentaTwitter() {
		return cuentaTwitter;
	}
	public void setCuentaTwitter(String cuentaTwitter) {
		this.cuentaTwitter = cuentaTwitter;
	}
	//Fin P-CSR-11002 JLGN 25-04-2011
	public String getApellido1UsuarioAut() {
		return apellido1UsuarioAut;
	}
	public void setApellido1UsuarioAut(String apellido1UsuarioAut) {
		this.apellido1UsuarioAut = apellido1UsuarioAut;
	}
	public String getApellido1UsuarioLegal() {
		return apellido1UsuarioLegal;
	}
	public void setApellido1UsuarioLegal(String apellido1UsuarioLegal) {
		this.apellido1UsuarioLegal = apellido1UsuarioLegal;
	}
	public String getApellido2UsuarioAut() {
		return apellido2UsuarioAut;
	}
	public void setApellido2UsuarioAut(String apellido2UsuarioAut) {
		this.apellido2UsuarioAut = apellido2UsuarioAut;
	}
	public String getApellido2UsuarioLegal() {
		return apellido2UsuarioLegal;
	}
	public void setApellido2UsuarioLegal(String apellido2UsuarioLegal) {
		this.apellido2UsuarioLegal = apellido2UsuarioLegal;
	}

	public ValorClasificacionDTO[] getArrayCategoriaCliente() {
		return arrayCategoriaCliente;
	}
	public void setArrayCategoriaCliente(
			ValorClasificacionDTO[] arrayCategoriaCliente) {
		this.arrayCategoriaCliente = arrayCategoriaCliente;
	}
	public ValorClasificacionDTO[] getArrayCalificacion() {
		return arrayCalificacion;
	}
	public void setArrayCalificacion(ValorClasificacionDTO[] arrayCalificacion) {
		this.arrayCalificacion = arrayCalificacion;
	}
	public ValorClasificacionDTO[] getArrayColor() {
		return arrayColor;
	}
	public void setArrayColor(ValorClasificacionDTO[] arrayColor) {
		this.arrayColor = arrayColor;
	}
	public ValorClasificacionDTO[] getArrayCrediticia() {
		return arrayCrediticia;
	}
	public void setArrayCrediticia(ValorClasificacionDTO[] arrayCrediticia) {
		this.arrayCrediticia = arrayCrediticia;
	}
	public IdentificadorCivilComDTO[] getArrayIdentificadorCliente() {
		return arrayIdentificadorCliente;
	}
	public void setArrayIdentificadorCliente(
			IdentificadorCivilComDTO[] arrayIdentificadorCliente) {
		this.arrayIdentificadorCliente = arrayIdentificadorCliente;
	}
	public IdentificadorCivilComDTO[] getArrayIdentificador1() {
		return arrayIdentificador1;
	}
	public void setArrayIdentificador1(
			IdentificadorCivilComDTO[] arrayIdentificador1) {
		this.arrayIdentificador1 = arrayIdentificador1;
	}
	public IdentificadorCivilComDTO[] getArrayIdentificador2() {
		return arrayIdentificador2;
	}
	public void setArrayIdentificador2(
			IdentificadorCivilComDTO[] arrayIdentificador2) {
		this.arrayIdentificador2 = arrayIdentificador2;
	}
	public OperadoraDTO[] getArrayOperadora() {
		return arrayOperadora;
	}
	public void setArrayOperadora(OperadoraDTO[] arrayOperadora) {
		this.arrayOperadora = arrayOperadora;
	}
	public FormularioReferenciaClienteDTO[] getArrayRefClienteAlta() {
		return arrayRefClienteAlta;
	}
	public void setArrayRefClienteAlta(
			FormularioReferenciaClienteDTO[] arrayRefClienteAlta) {
		this.arrayRefClienteAlta = arrayRefClienteAlta;
	}
	public RegistroFacturacionComDTO[] getArrayRegFact() {
		return arrayRegFact;
	}
	public void setArrayRegFact(RegistroFacturacionComDTO[] arrayRegFact) {
		this.arrayRegFact = arrayRegFact;
	}
	public DatosGeneralesDTO[] getArrayTipoCliente() {
		return arrayTipoCliente;
	}
	public void setArrayTipoCliente(DatosGeneralesDTO[] arrayTipoCliente) {
		this.arrayTipoCliente = arrayTipoCliente;
	}
	public String getCategoriaCliente() {
		return categoriaCliente;
	}
	public void setCategoriaCliente(String categoriaCliente) {
		this.categoriaCliente = categoriaCliente;
	}
	public String getCicloFact() {
		return cicloFact;
	}
	public void setCicloFact(String cicloFact) {
		this.cicloFact = cicloFact;
	}
	public String getCodCalificacion() {
		return codCalificacion;
	}
	public void setCodCalificacion(String codCalificacion) {
		this.codCalificacion = codCalificacion;
	}
	public String getCodCicloSeleccionado() {
		return codCicloSeleccionado;
	}
	public void setCodCicloSeleccionado(String codCicloSeleccionado) {
		this.codCicloSeleccionado = codCicloSeleccionado;
	}
	public String getCodColor() {
		return codColor;
	}
	public void setCodColor(String codColor) {
		this.codColor = codColor;
	}
	public String getCodCrediticia() {
		return codCrediticia;
	}
	public void setCodCrediticia(String codCrediticia) {
		this.codCrediticia = codCrediticia;
	}
	public String getCodCrediticiaExcepcionado() {
		return codCrediticiaExcepcionado;
	}
	public void setCodCrediticiaExcepcionado(String codCrediticiaExcepcionado) {
		this.codCrediticiaExcepcionado = codCrediticiaExcepcionado;
	}
	public String getCodModuloSolicitudVenta() {
		return codModuloSolicitudVenta;
	}
	public void setCodModuloSolicitudVenta(String codModuloSolicitudVenta) {
		this.codModuloSolicitudVenta = codModuloSolicitudVenta;
	}
	public String getCodSegmento() {
		return codSegmento;
	}
	public void setCodSegmento(String codSegmento) {
		this.codSegmento = codSegmento;
	}
	public String getCodSegmentoSeleccionado() {
		return codSegmentoSeleccionado;
	}
	public void setCodSegmentoSeleccionado(String codSegmentoSeleccionado) {
		this.codSegmentoSeleccionado = codSegmentoSeleccionado;
	}
	public String getCorreo() {
		return correo;
	}
	public void setCorreo(String correo) {
		this.correo = correo;
	}
	public String getFlagDatosEmpresa() {
		return flagDatosEmpresa;
	}
	public void setFlagDatosEmpresa(String flagDatosEmpresa) {
		this.flagDatosEmpresa = flagDatosEmpresa;
	}
	public String getFlagDatosParticular() {
		return flagDatosParticular;
	}
	public void setFlagDatosParticular(String flagDatosParticular) {
		this.flagDatosParticular = flagDatosParticular;
	}
	public String getLargoNumCelular() {
		return largoNumCelular;
	}
	public void setLargoNumCelular(String largoNumCelular) {
		this.largoNumCelular = largoNumCelular;
	}
	public String getMensajesPromocionales() {
		return mensajesPromocionales;
	}
	public void setMensajesPromocionales(String mensajesPromocionales) {
		this.mensajesPromocionales = mensajesPromocionales;
	}
	public String getModuloOrigen() {
		return moduloOrigen;
	}
	public void setModuloOrigen(String moduloOrigen) {
		this.moduloOrigen = moduloOrigen;
	}
	public String getNombresUsuarioAut() {
		return nombresUsuarioAut;
	}
	public void setNombresUsuarioAut(String nombresUsuarioAut) {
		this.nombresUsuarioAut = nombresUsuarioAut;
	}
	public String getNombresUsuarioLegal() {
		return nombresUsuarioLegal;
	}
	public void setNombresUsuarioLegal(String nombresUsuarioLegal) {
		this.nombresUsuarioLegal = nombresUsuarioLegal;
	}

	public String getNumeroIdentificacion1() {
		return numeroIdentificacion1;
	}
	public void setNumeroIdentificacion1(String numeroIdentificacion1) {
		this.numeroIdentificacion1 = numeroIdentificacion1;
	}
	public String getNumeroIdentificacion2() {
		return numeroIdentificacion2;
	}
	public void setNumeroIdentificacion2(String numeroIdentificacion2) {
		this.numeroIdentificacion2 = numeroIdentificacion2;
	}
	public String getNumeroIdentificacionUsuarioAut() {
		return numeroIdentificacionUsuarioAut;
	}
	public void setNumeroIdentificacionUsuarioAut(
			String numeroIdentificacionUsuarioAut) {
		this.numeroIdentificacionUsuarioAut = numeroIdentificacionUsuarioAut;
	}
	public String getNumeroIdentificacionUsuarioLegal() {
		return numeroIdentificacionUsuarioLegal;
	}
	public void setNumeroIdentificacionUsuarioLegal(
			String numeroIdentificacionUsuarioLegal) {
		this.numeroIdentificacionUsuarioLegal = numeroIdentificacionUsuarioLegal;
	}
	public String getOperadoraAnterior() {
		return operadoraAnterior;
	}
	public void setOperadoraAnterior(String operadoraAnterior) {
		this.operadoraAnterior = operadoraAnterior;
	}
	public String getParamIndFacturaElectronica() {
		return paramIndFacturaElectronica;
	}
	public void setParamIndFacturaElectronica(String paramIndFacturaElectronica) {
		this.paramIndFacturaElectronica = paramIndFacturaElectronica;
	}
	public String getRegistroFacturacion() {
		return registroFacturacion;
	}
	public void setRegistroFacturacion(String registroFacturacion) {
		this.registroFacturacion = registroFacturacion;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}

	public String getTipoIdentificacion1() {
		return tipoIdentificacion1;
	}
	public void setTipoIdentificacion1(String tipoIdentificacion1) {
		this.tipoIdentificacion1 = tipoIdentificacion1;
	}
	public String getTipoIdentificacion2() {
		return tipoIdentificacion2;
	}
	public void setTipoIdentificacion2(String tipoIdentificacion2) {
		this.tipoIdentificacion2 = tipoIdentificacion2;
	}
	public String getTipoIdentificacionUsuarioAut() {
		return tipoIdentificacionUsuarioAut;
	}
	public void setTipoIdentificacionUsuarioAut(String tipoIdentificacionUsuarioAut) {
		this.tipoIdentificacionUsuarioAut = tipoIdentificacionUsuarioAut;
	}
	public String getTipoIdentificacionUsuarioLegal() {
		return tipoIdentificacionUsuarioLegal;
	}
	public void setTipoIdentificacionUsuarioLegal(
			String tipoIdentificacionUsuarioLegal) {
		this.tipoIdentificacionUsuarioLegal = tipoIdentificacionUsuarioLegal;
	}
	public String getFlagCtrlClasifCalificacion() {
		return flagCtrlClasifCalificacion;
	}
	public void setFlagCtrlClasifCalificacion(String flagCtrlClasifCalificacion) {
		this.flagCtrlClasifCalificacion = flagCtrlClasifCalificacion;
	}
	public String getFlagCtrlClasifCategoria() {
		return flagCtrlClasifCategoria;
	}
	public void setFlagCtrlClasifCategoria(String flagCtrlClasifCategoria) {
		this.flagCtrlClasifCategoria = flagCtrlClasifCategoria;
	}
	public String getFlagCtrlClasifColor() {
		return flagCtrlClasifColor;
	}
	public void setFlagCtrlClasifColor(String flagCtrlClasifColor) {
		this.flagCtrlClasifColor = flagCtrlClasifColor;
	}
	public String getFlagCtrlClasifCrediticia() {
		return flagCtrlClasifCrediticia;
	}
	public void setFlagCtrlClasifCrediticia(String flagCtrlClasifCrediticia) {
		this.flagCtrlClasifCrediticia = flagCtrlClasifCrediticia;
	}
	public String getFlagCtrlClasifSegmento() {
		return flagCtrlClasifSegmento;
	}
	public void setFlagCtrlClasifSegmento(String flagCtrlClasifSegmento) {
		this.flagCtrlClasifSegmento = flagCtrlClasifSegmento;
	}
	public ClasificacionDTO[] getArrayClasificacion() {
		return arrayClasificacion;
	}
	public void setArrayClasificacion(ClasificacionDTO[] arrayClasificacion) {
		this.arrayClasificacion = arrayClasificacion;
	}
	public String getFlagCtrlClasifSegmentoActivo() {
		return flagCtrlClasifSegmentoActivo;
	}
	public void setFlagCtrlClasifSegmentoActivo(String flagCtrlClasifSegmentoActivo) {
		this.flagCtrlClasifSegmentoActivo = flagCtrlClasifSegmentoActivo;
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
	public String getTipoIdentificacion2Seleccionado() {
		return tipoIdentificacion2Seleccionado;
	}
	public void setTipoIdentificacion2Seleccionado(
			String tipoIdentificacion2Seleccionado) {
		this.tipoIdentificacion2Seleccionado = tipoIdentificacion2Seleccionado;
	}
	
	public int getCantidadReferenciasCliente() {
		if (getArrayRefClienteAlta() == null) {
			return 0;
		}
		else {
			return getArrayRefClienteAlta().length;
		}
	}
	public MensajePromocionalDTO[] getArrayMensajesPromocionales() {
		return arrayMensajesPromocionales;
	}
	public void setArrayMensajesPromocionales(
			MensajePromocionalDTO[] arrayMensajesPromocionales) {
		this.arrayMensajesPromocionales = arrayMensajesPromocionales;
	}
	public String getTipoIdentificacion1Seleccionado() {
		return tipoIdentificacion1Seleccionado;
	}
	public void setTipoIdentificacion1Seleccionado(
			String tipoIdentificacion1Seleccionado) {
		this.tipoIdentificacion1Seleccionado = tipoIdentificacion1Seleccionado;
	}
}
