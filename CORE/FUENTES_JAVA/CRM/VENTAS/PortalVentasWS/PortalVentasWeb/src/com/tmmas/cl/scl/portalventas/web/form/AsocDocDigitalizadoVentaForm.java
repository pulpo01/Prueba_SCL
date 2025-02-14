package com.tmmas.cl.scl.portalventas.web.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoDocDigitalizadoDTO;

public class AsocDocDigitalizadoVentaForm extends ActionForm {

	private static final long serialVersionUID = 2504993289983476633L;

	private FormFile archivoFormFile;

	private String ruta;

	private String codTipoDocDigitalizado;

	private String observacion;

	private long numVenta;

	private String extensionesValidas;

	private int maximoTamanoBytes = 0;

	private String mensajeAccion;

	private DocDigitalizadoDTO[] arrayDocDigitalizado;

	private TipoDocDigitalizadoDTO[] arrayTipoDocDigitalizado;

	public FormFile getArchivoFormFile() {
		return archivoFormFile;
	}

	public TipoDocDigitalizadoDTO[] getArrayTipoDocDigitalizado() {
		return arrayTipoDocDigitalizado;
	}

	public String getCodTipoDocDigitalizado() {
		return codTipoDocDigitalizado;
	}

	public long getNumVenta() {
		return numVenta;
	}

	public String getObservacion() {
		return observacion;
	}

	public String getRuta() {
		return ruta;
	}

	public void setArchivoFormFile(FormFile archivoFormFile) {
		this.archivoFormFile = archivoFormFile;
	}

	public void setArrayTipoDocDigitalizado(TipoDocDigitalizadoDTO[] arrayTipoDocumento) {
		this.arrayTipoDocDigitalizado = arrayTipoDocumento;
	}

	public void setCodTipoDocDigitalizado(String descTipoDocumento) {
		this.codTipoDocDigitalizado = descTipoDocumento;
	}

	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}

	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}

	public void setRuta(String ruta) {
		this.ruta = ruta;
	}

	public DocDigitalizadoDTO[] getArrayDocDigitalizado() {
		return arrayDocDigitalizado;
	}

	public void setArrayDocDigitalizado(DocDigitalizadoDTO[] arrayDocDigitalizado) {
		this.arrayDocDigitalizado = arrayDocDigitalizado;
	}

	public void reset(ActionMapping actionMapping, HttpServletRequest request) {
		super.reset(actionMapping, request);

		this.observacion = null;
		this.archivoFormFile = null;
	}

	public String getExtensionesValidas() {
		return extensionesValidas;
	}

	public void setExtensionesValidas(String extensionesValidas) {
		this.extensionesValidas = extensionesValidas;
	}

	public int getMaximoTamanoBytes() {
		return maximoTamanoBytes;
	}

	public void setMaximoTamanoBytes(int maximoTamanoBytes) {
		this.maximoTamanoBytes = maximoTamanoBytes;
	}

	public String getMensajeAccion() {
		return mensajeAccion;
	}

	public void setMensajeAccion(String mensaje) {
		this.mensajeAccion = mensaje;
	}

	public String getMensaje() {
		String r = null;
		if (getArrayDocDigitalizado() == null || getArrayDocDigitalizado().length == 0) {
			r = "No existen documentos.";
		}
		return r;
	}
}
