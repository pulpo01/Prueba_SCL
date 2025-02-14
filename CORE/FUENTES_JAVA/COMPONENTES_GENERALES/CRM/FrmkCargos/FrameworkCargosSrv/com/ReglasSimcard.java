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
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasSimcardDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoSimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.interfaz.ClaseProductos;
import com.tmmas.scl.framework.productDomain.interfaz.ListaProductos;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DocumentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SimcardBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;

public class ReglasSimcard extends ReglaListaPrecio{

	private final Logger logger = Logger.getLogger(ReglasSimcard.class);
	private ParametrosReglasSimcardDTO parametrosRegla;
	//private Simcard simcardBO = new Simcard();
	private SimcardBOFactoryIT simcardFactory=new SimcardBOFactory();
	private SimcardBOIT simcardBO=simcardFactory.getBusinessObject1();
	private PlanTarifarioBOFactoryIT planTarifarioFactory = new PlanTarifarioBOFactory();
	private PlanTarifarioIT planTarifarioBO =planTarifarioFactory.getBusinessObject1();
	//private Documento documentoBO = new Documento();
	private DocumentoBOFactoryIT documentoFactory=new DocumentoBOFactory();
	private DocumentoBOIT documentoBO=documentoFactory.getBusinessObject1();
	//private RegistroFacturacion registroFacturacionBO = new RegistroFacturacion();
	private RegistroFacturacionBOFactoryIT regFactFactory = new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT  registroFacturacionBO=regFactFactory.getBusinessObject1();
	private ParametrosCargoSimcardDTO simcard;
    private String codigoConceptoCargo;

    private static String IndValorar = "1"; 			//< 1: valorar >
    private static String IndPrecioLista = "TRUE"; 		//< TRUE: considera precio lista >
    private static String IndEquipo = "E";
    private static String CodigoUsoPrepago = "3";
    
	public ReglasSimcard(ParametrosReglasSimcardDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasSimcard

	public PrecioDTO[] seleccionPrecios() {
		logger.debug("Inicio:ReglasSimcard:seleccionPrecios()");

		simcard = new ParametrosCargoSimcardDTO();
		simcard.setCodigoArticulo(parametrosRegla.getCodigoArticulo());
		simcard.setTipoStock(parametrosRegla.getTipoStock());
		simcard.setCodigoUso(parametrosRegla.getCodigoUso());
		simcard.setEstado(parametrosRegla.getEstado());
		simcard.setCodigoCategoria(parametrosRegla.getCodigoCategoria());
		simcard.setModalidadVenta(parametrosRegla.getCodigoModalidadVenta());
		simcard.setTipoContrato(parametrosRegla.getTipoContrato());
		simcard.setCodigoUsoPrepago(CodigoUsoPrepago);
		simcard.setPlanTarifario(parametrosRegla.getCodigoPlanTarifario());
		
		PrecioCargoDTO[] arregloPreciosCargos = null;
		PrecioDTO[] arregloPrecios = null;
		
		try {
			if (parametrosRegla.getIndicadorPrecioLista().equals(IndPrecioLista)){
				simcard.setIndiceRecambio(parametrosRegla.getIndiceRecambioPrecioLista());
				arregloPreciosCargos = simcardBO.getPrecioCargoSimcard_PrecioLista(simcard);
			}
			else{
				simcard.setIndicadorEquipo(IndEquipo);
				simcard.setIndiceRecambio(parametrosRegla.getIndiceRecambioNoLista());
				arregloPreciosCargos = simcardBO.getPrecioCargoSimcard_NoPrecioLista(simcard);
				
			}
			List listaPrecios = new ArrayList();
	        for (int indice = 0; indice < arregloPreciosCargos.length; indice++) {
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
	        	atributos.setNumAbonado(parametrosRegla.getNumAbonado());
	        	precio.setDatosAnexos(atributos);

	        	listaPrecios.add(precio);
	        }//fin for
			arregloPrecios =(PrecioDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaPrecios.toArray(),PrecioDTO.class);
			
		} catch (ProductException e) {
			e.printStackTrace();
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

	public DescuentoDTO[] seleccionDescuentos() {
		logger.debug("Inicio:seleccionDescuentos()");
		DescuentoDTO[] arregloDescuentosAutomaticos = null;
		DescuentoDTO[] arregloDescuentos = null;
		//PlanTarifarioDTO planTarifario= new PlanTarifarioDTO();
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
			parametrosDescto.setConcepto(codigoConceptoCargo);
			PlanTarifarioDTO planTarifario=new PlanTarifarioDTO(); 
			planTarifario.setCodigoPlanTarifario(parametrosRegla.getCodigoPlanTarifario());
			planTarifario.setCodPlanTarif(parametrosRegla.getCodigoPlanTarifario());
			planTarifario= planTarifarioBO.getCategoriaPlanTarifario(planTarifario);
			parametrosDescto.setCodigoCategoria(planTarifario.getCodigoCategoria());

			//Obtiene Descuento Automatico
			arregloDescuentosAutomaticos = simcardBO.getDescuentoCargo(parametrosDescto);
			List listaDescuentos = new ArrayList();
			for (int indice = 0; indice < arregloDescuentosAutomaticos.length; indice++) {
				
				arregloDescuentosAutomaticos[indice].setTipo(String.valueOf(TipoDescuentos.Automatico));
				listaDescuentos.add(arregloDescuentosAutomaticos[indice]);
	        }//fin for
			     
	        //Obtiene concepto descuento manual.
			/*ParametrosDescuentoDTO parametrosDescuentoManual = new ParametrosDescuentoDTO();
			parametrosDescuentoManual.setCodigoConcepto(codigoConceptoCargo);
	        parametrosDescuentoManual.setTipoConcepto(parametrosDescto.getTipoConceptoDescuento());
	        DescuentoDTO descuentoManual = simcardBO.getCodigoDescuentoManual(parametrosDescuentoManual);
	        listaDescuentos.add(descuentoManual);*/
	        
	        arregloDescuentos =(DescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaDescuentos.toArray(),DescuentoDTO.class);
	        
		} catch (ProductException e) {
			e.printStackTrace();
		} 
		catch (ProductOfferingException e) {
			e.printStackTrace();
		} 
		
		logger.debug("Fin:seleccionDescuentos()");
		return arregloDescuentos;
	}//fin seleccionDescuentos

	public boolean validacion() {
		logger.debug("Inicio:ReglasSimcard:validacion()");
		/*if (!parametrosRegla.getIndicadorValorar().equals(IndValorar)) 
			return false;
		if (!parametrosRegla.getGrupoTecnologiaGSM().equals(parametrosRegla.getGrupoTecnologico()))
			return false;*/
		logger.debug("Fin:ReglasSimcard:validacion()");
		return true;
		//return false;
	}//fin validacion

	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		logger.debug("Inicio:getAtributos()");
		
		AtributosCargoDTO atributos = new AtributosCargoDTO();
		atributos.setTipoProducto(ListaProductos.Simcard);
		atributos.setClaseProducto(ClaseProductos.Bien);
		atributos.setCodigoArticuloServicio(parametrosRegla.getCodigoArticulo());
		atributos.setNumAbonado(parametrosRegla.getNumAbonado());
	
		parametrosRegla.setAtributos(atributos);
		logger.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos
	
}//fin ReglasSimcard
