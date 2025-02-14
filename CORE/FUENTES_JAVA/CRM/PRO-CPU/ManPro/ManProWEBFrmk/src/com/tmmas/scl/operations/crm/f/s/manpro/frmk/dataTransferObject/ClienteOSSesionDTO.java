package com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;

public class ClienteOSSesionDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private long codCliente;
	private long numAbonado;
	private long codOrdenServicio;
	private long numOrdenServicio;
	
	private String usuario;
	private String clave;
	private String forward;
	
	private ClienteDTO cliente;
	private AbonadoDTO[] abonados;
	//private DefaultPaginaCPUDTO defaultPagina;
	private String resumenOS;
	private String ComentarioOS;
	//private CargosObtenidosDTO cargosObtenidos;
	
	private String clColor;
	private String clSegmento;
	
	private ValoresDefectoPaginaDTO valoresDefecto;
	private long numVenta;
	private int maxListaProductos;
	
	public int getMaxListaProductos() {
		return maxListaProductos;
	}
	public void setMaxListaProductos(int maxListaProductos) {
		this.maxListaProductos = maxListaProductos;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	//public CargosObtenidosDTO getCargosObtenidos() {
		//return cargosObtenidos;
	//}
	//public void setCargosObtenidos(CargosObtenidosDTO cargosObtenidos) {
		//this.cargosObtenidos = cargosObtenidos;
	//}
	public AbonadoDTO[] getAbonados() {
		return abonados;
	}
	public void setAbonados(AbonadoDTO[] abonados) {
		this.abonados = abonados;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodOrdenServicio() {
		return codOrdenServicio;
	}
	public void setCodOrdenServicio(long codOrdenServicio) {
		this.codOrdenServicio = codOrdenServicio;
	}
//	public DefaultPaginaCPUDTO getDefaultPagina() {
//		return defaultPagina;
//	}
//	public void setDefaultPagina(DefaultPaginaCPUDTO defaultPagina) {
//		this.defaultPagina = defaultPagina;
//	}
	public String getForward() {
		return forward;
	}
	public void setForward(String forward) {
		this.forward = forward;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumOrdenServicio() {
		return numOrdenServicio;
	}
	public void setNumOrdenServicio(long numOrdenServicio) {
		this.numOrdenServicio = numOrdenServicio;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getResumenOS() {
		return resumenOS;
	}
	public void setResumenOS(String resumenOS) {
		this.resumenOS = resumenOS;
	}
	public String getComentarioOS() {
		return ComentarioOS;
	}
	public void setComentarioOS(String comentarioOS) {
		ComentarioOS = comentarioOS;
	}
	public String getClColor() {
		return clColor;
	}
	public void setClColor(String clColor) {
		this.clColor = clColor;
	}
	public String getClSegmento() {
		return clSegmento;
	}
	public void setClSegmento(String clSegmento) {
		this.clSegmento = clSegmento;
	}
	public ValoresDefectoPaginaDTO getValoresDefecto() {
		return valoresDefecto;
	}
	public void setValoresDefecto(ValoresDefectoPaginaDTO valoresDefecto) {
		this.valoresDefecto = valoresDefecto;
	}
	
	
	
	

}
