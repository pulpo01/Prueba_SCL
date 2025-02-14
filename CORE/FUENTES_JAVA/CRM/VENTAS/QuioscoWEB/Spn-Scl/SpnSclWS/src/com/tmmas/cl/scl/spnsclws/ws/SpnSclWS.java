package com.tmmas.cl.scl.spnsclws.ws;

import java.rmi.RemoteException;
import java.util.ArrayList;

import javax.ejb.CreateException;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonapp.dto.SSuplementarioOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsAltaClienteOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsAltaCuentaSubCuentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsAltaCuentaSubCuentaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsConsCargosVentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsConsCargosVentaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCuentaInNDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsDireccionInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsDireccionOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsDireccionesOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsFacturacionVentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsFacturacionVentaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsRegistraCampanaByPInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.OutAbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingOUTDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSCentralQuioscoOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsAgregaEliminaSSInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsListTipoPrestacionOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsOutSSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.AceptacionVentaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CargosDescuentosManualesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CierreVentaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RechazoVentaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoLineaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClasificacionOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCrediticiaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCategoriasClienteOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCiudadesOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoComunasOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoProvinciasOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoRegionesOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoTiposIdentificacionOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCategoriaCambioDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.WsDatosDireccionOutDTO;
import com.tmmas.cl.scl.spnsclorq.negocio.ejb.session.SpnSclORQ;
import com.tmmas.cl.scl.spnsclorq.negocio.ejb.session.SpnSclORQHome;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsAceptacionVentaInDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsCierreVentaInDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsRechazoVentaInDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsCreaStructuraComercialInDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraComercialOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DatosClienteDTO;
//import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificaClientizaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificacionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsCajaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTipificacionOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsUpdateTiendaOutDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionPrepagoPostpagoDTO;
import com.tmmas.cl.scl.spnsclwscommon.busito.dto.AltaDeLineaBusitoInDTO;
import com.tmmas.cl.scl.spnsclwscommon.busito.dto.AltaDeLineaBusitoOutDTO;

@WebService
@SOAPBinding(style = SOAPBinding.Style.DOCUMENT,
		use = SOAPBinding.Use.LITERAL,		
		parameterStyle = SOAPBinding.ParameterStyle.WRAPPED)
		
public class SpnSclWS{
	
	private CompositeConfiguration config;
	private final Logger logger = Logger.getLogger(this.getClass());
	
	public SpnSclWS() {
		System.out.println("SpnSclWSBean(): Start");
		config = UtilProperty.getConfigurationfromExternalFile("SpnSclWS.properties");
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));	
		logger.debug("SpnSclWSBean():End");
	}
	
	private SpnSclORQ getSpnSclORQ() throws GeneralException {

		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		logger.debug("getSpnSclORQ():start");
		SpnSclORQHome SpnSclORQHome = null;
		String jndi = config.getString("SpnSclORQ.jndi");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("SpnSclORQ.url.provider");
		logger.debug("Url provider[" + url + "]");

		try {
					
			SpnSclORQHome = (SpnSclORQHome) ServiceLocator.getInstance().getRemoteHome(url, jndi, SpnSclORQHome.class);
		} catch (ServiceLocatorException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("Recuperada interfaz home de SpnSclORQ...");
		SpnSclORQ SpnSclORQ = null;
		
		try {
			SpnSclORQ = SpnSclORQHome.create();
		} catch (CreateException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
			throw new GeneralException(e);
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("getSpnSclORQ()():end");
		return SpnSclORQ;
	}
	
	/*private SpnSclJMS getSpnSclJMS()
	throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("getSpnSclJMS():start");
		SpnSclJMSHome SpnSclJMSHome = null;
		String jndi = config.getString("SpnSclJMS.jndi");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("SpnSclJMS.url.provider");
		logger.debug("Url provider[" + url + "]");

		try {
			SpnSclJMSHome = (SpnSclJMSHome) ServiceLocator.getInstance().getRemoteHome(url, jndi, SpnSclJMSHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("Recuperada interfaz home de SpnSclJMS...");
		SpnSclJMS SpnSclJMS = null;

		try {
			SpnSclJMS = SpnSclJMSHome.create();
		} catch (CreateException e) {
			//TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
			throw new GeneralException(e);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("getSpnSclJMS()():end");
		return SpnSclJMS;
	}
	*/
	
	@WebMethod
	public String foo(String param) {
		return null;
	}
	
	@WebMethod
	public SSuplementarioOutDTO setAgregaEliminaSS(WsAgregaEliminaSSInDTO[] sSuplemenAgregar, WsAgregaEliminaSSInDTO[] sSuplemenEliminar, Long NumeroCelular, String NomUsuario, int rollback)
	{	 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:setAgregaEliminaSS()");
		SSuplementarioOutDTO resultado = new SSuplementarioOutDTO();
		ArrayList<RetornoDTO> error = new ArrayList<RetornoDTO>();
		try{			
			
			resultado = getSpnSclORQ().setAgregaEliminaSS(sSuplemenAgregar, sSuplemenEliminar, NumeroCelular, NomUsuario, rollback);
			
		} catch (GeneralException e) {
			RetornoDTO respuesta = new RetornoDTO();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));			
			resultado = new SSuplementarioOutDTO();
			respuesta.setCodError(e.getCodigo());
			respuesta.setMensajseError(e.getDescripcionEvento());
			error.add(respuesta);
			resultado.setResultadoTransaccion("1");
			resultado.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(error.toArray(), RetornoDTO.class));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			return resultado;
		} catch (Exception e) {		
			RetornoDTO respuesta = new RetornoDTO();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));	
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			resultado = new SSuplementarioOutDTO();			
			respuesta.setCodError("1");
			respuesta.setMensajseError(e.getMessage());
			error.add(respuesta);
			resultado.setResultadoTransaccion("1");
			resultado.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(error.toArray(), RetornoDTO.class));			
			logger.debug("Exception");			
			return resultado;
		}
		logger.debug("Fin:setAgregaEliminaSS()");		
		return resultado;
	}
	
	@WebMethod
	public WsAltaCuentaSubCuentaOutDTO AltaCuentaSubCuenta(WsAltaCuentaSubCuentaInDTO cuentaIn, int rollback)
	throws GeneralException{	
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		WsAltaCuentaSubCuentaOutDTO cuentaOut = new WsAltaCuentaSubCuentaOutDTO();
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		logger.debug("AltaCuentaSubCuenta():start");  				
		try{
				
			cuentaOut = getSpnSclORQ().AltaCuentaSubCuenta(cuentaIn, rollback);
			
		} catch (GeneralException e) {
			RetornoDTO error = new RetornoDTO();								
			cuentaOut = new WsAltaCuentaSubCuentaOutDTO();			
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);				
			cuentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));	
			cuentaOut.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			return cuentaOut;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));			
			RetornoDTO error = new RetornoDTO();								
			cuentaOut = new WsAltaCuentaSubCuentaOutDTO();			
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);						
			cuentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			cuentaOut.setResultadoTransaccion("1");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");					
			return cuentaOut;
		}
		logger.debug("AltaCuentaSubCuenta():end");
		return cuentaOut;

	}
	
	@WebMethod
	public WsAltaClienteOutDTO AltaCliente(WsCuentaInNDTO cuenta, int rollback) 
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		logger.debug("AltaCliente():start"); 
		WsAltaClienteOutDTO altaClienteOut = new  WsAltaClienteOutDTO();
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		try{											
								
			altaClienteOut = getSpnSclORQ().AltaCliente(cuenta, rollback);
			
		} catch (GeneralException e) {
			RetornoDTO error = new RetornoDTO();	
			altaClienteOut = new WsAltaClienteOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			altaClienteOut.setResultadoTransaccion("1");
			altaClienteOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			return altaClienteOut;

		} catch (Exception e) {
			RetornoDTO error = new RetornoDTO();	
			altaClienteOut = new WsAltaClienteOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			altaClienteOut.setResultadoTransaccion("1");
			altaClienteOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			return altaClienteOut;
		}

		logger.debug("crearCliente():end");
		return altaClienteOut; 
	}
	
	@WebMethod
	public WsCunetaAltaDeLineaOutDTO AltaDeLinea(WsCunetaAltaDeLineaDTO altaLinea, int rollback) 
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		logger.debug("AltaCliente():start"); 
		WsCunetaAltaDeLineaOutDTO CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();
		ArrayList<RetornoLineaDTO> errores = new ArrayList<RetornoLineaDTO>();
		try{		
			
			
			int cantLineas =   new Integer(config.getString("CantLinasAsin")).intValue();
			
			logger.debug("cantLineas ["+cantLineas+"]"); 
			
			/*if (altaLinea.getLinea().getLineas().length >= cantLineas){
				logger.debug("Ejecuta Alta JMS");
				getSpnSclJMS().AltaDeLineaJMS(altaLinea, rollback);
				CunetaAltaDeLineaOut.setResultadoTransaccion("0");				
			}else{*/
				logger.debug("Ejecuta Alta sin JMS");
				CunetaAltaDeLineaOut = getSpnSclORQ().AltaDeLinea(altaLinea, rollback);
			/*}*/
								
			
			
		} catch (GeneralException e) {
			RetornoLineaDTO error = new RetornoLineaDTO();	
			CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			CunetaAltaDeLineaOut.setErrores((RetornoLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoLineaDTO.class));
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			return CunetaAltaDeLineaOut;

		} catch (Exception e) {
			RetornoLineaDTO error = new RetornoLineaDTO();	
			CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			CunetaAltaDeLineaOut.setErrores((RetornoLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoLineaDTO.class));		
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			return CunetaAltaDeLineaOut;
		}

		logger.debug("crearCliente():end");
		return CunetaAltaDeLineaOut; 
	}
	
	@WebMethod
	public WsFacturacionVentaOutDTO ProcesoDeFacturacion(WsFacturacionVentaInDTO wsFacturacionVentaIn, int rollback) 
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		logger.debug("ProcesoDeFacturacion():start");
		WsFacturacionVentaOutDTO proceso = new WsFacturacionVentaOutDTO();
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		try{
			CargosDescuentosManualesDTO[] carDesManuales = null;
			proceso = getSpnSclORQ().ProcesoDeFacturacion(wsFacturacionVentaIn, carDesManuales, rollback);
			
		} catch (GeneralException e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			RetornoDTO error = new RetornoDTO();	
			proceso = new WsFacturacionVentaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			proceso.setResultadoTransaccion("1");
			proceso.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			return proceso; 

		} catch (Exception e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			RetornoDTO error = new RetornoDTO();	
			proceso = new WsFacturacionVentaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			proceso.setResultadoTransaccion("1");
			proceso.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			return proceso; 
		}

		logger.debug("crearCliente():end");
		return proceso; 
	}
	
	@WebMethod
	public WsDireccionesOutDTO agregarDirecciones(WsDireccionInDTO[] WsDireccionesIn, int rollback)	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		logger.debug("agregarDirecciones():start"); 
		WsDireccionesOutDTO wsDireccionesOut = null;
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		try{																			
			wsDireccionesOut = getSpnSclORQ().agregarDirecciones(WsDireccionesIn, rollback);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));	
			RetornoDTO error = new RetornoDTO();
			wsDireccionesOut = new WsDireccionesOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			wsDireccionesOut.setResultadoTransaccion("1");
			wsDireccionesOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));

			return wsDireccionesOut;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));	
			RetornoDTO error = new RetornoDTO();
			wsDireccionesOut = new WsDireccionesOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			wsDireccionesOut.setResultadoTransaccion("1");
			wsDireccionesOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));

			return wsDireccionesOut;
		}

		logger.debug("agregarDirecciones():end");
		return wsDireccionesOut; 
	}
	
	@WebMethod
	public WsDireccionOutDTO agregarDireccion(WsDireccionInDTO WsDireccionesIn, int rollback) 
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("agregarDireccion():start");
		WsDireccionOutDTO WsDireccion = new WsDireccionOutDTO(); 
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		try{
			
			WsDireccion = getSpnSclORQ().agregarDireccion(WsDireccionesIn, rollback);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			WsDireccion = new WsDireccionOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			WsDireccion.setResultadoTransaccion("1");
			WsDireccion.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));

			return WsDireccion;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));	
			RetornoDTO error = new RetornoDTO();
			WsDireccion = new WsDireccionOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			WsDireccion.setResultadoTransaccion("1");
			WsDireccion.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));

			return WsDireccion;

		}
		logger.debug("agregarDireccion():end");
		return WsDireccion;

	}
	
	@WebMethod
	public CierreVentaOutDTO cierreVenta(WsCierreVentaInDTO cierreVenta, int rollback)
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		logger.debug("agregarDirecciones():start"); 
		CierreVentaOutDTO cierreVentaOut = new CierreVentaOutDTO();
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		try{
			
			cierreVentaOut = getSpnSclORQ().cierreVenta(cierreVenta, rollback);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			cierreVentaOut = new CierreVentaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			cierreVentaOut.setResultadoTransaccion("1");
			cierreVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));

			return cierreVentaOut;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			cierreVentaOut = new CierreVentaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			cierreVentaOut.setResultadoTransaccion("1");
			cierreVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));

			return cierreVentaOut;
		}

		logger.debug("agregarDirecciones():end");
		return cierreVentaOut; 
	}
	
	@WebMethod
	public AceptacionVentaOutDTO aceptacionVenta(WsAceptacionVentaInDTO aceptacionVenta, int rollback)
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		logger.debug("AceptacionVenta():start"); 
		AceptacionVentaOutDTO aceptacionVentaOut = new AceptacionVentaOutDTO();
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();		
		try{
			
			aceptacionVentaOut = getSpnSclORQ().aceptacionVenta(aceptacionVenta, rollback);
				
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			aceptacionVentaOut = new AceptacionVentaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			aceptacionVentaOut.setResultadoTransaccion("1");
			aceptacionVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return aceptacionVentaOut; 

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			aceptacionVentaOut = new AceptacionVentaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			aceptacionVentaOut.setResultadoTransaccion("1");
			aceptacionVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return aceptacionVentaOut; 
		}

		logger.debug("AceptacionVenta():end");
		return aceptacionVentaOut; 
	}
	
	@WebMethod
	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonado(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, int rollback){	
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();
		try{
			logger.debug("SpnSclWSBean: solicitaBajaAbonado:start");
			solicitaBajaAbonadoOut = getSpnSclORQ().solicitaBajaAbonado(solicitudBajaAbonadoDTO, rollback);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclWSBean: solicitaBajaAbonado:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			solicitudBajaAbonadoDTO = new WSSolicitudBajaAbonadoDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			solicitaBajaAbonadoOut.setResultadoTransaccion("1");
			solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return solicitaBajaAbonadoOut; 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			solicitudBajaAbonadoDTO = new WSSolicitudBajaAbonadoDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			solicitaBajaAbonadoOut.setResultadoTransaccion("1");
			solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return solicitaBajaAbonadoOut; 
		}
		return solicitaBajaAbonadoOut;
	}
	
	@WebMethod
	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoPrepago(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, int rollback){	
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();
		try{
			logger.debug("SpnSclWSBean: solicitaBajaAbonado:start");
			solicitaBajaAbonadoOut = getSpnSclORQ().solicitaBajaAbonadoPrepago(solicitudBajaAbonadoDTO, rollback);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclWSBean: solicitaBajaAbonado:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			solicitudBajaAbonadoDTO = new WSSolicitudBajaAbonadoDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			solicitaBajaAbonadoOut.setResultadoTransaccion("1");
			solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return solicitaBajaAbonadoOut; 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			solicitudBajaAbonadoDTO = new WSSolicitudBajaAbonadoDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			solicitaBajaAbonadoOut.setResultadoTransaccion("1");
			solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return solicitaBajaAbonadoOut; 
		}
		return solicitaBajaAbonadoOut;
	}
	
	@WebMethod
	public ReservaOutDTO reservaDesreserva(ReservaDTO solicitaReservaDTO, String tipoSolicitud, int rollback){	
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		ReservaOutDTO solicitaReservaOutDTO = new ReservaOutDTO();
		try{
			logger.debug("SpnSclWSBean: solicitaReserva:start");
			solicitaReservaOutDTO = getSpnSclORQ().reservaDesreserva(solicitaReservaDTO, tipoSolicitud, rollback);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclWSBean: solicitaReserva:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			solicitaReservaOutDTO = new ReservaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			solicitaReservaOutDTO.setResultadoTransaccion("1");
			solicitaReservaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return solicitaReservaOutDTO; 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			solicitaReservaOutDTO = new ReservaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			solicitaReservaOutDTO.setResultadoTransaccion("1");
			solicitaReservaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return solicitaReservaOutDTO; 
		}
		return solicitaReservaOutDTO;
	}
	
	@WebMethod
	public WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn)throws GeneralException{
		WsListConsultaPlanTarifarioOutDTO retValue=null;
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		try{
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclWSBean: getListadoPlanesTarifarios:start");
			retValue=getSpnSclORQ().getConsultaPlanesTarifarios(consultaPlanTarifarioIn);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclWSBean: getListadoPlanesTarifarios:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			retValue = new WsListConsultaPlanTarifarioOutDTO();
			retValue.setCodError(e.getCodigo());
			retValue.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			retValue.setResultadoTransaccion("1");
			return retValue; 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			retValue = new WsListConsultaPlanTarifarioOutDTO();
			retValue.setCodError("1");
			retValue.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			retValue.setResultadoTransaccion("1");
			return retValue; 
		}
		return retValue;
	}
	
	@WebMethod
	public WsOutSSuplementariosDTO getSSincluidosEnPlan(String codigoPlanTarifario) throws GeneralException {	 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:getSSincluidosEnPlan()");
		SSuplementariosDTO[] resultado = null;
		WsOutSSuplementariosDTO retorno  = new WsOutSSuplementariosDTO();
		try{
			resultado = getSpnSclORQ().getSSincluidosEnPlan(codigoPlanTarifario);
			retorno.setServiciosSuplementarios(resultado);
		} catch (GeneralException e) {			
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			retorno.setCodError(e.getCodigo());
			retorno.setMensajseError(e.getDescripcionEvento());
			retorno.setResultadoTransaccion("1");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			retorno.setCodError("1");
			retorno.setResultadoTransaccion("1");
			retorno.setMensajseError(e.getMessage());
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}
		logger.debug("Fin:getSSincluidosEnPlan()");
		return retorno;
	}
	
	@WebMethod
	public WsOutSSuplementariosDTO getSSOpcionalesAlPlan(String codigoPlanTarifario, String codigoArticulo, String codigCentral) throws GeneralException{	 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:getSSOpcionalesAlPlan()");
		SSuplementariosDTO[] resultado = null;
		WsOutSSuplementariosDTO retorno = new WsOutSSuplementariosDTO();
		try{
			resultado = getSpnSclORQ().getSSOpcionalesAlPlan(codigoPlanTarifario, codigoArticulo, codigCentral);
			retorno.setServiciosSuplementarios(resultado);
			retorno.setCodError("0");
			retorno.setResultadoTransaccion("0");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			retorno.setCodError(e.getCodigo());
			retorno.setMensajseError(e.getDescripcionEvento());
			retorno.setResultadoTransaccion("1");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));	
			retorno.setCodError("1");
			retorno.setResultadoTransaccion("1");
			retorno.setMensajseError(e.getMessage());
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}
		logger.debug("Fin:getSSOpcionalesAlPlan()");
		return retorno;
	}
	
		@WebMethod
	public RechazoVentaOutDTO rechazoVenta(WsRechazoVentaInDTO rechazoVenta, int rollback)
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		logger.debug("AceptacionVenta():start"); 
		RechazoVentaOutDTO rechazoVentaOut = new RechazoVentaOutDTO();
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();		
		try{
			
			rechazoVentaOut = getSpnSclORQ().rechazoVenta(rechazoVenta, rollback);
				
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			rechazoVentaOut = new RechazoVentaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			rechazoVentaOut.setResultadoTransaccion("1");
			rechazoVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return rechazoVentaOut; 

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			rechazoVentaOut = new RechazoVentaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			rechazoVentaOut.setResultadoTransaccion("1");
			rechazoVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return rechazoVentaOut; 
		}

		logger.debug("AceptacionVenta():end");
		return rechazoVentaOut; 
	}
	
	@WebMethod
	public WsConsCargosVentaOutDTO getCargosFacturacion(WsConsCargosVentaInDTO WsFacturacionVentaIn) 
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		logger.debug("getCargosFacturacion():start");
		WsConsCargosVentaOutDTO proceso = new WsConsCargosVentaOutDTO();
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();
		try{																			
			
			proceso = getSpnSclORQ().getCargosFacturacion(WsFacturacionVentaIn);

			
		} catch (GeneralException e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			RetornoDTO error = new RetornoDTO();	
			proceso = new WsConsCargosVentaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			proceso.setResultadoTransaccion("1");
			proceso.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			return proceso; 

		} catch (Exception e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			RetornoDTO error = new RetornoDTO();	
			proceso = new WsConsCargosVentaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			proceso.setResultadoTransaccion("1");
			proceso.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			return proceso; 
		}

		logger.debug("getCargosFacturacion():end");
		return proceso; 
	}
			
	@WebMethod
	public MigracionPrepagoPostpagoDTO WSMigracionClientePrepagoAPostpago(MigracionDTO migracionDTO) throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		logger.debug("getCargosFacturacion():start");
		MigracionPrepagoPostpagoDTO proceso = new MigracionPrepagoPostpagoDTO();
		try{																			
			
			proceso = getSpnSclORQ().WSMigracionClientePrepagoAPostpago(migracionDTO);
		
		} catch (GeneralException e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
			proceso.setCodError(e.getCodigo());
			proceso.setDesError(e.getDescripcionEvento());
			proceso.setNumEvento(new Long(e.getCodigoEvento()).intValue());
		
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			return proceso; 

		} catch (Exception e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			proceso.setCodError("1");
			proceso.setDesError(e.getMessage());
			proceso.setNumEvento(0);			
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			return proceso; 
		}

		logger.debug("getCargosFacturacion():end");
		return proceso; 
	}	
	
	
	@WebMethod
	public WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(WsPlanTarifarioInDTO inWSLstPlanTarifDTO)throws GeneralException{
		WsListPlanTarifarioOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclWSBean: getListadoPlanesTarifarios:start");
			retValue=getSpnSclORQ().getListadoPlanesTarifarios(inWSLstPlanTarifDTO);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclWSBean: getListadoPlanesTarifarios:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));			
			retValue = new WsListPlanTarifarioOutDTO();
			retValue.setCodError(e.getCodigo());
			retValue.setMensajseError(e.getDescripcionEvento());							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			retValue.setResultadoTransaccion("1");
			return retValue; 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			retValue = new WsListPlanTarifarioOutDTO();
			retValue.setCodError("1");
			retValue.setMensajseError(e.getMessage());			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			retValue.setResultadoTransaccion("1");
			return retValue; 
		}
		return retValue;
	}		
	
	/*CSR-11002 pertenece a portabilidad
	@WebMethod
	public OutAbonadoPortadoDTO setDesMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		OutAbonadoPortadoDTO retValue=null;
		try{
			logger.debug("SpnSclORQBean: setDesMarcaAbonadoPortado:start");
			retValue= getSpnSclORQ().setDesMarcaAbonadoPortado(abonadoPortadoDTO);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: setDesMarcaAbonadoPortado:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));			
			retValue = new OutAbonadoPortadoDTO();
			retValue.setCodError(e.getCodigo());
			retValue.setMensajseError(e.getDescripcionEvento());							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			retValue.setResultadoTransaccion("1");
			return retValue; 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));			
			retValue = new OutAbonadoPortadoDTO();
			retValue.setCodError("1");
			retValue.setMensajseError(e.getMessage());			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			retValue.setResultadoTransaccion("1");
			return retValue; 
		}
		return retValue;
	}

	
	@WebMethod
	public OutAbonadoPortadoDTO setMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		OutAbonadoPortadoDTO retValue=null;
		try{
			logger.debug("SpnSclORQBean: setMarcaAbonadoPortado:start");
			retValue= getSpnSclORQ().setMarcaAbonadoPortado(abonadoPortadoDTO);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: setMarcaAbonadoPortado:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));			
			retValue = new OutAbonadoPortadoDTO();
			retValue.setCodError(e.getCodigo());
			retValue.setMensajseError(e.getDescripcionEvento());							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			retValue.setResultadoTransaccion("1");
			return retValue; 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));			
			retValue = new OutAbonadoPortadoDTO();
			retValue.setCodError("1");
			retValue.setMensajseError(e.getMessage());			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			retValue.setResultadoTransaccion("1");
			return retValue; 
		}
		return retValue;
	}	
	FIN CSR-11002*/
	
	@WebMethod
	public String pruebaJMS(String prueba){
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		String retValue= new String();
		try{
			logger.debug("SpnSclORQBean: pruebaJMS:start");
			
			//getSpnSclJMS().pruebaJMS(prueba);
			
			retValue = "Retorno WS ["+prueba+"]";
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: pruebaJMS:end");
					
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));									
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			return retValue;
			
		}
		return retValue;
	}				
	
	@WebMethod
	public WsCunetaAltaDeLineaOutDTO recuperarAltaAsincrono(String id_transaccion) 
	throws GeneralException
	{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		WsCunetaAltaDeLineaOutDTO CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();
		try{
			logger.debug("SpnSclORQBean: recuperarAltaAsincrono:start");
			CunetaAltaDeLineaOut= getSpnSclORQ().recuperarAltaAsincrono(id_transaccion);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: recuperarAltaAsincrono:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}
		return CunetaAltaDeLineaOut;
	}
	
	
	@WebMethod
	public WsBeneficioPromocionOutDTO[] recCampanaBeneficio(WsBeneficioPromocionInDTO beneficioPromocion) 
	throws GeneralException
	{	
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));	
		WsBeneficioPromocionOutDTO[] retorno = null;
		try{
			logger.debug("SpnSclORQBean: recCampanaBeneficio:start");
			retorno = getSpnSclORQ().recCampanaBeneficio(beneficioPromocion);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: recCampanaBeneficio:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}
		return retorno;
	}		
	
	
	@WebMethod
	public void registraCampanaBeneficio(WsRegistraCampanaByPInDTO registraCampanaByPIn) 
	throws GeneralException
	{	
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: registraCampanaBeneficio:start");
			getSpnSclORQ().registraCampanaBeneficio(registraCampanaByPIn);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: registraCampanaBeneficio:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}		
	}		
	


	
	@WebMethod
	public RoamingOUTDTO getDetalleUltimaLlamadasRoamingTOL(RoamingDTO rommingDTO)throws GeneralException 
	{	
		RoamingOUTDTO roamingOUT = null; 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: registraCampanaBeneficio:start");			                            
			roamingOUT = getSpnSclORQ().getDetalleUltimaLlamadasRoamingTOL(rommingDTO);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: registraCampanaBeneficio:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			roamingOUT = new RoamingOUTDTO();
			roamingOUT.setCodError(e.getCodigo());
			roamingOUT.setMensajseError(e.getDescripcionEvento());
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			roamingOUT = new RoamingOUTDTO();
			roamingOUT.setCodError("1");			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}		
		
		return roamingOUT;
	}	

	@WebMethod
	public WsTiendasOutDTO getTiendas() 
	throws GeneralException
	{	
		WsTiendasOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getTiendas:start");
		    resultado = getSpnSclORQ().getTiendas();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getTiendas:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			resultado = new WsTiendasOutDTO();
			logger.debug("log error[" + log + "]");	
			resultado.setCodError(Integer.parseInt(e.getCodigo()));
			resultado.setMsgError(e.getMessage());
			resultado.setNumEvento(new Long(e.getCodigoEvento()).intValue());
		}catch (Exception e){
			resultado = new WsTiendasOutDTO();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado.setMsgError(e.getMessage());

		}		
		
		return resultado;
	}	
	
	@WebMethod
	public TipificacionDTO[] recuperaDatoTipificacion (String datoTipificacion, String codVendedor) throws GeneralException
	{	
		TipificacionDTO[] resultado = null;
		
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getTiendas:start");
		    resultado = getSpnSclORQ().recuperaDatoTipificacion(datoTipificacion, codVendedor);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getTiendas:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new TipificacionDTO[1];
			resultado[0]= new TipificacionDTO();
			resultado[0].setCodError(Integer.parseInt(e.getCodigo()));
			resultado[0].setMsgError(e.getMessage());
			
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new TipificacionDTO[1];
			resultado[0]= new TipificacionDTO();
			resultado[0].setCodError(-1);
			resultado[0].setMsgError("Error desconocido al recuperar serie");
		}		
		
		return resultado;
	}
	
	@WebMethod
	public WsStructuraComercialOutDTO AltaDeStructuraComercial(WsCreaStructuraComercialInDTO WsCreaStructuraComercial) 	throws GeneralException
	{	
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		WsStructuraComercialOutDTO CunetaAltaDeLineaOut = new WsStructuraComercialOutDTO();
		try{
			logger.debug("TRAZADOR 144242 SpnSclWS-----ANTES ALTA ESTRUCTURA------------: AltaDeStructuraComercial:start------------------------------");
			
			
			CunetaAltaDeLineaOut = getSpnSclORQ().AltaDeStructuraComercial(WsCreaStructuraComercial);
			logger.debug("TRAZADOR 144242 SpnSclWS-----DESPUES ALTA ESTRUCTURA------------getNumVenta: ["+CunetaAltaDeLineaOut.getNumVenta()+"]--------------------------------------------------------");
			if (CunetaAltaDeLineaOut.getResultadoTransaccion().equals("0") ){
				logger.debug("TRAZADOR 144242 -----ANTES APLICA PAGO------------: AplicaPagoQuiosco:Start--------------------------------------------------------");
				CunetaAltaDeLineaOut = getSpnSclORQ().AplicaPagoQuiosco(WsCreaStructuraComercial, CunetaAltaDeLineaOut);				
				logger.debug("TRAZADOR 144242 ----DESPUES APLICA PAGO-------------: AplicaPagoQuiosco:End--------------------------------------------------------");
			}
								
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclWS-----------------: AltaDeStructuraComercial:End--------------------------------------------------------");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));	
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}
		return CunetaAltaDeLineaOut;
	}	
	
	@WebMethod
	public WsTiendaVendedorOutDTO getTiendaVendedor(String codTienda) 
	{	
		WsTiendaVendedorOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getTiendaVendedor:start");
		    resultado = getSpnSclORQ().getTiendaVendedor(codTienda);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getTiendaVendedor:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsTiendaVendedorOutDTO();
			resultado.setCodError(Integer.parseInt(e.getCodigo()));
			resultado.setMsgError(e.getMessage());
			resultado.setNumEvento(new Long(e.getCodigoEvento()).intValue());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsTiendaVendedorOutDTO();
			resultado.setMsgError(e.getMessage());
		}		
		
		return resultado;
	}
	
	@WebMethod
	public WsListBancoOutDTO getListadoBancosPAC() throws GeneralException{

		WsListBancoOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getListadoBancosPAC:start");
		    resultado = getSpnSclORQ().getListadoBancosPAC();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getListadoBancosPAC:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsListBancoOutDTO();
			resultado.setCodError(e.getCodigo());
			resultado.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsListBancoOutDTO();
			resultado.setCodError("-1");
			resultado.setMensajseError("Error desconocio al intentar recuperar bancos.");
		}		
		
		return resultado;
	}	
	
	@WebMethod
	public WsListTarjetaOutDTO getListadoTarjetas() throws GeneralException{

		WsListTarjetaOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getListadoBancosPAC:start");
		    resultado = getSpnSclORQ().getListadoTarjetas();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getListadoBancosPAC:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsListTarjetaOutDTO();
			resultado.setCodError(e.getCodigo());
			resultado.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsListTarjetaOutDTO();
			resultado.setCodError("-1");
			resultado.setMensajseError("Error desconocido al intentar recuperar tarjetas de credito");
		}		
		
		return resultado;
	}
	
	@WebMethod
	public DatosClienteDTO clientePorNumeroCelular (long numeroCelular)throws GeneralException{
		DatosClienteDTO datosClienteDTO =  null;  
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: clientePorNumeroCelular:start");
			datosClienteDTO = getSpnSclORQ().clientePorNumeroCelular(numeroCelular);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: clientePorNumeroCelular:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			datosClienteDTO = new DatosClienteDTO();	
			datosClienteDTO.setCodError(Integer.parseInt(e.getCodigo()));			
			datosClienteDTO.setMsgError(e.getMessage());
			datosClienteDTO.setNumEvento(new Long(e.getCodigoEvento()).intValue());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			datosClienteDTO = new DatosClienteDTO();
			datosClienteDTO.setCodError(-1);
			datosClienteDTO.setMsgError("Error desconocido al intentar recuperar el cliente.");
		}		
		
		return datosClienteDTO;
	}
	
	@WebMethod
	public WsListadoCategoriasClienteOutDTO getListCategorias()throws GeneralException{
		WsListadoCategoriasClienteOutDTO resultado = new WsListadoCategoriasClienteOutDTO();  
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getListCategorias:start");
			resultado = getSpnSclORQ().getListCategorias();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getListCategorias:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado.setCodError(e.getCodigo());
			resultado.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado.setCodError("-1");
			resultado.setMensajseError("Se ha producido un error al intentar rescatar las categorias para cliente");
		}		
		return resultado;
	}
	
	@WebMethod
	public WsListadoRegionesOutDTO getListadoRegiones() throws GeneralException{		 		
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:getListadoRegiones()");
		WsListadoRegionesOutDTO regiones = new WsListadoRegionesOutDTO();
		try{
			regiones = getSpnSclORQ().getListadoRegionesQuiosco();
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			regiones.setCodError(e.getCodigo());
			regiones.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			regiones.setCodError("-1");
			regiones.setMensajseError("Se ha producido un error al intentar rescatar regiones");
		}		
		return regiones;
		}
	
	@WebMethod
	public WsListadoProvinciasOutDTO getListadoProvincias(RegionDTO regionDTO) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:getListadoProvincias()");
		WsListadoProvinciasOutDTO provincias = new WsListadoProvinciasOutDTO();
		try{
			provincias = getSpnSclORQ().getListadoProvinciasQuiosco(regionDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			provincias.setCodError(e.getCodigo());
			provincias.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			provincias.setCodError("-1");
			provincias.setMensajseError("Se ha producido un error al intentar rescatar provincias");
		}		
		return provincias;
		}
	
	@WebMethod
	public WsListadoCiudadesOutDTO getListadoCiudades(ProvinciaDTO provinciaDTO) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:getListadoCiudades()");
		WsListadoCiudadesOutDTO ciudades = new WsListadoCiudadesOutDTO();
		try{
			ciudades = getSpnSclORQ().getListadoCiudaddesQuiosco(provinciaDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			ciudades.setCodError(e.getCodigo());
			ciudades.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			ciudades.setCodError("-1");
			ciudades.setMensajseError("Se ha producido un error al intentar rescatar ciudades");
		}		
		return ciudades;
		}
	
	@WebMethod
	public WsListadoComunasOutDTO getListadoComunas(CiudadDTO ciudadDTO) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:getListadoComunas()");
		WsListadoComunasOutDTO comunas = new WsListadoComunasOutDTO();
		try{
			comunas = getSpnSclORQ().getListadoComunasQuiosco(ciudadDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			comunas.setCodError(e.getCodigo());
			comunas.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			comunas.setCodError("-1");
			comunas.setMensajseError("Se ha producido un error al intentar rescatar comunas");
		}		
		return comunas;
		}
	
	/*
	 * Metodo: recuperaArrayTipificacion
	 * Descripcion: obtiene la lista de tipificaciones de los articulos
	 * Fecha: 08/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	@WebMethod
	public TipificaClientizaDTO[] recuperaArrayTipificacion() throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:recuperaArrayTipificacion()");
		TipificaClientizaDTO[] tipificaClientizaDTO = null;
		try{
			tipificaClientizaDTO = getSpnSclORQ().recuperaArrayTipificacion();
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw new GeneralException(e);
		}		
		return tipificaClientizaDTO;
	}
	
	/*
	 * Metodo: updateTipificacion
	 * Descripcion: Actualiza los datos de tipificados de un articulo
	 * Fecha: 08/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	@WebMethod
	public void updateTipificacion(TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:updateTipificacion()");
		try{
			getSpnSclORQ().updateTipificacion(tipificaClientizaDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw new GeneralException(e);
		}		
	}
	
	/*
	 * Metodo: createTipificacion
	 * Descripcion: crea una tipificacion de un articulo
	 * Fecha: 09/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	@WebMethod
	public WsInsertTipificacionOutDTO insertarTipificacion(TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:createTipificacion()");
		WsInsertTipificacionOutDTO wsInsertTipificacionOutDTO = null;
		try{
			getSpnSclORQ().insertTipificacion(tipificaClientizaDTO);
			wsInsertTipificacionOutDTO = new WsInsertTipificacionOutDTO();
			wsInsertTipificacionOutDTO.setCodError(0);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			wsInsertTipificacionOutDTO = new WsInsertTipificacionOutDTO();
			wsInsertTipificacionOutDTO.setCodError(Integer.parseInt(e.getCodigo()));
			wsInsertTipificacionOutDTO.setMsgError(e.getMessage()+" "+e.getDescripcionEvento());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			wsInsertTipificacionOutDTO = new WsInsertTipificacionOutDTO();
			wsInsertTipificacionOutDTO.setCodError(-1);
			wsInsertTipificacionOutDTO.setMsgError("Error Inesperado Al Insertar Tipificación");
		}		
		
		return wsInsertTipificacionOutDTO;
	}
	
	/*
	 * Metodo: deleteTipificacion
	 * Descripcion: elimina una tipificacion de un articulo
	 * Fecha: 09/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	@WebMethod
	public void deleteTipificacion(Long codArticulo) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:deleteTipificacion()");
		try{
			getSpnSclORQ().deleteTipificacion(codArticulo);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw new GeneralException(e);
		}		
	}
	
	/*
	 * Metodo: insertTienda
	 * Descripcion: crea una tienda
	 * Fecha: 09/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	@WebMethod
	public WsInsertTiendaOutDTO insertTienda(TiendaDTO tiendaDTO) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:insertTienda()");
		
		WsInsertTiendaOutDTO wsInsertTiendaOutDTO = null;
		
		try{
			wsInsertTiendaOutDTO = getSpnSclORQ().insertTienda(tiendaDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			wsInsertTiendaOutDTO = new WsInsertTiendaOutDTO();
			wsInsertTiendaOutDTO.setCodError(Integer.parseInt(e.getCodigo()));
			wsInsertTiendaOutDTO.setMsgError(e.getMessage()+" "+e.getDescripcionEvento());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			wsInsertTiendaOutDTO = new WsInsertTiendaOutDTO();
			wsInsertTiendaOutDTO.setCodError(-1);
			wsInsertTiendaOutDTO.setMsgError("Error Inesperado Al Insertar Tienda");
		}
		
		return wsInsertTiendaOutDTO;
	}
	
	/*
	 * Metodo: obtieneListaTienda
	 * Descripcion: obtiene la lista de tiendas
	 * Fecha: 09/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	@WebMethod
	public TiendaDTO[] obtieneListaTienda() throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:obtieneListaTienda()");
		TiendaDTO[] tiendaDTO = null;
		try{
			tiendaDTO = getSpnSclORQ().obtieneListaTienda();
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw new GeneralException(e);
		}		
		return tiendaDTO;
	}
	
	/*
	 * Metodo: updateTienda
	 * Descripcion: Actualiza los datos de una tienda
	 * Fecha: 08/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	@WebMethod
	public WsUpdateTiendaOutDTO updateTienda(TiendaDTO tiendaModDTO) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:updateTienda()");
		WsUpdateTiendaOutDTO wsUpdateTiendaOutDTO = null;
		try{
			wsUpdateTiendaOutDTO = getSpnSclORQ().updateTienda(tiendaModDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw new GeneralException(e);
		}
		return wsUpdateTiendaOutDTO;
	}
	
	/*
	 * Metodo: deleteTipificacion
	 * Descripcion: elimina una tienda
	 * Fecha: 09/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	@WebMethod
	public void deleteTienda(Long codTienda) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:deleteTienda()");
		try{
			getSpnSclORQ().deleteTienda(codTienda);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw new GeneralException(e);
		}		
	}
	
	@WebMethod
	public WsListadoTiposIdentificacionOutDTO getTiposIdentificacion() throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("Inicio:getTiposIdentificacion()");
		WsListadoTiposIdentificacionOutDTO identificadorCivilDTOs = new WsListadoTiposIdentificacionOutDTO();
		try{
			identificadorCivilDTOs=getSpnSclORQ().getTiposIdentificacion();
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			identificadorCivilDTOs.setCodError(e.getCodigo());
			identificadorCivilDTOs.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			identificadorCivilDTOs.setCodError("-1");
			identificadorCivilDTOs.setMensajseError("Se ha producido un error al intentar rescatar tipos de identificación");
		}
		return identificadorCivilDTOs;
	}
	
	@WebMethod
	public float getImpuesto(String codigoVendedor) throws GeneralException{
		float resultado = 0;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getImpuesto:start");
		    resultado = getSpnSclORQ().getImpuesto(codigoVendedor);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getImpuesto:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
		
		return resultado;
	}	
	
	@WebMethod
	public String getZip(com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO direccion) throws GeneralException{
		String resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getZip:start");
		    resultado = getSpnSclORQ().getZip(direccion);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getZip:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
		
		return resultado;
	}	
	
	@WebMethod
	public WsCajaOutDTO getListaCaja(String codOficina) throws GeneralException{
		WsCajaOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getListaCaja:start");
		    resultado = getSpnSclORQ().getListaCaja(codOficina);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getListaCaja:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			resultado = new WsCajaOutDTO();
			logger.debug("log error[" + log + "]");	
			resultado.setCodError(Integer.parseInt(e.getCodigo()));
			resultado.setMsgError(e.getMessage());
			resultado.setNumEvento(new Long(e.getCodigoEvento()).intValue());
		}catch (Exception e){
			resultado = new WsCajaOutDTO();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado.setMsgError(e.getMessage());

		}		
		return resultado;
	}
	
	
	@WebMethod
	public WSCentralQuioscoOutDTO getCentralesQuiosco() throws GeneralException{
		WSCentralQuioscoOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getListaCaja:start");
		    resultado = getSpnSclORQ().getCentralesQuiosco();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getListaCaja:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			resultado = new WSCentralQuioscoOutDTO();
			logger.debug("log error[" + log + "]");	
			resultado.setCodError(e.getCodigo());
			resultado.setMsgError(e.getMessage());
			resultado.setNumEvento(Long.toString(e.getCodigoEvento()));
		}catch (Exception e){
			resultado = new WSCentralQuioscoOutDTO();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado.setCodError("-1");
			resultado.setMsgError(e.getMessage());

		}		
		return resultado;
	}
	
	
	@WebMethod
	public AltaDeLineaBusitoOutDTO AltaDeLineaBusito(AltaDeLineaBusitoInDTO altaDeLineaBusitoIn)
	throws GeneralException{
		AltaDeLineaBusitoOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclWSBean: AltaDeLineaBusito:start");
		    resultado = getSpnSclORQ().AltaDeLineaBusito(altaDeLineaBusitoIn);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclWSBean: AltaDeLineaBusito:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	

		}		
		return resultado;
	}	
	
	//Inicio Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
	@WebMethod
	public RechazoVentaOutDTO cancelaVenta(WsRechazoVentaInDTO cancelaVenta, int rollback)
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		logger.debug("INCIDENCIA 143860"); 
		logger.debug("cancelaVenta():start"); 
		RechazoVentaOutDTO rechazoVentaOut = new RechazoVentaOutDTO();
		ArrayList<RetornoDTO> errores = new ArrayList<RetornoDTO>();		
		try{
			
			rechazoVentaOut = getSpnSclORQ().cancelaVenta(cancelaVenta, rollback);
				
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			rechazoVentaOut = new RechazoVentaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			rechazoVentaOut.setResultadoTransaccion("1");
			rechazoVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return rechazoVentaOut; 

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			RetornoDTO error = new RetornoDTO();
			rechazoVentaOut = new RechazoVentaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			rechazoVentaOut.setResultadoTransaccion("1");
			rechazoVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			return rechazoVentaOut; 
		}

		logger.debug("cancelaVenta():end");
		return rechazoVentaOut; 
	}	
	//Fin Incidencia 143860 [ACP Soporte Ventas 05-10-2010]


  /*CSR-11002 Se incorpora método getTiposPrestacion*/
  @WebMethod
  public WsListTipoPrestacionOutDTO getTiposPrestacion(String codGrupoPrestacion, String tipoCliente) throws GeneralException{

         UtilLog.setLog(config.getString("SpnSclWSBean.log"));
         logger.debug("Inicio:getTipoPrestacion()");
         WsListTipoPrestacionOutDTO tipoPrestacionDTO = new WsListTipoPrestacionOutDTO();

         try{

             tipoPrestacionDTO = getSpnSclORQ().getTiposPrestacion(codGrupoPrestacion, tipoCliente);

         }catch(GeneralException e){
             UtilLog.setLog(config.getString("SpnSclWSBean.log"));
             logger.debug("GeneralException");
             String log = StackTraceUtl.getStackTrace(e);
             logger.debug("log error[" + log + "]");
             tipoPrestacionDTO.setCodError(e.getCodigo());
             tipoPrestacionDTO.setMensajseError(e.getMessage());
         }catch (Exception e){
             UtilLog.setLog(config.getString("SpnSclWSBean.log"));
             logger.debug("GeneralException");
             String log = StackTraceUtl.getStackTrace(e);
             logger.debug("log error[" + log + "]");
             tipoPrestacionDTO.setCodError("-1");
             tipoPrestacionDTO.setMensajseError("Se ha producido un error al intentar rescatar Tipo de prestación");
         }

         return tipoPrestacionDTO;
  }
  //fin getTiposPrestacion

	@WebMethod
	public WsDatosDireccionOutDTO getDatosDireccion(com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO direccionDTO) throws GeneralException{

		WsDatosDireccionOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		try{
			logger.debug("SpnSclORQBean: getDatosDireccion:start");
		    resultado = getSpnSclORQ().getDatosDireccion(direccionDTO);
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getDatosDireccion:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			resultado = new WsDatosDireccionOutDTO();
			resultado.setCodError(e.getCodigo());
			resultado.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			resultado = new WsDatosDireccionOutDTO();
			resultado.setCodError("-1");
			resultado.setMensajseError("Error desconocido al intentar recuperar los campos de direcciones");
		}		
		
		return resultado;
	}
	@WebMethod
	public WsListadoCategoriaCambioDTO getCategoriasCambio() throws GeneralException
	{
		WsListadoCategoriaCambioDTO segmentosDTO = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclWSBean: getCategoriasCambio:start");
			segmentosDTO = getSpnSclORQ().getCategoriasCambio();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclWSBean: getCategoriasCambio:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			segmentosDTO.setCodError(e.getCodigo());
			segmentosDTO.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			segmentosDTO.setCodError("-1");
			segmentosDTO.setMensajseError("Se ha producido un error al intentar rescatar las categorias de cambio");

		}		
		return segmentosDTO;
	}
	
	//CSR-11002
	@WebMethod
	public WsCrediticiaOutDTO getCrediticia() throws GeneralException{

		WsCrediticiaOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getCrediticia:start");
		    resultado = getSpnSclORQ().getCrediticia();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getCrediticia:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsCrediticiaOutDTO();
			resultado.setCodError(e.getCodigo());
			resultado.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsCrediticiaOutDTO();
			resultado.setCodError("-1");
			resultado.setMensajseError("Error desconocido al intentar recuperar las clasificaiones crediticias");
		}		
		
		return resultado;
	}
	
	//CSR-11002
	@WebMethod
	public WsClasificacionOutDTO getClasificaciones() throws GeneralException{

		WsClasificacionOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getClasificaciones:start");
		    resultado = getSpnSclORQ().getClasificaciones();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getClasificaciones:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsClasificacionOutDTO();
			resultado.setCodError(e.getCodigo());
			resultado.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsClasificacionOutDTO();
			resultado.setCodError("-1");
			resultado.setMensajseError("Error desconocido al intentar recuperar las clasificaiones");
		}		
		
		return resultado;
	}
	
	@WebMethod
	public WsListTipoPagoOutDTO getListadoTipoPago() throws GeneralException {
		WsListTipoPagoOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));
		try {
			logger.debug("SpnSclORQBean: getListadoTipoPago:start");
			resultado = getSpnSclORQ().getListadoTipoPago();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getListadoTipoPago:end");
		}
		catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug((new StringBuilder("log error[")).append(log).append("]").toString());
			resultado = new WsListTipoPagoOutDTO();
			resultado.setCodError(e.getCodigo());
			resultado.setMensajseError(e.getMessage());
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug((new StringBuilder("log error[")).append(log).append("]").toString());
			resultado = new WsListTipoPagoOutDTO();
			resultado.setCodError("-1");
			resultado.setMensajseError("Error desconocido al intentar recuperar los tipos de pagos");
		}
		return resultado;
	}
	
	//JLGN PT
	@WebMethod
	public WsListPlanTarifarioOutDTO getListadoPlanTarifario() throws GeneralException{

		WsListPlanTarifarioOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclWSBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getListadoPlanTarifario:start");
		    resultado = getSpnSclORQ().getListadoPlanTarifario();
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));
			logger.debug("SpnSclORQBean: getListadoPlanTarifario:end");
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));													
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsListPlanTarifarioOutDTO();
			resultado.setCodError(e.getCodigo());
			resultado.setMensajseError(e.getMessage());
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclWSBean.log"));							
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			resultado = new WsListPlanTarifarioOutDTO();
			resultado.setCodError("-1");
			resultado.setMensajseError("Error desconocio al intentar recuperar Planes Tarifarios.");
		}		
		
		return resultado;
	}	
}