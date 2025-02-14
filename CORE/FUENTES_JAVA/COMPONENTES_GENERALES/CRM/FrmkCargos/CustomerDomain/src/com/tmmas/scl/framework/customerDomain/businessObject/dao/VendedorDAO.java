package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.VendedorDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DireccionDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;


public class VendedorDAO extends ConnectionDAO implements VendedorDAOIT{
	private final Logger logger = Logger.getLogger(VendedorDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerBillException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerBillException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}
	
	private String getSQLDatosVendedor(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	
	public VendedorDTO getVendedor(VendedorDTO vendedor) throws CustomerBillException{
		logger.debug("getVendedor:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosVendedor("VE_PARAMETROS_COMERCIALES_PG","VE_datosvendedor_PR",15);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			logger.debug("vendedor.getCodigoVendedor()["+vendedor.getCodigoVendedor()+"]");
			cstmt.setInt(1,Integer.parseInt(vendedor.getCodigoVendedor()));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes"+ vendedor.getCodigoVendedor());
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(13);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(14);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(15);
			logger.debug("numEvento[" + numEvento + "]");
	
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar el Vendedor");
				throw new CustomerBillException(
						"Ocurrió un error al consultar el vendedor", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				logger.debug("Llenado Vendedor");
				vendedor.setNombreVendedor(cstmt.getString(2));
				vendedor.setCodigoCliente(String.valueOf(cstmt.getInt(3)));
				vendedor.setCodigoVendedorRaiz(cstmt.getLong(4));
				vendedor.setCodigoVendedorDealer(cstmt.getLong(5));
				DireccionDTO direccion = new DireccionDTO();
				direccion.setRegion(cstmt.getString(6));
				direccion.setProvincia(cstmt.getString(7));
				direccion.setCiudad(cstmt.getString(8));
				vendedor.setDireccion(direccion);
				vendedor.setCodigoOficina(cstmt.getString(9));
				vendedor.setCodTipComisionista(cstmt.getString(10));
				vendedor.setDesTipComisionista(cstmt.getString(11));
				vendedor.setIndicadorTipoVenta(cstmt.getInt(12));
				logger.debug("Fin Llenado Vendedor");
			}
			if (vendedor.getCodigoVendedor() == null) {
				msgError = "No se pudo rescatar la Información";
				logger.error("Ocurrió un error al consultar el Vendedor");
				throw new CustomerBillException(
						"Ocurrió un error al consultar el vendedor", String
								.valueOf(codError), numEvento, msgError);
			}
			
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el vendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerBillException(
					"Ocurrió un error al consultar el vendedor",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("getVendedor():end");

		return vendedor;
		}

	/*public DatosValidacionDTO getVendedorNumero(ParametrosValidacionVentasDTO entradaVendedorNumero) throws CustomerDomainException{
		DatosValidacionDTO resultado = new DatosValidacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:getVendedorNumero()");
			
			String call = getSQLDatosVendedor("VE_validacion_linea_PG","VE_vendedor_numero_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,Long.parseLong(entradaVendedorNumero.getNumeroCelular()));
			cstmt.setLong(2,Long.parseLong(entradaVendedorNumero.getCodigoCliente()));
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getVendedorNumero:execute");
			cstmt.execute();
			logger.debug("Fin:getVendedorNumero:execute");

			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");

			resultado.setVendedorNumeroValido(cstmt.getInt(2));
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener vendedor reserva numero",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		
		logger.debug("Fin:getVendedorNumero");

		return resultado;
		
	}*/
	
/*	public ResultadoValidacionVentaDTO getExisteVendedorEnBodegaSimcard(ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getExisteVendedorEnBodegaSimcard");
			
			String call = getSQLDatosVendedor("VE_validacion_linea_PG","VE_vendedorbodega_PR",6);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entradaValidacionVentas.getCodigoVendedor());
			cstmt.setString(2,entradaValidacionVentas.getCodigoBodega());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getExisteVendedorEnBodegaSimcard:execute");
			cstmt.execute();
			logger.debug("Fin:getExisteVendedorEnBodegaSimcard:execute");

			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");

			if (cstmt.getInt(3)==1)
				logger.debug("VENDEDOR <<< EXISTE >>> EN BODEGA");
			else
				logger.debug("VENDEDOR <<< NO EXISTE >>> EN BODEGA");

			resultado.setResultadoBase(cstmt.getInt(3));
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al buscar vendedor en bodega (simcard)",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getExisteVendedorEnBodegaSimcard");

		return resultado;
	}//fin getExisteVendedorEnBodegaSimcard*/

/*	public ResultadoValidacionVentaDTO getExisteVendedorEnBodegaTerminal(ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getExisteVendedorEnBodegaTerminal");
			
			String call = getSQLDatosVendedor("VE_validacion_linea_PG","VE_vendedorbodega_PR",6);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entradaValidacionVentas.getCodigoVendedor());
			cstmt.setString(2,entradaValidacionVentas.getCodigoBodega());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getExisteVendedorEnBodegaTerminal:execute");
			cstmt.execute();
			logger.debug("Fin:getExisteVendedorEnBodegaTerminal:execute");

			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");

			if (cstmt.getInt(3)==1)
				logger.debug("VENDEDOR <<< EXISTE >>> EN BODEGA");
			else
				logger.debug("VENDEDOR <<< NO EXISTE >>> EN BODEGA");

			resultado.setResultadoBase(cstmt.getInt(3));
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al buscar vendedor en bodega (terminal)",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getExisteVendedorEnBodegaTerminal");

		return resultado;
	}//fin getExisteVendedorEnBodegaTerminal*/

	/*public void setBloqueaDesbloqueaVendedor(VendedorDTO vendedor) throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:setBloqueaDesbloqueaVendedor");
			
			String call = getSQLDatosVendedor("VE_intermediario_PG","VE_bloqdesbloq_vendedor_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,vendedor.getCodigoVendedor());
			cstmt.setString(2,vendedor.getCodigoAccionBloqueo());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:setBloqueaDesbloqueaVendedor:execute");
			cstmt.execute();
			logger.debug("Fin:setBloqueaDesbloqueaVendedor:execute");

			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");

			if (cstmt.getInt(3)==0) 
				logger.debug("OPERACION SOBRE EL VENDEDOR <"+ vendedor.getCodigoVendedor() +"> OK ["+ vendedor.getCodigoAccionBloqueo()+" ]");
			else
				logger.debug("OPERACION SOBRE EL VENDEDOR <"+ vendedor.getCodigoVendedor() +"> NO OK ["+ vendedor.getCodigoAccionBloqueo()+" ]");
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al bloquear/desbloquear el vendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:setBloqueaDesbloqueaVendedor");

	}//fin getExisteVendedorEnBodegaTerminal*/

	/*public ResultadoValidacionVentaDTO validaCodigoVendedor(VendedorDTO vendedordto) throws CustomerDomainException{
		boolean resultado = false;
		int codError = 0;
		String msgError = null;
		ResultadoValidacionVentaDTO resultadovalidacion = new ResultadoValidacionVentaDTO();
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:validaCodigoVendedor");
			String call = getSQLDatosVendedor("PV_SERVICIOS_POSVENTA_PG","VE_valida_codigo_vendedor_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(vendedordto.getCodigoVendedor()));
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			int res = cstmt.getInt(2);
			resultado = res==1?true:false;
			String mensaje = res==1?"Validacion exitosa":"No se puede ejecutar, usuario no es vendedor"; 
			resultadovalidacion.setResultado(resultado);
			resultadovalidacion.setMensajeValidacion(mensaje);
			
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
		
		} catch (Exception e) {
			logger.error("Ocurrió un error en validaCodigoVendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:validaCodigoVendedor");
		return resultadovalidacion;
	}//fin validaCodigoVendedor*/
	
   
	// Verifica si un vendedor es externo
	public VendedorDTO verificaVendedorEsExterno (VendedorDTO vendedor) throws CustomerBillException{
		logger.debug("verificaVendedorEsExterno:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		//conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosVendedor("PV_SERVICIOS_POSVENTA_PG","VE_es_vendedor_externo_PR",5);
			logger.debug("sql[" + call + "]");
			conn=getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(vendedor.getCodigoVendedor()));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes"+ vendedor.getCodigoVendedor());
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			if (codError!=0){
				throw new CustomerBillException(String.valueOf(codError),numEvento,msgError);
			}
			else{
				int res = cstmt.getInt(2);
				boolean resultado = res==1?true:false;
				vendedor.setVendedorInterno(!resultado);	
			}
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al consultar el vendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerBillException("Ocurrió un error al consultar el vendedor",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("verificaVendedorEsExterno():end");
		return vendedor;
	}
	/**
	 * Obtiene rango de descuentos asignados al vendedor
	 * @param vendedor
	 * @return vendedor
	 * @throws CustomerDomainException
	 */
	/*public VendedorDTO getRangoDescuento(VendedorDTO vendedor) throws CustomerBillException{
		logger.debug("getRangoDescuento():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosVendedor("PV_SERVICIOS_POSVENTA_PG","VE_con_rango_descto_vend_PR",9);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(vendedor.getCodigoVendedor()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes"+ vendedor.getCodigoVendedor());
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(7);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(8);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(9);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError == 0){
				vendedor.setPuntoDesctoInferior(cstmt.getFloat(2));
				vendedor.setPuntoDesctoSuperior(cstmt.getFloat(3));
				vendedor.setPorcentajeDesctoInferior(cstmt.getFloat(4));
				vendedor.setPorcentajeDesctoSuperior(cstmt.getFloat(5));
				vendedor.setAplicaDescuento(cstmt.getInt(6)==1 ? true:false);
			}
			else
				vendedor.setAplicaDescuento(false);
	
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}

		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el rango de descuento del vendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerBillException(
					"Ocurrió un error al consultar el rango de descuento del vendedor",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("getRangoDescuento():end");

		return vendedor;
		}*/
	
	/**
	 * Obtiene listado de tipos de comisionistas
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws CustomerDomainException
	 */
	/*public VendedorDTO[] getListTiposComisionistas() 
	throws CustomerDomainException{
		logger.debug("Inicio:getListTiposComisionistas()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosVendedor("VE_alta_cliente_PG","VE_getListTipComisionistas_PR",4);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListTiposComisionistas:execute");
			cstmt.execute();
			logger.debug("Fin:getListTiposComisionistas:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar tipos de comisionistas");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar tipos de comisionistas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando categorias");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					VendedorDTO vendedorDTO = new VendedorDTO();
					vendedorDTO.setCodTipComisionista(rs.getString(1));
					vendedorDTO.setDesTipComisionista(rs.getString(2));
					lista.add(vendedorDTO);
				}
				rs.close();
				resultado =(VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), VendedorDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar tipos de comisionistas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getListTiposComisionistas()");
		return resultado;
	}//fin getListTiposComisionistas	*/

	
}//fin VendedorDAO


