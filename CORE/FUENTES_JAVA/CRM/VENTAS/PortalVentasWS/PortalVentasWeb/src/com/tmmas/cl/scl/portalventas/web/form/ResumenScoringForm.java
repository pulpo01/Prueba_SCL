package com.tmmas.cl.scl.portalventas.web.form;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ResultadoScoreClienteDTO;

public class ResumenScoringForm extends SolicitudScoringForm {

	private static final long serialVersionUID = -9053529122964071565L;

	protected EstadoDTO[] arrayEstadosDestino;

	protected String codEstadoDestino;

	protected String codEstadoScoringAprobado;

	protected String codEstadoScoringCancelado;

	protected String codEstadoScoringEvaluado;

	protected String codEstadoScoringRechazado;

	protected String codEstadoScoringPendienteEnviar;

	protected String codEstadoScoringPendientePreactivar;
	
	protected String codEstadoActualizaSolicitudNormal;

	protected String numVenta;

	protected String comentario;
	
	private String codModuloOrigen;
	
	private String codModuloGestionScoring;
	
	private ResultadoScoreClienteDTO resultadoScoreClienteDTO;

	public ResultadoScoreClienteDTO getResultadoScoreClienteDTO() {
		return resultadoScoreClienteDTO;
	}

	public void setResultadoScoreClienteDTO(ResultadoScoreClienteDTO resultadoScoreClienteDTO) {
		this.resultadoScoreClienteDTO = resultadoScoreClienteDTO;
	}

	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	public String getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}

	public String getCodEstadoScoringPendienteEnviar() {
		return codEstadoScoringPendienteEnviar;
	}

	public void setCodEstadoScoringPendienteEnviar(String codEstadoScoringPendienteEnviar) {
		this.codEstadoScoringPendienteEnviar = codEstadoScoringPendienteEnviar;
	}

	public EstadoDTO[] getArrayEstadosDestino() {
		return arrayEstadosDestino;
	}

	public String getCodEstadoActual() {
		return getScoreClienteDTO().getEstadoActualDTO().getCodEstado();
	}

	public String getCodEstadoDestino() {
		return codEstadoDestino;
	}

	public String getCodEstadoScoringAprobado() {
		return codEstadoScoringAprobado;
	}

	public String getCodEstadoScoringCancelado() {
		return codEstadoScoringCancelado;
	}

	public String getCodEstadoScoringEvaluado() {
		return codEstadoScoringEvaluado;
	}

	public String getDesEstadoActual() {
		return getScoreClienteDTO().getEstadoActualDTO().getDesEstado();
	}

	public void setArrayEstadosDestino(EstadoDTO[] arrayEstadosDestino) {
		this.arrayEstadosDestino = arrayEstadosDestino;
	}

	public void setCodEstadoDestino(String codEstadoDestino) {
		this.codEstadoDestino = codEstadoDestino;
	}

	public void setCodEstadoScoringAprobado(String codEstadoScoringAprobado) {
		this.codEstadoScoringAprobado = codEstadoScoringAprobado;
	}

	public void setCodEstadoScoringCancelado(String codEstadoScoringCancelado) {
		this.codEstadoScoringCancelado = codEstadoScoringCancelado;
	}

	public void setCodEstadoScoringEvaluado(String codEstadoScoringEvaluado) {
		this.codEstadoScoringEvaluado = codEstadoScoringEvaluado;
	}

	public String getCodEstadoScoringRechazado() {
		return codEstadoScoringRechazado;
	}

	public void setCodEstadoScoringRechazado(String codEstadoScoringRechazado) {
		this.codEstadoScoringRechazado = codEstadoScoringRechazado;
	}

	public String getCodEstadoScoringPendientePreactivar() {
		return codEstadoScoringPendientePreactivar;
	}

	public void setCodEstadoScoringPendientePreactivar(String codEstadoScoringPendientePreactivar) {
		this.codEstadoScoringPendientePreactivar = codEstadoScoringPendientePreactivar;
	}

	public String getCodEstadoActualizaSolicitudNormal() {
		return codEstadoActualizaSolicitudNormal;
	}

	public void setCodEstadoActualizaSolicitudNormal(
			String codEstadoActualizaSolicitudNormal) {
		this.codEstadoActualizaSolicitudNormal = codEstadoActualizaSolicitudNormal;
	}

	public String getCodModuloGestionScoring() {
		return codModuloGestionScoring;
	}

	public void setCodModuloGestionScoring(String codModuloGestionScoring) {
		this.codModuloGestionScoring = codModuloGestionScoring;
	}

	public String getCodModuloOrigen() {
		return codModuloOrigen;
	}

	public void setCodModuloOrigen(String codModuloOrigen) {
		this.codModuloOrigen = codModuloOrigen;
	}

	public String getClasificacion() {
		return resultadoScoreClienteDTO.getClasificacion();
	}

	public String getPunteo() {
		return resultadoScoreClienteDTO.getPunteo();
	}

	public String getReferencia() {
		return resultadoScoreClienteDTO.getReferencia();
	}

}
