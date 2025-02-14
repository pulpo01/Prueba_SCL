/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.vo.ventaenlace;

import java.io.Serializable;

import com.tmmas.scl.wsventaenlace.transport.vo.AbonadoVO;

/**
 * 
 *
 */
public class VentaEnlaceE1VO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private AbonadoVO abonadoVO;
	private String enlaceFija;
	private String cenFija;	
	private String prefijoNumFija;	
	private Integer codServSuspension;	
	private boolean pilotoActivo;
	private String codActuacion; 
	
	public String getCodActuacion() {
		return codActuacion;
	}

	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}

	/**
	 * 
	 */
	public VentaEnlaceE1VO() {

	}

	public AbonadoVO getAbonadoVO() {
		return abonadoVO;
	}

	public void setAbonadoVO(AbonadoVO abonadoVO) {
		this.abonadoVO = abonadoVO;
	}

	public String getCenFija() {
		return cenFija;
	}

	public void setCenFija(String cenFija) {
		this.cenFija = cenFija;
	}

	public Integer getCodServSuspension() {
		return codServSuspension;
	}

	public void setCodServSuspension(Integer codServSuspension) {
		this.codServSuspension = codServSuspension;
	}

	public String getEnlaceFija() {
		return enlaceFija;
	}

	public void setEnlaceFija(String enlaceFija) {
		this.enlaceFija = enlaceFija;
	}

	public boolean isPilotoActivo() {
		return pilotoActivo;
	}

	public void setPilotoActivo(boolean pilotoActivo) {
		this.pilotoActivo = pilotoActivo;
	}

	public String getPrefijoNumFija() {
		return prefijoNumFija;
	}

	public void setPrefijoNumFija(String prefijoNumFija) {
		this.prefijoNumFija = prefijoNumFija;
	}	
}
