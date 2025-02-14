package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CantidadStockSerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieKitDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TipoStockValidoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;

public class SerieKitDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(SerieKitDAO.class);
	Global global = Global.getInstance();
	
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
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
		
	
	public SerieKitDTO validaSerieKit(SerieKitDTO serieKit)
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			cat.debug("Inicio:validaSerieKit");

			String call = getSQLDatos("al_series_kit_pg","ve_valida_serie_kit_pr",6);
			cat.debug("sql[" + call + "]");		

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,serieKit.getNumSerieSimcard());  		
			cat.debug("serieKit.getNumSerieSimcard() [" + serieKit.getNumSerieSimcard() + "]");
			cstmt.setString(2,serieKit.getNumSerieTerminal());
			cat.debug("serieKit.getNumSerieTerminal() [" + serieKit.getNumSerieTerminal() + "]");
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);

				cat.debug("Inicio:validaSerieKit:execute");
				cstmt.execute();
				cat.debug("Fin:validaSerieKit:execute");

				codError  = cstmt.getInt(4);
				msgError  = cstmt.getString(5);
				numEvento = cstmt.getInt(6);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");


			if (codError != 0) {
				cat.debug("Ocurrió un error al validar serie kit");
				throw new GeneralException(
						"Ocurrió un error al validar serie kit", String
						.valueOf(codError), numEvento, msgError);

			}				
			cat.debug("serieKit.setNumSerieKit [" + cstmt.getString(3) + "]");
			if (cstmt.getString(3) == null){
				serieKit.setNumSerieKit("");
			}else{
				serieKit.setNumSerieKit(cstmt.getString(3));
			}
			
		}catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error al validar serie kit",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error al validar serie kit", e);
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
		cat.debug("Fin:validaSerieKit");
		return serieKit;
	}//fin actualizaStockSimcard
	
		
	
	public SimcardSNPNDTO getSerieSimcardKit(SerieKitDTO serieKit) 
	throws GeneralException{
		cat.debug("Inicio:getSerieKit()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		SimcardSNPNDTO SimcardSNPNDTO = null;
		try {
			String call = getSQLDatos("al_series_kit_pg","ve_consulta_serie_kit_pr",20);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,serieKit.getNumSerieKit());
			cat.debug("serieKit.getNumSerieKit() [" + serieKit.getNumSerieKit() + "]");
			cstmt.setString(2,serieKit.getNumSerieSimcard());
			cat.debug("serieKit.getNumSerieSimcard() [" + serieKit.getNumSerieSimcard() + "]");
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSerieSimcardKit:execute");
			cstmt.execute();
			cat.debug("Fin:getSerieSimcardKit:execute");

			codError = cstmt.getInt(18);
			msgError = cstmt.getString(19);
			numEvento = cstmt.getInt(20);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");


			if (codError == 0){
				SimcardSNPNDTO = new SimcardSNPNDTO();
				SimcardSNPNDTO.setNumeroSerie(serieKit.getNumSerieSimcard());
				cat.debug("SimcardSNPNDTO.setNumeroSerie ["+serieKit.getNumSerieSimcard()+"]");
				SimcardSNPNDTO.setCodigoBodega(String.valueOf(cstmt.getInt(3)));
				cat.debug("SimcardSNPNDTO.setCodigoBodega ["+cstmt.getInt(3)+"]");
				SimcardSNPNDTO.setEstado(String.valueOf(cstmt.getInt(4)));
				cat.debug("SimcardSNPNDTO.setEstado ["+cstmt.getInt(4)+"]");
				SimcardSNPNDTO.setIndicadorProgramado(String.valueOf(cstmt.getInt(5)));
				cat.debug("SimcardSNPNDTO.setIndicadorProgramado ["+cstmt.getInt(5)+"]");
				SimcardSNPNDTO.setNumeroCelular(String.valueOf(cstmt.getLong(6)));
				cat.debug("SimcardSNPNDTO.setNumeroCelular ["+cstmt.getLong(6)+"]");
				SimcardSNPNDTO.setCodigoUso(String.valueOf(cstmt.getInt(7)));
				cat.debug("SimcardSNPNDTO.setCodigoUso ["+cstmt.getInt(7)+"]");
				SimcardSNPNDTO.setTipoStock(String.valueOf(cstmt.getInt(8)));
				cat.debug("SimcardSNPNDTO.setTipoStock ["+cstmt.getInt(8)+"]");
				SimcardSNPNDTO.setCodigoCentral(String.valueOf(cstmt.getInt(9)));
				cat.debug("SimcardSNPNDTO.setCodigoCentral ["+cstmt.getInt(9)+"]");
				SimcardSNPNDTO.setCodigoArticulo(String.valueOf(cstmt.getInt(10)));
				cat.debug("SimcardSNPNDTO.setCodigoArticulo ["+cstmt.getInt(10)+"]");
				SimcardSNPNDTO.setCapCode(String.valueOf(cstmt.getInt(11)));
				cat.debug("SimcardSNPNDTO.setCapCode ["+cstmt.getInt(11)+"]");
				SimcardSNPNDTO.setTipoArticulo(String.valueOf(cstmt.getInt(12)));
				cat.debug("SimcardSNPNDTO.setTipoArticulo ["+cstmt.getInt(12)+"]");
				SimcardSNPNDTO.setDescripcionArticulo(cstmt.getString(13));
				cat.debug("SimcardSNPNDTO.setDescripcionArticulo ["+cstmt.getString(13)+"]");
				SimcardSNPNDTO.setCodigoSubAlm(cstmt.getString(14));
				cat.debug("SimcardSNPNDTO.setCodigoSubAlm ["+cstmt.getString(14)+"]");
				SimcardSNPNDTO.setIndicadorValorar(cstmt.getString(15));
				cat.debug("SimcardSNPNDTO.setIndicadorValorar ["+cstmt.getString(15)+"]");
				SimcardSNPNDTO.setCarga(cstmt.getString(16));
				cat.debug("SimcardSNPNDTO.setCarga ["+cstmt.getString(16)+"]");
				SimcardSNPNDTO.setCodHLR(cstmt.getString(17));
				cat.debug("SimcardSNPNDTO.setCodHLR ["+cstmt.getString(17)+"]");
			}else{
				cat.error("Ocurrió un error al recuperar informacion de simcard");
				throw new GeneralException(
						"Ocurrió un error al recuperar informacion de simcard", String
						.valueOf(codError), numEvento, msgError);
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		}catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Datos de la serie simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getSimcard()");
		return SimcardSNPNDTO;				
	}	
	
	
	
	
	
	
	public TerminalSNPNDTO getSerieTerminalKit(SerieKitDTO serieKit) 
	throws GeneralException{
		cat.debug("Inicio:getSerieTerminalKit()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		TerminalSNPNDTO TerminalSNPN = null;
		try {
			String call = getSQLDatos("al_series_kit_pg","ve_consulta_serie_kit_pr",20);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,serieKit.getNumSerieKit());
			cat.debug("serieKit.getNumSerieKit() [" + serieKit.getNumSerieKit() + "]");
			cstmt.setString(2,serieKit.getNumSerieTerminal());
			cat.debug("serieKit.getNumSerieSimcard() [" + serieKit.getNumSerieTerminal() + "]");
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSerieTerminalKit:execute");
			cstmt.execute();
			cat.debug("Fin:getSerieTerminalKit:execute");

			codError = cstmt.getInt(18);
			msgError = cstmt.getString(19);
			numEvento = cstmt.getInt(20);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");


			if (codError == 0){
				
				  
				TerminalSNPN = new TerminalSNPNDTO();
				TerminalSNPN.setNumeroSerie(serieKit.getNumSerieTerminal());
				cat.debug("SimcardSNPNDTO.setNumeroSerie ["+serieKit.getNumSerieTerminal()+"]");
				TerminalSNPN.setCodigoBodega(String.valueOf(cstmt.getInt(3)));
				cat.debug("SimcardSNPNDTO.setCodigoBodega ["+cstmt.getInt(3)+"]");
				TerminalSNPN.setEstado(String.valueOf(cstmt.getInt(4)));
				cat.debug("SimcardSNPNDTO.setEstado ["+cstmt.getInt(4)+"]");
				TerminalSNPN.setIndicadorProgramado(String.valueOf(cstmt.getInt(5)));
				cat.debug("SimcardSNPNDTO.setIndicadorProgramado ["+cstmt.getInt(5)+"]");
				TerminalSNPN.setNumeroCelular(String.valueOf(cstmt.getLong(6)));
				cat.debug("SimcardSNPNDTO.setNumeroCelular ["+cstmt.getLong(6)+"]");
				TerminalSNPN.setCodigoUso(String.valueOf(cstmt.getInt(7)));
				cat.debug("SimcardSNPNDTO.setCodigoUso ["+cstmt.getInt(7)+"]");
				TerminalSNPN.setTipoStock(String.valueOf(cstmt.getInt(8)));
				cat.debug("SimcardSNPNDTO.setTipoStock ["+cstmt.getInt(8)+"]");
				TerminalSNPN.setCodigoCentral(String.valueOf(cstmt.getInt(9)));
				cat.debug("SimcardSNPNDTO.setCodigoCentral ["+cstmt.getInt(9)+"]");
				TerminalSNPN.setCodigoArticulo(String.valueOf(cstmt.getInt(10)));
				cat.debug("SimcardSNPNDTO.setCodigoArticulo ["+cstmt.getInt(10)+"]");
				TerminalSNPN.setCapCode(String.valueOf(cstmt.getInt(11)));
				cat.debug("SimcardSNPNDTO.setCapCode ["+cstmt.getInt(11)+"]");
				TerminalSNPN.setTipoArticulo(String.valueOf(cstmt.getInt(12)));
				cat.debug("SimcardSNPNDTO.setTipoArticulo ["+cstmt.getInt(12)+"]");
				TerminalSNPN.setDescripcionArticulo(cstmt.getString(13));
				cat.debug("SimcardSNPNDTO.setDescripcionArticulo ["+cstmt.getString(13)+"]");
				TerminalSNPN.setCodigoSubAlm(cstmt.getString(14));
				cat.debug("SimcardSNPNDTO.setCodigoSubAlm ["+cstmt.getString(14)+"]");
				TerminalSNPN.setIndicadorValorar(cstmt.getString(15));
				cat.debug("SimcardSNPNDTO.setIndicadorValorar ["+cstmt.getString(15)+"]");
				TerminalSNPN.setCarga(cstmt.getString(16));
				cat.debug("SimcardSNPNDTO.setCarga ["+cstmt.getString(16)+"]");
				
				TerminalSNPN.setIndProcEq("I");
				cat.debug("resultado.setIndProcEq [" + "I" + "]");
				
			}else{
				cat.debug("Ocurrió un error al recuperar informacion de simcard");
				throw new GeneralException(
						"Ocurrió un error al recuperar informacion de simcard", String
						.valueOf(codError), numEvento, msgError);
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		}catch (SQLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error SQLException [" + log + "]");
			throw new GeneralException(e);
		}catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Datos de la serie simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getSimcard()");
		return TerminalSNPN;				
	}	
	

	

}
