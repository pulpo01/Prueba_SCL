package com.tmmas.scl.doblecuenta.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import oracle.jdbc.driver.OracleTypes;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.businessobject.dao.interfaces.ClienteDAOIT;
import com.tmmas.scl.doblecuenta.businessobject.helper.Global;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClientesAsociadosDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;

public class ClienteDAO extends ConnectionDAO implements ClienteDAOIT{

	private final Logger logger = Logger.getLogger(ClienteDAO.class);
	//private final Global global = Global.getInstance();
	
	private CompositeConfiguration config; // MA
	
	private void ClienteDAO() {
		setPropertieFile();
	}

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
	

	private String getSQLobtenerListaClientesAsociados() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("	EN_COD_CLIENTE NUMBER;");
		call.append("	EV_NUM_IDENT VARCHAR2(200);");
		call.append("	EV_NOM_CLIENTE VARCHAR2(200);");
		call.append("	EV_NOM_APECLIEN1 VARCHAR2(200);");
		call.append("	EV_NOM_APECLIEN2 VARCHAR2(200);");
		call.append("	EN_COD_CICLO NUMBER;");
		call.append("	SC_CLIENTES FA_FACTURACION_DIF_SP_PG.ref_cursor;");
		call.append(" BEGIN ");
		call.append("	FA_FACTURACION_DIF_SP_PG.FA_SEL_CLIENTES_PR( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	

	private String getSQLobtenerInformacionCliente() {
		StringBuffer call = new StringBuffer();

		//FA_SEL_CLI_CONTRATA_PR
		call.append(" DECLARE ");
		call.append("	EN_COD_CLIENTE_CONTRA NUMBER;");
		call.append("	SV_NOM_CLIENTE VARCHAR2(200);");
		call.append("	SV_COD_TIPIDENT VARCHAR2(200);");
		call.append("	SV_NUM_IDENT VARCHAR2(200);");
		call.append("	SN_COD_CUENTA NUMBER;");
		call.append("	SV_NOM_APECLIEN1 VARCHAR2(200);");
		call.append("	SV_NOM_APECLIEN2 VARCHAR2(200);");
		call.append("	SN_COD_CICLO NUMBER;");
		call.append("	SN_NUM_SEC_ENC NUMBER;");
		call.append("	SN_TIP_VALOR NUMBER;");
		call.append(" BEGIN ");
		call.append("	FA_FACTURACION_DIF_SP_PG.FA_SEL_CLI_CONTRATA_PR ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();	
	}

	private String getSQLbuscarClientesAsociados(){
		StringBuffer call = new StringBuffer();
		//FA_SEL_INFO_FD_PR
		call.append(" DECLARE ");
		call.append("	EN_COD_CLIENTE_CONTRA NUMBER;");
		call.append("	SC_INFO_FD FA_FACTURACION_DIF_SP_PG.ref_cursor;");
		call.append(" BEGIN ");
		call.append("	FA_FACTURACION_DIF_SP_PG.FA_SEL_INFO_FD_PR ( ?, ?, ?, ?, ? );");
		call.append(" END;");
		return call.toString();	
	}

	private String getSQLobtenerSecuencia() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_secuencia PV_SECUENCIA_QT := PV_INICIA_ESTRUCTURAS_PG.PV_SECUENCIA_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_secuencia.NOM_SECUENCIA := ?;");
		call.append("   PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR( eo_secuencia, ?, ?, ?);");
		call.append("   			? := eo_secuencia.NUM_SECUENCIA ;");
		call.append(" END;");
		return call.toString();		
	}	
	
	/**
	 * Obtiene la lista de clientes asociados
	 * @author Matías Guajardo
	 * @param cliente
	 * @return clientes
	 */
	public ClienteDTO[] obtenerListaClientesAsociados(ClienteDTO cliente) throws ProyectoException{

		logger.debug("obtenerListaClientesAsociadosDAO():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteDTO[] clientes = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLobtenerListaClientesAsociados();

		try {

			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("com.tmmas.scl.dobleCuentaABE.ds");//MA
			
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, cliente.getCodCliente());
			cstmt.setString(2, cliente.getNumIdent());
			cstmt.setString(3, cliente.getNomCliente());
			cstmt.setString(4, cliente.getNomApeClien1());
			cstmt.setString(5, cliente.getNomApeClien2());
			cstmt.setLong(6, cliente.getCodCiclo());
			
			cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.CURSOR);
			logger.debug("recupero 7");
			cstmt.registerOutParameter(8, OracleTypes.NUMBER);
			logger.debug("recupero 8");
			cstmt.registerOutParameter(9, OracleTypes.VARCHAR);
			logger.debug("recupero 9");
			cstmt.registerOutParameter(10, OracleTypes.NUMBER);	
			logger.debug("recupero 10");

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(8);
			logger.debug("codError[" + codError + "]");
			System.out.println("codError" + codError);

			msgError = cstmt.getString(9);
			logger.debug("msgError[" + msgError + "]");
			System.out.println("msgError" + msgError);

			numEvento = cstmt.getInt(10);
			logger.debug("numEvento[" + numEvento + "]");
			System.out.println("numEvento" + numEvento);

			if (codError != 0) {
				ProyectoException e = null;
				logger.error("Ocurrio un error al obtener lista de clientes asociados");
				throw new ProyectoException("["+ msgError + "]", e);
			}

			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(7);
			logger.debug("el rs es " + rs);
			ArrayList listaClientes = new ArrayList();
			while (rs.next()) {
				ClienteDTO lista = new ClienteDTO();
				lista.setCodCliente(rs.getLong(1));
				logger.debug("codcliente" + rs.getLong(1));
				lista.setNumIdent(rs.getString(2));
				logger.debug("numident" + rs.getString(2));
				lista.setNomCliente(rs.getString(3));
				logger.debug("nomcliente" + rs.getString(3));
				lista.setNomApeClien1(rs.getString(4));
				logger.debug("nomapeclien1" + rs.getString(4));
				lista.setNomApeClien2(rs.getString(5));
				logger.debug("nomapeclien2" + rs.getString(5));
				listaClientes.add(lista);
			}
			clientes = (ClienteDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaClientes.toArray(), ClienteDTO.class);
			
		}catch (Exception e) {
			if (codError != 0) {
				throw new ProyectoException("["+ msgError + "]" ,e);
			}else{
				throw new ProyectoException("Ocurrió un error general al obtener lista de clientes asociados. " ,e);
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
		logger.debug("obtenerListaClientesAsociadosDAO():end");
		return clientes;
	}


	/**
	 * Busca la informacion del cliente contratante
	 * @author Matias Guajardo
	 * @return cliente
	 * @param clienteContratante
	 */
	public ClienteDTO obtenerInformacionCliente(ClienteDTO clienteContratante) throws ProyectoException{

		logger.debug("obtenerInformacionClienteDAO():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteDTO cliente = new ClienteDTO();
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLobtenerInformacionCliente();

		try{
			logger.debug("]");
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("com.tmmas.scl.dobleCuentaABE.ds");//MA
			
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, clienteContratante.getCodClienteContra());

			cstmt.registerOutParameter(2, OracleTypes.VARCHAR);
			logger.debug("recupero 2");
			cstmt.registerOutParameter(3, OracleTypes.VARCHAR);
			logger.debug("recupero 3");
			cstmt.registerOutParameter(4, OracleTypes.VARCHAR);
			logger.debug("recupero 4");
			cstmt.registerOutParameter(5, OracleTypes.NUMBER);	
			logger.debug("recupero 5");
			cstmt.registerOutParameter(6, OracleTypes.VARCHAR);
			logger.debug("recupero 6");
			cstmt.registerOutParameter(7, OracleTypes.VARCHAR);
			logger.debug("recupero 7");
			cstmt.registerOutParameter(8, OracleTypes.NUMBER);	
			logger.debug("recupero 8");
			cstmt.registerOutParameter(9, OracleTypes.NUMBER);
			logger.debug("recupero 9");
			cstmt.registerOutParameter(10, OracleTypes.NUMBER);	
			logger.debug("recupero 10");
			cstmt.registerOutParameter(11, OracleTypes.NUMBER);	
			logger.debug("recupero 11");
			cstmt.registerOutParameter(12, OracleTypes.VARCHAR);
			logger.debug("recupero 12");
			cstmt.registerOutParameter(13, OracleTypes.NUMBER);	
			logger.debug("recupero 13");

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(11);
			logger.debug("codError[" + codError + "]");
			System.out.println("codError" + codError);

			msgError = cstmt.getString(12);
			logger.debug("msgError[" + msgError + "]");
			System.out.println("msgError" + msgError);

			numEvento = cstmt.getInt(13);
			logger.debug("numEvento[" + numEvento + "]");
			System.out.println("numEvento" + numEvento);

			if (codError != 0) {
				ProyectoException e = null;
				logger.error(" Ocurrió un error de aplicacion al obtener informacion del cliente");
				throw new ProyectoException("["+ msgError + "]",e);
			}
	
			logger.debug("Recuperando data...");

			String nomCliente = cstmt.getString(2);
			logger.debug("nomCliente[" + nomCliente + "]");

			String codTipIdent = cstmt.getString(3);
			logger.debug("codTipIdent[" + codTipIdent + "]");

			String numIdent = cstmt.getString(4);
			logger.debug("numIdent[" + numIdent + "]");

			long codCuenta = cstmt.getLong(5);
			logger.debug("codCuenta[" + codCuenta + "]");

			String nomApeClien1 = cstmt.getString(6);
			logger.debug("nomApeClien1[" + nomApeClien1 + "]");

			String nomApeClien2 = cstmt.getString(7);
			logger.debug("nomApeClien2[" + nomApeClien2 + "]");

			long codCiclo = cstmt.getLong(8);
			logger.debug("codCiclo[" + codCiclo + "]");
			
			long numSecuencia = cstmt.getLong(9);
			logger.debug("numSecuencia[" + numSecuencia + "]");
			
			long tipoValor = cstmt.getLong(10);
			logger.debug("tipoValor[" + tipoValor + "]");
			
			cliente.setNomCliente(nomCliente);
			cliente.setCodTipIdent(codTipIdent);
			cliente.setNumIdent(numIdent);
			cliente.setCodCuenta(codCuenta);
			cliente.setNomApeClien1(nomApeClien1);
			cliente.setNomApeClien2(nomApeClien2);
			cliente.setCodCiclo(codCiclo);
			cliente.setNumSecuencialCliente(numSecuencia);
			cliente.setTipoValor(String.valueOf(tipoValor));
		
		}catch (Exception e) {
			if (codError != 0) {
				throw new ProyectoException("["+ msgError + "]" ,e);
			}else{
				logger.error("Ocurrió un error general al obtener informacion de clientes contratantes. ", e);
				throw new ProyectoException("Ocurrió un error general al obtener informacion de clientes contratantes. " ,e);
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
		logger.debug("obtenerInformacionClienteDAO():end");
		return cliente;
	}
	
	/**
	 * Busca la relación clientes asociados y abonados con cliente contratante
	 * @author Matias Guajardo
	 * @param clienteContratante
	 * @return clientes
	 */
	public ClientesAsociadosDTO[] buscarClientesAsociados(ClienteDTO clienteContratante) throws ProyectoException{

		logger.debug("buscaClientesAsociadosDAO():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClientesAsociadosDTO[] clientes = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLbuscarClientesAsociados();

		try{

			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			conn = getConnectionDAO("com.tmmas.scl.dobleCuentaABE.ds");//MA
			
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, clienteContratante.getCodClienteContra());

			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			logger.debug("recupero 2");
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
				logger.error(" Ocurrió un error de aplicacion al buscar clientes asociados");
				throw new ProyectoException("["+ msgError + "]",e);
			}

			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList listaAsociados = new ArrayList();
			while (rs.next()) {
				ClientesAsociadosDTO listAsociados = new ClientesAsociadosDTO();
				AbonadoDTO abonado = new AbonadoDTO();
				ClienteDTO cliente = new ClienteDTO();
				ConceptoDTO concepto = new ConceptoDTO();
				FacturaDTO factura = new FacturaDTO();
				cliente.setCodClienteAsoc(rs.getLong(1));
				logger.debug("cod cliente asoc " + rs.getLong(1));
				cliente.setNomCliente(rs.getString(2));
				logger.debug("nom cliente " + rs.getString(2));
				abonado.setNumAbonado(rs.getString(3));
				logger.debug("num abonado " + rs.getString(3));
				abonado.setNumCelular(rs.getString(4));
				logger.debug("num celular " + rs.getString(4));
				factura.setUser(rs.getString(5));
				logger.debug("user " + rs.getString(5));
				concepto.setCodConceptoOrig(rs.getLong(6));
				logger.debug("cod concepto " + rs.getLong(6));
				concepto.setDescripcion(rs.getString(7));
				logger.debug("descripcion " + rs.getString(7));
				concepto.setMontoConcepto(rs.getFloat(8));
				logger.debug("monto " + rs.getFloat(8));
				factura.setNumSecDetalleFd(rs.getLong(9));
				logger.debug("num secuencia " + rs.getLong(9));
				listAsociados.setAbonado(abonado);
				listAsociados.setCliente(cliente);
				listAsociados.setConcepto(concepto);
				listAsociados.setFactura(factura);
				listaAsociados.add(listAsociados);
			}
			
			clientes = (ClientesAsociadosDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaAsociados.toArray(), ClientesAsociadosDTO.class);
		
		}catch (Exception e) {
			if (codError != 0) {
				throw new ProyectoException("["+ msgError + "]" ,e);
			}else{
				logger.error("Ocurrió un error general al buscar clientes asociados", e);
				throw new ProyectoException("Ocurrió un error general al buscar clientes asociados. " ,e);
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
		logger.debug("buscaClientesAsociadosDAO():end");
		return clientes;
	}

	/**
	 * Recupera valor de una secuencia
	 * 
	 * @param secuencia
	 * @return SecuenciaDTO
	 * @throws CustomerOrderException
	 */
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws ProyectoException{
		logger.debug("obtenerSecuencia():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SecuenciaDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerSecuencia();

		try {
			//conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			conn = getConnectionDAO("com.tmmas.scl.dobleCuentaABE.ds");//MA
			
			logger.debug("secuencia.getNomSecuencia()[" + secuencia.getNomSecuencia() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, secuencia.getNomSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //NUM_SECUENCIA
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener el número de secuencia");
				throw new ProyectoException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			long numSecuencia = cstmt.getLong(5);
			logger.debug("numSecuencia[" + numSecuencia + "]");
			
			respuesta = secuencia;
			respuesta.setNumSecuencia(numSecuencia);
			
		} catch (ProyectoException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al obtener el número de secuencia", e);
			throw new ProyectoException("Ocurrió un error general al obtener el número de secuencia",e);
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
		logger.debug("obtenerSecuencia():end");
		return respuesta;	
	}
	
}
