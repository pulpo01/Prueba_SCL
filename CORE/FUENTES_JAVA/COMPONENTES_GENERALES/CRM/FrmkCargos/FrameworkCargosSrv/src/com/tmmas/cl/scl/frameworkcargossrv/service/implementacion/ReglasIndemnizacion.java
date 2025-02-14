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

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Global;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasBajaOptaPrepagoIndemnizacionDTO;
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
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.interfaz.ClaseProductos;
import com.tmmas.scl.framework.productDomain.interfaz.ListaProductos;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DocumentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ServicioOcasionalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.TerminalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ParametrosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoIndemnizQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ParamBajaIndemnizacionQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;


public class ReglasIndemnizacion extends ReglaListaPrecio{
	private final Logger logger = Logger.getLogger(ReglasBajaOptaPrepagoSinPenalizacion.class);
	private Global global = Global.getInstance();
	private ParametrosReglasBajaOptaPrepagoIndemnizacionDTO parametrosRegla;
		
   
    private String codigoConceptoCargo;
	
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
	
	private CargoBOFactoryIT cargosFactory=new CargoBOFactory();
	private CargoIT  cargosBO=cargosFactory.getBusinessObject1();
    
    private String codTipPlanTarifDest; 				//< 1: Prepago, 2:PostPago, 3:Hibrido
    
	
	public ReglasIndemnizacion(ParametrosReglasBajaOptaPrepagoIndemnizacionDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasTerminal

	public PrecioDTO[] seleccionPrecios() {
		logger.debug("Inicio:seleccionPrecios()");
		
		ArrayList listaPrecios = new ArrayList();
		PrecioCargoDTO[] arregloPreciosCargos = null;
		PrecioDTO[] arregloPrecios = null;
		

		try {
			ParamBajaIndemnizacionQTDTO paramBajIndemQTDTO=new ParamBajaIndemnizacionQTDTO();
			
			
			paramBajIndemQTDTO.setNum_Abonado(parametrosRegla.getNum_Abonado());
			paramBajIndemQTDTO.setCod_Producto(parametrosRegla.getCod_Producto());
			ParamBajaIndemnizacionQTDTO[] lstparamBajIndemQTDTO= cargosBO.getParametrosbajaIndemnizacion(paramBajIndemQTDTO);
			paramBajIndemQTDTO.setCod_Producto(lstparamBajIndemQTDTO[0].getCod_Producto());
			paramBajIndemQTDTO.setCod_TipContrato(lstparamBajIndemQTDTO[0].getCod_TipContrato());
			paramBajIndemQTDTO.setFec_Alta(lstparamBajIndemQTDTO[0].getFec_Alta());
			paramBajIndemQTDTO.setFec_Prorroga(lstparamBajIndemQTDTO[0].getFec_Prorroga());
			paramBajIndemQTDTO.setNum_Abonado(lstparamBajIndemQTDTO[0].getNum_Abonado());
			paramBajIndemQTDTO.setNum_Meses(lstparamBajIndemQTDTO[0].getNum_Meses());
			
			String fecAlta=null;
			fecAlta=paramBajIndemQTDTO.getFec_Alta()==null?"":paramBajIndemQTDTO.getFec_Alta().toString();
			
			String fecProg;
			fecProg=paramBajIndemQTDTO.getFec_Prorroga()==null?"":paramBajIndemQTDTO.getFec_Prorroga().toString();
			
			String tipContrato;
			tipContrato=paramBajIndemQTDTO.getCod_TipContrato();
			tipContrato=tipContrato==null?"":tipContrato;
			parametrosRegla.setCod_TipContrato(tipContrato);
			parametrosRegla.setNum_meses(String.valueOf(paramBajIndemQTDTO.getNum_Meses()));
			long meses=0;
			Calendar cal=Calendar.getInstance();
			Calendar now=Calendar.getInstance();
			
			if (!fecProg.equals("")){
				
				meses=(now.getTimeInMillis() - paramBajIndemQTDTO.getFec_Prorroga().getTime());
				meses = meses/1000;	//Segundos  Transcurridos entre las fechas Operadas
				meses = meses/3600; //Horas   	Transcurridas entre las fechas Operadas
				meses = meses/24; 	//Dias		Transcurridos entre las fechas Operadas
				meses = meses/30; 	//Meses		Transcurridos entre las fechas Operadas
				
			}
			else{
				meses=(now.getTimeInMillis() - paramBajIndemQTDTO.getFec_Alta().getTime());
				meses = meses/1000;	//Segundos  Transcurridos entre las fechas Operadas
				meses = meses/3600; //Horas   	Transcurridas entre las fechas Operadas
				meses = meses/24; 	//Dias		Transcurridos entre las fechas Operadas
				meses = meses/30; 	//Meses		Transcurridos entre las fechas Operadas
			}
				
			
			CargoIndemnizQTDTO cargoIndemnizQTDTO =new CargoIndemnizQTDTO();
			
			cargoIndemnizQTDTO.setCod_Producto(parametrosRegla.getCod_Producto());
			cargoIndemnizQTDTO.setCod_Actabo(parametrosRegla.getCod_Actabo());
			cargoIndemnizQTDTO.setCod_TipServ(parametrosRegla.getCod_TipServ());
			//Se realiza llamada a ged_parametros para cargar el dato de coConcepto;
			ParametrosGeneralesDTO parametrosDTO=new ParametrosGeneralesDTO();
			parametrosDTO.setCodigoproducto(String.valueOf(parametrosRegla.getCod_Producto()));
			parametrosDTO.setCodigomodulo(parametrosRegla.getCod_Modulo());
			parametrosDTO.setNombreparametro(Global.getValor("parametro.codigo.concepto.indemnizacion"));
    		parametrosDTO=paramGenerBO.getParametroGeneral(parametrosDTO);
			cargoIndemnizQTDTO.setCod_Servicio(parametrosDTO.getValorparametro());//Obtener Parametro de la ged_Parametros
			String mesesContrato=parametrosRegla.getMeses_Contrato();
			mesesContrato=mesesContrato==null?"0":mesesContrato;
			cargoIndemnizQTDTO.setMeses_Contrato(Long.parseLong(mesesContrato));
			cargoIndemnizQTDTO.setNum_Meses(meses);
			
			arregloPreciosCargos=cargosBO.getCargosIndemnizacion(cargoIndemnizQTDTO);
			
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
	        	atributos.setNumAbonado(parametrosRegla.getNumAbonado());
	        	precio.setDatosAnexos(atributos);

	        	listaPrecios.add(precio);
	        }//fin for
			
		arregloPrecios =(PrecioDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaPrecios.toArray(),PrecioDTO.class);
			if (arregloPrecios!=null)
				if (arregloPrecios.length>0)
					codigoConceptoCargo = arregloPrecios[0].getCodigoConcepto();
		} catch (ProductOfferingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 
		 catch (ProductOfferingPriceException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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

	public DescuentoDTO[] seleccionDescuentos() {
		logger.debug("Inicio:seleccionDescuentos()");
		DescuentoDTO[] arregloDescuentosAutomaticos = null;
		DescuentoDTO[] arregloDescuentos = null;
		try {
			ParametrosDescuentoDTO parametrosDescto = parametrosRegla.getParametrosDescuento();
		
			//Obtiene Promedio Facturado a Cliente
			DocumentoFacturacionDTO documento = new DocumentoFacturacionDTO();
			documento.setIndiceCiclo(parametrosDescto.getIndicadorCiclo());
			documento.setNumeroMeses(parametrosDescto.getNumeroMesesFact());
			documento.setCodigoCliente(String.valueOf(parametrosRegla.getCodigoCliente()));
			documento = documentoBO.getPromedioDocumentosFacturados(documento);
			System.out.println("documento.getPromedioFacturado():::::::::::::::."+documento.getPromedioFacturado());
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
			
			paramGeneralDTO.setCodigomodulo(parametrosRegla.getCod_Modulo()); //GA
			paramGeneralDTO.setCodigoproducto(String.valueOf(parametrosRegla.getCod_Producto()));//1
			paramGeneralDTO.setNombreparametro(Global.getValor("parametro.clase.descuento.concepto"));
			
			paramGeneralDTO=paramGenerBO.getParametroGeneral(paramGeneralDTO);
			parametrosDescto.setClaseDescuento(paramGeneralDTO.getValorparametro());
			//Se aplica validación para clase-descuento 
			ArticuloDTO articuloDTO=new ArticuloDTO();  
			//articuloDTO.setCod_conceptoart(Integer.parseInt(codigoConceptoCargo));
			String codConceptoDesc=servicioOcasionalBO.existeCodigoConceptoArticulo(articuloDTO)?"ART":"CON";
			parametrosDescto.setClaseDescuento(codConceptoDesc);
			VendedorDTO vendedorDTO=new VendedorDTO();
			vendedorDTO.setCodigoVendedor(parametrosDescto.getCodigoVendedor());
			TipoComisionistaDTO tipoComisionistaDTO=new TipoComisionistaDTO();
			tipoComisionistaDTO=serviciosVentaBO.ObtieneComisPorVendedor(vendedorDTO);
			parametrosDescto.setIndiceVentaExterna(tipoComisionistaDTO.getIndExterno());
			parametrosDescto.setTipoPlanTarifario(codTipPlanTarifDest);
			parametrosDescto.setCodigoConcepto(codigoConceptoCargo);
			//Obtiene Descuento Automatico
			arregloDescuentosAutomaticos = servicioOcasionalBO.getDescuentoCargo(parametrosDescto);
			List listaDescuentos = new ArrayList();
			for (int indice = 0; indice < arregloDescuentosAutomaticos.length; indice++) {
				arregloDescuentosAutomaticos[indice].setTipo(String.valueOf(TipoDescuentos.Automatico));
				listaDescuentos.add(arregloDescuentosAutomaticos[indice]);
	        }//fin for
			          
	        //Obtiene concepto descuento manual.
			ParametrosDescuentoDTO parametrosDescuentoManual = new ParametrosDescuentoDTO();
	        parametrosDescuentoManual.setCodigoConcepto(codigoConceptoCargo);
			parametrosDescuentoManual.setTipoConcepto(parametrosDescto.getTipoConceptoDescuento());
	        //TODO :Analizar el uso de este proceso, probablemente no se usa
			DescuentoDTO descuentoManual = terminalBO.getCodigoDescuentoManual(parametrosDescuentoManual);
	        listaDescuentos.add(descuentoManual);
	        
	        arregloDescuentos =(DescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaDescuentos.toArray(),DescuentoDTO.class);
	        
	    } catch (ProductException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 catch (ProductOfferingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 catch(CustomerBillException e){
			 e.printStackTrace();
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
		//atributos.setCodigoArticuloServicio(parametrosRegla.getCodigoArticulo());
		//atributos.setNumAbonado(parametrosRegla.getNumAbonado());
		atributos.setNumAbonado(String.valueOf(parametrosRegla.getNum_Abonado()));
		parametrosRegla.setAtributos(atributos);
		logger.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos

}//fin ReglasTerminal
