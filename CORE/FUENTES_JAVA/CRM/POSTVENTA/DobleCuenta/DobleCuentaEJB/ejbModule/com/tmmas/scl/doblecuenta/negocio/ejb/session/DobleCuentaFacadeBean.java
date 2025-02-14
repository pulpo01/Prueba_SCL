/**
 * 
 */
package com.tmmas.scl.doblecuenta.negocio.ejb.session;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClientesAsociadosDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.RetornoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.service.helper.Global;
import com.tmmas.scl.doblecuenta.service.interfaz.DobleCuentaSrvFactoryIF;
import com.tmmas.scl.doblecuenta.service.interfaz.DobleCuentaSrvIF;
import com.tmmas.scl.doblecuenta.service.servicios.DobleCuentaSrvFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacadeHome;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="DobleCuentaFacade"	
 *           description="An EJB named DobleCuentaFacade"
 *           display-name="DobleCuentaFacade"
 *           jndi-name="DobleCuentaFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class DobleCuentaFacadeBean implements javax.ejb.SessionBean {

	private static final long serialVersionUID = 1L;

	private SessionContext context = null;
	
	//private Global global =  Global.getInstance();
	
	private final Logger logger = Logger.getLogger(DobleCuentaFacadeBean.class);
	
	private CompositeConfiguration config; // MA
	
	private void setPropertieFile() {
//		  inicio MA
		     String strRuta = "/com/tmmas/cl/DobleCuentaEJB/properties/";
		     String srtRutaDeploy = System.getProperty("user.dir");
		     String strArchivoProperties= "DobleCuentaEJB.properties";
		     String strArchivoLog="DobleCuentaEJB.log";
		     String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
		     config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		     UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		     // fin MA           
	}
	
	
	//Instancia el factory
	DobleCuentaSrvFactoryIF factorySrv1 = new DobleCuentaSrvFactory();
	//Obtiene el application service
	DobleCuentaSrvIF service1 = factorySrv1.getApplicationService1();
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.create-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
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
	 */
	public ConceptoDTO[] obtenerListaConceptos() throws ProyectoException{
		
		System.out.println("entramos con exito obtenerListaConceptosEJB()");
		ConceptoDTO[] listaConcepFacturas = null;
		try{
			//String log = global.getValor("negocio.log");
			//log = System.getProperty("user.dir") + log;
			//PropertyConfigurator.configure(log);
			
			setPropertieFile();// MA
			
			logger.debug("obtenerListaConceptosService():start");
			listaConcepFacturas = service1.obtenerListaConceptos();
			logger.debug("obtenerListaConceptosService():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Throwable e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerListaConceptosEJB()");
		return listaConcepFacturas;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */
	public AbonadoDTO[] obtenerListaAbonado(AbonadoDTO abonado) throws ProyectoException{
		
		System.out.println("entramos con exito obtenerListaAbonadoEJB()");
		AbonadoDTO[] abonadosList = null;
		try{
			//String log = global.getValor("negocio.log");
			//log = System.getProperty("user.dir") + log;
			//PropertyConfigurator.configure(log);
			
			setPropertieFile();// MA
			
			logger.debug("obtenerListaAbonadoService():start");
			abonadosList = service1.obtenerListaAbonado(abonado);
			logger.debug("obtenerListaAbonadoService():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Throwable e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerListaAbonadoEJB()");
		return abonadosList;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */
	public ClienteDTO obtenerInformacionCliente(ClienteDTO clienteContratante) throws ProyectoException{
		
		System.out.println("entramos con exito obtenerInformacionClienteEJB()");
		ClienteDTO respuesta = null;
		try{
			//String log = global.getValor("negocio.log");
			//log = System.getProperty("user.dir") + log;
			//PropertyConfigurator.configure(log);
			
			setPropertieFile();// MA
			
			logger.debug("obtenerInformacionClienteService():start");
			respuesta = service1.obtenerInformacionCliente(clienteContratante);
			logger.debug("obtenerInformacionClienteService():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Throwable e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerInformacionClienteEJB()");
		return respuesta;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */
	public ClienteDTO[] obtenerListaClientesAsociados(ClienteDTO cliente) throws ProyectoException{
		
		System.out.println("entramos con exito obtenerListaClientesAsociadosEJB()");
		ClienteDTO[] clienteList = null;
		try{
			//String log = global.getValor("negocio.log");
			//log = System.getProperty("user.dir") + log;
			//PropertyConfigurator.configure(log);
			
			setPropertieFile();// MA
			
			logger.debug("obtenerListaClientesAsociadosService():start");
			clienteList = service1.obtenerListaClientesAsociados(cliente);
			logger.debug("obtenerListaClientesAsociadosService():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Throwable e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerListaClientesAsociadosEJB()");
		return clienteList;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */	
	public RetornoDTO insertaFacturacionDiferenciadaCabecera(FacturaDTO factura, ClienteDTO cliente) throws ProyectoException{
		
		System.out.println("entramos con exito insertaFacturacionDiferenciadaCabeceraEJB()");
		RetornoDTO respuesta = null;
		try{
			
			//String log = global.getValor("negocio.log");
			//log = System.getProperty("user.dir") + log;
			//PropertyConfigurator.configure(log);
			
			setPropertieFile();// MA
			
			logger.debug("insertaFacturacionDiferenciadaCabeceraService():start");
			respuesta = service1.insertaFacturacionDiferenciadaCabecera(factura, cliente);
			logger.debug("insertaFacturacionDiferenciadaCabeceraService():end");
		} catch (ProyectoException e) {
			logger.debug("ProblemHandlingException");
			logger.debug("Rollbacking transaction...");
    		context.setRollbackOnly();
    		String log = StackTraceUtl.getStackTrace(e);
    		logger.debug("log error[" + log + "]");
    		throw e;
		} catch (Exception e) {
				logger.debug("Exception");
			    logger.debug("Rollbacking transaction...");
				context.setRollbackOnly();
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new ProyectoException(e);
     }
		System.out.println("salimos con exito insertaFacturacionDiferenciadaCabeceraEJB()");
		return respuesta;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */	
	public RetornoDTO insertarFacturacionDiferenciadaDetalle(FacturaDTO factura, AbonadoDTO abonado, ClienteDTO cliente, ConceptoDTO conceptos) throws ProyectoException{
		
		System.out.println("entramos con exito insertarFacturacionDiferenciadaDetalleEJB()");
		RetornoDTO respuesta = null;
		try{
			//String log = global.getValor("negocio.log");
			//log = System.getProperty("user.dir") + log;
			//PropertyConfigurator.configure(log);
			
			setPropertieFile();// MA
			
			logger.debug("insertarFacturacionDiferenciadaDetalleService():start");
			respuesta = service1.insertarFacturacionDiferenciadaDetalle(factura, abonado, cliente, conceptos);
			logger.debug("insertarFacturacionDiferenciadaDetalleService():end");
		} catch (ProyectoException e) {
			logger.debug("ProblemHandlingException");
			logger.debug("Rollbacking transaction...");
    		context.setRollbackOnly();
    		String log = StackTraceUtl.getStackTrace(e);
    		logger.debug("log error[" + log + "]");
    		throw e;
		} catch (Exception e) {
				logger.debug("Exception");
			    logger.debug("Rollbacking transaction...");
				context.setRollbackOnly();
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new ProyectoException(e);
     }
		System.out.println("salimos con exito insertarFacturacionDiferenciadaDetalleEJB()");
		return respuesta;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */	
	public RetornoDTO updateFacturacionDiferenciadaCabecera(ClienteDTO cliente, AbonadoDTO abonado, FacturaDTO factura) throws ProyectoException{
		
		System.out.println("entramos con exito updateFacturacionDiferenciadaCabeceraEJB()");
		RetornoDTO respuesta = null;
		try{
			//String log = global.getValor("negocio.log");
			//log = System.getProperty("user.dir") + log;
			//PropertyConfigurator.configure(log);
			
			setPropertieFile();// MA
			
			logger.debug("updateFacturacionDiferenciadaCabeceraService():start");
			respuesta = service1.updateFacturacionDiferenciadaCabecera(cliente, abonado, factura);
			logger.debug("updateFacturacionDiferenciadaCabeceraService():end");
		} catch (ProyectoException e) {
			logger.debug("ProblemHandlingException");
			logger.debug("Rollbacking transaction...");
    		context.setRollbackOnly();
    		String log = StackTraceUtl.getStackTrace(e);
    		logger.debug("log error[" + log + "]");
    		throw e;
     } catch (Exception e) {
    	 		logger.debug("Exception");
    	 		logger.debug("Rollbacking transaction...");
				context.setRollbackOnly();
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new ProyectoException(e);
     }
		return respuesta;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */	
	public ClientesAsociadosDTO[] buscarClientesAsociados(ClienteDTO clienteContratante) throws ProyectoException{
		
		System.out.println("entramos con exito updateFacturacionDiferenciadaCabeceraEJB()");
		ClientesAsociadosDTO[] clientes = null;
		try{
			//String log = global.getValor("negocio.log");
			//log = System.getProperty("user.dir") + log;
			//PropertyConfigurator.configure(log);
			setPropertieFile();// MA
			
			logger.debug("buscarClientesAsociadosService():start");
			clientes = service1.buscarClientesAsociados(clienteContratante);
			logger.debug("buscarClientesAsociadosService():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Throwable e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		return clientes;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */	
	public RetornoDTO bajaMasivaFacturacion(FacturaDTO factura) throws ProyectoException {
		
		System.out.println("entramos con exito updateFacturacionDiferenciadaCabeceraEJB()");
		RetornoDTO respuesta = null;
		try{
			//String log = global.getValor("negocio.log");
			//log = System.getProperty("user.dir") + log;
			//PropertyConfigurator.configure(log);
			
			setPropertieFile();// MA
			
			logger.debug("bajaMasivaFacturacionService():start");
			respuesta = service1.bajaMasivaFacturacion(factura);
			logger.debug("bajaMasivaFacturacionService():end");
		} catch (ProyectoException e) {
			logger.debug("ProblemHandlingException");
			logger.debug("Rollbacking transaction...");
    		context.setRollbackOnly();
    		String log = StackTraceUtl.getStackTrace(e);
    		logger.debug("log error[" + log + "]");
    		throw e;
		} catch (Exception e) {
				logger.debug("Exception");
			    logger.debug("Rollbacking transaction...");
				context.setRollbackOnly();
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new ProyectoException(e);
     }
		return respuesta;
		
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO parametro) throws ProyectoException{	
		
		System.out.println("entramos con exito obtenerSecuenciaEJB()");
		SecuenciaDTO respuesta = null;
		try{
			
			setPropertieFile();// MA
			
			logger.debug("obtenerSecuencia en EJB():start");
				respuesta = service1.obtenerSecuencia(parametro);
			logger.debug("obtenerSecuencia en EJB():end");
			logger.debug("buscarClientesAsociadosService():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Throwable e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		
		return respuesta;
		
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */	
	public long[][] ejecutaOS(String [] datosAsociadosChequeados, ClienteDTO cliente, FacturaDTO facturaDTO, long secuenciaInsertar, ArrayList listGri, RetornoDTO retorno, SecuenciaDTO sec) throws ProyectoException {
		long[][] respuesta = null;
		try{
			//String log = global.getValor("negocio.log");
			//log = System.getProperty("user.dir") + log;
			//PropertyConfigurator.configure(log);
			
			setPropertieFile();// MA
			Global global = Global.getInstance();
			logger.debug("ejecutaOS():start");
			respuesta = service1.ejecutaOS(datosAsociadosChequeados, cliente, facturaDTO, secuenciaInsertar, listGri, retorno);

			RegistrarOossEnLineaDTO registroLinea = new RegistrarOossEnLineaDTO();
            registroLinea.setCodOS(global.getValor("codigo.ooss"));
            registroLinea.setNumOs(sec.getNumSecuencia());
            registroLinea.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
            registroLinea.setTipInter(Integer.parseInt(global.getValor("tip.inter")));
            registroLinea.setCodInter(cliente.getCodClienteContra());
            registroLinea.setUsuario(facturaDTO.getUser());
            registroLinea.setFecha(new Date());
            registroLinea.setComentario("Facturación Diferenciada");
            com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO retornoDTO = null;
            retornoDTO = this.getCloCusOrdFacade().registrarOOSSEnLinea(registroLinea);

            //TODO validar retorno
            
			logger.debug("ejecutaOS():end");
		} catch (ProyectoException e) {
			logger.debug("ProblemHandlingException");
			logger.debug("Rollbacking transaction...");
    		context.setRollbackOnly();
    		String log = StackTraceUtl.getStackTrace(e);
    		logger.debug("log error[" + log + "]");
    		throw e;
		} catch (Exception e) {
				logger.debug("Exception");
			    logger.debug("Rollbacking transaction...");
				context.setRollbackOnly();
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new ProyectoException(e);
     }
		return respuesta;
	}
	
	private CloCusOrdFacade getCloCusOrdFacade() throws ProyectoException {

		/*String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);*/

		logger.debug("getCloCusOrdFacade():start");
		Global global = Global.getInstance();
		String jndi = global.getValor("jndi.CloCusOrdFacade");
		logger.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.CloCusOrdFacade");
		logger.debug("Url provider[" + url + "]");

		Hashtable env = new Hashtable();
		//env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		//env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		//env.put(Context.SECURITY_CREDENTIALS, securityCredentials);

		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}

		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}

		CloCusOrdFacadeHome facadeHome =
			(CloCusOrdFacadeHome) PortableRemoteObject.narrow(obj, CloCusOrdFacadeHome.class);	

		logger.debug("Recuperada interfaz home de CloCusOrdFacade...");
		CloCusOrdFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ProyectoException(e);

		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		logger.debug("getCloCusOrdFacade():end");
		return facade;
	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException {

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {

	}

	/**
	 * 
	 */
	public DobleCuentaFacadeBean() {
	}
}
