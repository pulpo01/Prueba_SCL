/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtebo.helper.Global;
import com.tmmas.cl.framework20.util.ServiceLocator;

public class DireccionDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements DireccionDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(DireccionDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public DireccionDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Entrega el tipo de dirección, el código de dirección y las descripción
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO consultarCodigoDireccion(com.tmmas.gte.integraciongtecommon.dto.ConsDirecDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarDireccionXCodCliente:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONSULTARDIRECCLIENTE_PR(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codSujeto[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.DireccionDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.DireccionDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(5));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			logger.info("Recuperando cursor..");
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(2);
			java.util.List lista2 = new java.util.ArrayList();

			logger.info("Recuperando cursor2:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.DireccionDTO dto2 = new com.tmmas.gte.integraciongtecommon.dto.DireccionDTO();

				dto2.setCodTipDireccion(rs.getString("cod_tipdireccion"));
				logger.debug("CodTipDireccion[" + dto2.getCodTipDireccion() + "]");

				dto2.setCodDireccion(""+rs.getInt("cod_direccion"));
				logger.debug("CodDireccion[" + dto2.getCodDireccion() + "]");

				dto2.setDesTipDireccion(rs.getString("des_tipdireccion"));
				logger.debug("DesTipDireccion[" + dto2.getDesTipDireccion() + "]");

				
				lista2.add(dto2);
			}
			logger.info("Recuperando cursor2:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor2 en clase de salida....");
			outParam0.setLstlistadoDireciones((com.tmmas.gte.integraciongtecommon.dto.DireccionDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista2.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.DireccionDTO.class));

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarDireccionXCodCliente:end()");
		return outParam0;
	}

	/**
	* Entrega el tipo de dirección y el código de dirección
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO consultarCodigoDireccion(com.tmmas.gte.integraciongtecommon.dto.ConsDirecTipoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarDireccionXCodClienteTipo:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DireccionDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DireccionDTO();
		com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO outParamSalida = new com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO();
		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONSULTARDIRECCLIENTE_PR(?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setString(2,inParam0.getTipDireccion());
			logger.debug("tipDireccion[" + inParam0.getTipDireccion() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(5));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(6));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(7));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				java.util.List lista3 = new java.util.ArrayList();
				outParamSalida.setLstlistadoDireciones((com.tmmas.gte.integraciongtecommon.dto.DireccionDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista3.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.DireccionDTO.class));
				outParamSalida.setRespuesta(outParam1);
				return outParamSalida;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParamSalida.setRespuesta(outParam1);

			outParam0.setCodTipDireccion(cstmt.getString(3));
			logger.debug("codTipDireccion[" + outParam0.getCodTipDireccion() + "]");

			outParam0.setCodDireccion(cstmt.getString(4));
			logger.debug("codDireccion[" + outParam0.getCodDireccion() + "]");
			
			java.util.List lista3 = new java.util.ArrayList();
			lista3.add(outParam0);
			
			outParamSalida.setLstlistadoDireciones((com.tmmas.gte.integraciongtecommon.dto.DireccionDTO[])
			com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista3.toArray(),
									com.tmmas.gte.integraciongtecommon.dto.DireccionDTO.class));

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarDireccionXCodClienteTipo:end()");
		return outParamSalida;
	}	
	
	
	/**
	* Entrega un DireccionDTO con los datos
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionDTO consultarDireccion(com.tmmas.gte.integraciongtecommon.dto.DireccionInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarDireccion:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DireccionDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DireccionDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_consultarDireccion_PR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodDireccion());
			logger.debug("codDireccion[" + inParam0.getCodDireccion() + "]");

			cstmt.setString(2,inParam0.getCodTipDireccion());
			logger.debug("tipDireccion[" + inParam0.getCodTipDireccion() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
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
			cstmt.registerOutParameter(24,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(26,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(27,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(25));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(26));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(27));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setCodTipoCalle(cstmt.getString(3));
			logger.debug("codTipoCalle[" + outParam0.getCodTipoCalle() + "]");

			outParam0.setCodTipDireccion(cstmt.getString(4));
			logger.debug("codTipDireccion[" + outParam0.getCodTipDireccion() + "]");

			outParam0.setDesTipDireccion(cstmt.getString(5));
			logger.debug("desTipDireccion[" + outParam0.getDesTipDireccion() + "]");

			outParam0.setCodDireccion(cstmt.getString(6));
			logger.debug("codDireccion[" + outParam0.getCodDireccion() + "]");

			outParam0.setCodProvincia(cstmt.getString(7));
			logger.debug("codProvincia[" + outParam0.getCodProvincia() + "]");

			outParam0.setDesProvincia(cstmt.getString(8));
			logger.debug("desProvincia[" + outParam0.getDesProvincia() + "]");

			outParam0.setCodRegion(cstmt.getString(9));
			logger.debug("codRegion[" + outParam0.getCodRegion() + "]");

			outParam0.setDesRegion(cstmt.getString(10));
			logger.debug("desRegion[" + outParam0.getDesRegion() + "]");

			outParam0.setCodCiudad(cstmt.getString(11));
			logger.debug("codCiudad[" + outParam0.getCodCiudad() + "]");

			outParam0.setDesCuidad(cstmt.getString(12));
			logger.debug("desCuidad[" + outParam0.getDesCuidad() + "]");

			outParam0.setCodComuna(cstmt.getString(13));
			logger.debug("codComuna[" + outParam0.getCodComuna() + "]");

			outParam0.setDesComuna(cstmt.getString(14));
			logger.debug("desComuna[" + outParam0.getDesComuna() + "]");

			outParam0.setNomCalle(cstmt.getString(15));
			logger.debug("nomCalle[" + outParam0.getNomCalle() + "]");

			outParam0.setNumCalle(cstmt.getString(16));
			logger.debug("numCalle[" + outParam0.getNumCalle() + "]");

			outParam0.setNumCasilla(cstmt.getString(17));
			logger.debug("numCasilla[" + outParam0.getNumCasilla() + "]");

			outParam0.setObsDirecc(cstmt.getString(18));
			logger.debug("obsDirecc[" + outParam0.getObsDirecc() + "]");

			outParam0.setZip(cstmt.getString(19));
			logger.debug("zip[" + outParam0.getZip() + "]");

			outParam0.setDesDirec1(cstmt.getString(20));
			logger.debug("desDirec1[" + outParam0.getDesDirec1() + "]");

			outParam0.setDesDirec2(cstmt.getString(21));
			logger.debug("desDirec2[" + outParam0.getDesDirec2() + "]");

			outParam0.setCodPueblo(cstmt.getString(22));
			logger.debug("codPueblo[" + outParam0.getCodPueblo() + "]");

			outParam0.setCodEstado(cstmt.getString(23));
			logger.debug("codEstado[" + outParam0.getCodEstado() + "]");

			outParam0.setNumPiso(cstmt.getString(24));
			logger.debug("numPiso[" + outParam0.getNumPiso() + "]");

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarDireccion:end()");
		return outParam0;
	}

}