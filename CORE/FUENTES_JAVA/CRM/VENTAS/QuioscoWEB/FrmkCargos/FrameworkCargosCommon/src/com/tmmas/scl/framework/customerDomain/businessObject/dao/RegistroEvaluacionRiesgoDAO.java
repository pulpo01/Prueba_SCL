package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.RegistroEvaluacionRiesgoDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroEvaluacionRiesgoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionVentaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;


public class RegistroEvaluacionRiesgoDAO extends ConnectionDAO implements RegistroEvaluacionRiesgoDAOIT{
	private final Logger cat = Logger.getLogger(RegistroEvaluacionRiesgoDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerBillException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerBillException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}

	private String getSQLDatosEvaluacionRiesgo(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	public ResultadoValidacionVentaDTO existeEvaluacionRiesgo(ParametrosValidacionVentasDTO parametroEvaluacion) throws CustomerBillException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:existeEvaluacionRiesgo");

			String call = getSQLDatosEvaluacionRiesgo("VE_validacion_linea_PG","VE_existe_evaluacion_riesgo_PR",10);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEvaluacion.getNumeroIdentificador());
			cstmt.setString(2,parametroEvaluacion.getTipoIdentificador());
			//cstmt.setInt(3,global.getTipoSolicitud());
			cstmt.setInt(3,Integer.parseInt(parametroEvaluacion.getTipoSolicitudEvalRiesgo()));
			//cstmt.setInt(4,global.getIndicadorEvento());
			cstmt.setInt(4,Integer.parseInt(parametroEvaluacion.getIndicadorEventoEvalRiesgo()));
			//cstmt.setString(5,global.getEstadoVigenteEvaluacionRiesgo());
			cstmt.setString(5,parametroEvaluacion.getEstadoEvaluacionRiesgo());
			cat.debug("p1" + parametroEvaluacion.getNumeroIdentificador());
			cat.debug("p2" + parametroEvaluacion.getTipoIdentificador());
			cat.debug("p3" + parametroEvaluacion.getTipoSolicitudEvalRiesgo());
			cat.debug("p4" + parametroEvaluacion.getIndicadorEventoEvalRiesgo());
			//cstmt.setString(6,parametroEvaluacion.getCliente().getTipoCliente());
			cstmt.setString(6,parametroEvaluacion.getTipoCliente());
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			cat.debug("existeEvaluacionRiesgo:execute antes");
			cstmt.execute();
			cat.debug("existeEvaluacionRiesgo:execute despues");
			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			cat.debug("existeEvaluacionRiesgo:" + cstmt.getInt(7));
			cat.debug("msgError[" + msgError + "]");
			resultado.setResultadoBase(cstmt.getInt(7));
			

		} catch (Exception e) {
			cat.error("Ocurrió un error al buscar evaluación de riesgo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:existeEvaluacionRiesgo");

		return resultado;
	}
	
	public ResultadoValidacionVentaDTO existeEvalRiesgoPlanTarif(ParametrosValidacionVentasDTO parametroEvaluacion) throws CustomerBillException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getExisteEvalRiesgoPlanTarif");

			String call = getSQLDatosEvaluacionRiesgo("VE_validacion_linea_PG","VE_existe_eriesgo_ptarif_PR",10);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEvaluacion.getNumeroIdentificador());
			cstmt.setString(2,parametroEvaluacion.getTipoIdentificador());
			cstmt.setInt(3,Integer.parseInt(parametroEvaluacion.getTipoSolicitudEvalRiesgo()));
			cstmt.setInt(4,Integer.parseInt(parametroEvaluacion.getIndicadorEventoEvalRiesgo()));
			cstmt.setString(5,parametroEvaluacion.getEstadoEvaluacionRiesgo());
			cstmt.setString(6,parametroEvaluacion.getCodigoPlanTarifario());
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cat.debug("getExisteEvalRiesgoPlanTarif:execute antes");
			cstmt.execute();
			cat.debug("getExisteEvalRiesgoPlanTarif:execute despues");
			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			cat.debug("msgError[" + msgError + "]");
			resultado.setResultadoBase(cstmt.getInt(7));
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al buscar evaluación de riesgo asociada a plan tarifario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:getExisteEvalRiesgoPlanTarif");

		return resultado;
	}
	
	
	public RegistroEvaluacionRiesgoDTO getEvaluacionRiesgo(RegistroEvaluacionRiesgoDTO parametroEvaluacion) throws CustomerBillException{
		RegistroEvaluacionRiesgoDTO resultado = new RegistroEvaluacionRiesgoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getEvaluacionRiesgo");

			String call = getSQLDatosEvaluacionRiesgo("VE_servicios_venta_PG","VE_busca_evaluacion_riesgo_PR",11);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEvaluacion.getCliente().getNumeroIdentificacion());
			cat.debug("p1" + parametroEvaluacion.getCliente().getNumeroIdentificacion());
			cstmt.setString(2,parametroEvaluacion.getCliente().getCodigoTipoIdentificacion());
			cat.debug("p2" + parametroEvaluacion.getCliente().getCodigoTipoIdentificacion());
			cstmt.setInt(3,Integer.parseInt(parametroEvaluacion.getTipoSolicitud()));
			cat.debug("p3" + parametroEvaluacion.getTipoSolicitud());
			cstmt.setInt(4,Integer.parseInt(parametroEvaluacion.getIndicadorEvento()));
			cat.debug("p4" + parametroEvaluacion.getIndicadorEvento());
			cstmt.setString(5,parametroEvaluacion.getEstadosVigentes());
			cat.debug("p5" + parametroEvaluacion.getEstadosVigentes());
			/*cstmt.setString(6,parametroEvaluacion.getCliente().getTipoCliente());
			cat.debug("p6" + parametroEvaluacion.getCliente().getTipoCliente());*/
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			//cat.debug(global.getEstadoVigenteEvaluacionRiesgo());
			cat.debug("getEvaluacionRiesgo:execute antes");
			
			cstmt.execute();
			cat.debug("getEvaluacionRiesgo:execute despues");
			
			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			if (codError ==0){
				resultado.setLimiteCredito(cstmt.getDouble(7));
				resultado.setMontoGarantia(cstmt.getFloat(8));
			}
			

		} catch (Exception e) {
			cat.error("Ocurrió un error al buscar evaluación de riesgo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:getEvaluacionRiesgo");

		return resultado;
	}
	
	public RegistroEvaluacionRiesgoDTO getEvalRiesgoPlanTarif(RegistroEvaluacionRiesgoDTO parametroEvaluacion) throws CustomerBillException{
		RegistroEvaluacionRiesgoDTO resultado = new RegistroEvaluacionRiesgoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getEvalRiesgoPlanTarif");

			String call = getSQLDatosEvaluacionRiesgo("VE_servicios_venta_PG","VE_busca_eriesgo_ptarif_PR",13);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEvaluacion.getCliente().getNumeroIdentificacion());
			cat.debug("numero identificador: " + parametroEvaluacion.getCliente().getNumeroIdentificacion());
			cstmt.setString(2,parametroEvaluacion.getCliente().getCodigoTipoIdentificacion());
			cat.debug("getCodigoTipoIdentificacion: " + parametroEvaluacion.getCliente().getCodigoTipoIdentificacion());
			/*cstmt.setInt(3,global.getTipoSolicitud());
			cstmt.setInt(4,global.getIndicadorEvento());
			cstmt.setString(5,global.getEstadoVigenteEvaluacionRiesgo());*/
			cstmt.setInt(3,Integer.parseInt(parametroEvaluacion.getTipoSolicitud()));
			cat.debug("getTipoSolicitud: " + parametroEvaluacion.getTipoSolicitud());
			cstmt.setInt(4,Integer.parseInt(parametroEvaluacion.getIndicadorEvento()));
			cat.debug("getIndicadorEvento: " + parametroEvaluacion.getIndicadorEvento());
			cstmt.setString(5,parametroEvaluacion.getEstadosVigentes());
			cat.debug("getEstadosVigentes: " + parametroEvaluacion.getEstadosVigentes());
			cstmt.setString(6,parametroEvaluacion.getCodigoPlanTarifario());
			cat.debug("getCodigoPlanTarifario: " + parametroEvaluacion.getCodigoPlanTarifario());
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cat.debug("getEvalRiesgoPlanTarif:execute antes");
			cstmt.execute();
			cat.debug("getEvalRiesgoPlanTarif:execute despues");
			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(13);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			resultado.setNumeroSolicitud(cstmt.getLong(7));
			resultado.setCantidadTerminales(cstmt.getInt(8));
			resultado.setCantidadTerminalesVendidos(cstmt.getInt(9));
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al buscar evaluación de riesgo asociada a plan tarifario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getEvalRiesgoPlanTarif");
		return resultado;
	}	

	/**
	 * Obtiene registro evaluacion de riesgo 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	public RegistroEvaluacionRiesgoDTO getRegEvaluacionRiesgo(RegistroEvaluacionRiesgoDTO entrada) 
	throws CustomerBillException{
		RegistroEvaluacionRiesgoDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getRegEvaluacionRiesgo");

			String call = getSQLDatosEvaluacionRiesgo("ER_servicios_evalriesgo_PG","ER_getRegEvaluacionRiesgo_PR",10);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getNumIdentificacion());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getRegEvaluacionRiesgo:execute");
			cstmt.execute();
			cat.debug("Fin:getRegEvaluacionRiesgo:execute");
			
			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			
			if (codError == 0 ){
				resultado = new RegistroEvaluacionRiesgoDTO(); 	
				resultado.setNombreCliente(cstmt.getString(2));
				resultado.setDescripcionNombre(cstmt.getString(3));
				resultado.setPrimerApellido(cstmt.getString(4));
				resultado.setSegundoApellido(cstmt.getString(5));
				resultado.setCodigoTipoIdentificacion(cstmt.getString(6));
				resultado.setNumeroSolicitud(cstmt.getLong(7));
			} 
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al buscar registro de evaluación de riesgo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getRegEvaluacionRiesgo");
		return resultado;
	}//fin getRegEvaluacionRiesgo	

	/**
	 * Obtiene planes tarifarios autorizados
	 * @param entrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	public RegistroEvaluacionRiesgoDTO[] getListPlanTarifarioAutoriz(RegistroEvaluacionRiesgoDTO entrada) 
	throws CustomerBillException{
		RegistroEvaluacionRiesgoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getListPlanTarifarioAutoriz");

			String call = getSQLDatosEvaluacionRiesgo("ER_servicios_evalriesgo_PG","ER_getListPlanTarifAutoriz_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,entrada.getNumeroSolicitud());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListPlanTarifarioAutoriz:execute");
			cstmt.execute();
			cat.debug("Fin:getListPlanTarifarioAutoriz:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar planes tarifarios autorizados");
				throw new CustomerBillException(
						"Ocurrió un error al recuperar planes tarifarios autorizados", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando cargos basicos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					RegistroEvaluacionRiesgoDTO registroDTO = new RegistroEvaluacionRiesgoDTO();
					registroDTO.setCodigoPlanTarifario(rs.getString(1));
					lista.add(registroDTO);
				}
				rs.close();
				resultado =(RegistroEvaluacionRiesgoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), RegistroEvaluacionRiesgoDTO.class);
				
				cat.debug("Fin recuperacion planes tarifarios autorizados");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar planes tarifarios autorizados",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerBillException(
					"Ocurrió un error al recuperar planes tarifarios autorizados",e);
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListPlanTarifarioAutoriz");
		return resultado;
	}//fin getListPlanTarifarioAutoriz	
	
	/**
	 * Verifica si existe excepcion para el numero de identificador
	 * @param entrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	public RegistroEvaluacionRiesgoDTO getExcepcion(RegistroEvaluacionRiesgoDTO entrada) 
	throws CustomerBillException{
		RegistroEvaluacionRiesgoDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getExcepcion");

			String call = getSQLDatosEvaluacionRiesgo("ER_servicios_evalriesgo_PG","ER_getExcepcion_PR",6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entrada.getNumIdentificacion());
			cstmt.setString(2,entrada.getCodigoTipoIdentificacion());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("getExcepcion:execute antes");
			cstmt.execute();
			cat.debug("getExcepcion:execute despues");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError == 0){
				resultado = new RegistroEvaluacionRiesgoDTO();
				resultado.setCodigoRestriccion(cstmt.getInt(3));
			}

		} catch (Exception e) {
			cat.error("Ocurrió un error al verificar si existe excepcion para el numero identificador",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getExcepcion");
		return resultado;
	}//fin getExcepcion
	
	/**
	 * Obtiene evaluación de riesgo vigente asociada al cliente
	 * @param entrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	public RegistroEvaluacionRiesgoDTO getEvaluacionRiesgoVigenteCliente(RegistroEvaluacionRiesgoDTO entrada) 
	throws CustomerBillException{
		RegistroEvaluacionRiesgoDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getEvaluacionRiesgoVigenteCliente");

			String call = getSQLDatosEvaluacionRiesgo("ER_servicios_evalriesgo_PG","ER_getEvRiesgoVigente_PR",7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoTipoIdentificacion());
			cstmt.setString(2,entrada.getNumIdentificacion());
			cstmt.setString(3,entrada.getTipoSolicitud());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getEvaluacionRiesgoVigenteCliente:execute");
			cstmt.execute();
			cat.debug("Fin:getEvaluacionRiesgoVigenteCliente:execute");
			
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			if (codError == 0 ){
				resultado = new RegistroEvaluacionRiesgoDTO(); 	
				resultado.setNumeroSolicitud(cstmt.getLong(4));
			} 
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al buscar registro de evaluación de riesgo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getEvaluacionRiesgoVigenteCliente");
		return resultado;
	}//fin getEvaluacionRiesgoVigenteCliente	
	
	
	
	/**
	 * Actualiza cantidad de terminales vendidos asociados a la evaluacion de riesgo.
	 *
	 * @author Héctor Hermosilla	
	 * @param registroEvaluacionRiesgoDTO
	 * @return 
	 * @throws CustomerBillException
	 */
	public void actualizaTerminalesVendidos(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO) 
	throws CustomerBillException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:actualizaTerminalesVendidos");

			String call = getSQLDatosEvaluacionRiesgo("ER_servicios_evalriesgo_PG","VE_updSolicPlanes_TermVend_PR",6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,String.valueOf(registroEvaluacionRiesgoDTO.getNumeroSolicitud()));
			cstmt.setString(2,registroEvaluacionRiesgoDTO.getCodigoPlanTarifario());
			cstmt.setString(3,String.valueOf(registroEvaluacionRiesgoDTO.getCantidadTerminales()));
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:actualizaTerminalesVendidos:execute");
			cstmt.execute();
			cat.debug("Fin:actualizaTerminalesVendidos:execute");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			if (codError != 0 ){
				cat.error("Ocurrió un error al actualizar los terminales vendidos de la Ev. de Riesgo");
				throw new CustomerBillException(
						"Ocurrió un error al actualizar los terminales vendidos de la Ev. de Riesgo", String
								.valueOf(codError), numEvento, msgError);
			} 
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar los terminales vendidos de la Ev. de Riesgo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:actualizaTerminalesVendidos");
	}//fin actualizaTerminalesVendidos	
	
	/**
	 * Inserta relacion entre la solicitud y la venta
	 * @author wjrc	
	 * @param registroEvaluacionRiesgoDTO
	 * @return 
	 * @throws CustomerBillException
	 */
	public void insSolicitudVenta(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO) 
	throws CustomerBillException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:insSolicitudVenta");

			String call = getSQLDatosEvaluacionRiesgo("ER_servicios_evalriesgo_PG","VE_insSolicitudVenta_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			cstmt.setString(1,String.valueOf(registroEvaluacionRiesgoDTO.getNumeroSolicitud()));
			cstmt.setString(2,registroEvaluacionRiesgoDTO.getNumeroVenta());
			/*-- salida --*/
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:insSolicitudVenta:execute");
			cstmt.execute();
			cat.debug("Fin:insSolicitudVenta:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError != 0 ){
				cat.error("Ocurrió un error al insertar relacion entre la solicitud y la venta");
				throw new CustomerBillException(
						"Ocurrió un error al insertar relacion entre la solicitud y la venta", String
								.valueOf(codError), numEvento, msgError);
			} 
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar relacion entre la solicitud y la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:insSolicitudVenta");
	}//fin insSolicitudVenta	
	
}//fin CLASS RegistroEvaluacionRiesgoDAO
