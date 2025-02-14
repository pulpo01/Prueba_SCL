/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 04/04/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.frameworkcargossrv.service.implementacion;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.helper.Global;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasSegmentacionDTO;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.ServiciosVentaBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ServiciosVentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ServiciosVentaBOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.TipoComisionistaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DocumentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ParametrosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SegmentacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ServicioOcasionalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.TerminalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SegmentacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SegmentacionBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GaSegmentacionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GaSegmentacionCargosListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoSegmentacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.interfaz.ClaseProductos;
import com.tmmas.scl.framework.productDomain.interfaz.ListaProductos;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;


public class ReglasSegmentacion extends ReglaListaPrecio{
	private final Logger logger = Logger.getLogger(ReglasSegmentacion.class);
	private Global global = Global.getInstance();
	private ParametrosReglasSegmentacionDTO parametrosRegla;
	private ParametrosCargoSegmentacionDTO segmentacionCargos;
  
	
    private TerminalBOFactoryIT TerminalFactory=new TerminalBOFactory();
	private TerminalBOIT terminalBO=TerminalFactory.getBusinessObject1();


	private DocumentoBOFactoryIT docFactory =new DocumentoBOFactory();
	private DocumentoBOIT documentoBO=docFactory.getBusinessObject1();
	

	private RegistroFacturacionBOFactoryIT regFactFactory=new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT registroFacturacionBO=regFactFactory.getBusinessObject1();

	
	private PlanTarifarioBOFactoryIT planTarifFactory =new PlanTarifarioBOFactory();
	private PlanTarifarioIT planTarifarioBO=planTarifFactory.getBusinessObject1();
	
	private SegmentacionBOFactoryIT segFactory=new SegmentacionBOFactory();
	private SegmentacionBOIT segmentacionBO=segFactory.getBusinessObject1();
	
	private ParametrosGeneralesBOFactoryIT parmGenFactory= new ParametrosGeneralesBOFactory();
	private ParametrosGeneralesIT parametroGeneralesBO=parmGenFactory.getBusinessObject1();
	
	private ParametrosGeneralesBOFactoryIT paramGeneFactory=new ParametrosGeneralesBOFactory();
	private ParametrosGeneralesIT paramGenerBO=paramGeneFactory.getBusinessObject1();
	
	private ServicioOcasionalBOFactoryIT servOcFactory=new ServicioOcasionalBOFactory();
	private ServicioOcasionalBOIT servicioOcasionalBO=servOcFactory.getBusinessObject1();
	
	private ServiciosVentaBOFactoryIT serVentaFactory =new ServiciosVentaBOFactory();
	private ServiciosVentaBOIT serviciosVentaBO=serVentaFactory.getBusinessObject1();
	
	PrecioDTO[] arregloPrecios = null;
	
	
   // private String codTipPlanTarifDest; //1: Prepago, 2:PostPago, 3:Hibrido
    
	
	public ReglasSegmentacion(ParametrosReglasSegmentacionDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasTerminal

	public PrecioDTO[] seleccionPrecios() throws FrameworkCargosException{
		logger.debug("Inicio:seleccionPrecios Segmentacion()");
		
		segmentacionCargos = new ParametrosCargoSegmentacionDTO();
		
		ArrayList listaPreciosCargos = new ArrayList();
		PrecioCargoDTO[] arregloPreciosCargos = null;
		//PrecioDTO[] arregloPrecios = null;

		try {
						
			//TODO: Cargamos Plan Tarifario
			
			PlanTarifarioDTO planTarifOrigen= new PlanTarifarioDTO();
			planTarifOrigen.setCodigoProducto(parametrosRegla.getCodigoProducto());
			planTarifOrigen.setCodigoTecnologia(parametrosRegla.getCodigoTecnologia());
			planTarifOrigen.setCodigoPlanTarifario(parametrosRegla.getCodigoPlanTarifOrigen());
 			planTarifOrigen=planTarifarioBO.getPlanTarifario(planTarifOrigen);
			
			PlanTarifarioDTO planTarifDestino= new PlanTarifarioDTO();
			planTarifDestino.setCodigoProducto(parametrosRegla.getCodigoProducto());
			planTarifDestino.setCodigoTecnologia(parametrosRegla.getCodigoTecnologia());
			planTarifDestino.setCodigoPlanTarifario(parametrosRegla.getCodigoPlanTarifDestino());
			planTarifDestino=planTarifarioBO.getPlanTarifario(planTarifDestino);
 			
			//codTipPlanTarifDest=planTarifDestino.getCodigoTipoPlan();
			String impCargoOrigen =String.valueOf(planTarifOrigen.getImporteCargoBasico());
			
			String impCargoDestino=String.valueOf(planTarifDestino.getImporteCargoBasico());
			impCargoOrigen=impCargoOrigen==null?"0":impCargoOrigen.trim();
			impCargoDestino=impCargoDestino==null?"0":impCargoDestino.trim();
			
			//boolean EvalImpCargoDestino= (Double.valueOf(impCargoDestino).doubleValue()< Double.valueOf(impCargoOrigen).doubleValue())?true:false;
			boolean EvalImpCargoDestino= true;
			
			String cargoBasdestino =planTarifDestino.getCodigoCargoBasico()==null?"":planTarifDestino.getCodigoCargoBasico();
			ParametrosGeneralesDTO paramGenDTO= new ParametrosGeneralesDTO();
			String valorParametro=null;
			String codParametro=null;
			//codigo valor del cliente Plati, A
			
			
			codParametro=codParametro==null?"":codParametro.trim();
			boolean aplicaCargos=false;
			String codCambioPlan=parametrosRegla.getCodCausaCambioPlan();
			codCambioPlan=codCambioPlan==null?"":codCambioPlan.trim();
			long meses=0;
			if (cargoBasdestino.equals("")){
				paramGenDTO.setCodigomodulo(parametrosRegla.getCodigoModulo());
				paramGenDTO.setCodigoproducto(parametrosRegla.getCodigoProducto());
				paramGenDTO.setNombreparametro(parametrosRegla.getNombreParametro1());
				paramGenDTO =parametroGeneralesBO.getParametroGeneral(paramGenDTO);
				valorParametro=paramGenDTO.getValorparametro();
				paramGenDTO.setNombreparametro(parametrosRegla.getNombreParametro2());
				paramGenDTO =parametroGeneralesBO.getParametroGeneral(paramGenDTO);
				codParametro= paramGenDTO.getValorparametro();
			
			
			Calendar cal=Calendar.getInstance();
			cal.setTime(parametrosRegla.getFechaAceptacionVenta()==null?cal.getTime():parametrosRegla.getFechaAceptacionVenta());
			cal.add(Calendar.MONTH, Integer.parseInt(valorParametro));
			Calendar now=Calendar.getInstance();
			meses=now.getTimeInMillis()-cal.getTimeInMillis();
			meses=meses/1000; //Segundos entre las fechas procesadas
			meses=meses/3600; //Horas entre las fechas procesadas
			meses=meses/24; //Dias entre las fechas procesadas
			meses=meses/30; // Cantidad de Meses entre las fechas procesadas
			
			}
			if (meses>0){
				if (meses>0&&codCambioPlan.equals(codParametro)){
					aplicaCargos=false; //no se cobfran cargos por permanencia
				}
			}
			else if(String.valueOf(meses).equals("0")){
				//se aplican cargos por permanencia 
				aplicaCargos=true;
			}
			
			//TODO: Cargamos Lista de Cargos por Segmentación
			GaSegmentacionCargosDTO segCargoDTO=new GaSegmentacionCargosDTO();
			GaSegmentacionCargosListDTO GaSegCargosListDTO = new GaSegmentacionCargosListDTO();
			// codigo segementacion origen : 1: prepago, 2:postpago, 3:hibrido
			String codtipPlanOrg=planTarifOrigen.getCodigoTipoPlan();
			codtipPlanOrg=codtipPlanOrg==null||codtipPlanOrg.trim().equals("")?"0":codtipPlanOrg;
			
			String codtipPlanDes=planTarifDestino.getCodigoTipoPlan();
			codtipPlanDes=codtipPlanDes==null||codtipPlanDes.trim().equals("")?"0":codtipPlanDes;
			
			logger.debug("segCargoDTO.setCod_seg_orig = codtipPlanOrg ="+codtipPlanOrg);
			logger.debug("segCargoDTO.setCod_seg_des = codtipPlanDes ="+codtipPlanDes);
			
			segCargoDTO.setCod_seg_orig(Long.parseLong(codtipPlanOrg));
			segCargoDTO.setCod_seg_des(Long.parseLong(codtipPlanDes));
			//logica de consulta para seteo de variable de tiposegmentacion del cliente Alto medio ,bajo platino
			//Contemplar si en CPU se puede asignar nuevo cliente a un abonado,
			
			/*segCargoDTO.setTipo_seg_orig("A");
			segCargoDTO.setTipo_seg_des("PLATI");
			segCargoDTO.setCod_seg_orig(2);
			segCargoDTO.setCod_seg_des(1);*/
			
			logger.debug("segCargoDTO.setTipo_seg_orig = parametrosRegla.getTipoSegOrigen ="+parametrosRegla.getTipoSegOrigen());
			logger.debug("segCargoDTO.setTipo_seg_des = parametrosRegla.getTipoSegDestino ="+parametrosRegla.getTipoSegDestino());
			
			segCargoDTO.setTipo_seg_orig(parametrosRegla.getTipoSegOrigen());
			segCargoDTO.setTipo_seg_des(parametrosRegla.getTipoSegDestino());
			segCargoDTO.setCodTipoCargoSegm(parametrosRegla.getGedCodigoTipoCargoSegm());
			/*segCargoDTO.setCod_seg_orig(Long.parseLong(planTarifOrigen.getCodigoTipoPlan()));
			segCargoDTO.setCod_seg_des(Long.parseLong(planTarifDestino.getCodigoTipoPlan()));*/
			
			GaSegCargosListDTO =segmentacionBO.obtenerListaSegmentacionCargos(segCargoDTO);
			String tipoCargo=null;
			double impCargo=0;
			boolean existCarg=false;
			boolean llenar=false;
			
			for (int i=0;i<GaSegCargosListDTO.getGaSegmentacionCargosDTO().length;i++){
			//TODO: evaluamos los importes de cargo origen y destino  el destino mayor q origen =TRUE
				existCarg=true;
				llenar=false;
				//Se procede a Evaluar los cargos correspondientes
				tipoCargo=String.valueOf(GaSegCargosListDTO.getGaSegmentacionCargosDTO()[i].getTipo_cargo());
				// cargos basicos valor =1
				if (tipoCargo.equals(global.getValor("parametro.valor.cargobasico"))){
					llenar=true;
					impCargo=GaSegCargosListDTO.getGaSegmentacionCargosDTO()[i].getImp_cargo();
					//impCargo =((Double.parseDouble(impCargoDestino)-(Double.parseDouble(impCargoDestino)*impCargo)/100));
					impCargo =(Double.parseDouble(impCargoDestino)*impCargo)/100;
				}
				else if (tipoCargo.equals(global.getValor("parametro.valor.operacion"))){
					llenar=true;
					impCargo=GaSegCargosListDTO.getGaSegmentacionCargosDTO()[i].getImp_cargo();
				}
				else if (tipoCargo.equals(global.getValor("parametro.valor.indemnizacion"))){
					
					if (EvalImpCargoDestino){
						llenar=true;
						impCargo=GaSegCargosListDTO.getGaSegmentacionCargosDTO()[i].getImp_cargo();
					}
					
					
				}
				else if (tipoCargo.equals(global.getValor("parametro.valor.clausulapermanencia"))){
					if (aplicaCargos){
						llenar=true;
						impCargo=GaSegCargosListDTO.getGaSegmentacionCargosDTO()[i].getImp_cargo();
					}
				}
			PrecioCargoDTO precioDTO=new PrecioCargoDTO();	
			if (llenar){
				
				String codigoConcepto=String.valueOf(GaSegCargosListDTO.getGaSegmentacionCargosDTO()[i].getCod_concepto());
				precioDTO.setCodigoConcepto(codigoConcepto);
				String descripConcepto=GaSegCargosListDTO.getGaSegmentacionCargosDTO()[i].getDes_concepto();
				precioDTO.setDescripcionConcepto(descripConcepto);
				float monto=Float.parseFloat(String.valueOf(impCargo));
				precioDTO.setMonto(monto);
				String codMoneda=GaSegCargosListDTO.getGaSegmentacionCargosDTO()[i].getCod_moneda();
				String descMoneda=GaSegCargosListDTO.getGaSegmentacionCargosDTO()[i].getDes_moneda();
				precioDTO.setCodigoMoneda(codMoneda);
				precioDTO.setDescripcionMoneda(descMoneda);
				precioDTO.setValorMaximo(global.getValor("parametro.valor.maximo"));
				precioDTO.setValorMinimo(global.getValor("parametro.valor.minimo"));
				precioDTO.setIndicadorAutMan("A");
				//arregloPreciosCargos[i].setIndicadorPaquete(parametrosRegla);
				//arregloPreciosCargos[i].setIndicadorEquipo(parametrosRegla);
				listaPreciosCargos.add(precioDTO);
			}
			
			}//For
			
			arregloPreciosCargos=(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaPreciosCargos.toArray(), PrecioCargoDTO.class);
			
			ArrayList listaPrecios = new ArrayList();
			if (existCarg){
				for (int indice = 0; indice < arregloPreciosCargos.length; indice++) {
					PrecioDTO precio = new PrecioDTO();
		        	precio.setCodigoConcepto(arregloPreciosCargos[indice].getCodigoConcepto());
		        	precio.setDescripcionConcepto(arregloPreciosCargos[indice].getDescripcionConcepto());
		        	precio.setMonto(arregloPreciosCargos[indice].getMonto());
		        	//precio.setValorMaximo(arregloPreciosCargos[indice].getValorMaximo());
		        	//precio.setValorMinimo(arregloPreciosCargos[indice].getValorMinimo());
		        	//codigoConceptoCargo=arregloPreciosCargos[indice].getCodigoConcepto();
					MonedaDTO moneda = new MonedaDTO();
					moneda.setCodigo(arregloPreciosCargos[indice].getCodigoMoneda());
		        	moneda.setDescripcion(arregloPreciosCargos[indice].getDescripcionMoneda());
		        	precio.setUnidad(moneda);
		        	AtributosMigracionDTO atributos = new AtributosMigracionDTO();
		        	atributos.setInd_paquete(arregloPreciosCargos[indice].getIndicadorPaquete());
		        	atributos.setInd_equipo(arregloPreciosCargos[indice].getIndicadorEquipo());
		        	//atributos.setNumAbonado(parametrosRegla.getNumAbonado());
		        	atributos.setCodTipPlantarifOrig(planTarifOrigen.getCodigoTipoPlan());
		        	atributos.setCodTipPlantarifDes(planTarifDestino.getCodigoTipoPlan());
		        	atributos.setNumAbonado(parametrosRegla.getNumAbonado());
		        	precio.setDatosAnexos(atributos);
		        	precio.setIndicadorAutMan(arregloPreciosCargos[indice].getIndicadorAutMan());
		        	//precio.setIndicadorAutMan(global.getValor("indicador.automatico.cargo"));
		        	
		        	listaPrecios.add(precio);
		        }//fin for
			}
			arregloPrecios =(PrecioDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaPrecios.toArray(),PrecioDTO.class);
			/*if (arregloPrecios!=null)
			//	if (arregloPrecios.length>0)
					codigoConceptoCargo = arregloPrecios[0].getCodigoConcepto();*/
		} catch (GeneralException e) {
			// TODO Auto-generated catch block
			throw new FrameworkCargosException(e);
		}
		 
		//logger.debug("Fin:seleccionPrecios()+arregloPreciosCargos.length: " + arregloPreciosCargos.length);
		
		return arregloPrecios;
	}//fin seleccionPrecios
	
	/**
	 *Busca los descuentos asocaidos a la regla
	 * @param 
	 * @return arregloDescuentos
	 * @throws FrameworkCargosException
	 */

	public DescuentoDTO[] seleccionDescuentos() throws FrameworkCargosException{
		logger.debug("Inicio:seleccionDescuentos()");
		DescuentoDTO[] arregloDescuentosAutomaticos = null;
		DescuentoDTO[] arregloDescuentos = null;
		List listaDescuentos = null;
		try {
			ParametrosDescuentoDTO parametrosDescto = parametrosRegla.getParametrosDescuento();
		boolean existParamDesc=parametrosDescto==null?false:true;
			//Obtiene Promedio Facturado a Cliente
		
		if (existParamDesc){	 
			for (int i=0;i<arregloPrecios.length;i++){
				DocumentoFacturacionDTO documento = new DocumentoFacturacionDTO();
				String indCiclo=parametrosDescto.getIndicadorCiclo();
				indCiclo=indCiclo==null||indCiclo.trim().equals("")?"0":indCiclo;
				documento.setIndiceCiclo(indCiclo); 
				String numMesfact=String.valueOf(parametrosDescto.getNumeroMesesFact())==null?"0":String.valueOf(parametrosDescto.getNumeroMesesFact());
				documento.setNumeroMeses(Integer.parseInt(numMesfact));
				documento.setCodigoCliente(String.valueOf(parametrosRegla.getCodClienteDes()));
				documento = documentoBO.getPromedioDocumentosFacturados(documento);
				logger.debug("documento.getPromedioFacturado()::::::::::::: ::."+documento.getPromedioFacturado());
				parametrosDescto.setValorPromedioFact(documento.getPromedioFacturado());
				
	            //Obtiene Codigo Promedio Facturado a Cliente
				RegistroFacturacionDTO registroFac = new RegistroFacturacionDTO();
				registroFac.setValorPromedio(parametrosDescto.getValorPromedioFact());
				registroFac = registroFacturacionBO.getCodigoPromedioFacturado(registroFac);
				
								
				parametrosDescto.setCodigoPromedioFacturable(String.valueOf(registroFac.getCodigoPromedio()));
				ParametrosGeneralesDTO paramGeneralDTO =new ParametrosGeneralesDTO (); 
			
				//TODO: Obtención de Parametros de Decuentos Automáticos por:
				// 1. Concepto : VAL_PARAMETRO = 'CON' 
				// 2. Artículo : VAL_PARAMETRO = 'ART'
				
				paramGeneralDTO.setCodigomodulo(parametrosRegla.getCodigoModulo()); //GA
				paramGeneralDTO.setCodigoproducto(parametrosRegla.getCodigoProducto());//1
				paramGeneralDTO.setNombreparametro(parametrosRegla.getNombreClaseDescuento());
				
				paramGeneralDTO=paramGenerBO.getParametroGeneral(paramGeneralDTO);
				parametrosDescto.setClaseDescuento(paramGeneralDTO.getValorparametro());
				//Se aplica validación para clase-descuento 
				ArticuloDTO articuloDTO=new ArticuloDTO();  
				articuloDTO.setCod_conceptoart(Integer.parseInt(arregloPrecios[i].getCodigoConcepto()));
				String codConceptoDesc=servicioOcasionalBO.existeCodigoConceptoArticulo(articuloDTO)?"ART":"CON";
				parametrosDescto.setClaseDescuento(codConceptoDesc);
				VendedorDTO vendedorDTO=new VendedorDTO();
				vendedorDTO.setCodigoVendedor(parametrosDescto.getCodigoVendedor());
				TipoComisionistaDTO tipoComisionistaDTO=new TipoComisionistaDTO();
				tipoComisionistaDTO=serviciosVentaBO.ObtieneComisPorVendedor(vendedorDTO);
				parametrosDescto.setCodigoCausaVenta(parametrosRegla.getParametrosDescuento().getCodigoCausaVenta());
				parametrosDescto.setIndiceVentaExterna(tipoComisionistaDTO.getIndExterno());
				parametrosDescto.setCodigoTipoPlanTarifario(arregloPrecios[i].getDatosAnexos().getCodTipPlantarifDes());
				parametrosDescto.setCodigoConcepto(arregloPrecios[i].getCodigoConcepto());
				parametrosDescto.setCodigoModalidadVenta(parametrosRegla.getParametrosDescuento().getCodigoModalidadVenta());
				String numMesesContrato=String.valueOf(parametrosDescto.getNumeroMesesContrato());
				numMesesContrato=numMesesContrato==null||numMesesContrato.trim().equals("")?"0":numMesesContrato;
				String numMesesFact=String.valueOf(parametrosDescto.getNumeroMesesFact());
				numMesesFact=numMesesFact==null||numMesesFact.trim().equals("")?"0":numMesesFact;
				parametrosDescto.setNumeroMesesFact(Integer.parseInt(numMesesFact));
				parametrosDescto.setNumeroMesesContrato(Integer.parseInt(numMesesContrato));
				parametrosDescto.setNumeroMesesNuevo(numMesesContrato);
				//Obtiene Descuento Automatico
				arregloDescuentosAutomaticos = servicioOcasionalBO.getDescuentoCargo(parametrosDescto);
				
				for (int indice = 0; (arregloDescuentosAutomaticos!=null&&indice < arregloDescuentosAutomaticos.length); indice++) {
					listaDescuentos = new ArrayList();
					arregloDescuentosAutomaticos[indice].setTipo(String.valueOf(TipoDescuentos.Automatico));
					arregloDescuentosAutomaticos[indice].setCodigoConceptoCargo(arregloPrecios[i].getCodigoConcepto());
					listaDescuentos.add(arregloDescuentosAutomaticos[indice]);
		        }//fin for
				          
		        //Obtiene concepto descuento manual.
				ParametrosDescuentoDTO parametrosDescuentoManual = new ParametrosDescuentoDTO();
		        parametrosDescuentoManual.setCodigoConcepto(arregloPrecios[i].getCodigoConcepto());
				parametrosDescuentoManual.setTipoConcepto(parametrosDescto.getTipoConceptoDescuento());
		        //TODO :Analizar el uso de este proceso, probablemente no se usa
				DescuentoDTO descuentoManual = terminalBO.getCodigoDescuentoManual(parametrosDescuentoManual);
		        //listaDescuentos.add(descuentoManual);
			}
			if (listaDescuentos!=null){
		        arregloDescuentos =(DescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaDescuentos.toArray(),DescuentoDTO.class);
			}
		}
	        
	    } catch (GeneralException e) {
			// TODO Auto-generated catch block
			throw new FrameworkCargosException(e);
		}
		
		 
		 
		logger.debug("Fin:seleccionDescuentos()");
		return arregloDescuentos;
	}//fin seleccionDescuentos
	
	/**
	 *Retorna los atributos asocaidos a la regla
	 * @param 
	 * @return boolean 
	 * @throws 
	 */

	public boolean validacion() {
		logger.debug("Inicio:validacion()");

/*		   
		If DatVenta.Ind_Comodato = "1" Then
		      bCarCargosEquip = True
		      Exit Function
		   End If
		   
		   If DatVenta.IndCuota = "2" Or DatVenta.IndCuota = "-1" Then
		      ' Arriendo, no se generan cargos por el equipo.
		      bCarCargosEquip = True
		      Exit Function
		   End If
*/
		try{
			
			/*TerminalDTO terminaldto = new TerminalDTO();
			logger.debug("numero serie prueba:" + parametrosRegla.getNumeroSerie());
			terminaldto.setNumeroSerie(parametrosRegla.getNumeroSerie());
			terminaldto = terminalBO.getTerminal(terminaldto);
			if (!terminaldto.getIndProcEq().equals(IndProcedencia)) 
				return false;
			if (!parametrosRegla.getIndicadorValorar().equals(IndValorar)) 
				return false;*/
			//parametrosRegla
			
			logger.debug("Fin:validacion()");
			return true;
		}catch (Exception e){
			e.printStackTrace();
			
		}
		logger.debug("Fin:validacion()");
		return false;
		
	}//fin validacion
	
	/**
	 *Retorna los atributos asociados a la regla
	 * @param 
	 * @return parametrosRegla 
	 * @throws FrameworkCargosException
	 */
	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		logger.debug("Inicio:getAtributos()");
		
		AtributosCargoDTO atributos = new AtributosCargoDTO();
		atributos.setTipoProducto(ListaProductos.Terminal);
		atributos.setClaseProducto(ClaseProductos.Bien);
		atributos.setNumAbonado(parametrosRegla.getNumAbonado());
		parametrosRegla.setAtributos(atributos);
		logger.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos

}//fin ReglasTerminal
