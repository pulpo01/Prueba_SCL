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
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasServicioOcacionalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.bo.PlanTarifario;
import com.tmmas.cl.scl.productdomain.businessobject.bo.ServicioOcacional;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoServOcacionalesDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;

public class ReglasServiciosOcasionales extends ReglaListaPrecio{

	private static Category cat = Category.getInstance(ReglasServiciosOcasionales.class);
	private ParametrosReglasServicioOcacionalDTO parametrosRegla = new ParametrosReglasServicioOcacionalDTO();
	private ServicioOcacional servicioOcacionalBO = new ServicioOcacional();	
    private ParametrosCargoServOcacionalesDTO servicioOcacional;
	private Documento documentoBO = new Documento();
	private RegistroFacturacion registroFacturacionBO = new RegistroFacturacion();
	private PlanTarifario planTarifarioBO = new PlanTarifario();
    private String codigoConceptoCargo;

    public ReglasServiciosOcasionales(ParametrosReglasServicioOcacionalDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasServiciosOcasionales

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
			arregloDescuentosAutomaticos = servicioOcacionalBO.getDescuentoCargo(parametrosDescto);
			List listaDescuentos = new ArrayList();
			for (int indice = 0; indice < arregloDescuentosAutomaticos.length; indice++) {
				arregloDescuentosAutomaticos[indice].setTipo(String.valueOf(TipoDescuentos.Automatico));
				listaDescuentos.add(arregloDescuentosAutomaticos[indice]);
	        }//fin for
			
	        //Obtiene concepto descuento manual.
			ParametrosDescuentoDTO parametrosDescuentoManual = new ParametrosDescuentoDTO();
	        parametrosDescuentoManual.setCodigoConcepto(codigoConceptoCargo);
	        parametrosDescuentoManual.setTipoConcepto(parametrosDescto.getTipoConceptoDescuento());
	        DescuentoDTO descuentoManual = servicioOcacionalBO.getCodigoDescuentoManual(parametrosDescuentoManual);
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

	public PrecioDTO[] seleccionPrecios() {
		cat.debug("Inicio:seleccionPrecios()");
		servicioOcacional = new ParametrosCargoServOcacionalesDTO();
		servicioOcacional.setCodigoProducto(parametrosRegla.getCodigoProducto());
		servicioOcacional.setCodigoArticulo(parametrosRegla.getCodigoArticulo());
		servicioOcacional.setCodigoPlanTarifario(parametrosRegla.getCodigoPlanTarifario());
		servicioOcacional.setCodigoUso(parametrosRegla.getCodigoUso());
		servicioOcacional.setModalidadVenta(parametrosRegla.getModalidadVenta());
		servicioOcacional.setNumeroMeses(parametrosRegla.getNumeroMeses());
		servicioOcacional.setTipoStock(parametrosRegla.getTipoStock());
		servicioOcacional.setIndicadorComodato(parametrosRegla.getIndicadorComodato());
		servicioOcacional.setCodigoActuacion(parametrosRegla.getCodigoActuacion());
		
		PrecioCargoDTO[] arregloPreciosCargos = null;
		PrecioDTO[] arregloPrecios = null;

		try {
			arregloPreciosCargos = servicioOcacionalBO.getCargoServOcac(servicioOcacional);

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
	        	atributos.setNum_abonado(parametrosRegla.getNum_abonado());
	        	atributos.setNum_terminal(parametrosRegla.getNum_terminal());
	        	precio.setDatosAnexos(atributos);

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
		if (!parametrosRegla.getIndicadorComodato().equals(parametrosRegla.getEsComodato()) 
				&& parametrosRegla.getIndicadorInstalacion() != 1 )    //no es comodato y no tiene cargo de instalacion
			return false;
		cat.debug("Fin:validacion()");
		return true;
	}//fin validacion

	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		cat.debug("Inicio:getAtributos()");
		AtributosCargoDTO atributos = new AtributosCargoDTO();
		atributos.setTipoProducto(ListaProductos.ServiciosOcasionales);
		atributos.setClaseProducto(ClaseProductos.Servicio);
		atributos.setCodigoArticuloServicio(parametrosRegla.getCodigoArticulo());		
		parametrosRegla.setAtributos(atributos);
		cat.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos

}//fin ReglasServiciosOcasionales
