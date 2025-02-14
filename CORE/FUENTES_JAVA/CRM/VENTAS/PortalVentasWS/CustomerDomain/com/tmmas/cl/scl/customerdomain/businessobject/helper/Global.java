/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.customerdomain.businessobject.helper;

import java.io.Serializable;
import java.text.DateFormat;
import java.util.Locale;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private JndiForDataSource jndiForDataSource = null;

		private final String archivoRecurso = "com.tmmas.cl.scl.customerdomain.businessobject.properties.businessobject";

	// --------------------------------------------------------------------------
	private Global() {
		this.recurso = new MessageResourcesConfig(archivoRecurso);
	}

	// --------------------------------------------------------------------------
	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global();
		}
		return instance;
	}

	public MessageResourcesConfig getMessageResourcesConfig() {
		return this.recurso;
	}

	public String getValor(String valorClave) {
		String valor = this.recurso.obtenerValorClave(valorClave);
		return valor;
	}

	public String getJndiDataSource() {
		return this.recurso.obtenerValorClave("jndi.dataSource");
	}
	
	public JndiForDataSource getJndiForDataSource() {

		if (jndiForDataSource == null) {

			jndiForDataSource = new JndiForDataSource();

			jndiForDataSource.setJndiDataSource(this.getJndiDataSource());

		}
		return jndiForDataSource;
	}
	
	public String errorgetListado()
	{
		return this.recurso.obtenerValorClave("error.getListado.procesaRespuesta");
	}
	
	
	public String ModoEjecucion()
	{
		return this.recurso.obtenerValorClave("modo.ejecucion");
	}
	public String getValorCodigoModulo() {
		return this.recurso.obtenerValorClave("valor.codigo.modulo");
	}
	public int getValorCodigoProducto() {
		return Integer.parseInt(this.recurso.obtenerValorClave("valor.codigo.producto"));
	}
	public String getValorColumnaIndAgente() {
		return this.recurso.obtenerValorClave("valor.columna.ind_agente");
	}

	public String getValorColumnaIndSituacion() {
		return this.recurso.obtenerValorClave("valor.columna.ind_situacion");
	}

	public String getValorColumnaCodigoOperacion() {
		return this.recurso.obtenerValorClave("valor.columna.cod_operacion");
	}
	public String getVendedorExterno() {
		return this.recurso.obtenerValorClave("vendedor.externo");
	}
	
	public String getVendedorInterno() {
		return this.recurso.obtenerValorClave("vendedor.interno");
	}
	public String getEstadoVigenteEvaluacionRiesgo() {
		return this.recurso.obtenerValorClave("estado.vigente.evaluacionriesgo");
	}
	public int getIndicadorEvento() {
		return Integer.parseInt(this.recurso.obtenerValorClave("indicador.evento"));
	}
	public int getTipoSolicitud() {
		return Integer.parseInt(this.recurso.obtenerValorClave("tipo.solicitud"));
	}
	
	public String getNombreSecuenciaUsuario(){
		return this.recurso.obtenerValorClave("secuencia.usuario");
	}
	
	public String getNombreSecuenciaAbonado(){
		return this.recurso.obtenerValorClave("secuencia.abonado");
	}
	
	public String getNombreSecuenciaVenta(){
		return this.recurso.obtenerValorClave("secuencia.venta");
	}

	public String getNombreSecuenciaTransacabo(){
		return this.recurso.obtenerValorClave("secuencia.transacabo");
	}

	public String getEstadoIncompletoUsuario(){
		return this.recurso.obtenerValorClave("estado.incompleto.usuario");
	}
	
	public String getCodigoModuloAL(){
		return this.recurso.obtenerValorClave("codigo.modulo.AL");
	}//fin getCodigoModuloAL

	public String getStockConsignacion(){
		return this.recurso.obtenerValorClave("parametro.stockConsignacion");
	}//fin getLargoSerieTerminal

	
	public String obtenerCodigoLenguaje() {
		String CLAVE_CODIGO_LENGUAJE = "codigo.lenguaje";
		String r = getValor(CLAVE_CODIGO_LENGUAJE);
		return r.toLowerCase();
	}

	public String obtenerCodigoPais() {
		String CLAVE_CODIGO_PAIS = "codigo.pais";
		String r = getValor(CLAVE_CODIGO_PAIS);
		return r;
	}

	public Locale obtenerLocalePais() {
		return new Locale(obtenerCodigoLenguaje(), obtenerCodigoPais());
	}

	public DateFormat obtenerFormatoCortoFecha() {
		return DateFormat.getDateInstance(DateFormat.SHORT, obtenerLocalePais());
	}

	public DateFormat obtenerFormatoLargoFecha() {
		return DateFormat.getDateInstance(DateFormat.LONG, obtenerLocalePais());
	}
	
}