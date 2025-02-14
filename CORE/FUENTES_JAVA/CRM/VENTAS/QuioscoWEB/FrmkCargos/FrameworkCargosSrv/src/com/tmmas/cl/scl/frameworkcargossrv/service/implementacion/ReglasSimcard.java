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
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasSimcardDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DocumentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SimcardBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoSimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.interfaz.ClaseProductos;
import com.tmmas.scl.framework.productDomain.interfaz.ListaProductos;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;

public class ReglasSimcard extends ReglaListaPrecio{

	private final Logger cat = Logger.getLogger(this.getClass());
	private ParametrosReglasSimcardDTO parametrosRegla;
	private SimcardBOFactoryIT simcardFactory=new SimcardBOFactory();
	private SimcardBOIT simcardBO=simcardFactory.getBusinessObject1();
	private PlanTarifarioBOFactoryIT planTarifarioFactory = new PlanTarifarioBOFactory();
	private PlanTarifarioIT planTarifarioBO =planTarifarioFactory.getBusinessObject1();


	private DocumentoBOFactoryIT documentoFactory=new DocumentoBOFactory();
	private DocumentoBOIT documentoBO=documentoFactory.getBusinessObject1();
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

	public PrecioDTO[] seleccionPrecios() throws GeneralException {
		cat.debug("Inicio:ReglasSimcard:seleccionPrecios()");
		
		PlanTarifarioDTO planTarifario= new PlanTarifarioDTO();
		
		
		
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
			
			planTarifario.setCodigoPlanTarifario(parametrosRegla.getCodigoPlanTarifario());
			planTarifario.setCodigoTecnologia(parametrosRegla.getCodTecnologia());
			planTarifario.setCodigoProducto("1");
			planTarifario= planTarifarioBO.getPlanTarifario(planTarifario);
			
			
			cat.debug("parametrosRegla.getIndicadorPrecioLista() ["+parametrosRegla.getIndicadorPrecioLista()+"]");
			cat.debug("IndPrecioLista ["+IndPrecioLista+"]");
			
			if (parametrosRegla.getIndicadorPrecioLista().equals(IndPrecioLista)){
				simcard.setIndiceRecambio(parametrosRegla.getIndiceRecambioPrecioLista());
				arregloPreciosCargos = simcardBO.getPrecioCargoSimcard_PrecioLista(simcard);
			}
			else{				
				if (planTarifario.getCodigoTipoPlan().equals("1")){
					simcard.setIndiceRecambio(parametrosRegla.getIndiceRecambioPrecioLista());
					arregloPreciosCargos = simcardBO.getPrecioCargoSimcard_PrecioLista(simcard);
				}else{
					simcard.setIndicadorEquipo(IndEquipo);
					simcard.setIndiceRecambio(parametrosRegla.getIndiceRecambioNoLista());
					arregloPreciosCargos = simcardBO.getPrecioCargoSimcard_NoPrecioLista(simcard);	
				}
			}
			List listaPrecios = new ArrayList();
			for (int indice = 0; indice < arregloPreciosCargos.length; indice++) {
				PrecioDTO precio = new PrecioDTO();
				precio.setCodigoConcepto(arregloPreciosCargos[indice].getCodigoConcepto());
				precio.setDescripcionConcepto(arregloPreciosCargos[indice].getDescripcionConcepto());
				precio.setMonto(arregloPreciosCargos[indice].getMonto());
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

		} catch (GeneralException e) {
			cat.debug("GeneralException Simcard DAO");			
			cat.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
			cat.debug("e.getCodigo()[" + e.getCodigo() + "]");
			throw e;	
		}
		cat.debug("Fin:ReglasSimcard:seleccionPrecios()");
		return arregloPrecios;
	}//fin seleccionPrecios

	/**
	 *Busca los descuentos asocaidos a la regla
	 * @param 
	 * @return arregloDescuentos
	 * @throws FrameworkCargosException
	 */

	public DescuentoDTO[] seleccionDescuentos() {
		cat.debug("Inicio:seleccionDescuentos()");
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
			parametrosDescto.setConcepto(codigoConceptoCargo);




			try{
				arregloDescuentosAutomaticos = simcardBO.getDescuentoCargo(parametrosDescto);
			}catch (GeneralException e) {
				arregloDescuentosAutomaticos = null;
			}


			List listaDescuentos = new ArrayList();
			if (arregloDescuentosAutomaticos != null){
				for (int indice = 0; indice < arregloDescuentosAutomaticos.length; indice++) {

					arregloDescuentosAutomaticos[indice].setTipo(String.valueOf(TipoDescuentos.Automatico));
					listaDescuentos.add(arregloDescuentosAutomaticos[indice]);
				}//fin for
			}

			//Obtiene concepto descuento manual.
			ParametrosDescuentoDTO parametrosDescuentoManual = new ParametrosDescuentoDTO();
			parametrosDescuentoManual.setCodigoConcepto(codigoConceptoCargo);
			parametrosDescuentoManual.setTipoConcepto(parametrosDescto.getTipoConceptoDescuento());
			DescuentoDTO descuentoManual = simcardBO.getCodigoDescuentoManual(parametrosDescuentoManual);
			descuentoManual.setTipo(String.valueOf(TipoDescuentos.Manual));
			descuentoManual.setTipoAplicacion(String.valueOf(TipoDescuentos.Importe));
			listaDescuentos.add(descuentoManual);

			arregloDescuentos =(DescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaDescuentos.toArray(),DescuentoDTO.class);

		} catch (GeneralException e) {
			e.printStackTrace();
		} 
		cat.debug("Fin:seleccionDescuentos()");
		return arregloDescuentos;
	}//fin seleccionDescuentos

	public boolean validacion() {
		cat.debug("Inicio:ReglasSimcard:validacion()");
		if (!parametrosRegla.getIndicadorValorar().equals(IndValorar)) 
			return false;
		if (!parametrosRegla.getGrupoTecnologiaGSM().equals(parametrosRegla.getGrupoTecnologico()))
			return false;
		cat.debug("Fin:ReglasSimcard:validacion()");
		return true;
	}//fin validacion

	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		cat.debug("Inicio:getAtributos()");

		AtributosCargoDTO atributos = new AtributosCargoDTO();
		atributos.setTipoProducto(ListaProductos.Simcard);
		atributos.setClaseProducto(ClaseProductos.Bien);
		atributos.setCodigoArticuloServicio(parametrosRegla.getCodigoArticulo());
		atributos.setNumAbonado(parametrosRegla.getNumAbonado());
		atributos.setNumTerminal(parametrosRegla.getNumCelular());
		atributos.setNumSerie(parametrosRegla.getNumSerie());
		parametrosRegla.setAtributos(atributos);
		cat.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos

}//fin ReglasSimcard
