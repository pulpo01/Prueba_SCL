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
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.helper.Global;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasServicioOcacionalPVDTO;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerOrderException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ServicioOcasionalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoServOcacionalesPVDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.productDomain.interfaz.ClaseProductos;
import com.tmmas.scl.framework.productDomain.interfaz.ListaProductos;

public class ReglasServiciosOcasionalesPV extends ReglaListaPrecio{

	private final Logger logger = Logger.getLogger(ReglasServiciosOcasionalesPV.class);
	private Global global = Global.getInstance();
	private ParametrosReglasServicioOcacionalPVDTO parametrosRegla;
	
	private ServicioOcasionalBOFactoryIT  sOcasionalFactory=new ServicioOcasionalBOFactory(); 
    private ServicioOcasionalBOIT servicioOcacionalBO=sOcasionalFactory.getBusinessObject1();
	
    
    private ParametrosCargoServOcacionalesPVDTO servicioOcasional;
    
    
    
	private OrdenServicioBOFactoryIT OrdSrvfactory=new OrdenServicioBOFactory();
	private OrdenServicioIT ordenServicioBO=OrdSrvfactory.getBusinessObject1();
	
	public ReglasServiciosOcasionalesPV(ParametrosReglasServicioOcacionalPVDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasServiciosOcasionales

	public DescuentoDTO[] seleccionDescuentos() {
		
		logger.debug("Inicio:seleccionDescuentos()");
		DescuentoDTO[] arregloDescuentos = null;
		
		//TODO : no se configuraron descuentos para los cargos Ocasionales
		
		return arregloDescuentos;
	}//fin seleccionDescuentos
	  
	/** 
	 * @descripcion : Casuísticas de Obtención de cargos Ocasionales
	 *  Prepago - Prepago : Aplica sólo Prepago*Prepago 
	 *  Hibrido - Hibrido y/o Cualquier Otra Combinatoria : Aplica Prepago*Prepago, Hibrido*Hibrido
	 *  
	 */
	public PrecioDTO[] seleccionPrecios() {
			logger.debug("Inicio:seleccionPrecios() Ocasionales");
			
			servicioOcasional = new ParametrosCargoServOcacionalesPVDTO();
			servicioOcasional.setCodProducto(parametrosRegla.getCodProducto());
			servicioOcasional.setCodActuacion(parametrosRegla.getCodActuacion());
			servicioOcasional.setCodTipoServicio(parametrosRegla.getCodTipoServicio());
			
			PrecioDTO[] arregloPrecios = null;
			List listaPrecios=new ArrayList();
			try{
			
				
			//ged_parametros
			ParametroDTO paramPrepagoDTO=new ParametroDTO(); 
			paramPrepagoDTO.setCodProducto(Integer.parseInt(parametrosRegla.getCodProducto()));
			paramPrepagoDTO.setCodModulo(parametrosRegla.getCodModulo());
			
			//TODO: Prepago - Prepago
			
			List cargosPrepagoPrepago=getCargosPrepagoPrepago(paramPrepagoDTO);
			ParametroDTO paramHibridoDTO=new ParametroDTO();
			paramHibridoDTO.setCodProducto(Integer.parseInt(parametrosRegla.getCodProducto()));
			paramHibridoDTO.setCodModulo(parametrosRegla.getCodModulo());
			
			
			//TODO : Hibrido - Hibrido
			List cargosHibridoHibrido=new ArrayList();
			if (!parametrosRegla.isPrepagoPrepago()){
				cargosHibridoHibrido = getCargosHibridoHibrido(paramHibridoDTO);
			}
			
			if (cargosPrepagoPrepago.size()>0){
				Iterator iterator=cargosPrepagoPrepago.iterator();
				while(iterator.hasNext()){
					listaPrecios.add(iterator.next());
				}
			}
			if (cargosHibridoHibrido.size()>0){
				Iterator iterator=cargosHibridoHibrido.iterator();
				while(iterator.hasNext()){
					listaPrecios.add(iterator.next());
				}
			}
			
	        arregloPrecios =(PrecioDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaPrecios.toArray(),PrecioDTO.class);
			
		}
		catch(FrameworkCargosException e){
			e.printStackTrace();
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
		atributos.setTipoProducto(ListaProductos.ServiciosOcasionales);
		atributos.setClaseProducto(ClaseProductos.Servicio);
		//atributos.setCodigoArticuloServicio(parametrosRegla.getCodigoArticulo());
		
		atributos.setNumAbonado(parametrosRegla.getNumAbonado());
		parametrosRegla.setAtributos(atributos);
		logger.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos
	
	
	private List getCargosPrepagoPrepago(ParametroDTO ParamPrePagoDTO)throws FrameworkCargosException{
		List cargosPrepagoPrepago=new ArrayList();
		PrecioCargoDTO[] precCargPP = null;
		try {
			ParamPrePagoDTO.setNomParametro(parametrosRegla.getPrepagoPrepago());
			ParamPrePagoDTO=ordenServicioBO.obtenerParametroGeneral(ParamPrePagoDTO);
			//servicioOcasional.setCodConcepto(ParamPrePagoDTO.getValorParametro());
			servicioOcasional.setCodConcepto(parametrosRegla.isAplicaConcepto()?ParamPrePagoDTO.getValor():null);
			servicioOcasional.setCodPlanServicio(parametrosRegla.getCodPlanServicio());
		
			precCargPP = servicioOcacionalBO.getCargoServOcac(servicioOcasional);
			
	        for (int indice = 0; indice < precCargPP.length; indice++) {
				PrecioDTO precio = new PrecioDTO();
				
	        	precio.setCodigoConcepto(precCargPP[indice].getCodigoConcepto());
	        	precio.setDescripcionConcepto(precCargPP[indice].getDescripcionConcepto());
	        	precio.setMonto(precCargPP[indice].getMonto());
	        	precio.setIndicadorAutMan(precCargPP[indice].getIndicadorAutMan());
	        	//precio.setIndicadorAutMan(global.getValor("indicador.automatico.cargo"));
	
				MonedaDTO moneda = new MonedaDTO();
				moneda.setCodigo(precCargPP[indice].getCodigoMoneda());
	        	moneda.setDescripcion(precCargPP[indice].getDescripcionMoneda());
	        	
	        	precio.setUnidad(moneda);
	        	
	        	AtributosMigracionDTO atributos = new AtributosMigracionDTO();
	        	atributos.setInd_paquete(precCargPP[indice].getIndicadorPaquete());
	        	atributos.setInd_equipo(precCargPP[indice].getIndicadorEquipo());
	        	atributos.setNumAbonado(parametrosRegla.getNumAbonado());
	        	
	        	precio.setDatosAnexos(atributos);
	
	        	cargosPrepagoPrepago.add(precio);
	        }//fin for
		} catch(CustomerOrderException e){
			throw new FrameworkCargosException(e);
		}catch(ProductException e){
			throw new FrameworkCargosException(e);
		}
		return cargosPrepagoPrepago;
	}
	
	private List getCargosHibridoHibrido(ParametroDTO ParamHibridoDTO)throws FrameworkCargosException{
		List cargosHibridoHibrido=new ArrayList();
		PrecioCargoDTO[] precCargHH = null;
		try {
			ParamHibridoDTO.setNomParametro(parametrosRegla.getPrepagoHibrido());
			ParamHibridoDTO=ordenServicioBO.obtenerParametroGeneral(ParamHibridoDTO);
			//servicioOcasional.setCodConcepto(ParamHibridoDTO.getValorParametro());
			servicioOcasional.setCodConcepto(ParamHibridoDTO.getValor());
			servicioOcasional.setCodPlanServicio(parametrosRegla.getCodPlanServicio());
		
			precCargHH = servicioOcacionalBO.getCargoServOcac(servicioOcasional);
			
	        for (int indice = 0; indice < precCargHH.length; indice++) {
				PrecioDTO precio = new PrecioDTO();
	        	precio.setCodigoConcepto(precCargHH[indice].getCodigoConcepto());
	        	precio.setDescripcionConcepto(precCargHH[indice].getDescripcionConcepto());
	        	precio.setMonto(precCargHH[indice].getMonto());
	        	precio.setIndicadorAutMan(precCargHH[indice].getIndicadorAutMan());
	        	//precio.setIndicadorAutMan(global.getValor("indicador.automatico.cargo"));
	
				MonedaDTO moneda = new MonedaDTO();
				moneda.setCodigo(precCargHH[indice].getCodigoMoneda());
	        	moneda.setDescripcion(precCargHH[indice].getDescripcionMoneda());
	        	
	        	precio.setUnidad(moneda);
	        	
	        	AtributosMigracionDTO atributos = new AtributosMigracionDTO();
	        	atributos.setInd_paquete(precCargHH[indice].getIndicadorPaquete());
	        	atributos.setInd_equipo(precCargHH[indice].getIndicadorEquipo());
	        	atributos.setNumAbonado(parametrosRegla.getNumAbonado());
	        	precio.setDatosAnexos(atributos);
	
	        	cargosHibridoHibrido.add(precio);
	        }//fin for
		} catch(CustomerOrderException e){
			throw new FrameworkCargosException(e);
		}catch(ProductException e){
			throw new FrameworkCargosException(e);
		}
		
		return cargosHibridoHibrido;
	}
	
	
	
	

}//fin ReglasServiciosOcasionales
