/**
 * 
 */
package com.tmmas.scl.operations.crm.f.oh.isscusord.soa.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroOrdenServicioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.soa.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.ContratacionProductoSrvOrcFactory;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.ContratacionProductoSrvOrcFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.ContratacionProductoSrvOrcIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.soa.IssCusOrdORCSrvFactory;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.soa.interfaces.IssCusOrdORCSrvFactoryIT;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.soa.interfaces.IssCusOrdORCSrvIT;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.ContenedorPlanesAdicionalesDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="IssCusOrdORC"	
 *           description="An EJB named IssCusOrdORC"
 *           display-name="IssCusOrdORC"
 *           jndi-name="IssCusOrdORC"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class IssCusOrdORCBean implements javax.ejb.SessionBean 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private SessionContext context = null;
	private final Logger logger = Logger.getLogger(IssCusOrdORCBean.class);
	private Global global = Global.getInstance();	
	
	private ContratacionProductoSrvOrcFactoryIF serviceFactory=new ContratacionProductoSrvOrcFactory();
	private IssCusOrdORCSrvFactoryIT serviceFactory3 = new IssCusOrdORCSrvFactory();
	
	private ContratacionProductoSrvOrcIF service1 = serviceFactory.getApplicationService1();
	private IssCusOrdORCSrvIT service3 = serviceFactory3.getApplicationService1();

	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.create-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() 
	{
		
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
	public RetornoDTO activarProductoContratado(OfertaComercialDTO ofertaComercial) throws IssCusOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("soa.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("activarProductoContratado():start");			
			resultado = service1.activarProductoContratado(ofertaComercial);			
			logger.debug("activarProductoContratado():end");			
		}
		catch(IssCusOrdException e)
		{
			this.context.setRollbackOnly();
			logger.debug("IssCusOrdException[", e);
			throw e;
		}
		catch (Exception e) 
		{
			this.context.setRollbackOnly();
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Este método efectua la descontratación de productos para una oferta comercial.
	 * @return prodList este objeto contiene un arreglo de objetos ProductoContratadoDTO.
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.	 
	 * @throws IssCusOrdException 
	 * @see com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.ContratacionProductoSrvOrcIF
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO descontratarOfertaComercial(ProductoContratadoListDTO prodList) throws IssCusOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("soa.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("descontratarOfertaComercial():start");			
			resultado = service1.descontratarOfertaComercial(prodList);			
			logger.debug("descontratarOfertaComercial():end");			
		}		
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			this.context.setRollbackOnly();
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Este método es responsable de anular una venta para un cliente.
	 * @param venta objeto VentaDTO que contiene la información del Cliente (ClienteDTO), el código del vendedor y el resto de los
	 * 		  atributos que identifican la Venta.
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.	 
	 * @throws IssCusOrdException 
	 * @see com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.ContratacionProductoSrvOrcIF 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO anulacionVenta(VentaDTO venta) throws IssCusOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("soa.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("anulacionVenta():start");			
			resultado = service1.anulacionVenta(venta);			
			logger.debug("anulacionVenta():end");			
		}		
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			this.context.setRollbackOnly();
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	
	/** 
	 * Este método hace la descontratación de una oferta comercial a partir de un Venta (VentaDTO).
	 * @param venta objeto VentaDTO que contiene la información del Cliente (ClienteDTO), el código del vendedor y el resto de los
	 * 		  atributos que identifican la Venta.
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.	 
	 * @throws IssCusOrdException
	 * @see com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.ContratacionProductoSrvOrcIF 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub 
	 */
	public RetornoDTO descontratarOfertaComercialPorVenta(VentaDTO venta) throws IssCusOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("soa.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("descontratarOfertaComercial():start");			
			resultado = service1.descontratarOfertaComercialPorVenta(venta);		
			logger.debug("descontratarOfertaComercial():end");			
		}		
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			this.context.setRollbackOnly();
			throw new IssCusOrdException(e);
		}
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
	public RetornoDTO ejecutarMantencionPlanesAdicionales(ContenedorPlanesAdicionalesDTO contenedorPlanes) throws IssCusOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("soa.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("ejecutarMantencionPlanesAdicionales():start");			
			resultado = service1.ejecutarMantencionPlanesAdicionales(contenedorPlanes);	
			logger.debug("ejecutarMantencionPlanesAdicionales():end");			
		}		
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			this.context.setRollbackOnly();
			throw new IssCusOrdException(e);
		}
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
	public RetornoDTO validarActDescRegistrarCambPlanBatch(RegistroPlanDTO registro) throws IssCusOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("soa.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("validarActDescRegistrarCambPlanBatch():start");			
			resultado = service3.validarActDescRegistrarCambPlanBatch(registro);	
			logger.debug("validarActDescRegistrarCambPlanBatch():end");			
		}		
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			this.context.setRollbackOnly();
			throw new IssCusOrdException(e);
		}
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
	public RetornoDTO registrarCambioPlanAbonados(RegistroPlanDTO registro) throws IssCusOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("soa.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("registrarCambioPlanAbonados():start");			
			resultado = service3.registrarCambioPlanAbonados(registro);	
			logger.debug("registrarCambioPlanAbonados():end");			
		}		
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			this.context.setRollbackOnly();
			throw new IssCusOrdException(e);
		}
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
	public RetornoDTO registroReordenamientoAbonados(RegistroPlanDTO registro) throws IssCusOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("soa.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("registroReordenamientoAbonados():start");			
			//resultado = service3.registroReordenamientoAbonados(registro);	
			logger.debug("registroReordenamientoAbonados():end");			
		}		
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			this.context.setRollbackOnly();
			throw new IssCusOrdException(e);
		}
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
	public RetornoDTO registroCargosAbonadosBatch(ParamRegistroOrdenServicioDTO entrada) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("soa.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registroCargosAbonadosBatch():start");
			resultado = service3.registroCargosAbonadosBatch(entrada);
			logger.debug("registroCargosAbonadosBatch():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
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

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		this.context=arg0;
	}

	/**
	 * 
	 */
	public IssCusOrdORCBean() {
		// TODO Auto-generated constructor stub
	}
}
