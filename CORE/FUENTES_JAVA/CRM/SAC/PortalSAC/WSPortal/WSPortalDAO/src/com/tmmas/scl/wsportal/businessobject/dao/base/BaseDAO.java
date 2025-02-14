/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */

package com.tmmas.scl.wsportal.businessobject.dao.base;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.configuration.CompositeConfiguration;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.wsportal.businessobject.dao.helper.DAOHelper;
import com.tmmas.scl.wsportal.businessobject.dao.helper.ConexionJUnit;
import com.tmmas.scl.wsportal.businessobject.dao.helper.JndiHelper;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public abstract class BaseDAO extends ConnectionDAO
{

	private static final String CLAVE_GE_JNDI_DATA_SOURCE_DAO = "GE.jndi.dataSource.DAO";

	private static final String CLAVE_GE_PRUEBAS_UNITARIAS_GE = "GE.pruebas.unitarias.GE";

	private static final String PROPERTIES_INTERNO = "com/tmmas/scl/wsportal/properties/WSPortalDAO.properties";

	private static final String PROPERTIES_EXTERNO = "WSPortalDAO.properties";

	protected static JndiHelper jndiHelper = JndiHelper.getInstance();

	protected static final String NOMBRE_PACKAGE_BD_CONSULTAS = "PV_CONSULTAS_PORTAL_PG";
	
	protected static final String NOMBRE_PACKAGE_BD_CONSULTA_DIRECCIONES = "GE_CONSULTADIRECCION_PG";
	
	protected static final String NOMBRE_PACKAGE_BD_REALM = "PV_CONSULTAS_USER_WLOGIC_PG";
	
	protected static final String NOMBRE_PACKAGE_BD_ATENCION = "PV_ATENCION_PG";

	protected static final String MENSAJE_INICIO_LOG = "Inicio";

	protected static final String MENSAJE_FIN_LOG = "Fin";

	protected static CompositeConfiguration config = UtilProperty.getConfiguration(PROPERTIES_EXTERNO,
			PROPERTIES_INTERNO);

	private static final String JNDI_DATA_SOURCE_DAO = config.getString(CLAVE_GE_JNDI_DATA_SOURCE_DAO);

	private static final String GE_PRUEBAS_UNITARIAS_GE = config.getString(CLAVE_GE_PRUEBAS_UNITARIAS_GE);

	protected static final String COD_ERROR = config.getString("COD.ERR_SAC.1000");

	protected static final String DES_ERROR = config.getString("DES.ERR_SAC.1000");

	protected DAOHelper daoHelper = new DAOHelper();

	/**
	 * Procesar exception.
	 * 
	 * @param e the e
	 * 
	 * @return the portal sac exception
	 */
	protected static PortalSACException procesarException(Exception e)
	{
		PortalSACException pe = e instanceof PortalSACException ? (PortalSACException) e : new PortalSACException(
				COD_ERROR, DES_ERROR, e);
		return pe;
	}

	/**
	 * Obtiene el valor de connection.
	 * 
	 * @return the connection
	 * 
	 * @throws Exception the exception
	 * @throws SQLException the SQL exception
	 */
	protected Connection obtenerConnection() throws Exception, SQLException
	{
		Connection conn;
		if (GE_PRUEBAS_UNITARIAS_GE.equals("0"))
		{
			final JndiForDataSource jndiForDataSource = jndiHelper.getJndiForDataSource(JNDI_DATA_SOURCE_DAO);
			conn = getConnectionFromWLSInitialContext(jndiForDataSource);
		}
		else
		{
			ConexionJUnit conexion = new ConexionJUnit();
			conn = conexion.conexionBD();
		}
		return conn;
	}

	/**
	 * Cerrar recursos.
	 * 
	 * @param conn the conn
	 * @param cstmt the cstmt
	 * @param rs TODO
	 * @throws SQLException the SQL exception
	 */
	protected void cerrarRecursos(Connection conn, CallableStatement cstmt, ResultSet rs) throws SQLException
	{
		if (cstmt != null)
		{
			cstmt.close();
		}
		if (conn != null && !conn.isClosed())
		{
			conn.close();
		}
		if (rs != null)
		{
			rs.close();
		}
	}
	
	/**
	 * Cerrar recursos.
	 * 
	 * @param conn the conn
	 * @param cstmt the cstmt
	 * @throws SQLException the SQL exception
	 */
	protected void cerrarRecursos(Connection conn, CallableStatement cstmt) throws SQLException
	{
		if (cstmt != null)
		{
			cstmt.close();
		}
		if (conn != null && !conn.isClosed())
		{
			conn.close();
		}
	}

}
