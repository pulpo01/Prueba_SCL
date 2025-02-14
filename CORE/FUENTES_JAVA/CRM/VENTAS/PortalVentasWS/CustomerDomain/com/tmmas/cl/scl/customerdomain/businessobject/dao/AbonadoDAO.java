package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.NivelAbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RenovacionAbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class AbonadoDAO extends ConnectionDAO {

	protected final Logger logger = Logger.getLogger(getClass());

	protected final Global global = Global.getInstance();

	private Connection getConection() throws CustomerDomainException {
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		}
		catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexion ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexion", e1);
		}
		return conn;
	}//fin getConection

	private String getSQL(String packageName, String procedureName, int paramCount) {
		StringBuffer sb = new StringBuffer("{call " + packageName + "." + procedureName + "(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosAbonado

	/**
	 * Guarda un nuevo abonado
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */
	public void creaAbonado(AbonadoDTO entrada) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:creaAbonado");
			String call = getSQL("VE_crea_linea_venta_PG", "VE_IN_ga_abocel_PR", 96);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getNumAbonado());
			logger.debug("Numero Abonado:" + entrada.getNumAbonado());
			cstmt.setLong(2, entrada.getNumCelular());
			logger.debug("Celular:" + entrada.getNumCelular());
			cstmt.setInt(3, entrada.getCodProducto());
			logger.debug("Codigo producto:" + entrada.getCodProducto());
			cstmt.setLong(4, entrada.getCodCliente());
			logger.debug("Codigo cliente:" + entrada.getCodCliente());
			cstmt.setLong(5, entrada.getCodCuenta());
			logger.debug("Codigo cuenta:" + entrada.getCodCuenta());
			cstmt.setString(6, entrada.getCodSubCuenta());
			logger.debug("Codigo subcuenta:" + entrada.getCodSubCuenta());
			cstmt.setLong(7, entrada.getCodUsuario());
			logger.debug("Codigo usuario:" + entrada.getCodUsuario());
			cstmt.setString(8, entrada.getCodRegion());
			logger.debug("getCodRegion():" + entrada.getCodRegion());
			cstmt.setString(9, entrada.getCodProvincia());
			logger.debug("getCodProvincia():" + entrada.getCodProvincia());
			cstmt.setString(10, entrada.getCodCiudad());
			logger.debug("getCodCiudad():" + entrada.getCodCiudad());
			cstmt.setString(11, entrada.getCodCelda());
			logger.debug("getCodCelda()" + entrada.getCodCelda());
			cstmt.setInt(12, entrada.getCodCentral());
			logger.debug("getCodCentral():" + entrada.getCodCentral());
			cstmt.setInt(13, entrada.getCodUso());
			logger.debug("getCodUso:" + entrada.getCodUso());
			cstmt.setString(14, entrada.getCodSituacion());
			logger.debug("getCodSituacion:" + entrada.getCodSituacion());
			cstmt.setString(15, entrada.getIndProcAlta());
			logger.debug("getIndProcAlta:" + entrada.getIndProcAlta());
			cstmt.setString(16, entrada.getIndProcEqSimcard());
			logger.debug("getIndProcEqui:" + entrada.getIndProcEqSimcard());
			cstmt.setLong(17, entrada.getCodVendedor());
			logger.debug("getCodVendedor:" + entrada.getCodVendedor());
			cstmt.setLong(18, entrada.getCodVendedorAgente());
			logger.debug("getCodVendedorAgente:" + entrada.getCodVendedorAgente());
			cstmt.setString(19, entrada.getTipPlantarif());
			logger.debug("getTipPlantarif:" + entrada.getTipPlantarif());
			cstmt.setString(20, entrada.getTipTerminal());
			logger.debug("getTipTerminal:" + entrada.getTipTerminal());
			cstmt.setString(21, entrada.getCodPlanTarif());
			logger.debug("getCodPlanTarif:" + entrada.getCodPlanTarif());
			cstmt.setString(22, entrada.getCodCargoBasico());
			logger.debug("getCodCargoBasico :" + entrada.getCodCargoBasico());
			cstmt.setString(23, entrada.getCodPlanServ());
			logger.debug("getCodPlanServ :" + entrada.getCodPlanServ());
			cstmt.setString(24, entrada.getCodLimConsumo());
			logger.debug("getCodLimConsumo :" + entrada.getCodLimConsumo());
			if (entrada.getNumSerieSimcard() == null || entrada.getNumSerieSimcard().trim().equals("")) {
				entrada.setNumSerieSimcard("0");
			}
			cstmt.setString(25, entrada.getNumSerieSimcard());
			logger.debug("getNumSerie :" + entrada.getNumSerieSimcard());
			cstmt.setString(26, entrada.getNumSerieHex());
			logger.debug("getNumSerieHex :" + entrada.getNumSerieHex());
			cstmt.setString(27, entrada.getNomUsuarOra());
			logger.debug("getNomUsuarOra :" + entrada.getNomUsuarOra());
			cstmt.setString(28, entrada.getFecAlta());
			logger.debug("fecha alta:" + entrada.getFecAlta());
			cstmt.setInt(29, entrada.getNumPerContrato());
			logger.debug("getNumPerContrato :" + entrada.getNumPerContrato());
			cstmt.setString(30, entrada.getCodigoEstado());
			logger.debug("getCodEstado :" + entrada.getCodigoEstado());
			cstmt.setString(31, entrada.getNumSerieMec());
			logger.debug("getNumSerieMec :" + entrada.getNumSerieMec());
			cstmt.setString(32, null);
			if (entrada.getCodEmpresa() > 0) {
				cstmt.setLong(33, entrada.getCodEmpresa());
				logger.debug("Empresa ga_abocel: " + entrada.getCodEmpresa());
			}
			else {
				cstmt.setString(33, null);
				logger.debug("Empresa ga_abocel: " + "null");
			}
			logger.debug("getCodEmpresa :" + entrada.getCodEmpresa());
			cstmt.setString(34, entrada.getCodGrpSrv());
			logger.debug("getCodGrpSrv :" + entrada.getCodGrpSrv());
			cstmt.setInt(35, entrada.getIndSuperTel());
			logger.debug("getIndSuperTel :" + entrada.getIndSuperTel());
			cstmt.setString(36, entrada.getNumTeleFija());
			logger.debug("getNumTeleFija :" + entrada.getNumTeleFija());
			//cstmt.setLong(37,entrada.getCodOpRedFija()); Por defecto null
			//cstmt.setLong(38,entrada.getCodCarrier());Por defecto null
			cstmt.setString(37, null);
			logger.debug("null :" + null);
			cstmt.setString(38, null);
			logger.debug("null :" + null);
			cstmt.setInt(39, entrada.getIndPrepago());
			logger.debug("getIndPrepago :" + entrada.getIndPrepago());
			cstmt.setInt(40, entrada.getIndPlexSys());
			logger.debug("getIndPlexSys :" + entrada.getIndPlexSys());
			cstmt.setInt(41, entrada.getCodCentralPlex());
			logger.debug("getCodCentralPlex :" + entrada.getCodCentralPlex());
			cstmt.setLong(42, entrada.getNumCelularPlex());
			logger.debug("getNumCelularPlex :" + entrada.getNumCelularPlex());
			cstmt.setLong(43, entrada.getNumVenta());
			logger.debug("getNumVenta :" + entrada.getNumVenta());
			cstmt.setLong(44, entrada.getCodModVenta());
			logger.debug("getCodModVenta :" + entrada.getCodModVenta());
			cstmt.setString(45, entrada.getCodTipContrato());
			logger.debug("getCodTipContrato :" + entrada.getCodTipContrato());
			cstmt.setString(46, entrada.getNumContrato());
			logger.debug("getNumContrato :" + entrada.getNumContrato());
			cstmt.setString(47, entrada.getNumAnexo());
			logger.debug("getNumAnexo :" + entrada.getNumAnexo());
			cstmt.setString(48, entrada.getFecCumPlan());
			logger.debug("getFecCumPlan:" + entrada.getFecCumPlan());
			cstmt.setString(49, entrada.getCodCredMor());
			logger.debug("getCodCredMor :" + entrada.getCodCredMor());
			cstmt.setString(50, entrada.getCodCredCon());
			logger.debug("getCodCredCon :" + entrada.getCodCredCon());
			cstmt.setInt(51, entrada.getCodCiclo());
			logger.debug("getCodCiclo :" + entrada.getCodCiclo());
			cstmt.setInt(52, entrada.getCodFactur());//revisar dato
			logger.debug("getCodFactur :" + entrada.getCodFactur());
			cstmt.setInt(53, entrada.getIndSuspen());
			logger.debug("getIndSuspen :" + entrada.getIndSuspen());
			cstmt.setInt(54, entrada.getIndReHabi());
			logger.debug("getIndReHabi :" + entrada.getIndReHabi());
			cstmt.setInt(55, entrada.getInsGuias());
			logger.debug("getInsGuias :" + entrada.getInsGuias());
			cstmt.setString(56, entrada.getFecFinContra());
			logger.debug("getFecFinContra :" + entrada.getFecFinContra());
			cstmt.setString(57, entrada.getFecRecDocu());
			logger.debug("rec docu:" + entrada.getFecRecDocu());
			cstmt.setString(58, entrada.getFecCumplimen());
			logger.debug("fec cumplimen:" + entrada.getFecCumplimen());
			cstmt.setString(59, entrada.getFecAcepVenta());
			logger.debug("getFecAcepVenta():" + entrada.getFecAcepVenta());
			cstmt.setString(60, entrada.getFecActCen());
			logger.debug("getFecActCen:" + entrada.getFecActCen());
			cstmt.setString(61, entrada.getFecBaja());
			logger.debug("getFecBaja:" + entrada.getFecBaja());
			cstmt.setString(62, entrada.getFecBajaCen());
			logger.debug("getFecBajaCen:" + entrada.getFecBajaCen());
			cstmt.setString(63, entrada.getFecUltMod());
			logger.debug("getFecUltMod:" + entrada.getFecUltMod());
			cstmt.setString(64, entrada.getCodCausaBaja());
			logger.debug("getCodCausaBaja :" + entrada.getCodCausaBaja());
			cstmt.setString(65, entrada.getNumPersonal());
			logger.debug("getNumPersonal :" + entrada.getNumPersonal());
			cstmt.setInt(66, entrada.getIndSeguro());
			logger.debug("getIndSeguro :" + entrada.getIndSeguro());
			cstmt.setString(67, entrada.getClaseServicio());
			logger.debug("getClaseServicio :" + entrada.getClaseServicio());
			cstmt.setString(68, entrada.getPerfilAbonado());
			logger.debug("getPerfilAbonado :" + entrada.getPerfilAbonado());
			cstmt.setString(69, entrada.getNumMin());
			logger.debug("getNumMin :" + entrada.getNumMin());
			cstmt.setString(70, entrada.getCodVendealer() == 0 ? null : String.valueOf(entrada.getCodVendealer()));
			logger.debug("getCodVendealer :" + entrada.getCodVendealer());
			cstmt.setString(71, null);
			logger.debug("getIndDisp :" + entrada.getIndDisp());
			cstmt.setString(72, entrada.getCodPassword());
			logger.debug("getCodPassword :" + entrada.getCodPassword());
			cstmt.setString(73, entrada.getIndPassword());
			logger.debug("getIndPassword :" + entrada.getIndPassword());
			cstmt.setString(74, entrada.getCodAfinidad());
			logger.debug("getCodAfinidad :" + entrada.getCodAfinidad());
			cstmt.setString(75, entrada.getFecProrroga());
			logger.debug("getFecProrroga:" + entrada.getFecProrroga());
			cstmt.setString(76, entrada.getIndEqPrestadoTerminal());
			logger.debug("getIndEqPrestadoTerminal :" + entrada.getIndEqPrestadoTerminal());
			cstmt.setString(77, entrada.getFlgContDigi());
			logger.debug("getFlgContDigi :" + entrada.getFlgContDigi());
			cstmt.setString(78, entrada.getFecAltanTras());
			logger.debug("getFecAltanTras:" + entrada.getFecAltanTras());
			cstmt.setInt(79, entrada.getCodIndemnizacion());
			logger.debug("getCodIndemnizacion :" + entrada.getCodIndemnizacion());
			cstmt.setString(80, entrada.getNumImei());
			logger.debug("getNumImei :" + entrada.getNumImei());
			cstmt.setString(81, entrada.getCodTecnologia());
			logger.debug("getCodTecnologia :" + entrada.getCodTecnologia());
			cstmt.setString(82, entrada.getNumMinMdn());
			logger.debug("getNumMinMdn :" + entrada.getNumMinMdn());
			cstmt.setString(83, entrada.getFecActivacion());
			logger.debug("Fecha Activacion:" + entrada.getFecActivacion());
			cstmt.setInt(84, entrada.getIndTelefono());
			logger.debug("getIndTelefono :" + entrada.getIndTelefono());
			cstmt.setString(85, entrada.getCodOficinaPrincipal());
			logger.debug("getCodOficinaPrincipal :" + entrada.getCodOficinaPrincipal());
			cstmt.setString(86, entrada.getCodCausaVenta());
			logger.debug("getCodCausaVenta :" + entrada.getCodCausaVenta());
			cstmt.setString(87, entrada.getCodOperacion());
			logger.debug("getCodOperacion :" + entrada.getCodOperacion());
			cstmt.setString(88, entrada.getCodTipoPrestacion());
			logger.debug("getCodGrupoPrestacion :" + entrada.getCodTipoPrestacion());
			cstmt.setDouble(89, entrada.getValorRefXMinuto());
			logger.debug("getMontoPreautorizado :" + entrada.getValorRefXMinuto());
			cstmt.setString(90, entrada.getCodMoneda());
			logger.debug("getCodMoneda :" + entrada.getCodMoneda());
			cstmt.setString(91, entrada.getObsInstancia());
			logger.debug("getObsInstancia :" + entrada.getObsInstancia());
			cstmt.setString(92, entrada.getTipoPrimariaCarrier());
			logger.debug("getTipoPrimariaCarrier :" + entrada.getTipoPrimariaCarrier());
			cstmt.setDouble(93, entrada.getImpLimiteConsumo());
			logger.debug("getImpLimiteConsumo :" + entrada.getImpLimiteConsumo());

			cstmt.registerOutParameter(94, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(95, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(96, java.sql.Types.NUMERIC);

			logger.debug("Inicio:creaAbonado:execute");
			cstmt.execute();
			logger.debug("Inicio:creaAbonado:execute");
			codError = cstmt.getInt(94);
			msgError = cstmt.getString(95);
			numEvento = cstmt.getInt(96);

			if (codError != 0) {
				logger.error("Ocurrio un error al crear el abonado");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new CustomerDomainException("Ocurrio un error al crear el abonado", String.valueOf(codError),
						numEvento, msgError);
			}

			logger.debug("msgError[" + msgError + "]");

		}
		catch (CustomerDomainException e) {
			logger.error("Ocurrio un error al crear abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw (e);
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al crear abonado", e);
			throw new CustomerDomainException("Ocurrio un error al crear el abonado");
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:creaAbonado");

	}

	/**
	 * Almacena la Simcard del Nuevo Abonado
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */

	public void creaSimcardAboser(AbonadoDTO entrada) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:creaSimcardAboser");

			String call = getSQL("VE_crea_linea_venta_PG", "VE_IN_GA_EQUIPABOSER_PR", 35);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getNumAbonado());
			logger.debug("Numero Abonado:" + entrada.getNumAbonado());
			cstmt.setString(2, entrada.getNumSerieSimcard());
			logger.debug("Numero Serie:" + entrada.getNumSerieSimcard());
			cstmt.setInt(3, entrada.getCodProducto());
			logger.debug("Producto:" + entrada.getCodProducto());
			cstmt.setString(4, entrada.getIndProcEqSimcard());
			logger.debug("Procedencia Equipo:" + entrada.getIndProcEqSimcard());
			cstmt.setString(5, entrada.getFecAlta());
			logger.debug("getFecAlta:" + entrada.getFecAlta());

			cstmt.setString(6, entrada.getIndPropiedad());
			logger.debug("Propiedad:" + entrada.getIndPropiedad());
			cstmt.setLong(7, Long.parseLong(entrada.getCodBodegaSimcard()));
			logger.debug("Bodega:" + entrada.getCodBodegaSimcard());

			if (entrada.getIndProcEqSimcard().equals("I")) {
				cstmt.setString(8, String.valueOf(entrada.getTipoStockSimcard()));
				logger.debug("tipo stock:" + entrada.getTipoStockSimcard());
			}
			else {
				cstmt.setString(8, null);
				logger.debug("tipo stock:" + String.valueOf(entrada.getTipoStockSimcard()));
			}
			cstmt.setLong(9, Long.parseLong(entrada.getCodigoArticuloSimcard()));
			logger.debug("articulo:" + entrada.getCodigoArticuloSimcard());
			cstmt.setString(10, entrada.getIndEqAcc());
			logger.debug("indicador accesorio:" + entrada.getIndEqAcc());
			cstmt.setLong(11, entrada.getCodModVenta());
			logger.debug("modalidad venta:" + entrada.getCodModVenta());
			cstmt.setString(12, entrada.getTipTerminalSimcard());
			logger.debug("tipo terminal:" + entrada.getTipTerminalSimcard());
			cstmt.setInt(13, entrada.getCodUsoSimcard());
			logger.debug("cod uso:" + entrada.getCodUsoSimcard());
			cstmt.setString(14, entrada.getCodCuota() == 0 ? null : String.valueOf(entrada.getCodCuota()));
			logger.debug("getCodCuota:" + entrada.getCodCuota());
			cstmt.setInt(15, Integer.parseInt(entrada.getCodEstadoSimcard()));
			logger.debug("getCodEstadoSimcard:" + entrada.getCodEstadoSimcard());
			cstmt.setString(16, null);
			logger.debug("null");
			cstmt.setString(17, null);
			logger.debug("null");
			cstmt.setString(18, null);
			logger.debug("null");
			cstmt.setString(19, null);
			logger.debug("null");
			cstmt.setString(20, null);
			logger.debug("null");
			cstmt.setString(21, null);
			logger.debug("null");
			cstmt.setString(22, entrada.getDesArticuloSimcard());
			logger.debug("getDesArticuloSimcard:" + entrada.getDesArticuloSimcard());
			cstmt.setString(23, null);
			logger.debug("null");
			cstmt.setString(24, null);
			logger.debug("null");
			cstmt.setString(25, null);
			logger.debug("null");
			cstmt.setString(26, entrada.getIndComodato());
			logger.debug("getIndComodato:" + entrada.getIndComodato());
			cstmt.setString(27, entrada.getNumSerieTerminal());
			logger.debug("imei:" + entrada.getNumSerieTerminal());
			cstmt.setString(28, entrada.getCodTecnologia());
			logger.debug("getCodigoTecnoGsm:" + entrada.getCodTecnologia());
			cstmt.setString(29, null);
			logger.debug("null");
			cstmt.setString(30, null);
			logger.debug("null");
			cstmt.setString(31, null);
			logger.debug("null");
			cstmt.setString(32, null);
			logger.debug("null");
			cstmt.registerOutParameter(33, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(34, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(35, java.sql.Types.NUMERIC);

			logger.debug("Inicio:creaSimcardAboser:execute");
			cstmt.execute();
			logger.debug("Fin:creaSimcardAboser:execute");

			codError = cstmt.getInt(33);
			msgError = cstmt.getString(34);
			numEvento = cstmt.getInt(35);
			if (codError != 0) {
				logger.error("Ocurrio un error al insertar simcard en ga_equipaboser");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new CustomerDomainException("Ocurrio un error al insertar simcard en ga_equipaboser", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (CustomerDomainException e) {
			logger.error("Ocurrio un error al insertar simcard en ga_equipaboser", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw (e);
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al insertar simcard en ga_equipaboser", e);
			throw new CustomerDomainException("Ocurrio un error al insertar simcard en ga_equipaboser");
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:creaSimcardAboser");

	}

	/**
	 * Almacena el terminal del nuevo Abonado
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */

	public void creaTerminalAboser(AbonadoDTO entrada) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:creaTerminalAboser");

			String call = getSQL("VE_crea_linea_venta_PG", "VE_IN_GA_EQUIPABOSER_PR", 35);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getNumAbonado());
			logger.debug("Numero Abonado:" + entrada.getNumAbonado());
			cstmt.setString(2, entrada.getNumSerieTerminal());
			logger.debug("getNumSerieTerminal:" + entrada.getNumSerieTerminal());
			cstmt.setInt(3, entrada.getCodProducto());
			logger.debug("Producto:" + entrada.getCodProducto());
			cstmt.setString(4, entrada.getIndProcEqTerminal());
			logger.debug("Procedencia Equipo:" + entrada.getIndProcEqTerminal());
			cstmt.setString(5, entrada.getFecAlta());
			logger.debug("getFecAlta:" + entrada.getFecAlta());
			cstmt.setString(6, entrada.getIndPropiedad());
			logger.debug("Propiedad:" + entrada.getIndPropiedad());

			cstmt.setString(7, entrada.getCodBodegaTerminal());
			logger.debug("Bodega:" + entrada.getCodBodegaTerminal());
			cstmt.setString(8, entrada.getTipoStockTerminal() == 0 ? null : String.valueOf(entrada
					.getTipoStockTerminal()));
			logger.debug("tipo stock:" + entrada.getTipoStockTerminal());
			cstmt.setString(9, entrada.getCodigoArticuloTerminal());
			logger.debug("articulo:" + entrada.getCodigoArticuloTerminal());
			cstmt.setString(10, entrada.getIndEqAcc());
			logger.debug("indicador accesorio:" + entrada.getIndEqAcc());
			cstmt.setLong(11, entrada.getCodModVenta());
			logger.debug("modalidad venta:" + entrada.getCodModVenta());
			cstmt.setString(12, entrada.getTipTerminalEquipo());
			logger.debug("tipo terminal:" + entrada.getTipTerminalEquipo());
			logger.debug("cod uso:" + entrada.getCodUsoTerminal());
			cstmt.setInt(13, entrada.getCodUsoTerminal());
			cstmt.setString(14, entrada.getCodCuota() == 0 ? null : String.valueOf(entrada.getCodCuota()));
			logger.debug("getCodCuota:" + entrada.getCodCuota());
			//cstmt.setInt(15,Integer.parseInt(entrada.getCodEstadoTerminal()));
			cstmt.setString(15, entrada.getCodEstadoTerminal());
			logger.debug("getCodEstadoTerminal:" + entrada.getCodEstadoTerminal());
			cstmt.setString(16, null);
			logger.debug("null");
			cstmt.setString(17, null);
			logger.debug("null");
			cstmt.setString(18, null);
			logger.debug("null");
			cstmt.setString(19, null);
			logger.debug("null");
			cstmt.setString(20, null);
			logger.debug("null");
			cstmt.setString(21, null);
			logger.debug("null");
			cstmt.setString(22, entrada.getDesArticuloTerminal());
			logger.debug("getDesArticuloTerminal:" + entrada.getDesArticuloTerminal());
			cstmt.setString(23, null);
			logger.debug("null");
			cstmt.setString(24, null);
			logger.debug("null");
			cstmt.setString(25, null);
			logger.debug("null");
			cstmt.setString(26, entrada.getIndComodato());
			logger.debug("getIndComodato:" + entrada.getIndComodato());
			cstmt.setString(27, null);
			logger.debug("null");
			cstmt.setString(28, entrada.getCodTecnologia());
			logger.debug("getCodigoTecnoGsm:" + entrada.getCodTecnologia());
			cstmt.setString(29, null);
			logger.debug("null");
			cstmt.setString(30, null);
			logger.debug("null");
			cstmt.setString(31, null);
			logger.debug("null");
			cstmt.setDouble(32, entrada.getImpCargo());
			logger.debug("entrada.getImpCargo()" + entrada.getImpCargo());
			cstmt.registerOutParameter(33, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(34, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(35, java.sql.Types.NUMERIC);

			logger.debug("Inicio:creaTerminalAboser:execute");
			cstmt.execute();
			logger.debug("Fin:creaTerminalAboser:execute");

			codError = cstmt.getInt(33);
			msgError = cstmt.getString(34);
			numEvento = cstmt.getInt(35);

			if (codError != 0) {
				logger.error("Ocurrio un error al insertar terminal en ga_equipaboser");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new CustomerDomainException("Ocurrio un error al insertar terminal en ga_equipaboser", String
						.valueOf(codError), numEvento, msgError);
			}

		}
		catch (CustomerDomainException e) {
			logger.error("Ocurrio un error al insertar terminal en ga_equipaboser", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw (e);
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al insertar terminal en ga_equipaboser", e);
			throw new CustomerDomainException("Ocurrio un error al insertar terminal en ga_equipaboser");
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:creaTerminalAboser");

	}

	/**
	 * Obtiene Numero de Secuencia para asignarlo a un Nuevo Abonado
	 * @param abonado
	 * @return abonado
	 * @throws CustomerDomainException
	 */

	public AbonadoDTO getSecuenciaAbonado(AbonadoDTO abonado) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:getSecuenciaAbonado");

			String call = getSQL("VE_intermediario_PG", "VE_OBTIENE_SECUENCIA_PR", 5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, abonado.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getSecuenciaAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:getSecuenciaAbonado:execute");

			msgError = cstmt.getString(4);
			codError = cstmt.getInt(3);
			numEvento = cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0) {
				logger.error("Ocurrio un error al obtener la secuencia del abonado");
				throw new CustomerDomainException("Ocurrio un error al obtener la secuencia del abonado", String
						.valueOf(codError), numEvento, msgError);
			}
			else
				abonado.setNumAbonado(Long.parseLong(cstmt.getString(2)));

		}
		catch (Exception e) {
			logger.error("Ocurrio un error al obtener la secuencia del abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al obtener la secuencia del abonado", e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getSecuenciaAbonado");

		return abonado;
	}

	/**
	 * Consulta si una simcard especifica esta siendo utilizada por algun abonado
	 * @param entradaValidacionVentas
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public ResultadoValidacionVentaDTO getExisteSerieSimcardEnAbonado(
			ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:getExisteSerieSimcardEnAbonado");

			String call = getSQL("VE_validacion_linea_PG", "VE_existeserieabonado_PR", 5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entradaValidacionVentas.getNumeroSerie());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getExisteSerieSimcardEnAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:getExisteSerieSimcardEnAbonado:execute");

			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");

			if (cstmt.getInt(2) == 1)
				logger.debug("SERIE:<<< EXISTE >>> " + entradaValidacionVentas.getNumeroSerie());
			else
				logger.debug("SERIE:<<< NO EXISTE >>> " + entradaValidacionVentas.getNumeroSerie());

			resultado.setResultadoBase(cstmt.getInt(2));

		}
		catch (Exception e) {
			logger.error("Ocurrio un error al buscar serie simcard en abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al buscar serie simcard en abonado", e);

		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getExisteSerieSimcardEnAbonado");

		return resultado;
	}//fin getExisteSerieSimcardEnAbonado

	/**
	 * Consulta si un terminal especifico esta siendo utilizado por algún abonado
	 * @param entradaValidacionVentas
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public ResultadoValidacionVentaDTO existeSerieTerminalEnAbonado(
			ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {

			logger.debug("Inicio:existeSerieTerminalEnAbonado");
			String call = getSQL("VE_validacion_linea_PG", "VE_existeimeienabonado_PR", 5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entradaValidacionVentas.getNumeroSerieTerminal());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");

			if (cstmt.getInt(2) == 1)
				logger.debug("SERIE:<<< EXISTE >>> " + entradaValidacionVentas.getNumeroSerie());
			else
				logger.debug("SERIE:<<< NO EXISTE >>> " + entradaValidacionVentas.getNumeroSerie());

			resultado.setResultadoBase(cstmt.getInt(2));

		}
		catch (Exception e) {
			logger.error("Ocurrio un error al buscar serie terminal en abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al buscar serie terminal en abonado", e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:existeSerieTerminalEnAbonado");
		return resultado;
	}//fin getExisteSerieSimcardEnAbonado

	public ResultadoValidacionVentaDTO getValidaSerieTerminalListaNegra(
			ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		logger.info("Inicio:getValidaSerieTerminalListaNegra");
		logger.debug("entradaValidacionVentas.getNumeroSerieTerminal() ["
				+ entradaValidacionVentas.getNumeroSerieTerminal() + "]");
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "ve_servs_activacionesweb_pg";
		final String nombrePL = "ve_valida_serie_gsm_pr";
		final int cantidadParametros = 4;
		try {
			String call = getSQL(nombrePackage, nombrePL, cantidadParametros);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entradaValidacionVentas.getNumeroSerieTerminal());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getValidaSerieTerminalListaNegra:execute");
			cstmt.execute();
			logger.debug("Inicio:getValidaSerieTerminalListaNegra:execute");
			msgError = cstmt.getString(3);
			codError = cstmt.getInt(2);
			logger.debug("msgError[" + msgError + "]");
			if (cstmt.getInt(2) != 0) {
				resultado.setResultadoBase(1);
				resultado.setCodigoError(Integer.toString(codError));
				resultado.setDetalleEstado(msgError);
				logger.debug("SERIE:<<< EN LISTA NEGRA >>>");
			}
			else {
				resultado.setResultadoBase(0);
				logger.debug("SERIE:<<< NO EN LISTA NEGRA >>>");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al buscar serie terminal en listas negras", e);
			if (logger.isDebugEnabled()) {
				logger.error("Codigo de Error [" + codError + "]");
				logger.error("Mensaje de Error [" + msgError + "]");
				logger.error("Numero de Evento [" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al buscar serie terminal en listas negras", e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.error("SQLException", e);
			}
		}
		logger.info("Fin:getValidaSerieTerminalListaNegra");
		return resultado;
	}//fin getValidaSerieTerminalListaNegra

	/**
	 * Obtiene oficina principal de un Nuevo Abonado
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public AbonadoDTO getOficinaPrincipal(VendedorDTO entrada) throws CustomerDomainException {
		AbonadoDTO resultado = new AbonadoDTO();
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:getOficinaPrincipal");

			String call = "{?=call PV_OBTENER_OFIPRINC_FN(?,?,?)}";

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.setString(2, entrada.getDireccion().getRegion());
			cstmt.setString(3, entrada.getDireccion().getProvincia());
			cstmt.setString(4, entrada.getDireccion().getCiudad());
			logger.debug("Inicio:getOficinaPrincipal:execute");
			cstmt.execute();
			logger.debug("Inicio:getOficinaPrincipal:fin Execute");

			resultado.setCodOficinaPrincipal(cstmt.getString(1));
			logger.debug("oficina principal:" + resultado.getCodOficinaPrincipal());
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al buscar la oficina principal", e);
			throw new CustomerDomainException("Ocurrio un error al buscar la oficina principal", e);

		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getOficinaPrincipal");

		return resultado;
	}//fin getOficinaPrincipal

	/**
	 * Consulta Lista de Abonados asociados a un Numero de Venta
	 * @param registroventa
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public AbonadoDTO[] getListaAbonadosVenta(RegistroVentaDTO registroventa) throws CustomerDomainException {
		logger.debug("getListaAbonadosVenta:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO[] resultado = null;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String call = getSQL("VE_servicios_venta_PG", "VE_obtiene_abonados_venta_PR", 5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, registroventa.getNumeroVenta());
			logger.debug("registroventa.getNumeroVenta(): "+registroventa.getNumeroVenta());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getListaAbonadosVenta:Execute");
			cstmt.execute();
			logger.debug("Fin:getListaAbonadosVenta:Execute");
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				logger.error("Ocurrio un error al recuperar abonados para la venta");
				throw new CustomerDomainException("Ocurrio un error al recuperar abonados para la venta", String
						.valueOf(codError), numEvento, msgError);
			}
			else {
				logger.debug("Recuperando abonados");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					AbonadoDTO abonadoDTO = new AbonadoDTO();
					abonadoDTO.setNumAbonado(rs.getLong(1));
					abonadoDTO.setCodPlanTarif(rs.getString(2));
					abonadoDTO.setCodCargoBasico(rs.getString(3));
					abonadoDTO.setCodPlanServ(rs.getString(4));
					abonadoDTO.setNumSerieSimcard(rs.getString(5));
					abonadoDTO.setNumSerieTerminal(rs.getString(6));
					abonadoDTO.setCodCliente(rs.getLong(7));
					abonadoDTO.setCodVendedor(rs.getLong(8));
					abonadoDTO.setCodTipContrato(rs.getString(9));
					abonadoDTO.setCodCausaVenta(rs.getString(10));
					abonadoDTO.setCodModVenta(rs.getLong(11));
					abonadoDTO.setTipPlantarif(rs.getString(12));
					abonadoDTO.setNumContrato(rs.getString(13));
					abonadoDTO.setCodUso(rs.getInt(14));
					abonadoDTO.setNumMin(rs.getString(15));
					abonadoDTO.setCodCentral(rs.getInt(16));
					abonadoDTO.setNumCelular(rs.getLong(17));
					abonadoDTO.setCodCuenta(rs.getLong(18));
					abonadoDTO.setCodTecnologia(rs.getString(19));
					abonadoDTO.setCodTipoPrestacion(rs.getString(20));
					abonadoDTO.setCodGrpPrestacion(rs.getString(21));
					abonadoDTO.setTipTerminal(rs.getString(22));
					//abonadoDTO.setIndRenovacion(rs.getInt(23)); P-CSR-11002 JLGN 25-05-2011
					abonadoDTO.setIndRenovacion(rs.getString(23));	//P-CSR-11002 JLGN 25-05-2011
					abonadoDTO.setNumFax(rs.getLong(24));
					lista.add(abonadoDTO);
				}
				resultado = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), AbonadoDTO.class);
				logger.debug("Fin recuperacion de abonados");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecucion");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al recuperar abonados para la venta", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getListaAbonadosVenta()");
		return resultado;
	}//fin getListaAbonadosVenta

	/**
	 * Obtiene listado de equipos seriados
	 * @param abonado
	 * @return
	 * @throws CustomerDomainException
	 */
	public AbonadoDTO[] getEquiposSeriados(AbonadoDTO abonado) throws CustomerDomainException {
		logger.debug("getListaAbonadosVenta:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO[] resultado = null;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String call = getSQL("VE_servicios_venta_PG", "VE_obtiene_equipos_seriados_PR", 6);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			logger.debug("NumAbonado=" + abonado.getNumAbonado());
			logger.debug("Procedencia=" + abonado.getIndProcEqTerminal());

			cstmt.setString(1, String.valueOf(abonado.getNumAbonado()));
			cstmt.setString(2, abonado.getIndProcEqTerminal());
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getListaAbonadosVenta:Execute");
			cstmt.execute();
			logger.debug("Fin:getListaAbonadosVenta:Execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				logger.error("Ocurrio un error al recuperar equipos seriados");
				throw new CustomerDomainException("Ocurrio un error al recuperar equipos seriados", String
						.valueOf(codError), numEvento, msgError);

			}
			else {
				logger.debug("Recuperando equipos seriados");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					AbonadoDTO abonadoDTO = new AbonadoDTO();
					abonadoDTO.setTipoStock(rs.getLong(1));
					abonadoDTO.setCodigoBodega(rs.getString(2));
					abonadoDTO.setCodigoArticulo(rs.getString(3));
					abonadoDTO.setCodUso(rs.getInt(4));
					abonadoDTO.setCodigoEstado(rs.getString(5));
					abonadoDTO.setNumeroSerie(rs.getString(6));
					abonadoDTO.setIndicadorEquiAcc(rs.getString(7));
					abonadoDTO.setTipTerminal(rs.getString(8));
					lista.add(abonadoDTO);
				}
				resultado = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), AbonadoDTO.class);
				logger.debug("Fin recuperacion de abonados");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecucion");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al recuperar abonados para la venta", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al recuperar abonados para la venta", e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getListaAbonadosVenta()");

		return resultado;
	}//fin getEquiposSeriados

	/**
	 * Actualiza tabla ga_equipaboser
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */
	public void actualizaEquipAboSer(AbonadoDTO entrada) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:actualizaEquipAboSer");

			String call = getSQL("Ve_Servicios_Venta_Pg", "VE_actualiza_equipaboser_PR", 13);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, entrada.getNumeroMovimiento());
			cstmt.setLong(2, entrada.getTipoStock());
			cstmt.setString(3, entrada.getCodigoBodegaActual());
			cstmt.setLong(4, entrada.getTipoStockOriginal());
			cstmt.setString(5, entrada.getCodigoBodega());
			cstmt.setString(6, entrada.getCodigoArticulo());
			cstmt.setString(7, String.valueOf(entrada.getCodUso()));
			cstmt.setString(8, entrada.getCodigoEstado());
			cstmt.setString(9, entrada.getNumeroSerie());
			cstmt.setLong(10, entrada.getNumAbonado());
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			logger.debug("Inicio:actualizaEquipAboSer:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaEquipAboSer:execute");

			msgError = cstmt.getString(11);
			codError = cstmt.getInt(12);
			numEvento = cstmt.getInt(13);

		}
		catch (Exception e) {
			logger.error("Ocurrio un error al actualizar tabla ga_equipaboser", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:actualizaEquipAboSer");
	}//fin actualizaEquipAboSer

	/**
	 * Almacena el monto de garantia asociada al abonado
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */

	public void insertaGarantiaAbonado(AbonadoDTO entrada) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:insertaGarantiaAbonado");

			String call = getSQL("Ve_Servicios_Venta_Pg", "VE_ins_abo_garantia_PR", 8);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getNumVenta());
			logger.debug("entrada.getNumVenta(): " + entrada.getNumVenta());
			cstmt.setLong(2, entrada.getCodCliente());
			logger.debug("entrada.getCodCliente(): " + entrada.getCodCliente());
			cstmt.setLong(3, entrada.getNumAbonado());
			logger.debug("entrada.getNumAbonado(): " + entrada.getNumAbonado());
			cstmt.setFloat(4, entrada.getMontoGarantia());
			logger.debug("entrada.getMontoGarantia(): " + entrada.getMontoGarantia());
			cstmt.setInt(5, entrada.getIndicadorPago());
			logger.debug("entrada.getIndicadorPago(): " + entrada.getIndicadorPago());

			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.debug("Inicio:insertaGarantiaAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:insertaGarantiaAbonado:execute");

			msgError = cstmt.getString(6);
			codError = cstmt.getInt(7);
			numEvento = cstmt.getInt(8);
			logger.debug("msgError[" + msgError + "]");

		}
		catch (Exception e) {
			logger.error("Ocurrio un error al insertar la garantia", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al insertar la garantia", e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:creaTerminalAboser");

	}

	/**
	 * Actualiza clase servicio para el abonado
	 * @param abonado
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void updAbonadoClaseServ(AbonadoDTO abonado) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:updAbonadoClaseServ");

			String call = getSQL("Ve_Servicios_Venta_Pg", "VE_updAbocelClaseServ_PR", 5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, abonado.getNumAbonado());
			cstmt.setString(2, abonado.getClaseServicio());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:updAbonadoClaseServ:execute");
			cstmt.execute();
			logger.debug("Fin:updAbonadoClaseServ:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				logger.error("Ocurrio un error al actualizar clase servicio del abonado");
				throw new CustomerDomainException("Ocurrio un error al actualizar clase servicio del abonado", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al actualizar clase servicio del abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al actualizar clase servicio del abonado", e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:updAbonadoClaseServ");
	}//fin updAbonadoClaseServ

	/**
	 * Actualiza código situación del abonado
	 * @param abonado
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void updCodigoSituacion(AbonadoDTO abonado) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:updCodigoSituacion");

			String call = getSQL("Ve_Servicios_Venta_Pg", "VE_updAbocelCodSituac_PR", 5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, abonado.getNumVenta());
			cstmt.setString(2, abonado.getCodSituacion());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:updCodigoSituacion:execute");
			cstmt.execute();
			logger.debug("Fin:updCodigoSituacion:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				logger.error("Ocurrio un error al actualizar codigo situación del abonado");
				throw new CustomerDomainException("Ocurrio un error al actualizar codigo situacion del abonado", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al actualizar codigo situacion del abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al actualizar código situación del abonado", e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:updCodigoSituacion");
	}//fin updCodigoSituacion

	/**
	 * Actualiza código situación del abonado, por numero de abonado
	 * @param abonado
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void updCodigoSituacionAbo(AbonadoDTO abonado) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:updCodigoSituacionAbo");

			String call = getSQL("Ve_Servicios_Venta_Pg", "VE_updAbocelCodSituacAbo_PR", 5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, abonado.getNumAbonado());
			cstmt.setString(2, abonado.getCodSituacion());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:updCodigoSituacionAbo:execute");
			cstmt.execute();
			logger.debug("Fin:updCodigoSituacionAbo:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				logger.error("Ocurrio un error al actualizar código situación del abonado");
				throw new CustomerDomainException("Ocurrio un error al actualizar código situación del abonado", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al actualizar código situación del abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al actualizar código situación del abonado", e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:updCodigoSituacionAbo");
	}//fin updCodigoSituacion

	public void validarPlanCompartido(Long codCliente, String codPlanTarif) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:validarPlanCompartido");

			String call = getSQL("Ve_Servicios_Venta_Pg", "VE_ValidaPlanCompartido_PR", 5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, codCliente.longValue());
			cstmt.setString(2, codPlanTarif);

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:validarPlanCompartido:execute");
			cstmt.execute();
			logger.debug("Fin:validarPlanCompartido:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				logger.error("Ocurrio un error al validar plan compartido");
				throw new CustomerDomainException(msgError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al al validar plan compartido", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(msgError, e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:validarPlanCompartido");
	}//fin validarPlanCompartido

	/**
	 * Guarda un nuevo abonado prepago
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */

	public void creaAbonadoPrepago(AbonadoDTO entrada) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:creaAbonado");
			String call = getSQL("VE_crea_linea_venta_PG", "ve_insertar_ga_aboamist", 40);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getNumAbonado());
			logger.debug("Numero Abonado:" + entrada.getNumAbonado());
			cstmt.setLong(2, Long.valueOf(entrada.getCodigoArticuloTerminal()).longValue());
			logger.debug("Codigo Articulo:" + entrada.getCodigoArticuloTerminal());
			cstmt.setLong(3, entrada.getNumCelular());
			logger.debug("Num Celular:" + entrada.getNumCelular());
			cstmt.setInt(4, entrada.getCodProducto());
			logger.debug("Codigo producto:" + entrada.getCodProducto());
			cstmt.setLong(5, entrada.getCodCliente());
			logger.debug("Codigo cliente:" + entrada.getCodCliente());
			cstmt.setLong(6, entrada.getCodCuenta());
			logger.debug("Codigo cuenta:" + entrada.getCodCuenta());
			cstmt.setInt(7, entrada.getCodCentral());
			logger.debug("getCodCentral():" + entrada.getCodCentral());
			cstmt.setInt(8, entrada.getCodUso());
			logger.debug("getCodUso:" + entrada.getCodUso());
			cstmt.setLong(9, entrada.getCodVendedor());
			logger.debug("getCodVendedor:" + entrada.getCodVendedor());
			cstmt.setLong(10, entrada.getCodVendedorAgente());
			logger.debug("getCodVendedorAgente:" + entrada.getCodVendedorAgente());
			cstmt.setString(11, entrada.getNumSerieSimcard());
			logger.debug("Num Serie simcard:" + entrada.getNumSerieSimcard());
			cstmt.setLong(12, entrada.getNumVenta());
			logger.debug("Num Venta:" + entrada.getNumVenta());
			cstmt.setLong(13, entrada.getCodModVenta());
			logger.debug("Modalidad Venta:" + entrada.getCodModVenta());
			cstmt.setString(14, entrada.getClaseServicio());
			logger.debug("Clase Servicio:" + entrada.getClaseServicio());
			cstmt.setInt(15, entrada.getIndTelefono());
			logger.debug("Indicador telefono:" + entrada.getIndTelefono());
			cstmt.setString(16, entrada.getCodPlanTarif());
			logger.debug("Plan Tarifario:" + entrada.getCodPlanTarif());
			cstmt.setString(17, entrada.getTipPlantarif());
			logger.debug("Tipo Plan Tarifario:" + entrada.getTipPlantarif());
			cstmt.setLong(18, entrada.getCodUsuario());
			logger.debug("Codigo Usuario:" + entrada.getCodUsuario());
			cstmt.setInt(19, entrada.getIndTelefono());
			logger.debug("Ind Telefono:" + entrada.getIndTelefono());
			cstmt.setString(20, entrada.getCodPlanTarif());
			logger.debug("Plan:" + entrada.getCodPlanTarif());
			cstmt.setDouble(21, entrada.getCarga());
			logger.debug("Carga:" + entrada.getCarga());
			cstmt.setString(22, entrada.getCodTecnologia());
			logger.debug("Codigo Tecnologia:" + entrada.getCodTecnologia());
			cstmt.setString(23, entrada.getNumSerieTerminal());
			logger.debug("Serie equipo:" + entrada.getNumSerieTerminal());

			logger.debug("Codigo bodega equipo:" + entrada.getCodBodegaTerminal());
			if (entrada.getCodBodegaTerminal() != null) {
				cstmt.setLong(24, Long.valueOf(entrada.getCodBodegaTerminal()).longValue());
			}
			else
				cstmt.setLong(24, 0);

			cstmt.setString(25, entrada.getNumMinMdn());
			logger.debug("Min Mdn:" + entrada.getNumMinMdn());
			cstmt.setString(26, entrada.getCodCelda());
			logger.debug("Codigo Subalm:" + entrada.getCodCelda());
			cstmt.setLong(27, entrada.getCodCliente());
			logger.debug("Codigo Vendealer:" + entrada.getCodVendealer());
			if (entrada.getCodVendealer() == 0) {
				cstmt.setString(28, null);
			}
			else
				cstmt.setLong(28, entrada.getCodVendealer());
			logger.debug("Codigo Cliente:" + entrada.getCodCliente());
			cstmt.setString(29, entrada.getClaseServicio());
			logger.debug("Clase Servicio:" + entrada.getClaseServicio());
			cstmt.setString(30, entrada.getCodSituacion());
			logger.debug("Codigo Situacion:" + entrada.getCodSituacion());
			cstmt.setString(31, entrada.getNomUsuarOra());
			logger.debug("Nombre usuarora:" + entrada.getNomUsuarOra());
			cstmt.setString(32, entrada.getCodPlanServ());
			logger.debug("Codigo Plan Servicio:" + entrada.getCodPlanServ());
			cstmt.setString(33, entrada.getCodTipoPrestacion());
			logger.debug("Codigo Plan Servicio:" + entrada.getCodTipoPrestacion());
			cstmt.setString(34, entrada.getTipTerminal());
			logger.debug("tipo terminal:" + entrada.getTipTerminal());
			cstmt.setString(35, entrada.getCodOperacion());
			logger.debug("cod operacion:" + entrada.getCodOperacion());
			cstmt.setString(36, entrada.getCodCausaVenta());
			logger.debug("cod causa venta:" + entrada.getCodCausaVenta());
			cstmt.setString(37, entrada.getCodCargoBasico());
			logger.debug("cod cargo basico:" + entrada.getCodCargoBasico());

			cstmt.registerOutParameter(38, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(39, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(40, java.sql.Types.NUMERIC);

			logger.debug("Inicio:creaAbonadoPrepago:execute");
			cstmt.execute();
			logger.debug("Inicio:creaAbonadoPrepago:execute");
			codError = cstmt.getInt(38);
			msgError = cstmt.getString(39);
			numEvento = cstmt.getInt(40);

			if (codError != 0) {
				logger.error("Ocurrio un error al crear el abonado");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new CustomerDomainException("Ocurrio un error al crear el abonado", String.valueOf(codError),
						numEvento, msgError);
			}

			logger.debug("msgError[" + msgError + "]");

		}
		catch (CustomerDomainException e) {
			logger.error("Ocurrio un error al crear abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw (e);
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al crear abonado", e);
			throw new CustomerDomainException("Ocurrio un error al crear el abonado");
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:creaAbonado");
	}//fin creaAbonadoPrepago

	public AbonadoDTO[] getListadoAbonadosVenta(AbonadoDTO entrada) throws CustomerDomainException {
		logger.debug("getListadoAbonadosVenta:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO[] resultado = null;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String call = getSQL("VE_servicios_venta_PG", "VE_obtiene_AbonadosVta_PR", 6);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, entrada.getNumVenta());
			cstmt.setString(2, entrada.getOrigen());
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getListadoAbonadosVenta:Execute");
			cstmt.execute();
			logger.debug("Fin:getListadoAbonadosVenta:Execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				logger.error("Ocurrio un error al recuperar los abonados para la venta");
				throw new CustomerDomainException("Ocurrio un error al recuperar los abonados para la venta", String
						.valueOf(codError), numEvento, msgError);

			}
			else {
				logger.debug("Recuperando abonados");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					AbonadoDTO abonadoDTO = new AbonadoDTO();
					abonadoDTO.setRowNum(rs.getLong(1));
					abonadoDTO.setNumAbonado(rs.getLong(2));
					abonadoDTO.setCodGrpPrestacion(rs.getString(3));
					abonadoDTO.setNumCelular(rs.getLong(4));
					abonadoDTO.setCodPlanTarif(rs.getString(5));
					abonadoDTO.setCodSituacion(rs.getString(6));
					abonadoDTO.setDesSituacion(rs.getString(7));
					abonadoDTO.setCodGrpPrestacionWM(rs.getString(8));
					lista.add(abonadoDTO);
				}
				resultado = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), AbonadoDTO.class);
				logger.debug("Fin recuperacion de abonados");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al recuperar abonados para la venta", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al recuperar abonados para la venta", e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getListaAbonadosVenta()");

		return resultado;
	}//fin getListadoAbonadosVenta

	public void eliminaAbonado(AbonadoDTO entrada) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:eliminaAbonado");
			String call = getSQL("VE_servicios_venta_PG", "VE_reversaAbonados_PR", 7);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getNumAbonado());
			logger.debug("Numero Abonado:" + entrada.getNumAbonado());
			cstmt.setLong(2, entrada.getCodVendedor());
			logger.debug("Codigo Vendedor:" + entrada.getCodVendedor());
			cstmt.setString(3, entrada.getNomUsuarOra());
			logger.debug("Nom Usuarora:" + entrada.getNomUsuarOra());
			cstmt.setLong(4, entrada.getNumVenta());
			logger.debug("Num Vneta:" + entrada.getNumVenta());

			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.debug("Inicio:eliminaAbonado:execute");
			cstmt.execute();
			logger.debug("Inicio:eliminaAbonado:execute");
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			if (codError != 0) {
				logger.error("Ocurrio un error al eliminar el abonado");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new CustomerDomainException("Ocurrio un error al eliminar el abonado", String.valueOf(codError),
						numEvento, msgError);
			}
			logger.debug("msgError[" + msgError + "]");

		}
		catch (CustomerDomainException e) {
			logger.error("Ocurrio un error al eliminar abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw (e);
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al eliminar abonado", e);
			throw new CustomerDomainException("Ocurrio un error al eliminar el abonado");
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:eliminaAbonado");
	}//fin eliminaAbonado

	public AbonadoDTO[] getListaAbonadosCarrier(Long entrada) throws CustomerDomainException {
		logger.debug("getListaAbonadosCarrier:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO[] resultado = null;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String call = getSQL("VE_servicios_venta_PG", "VE_obtiene_abonados_vtaCA_PR", 5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.longValue());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getListaAbonadosCarrier:Execute");
			cstmt.execute();
			logger.debug("Fin:getListaAbonadosCarrier:Execute");
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				logger.error("Ocurrio un error al recuperar abonados carrier para la venta");
				throw new CustomerDomainException("Ocurrio un error al recuperar abonados carrier para la venta",
						String.valueOf(codError), numEvento, msgError);
			}
			else {
				logger.debug("Recuperando abonados");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					AbonadoDTO abonadoDTO = new AbonadoDTO();
					abonadoDTO.setNumAbonado(rs.getLong(1));
					lista.add(abonadoDTO);
				}
				resultado = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), AbonadoDTO.class);
				logger.debug("Fin recuperacion de abonados carrier");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al recuperar abonados carrier para la venta", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getListaAbonadosCarrier()");
		return resultado;
	}//fin getListaAbonadosCarrier

	public AbonadoDTO[] obtenerAbonadosDistribuidos(AbonadoDTO entrada) throws CustomerDomainException {
		logger.debug("obtenerAbonadosDistribuidos:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO[] resultado = null;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String call = getSQL("GA_DISTRIBUCION_BOLSA_PG", "VE_obtieneAbonados_Dist_PR", 6);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getNumVenta());
			logger.debug("numVenta: ");
			cstmt.setString(2, entrada.getCodPlanTarif());

			cstmt.registerOutParameter(3, OracleTypes.CURSOR);

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			logger.debug("Inicio:obtenerAbonadosDistribuidos:Execute");
			cstmt.execute();
			logger.debug("Fin:obtenerAbonadosDistribuidos:Execute");
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				logger.error("Ocurrio un error al recuperar abonados distribuidos");
				throw new CustomerDomainException("Ocurrio un error al recuperar abonados distribuidos", String
						.valueOf(codError), numEvento, msgError);
			}
			else {
				logger.debug("Recuperando abonados");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					AbonadoDTO abonadoDTO = new AbonadoDTO();
					abonadoDTO.setNumAbonado(rs.getLong(1));
					abonadoDTO.setNumCelular(rs.getLong(2));
					lista.add(abonadoDTO);
				}
				resultado = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), AbonadoDTO.class);
				logger.debug("Fin recuperacion de abonados");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al recuperar abonados distribuidos", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtenerAbonadosDistribuidos()");
		return resultado;
	}//fin obtenerAbonadosDistribuidos

	/*Obtiene una glosa con información del abonado*/
	public String getDatosInstalacion(Long numAbonado) throws CustomerDomainException {
		logger.debug("getDatosInstalacion:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String resultado = null;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			String call = getSQL("VE_servicios_venta_PG", "VE_Obtiene_DatosInstalacion_PR", 5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, numAbonado.longValue());
			cstmt.registerOutParameter(2, OracleTypes.CLOB);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getDatosInstalacion:Execute");
			cstmt.execute();
			logger.debug("Fin:getDatosInstalacion:Execute");
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				logger.error("Ocurrio un error al obtener datos de instalacion del abonado");
				throw new CustomerDomainException("Ocurrio un error al obtener datos de instalacion del abonado",
						String.valueOf(codError), numEvento, msgError);
			}
			else {
				Clob datosInstalacionClob = cstmt.getClob(2);
				java.io.Reader reader = datosInstalacionClob.getCharacterStream();

				StringBuffer sb = new StringBuffer();

				int nchars = 0; // Number of characters read
				char[] buffer = new char[10]; // Buffer holding characters being transferred

				while ((nchars = reader.read(buffer)) != -1)
					// Read from Clob
					sb.append(buffer, 0, nchars); // Write to StringBuffer

				resultado = sb.toString();

			}

		}
		catch (Exception e) {
			logger.error("Ocurrio un error al obtener datos de instalacion del abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getDatosInstalacion()");
		return resultado;
	}//fin getDatosInstalacion

	/**
	 * Almacena los niveles de la prestacion del abonado
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */

	public void insertaNivelesAbonado(NivelAbonadoDTO entrada) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:insertaNivelesAbonado");

			String call = getSQL("Ve_Servicios_Solicitud_Pg", "VE_inserta_niveles_abo_PR", 7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getNumAbonado());
			logger.debug("entrada.getNumAbonado(): " + entrada.getNumAbonado());
			cstmt.setString(2, entrada.getCodNivel1());
			logger.debug("entrada.getCodNivel1(): " + entrada.getCodNivel1());
			cstmt.setString(3, entrada.getCodNivel2());
			logger.debug("entrada.getCodNivel2(): " + entrada.getCodNivel2());
			cstmt.setString(4, entrada.getCodNivel3());
			logger.debug("entrada.getCodNivel3(): " + entrada.getCodNivel3());

			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cstmt.execute();

			msgError = cstmt.getString(5);
			codError = cstmt.getInt(6);
			numEvento = cstmt.getInt(7);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrio un error al insertar niveles de prestacion ");
				throw new CustomerDomainException("Ocurrio un error al insertar niveles de prestacion ", String
						.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e) {
			logger.error("Ocurrio un error al insertar niveles de prestacion ", e);
			throw new CustomerDomainException("Ocurrio un error al insertar niveles de prestacion ", e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:insertaNivelesAbonado");
	}

	/**
	 * inserta registro de datos adicionales del abonado con ind de renovacion
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */

	public void insertaDatosAdicAbonado(RenovacionAbonadoDTO entrada) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:insertaDatosAdicAbonado");

			String call = getSQL("Ve_Servicios_Solicitud_Pg", "VE_inserta_datosAdic_abo_PR", 7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getNumAbonado());
			logger.debug("entrada.getNumAbonado(): " + entrada.getNumAbonado());
			cstmt.setInt(2, entrada.getIndRenovacion());
			logger.debug("entrada.getIndRenovacion(): " + entrada.getIndRenovacion());
			cstmt.setLong(3, entrada.getNumFax());
			logger.debug("entrada.getNumFax(): " + entrada.getNumFax());
			cstmt.setString(4, entrada.getCodCalificacion());
			logger.debug("entrada.getCodCalificacion(): " + entrada.getCodCalificacion());

			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cstmt.execute();

			msgError = cstmt.getString(5);
			codError = cstmt.getInt(6);
			numEvento = cstmt.getInt(7);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrio un error al insertar datos adicionales del abonado ");
				throw new CustomerDomainException("Ocurrio un error al insertar datos adicionales del abonado ", String
						.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e) {
			logger.error("Ocurrio un error al insertar datos adicionales del abonado ", e);
			throw new CustomerDomainException("Ocurrio un error al insertar datos adicionales del abonado ", e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:insertaDatosAdicAbonado");
	}

	public void updWimaxMacAddress(AbonadoDTO abonado) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:updWimaxMacAddress");

			String call = getSQL("VE_SERVICIOS_SOLICITUD_PG", "VE_Upd_datosAdic_abo_PR", 5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, abonado.getNumAbonado());
			cstmt.setString(2, abonado.getWimaxMacAddress());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:updWimaxMacAddress:execute");
			cstmt.execute();
			logger.debug("Fin:updWimaxMacAddress:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				logger.error("Ocurrio un error al actualizar la IP Mac Addrees (Wimax)");
				throw new CustomerDomainException("Ocurrio un error al actualizar la IP Mac Addrees (Wimax)", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al actualizar la IP Mac Addrees (Wimax)", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrio un error al actualizar la IP Mac Addrees (Wimax)", e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:updWimaxMacAddress");
	}//fin updWimaxMacAddress

	public void updEstadoMovProductoSolicitud(Long numVenta) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		String mensajeError = "Ocurrio un error al actualizar el estado del movimiento";
		try {
			logger.debug("Inicio:updEstadoMovProductoSolicitud");

			String call = getSQL("VE_SERVICIOS_SOLICITUD_PG", "ve_actualiza_movproductosol_pr", 4);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, numVenta.longValue());

			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("Inicio:updEstadoMovProductoSolicitud:execute");
			cstmt.execute();
			logger.debug("Fin:updEstadoMovProductoSolicitud:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(mensajeError, e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:updEstadoMovProductoSolicitud");
	}//fin updEstadoMovProductoSolicitud

	/**
	 * @author JIB
	 * @param numSerie
	 * @return
	 * @throws CustomerDomainException
	 */
	public boolean existeAbonadoXSimcard(Long numSerie) throws CustomerDomainException {
		final String nombreMetodo = "existeAbonadoXSimcard";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("numSerie [" + numSerie + "]");
		final String nombrePackage = "VE_SERVS_ACTIVACIONESWEB_PG";
		final String nombrePLSQL = "VE_existeAbonadoXSimcard_PR";
		final int cantidadParametros = 5;
		final String mensajeError = "Ocurrio un error al obtener data";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		int r = 0;
		CallableStatement cstmt = null;
		try {
			conn = getConection();
			int i = 1;
			final String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setObject(i++, numSerie);

			cstmt.registerOutParameter(i++, OracleTypes.INTEGER);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);
			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			r = cstmt.getInt(cantidadParametros - 3);
		}
		catch (CustomerDomainException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.error("codError [" + codError + "]");
			logger.error("msgError [" + msgError + "]");
			logger.error("numEvento [" + numEvento + "]");
			throw e;
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new CustomerDomainException(e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.error("SQLException", e);
			}
		}
		logger.info(nombreMetodo + ", fin");
		return r == 0 ? false : true;
	}

	/**
	 * @author JIB
	 * @param numImei
	 * @param codSituacion
	 * @return
	 * @throws CustomerDomainException
	 */
	public boolean existeAbonadoXImei(Long numImei) throws CustomerDomainException {
		final String nombreMetodo = "existeAbonadoXImei";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("numImei [" + numImei + "]");
		final String nombrePackage = "VE_SERVS_ACTIVACIONESWEB_PG";
		final String nombrePLSQL = "VE_existeAbonadoXImei_PR";
		final int cantidadParametros = 5;
		final String mensajeError = "Ocurrio un error al obtener data";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		int r = 0;
		CallableStatement cstmt = null;
		try {
			conn = getConection();
			int i = 1;
			final String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setObject(i++, numImei);

			cstmt.registerOutParameter(i++, OracleTypes.INTEGER);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, despues");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);
			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			r = cstmt.getInt(cantidadParametros - 3);
		}
		catch (CustomerDomainException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.error("codError [" + codError + "]");
			logger.error("msgError [" + msgError + "]");
			logger.error("numEvento [" + numEvento + "]");
			throw e;
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new CustomerDomainException(e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.error("SQLException", e);
			}
		}
		logger.info(nombreMetodo + ", fin");
		return r == 0 ? false : true;
	}

}//fin AbonadoDAO
