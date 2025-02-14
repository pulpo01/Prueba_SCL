package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuentaIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuentaIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;

public class CuentaDAO extends ConnectionDAO{

	private final Logger logger = Logger	.getLogger(CuentaDAO.class);	
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

	private String getSQLDatosCuenta(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}//fin getSQLDatosCuenta
	
	public CuentaDTO getCuenta(CuentaDTO cuentaDTO) throws GeneralException{
		logger.debug("Inicio:getCuenta()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CuentaDTO resultado=null;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_validacion_linea_PG","VE_existe_cuenta_PR",7);
			String call = getSQLDatosCuenta("VE_validacion_linea_quiosco_PG","VE_existe_cuenta_PR",7);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,Integer.parseInt(cuentaDTO.getCodigoCuenta()));
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			
			logger.debug("inicio:Execute");
			cstmt.execute();
			logger.debug("Fin:Execute");

			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar la cuenta");
				throw new GeneralException(
						"Ocurrió un error al consultar la cuenta", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado = new CuentaDTO();
				resultado.setCodigoCuenta(cuentaDTO.getCodigoCuenta());
				resultado.setExisteCuenta(cstmt.getInt(2));
				resultado.setDescripcionCuenta(cstmt.getString(3));
				resultado.setCodigoCategoria(cstmt.getString(4));
			}
			
			logger.debug("cuenta[" + cuentaDTO.getCodigoCuenta() + "]");
			logger.debug("descripcion[" + resultado.getDescripcionCuenta() + "]");
			logger.debug("categoria[" + resultado.getCodigoCategoria() + "]");

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar la cuenta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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

		logger.debug("Fin:getCuenta()");

		return resultado;
		}//fin getDatosCuenta
	
	public CuentaDTO getSubCuenta(CuentaDTO entrada) throws GeneralException{
		logger.debug("Inicio:getSubCuenta()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_crea_linea_venta_PG","VE_obtiene_subcuentas_PR",5);
			String call = getSQLDatosCuenta("VE_crea_linea_venta_quiosco_PG","VE_obtiene_subcuentas_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,Integer.parseInt(entrada.getCodigoCuenta()));
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			
			logger.debug("inicio:Execute");
			cstmt.execute();
			logger.debug("Fin:Execute");
			
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				if(codError == 1){
					codError = 12240;
					msgError = "No Existe una SubCuenta";
				}else if (codError == 156){
					codError = 12241;
					msgError = "Existe un error no definido en Base Dato al recueprar la SubCuenta";
				}
				
				logger.error("Ocurrió un error al consultar la Subcuenta");
				throw new GeneralException(
						"Ocurrió un error al consultar la Subcuenta", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				entrada.setCodigoSubCuenta(cstmt.getString(2));
			}
			logger.debug("cuenta[" + entrada.getCodigoCuenta()+ "]");
			logger.debug("subcuenta[" + entrada.getCodigoSubCuenta() + "]");


			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida
		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar la Subcuenta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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

		logger.debug("Fin:getSubCuenta()");

		return entrada;
		}//fin getSubCuenta

	/**
	 * Obtiene listado de clasificacion cuenta
	 * @param N/A
	 * @return CuentaDTO[]
	 * @throws GeneralException
	 */
	public CuentaDTO[] getListClasificacionCuenta() 
	throws GeneralException{
		logger.debug("Inicio:getListClasificacionCuenta()");
		CuentaDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_alta_cuenta_PG","VE_getListClasifCuenta_PR",4);
			String call = getSQLDatosCuenta("VE_alta_cuenta_quiosco_PG","VE_getListClasifCuenta_PR",4);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListClasificacionCuenta:execute");
			cstmt.execute();
			logger.debug("Fin:getListClasificacionCuenta:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar clasificacion de cuentas");
				throw new GeneralException(
						"Ocurrió un error al recuperar clasificacion de cuentas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando clasificacion de cuentas");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					CuentaDTO cuentaDTO = new CuentaDTO();
					cuentaDTO.setCodigoClasificacion(rs.getString(1));
					cuentaDTO.setDescripcionClasificacion(rs.getString(2));
					lista.add(cuentaDTO);
				}
				rs.close();
				resultado =(CuentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), CuentaDTO.class);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar clasificacion de cuentas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		logger.debug("Fin:getListClasificacionCuenta()");
		return resultado;
	}//fin getListClasificacionCuenta	
	
	public CuentaDTO[] getListadoCuenta (CuentaDTO criterioBusquedaCuenta) 
	throws GeneralException{
		logger.debug("Inicio:getListadoCuenta()");
		CuentaDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;

		try {
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_alta_cuenta_PG","VE_getListCuentas_PR",8);
			String call = getSQLDatosCuenta("VE_alta_cuenta_quiosco_PG","VE_getListCuentas_PR",8);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,criterioBusquedaCuenta.getCriterioBusqueda());
			cstmt.setString(2,criterioBusquedaCuenta.getFiltroBusqueda());
			cstmt.setString(3,criterioBusquedaCuenta.getValorBusqueda());
			cstmt.setString(4,criterioBusquedaCuenta.getTipoIdentificacion());
			cstmt.registerOutParameter(5,OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getListadoCuenta:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoCuenta:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar cuentas");
				throw new GeneralException(
						"Ocurrió un error al recuperar  cuentas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando cuentas por criterio");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(5);
				while (rs.next()) {
					CuentaDTO cuentaDTO = new CuentaDTO();
					cuentaDTO.setTipoEntidad(rs.getString(1));
					cuentaDTO.setCodigoCuenta(String.valueOf(rs.getInt(2)));
					cuentaDTO.setCodigoTipIdentif(rs.getString(3));
					cuentaDTO.setDescripcionTipIdentif(rs.getString(4));
					cuentaDTO.setNumeroIdentificacion(rs.getString(5));
					cuentaDTO.setDescripcionCuenta(rs.getString(6));
					cuentaDTO.setTipoCuenta(rs.getString(7));
					lista.add(cuentaDTO);
				}
				rs.close();
				resultado =(CuentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), CuentaDTO.class);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar cuentas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		logger.debug("Fin:getListadoCuenta()");
		return resultado;
	}//fin getListadoCuenta	

	/**
	 * Inserta cuenta
	 * @param cuenta
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insCuenta(CuentaComDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insCuenta");
			
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_alta_cuenta_PG","VE_insCuenta_PR",25);
			String call = getSQLDatosCuenta("VE_alta_cuenta_quiosco_PG","VE_insCuenta_PR",25);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cuenta.getCodigoCuenta());
			logger.debug("cuenta.getCodigoCuenta(): " + cuenta.getCodigoCuenta());
			cstmt.setString(2,cuenta.getDescripcionCuenta());
			logger.debug("cuenta.getDescripcionCuenta(): " + cuenta.getDescripcionCuenta());
			cstmt.setString(3,cuenta.getTipoCuenta());
			logger.debug("cuenta.getTipoCuenta()): " + cuenta.getTipoCuenta());
			cstmt.setString(4,cuenta.getResponsable());
			logger.debug("cuenta.getResponsable(): " + cuenta.getResponsable());
			cstmt.setString(5,cuenta.getCodigoTipIdentif());
			logger.debug("cuenta.getCodigoTipIdentif(): " + cuenta.getCodigoTipIdentif());
			cstmt.setString(6,cuenta.getNumeroIdentificacion());
			logger.debug("cuenta.getNumeroIdentificacion(): " + cuenta.getNumeroIdentificacion());
			cstmt.setString(7, String.valueOf(cuenta.getDireccion().getCodigo() ));
			logger.debug("cuenta.getCodigoDireccion(): " + cuenta.getDireccion().getCodigo());
			cstmt.setString(8,cuenta.getIndicadorEstado());
			logger.debug("cuenta.getIndicadorEstado(): " + cuenta.getIndicadorEstado());
			cstmt.setString(9,cuenta.getTelefonoContacto());
			logger.debug("cuenta.getTelefonoContacto(): " + cuenta.getTelefonoContacto());
			cstmt.setString(10,cuenta.getIndicadorSector());
			logger.debug("cuenta.getIndicadorSector(): " + cuenta.getIndicadorSector());
			cstmt.setString(11,cuenta.getClaseCuenta());
			logger.debug("cuenta.getClaseCuenta(): " + cuenta.getClaseCuenta());
			cstmt.setString(12,cuenta.getCodigoCategTributaria());
			logger.debug("cuenta.getCodigoCategtTributaria(): " + cuenta.getCodigoCategTributaria());
			cstmt.setString(13,String.valueOf(cuenta.getCodigoCategoria()));
			logger.debug("cuenta.getCodigoCategoria(): " + cuenta.getCodigoCategoria());
			cstmt.setString(14, String.valueOf(cuenta.getCodigoSector()));
			logger.debug("cuenta.getCodigoSector(): " + cuenta.getCodigoSector());
			cstmt.setString(15,cuenta.getCodigoSubCategoria());
			logger.debug("cuenta.getCodigoSubCategoria(): " + cuenta.getCodigoSubCategoria());
			cstmt.setString(16,cuenta.getIndicadorMultUso());
			logger.debug("cuenta.getIndicadorMultUso(): " + cuenta.getIndicadorMultUso());
			cstmt.setString(17,cuenta.getClientePotencial());
			logger.debug("cuenta.getClientePotencial(): " + cuenta.getClientePotencial());
			cstmt.setString(18,cuenta.getRazonSocial());
			logger.debug("cuenta.getRazonSocial(): " + cuenta.getRazonSocial());
			cstmt.setString(19,cuenta.getFechaInVPac());
			logger.debug("cuenta.getFechaInVPac(): " + cuenta.getFechaInVPac());
			cstmt.setString(20,cuenta.getTipoComisionista());
			logger.debug("cuenta.getTipoComisionista(): " + cuenta.getTipoComisionista());
			cstmt.setString(21,cuenta.getUsuarioAsesor());
			logger.debug("cuenta.getUsuarioAsesor(): " + cuenta.getUsuarioAsesor());
			cstmt.setString(22,cuenta.getFechaNacimiento());
			logger.debug("cuenta.getFechaNacimiento(): " + cuenta.getFechaNacimiento());

			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insCuenta:execute");
			cstmt.execute();
			logger.debug("Fin:insCuenta:execute");
			
			codError = cstmt.getInt(23);
			msgError = cstmt.getString(24);
			numEvento = cstmt.getInt(25);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError !=0){
				logger.error("Ocurrió un error al insertar cuenta");
				throw new GeneralException(
						"Ocurrió un error al insertar cuenta", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar cuenta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);

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
		logger.debug("Fin:insCuenta()");
	}//fin insCuenta
	
	/**
	 * Inserta SubCuenta
	 * @param SubCuenta
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insSubCuenta(CuentaComDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insSubCuenta");
			
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_alta_cuenta_PG","VE_insSubCuenta_PR",7);
			String call = getSQLDatosCuenta("VE_alta_cuenta_quiosco_PG","VE_insSubCuenta_PR",7);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cuenta.getCodigoCuenta());
			logger.debug("cuenta.getCodigoCuenta(): " + cuenta.getCodigoCuenta());
			cstmt.setString(2,cuenta.getCodigoSubCuenta());
			logger.debug("cuenta.getCodigoSubCuenta(): " + cuenta.getCodigoSubCuenta());
			cstmt.setString(3,cuenta.getDescripcionSubCuenta());
			logger.debug("cuenta.getDescripcionSubCuenta(): " + cuenta.getDescripcionSubCuenta());
			cstmt.setString(4,String.valueOf(cuenta.getDireccion().getCodigo()));
			logger.debug("cuenta.getCodigoDireccion()): " + cuenta.getDireccion().getCodigo());

			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insSubCuenta:execute");
			cstmt.execute();
			logger.debug("Fin:insSubCuenta:execute");
			
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError !=0){
				logger.error("Ocurrió un error al insertar subcuenta");
				throw new GeneralException(
						"Ocurrió un error al insertar subcuenta", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar subcuenta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
			
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
		logger.debug("Fin:insSubCuenta()");
	}//fin insSubCuenta

	/**
	 * Retorna todos los datos de la cuenta
	 * @param cuenta
	 * @return resultado
	 * @throws GeneralException
	 */
	public CuentaDTO getCuentaAll(CuentaDTO cuenta) 
	throws GeneralException{
		CuentaDTO resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getCuentaAll");
			
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_alta_cuenta_PG","VE_getCuenta_PR",26);
			String call = getSQLDatosCuenta("VE_alta_cuenta_quiosco_PG","VE_getCuenta_PR",26);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cuenta.getCodigoCuenta());
			
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23,java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getCuentaAll:execute");
			cstmt.execute();
			logger.debug("Fin:getCuentaAll:execute");
			
			codError = cstmt.getInt(24);
			msgError = cstmt.getString(25);
			numEvento = cstmt.getInt(26);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError !=0){
				logger.error("Ocurrió un error al consultar la cuenta");
				throw new GeneralException(
						"Ocurrió un error al consultar la cuenta", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado = new CuentaDTO();
				resultado.setCodigoCuenta(cuenta.getCodigoCuenta());
				
				resultado.setDescripcionCuenta(cstmt.getString(2));
				resultado.setTipoCuenta(cstmt.getString(3));
				resultado.setResponsable(cstmt.getString(4));
				resultado.setCodigoTipIdentif(cstmt.getString(5));
				resultado.setNumeroIdentificacion(cstmt.getString(6));
				resultado.setDireccionCuenta(cstmt.getString(7));
				resultado.setIndicadorEstado(cstmt.getString(9));
				resultado.setTelefonoContacto(cstmt.getString(10));
				resultado.setIndicadorSector(cstmt.getString(11));
				resultado.setClaseCuenta(cstmt.getString(12));
				resultado.setCodigoCategTributaria(cstmt.getString(13));
				resultado.setCodigoCategoria(cstmt.getString(14));			
				resultado.setCodigoSector(cstmt.getString(15));
				resultado.setCodigoSubCategoria(cstmt.getString(16));
				resultado.setIndicadorMultUso(cstmt.getString(17));
				resultado.setClientePotencial(cstmt.getString(18));
				resultado.setRazonSocial(cstmt.getString(19));
				resultado.setFechaInVPac(cstmt.getString(20));
				resultado.setTipoComisionista(cstmt.getString(21));
				resultado.setUsuarioAsesor(cstmt.getString(22));
				resultado.setFechaNacimiento(cstmt.getString(23));
				logger.debug("cuenta[" + cuenta.getCodigoCuenta() + "]");
				logger.debug("descripcion[" + resultado.getDescripcionCuenta() + "]");
				logger.debug("categoria[" + resultado.getCodigoCategoria() + "]");
			}		
		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar cuenta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		logger.debug("Fin:getCuentaAll()");
		return resultado;
	}//fin getCuentaAll
	
	/**
	 * Retorna todos los datos de la cuenta
	 * @param cuenta
	 * @return resultado
	 * @throws GeneralException
	 */
	public CuentaComDTO getCuentaNumIdent(CuentaComDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
	    DireccionNegocioDTO direccion = new DireccionNegocioDTO();		
		try {
			logger.debug("Inicio:getCuentaNumIdent");
			
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_alta_cuenta_PG","VE_getCuentaIdentif_PR",26);
			String call = getSQLDatosCuenta("VE_alta_cuenta_quiosco_PG","VE_getCuentaIdentif_PR",26);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cuenta.getCodigoTipIdentif());
			cstmt.setString(2,cuenta.getNumeroIdentificacion());
			
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getCuentaNumIdent:execute");
			cstmt.execute();
			logger.debug("Fin:getCuentaNumIdent:execute");
			
			codError = cstmt.getInt(24);
			msgError = cstmt.getString(25);
			numEvento = cstmt.getInt(26);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
						
			if (codError ==0){
				cuenta.setDireccion(direccion);				
				cuenta.setCodigoCuenta(cstmt.getString(3));
				cuenta.setDescripcionCuenta(cstmt.getString(4));
				cuenta.setTipoCuenta(cstmt.getString(5));
				cuenta.setResponsable(cstmt.getString(6));
				cuenta.getDireccion().setCodigo(cstmt.getString(7));
				cuenta.setIndicadorEstado(cstmt.getString(9));
				cuenta.setTelefonoContacto(cstmt.getString(10));
				cuenta.setIndicadorSector(cstmt.getString(11));
				cuenta.setClaseCuenta(cstmt.getString(12));
				cuenta.setCodigoCategTributaria(cstmt.getString(13));
				cuenta.setCodigoCategoria(cstmt.getString(14));
			//	cuenta.setCodigoSector(Integer.parseInt(cstmt.getString(15)));
				cuenta.setCodigoSubCategoria(cstmt.getString(16));
				cuenta.setIndicadorMultUso(cstmt.getString(17));
				cuenta.setClientePotencial(cstmt.getString(18));
				cuenta.setRazonSocial(cstmt.getString(19));
				cuenta.setFechaInVPac(cstmt.getString(20));
				cuenta.setTipoComisionista(cstmt.getString(21));
				cuenta.setUsuarioAsesor(cstmt.getString(22));
				cuenta.setFechaNacimiento(cstmt.getString(23));
				
				
			}else if(codError != 1){
				logger.error("Ocurrió un error al consultar la cuenta");
				throw new GeneralException(
						"Ocurrió un error al consultar la cuenta", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cuenta.setCodigoCuenta("0");
			}
			
		}catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el numero de cuenta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		logger.debug("Fin:getCuentaNumIdent()");
		return cuenta;
	}//fin getCuentaNumIdent
	
	
	
	/**
	 * Obtiene la categoria de la cuenta
	 * @param cuenta
	 * @return resultado
	 * @throws GeneralException
	 */
	public CuentaComDTO getCategoriaCuenta(CuentaComDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getCategoriaCuenta");
			
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_intermediario_PG","VE_ObtieneCategoriaCta_PR",12);
			String call = getSQLDatosCuenta("VE_intermediario_Quiosco_PG","VE_ObtieneCategoriaCta_PR",12);
			
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cuenta.getNumeroIdentificacion());
			cstmt.setString(2,cuenta.getCodigoCategTributaria());
			cstmt.setString(3,cuenta.getTipoModulo());
			cstmt.setString(4,cuenta.getTipoIdentificacion());
			
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getCategoriaCuenta:execute");
			cstmt.execute();
			logger.debug("Fin:getCategoriaCuenta:execute");
			
			codError = cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento = cstmt.getInt(12);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError ==0){

				cuenta.setCodigoCuenta(cuenta.getCodigoCuenta());
				cuenta.setCodigoCategoria(cstmt.getString(5));
				cuenta.setCodigoSubCategoria(cstmt.getString(6));
				cuenta.setIndicadorMultUso(cstmt.getString(7));
				cuenta.setClientePotencial(cstmt.getString(8));
				cuenta.setRazonSocial(cstmt.getString(9));
			}else{
				logger.error("Ocurrió un error al obtener la categoria de la cuenta");
				throw new GeneralException(String.valueOf(codError),numEvento, msgError);
			}
		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener la categoria de la cuenta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		logger.debug("Fin:getCategoriaCuenta()");
		return cuenta;
	}//fin getCuentaAll
	
	/**
	 * Actualiza Cuenta
	 * @param cuenta
	 * @return N/A
	 * @throws GeneralException
	 */
	public void actualizaCuenta(CuentaComDTO cuenta) throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:actualizaCuenta");
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_alta_cuenta_PG","VE_updCategCuenta_PR",9);
			String call = getSQLDatosCuenta("VE_alta_cuenta_quiosco_PG","VE_updCategCuenta_PR",9);
			logger.debug ("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,cuenta.getCodigoCuenta());
			logger.debug("cuenta.getCodigoCuenta(): " + cuenta.getCodigoCuenta());
			cstmt.setString(2,cuenta.getCodigoCategoria());
			logger.debug("cuenta.getCodigoCategoria(): " + cuenta.getCodigoCategoria());
			cstmt.setString(3,cuenta.getCodigoSubCategoria());
			logger.debug("cuenta.getCodigoSubCategoria(): " + cuenta.getCodigoSubCategoria());
			cstmt.setString(4,cuenta.getIndicadorMultUso());
			logger.debug("cuenta.getIndicadorMultUso()): " + cuenta.getIndicadorMultUso());
			cstmt.setString(5,cuenta.getClientePotencial());
			logger.debug("cuenta.getClientePotencial()): " + cuenta.getClientePotencial());
			cstmt.setString(6,cuenta.getRazonSocial());
			logger.debug("cuenta.getRazonSocial()): " + cuenta.getRazonSocial());
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			logger.debug("Inicio:actualizaCuenta:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaCuenta:execute");
			
			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError !=0){
				logger.error("Ocurrió un error al actualizar la cuenta");
				throw new GeneralException(
						"Ocurrió un error al actualizar la cuenta", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar la cuenta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		logger.debug("Fin:actualizaCuenta()");
	}//fin actualizaCuenta
	
	/**
	 * Inserta SubCuenta
	 * @param SubCuenta
	 * @return N/A
	 * @throws GeneralException
	 */
	public void eliminaCuentasPotenciales(CuentaComDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:eliminaCuentasPotenciales");
			
			//INI-01 (AL) String call = getSQLDatosCuenta("VE_alta_cuenta_PG","VE_delCategCtasPotenciales_PR",4);
			String call = getSQLDatosCuenta("VE_alta_cuenta_quiosco_PG","VE_delCategCtasPotenciales_PR",4);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cuenta.getNumeroIdentificacion());
			logger.debug("cuenta.getNumeroIdentificacion()): " + cuenta.getNumeroIdentificacion());

			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:eliminaCuentasPotenciales:execute");
			cstmt.execute();
			logger.debug("Fin:eliminaCuentasPotenciales:execute");
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al eliminaCuentasPotenciales");
				throw new GeneralException("Ocurrió un error al eliminaCuentasPotenciales",String.valueOf( codError), numEvento  , msgError);
			}

		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al eliminaCuentasPotenciales",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		logger.debug("Fin:eliminaCuentasPotenciales()");
	}//fin eliminaCuentasPotenciales
	private String getSQLgetSubCuentaPorCodCliente(){
		StringBuffer call=new StringBuffer();
		call.append("BEGIN ");
		call.append(" GE_CONS_CATALOGO_PORTAB_PG.GE_REC_SUBCUENTA_X_CLIENTE_PR (?,?,?,?,?); ");
		call.append("END;");
		return call.toString();
	}
	
	public CuentaDTO[] getSubCuentaPorCodCliente(ClienteDTO clienteDTO) throws GeneralException{
		CuentaDTO[] retValue=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try{
			logger.debug("Inicio DAO:  getSubCuentaPorCodCliente");
			logger.debug("Codigo cliente:  ["+clienteDTO.getCodigoCliente()+"]");
			String call=getSQLgetSubCuentaPorCodCliente();
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,clienteDTO.getCodigoCliente());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getListTiposComisionistas:execute");
			cstmt.execute();
			logger.debug("Fin:getListTiposComisionistas:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar sub cuentas");
				throw new GeneralException(
						"Ocurrió un error al recuperar sub cuentas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando sub cuentas");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					CuentaDTO cuentaDTO = new CuentaDTO();
					cuentaDTO.setCodigoSubCuenta(rs.getString(1));
					cuentaDTO.setDescripcionSubCuenta(rs.getString(2));
					lista.add(cuentaDTO);
				}
				rs.close();
				retValue =(CuentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), CuentaDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		
		}catch(GeneralException e){
			throw(e);
		} 
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar sub cuentas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw (GeneralException)e;
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
		logger.debug("Inicio DAO:  getSubCuentaPorCodCliente");
		return retValue;
	}
	
	
	/**
	 * Obtiene la categoria de la cuenta
	 * @param cuenta
	 * @return resultado
	 * @throws GeneralException
	 */
	public WsCuentaIdentOutDTO validaCuentaNumeroIdentificacion(WsCuentaIdentInDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		WsCuentaIdentOutDTO cuentaout = new WsCuentaIdentOutDTO();
		try {
			logger.debug("Inicio:getCategoriaCuenta");
			
			String call = getSQLDatosCuenta("ve_portabilidad_pg","ve_val_cuenta_ident_pr",29);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cuenta.getCodigoTipoIdentificacion());
			cstmt.setString(2,cuenta.getNumeroidentificacion());			
			
			
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);   // sn_cod_cuenta          OUT NOCOPY      ga_cuentas.cod_cuenta%TYPE,
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);   // sv_des_cuenta       	 OUT NOCOPY      ga_cuentas.des_cuenta%TYPE,
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);   // sv_tip_cuenta       	 OUT NOCOPY      ga_cuentas.tip_cuenta%TYPE,
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);   // sv_nom_responsable  	 OUT NOCOPY      ga_cuentas.nom_responsable%TYPE,
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);   // sv_cod_tipident     	 OUT NOCOPY      ga_cuentas.cod_tipident%TYPE,
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);   // sv_num_ident        	 OUT NOCOPY      ga_cuentas.num_ident%TYPE,			
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);   // sn_cod_direccion   	 OUT NOCOPY      ga_cuentas.cod_direccion%TYPE,  
			cstmt.registerOutParameter(10,java.sql.Types.DATE);     // sd_fec_alta         	 OUT NOCOPY      ga_cuentas.fec_alta%TYPE,  
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);  // sv_ind_estado       	 OUT NOCOPY      ga_cuentas.ind_estado%TYPE,
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);  // sv_tel_contacto     	 OUT NOCOPY      ga_cuentas.tel_contacto%TYPE,
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);  // sv_ind_sector       	 OUT NOCOPY      ga_cuentas.ind_sector%TYPE, 
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);  // sv_cod_clascta      	 OUT NOCOPY      ga_cuentas.cod_clascta%TYPE, 
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);  // sv_cod_catribut      OUT NOCOPY      ga_cuentas.cod_catribut%TYPE, 
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);  // sv_des_valor        	 OUT NOCOPY      ged_codigos.des_valor%TYPE, 
			cstmt.registerOutParameter(17,java.sql.Types.NUMERIC);  // sn_cod_categoria    	 OUT NOCOPY      ga_cuentas.cod_categoria%TYPE, 
			cstmt.registerOutParameter(18,java.sql.Types.NUMERIC);  // sn_cod_sector       	 OUT NOCOPY      ga_cuentas.cod_sector%TYPE, 
			cstmt.registerOutParameter(19,java.sql.Types.VARCHAR);  // sv_cod_subcategori  	 OUT NOCOPY      ga_cuentas.cod_subcategoria%TYPE,
			cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);  // sv_ind_multuso         OUT NOCOPY      ga_cuentas.ind_multuso%TYPE, 
			cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);  // sv_ind_cliepotencial   OUT NOCOPY      ga_cuentas.ind_cliepotencial%TYPE, 
			cstmt.registerOutParameter(22,java.sql.Types.VARCHAR);  // sv_des_razon_social    OUT NOCOPY      ga_cuentas.des_razon_social%TYPE, 
			cstmt.registerOutParameter(23,java.sql.Types.DATE);     // sd_fec_inivta_pac      OUT NOCOPY      ga_cuentas.fec_inivta_pac%TYPE,  
			cstmt.registerOutParameter(24,java.sql.Types.VARCHAR);  // sv_cod_tipcomis        OUT NOCOPY      ga_cuentas.nom_usuario_asesor%TYPE,
			cstmt.registerOutParameter(25,java.sql.Types.VARCHAR);  // sv_nom_usuario_asesor  OUT NOCOPY      ga_cuentas.nom_usuario_asesor%TYPE, 
			cstmt.registerOutParameter(26,java.sql.Types.DATE);     // sd_fec_nacimiento      OUT NOCOPY      ga_cuentas.fec_nacimiento%TYPE,	
			cstmt.registerOutParameter(27, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(28, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(29, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getCategoriaCuenta:execute");
			cstmt.execute();
			logger.debug("Fin:getCategoriaCuenta:execute");
			
			codError = cstmt.getInt(27);
			msgError = cstmt.getString(28);
			numEvento = cstmt.getInt(29);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError ==0){

				cuentaout.setCodigoCuenta(cstmt.getLong(3));				
				cuentaout.setDescripcionCuenta(cstmt.getString(4));
				cuentaout.setTipoCuenta(cstmt.getString(5));
				cuentaout.setNombreResponsable(cstmt.getString(6));
				cuentaout.setCodigoTipoIdentificacion(cstmt.getString(7));
				cuentaout.setNumeroIdentifiacion(cstmt.getString(8));
				cuentaout.setCodigoDireccion(cstmt.getLong(9));
				cuentaout.setFechaAlta(cstmt.getDate(10));
				cuentaout.setIndicadorEstado(cstmt.getString(11));
				cuentaout.setTelefonoContacto(cstmt.getString(12));
				cuentaout.setIndicadorSector(cstmt.getString(13));
				cuentaout.setCodigoClasificacionCuenta(cstmt.getString(14));
				cuentaout.setCodigoCategoriaTributaria(cstmt.getString(15));
				cuentaout.setDescripcionCategoriaTributaria(cstmt.getString(16));
				cuentaout.setCodigoCategoria(cstmt.getLong(17));
				cuentaout.setCodigoSector(cstmt.getLong(18));
				cuentaout.setCodigoSubCategori(cstmt.getString(19));
				cuentaout.setIndicadorMultiUso(cstmt.getString(20));
				cuentaout.setIndicadorClientePotencial(cstmt.getString(21));
				cuentaout.setDescripcionRazonSocial(cstmt.getString(22));
				cuentaout.setFechaInicioVentaPac(cstmt.getDate(23));
				cuentaout.setCodigotipcomis(cstmt.getString(24));
				cuentaout.setNombreUsuarioAsesor(cstmt.getString(25));
				cuentaout.setFechaNacimiento(cstmt.getDate(26));
				
			}else{
				logger.error("Ocurrió un error al validar numero de identificacion de la cuenta");
				throw new GeneralException(String.valueOf(codError),numEvento, msgError);
			}
			
			
		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener la categoria de la cuenta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		logger.debug("Fin:getCategoriaCuenta()");
		return cuentaout;
	}//fin getCuentaAll	
	
}//fin CuentaDAO