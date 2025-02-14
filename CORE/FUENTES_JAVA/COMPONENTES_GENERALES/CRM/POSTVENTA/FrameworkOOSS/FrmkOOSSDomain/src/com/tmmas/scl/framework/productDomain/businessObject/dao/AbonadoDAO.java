/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 01/06/2007	     	Elizabeth Vera        				Versión Inicial
 * 26/07/2007           Raúl Lozano                       ObtenerListaAbonados(fec_AcepVenta,cod_uso)
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.AbonadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ConsultaHibridoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GaAbocelDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ObtencionRolUsuarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ValidaPermanenciaDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class AbonadoDAO extends ConnectionDAO implements AbonadoDAOIT {

	private final Logger logger = Logger.getLogger(AbonadoDAO.class);

	private final Global global = Global.getInstance();
	
	
	
	private String getSQLobtenerListaAbonados() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.COD_CLIENTE := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_OBTIENE_LISTA_ABONADOS_PR( eo_abonado, ?, ?, ?, ?);");
		call.append(" END;");
		
		return call.toString();		
	}	

	private String getSQLobtenerDatosAbonado() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   so_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_abonado.NUM_ABONADO := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR( so_abonado, ?, ?, ?);");
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
		
		call.append(" END;");
	
		return call.toString();		
	}
	
	private String getSQLactualizaIntarcelAcciones() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");		
		call.append("   eo_intarcel PV_GA_INTARCEL_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GA_INTARCEL_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_intarcel.NUM_ABONADO := ?;");
		call.append("   eo_intarcel.COD_CLIENTE := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_ACTUALIZA_INTARCEL_ACC_PR( eo_intarcel, ?, ?, ?);");
		call.append(" END;");		
 			   
		return call.toString();		
	}	
	  
	private String getSQLregistraElimActIntarcel() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");		
		call.append("   eo_intarcel PV_GA_INTARCEL_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GA_INTARCEL_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_intarcel.NUM_ABONADO := ?;");
		call.append("   eo_intarcel.COD_CLIENTE := ?;");
		call.append("   eo_intarcel.FEC_DESDE := ?;");
		call.append("   eo_intarcel.COD_PRODUCTO := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_REG_ELIM_INTARCEL_PR( eo_intarcel, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
	
	private String getSQLactualizaSituaAbo() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");		
		call.append("   eo_abonado GA_ABOAMIST_QT := PV_INICIA_ESTRUCTURAS_PG.GA_ABOAMIST_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.NUM_ABONADO := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_ACTUALIZA_SITUA_ABONADO_PR( eo_abonado, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
	
	private String getSQLeliminaCuentaPersonal() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_cuenta PV_NUMCEL_PERS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_NUMCEL_PERS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cuenta.NUM_CELULAR_PERS := ?;");
		call.append("   eo_cuenta.NUM_CELULAR_CORP := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_ELIMINA_CUENTA_PERSONAL_PR( eo_cuenta, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLreservaAmist() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_celular PV_NUMCEL_PERS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_NUMCEL_PERS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_celular.NUM_CELULAR_PERS := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_RESERVA_AMIST_PR( eo_celular, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLvalidaPermanencia() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_permanencia PV_VALIDA_PERM_QT := PV_INICIA_ESTRUCTURAS_PG.PV_VALIDA_PERM_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_permanencia.NUM_ABONADO := ?;");
		call.append("   eo_permanencia.TIEMPO_MIN := ?;");
		call.append("   eo_permanencia.COD_CAUSA_BAJA := ?;");
		call.append("   eo_permanencia.COD_CAUSA_BAJA_PARAM:= ?;");
		call.append("   	? := PV_DATOS_ABONADO_PG.PV_VALIDA_PERMANENCIA_FN( eo_permanencia, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLobtenerAbonadosPorVenta() {
		StringBuffer call = new StringBuffer();		
		call.append("DECLARE ");
		call.append(" EO_VENTA_ABONADO GA_VENTA_QT; ");
		call.append(" SO_LISTA_ABONADO PV_DATOS_ABONADO_PG.refCursor; ");
		call.append(" SN_COD_RETORNO NUMBER; ");
		call.append(" SV_MENS_RETORNO VARCHAR2(200); ");
		call.append(" SN_NUM_EVENTO NUMBER; ");
		call.append("BEGIN   ");		
		call.append(" EO_VENTA_ABONADO := ?; ");		
		call.append(" PV_DATOS_ABONADO_PG.PR_VENTA_S_PR(EO_VENTA_ABONADO,?,?,?,?); ");		
		call.append("END; ");
		return call.toString();		
	}
	
	private String getSQLconsultaHibrido() {
		StringBuffer call = new StringBuffer();	
		call.append(" DECLARE ");
		call.append("   eo_consulta PV_PLANES_TARIFARIOS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_PLANES_TARIFARIOS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_consulta.COD_CLIENTE := ?;");
		call.append("   eo_consulta.COD_PLANTARIF := ?;");
		call.append("   eo_consulta.TIP_PLANTARIF  := ?;");
		call.append("   eo_consulta.COD_TIPLAN   := ?;");
		call.append("   eo_consulta.COD_TECNOLOGIA  := ?;");
		call.append("   eo_consulta.NUM_ABONADO := ?;");
		call.append("   eo_consulta.NOM_USUARORA   := ?;");
		call.append("   eo_consulta.EN_CAMBIO_PLANFAMILIAR   := ?;");
		call.append("   eo_consulta.COD_PLANTARIF_NUEVO   := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_CONSULTA_HIBRIDO_PR( eo_consulta, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
	
	private String getSQLactualizarAboCtaSeg() {
		StringBuffer call = new StringBuffer();	
		call.append(" DECLARE ");
		call.append("   eo_abonado PV_GA_ABOCEL_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GA_ABOCEL_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.COD_PLANTARIF := ?;");
		call.append("   eo_abonado.COD_PRODUCTO := ?;");
		call.append("   eo_abonado.COD_TECNOLOGIA := ?;");
		call.append("   eo_abonado.NUM_ABONADO := ?;");
		call.append("   eo_abonado.COD_USO := ?;");
		call.append("   eo_abonado.NUM_DIA := ?;");
		call.append("   eo_abonado.COD_CARGOBASICO := ?;");
		call.append("   	? := PV_DATOS_ABONADO_PG.PV_ACT_ABO_CTASEG_FN( eo_abonado, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLmigrarAbonado() {
		StringBuffer call = new StringBuffer();	
		call.append(" DECLARE ");
		call.append("   eo_abonado PV_GA_ABOCEL_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GA_ABOCEL_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.NUM_ABONADO := ?;");
		call.append("   eo_abonado.ID_SECUENCIA := ?;");
		call.append("   eo_abonado.COD_CICLO := ?;");
		call.append("   eo_abonado.COD_PLANTARIF := ?;");
		call.append("   eo_abonado.COD_CLIENTE := ?;");
		call.append("   eo_abonado.TIP_PLANTARIF := ?;");
		call.append("   eo_abonado.COD_LIMCONSUMO := ?;");
		call.append("   eo_abonado.COD_CARGOBASICO := ?;");
		call.append("   eo_abonado.FEC_ALTA := ?;");
		call.append("   eo_abonado.NUM_CONTRATO := ?;");
		call.append("   eo_abonado.COD_TIPCONTRATO := ?;");
		call.append("   eo_abonado.NUM_VENTA := ?;");
		call.append("   eo_abonado.NUM_ANEXO := ?;");
		call.append("   eo_abonado.COD_CAUSA_VENTA := ?;");
		call.append("   eo_abonado.FEC_FINCONTRA := ?;");
		call.append("   eo_abonado.FEC_BAJA := ?;");
		call.append("   eo_abonado.FEC_BAJACEN := ?;");
		call.append("   eo_abonado.COD_SITUACION := ?;");
		call.append("   eo_abonado.COD_CUENTA := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_MIGRAR_ABONADO_PR( eo_abonado, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLobtenerFecCumPlan() {
		StringBuffer call = new StringBuffer();	
		call.append(" DECLARE ");
		call.append("   so_abonado PV_GA_ABOCEL_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GA_ABOCEL_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_abonado.COD_CLIENTE := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_OBTENER_FEC_CUMPLAN_PR( so_abonado, ?, ?, ?);");
		call.append("   			? := so_abonado.FEC_CUMPLAN;");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLactualizarSituPerfil() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.COD_ACTABO := ?;");
		call.append("   eo_abonado.COD_TECNOLOGIA := ?;");
		call.append("   eo_abonado.CLASE_SERVICIO := ?;");
		call.append("   eo_abonado.NUM_ABONADO := ?;");
		call.append("   eo_abonado.COD_CLIENTE := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_ACTUALIZA_SITUPERFIL_PR( eo_abonado, ?, ?, ?);");
		call.append(" END;");
		
		return call.toString();		
	}	
	
	private String getSQLobtenerNumeroMovimientoAlta()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE "); 
		call.append("   EO_ABONADO GA_Abonado_QT; ");
		call.append("   SO_MOVIMIENTOS PV_DATOS_ABONADO_PG.refcursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN   ");
		call.append("   PV_DATOS_ABONADO_PG.PV_OBTENER_MOVIMIENTO_PR(?,?,?,?,?); ");  
		call.append(" END; ");
		return call.toString();
	}

	private String getSQLobtenerFecDesdeCtaSeg() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");		
		call.append("   so_intarcel PV_GA_INTARCEL_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GA_INTARCEL_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_intarcel.NUM_ABONADO := ?;");
		call.append("   so_intarcel.COD_CLIENTE := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_FEC_DESDELLAM_INTARCEL_PR( so_intarcel, ?, ?, ?);");
		call.append("   			? := so_intarcel.FEC_DESDE;");			
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLObtenerRolUsuario() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append(" eo_abocel PV_GA_ABOCEL_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GA_ABOCEL_QT_FN;");
		call.append(" rolUsuario NUMBER(3); ");
		call.append(" BEGIN ");
		call.append("   eo_abocel.NOM_USUARORA := ?;");
		call.append("   PV_DATOS_ABONADOS_PG.PV_OBTIENE_ROLUSUARIO_FN( eo_abocel, ?, ?, ?);");
		call.append("		? := rolUsuario;");
		call.append(" END;");		
		return call.toString();		
	}
	
	
	/**
	 * Obtiene el Rol del usuario
	 * 
	 * @param intarcel
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public ObtencionRolUsuarioDTO obtenerRolUsuario(ObtencionRolUsuarioDTO obtRol) throws ProductException{
		logger.debug("obtenerRolUsuario():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLObtenerRolUsuario();
		try {
		
			logger.debug("obtRol.getNomUsuarOra()[" + obtRol.getNomUsuarOra() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, obtRol.getNomUsuarOra());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
		
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
			logger.debug("execute:antes");
			
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener el Rol del Usuario");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			obtRol.setRol(cstmt.getInt(5));
			logger.debug("obtRol.getRol()" + obtRol.getRol());
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener el Rol del Usuario", e);
			throw new ProductException("Ocurrió un error general al obtener el Rol del Usuario",e);
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
		logger.debug("obtenerRolUsuario():end");
		return obtRol;		
	}
	
	
	
	/**
	 * Obtiene la lista de abonados del cliente
	 * 
	 * @param cliente
	 * @return AbonadoListDTO
	 * @throws ProductException
	 */
	
	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente)
			throws ProductException {
		
		logger.debug("obtenerListaAbonados():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoListDTO abonadosList = null;
		AbonadoDTO[] abonados = null;
		ParametrosObtencionCargosDTO cargos = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerListaAbonados();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, cliente.getCodCliente());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);			
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
				logger.error(" Ocurrió un error al obtener lista de abonados");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				AbonadoDTO abonado = new AbonadoDTO();
			
				abonado.setCodCliente(rs.getLong(1));
				logger.debug("codCliente[" + abonado.getCodCliente() + "]");
				abonado.setNumAbonado(rs.getLong(2));
				logger.debug("NumAbonado[" + abonado.getNumAbonado() + "]");
				abonado.setNumCelular(rs.getLong(3));
				logger.debug("NumCelular[" + abonado.getNumCelular() + "]");
				abonado.setNumSerie(rs.getString(4));
				logger.debug("NumSerie[" + abonado.getNumSerie() + "]");
				abonado.setNumImei(rs.getString(5));
				logger.debug("NumImei[" + abonado.getNumImei() + "]");
				abonado.setCodTecnologia(rs.getString(6));
				logger.debug("CodTecnologia[" + abonado.getCodTecnologia() + "]");
				abonado.setCodSituacion(rs.getString(7));
				logger.debug("CodSituacion[" + abonado.getCodSituacion() + "]");
				abonado.setDesSituacion(rs.getString(8));
				logger.debug("DesSituacion[" + abonado.getDesSituacion() + "]");
				abonado.setCodTipoPlanTarif(rs.getString(9));
				logger.debug("CodTipoPlanTarif[" + abonado.getCodTipoPlanTarif() + "]");
				abonado.setDesTipoPlanTarif(rs.getString(10));
				logger.debug("DesTipoPlanTarif[" + abonado.getDesTipoPlanTarif() + "]");
				abonado.setCodPlanTarif(rs.getString(11));
				logger.debug("CodPlanTarif[" + abonado.getCodPlanTarif() + "]");
				abonado.setDesPlanTarif(rs.getString(12));
				logger.debug("DesPlanTarif[" + abonado.getDesPlanTarif() + "]");
				abonado.setCodCiclo(rs.getInt(13));
				logger.debug("CodCiclo[" + abonado.getCodCiclo() + "]");
				abonado.setLimiteConsumo(rs.getString(14));
				logger.debug("LimiteConsumo[" + abonado.getLimiteConsumo() + "]");
				abonado.setDesLimiteConsumo(rs.getString(15));
				logger.debug("DesLimiteConsumo[" + abonado.getDesLimiteConsumo() + "]");
				abonado.setCodTipPlan(rs.getString(16));
				logger.debug("CodTipPlan[" + abonado.getCodTipPlan() + "]");
				abonado.setDesTipPlan(rs.getString(17));
				logger.debug("DesTipPlan[" + abonado.getDesTipPlan() + "]");
				abonado.setCodCargoBasico(rs.getString(18));
				logger.debug("CodCargoBasico[" + abonado.getCodCargoBasico() + "]");
				abonado.setCodTipContrato(rs.getString(19));
				logger.debug("CodTipContrato[" + abonado.getCodTipContrato() + "]");
				abonado.setCodModVenta(rs.getString(20));
				logger.debug("CodModVenta[" + abonado.getCodModVenta() + "]");
				abonado.setNroContrato(rs.getString(21));
				logger.debug("NroContrato[" + abonado.getNroContrato() + "]");
				abonado.setCodPlanServ(rs.getString(22));
				logger.debug("CodPlanServ[" + abonado.getCodPlanServ() + "]");
				abonado.setCodCentral(rs.getInt(23));
				logger.debug("CodCentral[" + abonado.getCodCentral() + "]");
				abonado.setNumVenta(rs.getInt(24));
				logger.debug("NumVenta[" + abonado.getNumVenta() + "]");
				abonado.setCodUso(rs.getString(25));
				logger.debug("CodUso[" + abonado.getCodUso() + "]");
				abonado.setFecAcepVenta(rs.getDate(26));
				logger.debug("FecAcepVenta[" + abonado.getFecAcepVenta() + "]");
				abonado.setFecAlta(rs.getDate(27));
				logger.debug("FecAlta[" + abonado.getFecAlta() + "]");				
				abonado.setFecProrroga(rs.getDate(28));
				logger.debug("FecProrroga[" + abonado.getFecProrroga() + "]");
				abonado.setNumAnexo(rs.getString(29));
				logger.debug("NumAnexo[" + abonado.getNumAnexo() + "]");
				abonado.setCodUsuario(rs.getLong(30));
				logger.debug("CodUsuario[" + abonado.getCodUsuario() + "]");
				abonado.setCodTipoTerminal(rs.getString(31));
				logger.debug("CodTipoTerminal[" + abonado.getCodTipoTerminal() + "]");
				abonado.setNumVenta(rs.getLong(32));
				logger.debug("NumVenta[" + abonado.getNumVenta() + "]");
				abonado.setImpCargoBasico(rs.getString(33));
				logger.debug("ImpCargoBasico[" + abonado.getImpCargoBasico() + "]");
				abonado.setCodCuenta(rs.getLong(34));
				logger.debug("CodCuenta[" + abonado.getCodCuenta() + "]");
				abonado.setCodSubCuenta(rs.getString(35));
				logger.debug("CodSubCuenta[" + abonado.getCodSubCuenta() + "]");
				abonado.setCodVendedor(rs.getLong(36));
				logger.debug("CodVendedor[" + abonado.getCodVendedor() + "]");
				abonado.setCodCausaVenta(rs.getString(37));
				logger.debug("CodCausaVenta[" + abonado.getCodCausaVenta() + "]");
				abonado.setFecBaja(rs.getDate(38));
				logger.debug("FecBaja[" + abonado.getFecBaja() + "]");
				abonado.setFecBajaCen(rs.getDate(39));
				logger.debug("FecBajaCen[" + abonado.getFecBajaCen() + "]");
				abonado.setFecUltModificacion(rs.getDate(40));
				logger.debug("FecUltModificacion[" + abonado.getFecUltModificacion() + "]");
				abonado.setCodEmpresa(rs.getString(41));
				logger.debug("CodEmpresa[" + abonado.getCodEmpresa() + "]");
				abonado.setFecFinContrato(rs.getDate(42));
				logger.debug("FecFinContrato[" + abonado.getFecFinContrato() + "]");
				abonado.setIndEqPrestado(rs.getString(43));
				logger.debug("IndEqPrestado[" + abonado.getIndEqPrestado() + "]");
				abonado.setFlgRango(rs.getInt(44));
				logger.debug("FlgRango[" + abonado.getFlgRango() + "]");
				
				lista.add(abonado);
			}
			abonados = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), AbonadoDTO.class);
			abonadosList = new AbonadoListDTO();
			abonadosList.setAbonados(abonados);			
			rs.close();
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de abonados", e);
			throw new ProductException("Ocurrió un error general al obtener lista de abonados",e);
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
		logger.debug("obtenerListaAbonados():end");
		return abonadosList;

	}
	
	/**
	 * Recupera la informacion del abonado
	 * 
	 * @param abonado
	 * @return AbonadoDTO
	 * @throws ProductException
	 */
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado)
	throws ProductException {

		logger.debug("obtenerDatosAbonado():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerDatosAbonado();
		try {
		
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);			
			
			cstmt.setLong(1, abonado.getNumAbonado());
			
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
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
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
			
			respuesta = new AbonadoDTO();
			respuesta.setCodCliente(codCliente);
			respuesta.setNumAbonado(numAbonado);
			respuesta.setNumCelular(numCelular);
			respuesta.setNumSerie(numSerie);
			respuesta.setSimCard(numSimcard);
			respuesta.setCodTecnologia(codTecnologia);
			respuesta.setCodSituacion(codSituacion);
			respuesta.setDesSituacion(desSituacion);
			respuesta.setCodTipoPlanTarif(tipPlanTarif);
			respuesta.setDesTipoPlanTarif(desTipPlanTarif);
			respuesta.setCodPlanTarif(codPlanTarif);
			respuesta.setDesPlanTarif(desPlanTarif);
			respuesta.setCodCiclo(codCiclo);
			respuesta.setLimiteConsumo(codLimConsumo);
			respuesta.setDesLimiteConsumo(desLimConsumo);
			respuesta.setCodPlanServ(codPlanServ);
			respuesta.setCodTipPlan(codTiplan);
			respuesta.setDesTipPlan(desTiplan);
			respuesta.setCodTipContrato(codTipContrato);
			respuesta.setFecFinContrato(fechaFinContrato);
			respuesta.setFecAlta(fechaAlta);
			respuesta.setFecProrroga(fechaProrroga);
			respuesta.setIndEqPrestado(indEqPrestado);
			respuesta.setFlgRango(flgRango);
			respuesta.setImpCargoBasico(impCargoBasico);
			respuesta.setNumAnexo(numAnexo);
			respuesta.setCodUsuario(codUsuario);
			respuesta.setCodUso(codUso);
			respuesta.setCodTipoTerminal(tipTerminal);
			respuesta.setDesTipoTerminal(desTerminal);
			respuesta.setNumVenta(numVenta);
			respuesta.setCodCuenta(codCuenta);
			respuesta.setCodSubCuenta(codSubCuenta);
			respuesta.setCodVendedor(codVendedor);
			respuesta.setCodCausaVenta(codCausaVenta);
			respuesta.setFecBaja(fechaBaja);
			respuesta.setFecBajaCen(fechaBajaCen);
			respuesta.setFecUltModificacion(fechaUltMod);
			respuesta.setCodEmpresa(String.valueOf(codEmpresa));
			respuesta.setFecAcepVenta(fecAcepVenta);
			respuesta.setNumContrato(numContrato);
			respuesta.setCodModVenta(String.valueOf(modalidadPago));
			respuesta.setCodCargoBasico(codCargoBasico);
			respuesta.setCodCentral(codCentral);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar los datos del abonado", e);
			throw new ProductException("Ocurrió un error general al recuperar al recuperar los datos del abonado",e);
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
	/**
	 * Registro de intarcel
	 * 
	 * @param intarcel
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO actualizaIntarcelAcciones(IntarcelDTO intarcel) throws ProductException{
		logger.debug("actualizaIntarcelAcciones():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizaIntarcelAcciones();
		try {
		
			logger.debug("intarcel.getNumAbonado()[" + intarcel.getNumAbonado() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, intarcel.getNumAbonado());
			cstmt.setLong(2, intarcel.getCodCliente());
			
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
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error en el registro de intarcel");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general en el registro de intarcel", e);
			throw new ProductException("Ocurrió un error general en el registro de intarcel",e);
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
		logger.debug("actualizaIntarcelAcciones():end");
		return retorno;		
	}
	
	/**
	 * Elimina y actualiza de ga_intarcel
	 * 
	 * @param intarcel
	 * @return RetornoDTO
	 * @throws ProductException
	 */		
	public RetornoDTO registraElimActIntarcel(IntarcelDTO intarcel) throws ProductException{
		logger.debug("registraElimActIntarcel():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistraElimActIntarcel();
		try {
			logger.debug("intarcel.getNumAbonado()()[" + intarcel.getNumAbonado() + "]");
			logger.debug("intarcel.getCodCliente()()[" + intarcel.getCodCliente() + "]");
			logger.debug("intarcel.getFecDesde()()[" + intarcel.getFecDesde() + "]");
			logger.debug("intarcel.getCodProducto()()[" + intarcel.getCodProducto() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			java.sql.Date fecDesde = null;
			if (intarcel.getFecDesde()!=null)
				fecDesde =  new java.sql.Date(intarcel.getFecDesde().getTime());
			
			cstmt.setLong(1, intarcel.getNumAbonado()); //NUM_ABONADO
			cstmt.setLong(2, intarcel.getCodCliente()); //COD_CLIENTE
			cstmt.setDate(3, fecDesde); //FEC_DESDE
			cstmt.setLong(4, intarcel.getCodProducto()); //COD_PRODUCTO
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error en la actualización de intarcel");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");

			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general en la actualización de intarcel", e);
			throw new ProductException("Ocurrió un error general en la actualización de intarcel",e);
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
		logger.debug("registraElimActIntarcel():end");
		return retorno;			
	}	
	
	/**
	 * Actualiza la situación del abonado
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ProductException
	 */		
	public RetornoDTO actualizaSituaAbo(AbonadoDTO abonado) throws ProductException{

		logger.debug("actualizaSituaAbo():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizaSituaAbo();
		try {
		
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, abonado.getNumAbonado());
			
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
			
			if (codError != 0) {
				logger.error(" Ocurrió un error en la actualización de la situación del abonado");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");

			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general en la actualización de la situación del abonado", e);
			throw new ProductException("Ocurrió un error general en la actualización de la situación del abonado",e);
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
		logger.debug("actualizaSituaAbo():end");
		return retorno;			
	}
	
	/**
	 * Elimina de cuenta personal
	 * 
	 * @param cuenta
	 * @return RetornoDTO
	 * @throws ProductException
	 */		
	public RetornoDTO eliminaCuentaPersonal(CuentaPersonalDTO cuenta) throws ProductException{

		logger.debug("eliminaCuentaPersonal():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLeliminaCuentaPersonal();
		try {
		
			logger.debug("cuenta.getNumCelular()[" + cuenta.getNumCelular() + "]");
			logger.debug("cuenta.getNumCelularCorp()[" + cuenta.getNumCelularCorp() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, cuenta.getNumCelular());
			cstmt.setLong(2, cuenta.getNumCelularCorp());
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
				logger.error(" Ocurrió un error al eliminar de cuenta personal");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar de cuenta personal", e);
			throw new ProductException("Ocurrió un error general al eliminar de cuenta personal",e);
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
		logger.debug("eliminaCuentaPersonal():end");
		return retorno;			
		
	}
	
	/**
	 * Elimina el registro de la tabla re_servamist
	 * 
	 * @param cuenta
	 * @return RetornoDTO
	 * @throws ProductException
	 */		
	public RetornoDTO reservaAmist(CuentaPersonalDTO cuenta) throws ProductException{

		logger.debug("reservaAmist():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLreservaAmist();
		try {
		
			logger.debug("cuenta.getNumCelular()[" + cuenta.getNumCelular() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, cuenta.getNumCelular()); //NUM_CELULAR_PERS
			
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
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al eliminar el registro de re_servamist");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar el registro de re_servamist", e);
			throw new ProductException("Ocurrió un error general al eliminar el registro de re_servamist",e);
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
		logger.debug("reservaAmist():end");
		return retorno;
	}
	
	/**
	 * Valida permanencia para optar a un prepago
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws ProductException
	 */		
	public RetornoDTO validaPermanencia(ValidaPermanenciaDTO param) throws ProductException{

		logger.debug("validaPermanencia():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidaPermanencia();
		try {
			
			logger.debug("param.getNumAbonado()[" + param.getNumAbonado() + "]");
			logger.debug("param.getTiempoMin()[" + param.getTiempoMin()+ "]");
			logger.debug("param.getCodCausaBaja()[" + param.getCodCausaBaja() + "]");
			logger.debug("param.getCodCausaBajaParam()[" + param.getCodCausaBajaParam() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, param.getNumAbonado());
			cstmt.setInt(2, param.getTiempoMin());
			cstmt.setString(3, param.getCodCausaBaja());
			cstmt.setString(4, param.getCodCausaBajaParam());
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(6);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al validar permanencia");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String res = cstmt.getString(5);
			logger.debug("res[" + res + "]");
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			retorno.setResultado(res.equalsIgnoreCase("TRUE")?true:false);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al validar permanencia", e);
			throw new ProductException("Ocurrió un error general al validar permanencia",e);
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
		logger.debug("validaPermanencia():end");
		return retorno;
	}

	public AbonadoListDTO obtenerAbonadosPorVenta(VentaDTO venta) throws ProductException 
	{

		logger.debug("obtenerAbonadosPorVenta():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoListDTO retorno = null;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerAbonadosPorVenta();
		try {
		
			logger.debug("venta.getIdVenta()[" + venta.getIdVenta() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			logger.debug("lin 1");
			
			cstmt =  (OracleCallableStatement) conn.prepareCall(call);
			logger.debug("lin 2");
			StructDescriptor sd = StructDescriptor.createDescriptor("GA_VENTA_QT", conn);
			logger.debug("lin 3");
			STRUCT oracleObject = new STRUCT(sd, conn, venta.toStruct_GA_VENTA_QT());
			logger.debug("lin 4");
			cstmt.setObject(1, oracleObject);
			logger.debug("lin 5");
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);
			logger.debug("lin 6");
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			logger.debug("lin 7");
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			logger.debug("lin 8");
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("lin 9");
		
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
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error en el registro de intarcel");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			retorno = new AbonadoListDTO();
			AbonadoDTO[] abonadosList=null;
			AbonadoDTO abo=null;
			ArrayList listaAbonados=new ArrayList();
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			
			while(rs.next())
			{
				abo=new AbonadoDTO();				
				abo.setNumAbonado(rs.getString("num_abonado")!=null?rs.getLong("num_abonado"):-1);
				abo.setNumCelular(rs.getString("num_celular")!=null?rs.getLong("num_celular"):-1);
				abo.setNombre(rs.getString("nombre")!=null?rs.getString("nombre"):"");
				abo.setCodPlanTarif(rs.getString("cod_plantarif")!=null?rs.getString("cod_plantarif"):"");
				abo.setDesPlanTarif(rs.getString("des_plantarif")!=null?rs.getString("des_plantarif"):"");
				abo.setDesTipoPlanTarif(rs.getString("des_tipplantarif")!=null?rs.getString("des_tipplantarif"):"");
				abo.setCodTipoTerminal(rs.getString("tip_terminal")!=null?rs.getString("tip_terminal"):"");
				abo.setCodCentral(rs.getString("cod_central")!=null?rs.getInt("cod_central"):-1);
				abo.setNumSerie(rs.getString("num_serie")!=null?rs.getString("num_serie"):"");
				abo.setNumImei(rs.getString("num_imei")!=null?rs.getString("num_imei"):"");
				abo.setCodTecnologia(rs.getString("cod_tecnologia")!=null?rs.getString("cod_tecnologia"):"");
				abo.setCodSituacion(rs.getString("cod_situacion")!=null?rs.getString("cod_situacion"):"");
				abo.setDesSituacion(rs.getString("des_situacion")!=null?rs.getString("des_situacion"):"");
				abo.setCodCargoBasico(rs.getString("cod_cargobasico")!=null?rs.getString("cod_cargobasico"):"");
				abo.setDesCargoBasico(rs.getString("des_cargobasico")!=null?rs.getString("des_cargobasico"):"");
				abo.setImpCargoBasico(rs.getString("imp_cargobasico")!=null?rs.getString("imp_cargobasico"):"");
				abo.setCodProdPadre(rs.getString("cod_prod_padre")!=null?rs.getString("cod_prod_padre"):"");		
				PlanTarifarioDTO planTarif=new PlanTarifarioDTO();
				
				planTarif.setCodPlanTarif(abo.getCodPlanTarif());
				planTarif.setDesPlanTarif(abo.getDesPlanTarif());				
				PaqueteDTO paquete=new PaqueteDTO();
				paquete.setCodProdPadre(abo.getCodProdPadre());				
				planTarif.setPaqueteDefault(paquete);				
				abo.setPlanTarifario(planTarif);
				
				listaAbonados.add(abo);
			}
			
			abonadosList=(AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaAbonados.toArray(), AbonadoDTO.class);
			retorno.setAbonados(abonadosList);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general en el registro de intarcel", e);
			throw new ProductException("Ocurrió un error general en el registro de intarcel",e);
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
		logger.debug("obtenerAbonadosPorVenta():end");
		return retorno;				
	}
	
	/**
	 * Consulta hibrido
	 * 
	 * @param consulta
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO consultaHibrido(ConsultaHibridoDTO consulta) throws ProductException{
		logger.debug("consultaHibrido():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLconsultaHibrido();
		try {
			logger.debug("call="+call);
			logger.debug("consulta.getCodCliente()[" + consulta.getCodCliente() + "]");
			logger.debug("consulta.getCodPlanTarif()[" + consulta.getCodPlanTarif() + "]");
			logger.debug("consulta.getTipPlanTarif[" + consulta.getTipPlanTarif() + "]");
			logger.debug("consulta.getCodTipPlan()[" + consulta.getCodTipPlan()+ "]");
			logger.debug("consulta.getCodTecnologia()[" + consulta.getCodTecnologia() + "]");
			logger.debug("consulta.getNumAbonado()[" + consulta.getNumAbonado() + "]");
			logger.debug("consulta.getUsuarioOracle()[" + consulta.getUsuarioOracle() + "]");
			logger.debug("consulta.getEnCambioPlanFamiliar()[" + consulta.getEnCambioPlanFamiliar() + "]");
			logger.debug("consulta.getCodPlanTarifNuevo()[" + consulta.getCodPlanTarifNuevo() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
					
			cstmt.setLong(1, consulta.getCodCliente()); //COD_CLIENTE
			cstmt.setString(2, consulta.getCodPlanTarif()); //COD_PLANTARIF
			cstmt.setString(3, consulta.getTipPlanTarif()); //TIP_PLANTARIF
			cstmt.setString(4, consulta.getCodTipPlan()); //COD_TIPLAN
			cstmt.setString(5, consulta.getCodTecnologia()); //COD_TECNOLOGIA
			cstmt.setLong(6, consulta.getNumAbonado()); //NUM_ABONADO
			cstmt.setString(7, consulta.getUsuarioOracle()); //NOM_USUARORA
			cstmt.setInt(8, consulta.getEnCambioPlanFamiliar()); //EN_CAMBIO_PLANFAMILIAR
			cstmt.setString(9, consulta.getCodPlanTarifNuevo()); //COD_PLANTARIF_NUEVO
			
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(10);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(11);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(12);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al consultar hibrido");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al consultar hibrido", e);
			throw new ProductException("Ocurrió un error general al consultar hibrido",e);
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
		logger.debug("consultaHibrido():end");
		return retorno;
	}
	
	/**
	 * Actualiza GA_ABOCEL
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO actualizarAboCtaSeg(GaAbocelDTO abonado) throws ProductException{
		logger.debug("actualizarAboCtaSeg():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizarAboCtaSeg();
		try {
		
			logger.debug("abonado.getCodPlanTarif()[" + abonado.getCodPlanTarif() + "]");
			logger.debug("abonado.getCodProducto()[" + abonado.getCodProducto() + "]");
			logger.debug("abonado.getCodTecnologia()[" + abonado.getCodTecnologia() + "]");
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado() + "]");
			logger.debug("abonado.getCodUso()[" + abonado.getCodUso() + "]");
			logger.debug("abonado.getNumDia()[" + abonado.getNumDia() + "]");
			logger.debug("abonado.getCodCargoBasico()[" + abonado.getCodCargoBasico() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, abonado.getCodPlanTarif()); //COD_PLANTARIF
			cstmt.setInt(2, abonado.getCodProducto()); //COD_PRODUCTO
			cstmt.setString(3, abonado.getCodTecnologia()); //COD_TECNOLOGIA
			cstmt.setLong(4, abonado.getNumAbonado()); //NUM_ABONADO
			cstmt.setInt(5, abonado.getCodUso()); //COD_USO
			cstmt.setInt(6, abonado.getNumDia()); //NUM_DIA
			cstmt.setString(7, abonado.getCodCargoBasico()); //COD_CARGOBASICO
			
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(9);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(10);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(11);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al actualizar ga_abocel");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String res = cstmt.getString(8);
			logger.debug("res[" + res + "]");
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			retorno.setResultado(res.equalsIgnoreCase("TRUE")?true:false);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al actualizar ga_abocel", e);
			throw new ProductException("Ocurrió un error general al actualizar ga_abocel",e);
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
		logger.debug("actualizarAboCtaSeg():end");
		return retorno;	
	}
	
	/**
	 * Inserta en GA_ABOCEL
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO migrarAbonado(GaAbocelDTO abonado) throws ProductException{
		logger.debug("migrarAbonado():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLmigrarAbonado();
		try {
			
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado() + "]");
			logger.debug("abonado.getIdSecuencia()[" + abonado.getIdSecuencia() + "]");
			logger.debug("abonado.getCodCiclo()[" + abonado.getCodCiclo() + "]");
			logger.debug("abonado.getCodPlanTarif()[" + abonado.getCodPlanTarif() + "]");
			logger.debug("abonado.getCodCliente()[" + abonado.getCodCliente() + "]");
			logger.debug("abonado.getTipPlanTarif()[" + abonado.getTipPlanTarif() + "]");
			logger.debug("abonado.getCodLimiteConsumo()[" + abonado.getCodLimiteConsumo() + "]");
			logger.debug("abonado.getCodCargoBasico()[" + abonado.getCodCargoBasico() + "]");
			logger.debug("abonado.getFecAlta()[" + abonado.getFecAlta() + "]");
			logger.debug("abonado.getNumContrato()[" + abonado.getNumContrato() + "]");
			logger.debug("abonado.getCodTipContrato()[" + abonado.getCodTipContrato() + "]");
			logger.debug("abonado.getNumVenta()[" + abonado.getNumVenta() + "]");
			logger.debug("abonado.getNumAnexo()[" + abonado.getNumAnexo() + "]");
			logger.debug("abonado.getCodCausaVenta()[" + abonado.getCodCausaVenta() + "]");
			logger.debug("abonado.getFecFinContra()[" + abonado.getFecFinContra() + "]");
			logger.debug("abonado.getFecBaja()[" + abonado.getFecBaja() + "]");
			logger.debug("abonado.getFecBajaCen()[" + abonado.getFecBajaCen() + "]");
			logger.debug("abonado.getCodSituacion()[" + abonado.getCodSituacion() + "]");
			logger.debug("abonado.getCodCuenta()[" + abonado.getCodCuenta() + "]");

			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
					
			cstmt.setLong(1, abonado.getNumAbonado()); //NUM_ABONADO
			cstmt.setLong(2, abonado.getIdSecuencia()); //ID_SECUENCIA
			cstmt.setInt(3, abonado.getCodCiclo()); //COD_CICLO
			cstmt.setString(4, abonado.getCodPlanTarif()); //COD_PLANTARIF
			cstmt.setLong(5, abonado.getCodCliente()); //COD_CLIENTE
			cstmt.setString(6, abonado.getTipPlanTarif()); //TIP_PLANTARIF
			cstmt.setString(7, abonado.getCodLimiteConsumo()); //COD_LIMCONSUMO
			cstmt.setString(8, abonado.getCodCargoBasico()); //COD_CARGOBASICO
			java.sql.Date fecAlta = null;	try{	fecAlta = new java.sql.Date(abonado.getFecAlta().getTime());	}catch(Exception e){}
			cstmt.setDate(9, fecAlta); //FEC_ALTA
			cstmt.setString(10, abonado.getNumContrato()); //NUM_CONTRATO
			cstmt.setString(11, abonado.getCodTipContrato()); //COD_TIPCONTRATO
			cstmt.setLong(12, abonado.getNumVenta()); //NUM_VENTA
			cstmt.setString(13, abonado.getNumAnexo()); //NUM_ANEXO
			cstmt.setString(14, abonado.getCodCausaVenta()); //COD_CAUSA_VENTA
			java.sql.Date fecFinContra = null;	try{	fecFinContra = new java.sql.Date(abonado.getFecFinContra().getTime());	}catch(Exception e){}
			cstmt.setDate(15, fecFinContra); //FEC_FINCONTRA
			java.sql.Date fecBaja = null;	try{	fecBaja = new java.sql.Date(abonado.getFecBaja().getTime()); }catch(Exception e){}
			cstmt.setDate(16, fecBaja); //FEC_BAJA
			java.sql.Date fecBajaCen = null;	try{	fecBajaCen = new java.sql.Date(abonado.getFecBajaCen().getTime()); }catch(Exception e){}
			cstmt.setDate(17, fecBajaCen); //FEC_BAJACEN
			cstmt.setString(18, abonado.getCodSituacion()); //COD_SITUACION
			cstmt.setLong(19, abonado.getCodCuenta()); //COD_CUENTA
			
			cstmt.registerOutParameter(20, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22, java.sql.Types.NUMERIC);
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(20);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(21);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(22);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al migrar abonado");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al migrar abonado", e);
			throw new ProductException("Ocurrió un error general al migrar abonado",e);
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
		logger.debug("migrarAbonado():end");
		return retorno;		
	}
	
	/**
	 * Obtiene campo fec_cumplan de GA_ABOCEL
	 * 
	 * @param abonado
	 * @return GaAbocelDTO
	 * @throws ProductException
	 */	
	public GaAbocelDTO obtenerFecCumPlan(GaAbocelDTO abonado) throws ProductException{
		logger.debug("obtenerFecCumPlan():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		GaAbocelDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerFecCumPlan();
		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
					
			cstmt.setLong(1, abonado.getCodCliente()); //COD_CLIENTE
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.DATE);
			
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
				logger.error(" Ocurrió un error al obtener fecCumplan");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			java.sql.Date fecCumplan = cstmt.getDate(5);
			logger.debug("fecCumplan[" + fecCumplan + "]");
			
			retorno = abonado;
			retorno.setFecCumplan(fecCumplan);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener fecCumplan", e);
			throw new ProductException("Ocurrió un error general al obtener fecCumplan",e);
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
		logger.debug("obtenerFecCumPlan():end");
		return retorno;		
	}
	
	/**
	 * Actualiza la situación perfil del abonado
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ProductException
	 */		
	public RetornoDTO actualizarSituPerfil(AbonadoDTO abonado) throws ProductException{

		logger.debug("actualizarSituPerfil():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizaSituaAbo();
		try {
		
			logger.debug("abonado.getCodActAbo()[" + abonado.getCodActAbo() + "]");
			logger.debug("abonado.getCodTecnologia()[" + abonado.getCodTecnologia() + "]");
			logger.debug("abonado.getClaseServicio()[" + abonado.getClaseServicio() + "]");
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado() + "]");
			logger.debug("abonado.getCodCliente()[" + abonado.getCodCliente() + "]");
			
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, abonado.getCodActAbo());
			cstmt.setString(2, abonado.getCodTecnologia());
			cstmt.setString(3, abonado.getClaseServicio());
			cstmt.setLong(4, abonado.getNumAbonado());
			cstmt.setLong(5, abonado.getCodCliente());
			
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(6);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error en la actualización del perfil del abonado");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");

			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general en la actualización del perfil del abonado", e);
			throw new ProductException("Ocurrió un error general en la actualización del perfil del abonado",e);
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
		logger.debug("actualizarSituPerfil():end");
		return retorno;			
	}
	
	public AbonadoDTO obtenerNumeroMovimientoAlta(AbonadoDTO abonado) throws ProductException
	{
		logger.debug("obtenerNumeroMovimientoAlta():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerNumeroMovimientoAlta();
		try 
		{			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt =  (OracleCallableStatement) conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("GA_ABONADO_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, abonado.toStruct_GA_Abonado_QT());
			
			cstmt.setObject(1, oracleObject);
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
			//fin----------------------------------------------------------------------
			
			if (codError != 0 && codError != 765) {
				logger.error(" Ocurrió un error en el registro de intarcel");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}			
			if(codError == 765)
			{
				abonado.setNumMovimientoAlta(null);
			}
			
			logger.debug("Recuperando data...");				
			ResultSet rs = (ResultSet) cstmt.getObject(2);			
			if(rs.next())
			{
				abonado.setNumMovimientoAlta(rs.getString("NUM_MOVIMIENTO")!=null?rs.getString("NUM_MOVIMIENTO"):null);
			}
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al obtener el numero de movimiento alta", e);
			throw new ProductException("Ocurrio un error al obtener el numero de movimiento alta",e);
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
		logger.debug("obtenerNumeroMovimientoAlta():end");
		return abonado;	
	}
	
	/**
	 * Obtiene fecha cuenta segura
	 * 
	 * @param intarcel
	 * @return IntarcelDTO
	 * @throws ProductException
	 */	
	public IntarcelDTO obtenerFecDesdeCtaSeg(IntarcelDTO intarcel) throws ProductException{
		logger.debug("obtenerFecDesdeCtaSeg():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		IntarcelDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerFecDesdeCtaSeg();
		try {
		
			logger.debug("intarcel.getNumAbonado()[" + intarcel.getNumAbonado() + "]");
			logger.debug("intarcel.getCodCliente()[" + intarcel.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			
			cstmt.setLong(1, intarcel.getNumAbonado()); //NUM_ABONADO
			cstmt.setLong(2, intarcel.getCodCliente()); //COD_CLIENTE
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(6, java.sql.Types.DATE);//FEC_DESDE
			
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
				logger.error(" Ocurrió un error al obtener fecha cuenta segura");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			Date fecDesde = cstmt.getDate(6);
			logger.debug("fecDesde[" + fecDesde + "]");
			
			retorno = intarcel;
			retorno.setFecDesde(fecDesde);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener fecha cuenta segura", e);
			throw new ProductException("Ocurrió un error general al obtener fecha cuenta segura",e);
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
		logger.debug("obtenerFecDesdeCtaSeg():end");
		return retorno;			
		
	}
}

