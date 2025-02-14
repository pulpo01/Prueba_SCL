package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ConceptosCobranzaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;

public class ConceptosCobranzaDAO extends ConnectionDAO{

	private static Category cat = Category.getInstance(ConceptosCobranzaDAO.class);
	Global global = Global.getInstance();
	
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}//fin getConection
	
	private String getSQLPackage(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}//fin getSQLPackage
	
    /**
	 * Obtiene descripcion codigo 123
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ConceptosCobranzaDTO getDescripcion123(ConceptosCobranzaDTO parametroEntrada) 
	throws GeneralException{
		ConceptosCobranzaDTO resultado=new ConceptosCobranzaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getDescripcion123");
			
			//INI-01 (AL) String call = getSQLPackage("CO_servicios_cobranza_PG","CO_getDescCodigo123_PR",5);
			String call = getSQLPackage("CO_servicios_cobranza_Quiosco_PG","CO_getDescCodigo123_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigo123());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDescripcion123:execute");
			cstmt.execute();
			cat.debug("Fin:getDescripcion123:execute");

			codError  = cstmt.getInt(3);
			msgError  = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener descripcion codigo 123");
				throw new GeneralException(
				"Ocurrió un error al obtener descripcion codigo 123", String
				.valueOf(codError), numEvento, msgError);
			}
			else{				
				resultado.setDescripcion123(cstmt.getString(2));
				cat.debug("resultado.getDescripcion123 ["+resultado.getDescripcion123()+"]" );
			}
		
		} catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener descripcion codigo 123",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getDescripcion123");
		return resultado;
	}//fin getDescripcion123
	
    /**
	 * Obtiene descripcion codigo ABC
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ConceptosCobranzaDTO getDescripcionABC(ConceptosCobranzaDTO parametroEntrada) 
	throws GeneralException{
		ConceptosCobranzaDTO resultado=new ConceptosCobranzaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getDescripcionABC");
			
			//INI-01 (AL) String call = getSQLPackage("CO_servicios_cobranza_PG","CO_getDescCodigoABC_PR",5);
			String call = getSQLPackage("CO_servicios_cobranza_quiosco_PG","CO_getDescCodigoABC_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoABC());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDescripcionABC:execute");
			cstmt.execute();
			cat.debug("Fin:getDescripcionABC:execute");

			codError  = cstmt.getInt(3);
			msgError  = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener descripcion codigo ABC");
				throw new GeneralException(
				"Ocurrió un error al obtener descripcion codigo ABC", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setDescripcion123(cstmt.getString(2));
				cat.debug("resultado.getDescripcion123 ["+resultado.getDescripcion123()+"]" );
			}
		
		} catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener descripcion codigo ABC",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getDescripcionABC");
		return resultado;
	}//fin getDescripcionABC

    /**
	 * Inserta pago automatico
	 * @param parametroEntrada
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insPagoAutomatico(ConceptosCobranzaDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:insPagoAutomatico");
			
			//INI-01 (AL) String call = getSQLPackage("CO_servicios_cobranza_PG","CO_insPagoAutomatico_PR",9);
			String call = getSQLPackage("CO_servicios_cobranza_quiosco_PG","CO_insPagoAutomatico_PR",9);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoCliente());
			cat.debug("entrada.getCodigoCliente(): " + entrada.getCodigoCliente());
			cstmt.setString(2,entrada.getCodigoBanco());
			cat.debug("entrada.getCodigoBanco(): " + entrada.getCodigoBanco());
			cstmt.setString(3,entrada.getNumeroTelefono());
			cat.debug("entrada.getNumeroTelefono(): " + entrada.getNumeroTelefono());
			cstmt.setString(4,entrada.getCodigoZona());
			cat.debug("entrada.getCodigoZona(): " + entrada.getCodigoZona());
			cstmt.setString(5,entrada.getCodigoCentral());
			cat.debug("entrada.getCodigoCentral(): " + entrada.getCodigoCentral());
			cstmt.setString(6,entrada.getCodigoBcoi());
			cat.debug("entrada.getCodigoBcoi(): " + entrada.getCodigoBcoi());
			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:insPagoAutomatico:execute");
			cstmt.execute();
			cat.debug("Fin:insPagoAutomatico:execute");

			codError  = cstmt.getInt(7);
			msgError  = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al insertar pago automatico");
				throw new GeneralException(
				"Ocurrió un error al insertar pago automatico", String
				.valueOf(codError), numEvento, msgError);
			}

		} catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar pago automatico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar pago automatico", String
					.valueOf(codError), numEvento, msgError);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:insPagoAutomatico");
	}//fin insPagoAutomatico
	
	
	 /**
	 * Valida Formato de la tarjeta de Crédito
	 * @param entrada
	 * @return conceptosCobranzaDTO
	 * @throws GeneralException
	 */
	public ConceptosCobranzaDTO validaTarjeta(ConceptosCobranzaDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		ConceptosCobranzaDTO conceptosCobranzaDTO = null;
		try {
			cat.debug("Inicio:validaTarjeta");
			
			//INI-01 (AL) String call = getSQLPackage("VE_intermediario_PG","VE_validaTarjeta_PR",6);
			String call = getSQLPackage("VE_intermediario_Quiosco_PG","VE_validaTarjeta_PR",6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getTipoTarjeta());
			cat.debug("entrada.getTipoTarjeta(): " + entrada.getTipoTarjeta());
			cstmt.setString(2,entrada.getNumeroTarjeta());
			cat.debug("entrada.getNumeroTarjeta(): " + entrada.getNumeroTarjeta());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:validaTarjeta:execute");
			cstmt.execute();
			cat.debug("Fin:validaTarjeta:execute");

			codError  = cstmt.getInt(4);
			msgError  = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al validar la tarjeta de crédito");
				throw new GeneralException(
				"Ocurrió un error al validar la tarjeta de crédito", String
				.valueOf(codError), numEvento, msgError);
			}else{
				conceptosCobranzaDTO = new ConceptosCobranzaDTO();
				conceptosCobranzaDTO.setResValidacion(cstmt.getString(3));
				
				cat.debug("conceptosCobranzaDTO.getResValidacion ["+conceptosCobranzaDTO.getResValidacion()+"]" );
				
			}

		} catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al validar la tarjeta de crédito",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al validar la tarjeta de crédito", String
					.valueOf(codError), numEvento, msgError);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:validaTarjeta");
		return conceptosCobranzaDTO;
	}//fin validaTarjeta
	
	private String getSQLgetInformacionPrecio(){
		StringBuffer call = new StringBuffer();
					 call.append("	BEGIN "+
							 	 "		GE_CONS_CATALOGO_PORTAB_PG.GE_REC_PRECIO_X_ARTICULO_PR ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ); "+
							 	 "  END;"); 
		return call.toString();			 
	}
	
	
	  /**
	 * Obtiene getInformacionPrecio
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public RetornoDTO getInformacionPrecio(ArticuloDTO articuloDTO)throws GeneralException{
		RetornoDTO resultado=new RetornoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSQLgetInformacionPrecio");
			cat.debug(" Parametros de Entrada ");
			cat.debug(" Tipo Stock ["+articuloDTO.getTipoStock()+"] ");
			cat.debug(" Código Artículo ["+articuloDTO.getCodigo()+"] ");
			cat.debug(" Código Uso ["+articuloDTO.getCodigoUso()+"] ");
			cat.debug(" Código Estado ["+articuloDTO.getCodigoEstado()+"] ");
			cat.debug(" Ind Recambio ["+articuloDTO.getIndRecambio()+"] ");
			cat.debug(" Código Categoría ["+articuloDTO.getCodCategoria()+"] ");
			cat.debug(" Número Meses ["+articuloDTO.getNumMeses()+"] ");
			cat.debug(" Código Promedio ["+articuloDTO.getCodPromedio()+"] ");
			cat.debug(" Código Antigüedad ["+articuloDTO.getCodAntiguedad()+"] ");
			cat.debug(" Código ModVenta ["+articuloDTO.getCodModVenta()+"] ");
			
			String call = getSQLgetInformacionPrecio();
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,articuloDTO.getTipoStock());
			cstmt.setLong(2,articuloDTO.getCodigo());
			cstmt.setLong(3,articuloDTO.getCodigoUso());
			cstmt.setLong(4,articuloDTO.getCodigoEstado());
			cstmt.setString(5,articuloDTO.getIndRecambio());
			cstmt.setString(6,articuloDTO.getCodCategoria());
			cstmt.setLong(7,articuloDTO.getNumMeses());
			cstmt.setLong(8,articuloDTO.getCodPromedio());
			cstmt.setLong(9,articuloDTO.getCodAntiguedad());
			cstmt.setLong(10,articuloDTO.getCodModVenta());
			
			cstmt.registerOutParameter(11, java.sql.Types.FLOAT);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getInformacionPrecio:execute");
			cstmt.execute();
			cat.debug("Fin:getInformacionPrecio:execute");

			codError  = cstmt.getInt(12);
			msgError  = cstmt.getString(13);
			numEvento = cstmt.getInt(14);
			
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener getInformacionPrecio");
				throw new GeneralException(
				"Ocurrió un error al obtener getInformacionPrecio", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setCodError(""+cstmt.getFloat(11));
				cat.debug("resultado.getResultadoTransaccion ["+resultado.getCodError()+"]" );
			}
		
		}catch(GeneralException e){
			throw (e);
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener getInformacionPrecio",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
			}
			throw new GeneralException(e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getInformacionPrecio");
		return resultado;
	}//fin getDescripcion123


}//fin ConceptosCobranzaDAO
