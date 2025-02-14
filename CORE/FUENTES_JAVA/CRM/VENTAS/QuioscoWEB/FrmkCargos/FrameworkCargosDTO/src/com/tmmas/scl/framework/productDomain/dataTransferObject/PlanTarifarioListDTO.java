package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class PlanTarifarioListDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private PlanTarifarioDTO[] planesPrepago;
	private PlanTarifarioDTO[] planesPospago;
	private PlanTarifarioDTO[] planesHibrido;
	private PlanTarifarioDTO[] planesPospagoRango;
	
	public PlanTarifarioDTO[] getPlanesHibrido() {
		return planesHibrido;
	}
	public void setPlanesHibrido(PlanTarifarioDTO[] planesHibrido) {
		this.planesHibrido = planesHibrido;
	}
	public PlanTarifarioDTO[] getPlanesPospago() {
		return planesPospago;
	}
	public void setPlanesPospago(PlanTarifarioDTO[] planesPospago) {
		this.planesPospago = planesPospago;
	}
	public PlanTarifarioDTO[] getPlanesPrepago() {
		return planesPrepago;
	}
	public void setPlanesPrepago(PlanTarifarioDTO[] planesPrepago) {
		this.planesPrepago = planesPrepago;
	}
	public PlanTarifarioDTO[] getPlanesPospagoRango() {
		return planesPospagoRango;
	}
	public void setPlanesPospagoRango(PlanTarifarioDTO[] planesPospagoRango) {
		this.planesPospagoRango = planesPospagoRango;
	}
	
	
	
}
