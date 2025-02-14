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
package com.tmmas.scl.operations.crm.b.bcm.mancusbil.srv;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.VendedorBOFactory;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.VendedorBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.VendedorIT;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ConfiguradorTareaPrebillingDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ConfiguradorTareaPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ParametrosRegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.RegistroCargosBatchDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.productABE.exception.ProductException;
import com.tmmas.scl.framework.productDomain.productABE.interfaz.TipoDescuentos;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoFrameworkCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.common.exception.ManCusBilException;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.srv.helper.Global;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.srv.interfaces.GestionCargosRegistrarSrvIF;


public class GestionCargosRegistrarSrv implements  GestionCargosRegistrarSrvIF{
	
	private final Logger cat = Logger.getLogger(GestionCargosRegistrarSrv.class);
	private ClienteBOFactoryIT clienteFactory=new ClienteBOFactory();
	private ClienteIT clienteBO=clienteFactory.getBusinessObject1();
	private VendedorBOFactoryIT vendedorFactory=new VendedorBOFactory();
	private VendedorIT vendedorBO =vendedorFactory.getBusinessObject1();
	private RegistroFacturacionBOFactoryIT regFacturacionFactory = new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT regFacturacion = regFacturacionFactory.getBusinessObject1();
	private AbonadoBOFactory abonadoFactory=new AbonadoBOFactory();
	private AbonadoIT abonadoBO=abonadoFactory.getBusinessObject1();
	
	Global global = Global.getInstance();

	
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO resultadoObtenerCargos) throws ManCusBilException {
		
		RegCargosDTO listadoCargos = new RegCargosDTO();
		CargoFrameworkCargosDTO[] arregloCargos =null;
		List listaCargos = new ArrayList();
		CargosDTO[] cargos =resultadoObtenerCargos.getCargos();
		
		try{
			if (cargos !=null){
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
						cargo.setNumAbonado(precio.getDatosAnexos().getNumAbonado());
						DescuentoDTO[] arregloDescuento = cargos[i].getDescuento();
						if (arregloDescuento!=null)
							if (arregloDescuento.length>0){
								/*Recorre los descuentos. Si existe descuento automatico se asigna este como descuento del cargo, 
								en caso contrario toma el código del descuento manual. Si existen los dos tipos de descuentos toma
								el codigo concepto del descuento automatico*/
								for (int k=0;k<arregloDescuento.length;k++){
									/*if (arregloDescuento[k].getTipo()==null){
										if (arregloDescuento[k].getCodigoConcepto()!=null && cargo.getCodigoDescuento()==null){
											cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());
										}
									}*/
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
							}
						else{
							cargo.setMontoDescuento(0);
						}
						cargo.setDescuentoManual(1);
						listaCargos.add(cargo);
						
					}
				}
			}
		}
		catch(Exception e){
			throw new ManCusBilException(e);
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
		return listadoCargos;
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
	
	public RetornoDTO registraCargosBatch(RegistroCargosBatchDTO registro) throws ManCusBilException{
		RetornoDTO retorno;
		cat.debug("Inicio:registraCargosBatch()");
		try {
			retorno = regFacturacion.registraCargosBatch(registro);
		} catch (ProductException e) {
			throw new ManCusBilException(e.getMessage(),e.getCause());
		}
		cat.debug("Fin:registraCargosBatch()");
		return retorno;
	}
	
}//fin class GestionComunicacionClienteSRV

