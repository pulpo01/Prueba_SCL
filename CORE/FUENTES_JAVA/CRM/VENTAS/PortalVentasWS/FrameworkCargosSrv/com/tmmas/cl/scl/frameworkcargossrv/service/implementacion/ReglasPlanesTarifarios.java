package com.tmmas.cl.scl.frameworkcargossrv.service.implementacion;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.ClaseProductos;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.ListaProductos;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.TipoDescuentos;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.AtributosCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.AtributosMigracionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Documento;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroFacturacion;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DocumentoFacturacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglaPlanTarifarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.bo.PlanTarifario;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;

public class ReglasPlanesTarifarios extends ReglaListaPrecio {
	private static Category cat = Category.getInstance(ReglasPlanesTarifarios.class);
	private ParametrosReglaPlanTarifarioDTO parametrosRegla = new ParametrosReglaPlanTarifarioDTO();
	private PlanTarifario planTarifarioBO = new PlanTarifario();
	private Documento documentoBO = new Documento();
	private RegistroFacturacion registroFacturacionBO = new RegistroFacturacion();
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
		cat.debug("Inicio:seleccionPrecios()");
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
	        	precio.setTipoCobro(parametrosRegla.getTipoCobro());

				MonedaDTO moneda = new MonedaDTO();
				moneda.setCodigo(arregloPreciosCargos[indice].getCodigoMoneda());
	        	moneda.setDescripcion(arregloPreciosCargos[indice].getDescripcionMoneda());
	        	
	        	precio.setUnidad(moneda);
	        	AtributosMigracionDTO atributos = new AtributosMigracionDTO();
	        	atributos.setInd_paquete(arregloPreciosCargos[indice].getIndicadorPaquete());
	        	atributos.setInd_equipo(arregloPreciosCargos[indice].getIndicadorEquipo());
	        	atributos.setNum_abonado(parametrosRegla.getNum_abonado());
	        	atributos.setNum_terminal(parametrosRegla.getNum_terminal());
	        	atributos.setEsCobroAdelantado(1);
	        	atributos.setTipoServicioCobroAdelantado(parametrosRegla.getTipoServicioCobroAdelantado());
	        	precio.setDatosAnexos(atributos);
	        	codigoConceptoCargo=arregloPreciosCargos[indice].getCodigoConcepto();
	        	listaPrecios.add(precio);
	        }//fin for
			arregloPrecios =(PrecioDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaPrecios.toArray(),PrecioDTO.class);
			
		} catch (ProductDomainException e) {
			e.printStackTrace();
		}
		cat.debug("Fin:seleccionPrecios()");
		return arregloPrecios;
		
	}//fin seleccionPrecios

	public boolean validacion() {
		cat.debug("Inicio:validacion()");
		//SI NO ES CUENTA CONTROLADA O HÍBRIDO ENTONCES NO APLICA LA REGLA
	    /*if (!parametrosRegla.getCodigoUsoLinea().equals(CodUsoLineaCtaCont) && !parametrosRegla.getCodigoUsoLinea().equals(CodUsoLineaHibrido))
			return false;
		if (!parametrosRegla.getIndicadorCargoHabilitacion().equals(IndCargoHabil)) 
			return false;*/
		cat.debug("Fin:validacion()");
		return true;
	}//fin validacion

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
			parametrosDescto.setConcepto(codigoConceptoCargo);
			parametrosDescto.setCodigoCalificaion(parametrosRegla.getCodigoCalificacion());
			
			
			//Obtiene Descuento Automatico
			arregloDescuentosAutomaticos = planTarifarioBO.getDescuentoCargoBasico(parametrosDescto);
			List listaDescuentos = new ArrayList();
			if(arregloDescuentosAutomaticos != null )
			{
				for (int indice = 0; indice < arregloDescuentosAutomaticos.length; indice++) {
					arregloDescuentosAutomaticos[indice].setTipo(String.valueOf(TipoDescuentos.Automatico));
					listaDescuentos.add(arregloDescuentosAutomaticos[indice]);
		        }//fin for
			}
			
	        //Obtiene concepto descuento manual.
			ParametrosDescuentoDTO parametrosDescuentoManual = new ParametrosDescuentoDTO();
	        parametrosDescuentoManual.setCodigoConcepto(codigoConceptoCargo);
	        parametrosDescuentoManual.setTipoConcepto(parametrosDescto.getTipoConceptoDescuento());
	        DescuentoDTO descuentoManual = planTarifarioBO.getCodigoDescuentoManual(parametrosDescuentoManual);
	        listaDescuentos.add(descuentoManual);
	        
	        arregloDescuentos =(DescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaDescuentos.toArray(),DescuentoDTO.class);
	        
		} catch (ProductDomainException e) {
			e.printStackTrace();
		} catch (CustomerDomainException e) {
			e.printStackTrace();
		}
		cat.debug("Fin:seleccionDescuentos()");
		return arregloDescuentos;
	}//fin seleccionDescuentos

	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		cat.debug("Inicio:getAtributos()");
		AtributosCargoDTO atributos = new AtributosCargoDTO();
		atributos.setTipoProducto(ListaProductos.PlanTarifario);
		atributos.setClaseProducto(ClaseProductos.Bien);
		//atributos.setCodigoArticuloServicio(parametrosRegla.getCodigoCargoBasico());
		parametrosRegla.setAtributos(atributos);
		cat.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos


}//fin ReglasPlanesTarifarios
