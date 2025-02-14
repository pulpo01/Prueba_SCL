package com.tmmas.scl.frameworkcargos.srv;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.base.TareasRegistroCargos;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.motorv1.ProcesadorCargos;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglaPlanTarifarioDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasKitDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasServicioOcacionalDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasServicioSuplementarioDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasSimcardDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasTerminalDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.PreBillingVE;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.PreliquidacionVE;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasKit;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasPlanesTarifarios;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasServiciosOcasionales;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasServiciosSuplementarios;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasSimcard;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasTerminal;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.VendedorBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.VendedorBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.VendedorIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.BitacoraDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConfiguradorTareaPrebillingDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConfiguradorTareaPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosCodDescDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosMotorCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosRegistrarCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosRegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProgramaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoRegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.itermediario.AbonadoDTOInt;
import com.tmmas.scl.framework.productDomain.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DatosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.KitBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ParametrosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ServicioSuplementarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SimcardBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.TerminalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.KitBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.KitBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioSuplementarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioSuplementarioBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.KitDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroVentaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ServicioSuplementarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.interfaz.IdentificadorProceso;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.frameworkcargos.srv.helper.Global;
import com.tmmas.scl.frameworkcargos.srv.interfaces.GestionCargosSrvIF;

public class GestionCargosSRV implements GestionCargosSrvIF{

	private final Logger logger = Logger.getLogger(this.getClass());
	private Global global = Global.getInstance();

	private TerminalBOFactoryIT terminalFactory = new TerminalBOFactory();
	private TerminalBOIT terminalBO =terminalFactory.getBusinessObject1();

	private PlanTarifarioBOFactoryIT planTarifarioFactory = new PlanTarifarioBOFactory();
	private PlanTarifarioIT planTarifarioBO =planTarifarioFactory.getBusinessObject1();

	private AbonadoBOFactoryIT abonadoFactory = new AbonadoBOFactory();
	private AbonadoIT abonadoBO =abonadoFactory.getBusinessObject1();

	private ParametrosGeneralesBOFactoryIT factoryBO3 = new ParametrosGeneralesBOFactory();
	private ParametrosGeneralesIT parametrosGeneralesBO = factoryBO3.getBusinessObject1();

	private ServicioSuplementarioBOFactoryIT servSuplemFactory=new ServicioSuplementarioBOFactory();
	private ServicioSuplementarioBOIT servicioSuplementarioBO=servSuplemFactory.getBusinessObject1();

	private VendedorBOFactoryIT vendedorFactory =new VendedorBOFactory();
	private VendedorIT vendedorBO = vendedorFactory.getBusinessObject1();

	private SimcardBOFactoryIT simcardFactory=new SimcardBOFactory();
	private SimcardBOIT simcardBO=simcardFactory.getBusinessObject1();

	private KitBOFactoryIT kitFactory=new KitBOFactory();
	private KitBOIT kitBO=kitFactory.getBusinessObject1();

	private DatosGeneralesBOFactoryIT datosGeneralesFactory=new DatosGeneralesBOFactory();
	private DatosGeneralesBOIT datosGeneralesBO= datosGeneralesFactory.getBusinessObject1(); 

	private RegistroFacturacionBOFactoryIT regFactFactory=new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT registroFacturacionBO=regFactFactory.getBusinessObject1();

	//private String usuario="";
	private String codigoCuotas="";
	private ProgramaDTO datosPrograma = ProgramaDTO.getInstance();
	private long codCiclo;



	public GestionCargosSRV(){
		String log = global.getValor("servicios.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
	}


	/**
	 * Metodo que obtiene los cargos asociados a la venta
	 * @param ParametrosObtencionCargosDTO parametros
	 * @return cargos
	 * @throws Exception, GeneralException 
	 * @throws CustomerDomainException, ProductDomainException, FrameworkCargosException
	 */
	private ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO parametros,ParametrosCodDescDTO[] listParametrosCodDescDTO )throws Exception, GeneralException{
		ObtencionCargosDTO resultado = new ObtencionCargosDTO();
		try{
			logger.debug("Inicio:obtenerCargos()");
			RegistroVentaDTO regVenta = new RegistroVentaDTO();
			regVenta.setPrepago(parametros.isAplicaPrepago());
			regVenta.setNumeroVenta(Long.parseLong(parametros.getNumeroVenta()));
			AbonadoDTOInt[] listaAbonados = abonadoBO.getListaAbonadosVentaNoKit(regVenta);

			logger.debug("Inicio:obtenerCargos() listaAbonados : " + listaAbonados.length);
			ProcesadorCargos procesadorCargos = new ProcesadorCargos();
			String codCausaDesc=parametros.getCodigoCausalDescuento();
			for(int i=0;i<listaAbonados.length;i++)
			{
				if (listParametrosCodDescDTO!=null&&listParametrosCodDescDTO.length>0){
					for (int j=0;j<listParametrosCodDescDTO.length;j++){
						if (listaAbonados[i].getNumAbonado()==Long.parseLong(listParametrosCodDescDTO[j].getNumAbonado())){
							codCausaDesc=listParametrosCodDescDTO[j].getCodigoCausaDescuento();
						}
						break;
					}
					parametros.setCodigoCausalDescuento(codCausaDesc);
				}



				ArrayList arregloReglas = new ArrayList();

				//-- CARGOS PLAN TARIFARIO : CARGO BASICO
				//---------------------------------------


				logger.debug("CARGOS PLAN TARIFARIO : CARGO BASICO");
				ReglasPlanesTarifarios reglaPlanTarifario = new ReglasPlanesTarifarios(getParametrosReglaPlanTarifario(parametros,listaAbonados[i]));
				arregloReglas.add(reglaPlanTarifario);

				//-- CARGOS SERVICIOS SUPLEMENTARIOS
				//----------------------------------
				logger.debug("CARGOS SERVICIOS SUPLEMENTARIOS");
				ServicioSuplementarioDTO entradaServSupl = new ServicioSuplementarioDTO();
				entradaServSupl.setNumeroAbonado(String.valueOf(listaAbonados[i].getNumAbonado()));

				ServicioSuplementarioDTO[] listaServiciosSuplemantarios = null;
				try{
					listaServiciosSuplemantarios = servicioSuplementarioBO.getSSAbonado(entradaServSupl);
				}catch(Exception e){
					logger.debug("No se pudo obtener abonados");
				}
				if (listaServiciosSuplemantarios!=null)
					for(int j=0;j<listaServiciosSuplemantarios.length;j++)
					{
						ReglasServiciosSuplementarios reglaServicioSuplementario = new ReglasServiciosSuplementarios(getParametrosReglaServicioSuplementario(parametros,listaAbonados[i],listaServiciosSuplemantarios[j]));
						arregloReglas.add(reglaServicioSuplementario);
					}//fin for j

				//-- CARGOS KIT				
				//-----------------	
				ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
				parametrosGral.setNombreparametro(listaAbonados[i].getCodTecnologia());
				parametrosGral = parametrosGeneralesBO.getParametroGrupoTecnologico(parametrosGral);
				String sGrupoTecnologico = parametrosGral.getValorparametro();
				parametros.setCodigoClienteDestino("Ingreso ");

				/*if (i == 0){
					if (sGrupoTecnologico.equals("GSM")){	
						logger.debug("CARGOS KIT");
						ReglasKit reglaKit = new ReglasKit(getParametrosReglaKit(parametros,listaAbonados[i]));
						arregloReglas.add(reglaKit);
					}
				}*/
				//-----------------
				//-----------------

				//-- CARGOS SIMCARD
				//-----------------



				if (sGrupoTecnologico.equals("GSM")){			
					logger.debug("CARGOS SIMCARD");
					ReglasSimcard reglaSimcard = new ReglasSimcard(getParametrosReglaSimcard(parametros,listaAbonados[i]));
					arregloReglas.add(reglaSimcard);
				}


				//-- CARGOS TERMINAL
				//------------------
				logger.debug("CARGOS TERMINAL");
				ReglasTerminal reglaTerminal = new ReglasTerminal(getParametrosReglaTerminal(parametros,listaAbonados[i]));
				arregloReglas.add(reglaTerminal);

				if (reglaTerminal != null){
					logger.debug("reglaTerminal");
				}


				//-- CARGOS SERVICIOS OCACIONALES
				//-------------------------------
				logger.debug("CARGOS SERVICIOS OCACIONALES");
				ReglasServiciosOcasionales reglaServicioOcacional = new ReglasServiciosOcasionales(getParametrosReglaServicioOcacional(parametros,listaAbonados[i]));
				arregloReglas.add(reglaServicioOcacional);


				ReglaListaPrecio[] coleccionReglas =(ReglaListaPrecio[])ArrayUtl.copiaArregloTipoEspecifico(arregloReglas.toArray(), 
						ReglaListaPrecio.class);
				procesadorCargos.calcularCargos(coleccionReglas);
			}

			//---------------		
			AbonadoDTOInt[] listaAbonadosKit = abonadoBO.getListaAbonadosVentaKit(regVenta);

			for(int i=0;i<listaAbonadosKit.length;i++){
				ArrayList arregloReglas = new ArrayList();
				ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
				parametrosGral.setNombreparametro(listaAbonadosKit[i].getCodTecnologia());
				parametrosGral = parametrosGeneralesBO.getParametroGrupoTecnologico(parametrosGral);
				String sGrupoTecnologico = parametrosGral.getValorparametro();

				if (sGrupoTecnologico.equals("GSM")){	
					logger.debug("CARGOS KIT");
					ReglasKit reglaKit = new ReglasKit(getParametrosReglaKit(parametros,listaAbonadosKit[i]));
					arregloReglas.add(reglaKit);			
				}

				ReglaListaPrecio[] coleccionReglas =(ReglaListaPrecio[])ArrayUtl.copiaArregloTipoEspecifico(arregloReglas.toArray(), 
						ReglaListaPrecio.class);
				procesadorCargos.calcularCargos(coleccionReglas);
			}
			//---------------

			//procesadorCargos.agruparCargos();
			CargosDTO[] cargos = procesadorCargos.obtenerCargos();
			VendedorDTO vendedor = new VendedorDTO();
			vendedor.setCodigoVendedor(parametros.getCodigoVendedor());
			vendedor = vendedorBO.getRangoDescuento(vendedor);
			resultado.setAplicaDescuentoVendedor(vendedor.isAplicaDescuento());

			if (resultado.isAplicaDescuentoVendedor()){
				resultado.setPorcentajeDesctoInferior(vendedor.getPorcentajeDesctoInferior());
				logger.debug("porcentaje 1: " + resultado.getPorcentajeDesctoInferior());
				resultado.setPorcentajeDesctoSuperior(vendedor.getPorcentajeDesctoSuperior());
				logger.debug("porcentaje 2: " + resultado.getPorcentajeDesctoSuperior());
				resultado.setPuntoDesctoInferior(vendedor.getPuntoDesctoInferior());
				resultado.setPuntoDesctoSuperior(vendedor.getPuntoDesctoSuperior());
			}
			resultado.setCargos(cargos);
			logger.debug("Fin recorre lista de abonados...");
			logger.debug("Fin:obtenerCargos()");
		}catch(GeneralException e){
			logger.debug("Fin:obtenerCargos() -- GeneralException");
			throw e;
		}catch(Exception e){
			logger.debug("Fin:obtenerCargos() -- Exception");
			throw e;
		}



		return resultado;
	}//fin obtenerCargos

	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Plan Tarifario
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametrosReglaPlanTarifario
	 * @throws CustomerDomainException,ProductDomainException
	 */
	private ParametrosReglaPlanTarifarioDTO getParametrosReglaPlanTarifario(ParametrosObtencionCargosDTO parametros,AbonadoDTOInt abonado) throws GeneralException{
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();
		ParametrosReglaPlanTarifarioDTO parametrosReglaPlanTarifario = new ParametrosReglaPlanTarifarioDTO();
		String codCargobasico=abonado.getCodCargoBasico();
		String codPlantarif=abonado.getCodPlanTarif();		
		String valCodProduntoUno=global.getValor("codigo.producto");


		parametrosReglaPlanTarifario.setCodigoCargoBasico(codCargobasico);
		parametrosReglaPlanTarifario.setCodigoPlanTarifario(codPlantarif);
		parametrosReglaPlanTarifario.setCodigoProducto(valCodProduntoUno);
		parametrosReglaPlanTarifario.setCodigoTecnologia(abonado.getCodTecnologia());
		parametrosReglaPlanTarifario.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		parametrosReglaPlanTarifario.setCodigoUsoLinea(abonado.getCodUso());

		parametrosReglaPlanTarifario.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
		parametrosReglaPlanTarifario.setNumCelular(String.valueOf(abonado.getNumCelular()));
		parametrosReglaPlanTarifario.setNumSerie(abonado.getNumSerieSimcard());

		ParametrosDescuentoDTO parametrosDescuentoPlanTarifario = new ParametrosDescuentoDTO();
		parametrosDescuentoPlanTarifario.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoPlanTarifario.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
			parametrosDescuentoPlanTarifario.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
		else
			parametrosDescuentoPlanTarifario.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
		parametrosDescuentoPlanTarifario.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));

		parametrosDescuentoPlanTarifario.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoPlanTarifario.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoPlanTarifario.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoPlanTarifario.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
		parametrosDescuentoPlanTarifario.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoPlanTarifario.setCodigoArticulo("");


		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoPlanTarifario.setCodAbonocel(parametrosGral.getValorparametro());

		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(valCodProduntoUno);
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoPlanTarifario.setClaseDescuento(parametrosGral.getValorparametro());

		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoTecnologia(abonado.getCodTecnologia());
		planTarifario.setCodigoProducto(valCodProduntoUno);
		planTarifario.setCodigoPlanTarifario(codPlantarif);
		planTarifario = planTarifarioBO.getCategoriaPlanTarifario(planTarifario);
		parametrosDescuentoPlanTarifario.setCodigoCategoria(planTarifario.getCodigoCategoria());
		//Obtiene datos del plan tarifario
		planTarifario.setCodigoTecnologia(abonado.getCodTecnologia());
		planTarifario.setCodigoProducto(valCodProduntoUno);
		planTarifario.setCodigoPlanTarifario(codPlantarif);
		planTarifario.setCodPlanTarif(codPlantarif);
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		parametrosReglaPlanTarifario.setIndicadorCargoHabilitacion(planTarifario.getIndicadorCargoHabilitacion());

		parametrosDescuentoPlanTarifario.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoPlanTarifario.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));		
		parametrosDescuentoPlanTarifario.setCodigoOperacion(global.getValor("codigo.operacion"));		
		parametrosDescuentoPlanTarifario.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoPlanTarifario.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoPlanTarifario.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametrosDescuentoPlanTarifario.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan());
		parametrosReglaPlanTarifario.setParametrosDescuento(parametrosDescuentoPlanTarifario);
		return parametrosReglaPlanTarifario;
	}

	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Simcard
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaSimcard
	 * @throws CustomerDomainException,ProductDomainException
	 */
	private ParametrosReglasSimcardDTO getParametrosReglaSimcard(ParametrosObtencionCargosDTO parametros,AbonadoDTOInt abonado) throws GeneralException{
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();

		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		//Obtiene datos del plan tarifario
		String usoLinea = null;
		planTarifario.setCodigoTecnologia(abonado.getCodTecnologia());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.postpago"))){
			usoLinea =  global.getValor("codigo.uso.postpago");
		}else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.hibrido"))){
			usoLinea =  global.getValor("codigo.uso.hibrido");
		}else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.prepago"))){
			usoLinea =  global.getValor("codigo.uso.prepago");
		}

		//-- OBTIENE PARAMETRO : PRECIO LISTA


		String sPrecioLista = global.getValor("indicador.precio.lista");

		logger.debug("getParametrosReglaSimcard sPrecioLista ["+sPrecioLista+"]");


		//-- OBTIENE PARAMETRO : GRUPO TECNOLOGIA GSM
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.grupotecgsm"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		String sGrupoTecGSM = parametrosGral.getValorparametro();

		//-- OBTIENE PARAMETRO : GRUPO TECNOLOGICO
		parametrosGral.setNombreparametro(abonado.getCodTecnologia());
		parametrosGral = parametrosGeneralesBO.getParametroGrupoTecnologico(parametrosGral);
		String sGrupoTecnologico = parametrosGral.getValorparametro();


		SimcardDTO simcard = new SimcardDTO();
		ParametrosReglasSimcardDTO parametroReglaSimcard = new ParametrosReglasSimcardDTO();
		simcard.setNumeroSerie(abonado.getNumSerieSimcard());
		simcard = simcardBO.getSimcard(simcard);

		parametroReglaSimcard.setCodigoArticulo(simcard.getCodigoArticulo());
		parametroReglaSimcard.setTipoStock(simcard.getTipoStock());
		parametroReglaSimcard.setCodigoUso(usoLinea);
		parametroReglaSimcard.setEstado(global.getValor("estado.articulo"));
		parametroReglaSimcard.setCodigoCategoria(simcard.getCodigoCategoria());
		parametroReglaSimcard.setIndicadorValorar(simcard.getIndicadorValorar());
		parametroReglaSimcard.setIndicadorPrecioLista(sPrecioLista);
		parametroReglaSimcard.setGrupoTecnologiaGSM(sGrupoTecGSM);
		parametroReglaSimcard.setGrupoTecnologico(sGrupoTecnologico);
		parametroReglaSimcard.setIndiceRecambioPrecioLista(global.getValor("indice.recambio.preciolista"));
		parametroReglaSimcard.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
		parametroReglaSimcard.setCodigoCategoria(global.getValor("codigo.categoria"));
		parametroReglaSimcard.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametroReglaSimcard.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		parametroReglaSimcard.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
		parametroReglaSimcard.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametroReglaSimcard.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
		parametroReglaSimcard.setNumCelular(String.valueOf(abonado.getNumCelular()));
		parametroReglaSimcard.setNumSerie(abonado.getNumSerieSimcard());		
		parametroReglaSimcard.setCodTecnologia(abonado.getCodTecnologia());

		/*-- Inicio Parametros Descuentos --*/
		ParametrosDescuentoDTO parametrosDescuentoSimcard = new ParametrosDescuentoDTO();
		parametrosDescuentoSimcard.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoSimcard.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
			parametrosDescuentoSimcard.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
		else
			parametrosDescuentoSimcard.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
		parametrosDescuentoSimcard.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));		
		parametrosDescuentoSimcard.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoSimcard.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoSimcard.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoSimcard.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
		parametrosDescuentoSimcard.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoSimcard.setCodigoArticulo(simcard.getCodigoArticulo());



		parametrosDescuentoSimcard.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan());

		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoSimcard.setCodAbonocel(parametrosGral.getValorparametro());

		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoSimcard.setClaseDescuento(parametrosGral.getValorparametro());


		PlanTarifarioDTO planTarifario2 = new PlanTarifarioDTO();
		planTarifario2.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario2 = planTarifarioBO.getCategoriaPlanTarifario(planTarifario2);
		parametrosDescuentoSimcard.setCodigoCategoria(planTarifario2.getCodigoCategoria());


		parametrosDescuentoSimcard.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoSimcard.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));

		if (abonado.getCodUso().equals("3")){
			parametrosDescuentoSimcard.setCodigoOperacion(global.getValor("codigo.operacion.prepago"));
		}else{
			parametrosDescuentoSimcard.setCodigoOperacion(global.getValor("codigo.operacion"));
		}

		//parametrosDescuentoSimcard.setCodigoOperacion(global.getValor("codigo.operacion"));
		parametrosDescuentoSimcard.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoSimcard.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoSimcard.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametroReglaSimcard.setParametrosDescuento(parametrosDescuentoSimcard);

		return parametroReglaSimcard;
	}

	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Terminal
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaTerminal
	 * @throws CustomerDomainException,ProductDomainException
	 */
	private ParametrosReglasTerminalDTO getParametrosReglaTerminal(ParametrosObtencionCargosDTO parametros,AbonadoDTOInt abonado) throws GeneralException{


		//Obtiene datos del plan tarifario
		String usoLinea = null;
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		//Obtiene datos del plan tarifario
		planTarifario.setCodigoTecnologia(abonado.getCodTecnologia());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.postpago"))){
			usoLinea =  global.getValor("codigo.uso.postpago");
		}else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.hibrido"))){
			usoLinea =  global.getValor("codigo.uso.hibrido");
		}
		else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.prepago"))){
			usoLinea =  global.getValor("codigo.uso.prepago");
		}

		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();
		TerminalDTO terminal = new TerminalDTO();
		ParametrosReglasTerminalDTO parametroReglaTerminal = new ParametrosReglasTerminalDTO();

		//-- OBTIENE PARAMETRO : PRECIO LISTA

		String sPrecioLista = global.getValor("indicador.precio.lista");

		logger.debug("getParametrosReglaTerminal sPrecioLista ["+sPrecioLista+"]");

		parametrosGral.setNombreparametro(abonado.getCodTecnologia());
		parametrosGral = parametrosGeneralesBO.getParametroGrupoTecnologico(parametrosGral);
		String sGrupoTecnologico = parametrosGral.getValorparametro();


		//-- BUSCAR DATOS DEL TERMINAL

		if (sGrupoTecnologico.equals("GSM")){
			terminal.setNumeroSerie(abonado.getNumSerieTerminal());
		}else{
			terminal.setNumeroSerie(abonado.getNumSerieSimcard() );
		}

		terminal = terminalBO.getTerminal(terminal);



		parametroReglaTerminal.setCodigoTecnologia(abonado.getCodTecnologia());
		parametroReglaTerminal.setCodigoArticulo(terminal.getCodigoArticulo());
		parametroReglaTerminal.setTipoStock(terminal.getTipoStock());
		parametroReglaTerminal.setCodigoUso(usoLinea);
		parametroReglaTerminal.setEstado(global.getValor("estado.articulo"));
		parametroReglaTerminal.setCodigoCategoria(terminal.getCodigoCategoria());
		parametroReglaTerminal.setIndicadorValorar(terminal.getIndicadorValorar());
		parametroReglaTerminal.setIndicadorPrecioLista(sPrecioLista);
		parametroReglaTerminal.setIndiceRecambioPrecioLista(global.getValor("indice.recambio.preciolista"));
		parametroReglaTerminal.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
		parametroReglaTerminal.setCodigoCategoria(global.getValor("codigo.categoria"));
		parametroReglaTerminal.setIndicadorProcEquipo(terminal.getIndProcEq());
		parametroReglaTerminal.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametroReglaTerminal.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		parametroReglaTerminal.setNumeroSerie(terminal.getNumeroSerie());
		parametroReglaTerminal.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
		parametroReglaTerminal.setTipoContrato(parametros.getTipoContrato());
		parametroReglaTerminal.setNumeroImei(terminal.getNumeroSerie());


		parametroReglaTerminal.setCodigoTecnologia(abonado.getCodTecnologia());

		parametroReglaTerminal.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
		parametroReglaTerminal.setNumeroCelular(String.valueOf(abonado.getNumCelular()));
		//parametroReglaTerminal.setNumeroSerie(abonado.getNumSerieSimcard());
		/*-- Inicio Parametros Descuentos --*/
		ParametrosDescuentoDTO parametrosDescuentoTerminal = new ParametrosDescuentoDTO();
		parametrosDescuentoTerminal.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoTerminal.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
			parametrosDescuentoTerminal.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
		else
			parametrosDescuentoTerminal.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
		parametrosDescuentoTerminal.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));

		parametrosDescuentoTerminal.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoTerminal.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoTerminal.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoTerminal.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
		parametrosDescuentoTerminal.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoTerminal.setCodigoArticulo(terminal.getCodigoArticulo());

		parametrosDescuentoTerminal.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan());



		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoTerminal.setCodAbonocel(parametrosGral.getValorparametro());

		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoTerminal.setClaseDescuento(parametrosGral.getValorparametro());


		PlanTarifarioDTO planTarifario2 = new PlanTarifarioDTO();
		planTarifario2.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario2 = planTarifarioBO.getCategoriaPlanTarifario(planTarifario2);
		parametrosDescuentoTerminal.setCodigoCategoria(planTarifario2.getCodigoCategoria());


		parametrosDescuentoTerminal.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoTerminal.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));

		if (abonado.getCodUso().equals("3")){
			parametrosDescuentoTerminal.setCodigoOperacion(global.getValor("codigo.operacion.prepago"));
		}else{
			parametrosDescuentoTerminal.setCodigoOperacion(global.getValor("codigo.operacion"));
		}
		//	parametrosDescuentoTerminal.setCodigoOperacion(global.getValor("codigo.operacion"));
		parametrosDescuentoTerminal.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoTerminal.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoTerminal.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametroReglaTerminal.setParametrosDescuento(parametrosDescuentoTerminal);



		return parametroReglaTerminal;
	}//fin getParametrosReglaTerminal

	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Terminal
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaTerminal
	 * @throws CustomerDomainException,ProductDomainException
	 */
	private ParametrosReglasServicioSuplementarioDTO getParametrosReglaServicioSuplementario(ParametrosObtencionCargosDTO parametros,AbonadoDTOInt abonado,ServicioSuplementarioDTO servicio)	throws GeneralException{

		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();
		TerminalDTO terminal = new TerminalDTO();
		ParametrosReglasServicioSuplementarioDTO parametrosReglaServicioSuplementario = new ParametrosReglasServicioSuplementarioDTO();

		parametrosGral.setNombreparametro(abonado.getCodTecnologia());
		parametrosGral = parametrosGeneralesBO.getParametroGrupoTecnologico(parametrosGral);
		String sGrupoTecnologico = parametrosGral.getValorparametro();


		//-- BUSCAR DATOS DEL TERMINAL

		if (sGrupoTecnologico.equals("GSM")){
			terminal.setNumeroSerie(abonado.getNumSerieTerminal());
		}else{
			terminal.setNumeroSerie(abonado.getNumSerieSimcard() );
		}

		terminal = terminalBO.getTerminal(terminal);

		parametrosReglaServicioSuplementario.setCodigoProducto(global.getValor("codigo.producto"));
		parametrosReglaServicioSuplementario.setCodigoServicio(servicio.getCodigoServicio());
		parametrosReglaServicioSuplementario.setCodigoPlanServicio(abonado.getCodPlanServ());
		parametrosReglaServicioSuplementario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametrosReglaServicioSuplementario.setCodigoCliente(String.valueOf(abonado.getCodCliente()));

		//-- BUSCAR CODIGO ACTUACION
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario.setCodigoTecnologia(abonado.getCodTecnologia());
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);

		if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanPostPago()))
			parametrosReglaServicioSuplementario.setCodigoActuacion(global.getValor("codigo.actuacion.venta"));
		else if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido()))
			parametrosReglaServicioSuplementario.setCodigoActuacion(global.getValor("codigo.actuacion.hibrido"));
		else 
			parametrosReglaServicioSuplementario.setCodigoActuacion(global.getValor("codigo.actuacion.prepago"));

		parametrosReglaServicioSuplementario.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
		parametrosReglaServicioSuplementario.setNumCelular(String.valueOf(abonado.getNumCelular()));
		parametrosReglaServicioSuplementario.setNumSerie(abonado.getNumSerieSimcard());

		/*-- Inicio Parametros Descuentos --*/
		ParametrosDescuentoDTO parametrosDescuentoSS = new ParametrosDescuentoDTO();
		parametrosDescuentoSS.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoSS.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
			parametrosDescuentoSS.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
		else
			parametrosDescuentoSS.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
		parametrosDescuentoSS.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));
		parametrosDescuentoSS.setTipoPlanTarifario(planTarifario.getTipoPlanTarifario());
		parametrosDescuentoSS.setCodigoTipoPlanTarifario(planTarifario.getCodigoTipoPlan());

		parametrosDescuentoSS.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoSS.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoSS.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoSS.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
		parametrosDescuentoSS.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoSS.setCodigoArticulo(terminal.getCodigoArticulo());

		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoSS.setCodAbonocel(parametrosGral.getValorparametro());

		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoSS.setClaseDescuento(parametrosGral.getValorparametro());


		planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario = planTarifarioBO.getCategoriaPlanTarifario(planTarifario);
		parametrosDescuentoSS.setCodigoCategoria(planTarifario.getCodigoCategoria());

		parametrosDescuentoSS.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoSS.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
		parametrosDescuentoSS.setCodigoOperacion(global.getValor("codigo.operacion"));
		parametrosDescuentoSS.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoSS.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoSS.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametrosReglaServicioSuplementario.setParametrosDescuento(parametrosDescuentoSS);

		return parametrosReglaServicioSuplementario;
	}//fin getParametrosReglaServicioSuplementario

	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de los Servicios Ocacionales
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaTerminal
	 * @throws CustomerDomainException,ProductDomainException
	 */
	private ParametrosReglasServicioOcacionalDTO getParametrosReglaServicioOcacional(ParametrosObtencionCargosDTO parametros,AbonadoDTOInt abonado) throws GeneralException{

		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();
		ParametrosReglasServicioOcacionalDTO parametrosReglaServicioOcacional = new ParametrosReglasServicioOcacionalDTO();
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		TerminalDTO terminal = new TerminalDTO();

		parametrosGral.setNombreparametro(abonado.getCodTecnologia());
		parametrosGral = parametrosGeneralesBO.getParametroGrupoTecnologico(parametrosGral);
		String sGrupoTecnologico = parametrosGral.getValorparametro();


		//-- BUSCAR DATOS DEL TERMINAL

		if (sGrupoTecnologico.equals("GSM")){
			terminal.setNumeroSerie(abonado.getNumSerieTerminal());
		}else{
			terminal.setNumeroSerie(abonado.getNumSerieSimcard() );
		}

		terminal = terminalBO.getTerminal(terminal);

		String usoLinea = null;
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario.setCodigoTecnologia(abonado.getCodTecnologia());
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.postpago"))){
			usoLinea =  global.getValor("codigo.uso.postpago");
		}else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.hibrido"))){
			usoLinea =  global.getValor("codigo.uso.hibrido");
		}else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.prepago"))){
			usoLinea =  global.getValor("codigo.uso.prepago");
		}

		//-- BUSCAR DATOS COMODATO

		parametrosReglaServicioOcacional.setCodigoProducto(global.getValor("codigo.producto"));
		parametrosReglaServicioOcacional.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametrosReglaServicioOcacional.setCodigoArticulo(terminal.getCodigoArticulo());
		parametrosReglaServicioOcacional.setCodigoUso(usoLinea);
		parametrosReglaServicioOcacional.setTipoStock(String.valueOf(terminal.getTipoStock()));
		parametrosReglaServicioOcacional.setIndicadorComodato(String.valueOf(parametros.getIndComodato()));
		parametrosReglaServicioOcacional.setModalidadVenta(parametros.getCodigoModalidadVenta());
		parametrosReglaServicioOcacional.setNumeroMeses(String.valueOf(parametros.getNumeroMesesContrato()));
		parametrosReglaServicioOcacional.setEsComodato(global.getValor("indicador.comodato"));

		parametrosReglaServicioOcacional.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
		parametrosReglaServicioOcacional.setNumCelular(String.valueOf(abonado.getNumCelular()));
		parametrosReglaServicioOcacional.setNumSerie(abonado.getNumSerieSimcard());

		//-- BUSCAR CODIGO ACTUACION
		if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanPostPago())){
			parametrosReglaServicioOcacional.setCodigoActuacion(global.getValor("codigo.actuacion.venta"));
		}else if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido())){ 
			parametrosReglaServicioOcacional.setCodigoActuacion(global.getValor("codigo.actuacion.hibrido"));
		}else {
			parametrosReglaServicioOcacional.setCodigoActuacion(global.getValor("codigo.actuacion.prepago"));
		}
		/*-- Inicio Parametros Descuentos --*/
		ParametrosDescuentoDTO parametrosDescuentoTerminal = new ParametrosDescuentoDTO();
		parametrosDescuentoTerminal.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoTerminal.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
			parametrosDescuentoTerminal.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
		else
			parametrosDescuentoTerminal.setIndiceVentaExterna(global.getValor("indice.venta.interna"));


		parametrosDescuentoTerminal.setTipoPlanTarifario(planTarifario.getTipoPlanTarifario());
		parametrosDescuentoTerminal.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoTerminal.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		parametrosDescuentoTerminal.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoTerminal.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoTerminal.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
		parametrosDescuentoTerminal.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoTerminal.setCodigoArticulo(abonado.getCodigoArticuloTerminal());

		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoTerminal.setCodAbonocel(parametrosGral.getValorparametro());

		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoTerminal.setClaseDescuento(parametrosGral.getValorparametro());

		planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario = planTarifarioBO.getCategoriaPlanTarifario(planTarifario);
		parametrosDescuentoTerminal.setCodigoCategoria(planTarifario.getCodigoCategoria());

		parametrosDescuentoTerminal.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoTerminal.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
		parametrosDescuentoTerminal.setCodigoOperacion(global.getValor("codigo.operacion"));
		parametrosDescuentoTerminal.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoTerminal.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoTerminal.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametrosReglaServicioOcacional.setParametrosDescuento(parametrosDescuentoTerminal);

		return parametrosReglaServicioOcacional;
	}//fin getParametrosReglaServicioOcacional

	public ObtencionCargosDTO getObtencionCargos(ParametrosObtencionCargosDTO parametros, ParametrosCodDescDTO[] listParametrosCodDescDTO) throws Exception {
		ObtencionCargosDTO obtCargos=null;
		try{
			obtCargos= this.obtenerCargos(parametros,listParametrosCodDescDTO);
		}
		catch(GeneralException e){
			throw e;
		}
		return obtCargos;
	}

	/*	private RegCargosDTO construirRegistroCargos(ObtencionCargosDTOInt resultadoObtenerCargos) throws FrmkCargosException {
		logger.debug("construirRegistroCargos():start::GestionCargosRegistrarSRV");
		RegCargosDTO listadoCargos = new RegCargosDTO();
		CargoFrameworkCargosDTO[] arregloCargos =null;
		List listaCargos = new ArrayList();
		try{
			CargosDTO[] cargos =resultadoObtenerCargos!=null&&resultadoObtenerCargos.getCargos()!=null?resultadoObtenerCargos.getCargos():null;	
			if (cargos !=null){
				if (cargos.length>0){
					for (int i=0;i<cargos.length;i++){
						CargoFrameworkCargosDTO cargo = new CargoFrameworkCargosDTO();
						cargo.setCodigoArticuloServicio(cargos[i].getAtributo().getCodigoArticuloServicio());
						cargo.setTipoProducto(cargos[i].getAtributo().getTipoProducto());
						cargo.setCantidad(cargos[i].getCantidad());
						PrecioDTO precio = cargos[i].getPrecio();
						cargo.setCodigoConceptoPrecio(precio.getCodigoConcepto());
						cargo.setDescripcionConceptoPrecio(precio.getDescripcionConcepto());
						cargo.setMontoConceptoPrecio(precio.getMonto());
						cargo.setCodigoMoneda(precio.getUnidad().getCodigo());
						cargo.setDescripcionMoneda(precio.getUnidad().getDescripcion());
						cargo.setInd_equipo(precio.getDatosAnexos().getInd_equipo());
						cargo.setInd_paquete(precio.getDatosAnexos().getInd_paquete());
						//cargo.setNumAbonado(precio.getDatosAnexos().getNumAbonado());
						cargo.setNumAbonado(cargos[i].getAtributo().getNumAbonado());


						DescuentoDTO[] arregloDescuento = cargos[i].getDescuento();


						if (arregloDescuento!=null){
							String tipoDescuento=null;
							for (int k=0;k<arregloDescuento.length;k++){
								tipoDescuento=arregloDescuento[k].getTipo();


								cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());
								cargo.setDescripcionDescuento(arregloDescuento[k].getDescripcionConcepto());
								if (Integer.parseInt(tipoDescuento)==(TipoDescuentos.Manual)){
									cargo.setMontoDescuentoManual(arregloDescuento[k].getMonto());
									cargo.setTipoDescuentoManual(arregloDescuento[k].getTipoAplicacion());
								}
								if (Integer.parseInt(tipoDescuento)==(TipoDescuentos.Automatico)){
									cargo.setMontoDescuento(arregloDescuento[k].getMonto());
									cargo.setTipoDescuento(arregloDescuento[k].getTipoAplicacion());
								}
							}
						}



						/*if (arregloDescuento!=null)
							if (arregloDescuento.length>0){
								/*Recorre los descuentos. Si existe descuento automatico se asigna este como descuento del cargo, 
								en caso contrario toma el código del descuento manual. Si existen los dos tipos de descuentos toma
								el codigo concepto del descuento automatico
								for (int k=0;k<arregloDescuento.length;k++){
									/*if (arregloDescuento[k].getTipo()==null){
										if (arregloDescuento[k].getCodigoConcepto()!=null && cargo.getCodigoDescuento()==null){
											cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());
										}
									}
										cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());

										cargo.setDescripcionDescuento(arregloDescuento[k].getDescripcionConcepto());
										cargo.setTipoDescuentoManual(arregloDescuento[k].getTipoAplicacion());
										cargo.setTipoDescuento(arregloDescuento[k].getTipo());

										if (cargo.getTipoDescuento().equals(String.valueOf(TipoDescuentos.Manual))){
											cargo.setMontoDescuentoManual(arregloDescuento[k].getMonto());
										}else{
											cargo.setMontoDescuento(arregloDescuento[k].getMonto());
										}
									}


							}
							else{
								cargo.setCodigoDescuento("");
								cargo.setMontoDescuento(0);
							}*/
	/*	else{
							cargo.setMontoDescuento(0);
						}
						//cargo.setDescuentoManual(1);
						listaCargos.add(cargo);

					}
				}
			}
		}
		catch(Exception e){
			throw new FrmkCargosException(e);
		}
		arregloCargos =(CargoFrameworkCargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaCargos.toArray(), CargoFrameworkCargosDTO.class);
		//resultado.setAplicaDescuentoVendedor(objetoCargos.isAplicaDescuentoVendedor());

		if (listadoCargos.isAplicaDescuentoVendedor()){
			/*resultado.setPorcentajeDesctoInferior(objetoCargos.getPorcentajeDesctoInferior());
			resultado.setPorcentajeDesctoSuperior(objetoCargos.getPorcentajeDesctoSuperior());
			resultado.setPuntoDesctoInferior(objetoCargos.getPorcentajeDesctoInferior());
			resultado.setPuntoDesctoSuperior(objetoCargos.getPuntoDesctoSuperior());*/
	/*	}
		listadoCargos.setCargos(arregloCargos);

		//---------------------------------------------------------------------------------------------------------------


		//TODO: Registrar Cargos


		//ResultadoRegCargosDTO resultadoRegistrarCargos=new ResultadoRegCargosDTO();
		//RegCargosDTO param =new RegCargosDTO ();

		//Se procede a llenar la dto con los cargos Obtenidos
		/*try {
			param.setCargos(resultado.getCargos());
			resultadoRegistrarCargos=setRegistrarCargos(param, env);
		} catch (FrameworkCargosException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	/*	logger.debug("construirRegistroCargos():fin::GestionCargosRegistrarSRV");
		return listadoCargos;
	}

	 */

	/**
	 * Crea la Venta, registra los cargos, ejecuta prebilling y preliquidación y obtiene impuestos 
	 * de los cargos asociados a la venta.
	 * Es necesario crear la venta antes de ejecutar el Prebilling, lo cual es un mal diseño, esta 
	 * mal implementado y debiera realizarse este insert en el cierre de la venta. Fernando Garcia.
	 * @param cabecera
	 * @return parametros
	 * @throws 
	 */

	public ResultadoRegCargosDTO registrarCargos(ParametrosRegistrarCargosDTO paramRegCargosDTO) throws FrmkCargosException{
		logger.debug("registrarCargos():start");
		//VentasFacade ventasFacade = getVentasFacade();


		/*Setea los datos necesarios para crear registro en tabla GA_VENTA*/

		/*GaVentasDTO gaVentasDTO = new GaVentasDTO();
		gaVentasDTO.setNumVenta(new Long(listadoCargos.getObjetoSesion().getNumeroVenta()));
    	gaVentasDTO.setCodOficina(listadoCargos.getObjetoSesion().getOficinaVendedor());
    	gaVentasDTO.setCodTipcomis(listadoCargos.getObjetoSesion().getParametros().getTipoComisionista().getCodigoTipoComisionista());
    	//gaVentasDTO.setCodTipcomis("0");
    	gaVentasDTO.setCodVendedor(new Long (listadoCargos.getObjetoSesion().getCodigoVendedor()));
    	gaVentasDTO.setCodVendedorAgente(new Long (listadoCargos.getObjetoSesion().getCodigoVendedorRaiz()));
    	gaVentasDTO.setCodRegion(listadoCargos.getObjetoSesion().getParametros().getRegion().getCodigoRegion());
    	gaVentasDTO.setCodProvincia(listadoCargos.getObjetoSesion().getParametros().getProvincia().getCodigoProvincia());
    	gaVentasDTO.setCodCiudad(listadoCargos.getObjetoSesion().getParametros().getCiudad().getCodigoCiudad());
    	gaVentasDTO.setNumTransaccion(new Long (listadoCargos.getObjetoSesion().getNumeroTransaccionVenta()));
    	gaVentasDTO.setCodCliente(new Long(listadoCargos.getObjetoSesion().getCodigoCliente())); 
    	gaVentasDTO.setCodModVenta(new Long(listadoCargos.getObjetoSesion().getParametros().getModalidadPagoDTO().getCodigoModalidadPago()));
    	gaVentasDTO.setCodCuota(listadoCargos.getObjetoSesion().getParametros().getNumeroCuotas().getCodigo());
    	gaVentasDTO.setNumContrato(listadoCargos.getObjetoSesion().getParametros().getContrato().getNumeroContrato());
    	gaVentasDTO.setCodTipContrato(listadoCargos.getObjetoSesion().getParametros().getContrato().getCodigoTipoContrato());
    	gaVentasDTO.setNomUsuarVta(listadoCargos.getObjetoSesion().getNombreUsuario());
    	gaVentasDTO.setCodVenDealer(new Long(listadoCargos.getObjetoSesion().getCodigoVenDealer()));
    	gaVentasDTO.setTipFoliacion( listadoCargos.getObjetoSesion().getTipoFoliacion());
    	logger.debug("tipo foliacion: " + listadoCargos.getObjetoSesion().getTipoFoliacion());
    	gaVentasDTO.setCodTipDocumento(listadoCargos.getObjetoSesion().getCodigoDocumento());
    	logger.debug("tipo documento: " + listadoCargos.getObjetoSesion().getCodigoDocumento());
    	gaVentasDTO.setAciclo(listadoCargos.getObjetoSesion().isFacturaCiclo());
    	//gaVentasDTO.setTipValor(new Long(listadoCargos.getObjetoSesion().getParametros().getModalidadPagoDTO().getCodigoModalidadPago()));
    	//gaVentasDTO.setIndPasoCob(new Long(0));//valor por defecto obtenido de la BD ya q 
    	gaVentasDTO.setCodOperadora(listadoCargos.getObjetoSesion().getCodigoOperadora());
    	gaVentasDTO.setCodModPago(listadoCargos.getObjetoSesion().getParametros().getModalidadPagoDTO().getCodigoModalidadPago());
    	gaVentasDTO.setFormPago(listadoCargos.getObjetoSesion().getCodigoFormaPago());
    	gaVentasDTO.setIndTipVenta(new Long (listadoCargos.getObjetoSesion().getIndicadorTipoVenta()));*/
		datosPrograma.setCodigoPrograma(global.getValor("programa.codigo"));
		datosPrograma.setNumeroVersion(Integer.parseInt(global.getValor("programa.version")));
		datosPrograma.setNumeroSubVersion(Integer.parseInt(global.getValor("programa.subversion")));
		//gaVentasDTO.setDatosPrograma(datosPrograma);*/

		/*--Realiza el cierre de la venta--*/
		//ventasFacade.creaVenta(gaVentasDTO);	

		ResultadoRegCargosDTO resultado = new ResultadoRegCargosDTO();


		ResultadoRegistroCargosDTO resultadoRegistro = null;
		if (paramRegCargosDTO.getCargos() != null){
			//Registra Cargos
			ParametrosRegistroCargosDTO parametrosCargos = new ParametrosRegistroCargosDTO();	
			parametrosCargos.setCodigoCliente(String.valueOf(paramRegCargosDTO.getCodCliente()));
			parametrosCargos.setNumeroVenta(String.valueOf(paramRegCargosDTO.getNumVenta()));
			parametrosCargos.setNumeroTransaccion(String.valueOf(paramRegCargosDTO.getNumTransaccionVenta()));
			parametrosCargos.setCodigoPlanComercial(paramRegCargosDTO.getPlanComercialCliente());
			parametrosCargos.setCodigoOficina(paramRegCargosDTO.getCodOficinaVendedor());
			parametrosCargos.setCategoriaTributaria(paramRegCargosDTO.getCategTributaria());
			parametrosCargos.setCodigoDocumento(String.valueOf(paramRegCargosDTO.getCodDocumento()));
			parametrosCargos.setTipoFoliacion(paramRegCargosDTO.getTipoFoliacion());
			parametrosCargos.setModalidadVenta(paramRegCargosDTO.getCodModalidadPago());
			parametrosCargos.setFacturacionaCiclo(paramRegCargosDTO.isFacturaACiclo());
			parametrosCargos.setCodigoVendedor(String.valueOf(paramRegCargosDTO.getCodVendedor()));
			parametrosCargos.setCodigoVendedorRaiz(paramRegCargosDTO.getCodVendedorRaiz());
			parametrosCargos.setDatosPrograma(datosPrograma);
			parametrosCargos.setUsuario(paramRegCargosDTO.getUsuario());
			codCiclo=paramRegCargosDTO.getCodCiclo();
			List listaCargos=new ArrayList();
			for (int i=0;i<paramRegCargosDTO.getCargos().length;i++){
				CargosDTO cargo = new CargosDTO();

				PrecioDTO precio = new PrecioDTO();
				precio.setCodigoConcepto(paramRegCargosDTO.getCargos()[i].getPrecio().getCodigoConcepto());
				precio.setMonto(paramRegCargosDTO.getCargos()[i].getPrecio().getMonto()/paramRegCargosDTO.getCargos()[i].getCantidad());
				MonedaDTO moneda = new MonedaDTO();
				moneda.setCodigo(paramRegCargosDTO.getCargos()[i].getPrecio().getUnidad().getCodigo());
				precio.setUnidad(moneda);

				DescuentoDTO[] arregloDescuento = new DescuentoDTO[2];

				/*DescuentoDTO descuento = new DescuentoDTO();
	        	descuento.setTipo(String.valueOf(TipoDescuentos.Manual)); // Manual
	        	descuento.setTipoAplicacion(paramRegCargosDTO.getCargos()[i].getTipoDescuentoManual());//0-Monto 1-Porcentaje
	        	descuento.setMonto(paramRegCargosDTO.getCargos()[i].getMontoDescuentoManual());
	        	descuento.setCodigoConcepto(paramRegCargosDTO.getCargos()[i].getCodigoDescuento());
	        	arregloDescuento[0] = descuento;
	        	descuento = new DescuentoDTO();
	        	descuento.setCodigoConcepto(paramRegCargosDTO.getCargos()[i].getCodigoDescuento());
	        	descuento.setTipo(String.valueOf(TipoDescuentos.Automatico)); // Automatico
	        	descuento.setTipoAplicacion(paramRegCargosDTO.getCargos()[i].getTipoDescuento());//0-Monto 1-Porcentaje
	        	descuento.setMonto(paramRegCargosDTO.getCargos()[i].getMontoDescuento());
	        	arregloDescuento[1] = descuento;*/

				AtributosMigracionDTO atributo = new AtributosMigracionDTO();
				//if (listadoCargos.getObjetoSesion().getParametros().getNumeroCuotas().getCodigo()!=null)
				if (!"".equals(codigoCuotas)){
					//atributo.setCuotas(Integer.parseInt(listadoCargos.getObjetoSesion().getParametros().getNumeroCuotas().getCodigo()));
					atributo.setCuotas(Integer.parseInt(codigoCuotas));
				}
				else
					atributo.setCuotas(0);
				if (paramRegCargosDTO.isFacturaACiclo())
					atributo.setInd_cuota(global.getValor("indicador.cuota.si"));
				else
					atributo.setInd_cuota(global.getValor("indicador.cuota.no"));

				atributo.setInd_equipo(paramRegCargosDTO.getCargos()[i].getPrecio().getDatosAnexos().getInd_equipo());
				atributo.setInd_paquete(paramRegCargosDTO.getCargos()[i].getPrecio().getDatosAnexos().getInd_paquete());
				atributo.setTipoProducto(paramRegCargosDTO.getCargos()[i].getAtributo().getTipoProducto());
				atributo.setCodigoArticuloServicio(paramRegCargosDTO.getCargos()[i].getAtributo().getCodigoArticuloServicio());
				atributo.setCod_tecnologia(paramRegCargosDTO.getCargos()[i].getAtributo().getCodTecnologia());
				atributo.setCodTecnologia(paramRegCargosDTO.getCargos()[i].getAtributo().getCodTecnologia());
				atributo.setNombreUsuario(paramRegCargosDTO.getUsuario());
				atributo.setNumAbonado(paramRegCargosDTO.getCargos()[i].getAtributo().getNumAbonado());
				atributo.setNumSerie(paramRegCargosDTO.getCargos()[i].getAtributo().getNumSerie());
				atributo.setNumTerminal(paramRegCargosDTO.getCargos()[i].getAtributo().getNumTerminal());
				atributo.setNumCelular(paramRegCargosDTO.getCargos()[i].getAtributo().getNumTerminal());



				cargo.setPrecio(precio);
				cargo.setDescuento(paramRegCargosDTO.getCargos()[i].getDescuento());
				cargo.setAtributo(atributo);
				cargo.setCantidad(paramRegCargosDTO.getCargos()[i].getCantidad());
				listaCargos.add(cargo);
			}

			CargosDTO[] arregloCargos =(CargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					listaCargos.toArray(), CargosDTO.class);

			parametrosCargos.setCargos(arregloCargos);
			resultadoRegistro = this.registrarCargos(parametrosCargos);

			/***
			 * Insertar causal de descuento NO VA
			 */
			/*for (int i=0;i<iNumeroCargos;i++){
	        	CausalDescuentoDTO causalDescuentoDTO = new CausalDescuentoDTO();
	        	if (!listadoCargos.getCargos()[i].getMotivoDescuento().equals("-1")){
	        		causalDescuentoDTO.setCOD_CONCEPTO(listadoCargos.getCargos()[i].getCodigoDescuento());
	        		causalDescuentoDTO.setCOD_JUSTIFICACION(listadoCargos.getCargos()[i].getMotivoDescuento());
	        		if (!listadoCargos.getCargos()[i].getCentroCosto().equals("-1"))
	        			causalDescuentoDTO.setCOD_CENTCOS(listadoCargos.getCargos()[i].getCentroCosto());
	        		causalDescuentoDTO.setCOD_VENDEDOR(listadoCargos.getObjetoSesion().getCodigoVendedor());
	        		causalDescuentoDTO.setTIP_DOCUMEN(listadoCargos.getObjetoSesion().getCodigoDocumento());
	        		causalDescuentoDTO.setNumVenta(String.valueOf(listadoCargos.getObjetoSesion().getNumeroVenta()));
	        		ventasFacade.insDocumentoMotivo(causalDescuentoDTO);

	        	}
	        }
			 */

			/**
			 * Obtener Formas de Pago NO VA
			 */

			/*FormasPagoDTO[] formasPago = ventasFacade.obtenerFormasPago(parametrosCargos);

	        if (formasPago!=null){
	        	List listaFormaPago = new ArrayList();
	        	int largoFormadePago = formasPago.length; 
	        	for (int i =1 ; i<largoFormadePago;i++){
	        		FormadePagoDTO formadePago = new FormadePagoDTO();
	        		formadePago.setDescripcionTipoValor(formasPago[i].getDescripcionTipoValor());
	        		formadePago.setTipoValor(formasPago[i].getTipoValor());
	        		listaFormaPago.add(formadePago);
	        	}
	        	FormadePagoDTO[] arrayFormaPago =(FormadePagoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
	        			listaFormaPago.toArray(), FormadePagoDTO.class);
	        	resultado.setArregloFormasdePago(arrayFormaPago);
	        }*/
		}
		//Obtiene datos del presupuesto
		if (resultadoRegistro!= null && resultadoRegistro.getImpuestos()!=null){
			resultado.setNumeroProceso(resultadoRegistro.getImpuestos().getNumeroProceso());
			resultado.setTotalCargos(resultadoRegistro.getImpuestos().getTotalCargos());
			resultado.setTotalDescuentos(resultadoRegistro.getImpuestos().getTotalDescuentos());
			resultado.setTotalImpuestos(resultadoRegistro.getImpuestos().getTotalImpuestos());
		}
		/*else{
        	if (!listadoCargos.getObjetoSesion().isFacturaCiclo()){
            	throw new VentasException("No se pudo rescatar los impuestos");
        	}
        }*/

		logger.debug("registrarCargos():end");
		return resultado;

	} 


	/**
	 *Registra los cargos asociados a la venta
	 * @param ParametrosRegistroCargosDTO cargos
	 * @return 
	 * @throws CustomerDomainException,ProductDomainException,FrameworkCargosException
	 */

	private ResultadoRegistroCargosDTO registrarCargos(ParametrosRegistroCargosDTO cargos)throws FrmkCargosException{
		logger.debug("Inicio:registrarCargos()");
		ResultadoRegistroCargosDTO resultado = new ResultadoRegistroCargosDTO();
		try{
			List listaTareas = new ArrayList();
			ParametrosMotorCargosDTO parametrosMotor = new ParametrosMotorCargosDTO();
			parametrosMotor.setCodigoCliente(cargos.getCodigoCliente());
			parametrosMotor.setNumeroProceso(cargos.getNumeroVenta());
			parametrosMotor.setNumeroTransaccion(cargos.getNumeroTransaccion());
			parametrosMotor.setCodigoProducto(global.getValor("codigo.producto"));
			parametrosMotor.setCodigoSecuenciaCargo(global.getValor("secuencia.cargos"));
			parametrosMotor.setCodigoSecuenciaPaquete(global.getValor("secuencia.paquete"));
			parametrosMotor.setCodigoPlanComercialCliente(cargos.getCodigoPlanComercial());
			parametrosMotor.setParametroDiaVctoFact(global.getValor("parametro.dias.vcto.fact"));
			parametrosMotor.setModuloParametroDiaVctoFact(global.getValor("parametro.dias.vcto.fact"));

			//-- OBTIENE CANTIDAD DE DECIMALES UTILIZADOS EN FACTURACION Y PARA ALMACENAR EN BD
			logger.debug("Inicio:OBTIENE CANTIDAD DE DECIMALES UTILIZADOS EN FACTURACION Y PARA ALMACENAR EN BD");
			DatosGeneralesDTO parametroEntrada = new DatosGeneralesDTO();
			parametroEntrada.setCodigoProducto(global.getValor("codigo.producto"));
			parametroEntrada.setCodigoModulo(global.getValor("codigo.modulo.general"));
			parametroEntrada.setCodigoParametro(global.getValor("parametro.decimal.facturacion"));
			parametroEntrada = datosGeneralesBO.getValorParametro(parametroEntrada);
			//parametrosMotor.setNumeroDecimalesBD(cargos.getNumeroDecimalesBD());
			parametrosMotor.setNumeroDecimalesBD(Integer.parseInt(parametroEntrada.getValorParametro()));
			logger.debug("Fin :OBTIENE CANTIDAD DE DECIMALES UTILIZADOS EN FACTURACION Y PARA ALMACENAR EN BD ["+parametroEntrada.getValorParametro()+"]");
			

			//-- OBTIENE CANTIDAD DE DECIMALES UTILIZADOS PARA FORMATEAR LOS PORCENTAJES DE DESCUENTOS
			logger.debug("Inicio :OBTIENE CANTIDAD DE DECIMALES UTILIZADOS PARA FORMATEAR LOS PORCENTAJES DE DESCUENTOS");
			parametroEntrada.setCodigoParametro(global.getValor("parametro.decimal.descuento"));
			parametrosMotor.setNumeroDecimalesPorDesc((Integer.parseInt(parametroEntrada.getValorParametro())));
			logger.debug("Fin :OBTIENE CANTIDAD DE DECIMALES UTILIZADOS PARA FORMATEAR LOS PORCENTAJES DE DESCUENTOS ["+parametroEntrada.getValorParametro()+"]");
			/*Utilizados para ejecutar el Prebilling*/
			
			
			parametrosMotor.setNombreSecuenciaProcesoFacturacion(global.getValor("secuencia.num.proceso.fac"));
			parametrosMotor.setNombreParametroDocumentoGuia(global.getValor("parametro.documento.guia"));
			parametrosMotor.setModuloParametroDocumentoGuia(global.getValor("codigo.modulo.GA"));
			parametrosMotor.setNombreParametroFacturaGlobal(global.getValor("parametro.factura.global"));
			parametrosMotor.setModuloParametroFacturaGlobal(global.getValor("codigo.modulo.GA"));
			parametrosMotor.setParametroFlagCentroFac(global.getValor("parametro.flag.centro.emision.fact"));
			parametrosMotor.setModuloParametroFlagCentroFac(global.getValor("codigo.modulo.GA"));
			parametrosMotor.setCodigoTipoMovimiento(global.getValor("codigo.tipo.movimiento"));
			parametrosMotor.setCodigoTipoDocumento(cargos.getCodigoDocumento());
			parametrosMotor.setTipoFoliacionDocumento(cargos.getTipoFoliacion());
			parametrosMotor.setCodigoOficina(cargos.getCodigoOficina());
			parametrosMotor.setCategoriaTributaria(cargos.getCategoriaTributaria());
			parametrosMotor.setModalidadVenta(cargos.getModalidadVenta());
			parametrosMotor.setFacturacionaCiclo(cargos.isFacturacionaCiclo());

			parametrosMotor.setUsuario(cargos.getUsuario());
			RegistroFacturacionDTO regFactDTO=new RegistroFacturacionDTO();
			ClienteDTO cliente= new ClienteDTO();
			cliente.setCodCiclo(Integer.parseInt((String.valueOf(codCiclo))));
			regFactDTO=registroFacturacionBO.getCodigoCicloFacturacion(cliente);
			parametrosMotor.setCodigoFacturacion(String.valueOf(regFactDTO.getCodigoCicloFacturacion()));

			ConfiguradorTareaPreliquidacionDTO confPreliquidacion = parametrosPreliquidacion(cargos);
			PreliquidacionVE tareaPreliquidacion = new PreliquidacionVE(confPreliquidacion);

			ProcesadorCargos procesadorCargos = new ProcesadorCargos(parametrosMotor,cargos.getCargos());
			listaTareas.add(tareaPreliquidacion);

			ConfiguradorTareaPrebillingDTO confPrebilling =parametrosPrebilling(cargos);
			confPrebilling.setPrebilling(true);
			PreBillingVE tareaPreBilling = new PreBillingVE(confPrebilling);
			listaTareas.add(tareaPreBilling); 

			TareasRegistroCargos[] arregloTareas =(TareasRegistroCargos[])ArrayUtl.copiaArregloTipoEspecifico(listaTareas.toArray(), 
					TareasRegistroCargos.class);
			logger.debug("Inicio : Antes de Registrar Cargo *************************************************+");
			procesadorCargos.registrarCargos(arregloTareas);
			ImpuestosDTO impuestos = procesadorCargos.obtenerImpuestos();
			resultado.setImpuestos(impuestos);

			BitacoraDTO bitacora = procesadorCargos.obtenerBitacora();
			if (bitacora != null) {
				ProcesoDTO[] procesos = bitacora.getProcesos();
				resultado.setPrebillingOK(true);
				for (int i=0;i<procesos.length;i++){
					if (procesos[i].getIdentificadorProceso() == IdentificadorProceso.EjecutaPrebilling){
						resultado.setPrebillingOK(false);
					}

				}
			}
		}catch(Exception e){
			throw new FrmkCargosException(e);
		}
		logger.debug("Fin:registrarCargos()");
		return resultado;
	}

	private ConfiguradorTareaPreliquidacionDTO parametrosPreliquidacion(ParametrosRegistroCargosDTO parametrosCargos)throws FrameworkCargosException {
		ConfiguradorTareaPreliquidacionDTO configuradorTareas = new ConfiguradorTareaPreliquidacionDTO();
		try{
			configuradorTareas.setNumeroVenta(parametrosCargos.getNumeroVenta());
			configuradorTareas.setCodigoCliente(parametrosCargos.getCodigoCliente());
			configuradorTareas.setModalidadVenta(parametrosCargos.getModalidadVenta());
			configuradorTareas.setCodigoVendedor(parametrosCargos.getCodigoVendedor());
			configuradorTareas.setCodigoVendedorRaiz(parametrosCargos.getCodigoVendedorRaiz());
			configuradorTareas.setArrayCargos(parametrosCargos.getCargos());
			configuradorTareas.setDatosPrograma(parametrosCargos.getDatosPrograma());
		}catch(Exception e){
			throw new FrameworkCargosException(e);
		}	
		return configuradorTareas;
	}


	/**
	 *Metodo privado que genera los parametros necesarios para ejecutar la tarea prebilling
	 * @param  parametrosCargos
	 * @return configuradorTareas
	 * @throws 
	 */

	private ConfiguradorTareaPrebillingDTO parametrosPrebilling(ParametrosRegistroCargosDTO parametrosCargos)throws FrameworkCargosException{
		ConfiguradorTareaPrebillingDTO configuradorTareas = new ConfiguradorTareaPrebillingDTO();
		try{
			configuradorTareas.setCodigoCliente(parametrosCargos.getCodigoCliente());
			configuradorTareas.setNumeroVenta(parametrosCargos.getNumeroVenta());
			configuradorTareas.setNumeroTransaccionVenta(parametrosCargos.getNumeroTransaccion());
			configuradorTareas.setCategoriaTributaria(parametrosCargos.getCategoriaTributaria());
			configuradorTareas.setNombreSecuenciaTransacabo(global.getValor("secuencia.transacabo"));
			configuradorTareas.setActuacionPrebilling(global.getValor("codigo.actuacion.prebilling"));
			configuradorTareas.setProductoGeneral(global.getValor("codigo.producto.general"));
			configuradorTareas.setFacturacionaCiclo(parametrosCargos.isFacturacionaCiclo());
			configuradorTareas.setPrebilling(true);
		}catch(Exception e){
			throw new FrameworkCargosException(e);
		}	
		return configuradorTareas;
	}

	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Kit
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaKit
	 * @throws CustomerDomainException,ProductDomainException
	 */
	private ParametrosReglasKitDTO getParametrosReglaKit(ParametrosObtencionCargosDTO parametros,AbonadoDTOInt abonado) throws GeneralException{
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();

		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		//Obtiene datos del plan tarifario
		String usoLinea = null;
		planTarifario.setCodigoTecnologia(abonado.getCodTecnologia());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.postpago"))){
			usoLinea =  global.getValor("codigo.uso.postpago");
		}else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.hibrido"))){
			usoLinea =  global.getValor("codigo.uso.hibrido");
		}else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.prepago"))){
			usoLinea =  global.getValor("codigo.uso.prepago");
		}

		//-- OBTIENE PARAMETRO : PRECIO LISTA

		String sPrecioLista = global.getValor("indicador.precio.lista");

		logger.debug("getParametrosReglaSimcard sPrecioLista ["+sPrecioLista+"]");


		//-- OBTIENE PARAMETRO : GRUPO TECNOLOGIA GSM
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.grupotecgsm"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		String sGrupoTecGSM = parametrosGral.getValorparametro();

		//-- OBTIENE PARAMETRO : GRUPO TECNOLOGICO
		parametrosGral.setNombreparametro(abonado.getCodTecnologia());
		parametrosGral = parametrosGeneralesBO.getParametroGrupoTecnologico(parametrosGral);
		String sGrupoTecnologico = parametrosGral.getValorparametro();


		KitDTO kit = new KitDTO();
		ParametrosReglasKitDTO parametroReglaKit = new ParametrosReglasKitDTO();
		kit.setNumeroSerie(abonado.getNumeroSerie());
		kit = kitBO.getKit(kit);

		parametroReglaKit.setCodigoArticulo(kit.getCodigoArticulo());
		parametroReglaKit.setTipoStock(kit.getTipoStock());
		parametroReglaKit.setCodigoUso(usoLinea);
		parametroReglaKit.setEstado(global.getValor("estado.articulo"));		
		parametroReglaKit.setIndicadorValorar(kit.getIndicadorValorar());
		parametroReglaKit.setIndicadorPrecioLista(sPrecioLista);
		parametroReglaKit.setGrupoTecnologiaGSM(sGrupoTecGSM);
		parametroReglaKit.setGrupoTecnologico(sGrupoTecnologico);
		parametroReglaKit.setIndiceRecambioPrecioLista(global.getValor("indice.recambio.preciolista"));
		parametroReglaKit.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
		parametroReglaKit.setCodigoCategoria(global.getValor("codigo.categoria"));
		parametroReglaKit.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametroReglaKit.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		parametroReglaKit.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
		parametroReglaKit.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametroReglaKit.setNumAbonado("");
		parametroReglaKit.setNumCelular("");
		parametroReglaKit.setNumSerie(abonado.getNumeroSerie());		
		parametroReglaKit.setCodTecnologia(abonado.getCodTecnologia());

		/*-- Inicio Parametros Descuentos --*/
		ParametrosDescuentoDTO parametrosDescuentoKit = new ParametrosDescuentoDTO();
		parametrosDescuentoKit.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoKit.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
			parametrosDescuentoKit.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
		else
			parametrosDescuentoKit.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
		parametrosDescuentoKit.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));		
		parametrosDescuentoKit.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoKit.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoKit.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoKit.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
		parametrosDescuentoKit.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoKit.setCodigoArticulo(kit.getCodigoArticulo());



		parametrosDescuentoKit.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan());

		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoKit.setCodAbonocel(parametrosGral.getValorparametro());

		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoKit.setClaseDescuento(parametrosGral.getValorparametro());


		PlanTarifarioDTO planTarifario2 = new PlanTarifarioDTO();
		planTarifario2.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario2 = planTarifarioBO.getCategoriaPlanTarifario(planTarifario2);
		parametrosDescuentoKit.setCodigoCategoria(planTarifario2.getCodigoCategoria());


		parametrosDescuentoKit.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoKit.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));

		if (abonado.getCodUso().equals("3")){
			parametrosDescuentoKit.setCodigoOperacion(global.getValor("codigo.operacion.prepago"));
		}else{
			parametrosDescuentoKit.setCodigoOperacion(global.getValor("codigo.operacion"));
		}

		//parametrosDescuentoSimcard.setCodigoOperacion(global.getValor("codigo.operacion"));
		parametrosDescuentoKit.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoKit.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoKit.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametroReglaKit.setParametrosDescuento(parametrosDescuentoKit);

		return parametroReglaKit;
	}

}
