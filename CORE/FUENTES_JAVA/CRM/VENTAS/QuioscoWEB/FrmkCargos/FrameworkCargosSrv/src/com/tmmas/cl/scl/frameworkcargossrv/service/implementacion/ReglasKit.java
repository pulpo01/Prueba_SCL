package com.tmmas.cl.scl.frameworkcargossrv.service.implementacion;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasKitDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DocumentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.KitBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.KitBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.KitBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoKitDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.interfaz.ClaseProductos;
import com.tmmas.scl.framework.productDomain.interfaz.ListaProductos;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;

public class ReglasKit extends ReglaListaPrecio{

	private final Logger cat = Logger.getLogger(this.getClass());
	private ParametrosReglasKitDTO parametrosRegla;
	private KitBOFactoryIT kitFactory = new KitBOFactory();
	private KitBOIT kitBO = kitFactory.getBusinessObject1();
	private PlanTarifarioBOFactoryIT planTarifarioFactory = new PlanTarifarioBOFactory();
	private PlanTarifarioIT planTarifarioBO =planTarifarioFactory.getBusinessObject1();


	private DocumentoBOFactoryIT documentoFactory=new DocumentoBOFactory();
	private DocumentoBOIT documentoBO=documentoFactory.getBusinessObject1();
	private RegistroFacturacionBOFactoryIT regFactFactory = new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT  registroFacturacionBO=regFactFactory.getBusinessObject1();
	private ParametrosCargoKitDTO kit;
	private String codigoConceptoCargo;

	private static String IndValorar = "1"; 			//< 1: valorar >
	private static String IndPrecioLista = "TRUE"; 		//< TRUE: considera precio lista >
	private static String IndEquipo = "E";
	private static String CodigoUsoPrepago = "3";

	public ReglasKit(ParametrosReglasKitDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasKit

	public PrecioDTO[] seleccionPrecios() throws GeneralException {
		cat.debug("Inicio:ReglasKit:seleccionPrecios()");
		
		PlanTarifarioDTO planTarifario= new PlanTarifarioDTO();
				
		kit = new ParametrosCargoKitDTO();
		kit.setCodigoArticulo(parametrosRegla.getCodigoArticulo());
		kit.setTipoStock(parametrosRegla.getTipoStock());
		kit.setCodigoUso(parametrosRegla.getCodigoUso());
		kit.setEstado(parametrosRegla.getEstado());
		kit.setCodigoCategoria(parametrosRegla.getCodigoCategoria());
		kit.setModalidadVenta(parametrosRegla.getCodigoModalidadVenta());
		kit.setTipoContrato(parametrosRegla.getTipoContrato());
		kit.setCodigoUsoPrepago(CodigoUsoPrepago);
		kit.setPlanTarifario(parametrosRegla.getCodigoPlanTarifario());

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
				kit.setIndiceRecambio(parametrosRegla.getIndiceRecambioPrecioLista());
				arregloPreciosCargos = kitBO.getPrecioCargoKit_PrecioLista(kit);
			}
			else{				
				if (planTarifario.getCodigoTipoPlan().equals("1")){
					kit.setIndiceRecambio(parametrosRegla.getIndiceRecambioPrecioLista());
					arregloPreciosCargos = kitBO.getPrecioCargoKit_PrecioLista(kit);
				}else{
					kit.setIndicadorEquipo(IndEquipo);
					kit.setIndiceRecambio(parametrosRegla.getIndiceRecambioNoLista());
					arregloPreciosCargos = kitBO.getPrecioCargoKit_NoPrecioLista(kit);	
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
		cat.debug("Fin:ReglasKit:seleccionPrecios()");
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
				arregloDescuentosAutomaticos = kitBO.getDescuentoCargo(parametrosDescto);
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
			DescuentoDTO descuentoManual = kitBO.getCodigoDescuentoManual(parametrosDescuentoManual);
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
		cat.debug("Inicio:ReglasKit:validacion()");
		if (!parametrosRegla.getIndicadorValorar().equals(IndValorar)) 
			return false;
		if (!parametrosRegla.getGrupoTecnologiaGSM().equals(parametrosRegla.getGrupoTecnologico()))
			return false;
		cat.debug("Fin:ReglasKit:validacion()");
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
