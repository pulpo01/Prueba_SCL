package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;



public class CabeceraArchivoDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codigoOperadora;
	
	private long codigoVendedorRaiz;
	private long codigoVenDealer;
	//private DireccionNegocioDTO direccionVendedor;
	private int indicadorTipoVenta;
	private String codigoCliente;
	private String codigoTipoIdentificacion;
	private String numeroIdentificacion;
	private String nombreCliente;
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
    //private DireccionNegocioDTO direccionCliente;
    private long codigoEmpresa;
	private String codigoDealer;
	private String codigoVendedor;
	private String oficinaVendedor;
	private String identificadorEmpresa;
	private String nombreUsuario;
	private String nombreArchivo;
	//private ParametrosSeleccionadosDTO parametros;
	private String numeroSeries;
	private String parametroCalCliente;
	private String parametroCodigoAbc;
	private String parametroCodigo123;
	private String parametroCodigoEstadoCobros;
	private String parametroCodigoSimcardGSM;
	private String parametroCodigoTerminalGSM;
	private String planComercialCliente;
	private String tipoPlanPostpago;
	private String tipoPlanHibrido;
	/*-- Documento---*/
	private String codigoDocumento;
	private String categoriaTributaria;
	private String tipoFoliacion;
	private float totalImpuestoVenta;
	private float totalCargosVenta;
	private float totalDescuentosVenta;
	private boolean facturaCiclo;
	private String codigoFormaPago;
	private String numeroProcesoFacturacion;
	private boolean prebillingOK;
	private long numeroVenta;
	private long numeroTransaccionVenta;
	private float montoGarantia;
	private String tipoVentaOficinaTerreno;
	private float totalPresupuestoVenta;
	//--Numero de decimales utilizados en la aplicacion
	private int decimalesFormulario;
	private int decimalesBD;
	private int decimalesPorcentajeDescuento;
	
	//TODO: rlozano tipoplanTarifario : I--> Individual , E--> Empresa
	private String tipoPlanTarifario;
	
	//TODO:rlozano Modalidad de Venta
	private String codModalidadVenta;
	
	
	public String getCodModalidadVenta() {
		return codModalidadVenta;
	}
	public void setCodModalidadVenta(String codModalidadVenta) {
		this.codModalidadVenta = codModalidadVenta;
	}
	public String getTipoPlanTarifario() {
		return tipoPlanTarifario;
	}
	public void setTipoPlanTarifario(String tipoPlanTarifario) {
		this.tipoPlanTarifario = tipoPlanTarifario;
	}
	public int getDecimalesBD() {
		return decimalesBD;
	}
	public void setDecimalesBD(int decimalesBD) {
		this.decimalesBD = decimalesBD;
	}
	public int getDecimalesFormulario() {
		return decimalesFormulario;
	}
	public void setDecimalesFormulario(int decimalesFormulario) {
		this.decimalesFormulario = decimalesFormulario;
	}
	public int getDecimalesPorcentajeDescuento() {
		return decimalesPorcentajeDescuento;
	}
	public void setDecimalesPorcentajeDescuento(int decimalesPorcentajeDescuento) {
		this.decimalesPorcentajeDescuento = decimalesPorcentajeDescuento;
	}
	public float getMontoGarantia() {
		return montoGarantia;
	}
	public void setMontoGarantia(float montoGarantia) {
		this.montoGarantia = montoGarantia;
	}
	public long getNumeroTransaccionVenta() {
		return numeroTransaccionVenta;
	}
	public void setNumeroTransaccionVenta(long numeroTransaccionVenta) {
		this.numeroTransaccionVenta = numeroTransaccionVenta;
	}
	public long getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getNumeroSeries() {
		return numeroSeries;
	}
	public void setNumeroSeries(String numeroSeries) {
		this.numeroSeries = numeroSeries;
	}
	/*public ParametrosSeleccionadosDTO getParametros() {
		return parametros;
	}
	public void setParametros(ParametrosSeleccionadosDTO parametros) {
		this.parametros = parametros;
	}*/
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public String getIdentificadorEmpresa() {
		return identificadorEmpresa;
	}
	public void setIdentificadorEmpresa(String identificadorEmpresa) {
		this.identificadorEmpresa = identificadorEmpresa;
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
	public String getNombreArchivo() {
		return nombreArchivo;
	}
	public void setNombreArchivo(String nombreArchivo) {
		this.nombreArchivo = nombreArchivo;
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
	public String getParametroCalCliente() {
		return parametroCalCliente;
	}
	public void setParametroCalCliente(String parametroCalCliente) {
		this.parametroCalCliente = parametroCalCliente;
	}
	public String getParametroCodigo123() {
		return parametroCodigo123;
	}
	public void setParametroCodigo123(String parametroCodigo123) {
		this.parametroCodigo123 = parametroCodigo123;
	}
	public String getParametroCodigoAbc() {
		return parametroCodigoAbc;
	}
	public void setParametroCodigoAbc(String parametroCodigoAbc) {
		this.parametroCodigoAbc = parametroCodigoAbc;
	}
	public String getParametroCodigoEstadoCobros() {
		return parametroCodigoEstadoCobros;
	}
	public void setParametroCodigoEstadoCobros(String parametroCodigoEstadoCobros) {
		this.parametroCodigoEstadoCobros = parametroCodigoEstadoCobros;
	}
	
	public String getParametroCodigoSimcardGSM() {
		return parametroCodigoSimcardGSM;
	}
	public void setParametroCodigoSimcardGSM(String parametroCodigoSimcardGSM) {
		this.parametroCodigoSimcardGSM = parametroCodigoSimcardGSM;
	}
	public String getParametroCodigoTerminalGSM() {
		return parametroCodigoTerminalGSM;
	}
	public void setParametroCodigoTerminalGSM(String parametroCodigoTerminalGSM) {
		this.parametroCodigoTerminalGSM = parametroCodigoTerminalGSM;
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
	/*public DireccionNegocioDTO getDireccionCliente() {
		return direccionCliente;
	}
	public void setDireccionCliente(DireccionNegocioDTO direccionCliente) {
		this.direccionCliente = direccionCliente;
	}*/
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
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}
	/*public DireccionNegocioDTO getDireccionVendedor() {
		return direccionVendedor;
	}
	public void setDireccionVendedor(DireccionNegocioDTO direccionVendedor) {
		this.direccionVendedor = direccionVendedor;
	}*/
	public long getCodigoEmpresa() {
		return codigoEmpresa;
	}
	public void setCodigoEmpresa(long codigoEmpresa) {
		this.codigoEmpresa = codigoEmpresa;
	}
	public int getIndicadorTipoVenta() {
		return indicadorTipoVenta;
	}
	public void setIndicadorTipoVenta(int indicadorTipoVenta) {
		this.indicadorTipoVenta = indicadorTipoVenta;
	}
	public String getPlanComercialCliente() {
		return planComercialCliente;
	}
	public void setPlanComercialCliente(String planComercialCliente) {
		this.planComercialCliente = planComercialCliente;
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
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}
	public String getCodigoDocumento() {
		return codigoDocumento;
	}
	public void setCodigoDocumento(String codigoDocumento) {
		this.codigoDocumento = codigoDocumento;
	}
	public String getTipoFoliacion() {
		return tipoFoliacion;
	}
	public void setTipoFoliacion(String tipoFoliacion) {
		this.tipoFoliacion = tipoFoliacion;
	}
	public String getOficinaVendedor() {
		return oficinaVendedor;
	}
	public void setOficinaVendedor(String oficinaVendedor) {
		this.oficinaVendedor = oficinaVendedor;
	}
	public float getTotalImpuestoVenta() {
		return totalImpuestoVenta;
	}
	public void setTotalImpuestoVenta(float totalImpuestoVenta) {
		this.totalImpuestoVenta = totalImpuestoVenta;
	}
	public boolean isFacturaCiclo() {
		return facturaCiclo;
	}
	public void setFacturaCiclo(boolean facturaCiclo) {
		this.facturaCiclo = facturaCiclo;
	}
	public String getCodigoFormaPago() {
		return codigoFormaPago;
	}
	public void setCodigoFormaPago(String codigoFormaPago) {
		this.codigoFormaPago = codigoFormaPago;
	}
	public String getCodigoOperadora() {
		return codigoOperadora;
	}
	public void setCodigoOperadora(String codigoOperadora) {
		this.codigoOperadora = codigoOperadora;
	}
	public String getNumeroProcesoFacturacion() {
		return numeroProcesoFacturacion;
	}
	public void setNumeroProcesoFacturacion(String numeroProcesoFacturacion) {
		this.numeroProcesoFacturacion = numeroProcesoFacturacion;
	}
	public boolean isPrebillingOK() {
		return prebillingOK;
	}
	public void setPrebillingOK(boolean prebillingOK) {
		this.prebillingOK = prebillingOK;
	}
	public float getTotalCargosVenta() {
		return totalCargosVenta;
	}
	public void setTotalCargosVenta(float totalCargosVenta) {
		this.totalCargosVenta = totalCargosVenta;
	}
	public float getTotalDescuentosVenta() {
		return totalDescuentosVenta;
	}
	public void setTotalDescuentosVenta(float totalDescuentosVenta) {
		this.totalDescuentosVenta = totalDescuentosVenta;
	}
	public String getTipoVentaOficinaTerreno() {
		return tipoVentaOficinaTerreno;
	}
	public void setTipoVentaOficinaTerreno(String tipoVentaOficinaTerreno) {
		this.tipoVentaOficinaTerreno = tipoVentaOficinaTerreno;
	}
	public float getTotalPresupuestoVenta() {
		return totalPresupuestoVenta;
	}
	public void setTotalPresupuestoVenta(float totalPresupuestoVenta) {
		this.totalPresupuestoVenta = totalPresupuestoVenta;
	}

}
