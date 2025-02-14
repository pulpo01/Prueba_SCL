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

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasDiferenciaGarantiaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;


public class ReglasDiferenciaGarantia extends ReglaListaPrecio{
	private final Logger logger = Logger.getLogger(ReglasDiferenciaGarantia.class);

	private ParametrosReglasDiferenciaGarantiaDTO parametrosRegla;
	private CargoBOFactoryIT cargoFactory = new CargoBOFactory();
	private CargoIT cargoBO =cargoFactory.getBusinessObject1();
	
	
	public ReglasDiferenciaGarantia(ParametrosReglasDiferenciaGarantiaDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasDiferenciaGarantia

	public PrecioDTO[] seleccionPrecios() throws FrameworkCargosException{
		logger.debug("Inicio:seleccionPrecios()");

		PrecioCargoDTO[] arregloPreciosCargos = null;
		PrecioDTO[] arregloPrecios = null;

		try {
			
			arregloPreciosCargos = cargoBO.getPrecioCargoDifGarantia(parametrosRegla.getValorDiferencia());
			
			List listaPrecios = new ArrayList();
	        for (int indice = 0; arregloPreciosCargos!=null&&indice < arregloPreciosCargos.length; indice++) {
				PrecioDTO precio = new PrecioDTO();
	        	precio.setCodigoConcepto(arregloPreciosCargos[indice].getCodigoConcepto());
	        	precio.setDescripcionConcepto(arregloPreciosCargos[indice].getDescripcionConcepto());
	        	precio.setMonto(arregloPreciosCargos[indice].getMonto());
//	        	codigoConceptoCargo=arregloPreciosCargos[indice].getCodigoConcepto();
	        	precio.setIndicadorAutMan(arregloPreciosCargos[indice].getIndicadorAutMan());

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
//			if (arregloPrecios!=null)
//				if (arregloPrecios.length>0)
//					codigoConceptoCargo = arregloPrecios[0].getCodigoConcepto();					
		} catch (ProductOfferingPriceException e) {
			e.printStackTrace();
			throw new FrameworkCargosException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		}
		logger.debug("Fin:seleccionPrecios()+arregloPreciosCargos.length: " + (arregloPreciosCargos==null?0:arregloPreciosCargos.length));

		return arregloPrecios;
	}//fin seleccionPrecios
	
	/**
	 *Busca los descuentos asocaidos a la regla
	 * @param 
	 * @return arregloDescuentos
	 * @throws FrameworkCargosException 
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
	
	/**
	 *Retorna los atributos asocaidos a la regla
	 * @param 
	 * @return boolean 
	 * @throws 
	 */

	public boolean validacion() {
		logger.debug("Inicio:validacion()");

		return true;		
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
		parametrosRegla.setAtributos(atributos);
		logger.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos

	
}//fin ReglasTerminal
