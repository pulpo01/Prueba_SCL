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
 * 18/07/2007              Raúl Lozano       				Versión Inicial
 */

package com.tmmas.cl.scl.frameworkcargossrv.service.implementacion;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.helper.Global;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasHabilitacionDTO;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosCargoHabilitacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.productDomain.interfaz.ClaseProductos;
import com.tmmas.scl.framework.productDomain.interfaz.ListaProductos;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.CargoHabilitacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DocumentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoHabilitacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoHabilitacionBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;


public class ReglasHabilitacion extends ReglaListaPrecio{

	private final Logger logger = Logger.getLogger(ReglasHabilitacion.class);
	private Global global = Global.getInstance();
	private ParametrosReglasHabilitacionDTO parametrosRegla;
	
	private CargoHabilitacionBOFactoryIT  sCargoHabilitacionBOFactory=new CargoHabilitacionBOFactory(); 
    private CargoHabilitacionBOIT cargoHabilitacionBO=sCargoHabilitacionBOFactory.getBusinessObject1();
	
    private DocumentoBOFactoryIT documentoFactory=new DocumentoBOFactory();
	private DocumentoBOIT documentoBO=documentoFactory.getBusinessObject1();
	
	private RegistroFacturacionBOFactoryIT regFactFactory = new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT  registroFacturacionBO=regFactFactory.getBusinessObject1();
	
	private PlanTarifarioBOFactoryIT planTarifarioFactory = new PlanTarifarioBOFactory();
	private PlanTarifarioIT planTarifarioBO =planTarifarioFactory.getBusinessObject1();

	private OrdenServicioBOFactoryIT OrdSrvfactory=new OrdenServicioBOFactory();
	private OrdenServicioIT ordenServicioBO=OrdSrvfactory.getBusinessObject1();
	
    private ParametrosCargoHabilitacionDTO cargoHabilitacion;
    
    private String codigoConceptoCargo;
    

	
	public ReglasHabilitacion(ParametrosReglasHabilitacionDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasHabilitacion

	public DescuentoDTO[] seleccionDescuentos() {
		
		logger.debug("Inicio:seleccionDescuentos()");
		DescuentoDTO[] arregloDescuentosAutomaticos = null;
		DescuentoDTO[] arregloDescuentos = null;
		PlanTarifarioDTO planTarifario= new PlanTarifarioDTO();
		
		try {
			ParametrosDescuentoDTO parametrosDescto = parametrosRegla.getParametrosDescuento();
		
			//Obtiene Promedio Facturado a Cliente
			DocumentoFacturacionDTO documento = new DocumentoFacturacionDTO();
			documento.setIndiceCiclo(parametrosDescto.getIndicadorCiclo());
			documento.setNumeroMeses(parametrosDescto.getNumeroMesesFact());
			documento.setCodigoCliente(parametrosRegla.getCodigoCliente());
			documento = documentoBO.getPromedioDocumentosFacturados(documento);
			parametrosDescto.setValorPromedioFact(documento.getPromedioFacturado());
			
            //Obtiene Codigo Promedio Facturado a Cliente
			RegistroFacturacionDTO registroFac = new RegistroFacturacionDTO();
			registroFac.setValorPromedio(parametrosDescto.getValorPromedioFact());
			registroFac = registroFacturacionBO.getCodigoPromedioFacturado(registroFac);
			
			parametrosDescto.setCodigoPromedioFacturable(String.valueOf(registroFac.getCodigoPromedio()));
			
			planTarifario.setCodigoPlanTarifario(parametrosRegla.getCodigoPlanTarifario());
			planTarifario= planTarifarioBO.getCategoriaPlanTarifario(planTarifario);

			//Obtiene Descuento Automatico
			arregloDescuentosAutomaticos = cargoHabilitacionBO.getDescuentoCargo(parametrosDescto);
			List listaDescuentos = new ArrayList();
			for (int indice = 0; indice < arregloDescuentosAutomaticos.length; indice++) {
				arregloDescuentosAutomaticos[indice].setTipo(String.valueOf(TipoDescuentos.Automatico));
				listaDescuentos.add(arregloDescuentosAutomaticos[indice]);
	        }//fin for
			
	        //Obtiene concepto descuento manual.
			ParametrosDescuentoDTO parametrosDescuentoManual = new ParametrosDescuentoDTO();
	        parametrosDescuentoManual.setCodigoConcepto(codigoConceptoCargo);
	        parametrosDescuentoManual.setTipoConcepto(parametrosDescto.getTipoConceptoDescuento());
	        DescuentoDTO descuentoManual = cargoHabilitacionBO.getCodigoDescuentoManual(parametrosDescuentoManual);
	        listaDescuentos.add(descuentoManual);
	        
	        arregloDescuentos =(DescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaDescuentos.toArray(),DescuentoDTO.class);
	        
		} catch (ProductException e) {
			e.printStackTrace();
		} catch (ProductOfferingException e) {
			e.printStackTrace();
		}
		logger.debug("Fin:seleccionDescuentos()");
		return arregloDescuentos;
	}
	  
	/** 
	 * @descripcion : Obtencion de cargos
	 *  
	 *  
	 */
	public PrecioDTO[] seleccionPrecios() {
		
		logger.debug("Inicio:seleccionPrecios() habilitacion");
		
		cargoHabilitacion = new ParametrosCargoHabilitacionDTO();
		cargoHabilitacion.setCodProducto(Integer.valueOf(parametrosRegla.getCodigoProducto()));
		
		PrecioDTO[] arregloPrecios = null;
		PrecioCargoDTO[] arregloPreciosCargos = null;
		List listaPrecios=new ArrayList();
		try{
			
				
			//ged_parametros
//			ParametroDTO paramPrepagoDTO=new ParametroDTO(); 
//			paramPrepagoDTO.setCodProducto(Integer.parseInt(parametrosRegla.getCodProducto()));
//			paramPrepagoDTO.setCodModulo(parametrosRegla.getCodModulo());
			
//			List cargosPrepagoPrepago=getCargosPrepagoPrepago(paramPrepagoDTO);
//			ParametroDTO paramHibridoDTO=new ParametroDTO();
//			paramHibridoDTO.setCodProducto(Integer.parseInt(parametrosRegla.getCodProducto()));
//			paramHibridoDTO.setCodModulo(parametrosRegla.getCodModulo());
			
//			List cargosHibridoHibrido=new ArrayList();
//			if (!parametrosRegla.isPrepagoPrepago()){
//				cargosHibridoHibrido = getCargosHibridoHibrido(paramHibridoDTO);
//			}
			
//			if (cargosPrepagoPrepago.size()>0){
//				Iterator iterator=cargosPrepagoPrepago.iterator();
//				while(iterator.hasNext()){
//					listaPrecios.add(iterator.next());
//				}
//			}
//			if (cargosHibridoHibrido.size()>0){
//				Iterator iterator=cargosHibridoHibrido.iterator();
//				while(iterator.hasNext()){
//					listaPrecios.add(iterator.next());
//				}
//			}
			
			
			arregloPreciosCargos = cargoHabilitacionBO.getCargoHabilitacion(cargoHabilitacion);
				
	        for (int indice = 0; arregloPreciosCargos!=null&&indice < arregloPreciosCargos.length; indice++) {
				PrecioDTO precio = new PrecioDTO();
	        	precio.setCodigoConcepto(arregloPreciosCargos[indice].getCodigoConcepto());
	        	precio.setDescripcionConcepto(arregloPreciosCargos[indice].getDescripcionConcepto());
	        	precio.setMonto(arregloPreciosCargos[indice].getMonto());
	        	precio.setIndicadorAutMan(arregloPreciosCargos[indice].getIndicadorAutMan());

	        	codigoConceptoCargo=arregloPreciosCargos[indice].getCodigoConcepto();
	        	
				MonedaDTO moneda = new MonedaDTO();
				moneda.setCodigo(arregloPreciosCargos[indice].getCodigoMoneda());
	        	moneda.setDescripcion(arregloPreciosCargos[indice].getDescripcionMoneda());
	        	
	        	precio.setUnidad(moneda);
	        	
	        	AtributosMigracionDTO atributos = new AtributosMigracionDTO();
	        	atributos.setInd_paquete(arregloPreciosCargos[indice].getIndicadorPaquete());
	        	atributos.setInd_equipo(arregloPreciosCargos[indice].getIndicadorEquipo());
	        	precio.setDatosAnexos(atributos);

	        	listaPrecios.add(precio);
	        }//fin for
	        arregloPrecios =(PrecioDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaPrecios.toArray(),PrecioDTO.class);
			
//		}
//		catch(FrameworkCargosException e){
//			e.printStackTrace();
		} catch (ProductException e) {

			e.printStackTrace();
			logger.error("Error al obtener precios de habilitacion", e);
		}
		
		
		logger.debug("Fin:seleccionPrecios()");
		return arregloPrecios;
	}//fin seleccionPrecios

	public boolean validacion() {
		logger.debug("Inicio:validacion()");
		/*if (!parametrosRegla.getIndicadorComodato().equals(parametrosRegla.getEsComodato()))//no es comodato
			return false;*/
		logger.debug("Fin:validacion()");
		return true;
	}//fin validacion

	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		logger.debug("Inicio:getAtributos()");
		AtributosCargoDTO atributos = new AtributosCargoDTO();
		atributos.setTipoProducto(ListaProductos.Terminal);
		atributos.setClaseProducto(ClaseProductos.Bien);
		
		atributos.setNumAbonado(String.valueOf(parametrosRegla.getNumAbonado()));
		parametrosRegla.setAtributos(atributos);
		logger.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos
	
}
