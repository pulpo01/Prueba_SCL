package com.tmmas.scl.wsventaenlace.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.driver.OracleTypes;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.wsventaenlace.businessobject.dao.helper.DAOHelper;
import com.tmmas.scl.wsventaenlace.businessobject.dao.helper.JUnitConexion;
import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.transport.vo.AbonadoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.CentralesVO;
import com.tmmas.scl.wsventaenlace.transport.vo.ClienteVO;
import com.tmmas.scl.wsventaenlace.transport.vo.DatosGeneralesVO;
import com.tmmas.scl.wsventaenlace.transport.vo.OOSSDatosBasicosClienteVO;
import com.tmmas.scl.wsventaenlace.transport.vo.OOSSRecargaPrepagoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.OOSSVO;
import com.tmmas.scl.wsventaenlace.transport.vo.ParametroGeneralListVO;
import com.tmmas.scl.wsventaenlace.transport.vo.ParametroGeneralVO;
import com.tmmas.scl.wsventaenlace.transport.vo.PlanTarifarioVO;
import com.tmmas.scl.wsventaenlace.transport.vo.VendedorVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.NumeroPilotoHVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.NumeroPilotoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.OOSSAsociaRangoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.RangoVO;

public class AsociaDesasociaRangoDAO extends BaseDAO {
	private static final LoggerHelper logger = LoggerHelper.getInstance();
	private static final String nombreClase = AsociaDesasociaRangoDAO.class.getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	private DAOHelper daoHelper = new DAOHelper();
	private UtilesDAO utilesDAO = new UtilesDAO();

	/**
	 * Metodo para insertar en movimiento en centrales, tabla ICC_MOVIMIENTO.
	 * 
	 * @author Matías Guajardo U.
	 * @throws ServicioVentasEnlaceException
	 */
	public void insertaMovimientoCentrales(CentralesVO centralesVO) throws ServicioVentasEnlaceException {

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info("insertaMovimientoCentrales():start", nombreClase);

		try {
			
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			
			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_insta_movimiento_PR", 59);
			cstmt = conn.prepareCall(call);
			logger.info(".SQL[" + call + "]", nombreClase);

			cstmt.setLong(1, centralesVO.getNumMovimiento().longValue());
			logger.info("num movimiento centrales " + centralesVO.getNumMovimiento().longValue(), nombreClase);
			cstmt.setLong(2, centralesVO.getNumAbonado());
			logger.info("num abonado centrales " + centralesVO.getNumAbonado(), nombreClase);
			cstmt.setLong(3, centralesVO.getCodEstado());
			logger.info("cod estado centrales " + centralesVO.getCodEstado(), nombreClase);
			cstmt.setString(4, centralesVO.getCodActabo());
			cstmt.setString(5, centralesVO.getCodModulo());
			cstmt.setLong(6, centralesVO.getNumIntentos());
			cstmt.setString(7, centralesVO.getCodCentralNue() != null ? String.valueOf(centralesVO.getCodCentralNue().longValue()) : null);
			cstmt.setString(8, centralesVO.getDesRespuesta());
			cstmt.setLong(9, centralesVO.getCodActuacion());
			cstmt.setString(10, centralesVO.getNomUsuarOra());
			cstmt.setTimestamp(11, centralesVO.getFecIngreso());
			cstmt.setString(12, centralesVO.getTipTerminal());
			cstmt.setLong(13, centralesVO.getCodCentral().longValue());
			cstmt.setTimestamp(14, centralesVO.getFecLectura());
			cstmt.setInt(15, centralesVO.getIndBloqueo());
			cstmt.setTimestamp(16, centralesVO.getFecEjecucion());
			cstmt.setString(17, centralesVO.getTipTerminalNue());
			cstmt.setString(18, centralesVO.getNumMovant() != null ? String.valueOf(centralesVO.getNumMovant().longValue()) : null);
			cstmt.setLong(19, centralesVO.getNumCelular().longValue());
			cstmt.setString(20, centralesVO.getNumMovPos() != null ? String.valueOf(centralesVO.getNumMovPos().longValue()) : null);
			cstmt.setString(21, centralesVO.getNumSerie());
			cstmt.setString(22, centralesVO.getNumPersonal());
			cstmt.setString(23, centralesVO.getNumCelularNue() != null ? String.valueOf(centralesVO.getNumCelularNue().longValue()) : null);
			cstmt.setString(24, centralesVO.getNumSerieNue());
			cstmt.setString(25, centralesVO.getNumPersonalNue());
			cstmt.setString(26, centralesVO.getNumMsnb());
			cstmt.setString(27, centralesVO.getNumMsnbNue());
			cstmt.setString(28, centralesVO.getCodSusPreha());
			cstmt.setString(29, centralesVO.getCodServicios());
			cstmt.setString(30, centralesVO.getNumMin());
			cstmt.setString(31, centralesVO.getNumMinNue());
			cstmt.setString(32, String.valueOf(centralesVO.getSta()));
			cstmt.setString(33, centralesVO.getCodMensaje() != null ? String.valueOf(centralesVO.getCodMensaje().longValue()) : null);
			cstmt.setString(34, centralesVO.getParam1Mens());
			cstmt.setString(35, centralesVO.getParam2Mens());
			cstmt.setString(36, centralesVO.getParam3Mens());
			cstmt.setString(37, centralesVO.getPlan());
			cstmt.setString(38, centralesVO.getCarga() != null ? String.valueOf(centralesVO.getCarga().doubleValue()) : null);
			cstmt.setString(39, centralesVO.getValorPlan() != null ? String.valueOf(centralesVO.getValorPlan().doubleValue()) : null);
			cstmt.setString(40, centralesVO.getPin());
			cstmt.setTimestamp(41, centralesVO.getFecExpira());
			cstmt.setString(42, centralesVO.getDesMensaje());
			cstmt.setString(43, centralesVO.getCodPin());
			cstmt.setString(44, centralesVO.getCodIdioma());
			cstmt.setString(45, centralesVO.getCodEnrutamiento() != null ? String.valueOf(centralesVO.getCodEnrutamiento().longValue()) : null);
			cstmt.setString(46, null);// tipEnrutamiento
			cstmt.setString(47, null);// desorigenpin
			cstmt.setString(48, null);// num_lote_pin
			cstmt.setString(49, null);// num_serie_pin
			cstmt.setString(50, centralesVO.getTipTecnologia());
			cstmt.setString(51, centralesVO.getImsi());
			cstmt.setString(52, centralesVO.getImsiNue());
			cstmt.setString(53, centralesVO.getImei());
			cstmt.setString(54, centralesVO.getImeiNue());
			cstmt.setString(55, centralesVO.getIcc());
			cstmt.setString(56, centralesVO.getIccNue());

			cstmt.registerOutParameter(57, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(58, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(59, java.sql.Types.NUMERIC);

			logger.info(". Iniciando Ejecución", nombreClase);
			logger.info(".Execute Antes", nombreClase);

			cstmt.execute();
			logger.info(".Execute Despues", nombreClase);
			logger.info(". Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(57);
			msgError = cstmt.getString(58);
			numEvento = cstmt.getInt(59);

			logger.info(".codError[" + codError + "]", nombreClase);
			logger.info(".msgError[" + msgError + "]", nombreClase);
			logger.info(".numEvento[" + numEvento + "]", nombreClase);

			daoHelper.evaluaResultado("ERR.0065", codError, global.getValor("ERR.0065"));

		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(e,nombreClase);
				logger.error(".Codigo de Error[" + codError + "]", nombreClase);
				logger.error(".Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error(".Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;

		} finally {
			logger.info(".Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.error(e, nombreClase);
			}
		}
		logger.info(".insertaMovimientoCentrales():end", nombreClase);
	}

	/**
	 * Metodo en el cual define que por cada objeto de tipo orden de servicio se debe implemetar la inserción de la orden de servicio.
	 * 
	 * @author H&eacute;ctor Hermosilla
	 * @param OOSSVO
	 * @exception ServicioVentasEnlaceException
	 */

	public void insertarOOSS(OOSSVO oOSSVO) throws ServicioVentasEnlaceException {
		// TODO Auto-generated method stub
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		logger.debug("insertarOOSS():start", nombreClase);
		try {

			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "pv_insertar_os_pr", 11);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]", nombreClase);
			cstmt.setLong(1, oOSSVO.getNumOS().longValue());
			cstmt.setString(2, oOSSVO.getCodOS());
			cstmt.setInt(3, oOSSVO.getProducto().intValue());
			cstmt.setString(4, oOSSVO.getGrupoOS());
			cstmt.setLong(5, oOSSVO.getCodInter().longValue());
			cstmt.setString(6, oOSSVO.getNomUsuarioSCL());
			System.out.println("Fecha" + oOSSVO.getFechaOS());
			cstmt.setTimestamp(7, oOSSVO.getFechaOS());
			cstmt.setString(8, oOSSVO.getComentario());
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

			logger.debug(" Iniciando Ejecución", nombreClase);
			logger.debug("Execute Antes", nombreClase);

			cstmt.execute();
			logger.debug("Execute Despues", nombreClase);
			logger.debug(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);

			logger.debug("codError[" + codError + "]", nombreClase);
			logger.debug("msgError[" + msgError + "]", nombreClase);
			logger.debug("numEvento[" + numEvento + "]", nombreClase);

			daoHelper.evaluaResultado("ERR.0019", codError, global.getValor("ERR.0019"));

		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.debug("Codigo de Error[" + codError + "]", nombreClase);
				logger.debug("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.debug("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {

			logger.debug("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.debug("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.debug("insertarOOSS():end", nombreClase);
	}

	/**
	 * Obtiene datos asociados a una orden de servicio en tabla CI_TIPORSERV
	 * 
	 * @author H&eacute;ctor Hermosilla
	 * @param OOSSVO
	 *            oOSSVO
	 * @exception ServicioVentasEnlaceException
	 */
	public void consultarDatosOOSS(OOSSVO oOSSVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.debug("consultarDatosOOSS():start", nombreClase);
		try {

			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}

			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_CON_DATOS_OOSS_PR", 6);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]", nombreClase);
			cstmt.setString(1, oOSSVO.getCodOS());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug(" Iniciando Ejecución", nombreClase);
			logger.debug("Execute Antes", nombreClase);

			cstmt.execute();

			logger.debug("Execute Despues", nombreClase);
			logger.debug(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			logger.debug("codError[" + codError + "]", nombreClase);
			logger.debug("msgError[" + msgError + "]", nombreClase);
			logger.debug("numEvento[" + numEvento + "]", nombreClase);

			daoHelper.evaluaResultado("ERR.0067", codError, global.getValor("ERR.0067"));

			oOSSVO.setCodActuacion(cstmt.getString(2));
			oOSSVO.setGrupoOS(cstmt.getString(3));
		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.debug("Codigo de Error[" + codError + "]", nombreClase);
				logger.debug("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.debug("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {

			logger.debug("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.debug("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.debug("consultarDatosOOSS():end", nombreClase);
	}

	/**
	 * Consulta en la base de datos el numero de secuencia asociado a cualquier tabla de la BD
	 * 
	 * @author H&eacute;ctor Hermosilla
	 * @param DatosGeneralesVO
	 * @exception ServicioVentasEnlaceException
	 */
	public void consultarNumeroSecuencia(DatosGeneralesVO datosGeneralesVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.debug("consultarNumeroSecuencia():start", nombreClase);
		try {
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_REC_SECUENCIA_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]", nombreClase);
			cstmt.setString(1, datosGeneralesVO.getNombreSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug(" Iniciando Ejecución", nombreClase);
			logger.debug("Execute Antes", nombreClase);

			cstmt.execute();

			logger.debug("Execute Despues", nombreClase);
			logger.debug(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			logger.debug("codError[" + codError + "]", nombreClase);
			logger.debug("msgError[" + msgError + "]", nombreClase);
			logger.debug("numEvento[" + numEvento + "]", nombreClase);

			daoHelper.evaluaResultado("ERR.0186", codError, global.getValor("ERR.0186"));
			datosGeneralesVO.setNroSecuencia(new Long(cstmt.getLong(2)));
		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {

			logger.debug("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.error("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.debug("consultarNumeroSecuencia():end", nombreClase);

	}

	/**
	 * Este metodo consulta los datos basicos de un cliente. NOM_CLIENTE <br>
	 * NOM_APECLIEN1 <br>
	 * NOM_APECLIEN2 <br>
	 * COD_TIPIDENT <br>
	 * DES_TIPIDENT <br>
	 * NUM_IDENT <br>
	 * COD_CUENTA <br>
	 * DES_CUENTA <br>
	 * 
	 * Paquete: Pv_ventas_enlace_vpn_Pg Procedimiento: pv_cnslta_dat_basicosclt_pr
	 * 
	 * @author Santiago Ventura
	 * @param datosBasicosClienteVO
	 * @throws ServicioVentasEnlaceException
	 *             08/07/2008 17:09:44
	 */
	public void consultaDatosBasicosCliente(OOSSDatosBasicosClienteVO datosBasicosClienteVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info("consultaDatosBasicosCliente():start", nombreClase);

		try {
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "pv_cnslta_dat_basicosclt_pr", 12);
			cstmt = conn.prepareCall(call);

			logger.info("SQL[" + call + "]", nombreClase);
			cstmt.setLong(1, datosBasicosClienteVO.getCodCliente().longValue());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);

			cstmt.execute();

			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento = cstmt.getInt(12);
			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);
			System.out.println(codError);

			int err = Integer.parseInt(global.getValor("DAO.ERRORES.TD.CLIENTE.DAO"));
			System.out.println(err);
			if (codError == err) {
				daoHelper.evaluaResultado("ERR_0402PAN", codError, global.getValor("ERR.0402"));
			}
			daoHelper.evaluaResultado("ERR_0401PAN", codError, global.getValor("ERR.0401"));

			// SV_NOM_CLIENTE
			datosBasicosClienteVO.setNomCliente(cstmt.getString(2));
			// SV_NOM_APECLIEN1
			datosBasicosClienteVO.setApellido1(cstmt.getString(3));
			// SV_NOM_APECLIEN2
			datosBasicosClienteVO.setApellido2(cstmt.getString(4));
			// SV_COD_TIPIDENT
			datosBasicosClienteVO.setCodTipIdent(cstmt.getString(5));
			// SV_DES_TIPIDENT
			datosBasicosClienteVO.setDesTipIdent(cstmt.getString(6));
			// SV_NUM_IDENT
			datosBasicosClienteVO.setNumIdent(cstmt.getString(7));
			// SN_COD_CUENTA
			datosBasicosClienteVO.setCodCuenta(new Long(cstmt.getLong(8)));
			// SV_DES_CUENTA
			datosBasicosClienteVO.setDesCuenta(cstmt.getString(9));
			utilesDAO.imprimirPropiedades(datosBasicosClienteVO.getClass(), datosBasicosClienteVO, "consultaDatosBasicosCliente");
		} catch (Exception e) {
			e.printStackTrace();
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;

		} finally {
			logger.info("Cerrando conexiones...", nombreClase);
			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e.getMessage() + "]", nombreClase);
			}
		}
		logger.info("consultaDatosBasicosCliente():end", nombreClase);
	}

	/**
	 * Metodo para consultar paramatros de la tabla GED_PARAMETROS para el servicio de cambio de equipo GSM.
	 * 
	 * @author Matías Guajardo U.
	 * @param datosVO
	 * @return retorno
	 * @throws ServicioVentasEnlaceException
	 */
	public void consultaParametros(DatosGeneralesVO datosVO) throws ServicioVentasEnlaceException {

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.debug("consultaParametros():start", nombreClase);

		try {
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_cnslta_parametro_PR", 10);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]", nombreClase);

			cstmt.setLong(1, datosVO.getCodProducto());
			cstmt.setString(2, datosVO.getCodModulo());
			cstmt.setString(3, datosVO.getNomParametro());

			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.DATE);

			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			logger.debug(" Iniciando Ejecución", nombreClase);
			logger.debug("Execute Antes", nombreClase);

			cstmt.execute();

			logger.debug("Execute Despues", nombreClase);
			logger.debug(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);

			logger.debug("codError[" + codError + "]", nombreClase);
			logger.debug("msgError[" + msgError + "]", nombreClase);
			logger.debug("numEvento[" + numEvento + "]", nombreClase);

			//daoHelper.evaluaResultado("ERR_BD0124PAN", codError, global.getValor("ERR.0124"));

			datosVO.setValParametro(cstmt.getString(4));
			logger.debug("valParametro" + cstmt.getString(4), nombreClase);
			datosVO.setDesParametro(cstmt.getString(5));
			datosVO.setNomUsuario(cstmt.getString(6));
			datosVO.setFecAlta(cstmt.getTimestamp(7));

		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.debug("Codigo de Error[" + codError + "]", nombreClase);
				logger.debug("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.debug("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {

			logger.debug("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.debug("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.debug("consultaParametros():end", nombreClase);

	}

	/**
	 * Metodo para consultar paramétros de la tabla GED_PARAMETROS para el servicio de cambio de equipo GSM.
	 * con un a.nom_parametro like EV_nom_parametro || '%';
	 * @author Matías Guajardo U.
	 * @param datosVO
	 * @return retorno
	 * @throws ServicioVentasEnlaceException
	 */
	public ParametroGeneralListVO consultaParametrosLK(DatosGeneralesVO datosVO) throws ServicioVentasEnlaceException {

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ParametroGeneralListVO parametroGeneralList = null;
		ParametroGeneralVO[] parametrosGenerales = null;
		logger.debug("consultaParametrosLK():start", nombreClase);

		try {
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_cnslta_parametro_LK_PR", 7);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]", nombreClase);

			cstmt.setLong(1, datosVO.getCodProducto());
			cstmt.setString(2, datosVO.getCodModulo());
			cstmt.setString(3, datosVO.getNomParametro());
			
			cstmt.registerOutParameter(4, OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.debug(" Iniciando Ejecución", nombreClase);
			logger.debug("Execute Antes", nombreClase);

			cstmt.execute();

			logger.debug("Execute Despues", nombreClase);
			logger.debug(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			logger.debug("codError[" + codError + "]", nombreClase);
			logger.debug("msgError[" + msgError + "]", nombreClase);
			logger.debug("numEvento[" + numEvento + "]", nombreClase);

			//daoHelper.evaluaResultado("ERR_BD0124PAN", codError, global.getValor("ERR.0124"));
			ResultSet rs = (ResultSet) cstmt.getObject(4);
			ParametroGeneralVO parametroGeneral = null;
			List parametros = new ArrayList();
			codError = 1;
			while (rs.next()) {
				parametroGeneral = new ParametroGeneralVO();
				parametroGeneral.setValParametro(rs.getString(1));
				parametroGeneral.setDesParametro(rs.getString(2));
				parametroGeneral.setNomUsuario(rs.getString(3));
				parametroGeneral.setFecAlta(rs.getTimestamp(4));
				parametroGeneral.setNomParametro(rs.getString(5));
				logger.debug("valParametro" + parametroGeneral.getValParametro(), nombreClase);
				logger.debug("nomParametro" + parametroGeneral.getNomParametro(), nombreClase);
				parametros.add(parametroGeneral);
			}
			parametrosGenerales = (ParametroGeneralVO[]) ArrayUtl.copiaArregloTipoEspecifico(	parametros.toArray(), ParametroGeneralVO.class);
			parametroGeneralList = new ParametroGeneralListVO();
			parametroGeneralList.setParametrosGenerales(parametrosGenerales);	
			rs.close();

		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.debug("Codigo de Error[" + codError + "]", nombreClase);
				logger.debug("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.debug("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {

			logger.debug("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.debug("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.debug("consultaParametrosLK():end", nombreClase);
		return parametroGeneralList;
	}
	
	/**
	 * Obtiene el grupo tecnologico del abonado. Invoca a PL PV_GRUPO_TECNOLOGICO_FN
	 * 
	 * @param abonadoVO
	 * @throws ServicioVentasEnlaceException
	 * @author Héctor Hermosilla
	 */
	public void consultaGrupoTecnologico(AbonadoVO abonadoVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info("consultaGrupoTecnologico():start", nombreClase);

		try {
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_EJEC_PV_GRUPO_TEC_FN_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.info("SQL[" + call + "]", nombreClase);

			cstmt.setString(1, abonadoVO.getCodTecnologia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.info("Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);

			cstmt.execute();
			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);
			daoHelper.evaluaResultado("ERR.0268", codError, global.getValor("ERR.0268"));
			abonadoVO.setCodGrupoTecnologia(cstmt.getString(2));

		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.debug("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.error(e, nombreClase);
			}
		}
		logger.info("consultaGrupoTecnologico():end", nombreClase);
	}

	/**
	 * PACKAGE:Pv_ventas_enlace_vpn_Pg PROCEDIMIENTO:PV_CONS_CICLO_FACT_HIB_PR
	 * 
	 * @param ooSSRecargaPrepagoVO
	 * @throws ServicioVentasEnlaceException
	 *             05/11/2008 14:58:34
	 * @author Santiago Ventura
	 */
	public void validaCicloFactHibrido(OOSSRecargaPrepagoVO ooSSRecargaPrepagoVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.debug("validaCicloFactHibrido:start", nombreClase);
		try {
			utilesDAO.imprimirPropiedades(ooSSRecargaPrepagoVO.getClass(), ooSSRecargaPrepagoVO, "validaCicloFactHibrido");
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}

			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_CONS_CICLO_FACT_HIB_PR", 7);
			cstmt = conn.prepareCall(call);

			logger.info("SQL[" + call + "]", nombreClase);
			// EN_COD_CICLO IN FA_CICLFACT.COD_CICLO%TYPE,
			cstmt.setInt(1, ooSSRecargaPrepagoVO.getCodCicloFact().intValue());
			// EN_COD_CLIENTE IN GA_INFACCEL.COD_CLIENTE %TYPE,
			cstmt.setLong(2, ooSSRecargaPrepagoVO.getCodCliente().longValue());
			// EN_NUM_ABONADO IN GA_INFACCEL.NUM_ABONADO%TYPE,
			cstmt.setLong(3, ooSSRecargaPrepagoVO.getNumAbonado().longValue());
			// SN_EXISTE OUT NOCOPY NUMBER,
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);

			cstmt.execute();

			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);
			int existe = cstmt.getInt(4);
			logger.info("existe[" + existe + "]", nombreClase);
			
			if (existe == 0) {
				/**
				 * TODO: 02DIC2008 No devuelve error al validar el ciclo de facturación Bug Interno HH
				 */
				// daoHelper.evaluaResultado("ERR.0889",codError, global.getValor("ERR.0889"));
				throw new ServicioVentasEnlaceException("ERR.0889", 889, global.getValor("ERR.0889"));
			}
			utilesDAO.imprimirPropiedades(ooSSRecargaPrepagoVO.getClass(), ooSSRecargaPrepagoVO, "validaCicloFactHibrido");
		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.debug("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.debug("validaCicloFactHibrido:end", nombreClase);
	}

	/*
	 * TODO: 19MAY2008 BUG PU-PV-007 Se valida situacion del abonado, no puede tener deuda.
	 */
	public void consultarDeudaAbonado(AbonadoVO abonadoVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info("ConsultarDeudaAbonado:start", nombreClase);

		try {

			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}

			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_cons_deuda_cliente_PR", 5);

			/*
			 * **************************************************************** *COPIA INICIO PROCEDIMIENTO ALMACENADO PARA CLARIDAD DEL CODIGO* **************************************************************** en_num_abonado in co_cartera.NUM_ABONADO%type, sn_count OUT NOCOPY number, SN_cod_retorno OUT NOCOPY ge_errores_pg.CodError, SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError, SN_num_evento
			 * OUT NOCOPY ge_errores_pg.Evento)
			 * 
			 */

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, abonadoVO.getNumAbonado());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();

			int cuenta = cstmt.getInt(2);
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			System.out.println("-->" + "cuenta=" + cuenta + "coderror=" + codError + "msegError=" + msgError + "NumEvento=" + numEvento);

			if (cuenta > 0)
				throw new ServicioVentasEnlaceException("ERR.0345", 345, global.getValor("ERR.0345"));

			logger.info(" Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);

			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

		} catch (Exception e) {
			e.printStackTrace();
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;

		} finally {

			logger.info("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.error("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.info("ConsultarDeudaAbonado():end", nombreClase);
	}

	/**
	 * @param planTarifarioVO
	 * @throws ServiciosSCLFranquiciasDAOException
	 */
	public void obtenerCategoriaPlanTarifario(PlanTarifarioVO planTarifarioVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info(":obtenerCategoriaPlanTarifario():start", nombreClase);
		try {
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_cnslta_categoria_plan_PR", 6);
			cstmt = conn.prepareCall(call);

			logger.info("SQL[" + call + "]", nombreClase);

			cstmt.setLong(1, planTarifarioVO.getCodProducto());
			cstmt.setString(2, planTarifarioVO.getCodPlanTarif());

			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);

			cstmt.execute();

			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);

			daoHelper.evaluaResultado("ERR.0082", codError, global.getValor("ERR.0082"));

			planTarifarioVO.setCodCategoria(cstmt.getString(3));
		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.info("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.info("obtenerCategoriaPlanTarifario():end", nombreClase);
	}

	public void consultarClienteEmpresa(ClienteVO clienteVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info(": consultarClienteEmpresa():start", nombreClase);

		try {

			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}

			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_con_cliente_empresa_PR", 8);
			cstmt = conn.prepareCall(call);
			logger.info(": SQL[" + call + "]", nombreClase);
			cstmt.setLong(1, clienteVO.getCodCliente());
			cstmt.setInt(2, clienteVO.getCodProducto().intValue());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.info(":  Iniciando Ejecución", nombreClase);
			logger.info(": Execute Antes", nombreClase);
			cstmt.execute();
			logger.info(": Execute Despues", nombreClase);
			logger.info(":  Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			logger.info(": codError[" + codError + "]", nombreClase);
			logger.info(": msgError[" + msgError + "]", nombreClase);
			logger.info(": numEvento[" + numEvento + "]", nombreClase);
			daoHelper.evaluaResultado("ERR.0020", codError, global.getValor("ERR.0020"));
			clienteVO.setTipPlanTarif(cstmt.getString(3));
			clienteVO.setCodPlanTarif(cstmt.getString(4));
			clienteVO.setDesPlanTarif(cstmt.getString(5));
		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(e, nombreClase);
				logger.error(": Codigo de Error[" + codError + "]", nombreClase);
				logger.error(": Mensaje de Error[" + msgError + "]", nombreClase);
				;
				logger.error(": Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;

		} finally {
			logger.info(": Cerrando conexiones...", nombreClase);
			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.error(e, nombreClase);
			}
		}
		logger.info(": consultarClienteEmpresa():end", nombreClase);
	}

	/**
	 * Consulta en la base de datos los datos del abonado de tipo postpago en tabla ga_abocel.
	 * 
	 * @author H&eacute;ctor Hermosilla
	 * @param AbonadoVO
	 * @exception ServicioVentasEnlaceException
	 */

	public void consultarAbonadoPostPago(AbonadoVO abonadoVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info("consultarAbonadoPostPago():start", nombreClase);
		try {
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}

			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "PV_con_abonado_pospago_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.info("SQL[" + call + "]", nombreClase);

			cstmt.setLong(1, abonadoVO.getNumAbonado());
			cstmt.registerOutParameter(1, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);

			cstmt.execute();

			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);
			daoHelper.evaluaResultado("ERR.0013", codError, global.getValor("ERR.0013"));
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			codError = 1;
			while (rs.next()) {
				abonadoVO.setNumAbonado(rs.getLong(1));
				abonadoVO.setCodProducto(rs.getString(2));
				abonadoVO.setCodCuenta(new Long(rs.getLong(3)));
				abonadoVO.setCodSubCuenta(rs.getString(4));
				abonadoVO.setCodCliente(rs.getLong(5));
				abonadoVO.setCodUsuario(new Long(rs.getLong(6)));
				abonadoVO.setCodSituacion(rs.getString(7));
				abonadoVO.setCodEstado(rs.getString(8));
				abonadoVO.setCodVendedor(new Long(rs.getLong(9)));
				abonadoVO.setCodVendedorAgente(new Long(rs.getLong(10)));
				abonadoVO.setClaseServicio(rs.getString(11));
				abonadoVO.setCodCargoBasico(rs.getString(12));
				abonadoVO.setCodCredCon(new Long(rs.getLong(13)));
				abonadoVO.setCodCredMor(new Long(rs.getLong(14)));
				abonadoVO.setCodLimCon(rs.getString(15));
				abonadoVO.setCodPlanServ(rs.getString(16));
				abonadoVO.setCodPlanTarif(rs.getString(17));
				abonadoVO.setCodTipContrato(rs.getString(18));
				abonadoVO.setCodUso(new Integer(rs.getInt(19)));
				abonadoVO.setFecActCen(rs.getTimestamp(20));
				abonadoVO.setFecAlta(rs.getTimestamp(21));
				abonadoVO.setFecBaja(rs.getTimestamp(22));
				abonadoVO.setFecBajaCen(rs.getTimestamp(23));
				abonadoVO.setFecFinContra(rs.getTimestamp(24));
				abonadoVO.setFecUltMod(rs.getTimestamp(25));
				abonadoVO.setIndFactur(new Integer(rs.getInt(26)));
				abonadoVO.setIndProcAlta(rs.getString(27));
				abonadoVO.setIndProcEqui(rs.getString(28));
				abonadoVO.setIndRehabi(new Integer(rs.getInt(29)));
				abonadoVO.setIndSeguro(new Integer(rs.getInt(30)));
				abonadoVO.setIndSuspen(new Integer(rs.getInt(31)));
				abonadoVO.setNomusuarora(rs.getString(32));
				abonadoVO.setNumAnexo(rs.getString(33));
				abonadoVO.setNumContrato(rs.getString(34));
				abonadoVO.setNumSerie(rs.getString(35));
				abonadoVO.setNumSerieMec(rs.getString(36));
				abonadoVO.setPerfilAbonado(rs.getString(37));
				abonadoVO.setCodCentral(new Integer(rs.getInt(38)));
				abonadoVO.setNumVenta(new Long(rs.getLong(39)));
				abonadoVO.setCodEmpresa(new Long(rs.getLong(40)));
				abonadoVO.setCodHolding(new Long(rs.getLong(41)));
				abonadoVO.setCodModVenta(new Integer(rs.getInt(42)));
				abonadoVO.setCodCausaBaja(rs.getString(43));
				abonadoVO.setCodCiclo(new Integer(rs.getInt(44)));
				abonadoVO.setCodGrpserv(rs.getString(45));
				abonadoVO.setFecAcepVenta(rs.getTimestamp(46));
				abonadoVO.setFecCumplan(rs.getTimestamp(47));
				abonadoVO.setNumPerContrato(new Integer(rs.getInt(48)));
				abonadoVO.setTipPlanTarif(rs.getString(49));
				abonadoVO.setTipTerminal(rs.getString(50));
				abonadoVO.setFecCumplimen(rs.getTimestamp(51));
				abonadoVO.setFecRecDocum(rs.getTimestamp(52));
				abonadoVO.setIndInsguias(new Integer(rs.getInt(53)));
				abonadoVO.setNumCelular(new Long(rs.getLong(54)));
				abonadoVO.setCodCentralPlex(new Integer(rs.getInt(55)));
				abonadoVO.setCodRegion(rs.getString(56));
				abonadoVO.setCodProvincia(rs.getString(57));
				abonadoVO.setCodCiudad(rs.getString(58));
				abonadoVO.setIndPlexSys(new Integer(rs.getInt(59)));
				abonadoVO.setNumCelularPlex(new Long(rs.getLong(60)));
				abonadoVO.setNumSerieHex(rs.getString(61));
				abonadoVO.setCodCelda(rs.getString(62));
				abonadoVO.setNumPersonal(rs.getString(63));
				abonadoVO.setCodCarrier(new Long(rs.getLong(64)));
				abonadoVO.setCodOpredFija(new Long(rs.getLong(65)));
				abonadoVO.setIndPrepago(new Integer(rs.getInt(66)));
				abonadoVO.setIndSuperTel(new Integer(rs.getInt(67)));
				abonadoVO.setNumTeleFija(rs.getString(68));
				abonadoVO.setCodVendealer(new Long(rs.getLong(69)));

				if (rs.getString(70) == null)
					abonadoVO.setIndDisp(null);
				else
					abonadoVO.setIndDisp(new Integer(rs.getInt(70)));

				abonadoVO.setIndEqPrestado(rs.getString(71));
				abonadoVO.setFecProrroga(rs.getTimestamp(72));
				abonadoVO.setNumMin(rs.getString(73));
				abonadoVO.setNumImei(rs.getString(74));
				abonadoVO.setCodTecnologia(rs.getString(75));
				codError = 0;
			}
			rs.close();

			daoHelper.evaluaResultado("ERR.0013", codError, global.getValor("ERR.0013"));
			utilesDAO.imprimirPropiedades(abonadoVO.getClass(), abonadoVO, "AbonadoDAO");

		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0004"), nombreClase);
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.info("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.error("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.info("consultarAbonadoPostPago():end", nombreClase);
	}

	/**
	 * Obtiene datos asociados al vendedor con el nombre de usuario SCL en tabla ge_seg_usuarios
	 * 
	 * @author H&eacute;ctor Hermosilla
	 * @param vendedorVO
	 * @throws ServicioVentasEnlaceException
	 */
	public void consultaVendedorUsuario(VendedorVO vendedorVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info(":consultaVendedorUsuario():start", nombreClase);
		try {
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}

			String call = daoHelper.getPackageBD("Pv_ventas_enlace_vpn_Pg", "pv_cnslta_vende_usuario_pr", 7);
			cstmt = conn.prepareCall(call);

			logger.info("SQL[" + call + "]", nombreClase);
			cstmt.setString(1, vendedorVO.getNomUsuarioSCL());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);
			cstmt.execute();
			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			logger.info("Codigo de Error[" + codError + "]", nombreClase);
			logger.info("Mensaje de Error[" + msgError + "]", nombreClase);
			logger.info("Numero de Evento[" + numEvento + "]", nombreClase);

			daoHelper.evaluaResultado("ERR.0259", codError, global.getValor("ERR.0259"));

			vendedorVO.setCodVendedor(cstmt.getBigDecimal(2) != null ? new Long(cstmt.getBigDecimal(2).longValue()) : null);
			vendedorVO.setCodTipComis(cstmt.getString(3));
			vendedorVO.setCodOficina(cstmt.getString(4));
		} catch (Exception e) {
			logger.error(e, nombreClase);
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.info("Cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.error(e, nombreClase);
			}
		}
		logger.info(":consultaVendedorUsuario():end", nombreClase);
	}

	// Actualizado
	public void obtieneRangosAsociados(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("obtieneRangosAsociados: por consultar los rangos asociados...", nombreClase);

		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {
			// Sugerir separar codigos de testing
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}

			String call = daoHelper.getPackageBD("PV_VENTAS_ENLACE_VPN_PG", "PV_OBTS_DATOS_RANGO_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.info("SQL[" + call + "]", nombreClase);

			// entrada
			cstmt.setLong(1, asociaRangoVO.getAbonado().getNumAbonado());

			// salida
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);

			// error
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.info(" Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);

			cstmt.execute();

			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);

			// daoHelper.evaluaResultado("ERR.0500", codError,
			// global.getValor("ERR.0500"));

			// salida
			rs = (ResultSet) cstmt.getObject(2);
			RangoVO rangoVO = null;
			List rangos = new ArrayList();

			while (rs.next()) {
				rangoVO = new RangoVO();

				rangoVO.setNumDesde(rs.getLong("NUM_DESDE"));
				rangoVO.setNumHasta(rs.getLong("NUM_HASTA"));
				rangoVO.setFechaAlta(rs.getDate("FECHA_ALTA"));
				rangoVO.setFechaBaja(rs.getDate("FECHA_BAJA"));
				rangoVO.setFechaSuspension(rs.getDate("FECHA_SUSPENSION"));
				rangoVO.setFechaRehabilitacion(rs.getDate("FECHA_REHABILITACION"));
				rangoVO.setFechaModificacion(rs.getDate("FECHA_MODIFICACION"));
				rangoVO.setEstado(rs.getString("ESTADO"));
				rangoVO.setNomUsuarOra(rs.getString("NOM_USUARORA"));

				rangos.add(rangoVO);
			}

			logger.info("obtieneRangosAsociados: list.size = " + rangos.size(), nombreClase);
			logger.info("obtieneRangosAsociados: codError = [" + codError + "], msgError = [" + msgError + "], numEvento = [" + numEvento + "]", nombreClase);

			asociaRangoVO.setRangosAsociados(rangos);
			daoHelper.evaluaResultado("ERR.0400", codError, global.getValor("ERR.0400"));

			logger.info("obtieneRangosAsociados: end", nombreClase);
		} catch (Exception e) {
			logger.error(e, nombreClase);

			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error("obtieneRangosAsociados: " + global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.error("obtieneRangosAsociados: Codigo de Error[" + codError + "]", nombreClase);
				logger.error("obtieneRangosAsociados: Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("obtieneRangosAsociados: Numero de Evento[" + numEvento + "]", nombreClase);

				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			}

			throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.info("obtieneRangosAsociados: cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();

				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				logger.error("obtieneRangosAsociados: SQLException[" + e.getMessage() + "]", nombreClase);
			}
		}
	}

	//
	public void obtieneRangosDisponibles(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("obtieneRangosDisponibles: por consultar los rangos disponibles...", nombreClase);

		Connection conn = null;
		CallableStatement cstmt = null;

		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {
			// Sugerir separar codigos de testing
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}

			String call = daoHelper.getPackageBD("PV_VENTAS_ENLACE_VPN_PG", "PV_OBT_RANGOS_DISPONIBLES_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.info("SQL[" + call + "]", nombreClase);
			//entrada
			
			cstmt.setInt(1, asociaRangoVO.getCodCentral().intValue());
			// salida
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);

			// error
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.info("por consultar...", nombreClase);

			cstmt.execute();

			logger.info("consultado.", nombreClase);

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);

			daoHelper.evaluaResultado("ERR.0500", codError, global.getValor("ERR.0500"));

			// salida
			rs = (ResultSet) cstmt.getObject(2);
			RangoVO rangoVO = null;
			List rangos = new ArrayList();

			while (rs.next()) {
				rangoVO = new RangoVO();

				rangoVO.setNumDesde(rs.getLong("NUM_DESDE"));
				rangoVO.setNumHasta(rs.getLong("NUM_HASTA"));
				rangoVO.setFechaAlta(rs.getDate("FECHA_ALTA"));
				rangoVO.setFechaBaja(rs.getDate("FECHA_BAJA"));
				rangoVO.setFechaSuspension(rs.getDate("FECHA_SUSPENSION"));
				rangoVO.setFechaRehabilitacion(rs.getDate("FECHA_REHABILITACION"));
				rangoVO.setFechaModificacion(rs.getDate("FECHA_MODIFICACION"));
				rangoVO.setEstado(rs.getString("ESTADO"));
				rangoVO.setNomUsuarOra(rs.getString("NOM_USUARORA"));

				rangos.add(rangoVO);
			}

			logger.info("obtieneRangosDisponibles: list.size = " + rangos.size(), nombreClase);
			logger.info("obtieneRangosDisponibles: codError = [" + codError + "], msgError = [" + msgError + "], numEvento = [" + numEvento + "]", nombreClase);

			daoHelper.evaluaResultado("ERR.0400", codError, global.getValor("ERR.0400"));

			logger.info("obtieneRangosDisponibles: end", nombreClase);

			asociaRangoVO.setRangosDisponibles(rangos);
		} catch (Exception e) {
			logger.error(e, nombreClase);

			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.error("obtieneRangosDisponibles: Codigo de Error[" + codError + "]", nombreClase);
				logger.error("obtieneRangosDisponibles: Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("obtieneRangosDisponibles: Numero de Evento[" + numEvento + "]", nombreClase);

				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			}

			throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.info("obtieneRangosDisponibles: cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();

				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e.getMessage() + "]", nombreClase);
			}
		}
	}

	public void actualizaEstadoRango(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("actualizaEstadoRango: por actualizar rango...", nombreClase);

		Connection connection = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				connection = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				connection = conexion.conexionBD();
			}

			String call = daoHelper.getPackageBD("PV_VENTAS_ENLACE_VPN_PG", "PV_ACTUALIZA_ESTADO_RANGO_PR", 5);
			cstmt = connection.prepareCall(call);

			logger.info("SQL[" + call + "]", nombreClase);

			logger.info("actualizaEstadoRango: " + asociaRangoVO.getRangoVO(), nombreClase);

			cstmt.setLong(1, asociaRangoVO.getRangoVO().getNumDesde());
			cstmt.setString(2, asociaRangoVO.getRangoVO().getEstado());

			// error
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.info("por consultar...", nombreClase);

			cstmt.execute();

			logger.info("consultado.", nombreClase);

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);

			daoHelper.evaluaResultado("ERR.0500", codError, global.getValor("ERR.0500"));

			// salida
			cstmt.executeUpdate();

			logger.info("actualizaEstadoRango: rango actualizado.", nombreClase);
		} catch (Exception e) {
			logger.error(e, nombreClase);

			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error("actualizaEstadoRango: " + global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);

				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			}

			throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.info("actualizaEstadoRango: cerrando conexiones...", nombreClase);

			try {
				if (cstmt != null)
					cstmt.close();

				if (connection != null && !connection.isClosed())
					connection.close();
			} catch (SQLException e) {
				logger.error("actualizaEstadoRango: SQLException[" + e.getMessage() + "]", nombreClase);
			}
		}
	}

	// Agregado de emergencia... (no habia consultor de codigos)
	public void consultaCodigo(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("consultaCodigo: comenzando...", nombreClase);

		Connection connection = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			if (global.getValor("GE.pruebas.unitarias.GE") == null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));

			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				connection = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				connection = conexion.conexionBD();
			}

			stmt = connection.createStatement();
			String query = "SELECT COD_VALOR FROM GED_CODIGOS WHERE COD_MODULO = '" + asociaRangoVO.getCodModulo() + "' AND NOM_TABLA = '" + asociaRangoVO.getNomTabla() + "' AND NOM_COLUMNA = '" + asociaRangoVO.getNomColumna() + "' and DES_VALOR = '" + asociaRangoVO.getDesValor() + "'";
			logger.info(query, nombreClase);
			rs = stmt.executeQuery(query);

			if (!rs.next())
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));

			asociaRangoVO.setCodValor(rs.getString("COD_VALOR"));
		} catch (Exception e) {
			logger.error(e, nombreClase);

			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error("consultaCodigo: " + global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);

				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			}

			throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.info("consultaCodigo: cerrando conexiones...", nombreClase);

			try {
				if (stmt != null)
					stmt.close();

				if (connection != null && !connection.isClosed())
					connection.close();
			} catch (SQLException e) {
				logger.error("consultaCodigo: SQLException[" + e.getMessage() + "]", nombreClase);
			}
		}
	}

	/**
	 * 
	 * PACKAGE: PV_VENTAS_ENLACE_VPN_PG PROCEDIMIENTO: PV_INS_HISTASOCIA_RANGO_PR
	 * 
	 * @param asociaRangoVO
	 * @throws ServicioVentasEnlaceException
	 *             20/05/2003 15:42:12
	 * @author Héctor Hermosilla
	 */
	public void insertaNumeroPilotoHistorico(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info("insertaNumeroPilotoHistorico():start", nombreClase);
		try {
			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("PV_VENTAS_ENLACE_VPN_PG", "PV_INS_HISTASOCIA_RANGO_PR", 7);
			cstmt = conn.prepareCall(call);
			logger.info("SQL[" + call + "]", nombreClase);
			NumeroPilotoHVO numeroPilotoHVO = asociaRangoVO.getNumeroPilotoHVO();
			logger.info("numeroPilotoVO.getNumPiloto: " + numeroPilotoHVO.getNumPiloto(), nombreClase);
			logger.info("numeroPilotoVO.numDesde: " + numeroPilotoHVO.getNumDesde(), nombreClase);
			logger.info("numeroPilotoVO.getFechaHistorico: " + numeroPilotoHVO.getFechaHistorico(), nombreClase);
			logger.info("numeroPilotoVO.getNomUsuarOra: " + numeroPilotoHVO.getNomUsuarOra(), nombreClase);
			cstmt.setLong(1, numeroPilotoHVO.getNumPiloto());
			cstmt.setLong(2, numeroPilotoHVO.getNumDesde());
			cstmt.setTimestamp(3, numeroPilotoHVO.getFechaHistorico());
			cstmt.setString(4, numeroPilotoHVO.getNomUsuarOra());
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);
			cstmt.execute();
			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);
			// TODO cambiar error
			daoHelper.evaluaResultado("ERR.0611", codError, global.getValor("ERR.0611"));
		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.info("Cerrando conexiones...", nombreClase);
			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.info("insertaNumeroPilotoHistorico():end", nombreClase);

	}

	/**
	 * 
	 * PACKAGE: PV_VENTAS_ENLACE_VPN_PG PROCEDIMIENTO: PV_IN_NUM_PILOTO_PR
	 * 
	 * @param asociaRangoVO
	 * @throws ServicioVentasEnlaceException
	 * @author Héctor Hermosilla
	 */
	public void insertaNumeroPiloto(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info("insertaNumeroPiloto():start", nombreClase);
		try {
			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("PV_VENTAS_ENLACE_VPN_PG", "PV_IN_NUM_PILOTO_PR", 6);
			cstmt = conn.prepareCall(call);
			logger.info("SQL[" + call + "]", nombreClase);
			NumeroPilotoVO numeroPilotoVO = asociaRangoVO.getNumeroPilotoVO();
			logger.info("numeroPilotoVO.getNumPiloto: " + numeroPilotoVO.getNumPiloto(), nombreClase);
			logger.info("numeroPilotoVO.numDesde: " + numeroPilotoVO.getNumDesde(), nombreClase);
			logger.info("numeroPilotoVO.getNomUsuarOra: " + numeroPilotoVO.getNomUsuarOra(), nombreClase);
			cstmt.setLong(1, numeroPilotoVO.getNumPiloto());
			cstmt.setLong(2, numeroPilotoVO.getNumDesde());
			cstmt.setString(3, numeroPilotoVO.getNomUsuarOra());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);
			cstmt.execute();
			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);
			// TODO cambiar error
			daoHelper.evaluaResultado("ERR.0610", codError, global.getValor("ERR.0610"));
		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.info("Cerrando conexiones...", nombreClase);
			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.info("insertaNumeroPiloto():end", nombreClase);

	}

	/**
	 * 
	 * PACKAGE: PV_VENTAS_ENLACE_VPN_PG PROCEDIMIENTO: PV_DEL_RANGOS_PILOTO_PR
	 * 
	 * @param asociaRangoVO
	 * @throws ServicioVentasEnlaceException
	 * @author Héctor Hermosilla
	 */
	public void eliminaNumeroPiloto(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.info("eliminaNumeroPiloto():start", nombreClase);
		try {
			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else {
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("PV_VENTAS_ENLACE_VPN_PG", "PV_DEL_RANGOS_PILOTO_PR", 4);
			cstmt = conn.prepareCall(call);
			logger.info("SQL[" + call + "]", nombreClase);
			NumeroPilotoVO numeroPilotoVO = asociaRangoVO.getNumeroPilotoVO();
			logger.info("numeroPilotoVO.numDesde: " + numeroPilotoVO.getNumDesde(), nombreClase);
			cstmt.setLong(1, numeroPilotoVO.getNumDesde());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución", nombreClase);
			logger.info("Execute Antes", nombreClase);
			cstmt.execute();
			logger.info("Execute Despues", nombreClase);
			logger.info(" Finalizo ejecución", nombreClase);

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			logger.info("codError[" + codError + "]", nombreClase);
			logger.info("msgError[" + msgError + "]", nombreClase);
			logger.info("numEvento[" + numEvento + "]", nombreClase);
			// TODO cambiar error
			daoHelper.evaluaResultado("ERR.0609", codError, global.getValor("ERR.0609"));
		} catch (Exception e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
			} else
				throw (ServicioVentasEnlaceException) e;
		} finally {
			logger.info("Cerrando conexiones...", nombreClase);
			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]", nombreClase);
			}
		}
		logger.info("eliminaNumeroPiloto():end", nombreClase);

	}

}
