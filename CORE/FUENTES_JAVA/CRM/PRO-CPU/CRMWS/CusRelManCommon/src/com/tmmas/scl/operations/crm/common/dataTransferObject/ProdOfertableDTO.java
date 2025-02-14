package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;

public class ProdOfertableDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codProdOfer;
	private String desProd;
	private String tipoComportamiento;
	private CargoListDTO cargoListDTO;
	private LimiteConsumoPlanAdicionalListDTO limiteConsumoPlanAdicionalListDTO;  
	
	
	public String getCodProdOfer() {
		return codProdOfer;
	}
	public void setCodProdOfer(String codProdOfer) {
		this.codProdOfer = codProdOfer;
	}
	public String getDesProd() {
		return desProd;
	}
	public void setDesProd(String desProd) {
		this.desProd = desProd;
	}
	
	public CargoListDTO getCargoListDTO() {
		return cargoListDTO;
	}
	public void setCargoListDTO(CargoListDTO cargoListDTO) {
		this.cargoListDTO = cargoListDTO;
	}
	public LimiteConsumoPlanAdicionalListDTO getLimiteConsumoPlanAdicionalListDTO() {
		return limiteConsumoPlanAdicionalListDTO;
	}
	public void setLimiteConsumoPlanAdicionalListDTO(
			LimiteConsumoPlanAdicionalListDTO limiteConsumoPlanAdicionalListDTO) {
		this.limiteConsumoPlanAdicionalListDTO = limiteConsumoPlanAdicionalListDTO;
	}
	public String getTipoComportamiento() {
		return tipoComportamiento;
	}
	public void setTipoComportamiento(String tipoComportamiento) {
		this.tipoComportamiento = tipoComportamiento;
	}
	
	

}
