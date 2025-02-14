package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.OrdenServicioDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.OrdenServicioDAOIT;
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

public class OrdenServicio implements OrdenServicioIT {

	private OrdenServicioDAOIT osDAO = new OrdenServicioDAO();
	
	private final Logger logger = Logger.getLogger(OrdenServicio.class);
	//private Global global = Global.getInstance();
	
	public RetornoDTO registraNivelOoss(RegistroNivelOOSSDTO registro)
			throws CustomerOrderException {
		
		RetornoDTO respuesta = null;
		try {
			logger.debug("registraNivelOoss():start");
			respuesta = osDAO.registraNivelOoss(registro);
			logger.debug("registraNivelOoss():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;	
	}

	public RetornoDTO registraCambPlanBatch(PlanBatchDTO param) throws CustomerOrderException{
	
		RetornoDTO respuesta = null;
		try {
			logger.debug("registraCambPlanBatch():start");
			respuesta = osDAO.registraCambPlanBatch(param);
			logger.debug("registraCambPlanBatch():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;			
	}
	
	public RetornoDTO validaRestriccionComerOoss(RestriccionesDTO restricciones) throws CustomerOrderException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("validaRestriccionComerOoss():start");
			respuesta = osDAO.validaRestriccionComerOoss(restricciones);
			logger.debug("validaRestriccionComerOoss():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;			
	}
	
	public IOOSSDTO anulaOossPendPlan(IOOSSDTO ordenServicio) throws CustomerOrderException{
		IOOSSDTO respuesta = null;
		try {
			logger.debug("anulaOossPendPlan():start");
			respuesta = osDAO.anulaOossPendPlan(ordenServicio);
			logger.debug("anulaOossPendPlan():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public ValidaOOSSDTO validaOossPendPlan(ValidaOOSSDTO ordenServicio) throws CustomerOrderException{
		ValidaOOSSDTO respuesta = null;
		try {
			logger.debug("validaOossPendPlan():start");
			respuesta = osDAO.validaOossPendPlan(ordenServicio);
			logger.debug("validaOossPendPlan():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;			
	}
	
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws CustomerOrderException{
		ParametroDTO respuesta = null;
		try {
			logger.debug("obtenerParametroGeneral():start");
			respuesta = osDAO.obtenerParametroGeneral(param);
			logger.debug("obtenerParametroGeneral():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;	
	}
	
	public ConversionListDTO obtenerConversionOOSS(ConversionDTO param) throws CustomerOrderException{	
		ConversionListDTO respuesta = null;
		try {
			logger.debug("obtenerConversionOOSS():start");
			respuesta = osDAO.obtenerConversionOOSS(param);
			logger.debug("obtenerConversionOOSS():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;	
	}
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws CustomerOrderException{
		SecuenciaDTO respuesta = null;
		try {
			logger.debug("obtenerSecuencia():start");
			respuesta = osDAO.obtenerSecuencia(secuencia);
			logger.debug("obtenerSecuencia():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;			
	}

	public ParametroDTO obtenerParametrosSimples(ParametroDTO param) throws CustomerOrderException{
		ParametroDTO respuesta = null;
		try {
			logger.debug("obtenerParametrosSimples():start");
			respuesta = osDAO.obtenerParametrosSimples(param);
			logger.debug("obtenerParametrosSimples():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;			
	}

	public TipIdentListDTO obtenerTiposDeIdentidad() throws CustomerOrderException {
		TipIdentListDTO respuesta = null;
		try {
			logger.debug("obtenerParametrosSimples():start");
			respuesta = osDAO.obtenerTiposDeIdentidad();
			logger.debug("obtenerParametrosSimples():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;
	}
	
	public RetornoDTO actualizarComentPvIorserv(IOOSSDTO os) throws CustomerOrderException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("actualizarComentPvIorserv():start");
			respuesta = osDAO.actualizarComentPvIorserv(os);
			logger.debug("actualizarComentPvIorserv():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public RetornoDTO validarPortabilidad(AbonadoDTO abonado) throws CustomerOrderException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("validarPortabilidad():start");
			respuesta = osDAO.validarPortabilidad(abonado);
			logger.debug("validarPortabilidad():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public ConvertActAboDTO obtenerConverActAbo(ConvertActAboDTO param) throws CustomerOrderException{
		ConvertActAboDTO respuesta = null;
		try {
			logger.debug("obtenerParametrosSimples():start");
			respuesta = osDAO.obtenerConverActAbo(param);
			logger.debug("obtenerParametrosSimples():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public RetornoDTO validarServiciosDuplicados(AbonadoDTO abonado) throws CustomerOrderException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("validarServiciosDuplicados():start");
			respuesta = osDAO.validarServiciosDuplicados(abonado);
			logger.debug("validarServiciosDuplicados():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public RetornoDTO bajaSSPrepago(AbonadoDTO abonado) throws CustomerOrderException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("bajaSSPrepago():start");
			respuesta = osDAO.bajaSSPrepago(abonado);
			logger.debug("bajaSSPrepago():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public RetornoDTO bajaRegTarif(AbonadoDTO abonado) throws CustomerOrderException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("bajaRegTarif():start");
			respuesta = osDAO.bajaRegTarif(abonado);
			logger.debug("bajaRegTarif():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public ServicioDTO obtenerGrupoNivelContratado(AbonadoDTO abonado) throws CustomerOrderException{
		ServicioDTO respuesta = null;
		try {
			logger.debug("obtenerGrupoNivelContratado():start");
			respuesta = osDAO.obtenerGrupoNivelContratado(abonado);
			logger.debug("obtenerGrupoNivelContratado():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public RetornoDTO insertarTransacabo(SecuenciaDTO secuencia) throws CustomerOrderException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("insertarTransacabo():start");
			respuesta = osDAO.insertarTransacabo(secuencia);
			logger.debug("insertarTransacabo():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;	
	}
	
	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO registro) throws CustomerOrderException {
		RetornoDTO respuesta = null;
		try {
			logger.debug("registrarOOSSEnLinea():start");
			respuesta = osDAO.registrarOOSSEnLinea(registro);
			logger.debug("registrarOOSSEnLinea():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;
	}
	
	// INI-P-MIX-09003 OCB
	public RetornoDTO actualizaRenova(RegistrarRenovaDTO param) throws CustomerOrderException{
	
		RetornoDTO respuesta = null;
		try {
			logger.debug("actualizaRenova():start");
			respuesta = osDAO.actualizaRenova(param);
			logger.debug("actualizaRenova():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;			
	}
	// FIN-P-MIX-09003 OCB
	
	public RangoAntiguedadDTO obtenerRangoAntiguedad(RangoAntiguedadDTO param) throws CustomerOrderException{
		RangoAntiguedadDTO respuesta = null;
		try {
			logger.debug("obtenerRangoAntiguedad():start");
			respuesta = osDAO.obtenerRangoAntiguedad(param);
			logger.debug("obtenerRangoAntiguedad():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws CustomerOrderException{
		UsuarioDTO respuesta = null;
		try {
			logger.debug("obtenerVendedor():start");
			respuesta = osDAO.obtenerVendedor(usuario);
			logger.debug("obtenerVendedor():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;			
	}
	
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor) throws CustomerOrderException{
		DescuentoVendedorDTO respuesta = null;
		try {
			logger.debug("obtenerDescuentoVendedor():start");
			respuesta = osDAO.obtenerDescuentoVendedor(vendedor);
			logger.debug("obtenerDescuentoVendedor():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;			
	}
	
	public PenalizacionDTO obtenerPenalizacion(PenalizacionDTO penalizacion) throws CustomerOrderException{
		PenalizacionDTO respuesta = null;
		try {
			logger.debug("obtenerPenalizacion():start");
			respuesta = osDAO.obtenerPenalizacion(penalizacion);
			logger.debug("obtenerPenalizacion():end");
		} catch (CustomerOrderException e){
			logger.debug("CustomerOrderException[", e);
			throw e;
		}	
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}
		return respuesta;
	}

	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws CustomerOrderException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("registrarVenta():start");
			respuesta = osDAO.registrarVenta(venta);
			logger.debug("registrarVenta():end");
		} catch (CustomerOrderException e){
			logger.debug("CustomerOrderException[", e);
			throw e;
		}	
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}
		return respuesta;
	}
	
	public DireccionOficinaDTO obtenerDireccionOficina(String codOficina) throws CustomerOrderException{
		DireccionOficinaDTO respuesta = null;
		try {
			logger.debug("obtenerDatosVenta():start");
			respuesta = osDAO.obtenerDireccionOficina(codOficina);
			logger.debug("obtenerDatosVenta():end");
		} catch (CustomerOrderException e){
			logger.debug("CustomerOrderException[", e);
			throw e;
		}	
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}
		return respuesta;		
	}
	
	public Integer obtenerVendedorRaiz(Integer codVendedor) throws CustomerOrderException{
		Integer respuesta = null;
		try {
			logger.debug("obtenerVendedorRaiz():start");
			respuesta = osDAO.obtenerVendedorRaiz(codVendedor);
			logger.debug("obtenerVendedorRaiz():end");
		} catch (CustomerOrderException e){
			logger.debug("CustomerOrderException[", e);
			throw e;
		}	
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}
		return respuesta;		
	}
	
	public String obtenerOperadora(Long codCliente) throws CustomerOrderException{
		String respuesta = null;
		try {
			logger.debug("obtenerOperadora():start");
			respuesta = osDAO.obtenerOperadora(codCliente);
			logger.debug("obtenerOperadora():end");
		} catch (CustomerOrderException e){
			logger.debug("CustomerOrderException[", e);
			throw e;
		}	
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}
		return respuesta;			
	}
	
	public ServCuentaSegDTO tratarServCtaSeg(ServCuentaSegDTO param) throws CustomerOrderException{
		ServCuentaSegDTO respuesta = null;
		try {
			logger.debug("tratarServCtaSeg():start");
			respuesta = osDAO.tratarServCtaSeg(param);
			logger.debug("tratarServCtaSeg():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws CustomerOrderException{
		ContratoDTO respuesta = null;
		try {
			logger.debug("obtenerTipoContrato():start");
			respuesta = osDAO.obtenerTipoContrato(contrato);
			logger.debug("obtenerTipoContrato():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;	
	}
	
	public RetornoDTO registrarMovControlada(AbonadoDTO abonado) throws CustomerOrderException{
		
		RetornoDTO respuesta = null;
		try {
			logger.debug("registrarMovControlada():start");
			respuesta = osDAO.registrarMovControlada(abonado);
			logger.debug("registrarMovControlada():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;			
	}
	
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws CustomerOrderException{
		ModalidadPagoDTO respuesta = null;
		try {
			logger.debug("obtenerModalidadPago():start");
			respuesta = osDAO.obtenerModalidadPago(modalidad);
			logger.debug("obtenerModalidadPago():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}
	
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws CustomerOrderException{
		VendedorDTO respuesta = null;
		try {
			logger.debug("obtenerVendedor():start");
			respuesta = osDAO.obtenerVendedor(vendedor);
			logger.debug("obtenerVendedor():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;		
	}

	public CausaExcepcionListDTO obtenerCausaExcepcion() throws CustomerOrderException {
		CausaExcepcionListDTO respuesta = null;
		try {
			logger.debug("obtenerCausaExcepcion():start");
			respuesta = osDAO.obtenerCausaExcepcion();
			logger.debug("obtenerCausaExcepcion():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;	
	}
	
	public boolean registrarCarta(CartaGeneralDTO dto, long numOS) throws CustomerOrderException {
		logger.info("registrarCarta(), inicio");
		boolean r = false;
		try {
			r = osDAO.registrarCarta(dto, numOS);
		} catch (CustomerOrderException e) {
			logger.error("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.error("Exception[", e);
			throw new CustomerOrderException(e);
		}
		logger.info("registrarCarta(), fin");
		return r;	
	}
}
