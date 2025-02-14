
package com.tmmas.scl.quiosco.web.altaLinea;

import java.rmi.RemoteException;
import java.util.ArrayList;

import javax.xml.rpc.ServiceException;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWS;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService_Impl;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsCreaStructuraComercialInDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsDireccionQuioscoInDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraAccesorioDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraActivacionLineaDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraAntecedentesVentaDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraClienteDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraComercialOutDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraCuentaInDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraLineaDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraPagoDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DatosClienteDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.scl.quiosco.web.VO.AccesorioVO;


public class AltaLinea {
	
	private final Logger logger = Logger.getLogger(AltaLinea.class);	
	
	public WsStructuraComercialOutDTO altaLinea
	(DatosClienteDTO clienteDTO, WsTiendaVendedorOutDTO tiendaVendedorOutDTO, 
	 ArrayList<WsStructuraLineaDTO> listaStructura,ArrayList<AccesorioVO> listaAccesorios, WsStructuraPagoDTO pagoDTO, String usuarioAD, String codDireccion, String codPrestacion) throws  InterruptedException, ServiceException{
		
		CompositeConfiguration config;
		config = UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
		UtilLog.setLog(config.getString("QuioscoWEB.log"));
		
		String url = config.getString("ruta.webservice");
		logger.fatal("url WS ["+url+"]");
		//SpnSclWSServiceStub proxy = new SpnSclWSServiceStub(url);
		WsStructuraComercialOutDTO structuraComercialOutDTO = null;
		
		SpnSclWSService service = new SpnSclWSService_Impl(config.getString("ruta.webservice"));    
		SpnSclWS port = service.getSpnSclWSSoapPort();
		//FINALIZAR VENTA

		
		//Antecedentes de la venta
		WsStructuraAntecedentesVentaDTO antecedentesVentaDTO = new WsStructuraAntecedentesVentaDTO();
		antecedentesVentaDTO.setCodigoVendedor(tiendaVendedorOutDTO.getCodVendedor());
		
		//Lineas y usuarios de la venta
		WsStructuraActivacionLineaDTO activacionLineaDTO = new WsStructuraActivacionLineaDTO();
		
		activacionLineaDTO.setAntecedentesVenta(antecedentesVentaDTO);
		WsStructuraLineaDTO[] lineaDTOs =(WsStructuraLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
		listaStructura.toArray(), WsStructuraLineaDTO.class);
		activacionLineaDTO.setLineas(lineaDTOs);
		
		//Accesorios de la Venta
		WsStructuraAccesorioDTO structuraAccesorioDTO = null;
		WsStructuraAccesorioDTO[] structuraAccesorioDTOs = new WsStructuraAccesorioDTO[listaAccesorios.size()];
		for(int b=0;b<=listaAccesorios.size()-1;b++){
			structuraAccesorioDTO  = new WsStructuraAccesorioDTO();
			structuraAccesorioDTO.setCantidad(listaAccesorios.get(b).getCantidad());
			structuraAccesorioDTO.setCodigoArticulo(listaAccesorios.get(b).getCodigo());
			structuraAccesorioDTO.setNumeroSerie(listaAccesorios.get(b).getSerie());
			structuraAccesorioDTO.setCodBodega(tiendaVendedorOutDTO.getCodBodega());
			structuraAccesorioDTOs[b]=structuraAccesorioDTO;
		}
		
		//Datos del cliente
		WsStructuraClienteDTO structuraClienteDTO = new WsStructuraClienteDTO();
		structuraClienteDTO.setAccesorios(structuraAccesorioDTOs);
		structuraClienteDTO.setActivacion(activacionLineaDTO);
		structuraClienteDTO.setCodigoCategoria(Integer.toString(clienteDTO.getCodCategoria()));
		structuraClienteDTO.setCodigoCliente(Long.toString(clienteDTO.getCliente().getCodCliente()));
		structuraClienteDTO.setCodigoOficina(tiendaVendedorOutDTO.getCodOficina());
		structuraClienteDTO.setCodigoTipoIdent(clienteDTO.getCodigoTipIdentif());
		structuraClienteDTO.setNombreApeclien1(clienteDTO.getApellidoPaterno());
		structuraClienteDTO.setNombreApeclien2(clienteDTO.getApellidoMaterno());
		structuraClienteDTO.setNombreCliente(clienteDTO.getNomCliente());
		structuraClienteDTO.setNumeroIdent(clienteDTO.getNumIdent());
		//INCIO P-CSR-11002 
		structuraClienteDTO.setCodigoCategoriaCambio(clienteDTO.getCodCategoriaCambio());
		structuraClienteDTO.setCodCrediticia(clienteDTO.getCodCrediticia());
		//FIN P-CSR-11002
		
		//Direccion del cliente
		WsDireccionQuioscoInDTO direccionQuioscoInDTO = new WsDireccionQuioscoInDTO();
		if(null==codDireccion){
			direccionQuioscoInDTO.setCodigoRegion(clienteDTO.getDireccionDTO().getCodigoRegion());
			direccionQuioscoInDTO.setCodigoProvincia(clienteDTO.getDireccionDTO().getCodigoProvincia());
			direccionQuioscoInDTO.setCodigoCiudad(clienteDTO.getDireccionDTO().getCodigoCiudad());
			direccionQuioscoInDTO.setCodigoComuna(clienteDTO.getDireccionDTO().getCodigoComuna());
			direccionQuioscoInDTO.setNombreCalle(clienteDTO.getDireccionDTO().getNombreCalle());
			direccionQuioscoInDTO.setNumeroCalle(clienteDTO.getDireccionDTO().getNumeroCalle());
			//INICIO CSR-11002
			direccionQuioscoInDTO.setPiso(clienteDTO.getDireccionDTO().getNumPiso());
			direccionQuioscoInDTO.setCasilla(clienteDTO.getDireccionDTO().getNumCasilla());
			direccionQuioscoInDTO.setObservacionDescripcion(clienteDTO.getDireccionDTO().getObsDireccion());
			direccionQuioscoInDTO.setDescripcionDireccion1(clienteDTO.getDireccionDTO().getDesDirec1());
			direccionQuioscoInDTO.setDescripcionDireccion2(clienteDTO.getDireccionDTO().getDesDirec2());
			direccionQuioscoInDTO.setPueblo(clienteDTO.getDireccionDTO().getCodPueblo());
			direccionQuioscoInDTO.setEstado(clienteDTO.getDireccionDTO().getCodEstado());
			direccionQuioscoInDTO.setTipoCalle(clienteDTO.getDireccionDTO().getCodTipoCalle());
			//FIN CSR-11002		
			direccionQuioscoInDTO.setZIP(clienteDTO.getDireccionDTO().getZip());
		}
		else{
			direccionQuioscoInDTO.setCodigoDireccion(codDireccion);
		}
		structuraClienteDTO.setDireccion(direccionQuioscoInDTO);
		
		//Datos de la cuenta
		WsStructuraCuentaInDTO structuraCuentaInDTO = new WsStructuraCuentaInDTO();
		structuraCuentaInDTO.setCliente(structuraClienteDTO); 
		
		if(!"".equals(clienteDTO.getCliente().getCodCuenta()))
		structuraCuentaInDTO.setCodigoCuenta(Long.toString(clienteDTO.getCliente().getCodCuenta()));
		

				
		//Datos comerciales para el alta de linea
		WsCreaStructuraComercialInDTO structuraComercialInDTO = new WsCreaStructuraComercialInDTO();
		structuraComercialInDTO.setCuenta(structuraCuentaInDTO);
		structuraComercialInDTO.setUsuarioOracle(tiendaVendedorOutDTO.getNomUsuario());
		structuraComercialInDTO.setUsuarioAD(usuarioAD);
		structuraComercialInDTO.setPago(pagoDTO);
		
		
		WsCreaStructuraComercialInDTO altaDeStructuraComercial = new WsCreaStructuraComercialInDTO();
		
		//altaDeStructuraComercial.setWsCreaStructuraComercial(structuraComercialInDTO);
		altaDeStructuraComercial.setCuenta(structuraComercialInDTO.getCuenta());
		altaDeStructuraComercial.setUsuarioOracle(structuraComercialInDTO.getUsuarioOracle());
		altaDeStructuraComercial.setUsuarioAD(structuraComercialInDTO.getUsuarioAD());
		altaDeStructuraComercial.setPago(structuraComercialInDTO.getPago());
		
		logger.fatal("codPrestacion: " + codPrestacion);
		altaDeStructuraComercial.setCodPrestacion(codPrestacion);
		
		
		//EJECUTO ALTA
		 try {
			 
			 long soTimeout = 10 * 60 * 1000; // Two minutes    
		    			 			 			 
			// proxy._getServiceClient().getOptions().setTimeOutInMilliSeconds(soTimeout);
			 
			structuraComercialOutDTO = port.altaDeStructuraComercial(altaDeStructuraComercial);
			
			
			
		} catch (GeneralException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.fatal("log GeneralException[" + log + "]");		
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.fatal("log GeneralException[" + log + "]");
		}
					
	
		return structuraComercialOutDTO;
	}

}
