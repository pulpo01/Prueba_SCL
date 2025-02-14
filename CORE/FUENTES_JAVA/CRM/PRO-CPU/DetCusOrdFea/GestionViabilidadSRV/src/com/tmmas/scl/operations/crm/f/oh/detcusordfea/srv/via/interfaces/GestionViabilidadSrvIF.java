package com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.via.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosVentaOutDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.common.exception.DetCusOrdFeaException;

public interface GestionViabilidadSrvIF {

	public RetornoDTO actualizaCantAboCliente(ClienteDTO cliente) throws DetCusOrdFeaException;
	
	public CicloDTO obtenerFechaCiclo(CicloDTO ciclo) throws DetCusOrdFeaException;
	
	public RetornoDTO validaRestriccionComerOoss(RestriccionesDTO restricciones) throws DetCusOrdFeaException;
	
	public RetornoDTO validaFreedom(ClienteDTO cliente) throws DetCusOrdFeaException;
	
	public ValidaOOSSDTO validaOossPendPlan(ValidaOOSSDTO ordenServicio) throws DetCusOrdFeaException;
	
	public RetornoDTO validarPeriodoFact(AbonadoDTO abonado) throws DetCusOrdFeaException;
	
	public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO registro)throws DetCusOrdFeaException;

	public RegistroFacturacionDTO getDiasProrrateo(RegistroFacturacionDTO registro)throws DetCusOrdFeaException;
	
	public RetornoDTO ejecutaPLRestricciones(RestriccionesDTO restricciones)throws DetCusOrdFeaException;
	
	public String getCodigoOperadora()throws DetCusOrdFeaException;
	
	public DatosVentaOutDTO getCodOficinaXVendedor(DatosVentaOutDTO entrada) throws DetCusOrdFeaException;
}
