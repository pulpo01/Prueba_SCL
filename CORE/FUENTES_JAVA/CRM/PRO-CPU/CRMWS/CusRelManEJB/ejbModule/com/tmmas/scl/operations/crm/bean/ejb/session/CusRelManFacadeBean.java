/**
 * 
 */
package com.tmmas.scl.operations.crm.bean.ejb.session;

import java.rmi.RemoteException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.lang.SerializationUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.SOAPGeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.IntegracionInClasificacionDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.dao.RegistroFacturacionDAO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.dao.interfaces.RegistroFacturacionDAOIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ActDesPlanAdicDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AuditoriaResponseDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CantidadProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.InNumerosFrecuentesDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProcesoProductoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RespuestaDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.dao.CatalogoDAO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.dao.interfaces.CatalogoDAOIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ContratanteBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DescuentoProductoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ReglasListaNumerosListDTO;
import com.tmmas.scl.operations.crm.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.bean.ejb.helper.TokenSingleton;
import com.tmmas.scl.operations.crm.common.Exception.CusRelManWSException;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosConsultaProductoDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosContrModulosDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosContrPlanesAdicDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosInWSListaPLanesDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosObtProductosContratadosDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosOutWSListaPLanesDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosOutWSObtenerModProductoDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.InWsClasifClienteDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.NumeroCategDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.NumeroSimpleDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.OutWsDatosOutBeneficioDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.ProdOfertableDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.ProdOfertablesBenefDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.ProductoContratadoSimpleDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.RespProductoContratadoSimpleDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.RetornoConTokenDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.RetornoListaNumerosDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.ValidacionAbonadoDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.WSListaProdOferDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.WSPlanesAdicionalesContratadosDTO;
import com.tmmas.scl.operations.crm.delegate.CloCusOrdDelegate;
import com.tmmas.scl.operations.crm.delegate.DetCusOrdFeaDelegate;
import com.tmmas.scl.operations.crm.delegate.FrmkCargosDelegate;
import com.tmmas.scl.operations.crm.delegate.IssCusOrdDelegate;
import com.tmmas.scl.operations.crm.delegate.IssCusOrdORCDelegate;
import com.tmmas.scl.operations.crm.delegate.ManConFacadeDelegate;
import com.tmmas.scl.operations.crm.delegate.ManCusInvDelegate;
import com.tmmas.scl.operations.crm.delegate.ManProOffInvFacadeDelegate;
import com.tmmas.scl.operations.crm.delegate.MessageSender;
import com.tmmas.scl.operations.crm.delegate.SupBillAndColDelegate;
import com.tmmas.scl.operations.crm.delegate.SupCusIntManDelegate;
import com.tmmas.scl.operations.crm.delegate.SupOrdHanDelegate;
import com.tmmas.scl.operations.crm.delegate.helper.CRMRegistro;
import com.tmmas.scl.operations.crm.delegate.helper.CRMUtils;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.CambioPlanAdicionalDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.ContenedorPlanesAdicionalesDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosInBeneficioDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosOutBeneficioDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.PlanesAdicionalesDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;
import com.tmmas.scl.operations.crm.osr.supbillandcol.common.exception.SupBillAndColException;

/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="CusRelManFacade"	
 *           description="An EJB named CusRelManFacade"
 *           display-name="CusRelManFacade"
 *           jndi-name="CusRelManFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class CusRelManFacadeBean implements javax.ejb.SessionBean {

	private SessionContext context = null;
	private final Logger logger = Logger.getLogger(CusRelManFacadeBean.class);	
	private Global global=Global.getInstance();

	
	private IssCusOrdDelegate issCusOrdDelegate=new IssCusOrdDelegate();
	private IssCusOrdORCDelegate issCusOrdORCDelegate=new IssCusOrdORCDelegate();
	private MessageSender messageSender=new MessageSender();
	
	private ManProOffInvFacadeDelegate manProOffInvFacadeDelegate = new ManProOffInvFacadeDelegate();
	private ManConFacadeDelegate manConFacadeDelegate= new ManConFacadeDelegate();	
	private SupOrdHanDelegate supOrdHanDelegate=new SupOrdHanDelegate();	
	private ManCusInvDelegate manCusInvDelegate=new ManCusInvDelegate();
	private SupCusIntManDelegate supCusIntManDelegate = new SupCusIntManDelegate();
	private FrmkCargosDelegate frmkCargosDelegate = new FrmkCargosDelegate();
	private CatalogoDAOIT catalogoDAO=new CatalogoDAO();
	private RegistroFacturacionDAOIT regFactDAO= new RegistroFacturacionDAO();
	private DetCusOrdFeaDelegate detCusOrdFeaDelegate=new DetCusOrdFeaDelegate();
	private SupBillAndColDelegate supBillAndColDelegate = new SupBillAndColDelegate();
	private CloCusOrdDelegate cloCusOrdDelegate = new CloCusOrdDelegate();
	private static final int CODPRODUCTO = 1; //el 1 corresponde a producto celular, tipo definido en SCL
	private CRMUtils crmUtils=CRMUtils.getInstance();
	
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
		this.context=arg0;
	}

	/**
	 * 
	 */
	public CusRelManFacadeBean() {
		// TODO Auto-generated constructor stub
	}
	
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
		VentaDTO dto=new VentaDTO();
		dto.setIdVenta(datosVenta.getNum_venta());
		/**
		 * En esta llamada desde visual basic se debe setear el NomUsuaOra en el campo CodVendedor 301208
		 * */
		dto.setNomUsuaOra(dto.getCodVendedor());
		RetornoDTO retorno=null;
		/**
		 * Creo el proceso 
		 */
		ParametroSerializableDTO process=new ParametroSerializableDTO();
		try{
			process.setNumProceso(datosVenta.getNum_venta());
			process.setOrigenProceso(datosVenta.getCod_proceso());		
			supOrdHanDelegate.crearProceso(process);	
			dto.setNumEvento(supOrdHanDelegate.getProcess().getIdProceso());
			retorno=messageSender.sendToQueueAnulacionVenta(dto);
			supOrdHanDelegate.inscribeProceso("ENCOLADO", (byte[])SerializationUtils.serialize(dto));
			logger.debug("sendToQueueAnulacionVenta:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;
	}
	
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
		OfertaComercialDTO ofertaComercial=null;
		NegSalUtils utils=NegSalUtils.getInstance();
		VentaDTO venta=new VentaDTO();	
		venta.setIdVenta(numeroVenta);
		ClienteDTO cliente=new ClienteDTO();
		cliente.setCodCliente(Long.parseLong(numeroVenta));		
		AbonadoListDTO abonados=null;
		 try{
			cliente=manConFacadeDelegate.obtenerDatosCliente(cliente);		
			
			if("E".equalsIgnoreCase(cliente.getCodTipoPlanTarif()))
			{
				AbonadoDTO porClienteAbon=new AbonadoDTO();
				PlanTarifarioDTO planTarifario=new PlanTarifarioDTO();
				PaqueteDTO paqueteDefault=new PaqueteDTO();
				paqueteDefault.setCodProdPadre(String.valueOf(cliente.getCodProdPadre()));
				paqueteDefault.setIdPaquete(String.valueOf(cliente.getCodProdPadre()));
				planTarifario.setPaqueteDefault(paqueteDefault);					
				porClienteAbon.setPlanTarifario(planTarifario);
				porClienteAbon.setNumAbonado(0);
				porClienteAbon.setNumVenta(Long.parseLong(numeroVenta));
				porClienteAbon.setCodCliente(cliente.getCodCliente());
				AbonadoDTO[] abonadosArray={porClienteAbon};
				cliente.getAbonados().setAbonados(abonadosArray);
				abonados=cliente.getAbonados();
			}
			else		
				abonados=manConFacadeDelegate.obtenerListaAbonados(cliente);
			
			ProductoOfertadoListDTO productosOfertList=null;			
			
			for(int i=0;i<abonados.getAbonados().length;i++)
			{
				CatalogoDTO catalogo=new CatalogoDTO();
				Calendar cal= Calendar.getInstance();			
				cal.set(3000,11,31);			
				catalogo.setCodCanal("VT");
				catalogo.setFecInicioVigencia(new Date());
				catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
				catalogo.setIndNivelAplica("E".equalsIgnoreCase(cliente.getCodTipoPlanTarif())?"C":"A");
				
				abonados.getAbonados()[i]=manConFacadeDelegate.obtenerDatosAbonado(abonados.getAbonados()[i]);
				//PlanTarifarioDTO planTarifario= new PlanTarifarioDTO();					
				abonados.getAbonados()[i].setCodCliente(cliente.getCodCliente());				
				abonados.getAbonados()[i].setCatalogo(catalogo);								
				abonados.getAbonados()[i].setPlanTarifario(new PlanTarifarioDTO());
				abonados.getAbonados()[i].getPlanTarifario().setPaqueteDefault(new PaqueteDTO());
				abonados.getAbonados()[i].getPlanTarifario().getPaqueteDefault().setCodProdPadre("13");
				
				productosOfertList=manProOffInvFacadeDelegate.obtenerProductosOfertables(abonados.getAbonados()[i]);			
				abonados.getAbonados()[i].setProdOfertList(productosOfertList);			
				abonados.getAbonados()[i]=utils.splitProductosPaquetes(abonados.getAbonados()[i]);
				
				for(int indexPaq=0;indexPaq<abonados.getAbonados()[i].getPaqueteList().getPaqueteList().length;indexPaq++)
				{
					ProductoOfertadoListDTO productosDePaquete=manProOffInvFacadeDelegate.obtenerProductosOfertablesPorPaquete(abonados.getAbonados()[i].getPaqueteList().getPaqueteList()[indexPaq]);
					abonados.getAbonados()[i].getPaqueteList().getPaqueteList()[indexPaq].setProductoList(productosDePaquete);					
				}
			}		
			cliente.setAbonados(abonados);
			venta.setCliente(cliente);			
			ofertaComercial=utils.generarOfertaComercial(venta);
		 }
		 catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		 }
		return messageSender.sendToQueueActivacionVenta(ofertaComercial);
	}
	
	
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
	public RetornoDTO sendToQueueActivacionProductosPorDefecto(DatosVentaDTO datosVenta) throws ManConException, ManProOffInvException, NegSalException, SupOrdHanException
	{	
		OfertaComercialDTO ofertaComercial=null;
		NegSalUtils utils=NegSalUtils.getInstance();
		AbonadoListDTO abonados=null;
		ClienteDTO cliente=new ClienteDTO();
		cliente.setCodCliente(Long.parseLong(datosVenta.getCod_cliente())); 
		VentaDTO venta=new VentaDTO();	
		venta.setIdVenta(datosVenta.getNum_venta());
		venta.setCliente(cliente);
		venta.setNomUsuaOra(datosVenta.getCod_vendedor());
		AbonadoDTO porClienteAbon=null;
		
		/**
		 * Creo el proceso 
		 */
		ParametroSerializableDTO process=new ParametroSerializableDTO();
		process.setNumProceso(datosVenta.getNum_venta());
		process.setOrigenProceso(datosVenta.getCod_proceso());		
		supOrdHanDelegate.crearProceso(process);		
		
		cliente=manConFacadeDelegate.obtenerDatosClientePorVenta(venta);	
		abonados=cliente.getAbonados();
		
		if("S".equalsIgnoreCase(cliente.getPrimeraVenta()))
		{
			porClienteAbon=new AbonadoDTO();
			PlanTarifarioDTO planTarifario=new PlanTarifarioDTO();
			PaqueteDTO paqueteDefault=new PaqueteDTO();
			paqueteDefault.setCodProdPadre(String.valueOf(cliente.getCodProdPadre()));
			paqueteDefault.setIdPaquete(String.valueOf(cliente.getCodProdPadre()));
			planTarifario.setPaqueteDefault(paqueteDefault);					
			porClienteAbon.setPlanTarifario(planTarifario);
			porClienteAbon.setNumAbonado(0);
			porClienteAbon.setNumVenta(Long.parseLong(datosVenta.getNum_venta()));
			porClienteAbon.setCodCliente(cliente.getCodCliente());
			
			AbonadoDTO[] listaAbonAux=new AbonadoDTO[abonados.getAbonados().length+1];
			
			for(int i=0;i<abonados.getAbonados().length;i++)
			{
				listaAbonAux[i]=abonados.getAbonados()[i];
			}
			listaAbonAux[abonados.getAbonados().length]=porClienteAbon;
			abonados.setAbonados(listaAbonAux);			
		}			
				
		ProductoOfertadoListDTO productosOfertList=null;			
		
		for(int i=0;i<abonados.getAbonados().length;i++)
		{
			CatalogoDTO catalogo=new CatalogoDTO();
			Calendar cal= Calendar.getInstance();			
			cal.set(3000,11,31);			
			catalogo.setCodCanal(datosVenta.getCod_proceso());
			catalogo.setFecInicioVigencia(new Date());
			catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));			
			catalogo.setIndNivelAplica(abonados.getAbonados()[i].getNumAbonado()!=0?"A":"C");
			
			//abonados.getAbonados()[i]=manConFacadeDelegate.obtenerDatosAbonado(abonados.getAbonados()[i]);
			//PlanTarifarioDTO planTarifario= new PlanTarifarioDTO();					
			abonados.getAbonados()[i].setCodCliente(cliente.getCodCliente());				
			abonados.getAbonados()[i].setCatalogo(catalogo);								
			//abonados.getAbonados()[i].setPlanTarifario(new PlanTarifarioDTO());
			//abonados.getAbonados()[i].getPlanTarifario().setPaqueteDefault(new PaqueteDTO());
			//abonados.getAbonados()[i].getPlanTarifario().getPaqueteDefault().setCodProdPadre("13");
			
			productosOfertList=manProOffInvFacadeDelegate.obtenerProductosOfertablesPaquetePorDefecto(abonados.getAbonados()[i].getPlanTarifario().getPaqueteDefault());			
			
			//**agregar el producto al abonado solo si coincide el indAplica del producto con el del catalogo*//
			/** Se filtra por producto que coincida el indAplica 020109 AO*/
			ArrayList productosAList = new ArrayList();
			ProductoOfertadoDTO producto = null;
			for(int indexPdt=0;indexPdt<productosOfertList.getProductoList().length;indexPdt++)
			{
				producto = productosOfertList.getProductoList()[indexPdt];
				if(catalogo.getIndNivelAplica().equals(producto.getIndAplica()))
				{
					productosAList.add(producto);
				}
			}
			
			ProductoOfertadoDTO[] productos = (ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productosAList.toArray(), ProductoOfertadoDTO.class);
			productosOfertList.setProductoList(productos);
			/** fin 020109 AO*/
			
			abonados.getAbonados()[i].setProdOfertList(productosOfertList);			
			abonados.getAbonados()[i]=utils.splitProductosPaquetes(abonados.getAbonados()[i]);
			
			for(int indexPaq=0;indexPaq<abonados.getAbonados()[i].getPaqueteList().getPaqueteList().length;indexPaq++)
			{
				ProductoOfertadoListDTO productosDePaquete=manProOffInvFacadeDelegate.obtenerProductosOfertablesPorPaquete(abonados.getAbonados()[i].getPaqueteList().getPaqueteList()[indexPaq]);
				abonados.getAbonados()[i].getPaqueteList().getPaqueteList()[indexPaq].setProductoList(productosDePaquete);
				
			}
		}		
		cliente.setAbonados(abonados);
		venta.setCliente(cliente);			
		ofertaComercial=utils.generarOfertaComercial(venta);
		ofertaComercial.setNumEvento(supOrdHanDelegate.getProcess().getIdProceso());
		RetornoDTO retorno=messageSender.sendToQueueActivacionVenta(ofertaComercial);
		supOrdHanDelegate.inscribeProceso("ENCOLADO", (byte[])SerializationUtils.serialize(ofertaComercial));
		return retorno;
	}
	
	
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
		ParametroSerializableDTO process=new ParametroSerializableDTO();
		process.setNumProceso(datosVenta.getNum_venta());
		process.setOrigenProceso(datosVenta.getCod_proceso());
		RetornoDTO retorno=null;
		try{
			supOrdHanDelegate.crearProceso(process);		
			VentaDTO dto=new VentaDTO();
			dto.setIdVenta(datosVenta.getNum_venta());
			dto.setNumEvento(supOrdHanDelegate.getProcess().getIdProceso());
			dto.setOrigenProceso(datosVenta.getCod_proceso());
			/**
			 * En esta llamada desde visual basic se debe setear el NomUsuaOra en el campo CodVendedor 301208
			 * */
			dto.setNomUsuaOra(datosVenta.getCod_vendedor());
			retorno=messageSender.sendToQueueRechazoVenta(dto);			
			supOrdHanDelegate.inscribeProceso("ENCOLADO", (byte[])SerializationUtils.serialize(dto));
		}
		catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;
	}
	
	
	
	
	
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
		Calendar cal=Calendar.getInstance();
		ContenedorPlanesAdicionalesDTO contenedorFinal=new ContenedorPlanesAdicionalesDTO();		
		 
		
		NegSalUtils negSalUtils=NegSalUtils.getInstance();
		RetornoDTO retorno =null;
		try{		
			for(int indexArr=0;indexArr<cambioPlanAdicionalArr.length;indexArr++)
			{
				AbonadoDTO abonadoOrigen=new AbonadoDTO();
				AbonadoDTO abonadoDestino=new AbonadoDTO();
				PlanesAdicionalesDTO[] planesAdicionales=null;
				ArrayList planesAdicionalesArr=new ArrayList();
				ArrayList abonadosBeneficiariosArr=new ArrayList();
					CambioPlanAdicionalDTO cambioPlanAdicional=cambioPlanAdicionalArr[indexArr];
					if(cambioPlanAdicional.getFechaDesactivacionPlanes()==null || "".equals(cambioPlanAdicional.getFechaDesactivacionPlanes()))
					{
						cambioPlanAdicional.setFechaDesactivacionPlanes("31-12-3000");
					}
					
					abonadoOrigen.setNumAbonado(Long.parseLong(cambioPlanAdicional.getAbonadoOrigen()));
					abonadoOrigen.setCodCliente(Long.parseLong(cambioPlanAdicional.getClienteOrigen()));
					abonadoDestino.setNumAbonado(Long.parseLong(cambioPlanAdicional.getAbonadoDestino()));
					abonadoDestino.setCodCliente(Long.parseLong(cambioPlanAdicional.getClienteDestino()));
					
					abonadoOrigen=manConFacadeDelegate.obtenerDatosAbonado(abonadoOrigen);
					abonadoDestino=manConFacadeDelegate.obtenerDatosAbonado(abonadoDestino);
					
					PlanTarifarioDTO planTarifarioOrigen=new PlanTarifarioDTO();
					planTarifarioOrigen.setCodPlanTarif(cambioPlanAdicional.getPlanTarifOrigen());
					planTarifarioOrigen=this.manProOffInvFacadeDelegate.obtenerDetallePlanTarif(planTarifarioOrigen);								
					abonadoOrigen.setPlanTarifario(planTarifarioOrigen);
					
					PlanTarifarioDTO planTarifarioDestino=new PlanTarifarioDTO();
					planTarifarioDestino.setCodPlanTarif(cambioPlanAdicional.getPlanTarifDestino());
					planTarifarioDestino=this.manProOffInvFacadeDelegate.obtenerDetallePlanTarif(planTarifarioDestino);								
					abonadoDestino.setPlanTarifario(planTarifarioDestino);				
							
					if(!planTarifarioOrigen.getCodigoTipoPlan().equals(planTarifarioDestino.getCodigoTipoPlan()))
					{
						/**
						 * Se cumple esta condicion cuando se quiere cambiar de un tipo de plan a otro			  
						 */
						ProductoContratadoListDTO productosADescontratar=manCusInvDelegate.obtenerProductosContratados(abonadoOrigen);
						if(productosADescontratar!=null)
						{
							for(int i=0;i<productosADescontratar.getProductosContratadosDTO().length;i++)
							{
								ProductoContratadoDTO prodAux=productosADescontratar.getProductosContratadosDTO()[i];
								PlanesAdicionalesDTO planAux=new PlanesAdicionalesDTO();
								planAux.setAbonadoDestino(cambioPlanAdicional.getAbonadoDestino());
								planAux.setAbonadoOrigen(cambioPlanAdicional.getAbonadoOrigen());				
								planAux.setAccion("descontratar");
								planAux.setClienteDestino(cambioPlanAdicional.getClienteDestino());
								planAux.setClienteOrigen(cambioPlanAdicional.getClienteOrigen());
								planAux.setNumProceso(cambioPlanAdicional.getNumProceso());
								planAux.setOrigenProceso(cambioPlanAdicional.getOrigenProceso());
								planAux.setNumProducto(String.valueOf(prodAux.getIdProdContratado().longValue()));							
								planAux.setFechaHasta(cambioPlanAdicional.getFechaActivacionPlanes());							
								planesAdicionalesArr.add(planAux);				
							}
						}					
						ProductoOfertadoListDTO productosPorDefectoAcontratar=manProOffInvFacadeDelegate.obtenerProductosOfertablesPaquetePorDefecto(abonadoDestino.getPlanTarifario().getPaqueteDefault());
						if(productosPorDefectoAcontratar!=null)
						{
							for(int i=0;i<productosPorDefectoAcontratar.getProductoList().length;i++)
							{
								ProductoOfertadoDTO prodAux=productosPorDefectoAcontratar.getProductoList()[i];
								PlanesAdicionalesDTO planAux=new PlanesAdicionalesDTO();
								planAux.setAbonadoDestino(cambioPlanAdicional.getAbonadoDestino());
								planAux.setAbonadoOrigen(cambioPlanAdicional.getAbonadoOrigen());				
								planAux.setAccion("contratar");
								planAux.setClienteDestino(cambioPlanAdicional.getClienteDestino());
								planAux.setClienteOrigen(cambioPlanAdicional.getClienteOrigen());
								planAux.setNumProceso(cambioPlanAdicional.getNumProceso());
								planAux.setOrigenProceso(cambioPlanAdicional.getOrigenProceso());
								planAux.setCondicionContratacion("D");
								planAux.setNumProducto(String.valueOf(prodAux.getIdProductoOfertado()));
								planAux.setFechaDesde(cambioPlanAdicional.getFechaActivacionPlanes());
								planAux.setFechaHasta(cambioPlanAdicional.getFechaDesactivacionPlanes());
								planesAdicionalesArr.add(planAux);	
							}
						}
					}
					else if(planTarifarioOrigen.getCodigoTipoPlan().equals(planTarifarioDestino.getCodigoTipoPlan()))
					{
						/**
						 * En caso que tengan el mismo tipo de plan
						 */	
						ProductoContratadoListDTO productosContrOrigen=manCusInvDelegate.obtenerProductosContratados(abonadoOrigen);
						ProductoOfertadoListDTO productosOfertDestino=this.manProOffInvFacadeDelegate.obtenerProductosOfertablesPaquetePorDefecto(abonadoDestino.getPlanTarifario().getPaqueteDefault());					
						
						for(int indexProdDestino=0;indexProdDestino<productosOfertDestino.getProductoList().length;indexProdDestino++)
						{						
							boolean salir=false;
							ProductoOfertadoDTO productoDestino=productosOfertDestino.getProductoList()[indexProdDestino];
							
							PlanesAdicionalesDTO planAux=new PlanesAdicionalesDTO();
							planAux.setAbonadoDestino(cambioPlanAdicional.getAbonadoDestino());
							planAux.setAbonadoOrigen(cambioPlanAdicional.getAbonadoOrigen());				
							planAux.setAccion("contratar");
							planAux.setClienteDestino(cambioPlanAdicional.getClienteDestino());
							planAux.setClienteOrigen(cambioPlanAdicional.getClienteOrigen());
							planAux.setNumProceso(cambioPlanAdicional.getNumProceso());
							planAux.setOrigenProceso(cambioPlanAdicional.getOrigenProceso());
							planAux.setCondicionContratacion("D");
							planAux.setNumProducto(productoDestino.getIdProductoOfertado());		
							planAux.setFechaDesde(cambioPlanAdicional.getFechaActivacionPlanes());
							planAux.setFechaHasta(cambioPlanAdicional.getFechaDesactivacionPlanes());
								
							for(int indxOrigen=0;!salir && indxOrigen<productosContrOrigen.getProductosContratadosDTO().length;indxOrigen++)
							{
								ProductoContratadoDTO productoOrigen=productosContrOrigen.getProductosContratadosDTO()[indxOrigen];
								if(productoOrigen.getProdOfertado().getIdProductoOfertado().equals(productoDestino.getIdProductoOfertado()))
								{
									if("D".equals(productoOrigen.getIndCondicionContratacion()))
										planAux.setAccion("mantener");	
									else
									{
										planAux.setAccion("descontratar");
										planAux.setFechaHasta(cambioPlanAdicional.getFechaActivacionPlanes());
									}
									
									planAux.setNumProducto(String.valueOf(productoOrigen.getIdProdContratado().longValue()));
									salir=true;
								}
							}						
							planesAdicionalesArr.add(planAux);
						}
						
						
						for(int indxOrigen=0;indxOrigen<productosContrOrigen.getProductosContratadosDTO().length;indxOrigen++)
						{
							ProductoContratadoDTO productoOrigen=productosContrOrigen.getProductosContratadosDTO()[indxOrigen];						
							PlanesAdicionalesDTO planAux=new PlanesAdicionalesDTO();
							planAux.setAbonadoDestino(cambioPlanAdicional.getAbonadoDestino());
							planAux.setAbonadoOrigen(cambioPlanAdicional.getAbonadoOrigen());				
							planAux.setAccion("descontratar");
							planAux.setClienteDestino(cambioPlanAdicional.getClienteDestino());
							planAux.setClienteOrigen(cambioPlanAdicional.getClienteOrigen());
							planAux.setNumProceso(cambioPlanAdicional.getNumProceso());
							planAux.setOrigenProceso(cambioPlanAdicional.getOrigenProceso());
							planAux.setNumProducto(String.valueOf(productoOrigen.getIdProdContratado().longValue()));
							planAux.setFechaHasta(cambioPlanAdicional.getFechaActivacionPlanes());
							boolean addItem=true;
							
							for(int indexProdDestino=0;addItem && indexProdDestino<productosOfertDestino.getProductoList().length;indexProdDestino++)
							{
								ProductoOfertadoDTO productoDestino=productosOfertDestino.getProductoList()[indexProdDestino];
								if(productoDestino.getIdProductoOfertado().equals(productoOrigen.getProdOfertado().getIdProductoOfertado()))
								{
									addItem=false;
								}
							}						
							if(addItem)
								planesAdicionalesArr.add(planAux);						
						}					
					}
					AbonadoBeneficiarioDTO abonadoBeneficiario=new AbonadoBeneficiarioDTO();
					abonadoBeneficiario.setCodCliente(Long.parseLong(cambioPlanAdicional.getClienteOrigen()));
					abonadoBeneficiario.setNumAbonado(Long.parseLong(cambioPlanAdicional.getAbonadoOrigen()));
					
					if(cambioPlanAdicional.getFechaDesactivacionPlanes()!=null && !"".equals(cambioPlanAdicional.getFechaDesactivacionPlanes()))
					{
						String[] trozosFecha=cambioPlanAdicional.getFechaDesactivacionPlanes().split("-");
						cal.set(Integer.parseInt(trozosFecha[2]),Integer.parseInt(trozosFecha[1])+1,Integer.parseInt(trozosFecha[0]));
						Timestamp fechaTermino=new Timestamp(cal.getTimeInMillis());					
						abonadoBeneficiario.setFec_Termino_Vigencia(fechaTermino);
					}
					
					int aEjecutar=0;				
					if(("2".equals(planTarifarioOrigen.getCodigoTipoPlan()) || "3".equals(planTarifarioOrigen.getCodigoTipoPlan())) && "1".equals(planTarifarioDestino.getCodigoTipoPlan()))
					{
						aEjecutar=2;
					}
					else if(("2".equals(planTarifarioDestino.getCodigoTipoPlan()) || "3".equals(planTarifarioDestino.getCodigoTipoPlan())) && "1".equals(planTarifarioOrigen.getCodigoTipoPlan()))
					{
						aEjecutar=1;
					}
					abonadoBeneficiario.setEjecutarBenef(aEjecutar);	
					abonadosBeneficiariosArr.add(abonadoBeneficiario);
					
					//****MERGE
					planesAdicionales=(PlanesAdicionalesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(planesAdicionalesArr.toArray(), PlanesAdicionalesDTO.class);
					AbonadoBeneficiarioDTO[] abonBenef=(AbonadoBeneficiarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(abonadosBeneficiariosArr.toArray(), AbonadoBeneficiarioDTO.class);
					AbonadoBeneficiarioListDTO abonBenefList=new AbonadoBeneficiarioListDTO();
					abonBenefList.setAbonadoBeneficiarioList(abonBenef);		
					
					ContenedorPlanesAdicionalesDTO contenedorPlanAdic=crmUtils.mantencionPlanesAdicionales(planesAdicionales);
					contenedorPlanAdic.setAbonadosADesbenificiar(abonBenefList);
					
					contenedorFinal=negSalUtils.mergeContenedorPlanesAdicionales(contenedorPlanAdic, contenedorFinal);
		    }		
		
			retorno=this.issCusOrdORCDelegate.activarDesactivarMantenerProductos(contenedorFinal);	
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new CusRelManWSException(e);
		}
		return retorno;
	}
	
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
	public RetornoDTO mantencionPlanesAdicionales(PlanesAdicionalesDTO[] planesAdicionales) throws 
	IssCusOrdException,
	RemoteException,
	SupOrdHanException
	{
		logger.debug("mantencionPlanesAdicionales:start");
		NegSalUtils negSalUtils=NegSalUtils.getInstance();		
		//CRMUtils crmUtils=CRMUtils.getInstance();
		ContenedorPlanesAdicionalesDTO contenedorFinal=new ContenedorPlanesAdicionalesDTO();	
		ContenedorPlanesAdicionalesDTO contenedorPlanAdic = null;
		logger.debug("crmUtils.mantencionPlanesAdicionales:antes");
		contenedorPlanAdic = crmUtils.mantencionPlanesAdicionales(planesAdicionales);
		logger.debug("crmUtils.mantencionPlanesAdicionales:despues");		
		logger.debug("negSalUtils.mergeContenedorPlanesAdicionales:antes");
		contenedorFinal=negSalUtils.mergeContenedorPlanesAdicionales(contenedorPlanAdic, contenedorFinal);
		
		if (contenedorPlanAdic.getOfComercialContratar() == null)  {
			logger.debug("Oferta comercial del contenedor original nula");
			contenedorFinal.setOfComercialContratar(null);
		}
		logger.debug("negSalUtils.mergeContenedorPlanesAdicionales:despues");
		logger.debug("issCusOrdORCDelegate.activarDesactivarMantenerProductos:antes");
		RetornoDTO retorno=this.issCusOrdORCDelegate.activarDesactivarMantenerProductos(contenedorFinal);
		logger.debug("issCusOrdORCDelegate.activarDesactivarMantenerProductos:despues");
		logger.debug("mantencionPlanesAdicionales:end");
		return retorno;		
	}
	
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
	public DatosOutBeneficioDTO[] obtenerProductosOfertablesBeneficiario(DatosInBeneficioDTO datosInBeneficio) throws ManConException, ManProOffInvException, NegSalException
	//, SOAPGeneralException
	{	
		long validacion = 0;
		
		validacion = Long.parseLong(datosInBeneficio.getNumAbonadoBeneficiario());
					
		ArrayList filtro = new ArrayList();
		GeneralException generalException=null; 
		try{
			if ((datosInBeneficio.getNumAbonadoBeneficiario()==null) ||	(validacion==0)){
				// si es un string o esta vacio el benediciario tiene que tener el mismo valor que el contratado 
				datosInBeneficio.setNumAbonadoBeneficiario(datosInBeneficio.getNumAbonadoContratado());
			}
			
			
			AbonadoDTO abonadoContratante = new AbonadoDTO();
			abonadoContratante.setNumCelular(Long.parseLong(datosInBeneficio.getNumAbonadoContratado()));
			abonadoContratante = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoContratante);
	
			if ((abonadoContratante.getCodSituacion().equals("BAP"))||(abonadoContratante.getCodSituacion().equals("BAA")))
			{
				generalException= new GeneralException();
				generalException.setMessage("El abonado contrantante se encuentra en estado de baja..");
				generalException.setCodigo("situacion del abonado contratante no valida");
				generalException.setCodigoEvento(2);				
				logger.debug("Exception[", generalException);
				//throw new ManProOffInvException(abonadoContratanteBAA);				
			}
			
			if (generalException==null)
			{
				AbonadoDTO abonadoBeneficiario = new AbonadoDTO();
				abonadoBeneficiario.setNumCelular(Long.parseLong(datosInBeneficio.getNumAbonadoBeneficiario()));
				abonadoBeneficiario = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoBeneficiario);
		
				String planTarifBene = abonadoBeneficiario.getCodTipPlan();
						
				CatalogoDTO catalogo=new CatalogoDTO();
				Calendar cal= Calendar.getInstance();                
		        cal.set(3000,11,31);               
		        catalogo.setCodCanal(datosInBeneficio.getCanalOrigenPro());
		        catalogo.setFecInicioVigencia(new Date());
		        catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));        
		        catalogo.setIndNivelAplica(abonadoContratante.getNumAbonado()!=0?"A":"C");
		         
		        abonadoContratante.setCatalogo(catalogo);		
				abonadoContratante.setPlanTarifario(new PlanTarifarioDTO());
				abonadoContratante.getPlanTarifario().setPaqueteDefault(new PaqueteDTO());
				abonadoContratante.getPlanTarifario().getPaqueteDefault().setCodProdPadre(abonadoContratante.getCodProdPadre());
				
				ProductoOfertadoListDTO productosOfertListContratante=manProOffInvFacadeDelegate.obtenerProductosOfertables(abonadoContratante);
				
				/**
				 * @author rlozano
				 * @descripcion : se obtiene los limites de consumo asociados a los PA
				 * @date 30042010
				 */
				
				productosOfertListContratante=manProOffInvFacadeDelegate.obtenerLCplanAdicional(productosOfertListContratante);
				
				
				for (int p = 0;p<productosOfertListContratante.getProductoList().length-1;p++){
					ProductoOfertadoDTO productoAbonadoContratante = productosOfertListContratante.getProductoList()[p];
					if (planTarifBene.equals(productoAbonadoContratante.getIndTipoPlataforma())){
						DatosOutBeneficioDTO beneficioDTO = new DatosOutBeneficioDTO();
						beneficioDTO.setCodigoProductoOfertado(productoAbonadoContratante.getIdProductoOfertado());
						beneficioDTO.setDescripcionProductoOfertado(productoAbonadoContratante.getDesProdOfertado());	
						filtro.add(beneficioDTO);
					}
				}
		
				if (filtro.size()==0){				
					generalException= new GeneralException();
					generalException.setMessage("No se encontraron productos ofertables");
					generalException.setCodigo("no hay productos ofertables");
					generalException.setCodigoEvento(1);				
					logger.debug("Exception[", generalException);
					//throw new ManProOffInvException(NoTraeProductos);
	//				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	//                       " ", "Server fallo", "lstUsuario fallo", " ", NoTraeProductos);
	//				throw errorSoap.obtenerGeneralSoapException();
					
					
				}
		   }
			if (generalException!=null)
			{
				throw (generalException);
			}
		}
		
		catch(ManConException e)
		{
			logger.debug("ManConException");
			logger.error(e);
			throw(e);
			
		}
		catch(ManProOffInvException e)
		{
			logger.debug("ManProOffInvException");
			logger.error(e);
			throw(e);
			
		}
		catch(GeneralException e)
		{
			logger.debug("GeneralException");
			logger.error(e);
			throw new ManConException(e);
			
		}
		
		catch(Exception e)
		{
			logger.debug("Exception");
			logger.error(e);
			throw new ManConException(e);
		}
		
		
		
		
		DatosOutBeneficioDTO[] productoBeneficio = null;
		productoBeneficio = (DatosOutBeneficioDTO[])ArrayUtl.copiaArregloTipoEspecifico(filtro.toArray(), DatosOutBeneficioDTO.class);

		return productoBeneficio;
	}
	
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
	public RetornoDTO contratacionPlanesAdicionalesOpcionales
	(DatosContrPlanesAdicDTO datosContratacion) throws SOAPGeneralException,RemoteException{
		
		//CRMUtils crmUtils=CRMUtils.getInstance();
		logger.debug("ContratacionPlanesAdicionalesOpcionales:start");
		
		ClienteDTO cliente = new ClienteDTO();
		AbonadoDTO abonado = new AbonadoDTO();
		AbonadoListDTO abonadoList = new AbonadoListDTO();
		AbonadoDTO[] abonadoArray = new AbonadoDTO[1];
		ProductoOfertadoListDTO prodOfertadoList = new ProductoOfertadoListDTO();
		VentaDTO venta = new VentaDTO();
		OfertaComercialDTO ofertaComercial=new OfertaComercialDTO();
		RetornoDTO retorno = null;
		
		try{
		//obtención de datos
		
		//1. obtener datos del abonado
		abonado.setNumCelular(Long.parseLong(datosContratacion.getNumCelular()));
		abonado = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonado);
			
		//2. obtener datos del cliente
		cliente.setCodCliente(abonado.getCodCliente()); 
		cliente=manConFacadeDelegate.obtenerDatosCliente(cliente);	
		
		//3. verificar nivel de contratacion
		if (datosContratacion.getNivelAplicacion().equalsIgnoreCase("C")){ 
			//Se debe crear un abonado cero para contratar el plan adicional a nivel de cliente
			abonado = new AbonadoDTO();
			
			PlanTarifarioDTO planTarifario=new PlanTarifarioDTO();
			PaqueteDTO paqueteDefault=new PaqueteDTO();
			paqueteDefault.setCodProdPadre(String.valueOf(cliente.getCodProdPadre()));
			paqueteDefault.setIdPaquete(String.valueOf(cliente.getCodProdPadre()));
			planTarifario.setPaqueteDefault(paqueteDefault);
			
			abonado.setPlanTarifario(planTarifario);
			abonado.setNumAbonado(0);
			abonado.setNumVenta(Long.parseLong(datosContratacion.getNumVenta()));
			abonado.setCodCliente(cliente.getCodCliente());
			abonado.setCodTipPlan(cliente.getCodTipoPlan());
			abonado.setTipoCliente(cliente.getCodTipoPlanTarif());
		}
		
		//4. obtener catalogo
		CatalogoDTO catalogo=new CatalogoDTO();
		Calendar cal= Calendar.getInstance();			
		cal.set(3000,11,31);			
		catalogo.setCodCanal(datosContratacion.getCodCanal());
		catalogo.setFecInicioVigencia(new Date());
		catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
		catalogo.setIndNivelAplica("E".equalsIgnoreCase(cliente.getCodTipoPlanTarif())?"C":"A");
		abonado.setCatalogo(catalogo);
		
		//5. para cada codigo de producto ofertado se obtiene su detalle
		int totalProd = datosContratacion.getListaProductos().length;
		ProductoOfertadoDTO[] listaProd= new ProductoOfertadoDTO[totalProd];
		for(int i=0;i<totalProd; i++){
			ProductoOfertadoDTO producto= new ProductoOfertadoDTO();
			producto.setIdProductoOfertado(datosContratacion.getListaProductos()[i]);
			listaProd[i]=producto;
		}
		
		prodOfertadoList.setProductoList(listaProd);
		prodOfertadoList = manProOffInvFacadeDelegate.obtenerDetalleProductos(prodOfertadoList);
		
		//para cada detalle se setea el indicador de contratacion
		String indConContr = global.getValor("ind.condicion.contratacion");
		ProductoOfertadoDTO[] prodOferTemp = prodOfertadoList.getProductoList();
		
		for(int i=0; i<prodOferTemp.length;i++){
			prodOferTemp[i].setIndCondicionContratacion(indConContr);
		}
		abonado.setProdOfertList(prodOfertadoList);
		
		PaqueteListDTO paqueteList = new PaqueteListDTO();
		paqueteList.setPaqueteList(new PaqueteDTO[0]);
		abonado.setPaqueteList(paqueteList);
		
		//6. completar toda la información comercial
		abonadoArray[0]=abonado;
		abonadoList.setAbonados(abonadoArray);
		cliente.setAbonados(abonadoList);
		
		venta.setIdVenta(datosContratacion.getNumVenta());
		venta.setCliente(cliente);
		
		NegSalUtils utils=NegSalUtils.getInstance();
		ofertaComercial=utils.generarOfertaComercial(venta);
		
		//7. completar informacion de cliente abonado beneficiario, si es que corresponde
		if (datosContratacion.getNumCelularBenef()!=null && !datosContratacion.getNumCelularBenef().trim().equals("")){
			//obtener datos del abonado para obtener el codigo del cliente
			AbonadoDTO abonadoBenef = new AbonadoDTO();
			abonadoBenef.setNumCelular(Long.parseLong(datosContratacion.getNumCelularBenef()));
			abonadoBenef = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoBenef);
			
			int totalProdCon = ofertaComercial.getProductoList().getProductosContratadosDTO().length;
			
			for(int i=0; i<totalProdCon; i++){
				ofertaComercial.getProductoList().getProductosContratadosDTO()[i].setIdClienteBeneficiario(new Long(abonadoBenef.getCodCliente()));
				ofertaComercial.getProductoList().getProductosContratadosDTO()[i].setIdAbonadoBeneficiario(new Long(abonadoBenef.getNumAbonado()));
			}
			
		}
		
		
		//8. invoca al metodo que realiza la contratacion
		retorno=this.issCusOrdORCDelegate.activarProductoContratado(ofertaComercial);
		}
		catch(GeneralException e){
			throw crmUtils.errorSoap(e).obtenerGeneralSoapException();
		}
		catch(Exception e){
			throw crmUtils.errorSoap(e).obtenerGeneralSoapException();
		}

		logger.debug("ContratacionPlanesAdicionalesOpcionales:end");
		return retorno;
	}
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
	throws SOAPGeneralException,RemoteException{
		RetornoDTO retorno = new RetornoDTO();
		CRMUtils crmUtils=CRMUtils.getInstance();
		logger.debug("contratacionModulos:start");
		
		String codMsg = "";
		String mensaje = "";
		
		try{
			if (datosContratacion.getNumCelularContr()==null || datosContratacion.getNumCelularContr().trim().equals("")||!crmUtils.isNumber(datosContratacion.getNumCelularContr())){
				codMsg="1";
				mensaje = "Número de celular de abonado contratante debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}else
			if (datosContratacion.getCantidad()==null || datosContratacion.getCantidad().equals("")){
				codMsg="2";
				mensaje = "Cantidad del módulo a activar debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}else
			if (datosContratacion.getCantidad().trim().equals("0")){
				codMsg="3";
				mensaje = "Cantidad del módulo a activar debe ser mayor a 0";
				throw new GeneralException(codMsg,0, mensaje);
			}else				
			if (datosContratacion.getCodModulo()==null || datosContratacion.getCodModulo().trim().equals("")){
				codMsg="5";
				mensaje = "Código del modulo a activar debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}else
			if (datosContratacion.getCodCanal()==null || datosContratacion.getCodCanal().trim().equals("")){
				codMsg="6";
				mensaje = "Canal debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}
			//(+) EV 07/01/09 inc #061
			else
			if (datosContratacion.getUsuario()==null || datosContratacion.getUsuario().equals("")){
				codMsg="7";
				mensaje = "Usuario debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}
			//(-) EV 07/01/09 inc #061
			
			if (datosContratacion.getNumCelularBenef()==null || datosContratacion.getNumCelularBenef().trim().equals("")){
				datosContratacion.setNumCelularBenef(datosContratacion.getNumCelularContr());
			}
			else if(!crmUtils.isNumber(datosContratacion.getNumCelularBenef()))
			{
				mensaje = "Número de celular de abonado beneficiario no es válido:["+datosContratacion.getNumCelularBenef()+"]";
				throw new GeneralException(codMsg,0, mensaje);
			}
			
			if ( !codMsg.equals("")){
				throw new GeneralException(codMsg,0, mensaje);
			}

			//1. Se debe ejecutar el método de validación para el abonado contratante, 
			//el abonado beneficiario, la cantidad y monto de módulo contratado
			ContratanteBeneficiarioDTO paramValidacion = new ContratanteBeneficiarioDTO();
			paramValidacion.setNumCelularContratante(datosContratacion.getNumCelularContr());
			paramValidacion.setNumCelularBeneficiario(datosContratacion.getNumCelularBenef());
			paramValidacion.setCodProducto(global.getValor("codigo.producto"));
			paramValidacion.setCanProducto(datosContratacion.getCantidad());
			paramValidacion.setCanal(datosContratacion.getCodCanal());
			
			
			
		
			//2. Se debe obtener el código de cliente y número de abonado del contratante 
			//y código de cliente y número de abonado beneficiario.
			ClienteDTO clienteContr = new ClienteDTO();
			AbonadoDTO abonadoContr = new AbonadoDTO();
	
			//contratante
			abonadoContr.setNumCelular(Long.parseLong(datosContratacion.getNumCelularContr()));
			abonadoContr = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoContr);
			/**
			 * @author rlozano
			 * @description se vuelve a invocar para obtener datos opcionales del abonado. Esto queda pendiente de refactoring.
			 * @date 04-02-2009
			 */
			abonadoContr = manConFacadeDelegate.obtenerDatosAbonado(abonadoContr);
			
			RetornoDTO retornoVal = supCusIntManDelegate.validarContratanteBeneficiario(paramValidacion);
			
			if (!retornoVal.isResultado()){
				codMsg="5";
				mensaje = retornoVal.getDescripcion(); 
				throw new GeneralException(codMsg,0, mensaje);
			}
			
			/**
			 * @description : setear ciclo de facturacion codciclfact
			 */
				
			clienteContr.setCodCliente(abonadoContr.getCodCliente()); 
			clienteContr=manConFacadeDelegate.obtenerDatosCliente(clienteContr);
			
//			3. Obtener orden de servicio
			SecuenciaDTO secuencia = new SecuenciaDTO();
			secuencia.setNomSecuencia("CI_SEQ_NUMOS");
			secuencia = supOrdHanDelegate.obtenerSecuencia(secuencia);
			String usuarioOra ="";
			int codVendedor=0;
			
			//(+) EV 12/01/2008
			long numOOSS =  secuencia.getNumSecuencia();
			//(-) EV 12/01/2008
			
			//obtiene usuario
			//(+) EV 07/01/09 inc #061 
			/*ParametroDTO parametro = new ParametroDTO();
			parametro.setNomParametro("USUARIO_IVR");
			parametro.setCodModulo("GA");
			parametro.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
			parametro = this.supOrdHanDelegate.obtenerParametroGeneral(parametro);
			usuarioOra =  parametro.getValor();*/
			usuarioOra = datosContratacion.getUsuario();
			//(-) EV 07/01/09 inc #061
			
			logger.debug("usuarioOra="+ usuarioOra);
			//obtiene vendedor
			UsuarioDTO usuario = new UsuarioDTO();
			usuario.setNombre(usuarioOra);
			usuario = this.supOrdHanDelegate.obtenerVendedor(usuario);
			codVendedor = usuario.getCodigo();
			
			/***
			 * @author rlozano
			 * @description Se invoca método para validación y verificación de datos :  PL de Restricciones
			 * @date 17-12-2008
			 */
			RestriccionesDTO restriccionesDTO =new RestriccionesDTO();
			restriccionesDTO.setNumAbonado(abonadoContr.getNumAbonado());
			restriccionesDTO.setCodCliente(abonadoContr.getCodCliente());
			restriccionesDTO.setNumVenta(abonadoContr.getNumVenta());
			restriccionesDTO.setCodUso(Integer.parseInt(abonadoContr.getCodUso()));
			restriccionesDTO.setCodCuentaOrigen(abonadoContr.getCodCuenta());
			restriccionesDTO.setCodCuentaDestino(abonadoContr.getCodCuenta());
			restriccionesDTO.setTipoPlan(abonadoContr.getCodTipoPlanTarif());
			restriccionesDTO.setNumCiclo(abonadoContr.getCodCiclo());
			restriccionesDTO.setCodCentral(abonadoContr.getCodCentral());
			
			//(+) EV
			//obtener secuencia
			SecuenciaDTO secuenciaTransacabo = new SecuenciaDTO();
			secuenciaTransacabo.setNomSecuencia("GA_SEQ_TRANSACABO");
			secuenciaTransacabo = supOrdHanDelegate.obtenerSecuencia(secuenciaTransacabo);
			
//			TODO : Solo como referencia;
			restriccionesDTO.setIdSecuencia(secuenciaTransacabo.getNumSecuencia());
			//(-) EV
			
			String codOosExtTiempo = global.getValor("cod.ooss.extratiempo");
			String codOosPasModulo = global.getValor("cod.ooss.pasamodulo");
			//String codTiPlanPospago = global.getValor("cod.tipoplan.pospago");
			
			
			String codOOS = codOosExtTiempo; 
			if (datosContratacion.getNumCelularBenef()!=datosContratacion.getNumCelularContr() ){
				codOOS = codOosPasModulo; 
			}
			restriccionesDTO.setCodActuacion(global.getValor("cod.act.ooss."+codOOS));
			restriccionesDTO.setCodOOSS(codOOS);
			restriccionesDTO.setCodVendedor(String.valueOf(codVendedor));
			
			retorno = this.aplicaPLRestricciones(restriccionesDTO);
			if ("OK".equals(retorno.getDescripcion())){
			
				//4. verificar nivel de contratacion
				if (datosContratacion.getNivelAplicacion().equalsIgnoreCase("C")){ 
					//Se debe crear un abonado cero para contratar el plan adicional a nivel de cliente
					abonadoContr = new AbonadoDTO();
					
					PlanTarifarioDTO planTarifario=new PlanTarifarioDTO();
					PaqueteDTO paqueteDefault=new PaqueteDTO();
					paqueteDefault.setCodProdPadre(String.valueOf(clienteContr.getCodProdPadre()));
					paqueteDefault.setIdPaquete(String.valueOf(clienteContr.getCodProdPadre()));
					planTarifario.setPaqueteDefault(paqueteDefault);
					
					abonadoContr.setPlanTarifario(planTarifario);
					abonadoContr.setNumAbonado(0);
					abonadoContr.setNumVenta(numOOSS);
					abonadoContr.setCodCliente(clienteContr.getCodCliente());
					abonadoContr.setCodTipPlan(clienteContr.getCodTipoPlan());
					abonadoContr.setTipoCliente(clienteContr.getCodTipoPlanTarif());
				}
				
				//5. obtener catalogo
				CatalogoDTO catalogo=new CatalogoDTO();
				Calendar cal= Calendar.getInstance();			
				cal.set(3000,11,31);			
				catalogo.setCodCanal(datosContratacion.getCodCanal());
				catalogo.setFecInicioVigencia(new Date());
				catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
				catalogo.setIndNivelAplica("E".equalsIgnoreCase(clienteContr.getCodTipoPlanTarif())?"C":"A");
				
				
				
				
				
				
				abonadoContr.setCatalogo(catalogo);
				
				//6. obtiene el detalle del producto ofertado
				ProductoOfertadoListDTO prodOfertadoList = new ProductoOfertadoListDTO();
				ProductoOfertadoDTO[] listaProd= new ProductoOfertadoDTO[1];
				ProductoOfertadoDTO producto= new ProductoOfertadoDTO();
				producto.setIdProductoOfertado(datosContratacion.getCodModulo());
				listaProd[0]=producto;
				
				prodOfertadoList.setProductoList(listaProd);
				prodOfertadoList = manProOffInvFacadeDelegate.obtenerDetalleProductos(prodOfertadoList);
				
				//(+) EV 07/01/09 inc #061
				int maxContr=0;
				int cantContrUsuario = Integer.parseInt(datosContratacion.getCantidad());
				if (prodOfertadoList.getProductoList().length>0)		maxContr = Integer.parseInt(prodOfertadoList.getProductoList()[0].getMaxContrataciones());
				
				CantidadProductoContratadoDTO cantidadProd=new CantidadProductoContratadoDTO();
				cantidadProd.setCodProducto(Long.parseLong(prodOfertadoList.getProductoList()[0].getIdProductoOfertado()));				
				cantidadProd.setCodCliente(abonadoContr.getCodCliente());
				cantidadProd.setNumAbonado(abonadoContr.getNumAbonado());
				
				cantidadProd = manCusInvDelegate.obtieneCantidadProductosContratados(cantidadProd);
				logger.debug("cantidad productos ya contratados="+cantidadProd.getCantidad());
				maxContr = maxContr - cantidadProd.getCantidad();
				
				if (cantContrUsuario > maxContr){
					codMsg="7";
					mensaje = "Cantidad de módulos a contratar supera el máximo'";
					throw new GeneralException(codMsg,0, mensaje);
				}else{
					ProductoOfertadoDTO prodOferAux = null;
					ProductoOfertadoDTO[] prodOfertadoListNueva= new ProductoOfertadoDTO[cantContrUsuario]; 
					
					//setea el indicador de contratacion
					String indConContr = global.getValor("ind.condicion.contratacion");
					prodOfertadoList.getProductoList()[0].setIndCondicionContratacion(indConContr);
					
					//copia el producto tantas veces segun la cantidad ingresada por el usuario
					for (int i=0; i<cantContrUsuario;i++){
						prodOferAux = (ProductoOfertadoDTO)prodOfertadoList.getProductoList()[0].clone();
						prodOfertadoListNueva[i] = prodOferAux;
					}
					prodOfertadoList.setProductoList(prodOfertadoListNueva);
				}
				
				//(-) EV 07/01/09 inc #061
				
				/***
				 * @description Se obtienen los cargos asociados al producto
				 * @date 11-12-2008
				 */
				
				
				for(int i=0;i<prodOfertadoList.getProductoList().length;i++)
				{
					ProductoOfertadoDTO prod=null;
					CargoListDTO cargos=null;
					DescuentoProductoListDTO descuentosCargo=null;
					prod=prodOfertadoList.getProductoList()[i];			
					catalogo.setCodProdOfertado(prod.getIdProductoOfertado());
					catalogo.setCodVendedor(String.valueOf(codVendedor));
					
					cargos=catalogoDAO.obtenerCargosProductos(catalogo);
					
					if(cargos!=null && cargos.getCargoList()!=null)
					{
						for(int j=0;j<cargos.getCargoList().length;j++)
						{
							catalogo.setCodConcepto(cargos.getCargoList()[j].getCodConcepto());
							descuentosCargo=catalogoDAO.obtenerDescuentosCargo(catalogo);
							cargos.getCargoList()[j].setDescuentos(descuentosCargo);
						}
					}
					//cargos.getCargoList()[0].
					prodOfertadoList.getProductoList()[i].setCargoList(cargos);			
				}
				
				

				
				abonadoContr.setProdOfertList(prodOfertadoList);
				
				PaqueteListDTO paqueteList = new PaqueteListDTO();
				paqueteList.setPaqueteList(new PaqueteDTO[0]);
				abonadoContr.setPaqueteList(paqueteList);
				
				//7. completa información comercial
				AbonadoListDTO abonadoList = new AbonadoListDTO();
				AbonadoDTO[] abonadoArray = new AbonadoDTO[1];
				VentaDTO venta = new VentaDTO();
				OfertaComercialDTO ofertaComercial=new OfertaComercialDTO();
				
				abonadoArray[0]=abonadoContr;
				abonadoList.setAbonados(abonadoArray);
				clienteContr.setAbonados(abonadoList);
				
				ClienteDTO clientDTO= new ClienteDTO();
				clientDTO.setCodCliente(clienteContr.getCodCliente());
				clientDTO.setCodCiclo(clienteContr.getCodCiclo());
				RegistroFacturacionDTO regFactDTO=new RegistroFacturacionDTO();
				regFactDTO =regFactDAO.getCodigoCicloFacturacion(clientDTO);
				clienteContr.setCodCicloFacturacion(regFactDTO.getCodigoCicloFacturacion());
				
				venta.setIdVenta(String.valueOf(numOOSS));
				venta.setCliente(clienteContr);
				venta.setFlagCiclo(global.getValor("parametro.flag.a.ciclo.1"));
				venta.setNomUsuaOra(usuarioOra);//EV 07/01/09 inc #061
				
				NegSalUtils utils=NegSalUtils.getInstance();
				ofertaComercial=utils.generarOfertaComercial(venta);
				boolean isNullCargOcas=ofertaComercial.getCargoOcasionalList()==null||ofertaComercial.getCargoOcasionalList().getCargoOcasional()==null?true:false;
				if (!isNullCargOcas){
					
					for (int k=0;k<ofertaComercial.getCargoOcasionalList().getCargoOcasional().length;k++){
						ofertaComercial.getCargoOcasionalList().getCargoOcasional()[k].setCodPlanCom(String.valueOf(clienteContr.getCodPlanCom()));
					}
				}
				
				//8. completa informacion de cliente abonado beneficiario, si es que corresponde
				//y se deduce codigo de orden de servicio
				String codOossExtTiempo = global.getValor("cod.ooss.extratiempo");
				String codOossPasModulo = global.getValor("cod.ooss.pasamodulo");
				String codTipPlanPospago = global.getValor("cod.tipoplan.pospago");
				
				String codOOSS = codOossExtTiempo; 
				if (datosContratacion.getNumCelularBenef()!=datosContratacion.getNumCelularContr() ){
					codOOSS = codOossPasModulo; 
					
					AbonadoDTO abonadoBenef = new AbonadoDTO();
					abonadoBenef.setNumCelular(Long.parseLong(datosContratacion.getNumCelularBenef()));
					abonadoBenef = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoBenef);
					
					ofertaComercial.getProductoList().getProductosContratadosDTO()[0].setIdClienteBeneficiario(new Long(abonadoBenef.getCodCliente()));
					ofertaComercial.getProductoList().getProductosContratadosDTO()[0].setIdAbonadoBeneficiario(new Long(abonadoBenef.getNumAbonado()));
					
					if (abonadoBenef.getCodTipPlan().equals(codTipPlanPospago)){
						codMsg = "0";
						mensaje= "Ha recibido un regalo";
						retorno.setCodigo(codMsg);
						retorno.setDescripcion(mensaje);
					}
				}
				
				//9. invoca al metodo que realiza la contratacion
				retorno=this.issCusOrdORCDelegate.activarProductoContratado(ofertaComercial);
				logger.debug("contratacion realizada");
				
				//10. obtiene y registra cargos
				CRMRegistro crmRegistro = new CRMRegistro();
				String codActAbo = crmRegistro.obtenerCodActAbo(codOOSS);
				ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();
				ParametrosObtencionCargosDTO paramObtCargos = crmRegistro.obtenerParamObtCargos(abonadoContr, codOOSS, codActAbo);
				crmRegistro.imprimirParamObtCargos(paramObtCargos);
				
				logger.debug("-------------------------------------------------------------");			
				obtencionCargos=frmkCargosDelegate.obtenerCargos(paramObtCargos);
				logger.debug("-------------Retorno cargos----------------");
	
				crmRegistro.imprimirCargos(obtencionCargos.getCargos());
	
				
				
				crmRegistro.registrarCargos(retorno, clienteContr, obtencionCargos, codVendedor);
				
				//11. registra la orden de servicio
				retorno = crmRegistro.registrarOrdenServicio(datosContratacion, abonadoContr, numOOSS, codOOSS, codActAbo, usuarioOra);
	
				retorno.setCodigo("0");
				retorno.setDescripcion("Exito");
				retorno.setResultado(true);
			}
		}catch(GeneralException e){
			retorno.setCodigo(e.getCodigo());
			retorno.setDescripcion(e.getDescripcionEvento());
			this.context.setRollbackOnly();
		}
		catch(Exception e){
			retorno.setCodigo("-1");
			retorno.setDescripcion("Ha ocurrido un error en la contratación de módulos");
			this.context.setRollbackOnly();
		}
		
		logger.debug("contratacionModulos:end");
		return retorno;
	}
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
	public RetornoListaNumerosDTO consultaDetalleProductoContratado(DatosConsultaProductoDTO datosConsulta)	throws SOAPGeneralException,RemoteException{

		RetornoListaNumerosDTO retornoLista = new RetornoListaNumerosDTO();
		//CRMUtils crmUtils=CRMUtils.getInstance();
		logger.debug("consultaDetalleProductoContratado:start");
		
		String codMsg = "";
		String mensaje = "";
		
		try{
			if (datosConsulta.getNumCelularContr()==null || datosConsulta.getNumCelularContr().trim().equals("")){
				codMsg="1";
				mensaje = "Número de celular de abonado contratante debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}else
			if (datosConsulta.getCodProducto()==null || datosConsulta.getCodProducto().trim().equals("")){
				codMsg="2";
				mensaje = "Código del producto debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}else
			if (datosConsulta.getCodCanal()==null || datosConsulta.getCodCanal().trim().equals("")){
				codMsg="3";
				mensaje = "Canal debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}

			if ( !codMsg.equals("")){
				throw new GeneralException(codMsg,0, mensaje);
			}
			
			//Se debe obtener el código de cliente y número de abonado del número celular a consultar
			AbonadoDTO abonadoContr = new AbonadoDTO();
			ClienteDTO clienteContr = new ClienteDTO();
			abonadoContr.setNumCelular(Long.parseLong(datosConsulta.getNumCelularContr()));
			abonadoContr = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoContr);
				
			clienteContr.setCodCliente(abonadoContr.getCodCliente()); 
			clienteContr=manConFacadeDelegate.obtenerDatosCliente(clienteContr);	
			
			SecuenciaDTO secuencia = new SecuenciaDTO();
			secuencia.setNomSecuencia("CI_SEQ_NUMOS");
			secuencia = supOrdHanDelegate.obtenerSecuencia(secuencia);

			long numOOSS =  secuencia.getNumSecuencia();

			//Se debe obtener el detalle de los números frecuentes o códigos de cliente del plan adicional contratado.
			ProductoContratadoDTO productoContratado = new ProductoContratadoDTO();
			productoContratado.setIdProdContratado(new Long(datosConsulta.getCodProducto()));
			NumeroListDTO listaNumeros = manCusInvDelegate.obtenerListaNumeros(productoContratado);
		
			NumeroCategDTO[] listaNumerosCateg =  new NumeroCategDTO[0];
			Date hoy = new Date();
			ArrayList listaNum= new ArrayList();
			if (listaNumeros!=null){
				
				/**
				 * @author rlozano
				 * @description se filtra los numeros frecuentes por fecha de vigencia
				 * @date 05-05-2010
				 */
				for (int num=0;num<listaNumeros.getNumerosDTO().length;num++)
				{
					if (listaNumeros.getNumerosDTO()[num].getFecTerminoVigencia().after(hoy))
					{
						listaNum.add(listaNumeros.getNumerosDTO()[num]);
					}
				}
				
				NumeroDTO[] numeros= (NumeroDTO[])listaNum.toArray(new NumeroDTO[listaNum.size()]);//listaNumeros.getNumerosDTO();
				int total = numeros.length;
				
				logger.debug("totalNumeros="+ total);
				listaNumerosCateg = new NumeroCategDTO[total];
				for(int i=0; i<total; i++){
					NumeroCategDTO num = new NumeroCategDTO();
					num.setIdProductoContratado(numeros[i].getIdProductoContratado());
					num.setNro(numeros[i].getNro());
					num.setCodCategoriaDest(numeros[i].getCodCategoriaDest());
					listaNumerosCateg[i] = num;
				}
			}
			retornoLista.setListaNumeros(listaNumerosCateg);
			
			//Se debe ejecutar el método para obtener el cargo por uso de la orden de servicio. 
			//Si existen cargos se debe ejecutar el método para registrar los cargos ocasionales a ciclo
			String codOossExtTiempo = global.getValor("cod.ooss.extratiempo");
			String codOOSS          = codOossExtTiempo; 
			
			CRMRegistro crmRegistro = new CRMRegistro();
			String codActAbo = crmRegistro.obtenerCodActAbo(codOOSS);
			ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();
			ParametrosObtencionCargosDTO paramObtCargos = crmRegistro.obtenerParamObtCargos(abonadoContr, codOOSS, codActAbo);
			crmRegistro.imprimirParamObtCargos(paramObtCargos);
			
			logger.debug("-------------------------------------------------------------");			
			obtencionCargos=frmkCargosDelegate.obtenerCargos(paramObtCargos);
			logger.debug("-------------Retorno cargos----------------");

			crmRegistro.imprimirCargos(obtencionCargos.getCargos());

			String usuarioOra ="";
			int codVendedor=0;
			
			//obtiene usuario
			ParametroDTO parametro = new ParametroDTO();
			parametro.setNomParametro("USUARIO_IVR");
			parametro.setCodModulo("GA");
			parametro.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
			parametro = this.supOrdHanDelegate.obtenerParametroGeneral(parametro);
			usuarioOra =  parametro.getValor();
			
			logger.debug("usuarioOra="+ usuarioOra);
			//obtiene vendedor
			UsuarioDTO usuario = new UsuarioDTO();
			usuario.setNombre(usuarioOra);
			usuario = this.supOrdHanDelegate.obtenerVendedor(usuario);
			codVendedor = usuario.getCodigo();
			RetornoDTO retorno = new RetornoDTO();
			
			crmRegistro.registrarCargos(retorno, clienteContr, obtencionCargos, codVendedor);
			
			//11. registra la orden de servicio
			DatosContrModulosDTO datosContratacion = new DatosContrModulosDTO();
			datosContratacion.setNivelAplicacion("A");
			retorno = crmRegistro.registrarOrdenServicio(datosContratacion, abonadoContr, numOOSS, codOOSS, codActAbo, usuarioOra);
			
			retornoLista.setCodigo("0");
			retornoLista.setDescripcion("Exito");
			retornoLista.setResultado(true);
		}catch(GeneralException e){
			retornoLista.setCodigo(e.getCodigo());
			retornoLista.setDescripcion(e.getMessage());
			this.context.setRollbackOnly();
		}
		catch(Exception e){
			retornoLista.setCodigo("-1");
			retornoLista.setDescripcion("Ha ocurrido un error en consulta detalle producto contratado");
			this.context.setRollbackOnly();
		}
		
		logger.debug("consultaDetalleProductoContratado:end");
		return retornoLista;
		
	}
	
	
	/** 
	 * @ejb.interface-method view-type="remote"
	 */
	
	public RetornoListaNumerosDTO consultaDetalleNumeroFrecuente(DatosConsultaProductoDTO datosConsulta)	throws SOAPGeneralException,RemoteException{

		RetornoListaNumerosDTO retornoLista = new RetornoListaNumerosDTO();
		//CRMUtils crmUtils=CRMUtils.getInstance();
		logger.debug("consultaDetalleProductoContratado:start");
		
		String codMsg = "";
		String mensaje = "";
		
		try{
			if (datosConsulta.getNumCelularContr()==null || datosConsulta.getNumCelularContr().trim().equals("")){
				codMsg="1";
				mensaje = "Número de celular de abonado contratante debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}else
			if (datosConsulta.getCodProducto()==null || datosConsulta.getCodProducto().trim().equals("")){
				codMsg="2";
				mensaje = "Código del producto debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}/*else
			if (datosConsulta.getCodCanal()==null || datosConsulta.getCodCanal().trim().equals("")){
				codMsg="3";
				mensaje = "Canal debe contener un valor";
				throw new GeneralException(codMsg,0, mensaje);
			}*/

			if ( !codMsg.equals("")){
				throw new GeneralException(codMsg,0, mensaje);
			}
			
			//Se debe obtener el código de cliente y número de abonado del número celular a consultar
			AbonadoDTO abonadoContr = new AbonadoDTO();
			ClienteDTO clienteContr = new ClienteDTO();
			abonadoContr.setNumCelular(Long.parseLong(datosConsulta.getNumCelularContr()));
			abonadoContr = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoContr);
				
			clienteContr.setCodCliente(abonadoContr.getCodCliente()); 
			clienteContr=manConFacadeDelegate.obtenerDatosCliente(clienteContr);	
			
			SecuenciaDTO secuencia = new SecuenciaDTO();
			secuencia.setNomSecuencia("CI_SEQ_NUMOS");
			secuencia = supOrdHanDelegate.obtenerSecuencia(secuencia);

			long numOOSS =  secuencia.getNumSecuencia();

			
			/**
			 * @description valida que el abonado posea el producto contratado 
			 */
			OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
			ClienteDTO clienteDTO = new ClienteDTO();
			clienteDTO.setCodCliente(abonadoContr.getCodCliente());
			clienteDTO.setAbonados(creaAbonadoList("A",abonadoContr));
			ordenServicio.setCliente(clienteDTO);
			ordenServicio.setTipoComportamiento("PFRC");
			
			logger.debug("CRMWS getCodCliente "+clienteDTO.getCodCliente());
			logger.debug("CRMWS getNumAbonado "+clienteDTO.getAbonados().getAbonados()[0].getNumAbonado());
			logger.debug("CRMWS getTComportto "+ordenServicio.getTipoComportamiento());
			
			ProductoContratadoListDTO productoContratadoListDTO = issCusOrdDelegate.obtenerProductoContratado(ordenServicio);
			
			boolean isExistProdContratados=productoContratadoListDTO!=null&&productoContratadoListDTO.getProductosContratadosDTO()!=null&&
					productoContratadoListDTO.getProductosContratadosDTO().length>0?true:false;
			boolean isProdContratado=false;		
			String codProd="";
			String codProdCont="";
			String codProdOfer="";
			if (isExistProdContratados)
			{
				for (int k=0;k<productoContratadoListDTO.getProductosContratadosDTO().length;k++)
				{
					codProd=productoContratadoListDTO.getProductosContratadosDTO()[k].getIdProdContratado().toString();
					
					if (codProd.equals(datosConsulta.getCodProducto()))
					{
						codProdCont=productoContratadoListDTO.getProductosContratadosDTO()[k].getIdProdContratado().toString();
						codProdOfer=productoContratadoListDTO.getProductosContratadosDTO()[k].getIdProductoOfertado().toString();
						isProdContratado=true;
						break;
					}
				}
			}
			
			
			if (isProdContratado)
			{
				NumeroCategDTO[] listaNumerosCateg =  new NumeroCategDTO[0];
				Date hoy = new Date();
				ArrayList listaNum= new ArrayList();
				ProductoContratadoDTO productoContratado = new ProductoContratadoDTO();
				productoContratado.setIdProdContratado(new Long(codProdCont));
				productoContratado.setIdProductoOfertado(new Long(codProdOfer));
				NumeroListDTO listaNumeros = manCusInvDelegate.obtenerListaNumeros(productoContratado);
				
					if (listaNumeros!=null){
						
						/**
						 * @author rlozano
						 * @description se filtra los numeros frecuentes por fecha de vigencia
						 * @date 05-05-2010
						 */
						for (int num=0;num<listaNumeros.getNumerosDTO().length;num++)
						{
							if (listaNumeros.getNumerosDTO()[num].getFecTerminoVigencia().after(hoy))
							{
								listaNum.add(listaNumeros.getNumerosDTO()[num]);
							}
						}
						
						NumeroDTO[] numeros= (NumeroDTO[])listaNum.toArray(new NumeroDTO[listaNum.size()]);//listaNumeros.getNumerosDTO();
						int total = numeros.length;
						
						logger.debug("totalNumeros="+ total);
						listaNumerosCateg = new NumeroCategDTO[total];
						for(int i=0; i<total; i++){
							NumeroCategDTO num = new NumeroCategDTO();
							num.setIdProductoContratado(numeros[i].getIdProductoContratado());
							num.setNro(numeros[i].getNro());
							num.setCodCategoriaDest(numeros[i].getCodCategoriaDest());
							listaNumerosCateg[i] = num;
						}
					}
					retornoLista.setListaNumeros(listaNumerosCateg);
					
					//Se debe ejecutar el método para obtener el cargo por uso de la orden de servicio. 
					//Si existen cargos se debe ejecutar el método para registrar los cargos ocasionales a ciclo
					String codOossExtTiempo = global.getValor("cod.ooss.extratiempo");
					String codOOSS          = codOossExtTiempo; 
					
					CRMRegistro crmRegistro = new CRMRegistro();
					String codActAbo = crmRegistro.obtenerCodActAbo(codOOSS);
					ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();
					/*//ParametrosObtencionCargosDTO paramObtCargos = crmRegistro.obtenerParamObtCargos(abonadoContr, codOOSS, codActAbo);
					crmRegistro.imprimirParamObtCargos(paramObtCargos);
					
					logger.debug("-------------------------------------------------------------");			
					obtencionCargos=frmkCargosDelegate.obtenerCargos(paramObtCargos);
					logger.debug("-------------Retorno cargos----------------");
		
					crmRegistro.imprimirCargos(obtencionCargos.getCargos());*/
		
					String usuarioOra ="";
					int codVendedor=0;
					
					//obtiene usuario
					ParametroDTO parametro = new ParametroDTO();
					parametro.setNomParametro("USUARIO_IVR");
					parametro.setCodModulo("GA");
					parametro.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
					parametro = this.supOrdHanDelegate.obtenerParametroGeneral(parametro);
					usuarioOra =  parametro.getValor();
					
					logger.debug("usuarioOra="+ usuarioOra);
					//obtiene vendedor
					UsuarioDTO usuario = new UsuarioDTO();
					usuario.setNombre(usuarioOra);
					usuario = this.supOrdHanDelegate.obtenerVendedor(usuario);
					codVendedor = usuario.getCodigo();
					RetornoDTO retorno = new RetornoDTO();
					
					//crmRegistro.registrarCargos(retorno, clienteContr, obtencionCargos, codVendedor);
					
					//11. registra la orden de servicio
					DatosContrModulosDTO datosContratacion = new DatosContrModulosDTO();
					datosContratacion.setNivelAplicacion("A");
					//retorno = crmRegistro.registrarOrdenServicio(datosContratacion, abonadoContr, numOOSS, codOOSS, codActAbo, usuarioOra);
			}
			retornoLista.setCodigo("0");
			retornoLista.setDescripcion("Exito");
			retornoLista.setResultado(true);
		}catch(GeneralException e){
			retornoLista.setCodigo(e.getCodigo());
			retornoLista.setDescripcion(e.getMessage());
			this.context.setRollbackOnly();
		}
		catch(Exception e){
			retornoLista.setCodigo("-1");
			retornoLista.setDescripcion("Ha ocurrido un error en consulta detalle producto contratado");
			this.context.setRollbackOnly();
		}
		
		logger.debug("consultaDetalleProductoContratado:end");
		return retornoLista;
		
	}
		
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
	public RespProductoContratadoSimpleDTO obtenerPlanesAdicionalesContratados(DatosObtProductosContratadosDTO datosObtProdContratadosDTO ) throws GeneralException, RemoteException{		
		logger.debug("obtenerPlanesAdicionalesContratados():start");
		//CRMUtils crmUtils=CRMUtils.getInstance();
		/* ProductoContratadoDTO[] --> ProductoContratadoSimpleDTO[]
		numeroCelular-->buscar abonado
		nivel de aplicacion A ó C (abo o clien)
		tipo de comportamiento "" devuelve todos | pmod--pmod  
		*/
		OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
		ProductoContratadoDTO[] prodContratadoArr = null;
		ProductoContratadoSimpleDTO[] prodContratadoSimpleDTOArr = null; 
		ProductoContratadoListDTO productoContratadoListDTO = null;
		
		RespProductoContratadoSimpleDTO respProdContSimpleDTO = new RespProductoContratadoSimpleDTO();
		
		String codMsg = "";
		String mensaje = "";
		
		boolean hayError=false;
		String codError="";
		String descError="";
		String numEvento="";
		
		try{
			
			validarParametrosEntrada(codMsg, mensaje, datosObtProdContratadosDTO);
			
			/*búsqueda del abonado por número de celular*/
			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNumCelular(Long.parseLong(datosObtProdContratadosDTO.getNumCelular()));
			AbonadoDTO abonadoResp = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonado);
			
			//validarAbonadoCelular(codMsg, mensaje, abonadoResp);
			
			/* crea cliente para setear os de llamada para obtener productos contratados*/
			ClienteDTO clienteDTO = new ClienteDTO();
			clienteDTO.setCodCliente(abonadoResp.getCodCliente());
		
			//clienteDTO=manConFacadeDelegate.obtenerDatosCliente(clienteDTO);
			clienteDTO.setAbonados(creaAbonadoList(datosObtProdContratadosDTO.getNivelAplicacion(),abonadoResp));
			
			ordenServicio.setCliente(clienteDTO);
			ordenServicio.setTipoComportamiento(datosObtProdContratadosDTO.getTipoComportamiento());
			
			logger.debug("CRMWS getCodCliente "+clienteDTO.getCodCliente());
			logger.debug("CRMWS getNumAbonado "+clienteDTO.getAbonados().getAbonados()[0].getNumAbonado());
			logger.debug("CRMWS getTComportto "+ordenServicio.getTipoComportamiento());
			
			productoContratadoListDTO = issCusOrdDelegate.obtenerProductoContratado(ordenServicio);
			prodContratadoArr = productoContratadoListDTO.getProductosContratadosDTO();
			imprimeProductosCont(prodContratadoArr);

			prodContratadoSimpleDTOArr = obtieneSalidaProdCont(prodContratadoArr);
			respProdContSimpleDTO.setProductoContratadoSimpleDTO(prodContratadoSimpleDTOArr);
			
			//int i = 4/0;
			//el registro de cargos y os se realiza al consultar modulos que es quien llama a obtenerPlanesAdicionalesContratados
			//registrarCargosYOrdenServicio(datosObtProdContratadosDTO, abonadoResp, clienteDTO);
			respProdContSimpleDTO.setCodigo("0");
			respProdContSimpleDTO.setDescripcion("Exito");
			respProdContSimpleDTO.setResultado(true);
		}
		catch(GeneralException e){
			hayError=true;
			codError=e.getCodigo();
			descError=e.getDescripcionEvento();
			numEvento=""+e.getCodigoEvento();
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			//throw crmUtils.errorSoap(e).obtenerGeneralSoapException();
		}
		catch(Exception e){
			hayError=true;
		
			codError="-1";
			descError=e.getMessage();
			numEvento="-1";
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			/*respProdContSimpleDTO.setCodigo("-1");
			respProdContSimpleDTO.setDescripcion("Ha ocurrido un error en al obtener Planes Adicionales Contratados");
			logger.debug("Exception");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");*/
			//e.getMessage(),-1,e.getCause().toString()
			/*GeneralException ge = new GeneralException();//crmUtils.errorSoap(e).obtenerGeneralSoapException(); 
			ge.setCodigo("-1");
			ge.setMessage(e.toString());//e.getMessage());
			throw ge;*/
		}
		finally{
			if (hayError){
				respProdContSimpleDTO.setCodigo(numEvento);
				respProdContSimpleDTO.setDescripcion(descError);
				respProdContSimpleDTO.setResultado(false);
				/*logger.debug("GeneralException");
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + loge + "]");*/
			}
		}
		logger.debug("obtenerPlanesAdicionalesContratados():end");
		return respProdContSimpleDTO;//prodContratadoSimpleDTOArr;
	}

	private RetornoDTO registrarCargosYOrdenServicio(DatosObtProductosContratadosDTO datosObtProdContratadosDTO, AbonadoDTO abonadoResp, ClienteDTO clienteDTO) {
		logger.debug("registrarCargosYOrdenServicio():start");
		//10. obtiene y registra cargos
		CRMRegistro crmRegistro =CRMRegistro.getInstance();
		RetornoDTO retorno = new RetornoDTO();//null;
		boolean hayError=false;
		String codError="";
		String descError="";
		String numEvento="";
		try {
			logger.debug("obtenerNumOs():antes");
			long numOOSS = crmRegistro.obtenerNumOs();
			logger.debug("obtenerNumOs():despues");
			//TODO se crearan nuevas OS y se debe modificar para esta OS en particular su codOOSS
			String codOossExtTiempo = global.getValor("cod.ooss.extratiempo");
			String codOOSS          = codOossExtTiempo;
			String codActAbo        = crmRegistro.obtenerCodActAbo(codOOSS);
			ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();
			ParametrosObtencionCargosDTO paramObtCargos = crmRegistro.obtenerParamObtCargos(abonadoResp, codOOSS, codActAbo);
			crmRegistro.imprimirParamObtCargos(paramObtCargos);
			
			logger.debug("-------------------------------------------------------------");			
			obtencionCargos=frmkCargosDelegate.obtenerCargos(paramObtCargos);
			logger.debug("-------------Retorno cargos----------------");

			crmRegistro.imprimirCargos(obtencionCargos.getCargos());

			String usuarioOra = crmRegistro.obtenerUsuarioOra();
			int codVendedor   = crmRegistro.obtenerCodVendedor(usuarioOra);
			logger.debug("usuarioOra="+ usuarioOra);

			crmRegistro.registrarCargos(retorno, clienteDTO, obtencionCargos, codVendedor);
			
			//11. registra la orden de servicio
			DatosContrModulosDTO datosContratacion = new DatosContrModulosDTO();
			datosContratacion.setNivelAplicacion(datosObtProdContratadosDTO.getNivelAplicacion());
			retorno = crmRegistro.registrarOrdenServicio(datosContratacion, abonadoResp, numOOSS, codOOSS, codActAbo, usuarioOra);

			retorno.setCodigo("0");
			retorno.setDescripcion("Exito");
			retorno.setResultado(true);
		} catch (GeneralException e) {
			hayError = true;
			codError=e.getCodigo();
			descError=e.getDescripcionEvento();
			numEvento=""+e.getCodigoEvento();
			if(descError == null || "".equals(descError) ) descError = e.getMessage()+" registrarCargosYOrdenServicio "+e.getClass();
			if("0".equals(numEvento)) numEvento="-1";
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
		}
		finally{
			if (hayError){
				retorno.setCodigo(numEvento);
				retorno.setDescripcion(descError);
				retorno.setResultado(false);
			}
		}
		logger.debug("registrarCargosYOrdenServicio():end");
		return retorno;
	}
	
	
	private void validarAbonadoCelular(String codMsg, String mensaje, AbonadoDTO abonadoResp) throws ManProOffInvException {
		if ((abonadoResp.getCodSituacion().equals("BAP"))||(abonadoResp.getCodSituacion().equals("BAA")))
		{
			ManConException abonadoRespBAA= new ManConException();
			abonadoRespBAA.setMessage("El abonado se encuentra en estado de baja..");
			abonadoRespBAA.setCodigo("situacion del abonado no valida");
			abonadoRespBAA.setCodigoEvento(2);				
			logger.debug("Exception[", abonadoRespBAA);
			throw new ManProOffInvException(abonadoRespBAA);				
		}
		
	}

	private void validarParametrosEntrada(String codMsg, String mensaje, DatosObtProductosContratadosDTO datosObtProdContratadosDTO) throws GeneralException {
		if (datosObtProdContratadosDTO.getNumCelular()==null || datosObtProdContratadosDTO.getNumCelular().trim().equals("")){
			codMsg="1";
			mensaje = "Número de celular de abonado contratante debe contener un valor";
			throw new GeneralException(codMsg,0, mensaje);
		}else
		if (datosObtProdContratadosDTO.getNivelAplicacion()==null || datosObtProdContratadosDTO.getNivelAplicacion().equals("")){
			codMsg="2";
			mensaje = "El nivel de aplicación debe contener valor A para abonado o C para cliente";
			throw new GeneralException(codMsg,0, mensaje);
		}/*else  devuelve todos (pmod etc)
		if (datosObtProdContratadosDTO.getTipoComportamiento()==null || datosObtProdContratadosDTO.getTipoComportamiento().trim().equals("")){
			codMsg="3";
			mensaje = "El tipo de comportamiento debe contener un valor";
			throw new GeneralException(codMsg,0, mensaje);
		}*/
		
	}

	private AbonadoListDTO creaAbonadoList(String nivelAplicacion, AbonadoDTO abonadoResp) {
		logger.debug("creaAbonadoList():start");
		long abonado = Long.parseLong("0");
		AbonadoDTO abonado1 = new AbonadoDTO();
		if("A".equals(nivelAplicacion))
		{
			abonado = abonadoResp.getNumAbonado();
		}	
		abonado1.setNumAbonado(abonado);
		AbonadoDTO [] abonadoContratante = new AbonadoDTO [1];
		abonadoContratante[0] = abonado1;
		AbonadoListDTO abonadoListDTO = new AbonadoListDTO();
		abonadoListDTO.setAbonados(abonadoContratante);
		logger.debug("creaAbonadoList():end");
		return abonadoListDTO;
	}
	
	private ProductoContratadoSimpleDTO[] obtieneSalidaProdCont(ProductoContratadoDTO[] productoContratado) {
		
		ProductoContratadoSimpleDTO[] productoContratadoSimple = new ProductoContratadoSimpleDTO[productoContratado.length];
		for(int i=0;i<productoContratado.length;i++)
		{
			productoContratadoSimple[i] = new ProductoContratadoSimpleDTO();
		
			productoContratadoSimple[i].setNumAbonado(""+productoContratado[i].getNumAbonadoContratante());
			//productoContratadoSimple[i].setNumTerminal(productoContratado[i]);
			//productoContratadoSimple[i].setUsuario(productoContratado[i].get);
			productoContratadoSimple[i].setCodigo(""+productoContratado[i].getIdProdContratado());
			productoContratadoSimple[i].setDescripcion(productoContratado[i].getProdOfertado().getDesProdOfertado());
			productoContratadoSimple[i].setFechaDesde(productoContratado[i].getFechaInicioVigencia().toString());
			productoContratadoSimple[i].setFechaHasta(productoContratado[i].getFechaTerminoVigencia().toString());
			/* detalle numeros*/
			productoContratadoSimple[i].setNumeroSimpleDTOArr(obtieneArrNumero(productoContratado[i].getListaNumero()));
		}
		return productoContratadoSimple;
	}
	
	private NumeroSimpleDTO[] obtieneArrNumero(NumeroListDTO listaNumero) {
		NumeroSimpleDTO[] numerosArr = new NumeroSimpleDTO[listaNumero.getNumerosDTO().length];
		for(int i=0;i<listaNumero.getNumerosDTO().length;i++)
		{
			numerosArr[i] = new NumeroSimpleDTO();
			numerosArr[i].setIdProductoContratado(listaNumero.getNumerosDTO()[i].getIdProductoContratado());
			numerosArr[i].setNro(listaNumero.getNumerosDTO()[i].getNro());
			numerosArr[i].setCodCategoriaDest(listaNumero.getNumerosDTO()[i].getCodCategoriaDest());
			numerosArr[i].setDesCategoria(listaNumero.getNumerosDTO()[i].getDesCategoria());
			numerosArr[i].setFecInicioVigencia(listaNumero.getNumerosDTO()[i].getFecInicioVigencia().toString());
			numerosArr[i].setFecTerminoVigencia(listaNumero.getNumerosDTO()[i].getFecTerminoVigencia().toString());
			numerosArr[i].setNumProceso(listaNumero.getNumerosDTO()[i].getNumProceso());
		}
		return numerosArr;
	}

	private void imprimeProductosCont(ProductoContratadoDTO[] retorno) {
		ProductoContratadoDTO pcont = null;
		for(int i=0;i<retorno.length;i++)
		{
			pcont = retorno[i];
			logger.debug("CRMWS IdProdContratado   "+pcont.getIdProdContratado());
			logger.debug("CRMWS DesProdOfertado()  "+pcont.getProdOfertado().getDesProdOfertado());
			logger.debug("CRMWS TipoComportamiento "+pcont.getTipoComportamiento());
			logger.debug("------------------------------------------------------------");
			
		}
	}
	
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
	public RespProductoContratadoSimpleDTO consultarModulosContratados(DatosObtProductosContratadosDTO datosObtProdContratadosDTO ) throws SOAPGeneralException, RemoteException{		
		logger.debug("consultarModulosContratados():start");
		
		logger.debug("CRMUtils.getInstance():antes");
		//CRMUtils crmUtils=CRMUtils.getInstance();
		logger.debug("CRMUtils.getInstance():despues");
		/*tipo de comportamiento PMOD-->devuelve todos los productos PMOD  */

		//ProductoContratadoSimpleDTO[] prodContratadoSimpleDTOArr = null; 
		RespProductoContratadoSimpleDTO respProdContSimpleDTO = new RespProductoContratadoSimpleDTO();
		try{
			datosObtProdContratadosDTO.setTipoComportamiento("PMOD");
	
			//TODO registro-----os cargos
			logger.debug("obtenerPlanesAdicionalesContratados():antes");
			respProdContSimpleDTO = this.obtenerPlanesAdicionalesContratados(datosObtProdContratadosDTO);
			logger.debug("obtenerPlanesAdicionalesContratados():despues");
			if(!(respProdContSimpleDTO.isResultado()))
			{
				GeneralException ge = new GeneralException();
				ge.setCodigo(respProdContSimpleDTO.getCodigo());
				ge.setMessage(respProdContSimpleDTO.getDescripcion());
				throw ge;
			}
			/* Registrar cargos y os para consulta de módulos contratados*/
			RetornoDTO retorno = new RetornoDTO();

			/*búsqueda del abonado por número de celular*/
			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNumCelular(Long.parseLong(datosObtProdContratadosDTO.getNumCelular()));
			logger.debug("obtenerDatosAbonadoByNumCelular():antes");
			AbonadoDTO abonadoResp = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonado);
			logger.debug("obtenerDatosAbonadoByNumCelular():despues");
			
			/* la validación de entrada la realizó obtenerPlanesAdicionalesContratados */

			/* crea cliente*/
			ClienteDTO clienteDTO = new ClienteDTO();
			clienteDTO.setCodCliente(abonadoResp.getCodCliente());
			logger.debug("creaAbonadoList():antes");
			clienteDTO.setAbonados(creaAbonadoList(datosObtProdContratadosDTO.getNivelAplicacion(),abonadoResp));
			logger.debug("creaAbonadoList():despues");
			
			logger.debug("registrarCargosYOrdenServicio():antes");
			retorno = registrarCargosYOrdenServicio(datosObtProdContratadosDTO, abonadoResp, clienteDTO);
			logger.debug("registrarCargosYOrdenServicio():despues");
			if(!retorno.isResultado())
			{
				//respProdContSimpleDTO.setCodigo("-1");
				GeneralException ge = new GeneralException();
				ge.setCodigo(retorno.getCodigo());//respProdContSimpleDTO.getCodigo());
				ge.setMessage("Ha ocurrido un error en la consulta de módulos Contratados:"+retorno.getDescripcion());
				throw ge;
			}
			respProdContSimpleDTO.setCodigo("0");
			respProdContSimpleDTO.setDescripcion("Exito");
			respProdContSimpleDTO.setResultado(true);
			logger.debug("CRMWS consultarModulosContratados fin");
		}catch(GeneralException e){
			respProdContSimpleDTO.setCodigo(e.getCodigo());
			respProdContSimpleDTO.setDescripcion(e.getMessage());
			respProdContSimpleDTO.setResultado(false);
			logger.debug("GeneralException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			this.context.setRollbackOnly();
		}
		catch(Exception e){
			respProdContSimpleDTO.setCodigo("-1");
			respProdContSimpleDTO.setDescripcion("Ha ocurrido un error en al consultar Módulos Contratados");
			logger.debug("Exception");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			this.context.setRollbackOnly();
		}
		logger.debug("consultarModulosContratados():end");
		return respProdContSimpleDTO;//prodContratadoSimpleDTOArr;
	}
	
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
	public RetornoDTO validarContratanteBeneficiario(ContratanteBeneficiarioDTO contratanteBeneficiarioDTO) throws SOAPGeneralException, RemoteException{		
		//CRMUtils crmUtils=CRMUtils.getInstance();
		logger.debug("validarContratanteBeneficiario:start");
		RetornoDTO retorno = null;
		
		String codMsg = "";
		String mensaje = "";
		
		try {
			validarEntradaContratanteBeneficiario(codMsg,mensaje,contratanteBeneficiarioDTO);
			retorno = supCusIntManDelegate.validarContratanteBeneficiario(contratanteBeneficiarioDTO);
		}
		catch(GeneralException e){
			throw crmUtils.errorSoap(e).obtenerGeneralSoapException();
		}
		catch(Exception e){
			throw crmUtils.errorSoap(e).obtenerGeneralSoapException();
		}
		logger.debug("validarContratanteBeneficiario:fin");
		return retorno;
	}
	
	private void validarEntradaContratanteBeneficiario(String codMsg, String mensaje, ContratanteBeneficiarioDTO contratanteBeneficiarioDTO) throws GeneralException {
		if (contratanteBeneficiarioDTO.getNumCelularContratante()==null || contratanteBeneficiarioDTO.getNumCelularContratante().trim().equals("")){
			codMsg="1";
			mensaje = "Número de celular de abonado contratante debe contener un valor";
			throw new GeneralException(codMsg,0, mensaje);
		}/*else
		if (contratanteBeneficiarioDTO.getNumCelularBeneficiario()==null || contratanteBeneficiarioDTO.getNumCelularBeneficiario().equals("")){
			codMsg="2";
			mensaje = "Número de celular de abonado beneficiario debe contener un valor";
			throw new GeneralException(codMsg,0, mensaje);
		}*/else
		if (contratanteBeneficiarioDTO.getCodProducto()==null || contratanteBeneficiarioDTO.getCodProducto().trim().equals("")){
			codMsg="3";
			mensaje = "El código de producto debe contener un valor";
			throw new GeneralException(codMsg,0, mensaje);
		}else
		if (contratanteBeneficiarioDTO.getCanProducto()==null || contratanteBeneficiarioDTO.getCanProducto().trim().equals("")){
			codMsg="4";
			mensaje = "La cantidad de producto debe contener un valor";
			throw new GeneralException(codMsg,0, mensaje);
		}else
		if (contratanteBeneficiarioDTO.getCanal()==null || contratanteBeneficiarioDTO.getCanal().trim().equals("")){
			codMsg="5";
			mensaje = "Canal debe contener un valor";
			throw new GeneralException(codMsg,0, mensaje);
		}
		
	}

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
	public DatosOutWSListaPLanesDTO obtenerPlanesAdicionales(DatosInWSListaPLanesDTO datosInWSListaPLanesDTO) throws SOAPGeneralException,RemoteException{		
		//CRMUtils crmUtils=CRMUtils.getInstance();
		DatosOutWSListaPLanesDTO retValue=new DatosOutWSListaPLanesDTO();;
		ProductoOfertadoListDTO retValueTemp=null;
		RetornoDTO retornoDTO=new RetornoDTO(); 
		try{
		/***
			 * Validación ingreso de datos,
			 */
			String codCliente=datosInWSListaPLanesDTO.getCodCliente();
			codCliente=codCliente==null||"".equalsIgnoreCase(codCliente)?"0":codCliente;
			boolean IsNumeroOk=crmUtils.isNumber(codCliente);
			String numAbonado=datosInWSListaPLanesDTO.getNumAbonado();
			numAbonado=numAbonado==null||"".equalsIgnoreCase(numAbonado)?"0":numAbonado;
			IsNumeroOk=IsNumeroOk?crmUtils.isNumber(numAbonado):IsNumeroOk;
			String codCanal=datosInWSListaPLanesDTO.getCodCanal();
			codCanal=codCanal==null||"".equalsIgnoreCase(codCanal)?"PV":codCanal;
			String numCelular=datosInWSListaPLanesDTO.getNumCelular();
			numCelular=numCelular==null||"".equalsIgnoreCase(numCelular)?"0":numCelular;
			IsNumeroOk=IsNumeroOk?crmUtils.isNumber(numCelular):IsNumeroOk;
			String numCelularBenef=datosInWSListaPLanesDTO.getNumCelularBeneficiario();
			numCelularBenef=numCelularBenef==null||"".equals(numCelularBenef)?"0":numCelularBenef;
			IsNumeroOk=IsNumeroOk?IsNumeroOk:crmUtils.isNumber(numCelularBenef);
			
			if (!IsNumeroOk){
				throw new Exception("Verifique campos numéricos");
			}
			
			
			logger.debug("ObtenerPlanesAdicionales:start");
			logger.debug("codigo Cliente[" + codCliente + "]");
			logger.debug("numero Abonado[" + numAbonado + "]");
			logger.debug("indicador Procedencia[" + codCanal + "]");
			
			
			/*********/
			AbonadoDTO abonado=new AbonadoDTO();
			if ("0".equals(numAbonado)&&!"0".equals(numCelular)){
				abonado.setNumCelular(Long.parseLong(numCelular));
				abonado=manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonado);
				numAbonado=String.valueOf(abonado.getNumAbonado());
			}	
			
			if ("0".equals(codCliente)){
				codCliente=String.valueOf(abonado.getCodCliente());
			}
			
			abonado.setNumAbonado(Long.parseLong(numAbonado));
			abonado.setCodCliente(Long.parseLong(codCliente));
			
			
			
			AbonadoListDTO abonados=null;
			ClienteDTO cliente=new ClienteDTO();
			cliente.setCodCliente(Long.parseLong(codCliente));
			PlanTarifarioDTO planTarifario= new PlanTarifarioDTO();
			CatalogoDTO catalogo=new CatalogoDTO();
			
			
			
			
			if (!"0".equals(numAbonado)){
				abonado= manConFacadeDelegate.obtenerDatosAbonado(abonado);
				catalogo.setIndNivelAplica("A");
			}
			else{
				abonados= manConFacadeDelegate.obtenerListaAbonados(cliente);
				if (abonados.getAbonados()==null||abonados.getAbonados().length==0){
					throw new GeneralException("Obtencion Lista de Abonados",-200,"Cliente no posee Abonados en Alta");
				}
				abonado=abonados.getAbonados()[0];
				abonado.setNumAbonado(Long.parseLong(numAbonado));
				catalogo.setIndNivelAplica("C");
			}
			
			/**
			 * Verifica correspondencia de contratante beneficiario , tipo plataforma beneficiario
			 */
			
			
			if (!"0".equals(numCelularBenef)){
				
				AbonadoDTO abonadoBeneficiarioDTO=new AbonadoDTO();
				abonadoBeneficiarioDTO.setNumCelular(Long.parseLong(numCelularBenef));
				abonadoBeneficiarioDTO=manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoBeneficiarioDTO);
				//validaTipoUsoPlan(abonado, abonadoContratanteDTO);
				
				/***
				 * @author rlozano
				 * @description Verifica que el Contratante no esté vetado.
				 */
				
				AbonadoVetadoListDTO abonadoVetadoListDTO=new AbonadoVetadoListDTO();
				abonadoVetadoListDTO=manConFacadeDelegate.obtieneAbonadosVetados(abonado);
				boolean aplicaForVetado=abonadoVetadoListDTO==null||abonadoVetadoListDTO.getAbonadoVetadoList()==null?false:true;
				boolean isContratanteVetado=false;
				if (aplicaForVetado){
					for (int v=0 ;v<abonadoVetadoListDTO.getAbonadoVetadoList().length;v++){
						if ("S".equals(abonadoVetadoListDTO.getAbonadoVetadoList()[v].getTipo_Comportamiento())&&
								abonadoVetadoListDTO.getAbonadoVetadoList()[v].getNumAbonado()==abonado.getNumAbonado()){
									isContratanteVetado=true;
									break;
						}
					}
				}
				if (isContratanteVetado){
					throw new Exception("Contratante está Vetado");
				}
				
				
				/**
				 * @author rlozano
				 * @description verifica si Beneficiario se encuentra en la lista de Contratante. 
				 */
				
				
				AbonadoBeneficiarioListDTO abonadoBeneficiarioListDTO =new AbonadoBeneficiarioListDTO(); 
				abonadoBeneficiarioListDTO=manConFacadeDelegate.obtieneAbonadosBeneficiarios(abonado);
				boolean aplicaForBeneficiario=abonadoBeneficiarioListDTO==null||abonadoBeneficiarioListDTO.getAbonadoBeneficiarioList()==null?false:true;
				boolean isNotBeneficiario=false;
				if (aplicaForBeneficiario){
					for (int b=0 ;b<abonadoBeneficiarioListDTO.getAbonadoBeneficiarioList().length;b++){
						if (abonadoBeneficiarioListDTO.getAbonadoBeneficiarioList()[b].getNumAbonado()==abonadoBeneficiarioDTO.getNumAbonado()){
							isNotBeneficiario=true;
							break;
						}
					}
				}
				
				if (isNotBeneficiario){
					throw new Exception("El abonado no se encuentra en la lista de Beneficiarios");
				}
				
			}
			
			Calendar cal= Calendar.getInstance();			
			cal.set(3000, 11, 30);
			
			catalogo.setCodCanal(codCanal);
			catalogo.setFecInicioVigencia(new Date());
			catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
			
			abonado.setCatalogo(catalogo);
			abonado.setPlanTarifario(planTarifario);
			
			retValueTemp=manProOffInvFacadeDelegate.obtenerProductosOfertables(abonado);	//[OK]
			
			//TODO: Se aplica filtro de tipo Comportamiento :FREC;PRFC;MOD
			String tipoComportamiento=datosInWSListaPLanesDTO.getTipoComportamiento();
			tipoComportamiento=tipoComportamiento==null?"":tipoComportamiento;
			
			retValueTemp=("".equals(tipoComportamiento)||retValueTemp==null||retValueTemp.getProductoList()==null||retValueTemp.getProductoList().length==0)?
					retValueTemp:filtroListaPlanes(retValueTemp,tipoComportamiento);
			
			retValue.setProductoOfertadoListDTO(retValueTemp);
		}
		catch(GeneralException e){
			retornoDTO=crmUtils.errorRetornoDTO(e);
		}
		
		catch(Exception e){
			retornoDTO=crmUtils.errorRetornoDTO(e);
		}
		
		retValue.setCodigo(retornoDTO.getCodigo());
		retValue.setDescripcion(retornoDTO.getDescripcion());
		retValue.setResultado(retornoDTO.isResultado());
		logger.debug("ObtenerPlanesAdicionales:end");
		return retValue;
	}
/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/	
	private ProductoOfertadoListDTO filtroListaPlanes(ProductoOfertadoListDTO retorno,String tipoComportamiento){
		ProductoOfertadoListDTO retValue=new ProductoOfertadoListDTO();
		try{
			ArrayList listaProducto=new ArrayList();
			for(int p=0;p<retorno.getProductoList().length;p++){
				String tipCompEsp=retorno.getProductoList()[p].getEspecificacionProducto().getTipoComportamiento();
				if(tipoComportamiento.equals(tipCompEsp)){
					listaProducto.add(retorno.getProductoList()[p]);
				}
				tipCompEsp="";
			}
			retValue.setProductoList((ProductoOfertadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaProducto.toArray(),ProductoOfertadoDTO.class));
			//retValue=()
		}
		catch(Exception e){
			e.printStackTrace();
			retValue=retorno;
			
		}
		return retValue;
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
	public DatosOutWSObtenerModProductoDTO obtenerModificacionesProducto(ProductoContratadoDTO productoContratado)throws GeneralException{
		//CRMUtils crmUtils=CRMUtils.getInstance();
		DatosOutWSObtenerModProductoDTO retValue= new DatosOutWSObtenerModProductoDTO();
		RetornoDTO retornoDTO =new RetornoDTO();
		
		try{
			
			NumeroDTO numeroDTO= manCusInvDelegate.obtieneModificacionesProducto(productoContratado);
			
			/***
			 * @author rlozano
			 * @description Se procede como una orden de servicio , se obtinen los cargos, registro de la orden de servicio , cargos.
			 */
			
			ClienteDTO clienteDTO=new ClienteDTO();
			clienteDTO.setCodCliente(productoContratado.getIdClienteContratante().longValue());
			AbonadoListDTO abonadoListDTO=this.manConFacadeDelegate.obtenerListaAbonados(clienteDTO);
			
			AbonadoDTO abonadoContratanteDTO=new AbonadoDTO();
			abonadoContratanteDTO=abonadoListDTO.getAbonados()[0];
			
			DatosObtProductosContratadosDTO datos=new DatosObtProductosContratadosDTO();
			datos.setNivelAplicacion("A");
			this.registrarCargosYOrdenServicio(datos, abonadoContratanteDTO, clienteDTO);
			
			retValue.setNumeroDTO(numeroDTO);
		}
		catch(Exception e){
			retornoDTO=crmUtils.errorRetornoDTO(e);
		}
		retValue.setCodigo(retornoDTO.getCodigo());
		retValue.setDescripcion(retornoDTO.getDescripcion());
		retValue.setResultado(retornoDTO.getDescripcion()==null?true:false);
		return retValue;
	}
	
	private RetornoDTO aplicaPLRestricciones(RestriccionesDTO restricciones)throws GeneralException{
		RetornoDTO retornoDTO=null;
		
		
		try{
		    restricciones.setPrograma("GPA");
		    restricciones.setProceso("");
		    restricciones.setCodModGener("OSF");
		    restricciones.setCodOOSS(restricciones.getCodOOSS());
		    restricciones.setDesactivacionSS(0);
		    restricciones.setPlanDestino("");
		    restricciones.setTipoPlanDestino("");
		    restricciones.setFechaSistema(new Date());
		    restricciones.setCodTarea(0);
		    restricciones.setCodEvento(global.getValor("codigo.evento.cargar").trim());
		    
		    // Iterar por cada elemento del mapa de abonados
		    logger.debug("validaRestriccionComerOoss:inicio,abonado="+restricciones.getNumAbonado());
		    retornoDTO = detCusOrdFeaDelegate.validaRestriccionComerOoss(restricciones);
			
		}
		catch(GeneralException e){
			retornoDTO=new RetornoDTO();
			retornoDTO.setResultado(false);
			retornoDTO.setDescripcion(e.getDescripcionEvento());
		}
		catch(RemoteException e){
			retornoDTO.setResultado(false);
			retornoDTO.setDescripcion("Error al aplicar verificación de datos : Restricciones");
		}
		return retornoDTO;
	}
	
	
	/**
	 * @author rlozano
	 * @date 18-01-2010
	 * @description Se agrega código del Proyecto Activación y Desactivacion de Planes Adicionales  Mexico.
	 */
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * Permite validar al cliente contra el modelo de restricciones
	 */
	public RetornoConTokenDTO validacion(ValidacionAbonadoDTO param) {
		String codAct;
		String codEvento;
		RetornoDTO retornoDTO =new RetornoDTO();
		retornoDTO.setCodigo("0");
		//codOOS = global.getValor("cod.ooss.pa.validaUsuario").trim();
		codAct = global.getValor("cod.act.pa."+param.getCodigoOOSS().trim()).trim();
				
		codEvento = global.getValor("cod.evento.pa.validaUsuario").trim();
		
		//RetornoDTO retornoDTO = validaEnElModeloDeRestricciones(param.getAbonado(), param.getUsuarioSCL(), param.getCodigoOOSS(), codAct, codEvento, "", param.getCanal());
		
		String sNumAbonado = param.getAbonado();
		RetornoConTokenDTO retornoConTokenDTO = new RetornoConTokenDTO();
		
		if("0".equalsIgnoreCase(retornoDTO.getCodigo())){
			// Llamada al token
			String elToken = TokenSingleton.getInstance().getToken(sNumAbonado,param.getCodigoOOSS());
			retornoConTokenDTO.setResultado(true);
			retornoConTokenDTO.setCodigo("0");
			retornoConTokenDTO.setDescripcion("");
			retornoConTokenDTO.setToken(elToken);
		}else{
			retornoConTokenDTO.setCodigo(retornoDTO.getCodigo());
			retornoConTokenDTO.setDescripcion(retornoDTO.getDescripcion());
			retornoConTokenDTO.setToken("");
			retornoConTokenDTO.setResultado(false);
		}
		
		logger.debug("SALIDA metodo validacion");
		logger.debug("retornoConTokenDTO.getCodigo: " + retornoConTokenDTO.getCodigo());
		logger.debug("retornoConTokenDTO.getDescripcion: " + retornoConTokenDTO.getDescripcion());
		logger.debug("retornoConTokenDTO.getToken: " + retornoConTokenDTO.getToken());
		
		return retornoConTokenDTO;
	}
	
	private RetornoDTO validaEnElModeloDeRestricciones(String abonado, String usuarioSCL, String codOOS, String codAct, String codEvento, String codigoProducto, String canal)	{
		logger.debug("INICIO metodo validaEnElModeloDeRestricciones");

		RetornoDTO retornoDTO;
		
		String sNumAbonado = abonado;
		long lNumAbonado = Long.parseLong(sNumAbonado);
		String usuarioOra = usuarioSCL;
		
		AbonadoDTO abonadoContr = new AbonadoDTO();
		abonadoContr.setNumAbonado(lNumAbonado);
		
		try {
			abonadoContr = manConFacadeDelegate.obtenerDatosAbonado(abonadoContr);
			UsuarioDTO usuario = new UsuarioDTO();
			usuario.setNombre(usuarioOra);
		
			usuario = this.supOrdHanDelegate.obtenerVendedor(usuario);
			int codVendedor = usuario.getCodigo();

			//obtener secuencia
			SecuenciaDTO secuenciaTransacabo = new SecuenciaDTO();
			secuenciaTransacabo.setNomSecuencia("GA_SEQ_TRANSACABO");
		
			secuenciaTransacabo = supOrdHanDelegate.obtenerSecuencia(secuenciaTransacabo);
			
	
			RestriccionesDTO restriccionesDTO =new RestriccionesDTO();
			restriccionesDTO.setNumAbonado(abonadoContr.getNumAbonado());
			restriccionesDTO.setCodCliente(abonadoContr.getCodCliente());
			restriccionesDTO.setNumVenta(abonadoContr.getNumVenta());
			restriccionesDTO.setCodUso(Integer.parseInt(abonadoContr.getCodUso()));
			restriccionesDTO.setCodCuentaOrigen(abonadoContr.getCodCuenta());
			restriccionesDTO.setCodCuentaDestino(abonadoContr.getCodCuenta());
			restriccionesDTO.setTipoPlan(abonadoContr.getCodTipoPlanTarif());
			restriccionesDTO.setNumCiclo(abonadoContr.getCodCiclo());
			restriccionesDTO.setCodCentral(abonadoContr.getCodCentral());
			restriccionesDTO.setIdSecuencia(secuenciaTransacabo.getNumSecuencia());
			restriccionesDTO.setCodActuacion(codAct);
			restriccionesDTO.setCodOOSS(codOOS);
			restriccionesDTO.setCodVendedor(String.valueOf(codVendedor));
			restriccionesDTO.setPrograma("GPA");
			restriccionesDTO.setProceso("");
			restriccionesDTO.setCodModGener("OSF");
			restriccionesDTO.setDesactivacionSS(0);
			restriccionesDTO.setPlanDestino("");
			restriccionesDTO.setTipoPlanDestino("");
			restriccionesDTO.setFechaSistema(new Date());
			restriccionesDTO.setCodTarea(0);
			restriccionesDTO.setCodEvento(codEvento);//SIGUIENTE
			/**
			 * @author rlozano
			 * @description Verificar estos parametros en el PL
			 * @date 18-01-2010 
			 * */
			//restriccionesDTO.setParametrosExtras("|"+codigoProducto+"|"+usuarioSCL+"|"+canal);
		
		
			retornoDTO = detCusOrdFeaDelegate.validaRestriccionComerOoss(restriccionesDTO);
		
		
		} catch (GeneralException e) {
			logger.error("validaRestriccionComerOoss - GeneralException", e);
			e.printStackTrace();
			retornoDTO = new RetornoDTO();
			retornoDTO.setCodigo(String.valueOf(e.getCodigoEvento()));
			retornoDTO.setDescripcion(e.getDescripcionEvento());
		} catch (RemoteException e) {
			logger.error("validaRestriccionComerOoss - RemoteException", e);
			e.printStackTrace();
			retornoDTO = new RetornoDTO();
			retornoDTO.setCodigo("11");
			retornoDTO.setDescripcion(e.getMessage());
		} 
		return retornoDTO;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * Permite desactivar un plan adicional opcional
	 */
	public RetornoDTO desactivacionDePlanAdicional(ActDesPlanAdicDTO param)throws RemoteException {
		
		logger.debug("INICIO metodo desactivacionDePlanAdicional");
		logger.debug("param.getCanal: " + param.getCanal());
		logger.debug("param.getCodigoProducto: " + param.getCodigoProducto());
		logger.debug("param.getNumAbonado: " + param.getNumAbonado());
		logger.debug("param.getToken: " + param.getToken());
		logger.debug("param.getUsuarioSCL: " + param.getUsuarioSCL());
		
		
		
		String NUMABONADO = param.getNumAbonado();
		String USUARIO = param.getUsuarioSCL();
		String CODPRODUCTO = param.getCodigoProducto();
		String CANAL = param.getCanal();
		String TOKEN = param.getToken();
		long numOrdenServicio=0;
		ProcesoProductoDTO procesoProductoDTO=new ProcesoProductoDTO();
		//Llamada al token
		
		//retornoDTO.setCodigo("0"); //borrame, sirve para saltarme el token
		RetornoDTO retornoDTO = new RetornoDTO();
			
			AbonadoDTO abonado= new AbonadoDTO();
			try {
				ProductoContratadoListDTO productoContratadoListDesc;
				//AbonadoDTO abonado= new AbonadoDTO();
				abonado.setNumCelular(Long.parseLong(param.getNumAbonado()));
				logger.debug("Numero Celular Ingresado:::"+abonado.getNumCelular());
				abonado=manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonado);
				
				String codOOS = global.getValor("cod.ooss.pa.baja");
				String codAct = global.getValor("cod.act.pa."+codOOS);
				String codEvento = global.getValor("codigo.evento.cargar").trim();
				
				
				retornoDTO = validaEnElModeloDeRestricciones(""+abonado.getNumAbonado(), param.getUsuarioSCL(), codOOS, codAct, codEvento, param.getCodigoProducto(), param.getCanal());
				if(!"0".equalsIgnoreCase(retornoDTO.getCodigo())){
					return retornoDTO;
				}
				
				if("0".equalsIgnoreCase(retornoDTO.getCodigo())){		
					
					NUMABONADO=""+abonado.getNumAbonado();
					retornoDTO = TokenSingleton.getInstance().validaToken(NUMABONADO, codOOS, TOKEN);
					
					
		//			obtener datos del cliente
					ClienteDTO entCliente = new ClienteDTO();
					entCliente.setCodCliente(abonado.getCodCliente());
					ClienteDTO cliente;
				
					cliente = manConFacadeDelegate.obtenerDatosCliente(entCliente);
					
					cliente.setCodTipoTerminal(abonado.getCodTipoTerminal());
					cliente.setDesTipoTerminal(abonado.getDesTipoTerminal());
					cliente.setCodPlanTarif(abonado.getCodPlanTarif());
					cliente.setDesPlanTarif(abonado.getDesPlanTarif());
					cliente.setLimiteConsumo(abonado.getLimiteConsumo());
					cliente.setDesLimiteConsumo(abonado.getDesLimiteConsumo());
					cliente.setCodCiclo(abonado.getCodCiclo());
					cliente.setImpCargoBasico(Float.parseFloat(abonado.getImpCargoBasico()));
					
									
					AbonadoListDTO abonadoListaSH = new AbonadoListDTO();
					AbonadoDTO[] abonados=new AbonadoDTO[1];
					abonados[0]=abonado;
					abonadoListaSH.setAbonados(abonados);
					cliente.setAbonados(abonadoListaSH);
		//			Generar OrdenServicioDTO
					OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
					ordenServicio.setCliente(cliente);
					ordenServicio.setTipoComportamiento(null);
					
					ProductoContratadoListDTO productosContratados;
				
					productosContratados = issCusOrdDelegate.obtenerProductoContratado(ordenServicio);
				
					
				
					productoContratadoListDesc = obtenerDatosProductoADescontratar(CODPRODUCTO, productosContratados);
				
					SecuenciaDTO secuencia = new SecuenciaDTO();
					secuencia.setNomSecuencia("CI_SEQ_NUMOS");
				
					secuencia = supOrdHanDelegate.obtenerSecuencia(secuencia);
					numOrdenServicio = secuencia.getNumSecuencia();
					
					procesoProductoDTO.setCodCliente(cliente.getCodCliente());
					procesoProductoDTO.setNumAbonado(abonado.getNumAbonado());
					//procesoProductoDTO.setIdProceso(String.valueOf(secuencia.getNumSecuencia()));
					procesoProductoDTO.setCodOs(codOOS);
					procesoProductoDTO.setObjectoDesSerializado(null);
					procesoProductoDTO.setNumProceso(String.valueOf(numOrdenServicio));
					procesoProductoDTO.setOrigenProceso(param.getCanal());
					
					ParametroSerializableDTO proceso = new ParametroSerializableDTO();
					proceso.setEstadoProceso("INSCRITO");
					proceso.setNumProceso(String.valueOf(numOrdenServicio));
					proceso.setOrigenProceso(param.getCanal());
			//		obtener id para el nuevo proceso
					
					proceso = supOrdHanDelegate.nuevoProceso(proceso);
					procesoProductoDTO.setIdProceso(proceso.getIdProceso());
				
					
					productoContratadoListDesc.setNumEvento(proceso.getIdProceso());
					Date sysdate=new Date();
					boolean isDescontrando=productoContratadoListDesc!=null&&productoContratadoListDesc.getProductosContratadosDTO()!=null&&productoContratadoListDesc.getProductosContratadosDTO().length>0?true:false;
					if (isDescontrando){
						for (int k=0;k<productoContratadoListDesc.getProductosContratadosDTO().length;k++){
							productoContratadoListDesc.getProductosContratadosDTO()[k].setFechaProcesoDescontrata(sysdate);
						    productoContratadoListDesc.getProductosContratadosDTO()[k].setFechaTerminoVigencia(sysdate);
						       
						    productoContratadoListDesc.getProductosContratadosDTO()[k].setOrigenProcesoDescontrata(CANAL);
						    productoContratadoListDesc.getProductosContratadosDTO()[k].setNumProcesoDescontrata(Long.toString(secuencia.getNumSecuencia()));
						    productoContratadoListDesc.getProductosContratadosDTO()[k].setNombreUsuario(USUARIO);//301208
						   // productoContratadoListDesc.setNumEvento(""+secuencia);
						}
					}
					//registrar orden de servicio
					retornoDTO = registrarOrdenServicio(cliente, "B", USUARIO, numOrdenServicio);
					if(!retornoDTO.isResultado()){
						procesoProductoDTO.setEstadoProceso("ERROR");
						actualizaProceso(procesoProductoDTO);
						return retornoDTO;
					}
				} else {
					//no se valido token
					return retornoDTO;
				}
	//			Invocar servicio de descontratación de producto
			
				retornoDTO = issCusOrdORCDelegate.descontratarOfertaComercial(productoContratadoListDesc);
			} catch (GeneralException e) {
				logger.error("descontratarOfertaComercial - IssCusOrdException", e);
				e.printStackTrace();
				retornoDTO.setCodigo(e.getCodigo());
				retornoDTO.setDescripcion(e.getDescripcionEvento());
				retornoDTO.setResultado(false);
				
				procesoProductoDTO.setEstadoProceso("ERROR");
				actualizaProceso(procesoProductoDTO);
				return retornoDTO;
			} catch (RemoteException e) {
				logger.error("descontratarOfertaComercial - RemoteException", e);
				e.printStackTrace();
				retornoDTO.setCodigo("-14");
				retornoDTO.setDescripcion(e.getMessage());
				retornoDTO.setResultado(false);
				procesoProductoDTO.setEstadoProceso("ERROR");
				actualizaProceso(procesoProductoDTO);
				return retornoDTO;
			}
			procesoProductoDTO.setEstadoProceso("PROCESADO");
			actualizaProceso(procesoProductoDTO);
			
		
		logger.debug("SALIDA metodo desactivacionDePlanAdicional");
		logger.debug("retornoDTO.getCodigo: " + retornoDTO.getCodigo());
		logger.debug("retornoDTO.getDescripcion: " + retornoDTO.getDescripcion());
		
		retornoDTO.setResultado(true);
		retornoDTO.setCodigo("0");
		retornoDTO.setDescripcion("");
		
		return retornoDTO;
	}
	
	
	
	public CargoListDTO obtenerCargosProductos(ProductoOfertadoListDTO prodOfeProdList) throws SupBillAndColException, RemoteException {
		CargoListDTO resultado = null;                 
		logger.debug("obtenerCargosProductos():start");
		resultado = supBillAndColDelegate.obtenerCargosProductos(prodOfeProdList);
		logger.debug("obtenerCargosProductos():end");
		return resultado;
	}

	
	
		/**
		 * 
		 * filtra los productos contratados dejando el más antiguo de la lista
		 * 
		 * @param codProducto
		 * @param productosContratados
		 * @return
		 * @throws CodigoProductoNoContratadoException
		 */
		private ProductoContratadoListDTO obtenerDatosProductoADescontratar(String codProducto, ProductoContratadoListDTO productosContratados) throws GeneralException{
			boolean exito = false;
			ProductoContratadoDTO[] arregloProductoContratadoDTO = productosContratados.getProductosContratadosDTO();
			ProductoContratadoDTO[] resp = new ProductoContratadoDTO[1];
			resp[0] = null;
			for (int i=0; i<arregloProductoContratadoDTO.length; i++){
				if(arregloProductoContratadoDTO[i].getIdProdContratado().toString().equalsIgnoreCase(codProducto)){
					
					//dejo el de fecha de inicio vigencia mas antiguo
					if((resp[0]==null || resp[0].getFechaInicioVigencia().after(arregloProductoContratadoDTO[i].getFechaInicioVigencia()) ) &&
						(arregloProductoContratadoDTO[i].getIdEstado() != null && !"ELIMINADO".equals(arregloProductoContratadoDTO[i].getIdEstado().trim()))){
						resp[0] = arregloProductoContratadoDTO[i];
					}
					productosContratados.setProductosContratadosDTO(resp);
					exito = true;
				}
			}
			if(exito==false){
				throw new GeneralException(codProducto);
			}
			
			return productosContratados;
		}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * Permite activar un plan adicional opcional
	 */
	public RetornoDTO activacionDePlanAdicional(ActDesPlanAdicDTO param) {
		logger.debug("INICIO metodo activacionDePlanAdicional");
		logger.debug("param.getCanal: " + param.getCanal());
		logger.debug("param.getCodigoProducto: " + param.getCodigoProducto());
		logger.debug("param.getNumAbonado: " + param.getNumAbonado());
		//logger.debug("param.getToken: " + param.getToken());
		logger.debug("param.getUsuarioSCL: " + param.getUsuarioSCL());
		
		
				
				
				//		obtengo numero para la orden de servicio
				SecuenciaDTO secuencia = new SecuenciaDTO();
		
				secuencia.setNomSecuencia("CI_SEQ_NUMOS");
				ProcesoProductoDTO procesoProductoDTO = new ProcesoProductoDTO();
				RetornoDTO retorno = null;
		
				try {
		
					secuencia = supOrdHanDelegate.obtenerSecuencia(secuencia);
					long numeroOrdenServicio = secuencia.getNumSecuencia();
		
			//		------------ LOGICA LOGINACTION
			
			//		obtener datos del vendedor basado en el usuario ingresado por parametro
					UsuarioDTO usuario = new UsuarioDTO();
			
					usuario.setNombre(param.getUsuarioSCL());
			
					UsuarioDTO usuarioVend = null;
		
					usuarioVend = this.supOrdHanDelegate.obtenerVendedor(usuario);
		
			//		Obtener datos del abonado
					/*AbonadoDTO entAbonado = new AbonadoDTO();
					entAbonado.setNumAbonado(Long.parseLong(param.getNumAbonado()));
					AbonadoDTO abonado = null;
					abonado = manConFacadeDelegate.obtenerDatosAbonado(entAbonado);*/
					
					
					AbonadoDTO abonado= new AbonadoDTO();
					abonado.setNumCelular(Long.parseLong(param.getNumAbonado()));
					logger.debug("Numero Celular Ingresado:::"+abonado.getNumCelular());
					abonado=manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonado);
					
					//Inicio - Inc 176719 - 01/11/2011 - FADL
					AbonadoDTO entAbonado = new AbonadoDTO();
					entAbonado.setNumAbonado(abonado.getNumAbonado());
					AbonadoDTO abonadoAux = null;
					abonadoAux = manConFacadeDelegate.obtenerDatosAbonado(entAbonado);
					logger.debug("abonadoAux.getCodCentral() -> "+abonadoAux.getCodCentral());
					
					abonado.setCodCentral(abonadoAux.getCodCentral());
					//Fin - Inc 176719 - 01/11/2011 - FADL
					
					
					String codOOS = global.getValor("cod.ooss.pa.alta").trim();
					String codAct = global.getValor("cod.act.pa."+codOOS).trim();
					String codEvento = global.getValor("codigo.evento.cargar").trim();
					RetornoDTO retornoDTO;
					retornoDTO = validaEnElModeloDeRestricciones(""+abonado.getNumAbonado(), param.getUsuarioSCL(), codOOS, codAct, codEvento, param.getCodigoProducto(), param.getCanal());
					if(!"0".equalsIgnoreCase(retornoDTO.getCodigo())){
						return retornoDTO;
					}
					
			//		Llamada al token
					retornoDTO = TokenSingleton.getInstance().validaToken(param.getNumAbonado(), codOOS, param.getToken());
					if(!"0".equalsIgnoreCase(retornoDTO.getCodigo())){
						
						return retornoDTO;
					}
		
			//		se setea el numero de orden de servicio
					abonado.setNumeroOS(numeroOrdenServicio);
			
			//		Al abonado se setea el CatalogoDTO y en el PlanTarifarioDTO se setea un 13 como
			//		CodProdPadre en PaqueteDefault ¿será necesario?
			//		esta logica del catalogo está definida en el action ContDesPlanAdicionalAction
					CatalogoDTO catalogo = new CatalogoDTO();
			
					Calendar cal= Calendar.getInstance();
					cal.set(3000,11,31);
					catalogo.setCodCanal(param.getCanal());
					catalogo.setFecInicioVigencia(new Date());
					catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
					catalogo.setIndNivelAplica("A");//A de abonado
					catalogo.setCodVendedor(String.valueOf(usuarioVend.getCodigo()));
					catalogo.setCodProdOfertado(param.getCodigoProducto());
					abonado.setCatalogo(catalogo);
			
			//		abonado.setPlanTarifario(new PlanTarifarioDTO());
			//
			//		abonado.getPlanTarifario().setPaqueteDefault(new PaqueteDTO());
			//
			//		abonado.getPlanTarifario().getPaqueteDefault().setCodProdPadre("13");
			
			
			//		obtener datos del cliente
					ClienteDTO entCliente = new ClienteDTO();
			
					entCliente.setCodCliente(abonado.getCodCliente());
			
					ClienteDTO cliente = null;
				
					
					cliente = manConFacadeDelegate.obtenerDatosCliente(entCliente);
					cliente.setCodTipoTerminal(abonado.getCodTipoTerminal());
					cliente.setDesTipoTerminal(abonado.getDesTipoTerminal());
					cliente.setCodPlanTarif(abonado.getCodPlanTarif());
					cliente.setDesPlanTarif(abonado.getDesPlanTarif());
					cliente.setLimiteConsumo(abonado.getLimiteConsumo());
					cliente.setDesLimiteConsumo(abonado.getDesLimiteConsumo());
					cliente.setCodCiclo(abonado.getCodCiclo());
					cliente.setImpCargoBasico(Float.parseFloat(abonado.getImpCargoBasico()));
		//		---------- FIN LOGICA LOGINACTION
		
		//		---------- LOGICA ContDesPlanAdicionalAction
					AbonadoListDTO abonadoListaSH = new AbonadoListDTO();
			
					AbonadoDTO[] abonados=new AbonadoDTO[1];
			
					abonados[0]=abonado;
			
					abonadoListaSH.setAbonados(abonados);
			
					cliente.setAbonados(abonadoListaSH);
					
					
					
					
					procesoProductoDTO.setCodCliente(cliente.getCodCliente());
					procesoProductoDTO.setNumAbonado(abonado.getNumAbonado());
					//procesoProductoDTO.setIdProceso(String.valueOf(secuencia.getNumSecuencia()));
					procesoProductoDTO.setCodOs(codOOS);
					procesoProductoDTO.setObjectoDesSerializado(null);
					procesoProductoDTO.setNumProceso(String.valueOf(secuencia.getNumSecuencia()));
					procesoProductoDTO.setOrigenProceso(param.getCanal());
					
			//		obtener ProductoOfertadoListDTO con el producto a contratar
					ProductoOfertadoListDTO prodOfertadoList = new ProductoOfertadoListDTO();
					ProductoOfertadoDTO[] listaProd= new ProductoOfertadoDTO[1];
					ProductoOfertadoDTO producto= new ProductoOfertadoDTO();
					producto.setIdProductoOfertado(param.getCodigoProducto());
					listaProd[0]=producto;
		
					prodOfertadoList.setProductoList(listaProd);
		
				
					//prodOfertadoList = manProOffInvFacadeDelegate.obtenerDetalleProductos(prodOfertadoList);
					abonado.setPlanTarifario(new PlanTarifarioDTO());
					
					abonado.setCatalogo(catalogo);		
					abonado.setPlanTarifario(new PlanTarifarioDTO());
					abonado.getPlanTarifario().setPaqueteDefault(new PaqueteDTO());
					abonado.getPlanTarifario().getPaqueteDefault().setCodProdPadre(abonado.getCodProdPadre());
					
					prodOfertadoList = manProOffInvFacadeDelegate.obtenerProductosOfertables(abonado);
					
					if (prodOfertadoList.getProductoList()!=null)
					{
						ArrayList listaProdOfer=new ArrayList();
						String idProdOfer="";
						for (int j=0;j<prodOfertadoList.getProductoList().length;j++)
						{
							idProdOfer=prodOfertadoList.getProductoList()[j].getIdProductoOfertado();
							
							if (idProdOfer.equals(param.getCodigoProducto()))
							{
								prodOfertadoList.getProductoList()[j].setCodCliente(abonado.getCodCliente());
								listaProdOfer.add(prodOfertadoList.getProductoList()[j]);
								break;
							}
							
						}
						ProductoOfertadoDTO[] productosOfertadosDTO=(ProductoOfertadoDTO[])listaProdOfer.toArray(new ProductoOfertadoDTO[listaProdOfer.size()]);
						prodOfertadoList.setProductoList(productosOfertadosDTO);
						
					}
					
					if (prodOfertadoList.getProductoList()!=null&&prodOfertadoList.getProductoList().length>0)
					{
						    String idServicioBase=prodOfertadoList.getProductoList()[0].getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0].getIdServicioBase();
							prodOfertadoList.getProductoList()[0].getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0].setIdServicioBase(idServicioBase);
							prodOfertadoList = manProOffInvFacadeDelegate.obtenerLCplanAdicional(prodOfertadoList);
							boolean isAplicaLC=prodOfertadoList.getProductoList()!=null&&
							prodOfertadoList.getProductoList().length>0&&
							prodOfertadoList.getProductoList()[0].getListaLimCons()!=null&&
							prodOfertadoList.getProductoList()[0].getListaLimCons().getLimitesDeConsumo()!=null&&
							prodOfertadoList.getProductoList()[0].getListaLimCons().getLimitesDeConsumo().length>0?true:false;
							
							if (isAplicaLC)
							{
								prodOfertadoList.getProductoList()[0].getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0].setIdServicioBase(idServicioBase);
								String codLimConsumo;
								String codLimConsumoWS=param.getCodLimConsumo();
								codLimConsumoWS=codLimConsumoWS==null?"":codLimConsumoWS;
								float mntoLimConsMax;
								float mntoLimConsMin;
								boolean isExistCodLC=false;
								
								for (int k=0;k<prodOfertadoList.getProductoList()[0].getListaLimCons().getLimitesDeConsumo().length;k++){
									
										if ("".equals(codLimConsumoWS)){
											/*if ("S".equals(prodOfertadoList.getProductoList()[0].getListaLimCons().getLimitesDeConsumo()[k].getIndDefault()))
											{
												isExistCodLC=true;
												prodOfertadoList.getProductoList()[0].setLimiteConsumoSeleccionado(prodOfertadoList.getProductoList()[0].getListaLimCons().getLimitesDeConsumo()[k].getCodLimCons());
												prodOfertadoList.getProductoList()[0].setMtoConsumoConfigurado(prodOfertadoList.getProductoList()[0].getListaLimCons().getLimitesDeConsumo()[k].getMtoConsumoConfigurado());
												break;
											}*/
											isExistCodLC=true;
										}
										else
										{
										
											codLimConsumo=prodOfertadoList.getProductoList()[0].getListaLimCons().getLimitesDeConsumo()[k].getCodLimCons();
											
											if (codLimConsumo.equals(codLimConsumoWS))
												{
													mntoLimConsMax=prodOfertadoList.getProductoList()[0].getListaLimCons().getLimitesDeConsumo()[k].getMtoMaximo().floatValue();
													mntoLimConsMin=prodOfertadoList.getProductoList()[0].getListaLimCons().getLimitesDeConsumo()[k].getMtoMinimo().floatValue();
													isExistCodLC=true;
													if (mntoLimConsMin<=param.getMntoLimConsumo()&&param.getMntoLimConsumo()<=mntoLimConsMax)
													{
														prodOfertadoList.getProductoList()[0].getListaLimCons().getLimitesDeConsumo()[k].setMtoConsumoConfigurado(Float.valueOf(String.valueOf(param.getMntoLimConsumo())));
														prodOfertadoList.getProductoList()[0].setLimiteConsumoSeleccionado(codLimConsumo);
														prodOfertadoList.getProductoList()[0].setMtoConsumoConfigurado(Float.valueOf(String.valueOf(param.getMntoLimConsumo())));
														break;
													}
													else
													{
														retornoDTO.setCodigo("-1100");
														retornoDTO.setDescripcion("Límite de Consumo Ingresado se encuentra fuera de rango de contratacion");
														retornoDTO.setResultado(false);
														return retornoDTO;
													}
												}
										}
								}
								
								if (!isExistCodLC)
								{
									retornoDTO.setCodigo("-1101");
									retornoDTO.setDescripcion("Código de Limite Consumo no se enuentra asociado al PA");
									retornoDTO.setResultado(false);
									return retornoDTO;
									
								}
								
								
							}
							
					
					//		---------- FIN LOGICA ContDesPlanAdicionalAction
					
					//		---------- INICIO LOGICA PRODUCTOACTION
					
					//		Recorrer la lista de productos ofertables y obtener el producto que su codigo de producto corresponda
					//		al ingresado por parametro.
					
							ProductoOfertadoDTO[] productoOfertados = prodOfertadoList.getProductoList();
					
							//TODO aqui falta validación para el caso en que el arreglo sea nulo o de tamaño cero
							
					//		al producto ofertado seleccionado se setea IndCondicionContratacion = "O"
							productoOfertados[0].setIndCondicionContratacion("O");
					
					//		y el producto ofertado se setea en ProductoOfertadoListDTO
							prodOfertadoList.setProductoList(productoOfertados);
					
					
					//		---------- FIN LOGICA PRODUCTOACTION
							
					//		---------- Inicio obtencion de cargos
						
				
							/*CargoListDTO cargoListDTO;
							cargoListDTO = supBillAndColDelegate.obtenerCargosProductos(prodOfertadoList);
							productoOfertados[0].setCargoList(cargoListDTO);*/
						
					//		---------- Fin obtencion de cargos
					
					//		---------- INICIO LOGICA FLUJOCONTDESCPLANESAACTION
					
							cliente.getAbonados().getAbonados()[0].setProdOfertList(prodOfertadoList);
					
							cliente.getAbonados().getAbonados()[0].setPaqueteList(new PaqueteListDTO());
							cliente.getAbonados().getAbonados()[0].getPaqueteList().setPaqueteList(new PaqueteDTO[0]);
					//		---------- FIN LOGICA FLUJOCONTDESCPLANESAACTION
					
					//		el metodo obtieneVentaDto del FlujoContDescPlanesAAction no realiza operacion sobre el abonadoDTO y el clienteDTO
							VentaDTO venta = new VentaDTO();
							venta.setIdVenta(String.valueOf(numeroOrdenServicio));
							venta.setCliente(cliente);
							venta.setCodCanal(param.getCanal());
							venta.setOrigenProceso(param.getCanal());
							ParametroSerializableDTO proceso = new ParametroSerializableDTO();
							proceso.setEstadoProceso("INSCRITO");
							proceso.setNumProceso(String.valueOf(numeroOrdenServicio));
							proceso.setOrigenProceso(param.getCanal());
							
					//		obtener id para el nuevo proceso
							
							proceso = supOrdHanDelegate.nuevoProceso(proceso);
							procesoProductoDTO.setIdProceso(proceso.getIdProceso());
					//		completar datos de la venta
							venta.setNumEvento(proceso.getIdProceso());
							venta.setNomUsuaOra(param.getUsuarioSCL());
					//		obtener oferta comercial a partir de la venta
							NegSalUtils negSalUtils=NegSalUtils.getInstance();
							OfertaComercialDTO ofertaComercial = null;
							ofertaComercial = negSalUtils.generarOfertaComercial(venta);
				
							//		completar la oferta comercial con los datos de la venta
							ofertaComercial.setNumEvento(venta.getNumEvento());
					
							ofertaComercial.setOrigenProceso(venta.getOrigenProceso());
					
							
							
							//registrar la orden de servicio para la alta
							
							retorno = registrarOrdenServicio(cliente, "A", param.getUsuarioSCL(), numeroOrdenServicio);
							
							if(!retorno.isResultado()){
								procesoProductoDTO.setEstadoProceso("ERROR");
								retorno=actualizaProceso(procesoProductoDTO);
								return retorno;
							}
				
							retorno = issCusOrdORCDelegate.activarProductoContratado(ofertaComercial);
						
							//actualiza proceso
							procesoProductoDTO.setEstadoProceso("PROCESADO");
							retorno = actualizaProceso(procesoProductoDTO);
					}
					else
					{
						if (retorno==null)
						{
							retorno = new RetornoDTO();
						}
						retorno.setCodigo("-1101");
						retorno.setDescripcion("Abonado no tiene configurado el  producto ["+param.getCodigoProducto()+"], como ofertable");
						retorno.setResultado(true);
						
						
					}
					// fin actualiza proceso
			
					//retorno.setCodigo("0");
					//retorno.setDescripcion("");
					//retorno.setResultado(true);
								
			
			
			logger.debug("SALIDA metodo activacionDePlanAdicional");
			logger.debug("retorno.getCodigo: " + retorno.getCodigo());
			logger.debug("retorno.getDescripcion: " + retorno.getDescripcion());
			logger.debug("retorno.isResultado: " + retorno.isResultado());
		} catch (GeneralException e) {

			
			e.printStackTrace();
			retorno = new RetornoDTO();
			retorno.setCodigo("");
			retorno.setDescripcion(e.getDescripcionEvento());
			retorno.setResultado(false);
			
		} 
		catch (RemoteException e) {

			
			e.printStackTrace();
			retorno = new RetornoDTO();
			retorno.setCodigo("");
			retorno.setDescripcion("Error RemoteException");
			retorno.setResultado(false);
			
		} 
			return retorno;
	}
	
	private RetornoDTO actualizaProceso(ProcesoProductoDTO procesoProductoDTO)throws RemoteException {
		RetornoDTO retornoDTO = new RetornoDTO();
		
		try {

			retornoDTO = supOrdHanDelegate.actualizaProceso(procesoProductoDTO);
			
			retornoDTO.setCodigo("0");
			retornoDTO.setDescripcion("");
			retornoDTO.setResultado(true);
			if(!"0".equalsIgnoreCase(retornoDTO.getCodigo())){
				retornoDTO.setResultado(false);
		//		return retornoDTO;
			}
			
		} catch (GeneralException e) {

			logger.error("obtenerSecuencia - SupOrdHanException", e);
			e.printStackTrace();
			retornoDTO = new RetornoDTO();
			retornoDTO.setCodigo("");
			retornoDTO.setDescripcion(e.getDescripcionEvento());
			retornoDTO.setResultado(false);
			
		} 
		
		return retornoDTO;
	}
	
	/**
	 * permite registrar la orden de servicio según sea la operación, de alta o baja 
	 * @param clienteDTO
	 * @param operacion
	 * @param username
	 * @param numeroOrdenServicio
	 * @return
	 * @throws GetFacadeException 
	 * @throws RemoteException 
	 * @throws CloCusOrdException 
	 * @throws Exception 
	 */
	private RetornoDTO registrarOrdenServicio(ClienteDTO clienteDTO, String operacion, String username, long seqNumeroOrdenServicio)throws RemoteException {
		
		//registrar nivel de orden de servicio
		
		RegistroNivelOOSSDTO registroNivel = new RegistroNivelOOSSDTO();
		
		registroNivel.setNumAbonado(clienteDTO.getAbonados().getAbonados()[0].getNumAbonado());
		registroNivel.setCodCliente(clienteDTO.getCodCliente());

		long codOrdenServicio = 0;
		String comentarioRegistroOOSS = null;
		String codigoActuacion = null;
		
		//dependiendo de si es baja o alta se obtiene el numero de orden de servicio
		if("A".equals(operacion.toUpperCase())){
			
			codOrdenServicio = new Long(global.getValor("cod.ooss.pa.alta")).longValue();
			comentarioRegistroOOSS = global.getValor("comentario.ooss.pa.alta");
			codigoActuacion = global.getValor("cod.act.pa." + codOrdenServicio);
			
		}else if("B".equals(operacion.toUpperCase())){

			codOrdenServicio = new Long(global.getValor("cod.ooss.pa.baja")).longValue();
			comentarioRegistroOOSS = global.getValor("comentario.ooss.pa.baja");
			codigoActuacion = global.getValor("cod.act.pa." + codOrdenServicio);
		}

		registroNivel.setCodTipMod(codigoActuacion);
		registroNivel.setTipSujeto("A"); //A por abonado
		registroNivel.setNomUsuaOra(username); //nombre de usuario pasado por parametro

		RetornoDTO retorno = null;
		
		try {
		
			retorno = cloCusOrdDelegate.registraNivelOoss(registroNivel);
		
			//Registrar orden de servicio en linea
			RegistrarOossEnLineaDTO registroLinea = new RegistrarOossEnLineaDTO();
			registroLinea.setCodOS(String.valueOf(codOrdenServicio));
	
			registroLinea.setNumOs(seqNumeroOrdenServicio);
			registroLinea.setCodProducto(CODPRODUCTO);
			registroLinea.setTipInter(1); //TODO en validación por el usuario
			registroLinea.setCodInter(clienteDTO.getAbonados().getAbonados()[0].getNumAbonado());
			registroLinea.setUsuario(username);
	
			Date fecha = new Date();
			Timestamp fechaActual = new Timestamp(fecha.getTime());
	
			registroLinea.setFecha(fechaActual);
	
			registroLinea.setComentario(comentarioRegistroOOSS);
			
			retorno = cloCusOrdDelegate.registrarOOSSEnLinea(registroLinea);
		
		} catch (GeneralException e) {
			
			logger.error("registrarOOSSEnLinea - CloCusOrdException", e);
			e.printStackTrace();
			retorno = new RetornoDTO();
			retorno.setCodigo("");
			retorno.setDescripcion(e.getDescripcionEvento());
			retorno.setResultado(false);
			
			return retorno;
			
		} 
		retorno.setResultado(true);
		return retorno;
	}
	
	
	/**
	 * @ejb.interface-method view-type="remote"
	 * 
	 * @param inNumerosFrecuentesDTO
	 * @return
	 * @throws GeneralException
	 */
	
	public RetornoDTO AgregarEliminarNumerosFrecuentes(InNumerosFrecuentesDTO inNumerosFrecuentesDTO) throws GeneralException, RemoteException
	{
		logger.debug("inicio : AgregarEliminarNumerosFrecuentes");
		RetornoDTO retValue=null;
		String estadoProceso=null;
		ProcesoProductoDTO procesoProductoDTO = new ProcesoProductoDTO();
		ArrayList listaErrores = new ArrayList();
		ArrayList tiposMaximosNumFrec= new ArrayList();
		ArrayList numFrecContratdosxTipo= new ArrayList();
		try
		{
			
			/**
			 * @author rlozano
			 * @description Se ejecutan validaciones de negocio en base a los datos suministrados en la DTO de Auditoria
			 * @date 24-02-2010
			 */
			RespuestaDTO respuestaDTO=supOrdHanDelegate.validacionesFuncionalesAuditoria(inNumerosFrecuentesDTO.getAuditoriaDTO());
			boolean valFuncOK= respuestaDTO!=null&&respuestaDTO.getCodigoError()==0?true:false;
			
			if (valFuncOK)
			{
				/**
				 * @description se obtiene los datos del abonado a través del número celular
				 */
				AbonadoDTO abonadoDTO = new AbonadoDTO();
				abonadoDTO.setNumCelular(Long.parseLong(inNumerosFrecuentesDTO.getNumCelular()));
				abonadoDTO=manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoDTO);
				
				
				/**
				 * @description Se obtienen los datos del vendedor a través del usuario
				 */
	//			obtiene vendedor
				
				UsuarioDTO usuario = new UsuarioDTO();
				usuario.setNombre(inNumerosFrecuentesDTO.getNomUsuario());
				usuario = this.supOrdHanDelegate.obtenerVendedor(usuario);
				int codVendedor = usuario.getCodigo();
				
				
				
				/**
				 * @description Se aplica restricciones.
				 */
				
				RestriccionesDTO restriccionesDTO =new RestriccionesDTO();
				restriccionesDTO.setNumAbonado(abonadoDTO.getNumAbonado());
				restriccionesDTO.setCodCliente(abonadoDTO.getCodCliente());
				restriccionesDTO.setNumVenta(abonadoDTO.getNumVenta());
				restriccionesDTO.setCodUso(Integer.parseInt(abonadoDTO.getCodUso()));
				restriccionesDTO.setCodCuentaOrigen(abonadoDTO.getCodCuenta());
				restriccionesDTO.setCodCuentaDestino(abonadoDTO.getCodCuenta());
				restriccionesDTO.setTipoPlan(abonadoDTO.getCodTipoPlanTarif());
				restriccionesDTO.setNumCiclo(abonadoDTO.getCodCiclo());
				restriccionesDTO.setCodCentral(abonadoDTO.getCodCentral());
				
				
				//obtener secuencia
				SecuenciaDTO secuenciaTransacabo = new SecuenciaDTO();
				secuenciaTransacabo.setNomSecuencia("GA_SEQ_TRANSACABO");
				secuenciaTransacabo = supOrdHanDelegate.obtenerSecuencia(secuenciaTransacabo);
				
	//			TODO : Solo como referencia;
				restriccionesDTO.setIdSecuencia(secuenciaTransacabo.getNumSecuencia());
				
				
				String codOOS="41003";
				
				restriccionesDTO.setCodActuacion(global.getValor("cod.act.ooss."+codOOS));
				restriccionesDTO.setCodOOSS(codOOS);
				restriccionesDTO.setCodVendedor(String.valueOf(codVendedor));
				
				retValue = this.aplicaPLRestricciones(restriccionesDTO);
				
				
				if ("OK".equals(retValue.getDescripcion()))
				{
					/**
					 * @description Verificacion de validaciones Funcionales acorde a : Agregar - Eliminar Números Frecuentes.
					 */
					
	//				TODO Catalogar el numero ingresado / onnet , redfija , internacional
					//obtenerTipoNumero (SE_CATEGORIA_)
					
					ArrayList numerosDTO= new ArrayList();
					if ("A".equals(inNumerosFrecuentesDTO.getTipoAccion()))
					{
						NumeroDTO numeroDTO= null; 
						
						
						for(int j=0;j<inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO().length;++j)
						{
							numeroDTO= new NumeroDTO();
							numeroDTO=supCusIntManDelegate.obtenerTipoNumero(inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[j]);
							if (numeroDTO.getDesCategoria()==null){
								listaErrores.add("El número ["+numeroDTO.getNro()+"] es inválido");
								break;
							}
							
							numerosDTO.add(numeroDTO);
						}
						
						inNumerosFrecuentesDTO.getNumeroListDTO().setNumerosDTO((NumeroDTO[] )numerosDTO.toArray(new NumeroDTO[numerosDTO.size()]));
					}
					
					if (listaErrores.size()==0)
						{
							//TODO: Número de modificaciones del producto contratado
							
							ProductoContratadoDTO productoContratadoDTO= new ProductoContratadoDTO();
							productoContratadoDTO.setIdProdContratado(new Long(inNumerosFrecuentesDTO.getIdProductoContratado()));
							productoContratadoDTO.setIdClienteContratante(new Long(abonadoDTO.getCodCliente()));
							productoContratadoDTO.setNumAbonadoContratante(new Long(abonadoDTO.getNumAbonado()));
							NumeroDTO numeroDTO= manCusInvDelegate.obtieneModificacionesProducto(productoContratadoDTO);
							
							
							//TODO : Obtener el detalle de los productos contratados
							ProductoContratadoListDTO productoContratadoListDTO = new ProductoContratadoListDTO();
							
							//Como se espera que el proceso de agregar/elminar un número frecuente es a un producto específico se define lo siguiente.
							ProductoContratadoDTO[] productoContratadoArrayDTO = new ProductoContratadoDTO[1];
							productoContratadoArrayDTO[0]=productoContratadoDTO;
							
							productoContratadoListDTO.setProductosContratadosDTO(productoContratadoArrayDTO);
							productoContratadoListDTO=manCusInvDelegate.obtenerDetalleProductoContratado(productoContratadoListDTO);
							
							/**
							 * @description obtenemos los maximos numeros a contratar por tipo (categoria destino).
							 */
							
							ReglasListaNumerosListDTO reglasListaNumerosListDTO =productoContratadoListDTO.getProductosContratadosDTO()[0].getProdOfertado().getListaReglasNumeros();
							
							
							/**
							 * @description obtenemos la lista de numeros frecuentes agregados por tipo
							 */
							ProductoContratadoDTO productoContratado = new ProductoContratadoDTO();
							productoContratado.setIdProdContratado(new Long(inNumerosFrecuentesDTO.getIdProductoContratado()));
							
							/**
							 * @description Obtengo los maximos agregados por cada tipo
							 */
							
							NumeroListDTO listaNumeros = manCusInvDelegate.obtenerListaNumeros(productoContratado);
							/*HashMap hashMapTiposCantidadObtenida= new HashMap();
							*/
							if ("A".equals(inNumerosFrecuentesDTO.getTipoAccion()))
							{
								String inNumeroFrec;
								String bdNumeroFrec;
								for (int j=0;j<inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO().length;j++)
								{
									inNumeroFrec=inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[j].getNro();
									for (int k=0;k<listaNumeros.getNumerosDTO().length;k++)
									{
										bdNumeroFrec=listaNumeros.getNumerosDTO()[k].getNro();
										if (inNumeroFrec.equals(bdNumeroFrec)){
											listaErrores.add("El Número ["+inNumeroFrec+"], está registrado como frecuente");
										}
									}
								}
							
							
									logger.debug("Fin ::::: conteo de cantidades por tipo actualmente agregados");
									
									
									/**
									 * @description Obtengo los maximos permitidos por cada tipo
									 */
									logger.debug("INICIO ::::: Comparacion de máximos permitidos por cada tipo (PA) con la lista reflejada en BD ");
									HashMap hashMapTiposCantidadMaxMenosCantidadConsumida= new HashMap();
									
									if (listaErrores.size()==0)
									{
											String claveTipoPA= null;
											int valorMax;
											String valmaxString;
											for (int j=0;j<reglasListaNumerosListDTO.getReglaLisNumList().length;j++)
											{
												claveTipoPA=reglasListaNumerosListDTO.getReglaLisNumList()[j].getCodCategoriaDestino();
												valmaxString=reglasListaNumerosListDTO.getReglaLisNumList()[j].getCantidadMaxima();
												valorMax=Integer.parseInt(valmaxString!=null&&!"".equals(valmaxString)?valmaxString:"0");
												if (!hashMapTiposCantidadMaxMenosCantidadConsumida.containsKey(claveTipoPA)){
													hashMapTiposCantidadMaxMenosCantidadConsumida.put(claveTipoPA, ""+valorMax);
													
												}
												else
												{
													listaErrores.add("Revisar configuracion de plan adicional para el tipo ["+claveTipoPA+"]");
													break;
												}
												logger.debug("claveTipoPA :::"+claveTipoPA);
												logger.debug("valorMax :::"+valorMax);
												valorMax=0;
											}
											
											
											/**
											 * @description  
											 */
											
											String codCatDes=null;
											
											int valor;
											
											for (int j=0;j<listaNumeros.getNumerosDTO().length;j++)
											{
												codCatDes=listaNumeros.getNumerosDTO()[j].getCodCategoriaDest();
												valor=0;
												if (!hashMapTiposCantidadMaxMenosCantidadConsumida.containsKey(codCatDes))
												{
													hashMapTiposCantidadMaxMenosCantidadConsumida.put(codCatDes,""+valor++);
												}
												else
												{
													valor =Integer.parseInt((String)hashMapTiposCantidadMaxMenosCantidadConsumida.get(codCatDes))-1;
													hashMapTiposCantidadMaxMenosCantidadConsumida.put(codCatDes, ""+valor);
												}
											}
											
											logger.debug("FIN ::::: Comparacion de máximos permitidos por cada tipo (PA) con la lista reflejada en BD ");
											
											
											/**
											 * @description recorro la lista de numeros frecuentes ingresados y comparo con la lista que contiene de 
											 * las contrataciones restantes.  
											 */
											
											
											logger.debug("INICIO : compara si corresponde agregar numero frecuente");
											boolean isHayNum=inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()!=null&&
											inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO().length>0?true:false; 	
											
											if (isHayNum)
											{
												int valorACont=0;
												for(int k=0;k<inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO().length;k++)
												{
													if (hashMapTiposCantidadMaxMenosCantidadConsumida.containsKey(inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[k].getCodCategoriaDest()))
													{
														valorACont=Integer.parseInt((String)hashMapTiposCantidadMaxMenosCantidadConsumida.get(inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[k].getCodCategoriaDest()));
														
														if (valorACont<=0)
														{
															listaErrores.add("El número ingresado["+inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[k].getNro()+"] de tipo ["+inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[k].getCodCategoriaDest()+"]," +
																	"no puede ser agregado por haber copado el Máximo de agregaciones");
														}
													}
													else{
														listaErrores.add("El número ingresado["+inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[k].getNro()+"] de tipo ["+inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[k].getCodCategoriaDest()+"]," +
																"no puede ser agregado por no estar considerado en la lista de contratacion del PA["+inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[k].getIdProductoContratado()+"]");
														
													}
													if (listaErrores.size()>0)
													{
														break;
													}
												}
											}
									}
							}
							
							String maxModificaciones=productoContratadoListDTO.getProductosContratadosDTO()[0].getProdOfertado().getMaxModificaciones();
							maxModificaciones=maxModificaciones==null||"".equals(maxModificaciones)?"0":maxModificaciones;
							
							/**
							 * @description  verificamos el número de modificaciones restantes
							 */
							
							int modifRestantes=Integer.parseInt(maxModificaciones)-1;
							
							logger.debug("modifRestantes -> "+modifRestantes);
							
							if (modifRestantes<=0){
								listaErrores.add("Ha superado el máximo de modificaciones");
							}
						
							if (listaErrores.size()==0)
							{		
									
									/**
									 * @description Se inscribe el proceso en el esquema de producto
									 */
									
									SecuenciaDTO secuencia = new SecuenciaDTO();
									secuencia.setNomSecuencia("CI_SEQ_NUMOS");
									secuencia = supOrdHanDelegate.obtenerSecuencia(secuencia);
									
									ParametroSerializableDTO proceso = new ParametroSerializableDTO();
									estadoProceso="INSCRITO";
									proceso.setEstadoProceso(estadoProceso);
									proceso.setNumProceso(""+secuencia.getNumSecuencia());
									proceso.setOrigenProceso("WS");
							//		obtener id para el nuevo proceso
									
									proceso = supOrdHanDelegate.nuevoProceso(proceso);
									
									
									procesoProductoDTO.setObjetoSerializado(proceso.getObjetoSerializado());
									procesoProductoDTO.setCodCliente(abonadoDTO.getCodCliente());
									procesoProductoDTO.setNumAbonado(abonadoDTO.getNumAbonado());
									procesoProductoDTO.setCodOs(codOOS);
									procesoProductoDTO.setNumProceso(String.valueOf(secuencia.getNumSecuencia()));
									procesoProductoDTO.setIdProceso(proceso.getIdProceso());
									procesoProductoDTO.setOrigenProceso(proceso.getOrigenProceso());
									
									
									
									/**
									 * @author rlozano
									 * @description se complementa la informacion a registrar en para Agregar Eliminar Numeros Frecuentes
									 */
									Date hoy= new Date();
									for (int i=0 ; i<inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO().length;i++)
									{
										inNumerosFrecuentesDTO.getNumeroListDTO().setCodCliente(String.valueOf(abonadoDTO.getCodCliente()));
										inNumerosFrecuentesDTO.getNumeroListDTO().setNumAbonado(String.valueOf(abonadoDTO.getNumAbonado()));
										inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[i].setIdCliente(String.valueOf(abonadoDTO.getCodCliente()));
										inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[i].setIdAbonado(String.valueOf(abonadoDTO.getNumAbonado()));
										inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[i].setNumProceso(String.valueOf(secuencia.getNumSecuencia()));
										inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[i].setNumProcesoDescontrata(String.valueOf(secuencia.getNumSecuencia()));
										inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[i].setOrigenProceso(proceso.getOrigenProceso());
										inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[i].setOrigenProcDescontrata(proceso.getOrigenProceso());
										if ("E".equals(inNumerosFrecuentesDTO.getTipoAccion()))
											{
												java.sql.Timestamp ts =java.sql.Timestamp.valueOf(listaNumeros.getNumerosDTO()[i].getFecInicioVigencia());


												inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[i].setFecTerminoVigencia(hoy);
												inNumerosFrecuentesDTO.getNumeroListDTO().getNumerosDTO()[i].setFecInicioVigencia(ts);
												
											}
									}
									
									
									if ("A".equals(inNumerosFrecuentesDTO.getTipoAccion())){
										retValue=manCusInvDelegate.crearListaNumeros(inNumerosFrecuentesDTO.getNumeroListDTO());
									}
									else if ("E".equals(inNumerosFrecuentesDTO.getTipoAccion()))
									{
										retValue=manCusInvDelegate.eliminarListaNumeros(inNumerosFrecuentesDTO.getNumeroListDTO());
									}
									procesoProductoDTO.setEstadoProceso("PROCESADO");
									//actualizaProceso(procesoProductoDTO);
									
									/**
									 * @author rlozano
									 * @description insercion en las tablas de auditoria
									 * @date 24-02-2010
									 */
									
									AuditoriaResponseDTO auditoriaResponseDTO = supOrdHanDelegate.insertAuditoria(inNumerosFrecuentesDTO.getAuditoriaDTO());
									
									//Inicio Inc. 176841 - 02/11/2011 - FADL
									retValue = new RetornoDTO();
									//Fin Inc. 176841 - 02/11/2011 - FADL
									retValue.setCodigo(String.valueOf(auditoriaResponseDTO.getRespuesta().getCodigoError()));
									retValue.setDescripcion(auditoriaResponseDTO.getRespuesta().getMensajeError());
									retValue.setResultado("0".equals(retValue.getCodigo())?true:false);
							}
						}
					
					if (listaErrores.size()>0)
					{
						retValue= new RetornoDTO();
						retValue.setCodigo("-1101");
						retValue.setDescripcion(listaErrores.toString());
						retValue.setResultado(false);
					}
				}
		   }
			else
			{
				retValue= new RetornoDTO();
				retValue.setCodigo(String.valueOf(respuestaDTO.getCodigoError()));
				retValue.setDescripcion(respuestaDTO.getMensajeError());
				retValue.setResultado(false);
			}
		}	
		catch(GeneralException e)
		{
			logger.error("Exception ");
			logger.error(e);
			retValue=this.EventosException(e,procesoProductoDTO);
		}
		catch(Exception e)
		{
			logger.error("Exception ");
			logger.error(e);
			retValue=this.EventosException(e,procesoProductoDTO);
			
		}
		logger.debug("fin : AgregarEliminarNumerosFrecuentes");
		return retValue;
	}
	
	protected RetornoDTO EventosException (Object obj,ProcesoProductoDTO procesoProductoDTO){
		
		RetornoDTO retValue= new RetornoDTO();
		try
		{
			if (obj instanceof GeneralException) {
				GeneralException generalException = (GeneralException) obj;
				
				int subNivelException=0;
				while(subNivelException<10){
					
					if (generalException.getCodigo()!=null){
						retValue.setCodigo(""+generalException.getCodigoEvento());
						retValue.setDescripcion(generalException.getDescripcionEvento());
						retValue.setResultado(false);
						break;
					}
					else{			
						if (generalException.getCause() instanceof GeneralException) {
							generalException=(GeneralException)generalException.getCause();
							retValue.setCodigo(""+generalException.getCodigoEvento());
							retValue.setDescripcion(generalException.getDescripcionEvento());
							retValue.setResultado(false);
						}
						else{
							retValue.setCodigo(""+generalException.getCodigoEvento());
							retValue.setDescripcion(""+((SQLException)generalException.getCause()));
							retValue.setResultado(false);
							break;
						}
					}
						subNivelException++;
				}
				
			}
			else{
				retValue.setCodigo("000");
				retValue.setDescripcion("Error En los componentes de obtencion de datos funcionales");
				retValue.setResultado(false);
			}
			
			if (procesoProductoDTO.getEstadoProceso()!= null)
			{
				procesoProductoDTO.setEstadoProceso("ERROR");
				actualizaProceso(procesoProductoDTO);
			}
			
			
			 
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			context.setRollbackOnly();
		}
		return retValue;
	}
	
	
	
	
	
	/**
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 */
	
	public IntegracionInClasificacionDTO consultaClasificacionCliente(InWsClasifClienteDTO inWsClasifClienteDTO )throws GeneralException, RemoteException
	{
		logger.debug("inicio : consultaClasificacionCliente");
		IntegracionInClasificacionDTO integracionInClasificacionDTO=new IntegracionInClasificacionDTO();
		try
		{
			
			/**
			 * @author rlozano
			 * @description Se ejecutan validaciones de negocio en base a los datos suministrados en la DTO de Auditoria
			 * @date 24-02-2010
			 */
			RespuestaDTO respuestaDTO=supOrdHanDelegate.validacionesFuncionalesAuditoria(inWsClasifClienteDTO.getAuditoriaDTO());
			boolean valFuncOK= respuestaDTO!=null&&respuestaDTO.getCodigoError()==0?true:false;
			
			if (valFuncOK)
			{
				/**
				 * @description se obtiene los datos del abonado a través del número celular
				 */
				AbonadoDTO abonadoDTO = new AbonadoDTO();
				abonadoDTO.setNumCelular(Long.parseLong(inWsClasifClienteDTO.getNumCelular()));
				abonadoDTO=manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoDTO);
				
				
				/**
				 * @description se invoca el servicio de clasificacion de cliente a través del codigo de cliente.
				 */
				integracionInClasificacionDTO.setCodCliente(abonadoDTO.getCodCliente());
				
				integracionInClasificacionDTO=manConFacadeDelegate.consultaClasificacionCliente(integracionInClasificacionDTO);
					
				/**
				 * @author rlozano
				 * @description insercion en las tablas de auditoria
				 * @date 14-03-2010
				 */
				
				AuditoriaResponseDTO auditoriaResponseDTO = supOrdHanDelegate.insertAuditoria(inWsClasifClienteDTO.getAuditoriaDTO());
				
				integracionInClasificacionDTO.setCodigo(String.valueOf(auditoriaResponseDTO.getRespuesta().getCodigoError()));
				integracionInClasificacionDTO.setDescripcion(auditoriaResponseDTO.getRespuesta().getMensajeError());
				integracionInClasificacionDTO.setResultado("0".equals(integracionInClasificacionDTO.getCodigo())?true:false);
				if (integracionInClasificacionDTO.isResultado())
				{
					GedCodigosDTO gedCodigosDTO=new GedCodigosDTO();
					gedCodigosDTO.setCod_modulo("GE");
					gedCodigosDTO.setNom_tabla("GE_CLIENTES");
					gedCodigosDTO.setNom_columna("COD_TIPO");
					gedCodigosDTO.setCod_valor(integracionInClasificacionDTO.getCodTipo());
					GedCodigosListDTO gedCodigosListDTO=supOrdHanDelegate.obtenerListaGedCodigos(gedCodigosDTO);
					boolean isListaLLena=gedCodigosListDTO!=null&&gedCodigosListDTO.getGedCodigosDTO()!=null
										 &&gedCodigosListDTO.getGedCodigosDTO().length>0?true:false;
										 
					if (isListaLLena)
					{
						String codTipoCliente=integracionInClasificacionDTO.getCodTipo();
						String codTipoLista=null;
						for (int j=0;j<gedCodigosListDTO.getGedCodigosDTO().length;j++)
						{
							codTipoLista=gedCodigosListDTO.getGedCodigosDTO()[j].getCod_valor();
							if (codTipoCliente.equals(codTipoLista)){
							integracionInClasificacionDTO.setDesTipo(gedCodigosListDTO.getGedCodigosDTO()[j].getDes_valor());
							break;
							}
							codTipoLista=null;
								
						}
					}
				}
				
		   }
			else
			{
				integracionInClasificacionDTO= new IntegracionInClasificacionDTO();
				integracionInClasificacionDTO.setCodigo(String.valueOf(respuestaDTO.getCodigoError()));
				integracionInClasificacionDTO.setDescripcion(respuestaDTO.getMensajeError());
				integracionInClasificacionDTO.setResultado(false);
			}
		}	
		catch(GeneralException e)
		{
			logger.error("Exception ");
			logger.error(e);
			
			integracionInClasificacionDTO.setCodigo(String.valueOf(e.getCodigoEvento()));
			integracionInClasificacionDTO.setDescripcion(e.getDescripcionEvento());
			integracionInClasificacionDTO.setResultado(false);
			
		}
		catch(Exception e)
		{
			logger.error("Exception ");
			logger.error(e);
			throw new GeneralException(e);
			
		}
		
		logger.debug("fin : consultaClasificacionCliente");
		return integracionInClasificacionDTO;
		
	}
	
	
	
	
	public OutWsDatosOutBeneficioDTO obtenerProductosOfertablesBeneficiarioIntegracion(ProdOfertablesBenefDTO prodOfertablesBenefDTO) throws  GeneralException, RemoteException
	{
		logger.debug("inicio : obtenerProductosOfertablesBeneficiarioIntegracion");
		OutWsDatosOutBeneficioDTO outWsDatosOutBeneficioDTO=new OutWsDatosOutBeneficioDTO();
		RetornoDTO retornoDTO= new RetornoDTO();
		try
		{
			
			/**
			 * @author rlozano
			 * @description Se ejecutan validaciones de negocio en base a los datos suministrados en la DTO de Auditoria
			 * @date 09-04-2010
			 */
			RespuestaDTO respuestaDTO=supOrdHanDelegate.validacionesFuncionalesAuditoria(prodOfertablesBenefDTO.getAuditoriaDTO());
			boolean valFuncOK= respuestaDTO!=null&&respuestaDTO.getCodigoError()==0?true:false;
			
			if (valFuncOK)
			{
				/**
				 * @description se obtiene los Productos Ofertables por beneficiario
				 */
				DatosInBeneficioDTO datosInBeneficio = new DatosInBeneficioDTO();
				datosInBeneficio.setCanalOrigenPro(prodOfertablesBenefDTO.getCanalOrigenPro());
				datosInBeneficio.setNumAbonadoBeneficiario(prodOfertablesBenefDTO.getNumAbonadoBeneficiario());
				datosInBeneficio.setNumAbonadoContratado(prodOfertablesBenefDTO.getNumAbonadoContratado());
				outWsDatosOutBeneficioDTO.setDatosOutBeneficioDTO(this.obtenerProductosOfertablesBeneficiario(datosInBeneficio));
				
				//ProductoOfertadoDTO[] listaProductosOfertadosDTO=obtenerProductosOfertablesBeneficiario(datosInBeneficio);
				
				/*boolean isValidLista=listaProductosOfertadosDTO!=null&&listaProductosOfertadosDTO.length>0?true:false;
				
				if (isValidLista)
				{
					for (int j=0;j<listaProductosOfertadosDTO.length;j++)
					{
						if (listaProductosOfertadosDTO[j].getListaLimCons()!=null)
						{
							System.out.println("Hay Lista ["+j+"]:::");
						}
					}
				}*/
					
				
				
				
				
				/**
				 * @author rlozano
				 * @description insercion en las tablas de auditoria
				 * @date 14-03-2010
				 */
				
				AuditoriaResponseDTO auditoriaResponseDTO = supOrdHanDelegate.insertAuditoria(prodOfertablesBenefDTO.getAuditoriaDTO());
				
				retornoDTO.setCodigo(String.valueOf(auditoriaResponseDTO.getRespuesta().getCodigoError()));
				retornoDTO.setDescripcion(auditoriaResponseDTO.getRespuesta().getMensajeError());
				retornoDTO.setResultado("0".equals(retornoDTO.getCodigo())?true:false);
				
		   }
			else
			{
				
				retornoDTO.setCodigo(String.valueOf(respuestaDTO.getCodigoError()));
				retornoDTO.setDescripcion(respuestaDTO.getMensajeError());
				retornoDTO.setResultado(false);
			}
		}	
		catch(GeneralException e)
		{
			logger.error("Exception ");
			logger.error(e);
			
			retornoDTO.setCodigo(String.valueOf(e.getCodigoEvento()));
			retornoDTO.setDescripcion(e.getDescripcionEvento());
			retornoDTO.setResultado(false);
			
		}
		catch(Exception e)
		{
			logger.error("Exception ");
			logger.error(e);
			throw new GeneralException(e);
			
		}
		outWsDatosOutBeneficioDTO.setRetornoDTO(retornoDTO);
		logger.debug("fin : obtenerProductosOfertablesBeneficiarioIntegracion");
		return outWsDatosOutBeneficioDTO;
	}
	
	
	/**
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 */
	
	public RespProductoContratadoSimpleDTO obtenerPlanesAdicionalesContratadosIntegracion(WSPlanesAdicionalesContratadosDTO wsPlanesAdicionalesContratadosDTO ) throws GeneralException, RemoteException{
	{
		logger.debug("inicio : obtenerPlanesAdicionalesContratadosIntegracion");
		RespProductoContratadoSimpleDTO respProductoContratadoSimpleDTO=new RespProductoContratadoSimpleDTO();
		//RetornoDTO retornoDTO= new RetornoDTO();
		try
		{
			
			/**
			 * @author rlozano
			 * @description Se ejecutan validaciones de negocio en base a los datos suministrados en la DTO de Auditoria
			 * @date 09-04-2010
			 */
			RespuestaDTO respuestaDTO=supOrdHanDelegate.validacionesFuncionalesAuditoria(wsPlanesAdicionalesContratadosDTO.getAuditoriaDTO());
			boolean valFuncOK= respuestaDTO!=null&&respuestaDTO.getCodigoError()==0?true:false;
			
			if (valFuncOK)
			{
				/**
				 * @description se obtiene los Productos Ofertables por beneficiario
				 */
				DatosObtProductosContratadosDTO datosObtProdContratadosDTO = new DatosObtProductosContratadosDTO();
				datosObtProdContratadosDTO.setNivelAplicacion(wsPlanesAdicionalesContratadosDTO.getNivelAplicacion());
				datosObtProdContratadosDTO.setNumCelular(wsPlanesAdicionalesContratadosDTO.getNumCelular());
				datosObtProdContratadosDTO.setTipoComportamiento(wsPlanesAdicionalesContratadosDTO.getTipoComportamiento());
				respProductoContratadoSimpleDTO=this.obtenerPlanesAdicionalesContratados(datosObtProdContratadosDTO);
				/**
				 * @author rlozano
				 * @description insercion en las tablas de auditoria
				 * @date 14-03-2010
				 */
				if (respProductoContratadoSimpleDTO.isResultado()){
					AuditoriaResponseDTO auditoriaResponseDTO = supOrdHanDelegate.insertAuditoria(wsPlanesAdicionalesContratadosDTO.getAuditoriaDTO());
					
					respProductoContratadoSimpleDTO.setCodigo(String.valueOf(auditoriaResponseDTO.getRespuesta().getCodigoError()));
					respProductoContratadoSimpleDTO.setDescripcion(auditoriaResponseDTO.getRespuesta().getMensajeError());
					respProductoContratadoSimpleDTO.setResultado("0".equals(respProductoContratadoSimpleDTO.getCodigo())?true:false);
				}
				
		   }
		   else
			{
				
				respProductoContratadoSimpleDTO.setCodigo(String.valueOf(respuestaDTO.getCodigoError()));
				respProductoContratadoSimpleDTO.setDescripcion(respuestaDTO.getMensajeError());
				respProductoContratadoSimpleDTO.setResultado(false);
			}
		}	
		catch(GeneralException e)
		{
			logger.error("Exception ");
			logger.error(e);
			
			respProductoContratadoSimpleDTO.setCodigo(String.valueOf(e.getCodigoEvento()));
			respProductoContratadoSimpleDTO.setDescripcion(e.getDescripcionEvento());
			respProductoContratadoSimpleDTO.setResultado(false);
			
		}
		catch(Exception e)
		{
			logger.error("Exception ");
			logger.error(e);
			throw new GeneralException(e);
			
		}
		logger.debug("fin : obtenerPlanesAdicionalesContratadosIntegracion");
		return respProductoContratadoSimpleDTO;
	 }
	}
	
	
	/**
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 */
	public WSListaProdOferDTO obtenerProductosOfertablesBeneficiarioIntegracion(DatosInBeneficioDTO datosInBeneficio) throws ManConException, ManProOffInvException, NegSalException
	//, SOAPGeneralException
	{	
		long validacion = 0;
		WSListaProdOferDTO wsListaProdOferDTO=null;
		validacion = Long.parseLong(datosInBeneficio.getNumAbonadoBeneficiario());
					
		ArrayList filtro = new ArrayList();
		GeneralException generalException=null; 
		try{
			if ((datosInBeneficio.getNumAbonadoBeneficiario()==null) ||	(validacion==0)){
				// si es un string o esta vacio el benediciario tiene que tener el mismo valor que el contratado 
				datosInBeneficio.setNumAbonadoBeneficiario(datosInBeneficio.getNumAbonadoContratado());
			}
			
			
			AbonadoDTO abonadoContratante = new AbonadoDTO();
			abonadoContratante.setNumCelular(Long.parseLong(datosInBeneficio.getNumAbonadoContratado()));
			abonadoContratante = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoContratante);
	
			if ((abonadoContratante.getCodSituacion().equals("BAP"))||(abonadoContratante.getCodSituacion().equals("BAA")))
			{
				generalException= new GeneralException();
				generalException.setMessage("El abonado contrantante se encuentra en estado de baja..");
				generalException.setCodigo("situacion del abonado contratante no valida");
				generalException.setCodigoEvento(2);				
				logger.debug("Exception[", generalException);
				//throw new ManProOffInvException(abonadoContratanteBAA);				
			}
			
			if (generalException==null)
			{
				AbonadoDTO abonadoBeneficiario = new AbonadoDTO();
				abonadoBeneficiario.setNumCelular(Long.parseLong(datosInBeneficio.getNumAbonadoBeneficiario()));
				abonadoBeneficiario = manConFacadeDelegate.obtenerDatosAbonadoByNumCelular(abonadoBeneficiario);
		
				String planTarifBene = abonadoBeneficiario.getCodTipPlan();
						
				CatalogoDTO catalogo=new CatalogoDTO();
				Calendar cal= Calendar.getInstance();                
		        cal.set(3000,11,31);               
		        catalogo.setCodCanal(datosInBeneficio.getCanalOrigenPro());
		        catalogo.setFecInicioVigencia(new Date());
		        catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));        
		        catalogo.setIndNivelAplica(abonadoContratante.getNumAbonado()!=0?"A":"C");
		         
		        abonadoContratante.setCatalogo(catalogo);		
				abonadoContratante.setPlanTarifario(new PlanTarifarioDTO());
				abonadoContratante.getPlanTarifario().setPaqueteDefault(new PaqueteDTO());
				abonadoContratante.getPlanTarifario().getPaqueteDefault().setCodProdPadre(abonadoContratante.getCodProdPadre());
				
				ProductoOfertadoListDTO productosOfertListContratante=manProOffInvFacadeDelegate.obtenerProductosOfertables(abonadoContratante);
				
				/**
				 * @author rlozano
				 * @descripcion : se obtiene los limites de consumo asociados a los PA
				 * @date 30-04-2010
				 */
				for (int p = 0;p<productosOfertListContratante.getProductoList().length;p++){
					productosOfertListContratante.getProductoList()[p].setCodCliente(abonadoContratante.getCodCliente());
				}
				productosOfertListContratante=manProOffInvFacadeDelegate.obtenerLCplanAdicional(productosOfertListContratante);
				
				
				for (int p = 0;p<productosOfertListContratante.getProductoList().length;p++){
					ProductoOfertadoDTO productoAbonadoContratante = productosOfertListContratante.getProductoList()[p];
					if (planTarifBene.equals(productoAbonadoContratante.getIndTipoPlataforma())){
						filtro.add(productoAbonadoContratante);
					}
				}
		
				if (filtro.size()==0){				
					generalException= new GeneralException();
					generalException.setMessage("No se encontraron productos ofertables");
					generalException.setCodigo("no hay productos ofertables");
					generalException.setCodigoEvento(1);				
					logger.debug("Exception[", generalException);
					//throw new ManProOffInvException(NoTraeProductos);
	//				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	//                       " ", "Server fallo", "lstUsuario fallo", " ", NoTraeProductos);
	//				throw errorSoap.obtenerGeneralSoapException();
					
					
				}
				
				else
				{
					ProductoOfertadoDTO[] productoBeneficio = null;
					productoBeneficio = (ProductoOfertadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(filtro.toArray(), ProductoOfertadoDTO.class);
					
					wsListaProdOferDTO= new WSListaProdOferDTO();
					ProdOfertableDTO prodOfertableDTO=null;
					
					
					filtro.clear();
					for(int j=0;j<productoBeneficio.length;j++)
					{
						prodOfertableDTO= new ProdOfertableDTO();
						
						prodOfertableDTO.setCargoListDTO(productoBeneficio[j].getCargoList());
						prodOfertableDTO.setCodProdOfer(productoBeneficio[j].getIdProductoOfertado());
						prodOfertableDTO.setDesProd(productoBeneficio[j].getDesProdOfertado());
						prodOfertableDTO.setLimiteConsumoPlanAdicionalListDTO(productoBeneficio[j].getListaLimCons());
						prodOfertableDTO.setTipoComportamiento(productoBeneficio[j].getEspecificacionProducto().getTipoComportamiento());
						filtro.add(prodOfertableDTO);
					}
					
					wsListaProdOferDTO.setProdOfertableDTO((ProdOfertableDTO[])filtro.toArray(new ProdOfertableDTO[filtro.size()]));
					wsListaProdOferDTO.setResultado(true);
				}
				
		   }
			if (generalException!=null)
			{
				throw (generalException);
			}
		}
		
		catch(ManConException e)
		{
			logger.debug("ManConException");
			logger.error(e);
			throw(e);
			
		}
		catch(ManProOffInvException e)
		{
			logger.debug("ManProOffInvException");
			logger.error(e);
			throw(e);
			
		}
		catch(GeneralException e)
		{
			logger.debug("GeneralException");
			logger.error(e);
			throw new ManConException(e);
			
		}
		
		catch(Exception e)
		{
			logger.debug("Exception");
			logger.error(e);
			throw new ManConException(e);
		}
		
		
		
		

		return wsListaProdOferDTO;
	}
	
	
	private HashMap getCantidadesPorTipo(ArrayList aList) throws Exception{
		HashMap retValue= new HashMap();
		try
		{
			
		}
		catch(Exception e)
		{
			logger.debug("Exceptiion en la funcion de Haspmap Números frecuentes");
			e.printStackTrace();
			throw(e);	
		}
		return retValue;
	}	
}
