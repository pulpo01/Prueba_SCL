package com.tmmas.cl.scl.integracionsicsa.ws;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.jws.*;

import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.EntradaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaIntegracionSICSADTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.helper.IntegracionSICSAServiceLocator;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.sender.SenderTraspaso;

@WebService
public class TraspasoSeriesWS {
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	SenderTraspaso senderTraspaso;
	private IntegracionSICSAServiceLocator integracionSICSAServiceLocator;
	private IntegracionSICSALocal integracionSICSALocal;

	@WebMethod
	public SalidaIntegracionSICSADTO traspasoSeries(EntradaTraspasoDTO traspasoDTO) {
		logger.debug("traspasoSeriesWS: Inicio",nombreClase);
		SalidaIntegracionSICSADTO respuesta;
		try{
			//Valida Traspaso antes de insertarlo en la tabla temporal
			validaSeriesTraspaso(traspasoDTO);
			validaTraspaso(traspasoDTO);
			insertaEstadoTraspaso(traspasoDTO);
        	String numOperacion = "1";//integracionSICSALocal.registrarVentaCeltics(inDTO); consultar Sequencia        	
        	senderTraspaso = new SenderTraspaso();
        	senderTraspaso.send(traspasoDTO,numOperacion,new Integer(global.getValor("GE.registrarTraspaso")));
        	respuesta = new SalidaIntegracionSICSADTO();
        	respuesta.setStrDesError("Su solicitud ha quedado encolada exitosamente");
        	
		}catch(IntegracionSICSAException e) {
            logger.debug("IntegracionSICSAExceptionWS: " + e.getDescripcionEvento(), nombreClase);
            respuesta = new SalidaIntegracionSICSADTO();
            respuesta.setStrCodError(e.getCodigo());
            respuesta.setStrDesError(e.getDescripcionEvento());
            respuesta.setIEvento(e.getCodigoEvento());
		}catch(Exception e){
			logger.debug("ERROR: ", nombreClase);
            logger.debug("Exception: " + e.getLocalizedMessage(), nombreClase);
            logger.debug("Exception: " + e, nombreClase);
            respuesta = new SalidaIntegracionSICSADTO();
            respuesta.setStrCodError("ERR.0001");
            respuesta.setStrDesError(global.getValor("ERR.0001"));
            respuesta.setIEvento(0);
		}
		logger.debug("traspasoSeriesWS: Inicio",nombreClase);
		return respuesta;
	}
	
	private void validaTraspaso(EntradaTraspasoDTO traspasoDTO) throws IntegracionSICSAException{
		logger.debug("validaTraspaso: Inicio",nombreClase);
		integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
		integracionSICSALocal = integracionSICSAServiceLocator.getIntegracionSICSALocal();
		integracionSICSALocal.validaTraspaso(traspasoDTO, global.getValor("AL.estadoPendienteAutorizado"));
		logger.debug("validaTraspaso: Fin",nombreClase);		
	}
	
	private void insertaEstadoTraspaso(EntradaTraspasoDTO traspasoDTO) throws IntegracionSICSAException{
		logger.debug("insertaEstadoTraspaso: Inicio",nombreClase);
		integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
		integracionSICSALocal = integracionSICSAServiceLocator.getIntegracionSICSALocal();
		integracionSICSALocal.insertaEstadoTraspaso(traspasoDTO.getNumTraspaso(), global.getValor("AL.estadoEncolado"));
		logger.debug("insertaEstadoTraspaso: Fin",nombreClase);		
	}
	
	private void validaSeriesTraspaso(EntradaTraspasoDTO traspasoDTO) throws IntegracionSICSAException {
    	logger.debug("Inicio: validaSeriesTraspaso()", nombreClase);
		if (null == traspasoDTO.getSerieTraspasoDTOs()|| 0 == traspasoDTO.getSerieTraspasoDTOs().length) {
			throw new IntegracionSICSAException("ERROR FORMATO", 1,	"No vienen Series informadas.");
		}
		
		Set series = new HashSet(); // creo este objeto para validar duplicados
		StringBuffer mensajeError = new StringBuffer("");
		
		for (int i = 0; i <= traspasoDTO.getSerieTraspasoDTOs().length - 1; i++) {
			validarTipoSerie(traspasoDTO.getSerieTraspasoDTOs()[i].getLinTraspaso(), "linTraspaso", false, true);
			validarLargoSerie(traspasoDTO.getSerieTraspasoDTOs()[i].getLinTraspaso(), "linTraspaso", new Integer(1), new Integer(2));
			validarTipoSerie(traspasoDTO.getSerieTraspasoDTOs()[i].getNumSerie(), "numSerie", false, false);
			validarLargoSerie(traspasoDTO.getSerieTraspasoDTOs()[i].getNumSerie(), "numSerie", new Integer(1), new Integer(25));			
				
			// Valido serie duplicada en la misma linea de pedido
			if (!series.add(traspasoDTO.getSerieTraspasoDTOs()[i].getLinTraspaso() + traspasoDTO.getSerieTraspasoDTOs()[i].getNumSerie())) {
				mensajeError.append("Serie duplicada : "	+ traspasoDTO.getSerieTraspasoDTOs()[i].getNumSerie()
						+ " en la linea de proceso "+ traspasoDTO.getSerieTraspasoDTOs()[i].getLinTraspaso());
			}
		}
		
		if (!"".equals(mensajeError.toString())) {
			logger.debug("Ingresa al error", nombreClase);
			logger.debug(mensajeError.toString(), nombreClase);
			throw new IntegracionSICSAException("ERROR SERIES", 1, mensajeError.toString());
		}
		
		logger.debug("Fin: validaSeriesTraspaso()", nombreClase);
	}
	
	public static void validarTipoSerie(Object object, String strObjecName, boolean bNullable, boolean bIsNumeric) throws IntegracionSICSAException {

        if (!bNullable) {
            if (null == object) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "Existen series con el campo " + strObjecName+" nulo");
            }

            if ("".equals(object.toString())) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "Existen series con el campo " + strObjecName+" vacio");
            }
        }
        if (null != object && bIsNumeric) {
            try {
                Double.parseDouble(object.toString());
            } catch (Exception nfe) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "No todos los campos " + strObjecName+" de las series son númericos");
            }
        }
    }
	
	public static void validarLargoSerie(Object object, String strObjecName, Integer intMin, Integer intMax) throws IntegracionSICSAException {
        String value;
        if (object != null) {
            if (object instanceof Double) {
                value = String.valueOf(new BigDecimal(((Double) object).doubleValue()));
            } else {
                value = String.valueOf(object);
            }
            if (intMin != null) {
                if (value.length() < intMin.intValue()) {
                    throw new IntegracionSICSAException("ERROR FORMATO", 1, "No todos los campos " + strObjecName+" de las series tienen el tamaño minimo permitido");
                }
            }
            if (intMax != null) {
                if (value.length() > intMax.intValue()) {
                    throw new IntegracionSICSAException("ERROR FORMATO", 1, "No todos los campos " + strObjecName+" de las series tienen el tamaño maximo permitido");
                }
            }
        }
    }
}