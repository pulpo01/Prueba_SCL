package com.tmmas.cl.scl.gestionDeVendedores.srv;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestionDeVendedores.helper.Global;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.AbonadoBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.PlanTarifarioBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.RegistroVentaBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.ServicioSuplementarioBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.SimcardBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ProcesoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ServicioSuplementarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.CentralBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.ClienteBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.InterfazCentralBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.OficinaBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.RegistroFacturacionBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.VendedorBO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ArticuloResDesInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.InterfazCentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.OficinaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloImeiInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloImeiOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloResDesOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloVendedorOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCausalesVentasOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoComisionistaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsOficinaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsVendedorStockInDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.bo.DatosGeneralesBO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.bo.ParametrosGeneralesBO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.ParametrosGeneralesDTO;

public class GestionDeVendedoresSRV {
	private CompositeConfiguration config;
	private final Logger logger = Logger.getLogger(GestionDeVendedoresSRV.class);
	private VendedorBO vendedorBO =new VendedorBO();
	private OficinaBO oficinaBO = new OficinaBO();
	private InterfazCentralBO interfazCentralBO = new InterfazCentralBO();
	private RegistroFacturacionBO registroFacturacionBO = new RegistroFacturacionBO();
	private ParametrosGeneralesBO parametrosGeneralesBO = new ParametrosGeneralesBO();
	private SimcardBO simcardBO=new SimcardBO();
	private PlanTarifarioBO planTarifarioBO=new PlanTarifarioBO();
	private DatosGeneralesBO datosGeneralesBO =new DatosGeneralesBO();
	private CentralBO centralBO = new CentralBO();
	private ClienteBO clienteBO = new ClienteBO();
	private ServicioSuplementarioBO   servicioSuplementarioBO = new ServicioSuplementarioBO();
	private AbonadoBO abonadoBO = new AbonadoBO();
 	private Global global=Global.getInstance();
 	private RegistroVentaBO BORegistroVenta = new RegistroVentaBO();
 	private DatosGeneralesBO        BODatosgenerales        = new DatosGeneralesBO();
	
	public GestionDeVendedoresSRV(){				
		System.out.println("GestionDeVendedoresSRV(): Start");
		config = UtilProperty.getConfiguration("GestionDeVendedoresSRV.properties","com/tmmas/cl/scl/gestionDeVendedores/properties/GestionDeVendedores.properties");
		System.out.println("GestionDeVendedoresSRV.log ["+config.getString("GestionDeVendedoresSRV.log")+"]");
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		logger.debug("GestionDeVendedoresSRV():End");		
	}
	
	
	public VendedorDTO getVendedor(VendedorDTO vendedorDTO) throws GeneralException{
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));			
			vendedorDTO=vendedorBO.getVendedor(vendedorDTO);
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));					
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));		
			logger.debug("GeneralException");
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("e.getDescripcionEvento() ["+e.getDescripcionEvento()+"]");
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));			
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return vendedorDTO;
	}
	
	public VendedorDTO[] getTipoComisionista()throws GeneralException{
		VendedorDTO[] retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("getTipoComisionista():start");
			retValue= vendedorBO.getListTiposComisionistas();
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("getTipoComisionista():end");			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));			
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	public OficinaDTO[] getOficina()throws GeneralException{             
		OficinaDTO[]retValue =null;
		
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			retValue = oficinaBO.getListOficinasSCL();
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("Fin:getOficinas()");
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("GeneralException[", e);		
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public VendedorDTO[] getVendedoresPorOficina(VendedorDTO vendedorDTO) throws GeneralException{
		VendedorDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			retValue=vendedorBO.getListadoVendedoresXOficina(vendedorDTO);
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
		
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	
	public VendedorDTO[] getListadoVendedoresXOficinaEIndicador(VendedorDTO vendedorDTO)throws GeneralException{
		VendedorDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			retValue=vendedorBO.getListadoVendedoresXOficinaEIndicador(vendedorDTO);
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
		
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public VendedorDTO[] getListadoVendedoresXTipo(VendedorDTO vendedorDTO)throws GeneralException{
		VendedorDTO[] retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			retValue=vendedorBO.getListadoVendedoresXTipo(vendedorDTO);
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
		
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public WsArticuloVendedorOutDTO[] getArticulosPorVendedor(WsVendedorStockInDTO vendedorStockDTO) throws GeneralException{
		WsArticuloVendedorOutDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			retValue=vendedorBO.getArticulosPorVendedor(vendedorStockDTO);
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
		
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public WsArticuloImeiOutDTO getArticuloPorImei(WsArticuloImeiInDTO inWSLstNumSerieDTO) throws GeneralException{
		WsArticuloImeiOutDTO retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			retValue=vendedorBO.getArticuloPorImei(inWSLstNumSerieDTO);
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));							
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public OficinaDTO[] getOficinasPorVendedor(VendedorDTO vendedorDTO)throws GeneralException{             
		OficinaDTO[] retValue =null;
		
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			retValue = oficinaBO.getOficinasPorVendedor(vendedorDTO);
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("Fin:getOficinasPorVendedor()");
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("GeneralException[", e);				
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedores.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsListTipoComisionistaOutDTO getListadoComisionistasXOficina(WsOficinaInDTO wsOficinaInDTO) throws GeneralException{
		WsListTipoComisionistaOutDTO retValue=null; 
		try{
			logger.debug("Ini:getListadoComisionistasXOficina()");
			retValue=vendedorBO.getListadoComisionistasXOficina(wsOficinaInDTO);
			logger.debug("Fin:getListadoComisionistasXOficina()");
		
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public WsListadoCausalesVentasOutDTO getListadoMotivosDescuentosManuales(String CodigoUso) throws GeneralException{
		WsListadoCausalesVentasOutDTO retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
			logger.debug("Ini:getListadoMotivosDescuentosManuales()");
			retValue=vendedorBO.getListadoMotivosDescuentosManuales(CodigoUso);
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
			logger.debug("Fin:getListadoMotivosDescuentosManuales()");
		
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsArticuloResDesOutDTO reservaDesreserva(ArticuloResDesInDTO articuloDTO) throws GeneralException{
		WsArticuloResDesOutDTO retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
			logger.debug("Ini:reservaDesreserva()");
			retValue=vendedorBO.reservaDesreserva(articuloDTO);
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
			logger.debug("Fin:reservaDesreserva()");
		
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	/**
	 *Metodo que implementa caso de uso provisionar lineas, el cual crea movimiento en centrales
	 * @param  entrada
	 * @return resultado
	 * @throws GeneralException,ProductDomainException,ResourceDomainException
	 */
	
	public void provisionandoLinea(GaVentasDTO parametros) throws GeneralException {
	try{	
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		logger.debug("provisionandoLinea():inicio");
		
		
		String codigoActuacionProceso;
		//String sIndAkeys=null;
        String codigoAccion=null;
        String valorServicio=null;
        String codigoActuacionCentral = null;

		//no se valida si es simcard externa ya que solo se maneja simcard Internas.
		ParametrosGeneralesDTO parametrosGrales = new ParametrosGeneralesDTO();
		parametrosGrales.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosGrales.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGrales.setNombreparametro("parametro.ind.telefono.out");
		parametrosGrales=parametrosGeneralesBO.getParametroGeneral(parametrosGrales);
		
		
		SimcardSNPNDTO simcard = new SimcardSNPNDTO();
		simcard.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
		simcard.setIndicadorTelefono(parametrosGrales.getValorparametro());
		simcard = simcardBO.getIndicadorTelefono(simcard);
		
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(parametros.getAbonado().getCodPlanTarif());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		float fImportePlan = planTarifario.getImporteCargoBasico();
		codigoActuacionProceso = parametros.getCodigoActuacionDefecto();
		if (!planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido())){
			if (!simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.noprogramada")) 
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bodega.desactivada")) 
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bloqueada"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.infobox"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.bloqueada"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.espera"))){
				throw new GeneralException("10039",0,"Linea " + parametros.getAbonado().getNumCelular() + "con simcard en estado desconocido " + 
						simcard.getIndicadorTelefono() + ", no es posible aprovicionar en red");
			}else if (simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bloqueada"))){
				if (parametros.getCodigoActuacionDefecto().equals(global.getValor("codigo.actuacion.venta")))
					codigoActuacionProceso = global.getValor("central.venta.oficina");
				else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.terreno")))
					codigoActuacionProceso = global.getValor("central.venta.terreno");
				else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.ctc")))
					codigoActuacionProceso = global.getValor("central.venta.ctc");
				else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.cuenta.cont.ofic")))
					codigoActuacionProceso = global.getValor("central.venta.cuenta.cont.ofic");
				else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.cuenta.cont.terr")))
					codigoActuacionProceso = global.getValor("central.venta.cuenta.cont.terr");
				else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.renta.phone")))
					codigoActuacionProceso = global.getValor("central.alta.renta.phone");
				else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.oficina")))
					codigoActuacionProceso = global.getValor("central.alta.prepago.oficina");
				else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.terreno")))
					codigoActuacionProceso = global.getValor("central.alta.prepago.terreno");
			}else if (simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.bloqueada"))){
				if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.oficina")))
					codigoActuacionProceso = global.getValor("central.alta.prepago.oficina");
				else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.terreno")))
					codigoActuacionProceso = global.getValor("central.alta.prepago.terreno");
			}
				
		}
		else
			codigoActuacionProceso = global.getValor("codigo.actuacion.hibrido");
		
		/*Recupera código de actuación en centrales asociado al código de actuación de procesamiento*/
		DatosGeneralesDTO datosGrales = new DatosGeneralesDTO();
		datosGrales.setCodigoActuacionAbonado(codigoActuacionProceso);
		datosGrales.setCodigoProducto(global.getValor("codigo.producto"));
		datosGrales.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
		datosGrales = datosGeneralesBO.getActuacionCentral(datosGrales);
		codigoActuacionCentral = datosGrales.getCodigoActuacionCentral();
		if (codigoActuacionCentral ==null)
			throw new GeneralException("12382",0,"Línea, " + parametros.getAbonado().getNumCelular() + "no es posible aprovicionar en red");
		simcard = simcardBO.getSimcard(simcard);
		simcard.setIndProcEq(global.getValor("indicador.procedencia.equipo.simcard"));
		
		
		/*Valida autenticación de Serie Simcard*/
		ProcesoDTO proceso = new ProcesoDTO();
		proceso = simcardBO.validaAutenticacionSerie(simcard);
		
		if (proceso.getCodigoError()==0){
			logger.debug("codigoAccion: " + proceso.getMensajeError().substring(1,3));
			//sIndAkeys = proceso.getMensajeError().substring(1,1);
			codigoAccion = proceso.getMensajeError().substring(1,3);
	        valorServicio = proceso.getMensajeError().substring(3,9);
	        logger.debug("valorServicio: " + proceso.getMensajeError().substring(3,9));
		}
		logger.debug("Codigo Accion" + codigoAccion);
		/*Valida código de acción devuelto en la autenticación de la serie*/
		
		if (!codigoAccion.equals(global.getValor("codigo.accion.uno"))  
		&& !codigoAccion.equals(global.getValor("codigo.accion.dos")) 
		&& !codigoAccion.equals(global.getValor("codigo.accion.tres"))
		&& !codigoAccion.equals(global.getValor("codigo.accion.cuatro"))){
			
			throw new GeneralException("12383",0,"Ha ocurrido un error al momento de insertar movimiento en centrales");

		}
		else if (!codigoAccion.equals(global.getValor("codigo.accion.dos"))  
	             && parametros.getCodOperadora().equals(global.getValor("codigo.operadora.val.central")))
			throw new GeneralException("12384",0,"Ha ocurrido un error al momento de insertar movimiento en centrales");
		
		InterfazCentralDTO intCentralDTO = new InterfazCentralDTO();
		
		/*Obtiene secuencia movimiento a centrales */
		datosGrales = new DatosGeneralesDTO();
		datosGrales.setCodigoSecuencia(global.getValor("secuencia.movimiento.central"));
		datosGrales = datosGeneralesBO.getSecuencia(datosGrales);
		
		intCentralDTO.setNumeroMovimiento(datosGrales.getSecuencia());
		parametros.setNumeroMovtoAnterior(String.valueOf(intCentralDTO.getNumeroMovimiento()));
		intCentralDTO.setNumeroAbonado(parametros.getAbonado().getNumAbonado());
		intCentralDTO.setCodigoEstado(Integer.parseInt(global.getValor("codigo.estado.centrales")));
		intCentralDTO.setCodActabo(codigoActuacionProceso);
		intCentralDTO.setCodigoModulo(global.getValor("codigo.modulo.GA"));
		intCentralDTO.setCodigoActuacion(codigoActuacionCentral);
		intCentralDTO.setCodigoUsuario(parametros.getCodigoUsuario());
		
		Date fecha = new Date();
		Calendar cal = new GregorianCalendar();
		cal.setTimeInMillis(fecha.getTime());
//		INICIO CSR-11002
//	    Date fechaIngreso = new Date(cal.getTimeInMillis()); 
//	    String fechaIngresoFormateada = Formatting.dateTime(fechaIngreso,"dd/MM/yyyy HH:mm:ss");
//	    intCentralDTO.setFechaIngreso(fechaIngresoFormateada);
		intCentralDTO.setFechaIngreso(new java.sql.Timestamp( cal.getTimeInMillis()));
		//FIN CSR-11002
		
		intCentralDTO.setTipoTerminal(parametros.getParametroCodigoSimcardGSM());
		intCentralDTO.setCodigoCentral(parametros.getAbonado().getCodCentral());
		intCentralDTO.setNumeroCelular(parametros.getAbonado().getNumCelular());
		intCentralDTO.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
		if (codigoAccion.equals(global.getValor("codigo.accion.uno")) 
			|| codigoAccion.equals(global.getValor("codigo.accion.tres"))){
			intCentralDTO.setCodigoServicio(valorServicio);
		}
		intCentralDTO.setNumMin(parametros.getAbonado().getNumMin());
		
		CentralDTO central = new CentralDTO();
		central.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		central.setCodigoCentral(String.valueOf(parametros.getAbonado().getCodCentral()));
		central = centralBO.getCentral(central);
		intCentralDTO.setTipoTecnologia(central.getCodigoTecnologia());
		simcard.setCodigoImsi(global.getValor("codigo.imsi"));
		simcard = simcardBO.getImsiSimcard(simcard);
		intCentralDTO.setImsi(simcard.getValorImsi());
		intCentralDTO.setImei(parametros.getAbonado().getNumSerieTerminal());
		intCentralDTO.setIcc(parametros.getAbonado().getNumSerieSimcard());
		
		
		
		parametrosGrales = new ParametrosGeneralesDTO();
		parametrosGrales.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGrales.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGrales.setNombreparametro("parametro.categoria.cta.segura");
		parametrosGrales=parametrosGeneralesBO.getParametroGeneral(parametrosGrales);
		
		String sCuentaSegura = parametrosGrales.getValorparametro();
		
		
		parametrosGrales = new ParametrosGeneralesDTO();
		parametrosGrales.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGrales.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGrales.setNombreparametro(global.getValor("parametro.prorrateo.movimiento"));
		parametrosGrales=parametrosGeneralesBO.getParametroGeneral(parametrosGrales);
		
		String sProrrateo = parametrosGrales.getValorparametro();
		
		PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
		planTarifarioDTO.setCodigoPlanTarifario(parametros.getAbonado().getCodPlanTarif());
		planTarifarioDTO = planTarifarioBO.getCategoriaPlanTarifario(planTarifarioDTO);
		
		ClienteDTO clienteDTO = new ClienteDTO();
		clienteDTO.setCodigoCliente(String.valueOf(parametros.getCodCliente().longValue()));
		clienteDTO = clienteBO.getCliente(clienteDTO);
		//Si se cumple condición se realiza prorrateo, en caso contrario se mantieneel valor
		//del importe del plan y se le aplica los impuestos correspondientes
		if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido())
		&& !planTarifarioDTO.getCodigoCategoria().equals(sCuentaSegura)
		&& sProrrateo.equals(global.getValor("indicador.prorrateo"))){
			parametrosGrales = new ParametrosGeneralesDTO();
			parametrosGrales.setCodigomodulo(global.getValor("codigo.modulo.GE"));
			parametrosGrales.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGrales.setNombreparametro(global.getValor("parametro.formato.fecha1"));
			parametrosGrales=parametrosGeneralesBO.getParametroGeneral(parametrosGrales);
			
			RegistroFacturacionDTO registroFacturacionDTO = new RegistroFacturacionDTO();
			registroFacturacionDTO.setCodigoCicloFacturacion(clienteDTO.getCodigoCiclo());
			registroFacturacionDTO.setFormatoFecha(parametrosGrales.getValorparametro());
			
			registroFacturacionDTO = registroFacturacionBO.getDiasProrrateo(registroFacturacionDTO);
			if (registroFacturacionDTO!=null){
				fImportePlan = (fImportePlan * registroFacturacionDTO.getDiasDiferencia()/ registroFacturacionDTO.getDiasProrrateo());
			}
			intCentralDTO.setPlan(planTarifario.getPlanComverse()==null?planTarifario.getCodigoPlanTarifario():planTarifario.getPlanComverse());
		}
		//intCentralDTO.setPlan(planTarifario.getPlanComverse()==null?planTarifario.getCodigoPlanTarifario():planTarifario.getPlanComverse());
		
		RegistroFacturacionDTO registroFacturacionDTO2 = new RegistroFacturacionDTO();
		registroFacturacionDTO2.setCodigoCliente(String.valueOf(parametros.getCodCliente().longValue()));
		registroFacturacionDTO2.setCodigoOficina(parametros.getCodOficina());
		Double  dValorImporteAux = new Double(Math.round(fImportePlan*Math.pow(10,parametros.getNumDecimalBD()))/Math.pow(10,parametros.getNumDecimalBD()));
		fImportePlan =  dValorImporteAux.floatValue();
		registroFacturacionDTO2.setImportePlan(fImportePlan);
		registroFacturacionDTO2 = registroFacturacionBO.aplicaImpuestoImporte(registroFacturacionDTO2);
		
		if (registroFacturacionDTO2!=null)
			fImportePlan = registroFacturacionDTO2.getImporteTotal();
		
		if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido()))
		{
			intCentralDTO.setValorPlan(fImportePlan);
			//solo prepagos
			/*SimcardSNPNDTO SimcardSNPNDTO = new SimcardSNPNDTO();
			SimcardSNPNDTO.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
			SimcardSNPNDTO = simcardBO.getSimcard(SimcardSNPNDTO);
			intCentralDTO.setCarga(simcard.getCarga());*/
			
		}
		
		
		interfazCentralBO.provisionaLinea(intCentralDTO);
		enviaMovtoSSCentrales(parametros);
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		logger.debug("provisionandoLinea():fin");
	}
	catch (GeneralException e) {
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		logger.debug("GeneralException[", e);
		throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	}
	catch (Exception e) {
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		logger.debug("Exception[", e);
		throw new GeneralException(e);
	}
	}//fin provicionandoLinea
	
	
	/**
	 * Metodo que envia movimiento a centrales, relacionado a los servicios suplementarios
	 * @param datosVenta abonado
	 * @return void
	 * @throws CustomerDomainException, ProductDomainException,ResourceDomainException
	 */	
	private void enviaMovtoSSCentrales(GaVentasDTO datosVenta) 
	throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		logger.debug("Inicio:enviaMovtoSSCentrales()");

		InterfazCentralDTO intCentralDTO = new InterfazCentralDTO();
		DatosGeneralesDTO datosGrales = new DatosGeneralesDTO();
		
		SimcardSNPNDTO simcard = new SimcardSNPNDTO();
		datosGrales = new DatosGeneralesDTO();

		String valorAuntentificacion = null;
        String numeroMin = null;
        String actuacionServSupl = null;
        String actuacionCentral = null;
        String actuacionCentralSS = null;
        String cadenaSS = null;
        
	    //-- VERIFICA SERVICIO 460001
        //---------------------------
		valorAuntentificacion = "0";
		ParametrosGeneralesDTO parametrosGrales = new ParametrosGeneralesDTO();
		parametrosGrales.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGrales.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGrales.setNombreparametro(global.getValor("parametro.ind.autentificacion"));
		parametrosGrales = parametrosGeneralesBO.getParametroGeneral(parametrosGrales);
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		valorAuntentificacion = parametrosGrales.getValorparametro();	    	

		if (valorAuntentificacion==null) 
	    	valorAuntentificacion = "0";
	    	
	    //-- OBTIENE PREFIJO DEL NUM_MIN DE GA_ABOCEL
        //-------------------------------------------
	    numeroMin = datosVenta.getAbonado().getNumMin();

	    if (numeroMin.equals(""))
	    	logger.debug("enviaMovtoSSCentrales: No existe Prefijo asociado al Abonado");
	    
	    //-- OBTIENE CODIGO ACTUACION SERVICIOS SUPLEMENTARIOS
        //----------------------------------------------------
	    actuacionServSupl = global.getValor("codigo.actuacion.servsupl");

	    //-- OBTIENE CODIGO ACTUACION CENTRAL PARA LA ACTUACION DEL ABONADO Y TECNOLOGIA
        //------------------------------------------------------------------------------
	    DatosGeneralesDTO datos = new DatosGeneralesDTO();
	    datos.setCodigoProducto(global.getValor("codigo.producto"));
	    datos.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
	    datos.setCodigoActuacionAbonado(global.getValor("codigo.actuacion.venta"));
	    datos = datosGeneralesBO.getActuacionCentral(datos);
	    actuacionCentral = datos.getCodigoActuacionCentral();
	    logger.debug("actuacionCentral: " + actuacionCentral);
	    
	    datos = new DatosGeneralesDTO();
	    datos.setCodigoProducto(global.getValor("codigo.producto"));
	    datos.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
	    datos.setCodigoActuacionAbonado(global.getValor("codigo.actuacion.servsupl"));
	    datos = datosGeneralesBO.getActuacionCentral(datos);
	    UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
	    actuacionCentralSS = datos.getCodigoActuacionCentral();
	    logger.debug("actuacionCentralSS: " + actuacionCentralSS);
	    
	    //-- OBTIENE SERVICIOS SUPLEMENTARIOS PARA ENVIAR A CENTRALES 
        //-----------------------------------------------------------
	    ServicioSuplementarioDTO entradaServSupl = new ServicioSuplementarioDTO();
		entradaServSupl.setNumeroAbonado(String.valueOf(datosVenta.getAbonado().getNumAbonado()));
		entradaServSupl.setIndicadorEstado(Integer.parseInt(global.getValor("codigo.estado.alta_bd")));
		
		entradaServSupl.setCodigoProducto(global.getValor("codigo.producto"));
		entradaServSupl.setCodigoModulo(global.getValor("codigo.modulo.GA"));
		entradaServSupl.setCodigoSistema(Integer.parseInt(global.getValor("codigo.sistema")));
		entradaServSupl.setCodigoActuacion(actuacionCentral);
		
		ServicioSuplementarioDTO[] listaServiciosSuplemantarios = servicioSuplementarioBO.getSSAbonadoParaCentrales(entradaServSupl);
		cadenaSS ="";
		for(int j=0;j<listaServiciosSuplemantarios.length;j++)
		{
			if ((listaServiciosSuplemantarios[j].getCodigoServSupl().equals("46")) && (Integer.parseInt(valorAuntentificacion) > 0)){
				//-- no se incluye, porque no fue seleccionado por el usuario, es por default. 
			}
			else{
				String s1 = completarString(listaServiciosSuplemantarios[j].getCodigoServSupl(),2,"0","I");
				String s2 = completarString(listaServiciosSuplemantarios[j].getCodigoNivel(),4,"0","I");
                cadenaSS = cadenaSS + s1 + s2;
			}
		}

	   	if (cadenaSS!=null && !cadenaSS.equals(""))
			logger.debug("enviaMovtoSSCentrales: Insertando movimiento...");
	   	
		//-- INSERTA MOVIMIENTO PARA CENTRALES
        //------------------------------------
		/*Obtiene secuencia movimiento a centrales */
		datosGrales.setCodigoSecuencia(global.getValor("secuencia.movimiento.central"));
		datosGrales = datosGeneralesBO.getSecuencia(datosGrales);
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		intCentralDTO.setNumeroMovimiento(datosGrales.getSecuencia());
		intCentralDTO.setNumeroMovtoAnterior(datosVenta.getNumeroMovtoAnterior());
		intCentralDTO.setNumeroAbonado(datosVenta.getAbonado().getNumAbonado());
		intCentralDTO.setCodigoEstado(Integer.parseInt(global.getValor("codigo.estado.alta_bd")));
		intCentralDTO.setCodActabo(actuacionServSupl);
		intCentralDTO.setCodigoModulo(global.getValor("codigo.modulo.GA"));
		intCentralDTO.setCodigoActuacion(actuacionCentralSS);
		intCentralDTO.setCodigoUsuario(datosVenta.getCodigoUsuario());

		Date fecha = new Date();
		Calendar cal = new GregorianCalendar(); 
	    cal.setTimeInMillis(fecha.getTime()); 
		//INICIO CSR-11002
//	    Date fechaIngreso = new Date(cal.getTimeInMillis()); 
//	    String fechaIngresoFormateada = Formatting.dateTime(fechaIngreso,"dd/MM/yyyy HH:mm:ss");
//	    intCentralDTO.setFechaIngreso(fechaIngresoFormateada);
		intCentralDTO.setFechaIngreso(new java.sql.Timestamp( cal.getTimeInMillis()));
		//FIN CSR-11002
		
		intCentralDTO.setTipoTerminal(datosVenta.getParametroCodigoSimcardGSM());
		intCentralDTO.setCodigoCentral(datosVenta.getAbonado().getCodCentral());
		intCentralDTO.setNumeroCelular(datosVenta.getAbonado().getNumCelular());
		intCentralDTO.setNumeroSerie(datosVenta.getAbonado().getNumSerieSimcard());
		intCentralDTO.setCodigoServicio(cadenaSS);
		intCentralDTO.setNumMin(datosVenta.getAbonado().getNumMin());
		
		CentralDTO central = new CentralDTO();
		central.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		central.setCodigoCentral(String.valueOf(datosVenta.getAbonado().getCodCentral()));
		central = centralBO.getCentral(central);
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		intCentralDTO.setTipoTecnologia(central.getCodigoTecnologia());
		
		simcard.setNumeroSerie(datosVenta.getAbonado().getNumSerieSimcard());
		simcard.setCodigoImsi(global.getValor("codigo.imsi"));
		simcard = simcardBO.getImsiSimcard(simcard);
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		intCentralDTO.setImsi(simcard.getValorImsi());
		intCentralDTO.setImei(datosVenta.getAbonado().getNumSerieTerminal());
		intCentralDTO.setIcc(datosVenta.getAbonado().getNumSerieSimcard());
		
		interfazCentralBO.provisionaLinea(intCentralDTO);	    
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		
		//-- Actualiza clase servicio del abonado 
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNumAbonado(datosVenta.getAbonado().getNumAbonado());
		
		//Completa la cadena de clase servicio con los SS no enviados a centrales
		ServicioSuplementarioDTO[] servicioSuplementarioDTOs = servicioSuplementarioBO.getSSAbonadoNoCentrales(entradaServSupl);
		for(int j=0;j<servicioSuplementarioDTOs.length;j++)
		{
			cadenaSS = cadenaSS + servicioSuplementarioDTOs[j].getCadSSNivel();
		}
		
		abonado.setClaseServicio(cadenaSS);
		abonadoBO.updAbonadoClaseServ(abonado);
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		logger.debug("Fin:enviaMovtoSSCentrales()");
	}//fin enviaMovtoSSCentrales
	
	/**
	 * Metodo que completa un string con un caracter especifico.
	 * @param stringEntrada: string inicial
	 *        largoMaximoString : largo final del string de salida
	 *        caracter : caracter que sera de relleno
	 *        direccion : I (completar a la izquierda) D (completar a la derecha)
	 * @return String
	 * @throws CustomerDomainException, ProductDomainException
	 */	
	private String completarString(String stringEntrada,int largoMaximoString,String caracter,String direccion){
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));	
		String stringFinal = null;
		int diferencia;
		
		stringFinal = stringEntrada;
		diferencia = largoMaximoString - stringEntrada.length();
		
		if (direccion.equals("I")){
		// completar a la izquierda
			for (int i=1;i<=diferencia;i++)
				stringFinal = caracter + stringFinal;
		}
		else{
		// completar a la derecha
			for (int d=1;d<=diferencia;d++)
				stringFinal = stringFinal + caracter;
		}
		return stringFinal;
	}//fin completarString
	
	public void insertVenta(GaVentasDTO gaVentasDTO)throws GeneralException{ 
		try{
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("insertVenta:start");			
			gaVentasDTO.setCodOperadora(BODatosgenerales.getCodigoOperadora());
			BORegistroVenta.insertVenta(gaVentasDTO);			
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("insertVenta:end");
		
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}

	public ResultadoValidacionVentaDTO getValidaVendedorBodegaTerminal(ParametrosValidacionVentasDTO inValueDTO)throws GeneralException{ 
		UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
		ResultadoValidacionVentaDTO retValue=null;
		try{
			logger.debug("getValidaBodegaVendedor:start");
			retValue=vendedorBO.vendedorExisteEnBodegaTerminal(inValueDTO);			
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));
			logger.debug("getValidaBodegaVendedor:end");
		
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVendedoresSRV.log"));				
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
		
}
