package com.tmmas.cl.scl.productdomain.businessobject.bo;

import java.util.Date;

public class Product {
	private String name;
	private String description;
	private String productStatus;
	private String productSerialNumber;
	private Date validFor;
	
	public Product(){
		
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProductSerialNumber() {
		return productSerialNumber;
	}

	public void setProductSerialNumber(String productSerialNumber) {
		this.productSerialNumber = productSerialNumber;
	}

	public String getProductStatus() {
		return productStatus;
	}

	public void setProductStatus(String productStatus) {
		this.productStatus = productStatus;
	}

	public Date getValidFor() {
		return validFor;
	}

	public void setValidFor(Date validFor) {
		this.validFor = validFor;
	}
	

}
