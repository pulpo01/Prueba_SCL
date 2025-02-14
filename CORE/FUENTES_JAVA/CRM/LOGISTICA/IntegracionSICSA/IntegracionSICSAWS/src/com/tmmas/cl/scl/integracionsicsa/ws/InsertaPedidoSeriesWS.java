package com.tmmas.cl.scl.integracionsicsa.ws;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.jws.WebMethod;
import javax.jws.WebService;

import com.tmmas.cl.scl.integracionsicsa.common.dto.PedidoEncabezadoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.PedidoInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaIntegracionSICSADTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.helper.IntegracionSICSAServiceLocator;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.sender.SenderPedido;

@WebService
public class InsertaPedidoSeriesWS {
	
	private final LoggerHelper logger = LoggerHelper.getInstance();
    private final String nombreClase = this.getClass().getName();
    private GlobalProperties global = GlobalProperties.getInstance();
    SenderPedido senderPedido;
    private IntegracionSICSAServiceLocator integracionSICSAServiceLocator;
	private IntegracionSICSALocal integracionSICSALocal;
    /**
     * Ingresa Listado Pedido Series
     */
    @WebMethod
    public SalidaIntegracionSICSADTO registraSeries(PedidoInDTO pedidoInDTO) {

        logger.debug("registraSeries: Inicio ", nombreClase);
        SalidaIntegracionSICSADTO respuesta;
        integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
        try {
        	//Se realizan Validaciones Basicas al Pedido antes de Dejar Encolado
        	//Se valida que no venga NULO
        	if(pedidoInDTO == null){
        		throw new IntegracionSICSAException("ERROR FORMATO", -1, global.getValor("ERR.0016"));        		
        	}        	
        	validaCabeceraPedido(pedidoInDTO.getPedidoEncabezadoDTO());    
        	validaSeriesPedido(pedidoInDTO);
        	
        	logger.debug("Llama WS integracionSICSALocal.registraSeries(pedidoInDTO)",nombreClase);
        	logger.debug("codigoPedido: " + pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido(),nombreClase);
        	logger.debug("cantidadLineas: " + pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs().length,nombreClase);
        	
        	//HOM Se invocan validaciones del pedido sincronas
        	integracionSICSALocal = integracionSICSAServiceLocator
			.getIntegracionSICSALocal();
        	
        	integracionSICSALocal.validaPedido(pedidoInDTO);
        	
        	String numOperacion = "1";//integracionSICSALocal.registrarVentaCeltics(inDTO); consultar Sequencia        	
        	senderPedido = new SenderPedido();
        	senderPedido.send(pedidoInDTO,numOperacion,new Integer(global.getValor("GE.registrarPedidoSeries")));
        	respuesta = new SalidaIntegracionSICSADTO();
        	respuesta.setStrDesError("Su solicitud ha quedado encolada exitosamente");

        } catch (IntegracionSICSAException e) {
            logger.debug("IntegracionSICSAExceptionWS: " + e.getDescripcionEvento(), nombreClase);
            logger.error(e, nombreClase);
            respuesta = new SalidaIntegracionSICSADTO();
            respuesta.setStrCodError(e.getCodigo());
            respuesta.setStrDesError(e.getDescripcionEvento());
            respuesta.setIEvento(e.getCodigoEvento());

        } catch (Exception e) {
            logger.debug("ERROR: ", nombreClase);
            logger.debug("Exception: " + e.getLocalizedMessage(), nombreClase);
            logger.debug("Exception: " + e, nombreClase);
            respuesta = new SalidaIntegracionSICSADTO();
            respuesta.setStrCodError("ERR.0001");
            respuesta.setStrDesError(global.getValor("ERR.0001"));
            respuesta.setIEvento(0);
        }
        logger.debug("registraSeries: Fin ", nombreClase);
        return respuesta;
    }
    
    private void validaCabeceraPedido(PedidoEncabezadoDTO encabezadoDTO) throws IntegracionSICSAException {
    	logger.debug("Inicio: validaCabeceraPedido()", nombreClase);		
    	
    	if (null == encabezadoDTO) {
			throw new IntegracionSICSAException("ERROR FORMATO", 1,	"La cabecera del Pedido viene nula.");
		} else if (null == encabezadoDTO.getPedidoLineasDTOs() || 0 == encabezadoDTO.getPedidoLineasDTOs().length) {
			throw new IntegracionSICSAException("ERROR FORMATO", 1,	"No se informaron lineas de Pedido");
		}
		
		//Valida Datos de la Cabecera del Pedido
		validarTipo(encabezadoDTO.getCodPedido(), "codPedido", false, true);
		validarLargo(encabezadoDTO.getCodPedido(), "codPedido", new Integer(1), new Integer(12));
		
		validarTipo(encabezadoDTO.getTotalPedido(), "totalPedido", false, true);
		validarLargo(encabezadoDTO.getCodPedido(), "totalPedido", new Integer(1), new Integer(8));
		
		Set s = new HashSet(); // Se crea objeto para validar duplicados
		
		//Valida Lineas de la Cabecera del Pedido
		for (int i = 0; i <= encabezadoDTO.getPedidoLineasDTOs().length - 1; i++) {	
			validarNumero(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getCanDetallePedido()), "CanDetallePedido", false);
			validarLargo(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getCanDetallePedido()), "CanDetallePedido", new Integer(1), new Integer(6));
			
			validarNumero(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getCodArticulo()), "CodArticulo", false);
			validarLargo(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getCodArticulo()), "CodArticulo", new Integer(1), new Integer(6));
			
			validarNumero(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getLinPedido()), "LinPedido", false);
			validarLargo(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getLinPedido()), "LinPedido", new Integer(1), new Integer(2));
						
			if (!s.add(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getLinPedido()))){
				// Valido linPedido duplicada
			    throw new IntegracionSICSAException("ERROR FORMATO", 1, "linPedido duplicado : " + encabezadoDTO.getPedidoLineasDTOs()[i].getLinPedido());
			}
		}	
		logger.debug("Fin: validaCabeceraPedido()", nombreClase);
	}
    
    private void validaSeriesPedido(PedidoInDTO pedidoInDTO) throws IntegracionSICSAException {
    	logger.debug("Inicio: validaSeriesPedido()", nombreClase);
		if (null == pedidoInDTO.getSeriePedidoDTOs() || 0 == pedidoInDTO.getSeriePedidoDTOs().length) {
			throw new IntegracionSICSAException("ERROR FORMATO", 1,	"No vienen Series informadas.");
		}
		
		Set series = new HashSet(); // creo este objeto para validar duplicados
		StringBuffer mensajeError = new StringBuffer("");
		Set lineasProcesosDetalles = new HashSet();
		
		for (int i = 0; i <= pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs().length - 1; i++) {
			if (lineasProcesosDetalles.add(String.valueOf(pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getLinPedido()))) {								
			}
		}
		for (int i = 0; i <= pedidoInDTO.getSeriePedidoDTOs().length - 1; i++) {
			validarTipoSerie(pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido(), "linPedido", false, true);
			validarLargoSerie(pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido(), "linPedido", new Integer(1), new Integer(2));
			validarTipoSerie(pedidoInDTO.getSeriePedidoDTOs()[i].getNumSerie(), "numSerie", false, false);
			validarLargoSerie(pedidoInDTO.getSeriePedidoDTOs()[i].getNumSerie(), "numSerie", new Integer(1), new Integer(25));			
				
			// Valido serie duplicada en la misma linea de pedido
			if (!series.add(pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido() + pedidoInDTO.getSeriePedidoDTOs()[i].getNumSerie())) {
				mensajeError.append("Serie duplicada : "	+ pedidoInDTO.getSeriePedidoDTOs()[i].getNumSerie()
						+ " en la linea de proceso "+ pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido());
			}
			
			//Valida que Serie contenga linea pedido existente
			if (!lineasProcesosDetalles.contains(pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido())) {
				mensajeError.append("Serie  " + pedidoInDTO.getSeriePedidoDTOs()[i].getNumSerie()
						+ " contiene la linea de proceso "+ pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido()
						+ ", la cual no existe en el detalle;");
			}
		}
		
		if (!"".equals(mensajeError.toString())) {
			logger.debug("Ingresa al error", nombreClase);
			logger.debug(mensajeError.toString(), nombreClase);
			throw new IntegracionSICSAException("ERROR SERIES", 1, mensajeError.toString());
		}
		
		logger.debug("Fin: validaSeriesPedido()", nombreClase);
	}
    
    public static void validarNumero(Object object, String strObjecName, boolean bNullable) throws IntegracionSICSAException {

        if (!bNullable) {
            if (null == object) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo no debe ser nulo : " + strObjecName);
            }
            if (Long.valueOf(object.toString()) == 0) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo no debe ser igual a 0 : " + strObjecName);
            }
        }
    }
    
    public static void validarTipo(Object object, String strObjecName, boolean bNullable, boolean bIsNumeric) throws IntegracionSICSAException {

        if (!bNullable) {
        	System.out.println("no es nulo "+ strObjecName + "{"+object.toString()+ "}");
            if (null == object) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo no debe ser nulo : " + strObjecName);
            }

            //if ("".equals(object.toString().trim())) {
            if (object.toString().trim().equals("")) {
            	System.out.println("Entro 2");	
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo no debe ser vacio : " + strObjecName);
            }
        }
        if (null != object && bIsNumeric) {
            try {
                Double.parseDouble(object.toString());
            } catch (Exception nfe) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo debe ser numérico : " + strObjecName);
            }
        }
    }
    
    public static void validarLargo(Object object, String strObjecName, Integer intMin, Integer intMax) throws IntegracionSICSAException {
        String value;
        if (object != null) {
            if (object instanceof Double) {
                value = String.valueOf(new BigDecimal(((Double) object).doubleValue()));
            } else {
                value = String.valueOf(object);
            }
            if (intMin != null) {
                if (value.length() < intMin.intValue()) {
                    throw new IntegracionSICSAException("ERROR FORMATO", 1, "El largo del campo es menor a lo permitido : " + strObjecName);
                }
            }
            if (intMax != null) {
                if (value.length() > intMax.intValue()) {
                    throw new IntegracionSICSAException("ERROR FORMATO", 1, "El largo del campo es mayor a lo permitido : " + strObjecName);
                }
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
}
