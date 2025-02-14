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
 * 25/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.frameworkcargossrv.service.implementacion;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.interfaz.TipoDescuentos;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConfiguradorTareaPreliquidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrebillingDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroPreliquidacion;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Vendedor;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroDetPreliquidacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroPreliquidacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;
import com.tmmas.cl.scl.frameworkcargos.base.TareasRegistroCargos;
import com.tmmas.cl.scl.productdomain.businessobject.bo.Terminal;

public class PreliquidacionVE extends TareasRegistroCargos{
	private ConfiguradorTareaPreliquidacionDTO parametrosPreliquidacion;
	private ArrayList listaDetMercaderiaConsignacion;
	
	private Global global = Global.getInstance();
	private static Category cat = Category.getInstance(PreliquidacionVE.class);
	
	public PreliquidacionVE(ConfiguradorTareaPreliquidacionDTO parametros) {
		super(parametros);
		this.parametrosPreliquidacion = parametros;
	}
	
	public boolean validaciones() {
		boolean resultado = false;
		try {
			// Obtencion del vendedor para saber si es externo (dealer)
			Vendedor vendedorBO  =  new Vendedor();
			VendedorDTO vendedorDTO = new VendedorDTO();
			vendedorDTO.setCodigoVendedor(parametrosPreliquidacion.getCodigoVendedor());
			vendedorDTO = vendedorBO.verificaVendedorEsExterno(vendedorDTO);
			// Si el vendedor es externo el item entra en la preliquidacion
			if (!vendedorDTO.isVendedorInterno()) {
				// Recupero registros de la ga_abocel y al_series de terminales 
				// y simcards en consignacion y que no hayan sido rechazados 
				RegistroPreliquidacion registroPreliquidacionBO = new RegistroPreliquidacion();
				RegistroPreliquidacionDTO registroPreliquidacion = new RegistroPreliquidacionDTO();
				registroPreliquidacion.setNumeroVenta(Long.parseLong(parametrosPreliquidacion.getNumeroVenta()));
				listaDetMercaderiaConsignacion = registroPreliquidacionBO.getMercaderiaEnConsignacion(registroPreliquidacion);

				// Si hay algo en la lista verificar  series rechazadas
				if (!listaDetMercaderiaConsignacion.isEmpty()){
					Iterator itdet = listaDetMercaderiaConsignacion.iterator();
					Terminal terminalBO = new Terminal();
					ParametrosValidacionLogisticaDTO parametro = new ParametrosValidacionLogisticaDTO();
					while (itdet.hasNext()){
						RegistroDetPreliquidacionDTO registrodet = (RegistroDetPreliquidacionDTO) itdet.next();
						parametro.setNumeroSerie(registrodet.getNumeroSerie()); 
						ResultadoValidacionLogisticaDTO res = terminalBO.verificaRechazoSerie(parametro);
						if (res.isResultado()){
							// Remueve las series rechazadas de la lista
							listaDetMercaderiaConsignacion.remove(registrodet);
						}
					}//fin de while 
				}
				
				resultado = !listaDetMercaderiaConsignacion.isEmpty()?true:false; 
			}
		}
		catch(CustomerDomainException e){
			e.printStackTrace();
		}
		catch(ProductDomainException e){
			e.printStackTrace();
		}
		
		return resultado;
	}

	public boolean esPrebilling() {
		return false;
	}

	// La tarea seria registrar la preliquidacion
	public void tarea() {
		try{
			if (parametrosPreliquidacion!=null && listaDetMercaderiaConsignacion!=null && !listaDetMercaderiaConsignacion.isEmpty()){
				RegistroPreliquidacionDTO registroPreliquidacion = new RegistroPreliquidacionDTO();
				RegistroPreliquidacion registroPreliquidacionBO = new RegistroPreliquidacion();
				// Inserción de maestro preliquidacion
				registroPreliquidacion.setNumeroVenta(Long.parseLong(parametrosPreliquidacion.getNumeroVenta()));
				registroPreliquidacion.setCodigoVendedor(parametrosPreliquidacion.getCodigoVendedor());
				registroPreliquidacion.setCodigoVendedorRaiz(parametrosPreliquidacion.getCodigoVendedorRaiz());
				registroPreliquidacion.setCodigoCliente(parametrosPreliquidacion.getCodigoCliente());
				registroPreliquidacion.setCodigoModalidadVenta(Integer.parseInt(parametrosPreliquidacion.getModalidadVenta()));
				registroPreliquidacion.setDatosPrograma(parametrosPreliquidacion.getDatosPrograma());
				registroPreliquidacionBO.registraMaestroPreliquidacion(registroPreliquidacion);
				
				// Debo obtener los cargos para actualizar los objetos del arreglo 
				CargosDTO[] arrayCargos =	parametrosPreliquidacion.getArrayCargos();
				
				// Me saco los codigos de articulos distintos (no repetidos)
				HashSet setCodigosArticulos = new HashSet();
				
				Iterator itermercaderia = listaDetMercaderiaConsignacion.iterator();
				
				while (itermercaderia.hasNext()) {
					setCodigosArticulos.add(new Integer(((RegistroDetPreliquidacionDTO)itermercaderia.next()).getCodigoArticulo()));
				}
				
				// Correlativo de item, pk junto con numero de la venta  
				int numeroItem = 0; 
				Iterator it = setCodigosArticulos.iterator();
				while (it.hasNext()){
					Integer integer = (Integer) it.next();
					int codigoArticulo = integer.intValue();
					
					for (int i=0; i < arrayCargos.length; i++){
						CargosDTO cargodto = arrayCargos[i];  
						int codigoArticuloCargo = Integer.parseInt(cargodto.getAtributo().getCodigoArticuloServicio());  
						
						if (codigoArticuloCargo == codigoArticulo){
							double importeCargo = cargodto.getPrecio().getMonto()/cargodto.getCantidad();
							DescuentoDTO[] arrayDescuento = cargodto.getDescuento();
							double totalDescuento = 0.0f;
							
							if ( arrayDescuento != null) 
								for (int j=0;j<arrayDescuento.length; j++)
								totalDescuento += arrayDescuento[j].getMonto();
							
							double descuentoCargo = totalDescuento/cargodto.getCantidad();
							
							double importeFinal = importeCargo - descuentoCargo;
							// Recorrer la lista de detalles
							Iterator  itdet = listaDetMercaderiaConsignacion.iterator();
							
							while (itdet.hasNext()){
								RegistroDetPreliquidacionDTO regDetalle = (RegistroDetPreliquidacionDTO) itdet.next();
								if (regDetalle.getCodigoArticulo() == codigoArticuloCargo){
									// Setea los atributos que faltan
									regDetalle.setNumItem(++numeroItem);
									regDetalle.setImporteCargo(importeCargo);
									regDetalle.setImporteCargoFinal(importeFinal);
									regDetalle.setValorDescuento(descuentoCargo);
									regDetalle.setTipoDescuento(TipoDescuentos.Importe);
									// Guarda el detalle
									registroPreliquidacionBO.registraDetallePreliquidacion(regDetalle,registroPreliquidacion);
									// Probar eliminar del list para mejor rendimiento
									// Probar hacer un break; para que salga del while cuando
									// un contador alcance la cantidad cargodto.getCantidad()
								}// fin de if
							} // fin de while
								
						}// fin de if
					}// fin de for
				} // fin de while
				
				// Actualizacion del numero de unidades y el total de importe de la venta
				registroPreliquidacionBO.actualizaMaestroPreliquidacion(registroPreliquidacion);
				
			}// fin de if
		}// fin de try
		catch(CustomerDomainException e){
			e.printStackTrace();
		}
	}

	public void tarea(PrebillingDTO datos) {
		// TODO Auto-generated method stub
	}

}
