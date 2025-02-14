package com.tmmas.scl.frameworkooss.srv;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteCobroAdentadoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DireccionOficinaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.customerDomain.exception.CustomerOrderException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.EspecificacionProductoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SCLPlanBasicoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SCLPlanDescuentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.EspecificacionProductoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.EspecificacionProductoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SCLPlanBasicoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SCLPlanBasicoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SCLPlanDescuentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SCLPlanDescuentoIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.frameworkooss.srv.helper.Global;
import com.tmmas.scl.frameworkooss.srv.interfaces.FrmkOOSSSrvIF;

public class FrmkOOSSSrv implements FrmkOOSSSrvIF{
	private final Logger logger = Logger.getLogger(FrmkOOSSSrv.class);
	private Global global = Global.getInstance();
	
	private OrdenServicioBOFactoryIT factoryBO1 = new OrdenServicioBOFactory();
	private OrdenServicioIT ordenServicioBO1 = factoryBO1.getBusinessObject1();

	private CargoBOFactoryIT factoryBO8 = new CargoBOFactory();
	private CargoIT cargoBO = factoryBO8.getBusinessObject1();
	
	private OrdenServicioBOFactoryIT factoryBO2 = new OrdenServicioBOFactory();
	private OrdenServicioIT ordenServicioBO = factoryBO2.getBusinessObject1();

	private ClienteBOFactoryIT factoryBO3 = new ClienteBOFactory();
	private ClienteIT clienteBO = factoryBO3.getBusinessObject1();
	
	private SCLPlanBasicoBOFactoryIT factoryBO5 = new SCLPlanBasicoBOFactory();
	private SCLPlanBasicoIT planBO = factoryBO5.getBusinessObject1();
	
	private SCLPlanDescuentoBOFactoryIT factoryBO6 = new SCLPlanDescuentoBOFactory();
	private SCLPlanDescuentoIT planDescuentoBO = factoryBO6.getBusinessObject1();
	
	private EspecificacionProductoBOFactoryIT factoryBO4 = new EspecificacionProductoBOFactory();
	private EspecificacionProductoIT especificacionProductoBO = factoryBO4.getBusinessObject();
	
	private RegistroFacturacionBOFactoryIT factoryBO7 = new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT registroFacturacionBO = factoryBO7.getBusinessObject1();
	
	private AbonadoBOFactoryIT factoryBO9 = new AbonadoBOFactory();
	private AbonadoIT abonadoBO = factoryBO9.getBusinessObject1();	
	
	private com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteBOFactoryIT factoryBO10 = new com.tmmas.scl.framework.customerDomain.bo.ClienteBOFactory();
	private com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteIT clienteBO2 = factoryBO10.getBusinessObject1();
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws GeneralException {
		SecuenciaDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerSecuencia():start");
			respuesta = ordenServicioBO1.obtenerSecuencia(secuencia);
			logger.debug("obtenerSecuencia():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		return respuesta;	
	}
	
	
	public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO param) throws GeneralException{
		FormaPagoListDTO documentos = new FormaPagoListDTO();
		try{
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerFormasPago():start");
			
			int codProducto = Integer.parseInt(global.getValor("codigo.producto"));
			String codModulo = global.getValor("codigo.modulo.GA");
			String paramMostrarTipoPago = global.getValor("parametro.mostrartipopago");
			String paramCodigoOrdenCompra = global.getValor("parametro.codigoordencompra");
			
			//Obtencion parametro mostrar tipo de pago
			ParametroDTO parametro = new ParametroDTO();
			parametro.setCodProducto(codProducto);
			parametro.setCodModulo(codModulo);
			parametro.setNomParametro(paramMostrarTipoPago);
			parametro = ordenServicioBO.obtenerParametroGeneral(parametro);
		
			if (parametro.getValor().equalsIgnoreCase("1")){
				ParametroDTO parametroCodOrdCompra = new ParametroDTO();
				
		 		ClienteDTO cliente = new ClienteDTO();
		 		cliente.setCodCliente(param.getCodCliente()); //parametro de entrada
		 		
				// 1.- Ver si la venta tiene planes freedom asociados
				boolean existePlanFreedomEnVenta  = planBO.validaFreedom(cliente).isResultado();

				// 2.- Consultar la categoria tributaria del cliente (Factura F, o Boleta B)
		 		cliente =  clienteBO.obtenerCategoriaTributaria(cliente);
				
				// 3.- Obtener el parametro orden de compra. 
		 		parametroCodOrdCompra.setCodProducto(codProducto);
		 		parametroCodOrdCompra.setCodModulo(codModulo);
		 		parametroCodOrdCompra.setNomParametro(paramCodigoOrdenCompra);
		 		parametroCodOrdCompra = ordenServicioBO.obtenerParametroGeneral(parametroCodOrdCompra);

				// Obtencion de las formas de pago
		 		param.setExistePlanFreedom((existePlanFreedomEnVenta?"TRUE":"FALSE"));
		 		param.setCategoriaTributaria(cliente.getCodCategoria());
		 		param.setParamOrdenCompraValor(parametroCodOrdCompra.getValor());
		 		documentos = cargoBO.obtenerFormasPago(param);
			}
			
			logger.debug("obtenerFormasPago():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return documentos;	
	}
	
public DocumentoListDTO obtenerTiposDocumentos(BusquedaTiposDocumentoDTO param) throws GeneralException{
		
		DocumentoListDTO documentos = null;
		try{
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTiposDocumentos():start");
			param.setIndAgente(global.getValor("valor.columna.ind_agente"));
			param.setIndSituacion(global.getValor("valor.columna.ind_situacion"));
			param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
			param.setCodAmiCiclo(global.getValor("parametro.amiciclo"));
			param.setCodModulo(global.getValor("codigo.modulo.GA"));
			documentos = cargoBO.obtenerTiposDocumentos(param);
			logger.debug("obtenerTiposDocumentos():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return documentos;			
	}

public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws GeneralException{
	RetornoDTO respuesta = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("eliminarSolicitud():start");
		respuesta = planDescuentoBO.eliminarSolicitudDescuento(registro);
		logger.debug("eliminarSolicitud():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return respuesta;		
}
public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws GeneralException{
	RetornoDTO resultado = null;
	try{
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);

		logger.debug("Inicio:eliminarPresupuesto()");
		resultado = cargoBO.eliminarPresupuesto(registro);
		logger.debug("Fin:eliminarPresupuesto()");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}			
	return resultado;			
	
}

public CuotasProductoDTO[] obtenerCuotasProducto() throws GeneralException {
	String log = global.getValor("service.log");
	log = System.getProperty("user.dir") + log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerCuotasProducto():start");
	logger.debug("obtenerCuotasProducto():end");
	CuotasProductoDTO[] cuotasProducto = null;
	
		try {
			cuotasProducto = especificacionProductoBO.obtenerCuotasProducto();
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}

	
	return cuotasProducto;
}

public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws GeneralException{
	UsuarioDTO retorno = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerVendedor():start");
		retorno = ordenServicioBO.obtenerVendedor(usuario);
		logger.debug("obtenerVendedor():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return retorno;				
}

public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws GeneralException{
	CartaGeneralDTO retorno = null;
	String log = global.getValor("service.log");
	log = System.getProperty("user.dir") + log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerTextoCarta():start");
	try {
		retorno = especificacionProductoBO.obtenerTextoCarta(cartaGeneral);
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	logger.debug("obtenerTextoCarta():end");
	return retorno;
}

public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor) throws GeneralException{
	DescuentoVendedorDTO retorno = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDescuentoVendedor():start");
		retorno = ordenServicioBO.obtenerDescuentoVendedor(vendedor);
		logger.debug("obtenerDescuentoVendedor():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return retorno;			
}

/**
 * Registra una solicitud de aprobación de descuento en SCL
 * @param parametros
 * @return
 * @throws ProyectoException
 * @throws FrameworkCargosException
 */
public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro)throws GeneralException{
	RespuestaSolicitudDTO respuesta = new RespuestaSolicitudDTO();
	long lNumeroAutorizacion;
	long lNumAbonado = 0;
	
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("solicitarAprobacionDescuento():start");
		
		String sEstadoSolicitud = global.getValor("estado.solicitud.pendiente");
		String sCodigoMonedaSolicitud  = global.getValor("codigo.moneda.solicitud");
		String sCodigoOrigen = global.getValor("codigo.origen");
		String sNomSecuencia = global.getValor("secuencia.solicitud.autorizacion");
		int indModif = Integer.parseInt(global.getValor("indicador.modificacion.descuento"));
		
		SecuenciaDTO secuencia = new SecuenciaDTO();
		secuencia.setNomSecuencia(sNomSecuencia);
		secuencia = ordenServicioBO.obtenerSecuencia(secuencia);
		lNumeroAutorizacion = secuencia.getNumSecuencia();

		RegistroSolicitudDTO[] solicitudes = registro.getSolicitudes();
		for (int i=0; i<solicitudes.length;i++){
			solicitudes[i].setLinAutoriza(i+1);
			solicitudes[i].setCodigoEstado(sEstadoSolicitud);
			solicitudes[i].setNumeroAutorizacion(lNumeroAutorizacion);
			solicitudes[i].setCodigoMoneda(sCodigoMonedaSolicitud);
			solicitudes[i].setNumeroAbonado(lNumAbonado);
			solicitudes[i].setIndicadorModificacion(indModif);
			solicitudes[i].setCodigoOrigen(sCodigoOrigen);
			planDescuentoBO.crearSolicitud(solicitudes[i]);
		}
		respuesta.setNumeroAutorizacion(lNumeroAutorizacion);
		respuesta.setCodigoEstado(sEstadoSolicitud);
		
		logger.debug("solicitarAprobacionDescuento():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return respuesta;	
}

public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws GeneralException{
	RegistroSolicitudDTO respuesta = null;
	long lNumeroAutorizacion;
	long lNumAbonado = 0;
	
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("consultarEstadoSolicitud():start");
		String estadoPendiente = global.getValor("estado.solicitud.pendiente");
		String estadoAutorizada = global.getValor("estado.solicitud.autorizada");
		String estadoCancelada = global.getValor("estado.solicitud.cancelada");
		String glosaPendiente = global.getValor("desc.estado.solicitud.PD");
		String glosaAutorizada = global.getValor("desc.estado.solicitud.AU");
		String glosaCancelada = global.getValor("desc.estado.solicitud.CA");
		String glosaEstado = " ";
		
		respuesta = planDescuentoBO.consultarEstadoSolicitud(registro);
		if (registro.getCodigoEstado().equalsIgnoreCase(estadoPendiente))
			glosaEstado = glosaPendiente;
		else if (registro.getCodigoEstado().equalsIgnoreCase(estadoAutorizada))
			glosaEstado = glosaAutorizada;
		else if (registro.getCodigoEstado().equalsIgnoreCase(estadoCancelada))
			glosaEstado = glosaCancelada;
		
		respuesta.setDescripcionEstado(glosaEstado);
		
		logger.debug("consultarEstadoSolicitud():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return respuesta;			
}

public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws GeneralException{
	RetornoDTO respuesta = null;
	logger.debug("registrarVenta():start");
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		
		//parametros entrada :
		//numVenta
		//codCliente
		//usuario
		//codModVenta
		//codCuota
		//codTipDocum
		
		venta.setCodProducto(Integer.parseInt(global.getValor("codigo.producto"))); //codProducto
		Calendar cal=Calendar.getInstance();
		venta.setFecVenta(new Date(cal.getTimeInMillis())); //fecVenta
		venta.setNumUnidades(1); //numUnidades
		venta.setIndEstVenta(global.getValor("estado.venta.aceptada")); //indEstVenta
		venta.setIndTipVenta(1); //indTipVenta
		venta.setTipFoliacion(global.getValor("tipo.foliacion.autofoliado"));//tipFoliacion
		venta.setIndVenta(global.getValor("indicador.tipo.venta.web"));
		
	    int codModVentaRegalo = Integer.parseInt(global.getValor("codigo.modalidad.venta.regalo"));
	    int codModVentaComodato= Integer.parseInt(global.getValor("codigo.modalidad.venta.comodato"));
	    
		if (venta.getCodModVenta()==codModVentaRegalo || venta.getCodModVenta()==codModVentaComodato){
			venta.setIndPasoCob(1); //indPasoCob
		}else{
			venta.setIndPasoCob(0);
		}
		logger.debug("CodProducto:"+venta.getCodProducto());
		
		//obtener vendedor  (usuario)
		UsuarioDTO usuario = new UsuarioDTO();
		usuario.setNombre(venta.getNomUsuarioVenta());
		usuario = ordenServicioBO.obtenerVendedor(usuario);
		venta.setCodVendedor(usuario.getCodigo()); //codVendedor
		venta.setCodOficina(usuario.getCodOficina()); //codOficina
		venta.setCodTipComis(usuario.getCodTipComis()); //codTipComis
		logger.debug("usuario.codigo:"+usuario.getCodigo());
		
		//obtener direccion oficina
		DireccionOficinaDTO direccion = new DireccionOficinaDTO();
		direccion = ordenServicioBO.obtenerDireccionOficina(venta.getCodOficina());
		venta.setCodRegion(direccion.getCodRegion()); //codRegion
		venta.setCodProvincia(direccion.getCodProvincia()); //codProvincia
		venta.setCodCiudad(direccion.getCodCiudad()); //codCiudad
		venta.setCodPlaza(direccion.getCodPlaza()); //codPlaza
		
		//obtener vendedor raiz (vendedor)
		venta.setCodVendedorAgente(ordenServicioBO.obtenerVendedorRaiz(new Integer(venta.getCodVendedor())).intValue());
		
		//obtener codigo operadora (cliente)
		venta.setCodOperadora(ordenServicioBO.obtenerOperadora(new Long(venta.getCodCliente())));

		if (venta.getCodPlaza()==null || venta.getCodPlaza().equals("") 
				|| venta.getCodOperadora()==null || venta.getCodOperadora().equals("")){
			throw new GeneralException("1",0, "Error al recuperar datos para Insertar Venta");
		}
	
		//Validar que exista tipo de comisionista
		if (venta.getCodTipComis()==null || venta.getCodTipComis().equals("")){
			throw new GeneralException("1",0, "Error vendedor sin código de comisionista para Insertar Venta");
		}
		
		    respuesta = ordenServicioBO.registrarVenta(venta);
		logger.debug("registrarVenta():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return respuesta;		
}

public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws GeneralException{
	RetornoDTO respuesta = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("aceptarPresupuesto():start");
		String moduloGA =  global.getValor("codigo.modulo.GA");
		String codProducto = global.getValor("codigo.producto");
		String paramDiasVctoFact = global.getValor("parametro.dias.vcto.fact");
		
		ParametroDTO parametro = new ParametroDTO();
		parametro.setCodModulo(moduloGA);
		parametro.setCodProducto(Integer.parseInt(codProducto));
		parametro.setNomParametro(paramDiasVctoFact);
		parametro = ordenServicioBO.obtenerParametroGeneral(parametro);
		int numDias = Integer.parseInt(parametro.getValor());
		
		//calcula fecha de vencimiento
		Date fecha = new Date();	
		Calendar cal = new GregorianCalendar(); 
	    cal.setTimeInMillis(fecha.getTime()); 
	    cal.add(Calendar.DATE, numDias); 
	    Date fechaVencimiento = new Date(cal.getTimeInMillis());
	    
		presup.setFechaVcto(fechaVencimiento);
		respuesta = cargoBO.aceptarPresupuesto(presup);
		logger.debug("aceptarPresupuesto():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("Exception FrmkOOSSSrv [" + loge + "]");
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return respuesta;		
	
}

public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws GeneralException{
	ContratoDTO respuesta = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTipoContrato():start");
		respuesta = ordenServicioBO.obtenerTipoContrato(contrato);
		logger.debug("obtenerTipoContrato():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return respuesta;		
}

public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws GeneralException{
	ModalidadPagoDTO respuesta = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerModalidadPago():start");
		respuesta = ordenServicioBO.obtenerModalidadPago(modalidad);
		logger.debug("obtenerModalidadPago():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return respuesta;	
}

public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws GeneralException{
	PresupuestoDTO resultado = null;
	try{
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);

		logger.debug("Inicio:obtenerDetallePresupuesto()");
		resultado = cargoBO.obtenerDetallePresupuesto(presup);
		logger.debug("Fin:obtenerDetallePresupuesto()");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}			
	return resultado;
}

public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws GeneralException{
	VendedorDTO respuesta = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerVendedor():start");
		respuesta = ordenServicioBO.obtenerVendedor(vendedor);
		logger.debug("obtenerVendedor():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return respuesta;			
}

public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws GeneralException{
	RetornoDTO resultado = null;
	try{
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);

		logger.debug("Inicio:insertarConceptoDescuento()");
		resultado = cargoBO.insertarConceptoDescuento(desc);
		logger.debug("Fin:insertarConceptoDescuento()");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}			
	return resultado;			
	
}

public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws GeneralException{
	DescuentoDTO resultado = null;
	try{
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);

		logger.debug("Inicio:obtenerCodConceptoDescuento()");
		resultado = cargoBO.obtenerCodConceptoDescuento(sec);
		logger.debug("Fin:obtenerCodConceptoDescuento()");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}			
	return resultado;		
}

public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws GeneralException{
	RetornoDTO resultado = null;
	try{
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);

		logger.debug("Inicio:eliminaCodConceptoDescuento()");
		resultado = cargoBO.eliminaCodConceptoDescuento(numTransaccion);
		logger.debug("Fin:eliminaCodConceptoDescuento()");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}			
	return resultado;			
	
}

public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws GeneralException{
	ClienteDTO retorno = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerPlanComercial():start");
		retorno = planBO.obtenerPlanComercial(cliente);
		logger.debug("obtenerPlanComercial():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return retorno;			
}

public RetornoDTO consultarEstadoFacturado(long numProceso) throws GeneralException{
	RetornoDTO retorno = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultarEstadoFacturado():start");
		retorno = cargoBO.consultarEstadoFacturado(numProceso);
		logger.debug("consultarEstadoFacturado():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return retorno;			
}

public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws GeneralException{
	ArchivoFacturaDTO retorno = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerRutaFactura():start");
		retorno = registroFacturacionBO.obtenerRutaFactura(factura);
		logger.debug("obtenerRutaFactura():end");
	} catch (ProductException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return retorno;			
}

public ParametroDTO obtenerParametroGeneral(ParametroDTO registro) throws GeneralException{
	ParametroDTO respuesta = null;
	try {
		String log = global.getValor("service.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerParametroGeneral():start");
		respuesta = ordenServicioBO.obtenerParametroGeneral(registro);
		logger.debug("obtenerParametroGeneral():end");
	} catch (GeneralException e) {
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	return respuesta;		
}

	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO registro) throws GeneralException {
		RetornoDTO respuesta = null;
		try {
			logger.debug("registrarOOSSEnLinea():start");
			respuesta = ordenServicioBO1.registrarOOSSEnLinea(registro);
			logger.debug("registrarOOSSEnLinea():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
		return respuesta;
	}
	
	public RetornoDTO actualizaRenova(RegistrarRenovaDTO param) throws GeneralException {
		RetornoDTO respuesta = null;
		try {
			logger.debug("actualizaRenova():start");
			respuesta = ordenServicioBO1.actualizaRenova(param);
			logger.debug("actualizaRenova():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
		return respuesta;
	}


	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws GeneralException {
		AbonadoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);	
			//Santiago Ventura 23-04-2010				
			logger.debug("obtenerDatosAbonado2():start");
			respuesta = abonadoBO.obtenerDatosAbonado2(abonado);
			logger.debug("obtenerDatosAbonado2():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return respuesta;		
	}


	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws GeneralException {
		ClienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);	
			//Santiago Ventura 23-04-2010				
			logger.debug("obtenerDatosCliente():start");
			respuesta = clienteBO2.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return respuesta;
	}
	
	public RetornoDTO insertarCobroAdelantado(ClienteCobroAdentadoDTO clienteCobroAdelantadoDTO) throws GeneralException {
		RetornoDTO retValue = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);	
			logger.debug("insertarCobroAdelantado():start");
			retValue = clienteBO.insertarCobroAdelantado(clienteCobroAdelantadoDTO);
			logger.debug("insertarCobroAdelantado():end");
		} catch (CustomerException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}
		return retValue;
	}
	
	public boolean registrarCarta(CartaGeneralDTO dto, long numOS) throws CustomerOrderException {
		logger.info("registrarCarta(), inicio");
		boolean r = false;
		try {
			r = ordenServicioBO1.registrarCarta(dto, numOS);
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
