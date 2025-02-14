package com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteCobroAdentadoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.LimiteLineasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.LineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MorosidadClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionLineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroDTO;

public interface ClienteDAOIT {

	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CustomerException; 	
	
	public RetornoDTO actualizaCantAboCliente(ClienteDTO cliente) throws CustomerException;
	
	public CargoClienteDTO obtenerCargoBasicoActual(CargoClienteDTO cliente) throws CustomerException;
	
	public RetornoDTO validarTipoPlanCliente(ClienteDTO cliente) throws CustomerException;
	
	public ClienteDTO obtenerDatosPorVenta(VentaDTO venta) throws CustomerException; 
	
	public ClienteListDTO buscarCliente(NumeroDTO numero) throws CustomerException;
	
	public ClienteListDTO buscarCliente(ClienteDTO cliente) throws CustomerException;
	
	public ClienteDTO validarCliente(ClienteDTO cliente) throws CustomerException;

	public ClienteDTO obtenerCategoriaTributaria(ClienteDTO cliente) throws CustomerException;
	
	public ClienteDTO getCliente(ClienteDTO cliente) throws CustomerException;
	
	public String getcodValorCliente (String codCliente)throws CustomerException;
	
	public ClienteDTO obtenerValorCalculado(ClienteDTO cliente) throws CustomerException;
	 
	public LineasClienteDTO obtenerCantidadLineasCliente(LineasClienteDTO cliente) throws CustomerException;
	
	public MorosidadClienteDTO obtenerMorosidadCliente(MorosidadClienteDTO cliente) throws CustomerException;
	
	public LimiteLineasDTO obtenerLimiteLineas(ObtencionLineasClienteDTO cliente) throws CustomerException;
	
	public RetornoDTO insertarCobroAdelantado(ClienteCobroAdentadoDTO clienteCobroAdelantadoDTO) throws CustomerException; 

}

