package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CausaExcepcionListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConvertActAboDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DireccionOficinaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PenalizacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PlanBatchDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RangoAntiguedadDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ServCuentaSegDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.TipIdentListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerOrderException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ServicioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;

public interface OrdenServicioIT {
	
	public RetornoDTO registraNivelOoss(RegistroNivelOOSSDTO registro) throws CustomerOrderException;	

	public RetornoDTO registraCambPlanBatch(PlanBatchDTO param) throws CustomerOrderException;
	
	public CausaExcepcionListDTO obtenerCausaExcepcion() throws CustomerOrderException;
	
	public RetornoDTO validaRestriccionComerOoss(RestriccionesDTO restricciones) throws CustomerOrderException;
	
	public IOOSSDTO anulaOossPendPlan(IOOSSDTO ordenServicio) throws CustomerOrderException;
	
	public ValidaOOSSDTO validaOossPendPlan(ValidaOOSSDTO ordenServicio) throws CustomerOrderException;

	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws CustomerOrderException;
	
	public ConversionListDTO obtenerConversionOOSS(ConversionDTO param) throws CustomerOrderException;
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws CustomerOrderException;
	
	public ParametroDTO obtenerParametrosSimples(ParametroDTO param) throws CustomerOrderException;
	
	public TipIdentListDTO obtenerTiposDeIdentidad()  throws CustomerOrderException;
	
	public RetornoDTO actualizarComentPvIorserv(IOOSSDTO os) throws CustomerOrderException;
	
	public RetornoDTO validarPortabilidad(AbonadoDTO abonado) throws CustomerOrderException;
	
	public ConvertActAboDTO obtenerConverActAbo(ConvertActAboDTO param) throws CustomerOrderException;
	
	public RetornoDTO validarServiciosDuplicados(AbonadoDTO param) throws CustomerOrderException;
	
	public RetornoDTO bajaSSPrepago(AbonadoDTO param) throws CustomerOrderException;
	
	public RetornoDTO bajaRegTarif(AbonadoDTO param) throws CustomerOrderException;
	
	public ServicioDTO obtenerGrupoNivelContratado(AbonadoDTO param) throws CustomerOrderException;
	
	public RetornoDTO insertarTransacabo(SecuenciaDTO secuencia) throws CustomerOrderException;
	
	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO registro) throws CustomerOrderException;
	
	public RetornoDTO actualizaRenova(RegistrarRenovaDTO registro) throws CustomerOrderException ;  //INI P-MIX-09003 OCB
	
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws CustomerOrderException;	
	
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor) throws CustomerOrderException;
	
	public PenalizacionDTO obtenerPenalizacion(PenalizacionDTO penalizacion) throws CustomerOrderException;
	
	public RangoAntiguedadDTO obtenerRangoAntiguedad(RangoAntiguedadDTO param) throws CustomerOrderException;
	
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws CustomerOrderException;
	
	public DireccionOficinaDTO obtenerDireccionOficina(String codOficina) throws CustomerOrderException;
	
	public Integer obtenerVendedorRaiz(Integer codVendedor) throws CustomerOrderException;
	
	public String obtenerOperadora(Long codCliente) throws CustomerOrderException;
	
	public ServCuentaSegDTO tratarServCtaSeg(ServCuentaSegDTO param) throws CustomerOrderException;
	
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws CustomerOrderException;
	
	public RetornoDTO registrarMovControlada(AbonadoDTO abonado) throws CustomerOrderException;
	
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws CustomerOrderException;
	
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws CustomerOrderException;
	
	public boolean registrarCarta(CartaGeneralDTO dto, long numOS) throws CustomerOrderException;
}
