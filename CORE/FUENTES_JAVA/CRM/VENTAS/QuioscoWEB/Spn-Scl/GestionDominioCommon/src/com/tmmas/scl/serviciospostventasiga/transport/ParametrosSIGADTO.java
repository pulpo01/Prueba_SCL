package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class ParametrosSIGADTO extends MigracionPrepagoPostpagoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int indFacturNum;
	private String bodegaDef;
	private String codModVenta;
	private String codArtSim;
	private String desArtSim;
	private String causaBaja;
	private String codTipContrato;
	private int codIndemnizacion;
	private String codPlanServ;
	private String carga;
//	private Long numAbonado;
	

	public String getCarga() {
		return carga;
	}

	public void setCarga(String carga) {
		this.carga = carga;
	}

	public String getCodPlanServ() {
		return codPlanServ;
	}

	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}

	public int getCodIndemnizacion() {
		return codIndemnizacion;
	}

	public void setCodIndemnizacion(int codIndemnizacion) {
		this.codIndemnizacion = codIndemnizacion;
	}

	public String getCodTipContrato() {
		return codTipContrato;
	}

	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}

	public int getIndFacturNum() {
		return indFacturNum;
	}

	public void setIndFacturNum(int indFacturNum) {
		this.indFacturNum = indFacturNum;
	}

	public String getBodegaDef() {
		return bodegaDef;
	}

	public void setBodegaDef(String bodegaDef) {
		this.bodegaDef = bodegaDef;
	}

	public String getCausaBaja() {
		return causaBaja;
	}

	public void setCausaBaja(String causaBaja) {
		this.causaBaja = causaBaja;
	}

	public String getCodArtSim() {
		return codArtSim;
	}

	public void setCodArtSim(String codArtSim) {
		this.codArtSim = codArtSim;
	}

	public String getCodModVenta() {
		return codModVenta;
	}

	public void setCodModVenta(String codModVenta) {
		this.codModVenta = codModVenta;
	}

	public String getDesArtSim() {
		return desArtSim;
	}

	public void setDesArtSim(String desArtSim) {
		this.desArtSim = desArtSim;
	}
}
