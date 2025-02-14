/**
 * 
 */
package com.tmmas.cl.scl.inventarioportabilidad.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingOUTDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieKitDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSCentralQuioscoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.gestiondeventaaccesorios.service.servicios.GestionDeVentaAccesoriosSRV;
import com.tmmas.cl.scl.inventarioportabilidad.srv.GestionDeInventarioSRV;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DatosClienteDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.FacturaVO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.InfoFacturaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.PagoDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificaClientizaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificacionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsCajaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsUpdateTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsVentaAccesoriosDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsVentaAccesoriosOutDTO;




/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="InventarioPortabilidad"	
 *           description="An EJB named InventarioPortabilidad"
 *           display-name="InventarioPortabilidad"
 *           jndi-name="InventarioPortabilidad"
 *           type="Stateless" 
 *           transaction-type="Container"
 *  
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class InventarioPortabilidadBean implements
javax.ejb.SessionBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private GestionDeInventarioSRV gestionDeInventarioSRV= new GestionDeInventarioSRV();
	private GestionDeVentaAccesoriosSRV gestionDeVentaAccesoriosSRV = new GestionDeVentaAccesoriosSRV(); 
	private SessionContext context = null;

	private CompositeConfiguration config;



	private final Logger logger = Logger
	.getLogger(InventarioPortabilidadBean.class);

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
		this.context=arg0;

	}

	/**
	 * 
	 */
	public InventarioPortabilidadBean() {
		System.out.println("InventarioPortabilidadBean(): Start");		                                                                          
		config = UtilProperty.getConfiguration("InventarioPortabilidadEJB.properties","com/tmmas/cl/scl/inventarioportabilidad/negocio/ejb/properties/InventarioPortabilidadBean.properties");
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		logger.debug("InventarioPortabilidadBean():End");
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
	public RoamingOUTDTO getDetalleUltimaLlamadasRomingTOL(RoamingInDTO rommingDTO)throws GeneralException {
		RoamingOUTDTO retValue=null ;  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug(" getDetalleUltimaLlamadasRomingTOL:start");
			retValue=gestionDeInventarioSRV.getDetalleUltimaLlamadasRomingTOL(rommingDTO);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getDetalleUltimaLlamadasRomingTOL:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	/*--------------------------------------------------- Venta de Accesorios -------------------------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsVentaAccesoriosOutDTO preVentaAccesorios (WsVentaAccesoriosDTO ventaAccesoriosDTO)throws GeneralException{		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO = new WsVentaAccesoriosOutDTO();
		try{
			logger.debug(" preVentaAccesorios:start");
			logger.debug("ventaAccesoriosDTO.getArticulo().length ["+ventaAccesoriosDTO.getArticulo().length+"]");
			ventaAccesoriosOutDTO = gestionDeVentaAccesoriosSRV.preVentaAccesorios(ventaAccesoriosDTO);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("preVentaAccesorios:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		return ventaAccesoriosOutDTO;
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
	public WsVentaAccesoriosOutDTO ventaAccesorios (WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException{		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug(" ventaAccesorios:start");
			ventaAccesoriosOutDTO = gestionDeVentaAccesoriosSRV.ventaAccesorios(ventaAccesoriosOutDTO);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("ventaAccesorios:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
		return ventaAccesoriosOutDTO;
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
	public WsVentaAccesoriosOutDTO aceptacionVentaAccesorios (WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException{		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug(" aceptacionVentaAccesorios:start");
			ventaAccesoriosOutDTO = gestionDeVentaAccesoriosSRV.aceptacionVentaAccesorios(ventaAccesoriosOutDTO);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("aceptacionVentaAccesorios:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		return ventaAccesoriosOutDTO;
	}


	/*--------------------------------------------------- tipificacion --------------------------------------------------------------*/

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public TipificacionDTO[] recuperaDatoTipificacion (String datoTipificacion,String codVendedor)throws GeneralException{		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));
		TipificacionDTO[] tipificacionDTO = null;
		try{
			logger.debug(" recuperaDatoTipificacion:start");
			tipificacionDTO = gestionDeVentaAccesoriosSRV.recuperaDatoTipificacion(datoTipificacion,codVendedor);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("recuperaDatoTipificacion:end");
			return tipificacionDTO;
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
	}

	/*--------------------------------------------------- Tiendas --------------------------------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsTiendasOutDTO getTiendas()throws GeneralException {
		WsTiendasOutDTO retValue=null ;  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug(" getTiendas:start");
			retValue=gestionDeVentaAccesoriosSRV.getTiendas();
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getTiendas:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
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
	public WsTiendaVendedorOutDTO getTiendaVendedor(String codTienda)throws GeneralException
	{
		WsTiendaVendedorOutDTO retValue=null ;  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug(" getTiendas:start");
			retValue=gestionDeVentaAccesoriosSRV.getTiendaVendedor(codTienda);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getTiendas:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	/*----------------------------------------- Datos Cliente por numero de celular ----------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosClienteDTO clientePorNumeroCelular (long numeroCelular)throws GeneralException{
		DatosClienteDTO datosClienteDTO = new DatosClienteDTO();  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug(" clientePorNumeroCelular:start");
			datosClienteDTO = gestionDeVentaAccesoriosSRV.clientePorNumeroCelular(numeroCelular);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("clientePorNumeroCelular:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return datosClienteDTO;
	}


	/*----------------------------------------- Mantenedores Tipificacion ----------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void insertTipificacion (TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException {		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("insertTipificacion:start");
			gestionDeVentaAccesoriosSRV.insertTipificacion(tipificaClientizaDTO);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("insertTipificacion:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
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
	public TipificaClientizaDTO[] recuperaArrayTipificacion () throws GeneralException {
		TipificaClientizaDTO[] tipificaClientizaDTO = null;  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("recuperaArrayTipificacion:start");
			tipificaClientizaDTO=gestionDeVentaAccesoriosSRV.recuperaArrayTipificacion();
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("recuperaArrayTipificacion:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return tipificaClientizaDTO;
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
	public TipificaClientizaDTO recuperaTipificacion (int codArticulo) throws GeneralException {
		TipificaClientizaDTO tipificaClientizaDTO = new TipificaClientizaDTO();  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("recuperaTipificacion:start");
			tipificaClientizaDTO=gestionDeVentaAccesoriosSRV.recuperaTipificacion(codArticulo);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("recuperaTipificacion:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return tipificaClientizaDTO;
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
	public void updateTipificacion (TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException {		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("updateTipificacion:start");
			gestionDeVentaAccesoriosSRV.updateTipificacion(tipificaClientizaDTO);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("updateTipificacion:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
	}

	/*---------------------------------------------- Catalogos ---------------------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteDTO[] getListCategorias() throws GeneralException{
		ClienteDTO[] resultado = null;
		try{
			logger.debug("getListCategorias:start");
			resultado = gestionDeVentaAccesoriosSRV.getListCategorias();
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getListCategorias:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
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
	public PrecioCargoDTO[] getPrecioCargoAccesorio(ArticuloDTO articulo ) throws GeneralException{
		PrecioCargoDTO[] resultado = null;
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));
		try{
			logger.debug("getPrecioCargoAccesorio:start");
			resultado = gestionDeVentaAccesoriosSRV.getPrecioCargoAccesorio(articulo);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getPrecioCargoAccesorio:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
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
	public DescuentoDTO[] getDescuentoAccesorio(ArticuloDTO articulo ) throws GeneralException{
		DescuentoDTO[] resultado = null;
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));
		try{
			logger.debug("getDescuentoAccesorio:start");
			resultado = gestionDeVentaAccesoriosSRV.getDescuentoAccesorio(articulo);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getDescuentoAccesorio:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
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
	public IdentificadorCivilDTO[] getTiposIdentificacion()throws GeneralException{	
		IdentificadorCivilDTO[] identificadorCivilDTOs = null;  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug(" getTiposIdentificacion:start");
			identificadorCivilDTOs = gestionDeVentaAccesoriosSRV.getTiposIdentificacion();
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getTiposIdentificacion:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return identificadorCivilDTOs;
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
	public void deleteTipificacion (Long codArticulo) throws GeneralException {		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("deleteTipificacion:start");
			gestionDeVentaAccesoriosSRV.deleteTipificacion(codArticulo);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("deleteTipificacion:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
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
	public WsInsertTiendaOutDTO insertTienda(TiendaDTO tiendatDTO) throws GeneralException {		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	

		WsInsertTiendaOutDTO wsInsertTiendaOutDTO = null;

		try{
			logger.debug("insertTienda:start");
			wsInsertTiendaOutDTO = gestionDeVentaAccesoriosSRV.insertTienda(tiendatDTO);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("insertTienda:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}

		return wsInsertTiendaOutDTO;
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
	public TiendaDTO[] obtieneListaTienda() throws GeneralException {		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));

		TiendaDTO[] tiendaDTO = null;

		try{
			logger.debug("obtieneListaTienda:start");
			tiendaDTO = gestionDeVentaAccesoriosSRV.obtieneListaTienda();
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("obtieneListaTienda:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return tiendaDTO;
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
	public WsUpdateTiendaOutDTO updateTienda(TiendaDTO tiendaModDTO) throws GeneralException {		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		WsUpdateTiendaOutDTO wsUpdateTiendaOutDTO = null;
		try{
			logger.debug("updateTienda:start");
			wsUpdateTiendaOutDTO = gestionDeVentaAccesoriosSRV.updateTienda(tiendaModDTO);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("updateTienda:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}

		return wsUpdateTiendaOutDTO;
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
	public void deleteTienda(Long codTienda) throws GeneralException {		  
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("deleteTienda:start");
			gestionDeVentaAccesoriosSRV.deleteTienda(codTienda);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("deleteTienda:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
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
	public byte[] getFormFactura(FacturaVO facturaVO)throws GeneralException{	
		byte[] pdfAsBytes = null;
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug(" getFormFactura:start");
			pdfAsBytes = gestionDeVentaAccesoriosSRV.getFormFactura(facturaVO);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getFormFactura:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return pdfAsBytes;
	}	


	/*----------------------------------------------- Aplica Pago ------------------------------------------------*/

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PagoDTO AplicaPago (PagoDTO pagoDTO) throws GeneralException {	
		PagoDTO pagoDTO2 = new PagoDTO();
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug(" AplicaPago:start");						
			pagoDTO2 = gestionDeVentaAccesoriosSRV.AplicaPago(pagoDTO);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("AplicaPago:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return pagoDTO2;
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
	public SerieKitDTO validaSerieKit(SerieKitDTO serieKit)
	throws GeneralException{	
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("valisaSerieKit:start");
			serieKit = gestionDeInventarioSRV.validaSerieKit(serieKit);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("valisaSerieKit:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return serieKit;
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
	public SimcardSNPNDTO getSerieSimcardKit(SerieKitDTO serieKit) 
	throws GeneralException{	
		SimcardSNPNDTO Simcard = new SimcardSNPNDTO();
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("getSerieSimcardKit:start");
			Simcard = gestionDeInventarioSRV.getSerieSimcardKit(serieKit);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getSerieSimcardKit:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return Simcard;
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
	public TerminalSNPNDTO getSerieTerminalKit(SerieKitDTO serieKit) 
	throws GeneralException{	
		TerminalSNPNDTO Terminal = new TerminalSNPNDTO();
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("getSerieTerminalKit:start");
			Terminal = gestionDeInventarioSRV.getSerieTerminalKit(serieKit);
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getSerieTerminalKit:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return Terminal;
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
	public InfoFacturaDTO getInforCargos(String numVenta, String numProceso) 
	throws GeneralException{	
		InfoFacturaDTO infoFactura = new InfoFacturaDTO();
		
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("getInforCargos:start");			
			infoFactura = gestionDeVentaAccesoriosSRV.getInforCargos(numVenta, numProceso);			
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getInforCargos:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return infoFactura;
	}	
	
	/*------------------------------------------------ Carga de Impuesto -----------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public float getImpuesto(String codigoVendedor)throws GeneralException{
		float impuesto = 0;		
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("getInforCargos:start");			
			impuesto = gestionDeVentaAccesoriosSRV.getImpuesto(codigoVendedor);			
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getInforCargos:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return impuesto;
	}	
	
	/*------------------------------------------------- Busca ZIP ------------------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String getZip(DireccionDTO direccion)throws GeneralException{
		String zip = null;
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("getZip:start");			
			zip = gestionDeVentaAccesoriosSRV.getZip(direccion);			
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getZip:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return zip;
	}
	
	/*------------------------------------------------- Listado de Cajas -----------------------------------------*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsCajaOutDTO getListaCaja(String codOficina)throws GeneralException{		
		WsCajaOutDTO cajaOutDTO = null;
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("getListaCaja:start");			
			cajaOutDTO = gestionDeVentaAccesoriosSRV.getListaCaja(codOficina);			
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getListaCaja:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return cajaOutDTO;
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
	public String getNumCelularSeriePrepago(String numSerie, String numVenta) throws GeneralException{		
		String numeroCelular = null;
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{
			logger.debug("getNumCelularSeriePrepago:start");			
			numeroCelular = gestionDeVentaAccesoriosSRV.getNumCelularSeriePrepago(numSerie, numVenta);			
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("getNumCelularSeriePrepago:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return numeroCelular;
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
	public WSCentralQuioscoOutDTO getCentralesQuiosco()
	throws GeneralException{
		WSCentralQuioscoOutDTO resultado = null;
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));
		logger.debug("Inicio:getCentralesQuiosco()");	
		try{
		resultado =   gestionDeVentaAccesoriosSRV.getCentralesQuiosco();
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		
		logger.debug("Fin:getCentralesQuiosco()");
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
	public void insertQuioscoVenta (GaVentasDTO gaVentas) throws GeneralException {	
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{						
			logger.debug("++++++++++++++++++++++++++++++++++ Start : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++");
			gestionDeVentaAccesoriosSRV.insertQuioscoVenta(gaVentas);					
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));
			logger.debug("++++++++++++++++++++++++++++++++++ End : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
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
	public void insertReservArticulo(WsVentaAccesoriosOutDTO ventaAccesorio)throws GeneralException{	
		UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
		try{						
			logger.debug("++++++++++++++++++++++++++++++++++ Start : insertReservArticulo ++++++++++++++++++++++++++++++++++++++++++++");
			gestionDeVentaAccesoriosSRV.insertReservArticulo(ventaAccesorio);					
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));
			logger.debug("++++++++++++++++++++++++++++++++++ End : insertReservArticulo ++++++++++++++++++++++++++++++++++++++++++++");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("InventarioPortabilidadBean.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}		
	
}
