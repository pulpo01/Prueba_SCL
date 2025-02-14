package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RangoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeroPilotoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class RangoNumeroDAO extends ConnectionDAO
{
	
	private static Category cat = Category.getInstance(RangoNumeroDAO.class);
	Global global = Global.getInstance();
	private static final String nombreClase = RangoNumeroDAO.class.getName(); 
	
	private Connection getConection() 
		throws ProductDomainException 
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new ProductDomainException("No se pudo obtener una conexión", e1);
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
	}//fin getSQLDatos
	
	
	public RangoDTO[] obtieneRangosDisponibles(Integer codCentral)
		throws ProductDomainException
	{
		cat.debug("obtieneRangosDisponibles: por consultar los rangos disponibles..." + nombreClase);

		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;

		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		
		RangoDTO[] resultado = null;
		
		try
		{
			String call = getSQLDatos("PV_VENTAS_ENLACE_VPN_PG","PV_OBT_RANGOS_DISPONIBLES_PR", 5);
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cat.debug("SQL["+ call + "]" + nombreClase);
			
			//entrada
			cstmt.setInt(1, codCentral.intValue());
			cat.debug("codCentral: "+ codCentral.intValue());
			//salida
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			
			//error
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("por consultar..." + nombreClase);
			cstmt.execute();
			cat.debug("consultado." + nombreClase);

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("codError[" + codError + "]" + nombreClase);
			cat.debug("msgError[" + msgError + "]" + nombreClase);
			cat.debug("numEvento[" + numEvento + "]" + nombreClase);
			
			//salida
			rs = (ResultSet) cstmt.getObject(2);
			RangoDTO rangoVO = null;
			List rangos = new ArrayList();

			while(rs.next())
			{
				rangoVO = new RangoDTO();
				
				rangoVO.setNumDesde(rs.getLong("NUM_DESDE"));
				rangoVO.setNumHasta(rs.getLong("NUM_HASTA"));
				/*rangoVO.setFechaAlta(rs.getDate("FECHA_ALTA"));
				rangoVO.setFechaBaja(rs.getDate("FECHA_BAJA"));
				rangoVO.setFechaSuspension(rs.getDate("FECHA_SUSPENSION"));
				rangoVO.setFechaRehabilitacion(rs.getDate("FECHA_REHABILITACION"));
				rangoVO.setFechaModificacion(rs.getDate("FECHA_MODIFICACION"));
				rangoVO.setEstado(rs.getString("ESTADO"));
				rangoVO.setNomUsuarOra(rs.getString("NOM_USUARORA"));*/
				
				rangos.add(rangoVO);
			}

			
			resultado =(RangoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					rangos.toArray(), RangoDTO.class);
			
			cat.debug("obtieneRangosDisponibles: list.size = " + rangos.size() +nombreClase);
			cat.debug("obtieneRangosDisponibles: codError = [" + codError + "], msgError = [" + msgError + "], " +
					"numEvento = [" + numEvento + "]"+ nombreClase);
			
			cat.debug("obtieneRangosDisponibles: end"+ nombreClase);			
			
		} 
		catch (Exception e) 
		{
			cat.error("Ocurrió un error al obtener los rangos disponibles",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
		} 
		finally 
		{
			cat.debug("obtieneRangosDisponibles: cerrando conexiones..." + nombreClase);
			
			cat.debug("Cerrando conexiones...");
		    try {
		    	if (cstmt != null) {
					cstmt.close();
			    }
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:obtieneRangosDisponibles()");	
		return resultado;
	}
	
	
	public void insertaRangoAsociadoNroPiloto(NumeroPilotoDTO rango) 
		throws ProductDomainException
	{
		Connection conn = getConection();
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		cat.debug("insertaRangoAsociadoNroPiloto():start" + nombreClase);
		try {
			
			String call = getSQLDatos("PV_VENTAS_ENLACE_VPN_PG", "PV_IN_NUM_PILOTO_PR",6);
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cat.debug("SQL["+ call + "]" + nombreClase);			
			
			cat.debug("rango.nroPiloto: "+ rango.getNumeroPiloto() + nombreClase);
			cat.debug("rango.numDesde: "+rango.getNumDesde() + nombreClase);
			cat.debug("rango.getNomUsuarOra: "+rango.getNomUsuarOra() + nombreClase);
			cstmt.setLong(1, rango.getNumeroPiloto());
			cstmt.setLong(2, rango.getNumDesde());
			cstmt.setString(3, rango.getNomUsuarOra());
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			
			cat.debug("Execute Antes" + nombreClase);
			cstmt.execute();
			cat.debug("Execute Despues" + nombreClase);
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("codError[" + codError + "]" + nombreClase);
			cat.debug("msgError[" + msgError + "]" + nombreClase);
			cat.debug("numEvento[" + numEvento + "]" + nombreClase);
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar el rango",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
	 	} finally {
	 		cat.debug("insertaRangoAsociadoNroPiloto: cerrando conexiones..." + nombreClase);
			
			cat.debug("Cerrando conexiones...");
		    try {
		    	if (cstmt != null) {
					cstmt.close();
			    }
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("insertaRangoAsociadoNroPiloto():end" + nombreClase);
	
	}
	
	
	public void eliminarRangos(Long entrada)
		throws ProductDomainException
	{
		Connection conn = getConection();
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		cat.debug("eliminarRangos():start" + nombreClase);
		try {
			
			String call = getSQLDatos("PV_VENTAS_ENLACE_VPN_PG", "GA_ELIMINA_RANGOS_PR ",4);
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cat.debug("SQL["+ call + "]" + nombreClase);			
			
			cat.debug("nroPiloto: "+ entrada + nombreClase);			
			cstmt.setLong(1, entrada.longValue());
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			
			cat.debug("Execute Antes" + nombreClase);
			cstmt.execute();
			cat.debug("Execute Despues" + nombreClase);
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			cat.debug("codError[" + codError + "]" + nombreClase);
			cat.debug("msgError[" + msgError + "]" + nombreClase);
			cat.debug("numEvento[" + numEvento + "]" + nombreClase);
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar el rango",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
	 	} finally {
	 		cat.debug("eliminarRangos: cerrando conexiones..." + nombreClase);
			
			cat.debug("Cerrando conexiones...");
		    try {
		    	if (cstmt != null) {
					cstmt.close();
			    }
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("eliminarRangos():end" + nombreClase);
	
	}
	

	
	
}
