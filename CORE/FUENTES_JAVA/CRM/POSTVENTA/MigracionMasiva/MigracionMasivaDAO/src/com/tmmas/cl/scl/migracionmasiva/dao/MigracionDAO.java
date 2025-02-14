package com.tmmas.cl.scl.migracionmasiva.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.Global;
import com.tmmas.cl.scl.migracionmasiva.dto.WSDatosEntradaDTO;
import com.tmmas.cl.scl.migracionmasiva.dto.WSDatosSalidaDTO;
import com.tmmas.cl.scl.migracionmasiva.helper.GlobalProperties;
import com.tmmas.cl.scl.migracionmasiva.helper.LoggerHelper;


public class MigracionDAO extends ConnectionDAO {
	 private final LoggerHelper logger = LoggerHelper.getInstance();
	 private final String nombreClase = this.getClass().getName();
	 GlobalProperties global = GlobalProperties.getInstance();
	 	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", nombreClase);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConection
	
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin 
	
	
	
	public WSDatosSalidaDTO insertoDatosMigracion(WSDatosEntradaDTO datosDTO) throws GeneralException{
		int codError = 0;
		WSDatosSalidaDTO resultado = null;
	
		resultado= new WSDatosSalidaDTO();
		
				
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insertoDatosMigracion",nombreClase);
			
			String call = getSQLDatos("PV_DATOS_ABONADO_PG","PV_GENERA_SOLICMIGRAR_PR",10);

			logger.debug("sql[" + call + "]",nombreClase);
			
			/*
			 * 
			 *                                          
             PROCEDURE PV_GENERA_SOLICMIGRAR_PR (     
                                         EN_COD_CLIENTE        IN  GA_ABOCEL.COD_CLIENTE%TYPE, 
                                         EV_COD_PLANTARIF    IN  GA_ABOCEL.COD_PLANTARIF%TYPE, 
                                         EV_NUM_CELULAR      IN  GA_ABOCEL.NUM_CELULAR%TYPE, 
                                         EV_USER                      IN  GA_ABOCEL.NOM_USUARORA%TYPE, 
                                         EV_SERIE                     IN  AL_SERIES.NUM_SERIE%TYPE, 
                                         EV_PROCEDENCIA      IN  GA_ABOCEL.IND_PROCEQUI%TYPE, 
                                         EV_SALDO                   IN  GA_DATABONADO_TO.CADENA%TYPE, 
                                         SN_cod_retorno            OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE, 
                                         SV_mens_retorno         OUT NOCOPY   ge_errores_td.det_msgerror%TYPE, 
                                         SN_num_evento           OUT NOCOPY   ge_errores_pg.evento); 

			 */

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, datosDTO.getCodCliente());
			cstmt.setString(2, datosDTO.getCodPlanTarif());
			cstmt.setString(3, datosDTO.getNumCelular());
			cstmt.setString(4, datosDTO.getNomUsuario());
			cstmt.setString(5, datosDTO.getImei());
			cstmt.setString(6, datosDTO.getIndProcedencia());
			cstmt.setString(7, datosDTO.getSaldo());
						

			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insertoDatosMigracion:execute",nombreClase);
			cstmt.execute();
			logger.debug("Fin:insertoDatosMigracion:execute",nombreClase);

			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			logger.debug("Cod Error: "+codError,nombreClase);
			logger.debug("Msg Error: "+msgError,nombreClase);
			logger.debug("Num Evento: "+numEvento,nombreClase);
			if (codError !=0){
				resultado = new WSDatosSalidaDTO();
				resultado.setCodError(cstmt.getString(8));
				resultado.setDescError(cstmt.getString(9));
				resultado.setNroEvento(cstmt.getString(10));
				
			}else{
				resultado = new WSDatosSalidaDTO();
				resultado.setCodError("0");
			}
			
			logger.debug("msgError[" + msgError + "]",nombreClase);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar los datos: "+e.getMessage(),nombreClase);
			
				codError=10111;
				msgError=e.getMessage();
				numEvento=0;
				resultado.setCodError("10111");
				resultado.setDescError(msgError);
				resultado.setNroEvento("0");
				logger.debug("Codigo de Error[" + codError + "]",nombreClase);
				logger.debug("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.debug("Numero de Evento[" + numEvento + "]",nombreClase);
		} finally {
		 	if (codError!=0) 
		 		logger.debug("Cerrando conexiones...",nombreClase);
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException: "+e.getStackTrace(),nombreClase);
			}
		}

		logger.debug("Fin:insertoDatosMigracion",nombreClase);

		return resultado;
	}
}
