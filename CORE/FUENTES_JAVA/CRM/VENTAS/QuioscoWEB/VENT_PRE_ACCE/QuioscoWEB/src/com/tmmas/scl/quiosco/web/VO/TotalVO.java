package com.tmmas.scl.quiosco.web.VO;

import java.math.BigDecimal;

public class TotalVO {
	
	private BigDecimal subTotal;
	private BigDecimal itbm;
	private BigDecimal total;
	private BigDecimal isc;
	
	private BigDecimal iscRound;
	private BigDecimal itbmRound;
	private BigDecimal totalRound;
	private BigDecimal subTotalRound;
	
	
	public BigDecimal getIscRound() {
		return iscRound;
	}
	public void setIscRound(BigDecimal iscRound) {
		this.iscRound = iscRound;
	}
	public BigDecimal getItbmRound() {
		return itbmRound;
	}
	public void setItbmRound(BigDecimal itbmRound) {
		this.itbmRound = itbmRound;
	}
	public BigDecimal getSubTotal() {
		return subTotal;
	}
	public void setSubTotal(BigDecimal subTotal) {
		this.subTotal = subTotal;
	}
	public BigDecimal getItbm() {
		return itbm;
	}
	public void setItbm(BigDecimal itbm) {
		this.itbm = itbm;
	}
	public BigDecimal getTotal() {
		return total;
	}
	public void setTotal(BigDecimal total) {
		this.total = total;
	}
	public BigDecimal getIsc() {
		return isc;
	}
	public void setIsc(BigDecimal isc) {
		this.isc = isc;
	}
	public BigDecimal getTotalRound() {
		return totalRound;
	}
	public void setTotalRound(BigDecimal totalRound) {
		this.totalRound = totalRound;
	}
	public BigDecimal getSubTotalRound() {
		return subTotalRound;
	}
	public void setSubTotalRound(BigDecimal subTotalRound) {
		this.subTotalRound = subTotalRound;
	}
}
