/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class ProductDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String id;
	private String name;
	private String priority;
	private long idServSupl;
	private long codLevel;
	private String indicatorBagDiscount;
	private String codUpgradePhoneNumber;
	private String exceedId;
	private String descExceedId;
	private String profileId;
	private String descProfileId;
	private String codPlan;
	private boolean update = false;
	private boolean selected;
	private String type;
	
	public long getCodLevel() {
		return codLevel;
	}
	public void setCodLevel(long codLevel) {
		this.codLevel = codLevel;
	}
	public String getCodUpgradePhoneNumber() {
		return codUpgradePhoneNumber;
	}
	public void setCodUpgradePhoneNumber(String codUpgradePhoneNumber) {
		this.codUpgradePhoneNumber = codUpgradePhoneNumber;
	}
	public String getDescExceedId() {
		return descExceedId;
	}
	public void setDescExceedId(String descExceedId) {
		this.descExceedId = descExceedId;
	}
	public String getDescProfileId() {
		return descProfileId;
	}
	public void setDescProfileId(String descProfileId) {
		this.descProfileId = descProfileId;
	}
	public String getExceedId() {
		return exceedId;
	}
	public void setExceedId(String exceedId) {
		this.exceedId = exceedId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public long getIdServSupl() {
		return idServSupl;
	}
	public void setIdServSupl(long idServSupl) {
		this.idServSupl = idServSupl;
	}
	public String getIndicatorBagDiscount() {
		return indicatorBagDiscount;
	}
	public void setIndicatorBagDiscount(String indicatorBagDiscount) {
		this.indicatorBagDiscount = indicatorBagDiscount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getProfileId() {
		return profileId;
	}
	public void setProfileId(String profileId) {
		this.profileId = profileId;
	}
	public boolean isSelected() {
		return selected;
	}
	public void setSelected(boolean selected) {
		this.selected = selected;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public boolean isUpdate() {
		return update;
	}
	public void setUpdate(boolean update) {
		this.update = update;
	}
	public String getCodPlan() {
		return codPlan;
	}
	public void setCodPlan(String codPlan) {
		this.codPlan = codPlan;
	}
	
	
}
