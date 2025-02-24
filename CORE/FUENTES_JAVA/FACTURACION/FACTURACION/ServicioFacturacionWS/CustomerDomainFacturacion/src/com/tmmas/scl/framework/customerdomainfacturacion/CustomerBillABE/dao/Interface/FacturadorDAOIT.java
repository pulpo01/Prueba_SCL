//
//
//  Generated by StarUML(tm) Java Add-In
//
//  @ Project : P-TMM-08004
//  @ File Name : FacturadorDAOIT.java
//  @ Date : 09/09/2008
//  @ Author : hsegura
//
//

package com.tmmas.scl.framework.customerdomainfacturacion.CustomerBillABE.dao.Interface;

import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.CargoDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.EjecutarFacturaDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.FacturaMiscelaneaEntradaDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.ProcesoDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.RegistrarCargoDTO;
import com.tmmas.scl.framework.CustomerDomain.exception.RateUsageRecordsException;

public interface FacturadorDAOIT {
	public void obtenerSecuenciaFactura();

	public void obtenerCodigoDocumento();

	public boolean validarTipoDocumento(String modalidadCobro)
			throws RateUsageRecordsException;

	public boolean validarModalidadCobro(String modalidadCobro)
			throws RateUsageRecordsException;

	public boolean validarMoneda(String moneda)
			throws RateUsageRecordsException;

	public boolean validarConcepto(String codConcepto, String tipoConcepto)
			throws RateUsageRecordsException;

	public boolean validarConceptoAfecto(String codConcepto,
			String catImpositiva, String codZonaImpositiva,String fechaSistema)
			throws RateUsageRecordsException;

	public boolean validarConceptoDescuento(String codConceptoCargo,
			String codConceptoDescuento) throws RateUsageRecordsException;

	public boolean registrarCargo(RegistrarCargoDTO registrarCargoDTO)
			throws RateUsageRecordsException;

	public boolean ejecutarFactura(
			EjecutarFacturaDTO ejecutarFacturaDTO)
			throws RateUsageRecordsException;
	public  boolean registrarProceso(ProcesoDTO procesoDTO)	throws RateUsageRecordsException; 
}
