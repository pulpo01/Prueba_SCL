/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 * 
 */
package com.tmmas.cl.scl.activacionmasiva.soa.helper;

import java.io.Serializable;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private static Logger logger = Logger.getLogger(Global.class);

	private final String archivoRecurso = "com.tmmas.cl.scl.activacionmasiva.soa.properties.soa";

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
	
	public String getJndiFactory()
	{
		return this.recurso.obtenerValorClave("jndi.Factory");
	}	
	
	public String getJndiQueueOrdenServicio()
	{
		return this.recurso.obtenerValorClave("queue.OrdenServicio");
	}	
	
	
	/////


	public String getEtiquetaCabecera() {
		return this.recurso.obtenerValorClave("etiqueta.cabecera");
	}

	public String getEtiquetaDetalle() {
		return this.recurso.obtenerValorClave("etiqueta.detalle");
	}

	public String getSeparador(){
		return this.recurso.obtenerValorClave("separador.detalle");
	}
	
	public String getSufijoArchivoSalida(){
		return this.recurso.obtenerValorClave("sufijo.archivo.salida");
	}

	public String getSufijoArchivoFinal(){
		return this.recurso.obtenerValorClave("sufijo.archivo.final");
	}

	public String getTotalProcesos(){
		return this.recurso.obtenerValorClave("total.procesos");
	}

	public String getIndiceSubprocesoValidacion(){
		return this.recurso.obtenerValorClave("indice.subproceso.validacion");
	}

	public String getIndiceSubprocesoCrearLineas(){
		return this.recurso.obtenerValorClave("indice.subproceso.crear.lineas");
	}

	public String getIndicadorBloqueo(){
		return this.recurso.obtenerValorClave("indicador.bloqueo");
	}//fin getIndicadorBloqueo

	public String getIndicadorDesbloqueo(){
		return this.recurso.obtenerValorClave("indicador.desbloqueo");
	}//fin getIndicadorDesbloqueo
	
	public String getAplicaTipoCargo(){
		return this.recurso.obtenerValorClave("aplica.tipo.cargo");
	} 
	
}
