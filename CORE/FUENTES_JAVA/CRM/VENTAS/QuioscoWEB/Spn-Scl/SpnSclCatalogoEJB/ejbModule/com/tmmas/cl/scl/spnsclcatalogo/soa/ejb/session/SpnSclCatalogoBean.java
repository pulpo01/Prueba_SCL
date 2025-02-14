/**
 * 
 */
package com.tmmas.cl.scl.spnsclcatalogo.soa.ejb.session;

import java.rmi.RemoteException;
import java.util.ArrayList;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonapp.dto.WSEstadoCivilOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsActividadesOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCategoriaImpostivaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsClasificacionCuentaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsEstadoOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsOcupacionesOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsReglaSSOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsSucursalesBancoOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CantidadSerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CantidadStockSerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsOutSSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.BodegaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DireccionCentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SucursalBancoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SumaPlanesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SumaPrecioPlanesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCicloFactInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClienteIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsHomeLineaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCicloFactOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListClienteIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListModalidadPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.PuebloDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;
import com.tmmas.cl.scl.spnsclorq.negocio.ejb.session.SpnSclORQ;
import com.tmmas.cl.scl.spnsclorq.negocio.ejb.session.SpnSclORQHome;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="SpnSclCatalogo"	
 *           description="An EJB named SpnSclCatalogo"
 *           display-name="SpnSclCatalogo"
 *           jndi-name="SpnSclCatalogo"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class SpnSclCatalogoBean implements javax.ejb.SessionBean {

	
	private SessionContext context = null;

	private CompositeConfiguration config;

	private final Logger logger = Logger.getLogger(SpnSclCatalogoBean.class);
	
	/**
	 * 
	 */
	public SpnSclCatalogoBean() {
		System.out.println("SpnSclCatalogoBean(): Start");
		config = UtilProperty.getConfigurationfromExternalFile("CatalogoBean.properties");
		UtilLog.setLog(config.getString("CatalogoBean.log"));	
		logger.debug("SpnSclCatalogoBean():End");
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.create-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() {
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String foo(String param) {
		return null;
	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		// TODO Auto-generated method stub

	}


	
	
	private SpnSclORQ getSpnSclORQ()
	throws GeneralException {

		UtilLog.setLog(config.getString("CatalogoBean.log"));		
		logger.debug("getSpnSclORQ():start");
		SpnSclORQHome SpnSclORQHome = null;
		String jndi = config.getString("SpnSclORQ.jndi");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("SpnSclORQ.url.provider");
		logger.debug("Url provider[" + url + "]");

		try {
			SpnSclORQHome = (SpnSclORQHome) ServiceLocator.getInstance().getRemoteHome(url, jndi, SpnSclORQHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("Recuperada interfaz home de SpnSclORQ...");
		SpnSclORQ SpnSclORQ = null;
		
		try {
			SpnSclORQ = SpnSclORQHome.create();
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

		logger.debug("getSpnSclORQ()():end");
		return SpnSclORQ;
	}	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListClienteIdentOutDTO getListadoClientesXIdentificacion(WsClienteIdentInDTO cliente){
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsListClienteIdentOutDTO retValue = new WsListClienteIdentOutDTO();
		ArrayList listaRespuestaValidacion = new ArrayList();
		RetornoDTO respuesta = new RetornoDTO();
		RetornoDTO respuesta2 = new RetornoDTO();
		try{			
			String codTipIdentif=cliente.getCodigoTipoIdentificacion();
			String numIdentificacion=cliente.getNumeroIdentificacion();						
			if (codTipIdentif==null||"".equals(codTipIdentif)){
				respuesta.setCodError("12385");
				respuesta.setMensajseError("el tipo de identificacion no puede ser null o vacio");
				listaRespuestaValidacion.add(respuesta);
			}
			/*else if(!Validaciones.isNumber(codTipIdentif)) {
				listaErrores.add("6210");
			}*/
			if (numIdentificacion==null||"".equals(numIdentificacion)){
				respuesta2.setCodError("12386");
				respuesta2.setMensajseError("el numero de identificacion no puede ser null o vacio");
				listaRespuestaValidacion.add(respuesta2);
			}
			/*else if(!Validaciones.isNumber(numIdentificacion)){
				listaErrores.add("6220");
			}*/			
			logger.debug("SpnSclWSBean: getListadoClientesXIdentificacion:start");
			if (listaRespuestaValidacion.size() > 0){
			/*	String codErro = "|" ;
				for(int i=0; i< listaErrores.size(); i++){
					codErro = codErro +  listaErrores.get(i) +"|";					
				}*/
				retValue.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaRespuestaValidacion.toArray(), RetornoDTO.class));			
				retValue.setResultadoTransaccion("1");
			}
			else{
				retValue = getSpnSclORQ().getListadoClientesXIdentificacion(cliente);
				retValue.setResultadoTransaccion("0");
				//retValue.setCodError("0");
			}
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getListadoClientesXIdentificacion:end");
		}catch(GeneralException e){
			respuesta = new RetornoDTO(); 
			listaRespuestaValidacion=new ArrayList();
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion("1");
			respuesta.setCodError(e.getCodigo());
			respuesta.setMensajseError(e.getDescripcionEvento());	
			listaRespuestaValidacion.add(respuesta);
			retValue.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaRespuestaValidacion.toArray(), RetornoDTO.class));
			return retValue;
		}catch (Exception e) {
			respuesta = new RetornoDTO(); 
			listaRespuestaValidacion=new ArrayList();
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);
			retValue.setResultadoTransaccion("1");
			respuesta.setCodError("1");
			respuesta.setMensajseError(e.getMessage());	
			listaRespuestaValidacion.add(respuesta);
			retValue.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaRespuestaValidacion.toArray(), RetornoDTO.class));
			return retValue;
			
		}
		return retValue;
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public BodegaDTO[] getBodegasPorVendedor(String codigoVendedor) {		 
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		logger.debug("Inicio:getBodegasPorVendedor()");
		BodegaDTO[] resultado = null;
		try{
			resultado = getSpnSclORQ().getBodegasPorVendedor(codigoVendedor);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}
		logger.debug("Fin:getCiudad()");
		return resultado;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsOutSSuplementariosDTO getSSincluidosEnPlan(String codigoPlanTarifario) {	 
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		logger.debug("Inicio:getSSincluidosEnPlan()");
		SSuplementariosDTO[] resultado = null;
		WsOutSSuplementariosDTO retorno  = new WsOutSSuplementariosDTO();
		try{
			resultado = getSpnSclORQ().getSSincluidosEnPlan(codigoPlanTarifario);
			retorno.setServiciosSuplementarios(resultado);
		} catch (GeneralException e) {			
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			retorno.setCodError(e.getCodigo());
			retorno.setResultadoTransaccion("1");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			retorno.setCodError("1");
			retorno.setResultadoTransaccion("1");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}
		logger.debug("Fin:getSSincluidosEnPlan()");
		return retorno;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsOutSSuplementariosDTO getSSOpcionalesAlPlan(String codigoPlanTarifario, String codigoArticulo, String codigCentral)	 {	 
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		logger.debug("Inicio:getSSOpcionalesAlPlan()");
		SSuplementariosDTO[] resultado = null;
		WsOutSSuplementariosDTO retorno = new WsOutSSuplementariosDTO();
		try{
			resultado = getSpnSclORQ().getSSOpcionalesAlPlan(codigoPlanTarifario, codigoArticulo, codigCentral);
			retorno.setServiciosSuplementarios(resultado);
			retorno.setCodError("0");
			retorno.setResultadoTransaccion("0");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			retorno.setCodError(e.getCodigo());
			retorno.setResultadoTransaccion("1");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));	
			retorno.setCodError("1");
			retorno.setResultadoTransaccion("1");			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}
		logger.debug("Fin:getSSOpcionalesAlPlan()");
		return retorno;
	}		
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(WsPlanTarifarioInDTO inWSLstPlanTarifDTO){
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsListPlanTarifarioOutDTO retValue = new WsListPlanTarifarioOutDTO();
		try{
			boolean isAplicaError=inWSLstPlanTarifDTO.getTipPlanTarif()==null||!("I".equals(inWSLstPlanTarifDTO.getTipPlanTarif())||"E".equals(inWSLstPlanTarifDTO.getTipPlanTarif())||"F".equals(inWSLstPlanTarifDTO.getTipPlanTarif()))?true:false;
			ArrayList listaErrores =new ArrayList();
			if (!isAplicaError){
				logger.debug("SpnSclWSBean: getListadoPlanesTarifarios:start");
				retValue=getSpnSclORQ().getListadoPlanesTarifarios(inWSLstPlanTarifDTO);
				retValue.setResultadoTransaccion("0");
				retValue.setCodError("0");
				UtilLog.setLog(config.getString("CatalogoBean.log"));
				logger.debug("SpnSclWSBean: getListadoPlanesTarifarios:end");
			}
			else{
				listaErrores.add("6180");
			}
			if (listaErrores.size()>0){
				String codErro = "|" ;
				for(int i=0; i< listaErrores.size(); i++){
					codErro = codErro +  listaErrores.get(i) +"|";					
				}
				retValue.setCodError(codErro);		
				retValue.setResultadoTransaccion("1");				
			}
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion("1");
			retValue.setCodError("|"+e.getCodigo()+"|");
			//throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);
			
		}
		return retValue;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListModalidadPagoOutDTO getListadoModalidadPago() {
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsListModalidadPagoOutDTO retValue = new WsListModalidadPagoOutDTO();
		try{
			logger.debug("SpnSclWSBean: getListadoModalidadPago:start");				
			//if (Utilitarios.isNumber(String.valueOf(wsModalidadPagoInDTO.getIndManual()))){
			retValue=getSpnSclORQ().getListadoModalidadPago();
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			retValue.setResultadoTransaccion("0");
			retValue.setCodError("0");
				//}
				//else{
				//throw new GeneralException("Debe ingresar un valor numérico en indicador manual de sistema de pago");
				//}
			logger.debug("SpnSclWSBean: getListadoModalidadPago:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion("1");
			retValue.setCodError("|"+e.getCodigo()+"|");
			//throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);
			
		}
		return retValue;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RegionDTO[] getListadoRegiones() {		 
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		logger.debug("Inicio:getCiudad()");
		RegionDTO[] regiones = null;
		try{
			regiones = getSpnSclORQ().getListadoRegiones();
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
		}
		logger.debug("Fin:getCiudad()");
		return regiones;
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ProvinciaDTO[] getListadoProvincias(RegionDTO region) {		 
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		logger.debug("Inicio:getCiudad()");
		ProvinciaDTO[] Provincias = null;
		try{			                                       
			Provincias = getSpnSclORQ().getListadoProvincias(region);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
		}
		logger.debug("Fin:getCiudad()");
		return Provincias;
	}	
		
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CiudadDTO[] getListadoCiudades(ProvinciaDTO provincia) {		 
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		logger.debug("Inicio:getCiudad()");
		CiudadDTO[] ciudades = null;
		try{
			ciudades = getSpnSclORQ().getListadoCiudaddes(provincia);						
						
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
		}
		logger.debug("Fin:getCiudad()");
		return ciudades;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ComunaSPNDTO[] getListadoComunas(CiudadDTO ciudad) {		 
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		logger.debug("Inicio:getCiudad()");
		ComunaSPNDTO[] comunas = null;
		try{
			comunas = getSpnSclORQ().getListadoComunas(ciudad);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		}
		logger.debug("Fin:getCiudad()");
		return comunas;
	}	
		
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListCicloFactOutDTO getListadoCiclosPostPago() {
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsListCicloFactOutDTO retValue = new WsListCicloFactOutDTO();
		try{
			logger.debug("SpnSclWSBean: getListadoCiclosPostPago:start");
			String cicloFact = "25";
			//if (Utilitarios.isNumber(cicloFact)){
				WsCicloFactInDTO cicloFactDTO=new WsCicloFactInDTO();
				cicloFactDTO.setCodCiclo(Integer.parseInt(cicloFact));
				retValue=getSpnSclORQ().getListadoCiclosPostPago(cicloFactDTO);
				retValue.setResultadoTransaccion("0");
				retValue.setCodError("0");
				UtilLog.setLog(config.getString("CatalogoBean.log"));
			//}*/
			/*else{
				retValue.setCodError("1");
				retValue.setResultadoTransaccion("Debe ingresar un valor numérico en ciclo de facturación");
			}*/
			logger.debug("SpnSclWSBean: getListadoCiclosPostPago:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion("1");
			retValue.setCodError("|"+e.getCodigo()+"|");
			//throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);
			
		}
		return retValue;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO[] getTipoComisionista(){
		//RSIS 012
		VendedorDTO[] retValue=null;
		try{
			UtilLog.setLog(config.getString("CatalogoBean.log"));	
			logger.debug("GestionDeClienteBean: getTipoComisionista:start");
			retValue=getSpnSclORQ().getTipoComisionista();
			UtilLog.setLog(config.getString("CatalogoBean.log"));	
			logger.debug("GestionDeClienteBean: getTipoComisionista:end");
		}catch(GeneralException e){
			logger.debug("GeneralException[", e);			
		} catch (Exception e) {
			logger.debug("Exception[", e);
		}
		return retValue;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListBancoOutDTO getListadoBancosPAC() {
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsListBancoOutDTO retValue = new WsListBancoOutDTO();
		try{
			logger.debug("SpnSclWSBean: getListadoBancosPAC:start");
			//if (Utilitarios.isNumber(""+wsBancoInDTO.getIndPAC())){
				retValue=getSpnSclORQ().getListadoBancosPAC();
				retValue.setResultadoTransaccion("0");
				retValue.setCodError("0");
				UtilLog.setLog(config.getString("CatalogoBean.log"));
			//}
			/*else{
				retValue.setResultadoTransaccion("Debe ingresar un valor numérico en indicador PAC de banco");
				retValue.setCodError("1");
			}*/
			logger.debug("SpnSclWSBean: getListadoBancosPAC:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion("1");
			retValue.setCodError("|"+e.getCodigo()+"|");
			//throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);
			
		}
		return retValue;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListTarjetaOutDTO getListadoTarjetas() {
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsListTarjetaOutDTO retValue = new WsListTarjetaOutDTO();
		try{
			logger.debug("SpnSclWSBean: getListadoTarjetas:start");
			retValue=getSpnSclORQ().getListadoTarjetas();
			retValue.setResultadoTransaccion("0");
			retValue.setCodError("0");
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getListadoTarjetas:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion("1");
			retValue.setCodError("|"+e.getCodigo()+"|");
			//throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return retValue;
	}
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CantidadStockSerieDTO getCantidadStockSerie(CantidadSerieDTO cantidadSerieDTO) {
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		CantidadStockSerieDTO cantidadStockSerieDTO  = null;
		try{
			logger.debug("SpnSclWSBean: getCantidadStockSerie:start");
			cantidadStockSerieDTO = getSpnSclORQ().getCantidadStockSerie(cantidadSerieDTO);
			logger.debug("cantidad stock: " + cantidadStockSerieDTO.getCantidadStock());
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getCantidadStockSerie:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
			cantidadStockSerieDTO.setResultadoTransaccion("1");
		}catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return cantidadStockSerieDTO;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SumaPrecioPlanesDTO getSumaPrecioPlanesXAntiguedad(SumaPlanesDTO sumaPlanesDTO){
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		SumaPrecioPlanesDTO sumaPrecioPlanesDTO = null;
		try{
			logger.debug("SpnSclWSBean: getSumaPrecioPlanesXAntiguedad:start");
			sumaPrecioPlanesDTO = getSpnSclORQ().getSumaPrecioPlanesXAntiguedad(sumaPlanesDTO);
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getSumaPrecioPlanesXAntiguedad:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
		}catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return sumaPrecioPlanesDTO;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsReglaSSOutDTO getReglasCompatibilidadSS(){
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsReglaSSOutDTO wsReglaSSOutDTO = null;
		try{
			logger.debug("SpnSclWSBean: getReglasCompatibilidadSS:start");
			wsReglaSSOutDTO = getSpnSclORQ().getReglasCompatibilidadSS();
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getReglasCompatibilidadSS:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
		}catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return wsReglaSSOutDTO;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsCategoriaImpostivaOutDTO getListCategImpositivas(){
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsCategoriaImpostivaOutDTO wsCategoriaImpostivaOutDTO = null;
		try{
			logger.debug("SpnSclWSBean: getListCategImpositivas:start");
			wsCategoriaImpostivaOutDTO = getSpnSclORQ().getListCategImpositivas();
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getListCategImpositivas:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
		}catch (Exception e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return wsCategoriaImpostivaOutDTO;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsActividadesOutDTO getListActividades()  {
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsActividadesOutDTO wsActividadesOutDTO = null;
		try{
			logger.debug("SpnSclWSBean: getListActividades:start");
			wsActividadesOutDTO = getSpnSclORQ().getListActividades();
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getListActividades:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
		}catch (Exception e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return wsActividadesOutDTO;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsOcupacionesOutDTO getListaOcupaciones()    {
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsOcupacionesOutDTO wsOcupacionesOutDTO = null;
		try{
			logger.debug("SpnSclWSBean: getListaOcupaciones:start");
			wsOcupacionesOutDTO = getSpnSclORQ().getListaOcupaciones();
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getListaOcupaciones:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
		}catch (Exception e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return wsOcupacionesOutDTO;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsSucursalesBancoOutDTO getSucursalesBanco(SucursalBancoDTO sucursalBancoDTO){
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsSucursalesBancoOutDTO wsSucursalesBancoOutDTO = null;
		try{
			logger.debug("SpnSclWSBean: getSucursalesBanco:start");
			wsSucursalesBancoOutDTO = getSpnSclORQ().getSucursalesBanco(sucursalBancoDTO);
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getSucursalesBanco:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
		}catch (Exception e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return wsSucursalesBancoOutDTO;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsClasificacionCuentaOutDTO getClasificacionCuenta(){
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsClasificacionCuentaOutDTO wsClasificacionCuentaOutDTO = null;
		try{
			logger.debug("SpnSclWSBean: getClasificacionCuenta:start");
			wsClasificacionCuentaOutDTO = getSpnSclORQ().getClasificacionCuenta();
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getClasificacionCuenta:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
		}catch (Exception e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return wsClasificacionCuentaOutDTO;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsHomeLineaOutDTO getHomeLinea(DireccionCentralDTO direccionCentralDTO){
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsHomeLineaOutDTO wsHomeLineaOutDTO = null;
		try{
			logger.debug("SpnSclWSBean: getHomeLinea:start");
			wsHomeLineaOutDTO = getSpnSclORQ().getHomeLinea(direccionCentralDTO);
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getHomeLinea:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
		}catch (Exception e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return wsHomeLineaOutDTO;
	}
	
	
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WSEstadoCivilOutDTO getListaEstadoCivil()    {
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WSEstadoCivilOutDTO wsEstadoCivilOutDTO = null;
		try{
			logger.debug("SpnSclWSBean: getListaEstadoCivil:start");
			wsEstadoCivilOutDTO = getSpnSclORQ().getListaEstadoCivil();
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getListaEstadoCivil:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
		}catch (Exception e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return wsEstadoCivilOutDTO;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsEstadoOutDTO getListaEstados()    {
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsEstadoOutDTO wsEstadoDTO = null;
		try{
			logger.debug("SpnSclWSBean: getListaEstados:start");
			wsEstadoDTO = getSpnSclORQ().getListaEstados();
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("SpnSclWSBean: getListaEstados:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
		}catch (Exception e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);	
		}
		return wsEstadoDTO;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public PuebloDTO[] getListadoPueblos(EstadoDTO estado) {		 
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		logger.debug("Inicio:getPueblos()");
		PuebloDTO[] Pueblos = null;
		try{			                                       
			Pueblos = getSpnSclORQ().getListadoPueblos(estado);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
		}
		logger.debug("Fin:getPueblos()");
		return Pueblos;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn){
		UtilLog.setLog(config.getString("CatalogoBean.log"));
		WsListConsultaPlanTarifarioOutDTO retValue = new WsListConsultaPlanTarifarioOutDTO();
		try{
			ArrayList listaErrores =new ArrayList();
				logger.debug("SpnSclWSBean: getListadoPlanesTarifarios:start");
				retValue=getSpnSclORQ().getConsultaPlanesTarifarios(consultaPlanTarifarioIn);
				retValue.setResultadoTransaccion("0");
				retValue.setCodError("0");
				UtilLog.setLog(config.getString("CatalogoBean.log"));
				logger.debug("SpnSclWSBean: getListadoPlanesTarifarios:end");
			
			if (listaErrores.size()>0){
				String codErro = "|" ;
				for(int i=0; i< listaErrores.size(); i++){
					codErro = codErro +  listaErrores.get(i) +"|";					
				}
				retValue.setCodError(codErro);		
				retValue.setResultadoTransaccion("1");				
			}
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion("1");
			retValue.setCodError("|"+e.getCodigo()+"|");
			retValue.setMensajseError(e.getDescripcionEvento());
			//throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("CatalogoBean.log"));
			logger.debug("Exception[", e);
			
		}
		return retValue;
	}
	
	
	
	
	
	
	
}
