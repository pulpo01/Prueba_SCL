package com.tmmas.scl.wsventaenlace.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.wsventaenlace.businessobject.dao.helper.DAOHelper;
import com.tmmas.scl.wsventaenlace.businessobject.dao.helper.JUnitConexion;
import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.transport.vo.ventaenlace.VentaEnlaceE1VO;

public class ValidacionesVentaEnlaceE1DAO extends ConnectionDAO {

	private static final LoggerHelper logger = LoggerHelper.getInstance();
	private static final String nombreClase = ValidacionesVentaEnlaceE1DAO.class.getName();
	private GlobalProperties global =  GlobalProperties.getInstance();
	private DAOHelper daoHelper = new DAOHelper();
	private UtilesDAO utilesDAO = new UtilesDAO();
	
	
	/**
	 * Valida numero piloto activo.
	 * Paquete: PV_SUSPENSION_SERVICIO_VPN_PG
	 * Procedimiento: PV_VALIDA_PILOTO_ACTIVO_PR
	 * Tabla a consultar: GA_NRO_PILOTO_RANGO_TO
	 * @param suspensionVoluntariaVPNVO
	 * @throws ProyectoException
	 * @author Santiago Ventura
	 */
	public void validaNumeroPilotoActivo(VentaEnlaceE1VO ventaEnlaceE1VO) throws ServicioVentasEnlaceException {
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.debug("validaNumeroPilotoActivo():start", nombreClase);
		try {
			if (global.getValor("GE.pruebas.unitarias.GE")==null)
				throw new ServicioVentasEnlaceException("ERR.0003", 3, global.getValor("ERR.0003"));
			if (global.getValor("GE.pruebas.unitarias.GE").equals("0"))
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
			else{
				JUnitConexion conexion = new JUnitConexion();
				conn = conexion.conexionBD();
			}
			
			utilesDAO.imprimirPropiedades(ventaEnlaceE1VO.getClass(), ventaEnlaceE1VO, "validaNumeroPilotoActivo");
			String call = daoHelper.getPackageBD("PV_SUSPENSION_SERVICIO_VPN_PG","PV_VALIDA_PILOTO_ACTIVO_PR",5);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL["+ call + "]", nombreClase);
			
			cstmt.setLong(1,ventaEnlaceE1VO.getAbonadoVO().getNumCelular().longValue());
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			
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

			daoHelper.evaluaResultado("ERR.0701",codError,global.getValor("ERR.0701"));
			
			logger.debug("Parametros...", nombreClase);			
			ventaEnlaceE1VO.setPilotoActivo(false);
			if (cstmt.getInt(2)>0) {
				ventaEnlaceE1VO.setPilotoActivo(true);
			}
			logger.debug("...Parametros", nombreClase);						
			
		} catch (Exception e) 	{
			e.printStackTrace();
			
			if (!(e instanceof ServicioVentasEnlaceException)) 	{				
				logger.error(global.getValor("ERR.0002"), nombreClase);
				logger.error(e, nombreClase);
				logger.error("Codigo de Error[" + codError + "]", nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]", nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]", nombreClase);
				throw new ServicioVentasEnlaceException("ERR.0002",2,global.getValor("ERR.0002"));
			}
			else 
				throw (ServicioVentasEnlaceException)e;

		} 
		finally {
			logger.info("Cerrando conexiones...", nombreClase);
			
			try {
				if (cstmt != null) 
					cstmt.close();
				
				if (conn != null && !conn.isClosed()) 
					conn.close();
				
			} 
			catch (SQLException e){
				logger.error("SQLException[" + e.getMessage() + "]", nombreClase);
			}
		}
		logger.debug("validaNumeroPilotoActivo():end", nombreClase);
	}
}
