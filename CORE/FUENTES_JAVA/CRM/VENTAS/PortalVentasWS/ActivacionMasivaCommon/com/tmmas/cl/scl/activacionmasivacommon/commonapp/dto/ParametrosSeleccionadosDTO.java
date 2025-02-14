package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CiudadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoConsumoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoMorosidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocumentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoAfinidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoCobroServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.NumeroCuotasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanIndemnizacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProvinciaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RegionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoComisionistaDTO;

public class ParametrosSeleccionadosDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private CampanaVigenteDTO campanaVigente;
	private CausalDescuentoDTO causalDescuento;
	private CiudadDTO ciudad;
	private CreditoConsumoDTO creditoConsumo;
	private CreditoMorosidadDTO creditoMorosidadDTO;
	private DocumentoDTO documento;
	private GrupoAfinidadDTO grupoAfinidad;
	private GrupoCobroServicioDTO grupoCobroServicio;
	private ModalidadPagoDTO modalidadPagoDTO;
	private NumeroCuotasDTO numeroCuotas;
	private PlanIndemnizacionDTO planIndemnizacion;
	private ProvinciaDTO provincia;
	private RegionDTO region;
	private TipoComisionistaDTO tipoComisionista;
	private ContratosDTO contrato;
	private ListadoCentralDTO central;
	private ListadoCeldaDTO celda;
	public ListadoCeldaDTO getCelda() {
		return celda;
	}
	public void setCelda(ListadoCeldaDTO celda) {
		this.celda = celda;
	}
	public ListadoCentralDTO getCentral() {
		return central;
	}
	public void setCentral(ListadoCentralDTO central) {
		this.central = central;
	}
	public ContratosDTO getContrato() {
		return contrato;
	}
	public void setContrato(ContratosDTO contrato) {
		this.contrato = contrato;
	}
	public CampanaVigenteDTO getCampanaVigente() {
		return campanaVigente;
	}
	public void setCampanaVigente(CampanaVigenteDTO campanaVigente) {
		this.campanaVigente = campanaVigente;
	}
	public CausalDescuentoDTO getCausalDescuento() {
		return causalDescuento;
	}
	public void setCausalDescuento(CausalDescuentoDTO causalDescuento) {
		this.causalDescuento = causalDescuento;
	}
	public CiudadDTO getCiudad() {
		return ciudad;
	}
	public void setCiudad(CiudadDTO ciudad) {
		this.ciudad = ciudad;
	}
	
	public CreditoConsumoDTO getCreditoConsumo() {
		return creditoConsumo;
	}
	public void setCreditoConsumo(CreditoConsumoDTO creditoConsumo) {
		this.creditoConsumo = creditoConsumo;
	}
	public CreditoMorosidadDTO getCreditoMorosidadDTO() {
		return creditoMorosidadDTO;
	}
	public void setCreditoMorosidadDTO(CreditoMorosidadDTO creditoMorosidadDTO) {
		this.creditoMorosidadDTO = creditoMorosidadDTO;
	}
	public DocumentoDTO getDocumento() {
		return documento;
	}
	public void setDocumento(DocumentoDTO documento) {
		this.documento = documento;
	}
	public GrupoAfinidadDTO getGrupoAfinidad() {
		return grupoAfinidad;
	}
	public void setGrupoAfinidad(GrupoAfinidadDTO grupoAfinidad) {
		this.grupoAfinidad = grupoAfinidad;
	}
	public GrupoCobroServicioDTO getGrupoCobroServicio() {
		return grupoCobroServicio;
	}
	public void setGrupoCobroServicio(GrupoCobroServicioDTO grupoCobroServicio) {
		this.grupoCobroServicio = grupoCobroServicio;
	}
	public ModalidadPagoDTO getModalidadPagoDTO() {
		return modalidadPagoDTO;
	}
	public void setModalidadPagoDTO(ModalidadPagoDTO modalidadPagoDTO) {
		this.modalidadPagoDTO = modalidadPagoDTO;
	}
	public NumeroCuotasDTO getNumeroCuotas() {
		return numeroCuotas;
	}
	public void setNumeroCuotas(NumeroCuotasDTO numeroCuotas) {
		this.numeroCuotas = numeroCuotas;
	}
	public PlanIndemnizacionDTO getPlanIndemnizacion() {
		return planIndemnizacion;
	}
	public void setPlanIndemnizacion(PlanIndemnizacionDTO planIndemnizacion) {
		this.planIndemnizacion = planIndemnizacion;
	}
	public ProvinciaDTO getProvincia() {
		return provincia;
	}
	public void setProvincia(ProvinciaDTO provincia) {
		this.provincia = provincia;
	}
	public RegionDTO getRegion() {
		return region;
	}
	public void setRegion(RegionDTO region) {
		this.region = region;
	}
	public TipoComisionistaDTO getTipoComisionista() {
		return tipoComisionista;
	}
	public void setTipoComisionista(TipoComisionistaDTO tipoComisionista) {
		this.tipoComisionista = tipoComisionista;
	}
	
	
	
	
	

}
