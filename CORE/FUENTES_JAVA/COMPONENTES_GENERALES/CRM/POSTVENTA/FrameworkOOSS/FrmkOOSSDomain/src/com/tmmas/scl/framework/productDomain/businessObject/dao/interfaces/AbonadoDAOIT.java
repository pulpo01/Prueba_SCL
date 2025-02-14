package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ConsultaHibridoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GaAbocelDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ObtencionRolUsuarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ValidaPermanenciaDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface AbonadoDAOIT {
	
	public ObtencionRolUsuarioDTO obtenerRolUsuario(ObtencionRolUsuarioDTO obtRol) throws ProductException;
	
	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente) throws ProductException;

	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws ProductException;
	
	public RetornoDTO actualizaIntarcelAcciones(IntarcelDTO intarcel) throws ProductException;	
	
	public RetornoDTO registraElimActIntarcel(IntarcelDTO intarcel) throws ProductException;
	
	public RetornoDTO actualizaSituaAbo(AbonadoDTO abonado) throws ProductException;
	
	public RetornoDTO eliminaCuentaPersonal(CuentaPersonalDTO cuenta) throws ProductException;
	
	public RetornoDTO reservaAmist(CuentaPersonalDTO cuenta) throws ProductException;	
	
	public RetornoDTO validaPermanencia(ValidaPermanenciaDTO param) throws ProductException;	
	
	public AbonadoListDTO obtenerAbonadosPorVenta(VentaDTO venta) throws ProductException;	
	
	public RetornoDTO consultaHibrido(ConsultaHibridoDTO consulta) throws ProductException;
	
	public RetornoDTO actualizarAboCtaSeg(GaAbocelDTO abonado) throws ProductException;	
	
	public RetornoDTO migrarAbonado(GaAbocelDTO abonado) throws ProductException;
	
	public GaAbocelDTO obtenerFecCumPlan(GaAbocelDTO abonado) throws ProductException;
	
	public RetornoDTO actualizarSituPerfil(AbonadoDTO abonado) throws ProductException;
	
	public AbonadoDTO obtenerNumeroMovimientoAlta(AbonadoDTO abonado) throws ProductException;
	
	public IntarcelDTO obtenerFecDesdeCtaSeg(IntarcelDTO intarcel) throws ProductException;
	   
	
}
