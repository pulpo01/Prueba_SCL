package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ServSuplementarioLineaDTO;

public class WsInformacionLineaOutDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private float precioVenta;

	private long codVendedor;
	private String codCliente;
	private String nomCliente;
	private String nomCalleFact;
	private String numCalleFact;
	private String numPisoFact;
	private String codRegionFact;
	private String codProvinciaFact;
	private String codCiudadFact;
	private String codComunaFact;
	private String obsDireccionFact;
	private String codRegionCorr;
	private String codProvinciaCorr;
	private String codCiudadCorr;
	private String codComunaCorr;	

	private String telefContacto;//revisar Orden
	private String desEmpresa;
	private String nomCalleCorr;
	private String numCalleCorr;
	private String numPisoCorr;
	
	private String obsDireccionCorr;
	/*private int codSispago;
	private String codSituacion;
	private String numSerie;
	private String nomUsuario;
	private String fecAlta;//Formato mm-dd-yyyy
	*/
	private String codIcc;
	private String codPlantarif;	
	private int codCiclo;
	private String vigContrato;//Si es a 12, 0, 18 o 24 meses
	private String codCategoria;
	private int codUso;//Uso de la línea (prepago, postpago o hibrido)
	private ServSuplementarioLineaDTO[] serviciosSuplementarios;
	
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	
	public String getCodIcc() {
		return codIcc;
	}
	public void setCodIcc(String codIcc) {
		this.codIcc = codIcc;
	}
	public String getCodPlantarif() {
		return codPlantarif;
	}
	public void setCodPlantarif(String codPlantarif) {
		this.codPlantarif = codPlantarif;
	}
	
	public int getCodUso() {
		return codUso;
	}
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getDesEmpresa() {
		return desEmpresa;
	}
	public void setDesEmpresa(String desEmpresa) {
		this.desEmpresa = desEmpresa;
	}
	
	public String getNomCalleCorr() {
		return nomCalleCorr;
	}
	public void setNomCalleCorr(String nomCalleCorr) {
		this.nomCalleCorr = nomCalleCorr;
	}
	public String getNomCalleFact() {
		return nomCalleFact;
	}
	public void setNomCalleFact(String nomCalleFact) {
		this.nomCalleFact = nomCalleFact;
	}
	public String getNomCliente() {
		return nomCliente;
	}
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	
	public String getNumCalleCorr() {
		return numCalleCorr;
	}
	public void setNumCalleCorr(String numCalleCorr) {
		this.numCalleCorr = numCalleCorr;
	}
	public String getNumCalleFact() {
		return numCalleFact;
	}
	public void setNumCalleFact(String numCalleFact) {
		this.numCalleFact = numCalleFact;
	}
	public String getNumPisoCorr() {
		return numPisoCorr;
	}
	public void setNumPisoCorr(String numPisoCorr) {
		this.numPisoCorr = numPisoCorr;
	}
	public String getNumPisoFact() {
		return numPisoFact;
	}
	public void setNumPisoFact(String numPisoFact) {
		this.numPisoFact = numPisoFact;
	}
	
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getObsDireccionFact() {
		return obsDireccionFact;
	}
	public void setObsDireccionFact(String obsDireccionFact) {
		this.obsDireccionFact = obsDireccionFact;
	}
	public float getPrecioVenta() {
		return precioVenta;
	}
	public void setPrecioVenta(float precioVenta) {
		this.precioVenta = precioVenta;
	}
	public ServSuplementarioLineaDTO[] getServiciosSuplementarios() {
		return serviciosSuplementarios;
	}
	public void setServiciosSuplementarios(
			ServSuplementarioLineaDTO[] serviciosSuplementarios) {
		this.serviciosSuplementarios = serviciosSuplementarios;
	}
	public String getTelefContacto() {
		return telefContacto;
	}
	public void setTelefContacto(String telefContacto) {
		this.telefContacto = telefContacto;
	}
	public String getVigContrato() {
		return vigContrato;
	}
	public void setVigContrato(String vigContrato) {
		this.vigContrato = vigContrato;
	}
	public String getCodCiudadFact() {
		return codCiudadFact;
	}
	public void setCodCiudadFact(String codCiudadFact) {
		this.codCiudadFact = codCiudadFact;
	}
	public String getCodProvinciaFact() {
		return codProvinciaFact;
	}
	public void setCodProvinciaFact(String codProvinciaFact) {
		this.codProvinciaFact = codProvinciaFact;
	}
	public String getCodRegionFact() {
		return codRegionFact;
	}
	public void setCodRegionFact(String codRegionFact) {
		this.codRegionFact = codRegionFact;
	}
	public String getCodComunaFact() {
		return codComunaFact;
	}
	public void setCodComunaFact(String codComunaFact) {
		this.codComunaFact = codComunaFact;
	}
	public String getObsDireccionCorr() {
		return obsDireccionCorr;
	}
	public void setObsDireccionCorr(String obsDireccionCorr) {
		this.obsDireccionCorr = obsDireccionCorr;
	}
	public String getCodCiudadCorr() {
		return codCiudadCorr;
	}
	public void setCodCiudadCorr(String codCiudadCorr) {
		this.codCiudadCorr = codCiudadCorr;
	}
	public String getCodComunaCorr() {
		return codComunaCorr;
	}
	public void setCodComunaCorr(String codComunaCorr) {
		this.codComunaCorr = codComunaCorr;
	}
	public String getCodProvinciaCorr() {
		return codProvinciaCorr;
	}
	public void setCodProvinciaCorr(String codProvinciaCorr) {
		this.codProvinciaCorr = codProvinciaCorr;
	}
	public String getCodRegionCorr() {
		return codRegionCorr;
	}
	public void setCodRegionCorr(String codRegionCorr) {
		this.codRegionCorr = codRegionCorr;
	}
}
