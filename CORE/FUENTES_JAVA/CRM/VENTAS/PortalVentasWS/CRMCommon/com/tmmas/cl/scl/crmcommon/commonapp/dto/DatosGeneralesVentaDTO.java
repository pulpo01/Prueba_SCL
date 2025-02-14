package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class DatosGeneralesVentaDTO implements Serializable{
	private static final long serialVersionUID = 1L;

	private String fechaActual;
	private String codigoCliente;
	private String numeroVenta;
	private String numeroSerieSimcard;
	private String numeroSerieTerminal;
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
	//-- CAMPAÑAS
	private String codigoCampana;
	private String aplicaCampanaA;
    
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
	
	private Long num_abonado;
	
	//P-CSR-11002 JLGN 24-04-2011
	private long numMovimiento;
	
	private Long indTelefono;
	private Long codCuota;
	
	//-Codigo articulo terminal (para COLOMBIA)
	private String codigoArticuloTerminal;
	private String numAnexo;
	
	private Long numMesesContrato;	
	private String codigoEstrato;
	
	private Long valor_factura;
	
	
	//-- SERVICIOS SUPLEMENTARIOS ADICIONALES
	private String servSuplAdicionales;
	  
	//Release II
	private int cod_ciclo;
	  
	/*Datos nuevos GUATEMALA - EL SALVADOR */
	private String codGrupoPrestacion;
	private String codTipPrestacion;
	private String codNivel1;
	private String codNivel2;
	private String codNivel3;
	private double montoPreautorizado;
	private String codMoneda;
	private int codUso;
	private String codigoCalificacion;
	private String codigoTecnologia;
	private String codigoCausaDescuento;
	private String codPlanServ;
	private String codLimiteConsumo;
	private double valorRefXMinuto;
	private String obsInstancia;
	private String codTipoCliente;
	private String desArticuloTerminal;
	private String FlgSerieKit;
	private double impLimiteConsumo;
	
	
	//Datos necesarios para el seguro
	private double importeEquipo;
	private String codigoSeguro;
	private String fechaVigenciaSeguro;
	
	//indicador renovacion linea
	private int indRenovacion;
	
	//Numero fax asociado a SS FAX
	private long numFax;
	
	private String tipoPrimariaCarrier;
	
	public String getTipoPrimariaCarrier() {
		return tipoPrimariaCarrier;
	}
	public void setTipoPrimariaCarrier(String tipoPrimariaCarrier) {
		this.tipoPrimariaCarrier = tipoPrimariaCarrier;
	}
	public int getIndRenovacion() {
		return indRenovacion;
	}
	public void setIndRenovacion(int indRenovacion) {
		this.indRenovacion = indRenovacion;
	}
	public String getFechaVigenciaSeguro() {
		return fechaVigenciaSeguro;
	}
	public void setFechaVigenciaSeguro(String fechaVigenciaSeguro) {
		this.fechaVigenciaSeguro = fechaVigenciaSeguro;
	}
	public String getCodigoSeguro() {
		return codigoSeguro;
	}
	public void setCodigoSeguro(String codigoSeguro) {
		this.codigoSeguro = codigoSeguro;
	}
	public double getImporteEquipo() {
		return importeEquipo;
	}
	public void setImporteEquipo(double importeEquipo) {
		this.importeEquipo = importeEquipo;
	}
	public String getCodLimiteConsumo() {
		return codLimiteConsumo;
	}
	public void setCodLimiteConsumo(String codLimiteConsumo) {
		this.codLimiteConsumo = codLimiteConsumo;
	}
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getCodigoCausaDescuento() {
		return codigoCausaDescuento;
	}
	public void setCodigoCausaDescuento(String codigoCausaDescuento) {
		this.codigoCausaDescuento = codigoCausaDescuento;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getCodigoCalificacion() {
		return codigoCalificacion;
	}
	public void setCodigoCalificacion(String codigoCalificacion) {
		this.codigoCalificacion = codigoCalificacion;
	}
	public Long getNumMesesContrato() {
		return numMesesContrato;
	}
	public void setNumMesesContrato(Long numMesesContrato) {
		this.numMesesContrato = numMesesContrato;
	}
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
	public String getAplicaCampanaA() {
		return aplicaCampanaA;
	}
	public void setAplicaCampanaA(String aplicaCampanaA) {
		this.aplicaCampanaA = aplicaCampanaA;
	}
	public String getCodigoCampana() {
		return codigoCampana;
	}
	public void setCodigoCampana(String codigoCampana) {
		this.codigoCampana = codigoCampana;
	}
	public String getCodigoArticuloTerminal() {
		return codigoArticuloTerminal;
	}
	public void setCodigoArticuloTerminal(String codigoArticuloTerminal) {
		this.codigoArticuloTerminal = codigoArticuloTerminal;
	}
	public Long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(Long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public Long getIndTelefono() {
		return indTelefono;
	}
	public void setIndTelefono(Long indTelefono) {
		this.indTelefono = indTelefono;
	}
	public Long getCodCuota() {
		return codCuota;
	}
	public void setCodCuota(Long codCuota) {
		this.codCuota = codCuota;
	}
	public String getNumAnexo() {
		return numAnexo;
	}
	public void setNumAnexo(String numAnexo) {
		this.numAnexo = numAnexo;
	}
	public String getCodigoEstrato() {
		return codigoEstrato;
	}
	public void setCodigoEstrato(String codigoEstrato) {
		this.codigoEstrato = codigoEstrato;
	}
	public Long getValor_factura() {
		return valor_factura;
	}
	public void setValor_factura(Long valor_factura) {
		this.valor_factura = valor_factura;
	}
	public String getServSuplAdicionales() {
		return servSuplAdicionales;
	}
	public void setServSuplAdicionales(String servSuplAdicionales) {
		this.servSuplAdicionales = servSuplAdicionales;
	}
	public String getCodGrupoPrestacion() {
		return codGrupoPrestacion;
	}
	public void setCodGrupoPrestacion(String codGrupoPrestacion) {
		this.codGrupoPrestacion = codGrupoPrestacion;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public double getMontoPreautorizado() {
		return montoPreautorizado;
	}
	public void setMontoPreautorizado(double montoPreautorizado) {
		this.montoPreautorizado = montoPreautorizado;
	}
	public int getCod_ciclo() {
		return cod_ciclo;
	}
	public void setCod_ciclo(int cod_ciclo) {
		this.cod_ciclo = cod_ciclo;
	}
	public int getCodUso() {
		return codUso;
	}
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}
	public String getCodTipPrestacion() {
		return codTipPrestacion;
	}
	public void setCodTipPrestacion(String codTipPrestacion) {
		this.codTipPrestacion = codTipPrestacion;
	}
	public double getValorRefXMinuto() {
		return valorRefXMinuto;
	}
	public void setValorRefXMinuto(double valorRefXMinuto) {
		this.valorRefXMinuto = valorRefXMinuto;
	}
	public String getObsInstancia() {
		return obsInstancia;
	}
	public void setObsInstancia(String obsInstancia) {
		this.obsInstancia = obsInstancia;
	}
	public String getCodTipoCliente() {
		return codTipoCliente;
	}
	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}
	public String getDesArticuloTerminal() {
		return desArticuloTerminal;
	}
	public void setDesArticuloTerminal(String desArticuloTerminal) {
		this.desArticuloTerminal = desArticuloTerminal;
	}
	public String getFlgSerieKit() {
		return FlgSerieKit;
	}
	public void setFlgSerieKit(String flgSerieKit) {
		FlgSerieKit = flgSerieKit;
	}
	public double getImpLimiteConsumo() {
		return impLimiteConsumo;
	}
	public void setImpLimiteConsumo(double impLimiteConsumo) {
		this.impLimiteConsumo = impLimiteConsumo;
	}
	public String getCodNivel1() {
		return codNivel1;
	}
	public void setCodNivel1(String codNivel1) {
		this.codNivel1 = codNivel1;
	}
	public String getCodNivel2() {
		return codNivel2;
	}
	public void setCodNivel2(String codNivel2) {
		this.codNivel2 = codNivel2;
	}
	public String getCodNivel3() {
		return codNivel3;
	}
	public void setCodNivel3(String codNivel3) {
		this.codNivel3 = codNivel3;
	}
	public long getNumFax() {
		return numFax;
	}
	public void setNumFax(long numFax) {
		this.numFax = numFax;
	}
	public long getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
    
//FIN MERGE		
}//fin DatosGeneralesVentaDTO
