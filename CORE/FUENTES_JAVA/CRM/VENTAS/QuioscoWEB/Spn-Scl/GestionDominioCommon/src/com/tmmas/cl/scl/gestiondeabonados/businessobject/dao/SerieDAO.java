package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CantidadStockSerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TipoStockValidoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;

public class SerieDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(SerieDAO.class);
	Global global = Global.getInstance();
	
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	private String getSQLsalidaDefinitivaSerie() {
		StringBuffer calling = new StringBuffer();		
		calling.append("");
		calling.append("DECLARE");
		calling.append(  "   EV_NUM_SERIE VARCHAR2(200); ");
		calling.append(  "   EV_NOM_USUARIO VARCHAR2(200);");		
		calling.append(  "   EN_NUM_VENTA VARCHAR2(200);");
		calling.append(  "   SN_NUM_MOVIMIENTO VARCHAR2(200);");
   	    calling.append(  "   SN_COD_RETORNO NUMBER;");
  		calling.append(  "   SV_MENS_RETORNO VARCHAR2(200);");
		calling.append(  "   SN_NUM_EVENTO NUMBER;");
		calling.append(  " BEGIN ");
		calling.append(  "   EV_NUM_SERIE := ?;");
		calling.append(  "   EV_NOM_USUARIO := ?;");
		calling.append(  "   EN_NUM_VENTA := ?;");
		calling.append(  "   SN_NUM_MOVIMIENTO := NULL;");
		calling.append(  "   SN_COD_RETORNO := NULL;");
		calling.append(  "   SV_MENS_RETORNO := NULL;");
		calling.append(  "   SN_NUM_EVENTO := NULL;");
		calling.append(  "  AL_SERIES_PORTABILIDAD_PG.al_salida_def_series_pr( EV_NUM_SERIE, EV_NOM_USUARIO, EN_NUM_VENTA, SN_NUM_MOVIMIENTO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );");		
		calling.append(  "  ?:=SN_NUM_MOVIMIENTO;");        
		calling.append(  "  ?:=SN_COD_RETORNO;");
		calling.append(  "  ?:=SV_MENS_RETORNO;");
		calling.append(  "  ?:=SN_NUM_EVENTO;");		
		calling.append(  " END;");
		if (cat.isDebugEnabled()) 
			cat.debug("calling : " + calling);        
		return calling.toString();
	}
	
	
	private String getSQLreservaSerie() {
		StringBuffer calling = new StringBuffer();		
		calling.append("");
		calling.append("DECLARE");
		calling.append(  "   EV_NUM_SERIE VARCHAR2(200); ");
		calling.append(  "   EV_NOM_USUARIO VARCHAR2(200);");		
		calling.append(  "   EN_NUM_VENTA VARCHAR2(200);");
		calling.append(  "   SN_NUM_MOVIMIENTO VARCHAR2(200);");
   	    calling.append(  "   SN_COD_RETORNO NUMBER;");
  		calling.append(  "   SV_MENS_RETORNO VARCHAR2(200);");
		calling.append(  "   SN_NUM_EVENTO NUMBER;");
		calling.append(  " BEGIN ");
		calling.append(  "   EV_NUM_SERIE := ?;");
		calling.append(  "   EV_NOM_USUARIO := ?;");
		calling.append(  "   EN_NUM_VENTA := ?;");
		calling.append(  "   SN_NUM_MOVIMIENTO := NULL;");
		calling.append(  "   SN_COD_RETORNO := NULL;");
		calling.append(  "   SV_MENS_RETORNO := NULL;");
		calling.append(  "   SN_NUM_EVENTO := NULL;");
		calling.append(  "  AL_SERIES_PORTABILIDAD_PG.AL_RESERVA_SERIES_PR( EV_NUM_SERIE, EV_NOM_USUARIO, EN_NUM_VENTA, SN_NUM_MOVIMIENTO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );");		
		calling.append(  "  ?:=SN_NUM_MOVIMIENTO;");        
		calling.append(  "  ?:=SN_COD_RETORNO;");
		calling.append(  "  ?:=SV_MENS_RETORNO;");
		calling.append(  "  ?:=SN_NUM_EVENTO;");		
		calling.append(  " END;");
		if (cat.isDebugEnabled()) 
			cat.debug("calling : " + calling);        
		return calling.toString();
	}
	
	
	private String getSQLdesReservaSerie() {
		StringBuffer calling = new StringBuffer();		
		calling.append("");
		calling.append("DECLARE");
		calling.append(  "   EV_NUM_SERIE VARCHAR2(200); ");
		calling.append(  "   EV_NOM_USUARIO VARCHAR2(200);");		
		calling.append(  "   EN_NUM_VENTA VARCHAR2(200);");
		calling.append(  "   SN_NUM_MOVIMIENTO VARCHAR2(200);");
   	    calling.append(  "   SN_COD_RETORNO NUMBER;");
  		calling.append(  "   SV_MENS_RETORNO VARCHAR2(200);");
		calling.append(  "   SN_NUM_EVENTO NUMBER;");
		calling.append(  " BEGIN ");
		calling.append(  "   EV_NUM_SERIE := ?;");
		calling.append(  "   EV_NOM_USUARIO := ?;");
		calling.append(  "   EN_NUM_VENTA := ?;");
		calling.append(  "   SN_NUM_MOVIMIENTO := NULL;");
		calling.append(  "   SN_COD_RETORNO := NULL;");
		calling.append(  "   SV_MENS_RETORNO := NULL;");
		calling.append(  "   SN_NUM_EVENTO := NULL;");
		calling.append(  "  AL_SERIES_PORTABILIDAD_PG.AL_DESRESERVA_SERIES_PR( EV_NUM_SERIE, EV_NOM_USUARIO, EN_NUM_VENTA, SN_NUM_MOVIMIENTO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );");		
		calling.append(  "  ?:=SN_NUM_MOVIMIENTO;");        
		calling.append(  "  ?:=SN_COD_RETORNO;");
		calling.append(  "  ?:=SV_MENS_RETORNO;");
		calling.append(  "  ?:=SN_NUM_EVENTO;");		
		calling.append(  " END;");
		if (cat.isDebugEnabled()) 
			cat.debug("calling : " + calling);        
		return calling.toString();
	}	
	
	
	
	private Connection getConection() 
	throws GeneralException
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
	
	private String getSQLDatosPK(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosSimcard	
	
	
	
	public SerieDTO salidaDefinitivaSerie(SerieDTO serie)
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			cat.debug("Inicio:salidaDefinitivaSerie");

			String call = getSQLsalidaDefinitivaSerie();

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,serie.getNumSerie().trim());  //SERIE
			cat.debug("serie.getNumSerie() ["+serie.getNumSerie()+"]");
			cstmt.setString(2,serie.getNomUsuario().trim());  //USUARIO
			cat.debug("serie.getNomUsuario() ["+serie.getNomUsuario()+"]");
			cstmt.setString(3,serie.getNumPorceso().trim());  //VENTA
			cat.debug("serie.getNumPorceso() ["+serie.getNumPorceso()+"]");
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			for (int j = 0; j < 4; j++)
			{

				cat.debug("Inicio:salidaDefinitivaSerie:execute");
				cstmt.execute();
				cat.debug("Fin:salidaDefinitivaSerie:execute");

				codError  = cstmt.getInt(5);
				msgError  = cstmt.getString(6);
				numEvento = cstmt.getInt(7);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");


				if (codError != 100002){
					break;
				}
				Thread.sleep(2000);      //DELAY 2 segundos   			          
			}

			if (codError != 0) {
				cat.debug("Ocurrió un error en la salida definitiva de la serie");
				throw new GeneralException(
						"Ocurrió un error en la salida definitiva de la serie", String
						.valueOf(codError), numEvento, msgError);

			}				
			
			serie.setNumMovimiento( cstmt.getString(4));
			
		}catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error en la salida definitiva de la serie",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error en la desreserva de la serie", e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:salidaDefinitivaSerie");
		return serie;
	}//fin actualizaStockSimcard	
	
	
	
	public SerieDTO reservaSerie(SerieDTO serie)
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			cat.debug("Inicio:reservaSerie");

			String call = getSQLreservaSerie();

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,serie.getNumSerie());  //SERIE
			cat.debug("serie.getNumSerie() ["+serie.getNumSerie()+"]");
			cstmt.setString(2,serie.getNomUsuario());  //USUARIO
			cat.debug("serie.getNomUsuario() ["+serie.getNomUsuario()+"]");
			cstmt.setString(3,serie.getNumPorceso());  //VENTA
			cat.debug("serie.getNumPorceso() ["+serie.getNumPorceso()+"]");
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			for (int j = 0; j < 4; j++)
			{

				cat.debug("Inicio:reservaSerie:execute");
				cstmt.execute();
				cat.debug("Fin:reservaSerie:execute");

				codError  = cstmt.getInt(5);
				msgError  = cstmt.getString(6);
				numEvento = cstmt.getInt(7);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");


				if (codError != 100002){
					break;
				}
				Thread.sleep(2000);      //DELAY 2 segundos   			          
			}

			if (codError != 0) {
				cat.debug("Ocurrió un error en la reserva de la serie");
				throw new GeneralException(
						"Ocurrió un error en la reserva de la serie", String
						.valueOf(codError), numEvento, msgError);

			}				
			
			serie.setNumMovimiento( cstmt.getString(4));
			
		}catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error en la reserva de la serie",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error en la reserva de la serie", e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:reservaSerie");
		return serie;
	}//fin actualizaStockSimcard
	
	
	public SerieDTO desReservaSerie(SerieDTO serie)
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			cat.debug("Inicio:desReservaSerie");

			String call = getSQLdesReservaSerie();

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,serie.getNumSerie());  //SERIE
			cat.debug("serie.getNumSerie() ["+serie.getNumSerie()+"]");
			cstmt.setString(2,serie.getNomUsuario());  //USUARIO
			cat.debug("serie.getNomUsuario() ["+serie.getNomUsuario()+"]");
			cstmt.setString(3,serie.getNumPorceso());  //VENTA
			cat.debug("serie.getNumPorceso() ["+serie.getNumPorceso()+"]");
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			for (int j = 0; j < 4; j++)
			{

				cat.debug("Inicio:desReservaSerie:execute");
				cstmt.execute();
				cat.debug("Fin:desReservaSerie:execute");

				codError  = cstmt.getInt(5);
				msgError  = cstmt.getString(6);
				numEvento = cstmt.getInt(7);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");


				if (codError != 100002){
					break;
				}
				Thread.sleep(2000);      //DELAY 2 segundos   			          
			}

			if (codError != 0) {
				cat.debug("Ocurrió un error en la desreserva de la serie");
				throw new GeneralException(
						"Ocurrió un error en la desreserva de la serie", String
						.valueOf(codError), numEvento, msgError);

			}				
			
			serie.setNumMovimiento( cstmt.getString(4));
			
		} catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error en la desreserva de la serie",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error en la desreserva de la serie", e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:desReservaSerie");
		return serie;
	}//fin actualizaStockSimcard
	
	
	/**
	 * Metodo que retorna la cantidad de series segun el cod_uso, cod_bodega y cod_articulo.
	 * @param cantidadStockSerieDTO
	 * @throws GeneralException
	 */
	public CantidadStockSerieDTO getCantidadStockSerie(CantidadStockSerieDTO cantidadStockSerieDTO) throws GeneralException{
		cat.debug("getCantidadStockSerie:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();

		try {
			String call = getSQLDatos("AL_PORTABILIDAD_PG","al_consulta_cant_stock_pr",7);
			cat.debug("sql[" + call + "]");
			CallableStatement cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(cantidadStockSerieDTO.getCodUso()));
			cstmt.setInt(2,Integer.parseInt(cantidadStockSerieDTO.getCodBodega()));
			cstmt.setInt(3,Integer.parseInt(cantidadStockSerieDTO.getCodArticulo()));
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al consultar la cantidad de Stock");
				throw new GeneralException(String.valueOf(codError),numEvento, msgError);
			}
			
			cantidadStockSerieDTO.setCantidadStock(cstmt.getInt(4));			
			cat.debug("stock serie[" + cantidadStockSerieDTO.getCantidadStock()+ "]");
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar la cantidad de Stock",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("getCantidadStockSerie:end");
		return cantidadStockSerieDTO;
	}

}
