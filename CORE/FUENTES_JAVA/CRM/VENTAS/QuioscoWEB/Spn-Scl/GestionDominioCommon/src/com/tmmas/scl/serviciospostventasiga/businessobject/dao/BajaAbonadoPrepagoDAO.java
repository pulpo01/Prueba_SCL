package com.tmmas.scl.serviciospostventasiga.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.serviciospostventasiga.businessobject.dao.helper.ConnectionHelper;
import com.tmmas.scl.serviciospostventasiga.common.helper.Global;
import com.tmmas.scl.serviciospostventasiga.common.helper.ServiciosPostVentaSigaLoggerHelper;
import com.tmmas.scl.serviciospostventasiga.transport.AbonadoVtaDTO;

public class BajaAbonadoPrepagoDAO extends ConnectionDAO{
	
	private Global global = Global.getInstance();
	private ConnectionHelper helper = new ConnectionHelper();
	
	private ServiciosPostVentaSigaLoggerHelper logger = ServiciosPostVentaSigaLoggerHelper.getInstance();
	private String nombreClase = this.getClass().getName();

	/*
	 * valida que el abonado este migrado en GA_ABOCEL
	 * y que en GA_ABOAMIST el abonado este en situacion
	 * AAA
	 */
	public Boolean getAbonadoMigrado(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getAbonadoMigrado():Inicio",nombreClase);
		Boolean resultado = new Boolean(false);
		Integer existe = null;
		String codError = null;
		String msgError = null;
		Integer numEvento = null;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = helper.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_ABONADO_MIG_PR", 5);
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, abonadoVtaDTO.getNumAbonado().longValue());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = new Integer(cstmt.getInt(5));
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			if(codError.equals("0"))
			{
				existe = new Integer(cstmt.getInt(2));
				if(existe.intValue() == 1)
				{
					resultado = new Boolean(true);
				}
				else
				{
					resultado = new Boolean(false);
				}
			}
			else
			{
				throw new GeneralException("ERR.00025",25,global.getValor("ERR.00025"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.00025",25,global.getValor("ERR.00025"));
			}else throw (GeneralException)e;	

		}finally{
			logger.debug("Cerrando conexiones...",nombreClase);
			try {
				if (rs != null) rs.close(); 
				if (cstmt != null) cstmt.close();
				if (conn!=null && !conn.isClosed())	conn.close();	
			} catch (SQLException e) {
				logger.error("ERROR: ", nombreClase);
				logger.error("SQLException[" + e + "]",nombreClase);
			}
		}
		logger.info("getAbonadoMigrado():Fin",nombreClase);
		return resultado;
	}
	
	/*
	 * Obtiene la causa de baja del prepago que opto
	 * a postpago
	 */
	
	public String getCausaBaja()throws GeneralException
	{
		logger.info("getCausaBaja():Inicio",nombreClase);
		String resultado = null;
		String codError = null;
		String msgError = null;
		Integer numEvento = null;
		Connection conn = null;
		//conn = getConection();
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = helper.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_CAUSA_BAJA_PR", 4);
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = new Integer(cstmt.getInt(4));
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			if(codError.equals("0"))
			{
				resultado = cstmt.getString(1);
			}
			else
			{
				throw new GeneralException(codError,Integer.parseInt(codError),msgError); //TODO revisar
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.0000",0,global.getValor("ERR.0000")); //TODO revisar
			}else throw (GeneralException)e;	

		}finally{
			logger.debug("Cerrando conexiones...",nombreClase);
			try {
				if (rs != null) rs.close(); 
				if (cstmt != null) cstmt.close();
				if (conn!=null && !conn.isClosed())	conn.close();	
			} catch (SQLException e) {
				logger.error("ERROR: ", nombreClase);
				logger.error("SQLException[" + e + "]",nombreClase);
			}
		}
		logger.info("getCausaBaja():Fin",nombreClase);
		return resultado;
	}
	/*
	 * da de baja los servicios suplementarios del abonado prepago
	 */
	public void bajaServSuplabo(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("bajaServSuplabo():Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = helper.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_BAJA_SERVSUPL_PR", 4);
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, abonadoVtaDTO.getNumAbonado().longValue());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			if(!"0".equalsIgnoreCase(codError))
			{
				throw new GeneralException("ERR.00028",28,global.getValor("ERR.00028"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.00028",28,global.getValor("ERR.00028"));
			}else throw (GeneralException)e;	

		}finally{
			logger.debug("Cerrando conexiones...",nombreClase);
			try {
				if (rs != null) rs.close(); 
				if (cstmt != null) cstmt.close();
				if (conn!=null && !conn.isClosed())	conn.close();	
			} catch (SQLException e) {
				logger.error("ERROR: ", nombreClase);
				logger.error("SQLException[" + e + "]",nombreClase);
			}
		}
		logger.info("bajaServSuplabo():Fin",nombreClase);
	}
	/*
	 * elimina los servicios suplementarios asociados
	 * al numero celular del abonado prepago a dar de baja
	 */
	public void elimServSuplAmist(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("elimServSuplAmist():Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		Integer numEvento = null;
		Connection conn = null;
		//conn = getConection();
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = helper.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_ELI_SERVS_AMIST_PR", 4);
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, abonadoVtaDTO.getNumCelular());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = new Integer(cstmt.getInt(4));
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			if(!codError.equals("0"))
			{
				throw new GeneralException(codError,Integer.parseInt(codError),msgError);//TODO REVISAR
			}

		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.0000",0,global.getValor("ERR.0000")); //TODO REVISAR
			}else throw (GeneralException)e;	

		}finally{
			logger.debug("Cerrando conexiones...",nombreClase);
			try {
				if (rs != null) rs.close(); 
				if (cstmt != null) cstmt.close();
				if (conn!=null && !conn.isClosed())	conn.close();	
			} catch (SQLException e) {
				logger.error("ERROR: ", nombreClase);
				logger.error("SQLException[" + e + "]",nombreClase);
			}
		}
		logger.info("elimServSuplAmist():Fin",nombreClase);
	}
	
	/*
	 * metodo que da de baja un abonado prepago dejando
	 * su estado en BAA
	 */
	public void updAbonadoPrepago(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		System.out.println("updAbonadoPrepago():Inicio");
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			
			
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = helper.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_BAJA_PREPAGO_PR", 6);
			cstmt = conn.prepareCall(call);
			
			System.out.println("abonadoVtaDTO.getNumAbonado(): [" + abonadoVtaDTO.getNumAbonado() + "]");
			cstmt.setLong(1, abonadoVtaDTO.getNumAbonado().longValue());
			
			System.out.println("abonadoVtaDTO.getCodCausaBaja(): [" + abonadoVtaDTO.getCodCausaBaja() + "]");
			cstmt.setString(2, abonadoVtaDTO.getCodCausaBaja());
			
			System.out.println("abonadoVtaDTO.getCodSituacion(): [" + abonadoVtaDTO.getCodSituacion() + "]");
			cstmt.setString(3, abonadoVtaDTO.getCodSituacion());
			
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getString(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if(!codError.endsWith("0"))
			{
				throw new GeneralException("ERR.00026",26,global.getValor("ERR.00026"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.00026",26,global.getValor("ERR.00026"));
			}else throw (GeneralException)e;	

		}finally{
			logger.debug("Cerrando conexiones...",nombreClase);
			try {
				if (rs != null) rs.close(); 
				if (cstmt != null) cstmt.close();
				if (conn!=null && !conn.isClosed())	conn.close();	
			} catch (SQLException e) {
				logger.error("ERROR: ", nombreClase);
				logger.error("SQLException[" + e + "]",nombreClase);
			}
		}
		System.out.println("updAbonadoPrepago():Fin");
	}
	
	//obtiene el numero del abonado en ga_aboamist
	public void getNumAbonadoAboamist(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getNumAbonadoAboamist():Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try{
			JndiForDataSource jndi = new JndiForDataSource();
			jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

						conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = helper.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_DATOS_ABONADO_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("abonadoVtaDTO.getNumCelular(): " + abonadoVtaDTO.getNumCelular(),nombreClase);
			cstmt.setLong(1, abonadoVtaDTO.getNumCelular());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);


			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento =cstmt.getInt(5);
			
			

			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);

			if(codError.equals("0"))
			{
				rs = (ResultSet)cstmt.getObject(2);
				if(rs.next())
				{
					abonadoVtaDTO.setNumAbonado(new Long(rs.getLong(5)));
				}
			}
//			TODO faltra excepcion
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.0000",0,global.getValor("ERR.0000"));//TODO REVISAR
			}else throw (GeneralException)e;	

		}finally{
			logger.debug("Cerrando conexiones...",nombreClase);
			try {
				if (rs != null) rs.close(); 
				if (cstmt != null) cstmt.close();
				if (conn!=null && !conn.isClosed())	conn.close();	
			} catch (SQLException e) {
				logger.error("ERROR: ", nombreClase);
				logger.error("SQLException[" + e + "]",nombreClase);
			}
		}
		logger.info("getNumAbonadoAboamist():Fin",nombreClase);
	}
}
