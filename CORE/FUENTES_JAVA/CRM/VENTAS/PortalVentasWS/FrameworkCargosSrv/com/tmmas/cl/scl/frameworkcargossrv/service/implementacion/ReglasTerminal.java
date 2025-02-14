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
import com.tmmas.cl.scl.customerdomain.businessobject.bo.DatosGenerales;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Documento;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroFacturacion;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DocumentoFacturacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasTerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.bo.PlanTarifario;
import com.tmmas.cl.scl.productdomain.businessobject.bo.Terminal;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoTerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TerminalDTO;

public class ReglasTerminal extends ReglaListaPrecio{
	private static Category cat = Category.getInstance(ReglasTerminal.class);

	private ParametrosReglasTerminalDTO parametrosRegla = new ParametrosReglasTerminalDTO();
	private DatosGenerales datosGeneralesBO = new DatosGenerales();
	private Terminal terminalBO = new Terminal();
    private ParametrosCargoTerminalDTO terminal;
    private String codigoConceptoCargo;
    private Documento documentoBO = new Documento();
	private RegistroFacturacion registroFacturacionBO = new RegistroFacturacion();
	private PlanTarifario planTarifarioBO = new PlanTarifario();
    
    
    private static String IndValorar = "1"; 			//< 1: valorar >
    private static String IndProcedencia = "I"; 		//< I: interno >
    private static String IndPrecioLista = "TRUE"; 		//< TRUE: considera precio lista >
    private static String IndEquipo = "E";
    private static String CodigoUsoPrepago = "3";
    
	
	public ReglasTerminal(ParametrosReglasTerminalDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasTerminal

	public PrecioDTO[] seleccionPrecios() {
		cat.debug("Inicio:seleccionPrecios()");

		terminal = new ParametrosCargoTerminalDTO();
		terminal.setCodigoArticulo(parametrosRegla.getCodigoArticulo());
		terminal.setTipoStock(parametrosRegla.getTipoStock());
		terminal.setCodigoUso(parametrosRegla.getCodigoUso());
		terminal.setEstado(parametrosRegla.getEstado());
		terminal.setCodigoCategoria(parametrosRegla.getCodigoCategoria());
		terminal.setModalidadVenta(parametrosRegla.getCodigoModalidadVenta());
		terminal.setTipoContrato(parametrosRegla.getTipoContrato());
		terminal.setCodigoUsoPrepago(CodigoUsoPrepago);
		terminal.setPlanTarifario(parametrosRegla.getCodigoPlanTarifario());
		terminal.setCodigoCalificacion(parametrosRegla.getCodigoCalificacion());
		terminal.setIndRenovacion(parametrosRegla.getIndRenovacion());
		terminal.setIndiceRecambio(parametrosRegla.getCodigoUso()==3?"9":"0");
		PrecioCargoDTO[] arregloPreciosCargos = null;
		PrecioDTO[] arregloPrecios = null;

		try {
			if (parametrosRegla.getIndicadorPrecioLista().equals(IndPrecioLista)){
				//terminal.setIndiceRecambio(parametrosRegla.getIndiceRecambioPrecioLista());
				arregloPreciosCargos = terminalBO.getPrecioCargoTerminal_PrecioLista(terminal);
			}
			else{
				terminal.setIndicadorEquipo(IndEquipo);
				//terminal.setIndiceRecambio(parametrosRegla.getIndiceRecambioNoLista());
				arregloPreciosCargos = terminalBO.getPrecioCargoTerminal_NoPrecioLista(terminal);
				
			}
			List listaPrecios = new ArrayList();
			
			DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
			if( parametrosRegla.getEsMayorista().trim().equals("TRUE"))
			{
				try{			
					cat.debug("Ingreso a concepto_exento");
					datosGenerales.setCodigoParametro("CONCEPTO_EXENTO");
					datosGenerales.setCodigoModulo("GA");
					datosGenerales.setCodigoProducto("1");
					datosGenerales= datosGeneralesBO.getValorParametro(datosGenerales);
					cat.debug("Ingreso a concepto_exento datosGenerales : " + datosGenerales.getValorParametro());
				}catch(CustomerDomainException e){
				//	throw (e);
				}
			}
			
	        for (int indice = 0; indice < arregloPreciosCargos.length; indice++) 
	        {
				PrecioDTO precio = new PrecioDTO();
				cat.debug("parametrosRegla ES MAYORISTA TERMINAL: " + parametrosRegla.getEsMayorista());
				cat.debug("datosGenerales.getValorParametro() TERMINAL: " + datosGenerales.getValorParametro());
				if( parametrosRegla.getEsMayorista().trim().equals("FALSE"))
				{
					precio.setCodigoConcepto(arregloPreciosCargos[indice].getCodigoConcepto());
					precio.setMonto(arregloPreciosCargos[indice].getMonto());
				}else { //ES MAYORISTA
					precio.setCodigoConcepto(datosGenerales.getValorParametro());					
					//Se obtiene el impuesto asociado al concepto real dado que es mayorista
					RegistroFacturacionDTO registroDTO = new RegistroFacturacionDTO();
					registroDTO.setCodigoCliente(parametrosRegla.getCodigoCliente());
					registroDTO.setCodigoConcepto(Long.valueOf(arregloPreciosCargos[indice].getCodigoConcepto()));
					registroDTO.setCodigoOficina(parametrosRegla.getCodOficina());
					registroDTO.setImportePlan(arregloPreciosCargos[indice].getMonto());
					registroDTO = registroFacturacionBO.aplicaImpuestoConceptoMayorista(registroDTO);
					precio.setMonto(registroDTO.getImporteTotal());
				}				
				
	        	precio.setDescripcionConcepto(arregloPreciosCargos[indice].getDescripcionConcepto());	        	
	        	precio.setNroSerie(parametrosRegla.getNroSerie());
	        	precio.setCodBodega(parametrosRegla.getCodBodega());
	        	codigoConceptoCargo=arregloPreciosCargos[indice].getCodigoConcepto();

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
			if (arregloPrecios!=null)
				if (arregloPrecios.length>0)
					codigoConceptoCargo = arregloPrecios[0].getCodigoConcepto();					
		} catch (ProductDomainException e) {
			e.printStackTrace();		
		} catch (CustomerDomainException e) {
			e.printStackTrace();
		}		
		cat.debug("Fin:seleccionPrecios()+arregloPreciosCargos.length: " + arregloPreciosCargos.length);
		
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
			parametrosDescto.setCodigoCalificaion(parametrosRegla.getCodigoCalificacion());
			parametrosDescto.setIndRenovacion(parametrosRegla.getIndRenovacion());
			arregloDescuentosAutomaticos = terminalBO.getDescuentoCargo(parametrosDescto);
			List listaDescuentos = new ArrayList();
			if(arregloDescuentosAutomaticos!=null)
			{				
				for (int indice = 0; indice < arregloDescuentosAutomaticos.length; indice++) {
					arregloDescuentosAutomaticos[indice].setTipo(String.valueOf(TipoDescuentos.Automatico));
					listaDescuentos.add(arregloDescuentosAutomaticos[indice]);
		        }//fin for
				arregloDescuentos =(DescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaDescuentos.toArray(),DescuentoDTO.class);				
			}
			
			//Obtiene concepto descuento manual.
			/*ParametrosDescuentoDTO parametrosDescuentoManual = new ParametrosDescuentoDTO();
	        parametrosDescuentoManual.setCodigoConcepto(codigoConceptoCargo);
	        parametrosDescuentoManual.setTipoConcepto(parametrosDescto.getTipoConceptoDescuento());
	        DescuentoDTO descuentoManual = terminalBO.getCodigoDescuentoManual(parametrosDescuentoManual);
	        listaDescuentos.add(descuentoManual);*/	        
	        
	        
		} catch (ProductDomainException e) {
			e.printStackTrace();
		} catch (CustomerDomainException e) {
			e.printStackTrace();
		}
		cat.debug("Fin:seleccionDescuentos()");
		return arregloDescuentos;
	}//fin seleccionDescuentos
	
	/**
	 *Retorna los atributos asocaidos a la regla
	 * @param 
	 * @return boolean 
	 * @throws 
	 */

	public boolean validacion() {
		cat.debug("Inicio:validacion()");

/*		   
		If DatVenta.Ind_Comodato = "1" Then
		      bCarCargosEquip = True
		      Exit Function
		   End If
		   
		   If DatVenta.IndCuota = "2" Or DatVenta.IndCuota = "-1" Then
		      ' Arriendo, no se generan cargos por el equipo.
		      bCarCargosEquip = True
		      Exit Function
		   End If
*/
		try{
			
			TerminalDTO terminaldto = new TerminalDTO();
			cat.debug("numero serie prueba:" + parametrosRegla.getNumeroSerie());
			terminaldto.setNumeroSerie(parametrosRegla.getNumeroSerie());
			terminaldto = terminalBO.getTerminal(terminaldto);
			if (!terminaldto.getIndProcEq().equals(IndProcedencia))					
				return false;
			if (!parametrosRegla.getIndicadorValorar().equals(IndValorar) && 
					parametrosRegla.getEsMayorista().trim().equals("FALSE")) 
				return false;
			if(parametrosRegla.getEsMayorista().trim().equals("TRUE") 
					&& parametrosRegla.getCodigoModalidadVenta().trim().equals("1"))
				return false;		
			cat.debug("Fin:validacion()");
			return true;
		}catch (ProductDomainException e){
			e.printStackTrace();
			
		}
		cat.debug("Fin:validacion()");
		return false;
		
	}//fin validacion
	
	/**
	 *Retorna los atributos asociados a la regla
	 * @param 
	 * @return parametrosRegla 
	 * @throws FrameworkCargosException
	 */
	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		cat.debug("Inicio:getAtributos()");
		
		AtributosCargoDTO atributos = new AtributosCargoDTO();
		atributos.setTipoProducto(ListaProductos.Terminal);
		atributos.setClaseProducto(ClaseProductos.Bien);
		atributos.setCodigoArticuloServicio(parametrosRegla.getCodigoArticulo());
		parametrosRegla.setAtributos(atributos);
		cat.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos

}//fin ReglasTerminal
