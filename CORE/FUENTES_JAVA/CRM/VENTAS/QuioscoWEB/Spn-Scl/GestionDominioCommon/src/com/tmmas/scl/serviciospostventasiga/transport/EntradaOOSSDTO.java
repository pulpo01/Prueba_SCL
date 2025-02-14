package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;
import java.sql.Date;

public class EntradaOOSSDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String sCodOS;               // Codigo de orden de servicio
	public Long lNumCelular;            // Numero de Celular 
	public String sCodUsuario;          // Codigo de Uusario
	public Long lNumAbonado;            // Numero de Abonado
	public Long lCodCliente;            // Codigo de Cliente
	public Integer iIndCentral;             // Indicador de Central
	public String sTipTerminal;         // Tipo de Terminal
	public String sCodCausaSin;         // Codigo Causa de Siniestro
	public Long lNumVenta;              // Numero de Venta
	public Long lNumTransaccion;        // Numero de transaccion
	public Long lNumFolio;              // Numero de Folio
	public Integer iNumCuotas;              // Numero de Cuotas
	public Long lNumProceso;            // Numero de proceso
	public Date dFecAnulacion;          // Fecha de anulacion
	public String sCatTributaria;       // Categoria Tributaria
	public String sCodEstado;           // Codigo de Estado
	public Date dFecProgramacion;       // Fecha de Ejecucion o Programacion
	public String sClaseServActivar;    // Cadena Servicios Activar
	public String sClaseServDesactivar; // Cadena Servicios Desactivar
	public Integer iIndPortable;            // Indicador Portabilidad
	public String sComentario;          // Comentario OOSS
	
	
	public Date getDFecAnulacion() {
		return dFecAnulacion;
	}
	public void setDFecAnulacion(Date fecAnulacion) {
		dFecAnulacion = fecAnulacion;
	}
	public Date getDFecProgramacion() {
		return dFecProgramacion;
	}
	public void setDFecProgramacion(Date fecProgramacion) {
		dFecProgramacion = fecProgramacion;
	}
	public Integer getIIndCentral() {
		return iIndCentral;
	}
	public void setIIndCentral(Integer indCentral) {
		iIndCentral = indCentral;
	}
	public Integer getIIndPortable() {
		return iIndPortable;
	}
	public void setIIndPortable(Integer indPortable) {
		iIndPortable = indPortable;
	}
	public Integer getINumCuotas() {
		return iNumCuotas;
	}
	public void setINumCuotas(Integer numCuotas) {
		iNumCuotas = numCuotas;
	}
	public Long getLCodCliente() {
		return lCodCliente;
	}
	public void setLCodCliente(Long codCliente) {
		lCodCliente = codCliente;
	}
	public Long getLNumAbonado() {
		return lNumAbonado;
	}
	public void setLNumAbonado(Long numAbonado) {
		lNumAbonado = numAbonado;
	}
	public Long getLNumCelular() {
		return lNumCelular;
	}
	public void setLNumCelular(Long numCelular) {
		lNumCelular = numCelular;
	}
	public Long getLNumFolio() {
		return lNumFolio;
	}
	public void setLNumFolio(Long numFolio) {
		lNumFolio = numFolio;
	}
	public Long getLNumProceso() {
		return lNumProceso;
	}
	public void setLNumProceso(Long numProceso) {
		lNumProceso = numProceso;
	}
	public Long getLNumTransaccion() {
		return lNumTransaccion;
	}
	public void setLNumTransaccion(Long numTransaccion) {
		lNumTransaccion = numTransaccion;
	}
	public Long getLNumVenta() {
		return lNumVenta;
	}
	public void setLNumVenta(Long numVenta) {
		lNumVenta = numVenta;
	}
	public String getSCatTributaria() {
		return sCatTributaria;
	}
	public void setSCatTributaria(String catTributaria) {
		sCatTributaria = catTributaria;
	}
	public String getSClaseServActivar() {
		return sClaseServActivar;
	}
	public void setSClaseServActivar(String claseServActivar) {
		sClaseServActivar = claseServActivar;
	}
	public String getSClaseServDesactivar() {
		return sClaseServDesactivar;
	}
	public void setSClaseServDesactivar(String claseServDesactivar) {
		sClaseServDesactivar = claseServDesactivar;
	}
	public String getSCodCausaSin() {
		return sCodCausaSin;
	}
	public void setSCodCausaSin(String codCausaSin) {
		sCodCausaSin = codCausaSin;
	}
	public String getSCodEstado() {
		return sCodEstado;
	}
	public void setSCodEstado(String codEstado) {
		sCodEstado = codEstado;
	}
	public String getSCodOS() {
		return sCodOS;
	}
	public void setSCodOS(String codOS) {
		sCodOS = codOS;
	}
	public String getSCodUsuario() {
		return sCodUsuario;
	}
	public void setSCodUsuario(String codUsuario) {
		sCodUsuario = codUsuario;
	}
	public String getSComentario() {
		return sComentario;
	}
	public void setSComentario(String comentario) {
		sComentario = comentario;
	}
	public String getSTipTerminal() {
		return sTipTerminal;
	}
	public void setSTipTerminal(String tipTerminal) {
		sTipTerminal = tipTerminal;
	}
	
	
}
