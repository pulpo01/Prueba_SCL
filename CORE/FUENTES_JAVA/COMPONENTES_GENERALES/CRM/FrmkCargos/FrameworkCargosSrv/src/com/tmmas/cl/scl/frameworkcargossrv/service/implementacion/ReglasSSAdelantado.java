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
import java.util.List;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.helper.Global;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasSSAdelantadoDTO;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.ServiciosVentaBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ServiciosVentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ServiciosVentaBOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaSSAdelantadoCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaSSAdelantadoCargosListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.TipoComisionistaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DocumentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ParametrosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ServicioOcasionalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.TerminalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.interfaz.ClaseProductos;
import com.tmmas.scl.framework.productDomain.interfaz.ListaProductos;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;


public class ReglasSSAdelantado extends ReglaListaPrecio{
	private final Logger logger = Logger.getLogger(ReglasSSAdelantado.class);
	private Global global = Global.getInstance();
	private ParametrosReglasSSAdelantadoDTO parametrosRegla;
	//private ParametrosCargoSSAdelantadoDTO SSAdelantadoCargos;
  
	
    private TerminalBOFactoryIT TerminalFactory=new TerminalBOFactory();
	private TerminalBOIT terminalBO=TerminalFactory.getBusinessObject1();


	private DocumentoBOFactoryIT docFactory =new DocumentoBOFactory();
	private DocumentoBOIT documentoBO=docFactory.getBusinessObject1();
	

	private RegistroFacturacionBOFactoryIT regFactFactory=new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT registroFacturacionBO=regFactFactory.getBusinessObject1();
	
	private ParametrosGeneralesBOFactoryIT paramGeneFactory=new ParametrosGeneralesBOFactory();
	private ParametrosGeneralesIT paramGenerBO=paramGeneFactory.getBusinessObject1();
	
	private ServicioOcasionalBOFactoryIT servOcFactory=new ServicioOcasionalBOFactory();
	private ServicioOcasionalBOIT servicioOcasionalBO=servOcFactory.getBusinessObject1();
	
	private ServiciosVentaBOFactoryIT serVentaFactory =new ServiciosVentaBOFactory();
	private ServiciosVentaBOIT serviciosVentaBO=serVentaFactory.getBusinessObject1();
	
	private CargoBOFactoryIT cargoBoFactory = new CargoBOFactory();
	private CargoIT cargoBO=cargoBoFactory.getBusinessObject1();
	
	PrecioDTO[] arregloPrecios = null;
	
	
   // private String codTipPlanTarifDest; //1: Prepago, 2:PostPago, 3:Hibrido
    
	
	public ReglasSSAdelantado(ParametrosReglasSSAdelantadoDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasTerminal

	public PrecioDTO[] seleccionPrecios() throws FrameworkCargosException{
		logger.debug("Inicio:seleccionPrecios SSAdelantado()");
		
	//	SSAdelantadoCargos = new ParametrosCargoSSAdelantadoDTO();
		
		ArrayList listaPreciosCargos = new ArrayList();
		PrecioCargoDTO[] arregloPreciosCargos = null;
		//PrecioDTO[] arregloPrecios = null;

		try {
						
		
			//TODO: Cargamos Lista de Cargos por SSAdelantado
			GaSSAdelantadoCargosDTO SSAdelantadoCargoDTO=new GaSSAdelantadoCargosDTO();
			GaSSAdelantadoCargosListDTO gaSSAdelantadoCargosListDTO = new GaSSAdelantadoCargosListDTO();
			
			
			/*String codtipPlanOrg=planTarifOrigen.getCodigoTipoPlan();
			codtipPlanOrg=codtipPlanOrg==null||codtipPlanOrg.trim().equals("")?"0":codtipPlanOrg;*/
			
			
			
		//	logger.debug("SSAdelantadoCargoDTO.setCod_seg_orig = codtipPlanOrg ="+codtipPlanOrg);
			
			//TODO verificar ingreso de parametros
			/**SSAdelantadoCargoDTO.setCod_seg_orig(Long.parseLong(codtipPlanOrg));
			SSAdelantadoCargoDTO.setCod_seg_des(Long.parseLong(codtipPlanDes));
			*/
			
			logger.debug("Parametros regla : ReglasSSAdelantado ::");
			
			SSAdelantadoCargoDTO.setCodCliente(parametrosRegla.getCodigoCliente());
			logger.debug("Código Cliente : "+SSAdelantadoCargoDTO.getCodCliente());
			SSAdelantadoCargoDTO.setNumAbonado(parametrosRegla.getNumAbonado());
			logger.debug("NumeroAbonado : "+SSAdelantadoCargoDTO.getNumAbonado());
			SSAdelantadoCargoDTO.setCadenaSS(parametrosRegla.getCodCausaCambioPlan());
			logger.debug("Cadena SS : "+SSAdelantadoCargoDTO.getCadenaSS());
			SSAdelantadoCargoDTO.setCodActabo("SS");
			logger.debug("Código Actabo: "+SSAdelantadoCargoDTO.getCodActabo());
			SSAdelantadoCargoDTO.setCodModulo(parametrosRegla.getCodigoModulo());
			logger.debug("Código Módulo : "+SSAdelantadoCargoDTO.getCodModulo());
			SSAdelantadoCargoDTO.setCodOS(parametrosRegla.getCodOS());
			logger.debug("Código OS : "+SSAdelantadoCargoDTO.getCodOS());
			SSAdelantadoCargoDTO.setCodProducto(parametrosRegla.getCodigoProducto());
			logger.debug("Código Producto : "+SSAdelantadoCargoDTO.getCodProducto());
			SSAdelantadoCargoDTO.setCodTecnologia(parametrosRegla.getCodigoTecnologia());
			logger.debug("Código Tecnologia : "+SSAdelantadoCargoDTO.getCodTecnologia());
			SSAdelantadoCargoDTO.setSeqNumOs(parametrosRegla.getNumProceso());
			logger.debug("Seq Número OS : "+SSAdelantadoCargoDTO.getSeqNumOs());
			SSAdelantadoCargoDTO.setTipPantalla(parametrosRegla.getTipoPantalla());
			logger.debug("Tipo Pantalla : "+SSAdelantadoCargoDTO.getTipPantalla());
			SSAdelantadoCargoDTO.setCodPlanServ(parametrosRegla.getCodPlanServ());
			logger.debug("Codigo Plan Serv: "+SSAdelantadoCargoDTO.getCodPlanServ());
					
			gaSSAdelantadoCargosListDTO =cargoBO.obtenerListaSSAdelantadoCargos(SSAdelantadoCargoDTO);
			
			boolean isPrecios=gaSSAdelantadoCargosListDTO!=null&&gaSSAdelantadoCargosListDTO.getGaSSAdelantadoCargosDTO()!=null&&
			gaSSAdelantadoCargosListDTO.getGaSSAdelantadoCargosDTO().length>0? true:false;
			
			if (isPrecios)
			{
				;
				for (int i=0;i<gaSSAdelantadoCargosListDTO.getGaSSAdelantadoCargosDTO().length;i++)
				{
					PrecioCargoDTO precioDTO=new PrecioCargoDTO();
					
					precioDTO.setCodigoConcepto(gaSSAdelantadoCargosListDTO.getGaSSAdelantadoCargosDTO()[i].getCodigoConcepto());
					precioDTO.setDescripcionConcepto(gaSSAdelantadoCargosListDTO.getGaSSAdelantadoCargosDTO()[i].getDescripcionConcepto());
					precioDTO.setMonto(gaSSAdelantadoCargosListDTO.getGaSSAdelantadoCargosDTO()[i].getMonto());
					precioDTO.setCodigoMoneda(gaSSAdelantadoCargosListDTO.getGaSSAdelantadoCargosDTO()[i].getCodigoMoneda());
					precioDTO.setDescripcionMoneda(gaSSAdelantadoCargosListDTO.getGaSSAdelantadoCargosDTO()[i].getDescripcionMoneda());
					precioDTO.setValorMaximo(gaSSAdelantadoCargosListDTO.getGaSSAdelantadoCargosDTO()[i].getValorMaximo());
					precioDTO.setValorMinimo(gaSSAdelantadoCargosListDTO.getGaSSAdelantadoCargosDTO()[i].getValorMinimo());
					precioDTO.setIndicadorAutMan("A");
					
					
					
					listaPreciosCargos.add(precioDTO);
				}
			}
			
			
			arregloPreciosCargos=(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaPreciosCargos.toArray(), PrecioCargoDTO.class);
			boolean existCarg=listaPreciosCargos.size()>0?true:false;
			ArrayList listaPrecios = new ArrayList();
			if (existCarg){
				for (int indice = 0; indice < arregloPreciosCargos.length; indice++) {
					PrecioDTO precio = new PrecioDTO();
		        	precio.setCodigoConcepto(arregloPreciosCargos[indice].getCodigoConcepto());
		        	precio.setDescripcionConcepto(arregloPreciosCargos[indice].getDescripcionConcepto());
		        	precio.setMonto(arregloPreciosCargos[indice].getMonto());
		        	MonedaDTO moneda = new MonedaDTO();
					moneda.setCodigo(arregloPreciosCargos[indice].getCodigoMoneda());
		        	moneda.setDescripcion(arregloPreciosCargos[indice].getDescripcionMoneda());
		        	precio.setUnidad(moneda);
		        	AtributosMigracionDTO atributos = new AtributosMigracionDTO();
		        	atributos.setInd_paquete(arregloPreciosCargos[indice].getIndicadorPaquete());
		        	atributos.setInd_equipo(arregloPreciosCargos[indice].getIndicadorEquipo());
		        	/**
		        	 * @author rlozano
		        	 * @description se indica que el cargo asociado a este precio corresponde a un cobro adelantado
		        	 */
		        	atributos.setObligatorio(true);
		        	/**
		        	 * 
		        	 */
		        	
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
				System.out.println("documento.getPromedioFacturado()::::::::::::: ::."+documento.getPromedioFacturado());
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
