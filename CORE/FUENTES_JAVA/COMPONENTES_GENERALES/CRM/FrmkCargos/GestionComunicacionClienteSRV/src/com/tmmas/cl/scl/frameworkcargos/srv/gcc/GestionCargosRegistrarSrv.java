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
 * 10/01/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.frameworkcargos.srv.gcc;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.frameworkcargos.base.TareasRegistroCargos;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.motorv1.ProcesadorCargos;
import com.tmmas.cl.scl.frameworkcargos.srv.gcc.helper.Global;
import com.tmmas.cl.scl.frameworkcargos.srv.gcc.interfaces.GestionCargosRegistrarSrvIF;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.PreBillingVE;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.RegistroEvaluacionRiesgoBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.RegistroVentaBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.VendedorBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroEvaluacionRiesgoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroEvaluacionRiesgoBOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroVentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroVentaBOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.VendedorBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.VendedorIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.BitacoraDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConfiguradorTareaPrebillingDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConfiguradorTareaPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConfiguradorTareasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosEjecucionFacturacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosMotorCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosRegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroCargosBatchDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroEvaluacionRiesgoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoRegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ParametrosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargoFrameworkCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.productDomain.interfaz.IdentificadorProceso;
import com.tmmas.scl.framework.productDomain.interfaz.TipoDescuentos;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;

public class GestionCargosRegistrarSrv implements  GestionCargosRegistrarSrvIF{
	
	private final Logger cat = Logger.getLogger(GestionCargosRegistrarSrv.class);
	private ClienteBOFactoryIT clienteFactory=new ClienteBOFactory();
	private AbonadoBOFactoryIT abonadoFactory = new AbonadoBOFactory();
	private ClienteIT clienteBO=clienteFactory.getBusinessObject1();
	private AbonadoIT abonadoBO=abonadoFactory.getBusinessObject1();
	
	private VendedorBOFactoryIT vendedorFactory=new VendedorBOFactory();
	private VendedorIT vendedorBO =vendedorFactory.getBusinessObject1();
	private RegistroFacturacionBOFactoryIT regFacturacionFactory = new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT regFacturacion = regFacturacionFactory.getBusinessObject1();
	
	private ParametrosGeneralesBOFactoryIT paramGeneFactory=new ParametrosGeneralesBOFactory();
	private ParametrosGeneralesIT parametrosGeneralesBO=paramGeneFactory.getBusinessObject1();
	
	private RegistroVentaBOFactoryIT registroVentasFactory=new RegistroVentaBOFactory();
	private RegistroVentaBOIT registroVentaBO=registroVentasFactory.getBusinessObject1();
	
	private RegistroEvaluacionRiesgoBOFactoryIT regEvalRiesgoFactory = new RegistroEvaluacionRiesgoBOFactory();
	private RegistroEvaluacionRiesgoBOIT  registroEvaluacionRiesgoBO=regEvalRiesgoFactory.getBusinessObject1();
	
	
	Global global = Global.getInstance();

	
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO resultadoObtenerCargos) throws FrmkCargosException {
		cat.debug("construirRegistroCargos():start::GestionCargosRegistrarSRV");
		RegCargosDTO listadoCargos = new RegCargosDTO();
		CargoFrameworkCargosDTO[] arregloCargos =null;
		List listaCargos = new ArrayList();
		try{
			CargosDTO[] cargos =resultadoObtenerCargos!=null&&resultadoObtenerCargos.getCargos()!=null?resultadoObtenerCargos.getCargos():null;	
			if (cargos !=null){
				cat.debug("construirRegistroCargos():resultadoObtenerCargos.getCargos()!=null");
				cat.debug("construirRegistroCargos():cargos.length ["+cargos.length+"]");
				if (cargos.length>0){
					for (int i=0;i<cargos.length;i++){
						CargoFrameworkCargosDTO cargo = new CargoFrameworkCargosDTO();
						cargo.setCodigoArticuloServicio(cargos[i].getAtributo().getCodigoArticuloServicio());
						cargo.setTipoProducto(cargos[i].getAtributo().getTipoProducto());
						cargo.setCantidad(cargos[i].getCantidad());
						PrecioDTO precio = cargos[i].getPrecio();
						cargo.setCodigoConceptoPrecio(precio.getCodigoConcepto());
						cargo.setDescripcionConceptoPrecio(precio.getDescripcionConcepto());
						cargo.setMontoConceptoPrecio(precio.getMonto());
						cargo.setCodigoMoneda(precio.getUnidad().getCodigo());
						cargo.setDescripcionMoneda(precio.getUnidad().getDescripcion());
						cargo.setInd_equipo(precio.getDatosAnexos().getInd_equipo());
						cargo.setInd_paquete(precio.getDatosAnexos().getInd_paquete());
						//cargo.setNumAbonado(precio.getDatosAnexos().getNumAbonado());
						cargo.setNumAbonado(cargos[i].getAtributo().getNumAbonado());
						
						
						DescuentoDTO[] arregloDescuento = cargos[i].getDescuento();
						
						
						if (arregloDescuento!=null){
							String tipoDescuento=null;
							for (int k=0;k<arregloDescuento.length;k++){
								tipoDescuento=arregloDescuento[k].getTipo();
								
								
								cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());
								cargo.setDescripcionDescuento(arregloDescuento[k].getDescripcionConcepto());
								if (Integer.parseInt(tipoDescuento)==(TipoDescuentos.Manual)){
									cargo.setMontoDescuentoManual(arregloDescuento[k].getMonto());
									cargo.setTipoDescuentoManual(arregloDescuento[k].getTipoAplicacion());
								}
								if (Integer.parseInt(tipoDescuento)==(TipoDescuentos.Automatico)){
									cargo.setMontoDescuento(arregloDescuento[k].getMonto());
									cargo.setTipoDescuento(arregloDescuento[k].getTipoAplicacion());
								}
							}
						}
						
						
						
						/*if (arregloDescuento!=null)
							if (arregloDescuento.length>0){
								/*Recorre los descuentos. Si existe descuento automatico se asigna este como descuento del cargo, 
								en caso contrario toma el código del descuento manual. Si existen los dos tipos de descuentos toma
								el codigo concepto del descuento automatico
								for (int k=0;k<arregloDescuento.length;k++){
									/*if (arregloDescuento[k].getTipo()==null){
										if (arregloDescuento[k].getCodigoConcepto()!=null && cargo.getCodigoDescuento()==null){
											cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());
										}
									}
										cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());
										
										cargo.setDescripcionDescuento(arregloDescuento[k].getDescripcionConcepto());
										cargo.setTipoDescuentoManual(arregloDescuento[k].getTipoAplicacion());
										cargo.setTipoDescuento(arregloDescuento[k].getTipo());
										
										if (cargo.getTipoDescuento().equals(String.valueOf(TipoDescuentos.Manual))){
											cargo.setMontoDescuentoManual(arregloDescuento[k].getMonto());
										}else{
											cargo.setMontoDescuento(arregloDescuento[k].getMonto());
										}
									}
									
								
							}
							else{
								cargo.setCodigoDescuento("");
								cargo.setMontoDescuento(0);
							}*/
						else{
							cargo.setMontoDescuento(0);
						}
						//cargo.setDescuentoManual(1);
						listaCargos.add(cargo);
						
					}
				}
			}
			else
			{
				cat.debug("construirRegistroCargos():resultadoObtenerCargos.getCargos()====>null");
			}
		}
		catch(Exception e){
			throw new FrmkCargosException(e);
		}
		arregloCargos =(CargoFrameworkCargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaCargos.toArray(), CargoFrameworkCargosDTO.class);
		//resultado.setAplicaDescuentoVendedor(objetoCargos.isAplicaDescuentoVendedor());
		
		if (listadoCargos.isAplicaDescuentoVendedor()){
			/*resultado.setPorcentajeDesctoInferior(objetoCargos.getPorcentajeDesctoInferior());
			resultado.setPorcentajeDesctoSuperior(objetoCargos.getPorcentajeDesctoSuperior());
			resultado.setPuntoDesctoInferior(objetoCargos.getPorcentajeDesctoInferior());
			resultado.setPuntoDesctoSuperior(objetoCargos.getPuntoDesctoSuperior());*/
		}
		listadoCargos.setCargos(arregloCargos);
		
		//---------------------------------------------------------------------------------------------------------------
		
		
		//TODO: Registrar Cargos
		
		
		//ResultadoRegCargosDTO resultadoRegistrarCargos=new ResultadoRegCargosDTO();
		//RegCargosDTO param =new RegCargosDTO ();
		
		//Se procede a llenar la dto con los cargos Obtenidos
		/*try {
			param.setCargos(resultado.getCargos());
			resultadoRegistrarCargos=setRegistrarCargos(param, env);
		} catch (FrameworkCargosException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		cat.debug("construirRegistroCargos():fin::GestionCargosRegistrarSRV");
		return listadoCargos;
	}
	
	
	
	
	
	//TODO: Metodo Orquestador
	
	/**
	 * Crea la Venta, registra los cargos, ejecuta prebilling y preliquidación y obtiene impuestos 
	 * de los cargos asociados a la venta.
	 * Es necesario crear la venta antes de ejecutar el Prebilling, lo cual es un mal diseño, esta 
	 * mal implementado y debiera realizarse este insert en el cierre de la venta. Fernando Garcia.
	 * @param cabecera
	 * @return parametros
	 * @throws 
	 */
	
	public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO listadoCargos) throws FrmkCargosException{
		cat.debug("registrarCargos():start");
		//VentasFacade ventasFacade = getVentasFacade();
		ResultadoRegCargosDTO resultado = new ResultadoRegCargosDTO();
		List listaCargos = new ArrayList();
        try{
	        //Registra Cargos
        	String tipPlantarif=listadoCargos.getObjetoSesion().getTipoPlanTarifario();
			tipPlantarif=tipPlantarif==null?"":tipPlantarif;
			if (tipPlantarif.equals(global.getValor("parametro.tipo.plan.tarifario.empresa"))){
			}
        	
	        ParametrosRegistroCargosDTO parametrosCargos = new ParametrosRegistroCargosDTO();
	        int iNumeroCargos =listadoCargos.getCargos().length; 
	       
	        if (listadoCargos.getObjetoSesion().isFacturaCiclo()){
	        	parametrosCargos.setNumeroVenta(global.getValor("parametro.numero.venta"));
	        	parametrosCargos.setNumeroTransaccion(global.getValor("parametro.numero.transaccion"));
	        }
	        else{
	        	parametrosCargos.setNumeroVenta(String.valueOf(listadoCargos.getObjetoSesion().getNumeroVenta()));
	        	parametrosCargos.setNumeroTransaccion(String.valueOf(listadoCargos.getObjetoSesion().getNumeroTransaccionVenta()));
	        }
	        parametrosCargos.setFacturacionaCiclo(listadoCargos.getObjetoSesion().isFacturaCiclo());
	        parametrosCargos.setCodigoCliente(listadoCargos.getObjetoSesion().getCodigoCliente());
	        parametrosCargos.setCodigoPlanComercial(listadoCargos.getObjetoSesion().getPlanComercialCliente());
	        parametrosCargos.setCodigoVendedor(listadoCargos.getObjetoSesion().getCodigoVendedor());
	        ClienteDTO cliente =new ClienteDTO();
	        cliente.setCodCliente(Long.parseLong(listadoCargos.getObjetoSesion().getCodigoCliente()));
	        cliente=clienteBO.obtenerCategoriaTributaria(cliente);
	        parametrosCargos.setCategoriaTributaria(cliente.getCodCategoria());
	        
	        //TODO : Parametros a Llenar via web para la ejecucion de Prebilling
	        parametrosCargos.setCodigoOficina(listadoCargos.getObjetoSesion().getOficinaVendedor());
	        parametrosCargos.setCodigoDocumento(listadoCargos.getObjetoSesion().getCodigoDocumento());
	        //parametrosCargos.setTipoFoliacion(listadoCargos.getObjetoSesion().getTipoFoliacion());
	        //Por le momento se obtienen de un Properties
	        parametrosCargos.setTipoFoliacion(global.getValor("tipo.foliacion.documento"));
	        
	        parametrosCargos.setModalidadVenta(listadoCargos.getObjetoSesion().getCodModalidadVenta());
	        
	        /*parametrosCargos.setCodigoVendedorRaiz(listadoCargos.getObjetoSesion().getCodigoVendedorRaiz());
	        parametrosCargos.setDatosPrograma(datosPrograma);*/
	        
	        for (int i=0;i<iNumeroCargos;i++){
	        	CargosDTO cargo = new CargosDTO();
	        	
	        	PrecioDTO precio = new PrecioDTO();
	        	precio.setCodigoConcepto(listadoCargos.getCargos()[i].getCodigoConceptoPrecio());
	        	precio.setMonto(listadoCargos.getCargos()[i].getMontoConceptoPrecio()/listadoCargos.getCargos()[i].getCantidad());
	        	MonedaDTO moneda = new MonedaDTO();
	        	moneda.setCodigo(listadoCargos.getCargos()[i].getCodigoMoneda());
	        	precio.setUnidad(moneda);
	        	
	        	DescuentoDTO[] arregloDescuento = null;
	        	List arrDescuentos=new ArrayList();
	        	DescuentoDTO descuento = null;
	        	
	        	//Valor Por parametro
	        	String tipoAplicacionManual=listadoCargos.getCargos()[i].getTipoDescuentoManual();
	        	tipoAplicacionManual=tipoAplicacionManual==null?"":tipoAplicacionManual;
	        	String tipoAplicacionAut=listadoCargos.getCargos()[i].getTipoDescuento();
	        	tipoAplicacionAut=tipoAplicacionAut==null?"":tipoAplicacionAut;
	        	float montoDescAut=listadoCargos.getCargos()[i].getMontoDescuento();
	        	float montoDesMan=listadoCargos.getCargos()[i].getMontoDescuentoManual();
	        	
	        	String estipodescManual=String.valueOf(listadoCargos.getCargos()[i].getDescuentoManual());
	        	//tipodesc=tipodesc==null?"":tipodesc.trim();
	        	estipodescManual=estipodescManual==null?"":estipodescManual.trim();
	        	//if (estipodescManual.equals(String.valueOf(TipoDescuentos.Manual))){
	        	if (montoDesMan>0){
	        		descuento = new DescuentoDTO();
	        		descuento.setTipo(String.valueOf(TipoDescuentos.Manual)); // Manual
	        	    descuento.setTipoAplicacion(tipoAplicacionManual);//0-Monto 1-Porcentaje
		        	descuento.setMonto(listadoCargos.getCargos()[i].getMontoDescuentoManual()/listadoCargos.getCargos()[i].getCantidad());
		        	descuento.setCodigoConcepto(listadoCargos.getCargos()[i].getCodigoDescuento());
		        	arrDescuentos.add(descuento);
		        	//arregloDescuento[k] = descuento;
		        	//i++;
	        	}
	        	
	        	//if (montoDescAut>0&&!tipoAplicacionAut.equals("")){
	        	if (montoDescAut>0){
	        		descuento = new DescuentoDTO();
		        	descuento.setCodigoConcepto(listadoCargos.getCargos()[i].getCodigoDescuento());
		        	descuento.setTipo(String.valueOf(TipoDescuentos.Automatico)); // Automatico
		        	descuento.setTipoAplicacion(tipoAplicacionAut);//0-Monto 1-Porcentaje
		        	descuento.setMonto(listadoCargos.getCargos()[i].getMontoDescuento()/listadoCargos.getCargos()[i].getCantidad());
		        	arrDescuentos.add(descuento);
		        	//arregloDescuento[k] = descuento;
	        	}
	        	
	        	AtributosMigracionDTO atributo = new AtributosMigracionDTO();
	        	//atributo.setCuotas(Integer.parseInt(listadoCargos.getObjetoSesion().getParametros().getNumeroCuotas().getCodigo()));
	        	String indEquipo=listadoCargos.getCargos()[i].getInd_equipo()==null?"0":listadoCargos.getCargos()[i].getInd_equipo();
	        	atributo.setInd_equipo(indEquipo);
	        	String indPaquete=listadoCargos.getCargos()[i].getInd_paquete()==null?"0":listadoCargos.getCargos()[i].getInd_paquete();
	        	atributo.setInd_paquete(indPaquete);
	        	atributo.setTipoProducto(listadoCargos.getCargos()[i].getTipoProducto());
	        	atributo.setCodigoArticuloServicio(listadoCargos.getCargos()[i].getCodigoArticuloServicio());
	        	atributo.setNumAbonado(listadoCargos.getCargos()[i].getNumAbonado());
	        	

	        	
	        	/**
                        * @author rlozano
                        * @description se realiza consulta para la obtencion del numero celular a traves del numero de abonado
                        * @description 23-04-2008 se agrega if para soporte de validacion abonado cero se insertara null num terminal
                        * @param abonadoDTO
                        * @return abonadoDTO
                        */
                        AbonadoDTO abonadoDTO=new AbonadoDTO();
                        String numAbonado=listadoCargos.getCargos()[i].getNumAbonado();
                        numAbonado=numAbonado==null||numAbonado.equals("")?"0":numAbonado;
                        //atributo.setNumeroCelular(null);
                        if(!"0".equals(numAbonado)) {
	                        abonadoDTO.setNumAbonado(Long.parseLong(numAbonado));
	                        abonadoDTO=abonadoBO.obtenerDatosAbonado(abonadoDTO);
	                        atributo.setNumeroCelular(String.valueOf(abonadoDTO.getNumCelular()));
                        }
                        
                 atributo.setNombreUsuario(listadoCargos.getObjetoSesion().getNombreUsuario());       

	        	//atributo.set
	        	cargo.setPrecio(precio);
	        	boolean arrDes=descuento==null?false:true; 
	        	if (arrDes){
	        		arregloDescuento=(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrDescuentos.toArray(), DescuentoDTO.class);
	        		cargo.setDescuento(arregloDescuento);
	        	}
	        	
	        	cargo.setAtributo(atributo);
	        	cargo.setCantidad(listadoCargos.getCargos()[i].getCantidad());
	        	
	        	
	        	listaCargos.add(cargo);
	        }
	        
	        CargosDTO[] arregloCargos =(CargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					listaCargos.toArray(), CargosDTO.class);
	       
	        parametrosCargos.setCargos(arregloCargos);
	        ResultadoRegistroCargosDTO retValue =new ResultadoRegistroCargosDTO();
	        retValue=setRegistrarCargos(parametrosCargos);
       
       /* FormasPagoDTO[] formasPago = ventasFacade.obtenerFormasPago(parametrosCargos);
        
        if (formasPago!=null){
        	List listaFormaPago = new ArrayList();
        	int largoFormadePago = formasPago.length; 
        	for (int i =1 ; i<largoFormadePago;i++){
        		FormadePagoDTO formadePago = new FormadePagoDTO();
        		formadePago.setDescripcionTipoValor(formasPago[i].getDescripcionTipoValor());
        		formadePago.setTipoValor(formasPago[i].getTipoValor());
        		listaFormaPago.add(formadePago);
        	}
        	FormadePagoDTO[] arrayFormaPago =(FormadePagoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
        			listaFormaPago.toArray(), FormadePagoDTO.class);
        	resultado.setArregloFormasdePago(arrayFormaPago);
        }*/
        
        
        
       if (retValue.getImpuestos()!=null){
        	resultado.setNumeroProceso(retValue.getImpuestos().getNumeroProceso());
        	resultado.setTotalCargos(retValue.getImpuestos().getTotalCargos());
        	resultado.setTotalDescuentos(retValue.getImpuestos().getTotalDescuentos());
        	resultado.setTotalImpuestos(retValue.getImpuestos().getTotalImpuestos());
        }
        else{
        	if (!listadoCargos.getObjetoSesion().isFacturaCiclo()){
            	throw new FrmkCargosException("No se pudo rescatar los impuestos");
        	}
        }
        }
        catch(GeneralException e){
        	cat.debug("GeneralException", e);
        	throw new FrmkCargosException (e);
        }
        
        cat.debug("registrarCargos():end");
        return resultado;

	}
	
	
	
	//TODO : VentasSrv
	
	/**
	 *Registra los cargos asociados a la venta
	 * @param ParametrosRegistroCargosDTO cargos
	 * @return 
	 * @throws ManCusBilException
	 */
	
	private ResultadoRegistroCargosDTO setRegistrarCargos(ParametrosRegistroCargosDTO cargos)throws FrmkCargosException,FrameworkCargosException,CustomerException{
		cat.debug("Inicio:registrarCargos()");
		ResultadoRegistroCargosDTO resultado = new ResultadoRegistroCargosDTO();
		try{
			List listaTareas = new ArrayList();
			ParametrosMotorCargosDTO parametrosMotor = new ParametrosMotorCargosDTO();
			parametrosMotor.setCodigoCliente(cargos.getCodigoCliente());
			parametrosMotor.setNumeroProceso(cargos.getNumeroVenta());
			parametrosMotor.setNumeroTransaccion(cargos.getNumeroTransaccion());
			parametrosMotor.setCodigoProducto(global.getValor("codigo.producto"));
			parametrosMotor.setCodigoSecuenciaCargo(global.getValor("secuencia.cargos"));
			parametrosMotor.setCodigoSecuenciaPaquete(global.getValor("secuencia.paquete"));
			parametrosMotor.setCodigoPlanComercialCliente(cargos.getCodigoPlanComercial());
			parametrosMotor.setParametroDiaVctoFact(global.getValor("parametro.dias.vcto.fact"));
			parametrosMotor.setModuloParametroDiaVctoFact(global.getValor("parametro.dias.vcto.fact"));
			
			
			/*Utilizados para ejecutar el Prebilling*/
			parametrosMotor.setNombreSecuenciaProcesoFacturacion(global.getValor("secuencia.num.proceso.fac"));
			parametrosMotor.setNombreParametroDocumentoGuia(global.getValor("parametro.documento.guia"));
			parametrosMotor.setModuloParametroDocumentoGuia(global.getValor("codigo.modulo.GA"));
			parametrosMotor.setNombreParametroFacturaGlobal(global.getValor("parametro.factura.global"));
			parametrosMotor.setModuloParametroFacturaGlobal(global.getValor("codigo.modulo.GA"));
			parametrosMotor.setParametroFlagCentroFac(global.getValor("parametro.flag.centro.emision.fact"));
			parametrosMotor.setModuloParametroFlagCentroFac(global.getValor("codigo.modulo.GA"));
			parametrosMotor.setCodigoTipoMovimiento(global.getValor("codigo.tipo.movimiento"));
			//TODO : Parametros Obtenidos Mediante Web
			VendedorDTO vendedorDTO =new VendedorDTO();
			vendedorDTO.setCodigoVendedor(cargos.getCodigoVendedor());
			cat.debug("setRegistrarCargos vendedorBO ANTES");
			vendedorDTO=vendedorBO.getVendedor(vendedorDTO);
			cat.debug("setRegistrarCargos vendedorBO DESPUES");
			parametrosMotor.setCodigoTipoDocumento(cargos.getCodigoDocumento());
			parametrosMotor.setTipoFoliacionDocumento(cargos.getTipoFoliacion());
			//parametrosMotor.setCodigoOficina(cargos.getCodigoOficina());
			parametrosMotor.setCodigoOficina(vendedorDTO.getCodigoOficina());
			parametrosMotor.setCategoriaTributaria(cargos.getCategoriaTributaria());
			parametrosMotor.setModalidadVenta(cargos.getModalidadVenta());
			parametrosMotor.setFacturacionaCiclo(cargos.isFacturacionaCiclo());
			
			/**
			 * @autor : rlozano
			 * @description : se setean los decimales configurados en base de datos obtenidos de la ged_parametros
			 * @date : 23-04-2008
			 */
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GE"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.numero.decimales.facturacion"));
			cat.debug("setRegistrarCargos parametrosGeneralesBO ANTES");
			parametrosGeneralesDTO=parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			cat.debug("setRegistrarCargos parametrosGeneralesBO DESPUES");
			String valorDecimalBD=parametrosGeneralesDTO.getValorparametro();
			valorDecimalBD=valorDecimalBD==null||valorDecimalBD.equals("")?"0":valorDecimalBD;
			parametrosMotor.setNumeroDecimalesPorDesc(Integer.parseInt(valorDecimalBD));
			/********************************************************************************************************/
			/*ConfiguradorTareaPreliquidacionDTO confPreliquidacion = parametrosPreliquidacion(cargos);
			PreliquidacionVE tareaPreliquidacion = new PreliquidacionVE(confPreliquidacion);*/
			
			
			
			ProcesadorCargos procesadorCargos = new ProcesadorCargos(parametrosMotor,cargos.getCargos());
			ConfiguradorTareasDTO configuradorTareas = new ConfiguradorTareasDTO();
			/*listaTareas.add(tareaPreliquidacion);
			 */
			ConfiguradorTareaPrebillingDTO confPrebilling =parametrosPrebilling(cargos);
			//TODO: Facturacion false el Cliente desea cancelar los cargos obtenidos y no en la factura con el ciclo q le corresponde (ejem. 25)
			confPrebilling.setPrebilling(cargos.isFacturacionaCiclo()?false:true);
			PreBillingVE tareaPreBilling = new PreBillingVE(confPrebilling);
			listaTareas.add(tareaPreBilling); 
			
			TareasRegistroCargos[] arregloTareas =(TareasRegistroCargos[])ArrayUtl.copiaArregloTipoEspecifico(listaTareas.toArray(),TareasRegistroCargos.class);
			
			//TODO : Registrar Cargos
			procesadorCargos.registrarCargos(arregloTareas);
			
			
			ImpuestosDTO impuestos = procesadorCargos.obtenerImpuestos();
			resultado.setImpuestos(impuestos);
			
			BitacoraDTO bitacora = procesadorCargos.obtenerBitacora();
			if (bitacora != null) {
				ProcesoDTO[] procesos = bitacora.getProcesos();
				resultado.setPrebillingOK(true);
				for (int i=0;i<procesos.length;i++){
					if (procesos[i].getIdentificadorProceso() == IdentificadorProceso.EjecutaPrebilling){
						resultado.setPrebillingOK(false);
					}
						
				}
			}
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("GeneralException log error[" + loge + "]");
			throw new FrmkCargosException (e);
			
		}	
		cat.debug("Fin:registrarCargos()");
		return resultado;
	}
	
	private ConfiguradorTareaPreliquidacionDTO parametrosPreliquidacion(ParametrosRegistroCargosDTO parametrosCargos) {
		ConfiguradorTareaPreliquidacionDTO configuradorTareas = new ConfiguradorTareaPreliquidacionDTO();
		configuradorTareas.setNumeroVenta(parametrosCargos.getNumeroVenta());
		configuradorTareas.setCodigoCliente(parametrosCargos.getCodigoCliente());
		configuradorTareas.setModalidadVenta(parametrosCargos.getModalidadVenta());
		configuradorTareas.setCodigoVendedor(parametrosCargos.getCodigoVendedor());
		configuradorTareas.setCodigoVendedorRaiz(parametrosCargos.getCodigoVendedorRaiz());
		configuradorTareas.setArrayCargos(parametrosCargos.getCargos());
		configuradorTareas.setDatosPrograma(parametrosCargos.getDatosPrograma());
		return configuradorTareas;
	}	

	/**
	 *Metodo privado que genera los parametros necesarios para ejecutar la tarea prebilling
	 * @param  parametrosCargos
	 * @return configuradorTareas
	 * @throws 
	 */
	
	private ConfiguradorTareaPrebillingDTO parametrosPrebilling(ParametrosRegistroCargosDTO parametrosCargos){
		ConfiguradorTareaPrebillingDTO configuradorTareas = new ConfiguradorTareaPrebillingDTO();
		configuradorTareas.setCodigoCliente(parametrosCargos.getCodigoCliente());
		configuradorTareas.setNumeroVenta(parametrosCargos.getNumeroVenta());
		configuradorTareas.setNumeroTransaccionVenta(parametrosCargos.getNumeroTransaccion());
		configuradorTareas.setCategoriaTributaria(parametrosCargos.getCategoriaTributaria());
		configuradorTareas.setNombreSecuenciaTransacabo(global.getValor("secuencia.transacabo"));
		configuradorTareas.setActuacionPrebilling(global.getValor("codigo.actuacion.prebilling"));
		configuradorTareas.setProductoGeneral(global.getValor("codigo.producto.general"));
		configuradorTareas.setFacturacionaCiclo(parametrosCargos.isFacturacionaCiclo());
		configuradorTareas.setPrebilling(true);
		return configuradorTareas;
	}
	
	public RetornoDTO registraCargosBatch(RegistroCargosBatchDTO registro) throws FrmkCargosException{
		RetornoDTO retorno;
		cat.debug("Inicio:registraCargosBatch()");
		try {
			retorno = regFacturacion.registraCargosBatch(registro);
		} catch (ProductException e) {
			throw new FrmkCargosException(e.getMessage(),e.getCause());
		}
		cat.debug("Fin:registraCargosBatch()");
		return retorno;
	}
	
		
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws FrmkCargosException{
		ArchivoFacturaDTO resultado;
		cat.debug("Inicio:obtenerRutaFactura()");
		try {
			resultado =regFacturacion.obtenerRutaFactura(factura);
		} catch (ProductException e) {
			throw new FrmkCargosException(e.getMessage(),e.getCause());
		} 
		cat.debug("Fin:obtenerRutaFactura()");
		return resultado;		
	}
	
	public void cierreVenta(GaVentasDTO gaVentasDTO) throws FrmkCargosException {
		cat.debug("cierreVenta():start");
		ParametrosGeneralesDTO parametrosGeneralesDTO=new ParametrosGeneralesDTO();
		gaVentasDTO.setIndVenta(global.getValor("venta.indicador.venta"));
		gaVentasDTO.setIndOfiter(global.getValor("venta.oficina"));
		gaVentasDTO.setIndChkDicom(global.getValor("venta.chkdicom"));
		
		try{
//		se procede a efectuar los codigos alternativos
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.modalidad.venta.credito"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
			gaVentasDTO.setCodModPago(gaVentasDTO.getCodModPago()==null?"":gaVentasDTO.getCodModPago());
			if (parametrosGeneralesDTO.getValorparametro().equals(gaVentasDTO.getCodModPago())){
				gaVentasDTO.setCuotas(true);
			}else{
				gaVentasDTO.setTipValor(global.getValor("tipo.valor"));
			}
			
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.tarjeta.credito"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
			gaVentasDTO.setCodModPago(gaVentasDTO.getCodModPago()==null?"":gaVentasDTO.getCodModPago());
			if (parametrosGeneralesDTO.getValorparametro().equals(gaVentasDTO.getCodModPago())){
				gaVentasDTO.setTrajCredito(true);
			}
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.codigo.cheque"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			gaVentasDTO.setCodModPago(gaVentasDTO.getCodModPago()==null?"":gaVentasDTO.getCodModPago());
			parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
			
			if (parametrosGeneralesDTO.getValorparametro().equals(gaVentasDTO.getCodModPago())){
				gaVentasDTO.setCheque(true);
			}
			gaVentasDTO.setIndEstVenta(global.getValor("indicador.ind_estadoventa"));
			
			registroVentaBO.updateVenta(gaVentasDTO);
			
			if(!gaVentasDTO.isCuotas()){
				if (!gaVentasDTO.isAciclo()){
					if (gaVentasDTO.isTrajCredito()){
						registroVentaBO.updateVentasEscenarioA(gaVentasDTO);
					}
					if (gaVentasDTO.isCheque()){
						registroVentaBO.updateVentasEscenarioB(gaVentasDTO);
					}
					
					if (!gaVentasDTO.isTrajCredito()&&gaVentasDTO.isCheque()){
					
						registroVentaBO.updateVentasEscenarioC(gaVentasDTO);
					}
				}else{
					registroVentaBO.updateVentasEscenarioD(gaVentasDTO);
				}
				
			} 
			//Se actualiza código situación de los abonados
			AbonadoDTO abonadoDTO = new AbonadoDTO();
			abonadoDTO.setNumVenta(gaVentasDTO.getNumVenta().longValue());
			abonadoDTO.setCodSituacion(global.getValor("codigo.situacion.final"));
			abonadoBO.updCodigoSituacion(abonadoDTO);
			
			//Desreserva numero celular asociados a la venta
			//registroVentaBO.desreservaCelular(gaVentasDTO);
			
			//--BUSCA EV. DE RIESGO ASOCIADA AL CLIENTE y actualiza solicitud de venta
			ClienteDTO clienteDTO = new ClienteDTO();
			clienteDTO.setCodCliente(gaVentasDTO.getCodCliente().longValue());
			clienteDTO = clienteBO.getCliente(clienteDTO);
			
			/*
			 * Inc 131523.
			 * Guatemala – El Salvador no debe utilizar esta validación, 
			RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO = new RegistroEvaluacionRiesgoDTO();
			registroEvaluacionRiesgoDTO.setCodigoTipoIdentificacion(clienteDTO.getCodigoTipoIdentificacion());
			registroEvaluacionRiesgoDTO.setNumIdentificacion(clienteDTO.getNumeroIdentificacion());
			registroEvaluacionRiesgoDTO = getEvaluacionRiesgoVigenteCliente(registroEvaluacionRiesgoDTO);
			
			
			if (registroEvaluacionRiesgoDTO!=null){
				registroEvaluacionRiesgoDTO.setNumeroVenta(String.valueOf(gaVentasDTO.getNumVenta()));
				registroEvaluacionRiesgoBO.insSolicitudVenta(registroEvaluacionRiesgoDTO);
			}
			*/
		}
		catch(GeneralException e){
			throw new FrmkCargosException(e);
		}
		
		cat.debug("cierreVenta():end");
	}
	
	
	/**
	 * Busca evaluación de riesgo vigente del cliente.
	 * 
	 * @author Héctor Hermosilla
	 * @param registroEvaluacionRiesgoDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroEvaluacionRiesgoDTO getEvaluacionRiesgoVigenteCliente(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO)throws FrmkCargosException{
		cat.debug("Inicio:getEvaluacionRiesgoVigenteCliente()");
		RegistroEvaluacionRiesgoDTO resultado = null;
		try{
			registroEvaluacionRiesgoDTO.setTipoSolicitud(global.getValor("tipo.solicitud"));
			resultado = registroEvaluacionRiesgoBO.getEvaluacionRiesgoVigenteCliente(registroEvaluacionRiesgoDTO);
			cat.debug("Fin:getEvaluacionRiesgoVigenteCliente()");
		}
		catch(GeneralException e){
			throw new FrmkCargosException(e);
		}
		return resultado;
	}
	
	/**
	 * Actualiza Facturacion FA_INTERFACT.
	 * 
	 * @author Héctor Hermosilla
	 * @param registroEvaluacionRiesgoDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public void actualizaFacturacion(ParametrosEjecucionFacturacionDTO parametrosEjecucion) throws FrmkCargosException{
		cat.debug("Inicio:actualizaFacturacion");
		try{
			RegistroFacturacionDTO regFac = new RegistroFacturacionDTO();
			//regFac.setNumeroProcesoFacturacion(parametrosEjecucion.getNumeroProcesoFacturacion());
			regFac.setNumeroVenta(parametrosEjecucion.getNumeroVenta());//pl usa solo num_venta
			regFac.setEstadoDocumento(global.getValor("estado.documento"));
			regFac.setEstadoProceso(global.getValor("estado.proceso"));
			ProcesoDTO proceso = regFacturacion.actualizaFacturacion(regFac);
			cat.debug("Fin:actualizaFacturacion");	
		}catch(ProductException ex){
			cat.debug("ProductException:actualizaFacturacion "+ex.getMessage());
			String loge = StackTraceUtl.getStackTrace(ex);
			cat.debug("ProductException log error[" + loge + "]");
			throw new FrmkCargosException(ex);
		}
	}
	 	
}//fin class GestionComunicacionClienteSRV

