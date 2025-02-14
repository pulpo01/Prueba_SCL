/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoConsumoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoMorosidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocumentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoAfinidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoCobroServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanIndemnizacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RegionDTO;


public class ParametrosComercialesDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	//private HashMapVO listaPlanIndemnizacion;
	private CampanaVigenteDTO listaCampanasVigentes[];
	private CausalDescuentoDTO listaCausalDescuento[];
	private CreditoConsumoDTO listaCreditoConsumo[];
	private CreditoMorosidadDTO listaCreditoMorosidad[];
	private GrupoAfinidadDTO listaGrupoAfinidad[];
	private GrupoCobroServicioDTO listaGrupoCobroServicio[];
	private ModalidadPagoDTO listaModalidadPago[];
	private PlanIndemnizacionDTO listaPlanIndemnizacion[];
	private PlanServicioDTO listaPlanServicio[];
	private ContratosDTO listaTipoContrato[];
	private DocumentoDTO documento;
	private RegionDTO region[];
	private String codigoCliente;
	private String nombreCliente;
	private String numeroIdentificacion;
	private String codigoTipoIdentificacion;
	private String codigoCuentaCliente;
	private String codigoSubCuentaCliente;
	private String nombreApellido1Cliente;
	private String nombreApellido2Cliente;
	private String fechaNacimientoCliente;	
	private String indicadorEstadoCivilCliente;
	private String indicadorSexoCliente;
	private String codigoActividadCliente;
	private String tipoCliente;
	private String codigoCeldaCliente;
    private String codigoCalidadCliente;
    private int indicativoFacturableCliente;
    private int codigoCicloCliente;
    private DireccionNegocioDTO direccionCliente;
    private String planComercialCliente;
    private long codigoEmpresa;
    /*--Datos Vendedor--*/
    private String codigoDealer;
	private String nombreDealer;
	private String codigoVendedor;
	private String nombreVendedor;
	private long codigoVendedorRaiz;
	private long codigoVenDealer;
	private DireccionNegocioDTO direccionVendedor;
	private String oficinaVendedor;
	private String codigoTipoComisionista;
	private String descripcionTipoComisionista;
	private int indicadorTipoVenta;
	private String codigoOperadora;
	
	
	public String getCodigoOperadora() {
		return codigoOperadora;
	}
	public void setCodigoOperadora(String codigoOperadora) {
		this.codigoOperadora = codigoOperadora;
	}
	public int getIndicadorTipoVenta() {
		return indicadorTipoVenta;
	}
	public void setIndicadorTipoVenta(int indicadorTipoVenta) {
		this.indicadorTipoVenta = indicadorTipoVenta;
	}
	public CampanaVigenteDTO[] getCampanasVigentes() {
		return listaCampanasVigentes;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoDealer() {
		return codigoDealer;
	}
	public void setCodigoDealer(String codigoDealer) {
		this.codigoDealer = codigoDealer;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getNombreDealer() {
		return nombreDealer;
	}
	public void setNombreDealer(String nombreDealer) {
		this.nombreDealer = nombreDealer;
	}
	public String getNombreVendedor() {
		return nombreVendedor;
	}
	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}
	public void setCampanasVigentes(CampanaVigenteDTO[] listaCampanasVigentes) {
		this.listaCampanasVigentes = listaCampanasVigentes;
	}
	public CausalDescuentoDTO[] getCausalDescuento() {
		return listaCausalDescuento;
	}
	public void setCausalDescuento(CausalDescuentoDTO[] listaCausalDescuento) {
		this.listaCausalDescuento = listaCausalDescuento;
	}
	
	public CreditoConsumoDTO[] getCreditoConsumo() {
		return listaCreditoConsumo;
	}
	public void setCreditoConsumo(CreditoConsumoDTO[] listaCreditoConsumo) {
		this.listaCreditoConsumo = listaCreditoConsumo;
	}
	
	public CreditoMorosidadDTO[] getCreditoMorosidad() {
		return listaCreditoMorosidad;
	}
	public void setCreditoMorosidad(CreditoMorosidadDTO[] listaCreditoMorosidad) {
		this.listaCreditoMorosidad = listaCreditoMorosidad;
	}
	public GrupoAfinidadDTO[] getGrupoAfinidad() {
		return listaGrupoAfinidad;
	}
	public void setGrupoAfinidad(GrupoAfinidadDTO[] listaGrupoAfinidad) {
		this.listaGrupoAfinidad= listaGrupoAfinidad;
	}
	public GrupoCobroServicioDTO[] getGrupoCobroServicio() {
		return listaGrupoCobroServicio;
	}
	public void setGrupoCobroServicio(GrupoCobroServicioDTO[] listaGrupoCobroServicio) {
		this.listaGrupoCobroServicio= listaGrupoCobroServicio;
	}
	
	public ModalidadPagoDTO[] getListaModalidadPago() {
		return listaModalidadPago;
	}
	public void setListaModalidadPago(ModalidadPagoDTO[] listaModalidadPago) {
		this.listaModalidadPago= listaModalidadPago;
	}
	
	public PlanIndemnizacionDTO[] getListaPlanIndemnizacion() {
		return listaPlanIndemnizacion;
	}
	public void setListaPlanIndemnizacion(PlanIndemnizacionDTO[] listaPlanIndemnizacion) {
		this.listaPlanIndemnizacion = listaPlanIndemnizacion;
	}
	
	
	public PlanServicioDTO[] getListaPlanServicio() {
		return listaPlanServicio;
	}
	public void setListaPlanServicio(PlanServicioDTO[] listaPlanServicio) {
		this.listaPlanServicio = listaPlanServicio;
	}
	public ContratosDTO[] getListaTipoContrato() {
		return listaTipoContrato;
	}
	public void setListaTipoContrato(ContratosDTO[] listaTipoContrato) {
		this.listaTipoContrato = listaTipoContrato;
	}
	public DocumentoDTO getDocumento() {
		return documento;
	}
	public void setDocumento(DocumentoDTO documento) {
		this.documento = documento;
	}
	public RegionDTO[] getRegion() {
		return region;
	}
	public void setRegion(RegionDTO[] region) {
		this.region = region;
	}
	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}
	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	public long getCodigoVenDealer() {
		return codigoVenDealer;
	}
	public void setCodigoVenDealer(long codigoVenDealer) {
		this.codigoVenDealer = codigoVenDealer;
	}
	public long getCodigoVendedorRaiz() {
		return codigoVendedorRaiz;
	}
	public void setCodigoVendedorRaiz(long codigoVendedorRaiz) {
		this.codigoVendedorRaiz = codigoVendedorRaiz;
	}
	public String getCodigoActividadCliente() {
		return codigoActividadCliente;
	}
	public void setCodigoActividadCliente(String codigoActividadCliente) {
		this.codigoActividadCliente = codigoActividadCliente;
	}
	public String getCodigoCalidadCliente() {
		return codigoCalidadCliente;
	}
	public void setCodigoCalidadCliente(String codigoCalidadCliente) {
		this.codigoCalidadCliente = codigoCalidadCliente;
	}
	public String getCodigoCeldaCliente() {
		return codigoCeldaCliente;
	}
	public void setCodigoCeldaCliente(String codigoCeldaCliente) {
		this.codigoCeldaCliente = codigoCeldaCliente;
	}
	public int getCodigoCicloCliente() {
		return codigoCicloCliente;
	}
	public void setCodigoCicloCliente(int codigoCicloCliente) {
		this.codigoCicloCliente = codigoCicloCliente;
	}
	public String getCodigoCuentaCliente() {
		return codigoCuentaCliente;
	}
	public void setCodigoCuentaCliente(String codigoCuentaCliente) {
		this.codigoCuentaCliente = codigoCuentaCliente;
	}
	public String getCodigoSubCuentaCliente() {
		return codigoSubCuentaCliente;
	}
	public void setCodigoSubCuentaCliente(String codigoSubCuentaCliente) {
		this.codigoSubCuentaCliente = codigoSubCuentaCliente;
	}
	public DireccionNegocioDTO getDireccionCliente() {
		return direccionCliente;
	}
	public void setDireccionCliente(DireccionNegocioDTO direccionCliente) {
		this.direccionCliente = direccionCliente;
	}
	public String getFechaNacimientoCliente() {
		return fechaNacimientoCliente;
	}
	public void setFechaNacimientoCliente(String fechaNacimientoCliente) {
		this.fechaNacimientoCliente = fechaNacimientoCliente;
	}
	public String getIndicadorEstadoCivilCliente() {
		return indicadorEstadoCivilCliente;
	}
	public void setIndicadorEstadoCivilCliente(String indicadorEstadoCivilCliente) {
		this.indicadorEstadoCivilCliente = indicadorEstadoCivilCliente;
	}
	public String getIndicadorSexoCliente() {
		return indicadorSexoCliente;
	}
	public void setIndicadorSexoCliente(String indicadorSexoCliente) {
		this.indicadorSexoCliente = indicadorSexoCliente;
	}
	public int getIndicativoFacturableCliente() {
		return indicativoFacturableCliente;
	}
	public void setIndicativoFacturableCliente(int indicativoFacturableCliente) {
		this.indicativoFacturableCliente = indicativoFacturableCliente;
	}
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}
	public String getNombreApellido1Cliente() {
		return nombreApellido1Cliente;
	}
	public void setNombreApellido1Cliente(String nombreApellido1Cliente) {
		this.nombreApellido1Cliente = nombreApellido1Cliente;
	}
	public String getNombreApellido2Cliente() {
		return nombreApellido2Cliente;
	}
	public void setNombreApellido2Cliente(String nombreApellido2Cliente) {
		this.nombreApellido2Cliente = nombreApellido2Cliente;
	}
	public DireccionNegocioDTO getDireccionVendedor() {
		return direccionVendedor;
	}
	public void setDireccionVendedor(DireccionNegocioDTO direccionVendedor) {
		this.direccionVendedor = direccionVendedor;
	}
	public long getCodigoEmpresa() {
		return codigoEmpresa;
	}
	public void setCodigoEmpresa(long codigoEmpresa) {
		this.codigoEmpresa = codigoEmpresa;
	}
	public String getPlanComercialCliente() {
		return planComercialCliente;
	}
	public void setPlanComercialCliente(String planComercialCliente) {
		this.planComercialCliente = planComercialCliente;
	}
	public String getOficinaVendedor() {
		return oficinaVendedor;
	}
	public void setOficinaVendedor(String oficinaVendedor) {
		this.oficinaVendedor = oficinaVendedor;
	}
	public String getCodigoTipoComisionista() {
		return codigoTipoComisionista;
	}
	public void setCodigoTipoComisionista(String codigoTipoComisionista) {
		this.codigoTipoComisionista = codigoTipoComisionista;
	}
	public String getDescripcionTipoComisionista() {
		return descripcionTipoComisionista;
	}
	public void setDescripcionTipoComisionista(String descripcionTipoComisionista) {
		this.descripcionTipoComisionista = descripcionTipoComisionista;
	}
		
}
