package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsRegistraCampanaByPInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AperturaRangoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.GaEquipAboserDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.OutAbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RestriccionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ServSuplementarioLineaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoLineaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInformacionLineaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInformacionLineaOutDTO;

public class AbonadoDAO extends ConnectionDAO{
	private Logger logger = Logger.getLogger(AbonadoDAO.class);

	Global global = Global.getInstance();

	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConection

	private String getSQLDatosAbonado(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosAbonado


	private String getSQLDatosProcedure(String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosAbonado	

	/**
	 * Guarda un nuevo abonado
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */

	public void creaAbonado(AbonadoDTO entrada)throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:creaAbonado");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_crea_linea_venta_PG","ve_in_pospago_portado_pr",91);
			String call = getSQLDatosAbonado("VE_crea_linea_venta_quiosco_PG","ve_in_pospago_portado_pr",91);

			logger.debug("sql[" + call + "]");


			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,entrada.getNumAbonado());
			logger.debug("Numero Abonado:" + entrada.getNumAbonado());
			cstmt.setLong(2,entrada.getNumCelular());
			logger.debug("Celular:" + entrada.getNumCelular());
			cstmt.setInt(3,entrada.getCodProducto());
			logger.debug("Codigo producto:" + entrada.getCodProducto());
			cstmt.setLong(4,entrada.getCodCliente());
			logger.debug("Codigo cliente:" + entrada.getCodCliente());
			cstmt.setLong(5,entrada.getCodCuenta());
			logger.debug("Codigo cuenta:" + entrada.getCodCuenta());
			cstmt.setString(6,entrada.getCodSubCuenta());
			logger.debug("Codigo subcuenta:" + entrada.getCodSubCuenta());
			cstmt.setLong(7,entrada.getCodUsuario());
			logger.debug("Codigo usuario:" + entrada.getCodUsuario());
			cstmt.setString(8,entrada.getCodRegion());
			logger.debug("getCodRegion():" + entrada.getCodRegion());
			cstmt.setString(9,entrada.getCodProvincia());
			logger.debug("getCodProvincia():" + entrada.getCodProvincia());
			cstmt.setString(10,entrada.getCodCiudad());
			logger.debug("getCodCiudad():" + entrada.getCodCiudad());
			cstmt.setString(11,entrada.getCodCelda());
			logger.debug("getCodCelda()" + entrada.getCodCelda());
			cstmt.setInt(12,entrada.getCodCentral());
			logger.debug("getCodCentral():" + entrada.getCodCentral());
			cstmt.setString(13,entrada.getCodUso());
			logger.debug("getCodUso:" + entrada.getCodUso());
			cstmt.setString(14,entrada.getCodSituacion());
			logger.debug("getCodSituacion:" + entrada.getCodSituacion());
			cstmt.setString(15,entrada.getIndProcAlta());
			logger.debug("getIndProcAlta:" + entrada.getIndProcAlta());
			cstmt.setString(16,entrada.getIndProcEqTerminal() );
			logger.debug("getIndProcEqui:" + entrada.getIndProcEqTerminal());
			cstmt.setLong(17,new Long(entrada.getVendedor().getCodigoVendedor()).longValue());
			logger.debug("getCodVendedor:" + entrada.getVendedor().getCodigoVendedor());
			cstmt.setLong(18,entrada.getVendedor().getCodigoVendedorRaiz());
			logger.debug("getCodVendedorAgente:" + entrada.getVendedor().getCodigoVendedorRaiz());
			cstmt.setString(19,entrada.getTipPlantarif());
			logger.debug("getTipPlantarif:" + entrada.getTipPlantarif());
			cstmt.setString(20,entrada.getTipTerminal());
			logger.debug("getTipTerminal:" + entrada.getTipTerminal());
			cstmt.setString(21,entrada.getCodPlanTarif());
			logger.debug("getCodPlanTarif:" + entrada.getCodPlanTarif());
			cstmt.setString(22,entrada.getCodCargoBasico());
			logger.debug("getCodCargoBasico :" + entrada.getCodCargoBasico());
			cstmt.setString(23,entrada.getCodPlanServ());
			logger.debug("getCodPlanServ :" + entrada.getCodPlanServ());
			cstmt.setString(24,entrada.getCodLimConsumo());
			logger.debug("getCodLimConsumo :" + entrada.getCodLimConsumo());
			cstmt.setString(25,entrada.getNumSerieSimcard());
			logger.debug("getNumSerie :" + entrada.getNumSerieSimcard());
			cstmt.setString(26,entrada.getNumSerieHex());
			logger.debug("getNumSerieHex :" + entrada.getNumSerieHex());
			cstmt.setString(27,entrada.getNomUsuarOra());
			logger.debug("getNomUsuarOra :" + entrada.getNomUsuarOra());
			cstmt.setString(28,entrada.getFecAlta());
			logger.debug("fecha alta:" + entrada.getFecAlta());
			cstmt.setInt(29,entrada.getNumPerContrato());
			logger.debug("getNumPerContrato :" + entrada.getNumPerContrato());
			cstmt.setString(30,entrada.getCodigoEstado());
			logger.debug("getCodEstado :" + entrada.getCodigoEstado());
			cstmt.setString(31,entrada.getNumSerieMec());
			logger.debug("getNumSerieMec :" + entrada.getNumSerieMec());
			cstmt.setString(32,null);
			if (entrada.getCodEmpresa()>0){
				cstmt.setLong(33,entrada.getCodEmpresa());
				logger.debug ("Empresa ga_abocel: " + entrada.getCodEmpresa());
			}
			else{
				cstmt.setString(33,null);
				logger.debug ("Empresa ga_abocel: " + "null");
			}
			logger.debug("getCodEmpresa :" + entrada.getCodEmpresa());
			cstmt.setString(34,entrada.getCodGrpSrv());
			logger.debug("getCodGrpSrv :" + entrada.getCodGrpSrv());
			cstmt.setInt(35,entrada.getIndSuperTel());
			logger.debug("getIndSuperTel :" + entrada.getIndSuperTel());
			cstmt.setString(36,entrada.getNumTeleFija());
			logger.debug("getNumTeleFija :" + entrada.getNumTeleFija());
			//cstmt.setLong(37,entrada.getCodOpRedFija()); Por defecto null
			//cstmt.setLong(38,entrada.getCodCarrier());Por defecto null
			cstmt.setString(37,null);
			logger.debug("null :" + null);
			cstmt.setString(38,null);
			logger.debug("null :" + null);
			cstmt.setInt(39,entrada.getIndPrepago());
			logger.debug("getIndPrepago :" + entrada.getIndPrepago());
			cstmt.setInt(40,entrada.getIndPlexSys());
			logger.debug("getIndPlexSys :" + entrada.getIndPlexSys());
			cstmt.setString(41,entrada.getCodCentralPlex());
			logger.debug("getCodCentralPlex :" + entrada.getCodCentralPlex());
			cstmt.setString(42,entrada.getNumCelularPlex());
			logger.debug("getNumCelularPlex :" + entrada.getNumCelularPlex());
			cstmt.setLong(43,entrada.getNumVenta());
			logger.debug("getNumVenta :" + entrada.getNumVenta());
			cstmt.setLong(44,entrada.getCodModVenta());
			logger.debug("getCodModVenta :" + entrada.getCodModVenta());
			cstmt.setString(45,entrada.getCodTipContrato());
			logger.debug("getCodTipContrato :" + entrada.getCodTipContrato());
			cstmt.setString(46,entrada.getNumContrato());
			logger.debug("getNumContrato :" + entrada.getNumContrato());
			cstmt.setString(47,entrada.getNumAnexo());
			logger.debug("getNumAnexo :" + entrada.getNumAnexo());
			cstmt.setString(48,entrada.getFecCumPlan());
			logger.debug("getFecCumPlan:" + entrada.getFecCumPlan());
			cstmt.setString(49,entrada.getCodCredMor());
			logger.debug("getCodCredMor :" + entrada.getCodCredMor());
			cstmt.setString(50,entrada.getCodCredCon());
			logger.debug("getCodCredCon :" + entrada.getCodCredCon());
			cstmt.setInt(51,entrada.getCodCiclo());
			logger.debug("getCodCiclo :" + entrada.getCodCiclo());
			cstmt.setInt(52,entrada.getCodFactur());//revisar dato
			logger.debug("getCodFactur :" + entrada.getCodFactur());
			cstmt.setInt(53,entrada.getIndSuspen());
			logger.debug("getIndSuspen :" + entrada.getIndSuspen());
			cstmt.setInt(54,entrada.getIndReHabi());
			logger.debug("getIndReHabi :" + entrada.getIndReHabi());
			cstmt.setInt(55,entrada.getInsGuias());
			logger.debug("getInsGuias :" + entrada.getInsGuias());
			cstmt.setString(56,entrada.getFecFinContra());
			logger.debug("getFecFinContra :" + entrada.getFecFinContra());
			cstmt.setString(57,entrada.getFecRecDocu());
			logger.debug("rec docu:" + entrada.getFecRecDocu());
			cstmt.setString(58,entrada.getFecCumplimen());
			logger.debug("fec cumplimen:" + entrada.getFecCumplimen());
			cstmt.setString(59,entrada.getFecAcepVenta());
			logger.debug("getFecAcepVenta():" + entrada.getFecAcepVenta());
			cstmt.setString(60,entrada.getFecActCen());
			logger.debug("getFecActCen:" + entrada.getFecActCen());
			cstmt.setString(61,entrada.getFecBaja());
			logger.debug("getFecBaja:" + entrada.getFecBaja());
			cstmt.setString(62,entrada.getFecBajaCen());
			logger.debug("getFecBajaCen:" + entrada.getFecBajaCen());
			cstmt.setString(63,entrada.getFecUltMod());
			logger.debug("getFecUltMod:" + entrada.getFecUltMod());
			cstmt.setString(64,entrada.getCodCausaBaja());
			logger.debug("getCodCausaBaja :" + entrada.getCodCausaBaja());
			cstmt.setString(65,entrada.getNumPersonal());
			logger.debug("getNumPersonal :" + entrada.getNumPersonal());
			cstmt.setInt(66,entrada.getIndSeguro());
			logger.debug("getIndSeguro :" + entrada.getIndSeguro());
			cstmt.setString(67,entrada.getClaseServicio());
			logger.debug("getClaseServicio :" + entrada.getClaseServicio());
			cstmt.setString(68,entrada.getPerfilAbonado());
			logger.debug("getPerfilAbonado :" + entrada.getPerfilAbonado());
			cstmt.setString(69,entrada.getNumMin());
			logger.debug("getNumMin :" + entrada.getNumMin());
			cstmt.setString(70,entrada.getCodVendealer()==0?null:String.valueOf(entrada.getCodVendealer()));
			logger.debug("getCodVendealer :" + entrada.getCodVendealer());
			cstmt.setString(71,null);
			logger.debug("getIndDisp :" + entrada.getIndDisp());
			cstmt.setString(72,entrada.getCodPassword());
			logger.debug("getCodPassword :" + entrada.getCodPassword());
			cstmt.setString(73,entrada.getIndPassword());
			logger.debug("getIndPassword :" + entrada.getIndPassword());
			cstmt.setString(74,entrada.getCodAfinidad());
			logger.debug("getCodAfinidad :" + entrada.getCodAfinidad());
			cstmt.setString(75,entrada.getFecProrroga());
			logger.debug("getFecProrroga:" + entrada.getFecProrroga());
			cstmt.setString(76,entrada.getIndEqPrestadoTerminal());
			logger.debug("getIndEqPrestadoTerminal :" + entrada.getIndEqPrestadoTerminal());
			cstmt.setString(77,entrada.getFlgContDigi());
			logger.debug("getFlgContDigi :" + entrada.getFlgContDigi());
			cstmt.setString(78,entrada.getFecAltanTras());
			logger.debug("getFecAltanTras:" + entrada.getFecAltanTras());
			cstmt.setInt(79,entrada.getCodIndemnizacion());
			logger.debug("getCodIndemnizacion :" + entrada.getCodIndemnizacion());
			cstmt.setString(80,entrada.getNumImei());
			logger.debug("getNumImei :" + entrada.getNumImei());
			cstmt.setString(81,entrada.getCodTecnologia());
			logger.debug("getCodTecnologia :" + entrada.getCodTecnologia());
			cstmt.setString(82,entrada.getNumMinMdn());
			logger.debug("getNumMinMdn :" + entrada.getNumMinMdn());
			cstmt.setString(83,entrada.getFecActivacion());
			logger.debug("Fecha Activacion:" + entrada.getFecActivacion());
			cstmt.setInt(84,entrada.getIndTelefono());
			logger.debug("getIndTelefono :" + entrada.getIndTelefono());
			cstmt.setString(85,entrada.getCodOficinaPrincipal());
			logger.debug("getCodOficinaPrincipal :" + entrada.getCodOficinaPrincipal());
			cstmt.setString(86,entrada.getCodCausaVenta());
			logger.debug("getCodCausaVenta :" + entrada.getCodCausaVenta());


			cstmt.setString(87,entrada.getIndicadorPortado());
			logger.debug("getCodCausaVenta :" + entrada.getIndicadorPortado());
			cstmt.setString(88,entrada.getCodigoOperador());					
			logger.debug("getCodOperacion :" + entrada.getCodigoOperador());

			cstmt.registerOutParameter(89,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(90,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(91,java.sql.Types.NUMERIC);

			logger.debug("Inicio:creaAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:creaAbonado:execute");

			codError=cstmt.getInt(89);
			msgError = cstmt.getString(90);
			numEvento=cstmt.getInt(91);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al crear el abonado");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al crear el abonado", String
						.valueOf(codError), numEvento, msgError);
			}


			logger.debug("msgError[" + msgError + "]");

		} catch (GeneralException e) {
			logger.error("Ocurrió un error al crear abonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al crear abonado",e);
			throw new GeneralException("12283",0,
			"Ocurrió un error al crear el abonado");
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:creaAbonado");

	}

	/**
	 * Guarda un nuevo abonado
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */

	public void creaAbonadoprepago(AbonadoDTO entrada)throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:creaAbonado");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_crea_linea_venta_PG","ve_in_prepago_portado_PR",88);
			String call = getSQLDatosAbonado("VE_crea_linea_venta_quiosco_PG","ve_in_prepago_portado_PR",88); 

			logger.debug("sql[" + call + "]");


			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,entrada.getNumAbonado());
			logger.debug("Numero Abonado:" + entrada.getNumAbonado());
			cstmt.setLong(2,entrada.getNumCelular());
			logger.debug("Celular:" + entrada.getNumCelular());
			cstmt.setInt(3,entrada.getCodProducto());
			logger.debug("Codigo producto:" + entrada.getCodProducto());
			cstmt.setLong(4,entrada.getCodCliente());
			logger.debug("Codigo cliente:" + entrada.getCodCliente());
			cstmt.setLong(5,entrada.getCodCuenta());
			logger.debug("Codigo cuenta:" + entrada.getCodCuenta());
			cstmt.setString(6,entrada.getCodSubCuenta());
			logger.debug("Codigo subcuenta:" + entrada.getCodSubCuenta());
			cstmt.setLong(7,entrada.getCodUsuario());
			logger.debug("Codigo usuario:" + entrada.getCodUsuario());
			cstmt.setString(8,entrada.getCodRegion());
			logger.debug("getCodRegion():" + entrada.getCodRegion());
			cstmt.setString(9,entrada.getCodProvincia());
			logger.debug("getCodProvincia():" + entrada.getCodProvincia());
			cstmt.setString(10,entrada.getCodCiudad());
			logger.debug("getCodCiudad():" + entrada.getCodCiudad());
			cstmt.setString(11,entrada.getCodCelda());
			logger.debug("getCodCelda()" + entrada.getCodCelda());
			cstmt.setInt(12,entrada.getCodCentral());
			logger.debug("getCodCentral():" + entrada.getCodCentral());
			cstmt.setString(13,entrada.getCodUso());
			logger.debug("getCodUso:" + entrada.getCodUso());
			cstmt.setString(14,entrada.getCodSituacion());
			logger.debug("getCodSituacion:" + entrada.getCodSituacion());
			cstmt.setString(15,entrada.getIndProcAlta());
			logger.debug("getIndProcAlta:" + entrada.getIndProcAlta());
			cstmt.setString(16,entrada.getIndProcEqTerminal());
			logger.debug("getIndProcEqui:" + entrada.getIndProcEqTerminal());
			cstmt.setLong(17,new Long(entrada.getVendedor().getCodigoVendedor()).longValue());
			logger.debug("getCodVendedor:" + entrada.getVendedor().getCodigoVendedor());
			cstmt.setLong(18,entrada.getVendedor().getCodigoVendedorRaiz());
			logger.debug("getCodVendedorAgente:" + entrada.getVendedor().getCodigoVendedorRaiz());
			cstmt.setString(19,entrada.getTipPlantarif());
			logger.debug("getTipPlantarif:" + entrada.getTipPlantarif());
			cstmt.setString(20,entrada.getTipTerminal());
			logger.debug("getTipTerminal:" + entrada.getTipTerminal());
			cstmt.setString(21,entrada.getCodPlanTarif());
			logger.debug("getCodPlanTarif:" + entrada.getCodPlanTarif());
			cstmt.setString(22,entrada.getCodCargoBasico());
			logger.debug("getCodCargoBasico :" + entrada.getCodCargoBasico());
			cstmt.setString(23,entrada.getCodPlanServ());
			logger.debug("getCodPlanServ :" + entrada.getCodPlanServ());
			cstmt.setString(24,entrada.getCodLimConsumo());
			logger.debug("getCodLimConsumo :" + entrada.getCodLimConsumo());
			cstmt.setString(25,entrada.getNumSerieSimcard());
			logger.debug("getNumSerie :" + entrada.getNumSerieSimcard());
			cstmt.setString(26,entrada.getNumSerieHex());
			logger.debug("getNumSerieHex :" + entrada.getNumSerieHex());
			cstmt.setString(27,entrada.getNomUsuarOra());
			logger.debug("getNomUsuarOra :" + entrada.getNomUsuarOra());
			cstmt.setString(28,entrada.getFecAlta());
			logger.debug("fecha alta:" + entrada.getFecAlta());
			cstmt.setInt(29,entrada.getNumPerContrato());
			logger.debug("getNumPerContrato :" + entrada.getNumPerContrato());
			cstmt.setString(30,entrada.getCodigoEstado());
			logger.debug("getCodEstado :" + entrada.getCodigoEstado());
			cstmt.setString(31,entrada.getNumSerieMec());
			logger.debug("getNumSerieMec :" + entrada.getNumSerieMec());
			cstmt.setString(32,null);
			if (entrada.getCodEmpresa()>0){
				cstmt.setLong(33,entrada.getCodEmpresa());
				logger.debug ("Empresa ga_abocel: " + entrada.getCodEmpresa());
			}
			else{
				cstmt.setString(33,null);
				logger.debug ("Empresa ga_abocel: " + "null");
			}
			logger.debug("getCodEmpresa :" + entrada.getCodEmpresa());
			cstmt.setString(34,entrada.getCodGrpSrv());
			logger.debug("getCodGrpSrv :" + entrada.getCodGrpSrv());
			cstmt.setInt(35,entrada.getIndSuperTel());
			logger.debug("getIndSuperTel :" + entrada.getIndSuperTel());
			cstmt.setString(36,entrada.getNumTeleFija());
			logger.debug("getNumTeleFija :" + entrada.getNumTeleFija());
			//cstmt.setLong(37,entrada.getCodOpRedFija()); Por defecto null
			//cstmt.setLong(38,entrada.getCodCarrier());Por defecto null
			cstmt.setString(37,null);
			logger.debug("null :" + null);
			cstmt.setString(38,null);
			logger.debug("null :" + null);
			cstmt.setInt(39,1);
			logger.debug("getIndPrepago :" + 1);
			cstmt.setInt(40,entrada.getIndPlexSys());
			logger.debug("getIndPlexSys :" + entrada.getIndPlexSys());
			cstmt.setString(41,entrada.getCodCentralPlex());
			logger.debug("getCodCentralPlex :" + entrada.getCodCentralPlex());
			cstmt.setString(42,entrada.getNumCelularPlex());
			logger.debug("getNumCelularPlex :" + entrada.getNumCelularPlex());
			cstmt.setLong(43,entrada.getNumVenta());
			logger.debug("getNumVenta :" + entrada.getNumVenta());
			cstmt.setLong(44,entrada.getCodModVenta());
			logger.debug("getCodModVenta :" + entrada.getCodModVenta());
			cstmt.setString(45,entrada.getCodTipContrato());
			logger.debug("getCodTipContrato :" + entrada.getCodTipContrato());
			cstmt.setString(46,"");
			logger.debug("getNumContrato :" + "");
			cstmt.setString(47,"");
			logger.debug("getNumAnexo :" + "");
			cstmt.setString(48,entrada.getFecCumPlan());
			logger.debug("getFecCumPlan:" + entrada.getFecCumPlan());
			cstmt.setString(49,entrada.getCodCredMor());
			logger.debug("getCodCredMor :" + entrada.getCodCredMor());
			cstmt.setString(50,entrada.getCodCredCon());
			logger.debug("getCodCredCon :" + entrada.getCodCredCon());
			cstmt.setInt(51,entrada.getCodCiclo());
			logger.debug("getCodCiclo :" + entrada.getCodCiclo());
			cstmt.setInt(52,entrada.getCodFactur());//revisar dato
			logger.debug("getCodFactur :" + entrada.getCodFactur());
			cstmt.setInt(53,entrada.getIndSuspen());
			logger.debug("getIndSuspen :" + entrada.getIndSuspen());
			cstmt.setInt(54,entrada.getIndReHabi());
			logger.debug("getIndReHabi :" + entrada.getIndReHabi());
			cstmt.setInt(55,entrada.getInsGuias());
			logger.debug("getInsGuias :" + entrada.getInsGuias());
			cstmt.setString(56,"");
			logger.debug("getFecFinContra :" + "");
			cstmt.setString(57,entrada.getFecRecDocu());
			logger.debug("rec docu:" + entrada.getFecRecDocu());
			cstmt.setString(58,entrada.getFecCumplimen());
			logger.debug("fec cumplimen:" + entrada.getFecCumplimen());
			cstmt.setString(59,entrada.getFecAcepVenta());
			logger.debug("getFecAcepVenta():" + entrada.getFecAcepVenta());
			cstmt.setString(60,entrada.getFecActCen());
			logger.debug("getFecActCen:" + entrada.getFecActCen());
			cstmt.setString(61,entrada.getFecBaja());
			logger.debug("getFecBaja:" + entrada.getFecBaja());
			cstmt.setString(62,entrada.getFecBajaCen());
			logger.debug("getFecBajaCen:" + entrada.getFecBajaCen());
			cstmt.setString(63,entrada.getFecUltMod());
			logger.debug("getFecUltMod:" + entrada.getFecUltMod());
			cstmt.setString(64,entrada.getCodCausaBaja());
			logger.debug("getCodCausaBaja :" + entrada.getCodCausaBaja());
			cstmt.setString(65,entrada.getNumPersonal());
			logger.debug("getNumPersonal :" + entrada.getNumPersonal());
			cstmt.setInt(66,entrada.getIndSeguro());
			logger.debug("getIndSeguro :" + entrada.getIndSeguro());
			cstmt.setString(67,entrada.getClaseServicio());
			logger.debug("getClaseServicio :" + entrada.getClaseServicio());
			cstmt.setString(68,entrada.getPerfilAbonado());
			logger.debug("getPerfilAbonado :" + entrada.getPerfilAbonado());
			cstmt.setString(69,entrada.getNumMin());
			logger.debug("getNumMin :" + entrada.getNumMin());
			cstmt.setString(70,entrada.getCodVendealer()==0?null:String.valueOf(entrada.getCodVendealer()));
			logger.debug("getCodVendealer :" + entrada.getCodVendealer());
			cstmt.setString(71,null);
			logger.debug("getIndDisp :" + entrada.getIndDisp());
			cstmt.setString(72,entrada.getCodPassword());
			logger.debug("getCodPassword :" + entrada.getCodPassword());
			cstmt.setString(73,entrada.getIndPassword());
			logger.debug("getIndPassword :" + entrada.getIndPassword());
			cstmt.setString(74,entrada.getCodAfinidad());
			logger.debug("getCodAfinidad :" + entrada.getCodAfinidad());

			cstmt.setString(75,entrada.getNumImei());
			logger.debug("getNumImei :" + entrada.getNumImei());
			cstmt.setString(76,entrada.getCodTecnologia());
			logger.debug("getCodTecnologia :" + entrada.getCodTecnologia());
			cstmt.setString(77,entrada.getNumMinMdn());
			logger.debug("getNumMinMdn :" + entrada.getNumMinMdn());
			cstmt.setString(78,entrada.getFecActivacion());
			logger.debug("Fecha Activacion:" + entrada.getFecActivacion());
			cstmt.setInt(79,entrada.getIndTelefono());
			logger.debug("getIndTelefono :" + entrada.getIndTelefono());
			cstmt.setString(80,entrada.getCodOficinaPrincipal());
			logger.debug("getCodOficinaPrincipal :" + entrada.getCodOficinaPrincipal());
			cstmt.setString(81,entrada.getCodCausaVenta());
			logger.debug("getCodCausaVenta :" + entrada.getCodCausaVenta());
			//INI-01 (AL)
			//cstmt.setString(82,entrada.getIndicadorPortado());
			//logger.debug("getIndicadorPortado :" + entrada.getIndicadorPortado());
			cstmt.setString(82,entrada.getVendedor().getCodigoCliente());					
			logger.debug("getVendedor().getCodigoCliente() :" + entrada.getVendedor().getCodigoCliente());
			cstmt.setString(83,entrada.getVendedor().getCodigoCuenta());					
			logger.debug("getVendedor().getCodigoCuenta() :" + entrada.getVendedor().getCodigoCuenta());
			//INI-01 (AL)
			//cstmt.setString(85,entrada.getCodigoOperador());					
			//logger.debug("getCodigoOperador :" + entrada.getCodigoOperador());
			
			/*CSR-11002 7.1.3 RMS_003 Modificaciones en registro de la venta*/
			logger.debug("getCodOperacion :" + entrada.getCodOperacion());
			cstmt.setString(84,entrada.getCodOperacion());
			
			/*CSR-11002 7.1.3 RMS_003 Modificaciones en registro de la venta*/
			logger.debug("getCodPrestacion :" + entrada.getCodPrestacion());
			cstmt.setString(85,entrada.getCodPrestacion());

			cstmt.registerOutParameter(86,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(87,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(88,java.sql.Types.NUMERIC);

			logger.debug("Inicio:creaAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:creaAbonado:execute");

			codError=cstmt.getInt(86);
			msgError = cstmt.getString(87);
			numEvento=cstmt.getInt(88);


			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al crear el abonado");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al crear el abonado", String
						.valueOf(codError), numEvento, msgError);
			}


			logger.debug("msgError[" + msgError + "]");

		} catch (GeneralException e) {
			logger.error("Ocurrió un error al crear abonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al crear abonado",e);
			throw new GeneralException("12284",0,
			"Ocurrió un error al crear el abonado");
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:creaAbonado");

	}	

	/**
	 * Almacena la Simcard del Nuevo Abonado
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */


	public void creaSimcardAboser(AbonadoDTO entrada)throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:creaSimcardAboser");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_crea_linea_venta_PG","VE_IN_GA_EQUIPABOSER_PR",31);
			String call = getSQLDatosAbonado("VE_crea_linea_venta_quiosco_PG","VE_IN_GA_EQUIPABOSER_PR",31);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,entrada.getNumAbonado());
			logger.debug("Numero Abonado:" + entrada.getNumAbonado());
			cstmt.setString(2,entrada.getNumSerieSimcard());
			logger.debug("Numero Serie:" + entrada.getNumSerieSimcard());
			cstmt.setInt(3,entrada.getCodProducto());
			logger.debug("Producto:" + entrada.getCodProducto());
			cstmt.setString(4,entrada.getIndProcEqSimcard());
			logger.debug("Procedencia Equipo:" + entrada.getIndProcEqSimcard());
			cstmt.setString(5,entrada.getFecAlta());
			logger.debug("getFecAlta:"+entrada.getFecAlta());

			cstmt.setString(6,entrada.getIndPropiedad());
			logger.debug("Propiedad:" + entrada.getIndPropiedad());
			cstmt.setLong(7,Long.parseLong(entrada.getCodBodegaSimcard()));
			logger.debug("Bodega:" + entrada.getCodBodegaSimcard());

			if (entrada.getIndProcEqSimcard().equals("I")){
				cstmt.setString(8,String.valueOf(entrada.getTipoStockSimcard()));
				logger.debug("tipo stock:" + entrada.getTipoStockSimcard());
			}else{
				cstmt.setString(8,null);
				logger.debug("tipo stock:" + String.valueOf(entrada.getTipoStockSimcard()));
			}
			cstmt.setLong(9,Long.parseLong(entrada.getCodigoArticuloSimcard()));
			logger.debug("articulo:" + entrada.getCodigoArticuloSimcard());
			cstmt.setString(10,entrada.getIndEqAcc());
			logger.debug("indicador accesorio:" + entrada.getIndEqAcc());
			cstmt.setLong(11,entrada.getCodModVenta());
			logger.debug("modalidad venta:" + entrada.getCodModVenta());
			cstmt.setString(12,entrada.getTipTerminalSimcard());
			logger.debug("tipo terminal:" + entrada.getTipTerminalSimcard());
			cstmt.setInt(13,entrada.getCodUsoSimcard());
			logger.debug("cod uso:" + entrada.getCodUsoSimcard());
			cstmt.setString(14,entrada.getCodCuota());
			logger.debug("getCodCuota:" + entrada.getCodCuota());
			cstmt.setInt(15,Integer.parseInt(entrada.getCodEstadoSimcard()));
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
			cstmt.setString(26, entrada.getIndEqPrestadoSimcard());
			logger.debug("getIndComodato:" + entrada.getIndEqPrestadoSimcard());
			cstmt.setString(27,entrada.getNumSerieTerminal());
			logger.debug("imei:" + entrada.getNumSerieTerminal());
			cstmt.setString(28, entrada.getCodTecnologia());
			logger.debug("getCodigoTecnoGsm:" + entrada.getCodTecnologia());
			cstmt.registerOutParameter(29, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(30, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(31, java.sql.Types.NUMERIC);

			logger.debug("Inicio:creaSimcardAboser:execute");
			cstmt.execute();
			logger.debug("Fin:creaSimcardAboser:execute");

			codError=cstmt.getInt(29);
			msgError = cstmt.getString(30);
			numEvento=cstmt.getInt(31);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al insertar simcard en ga_equipaboser");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al insertar simcard en ga_equipaboser", String
						.valueOf(codError), numEvento, msgError);
			}
		} catch (GeneralException e) {
			logger.error("Ocurrió un error al insertar simcard en ga_equipaboser",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar simcard en ga_equipaboser",e);
			throw new GeneralException("12285",0,"Ocurrió un error al insertar simcard en ga_equipaboser");
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:creaSimcardAboser");
	}

	/**
	 * Almacena el terminal del nuevo Abonado
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */

	public void creaTerminalAboser(AbonadoDTO entrada)throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:creaTerminalAboser");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_crea_linea_venta_PG","VE_IN_GA_EQUIPABOSER_PR",31);
			String call = getSQLDatosAbonado("VE_crea_linea_venta_quiosco_PG","VE_IN_GA_EQUIPABOSER_PR",31);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,entrada.getNumAbonado());
			logger.debug("Numero Abonado:" + entrada.getNumAbonado());
			cstmt.setString(2,entrada.getNumSerieTerminal());
			logger.debug("getNumSerieTerminal:" + entrada.getNumSerieTerminal());
			cstmt.setInt(3,entrada.getCodProducto());
			logger.debug("Producto:" + entrada.getCodProducto());
			cstmt.setString(4,entrada.getIndProcEqTerminal());
			logger.debug("Procedencia Equipo:" + entrada.getIndProcEqTerminal());
			cstmt.setString(5,entrada.getFecAlta());
			logger.debug("getFecAlta:"+entrada.getFecAlta());
			cstmt.setString(6,entrada.getIndPropiedad());
			logger.debug("Propiedad:" + entrada.getIndPropiedad());

			cstmt.setString(7,entrada.getCodBodegaTerminal());
			logger.debug("Bodega:" + entrada.getCodBodegaTerminal());
			cstmt.setString(8,entrada.getTipoStockTerminal()==0?null:String.valueOf(entrada.getTipoStockTerminal()));
			logger.debug("tipo stock:" + entrada.getTipoStockTerminal());
			cstmt.setString(9,entrada.getCodigoArticuloTerminal());
			logger.debug("articulo:" + entrada.getCodigoArticuloTerminal());
			cstmt.setString(10,entrada.getIndEqAcc());
			logger.debug("indicador accesorio:" + entrada.getIndEqAcc());
			cstmt.setLong(11,entrada.getCodModVenta());
			logger.debug("modalidad venta:" + entrada.getCodModVenta());
			cstmt.setString(12,entrada.getTipTerminalEquipo());
			logger.debug("tipo terminal:" + entrada.getTipTerminalEquipo());
			cstmt.setInt(13,entrada.getCodUsoTerminal());
			logger.debug("cod uso:" + entrada.getCodUsoTerminal());
			cstmt.setString(14,entrada.getCodCuota());
			logger.debug("getCodCuota:" + entrada.getCodCuota());
			//cstmt.setInt(15,Integer.parseInt(entrada.getCodEstadoTerminal()));
			cstmt.setString(15,entrada.getCodEstadoTerminal());
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
			cstmt.setString(26, entrada.getIndEqPrestadoTerminal());
			logger.debug("getIndComodato:" + entrada.getIndEqPrestadoTerminal());
			cstmt.setString(27, null);
			logger.debug("null");
			cstmt.setString(28, entrada.getCodTecnologia());
			logger.debug("getCodigoTecnoGsm:" +entrada.getCodTecnologia());
			cstmt.registerOutParameter(29, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(30, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(31, java.sql.Types.NUMERIC);

			logger.debug("Inicio:creaTerminalAboser:execute");
			cstmt.execute();
			logger.debug("Fin:creaTerminalAboser:execute");

			codError=cstmt.getInt(29);
			msgError = cstmt.getString(30);
			numEvento=cstmt.getInt(31);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al insertar terminal en ga_equipaboser");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al insertar terminal en ga_equipaboser", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			logger.error("Ocurrió un error al insertar terminal en ga_equipaboser",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar terminal en ga_equipaboser",e);
			throw new GeneralException("12286",0,"Ocurrió un error al insertar terminal en ga_equipaboser");
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:creaTerminalAboser");


	}

	/**
	 * Obtiene Numero de Secuencia para asignarlo a un Nuevo Abonado
	 * @param abonado
	 * @return abonado
	 * @throws GeneralException
	 */

	public AbonadoDTO getSecuenciaAbonado(AbonadoDTO abonado) throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getSecuenciaAbonado");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
			String call = getSQLDatosAbonado("VE_intermediario_Quiosco_PG","VE_OBTIENE_SECUENCIA_PR",5);
			
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,abonado.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getSecuenciaAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:getSecuenciaAbonado:execute");

			msgError = cstmt.getString(4);
			codError=cstmt.getInt(3);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener la secuencia del abonado");
				throw new GeneralException(
						"Ocurrió un error al obtener la secuencia del abonado", String
						.valueOf(codError), numEvento, msgError);
			}
			else
				abonado.setNumAbonado(Long.parseLong(cstmt.getString(2)));

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener la secuencia del abonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener la secuencia del abonado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getSecuenciaAbonado");

		return abonado;
	}

	/**
	 * Consulta si una simcard especifica esta siendo utilizada por algún abonado
	 * @param entradaValidacionVentas
	 * @return resultado
	 * @throws GeneralException
	 */

	public ResultadoValidacionVentaDTO getExisteSerieSimcardEnAbonado(ParametrosValidacionVentasDTO entradaValidacionVentas) throws GeneralException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getExisteSerieSimcardEnAbonado");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_validacion_linea_PG","VE_existeserieabonado_PR",5);
			String call = getSQLDatosAbonado("VE_validacion_linea_quiosco_PG","VE_existeserieabonado_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entradaValidacionVentas.getNumeroSerie());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getExisteSerieSimcardEnAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:getExisteSerieSimcardEnAbonado:execute");

			msgError = cstmt.getString(4);
			codError=cstmt.getInt(3);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al buscar serie simcard en abonado");
				throw new GeneralException(
						"Ocurrió un error al buscar serie simcard en abonado", String
						.valueOf(codError), numEvento, msgError);
			}
			else{
				if (cstmt.getInt(2)==1)
					logger.debug("SERIE:<<< EXISTE >>> "+ entradaValidacionVentas.getNumeroSerie());
				else
					logger.debug("SERIE:<<< NO EXISTE >>> " + entradaValidacionVentas.getNumeroSerie());

				resultado.setResultadoBase(cstmt.getInt(2));
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al buscar serie simcard en abonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al buscar serie simcard en abonado",e);

		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
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
	 * @throws GeneralException
	 */

	public ResultadoValidacionVentaDTO existeSerieTerminalEnAbonado(ParametrosValidacionVentasDTO entradaValidacionVentas) throws GeneralException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:existeSerieTerminalEnAbonado");
			
			//INI-01 (AL) String call = getSQLDatosAbonado("VE_validacion_linea_PG","VE_serieterminalenabonado_PR",5);
			String call = getSQLDatosAbonado("VE_validacion_linea_quiosco_PG","VE_serieterminalenabonado_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entradaValidacionVentas.getNumeroSerie());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			msgError = cstmt.getString(4);
			codError=cstmt.getInt(3);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al buscar serie terminal en abonado");
				throw new GeneralException(
						"Ocurrió un error al buscar serie terminal en abonado", String
						.valueOf(codError), numEvento, msgError);
			}
			else{

				if (cstmt.getInt(2)==1)
					logger.debug("SERIE:<<< EXISTE >>> "+ entradaValidacionVentas.getNumeroSerie());
				else
					logger.debug("SERIE:<<< NO EXISTE >>> " + entradaValidacionVentas.getNumeroSerie());

				resultado.setResultadoBase(cstmt.getInt(2));
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al buscar serie terminal en abonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al buscar serie terminal en abonado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:existeSerieTerminalEnAbonado");

		return resultado;
	}//fin getExisteSerieSimcardEnAbonado

	public ResultadoValidacionVentaDTO getValidaSerieTerminalListaNegra(TerminalSNPNDTO terminal) throws GeneralException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getValidaSerieTerminalListaNegra");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_validacion_linea_PG","VE_terminallistanegra_PR",5);
			String call = getSQLDatosAbonado("VE_validacion_linea_quiosco_PG","VE_terminallistanegra_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,terminal.getNumeroSerie());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getValidaSerieTerminalListaNegra:execute");
			cstmt.execute();
			logger.debug("Inicio:getValidaSerieTerminalListaNegra:execute");

			msgError = cstmt.getString(4);
			codError=cstmt.getInt(3);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al buscar serie terminal en listas negras");
				throw new GeneralException(
						"Ocurrió un error al buscar serie terminal en listas negras", String
						.valueOf(codError), numEvento, msgError);
			}
			else{

				if (cstmt.getInt(2)==1)
					logger.debug("SERIE:<<< EN LISTA NEGRA >>>");
				else
					logger.debug("SERIE:<<< NO EN LISTA NEGRA >>>");

				resultado.setResultadoBase(cstmt.getInt(2));
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al buscar serie terminal en listas negras",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al buscar serie terminal en listas negras",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getValidaSerieTerminalListaNegra");

		return resultado;
	}//fin getValidaSerieTerminalListaNegra

	/**
	 * Obtiene oficina principal de un Nuevo Abonado
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */

	public AbonadoDTO getOficinaPrincipal(VendedorDTO entrada) throws GeneralException{
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
			cstmt.setString(2,entrada.getDireccion().getRegion());
			cstmt.setString(3,entrada.getDireccion().getProvincia());
			cstmt.setString(4,entrada.getDireccion().getCiudad());
			logger.debug("Inicio:getOficinaPrincipal:execute");
			cstmt.execute();
			logger.debug("Inicio:getOficinaPrincipal:fin Execute");

			resultado.setCodOficinaPrincipal(cstmt.getString(1));
			logger.debug("oficina principal:" + resultado.getCodOficinaPrincipal());

		} catch (Exception e) {
			logger.error("Ocurrió un error al buscar la oficina principal",e);
			throw new GeneralException(
					"Ocurrió un error al buscar la oficina principal",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
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
	 * @throws GeneralException
	 */

	public AbonadoDTO[] getListaAbonadosVenta(RegistroVentaDTO registroventa) throws GeneralException{
		logger.debug("getListaAbonadosVenta:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO[] resultado = null;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQLDatosAbonado("VE_servicios_venta_PG","VE_obtiene_abonados_venta_PR",5);
			String call = getSQLDatosAbonado("VE_servicios_venta_Quiosco_PG","VE_obtiene_abonados_venta_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,registroventa.getNumeroVenta());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getListaAbonadosVenta:Execute");
			cstmt.execute();
			logger.debug("Fin:getListaAbonadosVenta:Execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar abonados para la venta");
				throw new GeneralException(
						"Ocurrió un error al recuperar abonados para la venta", String
						.valueOf(codError), numEvento, msgError);

			}else{
				logger.debug("Recuperando abonados");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					AbonadoDTO abonadoDTO = new AbonadoDTO();
					abonadoDTO.setNumAbonado(rs.getLong(1));
					logger.debug("abonadoDTO.setNumAbonado[" + rs.getLong(1) + "]");
					abonadoDTO.setCodPlanTarif(rs.getString(2));
					logger.debug("abonadoDTO.setCodPlanTarif[" + rs.getString(2) + "]");
					abonadoDTO.setCodCargoBasico(rs.getString(3));
					logger.debug("abonadoDTO.setCodCargoBasico[" + rs.getString(3) + "]");
					abonadoDTO.setCodPlanServ(rs.getString(4));
					logger.debug("abonadoDTO.setCodPlanServ[" + rs.getString(4) + "]");
					abonadoDTO.setNumSerieSimcard(rs.getString(5));
					logger.debug("abonadoDTO.setNumSerieSimcard[" + rs.getString(5) + "]");
					abonadoDTO.setNumSerieTerminal(rs.getString(6));
					logger.debug("abonadoDTO.setNumSerieTerminal[" + rs.getString(6) + "]");
					abonadoDTO.setCodCliente(rs.getLong(7));
					logger.debug("abonadoDTO.setCodCliente[" + rs.getLong(7) + "]");
					abonadoDTO.setCodVendedor(rs.getLong(8));
					logger.debug("abonadoDTO.setCodVendedor[" + rs.getLong(8) + "]");
					abonadoDTO.setCodTipContrato(rs.getString(9));
					logger.debug("abonadoDTO.setCodTipContrato[" + rs.getString(9) + "]");
					abonadoDTO.setCodCausaVenta(rs.getString(10));
					logger.debug("abonadoDTO.setCodCausaVenta[" + rs.getString(10) + "]");
					abonadoDTO.setCodModVenta(rs.getLong(11));
					logger.debug("abonadoDTO.setCodModVenta[" + rs.getLong(11) + "]");
					abonadoDTO.setTipPlantarif(rs.getString(12));
					logger.debug("abonadoDTO.setTipPlantarif[" + rs.getString(12) + "]");
					abonadoDTO.setNumContrato(rs.getString(13));
					logger.debug("abonadoDTO.setNumContrato[" + rs.getString(13) + "]");
					abonadoDTO.setCodUso(rs.getString(14));
					logger.debug("abonadoDTO.setCodUso[" + rs.getString(14) + "]");
					abonadoDTO.setNumMin(rs.getString(15));
					logger.debug("abonadoDTO.setNumMin[" + rs.getString(15) + "]");
					abonadoDTO.setCodCentral(rs.getInt(16));
					logger.debug("abonadoDTO.setCodCentral[" + rs.getInt(16) + "]");
					abonadoDTO.setNumCelular(rs.getLong(17));
					logger.debug("abonadoDTO.setNumCelular[" + rs.getLong(17) + "]");
					abonadoDTO.setCodCuenta(rs.getLong(18));
					logger.debug("abonadoDTO.setCodCuenta[" + rs.getLong(18) + "]");
					abonadoDTO.setCodCiclo(rs.getInt(19));
					logger.debug("abonadoDTO.setCodCiclo[" + rs.getInt(19) + "]");
					abonadoDTO.setNumVenta(registroventa.getNumeroVenta());
					logger.debug("abonadoDTO.setNumVenta[" +registroventa.getNumeroVenta() + "]");
					abonadoDTO.setCodVendealer(rs.getInt(20));
					logger.debug("abonadoDTO.setCodVendealer[" + rs.getInt(20) + "]");
					abonadoDTO.setCodTecnologia(rs.getString(21));
					logger.debug("abonadoDTO.setCodTecnologia[" + rs.getString(21)+ "]");
					abonadoDTO.setCodCelda(rs.getString(22));
					logger.debug("abonadoDTO.setCodCelda[" + rs.getString(22) + "]");
					abonadoDTO.setTipTerminal(rs.getString(23));
					logger.debug("abonadoDTO.setNumAbonado[" + rs.getString(23) + "]");
					abonadoDTO.setNumSerieHex(rs.getString(24));
					logger.debug("abonadoDTO.setNumAbonado[" + rs.getString(24) + "]");
					abonadoDTO.setIndProcEqTerminal(rs.getString(25));
					logger.debug("abonadoDTO.setNumAbonado[" + rs.getString(25) + "]");
					lista.add(abonadoDTO);
				}
				resultado =(AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), AbonadoDTO.class);
				rs.close();
				logger.debug("Fin recuperacion de abonados");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar abonados para la venta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar abonados para la venta",e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
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
	 * @throws GeneralException
	 */
	public AbonadoDTO[] getEquiposSeriados(AbonadoDTO abonado)
	throws GeneralException{
		logger.debug("getListaAbonadosVenta:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO[] resultado = null;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt=null;
		try {
			//INI-01 (AL) String call = getSQLDatosAbonado("VE_servicios_venta_PG","VE_obtiene_equipos_seriados_PR",6);
			String call = getSQLDatosAbonado("VE_servicios_venta_Quiosco_PG","VE_obtiene_equipos_seriados_PR",6);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,String.valueOf(abonado.getNumAbonado()));
			logger.debug("abonado.getNumAbonado() ["+abonado.getNumAbonado()+"]");
			cstmt.setString(2,abonado.getIndProcEqTerminal());
			logger.debug("abonado.getIndProcEqTerminal() ["+abonado.getIndProcEqTerminal()+"]");
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getListaAbonadosVenta:Execute");
			cstmt.execute();
			logger.debug("Fin:getListaAbonadosVenta:Execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar equipos seriados");
				throw new GeneralException(
						"Ocurrió un error al recuperar equipos seriados", String
						.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando equipos seriados");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					AbonadoDTO abonadoDTO = new AbonadoDTO();
					abonadoDTO.setTipoStock(rs.getLong(1));
					logger.debug("abonadoDTO.setTipoStock() ["+rs.getLong(1)+"]");
					abonadoDTO.setCodigoBodega(rs.getString(2));
					logger.debug("abonadoDTO.setCodigoBodega() ["+rs.getString(2)+"]");
					abonadoDTO.setCodigoArticulo(rs.getString(3));
					logger.debug("abonadoDTO.setCodigoArticulo() ["+rs.getLong(1)+"]");
					abonadoDTO.setCodUso(rs.getString(4));
					logger.debug("abonadoDTO.setCodUso() ["+rs.getString(4)+"]");
					abonadoDTO.setCodigoEstado(rs.getString(5));
					logger.debug("abonadoDTO.setCodigoEstado() ["+rs.getString(5)+"]");
					abonadoDTO.setNumeroSerie(rs.getString(6));
					logger.debug("abonadoDTO.setNumeroSerie() ["+rs.getString(6)+"]");
					abonadoDTO.setIndicadorEquiAcc(rs.getString(7));
					logger.debug("abonadoDTO.setIndicadorEquiAcc() ["+rs.getString(7)+"]");
					abonadoDTO.setTipTerminal( rs.getString(8));
					logger.debug("abonadoDTO.setTipTerminal() ["+rs.getString(8)+"]");
					lista.add(abonadoDTO);
				}
				resultado =(AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), AbonadoDTO.class);
				rs.close();
				logger.debug("Fin recuperacion de abonados");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}

		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar abonados para la venta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar abonados para la venta",e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
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
	 * @throws GeneralException
	 */
	public void actualizaEquipAboSer(AbonadoDTO entrada)
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:actualizaEquipAboSer");

			//INI-01 (AL) String call = getSQLDatosAbonado("Ve_Servicios_Venta_Pg","VE_actualiza_equipaboser_PR",13);
			String call = getSQLDatosAbonado("Ve_Servicios_Venta_Quiosco_Pg","VE_actualiza_equipaboser_PR",13);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getNumeroMovimiento());
			cstmt.setLong(2,entrada.getTipoStock());
			cstmt.setString(3,entrada.getCodigoBodegaActual());
			cstmt.setLong(4,entrada.getTipoStockOriginal());
			cstmt.setString(5,entrada.getCodigoBodega());
			cstmt.setString(6,entrada.getCodigoArticulo());
			cstmt.setString(7,entrada.getCodUso());
			cstmt.setString(8,entrada.getCodigoEstado());
			cstmt.setString(9,entrada.getNumeroSerie());
			cstmt.setLong(10,entrada.getNumAbonado());
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			logger.debug("Inicio:actualizaEquipAboSer:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaEquipAboSer:execute");

			msgError  = cstmt.getString(12);
			codError  = cstmt.getInt(11);
			numEvento = cstmt.getInt(13);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al actualizar tabla ga_equipaboser");
				throw new GeneralException(
						"Ocurrió un error al actualizar tabla ga_equipaboser", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar tabla ga_equipaboser",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:actualizaEquipAboSer");
	}//fin actualizaEquipAboSer
	
	
	/*
	 * public void updateAboVendealer(String numAbonado) throws GeneralException{		
		
			cat.debug(" updateAboVendealer:start");
			abonadoDAO.updateAboVendealer(numAbonado);
			cat.debug(" updateAboVendealer:end");
	}
	 */
	/**
	 * Actualiza tabla ga_equipaboser
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */
	public void updateAboVendealer(String numAbonado)
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:updateAboVendealer");

			//INI-01 (AL) String call = getSQLDatosAbonado("Ve_Servicios_Venta_Pg","VE_actualiza_abovendealer_PR",4);
			String call = getSQLDatosAbonado("Ve_Servicios_Venta_Quiosco_Pg","VE_actualiza_abovendealer_PR",4);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			logger.debug("ABONADO A UPDATE numAbonado: "+numAbonado);
			cstmt.setString(1,numAbonado);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("Inicio:updateAboVendealer:execute");
			cstmt.execute();
			logger.debug("Fin:updateAboVendealer:execute");

			msgError  = cstmt.getString(2);
			codError  = cstmt.getInt(3);
			numEvento = cstmt.getInt(4);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al actualizar tabla ga_aboamist");
				throw new GeneralException(
						"Ocurrió un error al actualizar tabla ga_aboamist", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar tabla ga_aboamist",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:updateAboVendealer");
	}
	
	

	/**
	 * Almacena el monto de garantia asociada al abonado
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */

	public void insertaGarantiaAbonado(AbonadoDTO entrada)throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:insertaGarantiaAbonado");

			//INI-01 (AL) String call = getSQLDatosAbonado("Ve_Servicios_Venta_Pg","VE_ins_abo_garantia_PR",8);
			String call = getSQLDatosAbonado("Ve_Servicios_Venta_Quiosco_Pg","VE_ins_abo_garantia_PR",8);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,entrada.getNumVenta());
			logger.debug("entrada.getNumVenta(): " + entrada.getNumVenta());
			cstmt.setLong(2,entrada.getCodCliente());
			logger.debug("entrada.getCodCliente(): " + entrada.getCodCliente());
			cstmt.setLong(3,entrada.getNumAbonado());
			logger.debug("entrada.getNumAbonado(): " + entrada.getNumAbonado());
			cstmt.setFloat(4,entrada.getMontoGarantia());
			logger.debug("entrada.getMontoGarantia(): " + entrada.getMontoGarantia());
			cstmt.setInt(5,entrada.getIndicadorPago());
			logger.debug("entrada.getIndicadorPago(): " + entrada.getIndicadorPago());

			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.debug("Inicio:insertaGarantiaAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:insertaGarantiaAbonado:execute");

			msgError = cstmt.getString(6);
			codError=cstmt.getInt(7);
			numEvento=cstmt.getInt(8);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al insertar la garantia");
				throw new GeneralException(
						"Ocurrió un error al insertar la garantia", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar la garantia",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar la garantia",e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:creaTerminalAboser");
	}

	/**
	 * Actualiza clase servicio para el abonado
	 * @param abonado
	 * @return 
	 * @throws GeneralException
	 */
	public void updAbonadoClaseServ(AbonadoDTO abonado) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:updAbonadoClaseServ");

			//INI-01 (AL) String call = getSQLDatosAbonado("Ve_Servicios_Venta_Pg","VE_updAbocelClaseServ_PR",5);
			String call = getSQLDatosAbonado("Ve_Servicios_Venta_Quiosco_Pg","VE_updAbocelClaseServ_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,abonado.getNumAbonado());
			cstmt.setString(2,abonado.getClaseServicio());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:updAbonadoClaseServ:execute");
			cstmt.execute();
			logger.debug("Fin:updAbonadoClaseServ:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al actualizar clase servicio del abonado");
				throw new GeneralException(
						"Ocurrió un error al actualizar clase servicio del abonado", String
						.valueOf(codError), numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;			
		}catch (Exception e) {
			logger.error("Ocurrió un error al actualizar clase servicio del abonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al actualizar clase servicio del abonado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:updAbonadoClaseServ");
	}//fin updAbonadoClaseServ


	/**
	 * Actualiza código situación del abonado
	 * @param abonado
	 * @return 
	 * @throws GeneralException
	 */
	public void updCodigoSituacion(AbonadoDTO abonado) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:updCodigoSituacion");

			//INI-01 (AL) String call = getSQLDatosAbonado("Ve_Servicios_Venta_Pg","VE_updAbocelCodSituac_PR",5);
			String call = getSQLDatosAbonado("Ve_Servicios_Venta_Quiosco_Pg","VE_updAbocelCodSituac_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,abonado.getNumVenta());
			cstmt.setString(2,abonado.getCodSituacion());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:updCodigoSituacion:execute");
			cstmt.execute();
			logger.debug("Fin:updCodigoSituacion:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al actualizar código situación del abonado");
				throw new GeneralException(
						"Ocurrió un error al actualizar código situación del abonado", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar código situación del abonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al actualizar código situación del abonado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:updCodigoSituacion");
	}//fin updCodigoSituacion

	/**
	 * Obtiene numero abonados vigentes por cliente
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */	
	public Long obtieneAbonadosVigentes(Long codCliente) 
	throws GeneralException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		Long resultado = new Long(0);
		try {
			logger.debug("Inicio:obtieneAbonadosVigentes");

			//INI-01 (AL) String call = getSQLDatosAbonado("Ve_Servicios_Venta_Pg","VE_obtiene_AbosVigCliente_PR",5);
			String call = getSQLDatosAbonado("Ve_Servicios_Venta_Quiosco_Pg","VE_obtiene_AbosVigCliente_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,codCliente.longValue());			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:obtieneAbonadosVigentes:execute");
			cstmt.execute();
			logger.debug("Fin:obtieneAbonadosVigentes:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener abonados Vigentes");
				throw new GeneralException(
						"Ocurrió un error al obtener abonados Vigentes", String
						.valueOf(codError), numEvento, msgError);
			}
			resultado = new Long(cstmt.getInt(2)) ;

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener abonados Vigentes",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener abonados Vigentes",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtieneAbonadosVigentes");
		return resultado;
	}//fin obtieneAbonadosVigentes

	private String getSQLsetMarcaAbonadoPortado(){
		StringBuffer call = new StringBuffer();
		call.append(" BEGIN	" +
				//INI-01 (AL )"	VE_CREA_LINEA_VENTA_PG.VE_MARCA_ABONADO_PORT_PR ( ?,?,?,?,?);" +
				"	VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_MARCA_ABONADO_PORT_PR ( ?,?,?,?,?);" +
		"	END;");
		return call.toString();	
	}

	public OutAbonadoPortadoDTO setMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		OutAbonadoPortadoDTO resultado = new OutAbonadoPortadoDTO();
		try {
			logger.debug("Inicio:obtieneAbonadosVigentes");
			String call = getSQLsetMarcaAbonadoPortado();
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,abonadoPortadoDTO.getNumCelular());			
			cstmt.setString(2,abonadoPortadoDTO.getPerfil());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:setMarcaAbonadoPortado:execute");
			cstmt.execute();
			logger.debug("Fin:setMarcaAbonadoPortado:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al setMarcaAbonadoPortado");
				throw new GeneralException(
						"Ocurrió un error al setMarcaAbonadoPortado", String
						.valueOf(codError), numEvento, msgError);
			}


		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al setMarcaAbonadoPortado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al setMarcaAbonadoPortado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtieneAbonadosVigentes");
		return resultado;
	}

	private String getSQLsetDesMarcaAbonadoPortado(){
		StringBuffer call = new StringBuffer();
		call.append(" BEGIN" +
				//INI-01 (AL) "	  VE_CREA_LINEA_VENTA_PG.VE_DESMARCA_ABONADO_PORT_PR ( ?, ?, ?, ?, ?, ? );" +
				"	  VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_DESMARCA_ABONADO_PORT_PR ( ?, ?, ?, ?, ?, ? );" +
		"	END;");
		return call.toString();	
	}


	public OutAbonadoPortadoDTO setDesMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		OutAbonadoPortadoDTO resultado = new OutAbonadoPortadoDTO();
		try {
			logger.debug("Inicio:obtieneAbonadosVigentes");

			String call = getSQLsetDesMarcaAbonadoPortado();

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,abonadoPortadoDTO.getNumCelular());
			cstmt.setString(2,abonadoPortadoDTO.getPerfil());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:obtieneAbonadosVigentes:execute");
			cstmt.execute();
			logger.debug("Fin:obtieneAbonadosVigentes:execute");

			codError=cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento=cstmt.getInt(6);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			resultado.setIndPortado(cstmt.getInt(3));

			if (codError != 0) {
				logger.error("Ocurrió un error al setDesMarcaAbonadoPortado");
				throw new GeneralException(
						"Ocurrió un error al setDesMarcaAbonadoPortado", String
						.valueOf(codError), numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al setDesMarcaAbonadoPortado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al setDesMarcaAbonadoPortado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtieneAbonadosVigentes");
		return resultado;
	}
	private String getSQLgetPreActivaAbonado(){
		StringBuffer call = new StringBuffer();
		call.append(" BEGIN" +
				"	  IC_SERVICIOS_PORTABILIDAD_PG.IC_PREACTIVA_BLOQUEADO_PR ( ?, ?, ?, ?, ?,? );" +
		" END;");
		return call.toString();
	}
	public RetornoDTO getPreActivaAbonado(AbonadoDTO abonadoPortadoDTO)throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		RetornoDTO resultado = new RetornoDTO();
		try {
			logger.debug("Inicio:obtieneAbonadosVigentes");

			String call = getSQLgetPreActivaAbonado();

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,abonadoPortadoDTO.getNumCelular());
			cstmt.setString(2,abonadoPortadoDTO.getCodUso());
			cstmt.setString(3,abonadoPortadoDTO.getIndicadorPortado());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:obtieneAbonadosVigentes:execute");
			cstmt.execute();
			logger.debug("Fin:obtieneAbonadosVigentes:execute");

			codError=cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento=cstmt.getInt(6);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al getPreActivaAbonado");
				throw new GeneralException(
						"Ocurrió un error al getPreActivaAbonado", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al getPreActivaAbonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al getPreActivaAbonado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtieneAbonadosVigentes");
		return resultado;
	}


	private String getSQLgetAperturaRango(){
		StringBuffer call = new StringBuffer();
		call.append(" BEGIN" +
				"	  Al_portabilidad_pg.al_apertura_numeracion_pr(?,?,?,?,?,?,?);"+
		" END;");
		return call.toString();
	}
	public RetornoDTO getAperturaRango (AperturaRangoDTO aperturaRangoDTO)throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;		
		RetornoDTO resultado = new RetornoDTO();
		String ErroImasD = new String();
		int pos = 0;
		try {
			logger.debug("Inicio:getAperturaRango");

			String call = getSQLgetAperturaRango();

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			for (int i=0; i<aperturaRangoDTO.getSimMdn().length; i++){

				cstmt.setLong(1,aperturaRangoDTO.getCodVendedor());
				logger.debug("aperturaRangoDTO.getCodVendedor() [" + aperturaRangoDTO.getCodVendedor() + "]");
				cstmt.setString(2,aperturaRangoDTO.getSimMdn()[i].getNumSimcard());
				logger.debug("aperturaRangoDTO.getNumSimcard() [" + aperturaRangoDTO.getSimMdn()[i].getNumSimcard() + "]");
				cstmt.setLong(3,aperturaRangoDTO.getSimMdn()[i].getMdn());
				logger.debug("aperturaRangoDTO.getMdn() [" + aperturaRangoDTO.getSimMdn()[i].getMdn() + "]");
				cstmt.setString(4,aperturaRangoDTO.getCodUso());
				logger.debug("aperturaRangoDTO.getCodUso() [" + aperturaRangoDTO.getCodUso() + "]");
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

				for (int j = 0; j < 4; j++)
				{
					pos = 0;
					logger.debug("Inicio:getAperturaRango:execute");
					cstmt.execute();
					logger.debug("Fin:getAperturaRango:execute");

					codError = cstmt.getInt(5);
					msgError = cstmt.getString(6);
					numEvento=cstmt.getInt(7);

					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");

					if (codError != 1811){
						break;
					}
					Thread.sleep(2000);      //DELAY 2 segundos   			          
				}

				pos = i+1;

				if (codError != 0){
					ErroImasD = ErroImasD + "("+pos+")|"+codError+"|";
				}
				logger.error("pos ["+pos+"]");
				logger.error("ErroImasD ["+ErroImasD+"]");

			}

			if (ErroImasD.length() > 4){
				resultado.setCodError(ErroImasD);
			}else{
				resultado.setCodError("");				
			}

		}catch (Exception e) {
			logger.error("Ocurrió un error al getAperturaRango",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}						                        
			throw new GeneralException("Ocurrió un error al getAperturaRango",e, String.valueOf(codError) , numEvento ,msgError);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getAperturaRango");
		return resultado;

	}

	/**
	 * Obtiene informacion de una linea dado el numero de celular
	 * @param WsInformacionLineaInDTO
	 * @return WsInformacionLineaOutDTO
	 * @throws GeneralException
	 */
	public WsInformacionLineaOutDTO getInformacionLinea(WsInformacionLineaInDTO wsInformacionLineaInDTO)throws GeneralException{
		//1.27	RSis-038 
		WsInformacionLineaOutDTO resultado=new WsInformacionLineaOutDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		ResultSet rs =null;
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:creaAbonado");

			String call = getSQLDatosAbonado("GE_CONS_CATALOGO_PORTAB_PG","GE_REC_INFO_LINEA_PR",37);
			//1 parametro de entrada, 25 de salida, 1 cursor salida, val retorno 3 ==> 30
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			logger.debug("Numero Celular:" + wsInformacionLineaInDTO.getNumCelular());


			cstmt.setString(1,wsInformacionLineaInDTO.getNumCelular());
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);//codVendedor
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);//codCliente
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);//nomCliente
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);//nomCalleFact
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);//numCalleFact
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);//numPisoFact
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);//obsDireccionFact

			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);//codregionfact
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);//codprovinciafact
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);//codCiudadfact
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);//comunafact

			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);//telefContacto
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);//desEmpresa
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);//nomCalleCorr
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);//numCalleCorr
			cstmt.registerOutParameter(17,java.sql.Types.VARCHAR);//numPisoCorr
			cstmt.registerOutParameter(18,java.sql.Types.VARCHAR);//obsDireccionCorr

			cstmt.registerOutParameter(19,java.sql.Types.VARCHAR);//codregioncorr
			cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);//codprovinciacorr
			cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);//codCiudadcorr
			cstmt.registerOutParameter(22,java.sql.Types.VARCHAR);//comunacorr

			cstmt.registerOutParameter(23,java.sql.Types.NUMERIC);//codSispago
			cstmt.registerOutParameter(24,java.sql.Types.VARCHAR);//codSituacion
			cstmt.registerOutParameter(25,java.sql.Types.VARCHAR);//numSerie
			cstmt.registerOutParameter(26,java.sql.Types.VARCHAR);//nomUsuario
			cstmt.registerOutParameter(27,java.sql.Types.VARCHAR);//fecAlta

			cstmt.registerOutParameter(28,java.sql.Types.VARCHAR);//codIcc
			cstmt.registerOutParameter(29,java.sql.Types.VARCHAR);//codPlantarif
			cstmt.registerOutParameter(30,java.sql.Types.NUMERIC);//codCiclo
			cstmt.registerOutParameter(31,java.sql.Types.VARCHAR);//vigContrato
			cstmt.registerOutParameter(32,java.sql.Types.VARCHAR);//codCategoria
			cstmt.registerOutParameter(33,java.sql.Types.NUMERIC);//codUso
			cstmt.registerOutParameter(34,OracleTypes.CURSOR);//cursor servSupltarios
			cstmt.registerOutParameter(35,java.sql.Types.NUMERIC);//codError
			cstmt.registerOutParameter(36,java.sql.Types.VARCHAR);//msgError
			cstmt.registerOutParameter(37,java.sql.Types.NUMERIC);//numEvento

			logger.debug("Inicio:getInformacionLinea:execute");
			cstmt.execute();
			logger.debug("Fin:getInformacionLinea:execute");

			codError=cstmt.getInt(35);
			msgError = cstmt.getString(36);
			numEvento=cstmt.getInt(37);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener informacion de una linea");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al obtener informacion de una linea", String
						.valueOf(codError), numEvento, msgError);
			}
			else
			{											                          							  							 							  							 							                          							  
				resultado.setCodVendedor(cstmt.getLong(2));
				resultado.setCodCliente(String.valueOf(cstmt.getLong(3)));
				resultado.setNomCliente(cstmt.getString(4));
				resultado.setNomCalleFact(cstmt.getString(5));
				resultado.setNumCalleFact(cstmt.getString(6));
				resultado.setNumPisoFact(cstmt.getString(7));
				resultado.setObsDireccionFact(cstmt.getString(8));
				resultado.setCodRegionFact(cstmt.getString(9));
				resultado.setCodProvinciaFact(cstmt.getString(10));				
				resultado.setCodCiudadFact(cstmt.getString(11));				
				resultado.setCodComunaFact(cstmt.getString(12));
				resultado.setTelefContacto(cstmt.getString(13));//revisar Orden
				resultado.setDesEmpresa(cstmt.getString(14));
				resultado.setNomCalleCorr(cstmt.getString(15));
				resultado.setNumCalleCorr(cstmt.getString(16));
				resultado.setNumPisoCorr(cstmt.getString(17));
				resultado.setObsDireccionCorr(cstmt.getString(18));				
				resultado.setCodRegionCorr(cstmt.getString(19));
				resultado.setCodProvinciaCorr(cstmt.getString(20));				
				resultado.setCodCiudadCorr(cstmt.getString(21));			
				resultado.setCodComunaCorr(cstmt.getString(22));				

				/*		resultado.setCodSispago(cstmt.getInt(23));
				resultado.setCodSituacion(cstmt.getString(24));
				resultado.setNumSerie(cstmt.getString(25));
				resultado.setNomUsuario(cstmt.getString(26));
				resultado.setFecAlta(cstmt.getString(27));//Formato mm-dd-yyyy*/
				resultado.setCodIcc(cstmt.getString(28));
				resultado.setCodPlantarif(cstmt.getString(29));	
				resultado.setCodCiclo(cstmt.getInt(30));
				resultado.setVigContrato(cstmt.getString(31));//Si es a 12, 0, 18 o 24 meses
				resultado.setCodCategoria(cstmt.getString(32));
				resultado.setCodUso(cstmt.getInt(33));//Uso de la línea (prepago, postpago o hibrido)

				ServSuplementarioLineaDTO servSupLineaDTO = null;
				ServSuplementarioLineaDTO[] serviciosSuplementarios;
				rs = (ResultSet) cstmt.getObject(34);
				ArrayList lista = new ArrayList();
				while (rs.next()) {
					servSupLineaDTO = new ServSuplementarioLineaDTO();
					servSupLineaDTO.setCodServicio(rs.getString(1));
					logger.debug("servSupLin.CodServicio["+servSupLineaDTO.getCodServicio()+"]");
					lista.add(servSupLineaDTO);
				}
				rs.close();
				serviciosSuplementarios = (ServSuplementarioLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ServSuplementarioLineaDTO.class);
				resultado.setServiciosSuplementarios(serviciosSuplementarios);

			}
			logger.debug("msgError[" + msgError + "]");

		} catch (GeneralException e) {
			logger.error("Ocurrió un error al obtener informacion de una linea",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener informacion de una linea",e);
			throw new GeneralException("12287",0,
			"Ocurrió un error al obtener informacion de una linea");
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getInformacionLinea");
		return resultado;
	}

	private String getSQLgetAbonadoPorNumCelular(){
		StringBuffer call=new StringBuffer();
		call.append("BEGIN" +
				"	GA_SERVICIOS_ABONADOS_PG.GA_CONS_DATOS_ABO_PR ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );" +
		"END; ");
		return call.toString();
	}


	private String getSQLobtenerDatosAbonado() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE ");
		call.append("   so_abonado GA_ABONADO_PORTAB_QT := NEW  GA_ABONADO_PORTAB_QT();");
		call.append(" BEGIN ");
		call.append("   so_abonado.NUM_CELULAR := ?;");
		call.append("   ve_portabilidad_pg.ga_cons_datos_abo_pr ( SO_ABONADO, ?, ?, ? );");
		call.append("		? := so_abonado.COD_CLIENTE;");
		call.append("		? := so_abonado.NUM_ABONADO;");
		call.append("		? := so_abonado.NUM_CELULAR;");
		call.append("		? := so_abonado.NUM_SERIE;");
		call.append("		? := so_abonado.NUM_SIMCARD;");
		call.append("		? := so_abonado.COD_TECNOLOGIA;");
		call.append("		? := so_abonado.COD_SITUACION;");
		call.append("		? := so_abonado.DES_SITUACION;");
		call.append("		? := so_abonado.TIP_PLANTARIF;");
		call.append("		? := so_abonado.DES_TIPPLANTARIF;");
		call.append("		? := so_abonado.COD_PLANTARIF;");
		call.append("		? := so_abonado.DES_PLANTARIF;");
		call.append("		? := so_abonado.COD_CICLO;");
		call.append("		? := so_abonado.COD_LIMCONSUMO;");
		call.append("		? := so_abonado.DES_LIMCONSUMO;");
		call.append("		? := so_abonado.COD_PLANSERV;");
		call.append("		? := so_abonado.COD_TIPLAN;");
		call.append("		? := so_abonado.DES_TIPLAN;");
		call.append("		? := so_abonado.COD_TIPCONTRATO;");
		call.append("		? := so_abonado.FECHA_ALTA;");
		call.append("		? := so_abonado.FEC_FINCONTRA;");
		call.append("		? := so_abonado.IND_EQPRESTADO;");
		call.append("		? := so_abonado.FECHA_PRORROGA;");
		call.append("		? := so_abonado.FLG_RANGO;");
		call.append("		? := so_abonado.IMP_CARGOBASICO;");
		call.append("		? := so_abonado.NUM_ANEXO;");
		call.append("		? := so_abonado.COD_USUARIO;");
		call.append("		? := so_abonado.COD_USO;");
		call.append("		? := so_abonado.TIP_TERMINAL;");
		call.append("		? := so_abonado.DES_TERMINAL;");
		call.append("		? := so_abonado.NUM_VENTA;");
		call.append("		? := so_abonado.COD_CUENTA;");		
		call.append("		? := so_abonado.COD_SUBCUENTA;");
		call.append("		? := so_abonado.COD_VENDEDOR;");
		call.append("		? := so_abonado.COD_CAUSA_VENTA;");
		call.append("		? := so_abonado.FECHA_BAJA;");
		call.append("		? := so_abonado.FECHA_BAJACEN;");
		call.append("		? := so_abonado.FECHA_ULTMOD;");
		call.append("		? := so_abonado.COD_EMPRESA;");
		call.append("		? := so_abonado.FECHA_ACEPVENTA;");
		call.append("		? := so_abonado.NUM_CONTRATO;");
		call.append("		? := so_abonado.MODALIDAD_DE_PAGO;");		
		call.append("		? := so_abonado.COD_CARGOBASICO;");
		call.append("		? := so_abonado.COD_CENTRAL;");
		call.append("		? := so_abonado.cod_vendealer;");

		call.append(" END;");

		return call.toString();		
	}
	public AbonadoDTO getAbonadoPorNumCelular(AbonadoDTO abonadoDTO)throws GeneralException{
		logger.debug("obtenerDatosAbonado():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLobtenerDatosAbonado();
		try {

			logger.debug("abonado.getNumAbonado()[" + abonadoDTO.getNumCelular() + "]");

			conn = this.getConection();

			cstmt = conn.prepareCall(call);			

			cstmt.setLong(1, abonadoDTO.getNumCelular());

			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);	//COD_CLIENTE
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);	//NUM_ABONADO
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);	//NUM_CELULAR
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);  //NUM_SERIE
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//NUM_SIMCARD
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//COD_TECNOLOGIA
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);	//COD_SITUACION
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);	//DES_SITUACION
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);	//TIP_PLANTARIF
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);	//DES_TIPPLANTARIF
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);	//COD_PLANTARIF
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//DES_PLANTARIF
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);	//COD_CICLO
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);	//COD_LIMCONSUMO
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);	//DES_LIMCONSUMO
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);	//COD_PLANSERV
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);	//COD_TIPLAN
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);	//DES_TIPLAN
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);	//COD_TIPCONTRATO
			cstmt.registerOutParameter(24, java.sql.Types.DATE);	//FECHA_ALTA
			cstmt.registerOutParameter(25, java.sql.Types.DATE);	//FEC_FINCONTRA
			cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);	//IND_EQPRESTADO
			cstmt.registerOutParameter(27, java.sql.Types.DATE);	//FECHA_PRORROGA
			cstmt.registerOutParameter(28, java.sql.Types.NUMERIC);	//FLG_RANGO
			cstmt.registerOutParameter(29, java.sql.Types.NUMERIC);	//IMP_CARGOBASICO
			cstmt.registerOutParameter(30, java.sql.Types.VARCHAR); //NUM_ANEXO
			cstmt.registerOutParameter(31, java.sql.Types.NUMERIC); //COD_USUARIO
			cstmt.registerOutParameter(32, java.sql.Types.VARCHAR); //COD_USO
			cstmt.registerOutParameter(33, java.sql.Types.VARCHAR); //TIP_TERMINAL
			cstmt.registerOutParameter(34, java.sql.Types.VARCHAR); //DES_TERMINAL
			cstmt.registerOutParameter(35, java.sql.Types.NUMERIC); //NUM_VENTA
			cstmt.registerOutParameter(36, java.sql.Types.NUMERIC); //COD_CUENTA
			cstmt.registerOutParameter(37, java.sql.Types.VARCHAR); //COD_SUBCUENTA
			cstmt.registerOutParameter(38, java.sql.Types.NUMERIC); //COD_VENDEDOR
			cstmt.registerOutParameter(39, java.sql.Types.VARCHAR); //COD_CAUSA_VENTA
			cstmt.registerOutParameter(40, java.sql.Types.DATE);	//FECHA_BAJA
			cstmt.registerOutParameter(41, java.sql.Types.DATE);	//FECHA_BAJACEN
			cstmt.registerOutParameter(42, java.sql.Types.DATE);	//FECHA_ULTMOD
			cstmt.registerOutParameter(43, java.sql.Types.NUMERIC);	//COD_EMPRESA
			cstmt.registerOutParameter(44, java.sql.Types.DATE);	//FECHA_ACEPVENTA
			cstmt.registerOutParameter(45, java.sql.Types.VARCHAR); //NUM_CONTRATO
			cstmt.registerOutParameter(46, java.sql.Types.NUMERIC);	//MODALIDAD_DE_PAGO
			cstmt.registerOutParameter(47, java.sql.Types.VARCHAR); //COD_CARGOBASICO
			cstmt.registerOutParameter(48, java.sql.Types.NUMERIC);	//COD_CENTRAL
			cstmt.registerOutParameter(49, java.sql.Types.NUMERIC);	//COD_VENDEALER

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

			if (codError != 0) {
				logger.error(" Ocurrió un error al recuperar los datos del abonado");
				throw new GeneralException(String.valueOf(codError),numEvento, msgError);
			}

			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			long codCliente = cstmt.getLong(5);
			logger.debug("codCliente[" + codCliente + "]");

			long numAbonado = cstmt.getLong(6);
			logger.debug("numAbonado[" + numAbonado + "]");

			long numCelular = cstmt.getLong(7);
			logger.debug("numCelular[" + numCelular + "]");

			String numSerie = cstmt.getString(8);
			logger.debug("numSerie[" + numSerie + "]");

			String numSimcard = cstmt.getString(9);
			logger.debug("numSimcard[" + numSimcard + "]");

			String codTecnologia = cstmt.getString(10);
			logger.debug("codTecnologia[" + codTecnologia + "]");

			String codSituacion = cstmt.getString(11);
			logger.debug("codSituacion[" + codSituacion + "]");

			String desSituacion = cstmt.getString(12);
			logger.debug("desSituacion[" + desSituacion + "]");

			String tipPlanTarif = cstmt.getString(13);
			logger.debug("tipPlanTarif[" + tipPlanTarif + "]");

			String desTipPlanTarif = cstmt.getString(14);
			logger.debug("desTipPlanTarif[" + desTipPlanTarif + "]");

			String codPlanTarif = cstmt.getString(15);
			logger.debug("codPlanTarif[" + codPlanTarif + "]");

			String desPlanTarif = cstmt.getString(16);
			logger.debug("desPlanTarif[" + desPlanTarif + "]");

			int codCiclo = cstmt.getInt(17);
			logger.debug("codCiclo[" + codCiclo + "]");

			String codLimConsumo = cstmt.getString(18);
			logger.debug("codLimConsumo[" + codLimConsumo + "]");

			String desLimConsumo = cstmt.getString(19);
			logger.debug("desLimConsumo[" + desLimConsumo + "]");	

			String codPlanServ = cstmt.getString(20);
			logger.debug("codPlanServ[" + codPlanServ + "]");

			String codTiplan =  cstmt.getString(21);
			logger.debug("codTiplan[" + codTiplan + "]");

			String desTiplan =  cstmt.getString(22);
			logger.debug("desTiplan[" + desTiplan + "]");

			String codTipContrato =  cstmt.getString(23);
			logger.debug("codTipContrato[" + codTipContrato + "]");

			Date fechaAlta = cstmt.getDate(24);
			logger.debug("fechaAlta[" + fechaAlta + "]");

			Date fechaFinContrato = cstmt.getDate(25);
			logger.debug("fechaFinContrato[" + fechaFinContrato + "]");

			String indEqPrestado = cstmt.getString(26);
			logger.debug("indEqPrestado[" + indEqPrestado + "]");

			Date fechaProrroga = cstmt.getDate(27);
			logger.debug("fechaProrroga[" + fechaProrroga + "]");

			int flgRango = cstmt.getInt(28);
			logger.debug("flgRango[" + flgRango + "]");

			String impCargoBasico = cstmt.getString(29);
			logger.debug("impCargoBasico[" + impCargoBasico + "]");

			String numAnexo = cstmt.getString(30);
			logger.debug("numAnexo[" + numAnexo + "]");

			long codUsuario = cstmt.getLong(31);
			logger.debug("codUsuario[" + codUsuario + "]");

			String codUso = cstmt.getString(32);
			logger.debug("codUso[" + codUso + "]");

			String tipTerminal = cstmt.getString(33);
			logger.debug("tipTerminal[" + tipTerminal + "]");

			String desTerminal = cstmt.getString(34);
			logger.debug("desTerminal[" + desTerminal + "]");

			long numVenta = cstmt.getLong(35);
			logger.debug("numVenta[" + numVenta + "]");

			long codCuenta = cstmt.getLong(36);
			logger.debug("codCuenta[" + codCuenta + "]");

			String codSubCuenta = cstmt.getString(37);
			logger.debug("codSubCuenta[" + codSubCuenta + "]");

			long codVendedor = cstmt.getLong(38);
			logger.debug("codVendedor[" + codVendedor + "]");

			String codCausaVenta = cstmt.getString(39);
			logger.debug("codCausaVenta[" + codCausaVenta + "]");

			Date fechaBaja = cstmt.getDate(40);
			logger.debug("fechaBaja[" + fechaBaja + "]");

			Date fechaBajaCen = cstmt.getDate(41);
			logger.debug("fechaBajaCen[" + fechaBajaCen + "]");

			Date fechaUltMod = cstmt.getDate(42);
			logger.debug("fechaUltMod[" + fechaUltMod + "]");

			long codEmpresa = cstmt.getLong(43);
			logger.debug("codEmpresa[" + codEmpresa + "]");

			Date fecAcepVenta = cstmt.getDate(44);
			logger.debug("fecAcepVenta[" + fecAcepVenta + "]");

			String numContrato = cstmt.getString(45);
			logger.debug("numContrato[" + numContrato + "]");

			int modalidadPago = cstmt.getInt(46);
			logger.debug("modalidadPago[" + modalidadPago + "]");

			String codCargoBasico = cstmt.getString(47);
			logger.debug("codCargoBasico[" + codCargoBasico + "]");

			int codCentral = cstmt.getInt(48);
			logger.debug("codCentral[" + codCentral + "]");

			int codvendealer = cstmt.getInt(49);
			logger.debug("codvendealer[" + codvendealer + "]");

			respuesta = new AbonadoDTO();
			respuesta.setCodCliente(codCliente);
			respuesta.setNumAbonado(numAbonado);
			respuesta.setNumCelular(numCelular);
			respuesta.setNumImei(numSimcard);      // Se cambia ya que el pl esta retornando mal	num_simcard es el imei		
			respuesta.setNumeroSerie(numSerie);    // Se cambia ya que el pl esta retornando mal	num_serie   es el simcard
			respuesta.setCodTecnologia(codTecnologia);
			respuesta.setCodSituacion(codSituacion);
			//respuesta.setDesSituacion(desSituacion);
			respuesta.setTipPlantarif(tipPlanTarif);
			respuesta.setDesTipPlan(desTipPlanTarif);
			respuesta.setCodigoTipoPlan(codPlanTarif);
			//respuesta.setDesPlanTarif(desPlanTarif);
			respuesta.setCodCiclo(codCiclo);
			//respuesta.setLimiteConsumo(codLimConsumo);
			//respuesta.setDesLimiteConsumo(desLimConsumo);
			respuesta.setCodPlanServ(codPlanServ);
			respuesta.setCodigoTipoPlan(codTiplan);
			respuesta.setDesTipPlan(desTiplan);
			respuesta.setCodTipContrato(codTipContrato);
			respuesta.setFecFinContra(String.valueOf(fechaFinContrato));
			respuesta.setFecAlta(String.valueOf(fechaAlta));
			respuesta.setFecProrroga(String.valueOf(fechaProrroga));
			respuesta.setIndEqPrestadoTerminal(indEqPrestado);
			//respuesta.setFlgRango(flgRango);
			//respuesta.setImpCargoBasico(impCargoBasico);
			respuesta.setNumAnexo(numAnexo);
			respuesta.setCodUsuario(codUsuario);
			respuesta.setCodUso(codUso);
			respuesta.setTipTerminal(tipTerminal);
			respuesta.setDesArticuloTerminal(desTerminal);
			respuesta.setNumVenta(numVenta);
			respuesta.setCodCuenta(codCuenta);
			respuesta.setCodSubCuenta(codSubCuenta);
			respuesta.setCodVendedor(codVendedor);
			respuesta.setCodCausaVenta(codCausaVenta);
			respuesta.setFecBaja(String.valueOf(fechaBaja));
			respuesta.setFecBajaCen(String.valueOf(fechaBajaCen));
			respuesta.setFecUltMod(String.valueOf(fechaUltMod));
			respuesta.setCodEmpresa(codEmpresa);
			respuesta.setFecAcepVenta(String.valueOf(fecAcepVenta));
			respuesta.setNumContrato(numContrato);
			respuesta.setCodModVenta(modalidadPago);
			respuesta.setCodCargoBasico(codCargoBasico);
			respuesta.setCodCentral(codCentral);
			respuesta.setCodVendealer(codvendealer);

		} catch (GeneralException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
		}		
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar los datos del abonado", e);
			throw new GeneralException("Ocurrió un error general al recuperar al recuperar los datos del abonado",e);
		}
		finally {
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
		logger.debug("obtenerDatosAbonado():end");
		return respuesta;
	}


	private String getSQLsetUpdateAbonadoNumImei(){
		StringBuffer call=new StringBuffer();
		call.append("DECLARE ");
		call.append("   SO_ABONADO GA_ABONADO_PORTAB_QT := NEW  GA_ABONADO_PORTAB_QT();");
		call.append(" BEGIN ");
		call.append("   SO_ABONADO.NUM_CELULAR := ?;");
		call.append("   SO_ABONADO.NUM_IMEI := ?;");
		call.append("   SO_ABONADO.COD_CLIENTE:= ?;");
		call.append("   SO_ABONADO.COD_CAUSA_VENTA:= ?;");
		call.append("   GA_SERVICIOS_ABONADOS_PG.GA_UPD_TERM_ABO_AMIST_PR ( SO_ABONADO, ?, ?, ? );");
		call.append(" END; ");
		return call.toString();
	}

	public RetornoDTO setUpdateAbonadoNumImei(AbonadoDTO abonadoDTO)throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		RetornoDTO resultado = new RetornoDTO();
		try {
			logger.debug("Inicio:setUpdateAbonadoNumImei");

			String call = getSQLsetUpdateAbonadoNumImei();

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,abonadoDTO.getNumCelular());
			cstmt.setString(2,abonadoDTO.getNumImei());
			cstmt.setLong(3,abonadoDTO.getCodCliente());
			cstmt.setString(4,abonadoDTO.getCodCausaVenta());
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getSQLsetUpdateAbonadoNumImei:execute");
			cstmt.execute();
			logger.debug("Fin:getSQLsetUpdateAbonadoNumImei:execute");

			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al getSQLsetUpdateAbonadoNumImei");
				throw new GeneralException(
						"Ocurrió un error al getSQLsetUpdateAbonadoNumImei", String
						.valueOf(codError), numEvento, msgError);
			}			

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al getSQLsetUpdateAbonadoNumImei",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al getSQLsetUpdateAbonadoNumImei",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getSQLsetUpdateAbonadoNumImei");
		return resultado;
	}


	private String getSQLsetUpdateGaEquiAboser(){
		StringBuffer call= new StringBuffer();
		call.append(" BEGIN " +
				"  GA_SERVICIOS_ABONADOS_PG.GA_UPDATE_EQUIPOABOSER_PR ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,?);"+
		" END;");

		return call.toString();
	}

	/**
	 * Actualiza tabla ga_equipaboser
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */
	public void setUpdateGaEquiAboser(GaEquipAboserDTO gaEquipAboserDTO)
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:actualizaEquipAboSer");

			/*
			 * 
			 *  EN_NUM_ABONADO, 
				 EV_NUM_SERIE, 
				 EN_COD_BODEGA, 
				 EN_TIP_STOCK, 
				 EN_COD_ARTICULO, 
				 EV_TIP_TERMINAL, 
				 EN_COD_USO, 
				 EN_COD_ESTADO, 
				 EN_NUM_MOVIMIENTO, 
				 IND_PROCEQUIP, 
				 DES_EQUIPO
				 SN_COD_RETORNO, 
				 SV_MENS_RETORNO, 
				 SN_NUM_EVENTO
			 * 
			 * 
			 */
			String call =getSQLsetUpdateGaEquiAboser() ;

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,gaEquipAboserDTO.getNumAbonado());
			logger.debug("gaEquipAboserDTO.getNumAbonado() ["+gaEquipAboserDTO.getNumAbonado()+"]" );
			cstmt.setString(2,gaEquipAboserDTO.getNumSerie());
			logger.debug("gaEquipAboserDTO.getNumSerie() ["+gaEquipAboserDTO.getNumSerie()+"]");
			if (gaEquipAboserDTO.getIndProcequi().equals("E")){
				cstmt.setString(3,null);
				logger.debug("gaEquipAboserDTO.getCodBodega() ["+null+"]");
			}else{
				cstmt.setString(3,gaEquipAboserDTO.getCodBodega());
				logger.debug("gaEquipAboserDTO.getCodBodega() ["+gaEquipAboserDTO.getCodBodega()+"]");
			}
			cstmt.setString(4,gaEquipAboserDTO.getTipStock());
			logger.debug("gaEquipAboserDTO.getTipStock() ["+gaEquipAboserDTO.getTipStock()+"]");
			cstmt.setString(5,gaEquipAboserDTO.getCodArticulo());
			logger.debug("gaEquipAboserDTO.getCodArticulo() ["+gaEquipAboserDTO.getCodArticulo()+"]");
			cstmt.setString(6,gaEquipAboserDTO.getTipTerminal());
			logger.debug("gaEquipAboserDTO.getTipTerminal() ["+gaEquipAboserDTO.getTipTerminal()+"]");
			cstmt.setString(7,gaEquipAboserDTO.getCodUso());
			logger.debug("gaEquipAboserDTO.getCodUso() ["+gaEquipAboserDTO.getCodUso()+"]");
			cstmt.setString(8,gaEquipAboserDTO.getCodEstado());
			logger.debug("gaEquipAboserDTO.getCodEstado() ["+gaEquipAboserDTO.getCodEstado()+"]");
			cstmt.setString(9,gaEquipAboserDTO.getNumMovimiento());
			logger.debug("gaEquipAboserDTO.getNumMovimiento() ["+gaEquipAboserDTO.getNumMovimiento()+"]");
			cstmt.setString(10,gaEquipAboserDTO.getIndProcequi());
			logger.debug("gaEquipAboserDTO.getIndProcequi() ["+gaEquipAboserDTO.getIndProcequi()+"]");
			cstmt.setString(11,gaEquipAboserDTO.getDesEquipo());
			logger.debug("gaEquipAboserDTO.getDesEquipo() ["+gaEquipAboserDTO.getDesEquipo()+"]");
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

			logger.debug("Inicio:actualizaEquipAboSer:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaEquipAboSer:execute");

			msgError  = cstmt.getString(13);
			codError  = cstmt.getInt(12);
			numEvento = cstmt.getInt(14);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al actualizar tabla ga_equipaboser");
				throw new GeneralException(
						"Ocurrió un error al actualizar tabla ga_equipaboser", String
						.valueOf(codError), numEvento, msgError);
			}			
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar tabla ga_equipaboser",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:actualizaEquipAboSer");
	}//fin actualizaEquipAboSer

	private String getSQLgetGaEquipAboser(){
		StringBuffer call= new StringBuffer();
		call.append(" BEGIN "+
				"	 GA_SERVICIOS_ABONADOS_PG.GA_GETEQUIPOABOSER_PR ( ?, ?, ?, ?, ? );"+
		" END; ");
		return call.toString();
	}

	public GaEquipAboserDTO[] getGaEquipAboser(GaEquipAboserDTO gaEquipAboserDTO)throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs=null;
		GaEquipAboserDTO[] resultado = null;
		try {
			logger.debug("Inicio:getGaEquipAboser");

			String call = getSQLgetGaEquipAboser();

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,gaEquipAboserDTO.getNumAbonado());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getGaEquipAboser:execute");
			cstmt.execute();
			logger.debug("Fin:getGaEquipAboser:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al getGaEquipAboser");
				throw new GeneralException(
						"Ocurrió un error al getGaEquipAboser", String
						.valueOf(codError), numEvento, msgError);
			}
			else{
				logger.debug("Recuperando abonados");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					GaEquipAboserDTO gaEquipAboser = new GaEquipAboserDTO();
					gaEquipAboser.setCodProducto(rs.getInt(1));
					gaEquipAboser.setFecAlta(rs.getTimestamp(2));
					gaEquipAboser.setIndProcequi(rs.getString(3));
					gaEquipAboser.setIndPropiedad(rs.getString(4));
					gaEquipAboser.setNumSerie(rs.getString(5));
					gaEquipAboser.setTipTerminal(rs.getString(6));
					gaEquipAboser.setCodArticulo(rs.getString(7));

					lista.add(gaEquipAboserDTO);
				}
				resultado =(GaEquipAboserDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), GaEquipAboserDTO.class);
				rs.close();
				logger.debug("Fin recuperacion de abonados");

			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al getGaEquipAboser",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al getGaEquipAboser",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {

				/*if (rs.()){
				rs.close();
			}*/
				cstmt.close();

				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}

			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getGaEquipAboser");
		return resultado;
	}



	private String getSQLSolicitudBajaAbonado(){
		StringBuffer call= new StringBuffer();
		call.append(" BEGIN "+
				"	 ga_baja_abonado_pg.ga_solicita_baja_abonado_pr ( ?,?,?,?,?,?,?,?,?,?,?,?,?,? );"+
		" END; ");
		return call.toString();
	}

	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonado(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, AbonadoDTO abonado)throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();

		try {
			logger.debug("Inicio:solicitaBajaAbonado");

			String call = getSQLSolicitudBajaAbonado();

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,new Long(abonado.getNumAbonado()).longValue());
			cstmt.setString(2,solicitudBajaAbonadoDTO.getCodCausaBaja());
			cstmt.setString(3,solicitudBajaAbonadoDTO.getIdUsuario());
			cstmt.setString(4,solicitudBajaAbonadoDTO.getCodVendedor());
			cstmt.setString(5,solicitudBajaAbonadoDTO.getCodOficina());
			cstmt.setString(6,solicitudBajaAbonadoDTO.getCodTipComis());
			cstmt.setString(7,solicitudBajaAbonadoDTO.getComentario() );
			cstmt.setString(8,solicitudBajaAbonadoDTO.getTieneGarantia());
			cstmt.setString(9,solicitudBajaAbonadoDTO.getFechaVencOoss());
			cstmt.setString(10,solicitudBajaAbonadoDTO.getCodMod());
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

			logger.debug("Inicio:solicitaBajaAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:solicitaBajaAbonado:execute");

			codError=cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento=cstmt.getInt(14);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al getGaEquipAboser");
				throw new GeneralException(
						"Ocurrió un error al Solicitar Baja Abonado", String
						.valueOf(codError), numEvento, msgError);
			}else{
				solicitaBajaAbonadoOut.setNumOOSS(cstmt.getString(11));
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error en solicitaBajaAbonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error en solicitaBajaAbonado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {

				/*if (rs.()){
				rs.close();
			}*/
				cstmt.close();

				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}

			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:solicitaBajaAbonado");
		return solicitaBajaAbonadoOut;
	}



	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoPrepago(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, AbonadoDTO abonado)throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();

		try {
			logger.debug("Inicio:solicitaBajaAbonado");

			String call = getSQLSolicitudBajaAbonado();

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);


			cstmt.setLong(1,new Long(abonado.getNumAbonado()).longValue());
			cstmt.setString(2,solicitudBajaAbonadoDTO.getCodCausaBaja());
			cstmt.setString(3,solicitudBajaAbonadoDTO.getIdUsuario());
			cstmt.setString(4,solicitudBajaAbonadoDTO.getCodVendedor());
			cstmt.setString(5,solicitudBajaAbonadoDTO.getCodOficina());
			cstmt.setString(6,solicitudBajaAbonadoDTO.getCodTipComis());
			cstmt.setString(7,solicitudBajaAbonadoDTO.getComentario());
			cstmt.setString(8,solicitudBajaAbonadoDTO.getTieneGarantia());
			cstmt.setString(9,solicitudBajaAbonadoDTO.getFechaVencOoss());
			cstmt.setString(10,solicitudBajaAbonadoDTO.getCodMod());
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			logger.debug("Inicio:solicitaBajaAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:solicitaBajaAbonado:execute");

			codError=cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento=cstmt.getInt(13);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al getGaEquipAboser");
				throw new GeneralException(
						"Ocurrió un error al Solicitar Baja Abonado", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error en solicitaBajaAbonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error en solicitaBajaAbonado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {

				/*if (rs.()){
				rs.close();
			}*/
				cstmt.close();

				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}

			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:solicitaBajaAbonado");
		return solicitaBajaAbonadoOut;
	}	

	private String getSQLSolicitaReserva(){
		StringBuffer call= new StringBuffer();
		call.append(" BEGIN "+
				"	 AL_RESERVA_DESRESERVA_PG.AL_RESERVA_PR ( ?,?,?,?,?,?,?,?,?,?);"+
		" END; ");
		return call.toString();
	}	

	public ReservaOutDTO solicitaReserva(ReservaDTO solicitaReservaDTO)throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String numMovimiento = null; 
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ReservaOutDTO solicitaReservaOutDTO = new ReservaOutDTO();

		try {
			logger.debug("Inicio:solicitaReserva");

			String call = getSQLSolicitaReserva();

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,new Long(solicitaReservaDTO.getNumeroSolicitud()).longValue());
			cstmt.setString(2,solicitaReservaDTO.getNumeroSerie());
			cstmt.setInt(3,solicitaReservaDTO.getCodArticulo());
			cstmt.setInt(4,solicitaReservaDTO.getCodUso());
			cstmt.setString(5,solicitaReservaDTO.getEstadoReserva());
			cstmt.setLong(6,new Long(solicitaReservaDTO.getCodVendedor()).longValue());
			cstmt.setString(7,solicitaReservaDTO.getNomUsuario());	
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			logger.debug("Inicio:solicitaReserva:execute");
			cstmt.execute();
			logger.debug("Fin:solicitaReserva:execute");

			codError=cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento=cstmt.getInt(10);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al solicitar reserva");
				throw new GeneralException(
						"Ocurrió un error al solicitar reserva", String
						.valueOf(codError), numEvento, msgError);
			}			

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al solicitar reserva",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al solicitar reserva",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {

				/*if (rs.()){
				rs.close();
			}*/
				cstmt.close();

				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}

			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:solicitaReserva");
		return solicitaReservaOutDTO;
	}	


	private String getSQLSolicitaDesreserva(){
		StringBuffer call= new StringBuffer();
		call.append(" BEGIN "+
				"	 AL_RESERVA_DESRESERVA_PG.AL_DESRESERVA_PR ( ?,?,?,?,?,?);"+
		" END; ");
		return call.toString();
	}	

	public ReservaOutDTO solicitaDesreserva(ReservaDTO solicitaReservaDTO)throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String numMovimiento = null; 
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ReservaOutDTO solicitaReservaOutDTO = new ReservaOutDTO();

		try {
			logger.debug("Inicio:solicitaDesreserva");

			String call = getSQLSolicitaDesreserva();

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,new Long(solicitaReservaDTO.getNumeroSolicitud()).longValue());
			logger.debug("solicitaReservaDTO.getNumeroSolicitud() ["+solicitaReservaDTO.getNumeroSolicitud()+"]");
			cstmt.setLong(2,new Long(solicitaReservaDTO.getCodVendedor()).longValue());
			logger.debug("solicitaReservaDTO.getCodVendedor() [" + solicitaReservaDTO.getCodVendedor() +"]");
			cstmt.setString(3,solicitaReservaDTO.getNomUsuario());	
			logger.debug("solicitaReservaDTO.getNomUsuario() [" + solicitaReservaDTO.getNomUsuario() +"]");
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:solicitaDesreserva:execute");
			cstmt.execute();
			logger.debug("Fin:solicitaDesreserva:execute");

			codError=cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento=cstmt.getInt(6);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al solicitar Desreserva");
				throw new GeneralException(
						"Ocurrió un error al solicitar Desreserva", String
						.valueOf(codError), numEvento, msgError);
			}						
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al solicitar Desreserva",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al solicitar Desreserva",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {

				/*if (rs.()){
				rs.close();
			}*/
				cstmt.close();

				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}

			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:solicitaDesreserva");
		return solicitaReservaOutDTO;
	}	


	/**
	 * Actualiza clase servicio para el abonado
	 * @param abonado
	 * @return 
	 * @throws GeneralException
	 */
	public void ActualizaSituacionAbonado(GaVentasDTO gaVentasDTO, String codigoSituacion) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:ActualizaSituacionAbonado");

			//INI-01 (AL) String call = getSQLDatosAbonado("Ve_Servicios_Venta_Pg","ve_updabocelcodsituac_pr",5);
			String call = getSQLDatosAbonado("Ve_Servicios_Venta_Quiosco_Pg","ve_updabocelcodsituac_pr",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,String.valueOf(gaVentasDTO.getNumVenta()));
			cstmt.setString(2,codigoSituacion);

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:ActualizaSituacionAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:ActualizaSituacionAbonado:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al actualizar codigo situacion del abonado");
				throw new GeneralException(
						"Ocurrió un error al actualizar codigo situacion del abonado", String
						.valueOf(codError), numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;			
		}catch (Exception e) {
			logger.error("Ocurrió un error al actualizar codigo situacion del abonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al actualizar codigo situacion del abonado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:ActualizaSituacionAbonado");
	}

	/**
	 * Actualiza clase servicio para el abonado
	 * @param abonado
	 * @return 
	 * @throws GeneralException
	 */
	public void ejecutarRestriccion(RestriccionDTO restriccionDTO) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:ejecutarRestriccionejecutarRestriccion");

			String call = getSQLDatosProcedure("PV_PR_EJECUTA_RESTRICCION",6);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);			

			cstmt.setString(1,restriccionDTO.getSecuencia());
			cstmt.setString(2,restriccionDTO.getModulo());
			cstmt.setString(3,restriccionDTO.getProducto());
			cstmt.setString(4,restriccionDTO.getActuacion());
			cstmt.setString(5,restriccionDTO.getEvento());
			cstmt.setString(6,restriccionDTO.getParam_entrada());			

			logger.debug("Inicio:ActualizaSituacionAbonado:execute");
			cstmt.execute();
			logger.debug("Fin:ActualizaSituacionAbonado:execute");

		}catch (Exception e) {
			logger.error("Ocurrió un error al actualizar codigo situacion del abonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al actualizar codigo situacion del abonado",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:ActualizaSituacionAbonado");
	}	


	/**
	 * Obtiene numero abonados vigentes por cliente
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */	
	public void registraAltaAsincrono(WsCunetaAltaDeLineaOutDTO cunetaAltaDeLineaOut, String id_transaccion) 
	throws GeneralException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		int cantEjecucion;
		try {
			logger.debug("Inicio:registraAltaAsincrono");

			/*
			ve_registra_alta_linea_pr (
				      ev_id_transaccion   IN              ve_cabecera_linea_to.id_transaccion%TYPE,
				      ev_num_venta        IN              ve_cabecera_linea_to.num_venta%TYPE,
				      ev_estado           IN              ve_cabecera_linea_to.estado%TYPE,
				      ev_num_celular      IN              ve_detalle_linea_to.num_celular%TYPE,
				      ev_num_abonado      IN              ve_detalle_linea_to.num_abonado%TYPE,
				      ev_num_serie        IN              ve_detalle_linea_to.num_serie%TYPE,
				      ev_num_imei         IN              ve_detalle_linea_to.num_imei%TYPE,
				      ev_cod_error        IN              ve_error_linea_to.cod_error%TYPE,
				      ev_mensaje_error    IN              ve_error_linea_to.mensaje_error%TYPE,
				      en_num_linea        IN              ve_error_linea_to.num_linea%TYPE,
				      en_nun_proceso      IN              NUMBER,
				      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
				      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
				      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
			 */
			String call = getSQLDatosAbonado("ve_alta_linea_asin_pg","ve_registra_alta_linea_pr",14);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			if (cunetaAltaDeLineaOut.getResultadoTransaccion().equals("0")){
				cantEjecucion = cunetaAltaDeLineaOut.getLineaOut().length;
			}else{
				cantEjecucion = cunetaAltaDeLineaOut.getErrores().length ;
			}

			for (int i=0;i<cantEjecucion;i++){

				cstmt.setString(1, id_transaccion);			

				if (cunetaAltaDeLineaOut.getResultadoTransaccion().equals("0")) {
					cstmt.setString(2, cunetaAltaDeLineaOut.getNumVenta());
					cstmt.setString(3, "OK");
					cstmt.setString(4, cunetaAltaDeLineaOut.getLineaOut()[i].getNumCelular());
					cstmt.setString(5, cunetaAltaDeLineaOut.getLineaOut()[i].getNumAboando());
					cstmt.setString(6, cunetaAltaDeLineaOut.getLineaOut()[i].getNumSerie());
					cstmt.setString(7, cunetaAltaDeLineaOut.getLineaOut()[i].getNumImei());
					cstmt.setString(8, null);
					cstmt.setString(9, null);
					cstmt.setString(10, null);
					cstmt.setInt(11, i);
				}else{
					cstmt.setString(2, "0");
					cstmt.setString(3, "ERROR");
					cstmt.setString(4, null);
					cstmt.setString(5, null);
					cstmt.setString(6, null);
					cstmt.setString(7, null);											
					cstmt.setString(8, cunetaAltaDeLineaOut.getErrores()[i].getCodError());
					cstmt.setString(9, cunetaAltaDeLineaOut.getErrores()[i].getMensajseError());
					cstmt.setString(10, cunetaAltaDeLineaOut.getErrores()[i].getNumLinea());
					cstmt.setInt(11, i);
				}

				cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

				logger.debug("Inicio:registraAltaAsincrono:execute");
				cstmt.execute();
				logger.debug("Fin:registraAltaAsincrono:execute");

				codError=cstmt.getInt(12);
				msgError = cstmt.getString(13);
				numEvento=cstmt.getInt(14);

				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");

				if (codError != 0) {
					logger.error("Ocurrió un error al registrar alta de linea asincrona");
					throw new GeneralException(
							"Ocurrió un error al registrar alta de linea asincrona", String
							.valueOf(codError), numEvento, msgError);
				}


			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al registrar alta de linea asincrona",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al registrar alta de linea asincrona",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtieneAbonadosVigentes");		
	}//fin obtieneAbonadosVigentes	




	/**
	 * Obtiene numero abonados vigentes por cliente
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */	
	public WsCunetaAltaDeLineaOutDTO recuperarAltaAsincrono( String id_transaccion) 
	throws GeneralException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;	
		
		WsCunetaAltaDeLineaOutDTO CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();;
		WsLineaOutDTO             WsLineaOut = null;
		WsLineaOutDTO[]           WsLineaOutArray = null;
		RetornoLineaDTO           RetornoLinea = null;
		RetornoLineaDTO[]         RetornoLineaArray = null;
		
		
		try {
			logger.debug("Inicio:recuperarAltaAsincrono");

			
			
			String call = getSQLDatosAbonado("ve_alta_linea_asin_pg","ve_recupera_alta_linea_pr",11);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, id_transaccion);			
			cstmt.registerOutParameter( 2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter( 3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter( 4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter( 5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter( 6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter( 7, OracleTypes.CURSOR);
			cstmt.registerOutParameter( 8, OracleTypes.CURSOR);							
			cstmt.registerOutParameter( 9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

			logger.debug("Inicio:registraAltaAsincrono:execute");
			cstmt.execute();
			logger.debug("Fin:registraAltaAsincrono:execute");

			codError=cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento=cstmt.getInt(11);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar alta de linea asincrona");
				throw new GeneralException(
						"Ocurrió un error al recuperar alta de linea asincrona", String
						.valueOf(codError), numEvento, msgError);
			}else{	
				
				
				if (cstmt.getString(5).equals("OK")) {					
					ArrayList lista = new ArrayList();
					ResultSet rs = (ResultSet) cstmt.getObject(7);
					while (rs.next()) {
						WsLineaOut = new WsLineaOutDTO();																	
						WsLineaOut.setNumCelular(rs.getString(1));
						WsLineaOut.setNumAboando(rs.getString(2));
						WsLineaOut.setNumSerie(rs.getString(5));
						WsLineaOut.setNumImei(rs.getString(6));																	
						lista.add(WsLineaOut);
					}
					WsLineaOutArray =(WsLineaOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), WsLineaOutDTO.class);
					CunetaAltaDeLineaOut.setNumVenta(cstmt.getString(3));
					CunetaAltaDeLineaOut.setResultadoTransaccion("0");					
					CunetaAltaDeLineaOut.setLineaOut(WsLineaOutArray);
					rs.close();									
				}else{
					
					ArrayList lista2 = new ArrayList();
					ResultSet rs2 = (ResultSet) cstmt.getObject(8);
					while (rs2.next()) {
						RetornoLinea = new RetornoLineaDTO();																		
						RetornoLinea.setCodError(rs2.getString(1));
						RetornoLinea.setMensajseError(rs2.getString(2));															
						lista2.add(WsLineaOut);
					}
					RetornoLineaArray =(RetornoLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista2.toArray(), RetornoLineaDTO.class);
					CunetaAltaDeLineaOut.setResultadoTransaccion("1");
					rs2.close();										
				}	
				
				CunetaAltaDeLineaOut.setErrores(RetornoLineaArray);
				CunetaAltaDeLineaOut.setLineaOut(WsLineaOutArray);
				
			}




		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar alta de linea asincrona",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar alta de linea asincrona",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtieneAbonadosVigentes");		
		return CunetaAltaDeLineaOut;
	}	
	
	
	
	/**
	 * Obtiene numero abonados vigentes por cliente
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */	
	public void regBeneficioPrepago(AbonadoDTO entrada) 
	throws GeneralException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;						
		
		try {
			logger.debug("Inicio:regBeneficioPrepago");

			
			
			//INI-01 (AL) String call = getSQLDatosAbonado("VE_CREA_LINEA_VENTA_PG","VE_REG_BYP_PREPAGO_PR",5);
			String call = getSQLDatosAbonado("VE_CREA_LINEA_VENTA_QUIOSCO_PG","VE_REG_BYP_PREPAGO_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, entrada.getNumAbonado());
			logger.debug("entrada.getNumAbonado() ["+entrada.getNumAbonado()+"]");
			cstmt.setString(2, entrada.getIndProcEqTerminal());						
			logger.debug("entrada.getIndProcEqTerminal() ["+entrada.getIndProcEqTerminal()+"]");
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:regBeneficioPrepago:execute");
			cstmt.execute();
			logger.debug("Fin:regBeneficioPrepago:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al registrar beneficio Abonado prepago");
				throw new GeneralException(
						"Ocurrió un error al registrar beneficio Abonado prepago", String
						.valueOf(codError), numEvento, msgError);
			}


		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al registrar beneficio Abonado prepago",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al registrar beneficio Abonado prepago",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:regBeneficioPrepago");				
	}		
	
	
	/**
	 * Obtiene numero abonados vigentes por cliente
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */	
	public WsBeneficioPromocionOutDTO[] recCampanaBeneficio(WsBeneficioPromocionInDTO beneficioPromocion) 
	throws GeneralException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;						
		
		WsBeneficioPromocionOutDTO[] retorno = null;
		WsBeneficioPromocionOutDTO   beneficioPromocionOut = null;    
		
		try {
			logger.debug("Inicio:recCampanaBeneficio");

			
			
			//INI-01 (AL) String call = getSQLDatosAbonado("BP_PROMOCIONES_PG","BP_OBTENER_BENEFICIOS_PR",6);
			String call = getSQLDatosAbonado("BP_PROMOCIONES_QUIOSCO_PG","BP_OBTENER_BENEFICIOS_PR",6);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			
			cstmt.setString(1, beneficioPromocion.getClienteAboando());
			cstmt.setString(2, beneficioPromocion.getCodigoTipoPlan());						
			cstmt.registerOutParameter(3, OracleTypes.CURSOR );
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:recCampanaBeneficio:execute");
			cstmt.execute();
			logger.debug("Fin:recCampanaBeneficio:execute");

			codError=cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento=cstmt.getInt(6);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al registrar beneficio Abonado prepago");
				throw new GeneralException(
						"Ocurrió un error al registrar beneficio Abonado prepago", String
						.valueOf(codError), numEvento, msgError);
			}else{
				
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {	
					beneficioPromocionOut = new WsBeneficioPromocionOutDTO();					
					beneficioPromocionOut.setCodigoCampana(rs.getString(1));
					logger.debug("setCodigoCampana [" + rs.getString(1) + "]");					
					beneficioPromocionOut.setDdescripcionCampana(rs.getString(2));
					logger.debug("setDdescripcionCampana [" + rs.getString(2) + "]");
					beneficioPromocionOut.setCodigoTiplan(rs.getString(3));
					logger.debug("setCodigoTiplan [" + rs.getString(3) + "]");
					beneficioPromocionOut.setIndicadorDefault(rs.getString(4));										
					logger.debug("setIndicadorDefault [" + rs.getString(4) + "]");		
					
					lista.add(beneficioPromocionOut);
				}				
				retorno =(WsBeneficioPromocionOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), WsBeneficioPromocionOutDTO.class);						
			}


		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al registrar beneficio Abonado prepago",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al registrar beneficio Abonado prepago",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:recCampanaBeneficio");
		return retorno;				
	}
		
	public void registraCampanaBeneficio(WsRegistraCampanaByPInDTO registraCampanaByPIn) 
	throws GeneralException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;											
		try {
			logger.debug("Inicio:recCampanaBeneficio");

			
			
			//INI-01 (AL) String call = getSQLDatosAbonado("BP_PROMOCIONES_PG","BP_REGISTRA_CAMPANA_PR",4);
			String call = getSQLDatosAbonado("BP_PROMOCIONES_QUIOSCO_PG","BP_REGISTRA_CAMPANA_PR",4);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			
			cstmt.setString(1, registraCampanaByPIn.getCodigoCampana());
			cstmt.setString(2, registraCampanaByPIn.getCodigoCliente());						
			cstmt.setString(2, registraCampanaByPIn.getNumeroAbonado());
			cstmt.setString(2, registraCampanaByPIn.getIndicadorAsignacion());
			

			logger.debug("Inicio:recCampanaBeneficio:execute");
			cstmt.execute();
			logger.debug("Fin:recCampanaBeneficio:execute");


		} catch (SQLException e) {
			
			logger.debug("getErrorCode [" + e.getErrorCode() + "]");
			logger.debug("getCause     [" + e.getCause() + "]");
			logger.debug("getMessage   [" + e.getMessage() + "]");
			throw new GeneralException("Ocurrió un error al registrar beneficio Abonado prepago",e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al registrar beneficio Abonado prepago",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al registrar beneficio Abonado prepago",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:recCampanaBeneficio");			
	}				

//	Inicio Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
	/**
	 * Reversa venta
	 * @param venta
	 * @return 
	 * @throws GeneralException
	 */
	public void cancelaVenta(GaVentasDTO gaVentasDTO) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:cancelaVenta");

			//INI-01 (AL) String call = getSQLDatosAbonado("Ve_Servicios_Venta_Pg","ve_reversaventas_pr",8);
			String call = getSQLDatosAbonado("Ve_Servicios_Venta_Quiosco_Pg","ve_reversaventas_pr",8);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

		    cstmt.setString(1,String.valueOf(gaVentasDTO.getNumVenta()));
		    logger.debug("Inicio:NumVenta:execute" + gaVentasDTO.getNumVenta());
		    cstmt.setString(2,String.valueOf(gaVentasDTO.getCodVendedor()));
		    logger.debug("Inicio:CodVendedor:execute" + gaVentasDTO.getCodVendedor());
		    cstmt.setString(3,String.valueOf(gaVentasDTO.getCodigoUsuario()));
		    logger.debug("Inicio:CodUsuario:execute" + gaVentasDTO.getCodigoUsuario());
		    cstmt.setString(4,String.valueOf("0"));
		    logger.debug("Inicio:CodProcFact:execute:0");
		    cstmt.setString(5,String.valueOf(gaVentasDTO.getNumTransaccion()));
		    logger.debug("Inicio:NumTransaccion:execute" + gaVentasDTO.getNumTransaccion());
		    
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.debug("Inicio:cancelaVenta:execute");
			cstmt.execute();
			logger.debug("Fin:cancelaVenta:execute");

			codError=cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento=cstmt.getInt(8);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al reversar la venta");
				throw new GeneralException(
						"Ocurrió un error al reversar la venta", String
						.valueOf(codError), numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;			
		}catch (Exception e) {
			logger.error("Ocurrió un error al reversar la venta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al reversar la venta",e);
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:cancelaVenta");
	}	
//	Fin Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
	
}//fin AbonadoDAO
