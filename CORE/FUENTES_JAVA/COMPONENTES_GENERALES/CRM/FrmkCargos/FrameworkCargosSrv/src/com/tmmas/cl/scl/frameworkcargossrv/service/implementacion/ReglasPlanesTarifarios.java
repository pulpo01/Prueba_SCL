package com.tmmas.cl.scl.frameworkcargossrv.service.implementacion;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglaPlanTarifarioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.interfaz.ClaseProductos;
import com.tmmas.scl.framework.productDomain.interfaz.ListaProductos;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DocumentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;

public class ReglasPlanesTarifarios extends ReglaListaPrecio {
	private final Logger logger = Logger.getLogger(ReglasPlanesTarifarios.class);
	private ParametrosReglaPlanTarifarioDTO parametrosRegla;
	//private PlanTarifario planTarifarioBO = new PlanTarifario();
	private PlanTarifarioBOFactoryIT planTarifarioFactory = new PlanTarifarioBOFactory();
	private PlanTarifarioIT planTarifarioBO =planTarifarioFactory.getBusinessObject1();
	//private Documento documentoBO = new Documento();
	private DocumentoBOFactoryIT documentoFactory=new DocumentoBOFactory();
	private DocumentoBOIT documentoBO=documentoFactory.getBusinessObject1();
	//private RegistroFacturacion registroFacturacionBO = new RegistroFacturacion();
	private RegistroFacturacionBOFactoryIT regFactFactory = new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT  registroFacturacionBO=regFactFactory.getBusinessObject1();
	
	private PlanTarifarioDTO planTarifario;
	private String codigoConceptoCargo;
    
    private static String IndCargoHabil = "1"; 			//<1: aplica cargo habilitacion>
    private static String CodUsoLineaHibrido = "10"; 	//<10: hibrido, ahorro>
    private static String CodUsoLineaCtaCont = "10"; 	//<10: cuenta controlada, cuenta segura>
    
	public ReglasPlanesTarifarios(ParametrosReglaPlanTarifarioDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasPlanesTarifarios

	public PrecioDTO[] seleccionPrecios()throws FrameworkCargosException{
		logger.debug("Inicio:seleccionPrecios()");
		planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoProducto(parametrosRegla.getCodigoProducto());
		planTarifario.setCodigoCargoBasico(parametrosRegla.getCodigoCargoBasico());
		
		PrecioCargoDTO[] arregloPreciosCargos = null;
		PrecioDTO[] arregloPrecios = null;
		try {
			arregloPreciosCargos = planTarifarioBO.getCargoBasico(planTarifario);

			List listaPrecios = new ArrayList();
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
	        	codigoConceptoCargo=arregloPreciosCargos[indice].getCodigoConcepto();
	        	listaPrecios.add(precio);
	        }//fin for
			arregloPrecios =(PrecioDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaPrecios.toArray(),PrecioDTO.class);
			
		} catch (ProductOfferingException e) {
			e.printStackTrace();
		}
		logger.debug("Fin:seleccionPrecios()");
		return arregloPrecios;
		
	}//fin seleccionPrecios

	public boolean validacion() {
		logger.debug("Inicio:validacion()");
		//SI NO ES CUENTA CONTROLADA O HÍBRIDO ENTONCES NO APLICA LA REGLA
	    if (!parametrosRegla.getCodigoUsoLinea().equals(CodUsoLineaCtaCont) && !parametrosRegla.getCodigoUsoLinea().equals(CodUsoLineaHibrido))
			return false;
		if (!parametrosRegla.getIndicadorCargoHabilitacion().equals(IndCargoHabil)) 
			return false;
		logger.debug("Fin:validacion()");
		return true;
	}//fin validacion

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
			arregloDescuentosAutomaticos = planTarifarioBO.getDescuentoCargoBasico(parametrosDescto);
			List listaDescuentos = new ArrayList();
			for (int indice = 0; indice < arregloDescuentosAutomaticos.length; indice++) {
				arregloDescuentosAutomaticos[indice].setTipo(String.valueOf(TipoDescuentos.Automatico));
				listaDescuentos.add(arregloDescuentosAutomaticos[indice]);
	        }//fin for
			
	        //Obtiene concepto descuento manual.
			ParametrosDescuentoDTO parametrosDescuentoManual = new ParametrosDescuentoDTO();
	        parametrosDescuentoManual.setCodigoConcepto(codigoConceptoCargo);
	        parametrosDescuentoManual.setTipoConcepto(parametrosDescto.getTipoConceptoDescuento());
	        DescuentoDTO descuentoManual = planTarifarioBO.getCodigoDescuentoManual(parametrosDescuentoManual);
	        listaDescuentos.add(descuentoManual);
	        
	        arregloDescuentos =(DescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaDescuentos.toArray(),DescuentoDTO.class);
	        
		} catch (ProductOfferingException e) {
			e.printStackTrace();
		} catch (ProductException e) {
			e.printStackTrace();
		}
		logger.debug("Fin:seleccionDescuentos()");
		return arregloDescuentos;
	}//fin seleccionDescuentos

	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		logger.debug("Inicio:getAtributos()");
		AtributosCargoDTO atributos = new AtributosCargoDTO();
		atributos.setTipoProducto(ListaProductos.PlanTarifario);
		atributos.setClaseProducto(ClaseProductos.Bien);
		atributos.setCodigoArticuloServicio(parametrosRegla.getCodigoCargoBasico());		
		parametrosRegla.setAtributos(atributos);
		logger.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos


}//fin ReglasPlanesTarifarios
