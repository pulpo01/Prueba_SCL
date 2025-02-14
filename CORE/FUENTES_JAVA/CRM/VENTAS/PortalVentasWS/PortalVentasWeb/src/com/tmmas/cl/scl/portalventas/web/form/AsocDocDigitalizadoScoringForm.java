package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DocDigitalizadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DominioScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;

public class AsocDocDigitalizadoScoringForm extends ActionForm {

	private static final long serialVersionUID = 2504993289983476633L;

	private DocDigitalizadoScoringDTO[] arrayDocDigitalizadoScoring;

	private DominioScoringDTO[] arrayTipoDocumento;

	private String extensionesValidas;

	private int maximoTamanoBytes = 0;

	private String mensajeAccion;

	private String ruta;

	private FormFile archivoFormFile;

	private String observacion;

	private ScoreClienteDTO scoreClienteDTO;

	private EstadoScoringDTO estadoActualDTO;

	public String getDesEstadoActual() {
		return estadoActualDTO.getDesEstado();
	}

	private String numCorrelativo;

	public String getNumCorrelativo() {
		return numCorrelativo;
	}

	public void setNumCorrelativo(String numCorrelativo) {
		this.numCorrelativo = numCorrelativo;
	}

	public DocDigitalizadoScoringDTO[] getArrayDocDigitalizadoScoring() {
		return arrayDocDigitalizadoScoring;
	}

	public DominioScoringDTO[] getArrayTipoDocumento() {
		return arrayTipoDocumento;
	}

	public String getExtensionesValidas() {
		return extensionesValidas;
	}

	public int getMaximoTamanoBytes() {
		return maximoTamanoBytes;
	}

	public String getMaximoTamanoMBytes() {
		return new Double(new Double(maximoTamanoBytes).doubleValue() / 1024 / 1024).toString();
	}

	public String getMensajeAccion() {
		return mensajeAccion;
	}

	public long getNumSolScoring() {
		return this.scoreClienteDTO.getNumSolScoring();
	}

	public String getRuta() {
		return ruta;
	}

	public ScoreClienteDTO getScoreClienteDTO() {
		return scoreClienteDTO;
	}

	public void setArrayDocDigitalizadoScoring(DocDigitalizadoScoringDTO[] arrayDocDigitalizadoScoring) {
		this.arrayDocDigitalizadoScoring = arrayDocDigitalizadoScoring;
	}

	public void setArrayTipoDocumento(DominioScoringDTO[] arrayTipoDocumento) {
		this.arrayTipoDocumento = arrayTipoDocumento;
	}

	public void setExtensionesValidas(String extensionesValidas) {
		this.extensionesValidas = extensionesValidas;
	}

	public void setMaximoTamanoBytes(int maximoTamanoBytes) {
		this.maximoTamanoBytes = maximoTamanoBytes;
	}

	public void setMensajeAccion(String mensaje) {
		this.mensajeAccion = mensaje;
	}

	public void setRuta(String ruta) {
		this.ruta = ruta;
	}

	public void setScoreClienteDTO(ScoreClienteDTO scoreClienteDTO) {
		this.scoreClienteDTO = scoreClienteDTO;
		this.estadoActualDTO = scoreClienteDTO.getEstadoActualDTO();
	}

	public FormFile getArchivoFormFile() {
		return archivoFormFile;
	}

	public void setArchivoFormFile(FormFile archivoFormFile) {
		this.archivoFormFile = archivoFormFile;
	}

	public String getObservacion() {
		return observacion;
	}

	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}

}
