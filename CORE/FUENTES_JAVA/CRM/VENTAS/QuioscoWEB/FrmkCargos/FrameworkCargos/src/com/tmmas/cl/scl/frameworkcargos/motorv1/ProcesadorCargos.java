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

package com.tmmas.cl.scl.frameworkcargos.motorv1;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.base.TareasRegistroCargos;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.interfaces.ProcesadorCargosInterfaz;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.RegistroCargosBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.RegistroVentaBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroCargosBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroCargosIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroVentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroVentaBOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.BitacoraDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosEjecucionFacturacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosMotorCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrebillingDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.DatosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroVentaDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.productDomain.interfaz.IdentificadorProceso;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;

public class ProcesadorCargos implements ProcesadorCargosInterfaz{
	private final Logger cat = Logger.getLogger(ProcesadorCargos.class);

	private PrecioDTO[] precioRegla;
	private DescuentoDTO[] descuentoRegla;
	private CargosDTO[] cargosDTO;
	private Map cargos;

	private List cargosLista = new ArrayList();
	private AtributosCargoDTO atributosRegla;
	private ParametrosMotorCargosDTO configuracion;
	private ImpuestosDTO impuestos;
	private boolean preBillingRunning;
	private BitacoraDTO bitacora;


//	TODO : Metodos de Acceso a BD a través de Factory
	private RegistroCargosBOFactoryIT regCargosFactory=new RegistroCargosBOFactory();
	private RegistroCargosIT registroCargosBO=regCargosFactory.getBusinessObject1();

	private RegistroVentaBOFactoryIT regVentaFactory=new RegistroVentaBOFactory(); 
	private RegistroVentaBOIT registroVentaBO=regVentaFactory.getBusinessObject1();

	private RegistroFacturacionBOFactoryIT regFactFactory=new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT registroFacturacionBO=regFactFactory.getBusinessObject1();

	/*private ClienteBOFactoryIT clientFactory=new ClienteBOFactory();
	private ClienteIT clienteBO =clientFactory.getBusinessObject1();

	private ArticuloFCBOFactoryIT articuloFactory= new ArticuloFCBOFactory();
	private ArticuloFCBOIT articuloBO=articuloFactory.getBusinessObject1();
	 */
	private DatosGeneralesBOFactoryIT datosGenerFactory=new DatosGeneralesBOFactory();
	private DatosGeneralesBOIT datosGeneralesBO=datosGenerFactory.getBusinessObject1();

	public ProcesadorCargos (){

	}

	public ProcesadorCargos (ParametrosMotorCargosDTO configuracion,
			CargosDTO[] cargos){
		this.preBillingRunning = false;
		this.configuracion = configuracion; 
		cargosDTO = cargos;
		bitacora=null;
	}
	/**
	 *Calcula los cargos.
	 * @param 
	 * @return 
	 * @throws FrameworkCargosException
	 */

	public void calcularCargos(ReglaListaPrecio[] reglasNegocio) throws FrameworkCargosException, GeneralException {
		cat.debug("Inicio:calcularCargos()");
		int iIndice;
		for(iIndice=0;iIndice<reglasNegocio.length;iIndice++){
			if (reglasNegocio[iIndice].validacion())
			{
				precioRegla = null;
				precioRegla = reglasNegocio[iIndice].seleccionPrecios();
				
				cat.debug("reglasNegocio[iIndice].getClass(): " + reglasNegocio[iIndice].getClass());
				cat.debug("precioRegla.length: " + precioRegla.length);
				if (precioRegla!=null){
					if (precioRegla.length > 0){
						descuentoRegla = reglasNegocio[iIndice].seleccionDescuentos();
						/*if (descuentoRegla != null){
							if (descuentoRegla.length > 0)
								listaDescuentosRegla.addAll(Arrays.asList(descuentoRegla));
						}*/

						atributosRegla = new AtributosMigracionDTO();
						atributosRegla = reglasNegocio[iIndice].getAtributos().getAtributos();

						//agruparCargos();
					}
					//Se agrega cargo a lista de cargos
					for(int i=0;i<precioRegla.length;i++){
						CargosDTO cargo = new CargosDTO();
						cargo.setAtributo(atributosRegla);
						cargo.setPrecio(precioRegla[i]);
						cargo.setCantidad(1);
						if (descuentoRegla != null){
							cargo.setDescuento(descuentoRegla);
						}
						cargosLista.add(cargo);
					}
				}
			}
		}
		cat.debug("Fin:calcularCargos()");
	}

	/**
	 *Obtiene los cargos.
	 * @param 
	 * @return 
	 * @throws FrameworkCargosException
	 */

	public CargosDTO[] obtenerCargos() throws FrameworkCargosException{
		cat.debug("Inicio:obtenerCargos()");
		CargosDTO[] arregloCargos=null;
		if (cargos != null){
			List listaCargos = new ArrayList(cargos.values());
			arregloCargos =(CargosDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaCargos.toArray(), 
					CargosDTO.class);
		}else{
			arregloCargos =(CargosDTO[])ArrayUtl.copiaArregloTipoEspecifico(cargosLista.toArray(), 
					CargosDTO.class);
		}
		cat.debug("Fin:obtenerCargos()");
		return arregloCargos;

	}

	/**
	 *Agrupa los cargos
	 * @param 
	 * @return 
	 * @throws FrameworkCargosException
	 */
	public void agruparCargos() throws FrameworkCargosException{
		cat.debug("Inicio:agruparCargos()");
		ListIterator iter = cargosLista.listIterator();
		cargos = new HashMap();
		while (iter.hasNext()){
			CargosDTO cargo = new CargosDTO();
			CargosDTO cargosDTO = new CargosDTO();
			cargosDTO =(CargosDTO) iter.next();
			String codigoConcepto = String.valueOf(cargosDTO.getPrecio().getCodigoConcepto());
			if (cargos.get(codigoConcepto)!=null){
				cargo=(CargosDTO)cargos.get(codigoConcepto);
				if (cargo.getAtributo().getCodigoArticuloServicio()!=null){
					if (cargo.getAtributo().getCodigoArticuloServicio().equals(cargosDTO.getAtributo().getCodigoArticuloServicio())){
						cargo.setCantidad(cargo.getCantidad()+1);
						cargos.remove(codigoConcepto);
					}
				}
				else{
					if (atributosRegla.getCodigoArticuloServicio()==null){
						cargo.setCantidad(cargo.getCantidad()+1);
						cargos.remove(codigoConcepto);
					}
				}
			}
			else{
				cargo.setCantidad(1);
			}
			cargo.setPrecio(cargosDTO.getPrecio());
			cargo.setAtributo(cargosDTO.getAtributo());
			cargo.setDescuento(cargosDTO.getDescuento());
			cargos.put(String.valueOf(cargo.getPrecio().getCodigoConcepto()),cargo);
		}
		cat.debug("Fin:agruparCargos()");

	}

	/**
	 * @Description Registra los cargos asociados a la venta
	 * @param TareasRegistroCargos[] tareas
	 * @return 
	 * @throws FrameworkCargosException
	 */
	public void registrarCargos(TareasRegistroCargos[] tareas) throws FrameworkCargosException{
		cat.debug("Inicio:registrarCargos()");
		try{
			//RegistroCargos registroCargosBO = new RegistroCargos();
			boolean bExistDctoAut = false;
			float ifValorDescuento = 0;
			//RegistroVenta registroVentaBO = new RegistroVenta();
			//RegistroFacturacion registroFacturacionBO  = new RegistroFacturacion();

			//Cliente clienteBO = new Cliente();
			/*RegistroFacturacionDTO registrofact = new RegistroFacturacionDTO();
			ClienteDTOInt cliente = new ClienteDTOInt();
			cliente.setCodigoCliente(configuracion.getCodigoCliente());
			cliente = clienteBO.obtenerDatosCliente(cliente); 
			registrofact = registroFacturacionBO.getCodigoCicloFacturacion(cliente);*/
			
			
			cat.debug("cargosDTO.length ["+cargosDTO.length+"]");
			for (int i=0;i<cargosDTO.length;i++)
			{
				RegistroCargosDTO registroCargos = new RegistroCargosDTO();
				//Obtiene Secuencia del Cargo
				registroCargos.setCodigoSecuencia(configuracion.getCodigoSecuenciaCargo());
				registroCargos = registroCargosBO.getSecuenciaCargo(registroCargos);

				registroCargos.setCodigoCliente(configuracion.getCodigoCliente());
				//Si factura a ciclo se asigna valor 0 al numero de venta en caso contrario se pasa el numero de
				//la venta.
				if (configuracion.isFacturacionaCiclo())
					registroCargos.setNumeroVenta(0);
				else
					registroCargos.setNumeroVenta(Long.parseLong(configuracion.getNumeroProceso()));
				registroCargos.setCodigoProducto(Integer.parseInt(configuracion.getCodigoProducto()));
				registroCargos.setCodigoConceptoPrecio(cargosDTO[i].getPrecio().getCodigoConcepto());
				registroCargos.setImporteCargo(cargosDTO[i].getPrecio().getMonto());
				registroCargos.setCodigoMoneda(cargosDTO[i].getPrecio().getUnidad().getCodigo());
				registroCargos.setCodigoPlanComercial(configuracion.getCodigoPlanComercialCliente());
				registroCargos.setNumeroUnidades(cargosDTO[i].getCantidad());
				registroCargos.setCodigoCicloFacturacion(configuracion.getCodigoFacturacion());
				/**
				 * @author rlozano
				 * @date 28-04-2009
				 * @description se comenta codigo porque este no llama al package de facturacion fa_cargos_PG
				 */
				//registroCargos.setCodigoCicloFacturacion(configuracion.isFacturacionaCiclo()?String.valueOf(registrofact.getCodigoCicloFacturacion()):null);
				registroCargos.setNumeroTransaccion(Long.parseLong(configuracion.getNumeroTransaccion()));
				registroCargos.setTipoFoliacion(configuracion.getTipoFoliacionDocumento());
				registroCargos.setCodigoDocumento(configuracion.getCodigoTipoDocumento());
				//El descuento se guarda como tipo importe y el código concepto facturable
				//es del descuento automatico, si no existe descuento automatico se toma el código del descuento
				//manual.
				/*registroCargos.setTipoDescuento(String.valueOf(TipoDescuentos.Importe));
				if (cargosDTO[i].getDescuento()!=null)
					if (cargosDTO[i].getDescuento().length>0){
						for (int k=0; k<cargosDTO[i].getDescuento().length;k++){
							if (cargosDTO[i].getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Automatico)) 
								&& cargosDTO[i].getDescuento()[k].getMonto() > 0){
								registroCargos.setCodigoConceptoDescuento(cargosDTO[i].getDescuento()[k].getCodigoConcepto());
								bExistDctoAut = true;

							}
							else if(cargosDTO[i].getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Manual)) 
									&& !bExistDctoAut){
								registroCargos.setCodigoConceptoDescuento(cargosDTO[i].getDescuento()[k].getCodigoConcepto());
							}

							if(cargosDTO[i].getDescuento()[k].getTipoAplicacion().equals(String.valueOf(TipoDescuentos.Porcentaje)) 
								&& cargosDTO[i].getDescuento()[k].getMonto() > 0){
								ifValorDescuento =((registroCargos.getImporteCargo() * cargosDTO[i].getDescuento()[k].getMonto()) /100) + registroCargos.getValorDescuento();
								cat.debug("valor descuento sin redondeo: " + ifValorDescuento);
								Double  dValorDescAux = new Double(Math.round(ifValorDescuento*Math.pow(10,configuracion.getNumeroDecimalesPorDesc()))/Math.pow(10,configuracion.getNumeroDecimalesPorDesc()));
								ifValorDescuento =  dValorDescAux.floatValue();
								cat.debug("valor descuento con redondeo: " + ifValorDescuento);

								registroCargos.setValorDescuento(ifValorDescuento * cargosDTO[i].getCantidad());
							}	
							else
							registroCargos.setValorDescuento(registroCargos.getValorDescuento() + cargosDTO[i].getDescuento()[k].getMonto());
						}
					}*/

				//El descuento se guarda como tipo importe y el código concepto facturable
				//es del descuento automatico, si no existe descuento automatico se toma el código del descuento
				//manual.
				registroCargos.setTipoDescuento(String.valueOf(TipoDescuentos.Importe));
				float ifValorDescPorManual = 0;
				if (cargosDTO[i].getDescuento()!=null)
					if (cargosDTO[i].getDescuento().length>0){
						
						for (int k=0; k<cargosDTO[i].getDescuento().length;k++){

							if (cargosDTO[i].getDescuento()[k] != null){


								if (cargosDTO[i].getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Automatico)) 
										&& cargosDTO[i].getDescuento()[k].getMonto() > 0){
									registroCargos.setCodigoConceptoDescuento(cargosDTO[i].getDescuento()[k].getCodigoConcepto());
									bExistDctoAut = true;

								}
								else if(cargosDTO[i].getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Manual)) 
										&& !bExistDctoAut){
									registroCargos.setCodigoConceptoDescuento(cargosDTO[i].getDescuento()[k].getCodigoConcepto());
								}

								if(cargosDTO[i].getDescuento()[k].getTipoAplicacion().equals(String.valueOf(TipoDescuentos.Porcentaje)) 
										&& cargosDTO[i].getDescuento()[k].getMonto() > 0
										&& cargosDTO[i].getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Automatico))){
									ifValorDescuento =(registroCargos.getImporteCargo() * cargosDTO[i].getDescuento()[k].getMonto()) /100;
									Double  dValorDescAux = new Double(Math.round(ifValorDescuento*Math.pow(10,configuracion.getNumeroDecimalesPorDesc()))/Math.pow(10,configuracion.getNumeroDecimalesPorDesc()));
									ifValorDescuento =  dValorDescAux.floatValue();
									registroCargos.setValorDescuento((ifValorDescuento * cargosDTO[i].getCantidad()) + registroCargos.getValorDescuento());
								}else if(cargosDTO[i].getDescuento()[k].getTipoAplicacion().equals(String.valueOf(TipoDescuentos.Porcentaje)) 
										&& cargosDTO[i].getDescuento()[k].getMonto() > 0
										&& cargosDTO[i].getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Manual))){
									ifValorDescPorManual = cargosDTO[i].getDescuento()[k].getMonto();
								}else  if (!cargosDTO[i].getDescuento()[k].getTipoAplicacion().equals(String.valueOf(TipoDescuentos.Porcentaje))
										&& cargosDTO[i].getDescuento()[k].getMonto() > 0){
									registroCargos.setValorDescuento(registroCargos.getValorDescuento() + cargosDTO[i].getDescuento()[k].getMonto());
								}
								
								registroCargos.setCodigoConceptoDescuento(cargosDTO[i].getDescuento()[k].getCodigoConcepto());
							}					
						}
					}
				if (ifValorDescPorManual >0){
					ifValorDescuento =(((registroCargos.getImporteCargo() * registroCargos.getNumeroUnidades()) - registroCargos.getValorDescuento()) * ifValorDescPorManual) /100;
					Double  dValorDescAux = new Double(Math.round(ifValorDescuento*Math.pow(10,configuracion.getNumeroDecimalesPorDesc()))/Math.pow(10,configuracion.getNumeroDecimalesPorDesc()));
					ifValorDescuento =  dValorDescAux.floatValue();
					registroCargos.setValorDescuento(registroCargos.getValorDescuento() + ifValorDescuento);
				}


				AtributosMigracionDTO atributo = (AtributosMigracionDTO)cargosDTO[i].getAtributo();
				if (Integer.parseInt(atributo.getInd_paquete()) != 0 || Integer.parseInt(atributo.getInd_equipo()) != 0)
					registroCargos.setIndiceCuota(atributo.getInd_cuota());

				if (Integer.parseInt(atributo.getInd_paquete()) != 2)
					registroCargos.setIndiceFacturacion(1);
				else
					registroCargos.setIndiceFacturacion(0);
				if (Integer.parseInt(atributo.getInd_paquete()) == 1 || Integer.parseInt(atributo.getInd_paquete()) == 2){
					RegistroVentaDTO registroVenta = new RegistroVentaDTO();
					registroVenta.setCodigoSecuencia(configuracion.getCodigoSecuenciaPaquete());
					registroVenta = registroVentaBO.getSecuenciaPaquete(registroVenta);
					registroCargos.setNumeroPaquete(registroVenta.getNumeroPaquete());
				}


				registroCargos.setIndiceSuperTelefono(0);
				registroCargos.setNumeroTerminal(atributo.getNumTerminal());

				String nomUsuario=atributo.getNombreUsuario();
				nomUsuario=nomUsuario==null?"":nomUsuario.trim();
				nomUsuario=!"".equals(nomUsuario)?nomUsuario:configuracion.getUsuario();
				registroCargos.setNombreUsuario(nomUsuario);
				registroCargos.setCodigoTecnologia(cargosDTO[i].getAtributo().getCodTecnologia());
				registroCargos.setNumAbonado(cargosDTO[i].getAtributo().getNumAbonado());
				registroCargos.setNumeroImei(cargosDTO[i].getAtributo().getNumImei());
				registroCargos.setNumeroContrato(cargosDTO[i].getAtributo().getNumContrato());
				registroCargos.setNumeroSerie(cargosDTO[i].getAtributo().getNumSerie());
                cat.debug(" Antes de llaamr a registraCargo ---------------------------------");
				registroCargosBO.registraCargo(registroCargos);
			}


			//Ejecuta las tareas

			if (tareas!=null){
				int iNumeroTareas = tareas.length;
				for (int i =0;i<iNumeroTareas;i++){
					if(tareas[i].validaciones()){
						if (tareas[i].esPrebilling()){
							cat.debug("Antes de Ejecutar Tarea De Prebilling ---------------------------------  ["+tareas[i].getClass()+"]");
							ejecutaPrebilling(tareas[i]);
						}else
							
							tareas[i].tarea();
					}
				}
			}

		}catch(GeneralException ex){
			throw new FrameworkCargosException(ex);
		}
		cat.debug("Fin:registrarCargos()");
	}

	public void ejecutarFacturacion(ParametrosEjecucionFacturacionDTO parametrosEjecucion) throws FrameworkCargosException{
		// TODO Auto-generated method stub
		try{
			//RegistroFacturacion registroFacturacionBO  = new RegistroFacturacion();
			RegistroFacturacionDTO regFac = new RegistroFacturacionDTO();
			regFac.setNumeroProcesoFacturacion(parametrosEjecucion.getNumeroProcesoFacturacion());
			regFac.setNumeroVenta(parametrosEjecucion.getNumeroVenta());
			regFac.setEstadoDocumento(parametrosEjecucion.getEstadoDocumento());
			regFac.setEstadoProceso(parametrosEjecucion.getEstadoProceso());
			regFac.setTipoFoliacion(parametrosEjecucion.getTipoFoliacion());
			ProcesoDTO proceso = registroFacturacionBO.actualizaFacturacion(regFac);
			if (proceso !=null)
				componerBitacora(proceso);


		}catch(ProductException ex){
			throw new FrameworkCargosException(ex);
		}

	}

	public void cancelarFacturacion() throws FrameworkCargosException{
		// TODO Auto-generated method stub

	}
	private void ejecutaPrebilling(TareasRegistroCargos tarea) throws FrameworkCargosException, ProductException{
		cat.debug("Inicio:ejecutaPrebilling()");
		String sValorDocumentoGuia;
		String sValorFacturaGlobal;
		String sValorFlagCentroFact;
		//RegistroFacturacion registroFacturacionBO  = new RegistroFacturacion();


		PrebillingDTO prebillingDTO = new PrebillingDTO();
		RegistroFacturacionDTO registroFacturacion = new RegistroFacturacionDTO();
		//DatosGenerales datosGeneralesBO = new DatosGenerales();

		try{
			//Obtiene Secuencia Proceso Facturación
			registroFacturacion.setCodigoSecuencia(configuracion.getNombreSecuenciaProcesoFacturacion());
			registroFacturacion = registroFacturacionBO.getSecuenciaProcesoFacturacion(registroFacturacion);
			impuestos =new ImpuestosDTO();
			impuestos.setNumeroProceso(registroFacturacion.getNumeroProcesoFacturacion());

			//Obtiene Parametros Factura Global
			DatosGeneralesDTO datosGral = new DatosGeneralesDTO();
			datosGral.setCodigoParametro(configuracion.getNombreParametroFacturaGlobal());
			datosGral.setCodigoProducto(configuracion.getCodigoProducto());
			datosGral.setCodigoModulo(configuracion.getModuloParametroFacturaGlobal());
			datosGral = datosGeneralesBO.getValorParametro(datosGral);

			sValorFacturaGlobal = datosGral.getValorParametro();

			//Obtiene Parametros Documento Guia
			datosGral = new DatosGeneralesDTO();
			datosGral.setCodigoParametro(configuracion.getNombreParametroDocumentoGuia());
			datosGral.setCodigoProducto(configuracion.getCodigoProducto());
			datosGral.setCodigoModulo(configuracion.getModuloParametroDocumentoGuia());
			datosGral = datosGeneralesBO.getValorParametro(datosGral);

			sValorDocumentoGuia = datosGral.getValorParametro();

			//Obtiene Parametros Flag Centro Facturación
			datosGral = new DatosGeneralesDTO();
			datosGral.setCodigoParametro(configuracion.getParametroFlagCentroFac());
			datosGral.setCodigoProducto(configuracion.getCodigoProducto());
			datosGral.setCodigoModulo(configuracion.getModuloParametroFlagCentroFac());
			datosGral = datosGeneralesBO.getValorParametro(datosGral);

			sValorFlagCentroFact = datosGral.getValorParametro(); 


			registroFacturacion.setCodigoOficina(configuracion.getCodigoOficina());
			registroFacturacion.setCodigoTipoDocumento(configuracion.getCodigoTipoDocumento());
			registroFacturacion.setValorParametroFacturaGlobal(sValorFacturaGlobal);
			registroFacturacion.setValorParametroDocumentoGuia(sValorDocumentoGuia);
			registroFacturacion.setCodigoTipoFoliacion(configuracion.getTipoFoliacionDocumento());
			registroFacturacion.setCodigoTipoMovimiento(configuracion.getCodigoTipoMovimiento());
			registroFacturacion.setCategoriaTributaria(configuracion.getCategoriaTributaria());
			registroFacturacion.setValorParametroFlagCentroFact(sValorFlagCentroFact);
			registroFacturacion.setModalidadVenta(configuracion.getModalidadVenta());
			registroFacturacion = registroFacturacionBO.getModoGeneracion(registroFacturacion);

			tarea.tarea(prebillingDTO);
			registroFacturacion.setSecuenciaTransacabo(prebillingDTO.getSecuenciaTransacabo());
			registroFacturacion.setActuacionPrebilling(prebillingDTO.getActuacionPrebilling());
			registroFacturacion.setProductoGeneral(prebillingDTO.getProductoGeneral());
			registroFacturacion.setCodigoCliente(prebillingDTO.getCodigoCliente());
			registroFacturacion.setNumeroVenta(prebillingDTO.getNumeroVenta());
			registroFacturacion.setNumeroTransaccionVenta(prebillingDTO.getNumeroTransaccionVenta());
			// TODO : Fecha 


			registroFacturacionBO.ejecutaPrebilling(registroFacturacion);

			datosGral = new DatosGeneralesDTO();
			datosGral.setNumTransaccion(prebillingDTO.getSecuenciaTransacabo());
			datosGral = datosGeneralesBO.getResultadoTransaccion(datosGral);

			if (datosGral.getCodError()!=0){
				//if (true){
				cat.debug("No se ejecuto correctamente el Prebilling");
				ProcesoDTO proceso = new ProcesoDTO();
				proceso.setIdentificadorProceso(IdentificadorProceso.EjecutaPrebilling);
				proceso.setEstadoEjecucion(false);
				proceso.setCodigoError(datosGral.getCodError());
				componerBitacora(proceso);
				throw new FrameworkCargosException("Error al Registrar Cargos o Prebilling");
			}
		}
		catch(GeneralException e){
			throw new FrameworkCargosException(e);
		}

		this.preBillingRunning = true;
		cat.debug("Fin:ejecutaPrebilling()");

	}

	public ImpuestosDTO obtenerImpuestos() throws FrameworkCargosException {
		cat.debug("Inicio:obtenerImpuestos()");
		if (preBillingRunning == true){
			try{
				//RegistroFacturacion registroFacturacionBO  = new RegistroFacturacion();
				impuestos = registroFacturacionBO.getDatosPresupuesto(impuestos);
			}
			catch(ProductException ex){
				throw new FrameworkCargosException(ex);
			}
		}
		cat.debug("Fin:obtenerImpuestos()");
		return impuestos;

	}

	public void reconfigurarProcesosFacturacion() throws FrameworkCargosException {
		// TODO Auto-generated method stub
		cat.debug("Inicio:reconfigurarProcesosFacturacion()");
		try {
			Date fecha = new Date();	
			//Obtiene Parametros Dias Vencimiento Factura
			//DatosGenerales datosGeneralesBO = new DatosGenerales();
			DatosGeneralesDTO datosGral = new DatosGeneralesDTO();
			datosGral.setCodigoParametro(configuracion.getModuloParametroDiaVctoFact());
			datosGral.setCodigoProducto(configuracion.getCodigoProducto());
			datosGral.setCodigoModulo(configuracion.getParametroDiaVctoFact());
			datosGral = datosGeneralesBO.getValorParametro(datosGral);



			//RegistroFacturacion registroFacturacionBO  = new RegistroFacturacion();
			RegistroFacturacionDTO regFac = new RegistroFacturacionDTO();
			regFac.setNumeroVenta(configuracion.getNumeroProceso());


			Calendar cal = new GregorianCalendar(); 
			cal.setTimeInMillis(fecha.getTime()); 
			cal.add(Calendar.DATE,Integer.parseInt(datosGral.getValorParametro())); 
			Date fechaVencimiento = new Date(cal.getTimeInMillis()); 


			regFac.setFechaVencimiento(Formatting.dateTime(fechaVencimiento,"dd/MM/yyyy HH:mm:ss"));
			regFac.setCategoriaTributaria(configuracion.getCategoriaTributaria());
			ProcesoDTO proceso = registroFacturacionBO.actualizaFacturacion(regFac);
			if (proceso !=null){
				proceso.setIdentificadorProceso(IdentificadorProceso.ReconfigurarProcesosFacturacion);
				componerBitacora(proceso);
			}

		}catch(ProductException e){
			throw new FrameworkCargosException(e);
		}
		cat.debug("Fin:reconfigurarProcesosFacturacion()");

	}

	public BitacoraDTO obtenerBitacora() throws CustomerException {
		// TODO Auto-generated method stub
		return bitacora;
	}
	private void componerBitacora(ProcesoDTO proceso) throws FrameworkCargosException{
		cat.debug("Inicio:componerBitacora()");
		List listadoProcesos = new ArrayList();
		listadoProcesos.add(proceso);
		if (bitacora!=null){
			if (bitacora.getProcesos()!=null)
				if(bitacora.getProcesos().length >0)
					listadoProcesos.addAll(Arrays.asList(bitacora.getProcesos()));

		}
		else
			bitacora = new BitacoraDTO();
		ProcesoDTO[] arregloProcesos =(ProcesoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listadoProcesos.toArray(), 
				ProcesoDTO.class);
		bitacora.setProcesos(arregloProcesos);
		cat.debug("Fin:componerBitacora()");
	}


}
