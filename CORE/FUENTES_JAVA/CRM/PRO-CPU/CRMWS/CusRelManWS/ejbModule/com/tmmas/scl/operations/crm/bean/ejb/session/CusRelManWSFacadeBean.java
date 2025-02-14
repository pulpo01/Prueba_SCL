/**
 * 
 */
package com.tmmas.scl.operations.crm.bean.ejb.session;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.SOAPGeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.IntegracionInClasificacionDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ActDesPlanAdicDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AuditoriaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.InActDesPlanAdicDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.InActDesPlanAdicWSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.InNumerosFrecuentesDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.InWSNumFrecuenteDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ContratanteBeneficiarioDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.bean.ejb.helper.validacionesForma;
import com.tmmas.scl.operations.crm.common.Exception.CusRelManWSException;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosConsultaProductoDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosContrModulosDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosInListarNumerosFrecuentesDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosInWSListaPLanesDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosObtProductosContratadosDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosOutWSListaPLanesDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosOutWSObtenerModProductoDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.InWsClasifClienteDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.NumeroCategDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.OutWsDatosOutBeneficioDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.ProdOfertablesBenefDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.RespProductoContratadoSimpleDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.RetornoConTokenDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.RetornoListaNumerosDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.ValidacionAbonadoDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.WSListaProdOferDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.WSPlanesAdicionalesContratadosDTO;
import com.tmmas.scl.operations.crm.delegate.helper.CRMUtils;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.CambioPlanAdicionalDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosInBeneficioDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.PlanesAdicionalesDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="CusRelManWSFacade"	
 *           description="An EJB named CusRelManWSFacade"
 *           display-name="CusRelManWSFacade"
 *           jndi-name="CusRelManWSFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class CusRelManWSFacadeBean implements javax.ejb.SessionBean 
{	
	private SessionContext context = null;
	private final Logger logger = Logger.getLogger(CusRelManWSFacadeBean.class);	
	private Global global=Global.getInstance();
	private CusRelManFacade cusRelManFacade=null;
	protected CRMUtils cRMUtils =  CRMUtils.getInstance(); 

	
	
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
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);	
	}
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws SupOrdHanException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO sendToQueueAnulacionVenta(DatosVentaDTO datosVenta) throws CusRelManWSException,RemoteException
	{		
		logger.debug("sendToQueueAnulacionVenta:start");
		logger.debug("datosVenta[" + datosVenta.getCod_cliente() + "]");
		RetornoDTO retorno=null;
		/**
		 * Creo el proceso 
		 */
		try{
			
			retorno=this.getCusRelManFacade().sendToQueueAnulacionVenta(datosVenta);
			
			logger.debug("sendToQueueAnulacionVenta:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;
	}
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManConException 
	 * @throws ManProOffInvException 
	 * @throws NegSalException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO sendToQueueActivacionDesactivacionVenta(String numeroVenta,String codigoCliente) throws CusRelManWSException,RemoteException
	{	
		RetornoDTO retorno=null; 
		try{
			 
			 this.getCusRelManFacade().sendToQueueActivacionDesactivacionVenta(numeroVenta, codigoCliente);
			 }
		 catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		 }
		return retorno;
	}
	
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManConException 
	 * @throws ManProOffInvException 
	 * @throws NegSalException 
	 * @throws SupOrdHanException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO sendToQueueActivacionProductosPorDefecto(DatosVentaDTO datosVenta) throws CusRelManWSException,RemoteException
	{	
		
		RetornoDTO retorno=null;
		
		try{
			retorno=this.getCusRelManFacade().sendToQueueActivacionProductosPorDefecto(datosVenta);
		}
		catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		 }
		return retorno;
	}
	
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws SupOrdHanException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO sendToQueueRechazoVenta(DatosVentaDTO datosVenta) throws CusRelManWSException,RemoteException
	{			
		
		RetornoDTO retorno=null;
		try{
			retorno=this.getCusRelManFacade().sendToQueueRechazoVenta(datosVenta);
		}
		catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;
	}
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManConException 
	 * @throws ManCusInvException 
	 * @throws ManProOffInvException 
	 * @throws NegSalException 
	 * @throws SupOrdHanException 
	 * @throws IssCusOrdException 
	 * @throws RemoteException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO activarDesactivarMantenerProductos(CambioPlanAdicionalDTO[] cambioPlanAdicionalArr) throws CusRelManWSException, RemoteException
	{
		RetornoDTO retorno =null;
		try{
			retorno=this.getCusRelManFacade().activarDesactivarMantenerProductos(cambioPlanAdicionalArr);
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;
	}
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws IssCusOrdException 
	 * @throws RemoteException 
	 * @throws SupOrdHanException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO mantencionPlanesAdicionales(PlanesAdicionalesDTO[] planesAdicionales) throws  CusRelManWSException, RemoteException
	{
		RetornoDTO retorno =null;
		try{
			retorno=this.getCusRelManFacade().mantencionPlanesAdicionales(planesAdicionales);
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;		
	}
	
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManConException 
	 * @throws ManProOffInvException 
	 * @throws NegSalException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public OutWsDatosOutBeneficioDTO obtenerProductosOfertablesBeneficiario(DatosInBeneficioDTO datosInBeneficio) throws  CusRelManWSException, RemoteException
	//, SOAPGeneralException
	{	
		OutWsDatosOutBeneficioDTO retorno= new OutWsDatosOutBeneficioDTO();
		RetornoDTO retValue= new RetornoDTO();
		try{
			retorno.setDatosOutBeneficioDTO(this.getCusRelManFacade().obtenerProductosOfertablesBeneficiario(datosInBeneficio));
			retValue.setResultado(true);
		}catch(GeneralException e){
			retValue.setCodigo(e.getCodigo());
			retValue.setDescripcion(e.getDescripcionEvento());
		 	retValue.setResultado(false);
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			//throw new CusRelManWSException(e);
		}
		retorno.setRetornoDTO(retValue);
		return retorno;	
	}
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/	
	/* 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws RemoteException 
	 * @throws SOAPGeneralException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 *
	public RetornoDTO contratacionPlanesAdicionalesOpcionales
	(DatosContrPlanesAdicDTO datosContratacion) throws CusRelManWSException, RemoteException{
		
		RetornoDTO retorno =null;
		try{
			retorno=this.getCusRelManFacade().contratacionPlanesAdicionalesOpcionales(datosContratacion);
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;	
	}*/
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws RemoteException 
	 * @throws SOAPGeneralException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO contratacionModulos(DatosContrModulosDTO datosContratacion) 
	throws CusRelManWSException, RemoteException{
		RetornoDTO retorno =null;
		try{
			retorno=this.getCusRelManFacade().contratacionModulos(datosContratacion);
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;	
	}
	
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws SOAPGeneralException 
	 * @throws RemoteException
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoListaNumerosDTO consultaDetalleProductoContratado(DatosConsultaProductoDTO datosConsulta)	throws CusRelManWSException, RemoteException{

		RetornoListaNumerosDTO retorno =null;
		try{
			retorno=this.getCusRelManFacade().consultaDetalleProductoContratado(datosConsulta);
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;	
	}
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/		
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws RemoteException 
	 * @throws SOAPGeneralException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RespProductoContratadoSimpleDTO obtenerPlanesAdicionalesContratados(DatosObtProductosContratadosDTO datosObtProdContratadosDTO ) throws CusRelManWSException, RemoteException{		
		RespProductoContratadoSimpleDTO retorno =null;
		try{
			retorno=this.getCusRelManFacade().obtenerPlanesAdicionalesContratados(datosObtProdContratadosDTO);
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;	
	}

	
	
	
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws RemoteException 
	 * @throws SOAPGeneralException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RespProductoContratadoSimpleDTO consultarModulosContratados(DatosObtProductosContratadosDTO datosObtProdContratadosDTO ) throws CusRelManWSException, RemoteException{
		logger.debug("consultarModulosContratados():start");
		RespProductoContratadoSimpleDTO retorno =null;
		try{
			logger.debug("consultarModulosContratados():antes");
			retorno=this.getCusRelManFacade().consultarModulosContratados(datosObtProdContratadosDTO);
			logger.debug("consultarModulosContratados():despues");
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		logger.debug("consultarModulosContratados():end");
		return retorno;	
	}
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws RemoteException 
	 * @throws SOAPGeneralException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validarContratanteBeneficiario(ContratanteBeneficiarioDTO contratanteBeneficiarioDTO) throws CusRelManWSException, RemoteException{		
		RetornoDTO retorno =null;
		try{
			retorno=this.getCusRelManFacade().validarContratanteBeneficiario(contratanteBeneficiarioDTO);
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;	
	}
	/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/	
		/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws SupOrdHanException 
	 * @throws RemoteException
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosOutWSListaPLanesDTO obtenerPlanesAdicionales(DatosInWSListaPLanesDTO datosInWSListaPLanesDTO) throws CusRelManWSException, RemoteException{		
		DatosOutWSListaPLanesDTO retorno =null;
		try{
			retorno=this.getCusRelManFacade().obtenerPlanesAdicionales(datosInWSListaPLanesDTO);
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;	
	}
/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws SupOrdHanException 
	 * @throws RemoteException
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosOutWSObtenerModProductoDTO obtenerModificacionesProducto(ProductoContratadoDTO productoContratado)throws CusRelManWSException, RemoteException{
		DatosOutWSObtenerModProductoDTO retorno =null;
		try{
			retorno=this.getCusRelManFacade().obtenerModificacionesProducto(productoContratado);
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;	
	}
	

/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
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
		this.context=arg0;

	}

	/**
	 * 
	 */
	public CusRelManWSFacadeBean() {
		// TODO Auto-generated constructor stub
	}
	
	
	 public CusRelManFacade getCusRelManFacade() throws CusRelManWSException 
		{
			try 
			{
				if(cusRelManFacade==null)
				{
					String urlProvider = global.getValor("url.CusRelManEJBProvider");
					String 	EJBJndi =global.getValor("jndi.CusRelManFacade");
					Hashtable env=null;
					Object obj=null;
				 	env = new Hashtable();
					logger.debug("Instanciando EJB ["+EJBJndi+"]");
					env.put(Context.INITIAL_CONTEXT_FACTORY, global.getValor("initial.context.factory"));		
					env.put(Context.SECURITY_PRINCIPAL, global.getValor("security.principal"));
					env.put(Context.SECURITY_CREDENTIALS, global.getValor("security.credentials"));
					env.put(Context.PROVIDER_URL, urlProvider);

					Context context = new InitialContext(env);			
					obj = context.lookup(EJBJndi);
					logger.debug("WS ["+EJBJndi+"] instanciando");	
					CusRelManFacadeHome home =(CusRelManFacadeHome) PortableRemoteObject.narrow(obj, CusRelManFacadeHome.class);		
					cusRelManFacade = home.create();
				}
			}
			catch (Exception e) 
			{
				logger.error("Ocurrio un error al generar la instancia :"+e);
				throw new CusRelManWSException(e);			
			}		
			return cusRelManFacade;
		}
	 
	 /*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
	 /** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */
	public RetornoDTO activacionDePlanAdicional(InActDesPlanAdicWSDTO inactDesPlanAdicWSDTO) {
		
		RetornoDTO retorno =  new RetornoDTO();
		InActDesPlanAdicDTO inactDesPlanAdicDTO= new InActDesPlanAdicDTO();
		inactDesPlanAdicDTO.copiaCampos(inactDesPlanAdicWSDTO);
		
		//		 Validacion datos entrada
		if(inactDesPlanAdicDTO.getCanal()==null || inactDesPlanAdicDTO.getCanal().trim().length()==0){
			retorno.setCodigo("-1");
			retorno.setDescripcion("El parametro de entrada Canal es nulo o viene en blanco");
			retorno.setResultado(false);
			return retorno;
		}
		
		
		
		if(inactDesPlanAdicDTO.getUsuarioSCL()==null || inactDesPlanAdicDTO.getUsuarioSCL().trim().length()==0){
			
			retorno.setCodigo("-3");
			retorno.setDescripcion("El parametro de entrada UsuarioSCL es nulo o viene en blanco");
			retorno.setResultado(false);
			return retorno;
		}
		
		try{
			if(inactDesPlanAdicDTO.getNumAbonado()==null) throw new NumberFormatException();
			Long.parseLong(inactDesPlanAdicDTO.getNumAbonado());
		}catch(NumberFormatException e){
			
			retorno.setCodigo("-4");
			retorno.setDescripcion("El parametro de entrada número celular [NumAbonado] es nulo o no es numerico");
			retorno.setResultado(false);
			return retorno;
		}
		
		try{
			if(inactDesPlanAdicDTO.getCodigoProducto()==null) throw new NumberFormatException();
			Long.parseLong(inactDesPlanAdicDTO.getCodigoProducto());
		}catch(NumberFormatException e){
			
			retorno.setCodigo("-5");
			retorno.setDescripcion("El parametro de entrada CodigoProducto es nulo o no es numerico");
			retorno.setResultado(false);
			return retorno;
		}
		//inactDesPlanAdicWSDTO.
		/*if (inactDesPlanAdicWSDTO.getCodLimConsumo()==0){
			retorno.setCodigo("-6");
			retorno.setDescripcion("El parametro de entrada CodLimConsumo debe corresponcer a un valor válido");
			retorno.setResultado(false);
			return retorno;
		}
		if (inactDesPlanAdicWSDTO.getMntoLimConsumo()==0){
			retorno.setCodigo("-7");
			retorno.setDescripcion("El parametro de entrada mntoLimCOnsumo debe corresponcer a un valor válido");
			retorno.setResultado(false);
			return retorno;
		}*/
		
		
		// Fin validacion datos entrada
		try{
			
		
			/**
			 * @description Se valida la dto de Auditoria
			 */
			String mensajesAuditoria=this.validarAuditoria(inactDesPlanAdicDTO.getAuditoriaDTO());
			mensajesAuditoria=mensajesAuditoria==null?"":mensajesAuditoria;
			if ("".equals(mensajesAuditoria))
				{
				
				
				/**
				 * @author rlozano
				 * @date 26-01-2010
				 * @description Se setea el valor del Token
				 */
				ValidacionAbonadoDTO validacionAbonadoDTO = new ValidacionAbonadoDTO();
				
				validacionAbonadoDTO.setAbonado(inactDesPlanAdicDTO.getNumAbonado());
				validacionAbonadoDTO.setCanal(inactDesPlanAdicDTO.getCanal());
				validacionAbonadoDTO.setCodigoOOSS("40150");
				validacionAbonadoDTO.setUsuarioSCL(inactDesPlanAdicDTO.getUsuarioSCL());
				
				ActDesPlanAdicDTO actDesPlanAdicDTO= new ActDesPlanAdicDTO();
				
				actDesPlanAdicDTO.setCanal(inactDesPlanAdicDTO.getCanal());
				actDesPlanAdicDTO.setCodigoProducto(inactDesPlanAdicDTO.getCodigoProducto());
				actDesPlanAdicDTO.setNumAbonado(inactDesPlanAdicDTO.getNumAbonado());
				actDesPlanAdicDTO.setUsuarioSCL(inactDesPlanAdicDTO.getUsuarioSCL());
				actDesPlanAdicDTO.setCodLimConsumo(inactDesPlanAdicWSDTO.getCodLimConsumo());
				actDesPlanAdicDTO.setMntoLimConsumo(inactDesPlanAdicWSDTO.getMntoLimConsumo());
				actDesPlanAdicDTO.setToken(this.validacion(validacionAbonadoDTO).getToken());
				
				if(actDesPlanAdicDTO.getToken()==null || actDesPlanAdicDTO.getToken().trim().length()==0){
					retorno.setCodigo("-2");
					retorno.setDescripcion("El parametro de entrada Token es nulo o viene en blanco");
					retorno.setResultado(false);
					return retorno;
				}
				
				retorno = this.getCusRelManFacade().activacionDePlanAdicional(actDesPlanAdicDTO);
			}
			else
			{
				retorno.setCodigo("-6");
				retorno.setDescripcion(mensajesAuditoria);
				retorno.setResultado(false);
			}
		}
		catch (Exception e){
			e.printStackTrace();
			retorno = new RetornoDTO();
			retorno.setCodigo("-6");
			retorno.setDescripcion("["+e.getMessage()+"] - ["+e.getCause()+"]");
			
			context.setRollbackOnly();
		}
		
		if(!retorno.isResultado()){
			context.setRollbackOnly();
		}
		
		return retorno;
	 }
		
		
		
		
		public RetornoConTokenDTO validacion(ValidacionAbonadoDTO validacionAbonadoDTO) {
			RetornoConTokenDTO retorno = null;
			//Validacion del DTO de entrada
			if (validacionAbonadoDTO == null){
				retorno = new RetornoConTokenDTO();
				retorno.setCodigo("-1");
				retorno.setDescripcion("Debe ingresar parametros de entrada");
				retorno.setResultado(false);
				return retorno;
			}
			
			//Validacion datos entrada
			if(validacionAbonadoDTO.getUsuarioSCL()==null || validacionAbonadoDTO.getUsuarioSCL().trim().length()==0){
				retorno = new RetornoConTokenDTO();
				retorno.setCodigo("-2");
				retorno.setDescripcion("El parametro de entrada UsuarioSCL al metodo validacion viene nulo o en blanco");
				retorno.setResultado(false);
				return retorno;
			}
			try{
				if(validacionAbonadoDTO.getAbonado()==null) throw new NumberFormatException();
				Long.parseLong(validacionAbonadoDTO.getAbonado());
			}catch(NumberFormatException e){
				retorno = new RetornoConTokenDTO();
				retorno.setCodigo("-2");
				retorno.setDescripcion("El parametro de entrada Abonado al metodo validacion viene nulo o no es numerico");
				retorno.setResultado(false);
				return retorno;
			}
			if(validacionAbonadoDTO.getCanal()==null || validacionAbonadoDTO.getCanal().trim().length()==0){
				retorno = new RetornoConTokenDTO();
				retorno.setCodigo("-3");
				retorno.setDescripcion("El parametro de entrada Canal al metodo validacion viene nulo o no es numerico");
				retorno.setResultado(false);
				return retorno;
			}
			try{
				if(validacionAbonadoDTO.getCodigoOOSS() == null) throw new NumberFormatException();
					Long.parseLong(validacionAbonadoDTO.getCodigoOOSS());
			}catch(NumberFormatException e){
				retorno = new RetornoConTokenDTO();
				retorno.setCodigo("-5");
				retorno.setDescripcion("El parametro de entrada CodigoOOSS al metodo validacion viene nulo o no es numerico");
				retorno.setResultado(false);
				return retorno;
			}
			
			try{
				String codAct = global.getValor("cod.act.pa." + validacionAbonadoDTO.getCodigoOOSS().trim()).trim();
				if (codAct == null){
					retorno = new RetornoConTokenDTO();
					retorno.setCodigo("-4");
					retorno.setDescripcion("El parametro de entrada CodigoOOSS no tiene un codigo de actuacion");
					retorno.setResultado(false);
					return retorno;
				}
			}catch(NullPointerException e){
				retorno = new RetornoConTokenDTO();
				retorno.setCodigo("-4");
				retorno.setDescripcion("El parametro de entrada CodigoOOSS no tiene un codigo de actuacion");
				retorno.setResultado(false);
				return retorno;
			}
			//Fin validacion datos entrada
			try{
				retorno = this.getCusRelManFacade().validacion(validacionAbonadoDTO);
				
			}
			catch (Exception e){
				e.printStackTrace();
				retorno = new RetornoConTokenDTO();
				retorno.setCodigo("-6");
				retorno.setDescripcion(e.getMessage());
				retorno.setResultado(false);
				
				context.setRollbackOnly();
				
				return retorno;
			}
			
			if(!retorno.isResultado()){
				context.setRollbackOnly();
			}
			
			logger.debug(retorno);
			
			return retorno;
		}
		
		/** 
		 *
		 * <!-- begin-xdoclet-definition --> 
		 * @ejb.interface-method view-type="remote"
		 * <!-- end-xdoclet-definition --> 
		 * @generated
		 *
		 */
		public RetornoDTO desactivacionDePlanAdicional(InActDesPlanAdicWSDTO inactDesPlanAdicWSDTO) {
			RetornoDTO retorno = new RetornoDTO();;
			
			InActDesPlanAdicDTO inactDesPlanAdicDTO= new InActDesPlanAdicDTO();
			inactDesPlanAdicDTO.copiaCampos(inactDesPlanAdicWSDTO);
			
			// Validacion datos entrada
			if(inactDesPlanAdicDTO.getCanal()==null || inactDesPlanAdicDTO.getCanal().trim().length()==0){
				retorno.setCodigo("-1");
				retorno.setDescripcion("El parametro de entrada Canal es nulo o viene en blanco");
				retorno.setResultado(false);
				return retorno;
			}
			
			if(inactDesPlanAdicDTO.getUsuarioSCL()==null || inactDesPlanAdicDTO.getUsuarioSCL().trim().length()==0){
				retorno.setCodigo("-3");
				retorno.setDescripcion("El parametro de entrada UsuarioSCL es nulo o viene en blanco");
				retorno.setResultado(false);
				return retorno;
			}
			try{
				if(inactDesPlanAdicDTO.getNumAbonado()==null) throw new NumberFormatException();
				Long.parseLong(inactDesPlanAdicDTO.getNumAbonado());
			}catch(NumberFormatException e){
				retorno.setCodigo("-4");
				retorno.setDescripcion("El parametro de entrada NumAbonado es nulo o no es numerico");
				retorno.setResultado(false);
				return retorno;
			}
			try{
				if(inactDesPlanAdicDTO.getCodigoProducto()==null) throw new NumberFormatException();
				Long.parseLong(inactDesPlanAdicDTO.getCodigoProducto());
			}catch(NumberFormatException e){
				retorno.setCodigo("-5");
				retorno.setDescripcion("El parametro de entrada CodigoProducto es nulo o no es numerico");
				retorno.setResultado(false);
				return retorno;
			}
			// Fin validacion datos entrada
			try{
				
				/**
				 * @description Se valida la dto de Auditoria
				 */
				String mensajesAuditoria=this.validarAuditoria(inactDesPlanAdicDTO.getAuditoriaDTO());
				mensajesAuditoria=mensajesAuditoria==null?"":mensajesAuditoria;
				if ("".equals(mensajesAuditoria))
					{
				
					/**
					 * @author rlozano
					 * @date 26-01-2010
					 * @description Se setea el valor del Token
					 */
					ValidacionAbonadoDTO validacionAbonadoDTO = new ValidacionAbonadoDTO();
					
					validacionAbonadoDTO.setAbonado(inactDesPlanAdicDTO.getNumAbonado());
					validacionAbonadoDTO.setCanal(inactDesPlanAdicDTO.getCanal());
					validacionAbonadoDTO.setCodigoOOSS("40160");
					validacionAbonadoDTO.setUsuarioSCL(inactDesPlanAdicDTO.getUsuarioSCL());
					
					ActDesPlanAdicDTO actDesPlanAdicDTO= new ActDesPlanAdicDTO();
					
					actDesPlanAdicDTO.setCanal(inactDesPlanAdicDTO.getCanal());
					actDesPlanAdicDTO.setCodigoProducto(inactDesPlanAdicDTO.getCodigoProducto());
					actDesPlanAdicDTO.setNumAbonado(inactDesPlanAdicDTO.getNumAbonado());
					actDesPlanAdicDTO.setUsuarioSCL(inactDesPlanAdicDTO.getUsuarioSCL());
					
					
					actDesPlanAdicDTO.setToken(this.validacion(validacionAbonadoDTO).getToken());
					
					if(actDesPlanAdicDTO.getToken()==null || actDesPlanAdicDTO.getToken().trim().length()==0){
						retorno.setCodigo("-2");
						retorno.setDescripcion("El parametro de entrada Token es nulo o viene en blanco");
						retorno.setResultado(false);
						return retorno;
					}
					
					retorno = this.getCusRelManFacade().desactivacionDePlanAdicional(actDesPlanAdicDTO);
				}
				else
				{
					retorno.setCodigo("-6");
					retorno.setDescripcion(mensajesAuditoria);
					retorno.setResultado(false);
				}
			}
			catch (Exception e){
				e.printStackTrace();
				retorno.setCodigo("-6");
				retorno.setDescripcion("["+e.getMessage()+"] - ["+e.getCause()+"]");
				
				context.setRollbackOnly();
				
			}
			
			if(!retorno.isResultado()){
				context.setRollbackOnly();
			}
			
			return retorno;
		}
		
		/**
		 * @ejb.interface-method view-type="remote"
		 * @param inWSNumFrecuenteDTO
		 * @return
		 * @throws GeneralException
		 */
		
		public RetornoDTO AgregarNumerosFrecuentesPorAbonado(InWSNumFrecuenteDTO  inWSNumFrecuenteDTO)throws GeneralException
		{
			RetornoDTO retValue= null;
			try
			{
				InNumerosFrecuentesDTO inNumerosFrecuentesDTO= new InNumerosFrecuentesDTO();
				
				inNumerosFrecuentesDTO.setNumCelular(inWSNumFrecuenteDTO.getNumCelular());
				inNumerosFrecuentesDTO.setTipoAccion("A");
				inNumerosFrecuentesDTO.setIdProductoContratado(inWSNumFrecuenteDTO.getIdProducto());
				NumeroListDTO  numerosListDTO = new NumeroListDTO();
				numerosListDTO.setIdProducto(inWSNumFrecuenteDTO.getIdProducto());
				inNumerosFrecuentesDTO.setAuditoriaDTO(inWSNumFrecuenteDTO.getAuditoriaDTO());
				inNumerosFrecuentesDTO.setNomUsuario(inWSNumFrecuenteDTO.getAuditoriaDTO().getNombreUsuario());
				ArrayList listaNumerosDTO= new ArrayList();
				for(int j=0;j<inWSNumFrecuenteDTO.getNumerosDTO().length;j++)
				{
					NumeroDTO numeroDTO= new NumeroDTO();
					numeroDTO.setNro(inWSNumFrecuenteDTO.getNumerosDTO()[j]);
					numeroDTO.setIdProductoContratado(inWSNumFrecuenteDTO.getIdProducto());
					listaNumerosDTO.add(numeroDTO);
				}
				
				NumeroDTO[] numerosDTO = (NumeroDTO[] )listaNumerosDTO.toArray(new NumeroDTO[listaNumerosDTO.size()]);
				
				numerosListDTO.setNumerosDTO(numerosDTO);
				numerosListDTO.setTipoComportamiento(inWSNumFrecuenteDTO.getTipoComportamiento());
				inNumerosFrecuentesDTO.setNumeroListDTO(numerosListDTO);
				retValue=this.getCusRelManFacade().AgregarEliminarNumerosFrecuentes(inNumerosFrecuentesDTO);
			}
			catch(GeneralException e)
			{
				logger.error(e);
				if (retValue==null)
					{
					retValue=new RetornoDTO();
						retValue.setCodigo("-1091");
						retValue.setDescripcion("Ocurrió un error al Eliminar Numero Frecuente");
						retValue.setResultado(false);
					}
			}
			catch(RemoteException e)
			{
				throw new GeneralException(e);
			}
			catch(Exception e)
			{
				throw new GeneralException(e);
			}
			return retValue;
		}
		
		
		/**
		 * @ejb.interface-method view-type="remote"
		 * 
		 * @param inWSNumFrecuenteDTO
		 * @return
		 * @throws GeneralException
		 */
		
		
		public RetornoDTO EliminarNumerosFrecuentesPorAbonado(InWSNumFrecuenteDTO  inWSNumFrecuenteDTO )throws GeneralException
		{
			RetornoDTO retValue= null;
			try{
				InNumerosFrecuentesDTO inNumerosFrecuentesDTO= new InNumerosFrecuentesDTO();
				
				inNumerosFrecuentesDTO.setNumCelular(inWSNumFrecuenteDTO.getNumCelular());
				inNumerosFrecuentesDTO.setTipoAccion("E");
				inNumerosFrecuentesDTO.setIdProductoContratado(inWSNumFrecuenteDTO.getIdProducto());
				inNumerosFrecuentesDTO.setAuditoriaDTO(inWSNumFrecuenteDTO.getAuditoriaDTO());
				inNumerosFrecuentesDTO.setNomUsuario(inWSNumFrecuenteDTO.getAuditoriaDTO().getNombreUsuario());
				NumeroListDTO  numerosListDTO = new NumeroListDTO();
				numerosListDTO.setIdProducto(inWSNumFrecuenteDTO.getIdProducto());
				ArrayList listaNumerosDTO= new ArrayList();
				for(int j=0;j<inWSNumFrecuenteDTO.getNumerosDTO().length;j++)
				{
					NumeroDTO numeroDTO= new NumeroDTO();
					numeroDTO.setNro(inWSNumFrecuenteDTO.getNumerosDTO()[j]);
					numeroDTO.setIdProductoContratado(inWSNumFrecuenteDTO.getIdProducto());
					listaNumerosDTO.add(numeroDTO);
				}
				
				NumeroDTO[] numerosDTO = (NumeroDTO[] )listaNumerosDTO.toArray(new NumeroDTO[listaNumerosDTO.size()]);
				
				numerosListDTO.setNumerosDTO(numerosDTO);
				numerosListDTO.setTipoComportamiento(inWSNumFrecuenteDTO.getTipoComportamiento());
				inNumerosFrecuentesDTO.setNumeroListDTO(numerosListDTO);
				retValue=this.getCusRelManFacade().AgregarEliminarNumerosFrecuentes(inNumerosFrecuentesDTO);
			}
			catch(GeneralException e)
			{
				logger.error(e);
				if (retValue==null)
					{
						retValue=new RetornoDTO();
						retValue.setCodigo("-1091");
						retValue.setDescripcion("Ocurrió un error al Eliminar Numero Frecuente");
						retValue.setResultado(false);
					}
				
				
			}
			catch(RemoteException e)
			{
				throw new GeneralException(e);
			}
			catch(Exception e)
			{
				throw new GeneralException(e);
			}
			return retValue;
		}
		
		
		/**********************************************************************************************************************************/
		/**
		 * @description implementacion de validaciones ingreso de campos por servicio asociado a DTO 
		 */
		
		protected String validarParametrosNumFrecuenteDTO(InWSNumFrecuenteDTO inWSNumFrecuenteDTO)
		{
			ArrayList mensajes = new ArrayList();
			try
			{
				String idProducto=inWSNumFrecuenteDTO.getIdProducto();
				idProducto=idProducto==null?"":idProducto;
				mensajes.add("".equals(idProducto)?"Debe Ingresar un valor para [IdProducto]":null);
				String numCelular=inWSNumFrecuenteDTO.getNumCelular();
				numCelular=numCelular==null?"":numCelular;
				mensajes.add("".equals(numCelular)?"Debe Ingresar un valor para [numCelular]":null);
				String[] numerosDTO=inWSNumFrecuenteDTO.getNumerosDTO();
				mensajes.add(numerosDTO==null||numerosDTO.length==0?"Debe Ingresar un valor para [numerosDTO]":null);
				
			}
			catch(Exception e)
			{
				mensajes.add("Ocurrió una exception al validar el formato de datos de número Frecuentes");
			}
			return mensajes.toString();
		}
		
		
		protected String validarAuditoria(AuditoriaDTO auditoria){
			ArrayList mensaje = new ArrayList();
			String retValue=null;
			
			try{
				
				Class clase=auditoria.getClass();
				clase.getDeclaredFields();
				
				if(auditoria == null){
					mensaje.add("Problema con el ingreso de datos");
				}
				String nomUsuario=auditoria.getNombreUsuario();
				nomUsuario=nomUsuario==null?"":nomUsuario;
				
				String codPuntoAcceso=auditoria.getCodPuntoAcceso();
				codPuntoAcceso=codPuntoAcceso==null?"":codPuntoAcceso;
				
				String codServicio=auditoria.getCodServicio();
				codServicio=auditoria.getCodServicio()==null?"":codServicio;
				
				if("".equals(nomUsuario)){
					mensaje.add("Debe ingresar un nombre de usuario válido");
				}
				
				if("".equals(codPuntoAcceso)){
					mensaje.add("Debe ingresar un punto de acceso válido");
				}
				
				if("".equals(codServicio)){
					mensaje.add("Debe ingresar un código de servicio válido");
				}
				
			} catch (Exception e) {
				mensaje.add("Error en la validación de los datos de auditoria");
			}
			retValue=mensaje.size()==0?"":mensaje.toString();
			
			return retValue;
		}
		
		
	/**
	 * @ejb.interface-method view-type="remote"
	 * @author rlozano
	 * @date 14-03-2010
	 * @description Servicio que obtiene la clasificacion asociada al cliente a partir del numero celular del abonado
	 * @exception  Servicio se debe evaluar si debe estar considerado en el componente de Integracion EAR.
	 * @referencia 4.1.60	CU-062 Consultar Clasificación de un Cliente 
	 */	
		
		public IntegracionInClasificacionDTO consultarClasificacionCliente(InWsClasifClienteDTO inWsClasifClienteDTO)throws GeneralException
		{
			IntegracionInClasificacionDTO retValue= null;
			try{
				
				String numCelular =inWsClasifClienteDTO.getNumCelular();
				numCelular=numCelular==null?"":numCelular;
				
				if (validacionesForma.isNumberInt(numCelular))
				{
					/**
					 * @description Se valida la dto de Auditoria
					 */
					String mensajesAuditoria=this.validarAuditoria(inWsClasifClienteDTO.getAuditoriaDTO());
					mensajesAuditoria=mensajesAuditoria==null?"":mensajesAuditoria;
					if ("".equals(mensajesAuditoria))
					{
						
						retValue=this.getCusRelManFacade().consultaClasificacionCliente(inWsClasifClienteDTO);
					}
					else
					{
						retValue= new IntegracionInClasificacionDTO();
						retValue.setCodigo("-4");
						retValue.setDescripcion(mensajesAuditoria);
						retValue.setResultado(false);
					}
				}	
				else
				{
					retValue= new IntegracionInClasificacionDTO();
					retValue.setCodigo("-4");
					retValue.setDescripcion("El parametro de entrada NumCelular es nulo o no es numérico");
					retValue.setResultado(false);
				}
			}
			catch(GeneralException e)
			{
				logger.error(e);
				if (retValue==null)
					{
						retValue=new IntegracionInClasificacionDTO();
						retValue.setCodigo("-1092");
						retValue.setDescripcion("Ocurrió un error al consultar la clasificacion del cliente");
						retValue.setResultado(false);
					}
				
			}
			catch(RemoteException e)
			{
				throw new GeneralException(e);
			}
			catch(Exception e)
			{
				throw new GeneralException(e);
			}
			return retValue;
		}
		
		/**
		 * @ejb.interface-method view-type="remote"
		 * @author rlozano
		 * @date 14-03-2010
		 * @description Servicio que obtiene la clasificacion asociada al cliente a partir del numero celular del abonado
		 * @exception  Servicio se debe evaluar si debe estar considerado en el componente de Integracion EAR.
		 * @referencia 4.1.60	CU-062 Consultar Clasificación de un Cliente 
		 */	
			
			public RetornoListaNumerosDTO listaNumerosFrecuentes(DatosInListarNumerosFrecuentesDTO datosInListarNumerosFrecuentesDTO)throws GeneralException
			{
				RetornoListaNumerosDTO retValue= null;
				try{
					
					String numCelular =datosInListarNumerosFrecuentesDTO.getNumCelular();
					numCelular=numCelular==null?"":numCelular;
					
					String codProducto =datosInListarNumerosFrecuentesDTO.getCodProducto();
					codProducto=codProducto==null?"":codProducto;
					
					if (validacionesForma.isNumberInt(numCelular)&&validacionesForma.isNumberInt(codProducto))
					{
						/**
						 * @description Se valida la dto de Auditoria
						 */
						String mensajesAuditoria=this.validarAuditoria(datosInListarNumerosFrecuentesDTO.getAuditoriaDTO());
						mensajesAuditoria=mensajesAuditoria==null?"":mensajesAuditoria;
						if ("".equals(mensajesAuditoria))
						{
							DatosConsultaProductoDTO datosConsultaProductoDTO= new DatosConsultaProductoDTO();
							datosConsultaProductoDTO.setCodProducto(codProducto);
							datosConsultaProductoDTO.setNumCelularContr(numCelular);
							 
							retValue=this.getCusRelManFacade().consultaDetalleNumeroFrecuente(datosConsultaProductoDTO);
							ArrayList listaNumeros= new ArrayList();
							if (retValue.getListaNumeros()!=null)
							{
								for (int i=0;i<retValue.getListaNumeros().length;i++)
								{
									listaNumeros.add(retValue.getListaNumeros()[i]);
								}
							}
							
							
							NumeroCategDTO[] numerosCategDTO = (NumeroCategDTO[]) listaNumeros.toArray(new NumeroCategDTO[listaNumeros.size()]);
							retValue.setListaNumeros(numerosCategDTO);
						}
						else
						{
							retValue= new RetornoListaNumerosDTO();
							retValue.setCodigo("-4");
							retValue.setDescripcion(mensajesAuditoria);
							retValue.setResultado(false);
						}
					}	
					else
					{
						retValue= new RetornoListaNumerosDTO();
						retValue.setCodigo("-4");
						retValue.setDescripcion("El parametro de entrada NumCelular y/o codProducto es nulo o no es numérico");
						retValue.setResultado(false);
					}
				}
				catch(GeneralException e)
				{
					logger.error(e);
					if (retValue==null)
						{
						retValue= new RetornoListaNumerosDTO();;
							retValue.setCodigo("-1092");
							retValue.setDescripcion("Ocurrió un error al consultar la lista de Frecuentes");
							retValue.setResultado(false);
						}
					
				}
				catch(RemoteException e)
				{
					throw new GeneralException(e);
				}
				catch(Exception e)
				{
					throw new GeneralException(e);
				}
				return retValue;
			}
	
			/**
			 * 
			 * @ejb.interface-method view-type="remote"
			 * @param prodOfertablesBenefDTO
			 * @return
			 * @throws CusRelManWSException
			 * @throws RemoteException
			 */
			
	public WSListaProdOferDTO obtenerProductosOfertablesBeneficiarioIntegracion(ProdOfertablesBenefDTO prodOfertablesBenefDTO) throws  GeneralException, RemoteException
	//, SOAPGeneralException
	{	
		WSListaProdOferDTO wsListaProdOferDTO= null;
		RetornoDTO retValue= new RetornoDTO();
		retValue.setResultado(true);
		String canalOrigenPro=prodOfertablesBenefDTO.getCanalOrigenPro();
		canalOrigenPro=canalOrigenPro==null?"":canalOrigenPro;
		
		String numAbonadoBeneficiario =prodOfertablesBenefDTO.getNumAbonadoBeneficiario();
		numAbonadoBeneficiario = numAbonadoBeneficiario ==null?"":numAbonadoBeneficiario;
		
		String numAbonadoContratado=prodOfertablesBenefDTO.getNumAbonadoContratado();
		numAbonadoContratado=numAbonadoContratado==null?"":numAbonadoContratado;
		
		ArrayList listaErrores= new ArrayList();
		try{
			if ("".equals(canalOrigenPro))
			{
				listaErrores.add("Debe Ingresar el parámetro [canalOrigenPro]");
			}
			if (!validacionesForma.isNumberInt(numAbonadoBeneficiario))
			{
				listaErrores.add("Debe Ingresar el parámetro [numAbonadoBeneficiario]un valor numérico");
			}
			if (!validacionesForma.isNumberInt(numAbonadoContratado))
			{
				listaErrores.add("Debe Ingresar el parámetro [numAbonadoContratado]un valor numérico");
			}
			
			if (listaErrores.size()==0){
				
				String mensajesAuditoria=this.validarAuditoria(prodOfertablesBenefDTO.getAuditoriaDTO());
				mensajesAuditoria=mensajesAuditoria==null?"":mensajesAuditoria;
				if ("".equals(mensajesAuditoria))
				{
					wsListaProdOferDTO=this.getCusRelManFacade().obtenerProductosOfertablesBeneficiarioIntegracion(prodOfertablesBenefDTO);
				}
				else
				{
					retValue.setCodigo("-4");
					retValue.setDescripcion(mensajesAuditoria);
					retValue.setResultado(false);
				}
			}
			else{
				retValue.setCodigo("-1093");
				retValue.setDescripcion(listaErrores.toString());
				retValue.setResultado(false);
			}
		}
		catch(GeneralException e){
			retValue.setCodigo(e.getCodigo());
			retValue.setDescripcion(e.getDescripcionEvento());
			retValue.setResultado(false);
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			//throw new CusRelManWSException(e);
		}
		catch(Exception e)
		{
			logger.debug("Exception", e);
			logger.error(e);
			throw new GeneralException (e);
		}
		finally
		{
			if (!retValue.isResultado())
			{
				wsListaProdOferDTO= new WSListaProdOferDTO();
				wsListaProdOferDTO.setCodigo(retValue.getCodigo());
				wsListaProdOferDTO.setDescripcion(retValue.getDescripcion());
				wsListaProdOferDTO.setResultado(false);
			}
		}
		return wsListaProdOferDTO;	
	} 
	
	
	/**
	 * @ejb.interface-method view-type="remote"
	 * @param wsPlanesAdicionalesContratadosDTO
	 * @return
	 * @throws CusRelManWSException
	 * @throws RemoteException
	 */
	public RespProductoContratadoSimpleDTO obtenerPlanesAdicionalesContratadosIntegracion(WSPlanesAdicionalesContratadosDTO wsPlanesAdicionalesContratadosDTO ) throws GeneralException, RemoteException{		
		RespProductoContratadoSimpleDTO retorno =new RespProductoContratadoSimpleDTO();
		try{
			
			String nivelAplicacion=wsPlanesAdicionalesContratadosDTO.getNivelAplicacion();
			nivelAplicacion=nivelAplicacion==null?"":nivelAplicacion;
			
			String numCelular=wsPlanesAdicionalesContratadosDTO.getNumCelular();
			numCelular=numCelular==null?"":numCelular;
			
			String tipoComportamiento=wsPlanesAdicionalesContratadosDTO.getTipoComportamiento();
			tipoComportamiento=tipoComportamiento==null?"":tipoComportamiento;
			ArrayList listaErrores= new ArrayList();
			if ("".equals(nivelAplicacion))
			{
				listaErrores.add("Debe Ingresar el parámetro [nivelAplicacion]");
			}
			if ("".equals(numCelular))
			{
				listaErrores.add("Debe Ingresar el parámetro [numCelular]");
			}
			if ("".equals(tipoComportamiento))
			{
				//listaErrores.add("Debe Ingresar el parámetro [tipoComportamiento]");
			}
			
			if (listaErrores.size()==0){
				
				String mensajesAuditoria=this.validarAuditoria(wsPlanesAdicionalesContratadosDTO.getAuditoriaDTO());
				mensajesAuditoria=mensajesAuditoria==null?"":mensajesAuditoria;
				if ("".equals(mensajesAuditoria))
				{
						retorno=this.getCusRelManFacade().obtenerPlanesAdicionalesContratadosIntegracion(wsPlanesAdicionalesContratadosDTO);
				}
				else
				{
					retorno.setCodigo("-4");
					retorno.setDescripcion(mensajesAuditoria);
					retorno.setResultado(false);
				}
			}
			else
			{
				retorno.setCodigo("-1093");
				retorno.setDescripcion(listaErrores.toString());
				retorno.setResultado(false);
				
			}
			
			
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;	
	}
}
