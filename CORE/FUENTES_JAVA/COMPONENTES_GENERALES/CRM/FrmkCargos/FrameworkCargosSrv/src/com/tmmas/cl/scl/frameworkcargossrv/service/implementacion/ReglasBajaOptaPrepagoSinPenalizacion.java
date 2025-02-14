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
import com.tmmas.cl.framework.util.Global;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasBajaOptaPrepagoSinPenalizacionDTO;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.ServiciosVentaBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ServiciosVentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ServiciosVentaBOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.TipoComisionistaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoSegmentacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.interfaz.ClaseProductos;
import com.tmmas.scl.framework.productDomain.interfaz.ListaProductos;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DocumentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ServicioOcasionalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.TerminalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ParametrosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargosDevlEquipoAccesorioQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;


public class ReglasBajaOptaPrepagoSinPenalizacion extends ReglaListaPrecio{
	private final Logger logger = Logger.getLogger(ReglasBajaOptaPrepagoSinPenalizacion.class);
	private Global global = Global.getInstance();
	private ParametrosReglasBajaOptaPrepagoSinPenalizacionDTO parametrosRegla;
		
    private String codigoConceptoCargo;
	
    private TerminalBOFactoryIT TerminalFactory=new TerminalBOFactory();
	private TerminalBOIT terminalBO=TerminalFactory.getBusinessObject1();


	private DocumentoBOFactoryIT docFactory =new DocumentoBOFactory();
	private DocumentoBOIT documentoBO=docFactory.getBusinessObject1();
	

	private RegistroFacturacionBOFactoryIT regFactFactory=new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT registroFacturacionBO=regFactFactory.getBusinessObject1();

	private ParametrosGeneralesBOFactoryIT paramGeneFactory=new ParametrosGeneralesBOFactory();
	private ParametrosGeneralesIT paramGenerBO=paramGeneFactory.getBusinessObject1();
	
	private ServicioOcasionalBOFactoryIT servOcFactory=new ServicioOcasionalBOFactory();
	private ServicioOcasionalBOIT servicioOcasionalBO=servOcFactory.getBusinessObject1();
	
	private ServiciosVentaBOFactoryIT serVentaFactory =new ServiciosVentaBOFactory();
	private ServiciosVentaBOIT serviciosVentaBO=serVentaFactory.getBusinessObject1();
	private CargoBOFactoryIT cargoFactory = new CargoBOFactory();
	private CargoIT cargosBO=cargoFactory.getBusinessObject1();
	
	
    
    private String codTipPlanTarifDest; //1: Prepago, 2:PostPago, 3:Hibrido
    
	
	public ReglasBajaOptaPrepagoSinPenalizacion(ParametrosReglasBajaOptaPrepagoSinPenalizacionDTO parametros) {
		super(parametros);
		this.parametrosRegla = parametros;
	}//fin ReglasTerminal

	public PrecioDTO[] seleccionPrecios() {
		logger.debug("Inicio:seleccionPrecios()");
		
		
		PrecioDTO[] arregloPrecios = null;

		try {
			
			// Evaluamos el estado de devolucion del Equipo
			/*PrecioCargoDTO[] preciosCargosEquipo=null;
			
        	String codEstadoDev=parametrosRegla.getCod_EstadDevolucion();
        	codEstadoDev=codEstadoDev==null?"":codEstadoDev.trim();
        	String equipCargador=parametrosRegla.getCodEquipoCargador();
        	equipCargador=equipCargador==null?"":equipCargador.trim();
        	
        	CargosDevlEquipoAccesorioQTDTO cargosDevlEquipoAccesorioQTDTO= new CargosDevlEquipoAccesorioQTDTO();*/
			List listaPrecios = new ArrayList();
        	ParametrosGeneralesDTO parametrosDTO =new ParametrosGeneralesDTO();
        	parametrosDTO.setCodigomodulo(parametrosRegla.getCodModulo());
    		parametrosDTO.setCodigoproducto(String.valueOf(parametrosRegla.getCod_Producto()));
	
    		//TODO: Cargos por Equipo                                                                                                                       
            
	        String indComodato=parametrosRegla.getIndComodato();                                                                                    
	        indComodato=indComodato==null?"":indComodato.trim();                                                                                     
	        if (indComodato.equals(Global.getValor("parametro.comodato"))){                                                                          
	        	PrecioCargoDTO[] preciosCargosEquipo=null;                                                                                       
	        	String codEstadoDev=parametrosRegla.getCod_EstadDevolucion();                                                                          
	        	codEstadoDev=codEstadoDev==null?"":codEstadoDev.trim();                                                                          
	        	String equipCargador=parametrosRegla.getCodEquipoCargador();                                                                         
	        	equipCargador=equipCargador==null?"":equipCargador.trim();                                                                       
	        	                                                                                                                                 
	        	CargosDevlEquipoAccesorioQTDTO cargosDevlEquipoAccesorioQTDTO= new CargosDevlEquipoAccesorioQTDTO();                             
	        	parametrosDTO.setCodigomodulo(parametrosRegla.getCodModulo());                                                                  
	    		parametrosDTO.setCodigoproducto(String.valueOf(parametrosRegla.getCod_Producto()));                                              
	    		                                                                                                                                 
	        	if (!codEstadoDev.equals(Global.getValor("codigo.devolucion.equipo.D"))){                                                        
	        		                                                                                                                         
	        		//Se realiza llamada a ged_parametros para cargar el dato de coConcepto;                                                 
	        		parametrosDTO.setNombreparametro(Global.getValor("parametro.concepto.estado.equipo"));                                   
	        		parametrosDTO=paramGenerBO.getParametroGeneral(parametrosDTO);                                                           
	        		                                                                                                                         
	        		String codConcepto=parametrosDTO.getValorparametro()==null?"0":parametrosDTO.getValorparametro();                        
	        		cargosDevlEquipoAccesorioQTDTO.setCod_Concepto(Long.parseLong(codConcepto));                                             
					cargosDevlEquipoAccesorioQTDTO.setCod_Producto(parametrosRegla.getCod_Producto());                               
					cargosDevlEquipoAccesorioQTDTO.setCod_Categoria(parametrosRegla.getParametrosDescuento().getCodigoCategoria());  
					cargosDevlEquipoAccesorioQTDTO.setCod_Tipcontrato(parametrosRegla.getParametrosDescuento().getTipoContrato());   
					String numMeses=String.valueOf(parametrosRegla.getParametrosDescuento().getNumeroMesesContrato());               
					numMeses=numMeses==null?"0":numMeses;                                                                            
					cargosDevlEquipoAccesorioQTDTO.setNum_Meses(Long.parseLong(numMeses));                                           
					cargosDevlEquipoAccesorioQTDTO.setCod_Antiguedad(parametrosRegla.getParametrosDescuento().getCodigoAntiguedad());
					cargosDevlEquipoAccesorioQTDTO.setCod_Operacion(parametrosRegla.getParametrosDescuento().getCodigoOperacion());  
					String indCausa=parametrosRegla.getInd_Causa();                                                                  
					indCausa=indCausa==null?"0":indCausa;                                                                            
					cargosDevlEquipoAccesorioQTDTO.setInd_Causa(Long.parseLong(indCausa));                                           
					cargosDevlEquipoAccesorioQTDTO.setCod_Causa(parametrosRegla.getCod_Causa());                                     
					String codModPag=parametrosRegla.getParametrosDescuento().getCodigoModalidadVenta();                                                              
					codModPag=codModPag==null?"0":codModPag;                                                                         
					cargosDevlEquipoAccesorioQTDTO.setCod_Modpago(Long.parseLong(codModPag));                                        
					cargosDevlEquipoAccesorioQTDTO.setCod_Estado_Dev(parametrosRegla.getCod_EstadDevolucion());                            
					                                                                                                                 
					preciosCargosEquipo=cargosBO.getCargosDevolucionEquipoAccesorio(cargosDevlEquipoAccesorioQTDTO);                 
					                                                                                                                 
					for (int indice = 0; indice < preciosCargosEquipo.length; indice++) {                                            
						PrecioDTO precio = new PrecioDTO();                                                                      
			        	precio.setCodigoConcepto(preciosCargosEquipo[indice].getCodigoConcepto());                                       
			        	precio.setDescripcionConcepto(preciosCargosEquipo[indice].getDescripcionConcepto());                             
			        	precio.setMonto(preciosCargosEquipo[indice].getMonto());                                                         
			        	//precio.setValorMaximo(global.getValor("parametro.valor.maximo"));                                                
			        	//precio.setValorMinimo(global.getValor("parametro.valor.minimo"));                                                
	                                                                                                                                                 
						MonedaDTO moneda = new MonedaDTO();                                                                      
						moneda.setCodigo(preciosCargosEquipo[indice].getCodigoMoneda());                                         
			        	moneda.setDescripcion(preciosCargosEquipo[indice].getDescripcionMoneda());                                       
			        	                                                                                                                 
			        	precio.setUnidad(moneda);                                                                                        
			        	                                                                                                                 
			        	AtributosMigracionDTO atributos = new AtributosMigracionDTO();                                                   
			        	atributos.setInd_paquete(preciosCargosEquipo[indice].getIndicadorPaquete());                                     
			        	atributos.setInd_equipo(preciosCargosEquipo[indice].getIndicadorEquipo());
			        	atributos.setNumAbonado(parametrosRegla.getNumAbonado());
			        	precio.setDatosAnexos(atributos);                                                                                
	                                                                                                                                                 
			        	listaPrecios.add(precio);                                                                                        
			        }//fin for                                                                                                               
				}                                                                                                                        
				                                                                                                                         
				if (equipCargador.equals(Global.getValor("codigo.equipo.cargador.N"))){                                                  
//					Se realiza llamada a ged_parametros para cargar el dato de coConcepto;                                           
	        		parametrosDTO.setNombreparametro(Global.getValor("parametro.concepto.cargador"));                                        
	        		parametrosDTO=paramGenerBO.getParametroGeneral(parametrosDTO);                                                           
	        		                                                                                                                         
					PrecioCargoDTO[] preciosCargosAccesorios=null;                                                                   
					String codConcepto=parametrosDTO.getValorparametro()==null?"0":parametrosDTO.getValorparametro();                
	        		cargosDevlEquipoAccesorioQTDTO.setCod_Concepto(Long.parseLong(codConcepto));                                             
					cargosDevlEquipoAccesorioQTDTO.setCod_Producto(parametrosRegla.getCod_Producto());                               
					cargosDevlEquipoAccesorioQTDTO.setCod_Categoria(parametrosRegla.getParametrosDescuento().getCodigoCategoria());  
					cargosDevlEquipoAccesorioQTDTO.setCod_Tipcontrato(parametrosRegla.getParametrosDescuento().getTipoContrato());   
					String numMeses=String.valueOf(parametrosRegla.getParametrosDescuento().getNumeroMesesContrato());               
					numMeses=numMeses==null?"0":numMeses;                                                                            
					cargosDevlEquipoAccesorioQTDTO.setNum_Meses(Long.parseLong(numMeses));                                           
					cargosDevlEquipoAccesorioQTDTO.setCod_Antiguedad(parametrosRegla.getParametrosDescuento().getCodigoAntiguedad());
					cargosDevlEquipoAccesorioQTDTO.setCod_Operacion(parametrosRegla.getParametrosDescuento().getCodigoOperacion());  
					String indCausa=parametrosRegla.getInd_Causa();                                                                  
					indCausa=indCausa==null?"0":indCausa;                                                                            
					cargosDevlEquipoAccesorioQTDTO.setInd_Causa(Long.parseLong(indCausa));                                           
					cargosDevlEquipoAccesorioQTDTO.setCod_Causa(parametrosRegla.getCod_Causa());                                     
					String codModPag=parametrosRegla.getParametrosDescuento().getCodigoModalidadVenta();                                                              
					codModPag=codModPag==null?"0":codModPag;                                                                         
					cargosDevlEquipoAccesorioQTDTO.setCod_Modpago(Long.parseLong(codModPag));                                        
					cargosDevlEquipoAccesorioQTDTO.setCod_Estado_Dev(parametrosRegla.getCod_EstadDevolucion());		                 
					preciosCargosAccesorios=cargosBO.getCargosDevolucionEquipoAccesorio(cargosDevlEquipoAccesorioQTDTO);             
					for (int indice = 0; indice < preciosCargosAccesorios.length; indice++) {                                        
						PrecioDTO precio = new PrecioDTO();                                                                      
			        	precio.setCodigoConcepto(preciosCargosAccesorios[indice].getCodigoConcepto());                                   
			        	precio.setDescripcionConcepto(preciosCargosAccesorios[indice].getDescripcionConcepto());                         
			        	precio.setMonto(preciosCargosAccesorios[indice].getMonto());                                                     
	                                                                                                                                                 
						MonedaDTO moneda = new MonedaDTO();                                                                      
						moneda.setCodigo(preciosCargosAccesorios[indice].getCodigoMoneda());                                     
			        	moneda.setDescripcion(preciosCargosAccesorios[indice].getDescripcionMoneda());                                   
			        	                                                                                                                 
			        	precio.setUnidad(moneda);                                                                                        
			        	                                                                                                                 
			        	AtributosMigracionDTO atributos = new AtributosMigracionDTO();                                                   
			        	atributos.setInd_paquete(preciosCargosAccesorios[indice].getIndicadorPaquete());                                 
			        	atributos.setInd_equipo(preciosCargosAccesorios[indice].getIndicadorEquipo());
			        	atributos.setNumAbonado(parametrosRegla.getNumAbonado());
			        	precio.setDatosAnexos(atributos);                                                                                
	                                                                                                                                                 
			        	listaPrecios.add(precio);                                                                                        
			        }//fin for                                                                                                               
					                                                                                                                 
					//Aplicar descuentos Automáticos//Lista Precios                                                                  
					//Aplica Descuetos aUTOMATICOS                                                                                   
					                                                                                                                 
				}//Fin Cargador                                                                                                          
	        }//Fin Comodato   
			
			arregloPrecios =(PrecioDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaPrecios.toArray(),PrecioDTO.class);
			if (arregloPrecios!=null)
				if (arregloPrecios.length>0)
					codigoConceptoCargo = arregloPrecios[0].getCodigoConcepto();
		} catch (ProductOfferingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 
		 catch (ProductOfferingPriceException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		//logger.debug("Fin:seleccionPrecios()+arregloPreciosCargos.length: " + arregloPreciosCargos.length);
		
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
		try {
			ParametrosDescuentoDTO parametrosDescto = parametrosRegla.getParametrosDescuento();
		
			//Obtiene Promedio Facturado a Cliente
			DocumentoFacturacionDTO documento = new DocumentoFacturacionDTO();
			documento.setIndiceCiclo(parametrosDescto.getIndicadorCiclo());
			documento.setNumeroMeses(parametrosDescto.getNumeroMesesFact());
			documento.setCodigoCliente(String.valueOf(parametrosRegla.getCodigoCliente()));
			documento = documentoBO.getPromedioDocumentosFacturados(documento);
			System.out.println("documento.getPromedioFacturado():::::::::::::::."+documento.getPromedioFacturado());
			parametrosDescto.setValorPromedioFact(documento.getPromedioFacturado());
			
            //Obtiene Codigo Promedio Facturado a Cliente
			RegistroFacturacionDTO registroFac = new RegistroFacturacionDTO();
			registroFac.setValorPromedio(parametrosDescto.getValorPromedioFact());
			registroFac = registroFacturacionBO.getCodigoPromedioFacturado(registroFac);
			
			parametrosDescto.setCodigoPromedioFacturable(String.valueOf(registroFac.getCodigoPromedio()));
			ParametrosGeneralesDTO paramGeneralDTO =new ParametrosGeneralesDTO (); 
		
			//TODO: Obtención de Parametros de Decuentos Automáticos por:
			// 1. Concepto : VAL_PARAMETRO = 'CON' 
			// 2. Artículo : VAL_PARAMETRO = 'ART'
			
			paramGeneralDTO.setCodigomodulo(parametrosRegla.getCodModulo()); //GA
			paramGeneralDTO.setCodigoproducto(String.valueOf(parametrosRegla.getCod_Producto()));//1
			paramGeneralDTO.setNombreparametro(Global.getValor("parametro.clase.descuento.concepto"));
			
			paramGeneralDTO=paramGenerBO.getParametroGeneral(paramGeneralDTO);
			parametrosDescto.setClaseDescuento(paramGeneralDTO.getValorparametro());
			//Se aplica validación para clase-descuento 
			ArticuloDTO articuloDTO=new ArticuloDTO();  
			//articuloDTO.setCod_conceptoart(Integer.parseInt(codigoConceptoCargo));
			String codConceptoDesc=servicioOcasionalBO.existeCodigoConceptoArticulo(articuloDTO)?"ART":"CON";
			parametrosDescto.setClaseDescuento(codConceptoDesc);
			VendedorDTO vendedorDTO=new VendedorDTO();
			vendedorDTO.setCodigoVendedor(parametrosDescto.getCodigoVendedor());
			TipoComisionistaDTO tipoComisionistaDTO=new TipoComisionistaDTO();
			tipoComisionistaDTO=serviciosVentaBO.ObtieneComisPorVendedor(vendedorDTO);
			parametrosDescto.setIndiceVentaExterna(tipoComisionistaDTO.getIndExterno());
			parametrosDescto.setTipoPlanTarifario(codTipPlanTarifDest);
			parametrosDescto.setCodigoConcepto(codigoConceptoCargo);
			//Obtiene Descuento Automatico
			arregloDescuentosAutomaticos = servicioOcasionalBO.getDescuentoCargo(parametrosDescto);
			List listaDescuentos = new ArrayList();
			for (int indice = 0; indice < arregloDescuentosAutomaticos.length; indice++) {
				arregloDescuentosAutomaticos[indice].setTipo(String.valueOf(TipoDescuentos.Automatico));
				listaDescuentos.add(arregloDescuentosAutomaticos[indice]);
	        }//fin for
			          
	        //Obtiene concepto descuento manual.
			ParametrosDescuentoDTO parametrosDescuentoManual = new ParametrosDescuentoDTO();
	        parametrosDescuentoManual.setCodigoConcepto(codigoConceptoCargo);
			parametrosDescuentoManual.setTipoConcepto(parametrosDescto.getTipoConceptoDescuento());
	        //TODO :Analizar el uso de este proceso, probablemente no se usa
			DescuentoDTO descuentoManual = terminalBO.getCodigoDescuentoManual(parametrosDescuentoManual);
	        listaDescuentos.add(descuentoManual);
	        
	        arregloDescuentos =(DescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaDescuentos.toArray(),DescuentoDTO.class);
	        
	    } catch (ProductException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 catch (ProductOfferingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 
		 catch (CustomerBillException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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
			
			/*TerminalDTO terminaldto = new TerminalDTO();
			logger.debug("numero serie prueba:" + parametrosRegla.getNumeroSerie());
			terminaldto.setNumeroSerie(parametrosRegla.getNumeroSerie());
			terminaldto = terminalBO.getTerminal(terminaldto);
			if (!terminaldto.getIndProcEq().equals(IndProcedencia)) 
				return false;
			if (!parametrosRegla.getIndicadorValorar().equals(IndValorar)) 
				return false;*/
			//parametrosRegla
			
			logger.debug("Fin:validacion()");
			return true;
		}catch (Exception e){
			e.printStackTrace();
			
		}
		logger.debug("Fin:validacion()");
		return false;
		
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
		atributos.setTipoProducto(ListaProductos.Terminal);
		atributos.setClaseProducto(ClaseProductos.Bien);
		//atributos.setNumAbonado(parametrosRegla.getNumAbonado());
		//atributos.setCodigoArticuloServicio(parametrosRegla.getCodigoArticulo());
		parametrosRegla.setAtributos(atributos);
		logger.debug("Fin:getAtributos()");
		return parametrosRegla;
	}//fin getAtributos

}//fin ReglasTerminal
