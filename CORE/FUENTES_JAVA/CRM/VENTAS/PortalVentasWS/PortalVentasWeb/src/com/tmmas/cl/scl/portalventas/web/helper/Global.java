/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA. Av. Del Condor 720, Huechuraba,
 * Santiago de Chile, Chile Todos los derechos reservados. Este software es informaci&oacute;n propietaria y
 * confidencial de TM-mAs SA. Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia con los
 * t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs. Fecha ------------------- Autor
 * ------------------------- Cambios ---------- 10/08/2006 Jimmy Lopez Versión Inicial
 */
package com.tmmas.cl.scl.portalventas.web.helper;

import java.io.Serializable;

import org.apache.commons.configuration.CompositeConfiguration;

import com.tmmas.cl.framework.util.MessageResourcesConfig;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class Global implements Serializable {
	
	private static final String FORMULARIO_GESTION_SCORING = "valor.formulario.scoring";

	private static final String TITULO_GESTION_SCORING = "titulo.gestion.scoring";

	private static final String TITULO_REPORTES_SCORING = "titulo.reportes.scoring";

	private static final String FORMULARIO_REPORTES_SCORING = "valor.formulario.reportes.scoring";

	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private static final String archivoRecurso = "com.tmmas.cl.scl.portalventas.web.properties.portalventasweb";

	private CompositeConfiguration configExterno;

	private static final String CLAVE_TIPOS_ARCHIVOS_DOC_DIGITALIZADO = "modulo.web.asociacion.documentos.extensiones.validas";

	private static final String CLAVE_TAM_MAX_DOC_DIGITALIZADO = "modulo.web.asociacion.documentos.max.archivo.bytes";

	// --------------------------------------------------------------------------
	private Global() {
		this.recurso = new MessageResourcesConfig(archivoRecurso);
		
		configExterno = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
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

	public String getValorExterno(String valorClave) {
		return configExterno.getString(valorClave);
	}

	public String obtenerExtensionesDocDigitalizadoValidas() {
		return getValor(CLAVE_TIPOS_ARCHIVOS_DOC_DIGITALIZADO).trim().toLowerCase();
	}

	public int obtenerMaximoTamanoBytesDocDigitalizado() {
		return new Integer(getValorExterno(CLAVE_TAM_MAX_DOC_DIGITALIZADO).trim()).intValue();
	}

	public DatosGeneralesDTO[] obtenerArrayTipoClientePasilloLDI() {
		DatosGeneralesDTO[] r = new DatosGeneralesDTO[2];
		r[0] = new DatosGeneralesDTO();
		r[0].setCodigoValor(getValor("tipo.cliente.particular"));
		r[0].setDescripcionValor(getValor("tipo.cliente.particular.descripcion"));
		r[1] = new DatosGeneralesDTO();
		r[1].setCodigoValor(getValor("tipo.cliente.empresa"));
		r[1].setDescripcionValor(getValor("tipo.cliente.empresa.descripcion"));
		r[2] = new DatosGeneralesDTO();
		r[2].setCodigoValor(getValor("tipo.cliente.pyme"));
		r[2].setDescripcionValor(getValor("tipo.cliente.pyme.descripcion"));
		return r;
	}

	public String getFormularioReporteScoring() {
		return getValor(FORMULARIO_REPORTES_SCORING).trim();
	}

	public String getTituloReportesScoring() {
		return getValor(TITULO_REPORTES_SCORING).trim();
	}

	public String getTituloGestionScoring() {
		return getValor(TITULO_GESTION_SCORING).trim();
	}

	public String getFormularioGestionScoring() {
		return getValor(FORMULARIO_GESTION_SCORING).trim();
	}

	public String getEstadoScoringPendienteRevision() {
		return getValorExterno("scoring.estado.pendiente.revision");
	}
	
	public String getEstadoScoringPendientePreactivar() {
		return getValorExterno("scoring.estado.pendiente.preactivar");
	}

	public String getEstadoScoringPendienteEnviar() {
		return getValorExterno("scoring.estado.pendiente.enviar");
	}

	public String getEstadoScoringPreactivo() {
		return getValorExterno("scoring.estado.preactivo");
	}

	public String getEstadoScoringRechazado() {
		return getValorExterno("scoring.estado.rechazado");
	}

	public String getEstadoScoringEvaluado() {
		return getValorExterno("scoring.estado.evaluado");
	}

	public String getEstadoScoringCancelado() {
		return getValorExterno("scoring.estado.cancelado");
	}

	public String getEstadoScoringAprobado() {
		return getValorExterno("scoring.estado.aprobado");
	}

	public String getModuloWebScoring() {
		return getValor("modulo.web.scoring");
	}

	public String getEstadoScoringSolNormal() {
		return getValorExterno("scoring.estado.solnormal");
	}

	public String getTablaEstadosScoring() {
		return getValor("tabla.estado.scoring");
	}

	public String getCodProgramaScoring() {
		return getValor("cod_programa.scoring");
	}

	public String getCodigoProducto() {
		return getValor("codigo.producto");
	}

	public String getCodigoModuloGA() {
		return getValor("codigo.modulo.GA");
	}
}
