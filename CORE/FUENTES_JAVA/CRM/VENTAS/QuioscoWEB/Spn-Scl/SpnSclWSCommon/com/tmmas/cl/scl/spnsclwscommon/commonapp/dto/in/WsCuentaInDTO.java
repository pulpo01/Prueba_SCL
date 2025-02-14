package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;
import java.util.Date;

public class WsCuentaInDTO implements Serializable{

	private static final long serialVersionUID = 1L;
		
	 private WsClienteInDTO   ClienteDTO;	 
	 private String   DescripcionCuenta;	 
	 private Date     FechaNacimientoRespCta;
	 private WsDireccionInDTO direcciones;
	 private String   TelefonoRespnsable;	 
	 private String   CodigoTipoIdent;  
	 private String   NumeroIdent;    
	 private String   CodigoClascta;    
	 private String   CodigoTipcomis;
	 private String   IdentificadorTransaccion;

	 
	 
	public String getIdentificadorTransaccion() {
		return IdentificadorTransaccion;
	}
	public void setIdentificadorTransaccion(String identificadorTransaccion) {
		IdentificadorTransaccion = identificadorTransaccion;
	}
	public String getCodigoClascta() {
		return CodigoClascta;
	}
	public void setCodigoClascta(String codigoClascta) {
		CodigoClascta = codigoClascta;
	}
	
	public String getCodigoTipcomis() {
		return CodigoTipcomis;
	}
	public void setCodigoTipcomis(String codigoTipcomis) {
		CodigoTipcomis = codigoTipcomis;
	}
	public String getCodigoTipoIdent() {
		return CodigoTipoIdent;
	}
	public void setCodigoTipoIdent(String codigoTipoIdent) {
		CodigoTipoIdent = codigoTipoIdent;
	}
	public String getDescripcionCuenta() {
		return DescripcionCuenta;
	}
	public void setDescripcionCuenta(String descripcionCuenta) {
		DescripcionCuenta = descripcionCuenta;
	}
	
	public String getNumeroIdent() {
		return NumeroIdent;
	}
	public void setNumeroIdent(String numeroIdent) {
		NumeroIdent = numeroIdent;
	}
	public WsClienteInDTO getClienteDTO() {
		return ClienteDTO;
	}
	public void setClienteDTO(WsClienteInDTO clienteDTO) {
		ClienteDTO = clienteDTO;
	}
	public Date getFechaNacimientoRespCta() {
		return FechaNacimientoRespCta;
	}
	public void setFechaNacimientoRespCta(Date fechaNacimientoRespCta) {
		FechaNacimientoRespCta = fechaNacimientoRespCta;
	}
	public String getTelefonoRespnsable() {
		return TelefonoRespnsable;
	}
	public void setTelefonoRespnsable(String telefonoRespnsable) {
		TelefonoRespnsable = telefonoRespnsable;
	}
	public WsDireccionInDTO getDirecciones() {
		return direcciones;
	}
	public void setDirecciones(WsDireccionInDTO direcciones) {
		this.direcciones = direcciones;
	}

}
