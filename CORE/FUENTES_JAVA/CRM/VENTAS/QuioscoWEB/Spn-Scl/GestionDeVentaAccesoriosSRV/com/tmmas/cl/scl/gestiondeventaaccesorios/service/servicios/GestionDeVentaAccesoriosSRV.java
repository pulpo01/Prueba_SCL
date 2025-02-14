package com.tmmas.cl.scl.gestiondeventaaccesorios.service.servicios;

import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Iterator;

import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.RegistroVentaBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSCentralQuioscoOutDTO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.FacturacionBO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.RegistroFacturacionBO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.interfaz.TipoAtributoDireccion;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.CiudadBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.ComunaBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.EstadoBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.ProvinciaBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.RegionBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.TipoCalleBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.EstadoDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.TipoCalleDireccionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.bo.ClienteBO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.bo.PagoBO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.bo.TiendasBO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.bo.TipificacionBO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.bo.VentaAccesoriosBO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DatosClienteDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DetalleFacturaVO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.FacturaVO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.InfoFacturaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.PagoDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ParametrosCargosAccesoriosDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificaClientizaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificacionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.VentaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsCajaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsUpdateTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsVentaAccesoriosDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsVentaAccesoriosOutDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;

public class GestionDeVentaAccesoriosSRV {
	
	private VentaAccesoriosBO ventaAccesoriosBO = new VentaAccesoriosBO();
	private TiendasBO tiendasBO = new TiendasBO();
	private TipificacionBO tipificacionBO = new TipificacionBO();
	private ClienteBO clienteBO = new ClienteBO();
	private PagoBO pagoBO = new PagoBO();
	private FacturacionBO BOfacturacion = new FacturacionBO();
	private RegistroVentaBO BORegistroVenta = new RegistroVentaBO();
	private RegistroFacturacionBO registroFacturacionBO = new RegistroFacturacionBO();
	
	private com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.ClienteBO clienteBO2 = new com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.ClienteBO();
	private final Logger logger = Logger.getLogger(GestionDeVentaAccesoriosSRV.class);
	private CompositeConfiguration config;

	public GestionDeVentaAccesoriosSRV() {
		System.out.println("GestionDeVentaAccesoriosSRV(): Start");
		config = UtilProperty.getConfiguration("GestionDeVentaAccesoriosSRV.properties","com/tmmas/cl/scl/gestiondeventaaccesorios/service/properties/servicios.properties");
		System.out.println("GestionDeVentaAccesoriosSRV.log ["+config.getString("GestionDeVentaAccesoriosSRV.log")+"]");
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		logger.debug("GestionDeVentaAccesoriosSRV():End");
	}

	public WsVentaAccesoriosOutDTO preVentaAccesorios (WsVentaAccesoriosDTO ventaAccesoriosDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO = new WsVentaAccesoriosOutDTO();
		com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.VendedorDTO vendedor = new VendedorDTO();
		com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.VentaDTO venta = new VentaDTO();

		try{
			logger.debug("Valida que serie exista en la tabla AL_SERIES");
			for (int j = 0; j < ventaAccesoriosDTO.getArticulo().length;j++){
				if(ventaAccesoriosDTO.getArticulo()[j].getNumSerie() != null && !ventaAccesoriosDTO.getArticulo()[j].getNumSerie().equals("")){
					if (!validaNumeroSerie (ventaAccesoriosDTO.getArticulo()[j])){
						ventaAccesoriosOutDTO.setCodError(13000);
						ventaAccesoriosOutDTO.setMsgError("Ocurrió un error al Validar numero de serie");
						ventaAccesoriosOutDTO.setNumEvento(1);
						logger.error("Ocurrió un error al Validar numero de serie");
						throw new GeneralException("13000",0,"Ocurrió un error al Validar numero de serie");
					}
				}
			}
			ventaAccesoriosOutDTO.setArticulo(ventaAccesoriosDTO.getArticulo());
			ventaAccesoriosOutDTO.setCliente(ventaAccesoriosDTO.getCliente());
			ventaAccesoriosOutDTO.setNombreUsuario(ventaAccesoriosDTO.getNombreUsuario());
			vendedor.setCodVendedor(ventaAccesoriosDTO.getCodVendedor());					
			ventaAccesoriosOutDTO.setVendedor(vendedor);
			venta.setCodModVenta(ventaAccesoriosDTO.getCodModVenta());					
			ventaAccesoriosOutDTO.setVenta(venta);
			ventaAccesoriosOutDTO.setNumTransaccion(getObtieneSecuencia(config.getString("secuencia.transacabo")));
			
			ventaAccesoriosOutDTO = ventaAccesorios(ventaAccesoriosOutDTO);
			
			logger.debug("se obtiene numero de secuencia transaccion");
			
			////////////////////////////////////////////////////////////////////////////////////////////////////
			//logger.debug("Se inserta en la AL_MOVIMIENTOS el accesorio que se va a reservar");
			
			//ventaAccesoriosBO.insertAccesReservMovim(ventaAccesoriosOutDTO);
			
			//Se comenta ya que cuando hace la salida definitiva realiza este proceso con elnúmero de venta.
			//19-08-2010
			////////////////////////////////////////////////////////////////////////////////////////////////////
			
			logger.debug("Inserta en la GA_RESERVART");
			ventaAccesoriosBO.insertReservArticulo(ventaAccesoriosOutDTO);	

		}catch(GeneralException e) {
			logger.debug("VentaAccesorios:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		} 		

		return ventaAccesoriosOutDTO;
	}

	public WsVentaAccesoriosOutDTO ventaAccesorios (WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		try{			
			logger.debug("obtiene datos del vendedor de la tabla VE_VENDEDORES");
			ventaAccesoriosOutDTO = ventaAccesoriosBO.obtieneDatosVendedor(ventaAccesoriosOutDTO);
			logger.debug("obtiene datos del tipo de documentacion");
			ventaAccesoriosOutDTO = ventaAccesoriosBO.obtieneTipoDocumentacion(ventaAccesoriosOutDTO);
			logger.debug("se obtiene secuencia del numero de la venta");
			ventaAccesoriosOutDTO.getVenta().setNumVenta(String.valueOf(getObtieneSecuencia(config.getString("secuencia.venta"))));
			logger.debug("Inserta venta en la tabla GA_VENTAS con estado VP");
			ventaAccesoriosBO.insertaVenta(ventaAccesoriosOutDTO);			
		}catch(GeneralException e) {
			logger.debug("VentaAccesorios:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		} 	
		return ventaAccesoriosOutDTO;
	}

	public WsVentaAccesoriosOutDTO aceptacionVentaAccesorios(WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		try{
			logger.debug("sistema actualiza tabla GA_VENTAS");
			ventaAccesoriosOutDTO = ventaAccesoriosBO.updateVenta(ventaAccesoriosOutDTO);

			logger.debug("Se inserta en la AL_MOVIMIENTOS el accesorio para salida definitiva");			
			ventaAccesoriosBO.insertSalidAccesMovim(ventaAccesoriosOutDTO);

			logger.debug("se elimina reserva de la GA_RESERVART");
			ventaAccesoriosOutDTO = ventaAccesoriosBO.eliminaReserva(ventaAccesoriosOutDTO.getNumTransaccion());			

		}catch(GeneralException e) {
			logger.debug("VentaAccesorios:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		} 	
		return ventaAccesoriosOutDTO;
	}

	public long getObtieneSecuencia(String nombreSecuencia)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		logger.debug("Inicio:getSecuenciaAbonado()");
		long numTransaccion = 0;		
		numTransaccion = ventaAccesoriosBO.getObtieneSecuencia(nombreSecuencia);
		logger.debug("Fin:getSecuenciaAbonado()");
		return numTransaccion;
	}

	public boolean  validaNumeroSerie(ArticuloDTO articuloDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		boolean retValue=false;
		try{
			logger.debug("validaNumeroSerie:start");
			retValue= ventaAccesoriosBO.validaNumeroSerie(articuloDTO);
			logger.debug("validaNumeroSerie:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Fin:validaNumeroSerie()");
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}

	public WsTiendasOutDTO  getTiendas()throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		WsTiendasOutDTO resultado =null;
		try{
			logger.debug("getTiendas:start");
			resultado= tiendasBO.getTiendas();
			logger.debug("getTiendas:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Fin:getTiendas()");
			throw  e;
		}
		return resultado;
	}

	//Busca info de la tienda y el usuario
	public WsTiendaVendedorOutDTO getTiendaVendedor(String codTienda)throws GeneralException
	{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		WsTiendaVendedorOutDTO resultado = null;
		try{
			logger.debug("getTiendas:start");
			resultado= tiendasBO.getTiendaVendedor(codTienda);
			logger.debug("getTiendas:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Fin:getTiendas()");
			throw e;
		}
		return resultado;
	}

	public TipificacionDTO[] recuperaDatoTipificacion (String datoTipificacion,String codVendedor)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		String consulta = null;
		TipificacionDTO []tipificacionDTO = null;
		TipificacionDTO []tipificacionDTO2 = null;
		try{
			logger.debug("consultaKit:Start");
			consulta = tipificacionBO.consultaKit(datoTipificacion);

			if (consulta.equals(config.getString("consulta.kit"))){
				logger.debug("obtiene datos del KIT");								
				tipificacionDTO2 = tipificacionBO.recuperaKit(datoTipificacion,codVendedor);

				logger.debug("Largo Arreglo + 1: "+ tipificacionDTO2.length+1);
				logger.debug("Descripccion KIT: "+tipificacionDTO2[0].getDescripArticulo());
				logger.debug("Precio KIT: "+ tipificacionDTO2[0].getPrecioArticulo());

				tipificacionDTO = new TipificacionDTO[tipificacionDTO2.length+1];
				tipificacionDTO[0]=new TipificacionDTO();
				tipificacionDTO[0].setDescripArticulo(tipificacionDTO2[0].getDescripArticulo());
				tipificacionDTO[0].setPrecioArticulo(tipificacionDTO2[0].getPrecioArticulo());
				tipificacionDTO[0].setEquiAcc(config.getString("consulta.kit"));
				tipificacionDTO[0].setImpITMB(tipificacionDTO2[0].getImpITMB());
				tipificacionDTO[0].setImpISC(tipificacionDTO2[0].getImpISC());

				for (int i=0; i <= tipificacionDTO2.length-1; i++){
					tipificacionDTO[i+1]=new TipificacionDTO();
					tipificacionDTO[i+1].setCodArticulo(tipificacionDTO2[i].getCodArticulo());
					tipificacionDTO[i+1].setDescripArticulo(tipificacionDTO2[i].getDescripArticulo());
					tipificacionDTO[i+1].setEquiAcc(tipificacionDTO2[i].getEquiAcc());
					tipificacionDTO[i+1].setNumCelular(tipificacionDTO2[i].getNumCelular());
					tipificacionDTO[i+1].setNumSerie(tipificacionDTO2[i].getNumSerie());
					tipificacionDTO[i+1].setPrecioArticulo(tipificacionDTO2[i].getPrecioArticulo());
					tipificacionDTO[i+1].setTipTerminal(tipificacionDTO2[i].getTipTerminal());			
				}				
			}else {
				logger.debug("obtiene datos de tipificacion");
				tipificacionDTO = new TipificacionDTO[1];
				tipificacionDTO[0] = tipificacionBO.recuperaDatoTipificacion(datoTipificacion,codVendedor);				
			}						
		}catch(GeneralException e) {
			logger.debug("recuperaDatoTipificacion:end");
			logger.debug("GeneralException");
			throw e;
		} 		
		return tipificacionDTO;
	}

	public DatosClienteDTO clientePorNumeroCelular (long numeroCelular)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		DatosClienteDTO datosClienteDTO = new DatosClienteDTO();
		try{
			logger.debug("clientePorNumeroCelular:Start");
			datosClienteDTO = clienteBO.clientePorNumeroCelular(numeroCelular);	
			
			//INICIO CSR-11002
			//obtener las descripciones de Region, Provincia, Ciudad, comuna, estado, tipo_calle
			//si es que los campos poseen codigo
			
			datosClienteDTO.getDireccionDTO().setDescripcionRegion(obtenerDescripcion(TipoAtributoDireccion.region, datosClienteDTO.getDireccionDTO().getCodigoRegion()));
			datosClienteDTO.getDireccionDTO().setDescripcionProvincia(obtenerDescripcionProvincia(datosClienteDTO.getDireccionDTO().getCodigoRegion(),
					                                                                              datosClienteDTO.getDireccionDTO().getCodigoProvincia()));
			datosClienteDTO.getDireccionDTO().setDescripcionCiudad(obtenerDescripcionCiudad(datosClienteDTO.getDireccionDTO().getCodigoRegion(),
					                                                                        datosClienteDTO.getDireccionDTO().getCodigoProvincia(),
					                                                                        datosClienteDTO.getDireccionDTO().getCodigoCiudad()));
			datosClienteDTO.getDireccionDTO().setDescripcionComuna(obtenerDescripcionComuna(datosClienteDTO.getDireccionDTO().getCodigoRegion(),
                    									                                    datosClienteDTO.getDireccionDTO().getCodigoProvincia(),
                                                                                            datosClienteDTO.getDireccionDTO().getCodigoCiudad(),
					                                                                        datosClienteDTO.getDireccionDTO().getCodigoComuna()));
			datosClienteDTO.getDireccionDTO().setDescripcionEstado(obtenerDescripcion(TipoAtributoDireccion.estado, datosClienteDTO.getDireccionDTO().getCodEstado()));
			datosClienteDTO.getDireccionDTO().setDescripcionTipoCalle(obtenerDescripcion(TipoAtributoDireccion.tipoCalle, datosClienteDTO.getDireccionDTO().getCodTipoCalle()));
			
			//FIN CSR-11002
			
		}catch(GeneralException e) {
			logger.debug("clientePorNumeroCelular:end");
			logger.debug("GeneralException");
			//throw new GeneralException(e.getMessage(), e);
			logger.debug("codigoError: "+ e.getCodigo());
			logger.debug("codigoEvento: "+ e.getCodigoEvento());
			logger.debug("mensajeError: "+ e.getDescripcionEvento());
			throw e;
		} 		
		return datosClienteDTO;
	}	

    /**
     * CSR-11002
     * permite obtener la descripcion de una comuna
     * @param codigoRegion
     * @param codigoProvincia
     * @param codigoCiudad
     * @param codigoComuna
     * @return
     * @throws GeneralException
     */
	private String obtenerDescripcionComuna(String codigoRegion, 
			                                String codigoProvincia, 
			                                String codigoCiudad, 
			                                String codigoComuna) throws GeneralException {
		
		String result = null;
		
        if(codigoRegion == null){
			
			return result;
		}

        if(codigoProvincia == null){
	
	        return result;
        }

        if(codigoCiudad == null){
	
	        return result;
        }
	
        if(codigoComuna == null){
        	
	        return result;
        }
        
        ComunaBO comunaBO = new ComunaBO();
        
        CiudadDTO ciudad = new CiudadDTO();
        ciudad.setCodigoRegion(codigoRegion);
        ciudad.setCodigoProvincia(codigoProvincia);
        ciudad.setCodigoCiudad(codigoCiudad);
        
        ComunaSPNDTO[] comunas = comunaBO.getListadoComunas(ciudad);
        
        if(comunas != null && comunas.length >0){
        	
        	for (int i = 0; i < comunas.length; i++) {
				ComunaSPNDTO comunaSPNDTO = comunas[i];
				
				if(comunaSPNDTO.getCodigoComuna().equals(codigoComuna)){
					
					result = comunaSPNDTO.getDescripcionComuna();
					
					break;
				}
			}
        }
        
		return result;
	}

	/**
	 * CSR-11002
	 * permite obtener la descripcion segun codigo de la ciudad
	 * @param codigoRegion
	 * @param codigoProvincia
	 * @param codigoCiudad
	 * @return
	 * @throws GeneralException
	 */
	private String obtenerDescripcionCiudad(String codigoRegion, 
			                                String codigoProvincia, 
			                                String codigoCiudad) throws GeneralException {

		String result = null;
		
        if(codigoRegion == null){
			
			return result;
		}

        if(codigoProvincia == null){
	
	        return result;
        }

        if(codigoCiudad == null){
	
	        return result;
        }
        
        CiudadBO ciudadBO = new CiudadBO();
        
        ProvinciaDTO provincia = new ProvinciaDTO();
        provincia.setCodigoRegion(codigoRegion);
        provincia.setCodigoProvincia(codigoProvincia);
        
        CiudadDTO[] ciudades = ciudadBO.getListadoCiudades(provincia);
        
        if(ciudades != null && ciudades.length >0){
        	
        	for (int i = 0; i < ciudades.length; i++) {
				CiudadDTO ciudadDTO = ciudades[i];
				
				if(ciudadDTO.getCodigoCiudad().equals(codigoCiudad)){
					
					result = ciudadDTO.getDescripcionCiudad();
					
					break;
				}
			}
        }
        
		return result;
	}

	/**
	 * CSR-11002
	 * permite obtener la descripcion asociado una provincia
	 * @param codigoRegion
	 * @param codigoProvincia
	 * @return
	 * @throws GeneralException
	 */
	private String obtenerDescripcionProvincia(String codigoRegion, String codigoProvincia) throws GeneralException {
		
		String result = null;
		
		if(codigoRegion == null){
			
			return result;
		}
		
		if(codigoProvincia == null){
			return result;
		}
		
		ProvinciaBO provinciaBO = new ProvinciaBO();
		
		RegionDTO region = new RegionDTO();
		region.setCodigoRegion(codigoRegion);
		ProvinciaDTO[] provincias = provinciaBO.getListadoProvincias(region);
		
		if(provincias != null && provincias.length >0){
			
			for (int i = 0; i < provincias.length; i++) {
				ProvinciaDTO provinciaDTO = provincias[i];
				
				if(provinciaDTO.getCodigoProvincia().equals(codigoProvincia)){
					
					result = provinciaDTO.getDescripcionProvincia();
					
					break;
				}
			}
		}
		
		return result;
	}

	/*
	 * CSR-11002
	 * permite obtener la descripcion de la region
	 */
	private String obtenerDescripcion(int tipoCombo, 
			                          String codigo) throws GeneralException {
		
		String result = null;

		if(codigo == null){
			
			return result;
		}
		
		DatosDireccionDTO[] datosDireccion = null;
		
		if(TipoAtributoDireccion.region == tipoCombo){

			RegionBO regionBO = new RegionBO();
			
			RegionDireccionDTO regionDireccionDTO = regionBO.getListadoRegionesDireccion();
			
			datosDireccion = regionDireccionDTO.getDatosDireccionDTO();
			
		}else if(TipoAtributoDireccion.estado == tipoCombo){
			
			EstadoBO estadoBO = new EstadoBO();
			
			EstadoDireccionDTO estadoDTO = estadoBO.getListadoEstados();
			
			datosDireccion = estadoDTO.getDatosDireccionDTO();
		
		}else if(TipoAtributoDireccion.tipoCalle == tipoCombo){
			
			TipoCalleBO tipoCalleBO = new TipoCalleBO();
			
			TipoCalleDireccionDTO tipoCalleDireccionDTO = tipoCalleBO.getListadoTiposCalles();
			
			datosDireccion = tipoCalleDireccionDTO.getDatosDireccionDTO();
		}
		
		if(datosDireccion != null && datosDireccion.length >0){
			
			for (int i = 0; i < datosDireccion.length; i++) {
				DatosDireccionDTO direccionDTO = datosDireccion[i];
				
				if(direccionDTO.getCodigo().equals(codigo)){
					
					result = direccionDTO.getDescripcion();
					
					break;
				}
			}
		}
		
		return result;
	}

	public IdentificadorCivilDTO[] getTiposIdentificacion()throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		IdentificadorCivilDTO[] identificadorCivilDTOs = null;
		try{
			logger.debug("getTiposIdentificacion:Start");
			identificadorCivilDTOs = clienteBO.getTiposIdentificacion();			
		}catch(GeneralException e) {
			logger.debug("getTiposIdentificacion:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		} 		
		return identificadorCivilDTOs;
	}
	public void insertTipificacion (TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		try{			
			logger.debug("insertTipificacion:Start");
			tipificacionBO.insertTipificacion(tipificaClientizaDTO);
			logger.debug("insertTipificacion:end");
		}catch(GeneralException e) {
			logger.debug("insertTipificacion:end");
			logger.debug("GeneralException");
			throw  e;
		} 				
	}

	public TipificaClientizaDTO[] recuperaArrayTipificacion () throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		TipificaClientizaDTO[] tipificaClientizaDTO = null;
		try{
			logger.debug("recuperaArrayTipificacion:start");
			tipificaClientizaDTO= tipificacionBO.recuperaArrayTipificacion();
			logger.debug("recuperaArrayTipificacion:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Fin:recuperaArrayTipificacion()");
			throw new GeneralException(e.getMessage(), e);
		}
		return tipificaClientizaDTO;
	}

	public TipificaClientizaDTO recuperaTipificacion (int codArticulo) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		TipificaClientizaDTO tipificaClientizaDTO = new TipificaClientizaDTO();
		try{
			logger.debug("recuperaTipificacion:start");
			tipificaClientizaDTO= tipificacionBO.recuperaTipificacion(codArticulo);
			logger.debug("recuperaTipificacion:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Fin:recuperaTipificacion()");
			throw new GeneralException(e.getMessage(), e);
		}
		return tipificaClientizaDTO;
	}

	public void updateTipificacion (TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		try{			
			logger.debug("updateTipificacion:Start");
			tipificacionBO.updateTipificacion(tipificaClientizaDTO);
			logger.debug("updateTipificacion:end");
		}catch(GeneralException e) {
			logger.debug("updateTipificacion:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		} 				
	}

	public ClienteDTO[] getListCategorias() throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		ClienteDTO[] resultado = null;
		try{			
			logger.debug("updateTipificacion:Start");
			resultado = clienteBO2.getListCategorias();
			logger.debug("updateTipificacion:end");
		}catch(GeneralException e) {
			logger.debug("updateTipificacion:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		}
		return resultado;
	}

	public PrecioCargoDTO[] getPrecioCargoAccesorio(ArticuloDTO articulo ) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		PrecioCargoDTO[] precioCargoDTOs = null;

		try{			
			logger.debug("updateTipificacion:Start");


			ParametrosCargosAccesoriosDTO parametrosCargoAccesorio = new ParametrosCargosAccesoriosDTO();
			parametrosCargoAccesorio.setCodigoArticulo(String.valueOf(articulo.getCodArticulo()) );
			parametrosCargoAccesorio.setCodigoUso("3");
			parametrosCargoAccesorio.setTipoStock("2");
			parametrosCargoAccesorio.setEstado("1");										
			parametrosCargoAccesorio.setCodigoCategoria("ZZZ");			
			parametrosCargoAccesorio.setIndiceRecambio("9");

			try{
				precioCargoDTOs = ventaAccesoriosBO.getPrecioCargoAccesorio_PrecioLista(parametrosCargoAccesorio);

				if (precioCargoDTOs == null){					
					throw new GeneralException("12362",0,"No se encuentra precio para el Articulo asociado a la Simcard");

				}
			}catch(GeneralException e){					
				throw new GeneralException("12363",0,"No se encuentra precio para el Articulo asociado a la Simcard");
			}

			logger.debug("updateTipificacion:end");
		}catch(GeneralException e) {
			logger.debug("updateTipificacion:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		}
		return precioCargoDTOs;
	}	
	
	
	
	
	
		public DescuentoDTO[] getDescuentoAccesorio(ArticuloDTO articulo ) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		DescuentoDTO[] Descuentos = null;

		try{			
			logger.debug("updateTipificacion:Start");
			
			ParametrosCargosAccesoriosDTO parametrosCargoAccesorio = new ParametrosCargosAccesoriosDTO();
			parametrosCargoAccesorio.setCodigoArticulo(String.valueOf(articulo.getCodArticulo()) );
			parametrosCargoAccesorio.setCodigoUso("3");
			parametrosCargoAccesorio.setTipoStock("2");
			parametrosCargoAccesorio.setEstado("1");										
			parametrosCargoAccesorio.setCodigoCategoria("ZZZ");			
			parametrosCargoAccesorio.setIndiceRecambio("9");

            Descuentos = ventaAccesoriosBO.getDescuentoAccesorio(parametrosCargoAccesorio);
										
			logger.debug("updateTipificacion:end");
		}catch(GeneralException e) {
			logger.debug("updateTipificacion:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		}
		return Descuentos;
	}	

	/*
	 * Metodo: deleteTipificacion
	 * Descripcion: elimina una tipificacion
	 * Fecha: 09/06/2010
	 * Developer: Gabriel Moraga L.
	 */

	public void deleteTipificacion (Long codArticulo) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		try{			
			logger.debug("deleteTipificacion:Start");
			tipificacionBO.deleteTipificacion(codArticulo);
			logger.debug("deleteTipificacion:end");
		}catch(GeneralException e) {
			logger.debug("deleteTipificacion:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		} 				
	}

	/*
	 * Metodo: insertTienda
	 * Descripcion: crea una tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */

	public WsInsertTiendaOutDTO insertTienda(TiendaDTO tiendaMantDTO)throws GeneralException{		
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		WsInsertTiendaOutDTO wsInsertTiendaOutDTO = null;
		try{
			logger.debug("insertTienda:start");
			wsInsertTiendaOutDTO = tiendasBO.insertTienda(tiendaMantDTO);
			logger.debug("insertTienda:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Fin:insertTienda()");
			throw  e;
		}
		return wsInsertTiendaOutDTO;
	}

	/*
	 * Metodo: obtieneListaTienda
	 * Descripcion: Obtiene una lista de tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */

	public TiendaDTO[] obtieneListaTienda()throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));

		List listaTienda = null;
		TiendaDTO[] tiendaDTO = null;

		try{
			logger.debug("obtieneListaTienda:start");

			//Se obtien la lista de tiendas
			listaTienda = tiendasBO.obtieneListaTienda();

			tiendaDTO = new TiendaDTO[listaTienda.size()];

			//Posicion
			int j = 0; 

			for (Iterator iter = listaTienda.iterator(); iter.hasNext();) {
				TiendaDTO tiendaMantTempDTO = (TiendaDTO) iter.next();

				//Se traspasa la data
				tiendaDTO[j] = tiendaMantTempDTO;

				//Se incrementa j
				++j;
			}

			logger.debug("obtieneListaTienda:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Fin:obtieneListaTienda()");
			throw new GeneralException(e.getMessage(), e);
		}
		return tiendaDTO;
	}

	/*
	 * Metodo: updateTienda
	 * Descripcion: Actualiza una tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */

	public WsUpdateTiendaOutDTO  updateTienda(TiendaDTO tiendaModDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		WsUpdateTiendaOutDTO wsUpdateTiendaOutDTO = null;
		try{
			logger.debug("updateTienda:start");
			wsUpdateTiendaOutDTO = tiendasBO.updateTienda(tiendaModDTO);
			logger.debug("updateTienda:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Fin:updateTienda()");
			throw new GeneralException(e.getMessage(), e);
		}

		return wsUpdateTiendaOutDTO;
	}

	/*
	 * Metodo: deleteTienda
	 * Descripcion: elimina una tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */

	public void deleteTienda(Long codTienda)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		try{
			logger.debug("deleteTienda:start");
			tiendasBO.deleteTienda(codTienda);
			logger.debug("deleteTienda:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Fin:deleteTienda()");
			throw new GeneralException(e.getMessage(), e);
		}
	}


	/*---------------------------------------------- Impresion Factura -------------------------------------------*/
	public byte[] getFormFactura(FacturaVO facturaVO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		byte[] pdfAsBytes = null;
		String jasperPath = config.getString("jasper.jasperPath");		
//		String jasperFileName = "Factura.jasper"; CSR-11002
		String jasperFileName = null;
		
		if(facturaVO.getSoloAccesorios().booleanValue()){
			jasperFileName = "FacturaAccesorioQuiosco.jasper";
		}else{
			jasperFileName = "FacturaQuiosco.jasper";
		}
		
		String rutaPDF = new String();

		try {		
			String rutaReporte = System.getProperty("user.dir")+jasperPath + jasperFileName;			

			logger.debug("Ruta Planilla Factura: "+ rutaReporte);

			HashMap params = new HashMap();	
			List detalleFactura = getDetalleFactura(facturaVO);
			JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(detalleFactura);

			if(!facturaVO.getSoloAccesorios().booleanValue()){
				params.put("cliente", facturaVO.getCliente());
				params.put("identificacion", facturaVO.getTipoIdentificacion() + " " + facturaVO.getIdentificacion());
				params.put("direccion", facturaVO.getDireccion());
				params.put("comuna", facturaVO.getComuna());
				params.put("ciudad", facturaVO.getCiudad());
				params.put("region", facturaVO.getRegion());
				params.put("codCliente", facturaVO.getCodCliente());
			}
			
			//params.put("numFactura", facturaVO.getNumFactura());
			params.put("numPago", String.valueOf(facturaVO.getNumPago()));
			params.put("cajero", facturaVO.getCajero());
			params.put("caja", facturaVO.getCaja());
			params.put("subTotal", facturaVO.getSubTotal());
			params.put("iva", facturaVO.getIva());
			params.put("otrosCargos", facturaVO.getOtrosCargos());
			//params.put("cruzRoja", facturaVO.getCruzRoja());
			params.put("total", facturaVO.getTotal());
			//Inicio Inc. 177348 - 06/11/2011 -  FADL 
			params.put("numFactura", String.valueOf(facturaVO.getSerie()));
			params.put("impVenta", String.valueOf(facturaVO.getImpuestoVenta()));
			params.put("imp911", String.valueOf(facturaVO.getNumero911()));
			params.put("impCruzRoja", String.valueOf(facturaVO.getCruzRoja()));
			params.put("descuentos", String.valueOf(facturaVO.getDescuento()));
			//Fin Inc. 177348 - 06/11/2011 -  FADL 
			
		    
//			params.put("numCaja", Integer.toString(facturaVO.getNumCaja()));
//			params.put("numPago",Integer.toString(facturaVO.getNumPago()));
//			params.put("numFactura",facturaVO.getNumFactura());			
//			params.put("cliente", facturaVO.getCliente());
//			params.put("subTotal",facturaVO.getSubTotal()  );
//			params.put("impuestoVenta",facturaVO.getImpuestoVenta());
//			params.put("isc",facturaVO.getISC());
//			params.put("totalVenta",facturaVO.getTotalVenta());
			
			
		
			//Rellenar el informe con datos
			JasperPrint filename = JasperFillManager.fillReport(rutaReporte, params, ds);
			//Exporta el informe a PDF
			pdfAsBytes = JasperExportManager.exportReportToPdf(filename);
//			rutaPDF = System.getProperty("user.dir")+config.getString("ruta_pdf")+facturaVO.getNumFactura()+".pdf";
//			logger.debug("Ruta PDF: "+ rutaPDF);
//			JasperExportManager.exportReportToPdfFile(filename,rutaPDF);
			
			//JasperViewer.viewReport(filename, false);
			
						

		}catch (Exception e) {			
			logger.debug("updateTipificacion:end");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");			
			logger.debug("GeneralException");
			throw new GeneralException(e);			
		}		
		return pdfAsBytes;
	}

	private static List getDetalleFactura(FacturaVO facturaVO)throws GeneralException{		
		List detalleFactura = new ArrayList();

		for (int i=0; i < facturaVO.getDetalleFacturaVO().length; i++){
			DetalleFacturaVO detalleFacturaVO = new DetalleFacturaVO();

			detalleFacturaVO.setDescripArticulo(facturaVO.getDetalleFacturaVO()[i].getDescripArticulo());
			detalleFacturaVO.setNumCantidad(facturaVO.getDetalleFacturaVO()[i].getNumCantidad());
			detalleFacturaVO.setNumCelular(facturaVO.getDetalleFacturaVO()[i].getNumCelular());
			detalleFacturaVO.setPrecioUnitario(facturaVO.getDetalleFacturaVO()[i].getPrecioUnitario());
			detalleFacturaVO.setSerieArticulo(facturaVO.getDetalleFacturaVO()[i].getSerieArticulo());
			detalleFacturaVO.setDescuentoPrecio(facturaVO.getDetalleFacturaVO()[i].getDescuentoPrecio());
			
			detalleFactura.add(detalleFacturaVO);
		}
		return detalleFactura;		
	}	

	/*----------------------------------------------- Aplica Pago ------------------------------------------------*/

	public PagoDTO AplicaPago (PagoDTO pagoDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		PagoDTO pagoDTO2 = new PagoDTO();
		try{
			logger.debug("Inicio:AplicaPago()");
			long numSecuencia = getObtieneSecuencia(config.getString("secuencia.transacabo"));
			logger.debug("NumTransaccionEmp: " + numSecuencia);
			
			pagoDTO.setNumTransaccionEmp(String.valueOf(numSecuencia));
			
			pagoDTO2 = pagoBO.AplicaPago(pagoDTO);
			logger.debug("Fin:AplicaPago()");
		}catch(GeneralException e) {
			logger.debug("AplicaPago:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		}
		return pagoDTO2;
	}
	
	public InfoFacturaDTO getInforCargos(String numVenta, String numProceso) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		InfoFacturaDTO InfoFactura = new InfoFacturaDTO();
		try{
			logger.debug("Inicio:getInforCargos()");
			InfoFactura = BOfacturacion.getInforCargos(numVenta, numProceso);
			
			//INICIO CSR-11002
			logger.debug("inicio obtener detalle presupuesto");
			ImpuestosDTO impuesto = new ImpuestosDTO();
			impuesto.setNumeroProceso(numProceso);
			
			ImpuestosDTO[] impuestos = registroFacturacionBO.getDetallePresupuesto(impuesto);
			
			if(impuestos != null && impuestos.length >0){
				BigDecimal totalCargos = new BigDecimal("0");
				BigDecimal iva = new BigDecimal("0");
				BigDecimal totalAPagar = new BigDecimal("0");
				
				for (int i = 0; i < impuestos.length; i++) {
					ImpuestosDTO impuestoDTO = impuestos[i];
					
					totalCargos = totalCargos.add(new BigDecimal(String.valueOf(impuestoDTO.getTotalCargos())));
					iva = iva.add(new BigDecimal(String.valueOf(impuestoDTO.getTotalImpuestos())));
					totalAPagar = totalAPagar.add(new BigDecimal(String.valueOf(impuestoDTO.getTotal())));
				}
				
				logger.debug("TotalCargos: " + totalCargos.toString());
				InfoFactura.setTotalCargos(totalCargos.toString());
				
				logger.debug("iva: " + iva.toString());
				InfoFactura.setIva(iva.toString());
				
				logger.debug("TotalAPagar: " + totalAPagar.toString());
				InfoFactura.setTotalAPagar(totalAPagar.toString());
				
			}else{
				InfoFactura.setTotalCargos("0");
				InfoFactura.setIva("0");
				InfoFactura.setTotalAPagar("0");
			}
			logger.debug("fin obtener detalle presupuesto");
			//FIN CSR-11002
			
			logger.debug("Fin:getInforCargos()");
		}catch(GeneralException e) {
			logger.debug("getInforCargos:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		}
		return InfoFactura;
	}	
	
	/*------------------------------------------------ Carga de Impuesto -----------------------------------------*/
	
	public float getImpuesto(String codigoVendedor)throws GeneralException{		
		float impuesto = 0;
		try{
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Inicio:getImpuesto()");
			impuesto = ventaAccesoriosBO.getImpuesto(codigoVendedor);
			logger.debug("Fin:getInforCargos()");
		}catch(GeneralException e) {
			logger.debug("getImpuesto:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		}
		return impuesto;
	}
	
	/*------------------------------------------------- Busca ZIP ------------------------------------------------*/
	
	public String getZip(DireccionDTO direccion)throws GeneralException{		
		String zip = null;
		try{
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Inicio:getZip()");
			zip = ventaAccesoriosBO.getZip(direccion);
			logger.debug("Fin:getZip()");
		}catch(GeneralException e) {
			logger.debug("getZip:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		}
		return zip;
	}
	
	/*------------------------------------------------- Listado de Cajas -----------------------------------------*/
	
	public WsCajaOutDTO getListaCaja(String codOficina)throws GeneralException{		
		WsCajaOutDTO cajaOutDTO = null;
		try{
			UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
			logger.debug("Inicio:getListaCaja()");
			cajaOutDTO = tiendasBO.getListaCaja(codOficina);
			logger.debug("Fin:getListaCaja()");
		}catch(GeneralException e) {
			logger.debug("getListaCaja:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		}
		return cajaOutDTO;
	}
	
	public String getNumCelularSeriePrepago(String numSerie, String numVenta) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		String NumCelular = null;
		try{
			logger.debug("Inicio:getNumCelularSeriePrepago()");
			NumCelular = ventaAccesoriosBO.getNumCelularSeriePrepago(numSerie, numVenta);
			logger.debug("Fin:getNumCelularSeriePrepago()");
		}catch(GeneralException e) {
			logger.debug("getNumCelularSeriePrepago:end");
			logger.debug("GeneralException");
			throw new GeneralException(e.getMessage(), e);
		}
		return NumCelular;
	}	
	
	
	public WSCentralQuioscoOutDTO getCentralesQuiosco()
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		logger.debug("Inicio:getNumCelularSeriePrepago()");	
		WSCentralQuioscoOutDTO resultado = null;
		resultado =   ventaAccesoriosBO.getCentralesQuiosco();
		logger.debug("Fin:getNumCelularSeriePrepago()");
		return resultado;
	}
	
	public void insertQuioscoVenta(GaVentasDTO gaVentas) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		logger.debug("++++++++++++++++++++++++++++++++++ Start : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++");		
		BORegistroVenta.insertQuioscoVenta(gaVentas);
		logger.debug("++++++++++++++++++++++++++++++++++ End : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++");
	}
	
	public void insertReservArticulo(WsVentaAccesoriosOutDTO ventaAccesorio)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeVentaAccesoriosSRV.log"));
		logger.debug("Inicio:insertReservArticulo()");	
		ventaAccesoriosBO.insertReservArticulo(ventaAccesorio);
		logger.debug("Fin:insertReservArticulo()");
	}	
	
		
	
}
