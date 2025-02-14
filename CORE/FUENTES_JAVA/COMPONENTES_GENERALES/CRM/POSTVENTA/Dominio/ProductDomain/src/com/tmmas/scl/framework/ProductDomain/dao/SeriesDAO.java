package com.tmmas.scl.framework.ProductDomain.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.SeriesDAOIT;
import com.tmmas.scl.framework.ProductDomain.dto.ArticuloInDTO;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.ProductDomain.helper.Global;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;

public class SeriesDAO extends ConnectionDAO implements SeriesDAOIT {

	private final Logger logger = Logger.getLogger(SeriesDAO.class);

	private final Global global = Global.getInstance();

	private String getSQLreservaSimcard() {
		StringBuffer call = new StringBuffer();

		call.append("BEGIN ");
		call
				.append("	pv_cambio_simcard_sb_pg.pv_reserva_simcard_pr( ?, ?, ?, ?, ? ); ");
		call.append("END; ");
		return call.toString();
	}
	
	// INICIO RRG 70904 COL 03-02-2009

	private String getSQLValidaSerieExterna() {
		StringBuffer call = new StringBuffer();

		call.append("BEGIN ");
		call
				.append("	pv_cambio_simcard_sb_pg.pv_valida_serie_externa_pr( ?,  ?, ?, ? ); ");
		call.append("END; ");
		return call.toString();

	}

	// FIN RRG 70904 COL 03-02-2009
	private String getSQLdesReservaSimcard() {
		StringBuffer call = new StringBuffer();

		call.append("BEGIN ");
		call.append("	pv_cambio_simcard_sb_pg.pv_desreserva_simcard_pr( ?, ?, ?, ?, ? ); ");
		call.append("END; ");
		return call.toString();
	}	

	private String getSQLvalidaSerieBodego() {
		StringBuffer call = new StringBuffer();

		call.append("DECLARE ");
		call.append("RetVal BOOLEAN; ");
		call.append("	OE_SESION GE_SESION_QT := NEW GE_SESION_QT; ");
		call.append("	OE_USO AL_USO_QT := NEW AL_USO_QT; ");
		call.append("	OE_TIP_TERMINAL AL_TIPOS_TERMINALES_QT := NEW AL_TIPOS_TERMINALES_QT; ");
		call.append("	OE_DAT_ABO PV_DATOS_ABO_QT := NEW PV_DATOS_ABO_QT; ");
		call.append("	OE_AL_SERIE AL_SERIE_QT := NEW AL_SERIE_QT; ");
		call.append("BEGIN ");
		call.append("	OE_uso.cod_uso               := ? ; ");
		call.append("	OE_tip_terminal.tip_terminal := ? ; ");
		call.append("	OE_AL_SERIE.num_serie        := ? ; ");
		call.append("	OE_sesion.num_abonado        := ? ; ");
		call.append("	oe_sesion.nom_usuario        := ?; ");
		call.append("	oe_sesion.cod_programa       := ?; ");
		call.append("	oe_sesion.num_version        := ?; ");
		call
				.append("	RetVal := PV_CAMBIO_SIMCARD_SB_PG.PV_VALIDA_SERIE_EN_BODEGA_FN ( OE_SESION, OE_USO, OE_TIP_TERMINAL, OE_DAT_ABO, OE_AL_SERIE, ?, ?, ? ); ");
		call.append("END; ");
		return call.toString();
	}

	private String getSQLCambioDeSerie() {
		StringBuffer call = new StringBuffer();
		call.append("BEGIN ");
		call.append("	PV_ACTCAMBIOS_OFVIRTUAL_PG.PV_CAMBIOSERIE_PR ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ); ");
		call.append("END; ");
		return call.toString();
	}	
	
	private String getSQLrecInfoSerie() {
		StringBuffer call = new StringBuffer();

		call.append("BEGIN ");
		call.append("	PV_CAMBIO_SIMCARD_SB_PG.PV_REC_DATOS_SIMCARD_PR ( ?, ?, ?, ?, ? ); ");
		call.append("END; ");
		return call.toString();
	}

	private String getSQLregistraCambioSimcard() {
		StringBuffer call = new StringBuffer();
		call.append("DECLARE ");
		call.append("	eo_cambioserie PV_CAM_SIMCARD_OT := new PV_CAM_SIMCARD_OT(); ");
		call.append("BEGIN ");
		call.append("	eo_cambioserie.NumSerieAnt     := ?; ");
		call.append("	eo_cambioserie.Numserie        := ?; ");
		call.append("	eo_cambioserie.CodUsoLinea     := ?; ");
		call.append("	eo_cambioserie.NumAbonado      := ?; ");
		call.append("	eo_cambioserie.NumCelular      := ?; ");
		call.append("	eo_cambioserie.CodTecnologia   := ?; ");
		call.append("	eo_cambioserie.CodCliente      := ?; ");
		call.append("	eo_cambioserie.CodCuota        := ?; ");
		call.append("	eo_cambioserie.lCod_OOSS       := ?; ");
		call.append("	eo_cambioserie.numventa        := ?; ");
		call.append("	eo_cambioserie.CodModVenta     := ?; ");
		call.append("	eo_cambioserie.CodArticulo     := ?; ");
		call.append("	eo_cambioserie.CodBodega       := ?; ");
		call.append("	eo_cambioserie.IndProcEqui     := ?; ");
		call.append("	eo_cambioserie.CauCambio       := ?; ");
		call.append("	eo_cambioserie.CodProducto     := ?; ");
		call.append("	eo_cambioserie.CodModulo       := ?; ");
		call.append("	eo_cambioserie.usuario         := ?; ");
		call.append("	eo_cambioserie.sCodPlanTarif   := ?; ");
		call.append("	eo_cambioserie.CodActabo       := ?; ");
		call.append("	eo_cambioserie.TAREA           := ?; ");
		call.append("	eo_cambioserie.NumImei         := ?; ");
		call.append("	eo_cambioserie.numMovimientoBloqDesb:= ?; ");
		call.append("	pv_grabar_simcard_sb_pg.pv_graba_cambio_simcard_pr ( eo_cambioserie, ?, ?, ?); ");
		call.append("	END; ");
		return call.toString();
	}
	
	private String getSQLValidaSerieExternaEquipo() {
		StringBuffer call = new StringBuffer();

		call.append("BEGIN ");
		call.append("	pv_cambio_serie_sb_pg.pv_valida_serie_externa_pr(?,  ?, ?, ?, ?, ?); ");
		call.append("END; ");
		return call.toString();

	}
	
	public RetornoDTO reservaSimcard(SerieDTO serie) throws ProductException {

		logger.debug("reservaSimcard():start");
		RetornoDTO retValue= null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLreservaSimcard();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("serie.getNum_serie() ["+serie.getNum_serie()+"]");
			logger.debug("nn [1] // 1 Reserva Simcard");
			cstmt.setString(1, serie.getNum_serie());
			//cstmt.setLong(2, 1); // 1 Reserva Simcard
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
						.error(" Ocurrió un error general al reservar la SimCard");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}
			retValue=new RetornoDTO();
			
			retValue.setResultado(true);
			retValue.setDescripcion(String.valueOf(cstmt.getInt(2)));

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error generalal reservar la SimCard",
					e);
			throw new ProductException(
					"Ocurrió un error general al reservar la SimCard", e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("reservaSimcard():end");
		return retValue;
	}
	
	public RetornoDTO desReservaSimcard(SerieDTO serie) throws ProductException {

		logger.debug("desReservaSimcard():start");
		RetornoDTO retValue=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLdesReservaSimcard();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("serie.getNum_serie() ["+serie.getNum_serie()+"]");
			logger.debug("NN [1] //está por defecto");
			cstmt.setString(1, serie.getNum_serie());
			//cstmt.setLong(2, 1); // 1 Reserva Simcard
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
						.error(" Ocurrió un error general al des-reservar la simcard");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}
			
			retValue = new RetornoDTO();
			retValue.setResultado(true);
			retValue.setDescripcion(String.valueOf(cstmt.getInt(2)));

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al des-reservar la simcard",
					e);
			throw new ProductException(
					"Ocurrió un error general al des-reservar la simcard", e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("desReservaSimcard():end");
		
		return retValue;
	}	

	public void validaBodegaSerie(UsoArticuloDTO usoArticulos,
			TipoTerminalDTO tipoTerminal, UsuarioAbonadoDTO usuarioAbonado,
			SesionDTO sesion, SerieDTO serie) throws ProductException {

		logger.debug("validaBodegaSerie():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLvalidaSerieBodego();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("usoArticulos.getCod_uso()      ["+usoArticulos.getCod_uso()+"]");
			logger.debug("tipoTerminal.getTip_terminal() ["+tipoTerminal.getTip_terminal()+"]");
			logger.debug("serie.getNum_serie()           ["+serie.getNum_serie()+"]");
			logger.debug("usuarioAbonado.getNum_abonado()["+usuarioAbonado.getNum_abonado()+"]");
			logger.debug("sesion.getUsua.getNom_usuario()["+sesion.getUsuario().getNom_usuario()+"]");
			logger.debug("sesion.getCod_programa()       ["+sesion.getCod_programa()+"]");
			logger.debug("sesion.getNum_version()        ["+sesion.getNum_version()+"]");
			cstmt.setLong(1, usoArticulos.getCod_uso());
			cstmt.setString(2, tipoTerminal.getTip_terminal());
			cstmt.setString(3, serie.getNum_serie());
			cstmt.setLong(4, usuarioAbonado.getNum_abonado());
			cstmt.setString(5, sesion.getUsuario().getNom_usuario());
			cstmt.setString(6, sesion.getCod_programa());
			cstmt.setLong(7, sesion.getNum_version());

			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(8);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(9);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(10);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
						.error(" Ocurrió un error general al validar bodega serie");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al validar bodega serie",
					e);
			throw new ProductException(
					"Ocurrió un error general al validar bodega serie", e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("validaBodegaSerie():end");
	}

	public SerieDTO recInfoSerie(SerieDTO serie) throws ProductException {

		logger.debug("recInfoSerie():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs=null;
		String call = getSQLrecInfoSerie();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("serie.getNum_serie() ["+serie.getNum_serie()+"]");
			cstmt.setString(1, serie.getNum_serie());
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");

			logger.debug("Recuperando cursor...");
			
			
			if (codError != 0) {
				logger
						.error(" Ocurrió un error general al recuperar info serie");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}
			else{

			rs = (ResultSet) cstmt.getObject(2);

			while (rs.next()) {

				serie.setCod_bodega(rs.getLong(1));
				serie.setCod_articulo(rs.getLong(2));
				serie.setCod_estado(rs.getLong(3));
			}
			}
			

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar info serie",
					e);
			throw new ProductException(
					"Ocurrió un error general al recuperar info serie", e);
		} finally {
			try {
				
				if (rs != null) {
					rs.close();
					rs = null;
				}
				
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("recInfoSerie():end");
		return serie;
	}

	public void registraCambioSimcard(UsuarioAbonadoDTO usuarioAbonado,
			SerieDTO serie, UsoArticuloDTO usoArticulo, CuotaDTO cuota,
			SesionDTO sesion, ModalidadPagoDTO modalidadPago, BodegaDTO bodega,
			String actabo, String codModulo, CausaCamSerieDTO causaCamSerie)
			throws ProductException {

		logger.debug("registraCambioSimcard():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLregistraCambioSimcard();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("usuarioAbonado.getNum_serie()   ["+usuarioAbonado.getNum_serie()+"]");
			logger.debug("serie.getNum_serie()            ["+serie.getNum_serie()+"]");
			logger.debug("usoArticulo.getCod_uso()        ["+usoArticulo.getCod_uso()+"]");
			logger.debug("usuarioAbonado.getNum_abonado() ["+usuarioAbonado.getNum_abonado()+"]");
			logger.debug("usuarioAbonado.getNum_celular() ["+usuarioAbonado.getNum_celular()+"]");
			logger.debug("usuarioAbonado.getCod_tecnolo() ["+usuarioAbonado.getCod_tecnologia()+"]");
			logger.debug("usuarioAbonado.getCod_cliente() ["+usuarioAbonado.getCod_cliente()+"]");
			logger.debug("cuota.getCod_cuota()            ["+cuota.getCod_cuota()+"]");
			logger.debug("sesion.getCodOrdenServicio()    ["+sesion.getCodOrdenServicio()+"]");
			logger.debug("Numero de Venta                 ["+causaCamSerie.getNumeroVenta()+"]");
			logger.debug("modalidadPago.getCod_modventa() ["+modalidadPago.getCod_modventa()+"]");
			logger.debug("serie.getCod_articulo()         ["+serie.getCod_articulo()+"]");
			logger.debug("bodega.getCod_bodega()          ["+bodega.getCod_bodega()+"]");
			logger.debug("NN [I] //Por default");
			logger.debug("causaCamSerie.getCod_caucaser() ["+causaCamSerie.getCod_caucaser()+"]");
			logger.debug("NN [1] //Por default");
			logger.debug("codModulo                       ["+codModulo+"]");
			logger.debug("sesion.getUsuar.getNom_usuario()["+sesion.getUsuario().getNom_usuario()+"]");
			logger.debug("usuarioAbonado.getCodPlantarif()["+usuarioAbonado.getCodPlantarif()+"]");
			logger.debug("actabo                          ["+actabo+"]");
			logger.debug("sesion.getNumTarea()            ["+sesion.getNumTarea()+"]");
			logger.debug("usuarioAbonado.getNum_imei()    ["+usuarioAbonado.getNum_imei()+"]");
			logger.debug("Numero Movimiento Bloque-Desbloq["+serie.getMensajeRetorno().getNumMovimientoBloqDesb()+"]");
			cstmt.setString(1, usuarioAbonado.getNum_serie());
			cstmt.setString(2, serie.getNum_serie());
			cstmt.setLong(3, usoArticulo.getCod_uso());
			cstmt.setLong(4, usuarioAbonado.getNum_abonado());
			cstmt.setLong(5, usuarioAbonado.getNum_celular());
			cstmt.setString(6, usuarioAbonado.getCod_tecnologia());
			cstmt.setLong(7, usuarioAbonado.getCod_cliente());
			cstmt.setString(8, cuota.getCod_cuota());
			cstmt.setLong(9, sesion.getCodOrdenServicio());
			cstmt.setLong(10, causaCamSerie.getNumeroVenta());
			cstmt.setLong(11, modalidadPago.getCod_modventa());
			cstmt.setLong(12, serie.getCod_articulo());
			cstmt.setString(13, bodega.getCod_bodega());
			cstmt.setString(14, "I");
			cstmt.setString(15, causaCamSerie.getCod_caucaser());
			cstmt.setLong(16, 1);
			cstmt.setString(17, codModulo);
			cstmt.setString(18, sesion.getUsuario().getNom_usuario());
			cstmt.setString(19, usuarioAbonado.getCodPlantarif());
			cstmt.setString(20, actabo);
			cstmt.setLong(21, sesion.getNumTarea());
			cstmt.setString(22, usuarioAbonado.getNum_imei());
			cstmt.setLong(23, serie.getMensajeRetorno().getNumMovimientoBloqDesb());
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(24);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(25);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(26);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
						.error(" Ocurrió un error general al registrar cambio de Simcard");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.debug(
					"Ocurrió un error general al registrar cambio de Simcard",e);
			throw new ProductException(
					"Ocurrió un error general al registrar cambio de Simcard",
					e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("registraCambioSimcard():end");
	}

	// ---------------------------------------------------------------------------------------------------------------------------------------------
	
	public String registraCambioDeSerie(ParametrosCambioSerieDTO parametros,SaldoDTO saldo)  throws ProductException {

		logger.debug("registraCambioDeSerie():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String indicador ;
		
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLCambioDeSerie();

		logger.debug("78629"); // RRG
	    logger.debug(call); // RRG

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("Numero Celular      ["+parametros.getNumCelular()+"]");
			logger.debug("Numero Serie Equipo ["+parametros.getNumSerieEquipo()+"]");
			logger.debug("Numero Serie Simcard["+parametros.getNumSerieSimcard()+"]");
			logger.debug("Codigo Vendedor     ["+parametros.getCodVendedor()+"]");
			logger.debug("Nombre Usuario      ["+parametros.getNomUsuario()+"]");
			logger.debug("Codigo Central      ["+parametros.getCodCentral()+"]");
			logger.debug("Importe Cargo       ["+parametros.getImpCargo()+"]");
			logger.debug("Codigo Tipo Contrato["+parametros.getCodTipContrato()+"]");
			logger.debug("Numero Contrato     ["+parametros.getNumContrato()+"]");
			logger.debug("Numero Anexo        ["+parametros.getNumAnexo()+"]");
			logger.debug("Codigo Causa        ["+parametros.getCodCausa()+"]");
			logger.debug("Num Transaccion Bloqueo Equipo ["+parametros.getNumTransBloqEquipo()+"]");
			logger.debug("Num Transaccion Bloqueo Serie  ["+parametros.getNumTransBloqSerie()+"]");
			logger.debug("Codigo Uso          ["+parametros.getUsoVentaEquip()+"]");
			logger.debug("Codigo Articulo     ["+parametros.getCodArticulo()+"]");
			logger.debug("Descripcion Articulo["+parametros.getDescrEquipoEx()+"]");
			logger.debug("Precio Venta Equipo ["+parametros.getMntoTerminal()+"]");
			logger.debug("Carga               ["+saldo.getSaldo()+"]");
			logger.debug("Tipo Descuento ["+parametros.getTipoDescuento()+"]");
			logger.debug("Descuento Unitario ["+parametros.getDescuentoUnitario()+"]");
			
			logger.debug("Registro variables de entrada en CallableStatement");
			cstmt.setLong(1,parametros.getNumCelular());
			cstmt.setString(2,parametros.getNumSerieEquipo());
			cstmt.setString(3,parametros.getNumSerieSimcard());
			cstmt.setLong(4,parametros.getCodVendedor());
			cstmt.setString(5,parametros.getNomUsuario());
			cstmt.setString(6,parametros.getCodCentral());
			cstmt.setFloat(7,parametros.getImpCargo());
			cstmt.setLong(8,parametros.getCodTipContrato());
			cstmt.setString(9,parametros.getNumContrato());
			cstmt.setString(10,parametros.getNumAnexo());
			cstmt.setString(11,parametros.getCodCausa());
			cstmt.setString(12,parametros.getNumTransBloqEquipo());
			cstmt.setString(13,parametros.getNumTransBloqSerie());
			cstmt.setString(14,parametros.getUsoVentaEquip());
			cstmt.setString(15,parametros.getCodArticulo());
			cstmt.setString(16,parametros.getDescrEquipoEx());
			cstmt.setString(17,saldo.getSaldo());

			String prcVenta=parametros.getMntoTerminal();
			prcVenta=prcVenta==null||"".equals(prcVenta)?"0.0":prcVenta;
			StringTokenizer st= new StringTokenizer(prcVenta,",");
			prcVenta="";
			while (st.hasMoreTokens()){
				prcVenta=prcVenta+st.nextToken();
			}
			
			logger.debug("Sugerencia PAto ::: "+prcVenta);
			cstmt.setFloat(18,Float.parseFloat(prcVenta.trim()));
			
			String tipoDescuento=parametros.getTipoDescuento();		
			if (tipoDescuento!=null && (tipoDescuento.equals("1") || tipoDescuento.equals("0"))){
				cstmt.setInt(19,Integer.parseInt(tipoDescuento.trim()));	
			} else {
				cstmt.setNull(19, java.sql.Types.NULL);
			}
			
			String descuentoUnitario=parametros.getDescuentoUnitario();
			descuentoUnitario=descuentoUnitario==null||"".equals(descuentoUnitario)?"0.0":descuentoUnitario;
			//StringTokenizer st2= new StringTokenizer(descuentoUnitario,",");
			//descuentoUnitario="";
			//while (st.hasMoreTokens()){
				//descuentoUnitario=descuentoUnitario+st2.nextToken();
			//}
			
			float desc = Float.parseFloat(descuentoUnitario.trim());
			logger.debug("Descuento Unitario  ::: "+parametros.getDescuentoUnitario()+" convertido a "+desc);			
			cstmt.setFloat(20,desc);
			
			logger.debug("Registro variables de Salida en CallableStatement");
			cstmt.registerOutParameter(21, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(22, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);


			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			indicador =  cstmt.getString(21);
			logger.debug("indicador[" + indicador + "]");			
			codError = cstmt.getInt(22);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(23);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(24);
			logger.debug("numEvento[" + numEvento + "]");

			
			if (codError != 0) {
				logger.error(" Ocurrió un error general al registrar cambio de Serie");
				throw new ProductException(String.valueOf(codError), numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error( "Ocurrió un error general al registrar cambio de Serie", e);
			throw new ProductException( "Ocurrió un error general al registrar cambio de Serie", e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		
		logger.debug("registraCambioDeSerie():end");
		
		return indicador;
		
	} // registraCambioDeSerie

	// ---------------------------------------------------------------------------------------------------------------------------------------------
	
// inicio RRG 70904 24-09-2008 COL
	public RetornoDTO validaSerieExterna(SerieDTO serie) throws ProductException {
		logger.debug("validaSerieExterna():start");
		RetornoDTO retValue= null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLValidaSerieExterna();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("serie.getNum_serie() ["+serie.getNum_serie()+"]");

			cstmt.setString(1, serie.getNum_serie());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError == 4) {
				logger.error(" Ocurrió un error general al validar Serie Externa");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}
			retValue=new RetornoDTO();
			
			retValue.setResultado(true);
			//retValue.setDescripcion(String.valueOf(cstmt.getInt(3)));
			retValue.setDescripcion(msgError);

			//retValue.setDescripcion("OK") ;
			retValue.setCodigo("0");


			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al validar Serie Externa",
					e);
			throw new ProductException(
					"Ocurrió un error general al validar Serie Externa", e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("validaSerieExterna():end");
		return retValue;


			
	}
	
	public SerieDTO[] obtieneSerie(SerieDTO serieDTO) throws ProductException {
		SerieDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLDatosSerie("Ve_Servicios_Venta_Pg","VE_Busca_Serie_PR",15);
			logger.debug("sql[" + call + "]");				
			cstmt = conn.prepareCall(call);				
			logger.debug("obtieneSerie.DAO:inicio");		
			if (serieDTO.getNum_telefono()!=0) {
				cstmt.setString(1,String.valueOf(serieDTO.getNum_telefono()));
				logger.debug("serieDTO.getNum_telefono() : "	+ serieDTO.getNum_telefono());
			} else {
				cstmt.setNull(1, java.sql.Types.NULL);
				logger.debug("serieDTO.getNum_telefono() : se asigno null");
			}			
						
			if (serieDTO.getNum_serie()!=null && !serieDTO.getNum_serie().equals("") && !serieDTO.getNum_serie().equals("0")) {
				cstmt.setString(2,serieDTO.getNum_serie());
				logger.debug("serieDTO.getNum_serie() : "	+ serieDTO.getNum_serie());
			} else {
				cstmt.setNull(2, java.sql.Types.NULL);
				logger.debug("serieDTO.getNum_serie() : se asigno null");
			}			
			
			cstmt.setInt(3,serieDTO.getCodCanal());
			logger.debug("serieDTO.getCodCanal() : "	+ serieDTO.getCodCanal());
			cstmt.setInt(4,serieDTO.getCodModVenta());
			logger.debug("serieDTO.getCodModVenta() : "	+ serieDTO.getCodModVenta());
			cstmt.setLong(5,serieDTO.getCod_vendedor());
			logger.debug("serieDTO.getCod_vendedor() : "	+ serieDTO.getCod_vendedor());				
			cstmt.setString(6,serieDTO.getTipArticulo());
			logger.debug("serieDTO.getTipArticulo() : "	+ serieDTO.getTipArticulo());
			cstmt.setString(7,serieDTO.getCodTecnologia());
			logger.debug("serieDTO.getCodTecnologia() : "	+ serieDTO.getCodTecnologia());
			cstmt.setString(8,serieDTO.getTipTerminal()); 
			logger.debug("serieDTO.getTipTerminal() : "	+ serieDTO.getTipTerminal());  
			cstmt.setLong(9,serieDTO.getCod_uso()); 
			logger.debug("serieDTO.getCod_uso() : "	+ serieDTO.getCod_uso());
			cstmt.setLong(10,serieDTO.getCod_central()); 
			logger.debug("serieDTO.getCod_central() : "	+ serieDTO.getCod_central());
			cstmt.setString(11,serieDTO.getCod_hlr()); 
			logger.debug("serieDTO.getCod_hlr() : "	+ serieDTO.getCod_hlr());
			
		    cstmt.registerOutParameter(12,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			
			logger.debug("obtieneSerie:Antes exec");
			cstmt.execute();
			logger.debug("obtieneSerie:Despues exec");
			
			codError = cstmt.getInt(13);
			msgError = cstmt.getString(14);
			numEvento = cstmt.getInt(15);
			
			logger.debug("obtieneSerie:codError : " + codError );
			logger.debug("obtieneSerie:msgError : " + msgError );
			logger.debug("obtieneSerie:numEvento : " + numEvento );

			if (codError != 0) {					
				logger.error("Ocurrió un error al buscar la serie");
				throw new ProductException(String.valueOf(codError), numEvento, msgError);
				
			}
			logger.debug("Recuperando serie");
			List lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(12);
			while (rs.next()) {						
				SerieDTO outSerieDTO = new SerieDTO();
				outSerieDTO.setNum_serie(rs.getString(1));
				outSerieDTO.setNum_telefono(rs.getLong(5));
				//DateFormat df = new SimpleDateFormat("dd/MM/yyyy");					
				outSerieDTO.setFec_entrada(rs.getDate(6));//  19/10/2007 13:54:53
				lista.add(outSerieDTO);
			}					
			resultado =(SerieDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SerieDTO.class);
			logger.debug("recuperando serie, resultado: "+resultado.length);
			logger.debug("Fin recuperando serie");
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar la serie",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(msgError,e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtieneSerie()");

		return resultado;
	}
	
	private String getSQLDatosSerie(String packageName, String procedureName, int paramCount) {
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatosSimcard
	
	public SerieDTO[] obtieneSeries(SerieDTO serieDTO) throws ProductException {
		SerieDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLDatosSerie("PV_SERVICIOS_POSVENTA_PG","PV_getList_Series_PR",13);//"VE_SERVICIOS_VENTA_PG","ve_getlist_series_pr"
			logger.debug("sql[" + call + "]");				
			cstmt = conn.prepareCall(call);				
			logger.debug("obtieneSeries.DAO:inicio");				
			cstmt.setLong(1,serieDTO.getCod_bodega());
			logger.debug("serieDTO.getCod_bodega() : "	+ serieDTO.getCod_bodega());
			cstmt.setLong(2,serieDTO.getCod_articulo());
			logger.debug("serieDTO.getCod_articulo() : "	+ serieDTO.getCod_articulo());
			cstmt.setString(3,serieDTO.getCod_hlr());
			logger.debug("serieDTO.getCod_hlr() : "	+ serieDTO.getCod_hlr());
			cstmt.setInt(4,serieDTO.getCodModVenta());
			logger.debug("serieDTO.getCodModVenta() : "	+ serieDTO.getCodModVenta());
			cstmt.setLong(5,serieDTO.getCodCanal());
			logger.debug("serieDTO.getCodCanal() : "	+ serieDTO.getCodCanal());
			cstmt.setLong(6,serieDTO.getCod_vendedor());
			logger.debug("serieDTO.getCod_vendedor() : "	+ serieDTO.getCod_vendedor());
			cstmt.setLong(7,serieDTO.getCod_central());
			logger.debug("serieDTO.getCod_central() : "	+ serieDTO.getCod_central());
			cstmt.setLong(8,serieDTO.getCod_uso());
			logger.debug("serieDTO.getCod_uso() : "	+ serieDTO.getCod_uso());
			cstmt.setString(9,serieDTO.getTipArticulo());
			logger.debug("serieDTO.getCodTipArticulo() : "	+ serieDTO.getTipArticulo());
			
			
			cstmt.registerOutParameter(10,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			
			logger.debug("obtieneSeries:Antes exec");
			cstmt.execute();
			logger.debug("obtieneSeries:Despues exec");
			
			try {
				codError = cstmt.getInt(11);
				logger.debug("obtieneSeries:codError : " + codError );
				msgError = cstmt.getString(12);
				logger.debug("obtieneSeries:msgError : " + msgError );
				numEvento = cstmt.getInt(13);
				logger.debug("obtieneSeries:numEvento : " + numEvento );
			} catch (Throwable e) {
				logger.error("Ocurrió un error al listar la serie",e);
				e.printStackTrace();
			}
			
			if (codError != 0) {					
				logger.error("Ocurrió un error al listar la serie");
				throw new ProductException("Ocurrió un error al listar la serie", String.valueOf(codError), numEvento, msgError);
				
			}
			logger.debug("Recuperando serie");
			List lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(10);
			
			while (rs.next()) {						
				SerieDTO outSerieDTO = new SerieDTO();						
				outSerieDTO.setNum_serie(rs.getString(2));						
				outSerieDTO.setNum_telefono(rs.getLong(4));
				//DateFormat df = new SimpleDateFormat("dd/MM/yyyy");					
				outSerieDTO.setFec_entrada(rs.getDate(9));//  19/10/2007 13:54:53
				lista.add(outSerieDTO);
			}					
			resultado =(SerieDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SerieDTO.class);
			logger.debug("recuperando serie, resultado: "+resultado.length);
			logger.debug("Fin recuperando serie");
		

			logger.debug(" Finalizo ejecución");
			logger.debug(" Recuperando salidas");

		} catch (Exception e) {
			logger.error("Ocurrió un error al listar la serie",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException("Ocurrió un error al listar la serie",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtieneSeries()");

		return resultado;
		
	}
	
	public ArticuloInDTO[] obtieneArticulos(ArticuloInDTO articuloDTO) throws ProductException {
		logger.debug("Inicio:obtieneArticulos()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ArticuloInDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		ResultSet rs = null;
		logger.debug("Conexion obtenida OK");
		
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		   String call = getSQLDatosSerie("Ve_Servicios_Venta_Pg", "VE_Obtiene_Articulos_PR",8);
		   logger.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setString(1,articuloDTO.getCod_tecnologia());
		   logger.debug("entrada.getCod_tecnologia()" + articuloDTO.getCod_tecnologia());
		   cstmt.setString(2,articuloDTO.getTipTerminal());
		   logger.debug("entrada.getTipTerminal()" + articuloDTO.getTipTerminal());
		   cstmt.setString(3,articuloDTO.getIndEquipo());	
		   logger.debug("entrada.getIndEquipo()" + articuloDTO.getIndEquipo());
		   cstmt.setInt(4,articuloDTO.getCodUso());
		   logger.debug("entrada.getCodUso()" + articuloDTO.getCodUso());
		   cstmt.registerOutParameter(5,OracleTypes.CURSOR);
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
		     
		   cstmt.execute();		   
		   logger.debug("obtieneArticulos:Execute Despues");
		   
		   codError = cstmt.getInt(6);
		   msgError = cstmt.getString(7);
		   numEvento = cstmt.getInt(8);
		 
		   logger.debug("codError[" + codError + "]");
		   logger.debug("msgError[" + msgError + "]");
		   logger.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    logger.error("Ocurrió un error al recuperar listado de articulos ");
			    throw new ProductException("Ocurrió un error al recuperar listado de articulos", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				logger.debug("Recuperando listado de articulos");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(5);
				while (rs.next()) 
				{
					ArticuloInDTO outArticuloDTO = new ArticuloInDTO();
					outArticuloDTO.setCodArticulo(rs.getLong(1));
					outArticuloDTO.setDesArticulo(rs.getString(2));
					outArticuloDTO.setMesGarantia(rs.getInt(3));		
					outArticuloDTO.setTipoArticulo(rs.getLong(4));
					lista.add(outArticuloDTO);
				}				
				resultado =(ArticuloInDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ArticuloInDTO.class);
		  
				logger.debug("Fin recuperacion de listado de articulos");
			}
		   
		   if (logger.isDebugEnabled())
		    logger.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   logger.error("Ocurrió un error al obtener listado de articulos",e);
			   if (logger.isDebugEnabled()) {
			    logger.debug("Codigo de Error[" + codError + "]");
			    logger.debug("Mensaje de Error[" + msgError + "]");
			    logger.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof ProductException){
				  throw (ProductException) e;
			   }
		  } 
		  finally {
		    if (logger.isDebugEnabled()) 
		    logger.debug("Cerrando conexiones...");
			   try {
				   if (rs != null) {
						rs.close();
					}
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    logger.debug("SQLException", e);
			   }
		  }
		  logger.debug("obtieneArticulos():end");
		return resultado;
	}
	
	public BodegaDTO[] obtieneBodega(BodegaDTO bodegaDTO) throws ProductException {
		logger.debug("Inicio:getBodegas()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		BodegaDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		
		ResultSet rs = null;
		logger.debug("Conexion obtenida OK");
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLDatosSerie("VE_PARAMETROS_COMERCIALES_PG", "VE_Obtiene_Bodegas_PR",5);
		   logger.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,bodegaDTO.getCodVendedor());	 	   
		   cstmt.registerOutParameter(2,OracleTypes.CURSOR);
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		   
		   logger.debug("getBodegas:Execute Antes");
		   cstmt.execute();		   
		   logger.debug("getBodegas:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   logger.debug("codError[" + codError + "]");
		   logger.debug("msgError[" + msgError + "]");
		   logger.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {
			    logger.error("Ocurrió un error al recuperar listado de bodegas ");
			    throw new ProductException("Ocurrió un error al recuperar listado de bodegas", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				logger.debug("Recuperando listado de bodegas");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					BodegaDTO outBodega = new BodegaDTO();
					outBodega.setCod_bodega(String.valueOf(rs.getLong(1)));
					outBodega.setDes_bodega(rs.getString(2));					
					lista.add(outBodega);
				}				
				resultado =(BodegaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), BodegaDTO.class);
		  
				logger.debug("Fin recuperacion de listado de bodegas");
			}
		   
		   if (logger.isDebugEnabled())
		    logger.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   logger.error("Ocurrió un error al obtener listado de bodegas",e);
			   if (logger.isDebugEnabled()) {
			    logger.debug("Codigo de Error[" + codError + "]");
			    logger.debug("Mensaje de Error[" + msgError + "]");
			    logger.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof ProductException){
				  throw (ProductException) e;
			   }
		  } 
		  finally {
		    if (logger.isDebugEnabled()) 
		    logger.debug("Cerrando conexiones...");
			   try {
				   if (rs != null) {
						rs.close();
				   }
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    logger.debug("SQLException", e);
			   }
		  }
		  logger.debug("getBodegas():end");
		return resultado;
	}
// fin RRG 70904 24-09-2008 COL
	
	public RetornoDTO validaSerieExternaEquipo(SerieDTO serie) throws ProductException {
		logger.debug("validaSerieExternaEquipo():start");
		RetornoDTO retValue= null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLValidaSerieExternaEquipo();
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			logger.debug(call);
			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("cod_producto ["+serie.getCod_producto()+"]");
			logger.debug("num_serie ["+serie.getNum_serie()+"]");
			logger.debug("tip_terminal ["+serie.getTipTerminal()+"]");

			cstmt.setLong(1, serie.getCod_producto());
			cstmt.setString(2, serie.getNum_serie());
			cstmt.setString(3, serie.getTipTerminal());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError == 4) {
				logger.error(" Ocurrió un error general al validar Serie Externa");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			} else if (codError != 4 && codError != 0){
				retValue=new RetornoDTO();				
				retValue.setResultado(true);
				//retValue.setDescripcion(String.valueOf(cstmt.getInt(3)));
				retValue.setDescripcion(msgError);

				//retValue.setDescripcion("OK") ;
				retValue.setCodigo(String.valueOf(codError));
			} else if (codError == 0) {
				retValue=new RetornoDTO();				
				retValue.setResultado(true);
				//retValue.setDescripcion(String.valueOf(cstmt.getInt(3)));
				retValue.setDescripcion("");

				//retValue.setDescripcion("OK") ;
				retValue.setCodigo(String.valueOf(codError));
			}


			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al validar Serie Externa",
					e);
			throw new ProductException(
					"Ocurrió un error general al validar Serie Externa", e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("validaSerieExternaEquipo():end");
		return retValue;			
	}
	
	
	//INICIO 177697 PAH 
	public SerieDTO[] obtieneSeriesSinUso(SerieDTO serieDTO) throws ProductException {
		SerieDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLDatosSerie("PV_SERVICIOS_POSVENTA_PG","PV_getList_Series_SinUso_PR",12);
			logger.debug("sql[" + call + "]");				
			cstmt = conn.prepareCall(call);				
			logger.debug("obtieneSeries.DAO:inicio");				
			cstmt.setLong(1,serieDTO.getCod_bodega());
			logger.debug("serieDTO.getCod_bodega() : "	+ serieDTO.getCod_bodega());
			cstmt.setLong(2,serieDTO.getCod_articulo());
			logger.debug("serieDTO.getCod_articulo() : "	+ serieDTO.getCod_articulo());
			cstmt.setString(3,serieDTO.getCod_hlr());
			logger.debug("serieDTO.getCod_hlr() : "	+ serieDTO.getCod_hlr());
			cstmt.setInt(4,serieDTO.getCodModVenta());
			logger.debug("serieDTO.getCodModVenta() : "	+ serieDTO.getCodModVenta());
			cstmt.setLong(5,serieDTO.getCodCanal());
			logger.debug("serieDTO.getCodCanal() : "	+ serieDTO.getCodCanal());
			cstmt.setLong(6,serieDTO.getCod_vendedor());
			logger.debug("serieDTO.getCod_vendedor() : "	+ serieDTO.getCod_vendedor());
			cstmt.setLong(7,serieDTO.getCod_central());
			logger.debug("serieDTO.getCod_central() : "	+ serieDTO.getCod_central());
			cstmt.setString(8,serieDTO.getTipArticulo());
			logger.debug("serieDTO.getCodTipArticulo() : "	+ serieDTO.getTipArticulo());
			
			
			cstmt.registerOutParameter(9,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			
			logger.debug("obtieneSeriesSinUso:Antes exec");
			cstmt.execute();
			logger.debug("obtieneSeriesSinUso:Despues exec");
			
			try {
				codError = cstmt.getInt(10);
				logger.debug("obtieneSeriesSinUso:codError : " + codError );
				msgError = cstmt.getString(11);
				logger.debug("obtieneSeriesSinUso:msgError : " + msgError );
				numEvento = cstmt.getInt(12);
				logger.debug("obtieneSeriesSinUso:numEvento : " + numEvento );
			} catch (Throwable e) {
				logger.error("Ocurrió un error al listar la serie",e);
				e.printStackTrace();
			}
			
			if (codError != 0) {					
				logger.error("Ocurrió un error al listar la serie");
				throw new ProductException("Ocurrió un error al listar la serie", String.valueOf(codError), numEvento, msgError);
				
			}
			logger.debug("Recuperando serie");
			List lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(9);
			
			while (rs.next()) {						
				SerieDTO outSerieDTO = new SerieDTO();						
				outSerieDTO.setNum_serie(rs.getString(2));						
				outSerieDTO.setNum_telefono(rs.getLong(4));
				//DateFormat df = new SimpleDateFormat("dd/MM/yyyy");					
				outSerieDTO.setFec_entrada(rs.getDate(9));//  19/10/2007 13:54:53
				lista.add(outSerieDTO);
			}					
			resultado =(SerieDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SerieDTO.class);
			logger.debug("recuperando serie, resultado: "+resultado.length);
			logger.debug("Fin recuperando serie");
		

			logger.debug(" Finalizo ejecución");
			logger.debug(" Recuperando salidas");

		} catch (Exception e) {
			logger.error("Ocurrió un error al listar la serie",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException("Ocurrió un error al listar la serie",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtieneSeries()");

		return resultado;	
	}
	//FIN 177697 PAH
	
}
