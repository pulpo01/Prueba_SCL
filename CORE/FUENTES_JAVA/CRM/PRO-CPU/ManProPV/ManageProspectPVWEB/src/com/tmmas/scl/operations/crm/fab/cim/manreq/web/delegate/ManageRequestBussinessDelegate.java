/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 * 
 */
package com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate;

import java.rmi.RemoteException;
import java.util.Date;
import java.util.Hashtable;

import javax.ejb.CreateException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import javax.jms.QueueSession;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.xml.rpc.ServiceException;
import javax.xml.rpc.soap.SOAPFaultException;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.tempuri.PrincipalResponse;
import org.tempuri.WSClasifica;
import org.tempuri.WSClasificaSoap;
import org.tempuri.runtime.WSClasifica_Impl;

import com.tmmas.cl.framework.exception.FrameworkException;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.processmgr.AsyncProcessParameterObject;
import com.tmmas.cl.framework.util.MessagePublisher;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SalidaOutDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroEvaluacionRiesgoDTO;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaPlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaSaldoDTO;
import com.tmmas.cl.scl.socketps.common.dto.PlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.cl.scl.socketps.common.exception.SocketPSException;
import com.tmmas.cl.scl.socketps.negocio.ejb.session.ConsultaFacadeSTL;
import com.tmmas.cl.scl.socketps.negocio.ejb.session.ConsultaFacadeSTLHome;
import com.tmmas.cl.scl.ventas.negocio.ejb.session.VentasFacadeSTL;
import com.tmmas.cl.scl.ventas.negocio.ejb.session.VentasFacadeSTLHome;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteTipoPlanListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.DatosClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.LimiteLineasDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.LineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.MorosidadClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ObtencionLineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.PlanEvaluacionRiesgoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.SubCuentaListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.AbonadoSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CambioPlanPendienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CantSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CartaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaExcepcionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConvertActAboDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EstadoProcesoOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EventoNumFrecDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OficinaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OperadoraLocalDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PenalizacionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RangoAntiguedadDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ServCuentaSegDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.TipIdentListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CtaPersonalEmpDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.FiltroAbonadosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GaAbocelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtencionRolUsuarioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtencionSecuenciasDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaFiltroAbonadosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaPermanenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productABE.exception.ProductException;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaPlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanCicloDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BolsaDinamicaDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.framework.productDomain.productPromotionABE.dataTransferObject.EliminaPromocionDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoProductoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoProductoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.BodegaListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaBodegaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaPlanTarifDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaPrepagosDTO;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.bean.ejb.session.AppPriDisRebFacade;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.bean.ejb.session.AppPriDisRebFacadeHome;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.common.exception.AppPriDisRebException;
import com.tmmas.scl.operations.crm.b.bcm.mancol.bean.ejb.session.ManColFacade;
import com.tmmas.scl.operations.crm.b.bcm.mancol.bean.ejb.session.ManColFacadeHome;
import com.tmmas.scl.operations.crm.b.bcm.mancol.common.exception.ManColException;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session.ManCusBilFacade;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session.ManCusBilFacadeHome;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.common.exception.ManCusBilException;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session.DetCusOrdFeaFacade;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session.DetCusOrdFeaFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.common.exception.DetCusOrdFeaException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.afines.cmd.MantencionAfinesOSAsinORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.bean.ejb.session.IssCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.isscusord.bean.ejb.session.IssCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.AbonadoBeneficiarioOSAsinORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.AbonadoVetadoOSAsinORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.CambioPlanUnificadoOSAsinORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamAbonBenefRegOSDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamAbonVetadoRegOSDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamAbonoLimiteConsumoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionAfinesDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionFrecuentesDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionLimiteConsumoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionProductoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroOrdenServicioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.frecuentes.cmd.MantencionFrecuentesOSAsinORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.limiteconsumo.abono.cmd.AbonoLimiteConsumoOSAAsinORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.limiteconsumo.cmd.MantencionLimiteConsumoOSAsinORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.producto.cmd.MantencionProductoOSAsinORC;
import com.tmmas.scl.operations.crm.f.sel.negsal.bean.ejb.session.NegSalFacade;
import com.tmmas.scl.operations.crm.f.sel.negsal.bean.ejb.session.NegSalFacadeHome;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacade;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacadeHome;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.EvalCrediticiaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RespuestaEvalCrediticiaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.session.ManProOffInvFacade;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.session.ManProOffInvFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.bean.ejb.session.SupCusIntManFacade;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.bean.ejb.session.SupCusIntManFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.common.exception.SupCusIntManException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session.ManCusInvFacade;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session.ManCusInvFacadeHome;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;
import com.tmmas.scl.vendedor.dto.ConfiguracionVendedorCPUDTO;
import com.tmmas.scl.vendedor.dto.UsuarioSistemaDTO;
import com.tmmas.scl.vendedor.dto.UsuarioVendedorDTO;
import com.tmmas.scl.vendedor.exception.VendedorException;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTL;

public class ManageRequestBussinessDelegate {

	private static ManageRequestBussinessDelegate instance = null;
	private static Logger logger = Logger.getLogger(ManageRequestBussinessDelegate.class);
	private Global global = Global.getInstance();
	private FacadeMaker facadeMaker = FacadeMaker.getInstance();
	
	protected ServiceLocator svcLologgeror = ServiceLocator.getInstance();

	public static ManageRequestBussinessDelegate getInstance() {
		if (instance == null) {
			instance = new ManageRequestBussinessDelegate();
			
		}
		return instance;
	}	
	
	//ManageProductOfferingInventoryFacade	
	private ManProOffInvFacade getManProOffInvFacade() throws ManReqException {
		
		String log = global.getValor("web.log");
		log= global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getManProOffInvFacade():start");
		
		String jndi = global.getValor("jndi.ManProOffInvFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.ManProOffInvProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		ManProOffInvFacadeHome facadeHome =
			(ManProOffInvFacadeHome) PortableRemoteObject.narrow(obj, ManProOffInvFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de ManProOffInvFacade...");
		ManProOffInvFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getManProOffInvFacade()():end");
		return facade;
	}	
	
	//ManageContactFacade
	private ManConFacade getManConFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getManConFacade():start");
		
		String jndi = global.getValor("jndi.ManConFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.ManConProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		ManConFacadeHome facadeHome =
			(ManConFacadeHome) PortableRemoteObject.narrow(obj, ManConFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de ManConFacade...");
		ManConFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getManConFacade():end");
		return facade;
	}
	
	//DetermineCustomerOrderFeasibilityFacade
	private DetCusOrdFeaFacade getDetCusOrdFeaFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getDetCusOrdFeaFacade():start");
		
		String jndi = global.getValor("jndi.DetCusOrdFeaFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.DetCusOrdFeaProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getDetCusOrdFeaFacade()():end");
		return facade;
	}
	
	//SupportOrderHandlingFacade
	private SupOrdHanFacade getSupOrdHanFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getSupOrdHanFacade():start");
		
		String jndi = global.getValor("jndi.SupOrdHanFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.SupOrdHanProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		SupOrdHanFacadeHome facadeHome =
			(SupOrdHanFacadeHome) PortableRemoteObject.narrow(obj, SupOrdHanFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de SupOrdHanFacade...");
		SupOrdHanFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getSupOrdHanFacade()():end");
		return facade;
	}
	
//	IssueCustomerOrderFacade
	private IssCusOrdFacade getIssCusOrdFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getIssCusOrdFacade():start");
		
		String jndi = global.getValor("jndi.IssCusOrdFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.IssCusOrdProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		IssCusOrdFacadeHome facadeHome =
			(IssCusOrdFacadeHome) PortableRemoteObject.narrow(obj, IssCusOrdFacadeHome.class);	
		
		
		logger.debug("Recuperada interfaz home de IssCusOrdFacade...");
		IssCusOrdFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getIssCusOrdFacade():end");
		return facade;
	}
	
	/**Obtiene la fachada de ManageCollectionEJBEAR
	 * @return Instancia de la fachada ManColFacade
	 * @throws ManReqException
	 */
	private ManColFacade getManColFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("getManColFacade():start");
		
		String jndi = global.getValor("jndi.ManColFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.ManColProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);

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
		
		ManColFacadeHome facadeHome =
			(ManColFacadeHome) PortableRemoteObject.narrow(obj, ManColFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de ManColFacade...");
		ManColFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getManColFacade()():end");
		return facade;
	}
	
	/**Obtiene la fachada de 
	 * @return Instancia de la fachada 
	 * @throws 
	 */
	private AppPriDisRebFacade getAppPriDisRebFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("getAppPriDisRebFacade():start");
		
		String jndi = global.getValor("jndi.AppPriDisRebFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.AppPriDisRebProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);

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
		
		AppPriDisRebFacadeHome facadeHome =
			(AppPriDisRebFacadeHome) PortableRemoteObject.narrow(obj, AppPriDisRebFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de AppPriDisRebFacade...");
		AppPriDisRebFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getAppPriDisRebFacade():end");
		return facade;
	}
	

//	SupCusIntManFacade
	private SupCusIntManFacade getSupCusIntManFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getSupCusIntManFacade():start");
		
		String jndi = global.getValor("jndi.SupCusIntManFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.SupCusIntManProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		SupCusIntManFacadeHome facadeHome =
			(SupCusIntManFacadeHome) PortableRemoteObject.narrow(obj, SupCusIntManFacadeHome.class);	
		
		
		logger.debug("Recuperada interfaz home de SupCusIntManFacade...");
		SupCusIntManFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getSupCusIntManFacade():end");
		return facade;
	}
	
//	CloCusOrdFacade
	private CloCusOrdFacade getCloCusOrdFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getCloCusOrdFacade():start");
		
		String jndi = global.getValor("jndi.CloCusOrdFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.CloCusOrdProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getCloCusOrdFacade():end");
		return facade;
	}	
	
//	ManCusBilFacade
	private ManCusBilFacade getManCusBilFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getManCusBilFacade():start");
		
		String jndi = global.getValor("jndi.ManCusBilFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.ManCusBilProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		ManCusBilFacadeHome facadeHome =
			(ManCusBilFacadeHome) PortableRemoteObject.narrow(obj, ManCusBilFacadeHome.class);	
		
		
		logger.debug("Recuperada interfaz home de ManCusBilFacade...");
		ManCusBilFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getManCusBilFacade():end");
		return facade;
	}		
	
//	NegSalFacade
	private NegSalFacade getNegSalFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getNegSalFacade():start");
		
		String jndi = global.getValor("jndi.NegSalFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.NegSalProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		NegSalFacadeHome facadeHome =
			(NegSalFacadeHome) PortableRemoteObject.narrow(obj, NegSalFacadeHome.class);	
		
		
		logger.debug("Recuperada interfaz home de NegSalFacade...");
		NegSalFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getNegSalFacade():end");
		return facade;
	}
	
	private ManCusInvFacade getManCusInvFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getManCusInvFacade():start");
		
		String jndi = global.getValor("jndi.ManCusInvFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.ManCusInvProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		ManCusInvFacadeHome facadeHome =
			(ManCusInvFacadeHome) PortableRemoteObject.narrow(obj, ManCusInvFacadeHome.class);	
		
		
		logger.debug("Recuperada interfaz home de ManCusInvFacade...");
		ManCusInvFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getManCusInvFacade():end");
		return facade;
	}

//	 ConsultaFacade	
	private ConsultaFacadeSTL getConsultaFacadeSTL() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getConsultaFacadeSTL():start");
		
		String jndi = global.getValor("jndi.ConsultaFacadeSTL");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.SocketPSEJBEARProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		ConsultaFacadeSTLHome facadeHome =
			(ConsultaFacadeSTLHome) PortableRemoteObject.narrow(obj, ConsultaFacadeSTLHome.class);	
		
		
		logger.debug("Recuperada interfaz home de ConsultaFacadeSTL...");
		ConsultaFacadeSTL facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getConsultaFacadeSTL():end");
		return facade;
	}
	
	private FrmkCargosFacade getFrmkCargosFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getFrmkCargosFacade():start");
		
		String jndi = global.getValor("jndi.FrmkCargosFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.FrmkCargosProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		FrmkCargosFacadeHome facadeHome =
			(FrmkCargosFacadeHome) PortableRemoteObject.narrow(obj, FrmkCargosFacadeHome.class);	
		
		
		logger.debug("Recuperada interfaz home de FrmkCargosFacade...");
		FrmkCargosFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getFrmkCargosFacade():end");
		return facade;
	}
	
	
	//VentasFacadeSTL
	private VentasFacadeSTL getVentasFacade() throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("getVentasFacade():start");

		String jndi = global.getValor("jndi.VentasFacadeSTLFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = global.getValor("url.VentasFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		VentasFacadeSTLHome facadeHome =
			(VentasFacadeSTLHome) PortableRemoteObject.narrow(obj, VentasFacadeSTLHome.class);	
		
		logger.debug("Recuperada interfaz home de VentasFacadeSTL...");
		VentasFacadeSTL facade = null;
		
		try {
			facade = facadeHome.create();
		} 
		catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new ManReqException(e);
		} 
		catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}

		logger.debug("getVentasFacade():end");
		return facade;
	}

	
	/**
	 * Envia Mensaje a cola JMS y ejecuta pl de prueba
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ProyectoException
	 */
	public void ejecutarOrdenServicioJms(ParamRegistroOrdenServicioDTO ordenServicio) throws ManReqException, RemoteException

	{
		AsyncProcessParameterObject paramProceso;
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutarOrdenServicioJms():start");
		
		String sNombreMethodo = new String("ejecutarOrdenServicio:");
		
		logger.info(sNombreMethodo+"star");

			
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto CambioPlanUnificadoCmd");
			paramProceso = new AsyncProcessParameterObject(ordenServicio);
			
			CambioPlanUnificadoOSAsinORC generaQuueeCmd = new CambioPlanUnificadoOSAsinORC(paramProceso);		
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueOrdenServicio());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueOrdenServicio());
				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(FrameworkException e)	{
			logger.debug(sNombreMethodo+"Error al crear mensaje, se procede a modificar estado del proceso a error", e);
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			ManReqException ex = new ManReqException();
			ex.setMessage(e.getMessage());
			throw ex;
		}
		catch(Exception e){
			logger.debug(sNombreMethodo+"Error al crear mensaje, se procede a modificar estado del proceso a error", e);
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			ManReqException ex = new ManReqException();
			ex.setMessage(e.getMessage());
			throw ex;
		}
	
		logger.info(sNombreMethodo+"():end");
	}
	
	/**
	 * Envia Mensaje a cola JMS y ejecuta pl de prueba
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ProyectoException
	 */
	public void ejecutarMantencionProductosOSJms(ParamMantencionProductoDTO paramOServicio) throws ManReqException, RemoteException

	{
		AsyncProcessParameterObject paramProceso;
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutarOrdenServicioJms():start");
		
		String sNombreMethodo = new String("ejecutarOrdenServicio:");
		
		logger.info(sNombreMethodo+"star");

			
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto CambioPlanUnificadoCmd");
			paramProceso = new AsyncProcessParameterObject(paramOServicio);
			
			
			MantencionProductoOSAsinORC generaQuueeCmd = new MantencionProductoOSAsinORC(paramProceso);
			//CambioPlanUnificadoOSAsinORC generaQuueeCmd = new CambioPlanUnificadoOSAsinORC(paramProceso);		
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueOrdenServicio());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueOrdenServicio());
				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear menasje, se procede a modificar estado del proceso a error", e);
		}
	
		logger.info(sNombreMethodo+"():end");
	}
	
	/**
	 * Envia Mensaje a cola JMS y ejecuta pl de prueba
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ProyectoException
	 */
	public void ejecutarMantencionLimiteConsumoOSJms(ParamMantencionLimiteConsumoDTO paramOServicio) throws ManReqException, RemoteException

	{
		AsyncProcessParameterObject paramProceso;
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutarOrdenServicioJms():start");
		
		String sNombreMethodo = new String("ejecutarOrdenServicio:");
		
		logger.info(sNombreMethodo+"star");

			
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto MantencionLimiteConsumoCmd");
			paramProceso = new AsyncProcessParameterObject(paramOServicio);
			
			
			MantencionLimiteConsumoOSAsinORC generaQuueeCmd = new MantencionLimiteConsumoOSAsinORC(paramProceso);
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueOrdenServicio());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueOrdenServicio());
				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear menasje, se procede a modificar estado del proceso a error", e);
		}
	
		logger.info(sNombreMethodo+"():end");
	}
	
	/**
	 * Envia Mensaje a cola JMS y ejecuta pl de prueba
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ProyectoException
	 */
	public void ejecutarAbonoLimiteConsumoOSJms(ParamAbonoLimiteConsumoDTO paramOServicio) throws ManReqException, RemoteException

	{
		AsyncProcessParameterObject paramProceso;
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutarOrdenServicioJms():start");
		
		String sNombreMethodo = new String("ejecutarOrdenServicio:");
		
		logger.info(sNombreMethodo+"star");

			
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto AbonoLimiteConsumoCmd");
			paramProceso = new AsyncProcessParameterObject(paramOServicio);
			
			
			AbonoLimiteConsumoOSAAsinORC generaQuueeCmd = new AbonoLimiteConsumoOSAAsinORC(paramProceso);
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueOrdenServicio());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueOrdenServicio());
				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear menasje, se procede a modificar estado del proceso a error", e);
		}
	
		logger.info(sNombreMethodo+"():end");
	}


	/**
	 * Envia Mensaje a cola JMS y ejecuta pl de prueba
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ManReqException
	 */
	
	public void ejecutarOrdenServicioAbonadoBeneficiarioJms(ParamAbonBenefRegOSDTO ordenServicio) throws ManReqException, RemoteException

	{
		AsyncProcessParameterObject paramProceso;
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutarOrdenServicioAbonadoBeneficiarioJms():start");
		String sNombreMethodo = new String("ejecutarOrdenServicioAbonadoBeneficiarioJms:");
		logger.info(sNombreMethodo+"star");
		
			
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto CambioPlanUnificadoCmd");
			paramProceso = new AsyncProcessParameterObject(ordenServicio);
			
			AbonadoBeneficiarioOSAsinORC generaQuueeCmd = new AbonadoBeneficiarioOSAsinORC(paramProceso);		
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueOrdenServicio());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueOrdenServicio());
				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear mensaje, se procede a modificar estado del proceso a error", e);
		}
	
		logger.info(sNombreMethodo+"():end");
	}
	
	/**
	 * Envia Mensaje a cola JMS y ejecuta pl de prueba
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ManReqException
	 */
	
	public void ejecutarOrdenServicioAbonadoVetadoJms(ParamAbonVetadoRegOSDTO ordenServicio) throws ManReqException, RemoteException

	{
		AsyncProcessParameterObject paramProceso;
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutarOrdenServicioAbonadoVetadoJms():start");
		String sNombreMethodo = new String("ejecutarOrdenServicioAbonadoBeneficiarioJms:");
		logger.info(sNombreMethodo+"start");
		
			
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto AbonadoVetadoCmd");
			paramProceso = new AsyncProcessParameterObject(ordenServicio);
			
			AbonadoVetadoOSAsinORC generaQuueeCmd = new AbonadoVetadoOSAsinORC(paramProceso);		
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueOrdenServicio());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueOrdenServicio());
				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear mensaje, se procede a modificar estado del proceso a error", e);
		}
	
		logger.info(sNombreMethodo+"():end");
	}
	
	/**
	 * @author rlozano
	 * @description  Lista Abonados por código de cliente indicando condicion vetado S/N
	 */
	public AbonadoVetadoListDTO obtieneAbonadosVetados(AbonadoDTO abonadoDTO)throws ManReqException{
		AbonadoVetadoListDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtieneAbonadosVetados():start");
		try {
			retValue= getManConFacade().obtieneAbonadosVetados(abonadoDTO);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtieneAbonadosVetados():end");
		return retValue;
		
	}
	
	/**
	 * Envia Mensaje a cola JMS y ejecuta pl de prueba
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ProyectoException
	 */
	
	public void ejecutarMantencionFrecuentesOSJms(ParamMantencionFrecuentesDTO paramOServicio) throws ManReqException, RemoteException

	{
		AsyncProcessParameterObject paramProceso;
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutarOrdenServicioJms():start");
		
		String sNombreMethodo = new String("ejecutarOrdenServicio:");
		
		logger.info(sNombreMethodo+"star");

			
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto ParamMantencionFrecuentesDTO");
			paramProceso = new AsyncProcessParameterObject(paramOServicio);
			
			logger.debug("ENVIANDO "+ paramOServicio.getNumeroListAdd().getNumerosDTO().length+" NUMEROS FRECUENTES  A ENCOLAR A AGREGAR");
			logger.debug("ENVIANDO "+ paramOServicio.getNumeroListDel().getNumerosDTO().length+" NUMEROS FRECUENTES  A ENCOLAR A ELIMINAR");
			MantencionFrecuentesOSAsinORC generaQuueeCmd = new MantencionFrecuentesOSAsinORC(paramProceso);
			//CambioPlanUnificadoOSAsinORC generaQuueeCmd = new CambioPlanUnificadoOSAsinORC(paramProceso);		
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueOrdenServicio());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueOrdenServicio());
			
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.debug(sNombreMethodo+"Error al crear menasje, se procede a modificar estado del proceso a error", e);
		}
	
		logger.info(sNombreMethodo+"():end");
	}


	public void ejecutarOrdenServicioAfinesOSJms(ParamMantencionAfinesDTO paramOServicio) throws ManReqException, RemoteException

	{
		AsyncProcessParameterObject paramProceso;
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutarOrdenServicioJms():start");
		
		String sNombreMethodo = new String("ejecutarOrdenServicio:");
		
		logger.info(sNombreMethodo+"star");

			
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto ParamMantencionAfinesDTO");
			paramProceso = new AsyncProcessParameterObject(paramOServicio);
							
			MantencionAfinesOSAsinORC generaQuueeCmd = new MantencionAfinesOSAsinORC(paramProceso);
			
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueOrdenServicio());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueOrdenServicio());
			
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.debug(sNombreMethodo+"Error al crear mensaje, se procede a modificar estado del proceso a error", e);
		}
	
		logger.info(sNombreMethodo+"():end");
	}
	
	public void ejecutarRegistroOrden(ParamMantencionProductoDTO param) throws ManReqException{
		RetornoDTO retorno = null;
		RegistroNivelOOSSDTO registroNivel = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		CloCusOrdFacade cloCusOrdFacade = null;
		logger.debug("ejecutarRegistroOrden():start");
		try{
			
			registroNivel = new RegistroNivelOOSSDTO();
			registroNivel.setNumAbonado(param.getAbonado().getNumAbonado());
			registroNivel.setCodCliente(param.getCliente().getCodCliente());
			registroNivel.setCodTipMod(param.getCodActAbo());
			registroNivel.setTipSujeto(param.getSujeto());
			logger.debug("registraNivelOoss() :inicio");
			cloCusOrdFacade = getCloCusOrdFacade();
			retorno = cloCusOrdFacade.registraNivelOoss(registroNivel);
			logger.debug("registraNivelOoss() :fin");
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}
		catch (CloCusOrdException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");	
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
			
			logger.debug("registrarOOSSEnLinea() :inicio");
			retorno = cloCusOrdFacade.registrarOOSSEnLinea(registroLinea);
			logger.debug("registrarOOSSEnLinea() :fin");
		}catch (CloCusOrdException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");	
		}
		logger.debug("ejecutarRegistroOrden(): end");
		
	}
	
	/**
	 * Obtiene informacion del cliente
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ProyectoException
	 */
	
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws ManReqException{
		ClienteDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosCliente():start");
		try {
			resultado = getManConFacade().obtenerDatosCliente(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDatosCliente():end");
		return resultado;
		
	}
	
	/**
	 * Obtiene datos de cliente por venta
	 * 
	 * @param cliente
	 * @return ClienteTipoPlanListDTO
	 * @throws ManConException 
	 * @throws ManReqException 
	 * @throws ProyectoException
	 */
	public ClienteDTO obtenerDatosCliente(
			VentaDTO venta) throws  ManConException, ManReqException{	
	
		ClienteDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosClienteCuenta():start");
		
			try {
				resultado = getManConFacade().obtenerDatosCliente(venta);
			} catch(ManReqException e){
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ManReqException[" + loge + "]");
				throw e;
			}catch(ManConException e){
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ManConException[" + loge + "]");
				throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + loge + "]");
				throw new ManReqException(e);
			}
		
		
		logger.debug("obtenerDatosClienteCuenta():end");
		return resultado;
	}

	/**
	 * Obtiene informacion del abonado
	 * 
	 * @param abonado
	 * @return AbonadoDTO
	 * @throws ProyectoException
	 */
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws ManReqException{
		AbonadoDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosAbonado():start");
		try {
			resultado = getManConFacade().obtenerDatosAbonado(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDatosAbonado():end");
		return resultado;
	}

	/**
	 * Obtiene informacion del abonado2 (completa info del cliente, inc 125478)
	 * 
	 * @param abonado
	 * @return AbonadoDTO
	 * @throws ProyectoException
	 */
	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws ManReqException{
		AbonadoDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosAbonado2():start");
		try {
			resultado = getManConFacade().obtenerDatosAbonado2(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDatosAbonado2():end");
		return resultado;
	}
	
	/**
	 * Obtiene lista de abonados
	 * 
	 * @param cliente
	 * @return AbonadoListDTO
	 * @throws ProyectoException
	 */
	
	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente) throws ManReqException{	
	
		AbonadoListDTO abonados = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerListaAbonados():start");
		try {
			abonados = getManConFacade().obtenerListaAbonados(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerListaAbonados():end");
		return abonados;
	}

	public RetornoDTO aplicarRestricciones(ClienteOSSesionDTO sessionData, AbonadoDTO abonado) throws GeneralException {
		/***
		 * @author rlozano
		 * @description Se invoca método para validación y verificación de datos :  PL de Restricciones
		 * @date 24-12-2008
		 */
		RetornoDTO retorno = new RetornoDTO();
		
		SecuenciaDTO secuencia = new SecuenciaDTO();
		secuencia.setNomSecuencia("CI_SEQ_NUMOS");
		secuencia = obtenerSecuencia(secuencia);
		long numOOSS =  secuencia.getNumSecuencia();
		
		
		//(+) EV 12/01/09
		SecuenciaDTO secuenciaTransacabo = new SecuenciaDTO();
		secuenciaTransacabo.setNomSecuencia("GA_SEQ_TRANSACABO");
		secuenciaTransacabo = obtenerSecuencia(secuenciaTransacabo);
		long numSeqTransacabo =  secuenciaTransacabo.getNumSecuencia();
		//(-) EV 12/01/09
		
		String usuarioOra ="";
		
		//obtiene usuario
		UsuarioDTO usuario = new UsuarioDTO();
		usuario.setNombre(sessionData.getUsuario());
		usuario = obtenerVendedor(usuario);
		
		ClienteDTO cliente = sessionData.getCliente();
		
		long numAbonado;
		long codCliente;
		long numVenta;
		int codUso;
		long codCuentaOrigen;
		long codCuentaDestino;
		String tipoPlan;
		long numCiclo;
		int codCentral;
		long idSecuencia = numOOSS;
		String codActuacion;
		String codOOS = ""+sessionData.getCodOrdenServicio();
		String codVendedor = ""+usuario.getCodigo();
		String planDestino = ""; //EV 30/04/09 inc 87696
		
		if(sessionData.getNumAbonado() != 0){
			numAbonado = abonado.getNumAbonado();
			codCliente = abonado.getCodCliente();
			numVenta   = abonado.getNumVenta();
			codUso     = Integer.parseInt(abonado.getCodUso());
			codCuentaOrigen  = abonado.getCodCuenta();
			codCuentaDestino = abonado.getCodCuenta();
			tipoPlan = abonado.getCodTipoPlanTarif();
			numCiclo = abonado.getCodCiclo();
			codCentral = abonado.getCodCentral();
			codActuacion = global.getValor("cod.act.ooss.abo");
			planDestino = abonado.getCodPlanTarif(); //EV 30/04/09 inc 87696
		}
		else
		{
			//cliente = sessionData.getCliente();
			numAbonado = 0;
			codCliente = cliente.getCodCliente();
			numVenta   = idSecuencia;//abonado.getNumVenta();
			codUso     = -1;
			codCuentaOrigen  = cliente.getCodCuenta();
			codCuentaDestino = cliente.getCodCuenta();
			tipoPlan = cliente.getCodTipoPlanTarif();
			numCiclo = cliente.getCodCiclo();
			codCentral = -1;
			codActuacion = global.getValor("cod.act.ooss.cli");
		}

		RestriccionesDTO restriccionesDTO = new RestriccionesDTO();
		restriccionesDTO.setNumAbonado(numAbonado);
		restriccionesDTO.setCodCliente(codCliente);
		restriccionesDTO.setNumVenta(numVenta);
		restriccionesDTO.setCodUso(codUso);
		restriccionesDTO.setCodCuentaOrigen(codCuentaOrigen);
		restriccionesDTO.setCodCuentaDestino(codCuentaDestino);
		restriccionesDTO.setTipoPlan(tipoPlan);
		restriccionesDTO.setNumCiclo(numCiclo);
		restriccionesDTO.setCodCentral(codCentral);
		//restriccionesDTO.setIdSecuencia(idSecuencia);    //EV
		restriccionesDTO.setIdSecuencia(numSeqTransacabo); //EV
		restriccionesDTO.setCodActuacion(codActuacion);
		restriccionesDTO.setCodOOSS(codOOS);
		restriccionesDTO.setCodVendedor(codVendedor);
		restriccionesDTO.setPlanDestino(planDestino); //EV 30/04/09 inc 87696
		retorno = aplicaPLRestricciones(restriccionesDTO);
		return retorno;
	}
	
	public RetornoDTO aplicaPLRestricciones(RestriccionesDTO restricciones)throws GeneralException{
		RetornoDTO retornoDTO=null;
		
		
		try{
		    restricciones.setPrograma("GPA");
		    restricciones.setProceso("");
		    restricciones.setCodModGener("OSF");
		    restricciones.setCodOOSS(restricciones.getCodOOSS());
		    restricciones.setDesactivacionSS(0);
		   // restricciones.setPlanDestino("");
		    restricciones.setTipoPlanDestino("");
		    restricciones.setFechaSistema(new Date());
		    restricciones.setCodTarea(0);
		    restricciones.setCodModulo(global.getValor("codigo.modulo.GA"));
		    restricciones.setCodEvento(global.getValor("codigo.evento.siguiente").trim());
		    restricciones.setCodPrograma("1");
		    
		    // Iterar por cada elemento del mapa de abonados
		    logger.debug("validaRestriccionComerOoss:inicio,abonado="+restricciones.getNumAbonado());
		    retornoDTO = getDetCusOrdFeaFacade().validaRestriccionComerOoss(restricciones);
			
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
	 * Obtiene lista de planes tarifarios
	 * 
	 * @param param
	 * @return PlanTarifarioListDTO
	 * @throws ProyectoException
	 */
	public PlanTarifarioListDTO obtenerPlanesTarifarios(
			BusquedaPlanTarifarioDTO param) throws ManReqException{	
	
		PlanTarifarioListDTO planes = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerPlanesTarifarios():start");
		try {
			planes = getManProOffInvFacade().obtenerPlanesTarifarios(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManProOffInvException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManProOffInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerPlanesTarifarios():end");
		return planes;
	}	
	
	/**
	 * Obtiene lista de clientes cuenta
	 * 
	 * @param cliente
	 * @return ClienteTipoPlanListDTO
	 * @throws ProyectoException
	 */
	public ClienteTipoPlanListDTO obtenerDatosClienteCuenta(
			ClienteDTO cliente) throws ManReqException{	
	
		ClienteTipoPlanListDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosClienteCuenta():start");
		try {
			resultado = getManConFacade().obtenerDatosClienteCuenta(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDatosClienteCuenta():end");
		return resultado;
	}	
	/**
	 * Obtiene lista de subcuentas de cuenta
	 * 
	 * @param param
	 * @return PlanTarifarioListDTO
	 * @throws ProyectoException
	 */
	public SubCuentaListDTO obtenerSubCuentas(ClienteDTO cliente) throws ManReqException{	
	
		SubCuentaListDTO subcuentas = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerSubCuentas():start");
		try {
			subcuentas = getManConFacade().obtenerSubCuentas(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerSubCuentas():end");
		return subcuentas;
	}
	/**
	 * Obtiene parametros de conversion OOSS
	 * 
	 * @param param
	 * @return ConversionDTO
	 * @throws ProyectoException
	 */
	public ConversionListDTO obtenerConversionOOSS(ConversionDTO param) throws ManReqException{	
	
		ConversionListDTO conversionList = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerConversionOOSS():start");
		try {
			conversionList = getSupOrdHanFacade().obtenerConversionOOSS(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			logger.debug("e.getMessage() :"+e.getMessage());
			logger.debug("e.getDescripcionEvento():"+e.getDescripcionEvento());
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerConversionOOSS():end");
		return conversionList;
	}
	/**
	 * Obtiene saldo
	 * 
	 * @param consulta
	 * @return SaldoDTO
	 * @throws ProyectoException
	 */
	/*public SaldoDTO consultaSaldo(SaldoDTO consulta) throws ManReqException{	
	
		SaldoDTO parametros = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultaSaldo():start");
		try {
			parametros = getIssCusOrdFacade().consultaSaldo(consulta);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("consultaSaldo():end");
		return parametros;
	}*/
	

	/**
	 * Consulta saldo
	 * 
	 * @param consultaSaldo
	 * @return SaldoDTO
	 * @throws ManReqException
	 */
	public SaldoDTO consultaSaldo(ConsultaSaldoDTO consultaSaldo) throws ManReqException{
		SaldoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultaSaldo():start");
		try {
			retorno = getConsultaFacadeSTL().consultaSaldo(consultaSaldo);
			
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SocketPSException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SocketPSException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("consultaSaldo():end");
		return retorno;		
	}	
	
	/**
	 * consulta prepago para combinatorio PREPAGOPREPAGO
	 * 
	 * @param consulta
	 * @return RetornoDTO
	 * @throws ProyectoException
	 */
	public RetornoDTO consultaPrepago(ConsultaPrepagosDTO consulta) throws ManReqException{	
	
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultaPrepago():start");
		try {
			retorno = getIssCusOrdFacade().consultaPrepago(consulta);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("consultaPrepago():end");
		return retorno;
	}
	
	/**
	 * Obtiene secuencia
	 * 
	 * @param secuencia
	 * @return SecuenciaDTO
	 * @throws ProyectoException
	 */
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO parametro) throws ManReqException{	
	
		SecuenciaDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerSecuencia():start");
		try {
			resultado = getSupOrdHanFacade().obtenerSecuencia(parametro);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerSecuencia():end");
		return resultado;
	}
	
	/**
	 * Obtiene parametro general
	 * 
	 * @param param
	 * @return ParametroDTO
	 * @throws ProyectoException
	 */
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws ManReqException{	
	
		ParametroDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerParametroGeneral():start");
		try {
			resultado = getSupOrdHanFacade().obtenerParametroGeneral(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerParametroGeneral():end");
		return resultado;
	}
	
	/**
	 * Obtiene parametro simple
	 * 
	 * @param param
	 * @return ParametroDTO
	 * @throws ManReqException
	 */
	public ParametroDTO obtenerParametrosSimples(ParametroDTO param) throws ManReqException{	
	
		ParametroDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerParametrosSimples():start");
		try {
			resultado = getSupOrdHanFacade().obtenerParametrosSimples(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerParametrosSimples():end");
		return resultado;
	}
	
	/**
	 * Valida restriccion comercial OS
	 * 
	 * @param restricciones
	 * @return RestriccionesDTO
	 * @throws ManReqException
	 */
	public RetornoDTO validaRestriccionComerOoss(RestriccionesDTO restricciones) throws ManReqException{	
	
		RetornoDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaRestriccionComerOoss():start");
		try {
			resultado = getDetCusOrdFeaFacade().validaRestriccionComerOoss(restricciones);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(DetCusOrdFeaException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("DetCusOrdFeaException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validaRestriccionComerOoss():end");
		return resultado;
	}
	
	/**
	 * Obtiene datos cambio de plan
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public AbonadoDTO obtenerDatosCambPlanServ(AbonadoDTO abonado) throws ManReqException{	
	
		AbonadoDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosCambPlanServ():start");
		try {
			resultado = getSupOrdHanFacade().obtenerDatosCambPlanServ(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDatosCambPlanServ():end");
		return resultado;
	}

	public FormaPagoListDTO obtenerFromasPago(BusquedaFormasPagoDTO formaPago) throws ManReqException{
		
		FormaPagoListDTO formaPagoList = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerFromasPago():start");
			try {
				formaPagoList = getManColFacade().obtenerFormasPago(formaPago);
			} catch (ManColException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ManColException[" + loge + "]");
				throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + loge + "]");
				throw new ManReqException(e);
			}
		logger.debug("obtenerFromasPago():end");
		
		return formaPagoList;
	}
	
	public DocumentoListDTO obtenerTiposDocumento(BusquedaTiposDocumentoDTO tipoDocumento) throws ManReqException{
		DocumentoListDTO documentoList = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTiposDocumento():start");
			try {
				documentoList = getManColFacade().obtenerTiposDocumentos(tipoDocumento);
			} catch (ManColException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ManColException[" + loge + "]");
				throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + loge + "]");
				throw new ManReqException(e);
			}
		logger.debug("obtenerTiposDocumento():end");
		return documentoList;
	}
	
	public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws ManReqException{
		RetornoDTO retorno= null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("eliminarSolicitud():start");
		try {
			retorno = getAppPriDisRebFacade().eliminarSolicitud(registro);
		} catch (AppPriDisRebException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		
		logger.debug("eliminarSolicitud():end");
		return retorno;
	}
	
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws ManReqException{
		RetornoDTO retorno= null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("eliminarPresupuesto():start");
		try {
			retorno = getAppPriDisRebFacade().eliminarPresupuesto(registro);
		} catch (AppPriDisRebException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("eliminarPresupuesto[" + loge + "]");
			throw new ManReqException(e);
		}
		
		logger.debug("eliminarSolicitud():end");
		return retorno;
	}
	
	public CuotasProductoDTO[] obtenerCuotasProducto() throws ManReqException{
		CuotasProductoDTO[] cuotasProducto = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCuotasProducto():start");
			try {
				cuotasProducto = getManColFacade().obtenerCuotasProducto();
			} catch (ManColException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ManColException[" + loge + "]");
				throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + loge + "]");
				throw new ManReqException(e);
			}
		logger.debug("obtenerCuotasProducto():end");
		return cuotasProducto;
	}
	
	
	/**
	 * Obtiene cargos
	 * 
	 * @param parametrosCargos
	 * @return ParametrosObtencionCargosDTO
	 * @throws ManReqException
	 */
	/*
	public ObtencionCargosDTO obtencionCargos(ParametrosObtencionCargosDTO parametrosCargos) throws ManReqException{	
	
		ObtencionCargosDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtencionCargos():start");
		try {
			resultado = getAppPriDisRebFacade().obtenerCargos(parametrosCargos);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(AppPriDisRebException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtencionCargos():end");
		return resultado;
	}
	*/
	
	public ObtencionCargosDTO obtencionCargos(com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ParametrosObtencionCargosDTO parametrosCargos) throws ManReqException{
		com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO resultado = new com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO();
		MapperIF mapper = new DozerBeanMapper();
		com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO paramCargosFrmk = new com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO();
    	mapper.map(parametrosCargos, paramCargosFrmk);
    	String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtencionCargos():start");
		
	    try {
	    	MapperIF mapper2 = new DozerBeanMapper();
	    	com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO obtCargosFrmk = new com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO();
	    	obtCargosFrmk = getFrmkCargosFacade().obtenerCargos(paramCargosFrmk);
	    	mapper2.map(obtCargosFrmk, resultado);
	    }catch(ManReqException e){
	    	String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
	    }catch(RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
	    }catch (FrmkCargosException e) {
	    	String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("FrmkCargosException[" + loge + "]");
			String msg  = ((GeneralException) e.getCause()).getDescripcionEvento();//msg antes-->e.getMessage();pv 080808
			if( msg == null)
			{
				msg = obtenerMensaje(e);
			}
			logger.debug("FrmkCargosException[" + msg + "]");
			throw new ManReqException(msg, e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	    }
	    logger.debug("obtencionCargos():end");	
		return resultado;
	}

	private String obtenerMensaje(FrmkCargosException e) {
		String msg = null;
		if( e instanceof FrmkCargosException)
		{
			logger.debug(" exception instanceof FrmkCargosException");
			try
			{
				GeneralException genExc = (GeneralException)e;
				msg = genExc.getDescripcionEvento();
				if(msg == null)
				{   //if( fe instanceof FrameworkCargosException)System.out.println(" fe instanceof FrameworkCargosException");
					if( genExc.getCause() instanceof FrameworkCargosException)
					{
						logger.debug(" fe.getCause() instanceof FrameworkCargosException");
						FrameworkCargosException frameCarExc = (FrameworkCargosException)genExc.getCause();
						msg = frameCarExc.getDescripcionEvento();
						if(msg == null)
						{
							GeneralException genExc2 = (GeneralException)frameCarExc.getCause();
							msg = genExc2.getDescripcionEvento();
						}
					}
					else if(genExc.getCause() instanceof FrmkCargosException){
						logger.debug(" fe.getCause() instanceof FrmkCargosException");
						FrmkCargosException frameCarExc = (FrmkCargosException)genExc.getCause();
						msg = frameCarExc.getDescripcionEvento();
						if(msg == null)
						{
							GeneralException genExc2 = (GeneralException)frameCarExc.getCause();
							msg = genExc2.getDescripcionEvento();
							
							if (msg == null){
								GeneralException genExc3 = (GeneralException)genExc2.getCause();
								msg = genExc3.getDescripcionEvento();
							}
						}
						
					}
				}
			}
			catch(Exception e2)
			{
				e.printStackTrace();
			}
		}
		logger.debug(" obtenerMensaje ["+msg+"]");
		return msg;
	}
	
	
	
	
	/**
	 * Obtiene los parametros generales
	 * 
	 * @param 
	 * @return ParametroListDTO
	 * @throws ManReqException
	 */
	public ParametroListDTO obtenerParametrosGenerales() throws ManReqException{
	
		ParametroListDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerParametrosGenerales():start");
		try {
			resultado = getSupOrdHanFacade().obtenerParametrosGenerales();
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerParametrosGenerales():end");
		return resultado;
	}
	
	
	/**
	 * Valida orden de servicio
	 * 
	 * @param ordenServicio
	 * @return ValidaOOSSDTO
	 * @throws ManReqException
	 */
	
	public ValidaOOSSDTO validaOossPendPlan(ValidaOOSSDTO ordenServicio) throws ManReqException{
	
		ValidaOOSSDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaOossPendPlan():start");
		try {
			resultado = getDetCusOrdFeaFacade().validaOossPendPlan(ordenServicio);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(DetCusOrdFeaException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("DetCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validaOossPendPlan():end");
		return resultado;
	}	
	
	
	/**
	 * Anula ordenes de servicio pendientes
	 * 
	 * @param ordenServicio
	 * @return ValidaOOSSDTO
	 * @throws ManReqException
	 */
	public IOOSSDTO anulaOossPendPlan(IOOSSDTO ordenServicio) throws ManReqException{
	
		IOOSSDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("anulaOossPendPlan():start");
		try {
			resultado = getSupOrdHanFacade().anulaOossPendPlan(ordenServicio);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("anulaOossPendPlan():end");
		return resultado;
	}
	
	/**
	 * Anula ordenes de servicio pendientes
	 * 
	 * @param ordenServicio
	 * @return ValidaOOSSDTO
	 * @throws ManReqException
	 */
	public IOOSSDTO anulaOossPendPlan(IOOSSDTO[] ordenServicioArr) throws ManReqException{
	
		IOOSSDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("anulaOossPendPlan():start");
		try {
			resultado = getSupOrdHanFacade().anulaOossPendPlan(ordenServicioArr);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("anulaOossPendPlan():end");
		return resultado;
	}	
	
	/**
	 * Obtiene solicitudes cambio plan pendiente
	 * 
	 * @param cliente
	 * @return CambioPlanPendienteListDTO
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	public CambioPlanPendienteListDTO obtenerSolicPendPlan(ClienteDTO cliente) throws ManReqException{
	
		CambioPlanPendienteListDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerSolicPendPlan():start");
		try {
			retorno = getCloCusOrdFacade().obtenerSolicPendPlan(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch (CloCusOrdException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		logger.debug("obtenerSolicPendPlan():end");
		return retorno;
	}
	
	/**
	 * Obtiene fecha ciclo
	 * 
	 * @param ciclo
	 * @return CicloDTO
	 * @throws ManReqException
	 */
	public CicloDTO obtenerFechaCiclo(CicloDTO ciclo) throws ManReqException{
	
		CicloDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerFechaCiclo():start");
		try {
			resultado = getDetCusOrdFeaFacade().obtenerFechaCiclo(ciclo);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(DetCusOrdFeaException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("DetCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerFechaCiclo():end");
		return resultado;
	}	
	
	/**
	 * Valida plan freedom
	 * 
	 * @param cliente
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO validaFreedom(ClienteDTO cliente) throws ManReqException{
	
		RetornoDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaFreedom():start");
		try {
			resultado = getDetCusOrdFeaFacade().validaFreedom(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(DetCusOrdFeaException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("DetCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validaFreedom():end");
		return resultado;
	}	
	
	/**
	 * Obtiene ciclo freedom
	 * 
	 * @param plan
	 * @return PlanCicloDTO
	 * @throws ManReqException
	 */
	public PlanCicloDTO obtenerCicloFreedom(PlanCicloDTO plan) throws ManReqException{
	
		PlanCicloDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCicloFreedom():start");
		try {
			resultado = getSupOrdHanFacade().obtenerCicloFreedom(plan);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerCicloFreedom():end");
		return resultado;
	}	
		
	
	/**
	 * Valida cuenta personal
	 * 
	 * @param cuenta
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO validaCuentaPersonal(CuentaPersonalDTO cuenta) throws ManReqException{
	
		RetornoDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaCuentaPersonal():start");
		try {
			resultado = getSupCusIntManFacade().validaCuentaPersonal(cuenta);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupCusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validaCuentaPersonal():end");
		return resultado;
	}	
	
	/**
	 * Obtiene categoria plan
	 * 
	 * @param plan
	 * @return PlanTarifarioDTO
	 * @throws ManReqException
	 */
	public PlanTarifarioDTO obtenerCategPlan(PlanTarifarioDTO plan) throws ManReqException{
	
		PlanTarifarioDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCategPlan():start");
		try {
			resultado = getSupOrdHanFacade().obtenerCategPlan(plan);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerCategPlan():end");
		return resultado;
	}	
	
	
	/**
	 * Elimina promocion
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO eliminarPromocion(EliminaPromocionDTO param) throws ManReqException{	
	
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("eliminarPromocion():start");
		try {
			retorno = getIssCusOrdFacade().eliminarPromocion(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("eliminarPromocion():end");
		return retorno;
	}
	
	/**
	 * Obtiene info de plan en Atlantida
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO obtenerPlanAtlantida(AbonadoDTO abonado) throws ManReqException{	
	
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerPlanAtlantida():start");
		try {
			retorno = getIssCusOrdFacade().obtenerPlanAtlantida(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerPlanAtlantida():end");
		return retorno;
	}
	
	/**
	 * Obtener valor calculado
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ManReqException
	 */
	public ClienteDTO obtenerValorCalculado(ClienteDTO cliente) throws ManReqException{	
	
		ClienteDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerValorCalculado():start");
		try {
			retorno = getSupOrdHanFacade().obtenerValorCalculado(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerValorCalculado():end");
		return retorno;
	}
	
	/**
	 * Obtiene tipo numero
	 * 
	 * @param numero
	 * @return NumeroDTO
	 * @throws ManReqException
	 */
	public NumeroDTO obtenerTipoNumero(NumeroDTO parametro) throws ManReqException{	
	
		NumeroDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerSecuencia():start");
		try {
			resultado = getSupCusIntManFacade().obtenerTipoNumero(parametro);//getSupOrdHanFacade().obtenerSecuencia(parametro);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupCusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupCusIntManException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerTipoNumero():end");
		return resultado;
	}
	
	/**
	 * Obtiene datos del vendedor
	 * 
	 * @param usuario
	 * @return UsuarioDTO
	 * @throws ManReqException
	 */
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws ManReqException{	
	
		UsuarioDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerVendedor():start");
		try {
			resultado = getSupOrdHanFacade().obtenerVendedor(usuario);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerVendedor():end");
		return resultado;
	}	
	/**
	 * Valida permanencia para optar a un prepago
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws ManReqException
	 */		
	public RetornoDTO validaPermanencia(ValidaPermanenciaDTO param) throws ManReqException{
		
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaPermanencia():start");
		try {
			retorno = getCloCusOrdFacade().validaPermanencia(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(CloCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validaPermanencia():end");
		return retorno;		
	}

	
	/**
	 * Obtiene campo fec_cumplan de GA_ABOCEL
	 * 
	 * @param abonado
	 * @return GaAbocelDTO
	 * @throws ManReqException
	 */		
	public GaAbocelDTO obtenerFecCumPlan(GaAbocelDTO abonado) throws ManReqException{
		
		GaAbocelDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerFecCumPlan():start");
		try {
			retorno = getSupOrdHanFacade().obtenerFecCumPlan(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerFecCumPlan():end");
		return retorno;		
	}
	/**
	 * Obtiene el cargo actual
	 * 
	 * @param cliente
	 * @return CargoClienteDTO
	 */
	public CargoClienteDTO obtenerCargoBasicoActual(CargoClienteDTO cliente) throws ManReqException{
		CargoClienteDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCargoBasicoActual():start");
		try {
			retorno = getSupOrdHanFacade().obtenerCargoBasicoActual(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerCargoBasicoActual():end");
		return retorno;		
	}
	
	/**
	 * Anula bolsa dinamica
	 * 
	 * @param bolsa
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO anularCargoBolsaDinamica(BolsaDinamicaDTO bolsa) throws ManReqException{
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("anularCargoBolsaDinamica():start");
		try {
			retorno = getSupOrdHanFacade().anularCargoBolsaDinamica(bolsa);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("anularCargoBolsaDinamica():end");
		return retorno;		
	}
	
	/**
	 * Validar portabilidad
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO validarPortabilidad(AbonadoDTO abonado) throws ManReqException{
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarPortabilidad():start");
		try {
			retorno = getSupOrdHanFacade().validarPortabilidad(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarPortabilidad():end");
		return retorno;		
	}	

	/**
	 * Valida periodo facturacion
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO validarPeriodoFact(AbonadoDTO abonado) throws ManReqException{
	
		RetornoDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarPeriodoFact():start");
		try {
			resultado = getDetCusOrdFeaFacade().validarPeriodoFact(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(DetCusOrdFeaException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("DetCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarPeriodoFact():end");
		return resultado;
	}	

	/**
	 * Valida servicios duplicados
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO validarServiciosDuplicados(AbonadoDTO abonado) throws ManReqException{
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarServiciosDuplicados():start");
		try {
			retorno = getSupOrdHanFacade().validarServiciosDuplicados(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarServiciosDuplicados():end");
		return retorno;		
	}
	
	/**
	 * Obtiene actAbo homologo de abonado
	 * 
	 * @param param
	 * @return ConvertActAboDTO
	 * @throws ManReqException
	 */
	public ConvertActAboDTO obtenerConverActAbo(ConvertActAboDTO param) throws ManReqException{
		ConvertActAboDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerConverActAbo():start");
		try {
			retorno = getSupOrdHanFacade().obtenerConverActAbo(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerConverActAbo():end");
		return retorno;		
	}	
	
	/**
	 * Obtiene Causa de baja
	 * 
	 * @param 
	 * @return CausaBajaListDTO
	 * @throws ManReqException
	 */
	public CausaBajaListDTO obtenerCausaBaja() throws ManReqException{	
	
		CausaBajaListDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCausaBaja():start");
		try {
			resultado = getSupOrdHanFacade().obtenerCausaBaja();
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerCausaBaja():end");
		return resultado;
	}	
	/**
	 * Obtiene ruta donde se encuentra la factura
	 * @param factura
	 * @return
	 * @throws ManReqException
	 */
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws ManReqException{
		ArchivoFacturaDTO retorno = null;
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerRutaFactura():start");
		try {			
			retorno = getSupOrdHanFacade().obtenerRutaFactura(factura);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerRutaFactura():end");
		return retorno;		
	}	
	
	
	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws ManReqException{
		CartaGeneralDTO retorno = null;

		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTextoCarta():start");
		try {			
			retorno = getSupOrdHanFacade().obtenerTextoCarta(cartaGeneral);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerTextoCarta():end");
		return retorno;		
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * Obtiene información de descuentos asociada a los privilegios de un vendedor
	 * @param vendedor
	 * @return
	 * @throws ManReqException
	 */
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor)throws ManReqException{
		DescuentoVendedorDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDescuentoVendedor():start");
		try {
			retorno = getSupOrdHanFacade().obtenerDescuentoVendedor(vendedor);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDescuentoVendedor():end");
		return retorno;		
	}	
	
	/**
	 * Inserta solicitud de autorización de descuento, para cargos que exceden el máximo
	 * descuento permitido
	 * @param registro
	 * @return
	 * @throws ManReqException
	 */
	public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro) throws ManReqException{	
		RespuestaSolicitudDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("solicitarAprobacionDescuento():start");
		try {
			retorno = getAppPriDisRebFacade().solicitarAprobacionDescuento(registro);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(AppPriDisRebException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("solicitarAprobacionDescuento():end");
		return retorno;		
	}
	/**
	 * Consulta estado de solicitud de autorización de descuento
	 * @param registro
	 * @return
	 * @throws ManReqException
	 */
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro)	 throws ManReqException{	
		RegistroSolicitudDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultarEstadoSolicitud():start");
		try {
			retorno = getAppPriDisRebFacade().consultarEstadoSolicitud(registro);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(AppPriDisRebException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("consultarEstadoSolicitud():end");
		return retorno;		
	}
	/**
	 * Obtener penalizacion
	 * 
	 * @param param
	 * @return PenalizacionDTO
	 * @throws ManReqException
	 */
	public PenalizacionDTO obtenerPenalizacion(PenalizacionDTO param) throws ManReqException{
		PenalizacionDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerPenalizacion():start");
		try {
			retorno = getSupOrdHanFacade().obtenerPenalizacion(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerPenalizacion():end");
		return retorno;		
	}
	
	/**
	 * Obtener rango de antiguedad
	 * 
	 * @param param
	 * @return RangoAntiguedadDTO
	 * @throws ManReqException
	 */
	public RangoAntiguedadDTO obtenerRangoAntiguedad(RangoAntiguedadDTO param) throws ManReqException{
		RangoAntiguedadDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerRangoAntiguedad():start");
		try {
			retorno = getSupOrdHanFacade().obtenerRangoAntiguedad(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerRangoAntiguedad():end");
		return retorno;		
	}
	
	/**
	 * Construir registro de cargos
	 * 
	 * @param cargos
	 * @return RegCargosDTO
	 * @throws ManReqException
	 */
	/*
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO cargos) throws ManReqException{
		RegCargosDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("construirRegistroCargos():start");
		try {
			retorno = getManCusBilFacade().construirRegistroCargos(cargos);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManCusBilException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManCusBilException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("construirRegistroCargos():end");
		return retorno;		
	}	
	*/
	
	public RegCargosDTO construirRegistroCargos (com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO cargos) throws ManReqException {
		com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO retorno = new com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO();
		MapperIF mapper = new DozerBeanMapper();
		com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO paramCargosFrmk = new com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO();
		mapper.map(cargos,paramCargosFrmk);
			
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("construirRegistroCargos():start");
		try{
			MapperIF mapper2 = new DozerBeanMapper();
			com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO retVal = new com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO();
			retVal = getFrmkCargosFacade().construirRegistroCargos(paramCargosFrmk);
			mapper2.map(retVal, retorno);
			
		}catch (ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;	
		}catch (FrmkCargosException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("FrmkCargosException[" + loge + "]");
			String msg  = ((GeneralException) e.getCause()).getDescripcionEvento();//msg antes-->e.getMessage();pv 080808
			logger.debug("FrmkCargosException[" + msg + "]");
			throw new ManReqException(msg, e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("construirRegistroCargos():end");
		return retorno;
	}
	/**
	 * Registrar cargos
	 * 
	 * @param cargos
	 * @return ResultadoRegCargosDTO
	 * @throws ManReqException
	 */
	/*
	public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO cargos) throws ManReqException{
		ResultadoRegCargosDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("parametrosRegistrarCargos():start");
		try {
			retorno = getManCusBilFacade().parametrosRegistrarCargos(cargos);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManCusBilException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManCusBilException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("parametrosRegistrarCargos():end");
		return retorno;		
	}		
	*/
	
	public ResultadoRegCargosDTO parametrosRegistrarCargos(com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO cargos) throws ManReqException{
		com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ResultadoRegCargosDTO retorno = new com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ResultadoRegCargosDTO();
		MapperIF mapper = new DozerBeanMapper();
		com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO paramCargosFrmk = new com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO();
		mapper.map(cargos, paramCargosFrmk);
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("parametrosRegistrarCargos():start");
		try {
			MapperIF mapper2 = new DozerBeanMapper();
			com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO resCargosFrmk = new com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO();
			resCargosFrmk = getFrmkCargosFacade().parametrosRegistrarCargos(paramCargosFrmk);
			mapper2.map(resCargosFrmk, retorno);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(FrmkCargosException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("FrmkCargosException[" + loge + "]");
			String msg  = ((GeneralException) e.getCause()).getDescripcionEvento();//msg antes-->e.getMessage();pv 080808
			if( msg == null)
			{
				msg = obtenerMensaje(e);
			}
			logger.debug("FrmkCargosException[" + msg + "]");
			throw new ManReqException(msg, e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("parametrosRegistrarCargos():end");
		return retorno;		
	}		
	
	/**
	 * Registrar venta
	 * 
	 * @param venta
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws ManReqException{
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("registrarVenta():start");
		try {
			retorno = getNegSalFacade().registrarVenta(venta);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(NegSalException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NegSalException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("registrarVenta():end");
		return retorno;		
	}
	
	/**
	 * Generar Oferta Comercial
	 * 
	 * @param venta
	 * @return OfertaComercialDTO
	 * @throws ManReqException
	 */
	public OfertaComercialDTO generarOfertaComercial(VentaDTO venta) throws ManReqException{
		OfertaComercialDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("generarOfertaComercial():start");
		try {
			retorno = getNegSalFacade().generarOfertaComercial(venta);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(NegSalException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NegSalException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("generarOfertaComercial():end");
		return retorno;		
	}	
	
	/**
	 * Aceptar presupuesto
	 * 
	 * @param presup
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws ManReqException{
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("aceptarPresupuesto():start");
		try {
			retorno = getAppPriDisRebFacade().aceptarPresupuesto(presup);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(AppPriDisRebException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("aceptarPresupuesto():end");
		return retorno;		
	}
	
	/**
	 * Consulta estado facturado
	 * 
	 * @param consultarEstadoFacturado
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws ManReqException{
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultarEstadoFacturado():start");
		try {
			retorno = getAppPriDisRebFacade().consultarEstadoFacturado(numProceso);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(AppPriDisRebException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("consultarEstadoFacturado():end");
		return retorno;		
	}	
	
	
	/**
	 * obtener Productos Contratados
	 * 
	 * @param VentaDTO
	 * @return ProductoContratadoListDTO
	 * @throws ManReqException
	 */ 
	public ProductoContratadoListDTO obtenerProductosContratadosVenta(VentaDTO venta) throws ManReqException{
		ProductoContratadoListDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerProductosContratadosVenta():start");
		try {
			retorno = getIssCusOrdFacade().obtenerProductosContratadosVenta(venta);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerRangoAntiguedad():end");
		return retorno;		
	}
	
	/**
	 * obtener Productos Contratados
	 * 
	 * @param VentaDTO
	 * @return ProductoContratadoListDTO
	 * @throws ManReqException
	 */ 
	public ProductoContratadoListDTO obtenerProductoContratado(OrdenServicioDTO ordenServicio) throws ManReqException{
		ProductoContratadoListDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerProductoContratado():start");
		try {
			retorno = getIssCusOrdFacade().obtenerProductoContratado(ordenServicio);//obtenerProductosContratadosVenta(venta);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			System.out.println("obtenerProductoContratado -------------->RemoteException------");
			logger.debug("RemoteException[" + loge + "]");
			if(e.getCause() instanceof oracle.jdbc.xa.OracleXAException)
			{
				oracle.jdbc.xa.OracleXAException e1 = (oracle.jdbc.xa.OracleXAException) e.getCause();
				System.out.println("errorCode[" + e1.errorCode + "]");
				System.out.println("getMessage[" + e1.getMessage() + "]");
				System.out.println("getOracleError[" + e1.getOracleError() + "]");
				System.out.println("getOracleSQLError[" + e1.getOracleSQLError() + "]");
				System.out.println("getXAError[" + e1.getXAError() + "]");
				System.out.println("toString[" + e1.toString() + "]");
				System.out.println("getLocalizedMessage[" + e1.getLocalizedMessage() + "]");
				System.out.println("getXAErrorMessage[" + e1.getXAErrorMessage(0) + "]");
				System.out.println("getXAErrorMessage[" + e1.getXAErrorMessage(1) + "]");
				System.out.println("getXAErrorMessage[" + e1.getXAErrorMessage(2) + "]");
				System.out.println("-----------------------------------------------");
			}

			throw new ManReqException(e);
		}
		logger.debug("obtenerRangoAntiguedad():end");
		return retorno;		
	}
	public ProductoOfertadoListDTO obtenerProductosOfertablesPorPaquete(PaqueteDTO paquete) throws GeneralException
	{
		ProductoOfertadoListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerProductosOfertablesPorPaquete():start");
		try {
			resultado = getManProOffInvFacade().obtenerProductosOfertablesPorPaquete(paquete);
		}
		catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerProductosOfertablesPorPaquete():end");
		return resultado;
	}
	
	/**
	 * obtener Productos Ofertados
	 * 
	 *  @param VentaDTO
	 * @return ProductoContratadoListDTO
	 * @throws ManReqException
	 */
	public ProductoOfertadoListDTO obtenerProductosOfertables(AbonadoDTO abonado) throws ManReqException{
		ProductoOfertadoListDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerRangoAntiguedad():start");
		try {
			retorno = getManProOffInvFacade().obtenerProductosOfertables(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManProOffInvException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerRangoAntiguedad():end");
		return retorno;		
	}
	
	/**
	 * Obtener clase de servicio
	 * 
	 * @param param
	 * @return ServCuentaSegDTO
	 * @throws ManReqException
	 */
	public ServCuentaSegDTO tratarServCtaSeg(ServCuentaSegDTO param) throws ManReqException{
		ServCuentaSegDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("tratarServCtaSeg():start");
		try {
			retorno = getSupOrdHanFacade().tratarServCtaSeg(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("tratarServCtaSeg():end");
		return retorno;		
	}
	
	/**
	 * Registrar mov.controlado
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO registrarMovControlada(AbonadoDTO abonado) throws ManReqException{
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("registrarMovControlada():start");
		try {
			retorno = getSupOrdHanFacade().registrarMovControlada(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("registrarMovControlada():end");
		return retorno;		
	}
	
	/**
	 * Consulta Plan
	 * 
	 * @param consultaPlan
	 * @return PlanDTO
	 * @throws ManReqException
	 */
	public PlanDTO consultaPlan(ConsultaPlanDTO consultaPlan) throws ManReqException{
		PlanDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultaPlan():start");
		try {
			retorno = getConsultaFacadeSTL().consultaPlan(consultaPlan);
			
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SocketPSException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SocketPSException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("consultaPlan():end");
		return retorno;		
	}	
	
	/**
	 * Obtiene tipo de contrato
	 * 
	 * @param contrato
	 * @return ContratoDTO
	 * @throws ManReqException
	 */
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws ManReqException{
		logger.debug("obtenerTipoContrato():start");
		
		ContratoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getSupOrdHanFacade().obtenerTipoContrato(contrato);
			
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerTipoContrato():end");
		return retorno;		
	}	
	
	/**
	 * Obtiene modalidad de pago
	 * 
	 * @param modalidad
	 * @return ModalidadPagoDTO
	 * @throws ManReqException
	 */
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws ManReqException{
		logger.debug("obtenerModalidadPago():start");
		
		ModalidadPagoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getSupOrdHanFacade().obtenerModalidadPago(modalidad);
			
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerModalidadPago():end");
		return retorno;		
	}	
	
	/**
	 * Obtiene detalle del presupuesto
	 * 
	 * @param presup
	 * @return PresupuestoDTO
	 * @throws ManReqException
	 */
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws ManReqException{
		logger.debug("obtenerDetallePresupuesto():start");
		
		PresupuestoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getAppPriDisRebFacade().obtenerDetallePresupuesto(presup);
			
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(AppPriDisRebException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDetallePresupuesto():end");
		return retorno;		
	}	
	
	/**
	 * Obtiene información del vendedor
	 * 
	 * @param vendedor
	 * @return VendedorDTO
	 * @throws ManReqException
	 */
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws ManReqException{
		logger.debug("obtenerVendedor():start");
		
		VendedorDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getSupOrdHanFacade().obtenerVendedor(vendedor);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerVendedor():end");
		return retorno;		
	}
	
	/**
	 * Obtiene lista de bodega
	 * 
	 * @param param
	 * @return BodegaListDTO
	 * @throws ManReqException
	 */
	public BodegaListDTO obtenerListaBodegas(ConsultaBodegaDTO param) throws ManReqException{	
	
		BodegaListDTO listaBodega = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerListaBodegas():start");
		try {
			listaBodega = getIssCusOrdFacade().obtenerListaBodegas(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerListaBodegas():end");
		return listaBodega;
	}
	
	
	/**
	 * Inserta concepto descuento en ga_transacabo
	 * 
	 * @param desc
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws ManReqException{
		logger.debug("insertarConceptoDescuento():start");
		
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getAppPriDisRebFacade().insertarConceptoDescuento(desc);
			
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(AppPriDisRebException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("insertarConceptoDescuento():end");
		return retorno;		
	}	

	/**
	 * Obtiene concepto descuento de ga_transacabo
	 * 
	 * @param param
	 * @return DescuentoDTO
	 * @throws ManReqException
	 */
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO param) throws ManReqException{
		logger.debug("obtenerCodConceptoDescuento():start");
		
		DescuentoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getAppPriDisRebFacade().obtenerCodConceptoDescuento(param);
			
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(AppPriDisRebException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerCodConceptoDescuento():end");
		return retorno;		
	}
	
	/**
	 * Elimina concepto descuento de ga_transacabo
	 * 
	 * @param numTransaccion
	 * @return RetornoDTO
	 * @throws ManReqException
	 */
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws ManReqException{
		logger.debug("eliminaCodConceptoDescuento():start");
		
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getAppPriDisRebFacade().eliminaCodConceptoDescuento(numTransaccion);
			
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(AppPriDisRebException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("eliminaCodConceptoDescuento():end");
		return retorno;		
	}	
	
	/**
	 * Obtiene plan comercial
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ManReqException
	 */
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws ManReqException{
		logger.debug("obtenerVendedor():start");
		
		ClienteDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getSupOrdHanFacade().obtenerPlanComercial(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerVendedor():end");
		return retorno;		
	}	
	
	/**
	 * Consulta Plan Actual
	 * 
	 * @param consulta
	 * @return PlanTarifarioDTO
	 * @throws ManReqException
	 */
	public PlanTarifarioDTO consultaPlanActual(ConsultaPlanTarifDTO consulta) throws ManReqException{
		PlanTarifarioDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultaPlanActual():start");
		try {
			retorno = getIssCusOrdFacade().consultaPlanActual(consulta);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("consultaPlanActual():end");
		return retorno;		
	}
	
	public TipIdentListDTO obtenerTiposDeIdentidad() throws ManReqException{	
		
		TipIdentListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTiposDeIdentidad():start");
		try {
			resultado = getSupOrdHanFacade().obtenerTiposDeIdentidad();
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;	
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerTiposDeIdentidad():end");
		return resultado;
	}
	
	public ClienteListDTO buscarCliente(ClienteDTO cliente) throws  ManReqException {
		ClienteListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("buscarCliente():start");
		try {
			resultado = getManConFacade().buscarCliente(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;		
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("buscarCliente():end");
		return resultado;
	}
	
	public AbonadoDTO [] obtenerAbonados(String [] numAbonados) throws ManReqException{
		AbonadoDTO []abonados = new AbonadoDTO[numAbonados.length];
		ManConFacade manConFacade;
		try {
			manConFacade = getManConFacade();
		
		for(int i = 0; i<abonados.length;i++){
			abonados[i] = new AbonadoDTO();
			abonados[i].setNumAbonado(Long.valueOf(numAbonados[i]).longValue());
			abonados[i] = manConFacade.obtenerDatosAbonado(abonados[i]);
		}
		
		} catch (ManReqException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		} catch (ManConException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		return abonados;
	}
	
	public ClienteListDTO buscarCliente(NumeroDTO numero) throws  ManReqException {
		ClienteListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("buscarCliente():start");
		try {
			resultado = getManConFacade().buscarCliente(numero);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;	
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("buscarCliente():end");
		return resultado;
	}
	/**
	 * @author rlozano
	 * @description  Busca Beneficiarios por número de abonado
	 */
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiariosPorNumCelular (AbonadoDTO abonadoDTO)throws ManReqException{
		AbonadoBeneficiarioListDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():start");
		try {
			retValue= getManConFacade().obtieneAbonadosBeneficiariosPorNumCelular(abonadoDTO);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():end");
		return retValue;
		
	}
	
	/**
	 * @author rlozano
	 * @description  Busca Beneficiarios asociados a número de abonado
	 */
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiarios(AbonadoDTO abonadoDTO)throws ManReqException{
		AbonadoBeneficiarioListDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():start");
		try {
			retValue= getManConFacade().obtieneAbonadosBeneficiarios(abonadoDTO);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():end");
		return retValue;
		
	}

	public MorosidadClienteDTO obtenerMorosidadCliente(MorosidadClienteDTO cliente)throws ManReqException{
		MorosidadClienteDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerMorosidadCliente():start");
		try {
			retValue= getSupOrdHanFacade().obtenerMorosidadCliente(cliente);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerMorosidadCliente():end");
		return retValue;
		
	}

	public LineasClienteDTO obtenerCantidadLineasCliente(LineasClienteDTO cliente)throws ManReqException{
		LineasClienteDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCantidadLineasCliente():start");
		try {
			retValue= getSupOrdHanFacade().obtenerCantidadLineasCliente(cliente);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerCantidadLineasCliente():end");
		return retValue;
		
	}
	
	public RespuestaEvalCrediticiaDTO validarEvaluacionCrediticia(EvalCrediticiaDTO data)throws ManReqException{
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarEvaluacionCrediticia():start");
		
		String url = "http://172.28.9.205/WSInstalador/WSClasifica.asmx?WSDL";
        WSClasifica  iservice = new WSClasifica_Impl();
        RespuestaEvalCrediticiaDTO retorno = new RespuestaEvalCrediticiaDTO();
        try{
 
	        WSClasificaSoap service = iservice.getWSClasificaSoap();
	        //parametros del metodo del WS
	        String sTipIdent = "";  //1
	        String sNumIdent = "";  //2
	        boolean nTipPersona = false;  //3
	        int nIndProducto = 1;  //4
	        String cLimCliente ="";  //5
	        String cCodCalcli  =""; //6
	        String cTipEmpleo  ="";  //7
	        String cCodProf	   ="";  //8
	        String cEstCivil   ="";  //9
	        String cIndSex     ="";  //10
	        String cTelPros    ="";  //11
	        String cPreTel     ="";  //12
	        int nIndMorosidad  =0;  //13
	        int nIndExistencia =0;  //14
	        int nIndPantalla   =0;  //15
	        String usuario     ="";  //16
	        String sCodError   ="";  //17
	        String sMenError   ="";  //18
	        String sContinuaVenta  =""; //19
	        String sCalidadCliente ="";  //20
	        String sCalidaDCifra   ="";  //21
	        String sLimConsumo     ="";  //22
	        String sLimCliente     ="";  //23
	        String sNombres        ="";  //24
	        String sApellido1      ="";  //25
	        String sApellido2      ="";  //26
	        String sProfesion      ="";  //27
	        String sTelefResidencia="";  //28
	        String sIngresos      ="";  //29
	        String sFecNacimiento ="";  //30
	        String indTipoRegimen ="";  //31
	        int numLineas =0; //32

	        
	        /*parametros entrada: codCliente,tipoIdentificador,numIdentificador,
	          usuarioLink,nombres,apellido1,apellido2 */
	        
	        long codCliente = data.getCodCliente();
	        logger.debug("codCliente="+codCliente);
	        
	        sTipIdent = data.getTipoIdentificador();
	        logger.debug("sTipIdent="+sTipIdent);
	        
	        sNumIdent = data.getNumIdentificador();
	        logger.debug("sNumIdent="+sNumIdent);
	        
	        usuario = data.getUsuarioLink();
	        logger.debug("usuario="+usuario);
	        
	        sNombres = data.getNombres();
	        logger.debug("sNombres="+sNombres);
	        
	        sApellido1 = data.getApellido1();
	        logger.debug("sApellido1="+sApellido1);
	        
	        sApellido2 = data.getApellido2();
	        logger.debug("sApellido2="+sApellido2); 
	        
	        nIndProducto = Integer.parseInt(global.getValor("codigo.producto"));
	        logger.debug("nIndProducto="+nIndProducto);
	        
			nIndExistencia = 1; //( 1= cuenta ya existe , 0 =cuenta no existe)
	        logger.debug("nIndExistencia="+nIndExistencia);
	        
			nIndPantalla = 0;
	        logger.debug("nIndPantalla="+nIndPantalla);
	        
	        //obtiene tipo persona
	        ParametroDTO parametro = new ParametroDTO();
			parametro.setCodModulo(global.getValor("codigo.modulo.GA"));
			parametro.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
			parametro.setNomParametro("IND_TIPIDENTJURIDICO");
			parametro = obtenerParametroGeneral(parametro);
			String valor = parametro.getValor();
			logger.debug("valor IND_TIPIDENTJURIDICO="+valor);
			
			int posicionSubCadena= sNumIdent.indexOf(valor);
			if (posicionSubCadena>=0) nTipPersona=true;
			logger.debug("nTipPersona="+nTipPersona);
			
			//obtiene indice de morosidad
			MorosidadClienteDTO morosidadCliente = new MorosidadClienteDTO();
			//morosidadCliente.setCodTipIdent(sTipIdent);
			//morosidadCliente.setNumIdent(sNumIdent);
			morosidadCliente.setCodCliente(codCliente);
			
			
			morosidadCliente = obtenerMorosidadCliente(morosidadCliente);
			nIndMorosidad = morosidadCliente.getMorosidad();
			logger.debug("nIndMorosidad="+nIndMorosidad);
			
			//obtiene numero de lineas
			LineasClienteDTO lineasCliente = new LineasClienteDTO();
			lineasCliente.setCodCliente(data.getCodCliente());
			lineasCliente = obtenerCantidadLineasCliente(lineasCliente);
			numLineas = lineasCliente.getNumLineas();
			logger.debug("nIndMorosidad="+nIndMorosidad);
			
	        PrincipalResponse result = service.principal(sTipIdent/*1*/,sNumIdent/*2*/,nTipPersona/*3*/,nIndProducto/*4*/,cLimCliente/*5*/,
	        					cCodCalcli/*6*/,cTipEmpleo/*7*/,cCodProf/*8*/,cEstCivil/*9*/,cIndSex/*10*/,cTelPros/*11*/,cPreTel/*12*/,
	        					nIndMorosidad/*13*/,nIndExistencia/*14*/,nIndPantalla/*15*/,usuario/*16*/,sCodError/*17*/,sMenError/*18*/,
	        					sContinuaVenta/*19*/,sCalidadCliente/*20*/,sCalidaDCifra/*21*/,sLimConsumo/*22*/,sLimCliente/*23*/,
	        					sNombres/*24*/,sApellido1/*25*/,sApellido2/*26*/,sProfesion/*27*/,sTelefResidencia/*28*/,sIngresos/*29*/,
	        					sFecNacimiento/*30*/,indTipoRegimen/*31*/,numLineas/*32*/);

	        retorno.setCodigoError(result.getSCodError());
	        logger.debug("SCodError[" + result.getSCodError() + "]");
	        
	        retorno.setMensajeError(result.getSMenError());
	        logger.debug("SMenError()[" + result.getSMenError() + "]");
	        
	        retorno.setContinuaVenta(result.getSContinuaVenta());
	        logger.debug("SContinuaVenta()[" + result.getSContinuaVenta() + "]");
	        
	        retorno.setCalidadVenta(result.getSCalidadCliente());
	        logger.debug("SCalidadCliente()[" + result.getSCalidadCliente() + "]");
	        
	        retorno.setCalidadCifra(result.getSCalidaDCifra());
	        logger.debug("SCalidaDCifra()[" + result.getSCalidaDCifra()+ "]");
	        
	        retorno.setLimiteConsumo(result.getSLimConsumo());
	        logger.debug("SLimConsumo()[" + result.getSLimConsumo()+ "]");
	        
	        retorno.setLimiteCliente(result.getSLimCliente());
	        logger.debug("SLimCliente()[" + result.getSLimCliente() + "]");
	        
	        retorno.setResultado(result.isPrincipalResult());
	        logger.debug("resultado()[" + result.isPrincipalResult() + "]");
	        
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
        } catch(SOAPFaultException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SOAPFaultException[" + loge + "]");
			retorno.setCodigoError("-1");
			retorno.setMensajeError(e.getMessage());
        } catch (ServiceException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceException[" + loge + "]");
			retorno.setCodigoError("-1");
			retorno.setMensajeError(e.getMessage());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			retorno.setCodigoError("-1");
			retorno.setMensajeError(e.getMessage());
       }catch(Exception e){
			retorno.setCodigoError("-1");
			retorno.setMensajeError("Error al validar evaluacion crediticia");
       }

       return retorno;
	}	
	public IntarcelDTO obtenerFecDesdeCtaSeg(IntarcelDTO intarcel)throws ManReqException{
		IntarcelDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerFecDesdeCtaSeg():start");
		try {
			retValue= getIssCusOrdFacade().obtenerFecDesdeCtaSeg(intarcel);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerFecDesdeCtaSeg():end");
		return retValue;
		
	}
	
	public LimiteLineasDTO obtenerLimiteLineas(ObtencionLineasClienteDTO obtLineas)throws ManReqException{
		LimiteLineasDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerLimiteLineas():start");
		try {
			retorno= getSupOrdHanFacade().obtenerLimiteLineas(obtLineas);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} catch (SupOrdHanException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		logger.debug("obtenerLimiteLineas():end");
		return retorno;
		
	}
	
	public ObtencionRolUsuarioDTO obtenerRolUsuario(ObtencionRolUsuarioDTO obtRol)throws ManReqException{
		ObtencionRolUsuarioDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerRolUsuario():start");
		try {
			retValue= getIssCusOrdFacade().obtenerRolUsuario(obtRol);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerRolUsuario():end");
		return retValue;
		
	}
	
	
	public CausaExcepcionListDTO obtenerCausaExcepcion() throws ManReqException{
		CausaExcepcionListDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCausaExcepcion():start");
		try {
			retValue= getIssCusOrdFacade().obtenerCausaExcepcion();
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(IssCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerCausaExcepcion():end");
		return retValue;
		
	}
	
	public NumeroDTO obtieneModificacionesProducto(ProductoContratadoDTO productoContratado) throws ManReqException{
		NumeroDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtieneModificacionesProducto():start");
		try {
			retValue= getManCusInvFacade().obtieneModificacionesProducto(productoContratado);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManCusInvException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManCusInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtieneModificacionesProducto():end");
		return retValue;
		
	}
	public AbonadoListDTO obtenerListaAbonadosFiltrados(FiltroAbonadosDTO filtro) throws ManReqException{
		AbonadoListDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerListaAbonadosFiltrados():start");
		try {
			retValue= getManConFacade().obtenerListaAbonadosFiltrados(filtro);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerListaAbonadosFiltrados():end");
		return retValue;
		
	}
	
	public RetornoDTO validaFiltroAbonados(ValidaFiltroAbonadosDTO filtro) throws ManReqException{
		RetornoDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaFiltroAbonados():start");
		try {
			retValue= getManConFacade().validaFiltroAbonados(filtro);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("IssCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validaFiltroAbonados():end");
		return retValue;	
	
	}
	
	
	//MANCON-->getManConFacade
	
	public CuentaPersonalDTO obtenerNumeroPersonal(CuentaPersonalDTO cuentaPersonalDTO)throws ManReqException{
		CuentaPersonalDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerNumeroPersonal():start");
		try {
			retorno = getManConFacade().obtenerNumeroPersonal(cuentaPersonalDTO);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManCusInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerNumeroPersonal():end");
		return retorno;
		
	}
	public int obtenerInfoPer(CuentaPersonalDTO cuentaPersonalDTO)throws ManReqException{
		int retorno = 0;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerInfoPer():start");
		try {
			retorno = getManConFacade().obtenerInfoPer(cuentaPersonalDTO);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManCusInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerInfoPer():end");
		return retorno;
		
	}
	
	public int validaPersonal(CuentaPersonalDTO cuentaPersonalDTO)throws ManReqException{
		int retorno = 0;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaPersonal():start");
		try {
			retorno = getManConFacade().validaPersonal(cuentaPersonalDTO);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManCusInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validaPersonal():end");
		return retorno;
		
	}
	
	public int validaAtlantida(AbonadoDTO abonado)throws ManReqException{
		int retorno = 0;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaAtlantida():start");
		try {
			retorno = getManConFacade().validaAtlantida(abonado);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validaAtlantida():end");
		return retorno;
		
	}
	
	public int validaAtlantidaCliente(ClienteDTO cliente)throws ManReqException{
		int retorno = 0;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaAtlantidaCliente():start");
		try {
			retorno = getManConFacade().validaAtlantidaCliente(cliente);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validaAtlantidaCliente():end");
		return retorno;
		
	}
	
	public ClienteDTO obtenerCliente(CuentaPersonalDTO cuentaPersonalDTO)throws ManReqException{
		ClienteDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCliente():start");
		try {
			retorno = getManConFacade().obtenerCliente(cuentaPersonalDTO);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManCusInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerCliente():end");
		return retorno;
		
	}
	
	//CLOCUSORD--> getCloCusOrdFacade()
	
	public void validarActivarNumPer(CuentaPersonalDTO cuentaPersonalDTO)throws ManReqException{

		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarActivarNumPer():start");
		try {
			 getCloCusOrdFacade().validarActivarNumPer(cuentaPersonalDTO);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(CloCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManCusInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarActivarNumPer():end");
	
	}
	
		
	//MANCOL-->getManColFacade()
	public int obtenerInfoAtl(CuentaPersonalDTO cuentaPersonalDTO)throws ManReqException{
		int retorno = 0;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerInfoAtl():start");
		try {
			retorno = getManColFacade().obtenerInfoAtl(cuentaPersonalDTO);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManColException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManCusInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerInfoAtl():end");
		return retorno;
	
	}

	public RetornoDTO validarClienteNPW (ClienteDTO cliente) throws ManReqException{
		RetornoDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarClienteNPW():start");
		try {
			retValue= getSupOrdHanFacade().validarClienteNPW(cliente);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarClienteNPW():end");
		return retValue;		
	}
	
    public RetornoDTO validarSituaCliEmp (ClienteDTO cliente) throws ManReqException{
		RetornoDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarSituaCliEmp():start");
		try {
			retValue= getSupOrdHanFacade().validarSituaCliEmp(cliente);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarSituaCliEmp():end");
		return retValue;		
	}
	
	public PlanTarifarioDTO obtenerPlanTarifario(PlanTarifarioDTO plan) throws ManReqException{
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerPlanTarifario():start");
		try {
			plan= getSupOrdHanFacade().obtenerPlanTarifario(plan);
		
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerPlanTarifario():end");
		return plan;		
	}
	
	public RetornoDTO validarOriDesUso (AbonadoDTO abonado) throws ManReqException{
		RetornoDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarOriDesUso():start");
		try {
			retValue= getSupOrdHanFacade().validarOriDesUso(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarOriDesUso():end");
		return retValue;		
	}	
	
	public ClienteDTO obtenerNumAbonadosCliente (ClienteDTO cliente) throws ManReqException{
		ClienteDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerNumAbonadosCliente():start");
		try {
			retValue= getManConFacade().obtenerNumAbonadosCliente(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerNumAbonadosCliente():end");
		return retValue;		
	}
	
	public RetornoDTO validarSolicitudesBaja (AbonadoDTO abonado) throws ManReqException{
		RetornoDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarSolicitudesBaja():start");
		try {
			retValue= getSupOrdHanFacade().validarSolicitudesBaja(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarSolicitudesBaja():end");
		return retValue;		
	}	
	
	public AbonadoDTO obtenerAbonadoEmpresa (ClienteDTO cliente) throws ManReqException{
		AbonadoDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerAbonadoEmpresa():start");
		try {
			retValue= getManConFacade().obtenerAbonadoEmpresa(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerAbonadoEmpresa():end");
		return retValue;		
	}		
	
	
	/**
	 * 
	 * Metodo para inscribir un nuevo proceso en la base de datos, ademas de guardar 
	 * una version binaria del DTO de oferta comercial 
	 * 
	 * @author Cristian Toledo 
	 * @param ofComercial
	 * @return
	 * @throws SupOrdHanException
	 */
	public ParametroSerializableDTO crearProceso(String numProceso) throws SupOrdHanException
	{
		logger.debug("crearProceso: start ");
		//(byte[])SerializationUtils.serialize(parametro.getParametroObject()		
		//GenericDTO dtoGeneric=new GenericDTO();
		//dtoGeneric.setSerializableObject(ofComercial);
		ParametroSerializableDTO param=new ParametroSerializableDTO();
		param.setEstadoProceso("INSCRITO");
		param.setNumProceso(numProceso);
		param.setOrigenProceso("PV");		
		
		//param.setObjetoSerializado((byte[])SerializationUtils.serialize(ofComercial));	
		try {
			param=getSupOrdHanFacade().nuevoProceso(param);
		} 
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
		
		logger.debug("crearProceso: end ");
		return param;
	}
	
	/**
	 * Registra nivel OOSS
	 * 
	 * @param RetornoDTO
	 * @return RetornoDTO
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	public RetornoDTO registraNivelOoss(RegistroNivelOOSSDTO registraNivel) throws ManReqException{
	
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("registraNivelOoss():start");
		try {
			retorno = getCloCusOrdFacade().registraNivelOoss(registraNivel);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch (CloCusOrdException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		logger.debug("registraNivelOoss():end");
		return retorno;
	}
	
	/**
	 * Registra OOSS en linea
	 * 
	 * @param RegistrarOossEnLineaDTO
	 * @return RetornoDTO
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO registraEnLinea) throws ManReqException{
	
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("registrarOOSSEnLinea():start");
		try {
			retorno = getCloCusOrdFacade().registrarOOSSEnLinea(registraEnLinea);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch (CloCusOrdException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		logger.debug("registrarOOSSEnLinea():end");
		return retorno;
	}
	
	/**
	 * Registra OOSS en linea
	 * 
	 * @param RegistrarOossEnLineaDTO
	 * @return RetornoDTO
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	public RetornoDTO insertarCarta(CartaDTO carta) throws ManReqException{
	
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("insertarCarta():start");
		try {
			retorno = getCloCusOrdFacade().insertarCarta(carta);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch (CloCusOrdException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		logger.debug("insertarCarta():end");
		return retorno;
	}
	
	/**
	 * obtener Productos validarReversa
	 * 
	 * @param OrdenServicioDTO
	 * @return ProductoContratadoListDTO
	 * @throws ManReqException
	 */ 
	public RetornoDTO validarReversa (OrdenServicioDTO ordenServicioDto) throws ManReqException{
		RetornoDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarReversa():start");
		try {
			retValue = getSupOrdHanFacade().validarReversa(ordenServicioDto);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarReversa():end");
		return retValue;		
	}
	
	/**
	 * obtener Productos validarReversa
	 * 
	 * @param OrdenServicioDTO
	 * @return ProductoContratadoListDTO
	 * @throws ManReqException
	 */ 
	public RetornoDTO validarNumPer(AbonadoDTO abonado) throws ManReqException{
		RetornoDTO retValue = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarNumPer():start");
		try {
			retValue = getSupOrdHanFacade().validarNumPer(abonado);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarNumPer():end");
		return retValue;		
	}
	
	/**
	 * Obtiene dias prorrateo
	 * 
	 * @param registro
	 * @return RegistroFacturacionDTO
	 * @throws ManReqException
	 */
	public RegistroFacturacionDTO getDiasProrrateo(RegistroFacturacionDTO registro) throws ManReqException{	
	
		RegistroFacturacionDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("getDiasProrrateo():start");
		try {
			resultado = getDetCusOrdFeaFacade().getDiasProrrateo(registro);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(DetCusOrdFeaException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("DetCusOrdFeaException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("getDiasProrrateo():end");
		return resultado;
	}
	
	/**
	 * Aplica impuesto
	 * 
	 * @param registro
	 * @return RegistroFacturacionDTO
	 * @throws ManReqException
	 */
	public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO registro) throws ManReqException{	
	
		RegistroFacturacionDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("aplicaImpuestoImporte():start");
		try {
			resultado = getDetCusOrdFeaFacade().aplicaImpuestoImporte(registro);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(DetCusOrdFeaException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("DetCusOrdFeaException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("aplicaImpuestoImporte():end");
		return resultado;
	}
	/**
	 * validar Carta
	 * 
	 * @param OrdenServicioDTO
	 * @return int
	 * @throws ManReqException
	 */ 
	public int validarCarta(OrdenServicioDTO ordenServicio) throws ManReqException{
		int canReg = 0;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarCarta():start");
		try {
			canReg = getSupOrdHanFacade().validarCarta(ordenServicio);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validarCarta():end");
		return canReg;		
	}
	
	/**
	 * Obtener numeros de sucuencias
	 * 
	 * @param OrdenServicioDTO
	 * @return int
	 * @throws ManReqException
	 */ 
	public SecuenciaDTO[] obtenerNumeroDeSecuencias(CantSecuenciaDTO param) throws ManReqException{
		SecuenciaDTO[] secuencias = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerNumeroDeSecuencias():start");
		try {
			secuencias = getSupOrdHanFacade().obtenerNumeroDeSecuencias(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerNumeroDeSecuencias():end");
		return secuencias;		
	}
	
	/**
	 * Obtener oficina
	 * 
	 * @param OficinaDTO
	 * @return OficinaDTO
	 * @throws ManReqException
	 */ 
	public OficinaDTO obtenerDatosOficina(OficinaDTO param) throws ManReqException{
		OficinaDTO oficina = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosOficina():start");
		try {
			oficina = getSupOrdHanFacade().obtenerDatosOficina(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDatosOficina():end");
		return oficina;		
	}
	
	/**
	 * Actualiza Estado en el modelo de procesos
	 * 
	 * @param EstadoProcesoOOSSDTO
	 * @return void
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	public EstadoProcesoOOSSDTO notificar(EstadoProcesoOOSSDTO estadoProcesoOOSS) throws ManReqException{
	
		EstadoProcesoOOSSDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("notificar():start");
		try {
			retorno=getCloCusOrdFacade().actualizarEstado(estadoProcesoOOSS);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch (CloCusOrdException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		logger.debug("notificar():end");
		return retorno;
		
	}

	/**
	 * Obtiene secuencias de abonados
	 * 
	 * @param EstadoProcesoOOSSDTO
	 * @return void
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	public AbonadoSecuenciaDTO[] obtenerSecuenciasAbonados(ObtencionSecuenciasDTO param) throws ManReqException{
	
		AbonadoSecuenciaDTO[] retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerSecuenciasAbonados():start");
		try {
			retorno=getSupOrdHanFacade().obtenerSecuenciasAbonados(param);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch (SupOrdHanException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		logger.debug("obtenerSecuenciasAbonados():end");
		return retorno;
		
	}
	
	
	public com.tmmas.scl.vendedor.dto.VendedorDTO recuperarInformacionVendedor(com.tmmas.scl.vendedor.dto.VendedorDTO vendedor) throws ManReqException  {
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);
		logger.debug("recuperarInformacionVendedor():start");
		com.tmmas.scl.vendedor.dto.VendedorDTO resultado = null;
		try {
			logger.debug("getVendedorFacade:antes");
			VendedorFacadeSTL facade = facadeMaker.getVendedorFacade();
			logger.debug("getVendedorFacade:despues");			
			logger.debug("recuperarInformacionVendedor():antes");
			resultado = facade.recuperarInformacionVendedor(vendedor);
			logger.debug("recuperarInformacionVendedor():despues");
		}catch (VendedorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("VendedorException[" + loge + "]");
			//throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			throw new ManReqException(e);
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} catch (Exception e) {
			logger.debug("Exception", e);
			throw new ManReqException(e);			
		}
		logger.debug("recuperarInformacionVendedor():end");
		return resultado;
	}	
	
	/**
	 * Recupera la informacion de la combinatoria para el vendedor comisionable dada una combinatoria
	 * @param config
	 * @return
	 * @throws ManReqException
	 */
	public ConfiguracionVendedorCPUDTO  recuperarConfiguracionVendedorCPU(ConfiguracionVendedorCPUDTO config) throws ManReqException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("recuperarConfiguracionVendedorCPU():start");

		ConfiguracionVendedorCPUDTO resultado = null;
		try {
			logger.debug("getVendedorFacade:antes");
			VendedorFacadeSTL facade = facadeMaker.getVendedorFacade();
			logger.debug("getVendedorFacade:despues");
			
			logger.debug("recuperarConfiguracionVendedorCPU():antes");
			resultado = facade.recuperarConfiguracionVendedorCPU(config);
			logger.debug("recuperarConfiguracionVendedorCPU():despues");
		}catch (VendedorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("VendedorException[" + loge + "]");
			throw new ManReqException(e);
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} catch (Exception e) {
			logger.debug("Exception", e);
			throw new ManReqException(e);			
		}
		logger.debug("recuperarConfiguracionVendedorCPU():end");
		return resultado;
	}	
	
	/**
	 * Obtiene la informacion del usuario y el vendedor. Aplica cuando se quiere tomar la informacion del vendedor
	 * del usuario que se loguea 
	 * @param usuarioSistema
	 * @return
	 * @throws ManReqException
	 */
	public UsuarioVendedorDTO  obtenerInformacionUsuarioVendedor(UsuarioSistemaDTO usuarioSistema) throws ManReqException {
		String log = global.getValor("web.log");
		PropertyConfigurator.configure(log);
		logger.debug("obtenerInformacionUsuarioVendedor():start");

		UsuarioVendedorDTO resultado = null;
		try {
			logger.debug("getVendedorFacade:antes");
			VendedorFacadeSTL facade = facadeMaker.getVendedorFacade();
			logger.debug("getVendedorFacade:despues");
			
			logger.debug("obtenerInformacionUsuarioVendedor():antes");
			resultado = facade.obtenerInformacionUsuarioVendedor(usuarioSistema);
			logger.debug("obtenerInformacionUsuarioVendedor():despues");
		}catch (VendedorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("VendedorException[" + loge + "]");
			throw new ManReqException(e);
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} catch (Exception e) {
			logger.debug("Exception", e);
			throw new ManReqException(e);			
		}
		logger.debug("obtenerInformacionUsuarioVendedor():end");
		return resultado;
	}		
	
	/**
	 * Consulta lista planes evaluacion de riesgo
	 * 
	 * @param EstadoProcesoOOSSDTO
	 * @return void
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	
	public LstPTaPlanTarifarioListOutDTO obtenerPlanesEvaluacion(ClienteDTO clienteOrigen) throws ManReqException{
		
		LstPTaPlanTarifarioListOutDTO planesEval = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerPlanesEvaluacion():start");

		try {
			LstPTaPlanTarifarioInDTO entrada = new LstPTaPlanTarifarioInDTO();
			entrada.setNumIdent(clienteOrigen.getNumeroIdentificacion());
			entrada.setTipIdent(clienteOrigen.getCodigoTipoIdentificacion());
			planesEval =  getVentasFacade().lstPlanTarifPosventa(entrada);
		}
		catch (ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}
		catch (VentasException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		logger.debug("obtenerPlanesEvaluacion():end");
		
		return planesEval;
	}

	/**
	 * Bloquea solicitud de evaluacion de riesgo
	 * 
	 * @param ClienteDTO
	 * @return void
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	
	public SalidaOutDTO bloqueaSolicitudEvRiesgo(long numSolicitud) throws ManReqException{
		
		SalidaOutDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("bloqueaSolicitudEvRiesgo():start");

		try {
			RegistroEvaluacionRiesgoDTO entrada = new RegistroEvaluacionRiesgoDTO();
			entrada.setCodigoTipoIdentificacion("01");// Está en duro pues en la implementacion final solo se enviara el numSolicitud    
			entrada.setNumIdentificacion("1234567");  // Está en duro pues en la implementacion final solo se enviara el numSolicitud
			entrada.setNumeroSolicitud(numSolicitud);
			resultado =  getVentasFacade().bloqueaSolicitudEvRiesgo(entrada);
		}
		catch (ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}
		catch (VentasException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		logger.debug("bloqueaSolicitudEvRiesgo():end");
		
		return resultado;
	}
	

	/**
	 * Desbloquea solicitud de evaluacion de riesgo
	 * 
	 * @param ClienteDTO
	 * @return void
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	
	public SalidaOutDTO desBloqueaSolicitudEvRiesgo(long numSolicitud) throws ManReqException{
		
		SalidaOutDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("desBloqueaSolicitudEvRiesgo():start");

		try {
			RegistroEvaluacionRiesgoDTO entrada = new RegistroEvaluacionRiesgoDTO();
			entrada.setCodigoTipoIdentificacion("01"); // Está en duro pues en la implementacion final solo se enviara el numSolicitud    
			entrada.setNumIdentificacion("1234567");   // Está en duro pues en la implementacion final solo se enviara el numSolicitud
			entrada.setNumeroSolicitud(numSolicitud);
			resultado =  getVentasFacade().desBloqueaEstadoSolicitudEvRiesgo(entrada);
		}
		catch (ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}
		catch (VentasException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		logger.debug("desBloqueaSolicitudEvRiesgo():end");
		
		return resultado;
	}
	

	/**
	 * Obtiene informacion del cliente
	 * 
	 * @param cliente
	 * @return RetornoDTO
	 * @throws ProyectoException
	 */
	
	public RetornoDTO actualizarLineasPorPlan (PlanEvaluacionRiesgoDTO planEval) throws ManReqException{
		RetornoDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("actualizarLineasPorPlan():start");
		try {
			resultado = getManConFacade().actualizarLineasPorPlan(planEval);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("actualizarLineasPorPlan():end");
		return resultado;
	}
	
	public RetornoDTO validaBajaAtlEmpresa(ClienteDTO cliente) throws ManReqException{
		RetornoDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaBajaAtlEmpresa():start");
		try {
			resultado = getCloCusOrdFacade().validaBajaAtlEmpresa(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(CloCusOrdException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("validaBajaAtlEmpresa():end");
		return resultado;
	}
	
	public Long obtenerNumClientesCuenta(ClienteDTO cliente) throws ManReqException{
		Long resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerNumClientesCuenta():start");
		try {
			resultado = getManConFacade().obtenerNumClientesCuenta(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerNumClientesCuenta():end");
		return resultado;
	}
	
	public ClienteListDTO listarClientesCuenta(ClienteDTO cliente) throws ManReqException{
		ClienteListDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("listarClientesCuenta():start");
		try {
			resultado = getManConFacade().listarClientesCuenta(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("listarClientesCuenta():end");
		return resultado;
	}
	
	
	/**
	 * Obtiene numero corportivo
	 * 
	 * @param CuentaPersonalDTO
	 * @return CuentaPersonalDTO
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	public CuentaPersonalDTO  obtieneNumeroCorporativo(CuentaPersonalDTO cuentaPersonal) throws ManReqException{
		logger.debug("obtieneNumeroCorporativo():start");
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		
		try {
			cuentaPersonal = getCloCusOrdFacade().obtieneNumeroCorporativo(cuentaPersonal);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch (CloCusOrdException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		
		logger.debug("obtieneNumeroCorporativo():end");
		return cuentaPersonal;
	}

	/**
	 * Obtiene datos de cuenta personal de cliente corporativo
	 * 
	 * @param CtaPersonalEmpDTO
	 * @return CtaPersonalEmpDTO
	 * @throws ManReqException
	 * @throws CloCusOrdException 
	 */
	public CtaPersonalEmpDTO  obtenerDatosCtaPersonalCliEmp (CtaPersonalEmpDTO cuentaPersonal) throws ManReqException{
		logger.debug("obtenerDatosCtaPersonalCliEmp():start");
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		
		try {
			cuentaPersonal = getCloCusOrdFacade().obtenerDatosCtaPersonalCliEmp(cuentaPersonal);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch (CloCusOrdException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		
		logger.debug("obtenerDatosCtaPersonalCliEmp():end");
		return cuentaPersonal;
	}
	
	/**
	 * Obtiene concepto abonado cero
	 * 
	 * @param gedCodigosDTO
	 * @return GedCodigosListDTO
	 * @throws ManReqException
	 * @throws SupOrdHanException 
	 */
	public GedCodigosListDTO obtenerListaGedCodigos(GedCodigosDTO gedCodigosDTO) throws ManReqException {
		logger.debug("obtenerListaGedCodigos():start");
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		GedCodigosListDTO codigos = null;
		
		try {
			codigos = getSupOrdHanFacade().obtenerListaGedCodigos(gedCodigosDTO);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch (SupOrdHanException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		
		logger.debug("obtenerListaGedCodigos():end");
		return codigos;
	}

	public EventoNumFrecDTO obtenerMontoEvento(EventoNumFrecDTO eventoNumeroFrec) throws ManReqException{
		logger.debug("obtenerMontoEvento():start");
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		EventoNumFrecDTO retorno = null;
		
		try {
			retorno = getCloCusOrdFacade().obtenerMontoEvento(eventoNumeroFrec);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch (CloCusOrdException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CloCusOrdException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		
		logger.debug("obtenerMontoEvento():end");
		return retorno;
	}
	
	
	/**
	 * Obtener operadora local
	 * 
	 * @param 
	 * @return CausaCambioPlanListDTO
	 * @throws ManReqException
	 */
	public OperadoraLocalDTO obtenerOperadoraLocal() throws ManReqException{	
	
		OperadoraLocalDTO resultado = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ManageRequestBussinessDelegate.obtenerOperadoraLocal():start");
		try {
			resultado = getSupOrdHanFacade().obtenerOperadoraLocal();
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerOperadoraLocal():end");
		return resultado;
	}
	
	public Date obtenerFechaBaseDeDatos() throws ManReqException
	{
		logger.debug("Obtener Fecha Base de Datos: start ");
		Date fechaHoraBaseDatos = null;
		try {
			fechaHoraBaseDatos = getSupOrdHanFacade().obtenerFechaBaseDeDatos();
		}catch (SupOrdHanException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		} 
		
		logger.debug("Obtener Fecha Base de Datos: end ");
		return fechaHoraBaseDatos;
	}
	
	public ProductoOfertadoListDTO obtenerLCplanAdicional(ProductoOfertadoListDTO listaProductos) throws GeneralException{
		ProductoOfertadoListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerLCplanAdicional():start");
		try {
			resultado = getManProOffInvFacade().obtenerLCplanAdicional(listaProductos);
		}catch(ManProOffInvException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}
		
		
		logger.debug("obtenerLCplanAdicional():end");
		return resultado;
	}
	
	public LimiteConsumoProductoListDTO consultaAbonoLcProducto(LimiteConsumoProductoDTO limiteConsumoProducto) throws GeneralException{
		LimiteConsumoProductoListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultaAbonoLcProducto():start");
		try {
			resultado = getManProOffInvFacade().consultaAboLc(limiteConsumoProducto);
		}catch(ManProOffInvException e){
			e.printStackTrace();
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			e.printStackTrace();
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}
		
		
		logger.debug("consultaAbonoLcProducto():end");
		return resultado;
	}
	
	public DatosClienteDTO obtenerDatosAdicCliente(Long codCliente)	throws ManReqException {
		logger.debug("obtenerDatosAdicCliente():start");
		DatosClienteDTO retorno = null;
		try {
			retorno = getManConFacade().obtenerDatosAdicCliente(codCliente);
		} catch (ManReqException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + log + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDatosAdicCliente():end");
		return retorno;
		
	}
	
	/**
	 * Obtiene indCompartido plan tarifario
	 * 
	 * @param codPlanTarif
	 * @return ParametroDTO
	 * @throws ProyectoException
	 */
	public PlanTarifarioDTO obtenerDatosPlanTarifario(String codPlanTarif) throws ManReqException{	
	
		PlanTarifarioDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosPlanTarifario():start");
		try {
			resultado = getSupOrdHanFacade().obtenerDatosPlanTarifario(codPlanTarif);
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDatosPlanTarifario():end");
		return resultado;
	}
	
	/**
	 * Obtiene informacion del cliente
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ProyectoException
	 */
	public ClienteDTO getCliente(ClienteDTO cliente) throws ManReqException{
		ClienteDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("getCliente():start");
		try {
			resultado = getManConFacade().getCliente(cliente);
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("getCliente():end");
		return resultado;
		
	}

	/**
	 * Obtiene tipos de Comportamiento
	 * 
	 * @param cliente
	 * @return TipoComportamientoListDTO
	 * @throws ProyectoException
	 */
	public TipoComportamientoListDTO obtenerTiposComportamiento() throws ManReqException{
		TipoComportamientoListDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTiposComportamiento():start");
		try {
			resultado = getManProOffInvFacade().obtenerTiposComportamiento();
		}catch(ManReqException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(ManProOffInvException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManProOffInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerTiposComportamiento():end");
		return resultado;	
	}
}
