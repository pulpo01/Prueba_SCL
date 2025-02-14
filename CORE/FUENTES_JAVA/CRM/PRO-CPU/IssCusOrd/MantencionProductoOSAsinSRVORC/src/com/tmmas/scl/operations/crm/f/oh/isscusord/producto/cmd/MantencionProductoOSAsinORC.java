package com.tmmas.scl.operations.crm.f.oh.isscusord.producto.cmd;


import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.rmi.RemoteException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.ejb.CreateException;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

import org.apache.commons.lang.SerializationUtils;
import org.apache.log4j.Logger;
import org.jdom.JDOMException;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.processmgr.AsyncProcessParameterObject;
import com.tmmas.cl.framework.processmgr.AsyncProcessResponseObject;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DetEstadoProcesoOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EstadoProcesoOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EventoNumFrecDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GenericDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session.ManCusBilFacade;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session.ManCusBilFacadeHome;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.common.exception.ManCusBilException;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.producto.cmd.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.orc.OrdenServicioAsincronoCmdORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.OrdenServicioBaseDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionAfinesDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionProductoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
//import com.tmmas.scl.operations.crm.f.oh.isscusord.soa.bean.ejb.helper.Global;
//import com.tmmas.scl.operations.crm.f.oh.isscusord.soa.bean.ejb.session.IssCusOrdORC;
//import com.tmmas.scl.operations.crm.f.oh.isscusord.soa.bean.ejb.session.IssCusOrdORCHome;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.ContratacionProductoSrvOrcFactory;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.LimiteConsumoSrvOrcFactory;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.ContratacionProductoSrvOrcFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.ContratacionProductoSrvOrcIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.LimiteConsumoSrvOrcFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.LimiteConsumoSrvOrcIF;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;




public class MantencionProductoOSAsinORC extends OrdenServicioAsincronoCmdORC {


	private static final long serialVersionUID = 1L;

	transient static Logger cat = Logger.getLogger(MantencionProductoOSAsinORC.class);
	transient private AsyncProcessParameterObject parametros = null;
	private ManCusBilFacade manCusBilFacade = null;
	private CloCusOrdFacade cloCusOrdFacade = null;
	private SupOrdHanFacade supOrdHandFacade =null;
	private String numeroEvento;
	private String numOrdenServicio;
	Map datosExtra = new HashMap();
	
	//private ContratacionProductoSrvOrcFactoryIF serviceFactory=new ContratacionProductoSrvOrcFactory();
	//private ContratacionProductoSrvOrcIF service1 = serviceFactory.getApplicationService1();

	public MantencionProductoOSAsinORC() {
		// TODO Auto-generated constructor stub
	}

	public MantencionProductoOSAsinORC(AsyncProcessParameterObject value) {
		super(value);
		// TODO Auto-generated constructor stub
	}

	public void ejecutarOrdenServicio(OrdenServicioBaseDTO objeto)
	throws IssCusOrdException {
		cat.debug("ejecutarMantencionProductos():start");		
		

		try{
			registroOrden((ParamMantencionProductoDTO) objeto);
		}catch(RemoteException e){

			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("SecurityException[" + loge + "]");
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IllegalArgumentException[" + loge + "]");
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("InstantiationException[" + loge + "]");
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IllegalAccessException[" + loge + "]");
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ClassNotFoundException[" + loge + "]");
			e.printStackTrace();
		} catch (JDOMException e) {
			// TODO Auto-generated catch block
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("JDOMException[" + loge + "]");
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IOException[" + loge + "]");
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("InvocationTargetException[" + loge + "]");
			e.printStackTrace();
		} catch (NoSuchFieldException e) {
			// TODO Auto-generated catch block
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("NoSuchFieldException[" + loge + "]");
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("NoSuchMethodException[" + loge + "]");
			e.printStackTrace();
		}
		cat.debug("ejecutarMantencionProductos():end");	
	}


//ParamRegistroOrdenServicioDTO
	public void registroOrden(ParamMantencionProductoDTO objeto) throws InstantiationException, IllegalAccessException, ClassNotFoundException, JDOMException, IOException, SecurityException, IllegalArgumentException, InvocationTargetException, NoSuchFieldException, NoSuchMethodException, IssCusOrdException
	{
		ProductoContratadoListDTO prodContList = objeto.getProdContList();//Productos a Descontratar
		OfertaComercialDTO ofertaComercial = objeto.getOfertaComercial();
		ProductoContratadoListDTO productoContratadoMantenidosLC = objeto.getListaProdContraMantenidosLC();
		ejecutarRegistroOrden(objeto);
		
		numOrdenServicio=objeto.getNumOrdenServicio();
		boolean insertaEvento = false;
		try{
			if(prodContList!=null && prodContList.getProductosContratadosDTO()!=null && 
			   prodContList.getProductosContratadosDTO().length>0)
			{

				ejecutarDescontratar(prodContList);
		    }
		    if(ofertaComercial!=null &&
		       ((ofertaComercial.getPaqueteList() !=null && ofertaComercial.getPaqueteList().getPaqueteContratadoList()!=null)|| 
		        (ofertaComercial.getProductoList()!=null && ofertaComercial.getProductoList().getProductosContratadosDTO()!=null)
		        ))
		    {
		    	ejecutarContratar(ofertaComercial);
		    }
		    /*Se agrega la mantención de Limite de Consumo a la mantención de planes adicionales 240210 pv*/
			if(productoContratadoMantenidosLC!=null && productoContratadoMantenidosLC.getProductosContratadosDTO()!=null && 
					productoContratadoMantenidosLC.getProductosContratadosDTO().length>0)
			{
				ejecutarMantencionLc(productoContratadoMantenidosLC);
		    }
			/**/
		    //TODO Revisar si esto está funcionando 110809 pv
		    /*insertaEvento = verificarInsertEvento(prodContList,ofertaComercial);
		    cat.debug("insertaEvento[" + insertaEvento + "]");
		    //MIX9003 pv 290709
		    if(insertaEvento)insertarEventoNumFrec(objeto);*/
		    
		}catch(GeneralException e){
			ofertaComercial.setNumProceso(numOrdenServicio);
			this.inscribeProceso(ofertaComercial);	
		}

	}
	
	private boolean verificarInsertEvento(ProductoContratadoListDTO prodContList, OfertaComercialDTO ofertaComercial) {
		//Para la mantencion de Productos se debe verificar si elimina lista de numeros
		if(prodContList != null && prodContList.getProductosContratadosDTO() != null && 
		   prodContList.getProductosContratadosDTO().length > 0)
		{
			for(int i=0;i<prodContList.getProductosContratadosDTO().length;i++)
			{
				if(prodContList.getProductosContratadosDTO()[i]                  != null &&
				   prodContList.getProductosContratadosDTO()[i].getListaNumero() != null &&
				   prodContList.getProductosContratadosDTO()[i].getListaNumero().getNumerosDTO().length > 0)
				{
					cat.debug("getNumerosDTO()[0].getNro()[" + prodContList.getProductosContratadosDTO()[i].getListaNumero().getNumerosDTO()[0].getNro() + "]");
					return true;	
				}
			}
		}
		//Para la mantencion de Productos esto no se debe preguntar ya que se crean listas vacias
		/*if(ofertaComercial.getProductoList() != null && 
		   ofertaComercial.getProductoList().getProductosContratadosDTO() != null &&
		   ofertaComercial.getProductoList().getProductosContratadosDTO().length > 0)
		{
			ProductoContratadoDTO[] productos = ofertaComercial.getProductoList().getProductosContratadosDTO();
			for(int i=0;i<productos.length;i++)
			{
				if(prodContList.getProductosContratadosDTO()[i].getListaNumero().getNumerosDTO().length > 0)
				{
					return true;	
				}
				
			}
		}*/
		return false;
	}

	private void ejecutarContratar(OfertaComercialDTO ofertaComercial)throws IssCusOrdException {
	
		cat.debug("ejecutarContratar():start");		
		RetornoDTO retorno= null;		
		//ParametroSerializableDTO param=new ParametroSerializableDTO();
		try
		{		
			cat.debug("AQUI DEBE EJECUTAR PROCESO");
			//retorno = this.getIssCusOrdORC().descontratarOfertaComercial(productoContratadoList);
			//debo llar a fachada con control del rollback o sea como en negsal
			ContratacionProductoSrvOrcFactoryIF serviceFactory=new ContratacionProductoSrvOrcFactory();
			ContratacionProductoSrvOrcIF service1 = serviceFactory.getApplicationService1();
			retorno = service1.activarProductoContratado(ofertaComercial);
			//retorno = this.getIssCusOrdORC().descontratarOfertaComercial(productoContratadoList);
			//agregar rollback
		}catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IssCusOrdException[" + loge + "]");	
			throw new IssCusOrdException(e);
		}		
		cat.debug("ejecutarDescontratar():end");	
	}

	private void ejecutarDescontratar(ProductoContratadoListDTO productoContratadoList)	throws IssCusOrdException 
	{
		cat.debug("ejecutarDescontratar():start");		
		RetornoDTO retorno= null;		
		//ParametroSerializableDTO param=new ParametroSerializableDTO();
		try
		{		
			cat.debug("AQUI DEBE EJECUTAR PROCESO");
			//retorno = this.getIssCusOrdORC().descontratarOfertaComercial(productoContratadoList);
			//debo llar a fachada con control del rollback o sea como en negsal
			ContratacionProductoSrvOrcFactoryIF serviceFactory=new ContratacionProductoSrvOrcFactory();
			ContratacionProductoSrvOrcIF service1 = serviceFactory.getApplicationService1();
			retorno = service1.descontratarOfertaComercial(productoContratadoList);
			//retorno = this.getIssCusOrdORC().descontratarOfertaComercial(productoContratadoList);
			//agregar rollback
		}catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IssCusOrdException[" + loge + "]");
			OfertaComercialDTO ofertaComercial =new OfertaComercialDTO();
			ofertaComercial.setProductoList(productoContratadoList);
			ofertaComercial.setNumEvento(productoContratadoList.getNumEvento());
			ofertaComercial.setNumProceso(numOrdenServicio);
			this.inscribeProceso(ofertaComercial);
			//param.setEstadoProceso("ERROR");
			//param.setNumProceso(productoContratadoList.getProductosContratadosDTO()[0].getNumProceso());
			//param.setIdProceso(productoContratadoList.getNumEvento());		
			//param.setObjetoSerializado((byte[])SerializationUtils.serialize(productoContratadoList));	
			//param.setOrigenProceso(productoContratadoList.getProductosContratadosDTO()[0].getOrigenProceso());			
			
			throw new IssCusOrdException(e);
		}		
		cat.debug("ejecutarDescontratar():end");	
	
	}

	private void ejecutarMantencionLc(ProductoContratadoListDTO listaProdContraMantenidosLC)throws IssCusOrdException {
		
		cat.debug("ejecutarMantencionLc():start");		
		RetornoDTO retorno= null;		
		try
		{		
			LimiteConsumoSrvOrcFactoryIF serviceFactory=new LimiteConsumoSrvOrcFactory();
			LimiteConsumoSrvOrcIF service1 = serviceFactory.getApplicationService1();
			retorno = service1.mantenerLimiteDeConsumo(listaProdContraMantenidosLC);
		}catch(IssCusOrdException e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IssCusOrdException[" + loge + "]");	
			throw e;
		}		
		cat.debug("ejecutarMantencionLc():end");	
	}
	
	private void ejecutarRegistroOrden(ParamMantencionProductoDTO param){
		cat.debug("ejecutarRegistroOrden(): start");
		RetornoDTO retorno = null;
		try{
			
			RegistroNivelOOSSDTO registroNivel = new RegistroNivelOOSSDTO();
			registroNivel.setNumAbonado(param.getAbonado().getNumAbonado());
			registroNivel.setCodCliente(param.getCliente().getCodCliente());
			registroNivel.setCodTipMod(param.getCodActAbo());
			registroNivel.setTipSujeto(param.getSujeto());
			registroNivel.setNomUsuaOra(param.getNomUsuaOra());
			cat.debug("registraNivelOoss() :inicio");
			cloCusOrdFacade = getCloCusOrdFacade();
			retorno = cloCusOrdFacade.registraNivelOoss(registroNivel);
			cat.debug("registraNivelOoss() :fin");
		}catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IssCusOrdException[" + loge + "]");	
		}
		
		try{
			RegistrarOossEnLineaDTO registroLinea = new RegistrarOossEnLineaDTO();
			registroLinea.setCodOS(param.getCodOrdenServicio());
			registroLinea.setNumOs(Long.parseLong(param.getNumOrdenServicio()));
			registroLinea.setCodProducto(1);
			registroLinea.setTipInter(param.getTipInter());
			registroLinea.setCodInter(param.getCodInter());
			registroLinea.setUsuario(param.getUsuario());
			registroLinea.setFecha(param.getFecha());
			registroLinea.setComentario(param.getComentario());
			
			cat.debug("registrarOOSSEnLinea() :inicio");
			retorno = cloCusOrdFacade.registrarOOSSEnLinea(registroLinea);
			cat.debug("registrarOOSSEnLinea() :fin");
		}catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IssCusOrdException[" + loge + "]");	
		}
		cat.debug("ejecutarRegistroOrden(): end");
		
	}

	private void insertarEventoNumFrec(ParamMantencionProductoDTO param) throws IssCusOrdException {
		cat.debug("insertarEventoNumFrec():start");			
		try
		{		
			EventoNumFrecDTO eventoNumFrecDTO = new EventoNumFrecDTO();
			eventoNumFrecDTO.setNumAbonado(param.getAbonado().getNumAbonado());
			eventoNumFrecDTO.setCodCliente(param.getCliente().getCodCliente());
			eventoNumFrecDTO.setCodOOSS(Long.parseLong(param.getCodOrdenServicio()));
			eventoNumFrecDTO.setNumOOSS(Long.parseLong(param.getNumOrdenServicio()));

			cat.debug("insertarEventoNumFrec() :inicio");
			cloCusOrdFacade = getCloCusOrdFacade();
			cloCusOrdFacade.insertarEventoNumFrec(eventoNumFrecDTO);
			cat.debug("insertarEventoNumFrec() :fin");
		}catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IssCusOrdException[" + loge + "]");	
			throw new IssCusOrdException(e);
		}		
		cat.debug("insertarEventoNumFrec():end");	
	}
	
	public void onInit() throws GeneralException {
		cat.debug("onInit():start");
		setRollBackManual(false);
		// Recupero el parametro
		parametros = getArguments();
		OrdenServicioBaseDTO paramOServicio;
		paramOServicio = (OrdenServicioBaseDTO)parametros.getArgumentsData();
		cat.debug("onInit():end");
	}

	public AsyncProcessResponseObject start() throws GeneralException {
		cat.debug("start():start");
		
		OrdenServicioBaseDTO ordenServicioBaseDTO;
		 
		try {
			// Recupero el parametro
			parametros = getArguments();
			ordenServicioBaseDTO = (OrdenServicioBaseDTO)parametros.getArgumentsData();
			
			cat.debug("ejecutarOrdenServicio() se procede a ejecutar proceso....");
			this.ejecutarOrdenServicio(ordenServicioBaseDTO);
			cat.debug("ejecutarOrdenServicio() Proceso terminó satisfactoriamente");
			
			
			
			boolean ejecutarRegistroCargos = true;
			if (ordenServicioBaseDTO.getRegistroCargos()== null || ordenServicioBaseDTO.getRegistroCargos().getOcacionales()==null){
				ejecutarRegistroCargos = false;
			}
			if (ordenServicioBaseDTO.getACiclo()==null || ordenServicioBaseDTO.getACiclo().equalsIgnoreCase("NO")){
				ejecutarRegistroCargos = false;
			}
			if  (ejecutarRegistroCargos){
				RegCargosDTO retValConst=new RegCargosDTO();
				cat.debug("construirRegistroCargos(): inicio");
				com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO obtCargosFrmk = new com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO();
				MapperIF mapper = new DozerBeanMapper();
				mapper.map(ordenServicioBaseDTO.getRegistroCargos().getOcacionales(), obtCargosFrmk);
				com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO retValConstFrmk = new com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO();
				
				
				cat.debug("construirRegistroCargos():inicio");
				//retValConst=this.getManCusBilFacade().construirRegistroCargos(objeto.getRegistroCargos().getOcacionales());
				cat.debug("::::::::::PARAMETROS ENTRADA CONSTRUIR CARGOS::::::::");
				cat.debug(":::::::::::::::::::::::::::::::::::::::::::::::::::::");
				cat.debug("ObtencionCargosDTO");
				cat.debug("monto               :"+obtCargosFrmk.getMonto());
				cat.debug("tipo                :"+obtCargosFrmk.getTipo());
				cat.debug("codigoConcepto      :"+obtCargosFrmk.getCodigoConcepto());
				cat.debug("DescripcionConcepto :"+obtCargosFrmk.getDescripcionConcepto());
				cat.debug("MinDescuento        :"+obtCargosFrmk.getMinDescuento());
				cat.debug("MaxDescuento        :"+obtCargosFrmk.getMaxDescuento());
				cat.debug("TipoAplicacion      :"+obtCargosFrmk.getTipoAplicacion());
				cat.debug("NumAbonado          :"+obtCargosFrmk.getNumAbonado());
				cat.debug("Aprobacion          :"+obtCargosFrmk.isAprobacion());
				cat.debug("----------------------------------------------------------");
				cat.debug("CargosDTO");
				if (obtCargosFrmk.getCargos()!= null) {
					for(int i=0; i<obtCargosFrmk.getCargos().length;i++){
						cat.debug("IdProducto             :"+obtCargosFrmk.getCargos()[i].getIdProducto());
						cat.debug("Cantidad               :"+obtCargosFrmk.getCargos()[i].getCantidad());
						
						cat.debug("--------------------------------------------------------------------------");
						cat.debug("AtributosCargoDTO");
						cat.debug("getAtributo().getCuotas()            :"+obtCargosFrmk.getCargos()[i].getAtributo().getCuotas());
						cat.debug("getAtributo().getFechaAplicacion()   :"+obtCargosFrmk.getCargos()[i].getAtributo().getFechaAplicacion());
						cat.debug("getAtributo().getTipoProducto()      :"+obtCargosFrmk.getCargos()[i].getAtributo().getTipoProducto());
						cat.debug("getAtributo().getClaseProducto()     :"+obtCargosFrmk.getCargos()[i].getAtributo().getClaseProducto());
						cat.debug("getAtributo().getCicloFacturacion()  :"+obtCargosFrmk.getCargos()[i].getAtributo().getCicloFacturacion());
						cat.debug("getAtributo().getCodigoArticuloServicio() :"+obtCargosFrmk.getCargos()[i].getAtributo().getCodigoArticuloServicio());
						cat.debug("getAtributo().getNumAbonado()             :"+obtCargosFrmk.getCargos()[i].getAtributo().getNumAbonado());
						cat.debug("getAtributo().isRecurrente()              :"+obtCargosFrmk.getCargos()[i].getAtributo().isRecurrente());
						cat.debug("getAtributo().isObligatorio()             :"+obtCargosFrmk.getCargos()[i].getAtributo().isObligatorio());
						cat.debug("getAtributo().isCiclo()                   :"+obtCargosFrmk.getCargos()[i].getAtributo().isCiclo());
						
						cat.debug("--------------------------------------------------------------------------");
						cat.debug("PrecioDTO");
						cat.debug("getPrecio().getMonto()               :"+obtCargosFrmk.getCargos()[i].getPrecio().getMonto());
						cat.debug("getPrecio().getCodigoConcepto()      :"+obtCargosFrmk.getCargos()[i].getPrecio().getCodigoConcepto());
						cat.debug("getPrecio().getDescripcionConcepto() :"+obtCargosFrmk.getCargos()[i].getPrecio().getDescripcionConcepto());
						cat.debug("getPrecio().getFechaAplicacion()     :"+obtCargosFrmk.getCargos()[i].getPrecio().getFechaAplicacion());
						cat.debug("getPrecio().getValorMaximo()         :"+obtCargosFrmk.getCargos()[i].getPrecio().getValorMaximo());
						cat.debug("getPrecio().getValorMinimo()         :"+obtCargosFrmk.getCargos()[i].getPrecio().getValorMinimo());
						cat.debug("getPrecio().getIndicadorAutMan()     :"+obtCargosFrmk.getCargos()[i].getPrecio().getIndicadorAutMan());
						
						cat.debug("--------------------------------------------------------------------------");
						cat.debug("AtributosMigracionDTO");
						cat.debug("getPrecio().getDatosAnexos().getInd_paquete() :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getInd_paquete());
						cat.debug("getPrecio().getDatosAnexos().getInd_cuota()   :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getInd_cuota());
						cat.debug("getPrecio().getDatosAnexos().getInd_equipo()  :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getInd_equipo());
						cat.debug("getPrecio().getDatosAnexos().getCod_tecnologia() :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getCod_tecnologia());
						cat.debug("getPrecio().getDatosAnexos().getCodTipPlantarifOrig() :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getCodTipPlantarifOrig());
						cat.debug("getPrecio().getDatosAnexos().getCodTipPlantarifDes()  :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getCodTipPlantarifDes());
						cat.debug("getPrecio().getDatosAnexos().getNumAbonado()          :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getNumAbonado());
						cat.debug("getPrecio().getDatosAnexos().getNumeroCelular()       :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getNumeroCelular());
						
						cat.debug("--------------------------------------------------------------------------");
						cat.debug("MonedaDTO");
						cat.debug("getPrecio().getUnidad().getCodigo()      :"+obtCargosFrmk.getCargos()[i].getPrecio().getUnidad().getCodigo());
						cat.debug("getPrecio().getUnidad().getDescripcion() :"+obtCargosFrmk.getCargos()[i].getPrecio().getUnidad().getDescripcion());
						if (obtCargosFrmk.getCargos()[i].getDescuento()!=null){
							for(int j=0; j<obtCargosFrmk.getCargos()[i].getDescuento().length;j++){
								cat.debug("=============================================================================");
								cat.debug("DescuentoDTO");
								cat.debug("Monto       :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getMonto());
								cat.debug("Tipo        :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getTipo());
								cat.debug("CodigoConceptoCargo :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getCodigoConceptoCargo());
								cat.debug("CodigoConcepto      :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getCodigoConcepto());
								cat.debug("DescripcionConcepto :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getDescripcionConcepto());
								cat.debug("MinDescuento        : :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getMinDescuento());
								cat.debug("MaxDescuento        :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getMaxDescuento());
								cat.debug("TipoAplicacion      :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getTipoAplicacion());
								cat.debug("MontoCalculado      :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getMontoCalculado());
								cat.debug("CodigoMoneda        :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getCodigoMoneda());
								cat.debug("NumTransaccion      :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getNumTransaccion());
								cat.debug("isAprobacion()      :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].isAprobacion());
							}
							
						} // del if (descuentos)
					
				} //del for de imprimir
					
				}  // del if (cargos)
				retValConstFrmk=this.getFrmkCargosFacade().construirRegistroCargos(obtCargosFrmk);
				
				cat.debug("construirRegistroCargos(): fin");
				CabeceraArchivoDTO objetoSesion=new CabeceraArchivoDTO();
				objetoSesion.setCodigoCliente(String.valueOf(ordenServicioBaseDTO.getCliente().getCodCliente()));
				objetoSesion.setPlanComercialCliente(String.valueOf(ordenServicioBaseDTO.getCliente().getCodPlanCom()));
				objetoSesion.setFacturaCiclo(true);
				objetoSesion.setNumeroVenta(0);
				objetoSesion.setNumeroTransaccionVenta(0);
				objetoSesion.setCodigoDocumento(ordenServicioBaseDTO.getCodTipoDocumento());
				objetoSesion.setCodModalidadVenta(ordenServicioBaseDTO.getModPago());
				objetoSesion.setCodigoVendedor(String.valueOf(ordenServicioBaseDTO.getCodVendedor()));
				objetoSesion.setNombreUsuario(ordenServicioBaseDTO.getNomUsuaOra());
				
				com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO objetoSesionFrmk=new com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO();
				mapper.map(objetoSesion, objetoSesionFrmk);
				retValConstFrmk.setObjetoSesion(objetoSesionFrmk);
				
				cat.debug("parametrosRegistrarCargos() :inicio");			
				this.getFrmkCargosFacade().parametrosRegistrarCargos(retValConstFrmk);
				cat.debug("parametrosRegistrarCargos() :fin");
				//resultado = null;

			}
				
			
		} catch (Exception e) {
			cat.debug("Error, se procede a ejecutar rollback");
			throw new GeneralException("A ocurrido un error al ejecutar descontratacion de oferta comercial", e); 
		}
		cat.debug("start():end");
		return null;
	}
	
		
	
	
	private CloCusOrdFacade getCloCusOrdFacade() throws CloCusOrdException 
	{
		Global global = Global.getInstance();		
		cat.debug("getCloCusOrdFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");
		
		CloCusOrdFacadeHome cloCusOrdFacadeHome = null;

		String jndi = global.getValor("jndi.CloCusOrdFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.CloCusOrdProvider");
		cat.debug("Url provider[" + url + "]");		
		
		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			
			cloCusOrdFacadeHome = (CloCusOrdFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, CloCusOrdFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new CloCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de CloseCustomerOrder");
		CloCusOrdFacade cloCusOrdFacade1 = null;

		try 
		{
			cloCusOrdFacade1 = cloCusOrdFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new CloCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new CloCusOrdException(e);
		}		
		cat.debug("getCloCusOrdFacade():end");
		return cloCusOrdFacade1;
	}
	
	private FrmkCargosFacade getFrmkCargosFacade() throws IssCusOrdException, FrmkCargosException 
	{
		Global global = Global.getInstance();		
		cat.debug("getFrmkCargosFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		FrmkCargosFacadeHome facadeHome = null;

		String jndi = global.getValor("jndi.FrmkCargosFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.FrmkCargosProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			facadeHome = (FrmkCargosFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, FrmkCargosFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new FrmkCargosException(e);
		}		
		cat.debug("Recuperada interfaz home de FrmkCargosFacade...");
		FrmkCargosFacade frmkCargosFacade = null;

		try 
		{
			frmkCargosFacade = facadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getFrmkCargosFacade():end");
		return frmkCargosFacade;
	}
	
	
	private SupOrdHanFacade getSupOrdHanFacade() throws IssCusOrdException, SupOrdHanException 
	{
		Global global = Global.getInstance();		
		cat.debug("getSupOrdHanFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		SupOrdHanFacadeHome facadeHome = null;

		String jndi = global.getValor("jndi.SupOrdHanFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.SupOrdHanProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			facadeHome = (SupOrdHanFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, SupOrdHanFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new SupOrdHanException(e);
		}		
		cat.debug("Recuperada interfaz home de SupOrdHanFacade...");
		FrmkCargosFacade frmkCargosFacade = null;

		try 
		{
			supOrdHandFacade = facadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getSupOrdHanFacade():end");
		return supOrdHandFacade;
	}
	
	/*
	private void notificarError(String codError, long numEvento, String desError) throws IssCusOrdException{
		cat.debug("notificarError:inicio");
		EstadoProcesoOOSSDTO estadoProc = new EstadoProcesoOOSSDTO();
		estadoProc.setEstado("ERROR");
		estadoProc.setFechaActualizacion(new Date());
		estadoProc.setNumProceso(this.numeroProceso);
		DetEstadoProcesoOSSDTO[] detalles = new DetEstadoProcesoOSSDTO[1];
		DetEstadoProcesoOSSDTO detalle = new DetEstadoProcesoOSSDTO();
		detalle.setEstado("ERROR");
		detalle.setFecEstado(new Date());
		detalle.setNumProceso(this.numeroProceso);
		detalle.setNumOOSS(this.numOrdenServicio);
		if(codError!=null)
			detalle.setCodError(Long.parseLong(codError));
		detalle.setNumEvento(numEvento);
		detalle.setDesError(desError);
		cat.debug("estadoProc.getEstado()[" + estadoProc.getEstado() + "]");
		cat.debug("estadoProc.getFechaActualizacion()[" + estadoProc.getFechaActualizacion() + "]");
		cat.debug("estadoProc.getNumProceso()[" + estadoProc.getNumProceso() + "]");
		cat.debug("detalle.getEstado()[" + detalle.getEstado() + "]");
		cat.debug("detalle.getFecEstado()[" + detalle.getFecEstado() + "]");
		cat.debug("detalle.getNumProceso()[" + detalle.getNumProceso() + "]");
		cat.debug("detalle.getNumOOSS()[" + detalle.getNumOOSS() + "]");
		if(codError!=null)
			cat.debug("detalle.getCodError()[" + detalle.getCodError() + "]");
		cat.debug("detalle.getNumEvento()[" + detalle.getNumEvento() + "]");
		if(desError!=null)
			cat.debug("detalle.getDesError()[" + detalle.getDesError() + "]");
		
		detalles[0] = detalle;
		estadoProc.setDetEstadoProcesoOSSDTO(detalles);
		try{
			cat.debug("notificar():inicio");
			notificar(estadoProc);
			cat.debug("notificar():fin");
		
		}catch(Exception e){
			throw new IssCusOrdException(e);
		}
			
		cat.debug("notificarError:fin");
		
	}
	*/
	/** 
	 * Este método inscribe un proceso representado por una Oferta Comercial, que es hecha Serializable antes de pasar a la fachada.
	 * La inscripción del proceso ocurre en el contexto del proceso definido por eTOM, <b>Support Order Handling</b>. 
	 * @param ofComercial objeto del tipo OfertaComercialDTO que contiene entre otras cosas un lista de paquetes contratados, 
	 *        lista de productos contratados (PaqueteContratadoListDTO y ProductoContratadoListDTO).	  
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.	 
	 * @see com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade 
	 * @throws SupOrdHanException
	 */
	public RetornoDTO inscribeProceso(OfertaComercialDTO ofComercial) throws IssCusOrdException
	{
		cat.debug("inscribeProceso: start ");
		//(byte[])SerializationUtils.serialize(parametro.getParametroObject()		
		RetornoDTO retorno=null;
		GenericDTO dtoGeneric=new GenericDTO();
		dtoGeneric.setSerializableObject(ofComercial);
		ParametroSerializableDTO param=new ParametroSerializableDTO();
		param.setEstadoProceso("ERROR");
		param.setNumProceso(ofComercial.getNumProceso());
		param.setIdProceso(ofComercial.getNumEvento());
		param.setOrigenProceso("PV");
		param.setObjetoSerializado((byte[])SerializationUtils.serialize(ofComercial));	
		try {
			retorno=getSupOrdHanFacade().inscribeProceso(param);
		} 
		catch(Exception e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("Exception[" + loge + "]");
			throw new IssCusOrdException(e);		
		}
		
				
		cat.debug("inscribeProceso: end ");
		return retorno;
	}
	
}
