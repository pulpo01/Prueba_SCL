/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 08/06/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.CuentaDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteTipoPlanListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SubCuentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SubCuentaListDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;

public class CuentaDAO extends ConnectionDAO implements CuentaDAOIT {
	private final Logger logger = Logger.getLogger(ClienteDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLobtenerDatosClienteCuenta() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cliente.COD_CUENTA := ?;");
		call.append("   PV_CUENTA_PG.PV_OBTIENE_CLIENTE_CUENTA_PR( eo_cliente, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLobtenerSubCuentas() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   eo_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cliente.COD_CUENTA := ?;");
		call.append("   PV_CUENTA_PG.PV_OBTIENE_SUBCUENTA_CUENTA_PR( eo_cliente, ?, ?, ?, ?);");
		call.append(" END;");
		
		return call.toString();		
	}	
	
	/**
	 * Obtiene lista de clientes por cuenta
	 * 
	 * @param cliente
	 * @return ClienteTipoPlanListDTO
	 * @throws CustomerException
	 */	
	public ClienteTipoPlanListDTO obtenerDatosClienteCuenta(ClienteDTO cliente) throws CustomerException{
		logger.debug("obtenerDatosClienteCuenta():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteTipoPlanListDTO clientes = null;
		ClienteDTO[] clientesPrepago = null;
		ClienteDTO[] clientesPospago = null;
		ClienteDTO[] clientesHibrido = null;
		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerDatosClienteCuenta();
		try {
		
			logger.debug("cuenta.getCodCuenta()[" + cliente.getCodCuenta() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, cliente.getCodCuenta());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener lista de clientes por cuenta");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			logger.debug("Recuperando cursor prepago...");
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			logger.debug("Recuperando cursor pospago...");
			ResultSet rspos = (ResultSet) cstmt.getObject(3);			
			logger.debug("Recuperando cursor hibrido...");
			ResultSet rshib = (ResultSet) cstmt.getObject(4);			
			
			clientes = new ClienteTipoPlanListDTO();
			
			ArrayList listaPrepago = new ArrayList();
			while (rs.next()) {
				ClienteDTO clientePrepago = new ClienteDTO();

				clientePrepago.setCodCliente(rs.getLong(1));
				logger.debug("codCliente[" + clientePrepago.getCodCliente() + "]");
				
				clientePrepago.setNombres(rs.getString(2));
				logger.debug("nombre[" + clientePrepago.getNombres() + "]");
				
				clientePrepago.setCodCiclo(rs.getInt(3));
				logger.debug("codCiclo[" + clientePrepago.getCodCiclo() + "]");
				
				clientePrepago.setCodCuenta(rs.getLong(4));
				logger.debug("codCuenta[" + clientePrepago.getCodCuenta() + "]");
				
				clientePrepago.setApellido1(rs.getString(5));
				logger.debug("Apellido1[" + clientePrepago.getApellido1() + "]");
				
				clientePrepago.setApellido2(rs.getString(6));
				logger.debug("Apellido2[" + clientePrepago.getApellido2() + "]");
				
				clientePrepago.setNumeroIdentificacion(rs.getString(7));
				logger.debug("NumeroIdentificacion[" + clientePrepago.getNumeroIdentificacion() + "]");
				
				clientePrepago.setCodigoTipoIdentificacion(rs.getString(8));
				logger.debug("CodigoTipoIdentificacion[" + clientePrepago.getCodigoTipoIdentificacion() + "]");
				
				String nombreCompleto = " ";
				if (clientePrepago.getNombres()  !=null) nombreCompleto = clientePrepago.getNombres().trim() + " ";
				if (clientePrepago.getApellido1()!=null) nombreCompleto = nombreCompleto + clientePrepago.getApellido1().trim() + " ";
				if (clientePrepago.getApellido2()!=null) nombreCompleto = nombreCompleto + clientePrepago.getApellido2().trim();
				
				clientePrepago.setNombreCompleto(nombreCompleto);
				logger.debug("NombreCompleto[" + clientePrepago.getNombreCompleto() + "]");
				
				listaPrepago.add(clientePrepago);
			}
			clientesPrepago = (ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaPrepago.toArray(), ClienteDTO.class);
			
			ArrayList listaPospago = new ArrayList();
			while (rspos.next()) {
				ClienteDTO clientePospago = new ClienteDTO();

				clientePospago.setCodCliente(rspos.getLong(1));
				logger.debug("codCliente[" + clientePospago.getCodCliente() + "]");
				
				clientePospago.setNombres(rspos.getString(2));
				logger.debug("nombre[" + clientePospago.getNombres() + "]");
				
				clientePospago.setCodCiclo(rspos.getInt(3));
				logger.debug("codCiclo[" + clientePospago.getCodCiclo() + "]");
				
				clientePospago.setCodCuenta(rspos.getLong(4));
				logger.debug("codCuenta[" + clientePospago.getCodCuenta() + "]");
				
				clientePospago.setApellido1(rspos.getString(5));
				logger.debug("Apellido1[" + clientePospago.getApellido1() + "]");
				
				clientePospago.setApellido2(rspos.getString(6));
				logger.debug("Apellido2[" + clientePospago.getApellido2() + "]");
				
				clientePospago.setNumeroIdentificacion(rspos.getString(7));
				logger.debug("NumeroIdentificacion[" + clientePospago.getNumeroIdentificacion() + "]");
				
				clientePospago.setCodigoTipoIdentificacion(rspos.getString(8));
				logger.debug("CodigoTipoIdentificacion[" + clientePospago.getCodigoTipoIdentificacion() + "]");
				
				String nombreCompleto = " ";
				if (clientePospago.getNombres()  !=null) nombreCompleto = clientePospago.getNombres().trim() + " ";
				if (clientePospago.getApellido1()!=null) nombreCompleto = nombreCompleto + clientePospago.getApellido1().trim() + " ";
				if (clientePospago.getApellido2()!=null) nombreCompleto = nombreCompleto + clientePospago.getApellido2().trim();
				
				clientePospago.setNombreCompleto(nombreCompleto);
				logger.debug("NombreCompleto[" + clientePospago.getNombreCompleto() + "]");
				
				listaPospago.add(clientePospago);
			}
			clientesPospago = (ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaPospago.toArray(), ClienteDTO.class);
			
			ArrayList listaHibrido = new ArrayList();
			while (rshib.next()) {
				ClienteDTO clienteHibrido = new ClienteDTO();

				clienteHibrido.setCodCliente(rshib.getLong(1));
				logger.debug("codCliente[" + clienteHibrido.getCodCliente() + "]");
				
				clienteHibrido.setNombres(rshib.getString(2));
				logger.debug("nombre[" + clienteHibrido.getNombres() + "]");
				
				clienteHibrido.setCodCiclo(rshib.getInt(3));
				logger.debug("codCiclo[" + clienteHibrido.getCodCiclo() + "]");
				
				clienteHibrido.setCodCuenta(rshib.getLong(4));
				logger.debug("codCuenta[" + clienteHibrido.getCodCuenta() + "]");
				
				clienteHibrido.setApellido1(rshib.getString(5));
				logger.debug("Apellido1[" + clienteHibrido.getApellido1() + "]");
				
				clienteHibrido.setApellido2(rshib.getString(6));
				logger.debug("Apellido2[" + clienteHibrido.getApellido2() + "]");
				
				clienteHibrido.setNumeroIdentificacion(rshib.getString(7));
				logger.debug("NumeroIdentificacion[" + clienteHibrido.getNumeroIdentificacion() + "]");
				
				clienteHibrido.setCodigoTipoIdentificacion(rshib.getString(8));
				logger.debug("CodigoTipoIdentificacion[" + clienteHibrido.getCodigoTipoIdentificacion() + "]");
				
				String nombreCompleto = " ";
				if (clienteHibrido.getNombres()  !=null) nombreCompleto = clienteHibrido.getNombres().trim() + " ";
				if (clienteHibrido.getApellido1()!=null) nombreCompleto = nombreCompleto + clienteHibrido.getApellido1().trim() + " ";
				if (clienteHibrido.getApellido2()!=null) nombreCompleto = nombreCompleto + clienteHibrido.getApellido2().trim();
				
				clienteHibrido.setNombreCompleto(nombreCompleto);
				logger.debug("NombreCompleto[" + clienteHibrido.getNombreCompleto() + "]");
				
				listaHibrido.add(clienteHibrido);
			}			
			clientesHibrido = (ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaHibrido.toArray(), ClienteDTO.class);			
			
			clientes.setClientesPrepago(clientesPrepago);			
			clientes.setClientesPospago(clientesPospago);
			clientes.setClientesHibrido(clientesHibrido);
			rs.close();
			rspos.close();
			rshib.close();
		
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de clientes por cuenta", e);
			throw new CustomerException("Ocurrió un error al obtener lista de clientes por cuenta",e);
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
		logger.debug("obtenerDatosClienteCuenta():end");
		return clientes;				
	}
	
	/**
	 * Obtiene lista de subcuentas de la cuenta
	 * 
	 * @param cliente
	 * @return SubCuentaListDTO
	 * @throws CustomerException
	 */	
	public SubCuentaListDTO obtenerSubCuentas(ClienteDTO cliente) throws CustomerException{
		logger.debug("obtenerSubCuentas():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SubCuentaListDTO subCuentaList = null;
		SubCuentaDTO[] subCuentas = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerSubCuentas();
		try {
		
			logger.debug("cliente.getCodCuenta()[" + cliente.getCodCuenta() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, cliente.getCodCuenta());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);			
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);	
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener lista de subcuentas");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				SubCuentaDTO subCuenta = new SubCuentaDTO();

				subCuenta.setCodCuenta(rs.getLong(1));
				subCuenta.setCodSubCuenta(rs.getString(2));
				subCuenta.setDesSubCuenta(rs.getString(3));

				logger.debug("codCuenta[" + subCuenta.getCodCuenta() + "]");
				logger.debug("codSubCuenta[" + subCuenta.getCodSubCuenta() + "]");
				logger.debug("desSubCuenta[" + subCuenta.getDesSubCuenta() + "]");
				
				lista.add(subCuenta);
			}
			
			subCuentas = (SubCuentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SubCuentaDTO.class);
			subCuentaList = new SubCuentaListDTO();
			subCuentaList.setListaSubCuentas(subCuentas);		
			rs.close();
		
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de subcuentas", e);
			throw new CustomerException("Ocurrió un error al obtener lista de subcuentas",e);
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
		logger.debug("obtenerSubCuentas():end");
		return subCuentaList;		
	}
}
