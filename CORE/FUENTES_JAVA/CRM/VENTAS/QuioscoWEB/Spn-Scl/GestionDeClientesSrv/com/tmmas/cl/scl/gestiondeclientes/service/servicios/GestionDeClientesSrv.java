package com.tmmas.cl.scl.gestiondeclientes.service.servicios;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;


import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.AbonadoBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.ArticuloBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.CeldaBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.ContratoBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.PlanTarifarioBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.RegistroVentaBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.SerieBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.SerieKitBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.ServicioSuplementarioBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.SimcardBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.TerminalBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.TipoStockSerieBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.UsuarioBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoActivoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CantidadStockSerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CelularDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosCargoSimcardDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosCargoTerminalDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosValidacionTasacionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanUsoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ProcesoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionTasacionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingOUTDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieKitDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ServicioSuplementarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TipoStockValidoDTO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.CausalDescuentoBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.CentralBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.ClienteBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.ConceptosCobranzaBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.CuentaBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.FacturacionBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.InterfazCentralBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.ModalidadPagoBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.PlanComercialBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.RegistroFacturacionBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.TasacionBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.VendedorBO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.BodegaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CeldaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionCuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteImpDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ConceptosCobranzaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ContratoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DireccionCentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.FaMensProcesoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaDocVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GeModVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.HomeLineaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.InterfazCentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.PagosUltimosMesesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosAnulacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.PlanComercialDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SucursalBancoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SumaPrecioPlanesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.TipoContratoClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.UsuarioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WSValidarTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsBancoInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCicloFactInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuentaIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuentaIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCicloFactOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsMotivosDeDescuentoManualInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClienteIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsContratoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInfoComercialClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsLinkDocumentoInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsLinkDocumentoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListClienteIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCuotaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListModalidadPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsRespuestaValidacionCuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsValTarjetaInDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.bo.DatosGeneralesBO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.bo.ParametrosAuditoriaBO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.bo.ParametrosGeneralesBO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.EstadoAsincDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.EstadoCivilDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.OcupacionDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;


public class GestionDeClientesSrv {


	private AbonadoBO               BOAbonado               = new AbonadoBO();
	private CuentaBO                BOCuenta                = new CuentaBO();
	private ClienteBO               BOCliente               = new ClienteBO();
	private ConceptosCobranzaBO     BOconceptosCobranza     = new ConceptosCobranzaBO();
	private ParametrosGeneralesBO   BOParametrosGenerales   = new ParametrosGeneralesBO();
	private PlanComercialBO         BOPlanComercial         = new PlanComercialBO();
	private PlanTarifarioBO         BOPlanTarifario         = new PlanTarifarioBO();
	private TerminalBO              BOTerminal              = new TerminalBO();
	private TipoStockSerieBO        BOTipoStockSerie        = new TipoStockSerieBO();
	private SimcardBO               BOSimcard               = new SimcardBO();
	private VendedorBO              BOVendedor              = new VendedorBO();
	private RegistroVentaBO         BORegistroVenta         = new RegistroVentaBO();
	private ContratoBO              BOContrato              = new ContratoBO();
	private CeldaBO                 BOCelda                 = new CeldaBO();
	private TasacionBO              BOTasacion              = new TasacionBO();
	private InterfazCentralBO       BOInterfazCentral       = new InterfazCentralBO(); 
	private DatosGeneralesBO        BODatosgenerales        = new DatosGeneralesBO();
	private CentralBO               BOCentral               = new CentralBO();
	private RegistroFacturacionBO   BORegistroFacturacion   = new RegistroFacturacionBO(); 
	private ServicioSuplementarioBO BOServicioSuplementario = new ServicioSuplementarioBO();
	private UsuarioBO               BOUsuario               = new UsuarioBO();
	private ParametrosAuditoriaBO   bOParametrosAuditoriaBO = new ParametrosAuditoriaBO();
	private ModalidadPagoBO         BOModalidadPago         = new ModalidadPagoBO();
	private FacturacionBO           FacturacionBO           = new FacturacionBO();
	private CausalDescuentoBO       BOCausalDescuento       = new CausalDescuentoBO();
	private SerieBO                 BOSerie                 = new SerieBO();
	private SerieKitBO              BOSerieKit              = new SerieKitBO();
	private ArticuloBO              BOArticulo              = new ArticuloBO();

	private final Logger logger = Logger.getLogger(GestionDeClientesSrv.class);
	private CompositeConfiguration config;

	public GestionDeClientesSrv() {
		System.out.println("GestionDeClientesSrv(): Start");
		config = UtilProperty.getConfiguration("GestionDeClientesSRV.properties","com/tmmas/cl/scl/gestiondeclientes/service/properties/servicios.properties");
		System.out.println("GestionDeClientesSrv.log ["+config.getString("GestionDeClientesSrv.log")+"]");
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("GestionDeClientesSrv():End");
	}	



	/*public CuentaComDTO crearCuentaCliente(CuentaComDTO cuentaComDTO) throws GeneralException,
	RemoteException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		logger.debug("Inicio:crearCliente()");
		try {

			//Verifica si la cuenta existe o no en BD
			cuentaComDTO = getCuenta(cuentaComDTO);
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));			
			//Si la cuenta no existe se registra en BD
			if (cuentaComDTO.getCodigoCuenta().equals("0")){
				cuentaComDTO.setIndicadorEstado(config.getString("indicador.estado.cuenta"));
				cuentaComDTO.setIndicadorMultUso(config.getString("indicador.multiuso"));
				cuentaComDTO.setClientePotencial(config.getString("indicador.cliente.potencial"));				
				crearCuenta(cuentaComDTO);
				UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));				
				if (cuentaComDTO.getClienteComDTO()!=null){
					cuentaComDTO.setCodigoCuenta(cuentaComDTO.getCodigoCuenta());
				}
			}
			else{

				if (!BOCuenta.getValSubCuenta(cuentaComDTO)){
					crearSubCuenta(cuentaComDTO);
				}

				cuentaComDTO = categorizacionCuenta(cuentaComDTO);
				UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));				
			}


			if (cuentaComDTO.getClienteComDTO()!=null){




				cuentaComDTO.getClienteComDTO().setIndicadorAgente(config.getString("indicador.agente"));
				cuentaComDTO.getClienteComDTO().setIndicadorSituacion(config.getString("indicador.situacion"));
				cuentaComDTO.getClienteComDTO().setIndicadorAcepVenta(config.getString("indicador.aceptacion.venta"));

				if (cuentaComDTO.getClienteComDTO().getCodigoTipoPlan().equals("1")){				
					cuentaComDTO.getClienteComDTO().setIndicadorAlta("M");
				}else{
					cuentaComDTO.getClienteComDTO().setIndicadorAlta("V");
				}
				//cuentaComDTO.getClienteComDTO().setIndicadorAlta(config.getString("indicador.alta.venta"));
				cuentaComDTO.getClienteComDTO().setIndicadorTraspaso(config.getString("indicador.traspaso.si").trim());
				cuentaComDTO.getClienteComDTO().setCodigoModificacion(config.getString("codigo.modificacion.cliente"));
				cuentaComDTO.getClienteComDTO().setIndentificadorSegmento(config.getString("id.segmento.defecto"));								


				//Obtiene secuencia del cliente
				DatosGeneralesDTO datosGeneralesDTO = null;
				cuentaComDTO.getClienteComDTO().setCodigoOperadora(BODatosgenerales.getCodigoOperadora());
				//Obtiene calidad
				datosGeneralesDTO = new DatosGeneralesDTO();
				datosGeneralesDTO.setColumna(config.getString("parametro.calidad.defecto"));
				datosGeneralesDTO = BODatosgenerales.getDatosGener(datosGeneralesDTO);
				cuentaComDTO.getClienteComDTO().setCodigoCalidadCliente(datosGeneralesDTO.getValorParametro());


				PlanComercialDTO planComercia = new PlanComercialDTO();  

				planComercia.setCodigoCalifCliente(cuentaComDTO.getClienteComDTO().getCodigoCalidadCliente());
				planComercia = BOPlanComercial.getPlanComercial(planComercia);

				cuentaComDTO.getClienteComDTO().setCodigoPlanComercial(String.valueOf(planComercia.getCodigoPlanComercial()));

				cuentaComDTO.getClienteComDTO().setNumeroAbocel(config.getString("numero.abocel"));
				cuentaComDTO.getClienteComDTO().setCodigoNPI(config.getString("codigo.npi"));						

				//Registra Cliente


				if (cuentaComDTO.getClienteComDTO().getCodigoCliente().equals("0")){
					datosGeneralesDTO = new DatosGeneralesDTO();
					datosGeneralesDTO.setCodigoSecuencia(config.getString("secuencia.cliente"));				
					datosGeneralesDTO = BODatosgenerales.getSecuencia(datosGeneralesDTO);
					cuentaComDTO.getClienteComDTO().setCodigoCliente(String.valueOf(datosGeneralesDTO.getSecuencia()));
					BOCliente.insCliente(cuentaComDTO);
					if (cuentaComDTO.getClienteComDTO().getModalidadCancelacionComDTO().getCodigo().equals(config.getString("modalidad.cancelacion.automatica.ind"))
							&& cuentaComDTO.getClienteComDTO().getCodigoSistemaPago().equals(config.getString("sistema.pago.ctacte")))
					{
						ConceptosCobranzaDTO conceptosCobranzaDTO = new ConceptosCobranzaDTO();

						conceptosCobranzaDTO.setCodigoCliente(cuentaComDTO.getClienteComDTO().getCodigoCliente());
						conceptosCobranzaDTO.setCodigoBanco(cuentaComDTO.getClienteComDTO().getCodigoBanco());
						conceptosCobranzaDTO.setNumeroTelefono(cuentaComDTO.getClienteComDTO().getCodigoCliente());//En VB esta así. 
						conceptosCobranzaDTO.setCodigoZona(config.getString("pac.codigo.zona"));
						conceptosCobranzaDTO.setCodigoBcoi(config.getString("pac.codigo.bancoi"));
						conceptosCobranzaDTO.setCodigoCentral(config.getString("pac.codigo.central"));
						BOconceptosCobranza.insPagoAutomatico(conceptosCobranzaDTO);
					}
				}else{
					CuentaComDTO cuentanueva = new CuentaComDTO();
					cuentanueva = BOCliente.getCliente(cuentaComDTO);

					if (cuentaComDTO.getClienteComDTO().getTipoPlanTarifario().equals("E")){
						cuentanueva = BOCliente.getEmpresa(cuentanueva);
						if (!cuentanueva.getClienteComDTO().getCodigoPlanTarifario().equals(cuentaComDTO.getClienteComDTO().getCodigoPlanTarifario())){
							throw new GeneralException ("12342",0,"Error de plan tarifario en plan empresa");
						}

						cuentanueva.getClienteComDTO().setNumeroAbonados(cuentanueva.getClienteComDTO().getNumeroAbonados()+cuentaComDTO.getClienteComDTO().getNumeroAbonados());					
						BOCliente.udpEmpresa(cuentanueva);
					}

					if (cuentanueva.getCodigoCuenta().equals(cuentaComDTO.getCodigoCuenta())){

						if (!cuentanueva.getClienteComDTO().getIndicadorAlta().equals(cuentaComDTO.getClienteComDTO().getIndicadorAlta())){
							logger.debug("Error en indicador de Alta de Cliente");
							throw new GeneralException("12343",0,"Error en indicador de Alta de Cliente");
						}

						cuentanueva.getClienteComDTO().setLinea(cuentaComDTO.getClienteComDTO().getLinea());						
						cuentanueva.getClienteComDTO().setTipoCliente(cuentaComDTO.getClienteComDTO().getTipoCliente());
						cuentanueva.getClienteComDTO().setPlanTarifario(cuentaComDTO.getClienteComDTO().getPlanTarifario());
						cuentanueva.getClienteComDTO().setCodigoCategoriaEmpresa(cuentaComDTO.getClienteComDTO().getCodigoCategoriaEmpresa());

						/*cuentanueva.getClienteComDTO().setCodigoBanco(cuentaComDTO.getClienteComDTO().getCodigoBanco());
						cuentanueva.getClienteComDTO().setCodigoSucursal(cuentaComDTO.getClienteComDTO().getCodigoSucursal());
						cuentanueva.getClienteComDTO().setNumeroTarjeta(cuentaComDTO.getClienteComDTO().getNumeroTarjeta());
						cuentanueva.getClienteComDTO().setCodigoTipoTarjeta(cuentaComDTO.getClienteComDTO().getCodigoTipoTarjeta());						
						cuentanueva.getClienteComDTO().setFechaVencimientoTarjeta(cuentaComDTO.getClienteComDTO().getFechaVencimientoTarjeta());
						cuentanueva.getClienteComDTO().setNumeroCuentaCorriente(cuentaComDTO.getClienteComDTO().getNumeroCuentaCorriente());*/


	/*logger.debug("cuentanueva.getClienteComDTO().getCodigoBanco() ["+cuentanueva.getClienteComDTO().getCodigoBanco()+"]");
						logger.debug("cuentanueva.getClienteComDTO().getCodigoSucursal() ["+cuentanueva.getClienteComDTO().getCodigoSucursal()+"]");
						logger.debug("cuentanueva.getClienteComDTO().getNumeroTarjeta() ["+cuentanueva.getClienteComDTO().getNumeroTarjeta()+"]");
						logger.debug("cuentanueva.getClienteComDTO().getCodigoTipoTarjeta() ["+cuentanueva.getClienteComDTO().getCodigoTipoTarjeta()+"]");
						logger.debug("cuentanueva.getClienteComDTO().getFechaVencimientoTarjeta() ["+cuentanueva.getClienteComDTO().getFechaVencimientoTarjeta()+"]");
						logger.debug("cuentanueva.getClienteComDTO().getNumeroCuentaCorriente() ["+cuentanueva.getClienteComDTO().getNumeroCuentaCorriente()+"]");
						cuentaComDTO.setClienteComDTO(cuentanueva.getClienteComDTO());
					}else{
						logger.debug("Error la cuenta no corresponde al cliente CTAA ["+cuentaComDTO.getCodigoCuenta()+"] CTAN ["+cuentanueva.getCodigoCuenta()+"]");
						throw new GeneralException("12344",0,"Error la cuenta no corresponde al cliente ");
					}


				}

			}					
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:crearCliente()");
		return cuentaComDTO;
	}*/

	public void crearCuenta(CuentaComDTO cuentaComDTO) throws GeneralException {
		try{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));			
			logger.debug("Inicio:crearCuenta()");
			//Obtiene secuencia de la cuenta
			DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoSecuencia(config.getString("secuencia.cuenta"));
			DatosGeneralesBO datosGeneralesBO = new DatosGeneralesBO();
			datosGeneralesDTO = datosGeneralesBO.getSecuencia(datosGeneralesDTO);
			cuentaComDTO.setCodigoCuenta(String.valueOf(datosGeneralesDTO.getSecuencia())); 
			BOCuenta.insCuenta(cuentaComDTO);
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			crearSubCuenta(cuentaComDTO);			
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
		logger.debug("Fin:crearCuenta()");

	}	

	private void crearSubCuenta(CuentaComDTO cuentaDTO) throws GeneralException {
		try{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));			
			logger.debug("Inicio:crearSubCuenta()");
			cuentaDTO.setCodigoSubCuenta(cuentaDTO.getCodigoCuenta() + ".1");
			if (cuentaDTO.getDescripcionCuenta().length() > 15) {
				cuentaDTO.setDescripcionSubCuenta(cuentaDTO.getDescripcionCuenta().substring(0, 15));
			}
			else{
				cuentaDTO.setDescripcionSubCuenta(cuentaDTO.getDescripcionCuenta());
			}

			BOCuenta.insSubCuenta(cuentaDTO);
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:crearSubCuenta()");
	}


	public CuentaComDTO getCuenta(CuentaComDTO cuentaComDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		try{			
			logger.debug("Inicio:getCuenta()");
			cuentaComDTO = BOCuenta.valExisCuentaIdent(cuentaComDTO);
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getCuenta()");
		return cuentaComDTO;
	}//fin getCuenta



	private CuentaComDTO categorizacionCuenta(CuentaComDTO cuentaComDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		ParametrosGeneralesDTO parametrosGeneralesDTO =null;
		try{
			logger.debug("Inicio:categorizacionCuenta()");
			if(cuentaComDTO.getCodigoCategoria() ==null || cuentaComDTO.getCodigoCategoria().equals("0")){	
				cuentaComDTO.setTipoModulo(config.getString("tipo.modulo"));
				cuentaComDTO= BOCuenta.getCategoriaCuenta(cuentaComDTO);
				UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));					
			}
			else{
				if(cuentaComDTO.getCodigoCategoria() !=null && !cuentaComDTO.getCodigoCategoria().equals("0")){
					//Actualiza datos de la cuenta.
					BOCuenta.actualizaCuenta(cuentaComDTO);
					UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));						
					//Actualiza categorias de los clientes											
					//cuentaComDTO.getClienteComDTO().setCodigoCategoria(cuentaComDTO.getCodigoCategoria());
					cuentaComDTO.setCodigoCuenta(cuentaComDTO.getCodigoCuenta());

					BOCliente.actualizaCategoriasClientes(cuentaComDTO);
					UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));						
					//Actualiza codigo uso de los clientes asociados a la cuenta.

					if (cuentaComDTO.getIndicadorMultUso().equals(config.getString("indicador.multiuso"))){
						parametrosGeneralesDTO = new ParametrosGeneralesDTO();		
						parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.uso.venta"));
						parametrosGeneralesDTO.setCodigomodulo(config.getString("codigo.modulo.GA"));
						parametrosGeneralesDTO.setCodigoproducto(config.getString("codigo.producto"));
						parametrosGeneralesDTO = BOParametrosGenerales.getParametroGeneral(parametrosGeneralesDTO);

						cuentaComDTO.getClienteComDTO().setCodigoUso(parametrosGeneralesDTO.getValorparametro());
						//cuentaComDTO.getClienteComDTO().setCodigoCategoria(cuentaComDTO.getCodigoCategoria());
						BOCliente.actualizaCodigoUsoClientes(cuentaComDTO);
						UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));							
					}

					parametrosGeneralesDTO = new ParametrosGeneralesDTO();		
					parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.indicador.subcatimp"));
					parametrosGeneralesDTO.setCodigomodulo(config.getString("codigo.modulo.GA"));
					parametrosGeneralesDTO.setCodigoproducto(config.getString("codigo.producto"));
					parametrosGeneralesDTO = BOParametrosGenerales.getParametroGeneral(parametrosGeneralesDTO);
					UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));						
					//Actualiza subcategoria impositiva del cliente.
					if (parametrosGeneralesDTO.getValorparametro().equals("TRUE")){


						cuentaComDTO.getClienteComDTO().setCodigoSubCategoria(cuentaComDTO.getCodigoSubCategoria());
						BOCliente.actualizaSubCategoriaImpositiva(cuentaComDTO.getClienteComDTO());
					}
					//Elimina cliente potencial
					if (cuentaComDTO.getClientePotencial().equals(config.getString("cliente.potencial"))){
						BOCuenta.eliminaCuentasPotenciales(cuentaComDTO);
						UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));							
					}
				}
			}

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:categorizacionCuenta()");
		return cuentaComDTO;
	}//fin categorizacionCuenta	


	public CuentaDTO[] getSubCuentaPorCodCliente(ClienteDTO clienteDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		CuentaDTO[] retValue=null;
		try{
			retValue=BOCuenta.getSubCuentaPorCodCliente(clienteDTO);

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsListTarjetaOutDTO getListadoTarjetas() throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsListTarjetaOutDTO retValue=null;
		try{
			retValue=BOCliente.getListadoTarjetas();

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsListModalidadPagoOutDTO getListadoModalidadPago() throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsListModalidadPagoOutDTO retValue=null;
		try{
			retValue=BOCliente.getListadoModalidadPago();

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsListBancoOutDTO getListadoBancosPAC(WsBancoInDTO wsBanco) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsListBancoOutDTO retValue=null;
		try{
			logger.debug("wsBancoInDTO.getIndPAC ["+wsBanco.getIndPAC()+"]");
			retValue=BOCliente.getListadoBancosPAC(wsBanco);

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsListCuotaOutDTO getListadoCuotas() throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsListCuotaOutDTO retValue=null;
		try{
			retValue=BOCliente.getListadoCuotas();

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	public WsContratoOutDTO[] getListVigenciasContratos()throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsContratoOutDTO[] retValue =null;

		try{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			retValue = BOCliente.getListVigenciasContratos();
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Fin:getListVigenciasContratos()");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public GeModVentaDTO[] getListModalidadVenta()throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		GeModVentaDTO[] retValue =null;

		try{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			retValue = BOCliente.getListModalidadVenta();
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Fin:getListModalidadVenta()");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(WsPlanTarifarioInDTO inWSLstPlanTarifDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsListPlanTarifarioOutDTO retValue =null;

		try{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			retValue = BOPlanTarifario.getListadoPlanesTarifarios(inWSLstPlanTarifDTO);
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Fin:getListadoPlanesTarifarios()");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsListTipoPlanTarifarioOutDTO getListadoTiposPlanesTarifarios()throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsListTipoPlanTarifarioOutDTO retValue =null;

		try{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			retValue = BOPlanTarifario.getListadoTiposPlanesTarifarios();
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Fin:getListadoTiposPlanesTarifarios()");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}	

	public WsListClienteIdentOutDTO getListadoClientesXIdentificacion(WsClienteIdentInDTO cliente)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsListClienteIdentOutDTO retValue =null;

		try{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			retValue = BOCliente.getListadoClientesXIdentificacion(cliente);
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}	


	/*--------------------------------------------------------------------------------------------Validaciones--------------------------------------------------------------------------------*/




	public ResultadoValidacionLogisticaDTO validacionesSerieSimcard(ParametrosValidacionLogisticaDTO parametrosEntrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:validacionesSerieSimcard()");

		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		//Valida el largo de la serie Simcard
		parametrosEntrada.setCodigoProducto(config.getString("codigo.producto"));		
		if(parametrosEntrada.getLargoSerieSimcard() == parametrosEntrada.getNumeroSerie().length())
		{
			SimcardSNPNDTO simcard = new SimcardSNPNDTO();
			
			if (parametrosEntrada.getNumeroSerieKit().equals("")){
				
				simcard.setNumeroSerie(parametrosEntrada.getNumeroSerie());
			    simcard = BOSimcard.getSimcard(simcard);
			    
			}else{
				SerieKitDTO serieKit = new SerieKitDTO();
				serieKit.setNumSerieKit(parametrosEntrada.getNumeroSerieKit());
				serieKit.setNumSerieSimcard(parametrosEntrada.getNumeroSerie());
				simcard = 	BOSerieKit.getSerieSimcardKit(serieKit);
			}

			//Verifica que la serie exista
			if(simcard!=null)
			{
				//Verifica que la serie a vender sea nueva
				logger.debug("parametrosEntrada.getEstadoNuevoSimcard(): " + parametrosEntrada.getEstadoNuevoSimcard());
				logger.debug("simcard.getEstado(): " + simcard.getEstado());
				if(simcard.getEstado().equals(parametrosEntrada.getEstadoNuevoSimcard()) ||  simcard.getNumeroCelular().length() > 5  )
				{

					//Verifica que el uso de la serie corresponda a venta pospago o hibrido

					PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
					planTarifario.setCodigoProducto(parametrosEntrada.getCodigoProducto());
					planTarifario.setCodigoTecnologia(parametrosEntrada.getCodigoTecnologia());
					planTarifario.setCodigoPlanTarifario(parametrosEntrada.getCodigoPlanTarifario());
					planTarifario = BOPlanTarifario.getPlanTarifario(planTarifario);
					//Valida que el uso de la simcard corresponda al del plan tarifario

					logger.debug("planTarifario.getCodigoTipoPlan() ["+planTarifario.getCodigoTipoPlan()+"]");
					logger.debug("simcard.getCodigoUso() ["+simcard.getCodigoUso()+"]");												

					if (  (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.postpago"))
							&& parametrosEntrada.getUsoVentaPostpago().equals(simcard.getCodigoUso())    ) || 

							(planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.hibrido")) 
									&&	(parametrosEntrada.getUsoVentaHibrido().equals(simcard.getCodigoUso()) || parametrosEntrada.getUsoVentaPostpago().equals(simcard.getCodigoUso()))  ) 							
									|| 								
									(planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.prepago")) 
											&&	config.getString("parametro.usoVentaPrepago").equals(simcard.getCodigoUso()))																
											|| 
											simcard.getNumeroCelular()==null || simcard.getNumeroCelular().equals("0")
					)
					{


						TipoStockValidoDTO datosStockSerie=new TipoStockValidoDTO();
						datosStockSerie.setTipoStockaValidar(Integer.parseInt(simcard.getTipoStock()));
						datosStockSerie.setModalidadVenta(Integer.parseInt(parametrosEntrada.getCodigoModalidadVenta()));
						datosStockSerie.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto")));
						resultado=BOTipoStockSerie.validaTipoStockSerie(datosStockSerie);

						if (resultado.isResultado())
						{
							logger.debug("Simcard OK");	
							resultado.setEstado("OK");
							resultado.setDetalleEstado("-");
						}
						else
						{
							resultado.setEstado("NOK");
							resultado.setDetalleEstado("La serie simcard tiene un tipo de stock no permitido");
							logger.debug("La serie simcard tiene un tipo de stock no permitido");
							throw new GeneralException("12345",0,"La serie simcard tiene un tipo de stock no permitido");
						}
					}else{
						resultado.setEstado("NOK");
						resultado.setDetalleEstado("El uso de la simcard no corresponde al uso del plan tarifario");
						logger.debug("El uso de la simcard no corresponde al uso del plan tarifario");
						throw new GeneralException("12346",0,"El uso de la simcard no corresponde al uso del plan tarifario");
					}				
				}
				else
				{
					resultado.setEstado("NOK");
					resultado.setDetalleEstado("Serie Simcard No es Nueva");
					logger.debug("Serie Simcard No es Nueva");
					throw new GeneralException("12347",0,"Serie Simcard No es Nueva");

				}
			}
			else
			{
				resultado.setEstado("NOK");
				resultado.setDetalleEstado("Serie Simcard No Existe");
				logger.debug("Serie Simcard No Existe");
				throw new GeneralException("12348",0,"Serie Simcard No Existe");
			}
		}
		else
		{
			resultado = new ResultadoValidacionLogisticaDTO();
			resultado.setEstado("NOK");
			resultado.setDetalleEstado("Largo Serie Simcard Incorrecto");
			logger.debug("Largo Serie Simcard Incorrecto");
			throw new GeneralException("12349",0,"Largo Serie Simcard Incorrecto");
		}

		logger.debug("Fin:validacionesSerieSimcard()");
		return resultado;
	}	

	public ResultadoValidacionLogisticaDTO validacionesSerieTerminal(ParametrosValidacionLogisticaDTO parametrosEntrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:validacionesSerieTerminal()");

		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();

		parametrosEntrada.setCodigoProducto(config.getString("codigo.producto"));
		parametrosEntrada.setCodigoModulo(config.getString("codigo.modulo.AL"));
		parametrosEntrada.setNombreParametro(config.getString("codigo.modulo.AL"));
		parametrosEntrada.setCodigoTecnologia(parametrosEntrada.getCodigoTecnologia());
		ResultadoValidacionVentaDTO resltadoV = new ResultadoValidacionVentaDTO();

		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Antes Largo Terminal");
		if(parametrosEntrada.getLargoSerieTerminal() == parametrosEntrada.getNumeroSerieTerminal().length())			
		{
			logger.debug("Largo Terminal Correcto");
			TerminalSNPNDTO terminal = new TerminalSNPNDTO();
			terminal.setNumeroSerie(parametrosEntrada.getNumeroSerieTerminal());

			resultado = BOTerminal.validaFormatoTerminalGSM(terminal);



			if (resultado.isResultado()){
				logger.debug("Formato Terminal Correcto");
				terminal = BOTerminal.getTerminal(terminal);

				resltadoV = BOTerminal.validaRepeticionTerminal(terminal);
				if(!resltadoV.isResultado()){			
					logger.debug("12355 - Serie terminal no puede ser nuevamente vendida");							
					resultado.setEstado("NOK");
					resultado.setDetalleEstado("Serie terminal no puede ser nuevamente vendida");
					throw new GeneralException("12355",0,"Serie terminal no puede ser nuevamente vendida");
				}
				
				if (config.getString("IMEI-DUMY").equals(parametrosEntrada.getNumeroSerieTerminal()) ){
					resltadoV = BOAbonado.validaSerieTermialEnListaNegra(terminal);					
				}else{
					resltadoV = new ResultadoValidacionVentaDTO();
					resltadoV.setResultado(false);
				}

				if(resltadoV.isResultado()){
					logger.debug("12356 - Serie terminal se encuentra en listas negras");
					resultado.setEstado("NOK");
					resultado.setDetalleEstado("Serie terminal se encuentra en listas negras");
					throw new GeneralException("12356",0,"Serie terminal se encuentra en listas negras");
				}					
				
				logger.debug("terminal.getIndProcEq() ["+terminal.getIndProcEq()+"]");
				logger.debug("config.getString(equipo.procedencia.interna) ["+config.getString("equipo.procedencia.interna")+"]");

				if (terminal.getIndProcEq().equals(config.getString("equipo.procedencia.interna"))){
					logger.debug("Terminal interno Correcto");
					//Verifica que el uso de la serie corresponda a venta pospago

					TipoStockValidoDTO datosStockSerie=new TipoStockValidoDTO();
					datosStockSerie.setTipoStockaValidar(Integer.parseInt(terminal.getTipoStock()));
					logger.debug("codigo modalidad de venta: " + parametrosEntrada.getCodigoModalidadVenta());
					datosStockSerie.setModalidadVenta(Integer.parseInt(parametrosEntrada.getCodigoModalidadVenta()));
					datosStockSerie.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto")));
					resultado=BOTipoStockSerie.validaTipoStockSerie(datosStockSerie);

					if (resultado.isResultado()){
						logger.debug("Terminal OK ultima instanciacion");
						resultado.setEstado("OK");
						resultado.setDetalleEstado("-");
					}
					else
					{
						resultado.setEstado("NOK");
						resultado.setDetalleEstado("La serie terminal tiene un tipo de stock no permitido");
						logger.debug("La serie terminal tiene un tipo de stock no permitido");
						throw new GeneralException("12350",0,"La serie terminal tiene un tipo de stock no permitido");
					}

					logger.debug("Antes de validar estado");
					if (!terminal.getEstado().equals("1")){
						logger.debug("22355 - Serie terminal debe ser nueva");							
						resultado.setEstado("NOK");
						resultado.setDetalleEstado("Serie terminal debe ser nueva");
						throw new GeneralException("22355",0,"Serie terminal debe ser nueva");
					}
					logger.debug("estado terminal correcto");								
				}
				else
				{
					resultado.setEstado("OK");
					resultado.setDetalleEstado("-");

				}
			}
			else
			{
				resultado.setEstado("NOK");
				resultado.setDetalleEstado("Formato de la serie del terminal no es valido");
				logger.debug("Formato de la serie del terminal no es valido");
				throw new GeneralException("12352",0,"Formato de la serie del terminal no es valido");				

			}

		}
		else
		{
			resultado.setEstado("NOK");
			resultado.setDetalleEstado("El largo de la serie terminal no es correcto");
			logger.debug("El largo de la serie terminal no es correcto ["+parametrosEntrada.getNumeroSerieTerminal().length()+"]");
			logger.debug("El largo de la serie terminal no es correcto ["+parametrosEntrada.getNumeroSerieTerminal()+"]");
			throw new GeneralException("12353",0,"El largo de la serie terminal no es correcto");			
		}
		logger.debug("Fin:validacionesSerieTerminal()");
		return resultado;
	}


	public ArrayList ValidaTermianlFacturacion(TerminalSNPNDTO terminal,ArrayList listaerrores)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));	
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		ResultadoValidacionVentaDTO resltadoV = new ResultadoValidacionVentaDTO();
		WsRespuestaValidacionCuentaDTO retorno;

		try{			
			resultado = BOTerminal.validaFormatoTerminalGSM(terminal);
			if (!resultado.isResultado()){			
				logger.debug("12354 - Error en Formato de Serie");
				retorno = new WsRespuestaValidacionCuentaDTO(); 
				retorno.setCodigoRespuesta("12354");
				retorno.setDescripcion("Error en Formato de Serie");						
				listaerrores.add(retorno);	
			}

			resltadoV = BOTerminal.validaRepeticionTerminal(terminal);
			if(!resltadoV.isResultado()){			
				logger.debug("12355 - Serie terminal no puede ser nuevamente vendida");
				retorno = new WsRespuestaValidacionCuentaDTO(); 
				retorno.setCodigoRespuesta("12355");
				retorno.setDescripcion("Serie terminal no puede ser nuevamente vendida");						
				listaerrores.add(retorno);	
			}

			resltadoV = BOAbonado.validaSerieTermialEnListaNegra(terminal);
			if(resltadoV.isResultado()){
				logger.debug("12356 - Serie terminal se encuentra en listas negras");
				retorno = new WsRespuestaValidacionCuentaDTO(); 
				retorno.setCodigoRespuesta("12356");
				retorno.setDescripcion("Serie terminal se encuentra en listas negras");						
				listaerrores.add(retorno);	
			}

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:validacionLinea()");

		return listaerrores;

	}


	public ResultadoValidacionTasacionDTO tasacionValidacionLinea(ParametrosValidacionTasacionDTO parametroEntrada)	
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		ResultadoValidacionTasacionDTO resultado = new ResultadoValidacionTasacionDTO();
		logger.debug("Inicio:ValidacionLinea()");
		parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
		parametroEntrada.setCodigoTecnologia(parametroEntrada.getCodigoTecnologia());

		resultado = BOPlanTarifario.existePlanTarifario(parametroEntrada);	
		if (!resultado.isResultado()){
			resultado.setEstado("NOK");
			resultado.setDetalleEstado("Codigo Plan Tarifario no existe o no es válido");
			logger.debug("Codigo Plan Tarifario no existe o no es válido");
			throw new GeneralException("12357",0,"Codigo Plan Tarifario no existe o no es válido");			
		}
		else{
			PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
			planTarifario.setCodigoProducto(parametroEntrada.getCodigoProducto());
			planTarifario.setCodigoTecnologia(parametroEntrada.getCodigoTecnologia());
			planTarifario.setCodigoPlanTarifario(parametroEntrada.getCodigoPlanTarifario());
			planTarifario = BOPlanTarifario.getPlanTarifario(planTarifario);
			if (planTarifario.getDescripcionPlanTarifario()!= null){
				ClienteDTO cliente = new ClienteDTO();
				cliente.setCodigoCliente(parametroEntrada.getCodigoCliente());
				cliente = BOCliente.getCliente(cliente);
				cliente.setTipoCliente(parametroEntrada.getTipoCliente());

				/*if (parametroEntrada.getTipoCliente().equals(config.getString("identificador.empresa"))
						&& !cliente.getCodigoPlanTarifario().equals(parametroEntrada.getCodigoPlanTarifario())){
					resultado.setEstado("NOK");
					resultado.setDetalleEstado("Plan Tarifario no corresponde al asignado a la Empresa");

				}else if(parametroEntrada.getTipoCliente().equals(config.getString("identificador.individual"))
						&& !planTarifario.getTipoPlanTarifario().equals(config.getString("identificador.individual"))){
					resultado.setEstado("NOK");
					resultado.setDetalleEstado("Plan Tarifario no es de tipo Individual");
				}
				else{*/	
				resultado.setImporteCargoBasico(planTarifario.getImporteCargoBasico());
				resultado.setTotalImporteCargoBasico(planTarifario.getImporteCargoBasico() + parametroEntrada.getTotalImporteCargoBasico());										

				logger.debug("TasacionSRV.validacionLinea --> NO aplica ev. de riesgo");
				resultado.setEstado("OK");
				resultado.setDetalleEstado("-");				
				/*}*/

			}else{
				resultado.setEstado("NOK");
				resultado.setDetalleEstado("Plan Tarifario es invalido");
				logger.debug("Plan Tarifario es invalido");
				throw new GeneralException("12358",0,"Plan Tarifario es invalido");
			}
		}
		logger.debug("Fin:ValidacionLinea()");
		return resultado;
	}

	public ResultadoValidacionVentaDTO ventasValidacionLinea(ParametrosValidacionVentasDTO entrada)
	throws GeneralException{
		ResultadoValidacionVentaDTO resultadoValidacion = null;
		logger.debug("*********************************Inicio:validacionLinea()******************************");
		logger.debug("Inicio:validacionLinea() : " + entrada.getNumeroSerie());
		logger.debug("numero de linea : " + entrada.getNumeroLinea());



		// ( 43 ) Verifica si serie simcard existe en abonado					
		resultadoValidacion = BOAbonado.existeSerieSimcardEnAbonado(entrada);
		if (resultadoValidacion.isResultado()){
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setDetalleEstado("Serie simcard existe en abonado");			
			logger.debug("Serie simcard existe en abonado");
			throw new GeneralException("12359",0,"Serie simcard existe en abonado");
		}

		//Valida que el vendedor tenga acceso a bodega de la simcard
		SimcardSNPNDTO  simcard = new SimcardSNPNDTO();
		logger.debug("entrada.getNumeroSerieKit() ["+entrada.getNumeroSerieKit()+"]");
		if (entrada.getNumeroSerieKit().equals("")){			
			logger.debug("Se Valida Sere de Simcarda");
			simcard.setNumeroSerie(entrada.getNumeroSerie());
			simcard = BOSimcard.getSimcard(simcard);
		}else{
			logger.debug("No Se Valida Sere de Simcarda");
			SerieKitDTO serieKit = new SerieKitDTO();
			serieKit.setNumSerieSimcard(entrada.getNumeroSerie());
			serieKit.setNumSerieKit(entrada.getNumeroSerieKit());
			simcard = BOSerieKit.getSerieSimcardKit(serieKit);
		}
		entrada.setCodigoBodega(simcard.getCodigoBodega());
		
		logger.debug("Antes de Validar Bodega Simcard entrada.getNumeroSerieKit() ["+entrada.getNumeroSerieKit()+"]");
		if (entrada.getNumeroSerieKit().equals("")){
			resultadoValidacion = BOVendedor.vendedorExisteEnBodegaSimcard(entrada);
			if (!resultadoValidacion.isResultado()){
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("Vendedor no tiene acceso a la bodega de la simcard");
				logger.debug("Vendedor no tiene acceso a la bodega de la simcard");
				throw new GeneralException("12360",0,"Vendedor no tiene acceso a la bodega de la simcard");
			}
		}
		//Obtiene datos del plan tarifario para obtener uso y otros
		String usoLinea = null;
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(entrada.getCodigoPlanTarifario());
		planTarifario.setCodigoProducto(config.getString("codigo.producto"));
		planTarifario.setCodigoTecnologia(entrada.getCodigoTecnologia());
		planTarifario = BOPlanTarifario.getPlanTarifario(planTarifario);

		if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.postpago"))){
			usoLinea =  config.getString("codigo.uso.postpago");
		}else if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.hibrido"))){
			usoLinea =  config.getString("codigo.uso.hibrido");
		}else if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.prepago"))){
			usoLinea =  config.getString("codigo.uso.prepago");
		}else{
			logger.debug("Error en el uso de la linea");
			throw new GeneralException("12361",0,"Error en el uso de la linea");
		}


		//-- OBTIENE PARAMETRO : PRECIO LISTA
		String sPrecioLista = config.getString("parametro.preciolista");

		//Valida que el articulo asociado a la simcard tenga configurado precio
		ParametrosCargoSimcardDTO parametrosCargoSimcardDTO = new ParametrosCargoSimcardDTO();
		parametrosCargoSimcardDTO.setCodigoArticulo(simcard.getCodigoArticulo());
		parametrosCargoSimcardDTO.setCodigoUso(usoLinea);
		parametrosCargoSimcardDTO.setTipoStock(simcard.getTipoStock());
		parametrosCargoSimcardDTO.setEstado("1");
		parametrosCargoSimcardDTO.setModalidadVenta(entrada.getCodigoModalidadVenta());
		parametrosCargoSimcardDTO.setTipoContrato(entrada.getCodigoTipoContrato());
		parametrosCargoSimcardDTO.setPlanTarifario(entrada.getCodigoPlanTarifario());
		parametrosCargoSimcardDTO.setCodigoUsoPrepago(config.getString("codigo.uso.prepago"));
		parametrosCargoSimcardDTO.setCodigoCategoria(simcard.getCodigoCategoria());
		parametrosCargoSimcardDTO.setIndicadorEquipo(config.getString("indicador.equiacc"));
		PrecioCargoDTO[] precioCargoDTOs = null;
		if (simcard.getIndicadorValorar().equals(config.getString("indicador.valoracion"))){
			try{

				if (sPrecioLista.equals(config.getString("indicador.precio.lista"))){
					parametrosCargoSimcardDTO.setIndiceRecambio(config.getString("indice.recambio.preciolista"));
					parametrosCargoSimcardDTO.setCodigoCategoria(config.getString("codigo.categoria"));
					precioCargoDTOs = BOSimcard.getPrecioCargoSimcard_PrecioLista(parametrosCargoSimcardDTO);
				}
				else{
					if (planTarifario.getCodigoTipoPlan().equals("1")){
						parametrosCargoSimcardDTO.setIndiceRecambio(config.getString("indice.recambio.preciolista"));
						parametrosCargoSimcardDTO.setCodigoCategoria(config.getString("codigo.categoria"));
						precioCargoDTOs = BOSimcard.getPrecioCargoSimcard_PrecioLista(parametrosCargoSimcardDTO);
					}else{
						parametrosCargoSimcardDTO.setIndiceRecambio(config.getString("indice.recambio.nolista"));
						precioCargoDTOs = BOSimcard.getPrecioCargoSimcard_NoPrecioLista(parametrosCargoSimcardDTO);
					}


				}
				if (precioCargoDTOs == null){
					resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado a la Simcard");
					throw new GeneralException("12362",0,"No se encuentra precio para el Articulo asociado a la Simcard");

				}
			}catch(GeneralException e){
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado a la Simcard");
				throw new GeneralException("12363",0,"No se encuentra precio para el Articulo asociado a la Simcard");
			}
		}

		// Verifica si el vendedor tiene acceso a la bodega del teminal
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		TerminalSNPNDTO terminal = new TerminalSNPNDTO();
		
		if (entrada.getNumeroSerieKit().equals("")){
			terminal.setNumeroSerie(entrada.getNumeroSerieTerminal());
			terminal = BOTerminal.getTerminal(terminal);			
		}else{
			SerieKitDTO seriekit = new SerieKitDTO();
			seriekit.setNumSerieKit(entrada.getNumeroSerieKit());
			seriekit.setNumSerieTerminal(entrada.getNumeroSerieTerminal());
			terminal = BOSerieKit.getSerieTerminalKit(seriekit);
		}

		entrada.setCodigoBodega(terminal.getCodigoBodega());
		if (entrada.getNumeroSerieKit().equals("")){
			resultadoValidacion = BOVendedor.vendedorExisteEnBodegaTerminal(entrada);
			if (!resultadoValidacion.isResultado() && terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("Vendedor no tiene acceso a la bodega del terminal");
				logger.debug("Vendedor no tiene acceso a la bodega del terminal");
				throw new GeneralException("12364",0,"Vendedor no tiene acceso a la bodega del terminal");
			}
		}
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));


		//Verifica que el Articulo asociado al terminal tenga precio.
		if (terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna")) &&
				terminal.getIndicadorValorar().equals(config.getString("indicador.valoracion"))){
			ParametrosCargoTerminalDTO parametrosCargoTerminalDTO = new ParametrosCargoTerminalDTO();
			parametrosCargoTerminalDTO.setCodigoArticulo(terminal.getCodigoArticulo());
			parametrosCargoTerminalDTO.setCodigoUso(usoLinea);
			parametrosCargoTerminalDTO.setTipoStock(terminal.getTipoStock());
			parametrosCargoTerminalDTO.setEstado(terminal.getEstado());
			parametrosCargoTerminalDTO.setModalidadVenta(entrada.getCodigoModalidadVenta());
			parametrosCargoTerminalDTO.setTipoContrato(entrada.getCodigoTipoContrato());
			parametrosCargoTerminalDTO.setPlanTarifario(entrada.getCodigoPlanTarifario());
			parametrosCargoTerminalDTO.setCodigoUsoPrepago(config.getString("codigo.uso.prepago"));
			parametrosCargoTerminalDTO.setCodigoCategoria(terminal.getCodigoCategoria());
			parametrosCargoTerminalDTO.setIndicadorEquipo(config.getString("indicador.equiacc"));
			try{
				precioCargoDTOs = null;
				if (sPrecioLista.equals(config.getString("indicador.precio.lista"))){
					parametrosCargoTerminalDTO.setCodigoCategoria(config.getString("codigo.categoria"));
					parametrosCargoTerminalDTO.setIndiceRecambio(config.getString("indice.recambio.preciolista"));
					precioCargoDTOs = BOTerminal.getPrecioCargoTerminal_PrecioLista(parametrosCargoTerminalDTO);		
				}
				else{

					if (planTarifario.getCodigoTipoPlan().equals("1")){
						parametrosCargoTerminalDTO.setCodigoCategoria(config.getString("codigo.categoria"));
						parametrosCargoTerminalDTO.setIndiceRecambio(config.getString("indice.recambio.preciolista"));
						precioCargoDTOs = BOTerminal.getPrecioCargoTerminal_PrecioLista(parametrosCargoTerminalDTO);						
					}else{
						parametrosCargoTerminalDTO.setIndiceRecambio(config.getString("indice.recambio.nolista"));
						precioCargoDTOs = BOTerminal.getPrecioCargoTerminal_NoPrecioLista(parametrosCargoTerminalDTO);	
					}


				}
				if (precioCargoDTOs == null){
					logger.debug("No se encontro precio asociado al terminal" + parametrosCargoTerminalDTO.getNumeroSerie());
					resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado al Terminal");
					logger.debug("No se encuentra precio para el Articulo asociado al Terminal");
					throw new GeneralException("12365",0,"No se encuentra precio para el Articulo asociado al Terminal");
				}
			}catch(GeneralException e){
				logger.debug("Exception: No se encontro precio asociado al terminal");
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado al Terminal");
				logger.debug("No se encuentra precio para el Articulo asociado al Terminal");
				throw new GeneralException("12366",0,"No se encuentra precio para el Articulo asociado al Terminal");
			}

		}	

		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));

		//( 55* ) Verifica si serie terminal existe en abonado					
		resultadoValidacion = BOTerminal.validaRepeticionTerminal(terminal);
		resultadoValidacion = new ResultadoValidacionVentaDTO();
		resultadoValidacion.setResultado(true);		
		if (!resultadoValidacion.isResultado()){			
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setDetalleEstado("Serie terminal no puede ser nuevamente vendida");
			logger.debug("Serie terminal no puede ser nuevamente vendida");
			throw new GeneralException("12367",0,"Serie terminal no puede ser nuevamente vendida");
		}


		// ( 58 ) Verifica si serie terminal esta en lista negras		
		terminal.setNumeroSerie(entrada.getNumeroSerieTerminal());
		resultadoValidacion = BOAbonado.validaSerieTermialEnListaNegra(terminal);
		resultadoValidacion = new ResultadoValidacionVentaDTO();
		resultadoValidacion.setResultado(false);		
		if (resultadoValidacion.isResultado()){
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setDetalleEstado("Serie terminal se encuentra en listas negras");
			logger.debug("Serie terminal se encuentra en listas negras");
			throw new GeneralException("12368",0,"Serie terminal se encuentra en listas negras");
		}

		// Varifica si la modalidad de venta es credito, el terminal no sea externo
		if (!terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){

			ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
			parametrosGral.setNombreparametro(config.getString("parametro.modalidad.venta.credito"));
			parametrosGral.setCodigoproducto(config.getString("codigo.producto"));
			parametrosGral.setCodigomodulo(config.getString("codigo.modulo.GA"));
			parametrosGral = BOParametrosGenerales.getParametroGeneral(parametrosGral);

			if (parametrosGral.getValorparametro().equals(entrada.getCodigoModalidadVenta())){
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("Para venta a credito terminal no puede ser externo");				
				logger.debug("Para venta a credito terminal no puede ser externo");
				throw new GeneralException("12369",0,"Para venta a credito terminal no puede ser externo");
			}
		}

		// Obtiene SubAlm celda seleccionada en Parametros Comerciales
		CelularDTO celular = new CelularDTO();
		CeldaDTO celda = new CeldaDTO();

		celda.setCodigoCelda(entrada.getCodigoCelda());
		celda.setCodigoProducto(config.getString("codigo.producto"));
		celda = obtieneDatosCelda(celda);
		//setear datos para la busqueda del numero de celular automatica

		celular.setCodSubAlm(celda.getCodSubAlm());
		celular.setCentral(entrada.getCodigoCentral());
		celular.setCodigoUso(usoLinea);
		celular.setNomUsuarioOra(entrada.getUsuarioConectado());

		//-- BUSCAR CODIGO ACTUACION
		if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.hibrido"))){
			celular.setCodActabo(config.getString("codigo.actuacion.hibrido"));
		}else if(planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.postpago"))){ 
			celular.setCodActabo(config.getString("codigo.actuacion.venta"));
		}else if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.prepago"))){
			celular.setCodActabo(config.getString("codigo.actuacion.prepago"));
		}



		ClienteDTO cliente = new ClienteDTO();
		cliente.setCodigoCliente(entrada.getCodigoCliente());
		cliente = BOCliente.getCliente(cliente);
		cliente.setTipoCliente(entrada.getTipoCliente());

		//Si el cliente no tiene excepciones valida cantidad de terminales vendidos.
		//Si es un cliente de tipo empresa tb valida los numeros de abonados permitidos en el plan tarifario.

		VendedorDTO vendedorDTO = new VendedorDTO();
		vendedorDTO.setCodigoVendedor(entrada.getCodigoVendedor());
		//Obtiene numero celular
		if (entrada.getNumeroCelular().equals(config.getString("no.existe")) || entrada.getNumeroCelular().equals("0"))
		{// no viene numero celular en el archivo
			if(!simcard.getIndicadorProgramado().equals(config.getString("indicativo.telefono.no.programado")) && simcard.getNumeroCelular()!=null && !simcard.getNumeroCelular().equals("0")){
				// simcard programada
				resultadoValidacion.setBDireccionLinea(false);
				celular.setNumeroCelular(Long.parseLong(simcard.getNumeroCelular()));
				vendedorDTO.setNumeroCelular(simcard.getNumeroCelular());
				/* Comentado por solicitud de Marcelo Miranda no es necesaria la validacion del home del vendedor*/
				/*vendedorDTO = BOVendedor.validaHomeVendCel(vendedorDTO);
				if (!vendedorDTO.isIndicadorHomeVendCelular()){
					resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setDetalleEstado("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
					logger.debug("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
					throw new GeneralException("12370",0,"Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
				}*/
			}
			else
			{// simcard no programada
				//-- NUMERACION AUTOMATICA
				celular = getNumeroCelularAut(celular);
				logger.debug("celular" +celular.getNumeroCelular()+"]");
				celular.setNumeroTransaccion(Long.parseLong(entrada.getNumeroTransaccionVenta()));
				celular.setNumeroLinea(String.valueOf(entrada.getNumeroLinea()+1)); 
				celular.setNumeroOrden(String.valueOf(entrada.getNumeroOrden()+1));
				//-- RESERVA DE NUMERO


				celular = setReservaNumeroCelular(celular);
				logger.debug("NUMERACION AUTOMATICA celular ["+celular.getNumeroCelular()+"]");
				resultadoValidacion.setBDireccionLinea(true);
			}
		}
		else
		{// viene numero celular en el archivo
			//Si es distinto de estado 8 simcard es programada
			resultadoValidacion.setBDireccionLinea(false);
			if (!simcard.getIndicadorProgramado().equals(config.getString("indicativo.telefono.no.programado")))
				// simcard programada
				if (!simcard.getNumeroCelular().equals("0")){
					celular.setNumeroCelular(Long.parseLong(simcard.getNumeroCelular()));
					vendedorDTO.setNumeroCelular(simcard.getNumeroCelular());
					/*
					 Comentado por definicion de Marcelo Miranda no es necesaria la validacion del home del vendedor
					 vendedorDTO = BOVendedor.validaHomeVendCel(vendedorDTO);
					if (!vendedorDTO.isIndicadorHomeVendCelular()){
						resultadoValidacion.setEstado("NOK");
						resultadoValidacion.setDetalleEstado("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
						logger.debug("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
						throw new GeneralException("12371",0,"Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
					}*/
				}
			logger.debug("ANTES RESERVA DE NUMERO celular ["+celular.getNumeroCelular()+"]");
			if (celular.getNumeroCelular() != 0){
				logger.debug("EN RESERVA DE NUMERO celular ["+celular.getNumeroCelular()+"]");
				//-- RESERVA DE NUMERO							
				celular.setNumeroTransaccion(Long.parseLong(entrada.getNumeroTransaccionVenta()));
				celular.setNumeroLinea(String.valueOf(entrada.getNumeroLinea()+1)); 
				celular.setNumeroOrden(String.valueOf(entrada.getNumeroOrden()+1));
				logger.debug("ANTES de  getInfoCelular["+celular.getNumeroCelular()+"]");
				celular = BORegistroVenta.getInfoCelular(celular);
				logger.debug("despues de  getInfoCelular celular.getCategoria["+celular.getCategoria()+"]");
				celular.setTipoCelular(config.getString("tipo.num.celular"));
				celular = setReservaNumeroCelular(celular);
			}
			else 
				// simcard no programada
			{
				logger.debug("EN RESERVA DE NUMERO celular ["+celular.getNumeroCelular()+"]");
				ResultadoValidacionLogisticaDTO resultado =null;
				ParametrosValidacionLogisticaDTO parametrosEntrada = new ParametrosValidacionLogisticaDTO();
				parametrosEntrada.setNumeroCelular(entrada.getNumeroCelular());
				parametrosEntrada.setCodigoCliente(entrada.getCodigoCliente());
				parametrosEntrada.setCodigoVendedor(entrada.getCodigoVendedor());
				logger.debug("entrada.getNumeroCelular() ["+entrada.getNumeroCelular()+"]");
				resultado=BOSimcard.numeroReservadoOK(parametrosEntrada);
				resultadoValidacion.setBDireccionLinea(false);
				if(!resultado.isResultado())
				{

					celular.setNumeroTransaccion(Long.parseLong(entrada.getNumeroTransaccionVenta()));
					celular.setNumeroLinea(String.valueOf(entrada.getNumeroLinea()+1)); 
					celular.setNumeroOrden(String.valueOf(entrada.getNumeroOrden()+1)); 
					celular.setCategoria(simcard.getCodigoCategoria());
					//celular = setReservaNumeroCelular(celular);
					/*Solicitud de Marcelo Miranda no debe generar error si no reservar el celular para le vendedor.*/
					/*resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setDetalleEstado("Numero de celular no esta reservado para el vendedor y/o cliente");
					logger.debug("Numero de celular no esta reservado para el vendedor y/o cliente");
					throw new GeneralException("12372",0,"Numero de celular no esta reservado para el vendedor y/o cliente");*/


				}
				celular.setNumeroCelular(Long.parseLong(entrada.getNumeroCelular()));
				vendedorDTO.setNumeroCelular(entrada.getNumeroCelular());
				/* Comentado por solicitud de MArcelo Miranda no es necesario la validacion del Home del Vendedor
				vendedorDTO = BOVendedor.validaHomeVendCel(vendedorDTO);
				if (!vendedorDTO.isIndicadorHomeVendCelular()){
					resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setDetalleEstado("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
					logger.debug("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
					throw new GeneralException("12373",0,"Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
				}*/
				if (celular.getNumeroCelular() != 0){
					//-- RESERVA DE NUMERO
					celular.setTipoCelular(config.getString("tipo.num.celular"));
					celular.setNumeroTransaccion(Long.parseLong(entrada.getNumeroTransaccionVenta()));
					celular.setNumeroLinea(String.valueOf(entrada.getNumeroLinea()+1)); 
					celular.setNumeroOrden(String.valueOf(entrada.getNumeroOrden()+1)); 					
					celular = BORegistroVenta.getInfoCelular(celular);
					celular = setReservaNumeroCelular(celular);
					BORegistroVenta.setNumeracionManual(celular);


				}
			}

		}
		if (celular.getNumeroCelular() == 0){
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setDetalleEstado("No se pudo obtener número celular");
			logger.debug("No se pudo obtener número celular");
			throw new GeneralException("12374",0,"No se pudo obtener número celular");
		}

		//P-ECU-08019: Verifica si cliente se encuentra en las tablas de tipo contrato cliente
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));

		logger.debug("Antes de recueprar Contrao de cliente");

		TipoContratoClienteDTO tipoContratoCliente = obtieneTipContratoCliente(
				Long.valueOf(entrada.getCodigoCliente()));

		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Despues de recueprar Contrao de cliente ["+tipoContratoCliente.getCodCliente().longValue()+"]");
		if(tipoContratoCliente.getCodCliente().longValue() != 0)
		{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("cliente SI se encuentra en las tablas de tipContrato");

			//Consulto vigencia plan uso
			PlanUsoDTO planUso = new PlanUsoDTO();
			planUso.setCodPlanTarif(entrada.getCodigoPlanTarifario());
			planUso.setCodUso(Long.valueOf(simcard.getCodigoUso()));
			String vigencia = obtieneVigenciaPlanUso(planUso);
			logger.debug("vigencia plan uso : " + vigencia);	



		} else {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("cliente NO se  encuentra en las tablas de tipContrato : " + entrada.getNumeroLinea());
			logger.debug("numero de linea : " + entrada.getNumeroLinea());
			logger.debug("numero de serie simcard: " + entrada.getNumeroSerie());
			logger.debug("total lineas: " + entrada.getTotalRegistros());

			if(entrada.getNumeroLinea() == 0)
			{
				logger.debug("cliente NO se  encuentra en las tablas de tipContrato, es primera linea");
				//Consulto vigencia plan uso
				PlanUsoDTO planUso = new PlanUsoDTO();
				planUso.setCodPlanTarif(entrada.getCodigoPlanTarifario());
				planUso.setCodUso(Long.valueOf(simcard.getCodigoUso()));
				String vigencia = obtieneVigenciaPlanUso(planUso);
				logger.debug("vigencia plan uso : " + vigencia);
				//Vigencia de plan uso con flag S
				if(vigencia.trim().equals("S"))
				{
					logger.debug("cliente NO se  encuentra en las tablas de tipContrato, plan uso es vigente");
					Long nroAbonados = obtieneAbonadosVigentes(Long.valueOf(entrada.getCodigoCliente()));
					logger.debug(" nroAbonados : " + nroAbonados.longValue() );
					logger.debug(" codTipoContrato : " + entrada.getCodigoTipoContrato() );
					if(nroAbonados.longValue() == 0 ) //Es abonado nuevo
					{
						if(!entrada.getCodigoTipoContrato().trim().
								equals(config.getString("codigo.tipo.contrato.0.meses")))
						{
							logger.debug("cliente NO se  encuentra en las tablas de tipContrato, abonado SI es nuevo");
							//inserto tipo contrato asociado al cliente
							TipoContratoClienteDTO tipoContratoCLiente = new TipoContratoClienteDTO();
							logger.debug("codigo cliente : " + entrada.getCodigoCliente());
							tipoContratoCLiente.setCodCliente(Long.valueOf(entrada.getCodigoCliente()));
							logger.debug("codigo plan tarifario : " + entrada.getCodigoPlanTarifario());
							tipoContratoCLiente.setCodPlanTarif(entrada.getCodigoPlanTarifario());
							logger.debug("codigo producto : " + entrada.getCodigoProducto());
							//tipoContratoCliente.setCodProducto(Long.valueOf(entrada.getCodigoProducto()));
							tipoContratoCLiente.setCodProducto( new Long(1) );
							tipoContratoCLiente.setCodTipContrato(entrada.getCodigoTipoContrato());
							tipoContratoCLiente.setCodUso(Long.valueOf(simcard.getCodigoUso()));
							logger.debug("usuario conectado : " + entrada.getNombreUsuario());
							tipoContratoCLiente.setNomUsuario(entrada.getUsuarioConectado());
							insertaTipContratoCliente(tipoContratoCLiente);
						}
					} else { //No es abonado nuevo
						logger.debug("cliente NO se encuentra en las tablas de tipContrato, abonado NO es nuevo");
						resultadoValidacion.setEstado("NOK");
						resultadoValidacion.setDetalleEstado("Debe crear un cliente nuevo para seleccionar este plan tarifario " + entrada.getCodigoPlanTarifario()+ " ");
						logger.debug("cliente NO se encuentra en las tablas de tipContrato, abonado NO es nuevo");
						throw new GeneralException("12377",0,"cliente NO se encuentra en las tablas de tipContrato, abonado NO es nuevo");
					}
				}
			} else {
				if( entrada.getEsPlanNoFijoPrimeraLinea().trim().equals("N")){
					//Consulto vigencia plan uso
					PlanUsoDTO planUso = new PlanUsoDTO();
					planUso.setCodPlanTarif(entrada.getCodigoPlanTarifario());
					planUso.setCodUso(Long.valueOf(simcard.getCodigoUso()));
					String vigencia = obtieneVigenciaPlanUso(planUso);
					logger.debug("contrato NO fijo vigencia plan uso : " + vigencia);		
					if(vigencia.trim().equals("S"))
					{
						resultadoValidacion.setEstado("NOK");
						resultadoValidacion.setDetalleEstado("Vigencia plan uso no corresponde");
						logger.debug("Vigencia plan uso no corresponde");
						throw new GeneralException("12378",0,"Vigencia plan uso no corresponde");
					}
				}
			}
		}
		//FIN P-ECU-08019


		if (celular.getNumeroCelular() != 0 ){
			resultadoValidacion.setNumeroCelular(String.valueOf(celular.getNumeroCelular()));		
			resultadoValidacion.setCodigoCentral(celular.getCentral());
		}




		resultadoValidacion.setEstado("OK");
		resultadoValidacion.setDetalleEstado("-");

		logger.debug("Fin:validacionLinea()");
		return resultadoValidacion;
	}//fin validacionLinea	

	public void insertaTipContratoCliente(TipoContratoClienteDTO entrada)
	throws GeneralException	
	{	
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("VentasSrv:Inicio:insertaTipContratoCliente()");		
		BOContrato.insertaTipContratoCliente(entrada);
		logger.debug("VentasSrv:Fin:insertaTipContratoCliente()");	
	}	

	public String obtieneVigenciaPlanUso(PlanUsoDTO entrada)
	throws GeneralException		
	{	
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("VentasSrv:Inicio:obtieneVigenciaPlanUso()");		
		String resultado = BOPlanTarifario.obtieneVigenciaPlanUso(entrada);
		logger.debug("VentasSrv:Fin:obtieneVigenciaPlanUso()");	
		return resultado;
	}	

	public CeldaDTO obtieneDatosCelda(CeldaDTO entrada) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:obtieneDatosCelda()");
		CeldaDTO resultado = new CeldaDTO();
		resultado =BOCelda.obtieneDatosCelda(entrada);
		logger.debug("Fin:obtieneDatosCelda()");
		return resultado;
	}	

	public CelularDTO setReservaNumeroCelular(CelularDTO celular) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("setReservaNumeroCelular():start");
		CelularDTO resultado = BORegistroVenta.setReservaNumeroCelular(celular);
		logger.debug("setReservaNumeroCelular():end");
		return resultado;
	}//fin setReservaNumeroCelular	

	public Long obtieneAbonadosVigentes(Long codCliente)
	throws GeneralException		
	{	
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("VentasSrv:Inicio:obtieneAbonadosVigentes()");		
		Long resultado = BOAbonado.obtieneAbonadosVigentes(codCliente);
		logger.debug("VentasSrv:Fin:obtieneAbonadosVigentes()");	
		return resultado;
	}	

	public TipoContratoClienteDTO obtieneTipContratoCliente(Long codCliente)
	throws GeneralException		
	{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("VentasSrv:Inicio:obtieneTipContratoCliente()");		
		TipoContratoClienteDTO resultado = BOContrato.obtieneTipContratoCliente(codCliente);
		logger.debug("VentasSrv:Fin:obtieneTipContratoCliente()");	
		return resultado;
	}	

	public CelularDTO getNumeroCelularAut(CelularDTO celular) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("getNumeroCelularAut():start");
		CelularDTO resultado = BORegistroVenta.getNumeroCelularAut(celular);
		logger.debug("getNumeroCelularAut():end");
		return resultado;
	}//fin getNumeroCelularAut


	public AbonadoActivoDTO[]  getAbonadosActivosCliente(Long codCliente) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		//RSIS -015
		AbonadoActivoDTO[]  retValue=null;
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("listAbonadosActivosCliente:start");
			retValue= BOCliente.getAbonadosActivosCliente(codCliente.longValue());
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("listAbonadosActivosCliente:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsLinkDocumentoOutDTO getLinkFactura(WsLinkDocumentoInDTO wsLinkDocumentoInDTO) throws GeneralException{
		//RSIS 032
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsLinkDocumentoOutDTO retValue=null;
		try{
			logger.debug("SpnSclWSBean: getLinkFactura:start");
			retValue= BOCliente.getLinkFactura(wsLinkDocumentoInDTO);
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("SpnSclWSBean: getLinkFactura:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}
	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO entrada) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		PlanTarifarioDTO resultado = null;
		logger.debug("Inicio:getPlanTarifario()");
		try{
			resultado = BOPlanTarifario.getPlanTarifario(entrada);
			logger.debug("Fin:getPlanTarifario()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return resultado;
	}

	public PagosUltimosMesesDTO[] getRecPagosClie(ClienteDTO clienteDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		PagosUltimosMesesDTO[] retValue=null;
		try{
			logger.debug("getRecPagosClie:start");
			retValue= BOCliente.getRecPagosClie(clienteDTO);
			logger.debug("getRecPagosClie:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsInfoComercialClienteDTO[] getDatosCredCliente(ClienteDTO clienteDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		//RSIS - 036
		WsInfoComercialClienteDTO[] retValue=null;
		try{
			logger.debug("getDatosCredCliente:start");
			retValue= BOCliente.getDatosCredCliente(clienteDTO);
			logger.debug("getDatosCredCliente:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	public RoamingOUTDTO getDetalleUltimaLlamadasRoamingTOL(RoamingInDTO rommingDTO)throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		                                 
		RoamingOUTDTO retValue= null;  
		try{
			logger.debug("getDetalleUltimaLlamadasRomingTOL:start");
			retValue=BOTasacion.getDetalleUltimaLlamadasRomingTOL(rommingDTO);
			logger.debug(this.getClass().getName()+" getDetalleUltimaLlamadasRomingTOL:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public SimcardSNPNDTO getSimcard(SimcardSNPNDTO entrada)
	throws GeneralException{

		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:getSimcard()");
		SimcardSNPNDTO resultado = BOSimcard.getSimcard(entrada); 
		logger.debug("Fin:getSimcard()");
		return resultado;
	}//fin getSimcard	


	public long getSecuenciaVenta()throws GeneralException{
		long resultado;
		try{
			logger.debug("Inicio:getSecuenciaVenta()");
			RegistroVentaDTO parametroEntrada = new RegistroVentaDTO();
			parametroEntrada.setCodigoSecuencia(config.getString("secuencia.venta"));
			resultado = BORegistroVenta.getSecuenciaVenta(parametroEntrada).getNumeroVenta();
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getSecuenciaVenta()");
		return resultado;
	}




	public ContratoDTO getListadoNumeroMesesContrato(ContratoDTO contrato) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getListadoNumeroMesesContrato():start");
			contrato = BOContrato.getListadoNumeroMesesContrato(contrato);
			logger.debug("getListadoNumeroMesesContrato():end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return contrato;
	}

	public ClienteDTO getPlanComercial(ClienteDTO clienteDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getPlanComercial():start");
			clienteDTO = BOCliente.getPlanComercial(clienteDTO);
			logger.debug("getPlanComercial():end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return clienteDTO;
	}



	public ClienteDTO getCategoriaTributariaCliente(ClienteDTO clienteDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getCategoriaTributariaCliente():start");
			clienteDTO = BOCliente.getCategoriaTributariaCliente(clienteDTO);
			logger.debug("getCategoriaTributariaCliente():end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return clienteDTO;
	}


	public RegistroVentaDTO getSecuencia(RegistroVentaDTO registroVentaDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getSecuenciaTransacabo():start");
			registroVentaDTO = BORegistroVenta.getSecuenciaTransacabo(registroVentaDTO);
			logger.debug("getSecuenciaTransacabo():end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return registroVentaDTO;
	}

	public void provisionandoLinea(GaVentasDTO parametros) 
	throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		logger.debug("provisionandoLinea():inicio");
		String codigoActuacionProceso;
		//String sIndAkeys=null;
		String codigoAccion=null;
		String valorServicio=null;
		String codigoActuacionCentral = null;
		SimcardSNPNDTO simcard2 = new SimcardSNPNDTO();
		TerminalSNPNDTO terminal2 = new TerminalSNPNDTO();
		

		CentralDTO centralSistema = new CentralDTO();
		centralSistema.setCodigoCentral( String.valueOf(parametros.getAbonado().getCodCentral()) );
		centralSistema.setCodigoCelda(parametros.getAbonado().getCodCelda());
		centralSistema = getCentralTecnologia(centralSistema);
		
		if(centralSistema.getCodGrupoTecnologico().equals("GSM")){
			
			SerieKitDTO serieKit = new SerieKitDTO();
			serieKit.setNumSerieSimcard(parametros.getAbonado().getNumSerieSimcard());
			serieKit.setNumSerieTerminal(parametros.getAbonado().getNumSerieTerminal());		
			serieKit = BOSerieKit.validaSerieKit(serieKit);
		
		
			if(serieKit.getNumSerieKit().equals("")){
				simcard2.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
				simcard2 = BOSimcard.getSimcard(simcard2);
			}else{
				SerieKitDTO seriekit = new SerieKitDTO();
				seriekit.setNumSerieKit(serieKit.getNumSerieKit());
				seriekit.setNumSerieSimcard(parametros.getAbonado().getNumSerieSimcard());
				simcard2 = BOSerieKit.getSerieSimcardKit(seriekit);
				
				seriekit.setNumSerieKit(serieKit.getNumSerieKit());
				seriekit.setNumSerieTerminal(parametros.getAbonado().getNumSerieTerminal());
				terminal2 = BOSerieKit.getSerieTerminalKit(seriekit);
			}
		}

		//no se valida si es simcard externa ya que solo se maneja simcard Internas.
		ParametrosGeneralesDTO parametrosGrales = new ParametrosGeneralesDTO();
		parametrosGrales.setCodigomodulo(config.getString("codigo.modulo.GE"));
		parametrosGrales.setCodigoproducto(config.getString("codigo.producto"));
		parametrosGrales.setNombreparametro(config.getString("parametro.ind.telefono.out"));
		parametrosGrales=BOParametrosGenerales.getParametroGeneral(parametrosGrales);

		SimcardSNPNDTO simcard = new SimcardSNPNDTO();
		simcard.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
		simcard.setIndicadorTelefono(parametrosGrales.getValorparametro());
		simcard = BOSimcard.getIndicadorTelefono(simcard);

		String indicadorTelefono = simcard.getIndicadorTelefono();
		logger.debug("Inicador de Telefono: " + indicadorTelefono);
		
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(parametros.getAbonado().getCodPlanTarif());
		planTarifario.setCodigoProducto(config.getString("codigo.producto"));


		planTarifario.setCodigoTecnologia(parametros.getAbonado().getCodTecnologia());
		planTarifario = BOPlanTarifario.getPlanTarifario(planTarifario);
		logger.debug("planTarifario: ["+planTarifario.getCodigoPlanTarifario() +"] - [" +planTarifario.getPlanComverse()+"]");
		float fImportePlan = planTarifario.getImporteCargoBasico();
		codigoActuacionProceso = parametros.getCodigoActuacionDefecto();

		//CSR-11002
		//if (parametros.getIndPortado().equals("1")){
		if ("1".equals(parametros.getIndPortado())){

			if (planTarifario.getCodigoTipoPlan().equals("3")){
				codigoActuacionProceso = config.getString("codigo.actuacion.hibrido.portado");
			}else if (planTarifario.getCodigoTipoPlan().equals("2")){
				codigoActuacionProceso = config.getString("codigo.actuacion.venta.portado");
			}else if (planTarifario.getCodigoTipoPlan().equals("1")){
				codigoActuacionProceso = config.getString("codigo.actuacion.prepago.portado");
			}
		}else{
			if (planTarifario.getCodigoTipoPlan().equals("3")){
				codigoActuacionProceso = config.getString("codigo.actuacion.hibrido");
			}else if (planTarifario.getCodigoTipoPlan().equals("2")){
				codigoActuacionProceso = config.getString("codigo.actuacion.venta");
			}else if (planTarifario.getCodigoTipoPlan().equals("1")){
				//INICIO CSR-11002
				if(indicadorTelefono.equals(config.getString("indice.simcard.act.prepago.bloqueada"))){
					
					codigoActuacionProceso = config.getString("codigo.actuacion.prepago.vx");
				}else{
					
					codigoActuacionProceso = config.getString("codigo.actuacion.prepago");
				}

				//FIN CSR-11002
			}
		}
		

		/*Recupera código de actuación en centrales asociado al código de actuación de procesamiento*/
		DatosGeneralesDTO datosGrales = new DatosGeneralesDTO();
		datosGrales.setCodigoActuacionAbonado(codigoActuacionProceso);
		datosGrales.setCodigoProducto(config.getString("codigo.producto"));
		datosGrales.setCodigoTecnologia(parametros.getAbonado().getCodTecnologia());
		datosGrales = BODatosgenerales.getActuacionCentral(datosGrales);
		codigoActuacionCentral = datosGrales.getCodigoActuacionCentral();

		logger.debug("codigoActuacionCentral: " + codigoActuacionCentral);
		
		if (codigoActuacionCentral ==null){
			throw new GeneralException("12278",0,"Línea, " + parametros.getAbonado().getNumCelular() + "no es posible aprovicionar en red");
		}

		ProcesoDTO proceso = new ProcesoDTO();

		if(centralSistema.getCodGrupoTecnologico().equals("GSM")){

			
			simcard2.setIndProcEq(config.getString("indicador.procedencia.equipo.simcard"));

			/*Valida autenticación de Serie Simcard*/

			proceso = BOSimcard.validaAutenticacionSerie(simcard2);
		}else{
			proceso.setCodigoError(0);
			proceso.setMensajeError("024000000TMM");

		}

		if (proceso.getCodigoError()==0){
			logger.debug("codigoAccion: " + proceso.getMensajeError().substring(1,3));
			//sIndAkeys = proceso.getMensajeError().substring(1,1);
			codigoAccion = proceso.getMensajeError().substring(1,3);
			valorServicio = proceso.getMensajeError().substring(3,9);
			logger.debug("valorServicio: " + proceso.getMensajeError().substring(3,9));
		}
		logger.debug("Codigo Accion" + codigoAccion);
		/*Valida código de acción devuelto en la autenticación de la serie*/

		if (!codigoAccion.equals(config.getString("codigo.accion.uno"))  
				&& !codigoAccion.equals(config.getString("codigo.accion.dos")) 
				&& !codigoAccion.equals(config.getString("codigo.accion.tres"))
				&& !codigoAccion.equals(config.getString("codigo.accion.cuatro"))){

			throw new GeneralException("12279",0,"Ha ocurrido un error al momento de insertar movimiento en centrales");

		}
		else if (!codigoAccion.equals(config.getString("codigo.accion.dos"))  
				&& parametros.getCodOperadora().equals(config.getString("codigo.operadora.val.central")))
			throw new GeneralException("12280",0,
			"Ha ocurrido un error al momento de insertar movimiento en centrales");

		InterfazCentralDTO intCentralDTO = new InterfazCentralDTO();

		/*Obtiene secuencia movimiento a centrales */
		datosGrales = new DatosGeneralesDTO();
		datosGrales.setCodigoSecuencia(config.getString("secuencia.movimiento.central"));
		datosGrales = BODatosgenerales.getSecuencia(datosGrales);

		intCentralDTO.setNumeroMovimiento(datosGrales.getSecuencia());
		parametros.setNumeroMovtoAnterior(String.valueOf(intCentralDTO.getNumeroMovimiento()));
		intCentralDTO.setNumeroAbonado(parametros.getAbonado().getNumAbonado());
		intCentralDTO.setCodigoEstado(Integer.parseInt(config.getString("codigo.estado.centrales")));
		intCentralDTO.setCodActabo(codigoActuacionProceso);
		intCentralDTO.setCodigoModulo(config.getString("codigo.modulo.GA"));
		intCentralDTO.setCodigoActuacion(codigoActuacionCentral);
		intCentralDTO.setCodigoUsuario(parametros.getCodigoUsuario());

		Date fecha = new Date();
		Calendar cal = new GregorianCalendar(); 
		cal.setTimeInMillis(fecha.getTime()); 
		//INICIO CSR-11002
//		Date fechaIngreso = new Date(cal.getTimeInMillis()); 
//		String fechaIngresoFormateada = Formatting.dateTime(fechaIngreso,"dd/MM/yyyy HH:mm:ss");
//		intCentralDTO.setFechaIngreso(fechaIngresoFormateada);
		intCentralDTO.setFechaIngreso(new java.sql.Timestamp( cal.getTimeInMillis()));
		//FIN CSR-11002
	
		intCentralDTO.setTipoTerminal(parametros.getAbonado().getTipTerminal() );
		intCentralDTO.setCodigoCentral(parametros.getAbonado().getCodCentral());
		intCentralDTO.setNumeroCelular(parametros.getAbonado().getNumCelular());
		intCentralDTO.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
		if (codigoAccion.equals(config.getString("codigo.accion.uno")) 
				|| codigoAccion.equals(config.getString("codigo.accion.tres"))){
			intCentralDTO.setCodigoServicio(valorServicio);
		}
		intCentralDTO.setNumMin(parametros.getAbonado().getNumMin());

		CentralDTO central = new CentralDTO();
		central.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto")));
		central.setCodigoCentral(String.valueOf(parametros.getAbonado().getCodCentral()));
		central = BOCentral.getCentral(central);
		intCentralDTO.setTipoTecnologia(central.getCodigoTecnologia());

		if(centralSistema.getCodGrupoTecnologico().equals("GSM")){

			simcard.setCodigoImsi(config.getString("codigo.imsi"));
			simcard = BOSimcard.getImsiSimcard(simcard);
			intCentralDTO.setImsi(simcard.getValorImsi());
			intCentralDTO.setImei(parametros.getAbonado().getNumSerieTerminal());
			intCentralDTO.setIcc(parametros.getAbonado().getNumSerieSimcard());	
		}else{
			intCentralDTO.setImsi("");
			intCentralDTO.setImei("");
			intCentralDTO.setIcc("");
			intCentralDTO.setNumeroSerie(parametros.getAbonado().getNumSerieHex());
		}


		parametrosGrales = new ParametrosGeneralesDTO();
		parametrosGrales.setCodigomodulo(config.getString("codigo.modulo.GA"));
		parametrosGrales.setCodigoproducto(config.getString("codigo.producto"));
		parametrosGrales.setNombreparametro(config.getString("parametro.categoria.cta.segura"));
		parametrosGrales=BOParametrosGenerales.getParametroGeneral(parametrosGrales);

		String sCuentaSegura = parametrosGrales.getValorparametro();


		parametrosGrales = new ParametrosGeneralesDTO();
		parametrosGrales.setCodigomodulo(config.getString("codigo.modulo.GA"));
		parametrosGrales.setCodigoproducto(config.getString("codigo.producto"));
		parametrosGrales.setNombreparametro(config.getString("parametro.prorrateo.movimiento"));
		parametrosGrales=BOParametrosGenerales.getParametroGeneral(parametrosGrales);

		String sProrrateo = parametrosGrales.getValorparametro();

		PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
		planTarifarioDTO.setCodigoPlanTarifario(parametros.getAbonado().getCodPlanTarif());
		planTarifarioDTO = BOPlanTarifario.getCategoriaPlanTarifario(planTarifarioDTO);

		ClienteDTO clienteDTO = new ClienteDTO();
		clienteDTO.setCodigoCliente(String.valueOf(parametros.getCodCliente().longValue()));
		clienteDTO = BOCliente.getCliente(clienteDTO);
		//Si se cumple condición se realiza prorrateo, en caso contrario se mantieneel valor
		//del importe del plan y se le aplica los impuestos correspondientes
		if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido())
				&& !planTarifarioDTO.getCodigoCategoria().equals(sCuentaSegura)
				&& sProrrateo.equals(config.getString("indicador.prorrateo"))){
			parametrosGrales = new ParametrosGeneralesDTO();
			parametrosGrales.setCodigomodulo(config.getString("codigo.modulo.GE"));
			parametrosGrales.setCodigoproducto(config.getString("codigo.producto"));
			parametrosGrales.setNombreparametro(config.getString("parametro.formato.fecha1"));
			parametrosGrales=BOParametrosGenerales.getParametroGeneral(parametrosGrales);

			RegistroFacturacionDTO registroFacturacionDTO = new RegistroFacturacionDTO();
			registroFacturacionDTO.setCodigoCicloFacturacion(clienteDTO.getCodigoCiclo());
			registroFacturacionDTO.setFormatoFecha(parametrosGrales.getValorparametro());

			registroFacturacionDTO = BORegistroFacturacion.getDiasProrrateo(registroFacturacionDTO);
			if (registroFacturacionDTO!=null){
				fImportePlan = (fImportePlan * registroFacturacionDTO.getDiasDiferencia()/ registroFacturacionDTO.getDiasProrrateo());
			}
			intCentralDTO.setPlan(planTarifario.getPlanComverse()==null?planTarifario.getCodigoPlanTarifario():planTarifario.getPlanComverse());
		}
		intCentralDTO.setPlan(planTarifario.getPlanComverse()==null?planTarifario.getCodigoPlanTarifario():planTarifario.getPlanComverse());

		RegistroFacturacionDTO registroFacturacionDTO2 = new RegistroFacturacionDTO();
		registroFacturacionDTO2.setCodigoCliente(String.valueOf(parametros.getCodCliente().longValue()));
		registroFacturacionDTO2.setCodigoOficina(parametros.getCodOficina());
		Long lValorImporteMultAux = new Long(Math.round(fImportePlan*Math.pow(10,parametros.getNumDecimalBD())));
		Double  dValorImporteAux = new Double(lValorImporteMultAux.longValue()/Math.pow(10,parametros.getNumDecimalBD()));
		fImportePlan =  dValorImporteAux.floatValue();
		registroFacturacionDTO2.setImportePlan(fImportePlan);
		registroFacturacionDTO2.setImporteTotal(fImportePlan);
		parametrosGrales = new ParametrosGeneralesDTO();
		parametrosGrales.setCodigomodulo(config.getString("codigo.modulo.GA"));
		parametrosGrales.setCodigoproducto(config.getString("codigo.producto"));
		parametrosGrales.setNombreparametro(config.getString("parametro.aplica.impuesto"));
		parametrosGrales=BOParametrosGenerales.getParametroGeneral(parametrosGrales);
		long aplicaImpuesto = Long.parseLong(parametrosGrales.getValorparametro());
		if (aplicaImpuesto == 0){
			registroFacturacionDTO2 = BORegistroFacturacion.aplicaImpuestoImporte(registroFacturacionDTO2);
		}

		if (registroFacturacionDTO2!=null)
			fImportePlan = registroFacturacionDTO2.getImporteTotal();

		logger.debug("Antes de plan prepago Hibrido");
		logger.debug("planTarifario.getCodigoTipoPlan() ["+planTarifario.getCodigoTipoPlan()+"]");
		logger.debug("parametros.getTipoPlanHibrido() ["+parametros.getTipoPlanHibrido()+"]");
		logger.debug("parametros.getTipoPlanPrepago() ["+parametros.getTipoPlanPrepago()+"]");

		if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido()) || planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanPrepago()))
		{
			logger.debug("plan prepago Hibrido");
			if(centralSistema.getCodGrupoTecnologico().equals("GSM")){
				logger.debug("Carga GSM");
				intCentralDTO.setValorPlan(fImportePlan);
				//solo prepagos				
				intCentralDTO.setCarga(simcard2.getCarga());				
			}else{
				logger.debug("Carga CDMA");
				TerminalSNPNDTO terminalCarga = new TerminalSNPNDTO();
				terminalCarga.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
				terminalCarga = BOTerminal.getTerminal(terminalCarga);				
				intCentralDTO.setCarga(terminalCarga.getCarga() );
			}


		}

		BOInterfazCentral.provisionaLinea(intCentralDTO);
		enviaMovtoSSCentrales(parametros, intCentralDTO.getCodActabo(), centralSistema);
		
		BOAbonado.regBeneficioPrepago(parametros.getAbonado());
		
		logger.debug("provisionandoLinea():fin");

	}//fin provicionandoLinea


	private void enviaMovtoSSCentrales(GaVentasDTO datosVenta, String codActAbo, CentralDTO centralSistema) 
	throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:enviaMovtoSSCentrales()");

		InterfazCentralDTO intCentralDTO = new InterfazCentralDTO();
		DatosGeneralesDTO datosGrales = new DatosGeneralesDTO();

		SimcardSNPNDTO simcard = new SimcardSNPNDTO();

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
		parametrosGrales.setCodigomodulo(config.getString("codigo.modulo.GA"));
		parametrosGrales.setCodigoproducto(config.getString("codigo.producto"));
		parametrosGrales.setNombreparametro(config.getString("parametro.ind.autentificacion"));
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		parametrosGrales = BOParametrosGenerales.getParametroGeneral(parametrosGrales);
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
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
		actuacionServSupl = config.getString("codigo.actuacion.servsupl");

		//-- OBTIENE CODIGO ACTUACION CENTRAL PARA LA ACTUACION DEL ABONADO Y TECNOLOGIA
		//------------------------------------------------------------------------------
		DatosGeneralesDTO datos = new DatosGeneralesDTO();
		datos.setCodigoProducto(config.getString("codigo.producto"));
		datos.setCodigoTecnologia(datosVenta.getAbonado().getCodTecnologia());
		//datos.setCodigoActuacionAbonado(config.getString("codigo.actuacion.venta"));
		datos.setCodigoActuacionAbonado(codActAbo);
		datos = BODatosgenerales.getActuacionCentral(datos);
		actuacionCentral = datos.getCodigoActuacionCentral();
		logger.debug("actuacionCentral: " + actuacionCentral);

		datos = new DatosGeneralesDTO();
		datos.setCodigoProducto(config.getString("codigo.producto"));
		datos.setCodigoTecnologia(datosVenta.getAbonado().getCodTecnologia());
		datos.setCodigoActuacionAbonado(config.getString("codigo.actuacion.servsupl"));
		datos = BODatosgenerales.getActuacionCentral(datos);
		actuacionCentralSS = datos.getCodigoActuacionCentral();
		logger.debug("actuacionCentralSS: " + actuacionCentralSS);

		//-- OBTIENE SERVICIOS SUPLEMENTARIOS PARA ENVIAR A CENTRALES 
		//-----------------------------------------------------------
		ServicioSuplementarioDTO entradaServSupl = new ServicioSuplementarioDTO();
		entradaServSupl.setNumeroAbonado(String.valueOf(datosVenta.getAbonado().getNumAbonado()));
		entradaServSupl.setIndicadorEstado(Integer.parseInt(config.getString("codigo.estado.alta_bd")));

		entradaServSupl.setCodigoProducto(config.getString("codigo.producto"));
		entradaServSupl.setCodigoModulo(config.getString("codigo.modulo.GA"));
		entradaServSupl.setCodigoSistema(centralSistema.getCodigoSistema() );
		entradaServSupl.setCodigoActuacion(actuacionCentral);

		ServicioSuplementarioDTO[] listaServiciosSuplemantarios = BOServicioSuplementario.getSSAbonadoParaCentrales(entradaServSupl);
		cadenaSS ="";

		logger.debug("listaServiciosSuplemantarios.length ["+listaServiciosSuplemantarios.length+"]");

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

		logger.debug("cadenaSS.equals() ["+cadenaSS.equals("")+"]");

		if (!cadenaSS.equals("")){
			logger.debug("enviaMovtoSSCentrales: Insertando movimiento...");

			//-- INSERTA MOVIMIENTO PARA CENTRALES
			//------------------------------------
			/*Obtiene secuencia movimiento a centrales */
			datosGrales.setCodigoSecuencia(config.getString("secuencia.movimiento.central"));
			datosGrales = BODatosgenerales.getSecuencia(datosGrales);

			intCentralDTO.setNumeroMovimiento(datosGrales.getSecuencia());
			intCentralDTO.setNumeroMovtoAnterior(datosVenta.getNumeroMovtoAnterior());
			intCentralDTO.setNumeroAbonado(datosVenta.getAbonado().getNumAbonado());
			intCentralDTO.setCodigoEstado(Integer.parseInt(config.getString("codigo.estado.alta_bd")));
			intCentralDTO.setCodActabo(actuacionServSupl);
			intCentralDTO.setCodigoModulo(config.getString("codigo.modulo.GA"));
			intCentralDTO.setCodigoActuacion(actuacionCentralSS);
			intCentralDTO.setCodigoUsuario(datosVenta.getCodigoUsuario());
			
			Date fecha = new Date();
			Calendar cal = new GregorianCalendar(); 
			cal.setTimeInMillis(fecha.getTime()); 
			//INICIO CSR-11002
//			Date fechaIngreso = new Date(cal.getTimeInMillis()); 
//			String fechaIngresoFormateada = Formatting.dateTime(fechaIngreso,"dd/MM/yyyy HH:mm:ss");
//			intCentralDTO.setFechaIngreso(fechaIngresoFormateada);
			intCentralDTO.setFechaIngreso(new java.sql.Timestamp( cal.getTimeInMillis()));
			//FIN CSR-11002
			
			intCentralDTO.setTipoTerminal(datosVenta.getAbonado().getTipTerminal());
			intCentralDTO.setCodigoCentral(datosVenta.getAbonado().getCodCentral());
			intCentralDTO.setNumeroCelular(datosVenta.getAbonado().getNumCelular());
			intCentralDTO.setCodigoServicio(cadenaSS);
			intCentralDTO.setNumMin(datosVenta.getAbonado().getNumMin());
			CentralDTO central = new CentralDTO();
			central.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto")));
			central.setCodigoCentral(String.valueOf(datosVenta.getAbonado().getCodCentral()));
			central = BOCentral.getCentral(central);
			intCentralDTO.setTipoTecnologia(central.getCodigoTecnologia());





			if(centralSistema.getCodGrupoTecnologico().equals("GSM")){

				simcard.setCodigoImsi(config.getString("codigo.imsi"));
				simcard.setNumeroSerie(datosVenta.getAbonado().getNumSerieSimcard());

				simcard = BOSimcard.getImsiSimcard(simcard);
				intCentralDTO.setNumeroSerie(datosVenta.getAbonado().getNumSerieSimcard());
				intCentralDTO.setImei(datosVenta.getAbonado().getNumSerieTerminal());
				intCentralDTO.setIcc(datosVenta.getAbonado().getNumSerieSimcard());
				intCentralDTO.setImsi(simcard.getValorImsi());
			}else{
				intCentralDTO.setImsi("");
				intCentralDTO.setImei("");
				intCentralDTO.setIcc("");
				intCentralDTO.setNumeroSerie(datosVenta.getAbonado().getNumSerieHex());
			}

			logger.debug("Despues del If antes de inser a centrales");
			logger.debug("intCentralDTO.getCodigoServicio() ["+intCentralDTO.getCodigoServicio()+"]");
			BOInterfazCentral.provisionaLinea(intCentralDTO);	    

		}
		//-- Actualiza clase servicio del abonado 
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNumAbonado(datosVenta.getAbonado().getNumAbonado());

		//Completa la cadena de clase servicio con los SS no enviados a centrales
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Antes de getSSAbonadoNoCentrales ");
		ServicioSuplementarioDTO[] servicioSuplementarioDTOs = BOServicioSuplementario.getSSAbonadoNoCentrales(entradaServSupl);
		logger.debug("despues de getSSAbonadoNoCentrales ");
		logger.debug("servicioSuplementarioDTOs.length ["+servicioSuplementarioDTOs.length+"]");
		for(int j=0;j<servicioSuplementarioDTOs.length;j++)
		{
			cadenaSS = cadenaSS + servicioSuplementarioDTOs[j].getCadSSNivel();
		}

		logger.debug("antes  de updAbonadoClaseServ ");
		abonado.setClaseServicio(cadenaSS);
		BOAbonado.updAbonadoClaseServ(abonado);
		logger.debug("despues de updAbonadoClaseServ ");

		logger.debug("Fin:enviaMovtoSSCentrales()");
	}//fin enviaMovtoSSCentrales

	private String completarString(String stringEntrada,int largoMaximoString,String caracter,String direccion){
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

	}
	public RetornoDTO getConsultaUsuario(UsuarioDTO usuario)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		RetornoDTO retValue=null;
		try{
			logger.debug("getConsultaUsuario():start");
			retValue = BOUsuario.getConsultaUsuario(usuario);
			logger.debug("getConsultaUsuario():end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	public RetornoDTO setAnulacionVenta(ParametrosAnulacionVentaDTO parametrosAnulacionVentaDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		RetornoDTO retValue=null;
		try{
			logger.debug("setAnulacionVenta:start");
			retValue= BOCliente.setAnulacionVenta(parametrosAnulacionVentaDTO);
			logger.debug("setAnulacionVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	public void  grabaEstadoAsinc(EstadoAsincDTO EstadoAsinc)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("grabaEstadoAsinc:start");
			bOParametrosAuditoriaBO.grabaEstadoAsinc(EstadoAsinc);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("grabaEstadoAsinc:end");
	}


	public void  grabaEstadoAsincSinSPNID(EstadoAsincDTO EstadoAsinc)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("grabaEstadoAsincSinSPNID:start");
			bOParametrosAuditoriaBO.grabaEstadoAsincSinSPNID(EstadoAsinc);

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("grabaEstadoAsincSinSPNID:end");
	}	


	public AbonadoDTO[] getListaAbonadosVenta(RegistroVentaDTO entrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		AbonadoDTO[] resultado= null;
		try{
			logger.debug("Inicio:getListaAbonadosVenta()");
			resultado = BOAbonado.getListaAbonadosVenta(entrada);
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getListaAbonadosVenta()");
		return resultado;
	}//fin getListaAbonadosVenta


	public GaVentasDTO procesosPreCierre(GaVentasDTO parametros) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:procesosPreCierre");
		int codErrorTerminal;

		RegistroVentaDTO regVenta = new RegistroVentaDTO();
		regVenta.setNumeroVenta(parametros.getNumVenta().longValue());

		ClienteDTO cliente = new ClienteDTO();
		cliente.setNumeroIdentificacion(parametros.getNumIdentCliente());
		cliente.setCodigoTipoIdentificacion(parametros.getTipIdentCliente());
		cliente.setTipoCliente(parametros.getTipoCliente());

		AbonadoDTO[] listaAbonados = getListaAbonadosVenta(regVenta);
		ContratoDTO contrato = new ContratoDTO();
		cliente.setCodigoCliente(String.valueOf(parametros.getCodCliente()));
		cliente = BOCliente.getCliente(cliente);
		contrato.setCodigoCuenta(cliente.getCodigoCuenta());
		contrato.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto")));
		contrato.setCodigoTipoContrato(parametros.getCodTipContrato());
		contrato.setIndComodato(parametros.getIndComodato());
		contrato.setNumeroContrato(parametros.getNumContrato());
		contrato.setNumeroMeses(parametros.getNumeroMesesContrato());
		contrato.setNumeroVenta(parametros.getNumVenta().longValue());
		int iNumAnexo;
		if (parametros.getIndicadorContratoNuevo() == 1)
			iNumAnexo=1;

		else{
			contrato = BOContrato.getMaxAnexoContrato(contrato);
			iNumAnexo = Integer.parseInt(contrato.getNumeroAnexo())+1;
		}
		
		

		for(int i=0;i<listaAbonados.length;i++){
														
			logger.debug("listaAbonados[i].getNumSerieSimcard() [" + listaAbonados[i].getNumSerieSimcard() + "]");		
			logger.debug("listaAbonados[i].getNumSerieTerminal() [" + listaAbonados[i].getNumSerieTerminal() + "]");
			
			listaAbonados[i].setMontoGarantia(parametros.getMtoGarantia().floatValue());
			listaAbonados[i].setNumVenta(parametros.getNumVenta().longValue());
			/*----(1) Almacena la garantia asociada a cada uno de los abonados de la venta----*/

			try{
				if (listaAbonados[i].getMontoGarantia()>0)
					BOAbonado.insertaGarantiaAbonado(listaAbonados[i]);
			}catch(GeneralException e){
				logger.debug("Ocurrio un error al registrar la garantia");
				throw e;
			}
			/*----(2) realiza alta de contrato----*/
			contrato.setNumeroAbonados(1);
			contrato.setNumAbonado(String.valueOf(listaAbonados[i].getNumAbonado()));
			String iNumeroAnexo = Formatting.number(iNumAnexo,config.getString("formato.numero.anexo"));
			contrato.setNumeroAnexo(contrato.getNumeroContrato().substring(0,16) + iNumeroAnexo);
			
			ContratoDTO contrato2 = new ContratoDTO();			          
			contrato2.setCodigoTipoContrato(parametros.getCodTipContrato());
			contrato2 = BOContrato.getTipcontrato(contrato2);
			contrato.setNumeroMeses(contrato2.getNumeroMeses());
			BOContrato.altaContrato(contrato);
			iNumAnexo++;

			//--Inserta Contratos en tabla ga_docventa
			GaDocVentasDTO gaDocVentasDTO=new GaDocVentasDTO();
			gaDocVentasDTO.setNum_Venta(parametros.getNumVenta());			
			gaDocVentasDTO.setNum_Folio(contrato.getNumeroAnexo());
			gaDocVentasDTO = insertGaDocVentas(gaDocVentasDTO);


			//-- SALIDA DE SIMCARD Y EQUIPOS
			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNumAbonado(listaAbonados[i].getNumAbonado());
			abonado.setIndProcEqTerminal(config.getString("indicador.procedencia.interna"));
			AbonadoDTO[] equiposSeriados =  BOAbonado.getEquiposSeriados(abonado);
				
			
			SimcardSNPNDTO simcardPreCierre = new SimcardSNPNDTO();
			TerminalSNPNDTO terminaPreCierre = new TerminalSNPNDTO();
						
			
			SerieKitDTO serieKit = new SerieKitDTO();
			serieKit.setNumSerieSimcard(listaAbonados[i].getNumSerieSimcard());
			serieKit.setNumSerieTerminal(listaAbonados[i].getNumSerieTerminal());		
			serieKit = BOSerieKit.validaSerieKit(serieKit);
		
			
			if(serieKit.getNumSerieKit().equals("")){
				simcardPreCierre.setNumeroSerie(listaAbonados[i].getNumSerieSimcard());
				simcardPreCierre = BOSimcard.getSimcard(simcardPreCierre);
			}else{
				SerieKitDTO seriekit = new SerieKitDTO();
				seriekit.setNumSerieKit(serieKit.getNumSerieKit());
				seriekit.setNumSerieSimcard(listaAbonados[i].getNumSerieSimcard());
				simcardPreCierre = BOSerieKit.getSerieSimcardKit(seriekit);
				
				seriekit.setNumSerieKit(serieKit.getNumSerieKit());
				seriekit.setNumSerieTerminal(listaAbonados[i].getNumSerieTerminal());
				terminaPreCierre = BOSerieKit.getSerieTerminalKit(seriekit);
			}

			logger.debug("Inicio recorre equipaboser para el abonado...");
			for(int j=0;j<equiposSeriados.length;j++)
			{
				AbonadoDTO abonadoDTO = new AbonadoDTO();
				abonadoDTO.setNumAbonado(listaAbonados[i].getNumAbonado());
				abonadoDTO.setTipoStock(equiposSeriados[j].getTipoStock());
				abonadoDTO.setCodigoBodegaActual(equiposSeriados[j].getCodigoBodega());
				abonadoDTO.setTipoStockOriginal(equiposSeriados[j].getTipoStock());
				abonadoDTO.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
				abonadoDTO.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
				abonadoDTO.setCodUso(equiposSeriados[j].getCodUso());
				abonadoDTO.setCodigoEstado(equiposSeriados[j].getCodigoEstado());
				abonadoDTO.setNumeroSerie(equiposSeriados[j].getNumeroSerie());

				SerieDTO serie = new SerieDTO();
				if (equiposSeriados[j].getTipTerminal().equals(config.getString("tipo.terminal.simcard")))
				{
					/*SimcardSNPNDTO simcardDTO = new SimcardSNPNDTO();
					simcardDTO.setTipoStock(String.valueOf(equiposSeriados[j].getTipoStock()));
					simcardDTO.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
					simcardDTO.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
					simcardDTO.setCodigoUso(equiposSeriados[j].getCodUso());
					simcardDTO.setEstado(equiposSeriados[j].getCodigoEstado());
					simcardDTO.setNumeroVenta(String.valueOf(parametros.getNumVenta().longValue()));
					simcardDTO.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
					simcardDTO.setIndicadorTelefono(String.valueOf(equiposSeriados[j].getIndTelefono()));
					//-- ACTUALIZA STOCK SIMCARD
					simcardDTO.setTipoMovimiento(config.getString("tipo.movto.saldefinitiva")); // salida definitiva

					simcardDTO = BOSimcard.actualizaStockSimcard(simcardDTO);*/
					
					
					if (serieKit.getNumSerieKit().equals("")){					
						serie.setNumSerie(equiposSeriados[j].getNumeroSerie());
						serie.setNomUsuario(parametros.getNomUsuarVta());
						serie.setNumPorceso(String.valueOf(parametros.getNumVenta().longValue()));					
					}else{
						serie.setNumSerie(serieKit.getNumSerieKit());
						serie.setNomUsuario(parametros.getNomUsuarVta());
						serie.setNumPorceso(String.valueOf(parametros.getNumVenta().longValue()));					
						
					}
					
					serie = BOSerie.salidaDefinitivaSerie(serie);
					abonadoDTO.setNumeroMovimiento(serie.getNumMovimiento());				
					//-- ACTUALIZA EQUIPABOSER
					BOAbonado.actualizaEquipAboSer(abonadoDTO);
				}
				else 
				{
					codErrorTerminal = 0;

					TerminalSNPNDTO terminalDTO = new TerminalSNPNDTO();
					terminalDTO.setTipoStock(String.valueOf(equiposSeriados[j].getTipoStock()));
					terminalDTO.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
					terminalDTO.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
					terminalDTO.setCodigoUso(equiposSeriados[j].getCodUso());
					terminalDTO.setEstado(equiposSeriados[j].getCodigoEstado());
					terminalDTO.setNumeroVenta(String.valueOf(parametros.getNumVenta().longValue()));
					terminalDTO.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
					terminalDTO.setIndicadorTelefono(String.valueOf(equiposSeriados[j].getIndTelefono()));

					//-- ACTUALIZA STOCK TERMINAL

					ModalidadPagoDTO modalidad = new ModalidadPagoDTO();
					modalidad.setCodigoModalidadPago(parametros.getCodModVenta().toString());
					BOModalidadPago.getModalidadPago(modalidad);        			
					parametros.setIndicadorCuotas(modalidad.getIndicadorCuotas());

					logger.debug("parametros.getIndicadorCuotas() ["+ parametros.getIndicadorCuotas() +"]");
					logger.debug("contrato.getIndComodato() ["+contrato.getIndComodato()+"]");        			
					logger.debug("parametros.getIndicadorCuotas() ["+ parametros.getIndicadorCuotas() +"]");
					if ((String.valueOf(contrato.getIndComodato()) == config.getString("indicador.comodato") || parametros.getIndicadorCuotas().equals("2") ||  parametros.getIndicadorCuotas().equals("-1"))
							&& equiposSeriados[j].getIndicadorEquiAcc().equals(config.getString("indicador.equipo")))
					{
						logger.debug("entra salida temporal de bodega ");
						terminalDTO.setTipoMovimiento(config.getString("tipo.movto.saltmp.arriendo")); // salida temporal por arriendo
						terminalDTO.setTipoStock(config.getString("tipo.stock.activo.fijo"));
						terminalDTO = BOTerminal.actualizaStockTerminal(terminalDTO);
						abonadoDTO.setNumeroMovimiento(terminalDTO.getNumeroMovimiento());
						codErrorTerminal = terminalDTO.getCodigoError();

						if (codErrorTerminal == 0)
							//-- si es comodato cambio a bodega desde parámetro
							if (String.valueOf(contrato.getIndComodato()) == config.getString("indicador.comodato"))
							{
								TerminalSNPNDTO terminalDTO2 = new TerminalSNPNDTO();
								terminalDTO2.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
								terminalDTO2 = BOTerminal.getEstadoAnterior(terminalDTO2);

								terminalDTO2.setTipoStock(String.valueOf(equiposSeriados[j].getTipoStock()));
								terminalDTO2.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
								terminalDTO2.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
								terminalDTO2.setCodigoUso(equiposSeriados[j].getCodUso());
								terminalDTO2.setEstado(terminalDTO2.getEstadoAnterior());
								terminalDTO2.setNumeroVenta(String.valueOf(equiposSeriados[j].getNumVenta()));
								terminalDTO2.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
								terminalDTO2.setIndicadorTelefono(String.valueOf(equiposSeriados[j].getIndTelefono()));

								ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
								parametrosGral.setNombreparametro(config.getString("parametro.bodega.comodato"));
								parametrosGral.setCodigoproducto(config.getString("codigo.producto"));
								parametrosGral.setCodigomodulo(config.getString("codigo.modulo.AL"));
								parametrosGral = BOParametrosGenerales.getParametroGeneral(parametrosGral);
								terminalDTO2.setCodigoBodega(parametrosGral.getValorparametro());

								terminalDTO2.setTipoMovimiento(config.getString("tipo.movto.retsaltmp.arriendo")); // retroceso salida temporal por arriendo
								terminalDTO2.setTipoStock(config.getString("tipo.stock.activo.fijo"));

								terminalDTO2 = BOTerminal.actualizaStockTerminal(terminalDTO2);
								abonadoDTO.setNumeroMovimiento(terminalDTO2.getNumeroMovimiento());
								codErrorTerminal = terminalDTO2.getCodigoError();

							}

						if (codErrorTerminal == 0)
							//-- ACTUALIZA EQUIPABOSER
							BOAbonado.actualizaEquipAboSer(abonadoDTO);
					}
					else{
						logger.debug("entra salida definitiva de bodega ");
						/*terminalDTO.setTipoMovimiento(config.getString("tipo.movto.saldefinitiva")); // salida definitiva
						terminalDTO = BOTerminal.actualizaStockTerminal(terminalDTO);
						abonadoDTO.setNumeroMovimiento(terminalDTO.getNumeroMovimiento());
						codErrorTerminal = terminalDTO.getCodigoError();
						if (codErrorTerminal == 0)
							//-- ACTUALIZA EQUIPABOSER
							BOAbonado.actualizaEquipAboSer(abonadoDTO);*/



						SerieDTO serie2 = new SerieDTO();
						serie2.setNumSerie(terminalDTO.getNumeroSerie());
						serie2.setNomUsuario(parametros.getNomUsuarVta());
						serie2.setNumPorceso(String.valueOf(parametros.getNumVenta().longValue()));					
						

						if (serieKit.getNumSerieKit().equals("")){
							serie2 = BOSerie.salidaDefinitivaSerie(serie2);
							abonadoDTO.setNumeroMovimiento(serie2.getNumMovimiento());
						}else{
							abonadoDTO.setNumeroMovimiento(serie.getNumMovimiento());
						}
						//-- ACTUALIZA EQUIPABOSER
						BOAbonado.actualizaEquipAboSer(abonadoDTO);									
					}
				}
			}  
		}

		logger.debug("Fin:procesosPreCierre");
		return parametros;
	}//fin procesosPreCierre


	private GaDocVentasDTO insertGaDocVentas(GaDocVentasDTO gaDocVentasDTO)
	throws GeneralException		
	{	
		logger.debug("insertGaDocVentas():start");
		DatosGeneralesDTO datosGenerDTO=new DatosGeneralesDTO();
		datosGenerDTO.setColumna(config.getString("nombre.columna.docanexo"));
		datosGenerDTO = BODatosgenerales.getDatosGener(datosGenerDTO);
		gaDocVentasDTO.setCod_TipDocumento(new Long(datosGenerDTO.getValorParametro()));
		gaDocVentasDTO = BORegistroVenta.insertGaDocVentas(gaDocVentasDTO);		
		logger.debug("insertGaDocVentas():end");
		return gaDocVentasDTO;
	}



	public void cierreVenta(GaVentasDTO gaVentasDTO) throws GeneralException{
		logger.debug("cierreVenta():start");
		ParametrosGeneralesDTO parametrosGeneralesDTO=new ParametrosGeneralesDTO();
		gaVentasDTO.setIndVenta(config.getString("venta.indicador.venta"));
		gaVentasDTO.setIndOfiter(config.getString("venta.oficina"));
		gaVentasDTO.setIndChkDicom(config.getString("venta.chkdicom"));

//		se procede a efectuar los codigos alternativos
		parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.modalidad.venta.credito"));
		parametrosGeneralesDTO.setCodigoproducto(config.getString("codigo.producto"));
		parametrosGeneralesDTO.setCodigomodulo(config.getString("codigo.modulo.GA"));
		parametrosGeneralesDTO = BOParametrosGenerales.getParametroGeneral(parametrosGeneralesDTO);
		parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
		gaVentasDTO.setCodModPago(gaVentasDTO.getCodModPago()==null?"":gaVentasDTO.getCodModPago());
		if (parametrosGeneralesDTO.getValorparametro().equals(gaVentasDTO.getCodModPago())){
			gaVentasDTO.setCuotas(true);
		}else{
			gaVentasDTO.setTipValor(config.getString("tipo.valor"));
		}
		parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.tarjeta.credito"));
		parametrosGeneralesDTO = BOParametrosGenerales.getParametroGeneral(parametrosGeneralesDTO);
		parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
		gaVentasDTO.setCodModPago(gaVentasDTO.getCodModPago()==null?"":gaVentasDTO.getCodModPago());
		if (parametrosGeneralesDTO.getValorparametro().equals(gaVentasDTO.getCodModPago())){
			gaVentasDTO.setTrajCredito(true);
		}
		parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.codigo.cheque"));
		parametrosGeneralesDTO = BOParametrosGenerales.getParametroGeneral(parametrosGeneralesDTO);
		gaVentasDTO.setCodModPago(gaVentasDTO.getCodModPago()==null?"":gaVentasDTO.getCodModPago());
		parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());

		if (parametrosGeneralesDTO.getValorparametro().equals(gaVentasDTO.getCodModPago())){
			gaVentasDTO.setCheque(true);
		}
		gaVentasDTO.setIndEstVenta(config.getString("estado.solicitud.pendiente"));

		BORegistroVenta.updateVentasEscenarioD(gaVentasDTO);

		//Se actualiza código situación de los abonados
		AbonadoDTO abonadoDTO = new AbonadoDTO();
		abonadoDTO.setNumVenta(gaVentasDTO.getNumVenta().longValue());
		abonadoDTO.setCodSituacion(config.getString("codigo.situacion.final"));
		BOAbonado.updCodigoSituacion(abonadoDTO);

		//Desreserva numero celular asociados a la venta
		BORegistroVenta.desreservaCelular(gaVentasDTO);
		FacturacionBO.udpInterfazDeFacturación(gaVentasDTO);

		logger.debug("cierreVenta():end");
	}	



	public GaVentasDTO getVenta(GaVentasDTO gaVentasDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getVenta:start");
			gaVentasDTO = BORegistroVenta.getVenta(gaVentasDTO);			
			logger.debug("getVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return gaVentasDTO;
	}	

	//validar tarjeta
	public WSValidarTarjetaOutDTO validarTarjeta(WsValTarjetaInDTO wsValTarjetaInDTO) throws GeneralException{
		WSValidarTarjetaOutDTO retValue=null;
		try{
			retValue=BOCliente.validarTarjeta(wsValTarjetaInDTO);

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	public boolean  isExisteCodCausaBaja(String codCausaBaja)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		boolean retValue=false;
		try{
			logger.debug("isExisteCodCausaBaja:start");
			retValue= BOCliente.isExisteCodCausaBaja(codCausaBaja);
			logger.debug("isExisteCodCausaBaja:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Fin:isExisteCodCausaBaja()");
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public ContratoDTO obtenerContratoNuevo() throws GeneralException{
		logger.debug("Inicio:obtenerContratoNuevo");
		DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
		datosGenerales.setCodigoSecuencia(config.getString("secuencia.contrato"));
		datosGenerales  = BODatosgenerales.getSecuencia(datosGenerales);
		String numeroContrato = Formatting.number(datosGenerales.getSecuencia(),config.getString("formato.numero.contrato"));
		ContratoDTO contrato = new ContratoDTO();
		Calendar hoy = Calendar.getInstance();
		String año = Formatting.dateTime(hoy,"yy");
		numeroContrato = config.getString("prefijo.numero.contrato") + "-" + numeroContrato + "-" + año +  "-" +  config.getString("sufijo.numero.contrato"); 
		contrato.setNumeroContrato(numeroContrato);
		logger.debug("Numero de contrato: " + numeroContrato);
		logger.debug("Fin:obtenerContratoNuevo");
		return contrato;

	}

	public void getUpdateGaVentaEscB(GaVentasDTO gaVentasDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getUpdateGaVentaEscB:start");
			BORegistroVenta.updateVentasEscenarioB(gaVentasDTO);			
			logger.debug("getVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getUpdateGaVentaEscB:end");
	}


	public void updateVentas(GaVentasDTO gaVentasDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("updateVentas:start");
			BORegistroVenta.updateVentasEscenarioD(gaVentasDTO);			
			logger.debug("getVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("updateVentas:end");
	}

	public RetornoDTO setObservacionFactura(FaMensProcesoDTO faMensProcesoDTO)throws GeneralException{ 
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		RetornoDTO retValue;
		try{
			logger.debug("setObservacionFactura:start");
			DatosGeneralesDTO dg=new DatosGeneralesDTO();
			dg.setCodigoSecuencia(config.getString("codigo.secuencia.famensajes"));
			dg=BODatosgenerales.getSecuencia(dg);
			faMensProcesoDTO.setCorrMensaje(dg.getSecuencia());
			retValue= BOCliente.setObservacionFactura(faMensProcesoDTO);			
			logger.debug("setObservacionFactura:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("setObservacionFactura:end");
		return retValue;
	}


	public ArrayList validaIdentificador(CuentaComDTO cuentaCom,ArrayList listaerrores)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		DatosGeneralesDTO datosGenerales;
		WsRespuestaValidacionCuentaDTO retorno;
		try{

			// Valida Identificador de Cuenta

			logger.debug("Validar NumIdent Cuenta");
			datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoModulo("GE");
			datosGenerales.setCorrelativo("1");
			datosGenerales.setNumeroIdentificador(cuentaCom.getNumeroIdentificacion());
			datosGenerales.setTipoIdentificador(cuentaCom.getCodigoTipIdentif());			
			datosGenerales = BODatosgenerales.validaIdentificador(datosGenerales);
			logger.debug("Validar NumIdent Cuenta datosGenerales.isBResultadoValidacion() ["+datosGenerales.isBResultadoValidacion()+"]");
			if (!datosGenerales.isBResultadoValidacion()){
				logger.debug("12379 - Error al validar Numero de Identificacion de la Cuenta");
				retorno = new WsRespuestaValidacionCuentaDTO(); 
				retorno.setCodigoRespuesta("12379");
				retorno.setDescripcion("Error al validar Numero de Identificacion de la Cuenta");						
				listaerrores.add(retorno);											
			}

			// Valida Identificador de apoderado	
			logger.debug("Validar NumIdent apoderado");
			datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoModulo("GE");
			datosGenerales.setCorrelativo("1");
			datosGenerales.setNumeroIdentificador(cuentaCom.getClienteComDTO().getNumeroIdentificacionApoderado()  );
			datosGenerales.setTipoIdentificador(cuentaCom.getClienteComDTO().getCodigoTipoIdentificacionApoderado()  );			
			datosGenerales = BODatosgenerales.validaIdentificador(datosGenerales);
			logger.debug("Validar NumIdent apoderado datosGenerales.isBResultadoValidacion() ["+datosGenerales.isBResultadoValidacion()+"]");
			if (!datosGenerales.isBResultadoValidacion()){
				logger.debug("12380 - Error al validar Numero de Identificacion del Apoderado");
				retorno = new WsRespuestaValidacionCuentaDTO(); 
				retorno.setCodigoRespuesta("12380");
				retorno.setDescripcion("Error al validar Numero de Identificacion del Apoderado");						
				listaerrores.add(retorno);								
			}

			// Valida Identificador de respon	
			logger.debug("Validar NumIdent respon");
			datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoModulo("GE");
			datosGenerales.setCorrelativo("1");
			datosGenerales.setNumeroIdentificador(cuentaCom.getClienteComDTO().getRepresentanteLegalComDTO()[0].getNumeroTipoIdentificacion());
			datosGenerales.setTipoIdentificador(cuentaCom.getClienteComDTO().getRepresentanteLegalComDTO()[0].getCodigoTipoIdentificacion());			
			datosGenerales = BODatosgenerales.validaIdentificador(datosGenerales);
			logger.debug("Validar NumIdent respon datosGenerales.isBResultadoValidacion() ["+datosGenerales.isBResultadoValidacion()+"]");
			if (!datosGenerales.isBResultadoValidacion()){
				logger.debug("12381 - Error al validar Numero de Identificacion del Apoderado");
				retorno = new WsRespuestaValidacionCuentaDTO(); 
				retorno.setCodigoRespuesta("12381");
				retorno.setDescripcion("Error al validar Numero de Identificacion del Representante Legal");						
				listaerrores.add(retorno);										
			}

			/*for (int i=0; i< cuentaCom.getClienteComDTO().getLinea().length;i++){
			datosGenerales.setNumeroIdentificador(cuentaCom.getClienteComDTO().getLinea()[i].get );
			datosGenerales.setTipoIdentificador(cuentaCom.getClienteComDTO().getRepresentanteLegalComDTO()[0].getCodigoTipoIdentificacion());			
			datosGenerales = BODatosgenerales.validaIdentificador(datosGenerales);
			if (!datosGenerales.isBResultadoValidacion()){
				throw new GeneralException("10101",0,"Error al validar Numero de Identificacion del Representante Legal");
			}
		}*/

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}	

		return listaerrores;

	}


	public CentralDTO[] getListadoCentrales(CeldaDTO entrada) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		CentralDTO[] resultado = null;
		try{
			logger.debug("getListadoCentrales:start");
			resultado = BOCentral.getListadoCentrales(entrada);			
			logger.debug("getVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getListadoCentrales:end");
		return resultado;

	}	







	public void insDocumentoMotivo(CausalDescuentoDTO entrada)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		CentralDTO[] resultado = null;
		try{
			logger.debug("insDocumentoMotivo:start");
			BOCausalDescuento.insDocumentoMotivo(entrada);			
			logger.debug("getVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("insDocumentoMotivo:end");		

	}	

	public WsMotivosDeDescuentoManualInDTO[] getListMotivosDeDescuentoManual(CausalDescuentoDTO causalDescuentoDTO) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsMotivosDeDescuentoManualInDTO[] resultado = null;
		try{
			logger.debug("getListMotivosDeDescuentoManual:start");
			resultado = BOCausalDescuento.getListMotivosDeDescuentoManual(causalDescuentoDTO);			
			logger.debug("getVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getListMotivosDeDescuentoManual:end");
		return resultado;

	}		


	public ClienteDTO getclientes(ClienteDTO cliente) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getclientes:start");
			cliente = BOCliente.getCliente(cliente);			
			logger.debug("getVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getclientes:end");
		return cliente;

	}	



	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO planTarifarioDTO) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getCategoriaPlanTarifario:start");
			planTarifarioDTO = BOPlanTarifario.getCategoriaPlanTarifario(planTarifarioDTO);			
			logger.debug("getCategoriaPlanTarifario:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getclientes:end");
		return planTarifarioDTO;

	}		

	public ContratoDTO getTipcontrato(ContratoDTO contrato) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getTipcontrato:start");
			contrato = BOContrato.getTipcontrato(contrato);		
			logger.debug("getTipcontrato:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getclientes:end");
		return contrato;

	}    


	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametro) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getParametroGeneral:start");
			parametro = BOParametrosGenerales.getParametroGeneral(parametro) ;		
			logger.debug("getParametroGeneral:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getParametroGeneral:end");
		return parametro;

	}        


	public String validaRangoTerminal(TerminalSNPNDTO TerminalSNPNDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		String retorno = "0";
		try{
			logger.debug("validaRangoTerminal:start");
			retorno =  BOTerminal.validaRangoTerminal(TerminalSNPNDTO) ;		
			logger.debug("validaRangoTerminal:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getParametroGeneral:end");
		return retorno;

	}        

	public SimcardSNPNDTO getSimcardAutomatico(SimcardSNPNDTO simcard)  throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		SimcardSNPNDTO retorno;
		try{
			logger.debug("getSimcardAutomatico:start");
			retorno =  BOSimcard.getSimcardAutomatico(simcard) ;		
			logger.debug("getSimcardAutomatico:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getSimcardAutomatico:end");
		return retorno;

	}            

	public BodegaDTO[] getBodegasPorVendedor(String codigoVendedor) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		BodegaDTO[] retorno;
		try{
			logger.debug("getBodegasPorVendedor:start");
			retorno =  BOVendedor.getBodegasPorVendedor(codigoVendedor) ;		
			logger.debug("getBodegasPorVendedor:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getBodegasPorVendedor:end");
		return retorno;

	}                


	public SerieDTO salidaDefinitivaSerie(SerieDTO serie)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		SerieDTO retorno;
		try{
			logger.debug("salidaDefinitivaSerie:start");
			retorno =  BOSerie.salidaDefinitivaSerie(serie) ;		
			logger.debug("salidaDefinitivaSerie:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("salidaDefinitivaSerie:end");
		return retorno;

	}
	
	public String SalidaDefArticulo(String codArticulo, String nomUsuario, String numVenta, String codVendedor, int numCantidad, String codBodega) 
	throws GeneralException{    	
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		String retValue=null;
		try{
			logger.debug("SalidaDefArticulo:start");
			retValue =  BOArticulo.SalidaDefArticulo(codArticulo,nomUsuario,numVenta,codVendedor,numCantidad,codBodega);		
			logger.debug("SalidaDefArticulo:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("SalidaDefArticulo:end");
		return retValue;

	}	


	public SerieDTO reservaSerie(SerieDTO serie)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		SerieDTO retorno;
		try{
			logger.debug("reservaSerie:start");
			retorno =  BOSerie.reservaSerie(serie) ;		
			logger.debug("reservaSerie:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("reservaSerie:end");
		return retorno;

	}          


	public SerieDTO desReservaSerie(SerieDTO serie)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		SerieDTO retorno;
		try{
			logger.debug("desReservaSerie:start");
			retorno =  BOSerie.desReservaSerie(serie) ;		
			logger.debug("desReservaSerie:end");
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("desReservaSerie:end");
		return retorno;

	}          	


	public WsCuentaIdentOutDTO validaCuentaNumeroIdentificacion(WsCuentaIdentInDTO cuenta) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		WsCuentaIdentOutDTO retorno = null;
		try{
			logger.debug("validaCuentaNumeroIdentificacion:start");
			retorno =  BOCuenta.validaCuentaNumeroIdentificacion(cuenta) ;		
			logger.debug("validaCuentaNumeroIdentificacion:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log GeneralException[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log Exception[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("validaCuentaNumeroIdentificacion:end");
		return retorno;
	}    

//	----------------------------------------------------- NUEVO ----------------------------------------	

	public CuentaComDTO AltaCuentaSubCuenta(CuentaComDTO cuentaComDTO) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		logger.debug("Inicio:crearCliente()");
		try {

			//Verifica si la cuenta existe o no en BD
			
			logger.debug("-------------------Recupera Cuenta------------------");
			logger.debug("cuentaComDTO.getNumeroIdentificacion() ["+cuentaComDTO.getNumeroIdentificacion()+"]");
			logger.debug("cuentaComDTO.getNumeroIdentificacion() ["+cuentaComDTO.getNumeroIdentificacion()+"]");
			cuentaComDTO = getCuenta(cuentaComDTO);

			if (!cuentaComDTO.getCodigoCuenta().equals("0")){
               return cuentaComDTO;
			}
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));			
			//Si la cuenta no existe se registra en BD
			if (cuentaComDTO.getCodigoCuenta().equals("0")){
				cuentaComDTO.setIndicadorEstado(config.getString("indicador.estado.cuenta"));
				cuentaComDTO.setIndicadorMultUso(config.getString("indicador.multiuso"));
				cuentaComDTO.setClientePotencial(config.getString("indicador.cliente.potencial"));				
				crearCuenta(cuentaComDTO);
				UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));				
				if (cuentaComDTO.getClienteComDTO()!=null){
					cuentaComDTO.setCodigoCuenta(cuentaComDTO.getCodigoCuenta());
				}
			}
			else{

				if (!BOCuenta.getValSubCuenta(cuentaComDTO)){
					crearSubCuenta(cuentaComDTO);
				}

				cuentaComDTO = categorizacionCuenta(cuentaComDTO);
				UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));				
			}

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:crearCliente()");
		return cuentaComDTO;
	}	



	public CuentaComDTO AltaCliente(CuentaComDTO cuentaComDTO) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		logger.debug("Inicio:crearCliente()");
		try {

			if (cuentaComDTO.getClienteComDTO()!=null){

				Date fechaActual = new Date(); 
				ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
				
				cuentaComDTO.getClienteComDTO().setIndicadorAgente(config.getString("indicador.agente"));
				cuentaComDTO.getClienteComDTO().setIndicadorSituacion(config.getString("indicador.situacion"));
				cuentaComDTO.getClienteComDTO().setIndicadorAcepVenta(config.getString("indicador.aceptacion.venta"));
				cuentaComDTO.getClienteComDTO().setFechaAcepVenta(Formatting.dateTime(fechaActual, "dd/MM/yyyy"));

				cuentaComDTO.getClienteComDTO().setIndicadorTraspaso(config.getString("indicador.traspaso.si").trim());
				cuentaComDTO.getClienteComDTO().setCodigoModificacion(config.getString("codigo.modificacion.cliente"));
				cuentaComDTO.getClienteComDTO().setIndentificadorSegmento(config.getString("id.segmento.defecto"));								


				//Obtiene secuencia del cliente
				DatosGeneralesDTO datosGeneralesDTO = null;
				cuentaComDTO.getClienteComDTO().setCodigoOperadora(BODatosgenerales.getCodigoOperadora());
				/*CSR-11002 Se comenta las linas de Obtiene calidad y se reemplaza por la lógica de PortalVentasWS
				 * creaCliente de AltaClienteSRV*/
				
				//Obtiene calidad
				datosGeneralesDTO = new DatosGeneralesDTO();
				datosGeneralesDTO.setColumna(config.getString("parametro.calidad.defecto"));
				datosGeneralesDTO = BODatosgenerales.getDatosGener(datosGeneralesDTO);
				cuentaComDTO.getClienteComDTO().setCodigoCalidadCliente(datosGeneralesDTO.getValorParametro());

				/*
				PlanComercialDTO planComercia = new PlanComercialDTO();  

				planComercia.setCodigoCalifCliente(cuentaComDTO.getClienteComDTO().getCodigoCalidadCliente());
				planComercia = BOPlanComercial.getPlanComercial(planComercia);
				
				cuentaComDTO.getClienteComDTO().setCodigoPlanComercial(String.valueOf(planComercia.getCodigoPlanComercial()));
				*
				*/
				
				parametrosGeneralesDTO.setCodigomodulo(config.getString("codigo.modulo.GA").trim());
				parametrosGeneralesDTO.setCodigoproducto(config.getString("codigo.producto").trim());
				parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.plan.comercial").trim());
				parametrosGeneralesDTO = BOParametrosGenerales.getParametroGeneral(parametrosGeneralesDTO);

				cuentaComDTO.getClienteComDTO().setCodigoPlanComercial(parametrosGeneralesDTO.getValorparametro());
				
				cuentaComDTO.getClienteComDTO().setNumeroAbocel(config.getString("numero.abocel"));
				cuentaComDTO.getClienteComDTO().setCodigoNPI(config.getString("codigo.npi"));					

				//Registra Cliente


				if (cuentaComDTO.getClienteComDTO().getCodigoCliente().equals("0")){
					datosGeneralesDTO = new DatosGeneralesDTO();
					datosGeneralesDTO.setCodigoSecuencia(config.getString("secuencia.cliente"));				
					datosGeneralesDTO = BODatosgenerales.getSecuencia(datosGeneralesDTO);
					cuentaComDTO.getClienteComDTO().setCodigoCliente(String.valueOf(datosGeneralesDTO.getSecuencia()));
					BOCliente.insCliente(cuentaComDTO);
					if (cuentaComDTO.getClienteComDTO().getModalidadCancelacionComDTO().getCodigo().equals(config.getString("modalidad.cancelacion.automatica.ind"))
							&& cuentaComDTO.getClienteComDTO().getCodigoSistemaPago().equals(config.getString("sistema.pago.ctacte")))
					{
						ConceptosCobranzaDTO conceptosCobranzaDTO = new ConceptosCobranzaDTO();

						conceptosCobranzaDTO.setCodigoCliente(cuentaComDTO.getClienteComDTO().getCodigoCliente());
						conceptosCobranzaDTO.setCodigoBanco(cuentaComDTO.getClienteComDTO().getCodigoBanco());
						conceptosCobranzaDTO.setNumeroTelefono(cuentaComDTO.getClienteComDTO().getCodigoCliente());//En VB esta así. 
						conceptosCobranzaDTO.setCodigoZona(config.getString("pac.codigo.zona"));
						conceptosCobranzaDTO.setCodigoBcoi(config.getString("pac.codigo.bancoi"));
						conceptosCobranzaDTO.setCodigoCentral(config.getString("pac.codigo.central"));
						BOconceptosCobranza.insPagoAutomatico(conceptosCobranzaDTO);
					}
					
					//INICIO CSR-11002
//					Inserta monto preautorizado
					logger.debug("Inicio:crearCliente() --> Inserta monto preautorizado");
					String montoPreAutorizado = config.getString("monto.preautorizado");
					
					cuentaComDTO.getClienteComDTO().setMontoPreAutorizado(montoPreAutorizado);
					BOCliente.insMontoPreautorizado(cuentaComDTO.getClienteComDTO());
					
					//FIN CSR-11002
					
				}else{
					throw new GeneralException("9825478",1,"El Cliente a crear debe ser nuevo");
				}

			}					
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:crearCliente()");
		return cuentaComDTO;
	}

	//Consulta el stock de serie
	public CantidadStockSerieDTO getCantidadStockSerie(CantidadStockSerieDTO cantidadStockSerieDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		try{
			logger.debug("getCantidadStockSerie:start");
			cantidadStockSerieDTO=BOSerie.getCantidadStockSerie(cantidadStockSerieDTO) ;		
			logger.debug("cantidad stock: " + cantidadStockSerieDTO.getCantidadStock());
			logger.debug("getCantidadStockSerie:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getCantidadStockSerie:end");
		return cantidadStockSerieDTO;
	}

	//Consulta suma de los planes por antiguedad.
	public SumaPrecioPlanesDTO getSumaPrecioPlanesXAntiguedad(SumaPrecioPlanesDTO sumaPrecioPlanesDTO) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		try{
			logger.debug("getSumaPrecioPlanesXAntiguedad:start");
			sumaPrecioPlanesDTO = BOPlanComercial.getSumaPrecioPlanesXAntiguedad(sumaPrecioPlanesDTO);		
			logger.debug("getSumaPrecioPlanesXAntiguedad:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getSumaPrecioPlanesXAntiguedad:end");
		return sumaPrecioPlanesDTO;
	}



	public CuentaComDTO getcliente(CuentaComDTO cuenta) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		try{
			logger.debug("getclientes:start");
			cuenta = BOCliente.getCliente(cuenta);	
			logger.debug("cuenta.getClienteComDTO().getCodigoPlanTarifario() ["+cuenta.getClienteComDTO().getPlanTarifario());
			logger.debug("getVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getclientes:end");
		return cuenta;
	}


	public ClienteDTO[] getListCategImpositivas() throws GeneralException{
		logger.debug("Inicio:getListCategImpositivas()");
		ClienteDTO[] clienteDTOs = null;
		try{
			logger.debug("getclientes:start");
			clienteDTOs = BOCliente.getListCategImpositivas();			
			logger.debug("getclientes:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getListCategImpositivas()");
		return clienteDTOs;
	}



	public DatosGeneralesDTO[] getListActividades() 
	throws GeneralException{
		logger.debug("Inicio:getListCategImpositivas()");
		DatosGeneralesDTO[] datosGeneralesDTOs = null;
		try{
			logger.debug("getListActividades:start");
			datosGeneralesDTOs = BODatosgenerales.getListActividades();			
			logger.debug("getListActividades:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getListActividades()");
		return datosGeneralesDTOs;
	}


	public OcupacionDTO[] getListaOcupaciones() 
	throws GeneralException{
		logger.debug("Inicio:getListaOcupaciones()");
		OcupacionDTO[] ocupacionDTOs = null;
		try{
			logger.debug("getListaOcupaciones:start");
			ocupacionDTOs = BODatosgenerales.getListaOcupaciones();			
			logger.debug("getListaOcupaciones:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getListaOcupaciones()");
		return ocupacionDTOs;
	}


	public SucursalBancoDTO[] getSucursalesBanco(SucursalBancoDTO sucursalBancoDTO) 
	throws GeneralException{
		logger.debug("Inicio:getSucursalesBanco()");
		SucursalBancoDTO[] sucursalBancoDTOs = null;
		try{
			logger.debug("getSucursalesBanco:start");
			sucursalBancoDTOs = BOCliente.getSucursalesBanco(sucursalBancoDTO);			
			logger.debug("getSucursalesBanco:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getSucursalesBanco()");
		return sucursalBancoDTOs;
	}

	public ClasificacionCuentaDTO[] getClasificacionCuenta() 
	throws GeneralException{
		logger.debug("Inicio:getClasificacionCuenta()");
		ClasificacionCuentaDTO[] clasificacionCuentaDTOs = null;
		try{
			logger.debug("getClasificacionCuenta:start");
			clasificacionCuentaDTOs = BOCliente.getClasificacionCuenta();	
			logger.debug("codigo clase cuenta"+ clasificacionCuentaDTOs[1].getCodClasCuenta());
			logger.debug("descripcion clase cuenta"+ clasificacionCuentaDTOs[1].getDesClasCuenta());		

			logger.debug("getClasificacionCuenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getClasificacionCuenta()");
		return clasificacionCuentaDTOs;
	}

	public HomeLineaDTO[] getHomeLinea(DireccionCentralDTO direccionCentralDTO)
	throws GeneralException{
		logger.debug("Inicio:getHomeLinea()");
		HomeLineaDTO[] homeLineaDTOs = null;
		try{
			logger.debug("getHomeLinea:start");
			homeLineaDTOs = BOCentral.getHomeLinea(direccionCentralDTO);			
			logger.debug("getHomeLinea:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getHomeLinea()");
		return homeLineaDTOs;
	}

	public EstadoCivilDTO[] getListaEstadoCivil() throws GeneralException{
		logger.debug("Inicio:getListaEstadoCivil()");
		EstadoCivilDTO[] estadoCivilDTOs = null;
		try{
			logger.debug("getListaEstadoCivil:start");
			estadoCivilDTOs = BODatosgenerales.getListaEstadoCivil();			
			logger.debug("getListaEstadoCivil:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getListaEstadoCivil()");
		return estadoCivilDTOs;
	}

	public EstadoDTO[] getListaEstados() throws GeneralException{
		logger.debug("Inicio:getListaEstados()");
		EstadoDTO[] estadoDTOs = null;
		try{
			logger.debug("getListaEstados:start");
			estadoDTOs = BODatosgenerales.getListaEstados();	

			logger.debug("variable retorno estado: "+ estadoDTOs[1].getCodigoEstado());
			logger.debug("variable retorno descripcion estado: "+ estadoDTOs[1].getDescripcionEstado());

			logger.debug("getListaEstado:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getListaEstadoCivil()");
		return estadoDTOs;
	}

	public WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		WsListConsultaPlanTarifarioOutDTO retValue =null;

		try{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			retValue = BOPlanTarifario.getConsultaPlanesTarifarios(consultaPlanTarifarioIn);
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Fin:getListadoPlanesTarifarios()");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	public CentralDTO getCentralTecnologia(CentralDTO central) 
	throws GeneralException{	
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));

		try{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			central = BOCentral.getCentralTecnologia(central);
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Fin:getCentralTecnologia()");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return central;
	}	


	public CuentaComDTO validacionLineaGrupoCDMA(CuentaComDTO cuentaComDTO) throws GeneralException{

		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		logger.debug("inicio():validacionLinea()");

		int numeroDeLineas = 0;
		int numeroDeOrden = 0;

		try {
			RegistroVentaDTO parametroEntrada = new RegistroVentaDTO();


			ParametrosValidacionDTO parametrosValidacion = new ParametrosValidacionDTO();

			parametrosValidacion.setCodigoCliente(cuentaComDTO.getClienteComDTO().getCodigoCliente());


			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigoproducto(config.getString("codigo.producto"));
			parametrosGeneralesDTO.setCodigomodulo(config.getString("codigo.modulo.AL"));


//			Busca largo serie simcard
			parametrosValidacion.setLargoSerieSimcard(Integer.parseInt(config.getString("parametro.largoSerieSimcard")));			    
			//Fin busca largo serie simcard

			//Busca largo serie terminal		
			parametrosValidacion.setLargoSerieTerminal(11);
			//Busca largo serie terminal 

			//Busca estado nuevo Simcard
			parametrosValidacion.setEstadoNuevoSimcard(config.getString("parametro.estadoNuevo"));
			//Fin busqueda estado nuevo simcard

			//Busca uso venta postpago
			parametrosValidacion.setUsoVentaPostpago(config.getString("parametro.usoVentaPostpago"));
			//Fin busqueda uso venta postpago

			//Busca uso venta hibrido
			parametrosValidacion.setUsoVentaHibrido(config.getString("parametro.usoVentaHibrido"));
			//Fin busqueda uso venta hibrido


			parametrosValidacion.setCodigoVendedor(cuentaComDTO.getClienteComDTO().getLineaCDMA()[0].getCodigoVendedor());
			parametrosValidacion.setCodigoDealer(String.valueOf(cuentaComDTO.getClienteComDTO().getLineaCDMA()[0].getCodigoVendedorDealer()));
			parametrosValidacion.setCodigoCliente(cuentaComDTO.getClienteComDTO().getCodigoCliente());
			parametrosValidacion.setTipoIdentificador(cuentaComDTO.getClienteComDTO().getCodigoTipoIdentificacion());
			parametrosValidacion.setNumeroIdentificador(cuentaComDTO.getClienteComDTO().getNumeroIdentificacion());				
			parametrosValidacion.setTipoCliente(cuentaComDTO.getClienteComDTO().getTipoCliente());				



			for (int canRegistros=0; canRegistros<cuentaComDTO.getClienteComDTO().getLineaCDMA().length;canRegistros++){
				double dtotalImporteCargoBasico = 0;

				parametroEntrada.setCodigoSecuencia(config.getString("secuencia.transacabo"));
				parametroEntrada = BORegistroVenta.getSecuenciaTransacabo(parametroEntrada);
				cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].setNumeroTransaccionVenta(String.valueOf(parametroEntrada.getNumeroTransaccionVenta()));

				ResultadoValidacionDTO resultadoValidacionDTO = new ResultadoValidacionDTO();
				ResultadoValidacionLogisticaDTO resultadoValidacionLogistica = null;
				ResultadoValidacionVentaDTO resultadoValidacionVentas = null;
				ResultadoValidacionTasacionDTO resultadoValidacionTasacion = null;
				if (cuentaComDTO.getClienteComDTO().getCodigoCategoriaEmpresa().equals(config.getString("identificador.empresa"))&& canRegistros == 0){																							
					parametrosValidacion.setCodigoPlanTarifario(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getCodigoPlanTarifario());
				}
				else if (cuentaComDTO.getClienteComDTO().getCodigoCategoriaEmpresa().equals(config.getString("identificador.empresa")) 
						&& canRegistros > 0){
					parametrosValidacion.setCodigoPlanTarifario(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getCodigoPlanTarifario());	
				}
				else
					parametrosValidacion.setCodigoPlanTarifario(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getCodigoPlanTarifario());


				parametrosValidacion.setNumeroSerieTerminal(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getNumeroSerieTerminal());
				parametrosValidacion.setNumeroCelular(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getNumeroCelular());


				parametrosValidacion.setNombreUsuario(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getUsuarioLinea().getNombre() );
				parametrosValidacion.setApellidoUsuario(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getUsuarioLinea().getPrimerApellido());
				parametrosValidacion.setTotalRegistros(cuentaComDTO.getClienteComDTO().getLineaCDMA().length);
				logger.debug("usuario conectado en validacion archivo : " + cuentaComDTO.getClienteComDTO().getNombreUsuarOra() );
				parametrosValidacion.setUsuarioConectado(cuentaComDTO.getClienteComDTO().getNombreUsuarOra());
				logger.debug("ValidacionArchivoCMD numeroDeLineas : " + numeroDeLineas);
				if( numeroDeLineas == 0 ) {
					//Consulto vigencia plan uso de la primera linea dada la simcard y el plan tarifario 
					PlanUsoDTO planUso = new PlanUsoDTO();
					planUso.setCodPlanTarif(parametrosValidacion.getCodigoPlanTarifario());
					planUso.setNumSerie(parametrosValidacion.getNumeroSerie());
					String vigencia = BOPlanTarifario.obtieneVigenciaPlanUsoSimcard(planUso);
					logger.debug("ValidacionArchivoCMD vigencia plan uso : " + vigencia);							
					parametrosValidacion.setEsPlanNoFijoPrimeraLinea(vigencia.trim());
				}

				//FIN parametros nuevos


				parametrosValidacion.setCodigoModalidadVenta(cuentaComDTO.getClienteComDTO().getLineaCDMA()[0].getCodigoModalidadVenta());
				//--- Validar linea ---

				// VALIDACION TASACION
				ParametrosValidacionTasacionDTO parametrosValidacionTasacion = new ParametrosValidacionTasacionDTO(parametrosValidacion); 					
				parametrosValidacionTasacion.setTotalImporteCargoBasico(dtotalImporteCargoBasico);

				parametrosValidacionTasacion.setCodigoTecnologia(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getCodigoTecnologia());

				resultadoValidacionTasacion = tasacionValidacionLinea(parametrosValidacionTasacion);				
				resultadoValidacionDTO.setEstado(resultadoValidacionTasacion.getEstado());
				resultadoValidacionDTO.setDetalleEstado(resultadoValidacionTasacion.getDetalleEstado());
				ParametrosValidacionLogisticaDTO parametrosValidacionLogistica =new ParametrosValidacionLogisticaDTO(parametrosValidacion);
				if (resultadoValidacionDTO.getEstado().equals("OK")){
					// VALIDACIONES LOGISTICA
					dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico();
					//VALIDACIONES Simcar

					parametrosValidacionLogistica.setCodigoTecnologia(cuentaComDTO.getClienteComDTO().getLineaCDMA()[0].getCodigoTecnologia());
					resultadoValidacionLogistica = validacionesSerieTerminalCDMA(parametrosValidacionLogistica);
					resultadoValidacionLogistica.setEstado("OK");



					resultadoValidacionDTO.setEstado(resultadoValidacionLogistica.getEstado());
					resultadoValidacionDTO.setDetalleEstado(resultadoValidacionLogistica.getDetalleEstado());
					if (resultadoValidacionDTO.getEstado().equals("OK")){
						//VALIDACIONES VENTAS
						ParametrosValidacionVentasDTO parametrosValidacionVentas = new ParametrosValidacionVentasDTO(parametrosValidacion);
						parametrosValidacionVentas.setCodigoCentral(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getCodigoCentral());
						parametrosValidacionVentas.setCodigoCelda(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getCodigoCelda());
						parametrosValidacionVentas.setNumeroTransaccionVenta(String.valueOf(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getNumeroTransaccionVenta()));
						parametrosValidacionVentas.setNumeroLinea(numeroDeLineas);
						parametrosValidacionVentas.setNumeroOrden(numeroDeOrden);
						parametrosValidacionVentas.setCodigoTipoContrato(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getCodigoTipoContrato());
						UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
						parametrosValidacionVentas.setCodigoTecnologia(cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getCodigoTecnologia());
						/*CSR-11002
						resultadoValidacionVentas = ventasValidacionLineaCDMA(parametrosValidacionVentas, cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getIndicadorPortado());*/
						resultadoValidacionVentas = ventasValidacionLineaCDMA(parametrosValidacionVentas);

						resultadoValidacionDTO.setEstado(resultadoValidacionVentas.getEstado());
						resultadoValidacionDTO.setDetalleEstado(resultadoValidacionVentas.getDetalleEstado());
						resultadoValidacionDTO.setBDireccionLinea(resultadoValidacionVentas.isBDireccionLinea());						
					}
					else{
						dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico() - 
						resultadoValidacionTasacion.getImporteCargoBasico();
					}
					if (resultadoValidacionDTO.getEstado().equals("OK")){
						logger.debug("Numero de celular SRV ["+resultadoValidacionVentas.getNumeroCelular()+"]");
						numeroDeOrden++;


						logger.debug("cuentaComDTO.getClienteComDTO().getLinea()[canRegistros].getNumeroCelular().length() ["+cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getNumeroCelular().length()+"]");

						if (cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].getNumeroCelular().length() < 5){
							cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].setNumeroCelular(resultadoValidacionVentas.getNumeroCelular());
							cuentaComDTO.getClienteComDTO().getLineaCDMA()[canRegistros].setCodigoCentral(resultadoValidacionVentas.getCodigoCentral());
						}
					}
					else{
						dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico() - 
						resultadoValidacionTasacion.getImporteCargoBasico();
					}

				}
			}
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:validacionLinea()");
		return cuentaComDTO;
	}		


	public CuentaComDTO validacionLineaGrupoGSM(CuentaComDTO cuentaComDTO) throws GeneralException{

		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		logger.debug("inicio():validacionLinea()");

		int numeroDeLineas = 0;
		int numeroDeOrden = 0;

		try {
			RegistroVentaDTO parametroEntrada = new RegistroVentaDTO();


			ParametrosValidacionDTO parametrosValidacion = new ParametrosValidacionDTO();

			parametrosValidacion.setCodigoCliente(cuentaComDTO.getClienteComDTO().getCodigoCliente());


			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigoproducto(config.getString("codigo.producto"));
			parametrosGeneralesDTO.setCodigomodulo(config.getString("codigo.modulo.AL"));


//			Busca largo serie simcard
			parametrosValidacion.setLargoSerieSimcard(Integer.parseInt(config.getString("parametro.largoSerieSimcard")));			    
			//Fin busca largo serie simcard

			//Busca largo serie terminal		
			parametrosValidacion.setLargoSerieTerminal(Integer.parseInt(config.getString("parametro.largoSerieTerminal")));
			//Busca largo serie terminal 

			//Busca estado nuevo Simcard
			parametrosValidacion.setEstadoNuevoSimcard(config.getString("parametro.estadoNuevo"));
			//Fin busqueda estado nuevo simcard

			//Busca uso venta postpago
			parametrosValidacion.setUsoVentaPostpago(config.getString("parametro.usoVentaPostpago"));
			//Fin busqueda uso venta postpago

			//Busca uso venta hibrido
			parametrosValidacion.setUsoVentaHibrido(config.getString("parametro.usoVentaHibrido"));
			//Fin busqueda uso venta hibrido


			parametrosValidacion.setCodigoVendedor(cuentaComDTO.getClienteComDTO().getLineaGSM()[0].getCodigoVendedor());
			parametrosValidacion.setCodigoDealer(String.valueOf(cuentaComDTO.getClienteComDTO().getLineaGSM()[0].getCodigoVendedorDealer()));
			parametrosValidacion.setCodigoCliente(cuentaComDTO.getClienteComDTO().getCodigoCliente());
			parametrosValidacion.setTipoIdentificador(cuentaComDTO.getClienteComDTO().getCodigoTipoIdentificacion());
			parametrosValidacion.setNumeroIdentificador(cuentaComDTO.getClienteComDTO().getNumeroIdentificacion());				
			parametrosValidacion.setTipoCliente(cuentaComDTO.getClienteComDTO().getTipoCliente());				



			for (int canRegistros=0; canRegistros<cuentaComDTO.getClienteComDTO().getLineaGSM().length;canRegistros++){
				double dtotalImporteCargoBasico = 0;

				parametroEntrada.setCodigoSecuencia(config.getString("secuencia.transacabo"));
				parametroEntrada = BORegistroVenta.getSecuenciaTransacabo(parametroEntrada);
				cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].setNumeroTransaccionVenta(String.valueOf(parametroEntrada.getNumeroTransaccionVenta()));

				ResultadoValidacionDTO resultadoValidacionDTO = new ResultadoValidacionDTO();
				ResultadoValidacionLogisticaDTO resultadoValidacionLogistica = null;
				ResultadoValidacionVentaDTO resultadoValidacionVentas = null;
				ResultadoValidacionTasacionDTO resultadoValidacionTasacion = null;
				if (cuentaComDTO.getClienteComDTO().getCodigoCategoriaEmpresa().equals(config.getString("identificador.empresa"))&& canRegistros == 0){																							
					parametrosValidacion.setCodigoPlanTarifario(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getCodigoPlanTarifario());
				}
				else if (cuentaComDTO.getClienteComDTO().getCodigoCategoriaEmpresa().equals(config.getString("identificador.empresa")) 
						&& canRegistros > 0){
					parametrosValidacion.setCodigoPlanTarifario(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getCodigoPlanTarifario());	
				}
				else
					parametrosValidacion.setCodigoPlanTarifario(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getCodigoPlanTarifario());

				//Datos Archivo
				parametrosValidacion.setNumeroSerie(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getNumeroSerieSimcard());
				parametrosValidacion.setNumeroSerieTerminal(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getNumeroSerieTerminal());
				parametrosValidacion.setNumeroSerieKit(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getNumeroSerieKit());
				parametrosValidacion.setNumeroCelular(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getNumeroCelular());

				//Nuevos parametros P-ECU-08019
				parametrosValidacion.setNombreUsuario(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getUsuarioLinea().getNombre());
				parametrosValidacion.setApellidoUsuario(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getUsuarioLinea().getPrimerApellido());
				parametrosValidacion.setTotalRegistros(cuentaComDTO.getClienteComDTO().getLineaGSM().length);
				logger.debug("usuario conectado en validacion archivo : " + cuentaComDTO.getClienteComDTO().getNombreUsuarOra() );
				parametrosValidacion.setUsuarioConectado(cuentaComDTO.getClienteComDTO().getNombreUsuarOra());
				logger.debug("ValidacionArchivoCMD numeroDeLineas : " + numeroDeLineas);
				if( numeroDeLineas == 0 ) {
					//Consulto vigencia plan uso de la primera linea dada la simcard y el plan tarifario 
					PlanUsoDTO planUso = new PlanUsoDTO();
					planUso.setCodPlanTarif(parametrosValidacion.getCodigoPlanTarifario());
					planUso.setNumSerie(parametrosValidacion.getNumeroSerie());
					String vigencia = BOPlanTarifario.obtieneVigenciaPlanUsoSimcard(planUso);
					logger.debug("ValidacionArchivoCMD vigencia plan uso : " + vigencia);							
					parametrosValidacion.setEsPlanNoFijoPrimeraLinea(vigencia.trim());
				}

				//FIN parametros nuevos


				parametrosValidacion.setCodigoModalidadVenta(cuentaComDTO.getClienteComDTO().getLineaGSM()[0].getCodigoModalidadVenta());
				//--- Validar linea ---

				// VALIDACION TASACION
				ParametrosValidacionTasacionDTO parametrosValidacionTasacion = new ParametrosValidacionTasacionDTO(parametrosValidacion); 					
				parametrosValidacionTasacion.setTotalImporteCargoBasico(dtotalImporteCargoBasico);
				parametrosValidacionTasacion.setCodigoTecnologia(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getCodigoTecnologia());
				resultadoValidacionTasacion = tasacionValidacionLinea(parametrosValidacionTasacion);
				resultadoValidacionDTO.setEstado(resultadoValidacionTasacion.getEstado());
				resultadoValidacionDTO.setDetalleEstado(resultadoValidacionTasacion.getDetalleEstado());
				ParametrosValidacionLogisticaDTO parametrosValidacionLogistica =new ParametrosValidacionLogisticaDTO(parametrosValidacion);
				if (resultadoValidacionDTO.getEstado().equals("OK")){
					// VALIDACIONES LOGISTICA
					dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico();
					//VALIDACIONES Simcard
					parametrosValidacionLogistica.setCodigoTecnologia(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getCodigoTecnologia());
					resultadoValidacionLogistica = validacionesSerieSimcard(parametrosValidacionLogistica);
					resultadoValidacionDTO.setEstado(resultadoValidacionLogistica.getEstado());
					resultadoValidacionDTO.setDetalleEstado(resultadoValidacionLogistica.getDetalleEstado());
					if (resultadoValidacionDTO.getEstado().equals("OK")){
						//VALIDACIONES Terminal  se comenta validacion de terminal por serie dummy
						resultadoValidacionLogistica = validacionesSerieTerminal(parametrosValidacionLogistica);
						resultadoValidacionLogistica.setEstado("OK");

					}
					else{
						dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico() - 
						resultadoValidacionTasacion.getImporteCargoBasico();
					}
					resultadoValidacionDTO.setEstado(resultadoValidacionLogistica.getEstado());
					resultadoValidacionDTO.setDetalleEstado(resultadoValidacionLogistica.getDetalleEstado());
					if (resultadoValidacionDTO.getEstado().equals("OK")){
						//VALIDACIONES VENTAS
						ParametrosValidacionVentasDTO parametrosValidacionVentas = new ParametrosValidacionVentasDTO(parametrosValidacion);
						parametrosValidacionVentas.setCodigoCentral(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getCodigoCentral());
						parametrosValidacionVentas.setCodigoCelda(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getCodigoCelda());
						parametrosValidacionVentas.setNumeroTransaccionVenta(String.valueOf(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getNumeroTransaccionVenta()));
						parametrosValidacionVentas.setNumeroLinea(numeroDeLineas);
						parametrosValidacionVentas.setNumeroOrden(numeroDeOrden);
						parametrosValidacionVentas.setCodigoTipoContrato(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getCodigoTipoContrato());
						UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
						parametrosValidacionVentas.setCodigoTecnologia(cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getCodigoTecnologia());
						resultadoValidacionVentas = ventasValidacionLinea(parametrosValidacionVentas);
						resultadoValidacionDTO.setEstado(resultadoValidacionVentas.getEstado());
						resultadoValidacionDTO.setDetalleEstado(resultadoValidacionVentas.getDetalleEstado());
						resultadoValidacionDTO.setBDireccionLinea(resultadoValidacionVentas.isBDireccionLinea());						
					}
					else{
						dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico() - 
						resultadoValidacionTasacion.getImporteCargoBasico();
					}
					if (resultadoValidacionDTO.getEstado().equals("OK")){
						logger.debug("Numero de celular SRV ["+resultadoValidacionVentas.getNumeroCelular()+"]");
						numeroDeOrden++;


						logger.debug("cuentaComDTO.getClienteComDTO().getLinea()[canRegistros].getNumeroCelular().length() ["+cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getNumeroCelular().length()+"]");

						if (cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].getNumeroCelular().length() < 5){
							cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].setNumeroCelular(resultadoValidacionVentas.getNumeroCelular());
							cuentaComDTO.getClienteComDTO().getLineaGSM()[canRegistros].setCodigoCentral(resultadoValidacionVentas.getCodigoCentral());
						}
					}
					else{
						dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico() - 
						resultadoValidacionTasacion.getImporteCargoBasico();
					}

				}
			}
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:validacionLinea()");
		return cuentaComDTO;
	}		


	/* CSR-11002
	 * public ResultadoValidacionVentaDTO ventasValidacionLineaCDMA(ParametrosValidacionVentasDTO entrada,String IndPortado)*/
	public ResultadoValidacionVentaDTO ventasValidacionLineaCDMA(ParametrosValidacionVentasDTO entrada)
	throws GeneralException{
		ResultadoValidacionVentaDTO resultadoValidacion = null;
		logger.debug("Inicio:validacionLinea() : " + entrada.getNumeroSerie());
		logger.debug("numero de linea : " + entrada.getNumeroLinea());



		String usoLinea = null;
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(entrada.getCodigoPlanTarifario());
		planTarifario.setCodigoProducto(config.getString("codigo.producto"));
		planTarifario.setCodigoTecnologia(entrada.getCodigoTecnologia());
		planTarifario = BOPlanTarifario.getPlanTarifario(planTarifario);

		if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.postpago"))){
			usoLinea =  config.getString("codigo.uso.postpago");
		}else if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.hibrido"))){
			usoLinea =  config.getString("codigo.uso.hibrido");
		}else if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.prepago"))){
			usoLinea =  config.getString("codigo.uso.prepago");
		}else{
			logger.debug("Error en el uso de la linea");
			throw new GeneralException("12361",0,"Error en el uso de la linea");
		}


		//-- OBTIENE PARAMETRO : PRECIO LISTA
		String sPrecioLista = config.getString("parametro.preciolista");

		//Valida que el articulo asociado a la simcard tenga configurado precio

		PrecioCargoDTO[] precioCargoDTOs = null;


		// Verifica si el vendedor tiene acceso a la bodega del teminal
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		TerminalSNPNDTO terminal = new TerminalSNPNDTO();
		terminal.setNumeroSerie(entrada.getNumeroSerieTerminal());
		terminal = BOTerminal.getTerminal(terminal);
		entrada.setCodigoBodega(terminal.getCodigoBodega());
		resultadoValidacion = BOVendedor.vendedorExisteEnBodegaTerminal(entrada);
		if (!resultadoValidacion.isResultado() && terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setDetalleEstado("Vendedor no tiene acceso a la bodega del terminal");
			logger.debug("Vendedor no tiene acceso a la bodega del terminal");
			throw new GeneralException("12364",0,"Vendedor no tiene acceso a la bodega del terminal");
		}
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));


		//Verifica que el Articulo asociado al terminal tenga precio.
		if (terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna")) && terminal.getIndicadorValorar().equals(config.getString("indicador.valoracion"))){
			ParametrosCargoTerminalDTO parametrosCargoTerminalDTO = new ParametrosCargoTerminalDTO();
			parametrosCargoTerminalDTO.setCodigoArticulo(terminal.getCodigoArticulo());
			parametrosCargoTerminalDTO.setCodigoUso(usoLinea);
			parametrosCargoTerminalDTO.setTipoStock(terminal.getTipoStock());
			parametrosCargoTerminalDTO.setEstado(terminal.getEstado());
			parametrosCargoTerminalDTO.setModalidadVenta(entrada.getCodigoModalidadVenta());
			parametrosCargoTerminalDTO.setTipoContrato(entrada.getCodigoTipoContrato());
			parametrosCargoTerminalDTO.setPlanTarifario(entrada.getCodigoPlanTarifario());
			parametrosCargoTerminalDTO.setCodigoUsoPrepago(config.getString("codigo.uso.prepago"));
			parametrosCargoTerminalDTO.setCodigoCategoria(terminal.getCodigoCategoria());
			parametrosCargoTerminalDTO.setIndicadorEquipo(config.getString("indicador.equiacc"));
			try{
				precioCargoDTOs = null;

				if (sPrecioLista.equals(config.getString("indicador.precio.lista"))){
					parametrosCargoTerminalDTO.setCodigoCategoria(config.getString("codigo.categoria"));
					parametrosCargoTerminalDTO.setIndiceRecambio(config.getString("indice.recambio.preciolista"));
					precioCargoDTOs = BOTerminal.getPrecioCargoTerminal_PrecioLista(parametrosCargoTerminalDTO);		
				}
				else{

					if (planTarifario.getCodigoTipoPlan().equals("1")){
						parametrosCargoTerminalDTO.setCodigoCategoria(config.getString("codigo.categoria"));
						parametrosCargoTerminalDTO.setIndiceRecambio(config.getString("indice.recambio.preciolista"));
						precioCargoDTOs = BOTerminal.getPrecioCargoTerminal_PrecioLista(parametrosCargoTerminalDTO);						
					}else{
						parametrosCargoTerminalDTO.setIndiceRecambio(config.getString("indice.recambio.nolista"));
						precioCargoDTOs = BOTerminal.getPrecioCargoTerminal_NoPrecioLista(parametrosCargoTerminalDTO);	
					}
				}

			}catch(GeneralException e){
				logger.debug("Exception: No se encontro precio asociado al terminal");
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado al Terminal");
				logger.debug("No se encuentra precio para el Articulo asociado al Terminal");
				throw new GeneralException("12366",0,"No se encuentra precio para el Articulo asociado al Terminal");
			}

		}	

		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));

		//( 55* ) Verifica si serie terminal existe en abonado					
		resultadoValidacion = BOTerminal.validaRepeticionTerminal(terminal);
		resultadoValidacion = new ResultadoValidacionVentaDTO();
		resultadoValidacion.setResultado(true);		
		if (!resultadoValidacion.isResultado()){			
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setDetalleEstado("Serie terminal no puede ser nuevamente vendida");
			logger.debug("Serie terminal no puede ser nuevamente vendida");
			throw new GeneralException("12367",0,"Serie terminal no puede ser nuevamente vendida");
		}


		// ( 58 ) Verifica si serie terminal esta en lista negras		
		terminal.setNumeroSerie(entrada.getNumeroSerieTerminal());
		resultadoValidacion = BOAbonado.validaSerieTermialEnListaNegra(terminal);
		resultadoValidacion = new ResultadoValidacionVentaDTO();
		resultadoValidacion.setResultado(false);		
		if (resultadoValidacion.isResultado()){
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setDetalleEstado("Serie terminal se encuentra en listas negras");
			logger.debug("Serie terminal se encuentra en listas negras");
			throw new GeneralException("12368",0,"Serie terminal se encuentra en listas negras");
		}

		// Varifica si la modalidad de venta es credito, el terminal no sea externo
		if (!terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){

			ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
			parametrosGral.setNombreparametro(config.getString("parametro.modalidad.venta.credito"));
			parametrosGral.setCodigoproducto(config.getString("codigo.producto"));
			parametrosGral.setCodigomodulo(config.getString("codigo.modulo.GA"));
			parametrosGral = BOParametrosGenerales.getParametroGeneral(parametrosGral);

			if (parametrosGral.getValorparametro().equals(entrada.getCodigoModalidadVenta())){
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("Para venta a credito terminal no puede ser externo");				
				logger.debug("Para venta a credito terminal no puede ser externo");
				throw new GeneralException("12369",0,"Para venta a credito terminal no puede ser externo");
			}

			terminal.setIndicadorProgramado("0");
			terminal.setNumeroCelular("0");
			terminal.setCodigoUso(usoLinea);			
		}

		// Obtiene SubAlm celda seleccionada en Parametros Comerciales
		CelularDTO celular = new CelularDTO();
		CeldaDTO celda = new CeldaDTO();

		celda.setCodigoCelda(entrada.getCodigoCelda());
		celda.setCodigoProducto(config.getString("codigo.producto"));
		celda = obtieneDatosCelda(celda);
		//setear datos para la busqueda del numero de celular automatica

		celular.setCodSubAlm(celda.getCodSubAlm());
		celular.setCentral(entrada.getCodigoCentral());
		celular.setCodigoUso(usoLinea);
		celular.setNomUsuarioOra(entrada.getUsuarioConectado());

		//-- BUSCAR CODIGO ACTUACION
		if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.hibrido"))){
			celular.setCodActabo(config.getString("codigo.actuacion.hibrido"));
		}else if(planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.postpago"))){ 
			celular.setCodActabo(config.getString("codigo.actuacion.venta"));
		}else if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.prepago"))){
			celular.setCodActabo(config.getString("codigo.actuacion.prepago"));
		}



		ClienteDTO cliente = new ClienteDTO();
		cliente.setCodigoCliente(entrada.getCodigoCliente());
		cliente = BOCliente.getCliente(cliente);
		cliente.setTipoCliente(entrada.getTipoCliente());

		//Si el cliente no tiene excepciones valida cantidad de terminales vendidos.
		//Si es un cliente de tipo empresa tb valida los numeros de abonados permitidos en el plan tarifario.

		VendedorDTO vendedorDTO = new VendedorDTO();
		vendedorDTO.setCodigoVendedor(entrada.getCodigoVendedor());
		//Obtiene numero celular
		if (entrada.getNumeroCelular().equals(config.getString("no.existe")) || entrada.getNumeroCelular().equals("0"))
		{// no viene numero celular en el archivo
			if(!terminal.getIndicadorProgramado().equals(config.getString("indicativo.telefono.no.programado")) && terminal.getNumeroCelular()!=null && !terminal.getNumeroCelular().equals("0")){
				// simcard programada
				resultadoValidacion.setBDireccionLinea(false);
				celular.setNumeroCelular(Long.parseLong(terminal.getNumeroCelular()));
				vendedorDTO.setNumeroCelular(terminal.getNumeroCelular());
				/* Comentado por solicitud de MArcelo Miranda no es necesario la validacion del Home del Vendedor
				vendedorDTO = BOVendedor.validaHomeVendCel(vendedorDTO);
				if (!vendedorDTO.isIndicadorHomeVendCelular()){
					resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setDetalleEstado("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
					logger.debug("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
					throw new GeneralException("12370",0,"Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
				}*/
			}
			else
			{// simcard no programada
				//-- NUMERACION AUTOMATICA
				celular = getNumeroCelularAut(celular);
				logger.debug("celular" +celular.getNumeroCelular()+"]");
				celular.setNumeroTransaccion(Long.parseLong(entrada.getNumeroTransaccionVenta()));
				celular.setNumeroLinea(String.valueOf(entrada.getNumeroLinea()+1)); 
				celular.setNumeroOrden(String.valueOf(entrada.getNumeroOrden()+1));
				//-- RESERVA DE NUMERO


				celular = setReservaNumeroCelular(celular);
				logger.debug("NUMERACION AUTOMATICA celular ["+celular.getNumeroCelular()+"]");
				resultadoValidacion.setBDireccionLinea(true);
			}
		}
		else
		{// viene numero celular en el archivo
			//Si es distinto de estado 8 simcard es programada
			resultadoValidacion.setBDireccionLinea(false);
			if (!terminal.getIndicadorProgramado().equals(config.getString("indicativo.telefono.no.programado")))
				// simcard programada
				if (!terminal.getNumeroCelular().equals("0")){
					celular.setNumeroCelular(Long.parseLong(terminal.getNumeroCelular()));
					vendedorDTO.setNumeroCelular(terminal.getNumeroCelular());
					/* Comentado por solicitud de MArcelo Miranda no es necesario la validacion del Home del Vendedor
					vendedorDTO = BOVendedor.validaHomeVendCel(vendedorDTO);
					if (!vendedorDTO.isIndicadorHomeVendCelular()){
						resultadoValidacion.setEstado("NOK");
						resultadoValidacion.setDetalleEstado("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
						logger.debug("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
						throw new GeneralException("12371",0,"Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
					}*/
				}
			logger.debug("ANTES RESERVA DE NUMERO celular ["+celular.getNumeroCelular()+"]");
			if (celular.getNumeroCelular() != 0){
				logger.debug("EN RESERVA DE NUMERO celular ["+celular.getNumeroCelular()+"]");
				//-- RESERVA DE NUMERO
				celular.setTipoCelular(config.getString("tipo.num.celular"));
				celular.setNumeroTransaccion(Long.parseLong(entrada.getNumeroTransaccionVenta()));
				celular.setNumeroLinea(String.valueOf(entrada.getNumeroLinea()+1)); 
				celular.setNumeroOrden(String.valueOf(entrada.getNumeroOrden()+1)); 
				celular.setCategoria(terminal.getCodigoCategoria());
				celular = setReservaNumeroCelular(celular);
			}
			else 
				// simcard no programada
			{
				logger.debug("EN RESERVA DE NUMERO celular ["+celular.getNumeroCelular()+"]");
				ResultadoValidacionLogisticaDTO resultado =null;
				ParametrosValidacionLogisticaDTO parametrosEntrada = new ParametrosValidacionLogisticaDTO();
				parametrosEntrada.setNumeroCelular(entrada.getNumeroCelular());
				parametrosEntrada.setCodigoCliente(entrada.getCodigoCliente());
				parametrosEntrada.setCodigoVendedor(entrada.getCodigoVendedor());
				logger.debug("entrada.getNumeroCelular() ["+entrada.getNumeroCelular()+"]");
				resultado=BOSimcard.numeroReservadoOK(parametrosEntrada);
				resultadoValidacion.setBDireccionLinea(false);
				if(!resultado.isResultado())
				{

					celular.setNumeroTransaccion(Long.parseLong(entrada.getNumeroTransaccionVenta()));
					celular.setNumeroLinea(String.valueOf(entrada.getNumeroLinea()+1)); 
					celular.setNumeroOrden(String.valueOf(entrada.getNumeroOrden()+1)); 
					celular.setCategoria(terminal.getCodigoCategoria());
					//celular = setReservaNumeroCelular(celular);
					/*Solicitud de Marcelo Miranda no debe generar error si no reservar el celular para le vendedor.*/
					/*resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setDetalleEstado("Numero de celular no esta reservado para el vendedor y/o cliente");
					logger.debug("Numero de celular no esta reservado para el vendedor y/o cliente");
					throw new GeneralException("12372",0,"Numero de celular no esta reservado para el vendedor y/o cliente");*/


				}
				celular.setNumeroCelular(Long.parseLong(entrada.getNumeroCelular()));
				vendedorDTO.setNumeroCelular(entrada.getNumeroCelular());
				/* Comentado por solicitud de MArcelo Miranda no es necesario la validacion del Home del Vendedor
				vendedorDTO = BOVendedor.validaHomeVendCel(vendedorDTO);
				if (!vendedorDTO.isIndicadorHomeVendCelular()){
					resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setDetalleEstado("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
					logger.debug("Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
					throw new GeneralException("12373",0,"Numero de Celular asociado a la simcard no corresponde al Home de la oficina del vendedor");
				}*/
				if (celular.getNumeroCelular() != 0){
					//-- RESERVA DE NUMERO
					celular.setCategoria(terminal.getCodigoCategoria());
					celular.setTipoCelular(config.getString("tipo.num.celular"));
					celular.setNumeroTransaccion(Long.parseLong(entrada.getNumeroTransaccionVenta()));
					celular.setNumeroLinea(String.valueOf(entrada.getNumeroLinea()+1)); 
					celular.setNumeroOrden(String.valueOf(entrada.getNumeroOrden()+1)); 					
					celular = BORegistroVenta.getInfoCelular(celular);
					celular = setReservaNumeroCelular(celular);
					/* CSR-11002
					if( IndPortado.equals("0")){*/
						BORegistroVenta.setNumeracionManual(celular);
					/* CSR-11002
					}*/


				}
			}

		}
		if (celular.getNumeroCelular() == 0){
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setDetalleEstado("No se pudo obtener número celular");
			logger.debug("No se pudo obtener número celular");
			throw new GeneralException("12374",0,"No se pudo obtener número celular");
		}

		//P-ECU-08019: Verifica si cliente se encuentra en las tablas de tipo contrato cliente
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));

		logger.debug("Antes de recueprar Contrao de cliente");

		TipoContratoClienteDTO tipoContratoCliente = obtieneTipContratoCliente(
				Long.valueOf(entrada.getCodigoCliente()));

		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Despues de recueprar Contrao de cliente ["+tipoContratoCliente.getCodCliente().longValue()+"]");
		if(tipoContratoCliente.getCodCliente().longValue() != 0)
		{
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("cliente SI se encuentra en las tablas de tipContrato");

			//Consulto vigencia plan uso
			PlanUsoDTO planUso = new PlanUsoDTO();
			planUso.setCodPlanTarif(entrada.getCodigoPlanTarifario());
			planUso.setCodUso(Long.valueOf(terminal.getCodigoUso()));
			String vigencia = obtieneVigenciaPlanUso(planUso);
			logger.debug("vigencia plan uso : " + vigencia);	



		} else {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("cliente NO se  encuentra en las tablas de tipContrato : " + entrada.getNumeroLinea());
			logger.debug("numero de linea : " + entrada.getNumeroLinea());
			logger.debug("numero de serie simcard: " + entrada.getNumeroSerie());
			logger.debug("total lineas: " + entrada.getTotalRegistros());

			if(entrada.getNumeroLinea() == 0)
			{
				logger.debug("cliente NO se  encuentra en las tablas de tipContrato, es primera linea");
				//Consulto vigencia plan uso
				PlanUsoDTO planUso = new PlanUsoDTO();
				planUso.setCodPlanTarif(entrada.getCodigoPlanTarifario());
				planUso.setCodUso(Long.valueOf(terminal.getCodigoUso()));
				String vigencia = obtieneVigenciaPlanUso(planUso);
				logger.debug("vigencia plan uso : " + vigencia);
				//Vigencia de plan uso con flag S
				if(vigencia.trim().equals("S"))
				{
					logger.debug("cliente NO se  encuentra en las tablas de tipContrato, plan uso es vigente");
					Long nroAbonados = obtieneAbonadosVigentes(Long.valueOf(entrada.getCodigoCliente()));
					logger.debug(" nroAbonados : " + nroAbonados.longValue() );
					logger.debug(" codTipoContrato : " + entrada.getCodigoTipoContrato() );
					if(nroAbonados.longValue() == 0 ) //Es abonado nuevo
					{
						if(!entrada.getCodigoTipoContrato().trim().
								equals(config.getString("codigo.tipo.contrato.0.meses")))
						{
							logger.debug("cliente NO se  encuentra en las tablas de tipContrato, abonado SI es nuevo");
							//inserto tipo contrato asociado al cliente
							TipoContratoClienteDTO tipoContratoCLiente = new TipoContratoClienteDTO();
							logger.debug("codigo cliente : " + entrada.getCodigoCliente());
							tipoContratoCLiente.setCodCliente(Long.valueOf(entrada.getCodigoCliente()));
							logger.debug("codigo plan tarifario : " + entrada.getCodigoPlanTarifario());
							tipoContratoCLiente.setCodPlanTarif(entrada.getCodigoPlanTarifario());
							logger.debug("codigo producto : " + entrada.getCodigoProducto());
							//tipoContratoCliente.setCodProducto(Long.valueOf(entrada.getCodigoProducto()));
							tipoContratoCLiente.setCodProducto( new Long(1) );
							tipoContratoCLiente.setCodTipContrato(entrada.getCodigoTipoContrato());
							tipoContratoCLiente.setCodUso(Long.valueOf(terminal.getCodigoUso()));
							logger.debug("usuario conectado : " + entrada.getNombreUsuario());
							tipoContratoCLiente.setNomUsuario(entrada.getUsuarioConectado());
							insertaTipContratoCliente(tipoContratoCLiente);
						}
					} else { //No es abonado nuevo
						logger.debug("cliente NO se encuentra en las tablas de tipContrato, abonado NO es nuevo");
						resultadoValidacion.setEstado("NOK");
						resultadoValidacion.setDetalleEstado("Debe crear un cliente nuevo para seleccionar este plan tarifario " + entrada.getCodigoPlanTarifario()+ " ");
						logger.debug("cliente NO se encuentra en las tablas de tipContrato, abonado NO es nuevo");
						throw new GeneralException("12377",0,"cliente NO se encuentra en las tablas de tipContrato, abonado NO es nuevo");
					}
				}
			} else {
				if( entrada.getEsPlanNoFijoPrimeraLinea().trim().equals("N")){
					//Consulto vigencia plan uso
					PlanUsoDTO planUso = new PlanUsoDTO();
					planUso.setCodPlanTarif(entrada.getCodigoPlanTarifario());
					planUso.setCodUso(Long.valueOf(terminal.getCodigoUso()));
					String vigencia = obtieneVigenciaPlanUso(planUso);
					logger.debug("contrato NO fijo vigencia plan uso : " + vigencia);		
					if(vigencia.trim().equals("S"))
					{
						resultadoValidacion.setEstado("NOK");
						resultadoValidacion.setDetalleEstado("Vigencia plan uso no corresponde");
						logger.debug("Vigencia plan uso no corresponde");
						throw new GeneralException("12378",0,"Vigencia plan uso no corresponde");
					}
				}
			}
		}
		//FIN P-ECU-08019


		if (celular.getNumeroCelular() != 0 ){
			resultadoValidacion.setNumeroCelular(String.valueOf(celular.getNumeroCelular()));		
			resultadoValidacion.setCodigoCentral(celular.getCentral());
		}




		resultadoValidacion.setEstado("OK");
		resultadoValidacion.setDetalleEstado("-");

		logger.debug("Fin:validacionLinea()");
		return resultadoValidacion;
	}//fin validacionLinea		

	public ResultadoValidacionLogisticaDTO validacionesSerieTerminalCDMA(ParametrosValidacionLogisticaDTO parametrosEntrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:validacionesSerieTerminal()");

		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();

		parametrosEntrada.setCodigoProducto(config.getString("codigo.producto"));
		parametrosEntrada.setCodigoModulo(config.getString("codigo.modulo.AL"));
		parametrosEntrada.setNombreParametro(config.getString("codigo.modulo.AL"));
		parametrosEntrada.setCodigoTecnologia(parametrosEntrada.getCodigoTecnologia());
		ResultadoValidacionVentaDTO resltadoV = new ResultadoValidacionVentaDTO();

		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Antes Largo Terminal");
		if(parametrosEntrada.getLargoSerieTerminal() == parametrosEntrada.getNumeroSerieTerminal().length())			
		{
			logger.debug("Largo Terminal Correcto");
			TerminalSNPNDTO terminal = new TerminalSNPNDTO();
			terminal.setNumeroSerie(parametrosEntrada.getNumeroSerieTerminal());


			logger.debug("Formato Terminal Correcto");
			terminal = BOTerminal.getTerminal(terminal);
			
			resltadoV = BOTerminal.validaRepeticionTerminal(terminal);
			if(!resltadoV.isResultado()){			
				logger.debug("12355 - Serie terminal no puede ser nuevamente vendida");							
				resultado.setEstado("NOK");
				resultado.setDetalleEstado("Serie terminal no puede ser nuevamente vendida");
				throw new GeneralException("12355",0,"Serie terminal no puede ser nuevamente vendida");
			}

			resltadoV = BOAbonado.validaSerieTermialEnListaNegra(terminal);
			if(resltadoV.isResultado()){
				logger.debug("12356 - Serie terminal se encuentra en listas negras");
				resultado.setEstado("NOK");
				resultado.setDetalleEstado("Serie terminal se encuentra en listas negras");
				throw new GeneralException("12356",0,"Serie terminal se encuentra en listas negras");
			}					
			

			logger.debug("terminal.getIndProcEq() ["+terminal.getIndProcEq()+"]");
			logger.debug("config.getString(equipo.procedencia.interna) ["+config.getString("equipo.procedencia.interna")+"]");

			if (terminal.getIndProcEq().equals(config.getString("equipo.procedencia.interna"))){
				logger.debug("Terminal interno Correcto");
				//Verifica que el uso de la serie corresponda a venta pospago

				TipoStockValidoDTO datosStockSerie=new TipoStockValidoDTO();
				datosStockSerie.setTipoStockaValidar(Integer.parseInt(terminal.getTipoStock()));
				logger.debug("codigo modalidad de venta: " + parametrosEntrada.getCodigoModalidadVenta());
				datosStockSerie.setModalidadVenta(Integer.parseInt(parametrosEntrada.getCodigoModalidadVenta()));
				datosStockSerie.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto")));
				resultado=BOTipoStockSerie.validaTipoStockSerie(datosStockSerie);

				if (resultado.isResultado()){
					logger.debug("Terminal OK ultima instanciacion");
					resultado.setEstado("OK");
					resultado.setDetalleEstado("-");
				}
				else
				{
					resultado.setEstado("NOK");
					resultado.setDetalleEstado("La serie terminal tiene un tipo de stock no permitido");
					logger.debug("La serie terminal tiene un tipo de stock no permitido");
					throw new GeneralException("12350",0,"La serie terminal tiene un tipo de stock no permitido");
				}

				logger.debug("Antes de validar estado");
				if (!terminal.getEstado().equals("1")){
					logger.debug("22355 - Serie terminal debe ser nueva");							
					resultado.setEstado("NOK");
					resultado.setDetalleEstado("Serie terminal debe ser nueva");
					throw new GeneralException("22355",0,"Serie terminal debe ser nueva");
				}
				logger.debug("estado terminal correcto");				
			}
			else
			{
				resultado.setEstado("OK");
				resultado.setDetalleEstado("-");

			}


		}
		else
		{
			resultado.setEstado("NOK");
			resultado.setDetalleEstado("El largo de la serie terminal no es correcto");
			logger.debug("El largo de la serie terminal no es correcto ["+parametrosEntrada.getNumeroSerieTerminal().length()+"]");
			logger.debug("El largo de la serie terminal no es correcto ["+parametrosEntrada.getNumeroSerieTerminal()+"]");
			throw new GeneralException("12353",0,"El largo de la serie terminal no es correcto");			
		}
		logger.debug("Fin:validacionesSerieTerminal()");
		return resultado;
	}


	public void getPlanTarifarioClienteEMP(PlanTarifarioDTO planEntrada) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:getPlanTarifario()");
		try{
			BOPlanTarifario.getPlanTarifarioClienteEMP(planEntrada);
			logger.debug("Fin:getPlanTarifario()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
	}	
	
	
	public void udpEmpresa(CuentaComDTO cuenta) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:udpEmpresa()");
		try{
			BOCliente.udpEmpresa(cuenta);
			logger.debug("Fin:udpEmpresa()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
	}		
	
	
	public void ValidaUsuarioSCL(String nomUsuario)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:ValidaUsuarioSCL()");
		try{
			BOUsuario.ValidaUsuarioSCL(nomUsuario);
			logger.debug("Fin:ValidaUsuarioSCL()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
	}			
	
	
	public void udpInterfazDeFacturación(GaVentasDTO gaVentas)
	throws GeneralException{			
		
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		logger.debug("Inicio:udpInterfazDeFacturación()");
		try{
			FacturacionBO.udpInterfazDeFacturación(gaVentas);
			logger.debug("Fin:udpInterfazDeFacturación()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
	}	

	/**
	 * CSR-11002 - (AL) - 2011.07.27
	 * Metodo de categorias para cambio asociadas al cliente.
	 * @return resultado
	 * @throws GeneralException
	 */
	public CategoriaCambioDTO[] getCategoriasCambio() throws GeneralException 
	{
		CategoriaCambioDTO[] resultado;
		try {
			logger.debug("Inicio:getCategoriasCambio()");
			resultado = BOCliente.getCategoriasCambio();		
		} catch (GeneralException e) {
			logger.debug("getCategoriasCambio:end");
			logger.debug("GeneralException");
			throw e;
		} catch (Exception e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
		logger.debug("Fin:getCategoriasCambio()");
		return resultado;
	}
	
	/**
	 * CSR-11002 - (AL) - 2011.07.27 - Inserta categoria de cambio del cliente
	 * @param categCambioCliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insCategoriaCambioCliente(CategoriaCambioClienteDTO categCambioCliente) throws GeneralException 
	{
		try {
			logger.debug("Inicio:insCategoriaCambioCliente()");
			BOCliente.insCategoriaCambioCliente(categCambioCliente);		
		} catch (GeneralException e) {
			logger.debug("insCategoriaCambioCliente:end");
			logger.debug("GeneralException");
			throw e;
		} catch (Exception e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
		logger.debug("Fin:insCategoriaCambioCliente()");
	}
	
	
	/**
	 * CSR-11002
	 * permite obtener las clasificaciones crediticia
	 * @return
	 * @throws GeneralException
	 */
	public ValorClasificacionDTO[] getCrediticia() throws GeneralException{
		
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		ValorClasificacionDTO[] retorno;
		try{
			logger.debug("getCrediticia:start");
			retorno =  BOCliente.getCrediticia();		
			logger.debug("getCrediticia:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getCrediticia:end");
		return retorno;

	}    

	/**
	 * CSR-11002
	 * permite obtener las clasificaciones
	 * @return
	 * @throws GeneralException
	 */
	public ClasificacionDTO[] getClasificaciones() throws GeneralException{
		
		UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));		
		ClasificacionDTO[] retorno;
		try{
			logger.debug("getClasificaciones:start");
			retorno =  BOCliente.getClasificaciones();		
			logger.debug("getClasificaciones:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getClasificaciones:end");
		return retorno;

	}

	/**
	 * Obtiene listado de tipos de pago.
	 * @return WsListModalidadPagoOutDTO
	 * @throws GeneralException
	 */
    public WsListTipoPagoOutDTO getListadoTipoPago() throws GeneralException {
    	UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
        WsListTipoPagoOutDTO retorno;
        try {
    		logger.debug("getListadoTipoPago:start");
    		retorno = BOCliente.getListadoTipoPago();
    		logger.debug("getListadoTipoPago:end");
        }
        catch (GeneralException e) {
        	UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
        	logger.debug("GeneralException");
        	String log = StackTraceUtl.getStackTrace(e);
        	logger.debug((new StringBuilder()).append("log error[").append(log).append("]").toString());
        	throw e;
        }
        catch (Exception e) {
        	UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
    		logger.debug("Exception");
    		String log = StackTraceUtl.getStackTrace(e);
    		logger.debug((new StringBuilder()).append("log error[").append(log).append("]").toString());
    		throw new GeneralException(e);
        }
        logger.debug("getListadoTipoPago:end");
        return retorno;
    }
	
    //JLGN PT
	/**
	 * Obtiene listado de Planes Tarifarios Prepago.
	 * @return WsListPlanTarifarioOutDTO
	 * @throws GeneralException
	 */
    public WsListPlanTarifarioOutDTO getListadoPlanTarifario(String tipProducto, String tipPlan, String codTipPrestacion, int indRenova, String codCalificacion)
    throws GeneralException {
    	UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
    	WsListPlanTarifarioOutDTO retorno;
        try {
    		logger.debug("getListadoPlanTarifario:start");
    		retorno = BOCliente.getListadoPlanTarifario(tipProducto, tipPlan, codTipPrestacion, indRenova, codCalificacion);
    		logger.debug("getListadoPlanTarifario:end");
        }
        catch (GeneralException e) {
        	UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
        	logger.debug("GeneralException");
        	String log = StackTraceUtl.getStackTrace(e);
        	logger.debug((new StringBuilder()).append("log error[").append(log).append("]").toString());
        	throw e;
        }
        catch (Exception e) {
        	UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
    		logger.debug("Exception");
    		String log = StackTraceUtl.getStackTrace(e);
    		logger.debug((new StringBuilder()).append("log error[").append(log).append("]").toString());
    		throw new GeneralException(e);
        }
        logger.debug("getListadoPlanTarifario:end");
        return retorno;
    }

}
