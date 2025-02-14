package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EstadoProcesoOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;

public class OrdenServicioBaseDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private ClienteDTO cliente;
	private AbonadoDTO abonado;
	private String usuario;
	private String codOrdenServicio;
	private String numOrdenServicio;
	private int codProducto;
	private int tipInter;
	private long codInter;
	private Date fecha;
	private String comentario;
	private long numMovimiento;
	private int codEstado;
	private String codModulo;
	private int idGestor;
	private String sujeto;
	private String codActAbo;
	private CargosObtenidosDTO RegistroCargos;
	private String codTipoDocumento;
	private String modPago;
	private int codVendedor;
	private String aCiclo;
	private String nomUsuaOra;
	private EstadoProcesoOOSSDTO estadoProcesoOOSS;
	
	
	public EstadoProcesoOOSSDTO getEstadoProcesoOOSS() {
		return estadoProcesoOOSS;
	}
	public void setEstadoProcesoOOSS(EstadoProcesoOOSSDTO estadoProcesoOOSS) {
		this.estadoProcesoOOSS = estadoProcesoOOSS;
	}
	public String getNomUsuaOra() {
		return nomUsuaOra;
	}
	public void setNomUsuaOra(String nomUsuaOra) {
		this.nomUsuaOra = nomUsuaOra;
	}
	public String getACiclo() {
		return aCiclo;
	}
	public void setACiclo(String ciclo) {
		aCiclo = ciclo;
	}
	public int getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(int codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getCodTipoDocumento() {
		return codTipoDocumento;
	}
	public void setCodTipoDocumento(String codTipoDocumento) {
		this.codTipoDocumento = codTipoDocumento;
	}
	public String getModPago() {
		return modPago;
	}
	public void setModPago(String modPago) {
		this.modPago = modPago;
	}
	public AbonadoDTO getAbonado() {
		return abonado;
	}
	public void setAbonado(AbonadoDTO abonado) {
		this.abonado = abonado;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public String getCodOrdenServicio() {
		return codOrdenServicio;
	}
	public void setCodOrdenServicio(String codOrdenServicio) {
		this.codOrdenServicio = codOrdenServicio;
	}
	public String getNumOrdenServicio() {
		return numOrdenServicio;
	}
	public void setNumOrdenServicio(String numOrdenServicio) {
		this.numOrdenServicio = numOrdenServicio;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public CargosObtenidosDTO getRegistroCargos() {
		return RegistroCargos;
	}
	public void setRegistroCargos(CargosObtenidosDTO registroCargos) {
		RegistroCargos = registroCargos;
	}
	public int getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(int codEstado) {
		this.codEstado = codEstado;
	}
	public long getCodInter() {
		return codInter;
	}
	public void setCodInter(long codInter) {
		this.codInter = codInter;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public int getIdGestor() {
		return idGestor;
	}
	public void setIdGestor(int idGestor) {
		this.idGestor = idGestor;
	}
	public long getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	public int getTipInter() {
		return tipInter;
	}
	public void setTipInter(int tipInter) {
		this.tipInter = tipInter;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getSujeto() {
		return sujeto;
	}
	public void setSujeto(String sujeto) {
		this.sujeto = sujeto;
	}
	
	

}
