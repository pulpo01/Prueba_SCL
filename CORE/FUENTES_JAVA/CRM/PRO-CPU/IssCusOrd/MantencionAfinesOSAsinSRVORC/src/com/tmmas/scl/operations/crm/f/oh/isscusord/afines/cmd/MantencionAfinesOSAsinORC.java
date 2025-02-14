package com.tmmas.scl.operations.crm.f.oh.isscusord.afines.cmd;


import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.rmi.RemoteException;

import javax.ejb.CreateException;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

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
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session.ManCusBilFacade;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session.ManCusBilFacadeHome;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.common.exception.ManCusBilException;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.afines.cmd.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.orc.OrdenServicioAsincronoCmdORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.OrdenServicioBaseDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionAfinesDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session.ManCusInvFacade;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session.ManCusInvFacadeHome;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;




public class MantencionAfinesOSAsinORC extends OrdenServicioAsincronoCmdORC {


	private static final long serialVersionUID = 1L;

	transient static Logger cat = Logger.getLogger(MantencionAfinesOSAsinORC.class);
	transient private AsyncProcessParameterObject parametros = null;
	

	public MantencionAfinesOSAsinORC() {
		// TODO Auto-generated constructor stub
	}

	public MantencionAfinesOSAsinORC(AsyncProcessParameterObject value) {
		super(value);
		// TODO Auto-generated constructor stub
	}

	public void ejecutarOrdenServicio(OrdenServicioBaseDTO objeto)
	throws IssCusOrdException {
		cat.debug("ejecutarOrdenServicio():start");		
		
		try{
			registroOrden((ParamMantencionAfinesDTO) objeto);
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
		cat.debug("ejecutarOrdenServicio():end");	
	}

	public void registroOrden(ParamMantencionAfinesDTO paramAfines) throws InstantiationException, IllegalAccessException, ClassNotFoundException, JDOMException, IOException, SecurityException, IllegalArgumentException, InvocationTargetException, NoSuchFieldException, NoSuchMethodException, IssCusOrdException
	{
			cat.debug("registroOrden() :inicio");
			NumeroListDTO numeroListAdd = paramAfines.getNumeroListAdd();//N�meros nuevos a agregar
			NumeroListDTO numeroListDel = paramAfines.getNumeroListDel();//N�meros antiguos a eliminar
			
	        ejecutarRegistroOrden(paramAfines);
	        
	        if(numeroListAdd!=null){
	        	ejecutarAgregarAfines(numeroListAdd);
	        }
	        if(numeroListDel!=null){
	        	ejecutarEliminarAfines(numeroListDel);
	        }
			
			
			cat.debug("registroOrden() :fin");
				
	}
	
	private void ejecutarAgregarAfines(NumeroListDTO numeroListDel)//	throws NegSalException 
	{
		cat.debug("ejecutarAgregarAfines():start");		
		RetornoDTO retorno= null;		
		
		try
		{		
			cat.debug("crearListaNumeros : inicio");
			retorno = getManCusInvFacade().crearListaNumeros(numeroListDel);
			cat.debug("crearListaNumeros : fin");
			
		}catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IssCusOrdException[" + loge + "]");			
			
		}		
		cat.debug("ejecutarAgregarAfines():end");	
	
	}
	
	private void ejecutarEliminarAfines(NumeroListDTO numeroListDel)//	throws NegSalException 
	{
		cat.debug("ejecutarEliminarAfines():start");		
		RetornoDTO retorno= null;		
		try
		{		
			cat.debug("eliminarListaNumeros : inicio");
			retorno = getManCusInvFacade().eliminarListaNumeros(numeroListDel);
			cat.debug("eliminarListaNumeros : fin");
			
		}catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IssCusOrdException[" + loge + "]");			
			
		}		
		cat.debug("ejecutarEliminarAfines():end");	
	
	}
	
	private void ejecutarRegistroOrden(ParamMantencionAfinesDTO param){
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
			retorno = getCloCusOrdFacade().registraNivelOoss(registroNivel);
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
			retorno = getCloCusOrdFacade().registrarOOSSEnLinea(registroLinea);
			cat.debug("registrarOOSSEnLinea() :fin");
		}catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("IssCusOrdException[" + loge + "]");	
		}
		cat.debug("ejecutarRegistroOrden(): end");
		
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
			cat.debug("ejecutarOrdenServicio() Proceso termin� satisfactoriamente");
			
			
			
			boolean ejecutarRegistroCargos = true;
			if (ordenServicioBaseDTO.getRegistroCargos()== null || ordenServicioBaseDTO.getRegistroCargos().getOcacionales()==null){
				ejecutarRegistroCargos = false;
			}
			if (ordenServicioBaseDTO.getACiclo()==null || ordenServicioBaseDTO.getACiclo().equalsIgnoreCase("NO")){
				ejecutarRegistroCargos = false;
			}
			if  (ejecutarRegistroCargos){
				cat.debug("construirRegistroCargos(): inicio");
				RegCargosDTO retValConst=new RegCargosDTO();
				cat.debug("construirRegistroCargos(): inicio");
				com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO obtCargosFrmk = new com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO();
				MapperIF mapper = new DozerBeanMapper();
				mapper.map(ordenServicioBaseDTO.getRegistroCargos().getOcacionales(), obtCargosFrmk);
				com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO retValConstFrmk = new com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO();
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
				
				com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO objetoSesionFrmk=new com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO();
				mapper.map(objetoSesion, objetoSesionFrmk);
				retValConstFrmk.setObjetoSesion(objetoSesionFrmk);
				
				cat.debug("parametrosRegistrarCargos() :inicio");			
				this.getFrmkCargosFacade().parametrosRegistrarCargos(retValConstFrmk);
				cat.debug("parametrosRegistrarCargos() :fin");

			}
				
			
		} catch (Exception e) {
			cat.debug("Error, se procede a ejecutar rollback");
			throw new GeneralException("A ocurrido un error al eliminar numeros afines", e); 
		}
		cat.debug("start():end");
		return null;
	}
	
	private ManCusInvFacade getManCusInvFacade() throws ManCusInvException
	{
		Global global = Global.getInstance();		
		cat.debug("getManCusInvFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		ManCusInvFacadeHome manCusInvFacadeHome = null;

		String jndi = global.getValor("jndi.ManCusInvFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.ManCusInvProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			manCusInvFacadeHome = (ManCusInvFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, ManCusInvFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new ManCusInvException(e);
		}		
		cat.debug("Recuperada interfaz home de Manage Customer...");
		ManCusInvFacade manCusInvFacade = null;

		try 
		{
			manCusInvFacade = manCusInvFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new ManCusInvException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new ManCusInvException(e);
		}		
		cat.debug("getManCusInvFacade():end");
		return manCusInvFacade;
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
		CloCusOrdFacade cloCusOrdFacade = null;

		try 
		{
			cloCusOrdFacade = cloCusOrdFacadeHome.create();
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
		return cloCusOrdFacade;
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
	
}
