package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioNumerosSMSDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioWebDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ProductoOfertadoDTO;


public class AltaLineaWebDTO implements Serializable  
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	//Datos Encabezado
	private String codOficina;	
	private String codTipoComisionista;	
	private String codDistribuidor;	
	private String codVendedor;	
	private String codTipoContrato;	
	private String codModalidadVenta;	
	private String codPeriodoContrato;	
	private String codTipoCliente;
	private String glsTipoCliente;	
	private String codCliente;
	private String codCalificacion;
	private String facturaTercero;
	private String codCrediticia;
	private double montoPreAutorizado;
	private String indOfiter;
	private String codCuotas;
	private String codTipoSolicitud;
	
	 /* Factura a nombre de terceros */
    private String facturaNombreTercero;   
	private String nombreClienteFactura; 
	private String apellido1ClienteFactura;
	private String apellido2ClienteFactura;
	private String tipoIdentClienteFactura;			
	private String numeroIdentClienteFactura;
	
	
	//Datos de la linea
	private String codGrpPrestacion;
	private String codTipoPrestacion;
	private String codNivel1;
	private String codNivel2;
	private String codNivel3;
	private int indRenovacion;
	
	//Home de Linea
	private String codRegion;
	private String codCelda;
	private String codProvincia;
	private String codCentral;
	private String codCiudad;	
	private String codTecnologia;
	
	//Datos serie simcard
	private String FlgSerieKit;
	private String numSerie;		
	
	//Datos serie terminal
	private String numEquipo;
	private String codArticuloSerieTerminal;
	private String codTipoTerminal;
	private String codProcedencia;	
	private String descArticuloEquipo;
	
	private int codUsoLinea;
	private String codActabo;
	private String codPlanTarif;
	private String codCargoBasico;	
	private String codCreditoConsumo;
	private String codLimiteConsumo;
	private double impLimiteConsumo;
	private String codPlanServicio;
	private String codGrupoCobroServ;
	private String codCausaDescuento;
	private String codCampanaVigente;
	private double valorRefPorMinuto;
	private String codMoneda;		
	private String numCelular;	
	private String codTipoIP;
	private String numIP;
	private String codAnchoBanda;
	private String observacion;	
	private String codTipoServicio;
	private String codIndemnizacion;
	
	private UsuarioWebDTO usuario;	
	private String nombreUsuarOra;
	
	//ServiciosSuplementarios
	private ListadoSSOutDTO[]listaServicios;
	
	//Contactos asociado a ss911
	private GaContactoAbonadoToDTO[]listaContactos;	
	
	//Datos del seguro
	private String codigoSeguro;
	private double importeSeguro = 0;
	private String vigenciaSeguro;
	
	private long numeroVenta;
	private long numeroTransaccionVenta;
	
	private long numFax;
	
	//Numeros sms asociados a la prestacion SMS Broadcast
	private FormularioNumerosSMSDTO[]listaNumerosSMS;
	
	private String tipoPrimariaCarrier;
	
	
	//Scoring
	private long numLineaScoring;
	private long numSolScoring;
	private String codEstadoEscoring;
	private int actualizadaScoringNormal=0;
	
	//Inicio P-CSR-11002 JLGN 20-04-2011
	private ProductoOfertadoDTO[] arrayPA;
	
	private long numAbonado;
	private long numMovimiento;
	private long [] arrayNumAbonado;
	private long [] arrayNumMovimiento;
	//Fin  P-CSR-11002 JLGN 20-04-2011
	
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	public int getActualizadaScoringNormal() {
		return actualizadaScoringNormal;
	}
	public void setActualizadaScoringNormal(int actualizadaScoringNormal) {
		this.actualizadaScoringNormal = actualizadaScoringNormal;
	}
	public String getCodEstadoEscoring() {
		return codEstadoEscoring;
	}
	public void setCodEstadoEscoring(String codEstadoEscoring) {
		this.codEstadoEscoring = codEstadoEscoring;
	}
	public long getNumSolScoring() {
		return numSolScoring;
	}
	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}
	public long getNumLineaScoring() {
		return numLineaScoring;
	}
	public void setNumLineaScoring(long numLineaScoring) {
		this.numLineaScoring = numLineaScoring;
	}
	public String getTipoPrimariaCarrier() {
		return tipoPrimariaCarrier;
	}
	public void setTipoPrimariaCarrier(String tipoPrimariaCarrier) {
		this.tipoPrimariaCarrier = tipoPrimariaCarrier;
	}
	public FormularioNumerosSMSDTO[] getListaNumerosSMS() {
		return listaNumerosSMS;
	}
	public void setListaNumerosSMS(FormularioNumerosSMSDTO[] listaNumerosSMS) {
		this.listaNumerosSMS = listaNumerosSMS;
	}
	public long getNumFax() {
		return numFax;
	}
	public void setNumFax(long numFax) {
		this.numFax = numFax;
	}
	public ListadoSSOutDTO[] getListaServicios() {
		return listaServicios;
	}
	public void setListaServicios(ListadoSSOutDTO[] listaServicios) {
		this.listaServicios = listaServicios;
	}
	public String getNombreUsuarOra() {
		return nombreUsuarOra;
	}
	public void setNombreUsuarOra(String nombreUsuarOra) {
		this.nombreUsuarOra = nombreUsuarOra;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodCrediticia() {
		return codCrediticia;
	}
	public void setCodCrediticia(String codCrediticia) {
		this.codCrediticia = codCrediticia;
	}
	public String getCodDistribuidor() {
		return codDistribuidor;
	}
	public void setCodDistribuidor(String codDistribuidor) {
		this.codDistribuidor = codDistribuidor;
	}	
	public String getCodModalidadVenta() {
		return codModalidadVenta;
	}
	public void setCodModalidadVenta(String codModalidadVenta) {
		this.codModalidadVenta = codModalidadVenta;
	}	
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}		
	public String getCodTipoCliente() {
		return codTipoCliente;
	}
	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}
	public String getCodTipoComisionista() {
		return codTipoComisionista;
	}
	public void setCodTipoComisionista(String codTipoComisionista) {
		this.codTipoComisionista = codTipoComisionista;
	}
	public String getCodTipoContrato() {
		return codTipoContrato;
	}
	public void setCodTipoContrato(String codTipoContrato) {
		this.codTipoContrato = codTipoContrato;
	}
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}	
	public String getFacturaTercero() {
		return facturaTercero;
	}
	public void setFacturaTercero(String facturaTercero) {
		this.facturaTercero = facturaTercero;
	}
	public String getGlsTipoCliente() {
		return glsTipoCliente;
	}
	public void setGlsTipoCliente(String glsTipoCliente) {
		this.glsTipoCliente = glsTipoCliente;
	}
	public double getMontoPreAutorizado() {
		return montoPreAutorizado;
	}
	public void setMontoPreAutorizado(double montoPreAutorizado) {
		this.montoPreAutorizado = montoPreAutorizado;
	}
	public String getCodAnchoBanda() {
		return codAnchoBanda;
	}
	public void setCodAnchoBanda(String codAnchoBanda) {
		this.codAnchoBanda = codAnchoBanda;
	}
	public String getCodCampanaVigente() {
		return codCampanaVigente;
	}
	public void setCodCampanaVigente(String codCampanaVigente) {
		this.codCampanaVigente = codCampanaVigente;
	}
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public String getCodCausaDescuento() {
		return codCausaDescuento;
	}
	public void setCodCausaDescuento(String codCausaDescuento) {
		this.codCausaDescuento = codCausaDescuento;
	}
	public String getCodCelda() {
		return codCelda;
	}
	public void setCodCelda(String codCelda) {
		this.codCelda = codCelda;
	}
	public String getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	public String getCodCreditoConsumo() {
		return codCreditoConsumo;
	}
	public void setCodCreditoConsumo(String codCreditoConsumo) {
		this.codCreditoConsumo = codCreditoConsumo;
	}
	public String getCodGrpPrestacion() {
		return codGrpPrestacion;
	}
	public void setCodGrpPrestacion(String codGrpPrestacion) {
		this.codGrpPrestacion = codGrpPrestacion;
	}
	public String getCodGrupoCobroServ() {
		return codGrupoCobroServ;
	}
	public void setCodGrupoCobroServ(String codGrupoCobroServ) {
		this.codGrupoCobroServ = codGrupoCobroServ;
	}
	public String getCodLimiteConsumo() {
		return codLimiteConsumo;
	}
	public void setCodLimiteConsumo(String codLimiteConsumo) {
		this.codLimiteConsumo = codLimiteConsumo;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getCodPlanServicio() {
		return codPlanServicio;
	}
	public void setCodPlanServicio(String codPlanServicio) {
		this.codPlanServicio = codPlanServicio;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodProcedencia() {
		return codProcedencia;
	}
	public void setCodProcedencia(String codProcedencia) {
		this.codProcedencia = codProcedencia;
	}
	public String getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	public String getCodTipoIP() {
		return codTipoIP;
	}
	public void setCodTipoIP(String codTipoIP) {
		this.codTipoIP = codTipoIP;
	}
	public String getCodTipoPrestacion() {
		return codTipoPrestacion;
	}
	public void setCodTipoPrestacion(String codTipoPrestacion) {
		this.codTipoPrestacion = codTipoPrestacion;
	}	
	public String getCodTipoTerminal() {
		return codTipoTerminal;
	}
	public void setCodTipoTerminal(String codTipoTerminal) {
		this.codTipoTerminal = codTipoTerminal;
	}
	
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumEquipo() {
		return numEquipo;
	}
	public void setNumEquipo(String numEquipo) {
		this.numEquipo = numEquipo;
	}	
	public String getNumIP() {
		return numIP;
	}
	public void setNumIP(String numIP) {
		this.numIP = numIP;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getObservacion() {
		return observacion;
	}
	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}
	public String getVigenciaSeguro() {
		return vigenciaSeguro;
	}
	public void setVigenciaSeguro(String vigenciaSeguro) {
		this.vigenciaSeguro = vigenciaSeguro;
	}
	public String getCodTipoServicio() {
		return codTipoServicio;
	}
	public void setCodTipoServicio(String codTipoServicio) {
		this.codTipoServicio = codTipoServicio;
	}	
	public String getIndOfiter() {
		return indOfiter;
	}
	public void setIndOfiter(String indOfiter) {
		this.indOfiter = indOfiter;
	}	
	public String getCodArticuloSerieTerminal() {
		return codArticuloSerieTerminal;
	}
	public void setCodArticuloSerieTerminal(String codArticuloSerieTerminal) {
		this.codArticuloSerieTerminal = codArticuloSerieTerminal;
	}
	public int getCodUsoLinea() {
		return codUsoLinea;
	}
	public void setCodUsoLinea(int codUsoLinea) {
		this.codUsoLinea = codUsoLinea;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public UsuarioWebDTO getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioWebDTO usuario) {
		this.usuario = usuario;
	}
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	public String getCodIndemnizacion() {
		return codIndemnizacion;
	}
	public void setCodIndemnizacion(String codIndemnizacion) {
		this.codIndemnizacion = codIndemnizacion;
	}
	public String getCodigoSeguro() {
		return codigoSeguro;
	}
	public void setCodigoSeguro(String codigoSeguro) {
		this.codigoSeguro = codigoSeguro;
	}
	public double getImporteSeguro() {
		return importeSeguro;
	}
	public void setImporteSeguro(double importeSeguro) {
		this.importeSeguro = importeSeguro;
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
	public double getValorRefPorMinuto() {
		return valorRefPorMinuto;
	}
	public void setValorRefPorMinuto(double valorRefPorMinuto) {
		this.valorRefPorMinuto = valorRefPorMinuto;
	}
	public String getApellido1ClienteFactura() {
		return apellido1ClienteFactura;
	}
	public void setApellido1ClienteFactura(String apellido1ClienteFactura) {
		this.apellido1ClienteFactura = apellido1ClienteFactura;
	}
	public String getApellido2ClienteFactura() {
		return apellido2ClienteFactura;
	}
	public void setApellido2ClienteFactura(String apellido2ClienteFactura) {
		this.apellido2ClienteFactura = apellido2ClienteFactura;
	}
	public String getFacturaNombreTercero() {
		return facturaNombreTercero;
	}
	public void setFacturaNombreTercero(String facturaNombreTercero) {
		this.facturaNombreTercero = facturaNombreTercero;
	}
	public String getNombreClienteFactura() {
		return nombreClienteFactura;
	}
	public void setNombreClienteFactura(String nombreClienteFactura) {
		this.nombreClienteFactura = nombreClienteFactura;
	}
	public String getNumeroIdentClienteFactura() {
		return numeroIdentClienteFactura;
	}
	public void setNumeroIdentClienteFactura(String numeroIdentClienteFactura) {
		this.numeroIdentClienteFactura = numeroIdentClienteFactura;
	}
	public String getTipoIdentClienteFactura() {
		return tipoIdentClienteFactura;
	}
	public void setTipoIdentClienteFactura(String tipoIdentClienteFactura) {
		this.tipoIdentClienteFactura = tipoIdentClienteFactura;
	}
	public String getCodCalificacion() {
		return codCalificacion;
	}
	public void setCodCalificacion(String codCalificacion) {
		this.codCalificacion = codCalificacion;
	}
	public String getDescArticuloEquipo() {
		return descArticuloEquipo;
	}
	public void setDescArticuloEquipo(String descArticuloEquipo) {
		this.descArticuloEquipo = descArticuloEquipo;
	}
	public String getFlgSerieKit() {
		return FlgSerieKit;
	}
	public void setFlgSerieKit(String flgSerieKit) {
		FlgSerieKit = flgSerieKit;
	}
	public String getCodCuotas() {
		return codCuotas;
	}
	public void setCodCuotas(String codCuotas) {
		this.codCuotas = codCuotas;
	}
	public String getCodPeriodoContrato() {
		return codPeriodoContrato;
	}
	public void setCodPeriodoContrato(String codPeriodoContrato) {
		this.codPeriodoContrato = codPeriodoContrato;
	}
	public String getCodTipoSolicitud() {
		return codTipoSolicitud;
	}
	public void setCodTipoSolicitud(String codTipoSolicitud) {
		this.codTipoSolicitud = codTipoSolicitud;
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
	public int getIndRenovacion() {
		return indRenovacion;
	}
	public void setIndRenovacion(int indRenovacion) {
		this.indRenovacion = indRenovacion;
	}
	public GaContactoAbonadoToDTO[] getListaContactos() {
		return listaContactos;
	}
	public void setListaContactos(GaContactoAbonadoToDTO[] listaContactos) {
		this.listaContactos = listaContactos;
	}
	
	//Inicio P-CSR-11002 JLGN 20-04-2011
	public ProductoOfertadoDTO[] getArrayPA() {
		return arrayPA;
	}
	public void setArrayPA(ProductoOfertadoDTO[] arrayPA) {
		this.arrayPA = arrayPA;
	}
	//Fin P-CSR-11002 JLGN 20-04-2011
	public long[] getArrayNumAbonado() {
		return arrayNumAbonado;
	}
	public void setArrayNumAbonado(long[] arrayNumAbonado) {
		this.arrayNumAbonado = arrayNumAbonado;
	}
	public long[] getArrayNumMovimiento() {
		return arrayNumMovimiento;
	}
	public void setArrayNumMovimiento(long[] arrayNumMovimiento) {
		this.arrayNumMovimiento = arrayNumMovimiento;
	}
}
