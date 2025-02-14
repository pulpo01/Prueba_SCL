package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonapp.dto.WsUsuarioInDTO;

public class DatosGeneralesVentaDTO implements Serializable, Cloneable{
	private static final long serialVersionUID = 1L;


	private String fechaActual;
	private String codigoCliente;
	private String numeroVenta;
	private String numeroSerieSimcard;
	private String numeroSerieTerminal;
	private String numeroSerieKit = new String("");	
	private String codigoPlanTarifario;
	private String numeroCelular;
	private String codigoVendedorRaiz;
	private String codigoVendedor;
	private String numeroTransaccionVenta;
	private String nombreUsuarioOracle;
	
	//-- datos obtenidos de la cabecera
	private String codigoCelda;  
	private String codigoCentral;
	private String tipoTerminal;
	private String numeroPerContrato;
	private String codigoEstado;
	private String identificadorEmpresa;
    private String codigoGrupoServicio;
    private String codigoModalidadVenta;
    private String codigoTipoContrato;
    private String numeroContrato;
    private String codigoCreditoMorosidad;
    private String codigoCreditoConsumo;
    private String indicadorFacturable;
    private String codigoVendedorDealer;
    private String codigoGrupoAfinidad;
    private String indicadorComodato;
    private String codigoPlanIndemnizacion;
    private String codigoTerminalGSM;
    private String codigoSimcardGSM;
    private String IndicadorCuotas;
    private String codigoCausaDescuento;
    private String codigoCuotas;
    
	//-- CAMPAÑAS
	private String codigoCampaña;
	private String aplicaCampañaA;
    
    private String estadoSerieSimcard;
    private String estadoSerieTerminal;
    private int    correlativoLinea;
    private int    numeroOrden;
    
    //Datos Ev. de Riesgo
    private long numeroSolicitud;
    
    //-- Control Error
	private String estadoError;
	private String detalleError;
	
	private String tipoPlanPostpago;
	private String tipoPlanHibrido;
	
	//--HOME DE LA LINEA
	private String codigoRegion;
	private String codigoProvincia;
	private String codigoCiudad;
	
	//USUARIO
	private WsUsuarioInDTO usuarioLinea;
	
	
	private String indicadorSexo;
	
	/* CSR-11002
	 * private String indicadorPortado;*/
	private String codigoOperador; //CSR-11002
	private String codPrestacion; //CSR-11002

	
	private String numeroAbonado;
		
	private String codigoTecnologia;
	private String codigoGrupoTecnologico;
	
		
	public String getCodPrestacion() {
		return codPrestacion;
	}
	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}
	public String getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(String numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public String getCodigoOperador() {
		return codigoOperador;
	}
	public void setCodigoOperador(String codigoOperador) {
		this.codigoOperador = codigoOperador;
	}
	/*CSR-11002
	public String getIndicadorPortado() {
		return indicadorPortado;
	}
	
	public void setIndicadorPortado(String indicadorPortado) {
		this.indicadorPortado = indicadorPortado;
	}
	*/
	public String getCodigoCiudad() {
		return codigoCiudad;
	}
	public void setCodigoCiudad(String codigoCiudad) {
		this.codigoCiudad = codigoCiudad;
	}
	public String getCodigoProvincia() {
		return codigoProvincia;
	}
	public void setCodigoProvincia(String codigoProvincia) {
		this.codigoProvincia = codigoProvincia;
	}
	public String getCodigoRegion() {
		return codigoRegion;
	}
	public void setCodigoRegion(String codigoRegion) {
		this.codigoRegion = codigoRegion;
	}
	public String getTipoPlanHibrido() {
		return tipoPlanHibrido;
	}
	public void setTipoPlanHibrido(String tipoPlanHibrido) {
		this.tipoPlanHibrido = tipoPlanHibrido;
	}
	public String getTipoPlanPostpago() {
		return tipoPlanPostpago;
	}
	public void setTipoPlanPostpago(String tipoPlanPostpago) {
		this.tipoPlanPostpago = tipoPlanPostpago;
	}
	public String getDetalleError() {
		return detalleError;
	}
	public void setDetalleError(String detalleError) {
		this.detalleError = detalleError;
	}
	public String getEstadoError() {
		return estadoError;
	}
	public void setEstadoError(String estadoError) {
		this.estadoError = estadoError;
	}
	public long getNumeroSolicitud() {
		return numeroSolicitud;
	}
	public void setNumeroSolicitud(long numeroSolicitud) {
		this.numeroSolicitud = numeroSolicitud;
	}
	public int getNumeroOrden() {
		return numeroOrden;
	}
	public void setNumeroOrden(int numeroOrden) {
		this.numeroOrden = numeroOrden;
	}
	public int getCorrelativoLinea() {
		return correlativoLinea;
	}
	public void setCorrelativoLinea(int correlativoLinea) {
		this.correlativoLinea = correlativoLinea;
	}
	public String getCodigoCelda() {
		return codigoCelda;
	}
	public void setCodigoCelda(String codigoCelda) {
		this.codigoCelda = codigoCelda;
	}
	public String getCodigoCentral() {
		return codigoCentral;
	}
	public void setCodigoCentral(String codigoCentral) {
		this.codigoCentral = codigoCentral;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoCreditoConsumo() {
		return codigoCreditoConsumo;
	}
	public void setCodigoCreditoConsumo(String codigoCreditoConsumo) {
		this.codigoCreditoConsumo = codigoCreditoConsumo;
	}
	public String getCodigoCreditoMorosidad() {
		return codigoCreditoMorosidad;
	}
	public void setCodigoCreditoMorosidad(String codigoCreditoMorosidad) {
		this.codigoCreditoMorosidad = codigoCreditoMorosidad;
	}
	public String getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(String codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	public String getIndicadorFacturable() {
		return indicadorFacturable;
	}
	public void setIndicadorFacturable(String indicadorFacturable) {
		this.indicadorFacturable = indicadorFacturable;
	}
	public String getCodigoGrupoServicio() {
		return codigoGrupoServicio;
	}
	public void setCodigoGrupoServicio(String codigoGrupoServicio) {
		this.codigoGrupoServicio = codigoGrupoServicio;
	}
	public String getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(String codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getCodigoTipoContrato() {
		return codigoTipoContrato;
	}
	public void setCodigoTipoContrato(String codigoTipoContrato) {
		this.codigoTipoContrato = codigoTipoContrato;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getCodigoVendedorRaiz() {
		return codigoVendedorRaiz;
	}
	public void setCodigoVendedorRaiz(String codigoVendedorRaiz) {
		this.codigoVendedorRaiz = codigoVendedorRaiz;
	}
	public String getFechaActual() {
		return fechaActual;
	}
	public void setFechaActual(String fechaActual) {
		this.fechaActual = fechaActual;
	}
	public String getIdentificadorEmpresa() {
		return identificadorEmpresa;
	}
	public void setIdentificadorEmpresa(String identificadorEmpresa) {
		this.identificadorEmpresa = identificadorEmpresa;
	}
	public String getNombreUsuarioOracle() {
		return nombreUsuarioOracle;
	}
	public void setNombreUsuarioOracle(String nombreUsuarioOracle) {
		this.nombreUsuarioOracle = nombreUsuarioOracle;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getNumeroContrato() {
		return numeroContrato;
	}
	public void setNumeroContrato(String numeroContrato) {
		this.numeroContrato = numeroContrato;
	}
	public String getNumeroPerContrato() {
		return numeroPerContrato;
	}
	public void setNumeroPerContrato(String numeroPerContrato) {
		this.numeroPerContrato = numeroPerContrato;
	}
	public String getNumeroSerieSimcard() {
		return numeroSerieSimcard;
	}
	public void setNumeroSerieSimcard(String numeroSerieSimcard) {
		this.numeroSerieSimcard = numeroSerieSimcard;
	}
	public String getNumeroSerieTerminal() {
		return numeroSerieTerminal;
	}
	public void setNumeroSerieTerminal(String numeroSerieTerminal) {
		this.numeroSerieTerminal = numeroSerieTerminal;
	}
	public String getNumeroTransaccionVenta() {
		return numeroTransaccionVenta;
	}
	public void setNumeroTransaccionVenta(String numeroTransaccionVenta) {
		this.numeroTransaccionVenta = numeroTransaccionVenta;
	}
	public String getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getTipoTerminal() {
		return tipoTerminal;
	}
	public void setTipoTerminal(String tipoTerminal) {
		this.tipoTerminal = tipoTerminal;
	}
	public String getCodigoGrupoAfinidad() {
		return codigoGrupoAfinidad;
	}
	public void setCodigoGrupoAfinidad(String codigoGrupoAfinidad) {
		this.codigoGrupoAfinidad = codigoGrupoAfinidad;
	}
	public String getCodigoPlanIndemnizacion() {
		return codigoPlanIndemnizacion;
	}
	public void setCodigoPlanIndemnizacion(String codigoPlanIndemnizacion) {
		this.codigoPlanIndemnizacion = codigoPlanIndemnizacion;
	}
	public String getCodigoVendedorDealer() {
		return codigoVendedorDealer;
	}
	public void setCodigoVendedorDealer(String codigoVendedorDealer) {
		this.codigoVendedorDealer = codigoVendedorDealer;
	}
	public String getIndicadorComodato() {
		return indicadorComodato;
	}
	public void setIndicadorComodato(String indicadorComodato) {
		this.indicadorComodato = indicadorComodato;
	}
	public String getCodigoSimcardGSM() {
		return codigoSimcardGSM;
	}
	public void setCodigoSimcardGSM(String codigoSimcardGSM) {
		this.codigoSimcardGSM = codigoSimcardGSM;
	}
	public String getCodigoTerminalGSM() {
		return codigoTerminalGSM;
	}
	public void setCodigoTerminalGSM(String codigoTerminalGSM) {
		this.codigoTerminalGSM = codigoTerminalGSM;
	}
	public String getIndicadorCuotas() {
		return IndicadorCuotas;
	}
	public void setIndicadorCuotas(String indicadorCuotas) {
		IndicadorCuotas = indicadorCuotas;
	}
	public String getEstadoSerieSimcard() {
		return estadoSerieSimcard;
	}
	public void setEstadoSerieSimcard(String estadoSerieSimcard) {
		this.estadoSerieSimcard = estadoSerieSimcard;
	}
	public String getEstadoSerieTerminal() {
		return estadoSerieTerminal;
	}
	public void setEstadoSerieTerminal(String estadoSerieTerminal) {
		this.estadoSerieTerminal = estadoSerieTerminal;
	}
	public String getAplicaCampañaA() {
		return aplicaCampañaA;
	}
	public void setAplicaCampañaA(String aplicaCampañaA) {
		this.aplicaCampañaA = aplicaCampañaA;
	}
	public String getCodigoCampaña() {
		return codigoCampaña;
	}
	public void setCodigoCampaña(String codigoCampaña) {
		this.codigoCampaña = codigoCampaña;
	}
	public String getCodigoCausaDescuento() {
		return codigoCausaDescuento;
	}
	public void setCodigoCausaDescuento(String codigoCausaDescuento) {
		this.codigoCausaDescuento = codigoCausaDescuento;
	}
	public String getCodigoCuotas() {
		return codigoCuotas;
	}
	public void setCodigoCuotas(String codigoCuotas) {
		this.codigoCuotas = codigoCuotas;
	}
	public String getIndicadorSexo() {
		return indicadorSexo;
	}
	public void setIndicadorSexo(String indicadorSexo) {
		this.indicadorSexo = indicadorSexo;
	}
	
	public WsUsuarioInDTO getUsuarioLinea() {
		return usuarioLinea;
	}
	public void setUsuarioLinea(WsUsuarioInDTO usuarioLinea) {
		this.usuarioLinea = usuarioLinea;
	}
	public String getCodigoGrupoTecnologico() {
		return codigoGrupoTecnologico;
	}
	public void setCodigoGrupoTecnologico(String codigoGrupoTecnologico) {
		this.codigoGrupoTecnologico = codigoGrupoTecnologico;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getNumeroSerieKit() {
		return numeroSerieKit;
	}
	public void setNumeroSerieKit(String numeroSerieKit) {
		this.numeroSerieKit = numeroSerieKit;
	}
	

		
}//fin DatosGeneralesVentaDTO
