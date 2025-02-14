package com.tmmas.scl.wsventaenlace.businessobject.dao;

import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import com.tmmas.scl.wsventaenlace.businessobject.dao.helper.DAOHelper;
import com.tmmas.scl.wsventaenlace.businessobject.dao.helper.JUnitConexion;
import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.transport.vo.OOSSVO;


public class UtilesDAO extends BaseDAO {
	
	private static final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName(); 
	private GlobalProperties global = GlobalProperties.getInstance();
	private DAOHelper daoHelper = DAOHelper.getInstance();
	

	public void imprimirPropiedades(Class clazz, Object obj, String metodo) {
		try {
			PropertyDescriptor[] pd = Introspector.getBeanInfo(clazz).getPropertyDescriptors();
	        for (int i = 0; i < pd.length; i++) {
	              System.out.println(pd[i].getReadMethod().getName()+": "+pd[i].getReadMethod().invoke(obj, null));
	              logger.info("DAO ["+this.getClass().getName()+"] METODO["+metodo+"] CLASE["+clazz.getName()+"] "+ pd[i].getReadMethod().getName()+": "+pd[i].getReadMethod().invoke(obj, null), nombreClase);
	        }
		}catch(Exception e){
			
		}
	}
	
	public void actualizaTransacabo(OOSSVO oossvo) throws ServicioVentasEnlaceException{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.debug("actualizaTransacabo():start",nombreClase);
		try {
			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else{
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			String call = daoHelper.getPackageBD("PV_VENTAS_ENLACE_VPN_PG", "PV_ACT_TRANSACABO_PR",6);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL["+ call + "]",nombreClase);
			logger.debug("NumId: "+oossvo.getNumId(),nombreClase);
			logger.debug("CodError: "+oossvo.getCodError(),nombreClase);
			logger.debug("DesError: "+oossvo.getDesError(),nombreClase);
			cstmt.setLong(1,Long.parseLong(oossvo.getNumId()));
			cstmt.setInt(2,Integer.parseInt(oossvo.getCodError()));
			cstmt.setString(3,oossvo.getDesError());
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			
			logger.debug(" Iniciando Ejecución",nombreClase);
			logger.debug("Execute Antes",nombreClase);
			cstmt.execute();
			logger.debug("Execute Despues",nombreClase);
			logger.debug(" Finalizo ejecución",nombreClase);
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError[" + codError + "]",nombreClase);
			logger.debug("msgError[" + msgError + "]",nombreClase);
			logger.debug("numEvento[" + numEvento + "]",nombreClase);
			//TODO cambiar error
			daoHelper.evaluaResultado("ERR.0000",codError,	global.getValor("ERR.0000"));
		} catch (Exception e) {
	    	if (!(e instanceof ServicioVentasEnlaceException)) {
				logger.error(e,nombreClase);
				logger.debug("Codigo de Error[" + codError + "]",nombreClase);
				logger.debug("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.debug("Numero de Evento[" + numEvento + "]",nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0078",78,global.getValor("ERR.0078"));
	    	}else throw (ServicioVentasEnlaceException)e;
	 	} finally {
			logger.debug("Cerrando conexiones...",nombreClase);
			try {
				if (cstmt != null) 
					cstmt.close();
				if (conn!=null && !conn.isClosed()) 
					conn.close();
			} catch (SQLException e) {
				logger.debug("SQLException[" + e + "]",nombreClase);
			}
		}
		logger.debug("actualizaTransacabo():end",nombreClase);
	}

}
