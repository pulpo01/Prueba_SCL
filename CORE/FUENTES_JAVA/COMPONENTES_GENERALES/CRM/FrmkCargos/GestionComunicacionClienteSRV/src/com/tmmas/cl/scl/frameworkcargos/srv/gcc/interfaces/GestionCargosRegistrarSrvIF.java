package com.tmmas.cl.scl.frameworkcargos.srv.gcc.interfaces;

import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosEjecucionFacturacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroCargosBatchDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;

public interface GestionCargosRegistrarSrvIF {
	
	//public ResultadoRegistroCargosDTO registrarCargos(ParametrosRegistroCargosDTO cargos)throws ProyectoException,FrameworkCargosException;
	
	public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO listadoCargos) throws FrmkCargosException;
	
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO resultadoObtenerCargos) throws FrmkCargosException;
	
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws FrmkCargosException;
	
	public RetornoDTO registraCargosBatch(RegistroCargosBatchDTO registro) throws FrmkCargosException;
	
	public void cierreVenta(GaVentasDTO gaVentasDTO) throws FrmkCargosException;
	
	public void actualizaFacturacion(ParametrosEjecucionFacturacionDTO parametrosEjecucion) throws FrmkCargosException;
}
