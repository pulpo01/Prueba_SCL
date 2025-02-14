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
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasAbonadoCeroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SegmentacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SegmentacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SegmentacionBOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParamCargosAbonadoCeroDTO;


public class ReglasAbonadoCero extends ReglaListaPrecio{

	private final Logger logger = Logger.getLogger(ReglasAbonadoCero.class);
	private ParametrosReglasAbonadoCeroDTO parametrosRegla;
	
	private CargoBOFactoryIT cargoFactory=new CargoBOFactory();
	private CargoIT cargoBO=cargoFactory.getBusinessObject1();
	
	private SegmentacionBOFactoryIT segmentacionFactory=new SegmentacionBOFactory();
	private SegmentacionBOIT segmentacionBO =segmentacionFactory.getBusinessObject1();
	
	
	public ReglasAbonadoCero(ParametrosReglasAbonadoCeroDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasSimcard

	public PrecioDTO[] seleccionPrecios() throws FrameworkCargosException {
		
			
		PrecioCargoDTO[] arregloPreciosCargos = null;
		PrecioCargoDTO precioCargo=null;
		PrecioDTO[] arregloPrecios = null;
		
		try {
			
			GedCodigosListDTO gedCodigosListDTO=new GedCodigosListDTO();
			GedCodigosDTO gedCodigosDTO=new GedCodigosDTO();
			gedCodigosDTO.setCod_modulo(parametrosRegla.getCodigoModulo());
			gedCodigosDTO.setNom_tabla(parametrosRegla.getNombreTabla());
			gedCodigosDTO.setNom_columna(parametrosRegla.getNombreColumna());
			
			gedCodigosListDTO=segmentacionBO.obtenerListaGedCodigos(gedCodigosDTO);
			boolean isExisteGedCodigos=gedCodigosListDTO!=null&&gedCodigosListDTO.getGedCodigosDTO()!=null
			&&gedCodigosListDTO.getGedCodigosDTO().length>0?true:false;
			String codigoConceptoAbonadoCero=null;
			if (isExisteGedCodigos){
				codigoConceptoAbonadoCero=gedCodigosListDTO.getGedCodigosDTO()[0].getCod_valor();
			}
			
			ParamCargosAbonadoCeroDTO paramCargosAbonadoCeroDTO =new ParamCargosAbonadoCeroDTO();
			paramCargosAbonadoCeroDTO.setCodCliente(Long.parseLong(parametrosRegla.getCodigoCliente()));
			paramCargosAbonadoCeroDTO.setFechaVigencia(parametrosRegla.getFechaVigenciaAbonadoCero());
			paramCargosAbonadoCeroDTO.setCodProducto(parametrosRegla.getCodigoProducto());
			
			precioCargo=cargoBO.getValorCargoAbonadoCero(paramCargosAbonadoCeroDTO);
			boolean isExistValorCargo=precioCargo!=null&&precioCargo.getMonto()>=0?true:false;
			
			if (isExistValorCargo){
				paramCargosAbonadoCeroDTO.setCodConcepto(codigoConceptoAbonadoCero);
				arregloPreciosCargos=cargoBO.getParametrosAbonadoCero(paramCargosAbonadoCeroDTO);
				
			}
			
			boolean isExisteParametrosCargos=arregloPreciosCargos!=null&&arregloPreciosCargos.length>0?true:false;
			List listaPrecios = new ArrayList();
			if (isExisteParametrosCargos){
				for(int i=0;i<arregloPreciosCargos.length;i++){
					arregloPreciosCargos[i].setMonto(precioCargo.getMonto());
					arregloPreciosCargos[i].setCodigoConcepto(codigoConceptoAbonadoCero);
				}
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
		        	precio.setDatosAnexos(atributos);
	
		        	listaPrecios.add(precio);
		        }//fin for
			}
			arregloPrecios =(PrecioDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaPrecios.toArray(),PrecioDTO.class);
			
		} catch (GeneralException e) {
			throw new FrameworkCargosException(e);
		}
		logger.debug("Fin:ReglasSimcard:seleccionPrecios()");
		return arregloPrecios;
	}//fin seleccionPrecios

	/**
	 *Busca los descuentos asocaidos a la regla
	 * @param 
	 * @return arregloDescuentos
	 * @throws FrameworkCargosException
	 */

	public DescuentoDTO[] seleccionDescuentos() throws FrameworkCargosException {
		logger.debug("Inicio:seleccionDescuentos()");
		DescuentoDTO[] arregloDescuentos = null;
		try {
			        
	        arregloDescuentos =null;
	        
		
		} catch (Exception e) {
			throw new FrameworkCargosException(e);
		}
		logger.debug("Fin:seleccionDescuentos()");
		return arregloDescuentos;
	}//fin seleccionDescuentos

	public boolean validacion() {
		logger.debug("Inicio:ReglasSimcard:validacion()");
		return true;
	}//fin validacion

	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		logger.debug("Inicio:getAtributos()");
		
		AtributosCargoDTO atributos = new AtributosCargoDTO();
		parametrosRegla.setAtributos(atributos);
		logger.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos
	
}//fin ReglasSimcard
