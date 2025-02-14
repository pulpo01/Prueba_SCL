package com.tmmas.scl.doblecuenta.delegate;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClientesAsociadosDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.RetornoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.helper.Global;
import com.tmmas.scl.doblecuenta.negocio.ejb.session.DobleCuentaFacade;
import com.tmmas.scl.doblecuenta.negocio.ejb.session.DobleCuentaFacadeHome;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session.DetCusOrdFeaFacade;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session.DetCusOrdFeaFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.common.exception.DetCusOrdFeaException;

/**
 * 
 * @author Matías Guajardo U.
 * @version 1.0
 *
 */

public class ManageRequestBussinessDelegate {

	private Global global = Global.getInstance();
	private static Logger logger = Logger.getLogger(ManageRequestBussinessDelegate.class);
	private static ManageRequestBussinessDelegate instance = null;

	protected ServiceLocator svcLologgeror = ServiceLocator.getInstance();

	public static ManageRequestBussinessDelegate getInstance() {
		if (instance == null) {
			instance = new ManageRequestBussinessDelegate();
		}
		return instance;
	}

	//DobleCuentaFacade
	private DobleCuentaFacade getDobleCuentaFacade() throws ProyectoException {

		//String log = global.getValor("web.log");
		//PropertyConfigurator.configure(log);

		logger.debug("getDobleCuentaFacade():start");

		String jndi = global.getValor("jndi.DobleCuentaFacade");
		logger.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.DobleCuentaProvider");
		logger.debug("Url provider[" + url + "]");

		Hashtable env = new Hashtable();
		//env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		//env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		//env.put(Context.SECURITY_CREDENTIALS, securityCredentials);

		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext();//env);
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

		DobleCuentaFacadeHome facadeHome =
			(DobleCuentaFacadeHome) PortableRemoteObject.narrow(obj, DobleCuentaFacadeHome.class);	

		logger.debug("Recuperada interfaz home de DobleCuentaFacade...");
		DobleCuentaFacade facade = null;
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
		logger.debug("getDobleCuentaFacade():end");
		return facade;
	}
	
	private DetCusOrdFeaFacade getDetCusOrdFeaFacade() throws ProyectoException {

		/*String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);*/

		logger.debug("getDetCusOrdFeaFacade():start");

		String jndi = global.getValor("jndi.DetCusOrdFeaFacade");
		logger.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.DetCusOrdFeaProvider");
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

		DetCusOrdFeaFacadeHome facadeHome =
			(DetCusOrdFeaFacadeHome) PortableRemoteObject.narrow(obj, DetCusOrdFeaFacadeHome.class);	

		logger.debug("Recuperada interfaz home de DetCusOrdFeaFacade...");
		DetCusOrdFeaFacade facade = null;
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
		logger.debug("getDetCusOrdFeaFacade():end");
		return facade;
	}

	/**
	 * Obtiene lista de conceptos facturables
	 * @author Matías Guajardo U.
	 */
	public ConceptoDTO[] obtenerConceptosFact() throws ProyectoException{

		ConceptoDTO[] respuesta = null;
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerConceptosFactDelegate():start");
		try{
			respuesta = getDobleCuentaFacade().obtenerListaConceptos();
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		logger.debug("obtenerConceptosFactDelegate():end");
		return respuesta;
	}

	/**
	 * Busca abonados según criterio de búsqueda
	 * @author Matías Guajardo U.
	 */
	public AbonadoDTO[] obtenerListaAbonado(AbonadoDTO abonado) throws ProyectoException{

		AbonadoDTO[] respuesta = null;
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);
		logger.debug("obtenerListaAbonadoDelegate():start");
		try{
			respuesta = getDobleCuentaFacade().obtenerListaAbonado(abonado);
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		logger.debug("obtenerListaAbonadoDelegate():end");
		return respuesta;
	}

	/**
	 * Busca la información del cliente contratante
	 * @author Matias Guajardo
	 */
	public ClienteDTO obtenerInformacionCliente(ClienteDTO clienteContratante) throws ProyectoException{

		ClienteDTO respuesta = null;
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerInformacionClienteDelegate():start");
		try{
			respuesta = getDobleCuentaFacade().obtenerInformacionCliente(clienteContratante);
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		return respuesta;
	}
	
	/**
	 * Obtiene la lista de clientes asociados
	 * @author Matías Guajardo U.
	 */
	public ClienteDTO[] obtenerListaClientesAsociados(ClienteDTO cliente) throws ProyectoException{
		
		ClienteDTO[] clienteList = null;
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerListaClientesAsociadosDelegate():start");
		try{
			clienteList = getDobleCuentaFacade().obtenerListaClientesAsociados(cliente);
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		return clienteList;
	}
	
	/**
	 * insert cabecera
	 */
	
	public RetornoDTO insertaFacturacionDiferenciadaCabecera(FacturaDTO factura, ClienteDTO cliente) throws ProyectoException{
		
		RetornoDTO respuesta = null;
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);		
		logger.debug("oinsertaFacturacionDiferenciadaCabeceraDelegate():start");
		try{
			respuesta = getDobleCuentaFacade().insertaFacturacionDiferenciadaCabecera(factura, cliente);
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		return respuesta;
	}
	
	
	/**
	 * insert detalle
	 */
	public RetornoDTO insertarFacturacionDiferenciadaDetalle(FacturaDTO factura, AbonadoDTO abonado, ClienteDTO cliente, ConceptoDTO conceptos) throws ProyectoException{
		
		RetornoDTO respuesta = null;
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);		
		logger.debug("insertarFacturacionDiferenciadaDetalleDelegate():start");
		try{
			respuesta = getDobleCuentaFacade().insertarFacturacionDiferenciadaDetalle(factura, abonado, cliente, conceptos);
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		return respuesta;
		
	}
	
	/**
	 * update de la factura
	 * @param cliente
	 * @param abonado
	 * @param factura
	 * @return
	 * @throws ProyectoException
	 * @author Matías Guajardo 
	 */
	public RetornoDTO updateFacturacionDiferenciadaCabecera(ClienteDTO cliente, AbonadoDTO abonado, FacturaDTO factura) throws ProyectoException {
		
		RetornoDTO respuesta = null;
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);		
		logger.debug("updateFacturacionDiferenciadaCabeceraDelegate():start");
		try{
			respuesta = getDobleCuentaFacade().updateFacturacionDiferenciadaCabecera(cliente, abonado, factura);
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		logger.debug("updateFacturacionDiferenciadaCabeceraDelegate():end");
		return respuesta;
	}
	
	/**
	 * 
	 * @param clienteContratante
	 * @return
	 * @throws ProyectoException
	 * @author Matías Guajardo
	 */
	public ClientesAsociadosDTO[] buscarClientesAsociados(ClienteDTO clienteContratante) throws ProyectoException {
		
		ClientesAsociadosDTO[] clientes = null;
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);	
		logger.debug("buscarClientesAsociadosDelegate():start");
		try{
			clientes = getDobleCuentaFacade().buscarClientesAsociados(clienteContratante);
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		logger.debug("buscarClientesAsociadosDelegate():end");
		return clientes;
	}	
	
	/**
	 * Baja masiva doble factura
	 * @param factura
	 * @return
	 * @throws ProyectoException
	 */
	public RetornoDTO bajaMasivaFacturacion(FacturaDTO factura) throws ProyectoException{
		
		RetornoDTO respuesta = null;
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);		
		logger.debug("bajaMasivaFacturacionDelegate():start");
		try{
			respuesta = getDobleCuentaFacade().bajaMasivaFacturacion(factura);
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		logger.debug("bajaMasivaFacturacionDelegate():end");
		return respuesta;
	}

	public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO validaRestricciones(RestriccionesDTO restricciones) throws ProyectoException {
		
		com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO respuesta = null;
		//String log = global.getValor("web.log");
		//PropertyConfigurator.configure(log);
		logger.debug("validaRestriccionesDelegate():start");
		try{
			respuesta = getDetCusOrdFeaFacade().validaRestriccionComerOoss(restricciones);
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		} catch (DetCusOrdFeaException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("DetCusOrdFeaException[" + loge + "]");
			throw new ProyectoException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		logger.debug("validaRestriccionesDelegate():end");
		return respuesta;
	}
	
	public long[][] ejecutaOS(String [] datosAsociadosChequeados, ClienteDTO cliente, FacturaDTO facturaDTO, long secuenciaInsertar, ArrayList listGri, RetornoDTO retorno, SecuenciaDTO sec) throws ProyectoException {
		
		long[][] respuesta = null;
		//String log = global.getValor("web.log");
		//PropertyConfigurator.configure(log);
		logger.debug("ejecutaOS():start");
		try{
			respuesta = getDobleCuentaFacade().ejecutaOS(datosAsociadosChequeados, cliente, facturaDTO, secuenciaInsertar, listGri, retorno,  sec);
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		logger.debug("ejecutaOS():end");
		return respuesta;
	}

	/**
	 * Obtiene secuencia
	 * 
	 * @param secuencia
	 * @return SecuenciaDTO
	 * @throws ProyectoException
	 */
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO parametro) throws ProyectoException{	
	
		SecuenciaDTO respuesta = null;
		//String log = global.getValor("web.log");
		//log=System.getProperty("user.dir")+ log;
		//PropertyConfigurator.configure(log);		
		logger.debug("ManageRequestBussinessDelegate.obtenerSecuencia():start");
		try {
			
			respuesta = getDobleCuentaFacade().obtenerSecuencia(parametro);
			
		}catch(ProyectoException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProyectoException(e);
		}
		logger.debug("ejecutaOS():end");
		return respuesta;
	}
}
