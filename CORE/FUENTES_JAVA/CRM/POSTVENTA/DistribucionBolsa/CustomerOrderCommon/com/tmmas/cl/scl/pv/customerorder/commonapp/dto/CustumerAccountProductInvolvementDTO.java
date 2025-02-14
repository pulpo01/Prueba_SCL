package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class CustumerAccountProductInvolvementDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
		private Integer code;
		private Integer cellularNumber;
		private Integer assignedMinutes;
		private Integer minutesToAssign;
		private Integer freePercentage ;
		
		
		public Integer getAssignedMinutes() {
			return assignedMinutes;
		}
		public void setAssignedMinutes(Integer assignedMinutes) {
			this.assignedMinutes = assignedMinutes;
		}
		public Integer getCellularNumber() {
			return cellularNumber;
		}
		public void setCellularNumber(Integer cellularNumber) {
			this.cellularNumber = cellularNumber;
		}
		public Integer getCode() {
			return code;
		}
		public void setCode(Integer code) {
			this.code = code;
		}
		public Integer getFreePercentage() {
			return freePercentage;
		}
		public void setFreePercentage(Integer freePercentage) {
			this.freePercentage = freePercentage;
		}
		public Integer getMinutesToAssign() {
			return minutesToAssign;
		}
		public void setMinutesToAssign(Integer minutesToAssign) {
			this.minutesToAssign = minutesToAssign;
		}
		
		
				
}	
