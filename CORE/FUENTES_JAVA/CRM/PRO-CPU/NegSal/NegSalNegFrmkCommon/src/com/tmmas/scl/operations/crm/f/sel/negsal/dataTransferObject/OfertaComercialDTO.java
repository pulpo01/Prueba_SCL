package com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PaqueteContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.PerfilProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.ProductoTasacionContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;

public class OfertaComercialDTO implements Serializable 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	private String numProceso;
	private String origenProceso;
	private String numEvento;
	private PaqueteContratadoListDTO paqueteList;
	private ProductoContratadoListDTO productoList;
	private CargoRecurrenteListDTO cargoRecurrenteList;
	private CargoOcasionalListDTO cargoOcasionalList;
	private ProductoTasacionContratadoListDTO listaProductoTasCon;
	private PerfilProvisionamientoListDTO listaPerfilProv;
	private LimiteConsumoPlanAdicionalListDTO listaLimitesDeConsumo;
	private long codCliente;
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}
	public String getOrigenProceso() {
		return origenProceso;
	}
	public void setOrigenProceso(String origenProceso) {
		this.origenProceso = origenProceso;
	}
	public PaqueteContratadoListDTO getPaqueteList() {
		return paqueteList;
	}
	public void setPaqueteList(PaqueteContratadoListDTO paqueteList) {
		this.paqueteList = paqueteList;
	}
	public PerfilProvisionamientoListDTO getListaPerfilProv() {
		return listaPerfilProv;
	}
	public void setListaPerfilProv(PerfilProvisionamientoListDTO listaPerfilProv) {
		this.listaPerfilProv = listaPerfilProv;
	}
	public ProductoTasacionContratadoListDTO getListaProductoTasCon() {
		return listaProductoTasCon;
	}
	public void setListaProductoTasCon(
			ProductoTasacionContratadoListDTO listaProductoTasCon) {
		this.listaProductoTasCon = listaProductoTasCon;
	}
	public CargoRecurrenteListDTO getCargoRecurrenteList() {
		return cargoRecurrenteList;
	}
	public void setCargoRecurrenteList(CargoRecurrenteListDTO cargoRecurrenteList) {
		this.cargoRecurrenteList = cargoRecurrenteList;
	}
	public CargoOcasionalListDTO getCargoOcasionalList() {
		return cargoOcasionalList;
	}
	public void setCargoOcasionalList(CargoOcasionalListDTO cargoOcasionalList) {
		this.cargoOcasionalList = cargoOcasionalList;
	}
	public ProductoContratadoListDTO getProductoList() {
		return productoList;
	}
	public void setProductoList(ProductoContratadoListDTO productoList) {
		this.productoList = productoList;
	}
	public String getNumEvento() {
		return numEvento;
	}
	public void setNumEvento(String numEvento) {
		this.numEvento = numEvento;
	}
	public LimiteConsumoPlanAdicionalListDTO getListaLimitesDeConsumo() {
		return listaLimitesDeConsumo;
	}
	public void setListaLimitesDeConsumo(LimiteConsumoPlanAdicionalListDTO listaLimitesDeConsumo) {
		this.listaLimitesDeConsumo = listaLimitesDeConsumo;
	}
	
}
