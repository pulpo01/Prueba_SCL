package com.tmmas.cl.scl.integracionsicsa.bo;

import java.util.HashMap;

import com.tmmas.cl.scl.integracionsicsa.common.dto.ConsultaPedidoUsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosFolioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosPedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.PedidoLineaDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.PedidoInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaPedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaIntegracionSICSADTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.dao.PedidoDAO;

public class PedidoBO extends IntegracionSICSABO {
	private PedidoDAO pedidoDAO = new PedidoDAO();

	/**
	 * Metodo que registra las series Informadas por CELISTIC
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public SalidaIntegracionSICSADTO validaEstadoPedido(String codPedido,
			String estadoPedido) throws IntegracionSICSAException {
		loggerDebug("validaEstadoPedido: Inicio");
		SalidaIntegracionSICSADTO respuesta = pedidoDAO.validaEstadoPedido(
				codPedido, estadoPedido);
		loggerDebug("validaEstadoPedido: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Obtiene cantidad total del pedido
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public int obtieneCantTotalPedido(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("obtieneCantTotalPedido: Inicio");
		int respuesta = pedidoDAO.obtieneCantTotalPedido(codPedido);
		loggerDebug("obtieneCantTotalPedido: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Obtiene cantidad total de las lineas del pedido
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public PedidoLineaDTO[] obtieneCantTotalPedidoXLinea(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("obtieneCantTotalPedidoXLinea: Inicio");
		PedidoLineaDTO[] respuesta = pedidoDAO
				.obtieneCantTotalPedidoXLinea(codPedido);
		loggerDebug("obtieneCantTotalPedidoXLinea: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Valida que el pedido exista en la tabla
	 * NP_VALIDACION_SERIES_TO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public SalidaIntegracionSICSADTO validaExistenciaPedido(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("validaExistenciaPedido: Inicio");
		SalidaIntegracionSICSADTO respuesta = pedidoDAO
				.validaExistenciaPedido(codPedido);
		loggerDebug("validaExistenciaPedido: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Valida si existe alguna serie con error del pedido en la tabla
	 * NP_VALIDACION_SERIES_TO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public SalidaIntegracionSICSADTO validaSeriePedido(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("validaSeriePedido: Inicio");
		SalidaIntegracionSICSADTO respuesta = pedidoDAO
				.validaSeriePedido(codPedido);
		loggerDebug("validaSeriePedido: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Elimina las series del pedido que existan en la tabla
	 * NP_VALIDACION_SERIES_TO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public SalidaIntegracionSICSADTO borrarSeriePedido(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("borrarSeriePedido: Inicio");
		SalidaIntegracionSICSADTO respuesta = pedidoDAO
				.borrarSeriePedido(codPedido);
		loggerDebug("borrarSeriePedido: Fin");
		return respuesta;
	}

	/**
	 * Metodo que registra las series Informadas por CELISTIC
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public SalidaIntegracionSICSADTO registraSeries(PedidoInDTO pedidoInDTO)
			throws IntegracionSICSAException, Exception {
		loggerDebug("registraSeries: Inicio");
		SalidaIntegracionSICSADTO respuesta = pedidoDAO
				.registraSeries(pedidoInDTO);
		loggerDebug("registraSeries: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Valida las series insertadas atravez del procedimiento
	 * NP_VALIDASERIES_PR
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public void validaSeriesInsertadas(String codPedido)
			throws IntegracionSICSAException, Exception {
		loggerDebug("validaSeriesInsertadas: Inicio");
		pedidoDAO.validaSeriesInsertadas(codPedido);
		loggerDebug("validaSeriesInsertadas: Fin");
	}

	/**
	 * Metodo que obtiene datos de la tabla NPT_PEDIDO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public DatosPedidoDTO obtieneDatosPedido(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("obtieneDatosPedido: Inicio");
		DatosPedidoDTO resultado = pedidoDAO.obtieneDatosPedido(codPedido);
		loggerDebug("obtieneDatosPedido: Fin");
		return resultado;
	}

	/**
	 * Metodo que inserta estado del pedido en la tabla NPT_ESTADO_PEDIDO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public void insertaEstadoPedido(DatosPedidoDTO datosPedidoDTO)
			throws Exception {
		loggerDebug("insertaEstadoPedido: Inicio");
		pedidoDAO.insertaEstadoPedido(datosPedidoDTO);
		loggerDebug("insertaEstadoPedido: Fin");
	}

	/**
	 * Metodo que valida si existe pedido en la tabla NP_CONTROL_ING_SERIES_TO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public boolean validaPedidoControl(String codPedido) throws Exception {
		loggerDebug("validaPedidoControl: Inicio");
		boolean resultado = pedidoDAO.validaPedidoControl(codPedido);
		loggerDebug("validaPedidoControl: Fin");
		return resultado;
	}

	/**
	 * Metodo que valida si pedido esta dado de baja
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public boolean validaBajaPedido(String codPedido) throws Exception {
		loggerDebug("validaBajaPedido: Inicio");
		boolean resultado = pedidoDAO.validaBajaPedido(codPedido);
		loggerDebug("validaBajaPedido: Fin");
		return resultado;
	}

	/**
	 * Metodo que inserta en la tabla NP_CONTROL_ING_SERIES_TO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public void insertaControlPedido(String codPedido, String userWeb,
			int cantSeries) throws Exception {
		loggerDebug("insertaControlPedido: Inicio");
		pedidoDAO.insertaControlPedido(codPedido, userWeb, cantSeries);
		loggerDebug("insertaControlPedido: Fin");
	}

	/**
	 * Metodo que obtiene parametro de la tabla NPT_PARAMETRO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public String obtieneParametroNPW(String aliasParametro)
			throws IntegracionSICSAException {
		loggerDebug("obtieneParametroNPW: Inicio");
		String respuesta = pedidoDAO.obtieneParametroNPW(aliasParametro);
		loggerDebug("obtieneParametroNPW: Fin");
		return respuesta;
	}

	/**
	 * Metodo que obtiene estado de escritura de la tabla
	 * npt_fun_estado_flujo_esc
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public String obtieneEstadoEscNPW(String codFuncion)
			throws IntegracionSICSAException {
		loggerDebug("obtieneEstadoEscNPW: Inicio");
		String respuesta = pedidoDAO.obtieneEstadoEscNPW(codFuncion);
		loggerDebug("obtieneEstadoEscNPW: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Valida pedido en las tablas npt_detalle_pedido y
	 * np_validacion_series_to
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public boolean valDetalleValidaSeries(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("valDetalleValidaSeries: Inicio");
		boolean resultado = pedidoDAO.valDetalleValidaSeries(codPedido);
		loggerDebug("valDetalleValidaSeries: Fin");
		return resultado;
	}

	/**
	 * Metodo que valida si pedido existe en la tabla npt_serie_pedido
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public boolean validaSeriePedidoNPW(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("validaSeriePedidoNPW: Inicio");
		boolean resultado = pedidoDAO.validaSeriePedidoNPW(codPedido);
		loggerDebug("validaSeriePedidoNPW: Fin");
		return resultado;
	}

	/**
	 * Metodo que valida el estado del Pedido en la tabla
	 * np_control_ing_series_to
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public boolean validaEstadoControl(String codPedido, String estadoProceso)
			throws IntegracionSICSAException {
		loggerDebug("validaEstadoControl: Inicio");
		boolean resultado = pedidoDAO.validaEstadoControl(codPedido,
				estadoProceso);
		loggerDebug("validaEstadoControl: Fin");
		return resultado;
	}

	/**
	 * Metodo que actualiza el estado del pedido en la tabla
	 * NP_CONTROL_ING_SERIES_TO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public void actualizaControlSeries(String codPedido,
			String estadoProcesoActual, String estadoProcesoNuevo)
			throws IntegracionSICSAException {
		loggerDebug("actualizaControlSeries: Inicio");
		pedidoDAO.actualizaControlSeries(codPedido, estadoProcesoActual,
				estadoProcesoNuevo);
		loggerDebug("actualizaControlSeries: Fin");
	}

	/**
	 * Metodo que inserta las series en la tabla NPT_SERIE_PEDIDO por medio del
	 * codPedido
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public void insertPedidoSerie(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("insertPedidoSerie: Inicio");
		pedidoDAO.insertPedidoSerie(codPedido);
		loggerDebug("insertPedidoSerie: Fin");
	}

	/**
	 * Metodo que Obtiene bodega del Pedido
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public long obtieneBodegaPedido(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("obtieneBodegaPedido: Inicio");
		long respuesta = pedidoDAO.obtieneBodegaPedido(codPedido);
		loggerDebug("obtieneBodegaPedido: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Obtiene numero de Folio
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public DatosFolioDTO obtieneNumFolio(long codBodega, String codOperadora)
			throws IntegracionSICSAException {
		loggerDebug("obtieneNumFolio: Inicio");
		DatosFolioDTO respuesta = pedidoDAO.obtieneNumFolio(codBodega,
				codOperadora);
		loggerDebug("obtieneNumFolio: Fin");
		return respuesta;
	}

	/**
	 * Metodo que actualiza número de guia de la tabla NPT_PEDIDO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public void updateNumGuia(String codPedido, String numGuia)
			throws IntegracionSICSAException {
		loggerDebug("updateNumGuia: Inicio");
		pedidoDAO.updateNumGuia(codPedido, numGuia);
		loggerDebug("updateNumGuia: Fin");
	}

	/**
	 * Metodo que Obtiene las Series con Error de la Tabla
	 * NP_VALIDACION_SERIES_TO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public SerieErrorDTO[] obtieneSeriesErroneas(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("obtieneSeriesErroneas: Inicio");
		SerieErrorDTO[] respuesta = pedidoDAO.obtieneSeriesErroneas(codPedido);
		loggerDebug("obtieneSeriesErroneas: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Elimina control de pedido de la tabla np_control_ing_series_to
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public void borrarControlPedido(String codPedido, String estadoRegistro)
			throws IntegracionSICSAException {
		loggerDebug("borrarControlPedido: Inicio");
		pedidoDAO.borrarControlPedido(codPedido, estadoRegistro);
		loggerDebug("borrarControlPedido: Fin");
	}

	/**
	 * Metodo que obtiene descripcion del articulo
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public String obtieneDescrArtic(long codArticulo)
			throws IntegracionSICSAException {
		loggerDebug("obtieneDescrArtic: Inicio");
		String respuesta = pedidoDAO.obtieneDescrArtic(codArticulo);
		loggerDebug("obtieneDescrArtic: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Obtiene descripcion del Estado del Pedido
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public SalidaConsultaPedidoDTO obtieneEstadoPedido(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("obtieneEstadoPedido: Inicio");
		SalidaConsultaPedidoDTO respuesta = pedidoDAO
				.obtieneEstadoPedido(codPedido);
		loggerDebug("obtieneEstadoPedido: Fin");
		return respuesta;
	}

	/**
	 * Hugo Olivares
	 * 
	 * @param codUsuario
	 * @param codPedido
	 * @param fecDesde
	 * @param fecHasta
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public ConsultaPedidoUsuarioDTO[] consultarPedidosUsuario(
			String codUsuario, String codPedido, String fecDesde,
			String fecHasta) throws IntegracionSICSAException {
		loggerDebug("consultarPedidosUsuario: Inicio");
		ConsultaPedidoUsuarioDTO[] respuesta = pedidoDAO
				.consultarPedidosUsuario(codUsuario, codPedido, fecDesde,
						fecHasta);
		loggerDebug("consultarPedidosUsuario: Fin");
		return respuesta;
	}

	/**
	 * Hugo Olivares
	 * 
	 * @param codPedido
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public HashMap consultarDetallePedidosUsuario(String codPedido,
			HashMap detalles) throws IntegracionSICSAException {
		loggerDebug("consultarDetallePedidosUsuario: inicio");
		HashMap respuesta = pedidoDAO.consultarDetallePedidosUsuario(codPedido,
				detalles);
		loggerDebug("consultarDetallePedidosUsuario: Fin");
		return respuesta;
	}

	/**
	 * Hugo Olivares
	 * 
	 * @param codPedido
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public HashMap consultarSeriePedidosUsuario(String codPedido,
			String linProceso, HashMap series) throws IntegracionSICSAException {
		loggerDebug("consultarSeriesPedidosUsuario: inicio");
		HashMap respuesta = pedidoDAO.consultarSeriePedidosUsuario(codPedido,
				linProceso, series);
		loggerDebug("consultarSeriePedidosUsuario: Fin");
		return respuesta;
	}

	/**
	 * Metodo que Elimina las series del pedido que existan en la tabla
	 * NP_VAL_SERIES_TEMP_TO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public void borrarSeriePedidoTemp(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("borrarSeriePedidoTemp: Inicio");
		pedidoDAO.borrarSeriePedidoTemp(codPedido);
		loggerDebug("borrarSeriePedidoTemp: Fin");
	}

	/**
	 * Metodo que Inserta las series con error del pedido en la tabla
	 * NP_VAL_SERIES_TEMP_TO
	 * 
	 * @author Jorge González
	 * @throws IntegracionSICSAException
	 */
	public void InsertaSeriePedidoTemp(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("InsertaSeriePedidoTemp: Inicio");
		pedidoDAO.InsertaSeriePedidoTemp(codPedido);
		loggerDebug("InsertaSeriePedidoTemp: Fin");
	}

	/**
	 * Metodo que limpia un pedido
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void limpiarPedido(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("limpiarPedido: inicio");
		pedidoDAO.limpiarPedido(codPedido);
		loggerDebug("limpiarPedido: fin");
	}

}
