package com.tmmas.scl.doblecuenta.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.businessobject.dao.interfaces.AbonadoDAOIT;
import com.tmmas.scl.doblecuenta.businessobject.helper.Global;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AbonadoDAO extends ConnectionDAO implements AbonadoDAOIT {

	private final Logger logger = Logger.getLogger(AbonadoDAO.class);
	//private final Global global = Global.getInstance();
	
	private CompositeConfiguration config; // MA
	
	private void setPropertieFile() {
//		  inicio MA
		     String strRuta = "/com/tmmas/cl/DobleCuentaBo/properties/";
		     String srtRutaDeploy = System.getProperty("user.dir");
		     String strArchivoProperties= "DobleCuentaBo.properties";
		     String strArchivoLog="DobleCuentaBo.log";
		     String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
		     config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		     UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		     // fin MA           
	}
	
	
	private Connection getConnectionDAO(String strDataSource)
    throws Exception {
		Context ctx = null;
		ctx = new InitialContext();
		DataSource ds = null;
		logger.debug("parameters.getJndiDataSource() ["+ strDataSource +"]");
		try {
		ds = ( DataSource ) ctx.lookup( strDataSource);
		}catch (Exception e ) {
		logger.debug("[getConnectionDAO][Conexion]" + e.getMessage());
		throw e;
	}
	Connection conn = null;
	conn = ds.getConnection();        
	return conn;
	}

	
	private void AbonadoDAO() {
		setPropertieFile();
	}
	

	private String getSQLobtenerListaAbonados() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("	EN_NUM_CELULAR NUMBER;");
		call.append("	SC_ABONADOS FA_FACTURACION_DIF_SP_PG.ref_cursor;");
		call.append(" BEGIN ");
		call.append("	FA_FACTURACION_DIF_SP_PG.FA_SEL_ABONADOS_PR ( ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	

	/**
	 * Obtiene lista de abonados según criterio de búsqueda.
	 * @author Matías Guajardo U.
	 * @param cliente
	 * @return abonadosList
	 */
	public AbonadoDTO[] obtenerListaAbonado(AbonadoDTO abonado) throws ProyectoException{

		logger.debug("obtenerListaAbonadosDAO():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO[] abonados = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLobtenerListaAbonados();

		try {

			logger.debug("");
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("com.tmmas.scl.dobleCuentaABE.ds"); // MA
			
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, abonado.getCodCliente());
			logger.debug("el cod cliente contratante en el DAO es..." + abonado.getCodCliente());
			cstmt.setString(2, abonado.getNumCelular());
			logger.debug("el numcelular que obtengo en el DAO es..." + abonado.getNumCelular());
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);
			logger.debug("recupero 3");
			cstmt.registerOutParameter(4, OracleTypes.NUMBER);
			logger.debug("recupero 4");
			cstmt.registerOutParameter(5, OracleTypes.VARCHAR);
			logger.debug("recupero 5");
			cstmt.registerOutParameter(6, OracleTypes.NUMBER);	
			logger.debug("recupero 6");

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			System.out.println("codError" + codError);

			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			System.out.println("msgError" + msgError);

			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			System.out.println("numEvento" + numEvento);

			if (codError != 0) {
				ProyectoException e = null;
				logger.error("Ocurrio un error al obtener lista de abonados");
				throw new ProyectoException("["+ msgError + "]",e);
			}	

			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(3);
			ArrayList listaAbonados = new ArrayList();
			while (rs.next()) {
				AbonadoDTO abonadoRs = new AbonadoDTO();
				abonadoRs.setCodUsuario(rs.getString(1));
				logger.debug("codUsuario " + rs.getString(1));
				abonadoRs.setNomUsuario(rs.getString(2));
				logger.debug("setNomUsuario" + rs.getString(2));
				abonadoRs.setNomApellido1(rs.getString(3));
				logger.debug("nomapellido1" + rs.getString(3));
				abonadoRs.setNomApellido2(rs.getString(4));
				logger.debug("nomapellido2" + rs.getString(4));
				abonadoRs.setNumCelular(rs.getString(5));
				logger.debug("numcelular" + rs.getString(5));
				abonadoRs.setNumAbonado(rs.getString(6));
				logger.debug("numabonado" + rs.getString(6));
				listaAbonados.add(abonadoRs);
			}
			abonados = (AbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaAbonados.toArray(), AbonadoDTO.class);

		}catch (Exception e) {
			if (codError != 0) {
				logger.error("Ocurrió un error general al obtener lista de abonados", e);
				throw new ProyectoException("["+ msgError + "]" ,e);
			}else{
				throw new ProyectoException("Ocurrió un error general al obtener lista de abonados. " ,e);
			}
		}finally {
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
		logger.debug("obtenerListaAbonadosDAO():end");
		return abonados;
	}




}
