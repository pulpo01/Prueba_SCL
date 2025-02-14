package com.tmmas.scl.doblecuenta.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.doblecuenta.businessobject.dao.interfaces.FacturaDAOIT;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.RetornoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;

public class FacturaDAO extends ConnectionDAO implements FacturaDAOIT {

	private final Logger logger = Logger.getLogger(FacturaDAO.class);
	//private final Global global = Global.getInstance();
	
	//private CompositeConfiguration config; // MA
	
	/*private void FacturaDAO() {
		setPropertieFile();
	}*/
	
	/*private void setPropertieFile() {
//		  inicio MA
		     String strRuta = "/com/tmmas/cl/DobleCuentaBo/properties/";
		     String srtRutaDeploy = System.getProperty("user.dir");
		     String strArchivoProperties= "DobleCuentaBo.properties";
		     String strArchivoLog="DobleCuentaBo.log";
		     String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
		     config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		     UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		     // fin MA           
	}*/
	
	
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

	private String getSQLobtenerConceptosAsociados() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("	TCONSULTACONCEPTOS FA_FACTURACION_DIF_SP_PG.ref_Cursor;");
		call.append(" BEGIN ");
		call.append("   FA_FACTURACION_DIF_SP_PG.FA_SEL_CONCEPTOS_PR( ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	

	private String getSQLinsertaFacturaDiferenciadaCabecera() {

		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("	EN_COD_CLICONTRA NUMBER;");
		call.append("	EN_COD_CLIASOC NUMBER;");
		call.append("	EN_NUMABONADO NUMBER;");
		call.append("	ED_FEC_INGRESO DATE;");
		call.append("	ED_FEC_CIERRE DATE;");
		call.append("	EN_COD_CICLO NUMBER;");
		call.append("	EN_TIP_OPERACION NUMBER;");
		call.append("	EN_TIP_MODALIDAD NUMBER;");
		call.append("	EN_TIP_VALOR NUMBER;");
		call.append("	EV_USUARIO VARCHAR2(200);");
		call.append(" BEGIN ");
		call.append("	FA_FACTURACION_DIF_SP_PG.FA_IN_FACTURACION_DIF_PR( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();
	}

	public String getSQLinsertaFacturaDiferenciadaDetalle(){

		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append("	FA_FACTURACION_DIF_SP_PG.FA_IN_DET_FACTURACION_DIF_PR( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();

	}

	public String getSQLupdateFacturaDiferenciada(){

		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append("	FA_FACTURACION_DIF_SP_PG.FA_UP_FACTURACION_DIF_PR ( ?, ?, ?, ?, ?, ?, ? );");
		call.append(" END;");
		return call.toString();
	}

	public String getSQLbajaMasivaFacturaDiferenciada(){

		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append("	FA_FACTURACION_DIF_SP_PG.FA_UP_FACTURACION_DIF_M_PR ( ?, ?, ?, ?, ? );");
		call.append(" END;");
		return call.toString(); 

	}


	/**
	 * Obtiene la lista de conceptos asociados para facturacion doble cuenta
	 * @author Matías Guajardo
	 * @return listaConcepFacturas
	 * 
	 */
	public ConceptoDTO[] obtenerListaConceptos() throws ProyectoException{

		logger.debug("obtenerListaConceptosDAO():start");
		System.out.println("entramos con exito obtenerListaConceptosDAO");

		int codError = 0;
		String msgError = null;
		int numEvento = 0; 
		ConceptoDTO[] listaConcepFacturas = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("com.tmmas.scl.dobleCuentaABE.ds"); // MA

			if(conn == null)
				throw new ProyectoException("No se pudo obtener una conexion a " + "com.tmmas.scl.dobleCuentaABE.ds");

		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProyectoException("No se pudo obtener una conexión", e1);
		}

		String call = getSQLobtenerConceptosAsociados();

		try{

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			logger.debug("recupero 1");
			cstmt.registerOutParameter(2, OracleTypes.NUMBER);
			logger.debug("recupero 2");
			cstmt.registerOutParameter(3, OracleTypes.VARCHAR);
			logger.debug("recupero 3");
			cstmt.registerOutParameter(4, OracleTypes.NUMBER);	
			logger.debug("recupero 4");

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			System.out.println("codError" + codError);

			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			System.out.println("msgError" + msgError);

			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			System.out.println("numEvento" + numEvento);

			if (codError != 0) {
				ProyectoException e = null;
				logger.error("Ocurrio un error al obtener lista de conceptos facturables");
				throw new ProyectoException("["+ msgError + "]",e);
			}	

			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(1);
			ArrayList listaConceptos = new ArrayList();
			while (rs.next()) {
				ConceptoDTO conceptos = new ConceptoDTO();
				conceptos.setCodConceptoOrig(rs.getLong(1));
				//logger.debug("codConceptoOrig " + rs.getLong(1));
				conceptos.setDescripcion(rs.getString(2));
				//logger.debug("descripcion " + rs.getString(2));
				listaConceptos.add(conceptos);
			}
			listaConcepFacturas = (ConceptoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaConceptos.toArray(), ConceptoDTO.class);

		}catch (Exception e) {
			e.printStackTrace();
			if (codError != 0) {
				throw new ProyectoException("["+ msgError + "]" ,e);
			}else{
				throw new ProyectoException("Ocurrió un error general al obtener lista de conceptos. " ,e);
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
		logger.debug("obtenerListaConceptosDAO():end");
		System.out.println("salimos con exito obtenerListaConceptosDAO");	
		return listaConcepFacturas;
	}

	/**
	 * Ingresar el alta de facturación diferenciada(CABECERA)
	 * @author Matías Guajardo
	 * @param factura, cliente , abonado
	 * @return respuesta
	 */
	public RetornoDTO insertaFacturacionDiferenciadaCabecera(FacturaDTO factura, ClienteDTO cliente) throws ProyectoException{

		logger.debug("insertaFacturacionDiferenciadaDAO():start");
		System.out.println("entramos con exito insertaFacturacionDiferenciadaDAO");

		int codError = 0;
		String msgError = null;
		int numEvento = 0; 
		RetornoDTO respuesta = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("com.tmmas.scl.dobleCuentaABE.ds"); // MA

			if(conn == null)
				throw new ProyectoException("No se pudo obtener una conexion a " + "getJndiForDataSource");

		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProyectoException("No se pudo obtener una conexión", e1);
		}

		String call = getSQLinsertaFacturaDiferenciadaCabecera();

		try{

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, cliente.getCodClienteContra());
			logger.debug("cliente contra" + cliente.getCodClienteContra());
			cstmt.setTimestamp(2, new Timestamp(factura.getFecIngRegistro().getTime()));
			logger.debug("fecha ingreso" + factura.getFecIngRegistro());
			cstmt.setDate(3, null);
			logger.debug("fecha cierre" + factura.getFecCieRegistro());
			cstmt.setLong(4, factura.getCodCiclo());
			logger.debug("cod ciclo" + factura.getCodCiclo());
			cstmt.setLong(5, factura.getTipOperación());
			logger.debug("tip operacion" + factura.getTipOperación());
			cstmt.setLong(6, factura.getTipModalidad());
			logger.debug("tip modalidad" + factura.getTipModalidad());
			cstmt.setLong(7, factura.getTipValor());
			logger.debug("tip valor" + factura.getTipValor());
			cstmt.setString(8, factura.getUser().toUpperCase().trim());
			logger.debug("User" + factura.getUser().toUpperCase().trim());

			cstmt.registerOutParameter(9, OracleTypes.NUMBER);
			logger.debug("recupero 9");
			cstmt.registerOutParameter(10, OracleTypes.NUMBER);
			logger.debug("recupero 10");
			cstmt.registerOutParameter(11, OracleTypes.VARCHAR);
			logger.debug("recupero 11");
			cstmt.registerOutParameter(12, OracleTypes.NUMBER);	
			logger.debug("recupero 12");

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(10);
			logger.debug("codError[" + codError + "]");
			System.out.println("codError" + codError);

			msgError = cstmt.getString(11);
			logger.debug("msgError[" + msgError + "]");
			System.out.println("msgError" + msgError);

			numEvento = cstmt.getInt(12);
			logger.debug("numEvento[" + numEvento + "]");
			System.out.println("numEvento" + numEvento);

			if (codError != 0) {
				ProyectoException e = null;
				logger.error("Ocurrio un error al insertar factura diferenciada (cabecera)");
				throw new ProyectoException("["+ msgError + "]",e);
			}

			//recuperamos respuesta
			respuesta = new RetornoDTO();
			long numSecEncabezadoFd = cstmt.getLong(9);
			logger.debug("numSecEncabezadoFd[" + numSecEncabezadoFd + "]");
			respuesta.setNumSecEncabezadoFd(numSecEncabezadoFd);
			respuesta.setDescripcion(msgError);
			if (codError != 0 ) {
				respuesta.setResultado(false);
			} else {
				respuesta.setResultado(true);
			}

			logger.debug("el msg de error despues de validacion es :" + msgError);
			logger.debug("el resultado final es :" + respuesta.getDescripcion());
			
		}catch (Exception e) {
			if (codError != 0) {
				throw new ProyectoException("["+ msgError + "]" ,e);
			}else{
				throw new ProyectoException("Ocurrió un error general al insertar factura diferenciada (cabecera). " ,e);
			}
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

		logger.debug("insertaFacturacionDiferenciadaDAO():end");
		System.out.println("salimos con exito insertaFacturacionDiferenciadaDAO");
		return respuesta;
	}

	/**
	 * Ingresar el alta de facturación diferenciada(DETALLE)
	 * @author Matias Guajardo
	 * @return respuesta
	 * @param factura, abonado, cliente
	 */

	public RetornoDTO insertarFacturacionDiferenciadaDetalle(FacturaDTO factura, AbonadoDTO abonado, ClienteDTO cliente, ConceptoDTO concepto) throws ProyectoException{

		logger.debug("insertarFacturacionDiferenciadaDetalleDAO():start");
		System.out.println("entramos con exito insertarFacturacionDiferenciadaDetalleDAO");

		int codError = 0;
		String msgError = null;
		int numEvento = 0; 
		RetornoDTO respuesta = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("com.tmmas.scl.dobleCuentaABE.ds"); // MA

			if(conn == null)
				throw new ProyectoException("No se pudo obtener una conexion a " + "getJndiDataSource");

		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProyectoException("No se pudo obtener una conexión", e1);
		}

		String call = getSQLinsertaFacturaDiferenciadaDetalle();

		try{

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, factura.getNumSecEncabezadoFd());
			logger.debug("num sec" + factura.getNumSecEncabezadoFd());
			cstmt.setLong(2, cliente.getCodClienteAsoc());
			logger.debug("cliente asoc" + cliente.getCodClienteAsoc());
			cstmt.setString(3, abonado.getNumAbonado());
			logger.debug("num abonado" + abonado.getNumAbonado());
			cstmt.setLong(4, concepto.getCodConceptoOrig());
			logger.debug("cod concepto" + concepto.getCodConceptoOrig());
			cstmt.setFloat(5, concepto.getMontoConcepto());
			logger.debug("monto concepto" + concepto.getMontoConcepto());
			cstmt.setTimestamp(6, new Timestamp(factura.getFecIngRegistro().getTime()));
			logger.debug("fecha ingreso" + new Timestamp(factura.getFecIngRegistro().getTime()));
			cstmt.setDate(7, null);
			logger.debug("fecha cierre" + factura.getFecCieRegistro());
			cstmt.setString(8, factura.getUser().toUpperCase().trim());
			logger.debug("usuario" + factura.getUser().toUpperCase().trim());

			cstmt.registerOutParameter(9, OracleTypes.NUMBER);
			logger.debug("recupero 10");
			cstmt.registerOutParameter(10, OracleTypes.NUMBER);
			logger.debug("recupero 11");
			cstmt.registerOutParameter(11, OracleTypes.VARCHAR);
			logger.debug("recupero 12");
			cstmt.registerOutParameter(12, OracleTypes.NUMBER);	
			logger.debug("recupero 13");

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(10);
			logger.debug("codError[" + codError + "]");
			System.out.println("codError" + codError);

			msgError = cstmt.getString(11);
			logger.debug("msgError[" + msgError + "]");
			System.out.println("msgError" + msgError);

			numEvento = cstmt.getInt(12);
			logger.debug("numEvento[" + numEvento + "]");
			System.out.println("numEvento" + numEvento);

			if (codError != 0) {
				ProyectoException e = null;
				logger.error("Ocurrio un error al insertar factura diferenciada (detalle)");
				throw new ProyectoException("["+ msgError + "]",e);
			}

			//recuperamos respuesta
			respuesta = new RetornoDTO();
			long numSecDet = cstmt.getLong(9);
			logger.debug("numSecDet[" + numSecDet + "]");
			respuesta.setNumSecDetalleFd(numSecDet);
			respuesta.setDescripcion(msgError);
			if (codError != 0 ) {
				respuesta.setResultado(false);
			} else {
				respuesta.setResultado(true);
			}
			logger.debug("el msg de error despues de validacion es :" + msgError);
			logger.debug("el resultado final es :" + respuesta.getDescripcion());
		
		}catch (Exception e) {
			if (codError != 0) {
				logger.debug("Ocurrió un error general al insertar factura diferenciada (detalle) ");
				throw new ProyectoException("["+ msgError + "]" ,e);
			}else{
				throw new ProyectoException("Ocurrió un error general al insertar factura diferenciada (detalle) " ,e);
			}
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
		logger.debug("insertaFacturacionDiferenciadaDetalleDAO():end");
		System.out.println("salimos con exito insertaFacturacionDiferenciadaDetalleDAO");
		return respuesta;

	}

	/**
	 * Update de facturación diferenciada (CABECERA)
	 * @author Matías Guajardo
	 * @param cliente, abonado, factura
	 * @return respuesta
	 */
	public RetornoDTO updateFacturacionDiferenciadaCabecera(ClienteDTO cliente, AbonadoDTO abonado, FacturaDTO factura) throws ProyectoException{

		logger.debug("updateFacturacionDiferenciadaCabeceraDAO():start");
		System.out.println("entramos con exito updateFacturacionDiferenciadaCabeceraDAO");

		int codError = 0;
		String msgError = null;
		int numEvento = 0; 
		RetornoDTO respuesta = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("com.tmmas.scl.dobleCuentaABE.ds"); // MA

			if(conn == null)
				throw new ProyectoException("No se pudo obtener una conexion a " + "getJndiDataSource");

		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProyectoException("No se pudo obtener una conexión", e1);
		}

		String call = getSQLupdateFacturaDiferenciada();

		try{

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, factura.getNumSecDetalleFd());
			logger.debug("num sec detalle" + factura.getNumSecDetalleFd());
			cstmt.setLong(2, cliente.getCodClienteAsoc());
			logger.debug("cod cliente asoc" + cliente.getCodClienteAsoc());
			cstmt.setString(3, abonado.getNumAbonado());
			logger.debug("num abonado" + abonado.getNumAbonado());
			cstmt.setString(4, factura.getUser().toUpperCase().trim());
			logger.debug("User" + factura.getUser().toUpperCase().trim());

			cstmt.registerOutParameter(5, OracleTypes.NUMBER);
			logger.debug("recupero 5");
			cstmt.registerOutParameter(6, OracleTypes.VARCHAR);
			logger.debug("recupero 6");
			cstmt.registerOutParameter(7, OracleTypes.NUMBER);	
			logger.debug("recupero 7");

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			System.out.println("codError" + codError);

			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			System.out.println("msgError" + msgError);

			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			System.out.println("numEvento" + numEvento);

			if (codError != 0) {
				ProyectoException e = null;
				logger.error("Ocurrio un error al hacer update factura diferenciada (detalle)");
				throw new ProyectoException("["+ msgError + "]",e);
			}

			//recuperamos respuesta
			respuesta = new RetornoDTO();
			respuesta.setDescripcion(msgError);
			if (codError != 0 ) {
				respuesta.setResultado(false);
			} else {
				respuesta.setResultado(true);
			}
			logger.debug("el msg de error despues de validacion es :" + msgError);
			logger.debug("el resultado final es :" + respuesta.getDescripcion());
			
		}catch (Exception e) {
			if (codError != 0) {
				logger.error("Ocurrió un error general al hacer update factura diferenciada (detalle)", e);
				throw new ProyectoException("["+ msgError + "]" ,e);
			}else{
				throw new ProyectoException("Ocurrió un error general al hacer update factura diferenciada (detalle). " ,e);
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
		logger.debug("updateFacturacionDiferenciadaDetalleDAO():end");
		System.out.println("salimos con exito updateFacturacionDiferenciadaDetalleDAO");
		return respuesta;
	}

	/**
	 * Baja masiva cliente contratante y sus abonados
	 * @param factura
	 * @return
	 * @throws ProyectoException
	 */
	public RetornoDTO bajaMasivaFacturacion(FacturaDTO factura) throws ProyectoException{

		logger.debug("bajaMasivaFacturacionDAO():start");
		System.out.println("entramos con exito bajaMasivaFacturacionDAO");

		int codError = 1;
		String msgError = null;
		int numEvento = 0; 
		RetornoDTO respuesta = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("com.tmmas.scl.dobleCuentaABE.ds"); // MA

			if(conn == null)
				throw new ProyectoException("No se pudo obtener una conexion a " + "getJndiDataSource");

		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProyectoException("No se pudo obtener una conexión", e1);
		}

		String call = getSQLbajaMasivaFacturaDiferenciada();

		try{

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setInt(1, (int) factura.getNumSecEncabezadoFd());
			logger.debug("num sec encabezado" + (int) factura.getNumSecEncabezadoFd());
			cstmt.setString(2, factura.getUser().toUpperCase().trim());
			logger.debug("User" + factura.getUser().toUpperCase().trim());

			cstmt.registerOutParameter(3, OracleTypes.NUMBER);
			logger.debug("recupero 3");
			cstmt.registerOutParameter(4, OracleTypes.VARCHAR);
			logger.debug("recupero 4");
			cstmt.registerOutParameter(5, OracleTypes.NUMBER);	
			logger.debug("recupero 5");

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			System.out.println("codError" + codError);

			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			System.out.println("msgError" + msgError);

			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			System.out.println("numEvento" + numEvento);

			if (codError != 0) {
				ProyectoException e = null;
				logger.error("Ocurrio un error al hacer baja masiva factura diferenciada");
				throw new ProyectoException("["+ msgError + "]",e);
			}

			//recuperamos respuesta
			respuesta = new RetornoDTO();
			respuesta.setDescripcion(msgError);
			if (codError != 0 ) {
				respuesta.setResultado(false);
			} else {
				respuesta.setResultado(true);
			}

			logger.debug("el msg de error despues de validacion es :" + msgError);
			logger.debug("el resultado final es :" + respuesta.getDescripcion());
			
		}catch (Exception e) {
			if (codError != 0) {
				logger.error("Ocurrió un error general al hacer baja masiva factura diferenciada ", e);
				throw new ProyectoException("["+ msgError + "]" ,e);
			}else{
				throw new ProyectoException("Ocurrió un error general al hacer baja masiva factura diferenciada. " ,e);
			}
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

		logger.debug("bajaMasivaFacturacionDAO():end");
		System.out.println("salimos con exito bajaMasivaFacturacionDAO");
		return respuesta;
	}


}
