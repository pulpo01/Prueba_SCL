package com.tmmas.cl.scl.gestiondeabonados.service.servicios;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.PrestacionDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TipoPrestacionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.PrestacionBO;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsRegistraCampanaByPInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.AbonadoBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.ArticuloBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.CampanaVigenteBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.ContratoBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.PlanTarifarioBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.RegistroVentaBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.SerieBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.SerieKitBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.ServicioSuplementarioBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.SimcardBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.TerminalBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.UsuarioBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AperturaRangoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CargosSimcarPrepagoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ExisteSSAbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.GaEquipAboserDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ImeiWSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.OutAbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParamRestriccionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReglaCompatibilidadSSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReglasSSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RestriccionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieKitDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ServicioSuplementarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ValidacionServicioSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsAgregaEliminaSSInDTO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.ClienteBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.CuentaBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.VendedorBO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ContratoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DatosGeneralesVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.UsuarioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClienteIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInformacionLineaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInformacionLineaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsNumeroSerieInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsNumeroSerieOutDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.DireccionBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.bo.DatosGeneralesBO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.bo.ParametrosGeneralesBO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.ParametrosGeneralesDTO;







public class GestionDeAbonadosSrv {

	ArticuloBO       		BOarticulo      		= new ArticuloBO();
	SimcardBO        		BOsimcard       		=  new SimcardBO();
	TerminalBO       		BOterminal      		= new TerminalBO();	
	PlanTarifarioBO  		BOplanTarifario 		= new PlanTarifarioBO(); 	
	ClienteBO        		BOCliente       		= new ClienteBO();
	CuentaBO         		BOCuenta        		= new CuentaBO();
	UsuarioBO        		BOUsuario       		= new UsuarioBO();
	AbonadoBO        		BOAbonado       		= new AbonadoBO();	
	DireccionBO      		BODireccion     		= new DireccionBO();
	ParametrosGeneralesBO   BOParametrosGenerales   = new ParametrosGeneralesBO();
	ServicioSuplementarioBO BOServicioSuplementario = new ServicioSuplementarioBO(); 
	VendedorBO              BOVendedor              = new VendedorBO();
	DatosGeneralesBO        BODatosGenerales        = new DatosGeneralesBO();
	CampanaVigenteBO        BOCampanaVigente        = new CampanaVigenteBO();
	RegistroVentaBO         BORegistroVenta         = new RegistroVentaBO();
	ContratoBO              BOContrato              = new ContratoBO(); 
	SerieBO                 BOSerie                 = new SerieBO();
	DatosGeneralesBO        DatosGeneralesBO        = new DatosGeneralesBO();    
	SerieKitBO              BOSerieKit              = new SerieKitBO();
	private PrestacionBO prestacionBO = new PrestacionBO();	

	private final Logger logger = Logger.getLogger(GestionDeAbonadosSrv.class);
	private CompositeConfiguration config;

    /* CSR-11002 Se incorpora el método getTiposPrestacion*/
	public TipoPrestacionDTO[] getTiposPrestacion(String codGrupoPrestacion, String tipoCliente) 
	/*throws ProductDomainException*/
	throws GeneralException
	{
	logger.debug("Inicio:getTiposPrestacion()");
	TipoPrestacionDTO[] resultado = prestacionBO.getTipoPrestacion(codGrupoPrestacion, tipoCliente);
	logger.debug("Fin:getTiposPrestacion()");
	return resultado;		
	}//fin getTiposPrestacion
	
	public GestionDeAbonadosSrv() {
		System.out.println("GestionDeAbonadosSrv(): Start");
		config = UtilProperty.getConfiguration("GestionDeAbonadosSrv.properties","com/tmmas/cl/scl/gestiondeabonados/service/properties/servicios.properties");
		System.out.println("GestionDeAbonadosSrv.log ["+config.getString("GestionDeAbonadosSrv.log")+"]");
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("GestionDeAbonadosSrv():End");
	}



	public DatosGeneralesVentaDTO creacionLineas(DatosGeneralesVentaDTO datosGeneralesVenta)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));		
		logger.debug("Inicio:creacionLineas()");
		DatosGeneralesVentaDTO resultado = datosGeneralesVenta;
		resultado.setEstadoError("OK");
		resultado.setDetalleError("-");

		String sNumeroMovtoSerieSimcard = null;
		String sNumeroMovtoSerieTerminal = null;

		Date fecha = new Date();




		AbonadoDTO abonadoAux = new AbonadoDTO();
		ServicioSuplementarioDTO servicioSuplementario = new ServicioSuplementarioDTO();
		UsuarioDTO usuario=new UsuarioDTO();
		ClienteDTO cliente = new ClienteDTO();
		AbonadoDTO abonado = new AbonadoDTO();
		CuentaDTO subCuenta = new CuentaDTO();
		SimcardSNPNDTO simcard = new SimcardSNPNDTO();		
		TerminalSNPNDTO terminal = new TerminalSNPNDTO();
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		VendedorDTO vendedor = new VendedorDTO();
		ArticuloDTO articulo = new ArticuloDTO();
		String usoLinea =null;

		//-- BUSCAR SERIE

		if (datosGeneralesVenta.getNumeroSerieKit().equals("")){
			simcard.setNumeroSerie(datosGeneralesVenta.getNumeroSerieSimcard());
			simcard = BOsimcard.getSimcard(simcard);
			
			terminal.setNumeroSerie(datosGeneralesVenta.getNumeroSerieTerminal());
			terminal = BOterminal.getTerminal(terminal);
		}else{
			SerieKitDTO seriekit = new SerieKitDTO();
			seriekit.setNumSerieKit(datosGeneralesVenta.getNumeroSerieKit());
			seriekit.setNumSerieSimcard(datosGeneralesVenta.getNumeroSerieSimcard());
			simcard = BOSerieKit.getSerieSimcardKit(seriekit);
			
			seriekit.setNumSerieKit(datosGeneralesVenta.getNumeroSerieKit());
			seriekit.setNumSerieTerminal(datosGeneralesVenta.getNumeroSerieTerminal());
			terminal = BOSerieKit.getSerieTerminalKit(seriekit);
		}


		//-- BUSCAR TERMINAL
		

		String lst_tipoTerminal = datosGeneralesVenta.getTipoTerminal();

		//-- BUSCAR PLAN TARIFARIO
		planTarifario.setCodigoPlanTarifario(datosGeneralesVenta.getCodigoPlanTarifario());
		planTarifario.setCodigoProducto(config.getString("codigo.producto"));
		
		
		
		planTarifario.setCodigoTecnologia(datosGeneralesVenta.getCodigoTecnologia());
		planTarifario = BOplanTarifario.getPlanTarifario(planTarifario);

		if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.postpago"))){
			usoLinea =  config.getString("codigo.uso.postpago");
		}else if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.hibrido"))){
			usoLinea =  config.getString("codigo.uso.hibrido");
		}else if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.prepago"))){
			usoLinea =  config.getString("codigo.uso.prepago");
		}else{
			logger.debug("Error en el uso de la linea");
			throw new GeneralException("12412",0,"Error en el uso de la linea");
		}
		//RESERVA SERIE SIMCARD
		if(simcard.getEstado().equals(datosGeneralesVenta.getEstadoSerieSimcard()))
		{				
			logger.debug("SIMCARD:RESERVA DEL ARTICULO");
			//-- RESERVA DEL ARTICULO
			articulo.setNumeroTransaccion(datosGeneralesVenta.getNumeroTransaccionVenta());
			articulo.setNumeroLinea(datosGeneralesVenta.getCorrelativoLinea());
			articulo.setNumeroOrden(datosGeneralesVenta.getNumeroOrden());
			articulo.setCodigo(Long.parseLong(simcard.getCodigoArticulo()));
			articulo.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto")));
			articulo.setCodigoBodega(Integer.parseInt(simcard.getCodigoBodega()));
			articulo.setTipoStock(Integer.parseInt(simcard.getTipoStock()));
			articulo.setCodigoUso(Integer.parseInt(simcard.getCodigoUso()));
			articulo.setCodigoEstado(Integer.parseInt(simcard.getEstado()));
			articulo.setNombreUsuario(datosGeneralesVenta.getNombreUsuarioOracle());//???
			articulo.setNumeroSerie(simcard.getNumeroSerie());

			try {
				BOarticulo.insReservaArticulo(articulo);

				logger.debug("SIMCARD:ACTUALIZA STOCK");
				//-- ACTUALIZA STOCK
				articulo.setTipoMovimiento(config.getString("tipo.movto.resventa"));
				articulo.setTipoStock(Integer.parseInt(simcard.getTipoStock()));
				articulo.setCodigoBodega(Integer.parseInt(simcard.getCodigoBodega()));
				articulo.setCodigo(Long.parseLong(simcard.getCodigoArticulo()));
				articulo.setCodigoUso(Integer.parseInt(simcard.getCodigoUso()));
				articulo.setCodigoEstado(Integer.parseInt(simcard.getEstado()));
				articulo.setNumeroVenta(datosGeneralesVenta.getNumeroVenta());
				articulo.setNumeroSerie(simcard.getNumeroSerie());

				try {
					if (articulo.getCodigoEstado() != 7 ){

						SerieDTO serie2 = new SerieDTO();
						if (datosGeneralesVenta.getNumeroSerieKit().equals("")){
							serie2.setNumSerie(simcard.getNumeroSerie());
						}else{
							serie2.setNumSerie(datosGeneralesVenta.getNumeroSerieKit());
						}
						
						
						serie2.setNomUsuario(datosGeneralesVenta.getNombreUsuarioOracle());
						serie2.setNumPorceso(String.valueOf(datosGeneralesVenta.getNumeroVenta()));					
						serie2 = BOSerie.reservaSerie(serie2);

						//articulo  = BOarticulo.ActualizaStock(articulo);

						sNumeroMovtoSerieSimcard = serie2.getNumMovimiento();
					}else{
						logger.debug("92413 --- La Serie ["+articulo.getNumeroSerie()+"] se encuentra reservada");
						throw new GeneralException("92413",0,"La Serie ["+simcard.getNumeroSerie()+"] se encuentra reservada");
					}

					//-- RESERVA SERIE TERMINAL

					logger.debug("TERMINAL:RESERVA DEL ARTICULO");
					//-- RESERVA DEL ARTICULO
					if(terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){
						articulo.setNumeroTransaccion(datosGeneralesVenta.getNumeroTransaccionVenta());
						articulo.setNumeroLinea(datosGeneralesVenta.getCorrelativoLinea());
						articulo.setNumeroOrden(datosGeneralesVenta.getNumeroOrden()+1);
						articulo.setCodigo(Long.parseLong(terminal.getCodigoArticulo()));
						articulo.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto")));
						articulo.setCodigoBodega(Integer.parseInt(terminal.getCodigoBodega()));
						articulo.setTipoStock(Integer.parseInt(terminal.getTipoStock()));
						articulo.setCodigoUso(Integer.parseInt(terminal.getCodigoUso()));
						articulo.setCodigoEstado(Integer.parseInt(terminal.getEstado()));
						articulo.setNombreUsuario(datosGeneralesVenta.getNombreUsuarioOracle());//???
						articulo.setNumeroSerie(terminal.getNumeroSerie());
					}
					try {
						if(terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){
							BOarticulo.insReservaArticulo(articulo);
							logger.debug("TERMINAL:ACTUALIZA STOCK");
							//-- ACTUALIZA STOCK  
							articulo.setTipoMovimiento(config.getString("tipo.movto.resventa"));
							articulo.setTipoStock(Integer.parseInt(terminal.getTipoStock()));
							articulo.setCodigoBodega(Integer.parseInt(terminal.getCodigoBodega()));
							articulo.setCodigo(Long.parseLong(terminal.getCodigoArticulo()));
							articulo.setCodigoUso(Integer.parseInt(terminal.getCodigoUso()));
							articulo.setCodigoEstado(Integer.parseInt(terminal.getEstado()));
							articulo.setNumeroVenta(datosGeneralesVenta.getNumeroVenta());
							articulo.setNumeroSerie(terminal.getNumeroSerie());
						}
						try {
							if(terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){

								if (articulo.getCodigoEstado() != 7 ){
                                   if (datosGeneralesVenta.getNumeroSerieKit().equals("")){
									   SerieDTO serie2 = new SerieDTO();
									   serie2.setNumSerie(articulo.getNumeroSerie());
									   serie2.setNomUsuario(datosGeneralesVenta.getNombreUsuarioOracle());
									   serie2.setNumPorceso(String.valueOf(datosGeneralesVenta.getNumeroVenta()));					
									   serie2 = BOSerie.reservaSerie(serie2);

									   //articulo  = BOarticulo.ActualizaStock(articulo);

									   sNumeroMovtoSerieTerminal = serie2.getNumMovimiento();
                                   }
								}else{
									logger.debug("92413 --- La Serie ["+articulo.getNumeroSerie()+"] se encuentra reservada");
									throw new GeneralException("92413",0,"La Serie ["+articulo.getNumeroSerie()+"] se encuentra reservada");
								}
							}
							//-- BUSCA CLIENTE
							cliente.setCodigoCliente(datosGeneralesVenta.getCodigoCliente());
							cliente = BOCliente.getCliente(cliente);

							//-- BUSCA OFICINA PRINCIPAL VENDEDOR
							vendedor.setCodigoVendedor(datosGeneralesVenta.getCodigoVendedor());
							vendedor.setCodigoVendedorDealer(Long.parseLong(datosGeneralesVenta.getCodigoVendedorDealer()));
							vendedor = getVendedor(vendedor);
							abonadoAux = getOficinaPrincipal(vendedor);

							//-- BUSCA SUBCUENTA

							if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.prepago"))){
								cliente.setCodigoSubCuenta("");										 
							}else{
								subCuenta.setCodigoCuenta(cliente.getCodigoCuenta());
								subCuenta = getSubCuenta(subCuenta);
								cliente.setCodigoSubCuenta(subCuenta.getCodigoSubCuenta());
							}


							String sEstadoError = "OK";
							String sDetalleError = "-";
							//-- CREAR USUARIO
							try{
								//P-ECU-08019 --> Valida si existe usuario en caso contrario lo crea

																	

								logger.debug("VentasSrv:Usuario NO se encuentra");								
								abonado = getSecuenciaAbonado();


								resultado.setNumeroAbonado(String.valueOf(abonado.getNumAbonado()));

								UsuarioDTO nuevoUsuario=new UsuarioDTO();
								nuevoUsuario=BOUsuario.getSecuenciaUsuario();
								if ( !(simcard.getCodigoUso().equals("3") || planTarifario.getCodigoTipoPlan().equals("1")) ){										
									usuario=creacionUsuario(cliente,planTarifario,datosGeneralesVenta, abonado,nuevoUsuario );									   	    
									if (usuario.getExitoCreacionUusario()==false){
										sEstadoError = "NOK";
										sDetalleError = "Ocurrio un error al crear el Usuario";
										throw new GeneralException("12413",0,"Ocurrio un error al crear el Usuario");
									}
								}else{
									usuario.setCodigoUsuario("0");
								}

								//-- OBTIENE SECUENCIA-NUMERO ABONADO
								sEstadoError = "NOK";
								sDetalleError = "Ocurrio un error al crear el Abonado";
								abonado = getSecuenciaAbonado();

								abonado.setFecAlta(datosGeneralesVenta.getFechaActual());

								abonado.setNumCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
								abonado.setCodProducto(Integer.parseInt(config.getString("codigo.producto")));
								abonado.setCodCliente(Long.parseLong(cliente.getCodigoCliente()));
								abonado.setCodCuenta(Long.parseLong(cliente.getCodigoCuenta()));
								abonado.setCodSubCuenta(cliente.getCodigoSubCuenta());
								abonado.setCodUsuario(Long.parseLong(nuevoUsuario.getCodigoUsuario()));
								abonado.setCodRegion(datosGeneralesVenta.getCodigoRegion());
								abonado.setCodProvincia(datosGeneralesVenta.getCodigoProvincia());
								abonado.setCodCiudad(datosGeneralesVenta.getCodigoCiudad());

								abonado.setNumSerieSimcard(simcard.getNumeroSerie());
								abonado.setCodBodegaSimcard(simcard.getCodigoBodega());
								abonado.setCapcodeSimcard(simcard.getCapCode());
								abonado.setTipoStockSimcard(Long.parseLong(simcard.getTipoStock()));
								abonado.setCodigoArticuloSimcard(simcard.getCodigoArticulo());
								abonado.setDesArticuloSimcard(simcard.getDescripcionArticulo());
								abonado.setCodEstadoSimcard(config.getString("estado.articulo"));
								abonado.setCodUsoSimcard(Integer.parseInt(simcard.getCodigoUso()));

								abonado.setCodPassword(simcard.getNumeroSerie().substring(simcard.getNumeroSerie().length()-4,simcard.getNumeroSerie().length()));

								abonado.setNumSerieTerminal(terminal.getNumeroSerie());
								abonado.setCodBodegaTerminal(terminal.getCodigoBodega());
								abonado.setCapcodeTerminal(terminal.getCapCode());
								if (terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){
									abonado.setTipoStockTerminal(Long.parseLong(terminal.getTipoStock()));
									abonado.setCodigoArticuloTerminal(terminal.getCodigoArticulo());
									abonado.setDesArticuloTerminal(terminal.getDescripcionArticulo());
									abonado.setCodUsoTerminal(Integer.parseInt(terminal.getCodigoUso()));
									abonado.setCodEstadoTerminal(terminal.getEstado());
								}
								else{
									ParametrosGeneralesDTO parametroTerminal = new ParametrosGeneralesDTO();

									/*--Busca Código Articulo por defecto asignado a equipos externos--*/
									parametroTerminal.setCodigomodulo(config.getString("codigo.modulo.GA"));
									parametroTerminal.setCodigoproducto(config.getString("codigo.producto"));


									articulo.setCodigo(Long.parseLong(config.getString("parametro.articulo.terminal.externo")));
									articulo = BOarticulo.getArticulo(articulo);

									abonado.setCodigoArticuloTerminal(String.valueOf(articulo.getCodigo()));
									abonado.setDesArticuloTerminal(articulo.getDescripcion());

									if (planTarifario.getCodigoTipoPlan().equals("2")){
										abonado.setCodUsoTerminal(Integer.parseInt(config.getString("parametro.usoVentaPostpago")));
									}else if (planTarifario.getCodigoTipoPlan().equals("3")){
										abonado.setCodUsoTerminal(Integer.parseInt(config.getString("parametro.usoVentaHibrido")));
									}else if (planTarifario.getCodigoTipoPlan().equals("1")){
										abonado.setCodUsoTerminal(Integer.parseInt(config.getString("parametro.usoVentaPrepago")));
									}



								}
								abonado.setNumImei(terminal.getNumeroSerie());
								abonado.setIndProcEqTerminal(terminal.getIndProcEq());
								abonado.setTipPlantarif(planTarifario.getTipoPlanTarifario());
								abonado.setCodCargoBasico(planTarifario.getCodigoCargoBasico());
								abonado.setCodPlanServ(planTarifario.getCodigoPlanServicio());
								
								if (datosGeneralesVenta.getIdentificadorEmpresa().equals(config.getString("identificador.empresa"))){																	
									String limConClieEmp = BOCliente.getLimConsClieEmpresa(datosGeneralesVenta.getCodigoCliente());
									
									if (limConClieEmp != null){
										if (!limConClieEmp.equals("")){
											abonado.setCodLimConsumo(limConClieEmp);
										}else{
											abonado.setCodLimConsumo(planTarifario.getCodigoLimiteConsumo());
										}
									}else{
										abonado.setCodLimConsumo(planTarifario.getCodigoLimiteConsumo());
									}
								}else{
									abonado.setCodLimConsumo(planTarifario.getCodigoLimiteConsumo());
								}
							
							
								abonado.setCodigoTipoPlan(planTarifario.getCodigoTipoPlan());				

								abonado.setCodCelda(datosGeneralesVenta.getCodigoCelda());  
								abonado.setCodCentral(Integer.parseInt(datosGeneralesVenta.getCodigoCentral()));
								abonado.setCodSituacion(config.getString("codigo.situacion"));
								abonado.setIndProcAlta(config.getString("indice.procalta"));
								abonado.setIndProcEqSimcard(config.getString("indicador.procedencia.equipo.simcard"));
								abonado.setCodVendedor(Long.parseLong(datosGeneralesVenta.getCodigoVendedor()));
								abonado.setCodVendedorAgente(Long.parseLong(datosGeneralesVenta.getCodigoVendedorRaiz()));
								abonado.setTipTerminal(lst_tipoTerminal);
								abonado.setCodPlanTarif(datosGeneralesVenta.getCodigoPlanTarifario());
								abonado.setNumSerieHex(config.getString("numero.serie.hexadecimal"));
								abonado.setNomUsuarOra(datosGeneralesVenta.getNombreUsuarioOracle());
								abonado.setNumPerContrato(Integer.parseInt(datosGeneralesVenta.getNumeroPerContrato()));
								abonado.setCodigoEstado(datosGeneralesVenta.getCodigoEstado());
								abonado.setNumSerieMec(null);
								if (datosGeneralesVenta.getIdentificadorEmpresa().equals(config.getString("identificador.empresa")))
									abonado.setCodEmpresa(cliente.getCodigoEmpresa());

								abonado.setIndSuperTel(Integer.parseInt(config.getString("indicador.supertelefono")));
								abonado.setNumTeleFija(null);
								abonado.setIndPrepago(Integer.parseInt(config.getString("indicador.prepago")));
								abonado.setIndPlexSys(Integer.parseInt(config.getString("indicador.plexsys")));
								abonado.setNumVenta(Long.parseLong(datosGeneralesVenta.getNumeroVenta()));
								abonado.setCodModVenta(Long.parseLong(datosGeneralesVenta.getCodigoModalidadVenta()));
								abonado.setCodTipContrato(datosGeneralesVenta.getCodigoTipoContrato());
								abonado.setNumContrato(datosGeneralesVenta.getNumeroContrato());
								abonado.setNumAnexo(null);

								ContratoDTO contrato1 = new ContratoDTO();

								contrato1.setCodigoTipoContrato(datosGeneralesVenta.getCodigoTipoContrato());
								contrato1 = BOContrato.getTipcontrato(contrato1);

								Calendar cal = new GregorianCalendar(); 
								cal.setTimeInMillis(fecha.getTime()); 
								cal.add(Calendar.MONTH, contrato1.getNumeroMeses());

								Date fechaFinContrato = new Date(cal.getTimeInMillis()); 

								String fechaFinContratoFormateada = Formatting.dateTime(fechaFinContrato,"dd/MM/yyyy HH:mm:ss");
								cal = new GregorianCalendar(); 
								cal.setTimeInMillis(fecha.getTime()); 
								cal.add(Calendar.DATE,planTarifario.getNumDias()); 
								Date fechaFecCumpPlan = new Date(cal.getTimeInMillis()); 
								String fechaFecCumpPlanFormateada = Formatting.dateTime(fechaFecCumpPlan,"dd/MM/yyyy HH:mm:ss");
								abonado.setFecCumPlan(fechaFecCumpPlanFormateada);
								abonado.setCodCredMor(datosGeneralesVenta.getCodigoCreditoMorosidad());
								abonado.setCodCredCon(datosGeneralesVenta.getCodigoCreditoConsumo());
								abonado.setCodCiclo(cliente.getCodigoCiclo());
								abonado.setCodFactur(Integer.parseInt(datosGeneralesVenta.getIndicadorFacturable()));
								abonado.setIndSuspen(Integer.parseInt(config.getString("indicador.ind_suspen")));
								abonado.setIndReHabi(Integer.parseInt(config.getString("indicador.ind_rehabi")));
								abonado.setInsGuias(Integer.parseInt(config.getString("indicador.ind_insguias")));
								abonado.setFecFinContra(fechaFinContratoFormateada);
								abonado.setFecRecDocu(datosGeneralesVenta.getFechaActual());	//Valor por defecto null.... Se asigna fecha actual
								abonado.setFecCumplimen(datosGeneralesVenta.getFechaActual());	//Valor por defecto null.... Se asigna fecha actual
								abonado.setFecAcepVenta(null);	//Valor por defecto null.... Se asigna fecha actual
								abonado.setFecActCen(null);		//Valor por defecto null.... Se asigna fecha actual
								abonado.setFecBaja(null);		//Valor por defecto null.... Se asigna fecha actual
								abonado.setFecBajaCen(null);	//Valor por defecto null.... Se asigna fecha actual
								abonado.setFecUltMod(datosGeneralesVenta.getFechaActual());
								abonado.setCodCausaBaja(null);//Valor por defecto null no utilizada en VB
								abonado.setNumPersonal(null); //Valor por defecto null no utilizada en VB
								abonado.setIndSeguro(Integer.parseInt(config.getString("indicador.ind_seguro")));
								abonado.setClaseServicio(null);//Valor por defecto null no utilizada en VB
								abonado.setPerfilAbonado(null);
								/*Obtiene prefijo min y min mdn*/
								RegistroVentaDTO registroVenta = new RegistroVentaDTO();
								registroVenta.setNumeroCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
								registroVenta = getPrefijoMin(registroVenta);
								if (registroVenta != null)
									abonado.setNumMin(registroVenta.getPrefijoMin());// Se Obtiene de procedimineto AL_FN_PREFIJO_NUMERO(celular parametro)
								if (registroVenta == null){
									registroVenta = new RegistroVentaDTO();
									registroVenta.setNumeroCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
								}
								registroVenta = BORegistroVenta.getMinMDN(registroVenta);
								abonado.setNumMinMdn(registroVenta.getMinMDN());// Se Obtiene de procedimineto AL_FN_PREFIJO_NUMERO(celular parametro)

								abonado.setCodVendealer(Long.parseLong(datosGeneralesVenta.getCodigoVendedorDealer()));
								abonado.setIndPassword(null);	//nulo por defecto
								abonado.setCodAfinidad(datosGeneralesVenta.getCodigoGrupoAfinidad());
								abonado.setFecProrroga(null);

								ContratoDTO contrato = new ContratoDTO();
								contrato.setCodigoProducto(1);
								contrato.setCodigoTipoContrato(datosGeneralesVenta.getCodigoTipoContrato());
								BOContrato.getTipoContrato(contrato);

								abonado.setIndEqPrestadoTerminal( String.valueOf(contrato.getIndComodato()));
								abonado.setIndEqPrestadoSimcard(String.valueOf(contrato.getIndComodato()));
								abonado.setFlgContDigi(null);	//Valor por defecto null, no es llenado en VB
								abonado.setFecAltanTras(null); 	//Valor por defecto null, no es llenado en VB
								abonado.setCodIndemnizacion(Integer.parseInt(datosGeneralesVenta.getCodigoPlanIndemnizacion()));
								abonado.setNumImei(datosGeneralesVenta.getNumeroSerieTerminal());
								abonado.setCodTecnologia(datosGeneralesVenta.getCodigoTecnologia());
								abonado.setFecActivacion(null);	//Valor por defecto null, no es llenado en VB
								abonado.setCodOficinaPrincipal(abonadoAux.getCodOficinaPrincipal());
								
								//CSR-11002
								abonado.setCodPrestacion(datosGeneralesVenta.getCodPrestacion());
								logger.debug("Set código de prestación: " + datosGeneralesVenta.getCodPrestacion());
								//fin CSR-11002
								
								//if (datosGeneralesVenta.getCodigoCausaDescuento()!=null){ modificacion proceso de facturacion
								//abonado.setCodCausaVenta(datosGeneralesVenta.getCodigoCausaDescuento()); modificacion proceso de facturacion
								if ( (simcard.getCodigoUso().equals("3") || planTarifario.getCodigoTipoPlan().equals("1")) ){
									abonado.setCodOperacion(config.getString("codigo.operacion.prepago"));	
									abonado.setCodGrpSrv("");
								}else{
									abonado.setCodOperacion(config.getString("codigo.operacion"));
									abonado.setCodGrpSrv(datosGeneralesVenta.getCodigoGrupoServicio());

								}
								//} modificacion proceso de facturacion

								if (!(datosGeneralesVenta.getCodigoOperador()==null)){

									TerminalSNPNDTO Terval = new TerminalSNPNDTO();
									Terval.setNumeroCelular(String.valueOf(abonado.getNumCelular()));
									String tipter = BOterminal.validaRangoTerminal(Terval);

									if (tipter.equals("E")){
										/* CSR-11002
										 * abonado.setIndicadorPortado(datosGeneralesVenta.getIndicadorPortado());*/
										abonado.setCodigoOperador(datosGeneralesVenta.getCodigoOperador());									    	
										abonado.setCodSituacion(config.getString("codigo.situacion.portado"));
									}else if (tipter.equals("I")){
										abonado.setIndicadorPortado("0");
										abonado.setCodigoOperador(datosGeneralesVenta.getCodigoOperador());									    	
										abonado.setCodSituacion(config.getString("codigo.situacion.portado"));
									}

								}

								abonado.setCodUso(usoLinea);
								//-- CREA ABONADO
								sEstadoError = "NOK";
								sDetalleError = "Ocurrio un error al crear los SS";
								logger.debug("ventasSrv:antes de crear abonado: " + datosGeneralesVenta.getNumeroSerieSimcard());
								abonado.setVendedor(vendedor);
								creaAbonado(abonado);
								logger.debug("ventasSrv:despues de crear abonado");

								if ( (simcard.getCodigoUso().equals("3") || planTarifario.getCodigoTipoPlan().equals("1")) ){										
									usuario=creacionUsuario(cliente,planTarifario,datosGeneralesVenta, abonado ,nuevoUsuario);									   	    
									if (usuario.getExitoCreacionUusario()==false){
										sEstadoError = "NOK";
										sDetalleError = "Ocurrio un error al crear el Usuario";
										throw new GeneralException("12414",0,"Ocurrio un error al crear el Usuario");
									}
								}

								//Ejecuta creación Abonados Red Celular ga_abocel (Simcard y Terminal).
								abonado.setIndComodato(String.valueOf(datosGeneralesVenta.getIndicadorComodato()));
								abonado.setTipTerminalEquipo(datosGeneralesVenta.getCodigoTerminalGSM());
								abonado.setTipTerminalSimcard(datosGeneralesVenta.getCodigoSimcardGSM());
								if(datosGeneralesVenta.getIndicadorCuotas() != null){
									if(!datosGeneralesVenta.getIndicadorCuotas().equals("0"))
										abonado.setIndPropiedad(config.getString("indicador.propiedad.externo"));
									else
										abonado.setIndPropiedad(config.getString("indicador.propiedad.cuotas"));
								}
								else
									abonado.setIndPropiedad(config.getString("indicador.propiedad.externo"));
								abonado.setIndEqAcc(config.getString("indicador.equiacc"));    
								//-- INSERTA EN ga_servsuplabo ( SERVICIOS SUPLEMENTARIOS )
								servicioSuplementario.setNumeroAbonado(String.valueOf(abonado.getNumAbonado()));
								servicioSuplementario.setCodigoPlan(abonado.getCodPlanTarif());
								servicioSuplementario.setNumeroTerminal(String.valueOf(abonado.getNumCelular()));
								servicioSuplementario.setNomUsuario(datosGeneralesVenta.getNombreUsuarioOracle());
								creaSSAbonado(servicioSuplementario);				    

								//-- INSERTA EN ga_equipaboser									    
								abonado.setNumeroMovimiento(sNumeroMovtoSerieSimcard);
								abonado.setCodCuota(datosGeneralesVenta.getCodigoCuotas());
								creaSimcardAboser(abonado);

								//-- INSERTA EN ga_equipaboser								    	
								abonado.setNumeroMovimiento(sNumeroMovtoSerieTerminal);
								creaTerminalAboser(abonado);									    
							}
							catch(GeneralException e){
								logger.debug("GeneralException 1");			
								logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
								logger.debug("e.getCodigo()[" + e.getCodigo() + "]");
								logger.debug("GeneralException[", e);
								throw e;
							} catch (Exception e) {
								logger.debug("Exception[", e);
								throw new GeneralException(e);
							}

						}
						catch(GeneralException e){
							logger.debug("GeneralException 2");			
							logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
							logger.debug("e.getCodigo()[" + e.getCodigo() + "]");
							logger.debug("GeneralException[", e);
							logger.debug("GeneralException[", e);
							throw e;
						} catch (Exception e) {
							logger.debug("Exception[", e);
							throw new GeneralException(e);
						}

					}
					catch(GeneralException e){
						logger.debug("GeneralException 3");			
						logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
						logger.debug("e.getCodigo()[" + e.getCodigo() + "]");
						logger.debug("GeneralException[", e);
						logger.debug("GeneralException[", e);
						logger.debug("GeneralException[", e);
						throw e;
					} catch (Exception e) {
						logger.debug("Exception[", e);
						throw new GeneralException(e);
					}

				}
				catch(GeneralException e){
					logger.debug("GeneralException 4");			
					logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
					logger.debug("e.getCodigo()[" + e.getCodigo() + "]");
					logger.debug("GeneralException[", e);
					logger.debug("GeneralException[", e);
					logger.debug("GeneralException[", e);
					throw e;
				} catch (Exception e) {
					logger.debug("Exception[", e);
					throw new GeneralException(e);
				}
			}
			catch(GeneralException e){
				logger.debug("GeneralException 5");			
				logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
				logger.debug("e.getCodigo()[" + e.getCodigo() + "]");
				logger.debug("GeneralException[", e);
				logger.debug("GeneralException[", e);
				logger.debug("GeneralException[", e);
				throw e;
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}
		}// estado (simcard)
		else {				
			logger.debug("[ERROR] Estado de la serie simcard no es el mismo. Serie fue tomada por otro vendedor. ");
			logger.debug("simcard.getNumeroSerie() [" + simcard.getNumeroSerie() + "]");
			logger.debug("simcard.getEstado() ["+simcard.getEstado()+"]");
			logger.debug("datosGeneralesVenta.getEstadoSerieSimcard() ["+datosGeneralesVenta.getEstadoSerieSimcard()+"]");
			
			resultado.setEstadoError("NOK");
			resultado.setDetalleError("Estado de la serie simcard no es el mismo. Serie fue tomada por otro vendedor");
			throw new GeneralException("9852365",0,"Estado de la serie simcard no es el mismo. Serie fue tomada por otro vendedor");
		}


		//-- Registra campaña a nivel de abonado
		logger.debug("codigo campana vigente: " + datosGeneralesVenta.getAplicaCampañaA());
		if(!resultado.getEstadoError().equals("NOK")) //-- no hubo error
			if (datosGeneralesVenta.getCodigoCampaña()!=null && 
					datosGeneralesVenta.getAplicaCampañaA().equals(config.getString("aplica.campana.a.abonado"))){
				logger.debug("aplica campaña a abonado..." + abonado.getNumAbonado());
				CampanaVigenteDTO campanaVigenteDTO = new CampanaVigenteDTO();
				campanaVigenteDTO.setCodigoCampanasVigentes(datosGeneralesVenta.getCodigoCampaña());
				campanaVigenteDTO.setCodigoCliente(Long.parseLong(datosGeneralesVenta.getCodigoCliente()));
				campanaVigenteDTO.setNumeroAbonado(abonado.getNumAbonado());
				registraCampanaVigente(campanaVigenteDTO);
			}


		resultado.setNumeroAbonado(String.valueOf(abonado.getNumAbonado()));
		resultado.setNumeroSerieSimcard(simcard.getNumeroSerie());
		resultado.setNumeroSerieTerminal(abonado.getNumImei());
		resultado.setNumeroCelular(String.valueOf(abonado.getNumCelular()));

		logger.debug("Fin:creacionLineas()");
		return resultado;
	}	


	public VendedorDTO getVendedor(VendedorDTO vendedor) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("getVendedor():start");
		VendedorDTO resultado= BOVendedor.getVendedor(vendedor);
		logger.debug("getVendedor():end");
		return resultado;
	}	

	public AbonadoDTO getOficinaPrincipal(VendedorDTO entrada) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:getOficinaPrincipal()");
		AbonadoDTO resultado = new AbonadoDTO();
		resultado = BOAbonado.getOficinaPrincipal(entrada);
		logger.debug("Fin:getOficinaPrincipal()");
		return resultado;
	}	

	public CuentaDTO getSubCuenta(CuentaDTO entrada) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:getSubCuenta()");
		CuentaDTO resultado = new CuentaDTO();

		resultado = BOCuenta.getSubCuenta(entrada);
		logger.debug("Fin:getSubCuenta()");
		return resultado;
	}	

	public UsuarioDTO creacionUsuario(ClienteDTO entrada,PlanTarifarioDTO planTarifario,DatosGeneralesVentaDTO datosGeneralesVenta, AbonadoDTO abonado,UsuarioDTO nuevoUsuario)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:creacionUsuario()");
				
		nuevoUsuario.setCodigoCuenta(entrada.getCodigoCuenta());
		nuevoUsuario.setCodigoSubCuenta(entrada.getCodigoSubCuenta());		
		nuevoUsuario.setIngresosBrutosAnuales(datosGeneralesVenta.getUsuarioLinea().getIngresosBrutosAnuales());
		nuevoUsuario.setNombre(datosGeneralesVenta.getUsuarioLinea().getNombre());
		nuevoUsuario.setNomEmpresa(datosGeneralesVenta.getUsuarioLinea().getNomEmpresa());
		nuevoUsuario.setNumeroIdentificacion(datosGeneralesVenta.getUsuarioLinea().getNumeroIdentificacion());
		nuevoUsuario.setOcupacion(datosGeneralesVenta.getUsuarioLinea().getOcupacion());
		nuevoUsuario.setPrimerApellido(datosGeneralesVenta.getUsuarioLinea().getPrimerApellido());
		nuevoUsuario.setSegundoApellido(datosGeneralesVenta.getUsuarioLinea().getSegundoApellido());
		nuevoUsuario.setTipIdentificacion(datosGeneralesVenta.getUsuarioLinea().getTipIdentificacion());
		nuevoUsuario.setCodDireccion(datosGeneralesVenta.getUsuarioLinea().getCodDireccion());	
		
		

		if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.postpago")) || planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.hibrido"))){
			nuevoUsuario.setTipUsuario("POS");
		}else{
			nuevoUsuario.setTipUsuario("PRE");
		}
		//clienteCom

		nuevoUsuario.setNumeroAboando(String.valueOf(abonado.getNumAbonado()));
		nuevoUsuario=BOUsuario.creaNuevoUsuario(nuevoUsuario);

		if (nuevoUsuario.getTipUsuario().equalsIgnoreCase("POS")){			
			BOUsuario.insDireccionUsuario(nuevoUsuario);
		}	

		logger.debug("Fin:creacionUsuario()");

		return nuevoUsuario; 
	}	

	public AbonadoDTO getSecuenciaAbonado()throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:getSecuenciaAbonado()");
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setCodigoSecuencia(config.getString("secuencia.abonado"));
		abonado = BOAbonado.getSecuenciaAbonado(abonado);
		logger.debug("Fin:getSecuenciaAbonado()");
		return abonado;
	}	

	public RegistroVentaDTO getPrefijoMin(RegistroVentaDTO entrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:getPrefijoMin()");
		RegistroVentaDTO resultado = null;
		resultado = BORegistroVenta.getPrefijoMin(entrada);
		logger.debug("Fin:getPrefijoMin()");
		return resultado;
	}	

	public void creaSSAbonado(ServicioSuplementarioDTO entrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:creaSSAbonado()");
		BOServicioSuplementario.creaSSAbonado(entrada);
		logger.debug("Fin:creaSSAbonado()");
	}//fin creaSSAbonado	

		
	public void creaAbonadoCDMA(AbonadoDTO entrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:creaAbonadoCDMA()");
		BOAbonado.creaAbonadoCDMA(entrada);
		logger.debug("Fin:creaAbonadoCDMA()");

	}
	
	public void creaAbonado(AbonadoDTO entrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:creaAbonado()");
		BOAbonado.creaAbonado(entrada);
		logger.debug("Fin:creaAbonado()");

	}

	public void creaSimcardAboser(AbonadoDTO entrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:creaSimcardAboser()");
		BOAbonado.creaSimcardAboser(entrada);
		logger.debug("Fin:creaSimcardAboser()");
	}

	public void creaTerminalAboser(AbonadoDTO entrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:creaTerminalAboser()");
		BOAbonado.creaTerminalAboser(entrada);
		logger.debug("Fin:creaTerminalAboser()");
	}	

	public void registraCampanaVigente(CampanaVigenteDTO entrada) 
	throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));		
		logger.debug("registraCampanaVigente():start");
		BOCampanaVigente.registraCampanaVigente(entrada);
		logger.debug("registraCampanaVigente():end");
	}//fin registraCampanaVigente


	/**
	 * setDesMarcaAbonadoPortado
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */	
	public OutAbonadoPortadoDTO setDesMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		OutAbonadoPortadoDTO retValue=null;
		try{
			logger.debug("Inicio:setDesMarcaAbonadoPortado()");
			retValue=BOAbonado.setDesMarcaAbonadoPortado(abonadoPortadoDTO);
			logger.debug("Fin:setDesMarcaAbonadoPortado()");
		}catch(GeneralException e){
			logger.debug("Error: General Exception");
			throw(e);
		}catch (Exception e){
			logger.debug("Exception setDesMarcaAbonadoPortado");
			throw new GeneralException(e);
		}
		return retValue;
	}


	/**
	 * setMarcaAbonadoPortado
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */	
	public OutAbonadoPortadoDTO setMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		OutAbonadoPortadoDTO retValue=null;
		try{
			logger.debug("Inicio:setMarcaAbonadoPortado()");
			retValue=BOAbonado.setMarcaAbonadoPortado(abonadoPortadoDTO);
			logger.debug("Fin:setMarcaAbonadoPortado()");
		}catch(GeneralException e){
			logger.debug("Error: General Exception");
			throw(e);
		}
		return retValue;
	}

	public WsNumeroSerieOutDTO getInformacionBodegaArticuloSerie(WsNumeroSerieInDTO wsNumeroSerieInDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		WsNumeroSerieOutDTO retValue=null;
		try{
			logger.debug("Inicio:getInformacionBodegaArticuloSerie()");
			retValue=BODatosGenerales.getInformacionBodegaArticuloSerie(wsNumeroSerieInDTO);
			logger.debug("Fin:getInformacionBodegaArticuloSerie()");
		}catch(GeneralException e){
			logger.debug("Error: General Exception");
			throw(e);
		}
		return retValue;
	}

	public RetornoDTO getPreActivaAbonado(AbonadoDTO inWSPreActivaAbonadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		//RSIS 001
		RetornoDTO retValue=new RetornoDTO();
		try{
			logger.debug("SpnSclWSBean: preactivaAbonado:start");
			retValue=BOAbonado.getPreActivaAbonado(inWSPreActivaAbonadoDTO);
			logger.debug("SpnSclWSBean: preactivaAbonado:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			retValue.setMensajseError(e.getDescripcionEvento());
			retValue.setCodError(e.getCodigo());
			//throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public RetornoDTO getAperturaRango (AperturaRangoDTO aperturaRangoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		RetornoDTO retValue=new RetornoDTO();
		try{
			logger.debug("SpnSclWSBean: preactivaAbonado:start");
			retValue=BOAbonado.getAperturaRango(aperturaRangoDTO);
			logger.debug("SpnSclWSBean: preactivaAbonado:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsInformacionLineaOutDTO getInformacionLinea(WsInformacionLineaInDTO wsInformacionLineaInDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		WsInformacionLineaOutDTO retValue=new WsInformacionLineaOutDTO();
		try{
			logger.debug("Inicio: getInformacionLinea:start");
			retValue=BOAbonado.getInformacionLinea(wsInformacionLineaInDTO);
			logger.debug("Fin: getInformacionLinea:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public AbonadoDTO getAbonadoPorNumCelular(AbonadoDTO abonadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		AbonadoDTO retValue=null;
		try{
			logger.debug("Inicio: getAbonadoPorNumCelular:start");
			retValue=BOAbonado.getAbonadoPorNumCelular(abonadoDTO);
			logger.debug("Fin: getAbonadoPorNumCelular:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public ArticuloDTO setReservaSerie(ArticuloDTO articuloDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("Inicio: setReservaSerie:start");
			BOarticulo.insReservaArticulo(articuloDTO);
			logger.debug("Fin: setReservaSerie:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return articuloDTO;
	}

	public TerminalSNPNDTO getTerminal(TerminalSNPNDTO terminalDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("Inicio: getTerminal:start");
			terminalDTO=BOterminal.getTerminal(terminalDTO);
			logger.debug("Fin: getTerminal:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return terminalDTO;
	}

	public SimcardSNPNDTO getSimcard(SimcardSNPNDTO simcardSNPNDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("Inicio: getTerminal:start");
			simcardSNPNDTO=BOsimcard.getSimcard(simcardSNPNDTO);
			logger.debug("Fin: getTerminal:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return simcardSNPNDTO;
	}

	public ArticuloDTO getArticulo(ArticuloDTO articuloDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("Inicio: getArticulo:start");
			articuloDTO=BOarticulo.getArticulo(articuloDTO);
			logger.debug("Fin: getArticulo:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return articuloDTO;
	}


	public ArticuloDTO setActualizaStock(ArticuloDTO articuloDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));		
		try{
			logger.debug("Inicio: setActualizaStock:start");
			articuloDTO  = BOarticulo.ActualizaStock(articuloDTO);
			logger.debug("Fin: setActualizaStock:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return articuloDTO;
	}

	public RetornoDTO setUpdateAbonadoNumImei(AbonadoDTO abonadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		RetornoDTO retValue=null;
		try{
			logger.debug("Inicio: setUpdateAbonadoNumImei:start");
			retValue=BOAbonado.setUpdateAbonadoNumImei(abonadoDTO);
			logger.debug("Fin: setUpdateAbonadoNumImei:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}	

	public void actualizaEquipAboSer(AbonadoDTO abonadoDTO)throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("actualizaEquipAboSer:start");
			BOAbonado.actualizaEquipAboSer(abonadoDTO);
			logger.debug("actualizaEquipAboSer:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:actualizaEquipAboSer()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}
	
	public void updateAboVendealer(String numAbonado) throws GeneralException{		
		try{
			logger.debug(" updateAboVendealer:start");
			BOAbonado.updateAboVendealer(numAbonado);
			logger.debug(" updateAboVendealer:end");						
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:actualizaEquipAboSer()");
			throw e;		
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);		
		}
	}	

	public void setUpdateGaEquiAboser(GaEquipAboserDTO gaEquipAboserDTO)throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("setUpdateGaEquiAboser:start");
			BOAbonado.setUpdateGaEquiAboser(gaEquipAboserDTO);
			logger.debug("setUpdateGaEquiAboser:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:setUpdateGaEquiAboser()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}

	public GaEquipAboserDTO[] getGaEquipAboser(GaEquipAboserDTO gaEquipAboserDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		GaEquipAboserDTO[] retValue=null;
		try{
			logger.debug("getGaEquipAboser:start");
			retValue = BOAbonado.getGaEquipAboser(gaEquipAboserDTO);
			logger.debug("getGaEquipAboser:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:getGaEquipAboser()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public ArticuloDTO[] getListArticuloPorCodigo(ArticuloDTO articuloDTO)throws GeneralException{
		ArticuloDTO[] retValue=null;

		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("getListArticuloPorCodigo:start");
			retValue = BOarticulo.getListArticuloPorCodigo(articuloDTO);
			logger.debug("getListArticuloPorCodigo:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:getListArticuloPorCodigo()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public ArticuloDTO ActualizaStock(ArticuloDTO articuloDTO)throws GeneralException{
		ArticuloDTO retValue=null;

		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("ActualizaStock:start");
			retValue = BOarticulo.ActualizaStock(articuloDTO);
			logger.debug("ActualizaStock:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException ActualizaStock()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public RetornoDTO  validaImeiGSM(ImeiWSDTO imeiWS) throws GeneralException{    	    	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		RetornoDTO resultado = null;
		try{
			logger.debug("validaImeiGSM:start");
			resultado = BOterminal.validaImeiGSM(imeiWS);
			logger.debug("validaImeiGSM:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException ActualizaStock()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;
	}	


	public ContratoDTO  getTipoContrato(ContratoDTO contrato) throws GeneralException{    	    	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		ContratoDTO resultado = null;
		try{
			logger.debug("getTipoContrato:start");
			resultado = BOContrato.getTipoContrato(contrato);
			logger.debug("getTipoContrato:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException getTipoContrato()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;
	}	



	public SSuplementariosDTO[] getSSincluidosEnPlan(String codigoPlanTarifario) 
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		SSuplementariosDTO[] resultado = null;
		try{
			logger.debug("getSSincluidosEnPlan:start");
			resultado = BOServicioSuplementario.getSSincluidosEnPlan(codigoPlanTarifario);
			logger.debug("getSSincluidosEnPlan:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException getSSincluidosEnPlan()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;
	}			

	public SSuplementariosDTO[] getSSOpcionalesAlPlan(String codigoPlanTarifario, String codigoArticulo, String codigCentral) 
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		SSuplementariosDTO[] resultado = null;
		try{
			logger.debug("getSSOpcionalesAlPlan:start");
			logger.debug("INCIDENCIA 163741 GDO 11-02-2011");
			resultado = BOServicioSuplementario.getSSOpcionalesAlPlan(codigoPlanTarifario, codigoArticulo, codigCentral);
			logger.debug("INCIDENCIA 163741 GDO 11-02-2011");
			logger.debug("getSSOpcionalesAlPlan:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException getSSOpcionalesAlPlan()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;
	}				


	public ValidacionServicioSDTO getValidacionAgregaServicio(SSuplementariosDTO[] sSuplementariosCont, SSuplementariosDTO sSuplementariosVal) 
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		SSuplementariosDTO[] tranferenciaGrupo = null;
		SSuplementariosDTO[] incompatible = null;
		SSuplementariosDTO[] ligadura = null;
		ReglasSSuplementariosDTO[] regal = null;
		ValidacionServicioSDTO retorno = new ValidacionServicioSDTO();
		ArrayList listtranGrupo = new ArrayList();

		try{
			logger.debug("getSSOpcionalesAlPlan:start");

			for (int i=0; i< sSuplementariosCont.length ; i++){					
				if (sSuplementariosCont[i].getCodigoServSupl().equals(sSuplementariosVal.getCodigoServSupl())){
					listtranGrupo.add(sSuplementariosCont[i]);			
				}					
			}

			tranferenciaGrupo =(SSuplementariosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listtranGrupo.toArray(), SSuplementariosDTO.class);



			regal = BOServicioSuplementario.getReglaSSporServicio(sSuplementariosVal.getCodigoServicio());

			int var = 0;
			for (int j=0; j<regal.length; j++){
				for(int k=0; k< sSuplementariosCont.length; k++){
					if (sSuplementariosCont[k].getCodigoServicio() == regal[j].getCodigoServicioDef() &&  regal[j].getTiporelacion().equals("3") ){
						SSuplementariosDTO incom = new SSuplementariosDTO();
						incom.setCodigoServicio(regal[j].getCodigoServicioDef());
						incompatible[0+var] = incom;
						var = var + 1;
					}
				}
			}

			for (int j=0; j<regal.length; j++){
				if (regal[j].getTiporelacion().equals("1")){
					SSuplementariosDTO lig = new SSuplementariosDTO();
					lig.setCodigoServicio(regal[j].getCodigoServicioDef());
					ligadura[j] = lig;

				}
			}
			if (incompatible != null){
				retorno.setIncompatible(incompatible);
			}
			if (ligadura != null){
				retorno.setLigadura(ligadura);
			}
			if (tranferenciaGrupo != null){
				retorno.setTrnferenicas(tranferenciaGrupo);
			}

			logger.debug("getSSOpcionalesAlPlan:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException getSSOpcionalesAlPlan()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retorno;			
	}						


	public ValidacionServicioSDTO getValidacionEliminaServicio(SSuplementariosDTO[] sSuplementariosCont, SSuplementariosDTO sSuplementariosVal) 
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		SSuplementariosDTO[] trnaferencias = null;
		ReglasSSuplementariosDTO[] regal = null;
		ValidacionServicioSDTO retorno = new ValidacionServicioSDTO();

		try{
			logger.debug("getSSOpcionalesAlPlan:start");

			regal = BOServicioSuplementario.getReglaSSporServicio(sSuplementariosVal.getCodigoServicio());				

			for (int j=0; j<regal.length; j++){
				if (regal[j].getTiporelacion().equals("2")){
					SSuplementariosDTO trnaferencia = new SSuplementariosDTO();
					trnaferencia.setCodigoServicio(regal[j].getCodigoServicioDef());
					trnaferencias[j] = trnaferencia;						
				}
			}

			if (trnaferencias != null){
				retorno.setTrnferenicas(trnaferencias);
			}				
			logger.debug("getSSOpcionalesAlPlan:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException getSSOpcionalesAlPlan()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retorno;			
	}		

	public void setAgregaSS(AbonadoDTO abonado, WsAgregaEliminaSSInDTO[] sSuplementarios)  
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("setAgregaSS:start");
			BOServicioSuplementario.setAgregaSS(abonado, sSuplementarios);
			logger.debug("setAgregaSS:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			logger.debug("Fin:GeneralException setAgregaSS()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}			
	}	
	
	public String getSerieHexa(TerminalSNPNDTO TerminalSNPNDTO) 
	throws GeneralException{	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:validaImeiGSM()");
		String resultado =  BOterminal.getSerieHexa(TerminalSNPNDTO);
		logger.debug("Fin:validaImeiGSM()");
		return resultado;
	}	

	public void setEliminarSS(AbonadoDTO abonado, WsAgregaEliminaSSInDTO[] sSuplementarios) 
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("setEliminarSS:start");
			BOServicioSuplementario.setEliminarSS(abonado, sSuplementarios);
			logger.debug("setEliminarSS:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			logger.debug("Fin:GeneralException setEliminarSS()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}			


	public ArticuloDTO reservaSerie(ArticuloDTO articuloDTO) 
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{

			SerieDTO serie2 = new SerieDTO();
			serie2.setNumSerie(articuloDTO.getNumeroSerie());
			serie2.setNomUsuario(articuloDTO.getNombreUsuario());
			serie2.setNumPorceso(articuloDTO.getNumeroVenta());		

			serie2 = BOSerie.reservaSerie(serie2);

			articuloDTO.setNumeroMovimiento(serie2.getNumMovimiento());

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException setEliminarSS()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}

		return articuloDTO;
	}	

	public WSPlanTarifarioOutDTO getPlanTarifarioImporteImpuesto(WSPlanTarifarioInDTO entrada)
	throws GeneralException
	{	    	
		WSPlanTarifarioOutDTO resultado = null;
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("getPlanTarifarioImporteImpuesto:start");
			resultado = BOplanTarifario.getPlanTarifarioImporteImpuesto(entrada);
			logger.debug("getPlanTarifarioImporteImpuesto:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException getPlanTarifarioImporteImpuesto()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;
	}


	public CargosSimcarPrepagoDTO[] getCargosSimcardPrepago() 
	throws GeneralException{	   	
		CargosSimcarPrepagoDTO[] resultado = null;
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("getCargosSimcardPrepago:start");
			resultado = BOsimcard.getCargosSimcardPrepago();
			logger.debug("getCargosSimcardPrepago:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException getCargosSimcardPrepago()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;
	}	


	/**
	 * Obtiene las reglas de compatibilidad de los servicios suplementarios.
	 * @return
	 * @throws GeneralException
	 */
	public ReglaCompatibilidadSSDTO[] getReglasCompatibilidadSS() 
	throws GeneralException{
		ReglaCompatibilidadSSDTO[] reglaCompatibilidadSSDTOs = null;
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("getReglasCompatibilidadSS:start");
			reglaCompatibilidadSSDTOs = BOServicioSuplementario.getReglasCompatibilidadSS();
			logger.debug("getReglasCompatibilidadSS:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException getReglasCompatibilidadSS()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return reglaCompatibilidadSSDTOs;	
	}

	/**
	 * Solicita la baja de un abonado
	 * @param solicitudBajaAbonadoDTO
	 * @throws GeneralException
	 */
	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonado(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();
		ParamRestriccionDTO paramRestriccion = new ParamRestriccionDTO();
		try{
			logger.debug("solicitaBajaAbonado:start");
			
			RegistroVentaDTO parametroEntrada = new RegistroVentaDTO();
			parametroEntrada.setCodigoSecuencia(config.getString("secuencia.transacabo"));
			parametroEntrada = BORegistroVenta.getSecuenciaTransacabo(parametroEntrada);
			
			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNumCelular(new Long(solicitudBajaAbonadoDTO.getNumCelular()).longValue());
			
			abonado = getAbonadoPorNumCelular(abonado);
			
			paramRestriccion.setPrograma("GBB");
            paramRestriccion.setVersion("1.0");
            paramRestriccion.setActuacion("BA");
            paramRestriccion.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
            paramRestriccion.setCodCliente(String.valueOf(abonado.getCodCliente()));
            paramRestriccion.setCodModGener("ACF");           
            paramRestriccion.setCodOOSS("10232");            
            paramRestriccion.setCodVendedor(solicitudBajaAbonadoDTO.getCodVendedor());                     
            paramRestriccion.setCodCiclo(String.valueOf(abonado.getCodCiclo()));                                           
            paramRestriccion.setCodModulo("GA");
            Date fechaactual = new Date();                       
            paramRestriccion.setFechaSistema(Formatting.dateTime(fechaactual, "dd/MM/yyyy"));
			
			String Param = getGeneraParamRestricc(paramRestriccion);
			RestriccionDTO restriccion = new RestriccionDTO();
			restriccion.setActuacion("BA");
			restriccion.setEvento("FORMLOAD");
			restriccion.setModulo("GA");
			restriccion.setParam_entrada(Param);
			restriccion.setProducto("1");
			restriccion.setSecuencia(String.valueOf(parametroEntrada.getNumeroTransaccionVenta()));
			
			BOAbonado.ejecutarRestriccion(restriccion);
			
			DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setNumTransaccion(String.valueOf(parametroEntrada.getNumeroTransaccionVenta()));
								
			datosGenerales = DatosGeneralesBO.getResultadoTransaccion(datosGenerales);
			
			
			if (datosGenerales.getCodError() != 0){
				throw new GeneralException(String.valueOf(datosGenerales.getCodError()),0,datosGenerales.getMnsError());
			}
			
			solicitaBajaAbonadoOut=BOAbonado.solicitaBajaAbonado(solicitudBajaAbonadoDTO, abonado);
			logger.debug("solicitaBajaAbonado:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException solicitaBajaAbonado()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		return solicitaBajaAbonadoOut;
	}

	/**
	 * Solicita la baja de un abonado Prepago
	 * @param solicitudBajaAbonadoDTO
	 * @throws GeneralException
	 */
	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoPrepago(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();
		try{
			logger.debug("solicitaBajaAbonado:start");
			
			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNumCelular(new Long(solicitudBajaAbonadoDTO.getNumCelular()).longValue());
			
			abonado = getAbonadoPorNumCelular(abonado);
			
			solicitaBajaAbonadoOut=BOAbonado.solicitaBajaAbonadoPrepago(solicitudBajaAbonadoDTO, abonado);
			logger.debug("solicitaBajaAbonado:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException solicitaBajaAbonado()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		return solicitaBajaAbonadoOut;
	}		

	/**
	 * Solicita la baja de un abonado Prepago
	 * @param solicitudBajaAbonadoDTO
	 * @throws GeneralException
	 */
	public ReservaOutDTO solicitaReserva(ReservaDTO solicitaReservaDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		ReservaOutDTO solicitaReservaOutDTO = new ReservaOutDTO();
		try{
			logger.debug("solicitaReserva:start");
			solicitaReservaOutDTO=BOAbonado.solicitaReserva(solicitaReservaDTO);
			logger.debug("solicitaReserva:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException solicitaBajaAbonado()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		return solicitaReservaOutDTO;
	}

	/**
	 * Solicita la baja de un abonado Prepago
	 * @param solicitudBajaAbonadoDTO
	 * @throws GeneralException
	 */
	public ReservaOutDTO solicitaDesreserva(ReservaDTO solicitaReservaDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		ReservaOutDTO solicitaReservaOutDTO = new ReservaOutDTO();
		try{
			logger.debug("solicitaReserva:start");
			solicitaReservaOutDTO=BOAbonado.solicitaDesreserva(solicitaReservaDTO);
			logger.debug("solicitaReserva:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException solicitaBajaAbonado()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		return solicitaReservaOutDTO;
	}



	public void ActualizaSituacionAbonado(GaVentasDTO gaVentasDTO, String codigoSituacion)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:ActualizaSituacionAbonado()");
		BOAbonado.ActualizaSituacionAbonado(gaVentasDTO,codigoSituacion);
		logger.debug("Fin:ActualizaSituacionAbonado()");
	}


	/**
	 * Valida que el servicio suplementario que se quiera agregar no lo tenga el abonado
	 * @param 
	 * @throws GeneralException
	 */
	public void validaExisteSSAbondo(WsAgregaEliminaSSInDTO[] sSuplemenAgregar, WsAgregaEliminaSSInDTO[] sSuplemenEliminar, long numAbonado)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		ExisteSSAbonadoDTO existeSSAbonadoDTO = new ExisteSSAbonadoDTO();
		try{
			logger.debug("validaExisteSSAbondo:start");
			for (int i=0;i<sSuplemenAgregar.length;i++){
				existeSSAbonadoDTO.setCodigoServicio(sSuplemenAgregar[i].getCodigoServicio());
				existeSSAbonadoDTO.setCodigoServSupl(sSuplemenAgregar[i].getCodigoServSupl());
				existeSSAbonadoDTO.setNumAbonado(numAbonado);

				existeSSAbonadoDTO = BOServicioSuplementario.validaExisteSSAbondo(existeSSAbonadoDTO);

				boolean seElimina = false;
				if (existeSSAbonadoDTO.getCodigoError().longValue() == 10620 || existeSSAbonadoDTO.getCodigoError().longValue() == 10621){
					for (int j=0;j<sSuplemenEliminar.length;j++){
						if (	existeSSAbonadoDTO.getCodigoServicio().equalsIgnoreCase(sSuplemenEliminar[j].getCodigoServicio()) ||
								existeSSAbonadoDTO.getCodigoServSupl().equalsIgnoreCase(sSuplemenEliminar[j].getCodigoServSupl())
						){
							seElimina = true;
							break;
						}
					}
					if (!seElimina){
						logger.debug(existeSSAbonadoDTO.getCodigoError() + " " + existeSSAbonadoDTO.getDescripcionError());
						throw new GeneralException(String.valueOf(existeSSAbonadoDTO.getCodigoError()),existeSSAbonadoDTO.getNumeroEvento().longValue(),existeSSAbonadoDTO.getDescripcionError()+", servicio con problemas ["+existeSSAbonadoDTO.getCodigoServicio()+"]");
					}
				}
			}
			logger.debug("validaExisteSSAbondo:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Fin:GeneralException validaExisteSSAbondo()");
			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
	}


	public DatosGeneralesVentaDTO creacionLineasGrupoCDMA(DatosGeneralesVentaDTO datosGeneralesVenta)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));		
		logger.debug("Inicio:creacionLineas()");
		DatosGeneralesVentaDTO resultado = datosGeneralesVenta;
		resultado.setEstadoError("OK");
		resultado.setDetalleError("-");

		String sNumeroMovtoSerieTerminal = null;

		Date fecha = new Date();




		AbonadoDTO abonadoAux = new AbonadoDTO();
		ServicioSuplementarioDTO servicioSuplementario = new ServicioSuplementarioDTO();
		UsuarioDTO usuario=new UsuarioDTO();
		ClienteDTO cliente = new ClienteDTO();
		AbonadoDTO abonado = new AbonadoDTO();
		CuentaDTO subCuenta = new CuentaDTO();					
		TerminalSNPNDTO terminal = new TerminalSNPNDTO();
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		VendedorDTO vendedor = new VendedorDTO();
		ArticuloDTO articulo = new ArticuloDTO();
		String usoLinea =null;

		String lst_tipoTerminal =datosGeneralesVenta.getTipoTerminal();

		//-- BUSCAR TERMINAL
		terminal.setNumeroSerie(datosGeneralesVenta.getNumeroSerieTerminal());
		terminal = BOterminal.getTerminal(terminal);
		
		
		
		if (terminal.getIndProcEq().equals("E")){
			terminal.setEstado("1");
			datosGeneralesVenta.setEstadoSerieTerminal("1");
			terminal.setCodigoBodega("");
			terminal.setCapCode("");
			lst_tipoTerminal = "D";
		}else{
			
			articulo.setCodigo(Long.parseLong(terminal.getCodigoArticulo()));
			articulo = BOarticulo.getArticulo(articulo);
			lst_tipoTerminal = articulo.getTipTerminal() ;
		}

		

		//-- BUSCAR PLAN TARIFARIO
		planTarifario.setCodigoPlanTarifario(datosGeneralesVenta.getCodigoPlanTarifario());
		planTarifario.setCodigoProducto(config.getString("codigo.producto"));
		planTarifario.setCodigoTecnologia(datosGeneralesVenta.getCodigoTecnologia());
		planTarifario = BOplanTarifario.getPlanTarifario(planTarifario);

		if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.postpago"))){
			usoLinea =  config.getString("codigo.uso.postpago");
		}else if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.hibrido"))){
			usoLinea =  config.getString("codigo.uso.hibrido");
		}else if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.prepago"))){
			usoLinea =  config.getString("codigo.uso.prepago");
		}else{
			logger.debug("Error en el uso de la linea");
			throw new GeneralException("12412",0,"Error en el uso de la linea");
		}
		//RESERVA SERIE SIMCARD
		
		logger.debug("terminal.getEstado() ["+terminal.getEstado()+"]");
		logger.debug("datosGeneralesVenta.getEstadoSerieTerminal() ["+datosGeneralesVenta.getEstadoSerieTerminal()+"]");
		if(terminal.getEstado().equals(datosGeneralesVenta.getEstadoSerieTerminal()))
		{				



			logger.debug("TERMINAL:RESERVA DEL ARTICULO");
			//-- RESERVA DEL ARTICULO
			if(terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){
				articulo.setNumeroTransaccion(datosGeneralesVenta.getNumeroTransaccionVenta());
				articulo.setNumeroLinea(datosGeneralesVenta.getCorrelativoLinea());
				articulo.setNumeroOrden(datosGeneralesVenta.getNumeroOrden()+1);
				articulo.setCodigo(Long.parseLong(terminal.getCodigoArticulo()));
				articulo.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto")));
				articulo.setCodigoBodega(Integer.parseInt(terminal.getCodigoBodega()));
				articulo.setTipoStock(Integer.parseInt(terminal.getTipoStock()));
				articulo.setCodigoUso(Integer.parseInt(terminal.getCodigoUso()));
				articulo.setCodigoEstado(Integer.parseInt(terminal.getEstado()));
				articulo.setNombreUsuario(datosGeneralesVenta.getNombreUsuarioOracle());//???
				articulo.setNumeroSerie(terminal.getNumeroSerie());
			}
			try {
				if(terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){
					BOarticulo.insReservaArticulo(articulo);
					logger.debug("TERMINAL:ACTUALIZA STOCK");
					//-- ACTUALIZA STOCK  
					articulo.setTipoMovimiento(config.getString("tipo.movto.resventa"));
					articulo.setTipoStock(Integer.parseInt(terminal.getTipoStock()));
					articulo.setCodigoBodega(Integer.parseInt(terminal.getCodigoBodega()));
					articulo.setCodigo(Long.parseLong(terminal.getCodigoArticulo()));
					articulo.setCodigoUso(Integer.parseInt(terminal.getCodigoUso()));
					articulo.setCodigoEstado(Integer.parseInt(terminal.getEstado()));
					articulo.setNumeroVenta(datosGeneralesVenta.getNumeroVenta());
					articulo.setNumeroSerie(terminal.getNumeroSerie());
				}
				try {
					if(terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){																																	    
						SerieDTO serie2 = new SerieDTO();
						serie2.setNumSerie(articulo.getNumeroSerie());
						serie2.setNomUsuario(datosGeneralesVenta.getNombreUsuarioOracle());
						serie2.setNumPorceso(String.valueOf(datosGeneralesVenta.getNumeroVenta()));					
						serie2 = BOSerie.reservaSerie(serie2);											    												    												    	
						sNumeroMovtoSerieTerminal = serie2.getNumMovimiento();

					}
					//-- BUSCA CLIENTE
					cliente.setCodigoCliente(datosGeneralesVenta.getCodigoCliente());
					cliente = BOCliente.getCliente(cliente);

					//-- BUSCA OFICINA PRINCIPAL VENDEDOR
					vendedor.setCodigoVendedor(datosGeneralesVenta.getCodigoVendedor());
					vendedor.setCodigoVendedorDealer(Long.parseLong(datosGeneralesVenta.getCodigoVendedorDealer()));
					vendedor = getVendedor(vendedor);
					abonadoAux = getOficinaPrincipal(vendedor);

					//-- BUSCA SUBCUENTA

					if (planTarifario.getCodigoTipoPlan().equals(config.getString("tipo.plan.prepago"))){
						cliente.setCodigoSubCuenta("");										 
					}else{
						subCuenta.setCodigoCuenta(cliente.getCodigoCuenta());
						subCuenta = getSubCuenta(subCuenta);
						cliente.setCodigoSubCuenta(subCuenta.getCodigoSubCuenta());
					}


					String sEstadoError = "OK";
					String sDetalleError = "-";
					//-- CREAR USUARIO
					try{
						//P-ECU-08019 --> Valida si existe usuario en caso contrario lo crea

						
						abonado = getSecuenciaAbonado();


						resultado.setNumeroAbonado(String.valueOf(abonado.getNumAbonado()));

						UsuarioDTO nuevoUsuario=new UsuarioDTO();
						nuevoUsuario=BOUsuario.getSecuenciaUsuario();
						if ( !planTarifario.getCodigoTipoPlan().equals("1") ){										
							usuario=creacionUsuario(cliente,planTarifario,datosGeneralesVenta, abonado,nuevoUsuario );									   	    
							if (usuario.getExitoCreacionUusario()==false){
								sEstadoError = "NOK";
								sDetalleError = "Ocurrio un error al crear el Usuario";
								throw new GeneralException("12413",0,"Ocurrio un error al crear el Usuario");
							}
						}else{
							usuario.setCodigoUsuario("0");
						}

						//-- OBTIENE SECUENCIA-NUMERO ABONADO
						sEstadoError = "NOK";
						sDetalleError = "Ocurrio un error al crear el Abonado";
						abonado = getSecuenciaAbonado();

						abonado.setFecAlta(datosGeneralesVenta.getFechaActual());

						abonado.setNumCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
						abonado.setCodProducto(Integer.parseInt(config.getString("codigo.producto")));
						abonado.setCodCliente(Long.parseLong(cliente.getCodigoCliente()));
						abonado.setCodCuenta(Long.parseLong(cliente.getCodigoCuenta()));
						abonado.setCodSubCuenta(cliente.getCodigoSubCuenta());
						abonado.setCodUsuario(Long.parseLong(nuevoUsuario.getCodigoUsuario()));
						abonado.setCodRegion(datosGeneralesVenta.getCodigoRegion());
						abonado.setCodProvincia(datosGeneralesVenta.getCodigoProvincia());
						abonado.setCodCiudad(datosGeneralesVenta.getCodigoCiudad());

						abonado.setNumSerieSimcard(terminal.getNumeroSerie());														

						abonado.setCodBodegaTerminal(terminal.getCodigoBodega());
						abonado.setCapcodeTerminal(terminal.getCapCode());
						if (terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){
							abonado.setTipoStockTerminal(Long.parseLong(terminal.getTipoStock()));
							abonado.setCodigoArticuloTerminal(terminal.getCodigoArticulo());
							abonado.setDesArticuloTerminal(terminal.getDescripcionArticulo());
							abonado.setCodUsoTerminal(Integer.parseInt(terminal.getCodigoUso()));
							abonado.setCodEstadoTerminal(terminal.getEstado());
						}
						else{
							ParametrosGeneralesDTO parametroTerminal = new ParametrosGeneralesDTO();

							/*--Busca Código Articulo por defecto asignado a equipos externos--*/
							parametroTerminal.setCodigomodulo(config.getString("codigo.modulo.GA"));
							parametroTerminal.setCodigoproducto(config.getString("codigo.producto"));


							articulo.setCodigo(Long.parseLong(config.getString("parametro.articulo.terminal.externo")));
							articulo = BOarticulo.getArticulo(articulo);

							abonado.setCodigoArticuloTerminal(String.valueOf(articulo.getCodigo()));
							abonado.setDesArticuloTerminal(articulo.getDescripcion());

							if (planTarifario.getCodigoTipoPlan().equals(datosGeneralesVenta.getTipoPlanPostpago())){
								abonado.setCodUsoTerminal(Integer.parseInt(config.getString("parametro.usoVentaPostpago")));
							}else{
								abonado.setCodUsoTerminal(Integer.parseInt(config.getString("parametro.usoVentaHibrido")));
							}

							

						}
						abonado.setNumImei("");
						abonado.setIndProcEqTerminal(terminal.getIndProcEq());
						abonado.setTipPlantarif(planTarifario.getTipoPlanTarifario());
						abonado.setCodCargoBasico(planTarifario.getCodigoCargoBasico());
						abonado.setCodPlanServ(planTarifario.getCodigoPlanServicio());
						
						if (datosGeneralesVenta.getIdentificadorEmpresa().equals(config.getString("identificador.empresa"))){																	
							String limConClieEmp = BOCliente.getLimConsClieEmpresa(datosGeneralesVenta.getCodigoCliente());
							
							if (!limConClieEmp.equals("")){
								abonado.setCodLimConsumo(limConClieEmp);
							}else{
								abonado.setCodLimConsumo(planTarifario.getCodigoLimiteConsumo());
							}								    
						}else{
							abonado.setCodLimConsumo(planTarifario.getCodigoLimiteConsumo());
						}
						
						abonado.setCodigoTipoPlan(planTarifario.getCodigoTipoPlan());				

						abonado.setCodCelda(datosGeneralesVenta.getCodigoCelda());  
						abonado.setCodCentral(Integer.parseInt(datosGeneralesVenta.getCodigoCentral()));
						abonado.setCodSituacion(config.getString("codigo.situacion"));
						abonado.setIndProcAlta(config.getString("indice.procalta"));
						abonado.setIndProcEqSimcard(config.getString("indicador.procedencia.equipo.simcard"));
						abonado.setCodVendedor(Long.parseLong(datosGeneralesVenta.getCodigoVendedor()));
						abonado.setCodVendedorAgente(Long.parseLong(datosGeneralesVenta.getCodigoVendedorRaiz()));
						abonado.setTipTerminal(lst_tipoTerminal);
						abonado.setCodPlanTarif(datosGeneralesVenta.getCodigoPlanTarifario());
						abonado.setNumSerieHex(getSerieHexa(terminal) );
						abonado.setNomUsuarOra(datosGeneralesVenta.getNombreUsuarioOracle());
						abonado.setNumPerContrato(Integer.parseInt(datosGeneralesVenta.getNumeroPerContrato()));
						abonado.setCodigoEstado(datosGeneralesVenta.getCodigoEstado());
						abonado.setNumSerieMec(null);
						if (datosGeneralesVenta.getIdentificadorEmpresa().equals(config.getString("identificador.empresa")))
							abonado.setCodEmpresa(cliente.getCodigoEmpresa());

						abonado.setIndSuperTel(Integer.parseInt(config.getString("indicador.supertelefono")));
						abonado.setNumTeleFija(null);
						abonado.setIndPrepago(Integer.parseInt(config.getString("indicador.prepago")));
						abonado.setIndPlexSys(Integer.parseInt(config.getString("indicador.plexsys")));
						abonado.setNumVenta(Long.parseLong(datosGeneralesVenta.getNumeroVenta()));
						abonado.setCodModVenta(Long.parseLong(datosGeneralesVenta.getCodigoModalidadVenta()));
						abonado.setCodTipContrato(datosGeneralesVenta.getCodigoTipoContrato());
						abonado.setNumContrato(datosGeneralesVenta.getNumeroContrato());
						abonado.setNumAnexo(null);

						ContratoDTO contrato1 = new ContratoDTO();

						contrato1.setCodigoTipoContrato(datosGeneralesVenta.getCodigoTipoContrato());
						contrato1 = BOContrato.getTipcontrato(contrato1);

						Calendar cal = new GregorianCalendar(); 
						cal.setTimeInMillis(fecha.getTime()); 
						cal.add(Calendar.MONTH, contrato1.getNumeroMeses());

						Date fechaFinContrato = new Date(cal.getTimeInMillis()); 

						String fechaFinContratoFormateada = Formatting.dateTime(fechaFinContrato,"dd/MM/yyyy HH:mm:ss");
						cal = new GregorianCalendar(); 
						cal.setTimeInMillis(fecha.getTime()); 
						cal.add(Calendar.DATE,planTarifario.getNumDias()); 
						Date fechaFecCumpPlan = new Date(cal.getTimeInMillis()); 
						String fechaFecCumpPlanFormateada = Formatting.dateTime(fechaFecCumpPlan,"dd/MM/yyyy HH:mm:ss");
						abonado.setFecCumPlan(fechaFecCumpPlanFormateada);
						abonado.setCodCredMor(datosGeneralesVenta.getCodigoCreditoMorosidad());
						abonado.setCodCredCon(datosGeneralesVenta.getCodigoCreditoConsumo());
						abonado.setCodCiclo(cliente.getCodigoCiclo());
						abonado.setCodFactur(Integer.parseInt(datosGeneralesVenta.getIndicadorFacturable()));
						abonado.setIndSuspen(Integer.parseInt(config.getString("indicador.ind_suspen")));
						abonado.setIndReHabi(Integer.parseInt(config.getString("indicador.ind_rehabi")));
						abonado.setInsGuias(Integer.parseInt(config.getString("indicador.ind_insguias")));
						abonado.setFecFinContra(fechaFinContratoFormateada);
						abonado.setFecRecDocu(datosGeneralesVenta.getFechaActual());	//Valor por defecto null.... Se asigna fecha actual
						abonado.setFecCumplimen(datosGeneralesVenta.getFechaActual());	//Valor por defecto null.... Se asigna fecha actual
						abonado.setFecAcepVenta(null);	//Valor por defecto null.... Se asigna fecha actual
						abonado.setFecActCen(null);		//Valor por defecto null.... Se asigna fecha actual
						abonado.setFecBaja(null);		//Valor por defecto null.... Se asigna fecha actual
						abonado.setFecBajaCen(null);	//Valor por defecto null.... Se asigna fecha actual
						abonado.setFecUltMod(datosGeneralesVenta.getFechaActual());
						abonado.setCodCausaBaja(null);//Valor por defecto null no utilizada en VB
						abonado.setNumPersonal(null); //Valor por defecto null no utilizada en VB
						abonado.setIndSeguro(Integer.parseInt(config.getString("indicador.ind_seguro")));
						abonado.setClaseServicio(null);//Valor por defecto null no utilizada en VB
						abonado.setPerfilAbonado(null);
						/*Obtiene prefijo min y min mdn*/
						RegistroVentaDTO registroVenta = new RegistroVentaDTO();
						registroVenta.setNumeroCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
						registroVenta = getPrefijoMin(registroVenta);
						if (registroVenta != null)
							abonado.setNumMin(registroVenta.getPrefijoMin());// Se Obtiene de procedimineto AL_FN_PREFIJO_NUMERO(celular parametro)
						if (registroVenta == null){
							registroVenta = new RegistroVentaDTO();
							registroVenta.setNumeroCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
						}
						registroVenta = BORegistroVenta.getMinMDN(registroVenta);
						abonado.setNumMinMdn(registroVenta.getMinMDN());// Se Obtiene de procedimineto AL_FN_PREFIJO_NUMERO(celular parametro)

						abonado.setCodVendealer(Long.parseLong(datosGeneralesVenta.getCodigoVendedorDealer()));
						abonado.setIndPassword(null);	//nulo por defecto
						abonado.setCodAfinidad(datosGeneralesVenta.getCodigoGrupoAfinidad());
						abonado.setFecProrroga(null);

						ContratoDTO contrato = new ContratoDTO();
						contrato.setCodigoProducto(1);
						contrato.setCodigoTipoContrato(datosGeneralesVenta.getCodigoTipoContrato());
						BOContrato.getTipoContrato(contrato);

						abonado.setIndEqPrestadoTerminal( String.valueOf(contrato.getIndComodato()));
						abonado.setIndEqPrestadoSimcard(String.valueOf(contrato.getIndComodato()));
						abonado.setFlgContDigi(null);	//Valor por defecto null, no es llenado en VB
						abonado.setFecAltanTras(null); 	//Valor por defecto null, no es llenado en VB
						abonado.setCodIndemnizacion(Integer.parseInt(datosGeneralesVenta.getCodigoPlanIndemnizacion()));
						abonado.setNumImei("");
						abonado.setCodTecnologia(datosGeneralesVenta.getCodigoTecnologia());
						abonado.setFecActivacion(null);	//Valor por defecto null, no es llenado en VB
						abonado.setCodOficinaPrincipal(abonadoAux.getCodOficinaPrincipal());
						
						//CSR-11002
						abonado.setCodPrestacion(datosGeneralesVenta.getCodPrestacion());
						logger.debug("Set código de prestación: " + datosGeneralesVenta.getCodPrestacion());
						//fin CSR-11002
						
						//if (datosGeneralesVenta.getCodigoCausaDescuento()!=null){ modificacion proceso de facturacion
						//abonado.setCodCausaVenta(datosGeneralesVenta.getCodigoCausaDescuento()); modificacion proceso de facturacion
						if ( planTarifario.getCodigoTipoPlan().equals("1")){
							abonado.setCodOperacion(config.getString("codigo.operacion.prepago"));	
							abonado.setCodGrpSrv("");
						}else{
							abonado.setCodOperacion(config.getString("codigo.operacion"));
							abonado.setCodGrpSrv(datosGeneralesVenta.getCodigoGrupoServicio());

						}
						//} modificacion proceso de facturacion

						if (!(datosGeneralesVenta.getCodigoOperador()==null)){

							TerminalSNPNDTO Terval = new TerminalSNPNDTO();
							Terval.setNumeroCelular(String.valueOf(abonado.getNumCelular()));
							String tipter = BOterminal.validaRangoTerminal(Terval);

							if (tipter.equals("E")){
								/* CSR-11002
								 * abonado.setIndicadorPortado(datosGeneralesVenta.getIndicadorPortado());*/
								abonado.setCodigoOperador(datosGeneralesVenta.getCodigoOperador());									    	
								abonado.setCodSituacion(config.getString("codigo.situacion.portado"));
							}else if (tipter.equals("I")){
								abonado.setIndicadorPortado("0");
								abonado.setCodigoOperador(datosGeneralesVenta.getCodigoOperador());									    	
								abonado.setCodSituacion(config.getString("codigo.situacion.portado"));
							}

						}

						abonado.setCodUso(usoLinea);
						//-- CREA ABONADO
						sEstadoError = "NOK";
						sDetalleError = "Ocurrio un error al crear los SS";
						logger.debug("ventasSrv:antes de crear abonado: " + datosGeneralesVenta.getNumeroSerieSimcard());
						abonado.setVendedor(vendedor);
						creaAbonadoCDMA(abonado);
						logger.debug("ventasSrv:despues de crear abonado");

						if ( (planTarifario.getCodigoTipoPlan().equals("1")) ){										
							usuario=creacionUsuario(cliente,planTarifario,datosGeneralesVenta, abonado ,nuevoUsuario);									   	    
							if (usuario.getExitoCreacionUusario()==false){
								sEstadoError = "NOK";
								sDetalleError = "Ocurrio un error al crear el Usuario";
								throw new GeneralException("12414",0,"Ocurrio un error al crear el Usuario");
							}
						}

						//Ejecuta creación Abonados Red Celular ga_abocel (Simcard y Terminal).
						abonado.setIndComodato(String.valueOf(datosGeneralesVenta.getIndicadorComodato()));
						if(terminal.getIndProcEq().equals(config.getString("indicador.procedencia.interna"))){
							abonado.setTipTerminalEquipo(articulo.getTipTerminal());
							abonado.setTipTerminalSimcard("");
						}else{
							abonado.setTipTerminalEquipo("D");
							abonado.setTipTerminalSimcard("");
						}
						
						if(datosGeneralesVenta.getIndicadorCuotas() != null){
							if(!datosGeneralesVenta.getIndicadorCuotas().equals("0"))
								abonado.setIndPropiedad(config.getString("indicador.propiedad.externo"));
							else
								abonado.setIndPropiedad(config.getString("indicador.propiedad.cuotas"));
						}
						else
							abonado.setIndPropiedad(config.getString("indicador.propiedad.externo"));
						abonado.setIndEqAcc(config.getString("indicador.equiacc"));    
						//-- INSERTA EN ga_servsuplabo ( SERVICIOS SUPLEMENTARIOS )
						servicioSuplementario.setNumeroAbonado(String.valueOf(abonado.getNumAbonado()));
						servicioSuplementario.setCodigoPlan(abonado.getCodPlanTarif());
						servicioSuplementario.setNumeroTerminal(String.valueOf(abonado.getNumCelular()));
						servicioSuplementario.setNomUsuario(datosGeneralesVenta.getNombreUsuarioOracle());
						creaSSAbonado(servicioSuplementario);				    




						//-- INSERTA EN ga_equipaboser								    	
						abonado.setNumeroMovimiento(sNumeroMovtoSerieTerminal);
						abonado.setNumSerieTerminal(terminal.getNumeroSerie());
						creaTerminalAboser(abonado);									    
					}
					catch(GeneralException e){
						logger.debug("GeneralException[", e);
						throw e;
					} catch (Exception e) {
						logger.debug("Exception[", e);
						throw new GeneralException(e);
					}

				}
				catch(GeneralException e){
					logger.debug("GeneralException[", e);
					throw e;
				} catch (Exception e) {
					logger.debug("Exception[", e);
					throw new GeneralException(e);
				}

			}
			catch(GeneralException e){
				logger.debug("GeneralException[", e);
				throw e;
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}
		}else {				
			logger.debug("[ERROR] Estado de la serie terminal no es el mismo. Serie fue tomada por otro vendedor. ");
			resultado.setEstadoError("NOK");
			resultado.setDetalleError("Estado de la serie terminal no es el mismo. Serie fue tomada por otro vendedor");
			throw new GeneralException("98523654",0,"Estado de la serie terminal no es el mismo. Serie fue tomada por otro vendedor");
		}						


		//-- Registra campaña a nivel de abonado
		logger.debug("codigo campana vigente: " + datosGeneralesVenta.getAplicaCampañaA());
		if(!resultado.getEstadoError().equals("NOK")) //-- no hubo error
			if (datosGeneralesVenta.getCodigoCampaña()!=null && 
					datosGeneralesVenta.getAplicaCampañaA().equals(config.getString("aplica.campana.a.abonado"))){
				logger.debug("aplica campaña a abonado..." + abonado.getNumAbonado());
				CampanaVigenteDTO campanaVigenteDTO = new CampanaVigenteDTO();
				campanaVigenteDTO.setCodigoCampanasVigentes(datosGeneralesVenta.getCodigoCampaña());
				campanaVigenteDTO.setCodigoCliente(Long.parseLong(datosGeneralesVenta.getCodigoCliente()));
				campanaVigenteDTO.setNumeroAbonado(abonado.getNumAbonado());
				registraCampanaVigente(campanaVigenteDTO);
			}


		resultado.setNumeroAbonado(String.valueOf(abonado.getNumAbonado()));
		resultado.setNumeroSerieTerminal(abonado.getNumSerieSimcard());
		resultado.setNumeroCelular(String.valueOf(abonado.getNumCelular()));

		logger.debug("Fin:creacionLineas()");
		return resultado;
	}	



	public void setNumeracionSimPortada(SimcardSNPNDTO simcardSNPNDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("Inicio: setNumeracionSimPortada:start");
			BOsimcard.setNumeracionSimPortada(simcardSNPNDTO);
			logger.debug("Fin: setNumeracionSimPortada:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}
	
	public void setAceptacionVenta(GaVentasDTO entrada) 
	throws GeneralException{	
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("Inicio: setAceptacionVenta:start");
			BORegistroVenta.setAceptacionVenta(entrada);
			logger.debug("Fin: setAceptacionVenta:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}
	
	public void setNumeracionTerminalPortada(TerminalSNPNDTO terminal) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("Inicio: setNumeracionTerminalPortada:start");
			BOterminal.setNumeracionTerminalPortada(terminal);
			logger.debug("Fin: setNumeracionTerminalPortada:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}
	
	private String getGeneraParamRestricc(ParamRestriccionDTO paramRestriccion) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		String retorno = new String();
		try{
						 			   						
			
			retorno = "|"+paramRestriccion.getPrograma()+"|"
			             +paramRestriccion.getVersion()+"|"
			             +paramRestriccion.getProceso()+"|"
			             +paramRestriccion.getActuacion()+"|"
			             +paramRestriccion.getNumAbonado()+"|"
			             +paramRestriccion.getCodCliente()+"|"
			             +paramRestriccion.getCodModGener()+"|"
			             +paramRestriccion.getNumVenta()+"|"
			             +paramRestriccion.getCodOOSS()+"|"
			             +paramRestriccion.getCodVendedor()+"|"
			             +paramRestriccion.getDesSS()+"|"
			             +paramRestriccion.getCodPlanTarifDes()+"|"
			             +paramRestriccion.getCodUso()+"|"
			             +paramRestriccion.getCodCuentaOrg()+"|"
			             +paramRestriccion.getCodCuentaDes()+"|"
			             +paramRestriccion.getCodClienteDes()+"|"
			             +paramRestriccion.getCodTipPlanTarif()+"|"
			             +paramRestriccion.getCodTipPlanTarifD()+"|"
			             +paramRestriccion.getCodCiclo()+"|"
			             +paramRestriccion.getFechaSistema()+"|"
			             +paramRestriccion.getRestriccionAux()+"|"
			             +paramRestriccion.getCodModulo()+"|"
			             +paramRestriccion.getNumId()+"|";
			             			             					
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retorno;
	}	
	
	
	public void registraAltaAsincrono(WsCunetaAltaDeLineaOutDTO cunetaAltaDeLineaOut, String id_transaccion) 
	throws GeneralException
	{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		try{
			logger.debug("Inicio: registraAltaAsincrono:start");
			BOAbonado.registraAltaAsincrono(cunetaAltaDeLineaOut, id_transaccion);
			logger.debug("Fin: registraAltaAsincrono:end");
		}
		catch(GeneralException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error GeneralException[" + log + "]");	
			throw e;
		} catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error Exception[" + log + "]");	
			throw new GeneralException(e);
		}
	}
	
	public WsCunetaAltaDeLineaOutDTO recuperarAltaAsincrono(String id_transaccion) 
	throws GeneralException
	{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		WsCunetaAltaDeLineaOutDTO CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO(); 
		try{
			logger.debug("Inicio: setNumeracionTerminalPortada:start");
			CunetaAltaDeLineaOut = BOAbonado.recuperarAltaAsincrono(id_transaccion);
			logger.debug("Fin: setNumeracionTerminalPortada:end");
		}
		catch(GeneralException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error GeneralException[" + log + "]");	
			throw e;
		} catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error Exception[" + log + "]");	
			throw new GeneralException(e);
		}
		return CunetaAltaDeLineaOut;
	}	
	
	
	
	public WsBeneficioPromocionOutDTO[] recCampanaBeneficio(WsBeneficioPromocionInDTO beneficioPromocion) 
	throws GeneralException
	{		
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		WsBeneficioPromocionOutDTO[] retorno = null;
		try{
			logger.debug("Inicio: recCampanaBeneficio:start");
			retorno = BOAbonado.recCampanaBeneficio(beneficioPromocion);
			logger.debug("Fin: recCampanaBeneficio:end");
		}
		catch(GeneralException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error GeneralException[" + log + "]");	
			throw e;
		} catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error Exception[" + log + "]");	
			throw new GeneralException(e);
		}		
		return retorno;
	}	
	
	public void registraCampanaBeneficio(WsRegistraCampanaByPInDTO registraCampanaByPIn) 
	throws GeneralException
	{			
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));		
		try{
			logger.debug("Inicio: registraCampanaBeneficio:start");
			BOAbonado.registraCampanaBeneficio(registraCampanaByPIn);
			logger.debug("Fin: registraCampanaBeneficio:end");
		}
		catch(GeneralException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error GeneralException[" + log + "]");	
			throw e;
		} catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error Exception[" + log + "]");	
			throw new GeneralException(e);
		}			
	}
		
//	Inicio Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
	public void cancelaVenta(GaVentasDTO gaVentasDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeAbonadosSrv.log"));
		logger.debug("Inicio:cancelaVenta()");
		BOAbonado.cancelaVenta(gaVentasDTO);
		logger.debug("Fin:cancelaVenta()");
	}	
//	Fin Incidencia 143860 [ACP Soporte Ventas 05-10-2010]

}
