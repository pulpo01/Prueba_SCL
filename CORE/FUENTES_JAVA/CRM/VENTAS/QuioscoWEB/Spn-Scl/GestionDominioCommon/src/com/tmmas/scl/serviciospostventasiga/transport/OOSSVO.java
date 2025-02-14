package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;
import java.sql.Timestamp;

public class OOSSVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	private String codActuacion;
	private String codOS;
	private String grupoOS;
	private Long numOS;
	private Integer producto;
	private Timestamp fechaOS;
	/*--Atributos utilizados en el esquema de restriccion--*/
	private Long secuencia;
	private String codModulo;
	private Integer codProducto;
	private String codActAbo;
	private String evento;
	private String programa;
	private String programaDetalle;
	private String proceso;
	private String codActAboDetalle;
	private long numAbonado;
	private long codCliente;
	private String codModGener;
	private Long numVenta;
	private String nomUsuarioSCL;
	private String desSS;
	private String codPlanTarif;
	private Integer codUso;
	private String codCuentaOrig;
	private String codCuentaDes;
	private Long codClienteDes;
	private String codTipPlanTarif;
	private String codTipPlanTarid;
	private String codCiclo;
	private String codFechaSistema;
	private String restriccionAux;
	private String codModuloDetalle;
	private String numId;
	private Integer codCentral;
	private String codError;
	private String desError;
	private String codTecnologia;
	private String CodActCen;
	private Long codInter;
	private String comentario;
	private String codTipModi;
	private String grupo;
	private String nomExe;
	private String carta;
	private int indProrroga;
	private String menu;
	private String tipExtincion;
	private int tipProcesa;
	private String codAplica;
	private int indCron;
	private int indArchivo;
	private int indAlgunos;
	private Timestamp fecMigracion;
	private String prg;
	private String indCServicio;
	private String tipoSuspension;
	private String codTipContrato;
	//private TiposContratosVO[] arrayTiposContratosVOs;
	//MAPAN-69765: Se agregan nuevos parametros para registrar en tabla CI_ORSERV
	private Long numCargo;
	private Long idGestor;
	private Long numMovimientoOS;
	private Integer codEstadoOS;
	private Integer codVendedorOS;
	
	
	
	public String getCarta() {
		return carta;
	}
	public void setCarta(String carta) {
		this.carta = carta;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getCodActAboDetalle() {
		return codActAboDetalle;
	}
	public void setCodActAboDetalle(String codActAboDetalle) {
		this.codActAboDetalle = codActAboDetalle;
	}
	public String getCodActCen() {
		return CodActCen;
	}
	public void setCodActCen(String codActCen) {
		CodActCen = codActCen;
	}
	public String getCodActuacion() {
		return codActuacion;
	}
	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}
	public String getCodAplica() {
		return codAplica;
	}
	public void setCodAplica(String codAplica) {
		this.codAplica = codAplica;
	}
	public Integer getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(Integer codCentral) {
		this.codCentral = codCentral;
	}
	public String getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(String codCiclo) {
		this.codCiclo = codCiclo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public Long getCodClienteDes() {
		return codClienteDes;
	}
	public void setCodClienteDes(Long codClienteDes) {
		this.codClienteDes = codClienteDes;
	}
	public String getCodCuentaDes() {
		return codCuentaDes;
	}
	public void setCodCuentaDes(String codCuentaDes) {
		this.codCuentaDes = codCuentaDes;
	}
	public String getCodCuentaOrig() {
		return codCuentaOrig;
	}
	public void setCodCuentaOrig(String codCuentaOrig) {
		this.codCuentaOrig = codCuentaOrig;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public Integer getCodEstadoOS() {
		return codEstadoOS;
	}
	public void setCodEstadoOS(Integer codEstadoOS) {
		this.codEstadoOS = codEstadoOS;
	}
	public String getCodFechaSistema() {
		return codFechaSistema;
	}
	public void setCodFechaSistema(String codFechaSistema) {
		this.codFechaSistema = codFechaSistema;
	}
	public Long getCodInter() {
		return codInter;
	}
	public void setCodInter(Long codInter) {
		this.codInter = codInter;
	}
	public String getCodModGener() {
		return codModGener;
	}
	public void setCodModGener(String codModGener) {
		this.codModGener = codModGener;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public String getCodModuloDetalle() {
		return codModuloDetalle;
	}
	public void setCodModuloDetalle(String codModuloDetalle) {
		this.codModuloDetalle = codModuloDetalle;
	}
	public String getCodOS() {
		return codOS;
	}
	public void setCodOS(String codOS) {
		this.codOS = codOS;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public Integer getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(Integer codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipContrato() {
		return codTipContrato;
	}
	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}
	public String getCodTipModi() {
		return codTipModi;
	}
	public void setCodTipModi(String codTipModi) {
		this.codTipModi = codTipModi;
	}
	public String getCodTipPlanTarid() {
		return codTipPlanTarid;
	}
	public void setCodTipPlanTarid(String codTipPlanTarid) {
		this.codTipPlanTarid = codTipPlanTarid;
	}
	public String getCodTipPlanTarif() {
		return codTipPlanTarif;
	}
	public void setCodTipPlanTarif(String codTipPlanTarif) {
		this.codTipPlanTarif = codTipPlanTarif;
	}
	public Integer getCodUso() {
		return codUso;
	}
	public void setCodUso(Integer codUso) {
		this.codUso = codUso;
	}
	public Integer getCodVendedorOS() {
		return codVendedorOS;
	}
	public void setCodVendedorOS(Integer codVendedorOS) {
		this.codVendedorOS = codVendedorOS;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
	public String getDesSS() {
		return desSS;
	}
	public void setDesSS(String desSS) {
		this.desSS = desSS;
	}
	public String getEvento() {
		return evento;
	}
	public void setEvento(String evento) {
		this.evento = evento;
	}
	public Timestamp getFechaOS() {
		return fechaOS;
	}
	public void setFechaOS(Timestamp fechaOS) {
		this.fechaOS = fechaOS;
	}
	public Timestamp getFecMigracion() {
		return fecMigracion;
	}
	public void setFecMigracion(Timestamp fecMigracion) {
		this.fecMigracion = fecMigracion;
	}
	public String getGrupo() {
		return grupo;
	}
	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}
	public String getGrupoOS() {
		return grupoOS;
	}
	public void setGrupoOS(String grupoOS) {
		this.grupoOS = grupoOS;
	}
	public Long getIdGestor() {
		return idGestor;
	}
	public void setIdGestor(Long idGestor) {
		this.idGestor = idGestor;
	}
	public int getIndAlgunos() {
		return indAlgunos;
	}
	public void setIndAlgunos(int indAlgunos) {
		this.indAlgunos = indAlgunos;
	}
	public int getIndArchivo() {
		return indArchivo;
	}
	public void setIndArchivo(int indArchivo) {
		this.indArchivo = indArchivo;
	}
	public int getIndCron() {
		return indCron;
	}
	public void setIndCron(int indCron) {
		this.indCron = indCron;
	}
	public String getIndCServicio() {
		return indCServicio;
	}
	public void setIndCServicio(String indCServicio) {
		this.indCServicio = indCServicio;
	}
	public int getIndProrroga() {
		return indProrroga;
	}
	public void setIndProrroga(int indProrroga) {
		this.indProrroga = indProrroga;
	}
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public String getNomExe() {
		return nomExe;
	}
	public void setNomExe(String nomExe) {
		this.nomExe = nomExe;
	}
	public String getNomUsuarioSCL() {
		return nomUsuarioSCL;
	}
	public void setNomUsuarioSCL(String nomUsuarioSCL) {
		this.nomUsuarioSCL = nomUsuarioSCL;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public Long getNumCargo() {
		return numCargo;
	}
	public void setNumCargo(Long numCargo) {
		this.numCargo = numCargo;
	}
	public String getNumId() {
		return numId;
	}
	public void setNumId(String numId) {
		this.numId = numId;
	}
	public Long getNumMovimientoOS() {
		return numMovimientoOS;
	}
	public void setNumMovimientoOS(Long numMovimientoOS) {
		this.numMovimientoOS = numMovimientoOS;
	}
	public Long getNumOS() {
		return numOS;
	}
	public void setNumOS(Long numOS) {
		this.numOS = numOS;
	}
	public Long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(Long numVenta) {
		this.numVenta = numVenta;
	}
	public String getPrg() {
		return prg;
	}
	public void setPrg(String prg) {
		this.prg = prg;
	}
	public String getProceso() {
		return proceso;
	}
	public void setProceso(String proceso) {
		this.proceso = proceso;
	}
	public Integer getProducto() {
		return producto;
	}
	public void setProducto(Integer producto) {
		this.producto = producto;
	}
	public String getPrograma() {
		return programa;
	}
	public void setPrograma(String programa) {
		this.programa = programa;
	}
	public String getProgramaDetalle() {
		return programaDetalle;
	}
	public void setProgramaDetalle(String programaDetalle) {
		this.programaDetalle = programaDetalle;
	}
	public String getRestriccionAux() {
		return restriccionAux;
	}
	public void setRestriccionAux(String restriccionAux) {
		this.restriccionAux = restriccionAux;
	}
	public Long getSecuencia() {
		return secuencia;
	}
	public void setSecuencia(Long secuencia) {
		this.secuencia = secuencia;
	}
	public String getTipExtincion() {
		return tipExtincion;
	}
	public void setTipExtincion(String tipExtincion) {
		this.tipExtincion = tipExtincion;
	}
	public String getTipoSuspension() {
		return tipoSuspension;
	}
	public void setTipoSuspension(String tipoSuspension) {
		this.tipoSuspension = tipoSuspension;
	}
	public int getTipProcesa() {
		return tipProcesa;
	}
	public void setTipProcesa(int tipProcesa) {
		this.tipProcesa = tipProcesa;
	}
	
	
}
