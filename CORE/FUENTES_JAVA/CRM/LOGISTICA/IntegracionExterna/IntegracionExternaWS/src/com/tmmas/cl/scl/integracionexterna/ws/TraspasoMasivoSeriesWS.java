package com.tmmas.cl.scl.integracionexterna.ws;

import javax.jws.*;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaIntegracionExternaDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.TraspasoMasivoInDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionexterna.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionexterna.helper.IntegracionExternaServiceLocator;
import com.tmmas.cl.scl.integracionexterna.negocio.session.IntegracionExternaLocal;
import com.tmmas.cl.scl.integracionexterna.sender.Sender;

@WebService
public class TraspasoMasivoSeriesWS {
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	Sender sender;
	private IntegracionExternaServiceLocator externaServiceLocator;
	private IntegracionExternaLocal externaLocal;

	@WebMethod
	public SalidaIntegracionExternaDTO traspasoMasivoSeries(TraspasoMasivoInDTO traspasoMasivoInDTO ){
		logger.debug("traspasoMasivoSeries: Inicio",nombreClase);
		SalidaIntegracionExternaDTO respuesta;
		String codError = null;
		int numEvento = -1;
		String msgError = null;
		String valParam = null;
		try{
			
			String numOperacion = "1";        	
			sender = new Sender();
			
			if(traspasoMasivoInDTO.getTipOperacion().equals("0")){
				logger.debug("TraspasoMasivo", nombreClase);
				logger.debug("Valida los parametros de entrada", nombreClase);
				validaSeriesTraspaso(traspasoMasivoInDTO);
				
				logger.debug("Valida que la bodega origen y destino no sean la misma", nombreClase);
				if(traspasoMasivoInDTO.getCodBodegaDestino().equals(traspasoMasivoInDTO.getCodBodegaOrigen())){
					codError = "ERR.0009";
					numEvento = -1;
					msgError = global.getValor("ERR.0009");
					throw new IntegracionExternaException(codError,numEvento,msgError);				
				}
				
				logger.debug("Valida que bodega origen pertenesca al distribuidor", nombreClase);
				if(!validaBodegaDTS(traspasoMasivoInDTO.getCodCliente(), traspasoMasivoInDTO.getCodBodegaOrigen())){
					codError = "ERR.0007";
					numEvento = -1;
					msgError = global.getValor("ERR.0007");
					throw new IntegracionExternaException(codError,numEvento,msgError);				
				}
				
				logger.debug("Valida que bodega destino pertenesca al distribuidor", nombreClase);
				if(!validaBodegaDTS(traspasoMasivoInDTO.getCodCliente(), traspasoMasivoInDTO.getCodBodegaDestino())){
					codError = "ERR.0008";
					numEvento = -1;
					msgError = global.getValor("ERR.0008");
					throw new IntegracionExternaException(codError,numEvento,msgError);				
				}
				
				logger.debug("Inserta Registro que indica que el traspaso se encuentra encolado", nombreClase);
				if(validaTraspOP(traspasoMasivoInDTO.getNumSecuencia())){
					insertaTraspasoOP(traspasoMasivoInDTO.getNumSecuencia());
				}else{
					SalidaConsultaTraspasoDTO outDTO = null;
					externaLocal = externaServiceLocator.getIntegracionExternaLocal();
					outDTO = externaLocal.consultaEstadoTraspOP(traspasoMasivoInDTO.getNumSecuencia());
					externaLocal.eliminaTraspasoMasivo(outDTO.getNumTraspasoMasivo());
					
					actualizaTraspasoOP(traspasoMasivoInDTO.getNumSecuencia());
				}				
			}else{
				logger.debug("Insercion de Movimientos", nombreClase);
				logger.debug("Valida los parametros de entrada", nombreClase);
				validaSeriesMovimiento(traspasoMasivoInDTO);
				
				logger.debug("Se obtiene parametro que indica si se valida la bodega del distribuidor para Insercion de movimiento", nombreClase);
				valParam = consultaParametros(global.getValor("AL.valMovDTS"),global.getValor("AL.codModulo"),global.getValor("AL.codProducto"));
				
				if(valParam.equals("TRUE")){
					logger.debug("Valida que bodega origen pertenesca al distribuidor", nombreClase);
					if(!validaBodegaDTS(traspasoMasivoInDTO.getCodCliente(), traspasoMasivoInDTO.getCodBodegaOrigen())){
						codError = "ERR.0007";
						numEvento = -1;
						msgError = global.getValor("ERR.0007");
						throw new IntegracionExternaException(codError,numEvento,msgError);				
					}
				}
				
				logger.debug("Inserta Registro que indica que el traspaso se encuentra encolado", nombreClase);
				if(validaTraspOP(traspasoMasivoInDTO.getNumSecuencia())){
					insertaTraspasoOP(traspasoMasivoInDTO.getNumSecuencia());
				}else{
					SalidaConsultaTraspasoDTO outDTO = null;
					externaLocal = externaServiceLocator.getIntegracionExternaLocal();
					outDTO = externaLocal.consultaEstadoTraspOP(traspasoMasivoInDTO.getNumSecuencia());					
					actualizaTraspasoOP(traspasoMasivoInDTO.getNumSecuencia());
				}					
			}				
			
			logger.debug("Deja traspaso masivo encolada", nombreClase);
			sender.send(traspasoMasivoInDTO,numOperacion,new Integer(traspasoMasivoInDTO.getTipOperacion()));
        	respuesta = new SalidaIntegracionExternaDTO();
        	logger.debug("Traspaso masivo quedo encolado exitosamente", nombreClase);
        	respuesta.setStrDesError("Su solicitud ha quedado encolada exitosamente");
        	
		}catch(IntegracionExternaException e) {
           logger.debug("IntegracionExternaException: " + e.getDescripcionEvento(), nombreClase);
            respuesta = new SalidaIntegracionExternaDTO();
            respuesta.setStrCodError(e.getCodigo());
            respuesta.setStrDesError(e.getDescripcionEvento());
            respuesta.setIEvento(e.getCodigoEvento());
		}catch(Exception e){
			logger.debug("ERROR: ", nombreClase);
            logger.debug("Exception: " + e.getLocalizedMessage(), nombreClase);
            logger.debug("Exception: " + e, nombreClase);
            respuesta = new SalidaIntegracionExternaDTO();
            respuesta.setStrCodError("ERR.0001");
            respuesta.setStrDesError(global.getValor("ERR.0001"));
            respuesta.setIEvento(0);
		}
		logger.debug("traspasoMasivoSeries: fin",nombreClase);
		return respuesta;
	}
	
	private void validaSeriesTraspaso(TraspasoMasivoInDTO traspasoDTO) throws IntegracionExternaException{
    	logger.debug("Inicio: validaSeriesTraspaso()", nombreClase);
		if (null == traspasoDTO.getSerieTraspasoMasivoDTO()|| 0 == traspasoDTO.getSerieTraspasoMasivoDTO().length) {
			throw new IntegracionExternaException("ERROR FORMATO", 1,	"No vienen Series informadas.");
		}
		
		Set series = new HashSet(); // creo este objeto para validar duplicados
		StringBuffer mensajeError = new StringBuffer("");
		
		logger.debug("Valida Codigo CLiente ", nombreClase);
		validarTipo(traspasoDTO.getCodCliente(), "codCliente", false, true);
		validarLargo(traspasoDTO.getCodBodegaOrigen(), "codCliente", new Integer(1), new Integer(8));
		
		logger.debug("Valida Numero de Secuencia", nombreClase);
		validarTipo(traspasoDTO.getNumSecuencia(), "numSecuencia", false, true);
		
		logger.debug("Valida Tipo Operacion", nombreClase);
		validarTipo(traspasoDTO.getTipOperacion(), "tipOperacion", false, true);
		
		logger.debug("Valida Codigo Bodega Origen", nombreClase);
		validarTipo(traspasoDTO.getCodBodegaOrigen(), "codBodegaOrigen", false, true);
		validarLargo(traspasoDTO.getCodBodegaOrigen(), "codBodegaOrigen", new Integer(1), new Integer(6));
		
		logger.debug("Valida Codigo Bodega Destino", nombreClase);
		validarTipo(traspasoDTO.getCodBodegaDestino(), "codBodegaDestino", false, true);
		validarLargo(traspasoDTO.getCodBodegaDestino(), "codBodegaDestino", new Integer(1), new Integer(6));		
		
		for (int i = 0; i <= traspasoDTO.getSerieTraspasoMasivoDTO().length - 1; i++) {			
			logger.debug("Valida Codigo Articulo", nombreClase);
			validarTipo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodArticulo(), "codArticulo", false, true);
			validarLargo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodArticulo(), "codArticulo", new Integer(1), new Integer(6));
			
			logger.debug("Valida Codigo Estado", nombreClase);
			validarTipo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodEstado(), "codEstado", true, true);
			validarLargo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodEstado(), "codEstado", new Integer(0), new Integer(2));
			
			logger.debug("Valida Codigo Uso", nombreClase);
			validarTipo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodUso(), "codUso", true, true);
			validarLargo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodUso(), "codUso", new Integer(0), new Integer(2));
			
			logger.debug("Valida Tipo Stock", nombreClase);
			validarTipo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getTipStock(), "tipStock", true, true);
			validarLargo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getTipStock(), "tipStock", new Integer(0), new Integer(2));
			
			logger.debug("Valida Numero de serie", nombreClase);
			validarTipoSerie(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getNumSerie(), "numSerie", false, false);
			validarLargoSerie(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getNumSerie(), "numSerie", new Integer(1), new Integer(25));	
			
			if (!series.add(String.valueOf(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getNumSerie()))){
				// Valido Serie duplicada
			    throw new IntegracionExternaException("ERROR FORMATO", 1, "Numero de Serie duplicada : " + traspasoDTO.getSerieTraspasoMasivoDTO()[i].getNumSerie());
			}
		}
		
		if (!"".equals(mensajeError.toString())) {
			logger.debug("Ingresa al error", nombreClase);
			logger.debug(mensajeError.toString(), nombreClase);
			throw new IntegracionExternaException("ERROR SERIES", 1, mensajeError.toString());
		}
		
		logger.debug("Fin: validaSeriesTraspaso()", nombreClase);
	}
	
	private void validaSeriesMovimiento(TraspasoMasivoInDTO traspasoDTO) throws IntegracionExternaException{
    	logger.debug("Inicio: validaSeriesMovimiento()", nombreClase);
		if (null == traspasoDTO.getSerieTraspasoMasivoDTO()|| 0 == traspasoDTO.getSerieTraspasoMasivoDTO().length) {
			throw new IntegracionExternaException("ERROR FORMATO", 1,	"No vienen Series informadas.");
		}
		
		Set series = new HashSet(); // creo este objeto para validar duplicados
		StringBuffer mensajeError = new StringBuffer("");
		
		logger.debug("Valida Codigo CLiente ", nombreClase);
		validarTipo(traspasoDTO.getCodCliente(), "codCliente", false, true);
		validarLargo(traspasoDTO.getCodBodegaOrigen(), "codCliente", new Integer(1), new Integer(8));
		
		logger.debug("Valida Numero de Secuencia", nombreClase);
		validarTipo(traspasoDTO.getNumSecuencia(), "numSecuencia", false, true);
		
		logger.debug("Valida Tipo Operacion", nombreClase);
		validarTipo(traspasoDTO.getTipOperacion(), "tipOperacion", false, true);
		
		logger.debug("Valida Codigo Bodega Origen", nombreClase);
		validarTipo(traspasoDTO.getCodBodegaOrigen(), "codBodegaOrigen", false, true);
		validarLargo(traspasoDTO.getCodBodegaOrigen(), "codBodegaOrigen", new Integer(1), new Integer(6));
		
		for (int i = 0; i <= traspasoDTO.getSerieTraspasoMasivoDTO().length - 1; i++) {			
			logger.debug("Valida Codigo Articulo", nombreClase);
			validarTipo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodArticulo(), "codArticulo", false, true);
			validarLargo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodArticulo(), "codArticulo", new Integer(1), new Integer(6));
			
			logger.debug("Valida Codigo Estado", nombreClase);
			validarTipo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodEstado(), "codEstado", true, true);
			validarLargo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodEstado(), "codEstado", new Integer(0), new Integer(2));
			
			logger.debug("Valida Codigo Uso", nombreClase);
			validarTipo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodUso(), "codUso", true, true);
			validarLargo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getCodUso(), "codUso", new Integer(0), new Integer(2));
			
			logger.debug("Valida Tipo Stock", nombreClase);
			validarTipo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getTipStock(), "tipStock", true, true);
			validarLargo(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getTipStock(), "tipStock", new Integer(0), new Integer(2));
			
			logger.debug("Valida Numero de serie", nombreClase);
			validarTipoSerie(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getNumSerie(), "numSerie", false, false);
			validarLargoSerie(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getNumSerie(), "numSerie", new Integer(1), new Integer(25));	
			
			if (!series.add(String.valueOf(traspasoDTO.getSerieTraspasoMasivoDTO()[i].getNumSerie()))){
				// Valido Serie duplicada
			    throw new IntegracionExternaException("ERROR FORMATO", 1, "Numero de Serie duplicada : " + traspasoDTO.getSerieTraspasoMasivoDTO()[i].getNumSerie());
			}
		}		
		if (!"".equals(mensajeError.toString())) {
			logger.debug("Ingresa al error", nombreClase);
			logger.debug(mensajeError.toString(), nombreClase);
			throw new IntegracionExternaException("ERROR SERIES", 1, mensajeError.toString());
		}		
		logger.debug("Fin: validaSeriesTraspaso()", nombreClase);
	}
	
	public static void validarTipo(Object object, String strObjecName, boolean bNullable, boolean bIsNumeric) throws IntegracionExternaException {

        if (!bNullable) {
        	System.out.println("no es nulo "+ strObjecName + "{"+object.toString()+ "}");
            if (null == object) {
                throw new IntegracionExternaException("ERROR FORMATO", 1, "El valor del campo no debe ser nulo : " + strObjecName);
            }

            if (object.toString().trim().equals("")) {
            	System.out.println("Entro 2");	
                throw new IntegracionExternaException("ERROR FORMATO", 1, "El valor del campo no debe ser vacio : " + strObjecName);
            }
        }
        
        if (null != object && bIsNumeric && !object.toString().trim().equals("")) {
            try {
                Double.parseDouble(object.toString());
            } catch (Exception nfe) {
                throw new IntegracionExternaException("ERROR FORMATO", 1, "El valor del campo debe ser numérico : " + strObjecName);
            }
        }
    }
    
    public static void validarLargo(Object object, String strObjecName, Integer intMin, Integer intMax) throws IntegracionExternaException{
        String value;
        if (object != null) {
            if (object instanceof Double) {
                value = String.valueOf(new BigDecimal(((Double) object).doubleValue()));
            } else {
                value = String.valueOf(object);
            }
            if (intMin != null) {
                if (value.length() < intMin.intValue()) {
                    throw new IntegracionExternaException("ERROR FORMATO", 1, "El largo del campo es menor a lo permitido : " + strObjecName);
                }
            }
            if (intMax != null) {
                if (value.length() > intMax.intValue()) {
                    throw new IntegracionExternaException("ERROR FORMATO", 1, "El largo del campo es mayor a lo permitido : " + strObjecName);
                }
            }
        }
    }
	
	public static void validarTipoSerie(Object object, String strObjecName, boolean bNullable, boolean bIsNumeric) throws IntegracionExternaException{
        if (!bNullable) {
            if (null == object) {
                throw new IntegracionExternaException("ERROR FORMATO", 1, "Existen series con el campo " + strObjecName+" nulo");
            }
            if ("".equals(object.toString())) {
                throw new IntegracionExternaException("ERROR FORMATO", 1, "Existen series con el campo " + strObjecName+" vacio");
            }
        }
        if (null != object && bIsNumeric) {
            try {
                Double.parseDouble(object.toString());
            } catch (Exception nfe) {
                throw new IntegracionExternaException("ERROR FORMATO", 1, "No todos los campos " + strObjecName+" de las series son númericos");
            }
        }
    }
	
	public static void validarLargoSerie(Object object, String strObjecName, Integer intMin, Integer intMax) throws IntegracionExternaException{
        String value;
        if (object != null) {
            if (object instanceof Double) {
                value = String.valueOf(new BigDecimal(((Double) object).doubleValue()));
            } else {
                value = String.valueOf(object);
            }
            if (intMin != null) {
                if (value.length() < intMin.intValue()) {
                    throw new IntegracionExternaException("ERROR FORMATO", 1, "No todos los campos " + strObjecName+" de las series tienen el tamaño minimo permitido");
                }
            }
            if (intMax != null) {
                if (value.length() > intMax.intValue()) {
                    throw new IntegracionExternaException("ERROR FORMATO", 1, "No todos los campos " + strObjecName+" de las series tienen el tamaño maximo permitido");
                }
            }
        }
    }
	
	private void insertaTraspasoOP(String numSecuencia) throws IntegracionExternaException, Exception{
		logger.debug("insertaTraspasoOP: Inicio",nombreClase);
		externaServiceLocator = new IntegracionExternaServiceLocator();
		externaLocal = externaServiceLocator.getIntegracionExternaLocal();
		externaLocal.insertaTraspasoOP(new String ("1"), new String (numSecuencia), new String(global.getValor("AL.estadoEncolado")));
		logger.debug("insertaTraspasoOP: Fin",nombreClase);		
	}
	
	private void actualizaTraspasoOP(String numSecuencia) throws IntegracionExternaException, Exception{
		logger.debug("actualizaTraspasoOP: Inicio",nombreClase);
		externaServiceLocator = new IntegracionExternaServiceLocator();
		externaLocal = externaServiceLocator.getIntegracionExternaLocal();
		externaLocal.actualizaTraspasoOP(new String ("1"), new String (numSecuencia), new String(global.getValor("AL.estadoEncolado")));
		logger.debug("actualizaTraspasoOP: Fin",nombreClase);		
	}
	
	private boolean validaTraspOP(String numSecuencia) throws IntegracionExternaException, Exception{
		logger.debug("validaTraspOP: Inicio",nombreClase);
		boolean resultado = false;
		externaServiceLocator = new IntegracionExternaServiceLocator();
		externaLocal = externaServiceLocator.getIntegracionExternaLocal();
		resultado = externaLocal.validaTraspOP(new String (numSecuencia));
		logger.debug("validaTraspOP: Fin",nombreClase);		
		return resultado;
	}
	
	private boolean validaBodegaDTS(String codCliente, String codBodega) throws IntegracionExternaException, Exception{
		logger.debug("validaBodegaDTS: Inicio",nombreClase);
		boolean resultado = false;
		externaServiceLocator = new IntegracionExternaServiceLocator();
		externaLocal = externaServiceLocator.getIntegracionExternaLocal();
		resultado = externaLocal.validaBodegaDTS(codCliente, codBodega);
		logger.debug("validaBodegaDTS: Fin",nombreClase);		
		return resultado;
	}
	
	private String consultaParametros(String nomParametro, String codModulo, String codProducto) throws IntegracionExternaException, Exception{
		logger.debug("consultaParametros: Inicio",nombreClase);
		String resultado = null;
		externaServiceLocator = new IntegracionExternaServiceLocator();
		externaLocal = externaServiceLocator.getIntegracionExternaLocal();
		resultado = externaLocal.consultaParametros(nomParametro, codModulo, codProducto);
		logger.debug("consultaParametros: Fin",nombreClase);		
		return resultado;
	}
}