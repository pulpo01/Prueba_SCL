package com.tmmas.cl.scl.portalventas.web.helper;

import org.apache.log4j.Logger;

import scorecliente.ScoreCliente;
import scorecliente.ScoreClienteProxy;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;

import consultas.Consulta;
import consultas.ConsultaProxy;

public class ScoringHelper {

	private static Logger logger = Logger.getLogger(ScoringHelper.class);

	private static Consulta consultaScoring = null;

	private static ScoreCliente scoreClienteScoring = null;
	
	private static Global global = Global.getInstance();

	public static Consulta getConsultaInstance(String endPoint) {
		logger.info("getConsultaInstance, inicio");
		logger.debug("endPoint [" + endPoint + "]");
		if (consultaScoring == null) {
			ConsultaProxy consultaProxy = new ConsultaProxy();
			consultaProxy.setEndpoint(endPoint);
			consultaScoring = consultaProxy.getConsulta();
		}
		logger.info("getConsultaInstance, fin");
		return consultaScoring;
	}

	public static ScoreCliente getScoreClienteInstance(String endPoint) {
		logger.info("getScoreClienteInstance, inicio");
		logger.debug("endPoint [" + endPoint + "]");
		if (scoreClienteScoring == null) {
			ScoreClienteProxy scoreClienteProxy = new ScoreClienteProxy();
			scoreClienteProxy.setEndpoint(endPoint);
			scoreClienteScoring = scoreClienteProxy.getScoreCliente();
		}
		logger.info("getScoreClienteInstance, fin");
		return scoreClienteScoring;
	}

	public static void validarSolicitudScoring(ScoreClienteDTO dto) throws Exception {
		logger.info("validarSolicitudScoring, inicio");
		logger.debug(dto.toString());
		if (Utilidades.emptyOrNull(dto.getAplicaTarjeta())) {
			throw new VentasException("Valor no establecido [I_tarjeta]");
		}
		if (Utilidades.emptyOrNull(dto.getAntiguedad_laboral())) {
			throw new VentasException("Valor no establecido [I_antiguedad_laboral]");
		}
		if (Utilidades.emptyOrNull(dto.getCodEstadoCivil())) {
			throw new VentasException("Valor no establecido [I_estado_civil]");
		}
		if (Utilidades.emptyOrNull(dto.getCodNacionalidad())) {
			throw new VentasException("Valor no establecido [I_nacionalidad]");
		}
		if (Utilidades.emptyOrNull(dto.getCodNivelAcademico())) {
			throw new VentasException("Valor no establecido [I_nivel_academico]");
		}
		if (Utilidades.emptyOrNull(dto.getCodTipoDocumento())) {
			throw new VentasException("Valor no establecido [I_tipo_documento]");
		}
		if (Utilidades.emptyOrNull(dto.getDocumento())) {
			logger.info("Valor no establecido [I_documento]"); // Campo opcional
		}
		if (Utilidades.emptyOrNull(dto.getCodTipoEmpresa())) {
			throw new VentasException("Valor no establecido [I_tipo_empresa]");
		}
		if (Utilidades.emptyOrNull(dto.getCodTipoTarjeta())) {
			logger.info("Valor no establecido [I_tipo_tarjeta]");// Campo opcional
		}
		if (Utilidades.emptyOrNull(dto.getNumTarjeta())) {
			logger.info("Valor no establecido [num_tarjeta]");// Campo opcional
		}
		if (Utilidades.emptyOrNull(dto.getNit())) {
			throw new VentasException("Valor no establecido [I_nit]");
		}
		if (Utilidades.emptyOrNull(dto.getPrimer_apellido())) {
			throw new VentasException("Valor no establecido [I_primer_apellido]");
		}
		if (Utilidades.emptyOrNull(dto.getPrimer_nombre())) {
			throw new VentasException("Valor no establecido [I_primer_nombre]");
		}
		if (Utilidades.emptyOrNull(dto.getSegundo_apellido())) {
			throw new VentasException("Valor no establecido [I_segundo_apellido]");
		}
		if (Utilidades.emptyOrNull(dto.getSegundo_nombre())) {
			throw new VentasException("Valor no establecido [I_segundo_nombre]");
		}
		if (Utilidades.emptyOrNull(dto.getFecha_nacimiento())) {
			throw new VentasException("Valor no establecido [I_fecha_nacimiento]");
		}
		logger.info("validarSolicitudScoring, fin");
	}

	public static void validarSujetoFisico(ScoreClienteDTO dto) throws Exception {
		logger.info("validarSujetoFisico, inicio");
		validarSolicitudScoring(dto);
		if (Utilidades.emptyOrNull(dto.getI_creado_por())) {
			throw new VentasException("Valor no establecido [I_creado_por]");
		}
		if (Utilidades.emptyOrNull(dto.getCapacidad_pago())) {
			throw new VentasException("Valor no establecido [I_capacidad_pago]");
		}
		if (Utilidades.emptyOrNull(dto.getTip_producto())) {
			throw new VentasException("Valor no establecido [I_tip_producto]");
		}
		if (Utilidades.emptyOrNull(dto.getI_cod_elementoid())) {
			throw new VentasException("Valor no establecido [I_cod_elementoid]");
		}
		logger.info("validarSujetoFisico, fin");
	}
	
	private static EstadoScoringDTO buscarEstado(EstadoScoringDTO[] estados, String codEstado) {
		logger.info("buscarEstado, inicio");
		logger.debug("codEstado [" + codEstado + "]");
		for (int i = 0; i < estados.length; i++) {
			if (estados[i].getCodEstado().equals(codEstado)) {
				return estados[i];
			}
		}
		return null;
	}

	public static EstadoScoringDTO buscarEstadoRechazado(EstadoScoringDTO[] estados) {
		return buscarEstado(estados, global.getEstadoScoringRechazado());
	}
	
	public static EstadoScoringDTO buscarEstadoEvaluado(EstadoScoringDTO[] estados) {
		return buscarEstado(estados, global.getEstadoScoringEvaluado());
	}
}
