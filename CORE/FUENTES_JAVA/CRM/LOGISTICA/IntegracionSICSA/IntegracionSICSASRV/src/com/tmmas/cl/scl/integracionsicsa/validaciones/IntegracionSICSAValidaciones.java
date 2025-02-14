package com.tmmas.cl.scl.integracionsicsa.validaciones;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.tmmas.cl.scl.integracionsicsa.common.dto.PedidoEncabezadoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.PedidoInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.VentaInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;

public class IntegracionSICSAValidaciones extends Validator {

	private final LoggerHelper logger = LoggerHelper.getInstance();

	public void loggerDebug(String mensaje) {
		logger.debug(mensaje, this.getClass().getName());
	}

	public void loggerInfo(String mensaje) {
		logger.info(mensaje, this.getClass().getName());
	}

	public void loggerError(String mensaje) {
		logger.error(mensaje, this.getClass().getName());
	}

	/*
	 * -------------------------------------------------------------------------
	 * INICIO BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */
	public void validarCabeceraLineas(VentaInDTO inDTO)
			throws IntegracionSICSAException {
		loggerDebug("inicio: validarCabeceraLineas()");

		// Cabecera

		validarTipo(inDTO.getVentaEncabezadoDTO().getNumProceso(),
				"numProceso", false, true);
		validarLargo(inDTO.getVentaEncabezadoDTO().getNumProceso(),
				"numProceso", new Integer(1), new Integer(12));

		validarTipo(inDTO.getVentaEncabezadoDTO().getIndAccion(), "indAccion",
				false, false);
		validarLargo(inDTO.getVentaEncabezadoDTO().getIndAccion(), "indAccion",
				new Integer(1), new Integer(1));

		if (!inDTO.getVentaEncabezadoDTO().getIndAccion().toUpperCase().equals(
				"V")
				&& !inDTO.getVentaEncabezadoDTO().getIndAccion().toUpperCase()
						.equals("D")) {
			throw new IntegracionSICSAException("ERROR FORMATO", 1,
					"El campo indAccion solo debe contener V(Venta) ó D(Devolución).");
		}

		// Solo si es venta valido los otros datos
		if ("V".equals(inDTO.getVentaEncabezadoDTO().getIndAccion()
				.toUpperCase())) {

			validarTipo(inDTO.getVentaEncabezadoDTO().getCodCliente(),
					"codCliente", false, true);
			validarLargo(inDTO.getVentaEncabezadoDTO().getCodCliente(),
					"codCliente", new Integer(1), new Integer(12));

			validarTipo(inDTO.getVentaEncabezadoDTO().getNomCliente(),
					"nomCliente", false, false);
			validarLargo(inDTO.getVentaEncabezadoDTO().getNomCliente(),
					"nomCliente", new Integer(1), new Integer(150));

			validarTipo(inDTO.getVentaEncabezadoDTO().getTotalSeries(),
					"totalSeries", false, true);
			validarLargo(inDTO.getVentaEncabezadoDTO().getTotalSeries(),
					"totalSeries", new Integer(1), new Integer(12));

			// Valido total de series vs series informadas
			int totalSeries = Integer.parseInt(inDTO.getVentaEncabezadoDTO()
					.getTotalSeries());
			int series = inDTO.getSerieDTOs().length;
			loggerDebug("Valido cantidad cabecera vs series: totalSeries: "
					+ totalSeries + ", series informadas: " + series);
			if (totalSeries != series) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"El campo totalSeries NO es igual a las series informadas:"
								+ "totalSerie: "
								+ inDTO.getVentaEncabezadoDTO()
										.getTotalSeries()
								+ ", series informadas: "
								+ inDTO.getSerieDTOs().length);
			}

			validarTipo(inDTO.getVentaEncabezadoDTO().getFechaProceso(),
					"fechaProceso", false, false);
			validarFecha(inDTO.getVentaEncabezadoDTO().getFechaProceso(),
					"fechaProceso");

			// Lineas

			Set s = new HashSet(); // creo este objeto para validar duplicados

			int cantidadSeries = 0;

			for (int i = 0; i <= inDTO.getVentaEncabezadoDTO()
					.getVentaLineaDTOs().length - 1; i++) {

				validarTipo(
						inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
								.getLinProceso(), "linProceso", false, true);
				validarLargo(
						inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
								.getLinProceso(), "linProceso", new Integer(1),
						new Integer(2));

				if (!s.add(inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
						.getLinProceso())) {// Valido linProceso duplicada
					throw new IntegracionSICSAException("ERROR FORMATO", 1,
							"linProceso duplicado : "
									+ inDTO.getVentaEncabezadoDTO()
											.getVentaLineaDTOs()[i]
											.getLinProceso());
				}

				validarTipo(
						inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
								.getCodArticulo(), "codArticulo", false, true);
				validarLargo(
						inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
								.getCodArticulo(), "codArticulo",
						new Integer(1), new Integer(12));

				validarTipo(
						inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
								.getDesArticulo(), "desArticulo", false, false);
				validarLargo(
						inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
								.getDesArticulo(), "desArticulo",
						new Integer(1), new Integer(150));

				validarTipo(
						inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
								.getCanArticulo(), "canArticulo", false, true);
				validarLargo(
						inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
								.getCanArticulo(), "canArticulo",
						new Integer(1), new Integer(12));

				cantidadSeries = cantidadSeries
						+ Integer.parseInt(inDTO.getVentaEncabezadoDTO()
								.getVentaLineaDTOs()[i].getCanArticulo());

				validarTipo(
						inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
								.getPrecioVenta(), "precioVenta", false, false);
				try {					
					Double.parseDouble(inDTO.getVentaEncabezadoDTO()
							.getVentaLineaDTOs()[i].getPrecioVenta());
				} catch (NumberFormatException e) {
					throw new IntegracionSICSAException("ERROR FORMATO", 1,
							"Formato del precio no es correcto: precioVenta");
				}

				String arr[] = inDTO.getVentaEncabezadoDTO()
						.getVentaLineaDTOs()[i].getPrecioVenta().split(",");

				if (arr.length == 1) {
					arr = inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs()[i]
							.getPrecioVenta().split("\\.");
				}

				if (arr[0].length() > 12) {
					throw new IntegracionSICSAException("ERROR FORMATO", 1,
							"El largo del campo es mayor a lo permitido : precioVenta");
				}

				if (arr.length > 1) {
					if (arr[1].length() > 4) {
						throw new IntegracionSICSAException("ERROR FORMATO", 1,
								"El largo del campo es mayor a lo permitido : precioVenta");
					}
				}

			}

			if (cantidadSeries != Integer.parseInt(inDTO
					.getVentaEncabezadoDTO().getTotalSeries())) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"El campo totalSeries NO es igual a la cantidad de series según el detalle");
			}
		}

		loggerDebug("fin: validarCabeceraLineas()");
	}

	public void validarSeries(VentaInDTO inDTO)
			throws IntegracionSICSAException {
		loggerDebug("inicio:validarSeries()");

		Set lineasProcesosDetalles = null;
		Map mapLineaDetalles = null;
		Set series = null; // creo este objeto para validar duplicados
		Set linProcesosSeries = null;
		Map mapLineaSeries = null;

		StringBuffer mensajeError = new StringBuffer("");

		if ("V".equals(inDTO.getVentaEncabezadoDTO().getIndAccion()
				.toUpperCase())) {

			lineasProcesosDetalles = new HashSet();
			mapLineaDetalles = new HashMap();
			series = new HashSet(); // creo este objeto para validar duplicados
			linProcesosSeries = new HashSet();
			mapLineaSeries = new HashMap();

			for (int i = 0; i <= inDTO.getVentaEncabezadoDTO()
					.getVentaLineaDTOs().length - 1; i++) {
				if (lineasProcesosDetalles.add(inDTO.getVentaEncabezadoDTO()
						.getVentaLineaDTOs()[i].getLinProceso())) {
					mapLineaDetalles.put(inDTO.getVentaEncabezadoDTO()
							.getVentaLineaDTOs()[i].getLinProceso(),
							new Integer(inDTO.getVentaEncabezadoDTO()
									.getVentaLineaDTOs()[i].getCanArticulo()));
				}
			}

		}

		for (int i = 0; i <= inDTO.getSerieDTOs().length - 1; i++) {

			validarTipoSerie(inDTO.getSerieDTOs()[i].getNumSerie(), "numSerie",
					false, false);
			validarLargoSerie(inDTO.getSerieDTOs()[i].getNumSerie(),
					"numSerie", new Integer(1), new Integer(150));

			if ("V".equals(inDTO.getVentaEncabezadoDTO().getIndAccion()
					.toUpperCase())) {
				validarTipoSerie(inDTO.getSerieDTOs()[i].getLinPedido(),
						"linPedido", false, true);
				validarLargoSerie(inDTO.getSerieDTOs()[i].getLinPedido(),
						"linPedido", new Integer(1), new Integer(2));

				if (!series.add(inDTO.getSerieDTOs()[i].getNumSerie())) {// Valido
					// serie
					// duplicada en
					// la misma
					// linea de
					// pedido
					mensajeError.append("<br><br> * Serie duplicada : "
							+ inDTO.getSerieDTOs()[i].getNumSerie());
				}

				if (!lineasProcesosDetalles.contains(inDTO.getSerieDTOs()[i]
						.getLinPedido())) {
					mensajeError.append("<br><br> * Serie  "
							+ inDTO.getSerieDTOs()[i].getNumSerie()
							+ " contiene la linea de proceso "
							+ inDTO.getSerieDTOs()[i].getLinPedido()
							+ ", la cual no existe en el detalle;");
				}

				if (linProcesosSeries.add(inDTO.getSerieDTOs()[i]
						.getLinPedido())) {
					mapLineaSeries.put(inDTO.getSerieDTOs()[i].getLinPedido(),
							new Integer(1));
				} else {
					Integer cant = (Integer) mapLineaSeries.get(inDTO
							.getSerieDTOs()[i].getLinPedido());
					mapLineaSeries.put(inDTO.getSerieDTOs()[i].getLinPedido(),
							new Integer(cant.intValue() + 1));
				}

			}

		}

		if ("V".equals(inDTO.getVentaEncabezadoDTO().getIndAccion()
				.toUpperCase())) {

			Iterator iterador = lineasProcesosDetalles.iterator();
			while (iterador.hasNext()) {
				String linProceso = (String) iterador.next();
				if (!linProcesosSeries.contains(linProceso)) {
					mensajeError.append("<br><br> * linProceso   " + linProceso
							+ " del detalle, no tiene series asociadas");
				}

				if (null != mapLineaSeries.get(linProceso)) {
					Integer canArticulos = (Integer) mapLineaDetalles
							.get(linProceso);
					Integer canSeries = (Integer) mapLineaSeries
							.get(linProceso);
					loggerDebug("Valido campo canArticulo vs series: canArticulo: "
							+ canArticulos.intValue()
							+ " series: "
							+ canSeries.intValue());
					if (canArticulos.intValue() != canSeries.intValue()) {
						mensajeError
								.append("<br><br> * la cantidad de series asociadas al linProceso   "
										+ linProceso
										+ " no son las mismas que las informadas en el campo canArticulo");
					}
				}
			}
		}

		if (!"".equals(mensajeError.toString())) {
			throw new IntegracionSICSAException("ERROR SERIES", 1, mensajeError
					.toString());
		}

		loggerDebug("fin: validarSeries()");

	}

	/*
	 * -------------------------------------------------------------------------
	 * FIN BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */
	
	//Validacion de Ingreso Pedido	
	public void validaCabeceraPedido(PedidoEncabezadoDTO encabezadoDTO) throws IntegracionSICSAException {
		loggerDebug("Inicio: validaCabeceraPedido()");		
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
			validarTipo(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getCanDetallePedido()), "CanDetallePedido", false, true);
			validarLargo(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getCanDetallePedido()), "CanDetallePedido", new Integer(1), new Integer(6));
			
			validarTipo(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getCodArticulo()), "CodArticulo", false, true);
			validarLargo(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getCodArticulo()), "CodArticulo", new Integer(1), new Integer(6));
			
			validarTipo(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getLinPedido()), "LinPedido", false, true);
			validarLargo(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getLinPedido()), "LinPedido", new Integer(1), new Integer(2));
						
			if (!s.add(String.valueOf(encabezadoDTO.getPedidoLineasDTOs()[i].getLinPedido()))){
				// Valido linPedido duplicada
			    throw new IntegracionSICSAException("ERROR FORMATO", 1, "linPedido duplicado : " + encabezadoDTO.getPedidoLineasDTOs()[i].getLinPedido());
			}
		}	
		loggerDebug("Fin: validaCabeceraPedido()");
	}	
	
	public void validaSeriesPedido(PedidoInDTO pedidoInDTO) throws IntegracionSICSAException {
		loggerDebug("Inicio: validaSeriesPedido()");
		if (null == pedidoInDTO.getSeriePedidoDTOs() || 0 == pedidoInDTO.getSeriePedidoDTOs().length) {
			throw new IntegracionSICSAException("ERROR FORMATO", 1,	"No vienen Series informadas.");
		}
		loggerDebug("Se Crea objeto");
		
		Set series = new HashSet(); // creo este objeto para validar duplicados
		StringBuffer mensajeError = new StringBuffer("");
		Set lineasProcesosDetalles = new HashSet();

		loggerDebug("Primer for");
		for (int i = 0; i <= pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs().length - 1; i++) {
			if (lineasProcesosDetalles.add(String.valueOf(pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getLinPedido()))) {								
			}
		}
		loggerDebug("segundo for");
		for (int i = 0; i <= pedidoInDTO.getSeriePedidoDTOs().length - 1; i++) {
			validarTipoSerie(pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido(), "linPedido", false, true);
			validarLargoSerie(pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido(), "linPedido", new Integer(1), new Integer(2));
			validarTipoSerie(pedidoInDTO.getSeriePedidoDTOs()[i].getNumSerie(), "numSerie", false, false);
			validarLargoSerie(pedidoInDTO.getSeriePedidoDTOs()[i].getNumSerie(), "numSerie", new Integer(1), new Integer(25));			
				
			// Valido serie duplicada en la misma linea de pedido
			if (!series.add(pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido() + pedidoInDTO.getSeriePedidoDTOs()[i].getNumSerie())) {
				mensajeError.append("<br><br> * Serie duplicada : "	+ pedidoInDTO.getSeriePedidoDTOs()[i].getNumSerie()
						+ " en la linea de proceso "+ pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido());
			}
			
			//Valida que Serie contenga linea pedido existente
			if (!lineasProcesosDetalles.contains(pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido())) {
				mensajeError.append("<br><br> * Serie  " + pedidoInDTO.getSeriePedidoDTOs()[i].getNumSerie()
						+ " contiene la linea de proceso "+ pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido()
						+ ", la cual no existe en el detalle;");
			}
		}
		
		if (!"".equals(mensajeError.toString())) {
			loggerDebug("Ingresa al error");
			loggerDebug(mensajeError.toString());
			throw new IntegracionSICSAException("ERROR SERIES", 1, mensajeError.toString());
		}
		
		loggerDebug("Fin: validaSeriesPedido()");
	}
}
