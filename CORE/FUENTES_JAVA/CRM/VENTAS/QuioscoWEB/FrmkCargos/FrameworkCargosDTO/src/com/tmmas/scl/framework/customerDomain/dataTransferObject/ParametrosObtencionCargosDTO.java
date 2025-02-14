package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Date;



public class ParametrosObtencionCargosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String codigoClienteOrigen;
	private String codigoClienteDestino;
	private String codigoVendedor;
	private int numeroMesesContrato;
	private int indicadorTipoVenta;
	private String numeroVenta;
	private String numeroCuotas;
	private String tipoPlanHibrido;
	private String tipoPlanPostPago;
	private String codigoConcepto;
	private String tipoContrato;
	private int indComodato;
	private String codigoModalidadVenta;
	private String codCausaCambioPlan;
	private String tipoPantalla;
	private ParametrosDescuentoDTO  parametrosDescuentoDTO;
	private String codActabo;
	private String codPlanServ;
	private String codPenalizacion;
	private String codCategoria;
	private String codPlanComercial;
	private String fechaFinContrato;
	private String estdDevlCargador;
	private String indCausa;
	private String codCargoBasico;
	private String codiTipServicio;
	private String tipoProducto;
	private String tipoSegOrigen;
	private String tipoSegDestino;
	private String codSegOrigen;
	private String codSegDestino;
	private String codigoPlanTarifOrigen;
	private String codigoPlanTarifDestino;
	private String[] abonados;
	private String codigoTecnologia;
	private String ordenServicio;
	
	
	private String gedCodigoTipoCargoSegm;
	private String gedCodigoDescTipoCargSeg;
	private String tipoPantallaPrevio;
	private Date FechaVigenciaAbonadoCero;
	private String codArticulo;
	private String tipoStock;
	private String codUso;
	private String estadoSimcard;
	private String indCiclo;
	private String codigoServicio;
	private String codServSS;
	private String numImei;
	private String numSerieTerminal;
	private String codigoCausalDescuento;
	private String numSerieSimcard;
	// INI INC-79469; COL; 11-03-2009
	private String operacion; 
    private String codigoCausaCambio;
    private String numAbonado;
    private long codCliente;
	private String codTipoPlan;
	private String nombreUsuario;
	private boolean aplicaPrepago;
	
	public boolean isAplicaPrepago() {
		return aplicaPrepago;
	}

	public void setAplicaPrepago(boolean aplicaPrepago) {
		this.aplicaPrepago = aplicaPrepago;
	}

	public String getCodigoCausaCambio() {
		return codigoCausaCambio;
	}

	public void setCodigoCausaCambio(String codigoCausaCambio) {
		this.codigoCausaCambio = codigoCausaCambio;
	}


	public String getOperacion() {
		return operacion;
	}

	public void setOperacion(String operacion) {
		this.operacion = operacion;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public String getCodTipoPlan() {
		return codTipoPlan;
	}

	public void setCodTipoPlan(String codTipoPlan) {
		this.codTipoPlan = codTipoPlan;
	}

	public String getNombreUsuario() {
		return nombreUsuario;
	}

	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}

	// FIN INC-79469; COL; 11-03-2009

	public String getNumSerieTerminal() {
		return numSerieTerminal;
	}
	public String getCodigoCausalDescuento() {
		return codigoCausalDescuento;
	}
	public void setCodigoCausalDescuento(String codigoCausalDescuento) {
		this.codigoCausalDescuento = codigoCausalDescuento;
	}
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public void setNumSerieTerminal(String numSerieTerminal) {
		this.numSerieTerminal = numSerieTerminal;
	}	
	public String getCodServSS() {
		return codServSS;
	}
	public void setCodServSS(String codServSS) {
		this.codServSS = codServSS;
	}
	public String getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getIndCiclo() {
		return indCiclo;
	}
	public void setIndCiclo(String indCiclo) {
		this.indCiclo = indCiclo;
	}
	public String getTipoPantallaPrevio() {
		return tipoPantallaPrevio;
	}
	public void setTipoPantallaPrevio(String tipoPantallaPrevio) {
		this.tipoPantallaPrevio = tipoPantallaPrevio;
	}
	public String getGedCodigoDescTipoCargSeg() {
		return gedCodigoDescTipoCargSeg;
	}
	public void setGedCodigoDescTipoCargSeg(String gedCodigoDescTipoCargSeg) {
		this.gedCodigoDescTipoCargSeg = gedCodigoDescTipoCargSeg;
	}
	public String getGedCodigoTipoCargoSegm() {
		return gedCodigoTipoCargoSegm;
	}
	public void setGedCodigoTipoCargoSegm(String gedCodigoTipoCargoSegm) {
		this.gedCodigoTipoCargoSegm = gedCodigoTipoCargoSegm;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getCodigoPlanTarifDestino() {
		return codigoPlanTarifDestino;
	}
	public void setCodigoPlanTarifDestino(String codigoPlanTarifDestino) {
		this.codigoPlanTarifDestino = codigoPlanTarifDestino;
	}
	public String getCodigoPlanTarifOrigen() {
		return codigoPlanTarifOrigen;
	}
	public void setCodigoPlanTarifOrigen(String codigoPlanTarifOrigen) {
		this.codigoPlanTarifOrigen = codigoPlanTarifOrigen;
	}
	public String getCodSegDestino() {
		return codSegDestino;
	}
	public void setCodSegDestino(String codSegDestino) {
		this.codSegDestino = codSegDestino;
	}
	public String getCodSegOrigen() {
		return codSegOrigen;
	}
	public void setCodSegOrigen(String codSegOrigen) {
		this.codSegOrigen = codSegOrigen;
	}
	public String getTipoSegDestino() {
		return tipoSegDestino;
	}
	public void setTipoSegDestino(String tipoSegDestino) {
		this.tipoSegDestino = tipoSegDestino;
	}
	public String getTipoSegOrigen() {
		return tipoSegOrigen;
	}
	public void setTipoSegOrigen(String tipoSegOrigen) {
		this.tipoSegOrigen = tipoSegOrigen;
	}
	public String getTipoProducto() {
		return tipoProducto;
	}
	public void setTipoProducto(String tipoProducto) {
		this.tipoProducto = tipoProducto;
	}
	public String getCodiTipServicio() {
		return codiTipServicio;
	}
	public void setCodiTipServicio(String codiTipServicio) {
		this.codiTipServicio = codiTipServicio;
	}
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	
	public String getIndCausa() {
		return indCausa;
	}
	public void setIndCausa(String indCausa) {
		this.indCausa = indCausa;
	}
	public String getFechaFinContrato() {
		return fechaFinContrato;
	}
	public void setFechaFinContrato(String fechaFinContrato) {
		this.fechaFinContrato = fechaFinContrato;
	}
	public String getCodPlanComercial() {
		return codPlanComercial;
	}
	public void setCodPlanComercial(String codPlanComercial) {
		this.codPlanComercial = codPlanComercial;
	}
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	public ParametrosDescuentoDTO getParametrosDescuentoDTO() {
		return parametrosDescuentoDTO;
	}
	public void setParametrosDescuentoDTO(
			ParametrosDescuentoDTO parametrosDescuentoDTO) {
		this.parametrosDescuentoDTO = parametrosDescuentoDTO;
	}
	public String getTipoPantalla() {
		return tipoPantalla;
	}
	public void setTipoPantalla(String tipoPantalla) {
		this.tipoPantalla = tipoPantalla;
	}
	public String getCodCausaCambioPlan() {
		return codCausaCambioPlan;
	}
	public void setCodCausaCambioPlan(String codCausaCambioPlan) {
		this.codCausaCambioPlan = codCausaCambioPlan;
	}
	
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(String codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public int getIndComodato() {
		return indComodato;
	}
	public void setIndComodato(int indComodato) {
		this.indComodato = indComodato;
	}
	public int getIndicadorTipoVenta() {
		return indicadorTipoVenta;
	}
	public void setIndicadorTipoVenta(int indicadorTipoVenta) {
		this.indicadorTipoVenta = indicadorTipoVenta;
	}
	public String getNumeroCuotas() {
		return numeroCuotas;
	}
	public void setNumeroCuotas(String numeroCuotas) {
		this.numeroCuotas = numeroCuotas;
	}
	public int getNumeroMesesContrato() {
		return numeroMesesContrato;
	}
	public void setNumeroMesesContrato(int numeroMesesContrato) {
		this.numeroMesesContrato = numeroMesesContrato;
	}
	public String getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getTipoContrato() {
		return tipoContrato;
	}
	public void setTipoContrato(String tipoContrato) {
		this.tipoContrato = tipoContrato;
	}
	public String getTipoPlanHibrido() {
		return tipoPlanHibrido;
	}
	public void setTipoPlanHibrido(String tipoPlanHibrido) {
		this.tipoPlanHibrido = tipoPlanHibrido;
	}
	public String getTipoPlanPostPago() {
		return tipoPlanPostPago;
	}
	public void setTipoPlanPostPago(String tipoPlanPostPago) {
		this.tipoPlanPostPago = tipoPlanPostPago;
	}
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
	public String getCodPenalizacion() {
		return codPenalizacion;
	}
	public void setCodPenalizacion(String codPenalizacion) {
		this.codPenalizacion = codPenalizacion;
	}
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getEstdDevlCargador() {
		return estdDevlCargador;
	}
	public void setEstdDevlCargador(String estdDevlCargador) {
		this.estdDevlCargador = estdDevlCargador;
	}
	public String[] getAbonados() {
		return abonados;
	}
	public void setAbonados(String[] abonados) {
		this.abonados = abonados;
	}
	public String getCodigoClienteDestino() {
		return codigoClienteDestino;
	}
	public void setCodigoClienteDestino(String codigoClienteDestino) {
		this.codigoClienteDestino = codigoClienteDestino;
	}
	public String getCodigoClienteOrigen() {
		return codigoClienteOrigen;
	}
	public void setCodigoClienteOrigen(String codigoClienteOrigen) {
		this.codigoClienteOrigen = codigoClienteOrigen;
	}
	public String getOrdenServicio() {
		return ordenServicio;
	}
	public void setOrdenServicio(String ordenServicio) {
		this.ordenServicio = ordenServicio;
	}
	public Date getFechaVigenciaAbonadoCero() {
		return FechaVigenciaAbonadoCero;
	}
	public void setFechaVigenciaAbonadoCero(Date fechaVigenciaAbonadoCero) {
		FechaVigenciaAbonadoCero = fechaVigenciaAbonadoCero;
	}
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getCodUso() {
		return codUso;
	}
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	public String getEstadoSimcard() {
		return estadoSimcard;
	}
	public void setEstadoSimcard(String estadoSimcard) {
		this.estadoSimcard = estadoSimcard;
	}
	public String getTipoStock() {
		return tipoStock;
	}
	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}
	public String getNumSerieSimcard() {
		return numSerieSimcard;
	}
	public void setNumSerieSimcard(String numSerieSimcard) {
		this.numSerieSimcard = numSerieSimcard;
	}
	
}
