/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 29/11/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.cl.scl.frameworkcargos.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.frameworkcargs.bean.ejb.helper.Global;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosCodDescDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosRegistrarCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.frameworkcargos.srv.GestionCargosSRV;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="FrmkCargosFacade"	
 *           description="An EJB named FrmkCargosFacade"
 *           display-name="FrmkCargosFacade"
 *           jndi-name="FrmkCargosFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class FrmkCargosFacadeBean implements javax.ejb.SessionBean {

	private final Logger logger = Logger.getLogger(FrmkCargosFacadeBean.class);
	private Global global = Global.getInstance();
	private SessionContext context=null;
	
//	Instancia el factory
	
	//Obtiene el application service
	
	GestionCargosSRV gestionCargosSRV=new GestionCargosSRV(); 
	
	
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
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
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
		this.context=arg0;
	}

	/**
	 * 
	 */
	public FrmkCargosFacadeBean() {
		// TODO Auto-generated constructor stub
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 
	public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO parametros)throws FrmkCargosException {
		
		ObtencionCargosDTO resultado = null;
			
			try{
					
				logger.debug("FrmkCargosFacadeBean:obtenerCargos():start");

				logger.debug("FrmkCargosFacadeBean:parametrosCargos.getOperacion:"+	parametros.getOperacion()); // RRG
				logger.debug("FrmkCargosFacadeBean:Tipo Pantalla::"+parametros.getTipoPantalla());                  
				logger.debug("FrmkCargosFacadeBean:Codigo Modalidad de Venta::"+parametros.getCodigoModalidadVenta());      
				logger.debug("FrmkCargosFacadeBean:Abonados cantidad::"+parametros.getAbonados());              
				logger.debug("FrmkCargosFacadeBean:Codigo Cliente Origen::"+parametros.getCodigoClienteOrigen());          
				logger.debug("FrmkCargosFacadeBean:Codigo Cliente Destino::"+parametros.getCodigoClienteDestino());         
				logger.debug("FrmkCargosFacadeBean:Codigo PlanTarifario Origen::"+parametros.getCodigoPlanTarifOrigen());    
				logger.debug("FrmkCargosFacadeBean:Codigo PlanTarifario Destino::"+parametros.getCodigoPlanTarifDestino());   
				logger.debug("FrmkCargosFacadeBean:Tipo Segmentacion Origen::"+parametros.getTipoSegOrigen());       
				logger.debug("FrmkCargosFacadeBean:Tipo Segmentacion Origen::"+parametros.getTipoSegDestino());       
				logger.debug("FrmkCargosFacadeBean:Codigo Causa Cambio de Plan::"+parametros.getCodCausaCambioPlan());    
				logger.debug("FrmkCargosFacadeBean:Codigo Actuacion::"+parametros.getCodActabo());               
				logger.debug("FrmkCargosFacadeBean:Codigo Tecnologia::"+parametros.getCodigoTecnologia());              
				logger.debug("FrmkCargosFacadeBean:Codigo Penalizacion::"+parametros.getCodPenalizacion());            
				logger.debug("FrmkCargosFacadeBean:Indicador Comodato::"+parametros.getIndComodato());             
				logger.debug("FrmkCargosFacadeBean:Codigo Categoria::"+parametros.getCodCategoria());               
				logger.debug("FrmkCargosFacadeBean:Tipo Contrato::"+parametros.getTipoContrato());                  
				logger.debug("FrmkCargosFacadeBean:Indicador Causa::"+parametros.getIndCausa());                
				logger.debug("FrmkCargosFacadeBean:Estado Devolucion de Cargador::"+parametros.getEstdDevlCargador());  
				logger.debug("FrmkCargosFacadeBean:Fecha Vigencia::"+parametros.getFechaVigenciaAbonadoCero());                
				logger.debug("FrmkCargosFacadeBean:Nombre Usuario:" + parametros.getNombreUsuario()); //INC-79469; COL; 11-03-2009; AVC

	

				resultado = service1.obtenerCargos(parametros);
				logger.debug("obtenerCargos():end");
			} catch(FrmkCargosException e){
				logger.debug("FrmkCargosException[", e);
				throw e;
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new FrmkCargosException(e);
			}
		return resultado;
	}
	*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	
	
	public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO cargos) throws FrmkCargosException{
		
		ResultadoRegCargosDTO retValue = null;
		try{
			logger.debug("registrarCargos():start");
			retValue = srv.parametrosRegistrarCargos(cargos);
			logger.debug("registrarCargos():end");
		} catch(FrmkCargosException e){
			logger.debug("ProyectoException[", e);
			
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
		return retValue;		
	} */
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	
	public ResultadoRegCargosDTO registrarCargos(ParametrosRegistrarCargosDTO cargos)throws FrmkCargosException, GeneralException{
		ResultadoRegCargosDTO retValue = null;
		try{
			logger.debug("registrarCargos():start");
			retValue = gestionCargosSRV.registrarCargos(cargos);
			logger.debug("registrarCargos():end");
		
		} catch(FrmkCargosException e){
			logger.debug("ProyectoException[", e);
			throw e;
		} catch (GeneralException e) {
			logger.debug("GeneralException Simcard DAO");			
			logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
			logger.debug("e.getCodigo()[" + e.getCodigo() + "]");	
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
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
	 
	public RetornoDTO registraCargosBatch(RegistroCargosBatchDTO registro) throws FrmkCargosException{
		RetornoDTO retorno;
		logger.debug("Inicio:registraCargosBatch()");
		try {
			retorno = srv.registraCargosBatch(registro);
		} catch (FrmkCargosException e) {		
			throw new FrmkCargosException(e.getMessage(),e.getCause());
		}
		logger.debug("Fin:registraCargosBatch()");
		return retorno;
	}
	 */
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	
	
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO resultadoObtenerCargos) throws FrmkCargosException{
		
		RegCargosDTO retValue = null;
		try{
			logger.debug("construirRegistroCargos():start");
			retValue = srv.construirRegistroCargos(resultadoObtenerCargos);
			logger.debug("construirRegistroCargos():end");
		} catch(FrmkCargosException e){
			logger.debug("FrmkCargosException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
		return retValue;		
	} */
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 
	public void cierreVenta(GaVentasDTO gaVentasDTO) throws FrmkCargosException{
		try{
			logger.debug("cierreVenta():start");
			srv.cierreVenta(gaVentasDTO);
			logger.debug("cierreVenta():end");
		} catch(FrmkCargosException e){
			logger.debug("FrmkCargosException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
	}
	 */
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	/*public ListasDTO consultaLista(ConsultaListaDTO consultaLista) throws SocketPSException, RemoteException {
		String log = global.getValor("negocio.log");
		PropertyConfigurator.configure(log);
		ListasDTO lista;
		try {
			logger.debug("consultaLista():start");
			lista = consultaSrv.consultaLista(consultaLista);
			logger.debug("consultaLista():end");
		} catch (SocketPSException e) {
			logger.debug("SocketPSException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SocketPSException(e);
		}		
		return lista;
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
	/*public PlanDTO consultaPlan(ConsultaPlanDTO consultaPlan) throws SocketPSException, RemoteException {
		String log = global.getValor("negocio.log");
		PropertyConfigurator.configure(log);	
		PlanDTO plan;
		try {
			logger.debug("consultaPlan():start");
			plan = consultaSrv.consultaPlan(consultaPlan);
			logger.debug("consultaPlan():end");
		} catch (SocketPSException e) {
			logger.debug("SocketPSException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SocketPSException(e);
		}				
		return plan;
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
	/*public SaldoDTO consultaSaldo(ConsultaSaldoDTO consultaSaldo) throws SocketPSException, RemoteException {
		String log = global.getValor("negocio.log");
		PropertyConfigurator.configure(log);		
		SaldoDTO saldo;
		try {
			logger.debug("consultaSaldo():start");		
			saldo = consultaSrv.consultaSaldo(consultaSaldo);
			logger.debug("consultaSaldo():end");
		} catch (SocketPSException e) {
			logger.debug("SocketPSException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SocketPSException(e);
		}	
		return saldo;
	}
	*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 	
	
	public PrecioTerminalDTO getRecPrecioEquipoActual(TerminalDTO terminalDTO)throws GeneralException,RemoteException{
		logger.debug("getRecPrecioEquipoActual: start");
		PrecioTerminalDTO  precioTerminalDTO=null;
		try{
			
			precioTerminalDTO=service1.getRecPrecioEquipoActual(terminalDTO);
			logger.debug("getRecPrecioEquipoActual: end");
		}catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw (e);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		
		logger.debug("getRecPrecioEquipoActual: end");
		return precioTerminalDTO;
	}
	 */
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public ObtencionCargosDTO getObtencionCargos(ParametrosObtencionCargosDTO parametros,ParametrosCodDescDTO[] listParametrosCodDescDTO) throws GeneralException,RemoteException{
		logger.debug("getObtencionCargos: start");
		ObtencionCargosDTO  obtCargos=null;
		try{
			
			obtCargos=gestionCargosSRV.getObtencionCargos(parametros,listParametrosCodDescDTO);
			logger.debug("getObtencionCargos: end");
		}catch(GeneralException e){
			logger.debug("GeneralException Simcard DAO");			
			logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
			logger.debug("e.getCodigo()[" + e.getCodigo() + "]");
			logger.debug("GeneralException[", e);
			throw (e);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		
		logger.debug("getObtencionCargos: end");
		return obtCargos;
	}
		
	
		
}
