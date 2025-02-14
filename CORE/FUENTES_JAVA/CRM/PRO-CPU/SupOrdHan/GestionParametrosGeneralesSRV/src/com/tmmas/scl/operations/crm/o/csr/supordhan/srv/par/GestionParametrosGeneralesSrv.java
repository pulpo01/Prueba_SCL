package com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.GeSegUsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.GeSegUsuarioListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.VendedorBOFactory;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.VendedorBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.VendedorIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.TipIdentListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.exception.CustomerOrderException;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.SegmentacionBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.SegmentacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.SegmentacionBOIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par.interfaces.GestionParametrosGeneralesSrvIF;

public class GestionParametrosGeneralesSrv implements GestionParametrosGeneralesSrvIF {

	private final Logger logger = Logger.getLogger(GestionParametrosGeneralesSrv.class);
	private Global global = Global.getInstance();
	
	private OrdenServicioBOFactoryIT factoryBO1 = new OrdenServicioBOFactory();
	private OrdenServicioIT ordenServicioBO = factoryBO1.getBusinessObject1();
	
	private VendedorBOFactoryIT vendFactory=new VendedorBOFactory();
	private VendedorIT vendedorBO = vendFactory.getBusinessObject1();
	
	private SegmentacionBOFactoryIT segFactory= new SegmentacionBOFactory();
	private SegmentacionBOIT segmentacion =segFactory.getBusinessObject1();
	
	public GestionParametrosGeneralesSrv(){
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
	
	public ConversionListDTO obtenerConversionOOSS(ConversionDTO param)
			throws SupOrdHanException {
		ConversionListDTO respuesta = null;
		try {
			
			logger.debug("obtenerConversionOOSS():start");
			respuesta = ordenServicioBO.obtenerConversionOOSS(param);
			logger.debug("obtenerConversionOOSS():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;	
	}

	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws SupOrdHanException{
		SecuenciaDTO respuesta = null;
		try {
			logger.debug("obtenerSecuencia():start");
			respuesta = ordenServicioBO.obtenerSecuencia(secuencia);
			logger.debug("obtenerSecuencia():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;			
	}
	
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws SupOrdHanException{
		ParametroDTO respuesta = null;
		try {
			logger.debug("obtenerParametroGeneral():start");
			respuesta = ordenServicioBO.obtenerParametroGeneral(param);
			logger.debug("obtenerParametroGeneral():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;		
	}
	
	public ParametroDTO obtenerParametrosSimples(ParametroDTO param) throws SupOrdHanException{
		ParametroDTO respuesta = null;
		try {
			logger.debug("obtenerParametrosSimples():start");
			respuesta = ordenServicioBO.obtenerParametrosSimples(param);
			logger.debug("obtenerParametrosSimples():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;			
	}

	public TipIdentListDTO obtenerTiposDeIdentidad() throws SupOrdHanException {
		TipIdentListDTO respuesta = null;
		try {
			logger.debug("obtenerParametrosSimples():start");
			respuesta = ordenServicioBO.obtenerTiposDeIdentidad();
			logger.debug("obtenerParametrosSimples():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;	
	}
	
	public RetornoDTO actualizarComentPvIorserv(IOOSSDTO os) throws SupOrdHanException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("actualizarComentPvIorserv():start");
			respuesta = ordenServicioBO.actualizarComentPvIorserv(os);
			logger.debug("actualizarComentPvIorserv():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;			
	}
	
	public RetornoDTO validarPortabilidad(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("validarPortabilidad():start");
			respuesta = ordenServicioBO.validarPortabilidad(abonado);
			logger.debug("validarPortabilidad():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;			
	}
	
	public ParametroListDTO obtenerParametrosGenerales() throws SupOrdHanException{
		ParametroListDTO parametrosList = null;
		ParametroDTO[] parametros = new ParametroDTO[8];
		try {
			logger.debug("obtenerParametrosGenerales():start");
			
			String moduloGA =  global.getValor("codigo.modulo.GA");
			String codProducto = global.getValor("codigo.producto");
			
			ParametroDTO parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGA);
			parametro.setCodProducto(Integer.parseInt(codProducto));
			
			parametro.setNomParametro("APLICA_TRASP_SS_OPC");   ////???????
			parametros[0] = ordenServicioBO.obtenerParametrosSimples(parametro);
			 
			parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGA);
			parametro.setCodProducto(Integer.parseInt(codProducto));
			parametro.setNomParametro("APLICA_ATLANTIDA");
			parametros[1] = ordenServicioBO.obtenerParametrosSimples(parametro);

			parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGA);
			parametro.setCodProducto(Integer.parseInt(codProducto));
			parametro.setNomParametro("EST_RESPCENTRAL");
			parametros[2] = ordenServicioBO.obtenerParametroGeneral(parametro);
			
			parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGA);
			parametro.setCodProducto(Integer.parseInt(codProducto));
			parametro.setNomParametro("MAX_INTENTOS");
			parametros[3] = ordenServicioBO.obtenerParametroGeneral(parametro);

			parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGA);
			parametro.setCodProducto(Integer.parseInt(codProducto));
			parametro.setNomParametro("COD_CAT_CTA_SEG_NUE");
			parametros[4] = ordenServicioBO.obtenerParametroGeneral(parametro);
			
			parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGA);
			parametro.setCodProducto(Integer.parseInt(codProducto));
			parametro.setNomParametro("MODULO_ESPECIAL");
			parametros[5] = ordenServicioBO.obtenerParametrosSimples(parametro);

			parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGA);
			parametro.setCodProducto(Integer.parseInt(codProducto));
			parametro.setNomParametro("MIN_OPTARAMISTAR");
			parametros[6] = ordenServicioBO.obtenerParametroGeneral(parametro);
			
			parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGA);
			parametro.setCodProducto(Integer.parseInt(codProducto));
			parametro.setNomParametro("COD_OPTAAMISTAR");
			parametros[7] = ordenServicioBO.obtenerParametroGeneral(parametro);			
			
			parametrosList = new ParametroListDTO();
			parametrosList.setParametros(parametros);		
			
			logger.debug("obtenerParametrosGenerales():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return parametrosList;	
		
	}
	
	public GeSegUsuarioListDTO obtenerUsuariosPorCodVendedorNumVenta(AbonadoDTO abonadoDTO) throws SupOrdHanException {
		GeSegUsuarioListDTO retValue = null;
		try {
			logger.debug("obtenerUsuariosPorCodVendedor():start");
			retValue = vendedorBO.getListUsuariosPorCodVendedor(abonadoDTO);
			logger.debug("obtenerUsuariosPorCodVendedor():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retValue;	
	}
	
	
	public GedCodigosListDTO obtenerListaGedCodigos(GedCodigosDTO gedCodigosDTO) throws SupOrdHanException{
		GedCodigosListDTO retValue = null;
		try {
			logger.debug("obtenerListaGedCodigos():start");
			retValue = segmentacion.obtenerListaGedCodigos(gedCodigosDTO);
			logger.debug("obtenerListaGedCodigos():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retValue;
	}
	
	public GeSegUsuarioListDTO obtenerUsuariosPorCodVendedorNumVenta(GeSegUsuarioDTO geSegUsuarioDTO) throws SupOrdHanException {
		GeSegUsuarioListDTO retValue = null;
		try {
			logger.debug("obtenerUsuariosPorCodVendedor():start");
			retValue = vendedorBO.getListUsuariosPorCodVendedor(geSegUsuarioDTO);
			logger.debug("obtenerUsuariosPorCodVendedor():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retValue;	
	}
	
	public RetornoDTO getUsuariosPorNumVenta(String numVenta) throws SupOrdHanException {
		RetornoDTO retValue = null;
		try {
			logger.debug("getUsuariosPorNumVenta():start");
			retValue = vendedorBO.getUsuariosPorNumVenta(numVenta);
			logger.debug("getUsuariosPorNumVenta():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retValue;	
	}
	
}

