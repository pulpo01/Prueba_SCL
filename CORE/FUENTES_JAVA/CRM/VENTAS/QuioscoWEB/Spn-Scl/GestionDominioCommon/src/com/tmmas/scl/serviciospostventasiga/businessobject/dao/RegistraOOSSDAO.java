package com.tmmas.scl.serviciospostventasiga.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.serviciospostventasiga.common.helper.Global;
import com.tmmas.scl.serviciospostventasiga.common.helper.ServiciosPostVentaSigaLoggerHelper;
import com.tmmas.scl.serviciospostventasiga.transport.EntradaOOSSDTO;
import com.tmmas.scl.serviciospostventasiga.transport.GenericoOOSSDTO;

public class RegistraOOSSDAO extends ConnectionDAO {

	
	private Global global = Global.getInstance();
	private ServiciosPostVentaSigaLoggerHelper logger = ServiciosPostVentaSigaLoggerHelper.getInstance();
	private String nombreClase = this.getClass().getName();
	
	public String getSQLRegistraOOSS() {
		StringBuffer call = new StringBuffer();
		call.append("DECLARE ");
		call.append(" tpv_ooss pv_ooss_qt:=pv_ooss_qt(");
		call.append(" null, null, null, null, null, null, ");
		call.append(" null, null, null, null, null, null, ");
		call.append(" null, null, null, null, null, null, ");
		call.append(" null, null, null, null, null, null, null); ");
		call.append("BEGIN ");
		call.append("tpv_ooss.NNUM_OS := NULL; ");
		call.append("tpv_ooss.NNUM_EVENTO := NULL; ");
		call.append("tpv_ooss.VDES_EVENTO := NULL; ");
		call.append("tpv_ooss.NCOD_ERROR := NULL; ");
		call.append("tpv_ooss.VCOD_OS := ?; ");
		call.append("tpv_ooss.NNUM_CELULAR := ?; "); 
		call.append("tpv_ooss.VCOD_USUARIO := ?; ");
		call.append("tpv_ooss.NNUM_ABONADO := ?; ");
		call.append("tpv_ooss.NCOD_CLIENTE := ?; ");
		call.append("tpv_ooss.NIND_CENTRAL := ?; ");
		call.append("tpv_ooss.VTIP_TERMINAL := ?; ");
		call.append("tpv_ooss.VCOD_CAUSASIN := ?; ");
		call.append("tpv_ooss.NNUM_VENTA := ?; ");
		call.append("tpv_ooss.NNUM_TRANSACCION := ?; ");
		call.append("tpv_ooss.NNUM_FOLIO := ?; ");
		call.append("tpv_ooss.NNUM_CUOTAS := ?; ");
		call.append("tpv_ooss.NNUM_PROCESO := ?; ");
		call.append("tpv_ooss.DFEC_ANULACION := ?; ");
		call.append("tpv_ooss.VCAT_TRIBUTARIA := ?; ");
		call.append("tpv_ooss.VCOD_ESTADO := ?; ");
		call.append("tpv_ooss.DFEC_EJECUCION := ?; ");
		call.append("tpv_ooss.VCLASE_SERVACT := ?; ");
		call.append("tpv_ooss.VCLASE_SERVDES := ?; ");
		call.append("tpv_ooss.NIND_PORTABLE := ?; ");
		call.append("tpv_ooss.VCOMENTARIO := ?; ");
		call.append("PV_INSCRIBE_OOSS_PG.PV_INSCRIBE_OS_PR( tpv_ooss, ?, ?, ?, ?); ");
		call.append("END; ");
		return call.toString();
	}
	
	public GenericoOOSSDTO inscribeOOSS(EntradaOOSSDTO OOSSDto)throws GeneralException, SQLException,Exception {
		logger.info("inscribeOOSS():Inicio",nombreClase);
		GenericoOOSSDTO genericoOOSSDto = new GenericoOOSSDTO();
		long codError = 0;
		String msgError = null;
		long numEvento = 0;
		Connection conn = null;
		ResultSet rs = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		
		try {
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = getSQLRegistraOOSS();
			
			cstmt = conn.prepareCall(call);
			
			if(OOSSDto.getSCodOS()!=null) cstmt.setString(1, OOSSDto.getSCodOS());else cstmt.setNull(1, java.sql.Types.NULL );
			if(OOSSDto.getLNumCelular()!=null) cstmt.setLong(2, OOSSDto.getLNumCelular().longValue() ); else cstmt.setNull(2, java.sql.Types.NUMERIC);
			if(OOSSDto.getSCodUsuario()!=null)cstmt.setString(3, OOSSDto.getSCodUsuario()); else cstmt.setNull(3, java.sql.Types.VARCHAR );
			if(OOSSDto.getLNumAbonado()!=null)cstmt.setLong(4, OOSSDto.getLNumAbonado().longValue()); else cstmt.setNull(4, java.sql.Types.NUMERIC );
			if(OOSSDto.getLCodCliente()!=null)cstmt.setLong(5, OOSSDto.getLCodCliente().longValue()); else cstmt.setNull(5, java.sql.Types.NUMERIC );
			if(OOSSDto.getIIndCentral()!=null)cstmt.setInt(6, OOSSDto.getIIndCentral().intValue()); else cstmt.setNull(6, java.sql.Types.NUMERIC );
			if(OOSSDto.getSTipTerminal()!=null)cstmt.setString(7, OOSSDto.getSTipTerminal()); else cstmt.setNull(7, java.sql.Types.VARCHAR );
			if(OOSSDto.getSCodCausaSin()!=null)cstmt.setString(8, OOSSDto.getSCodCausaSin()); else cstmt.setNull(8, java.sql.Types.VARCHAR );
			if(OOSSDto.getLNumVenta()!=null)cstmt.setLong(9, OOSSDto.getLNumVenta().longValue()); else cstmt.setNull(9, java.sql.Types.NUMERIC );
			if(OOSSDto.getLNumTransaccion()!=null)cstmt.setLong(10, OOSSDto.getLNumTransaccion().longValue()); else cstmt.setNull(10, java.sql.Types.NUMERIC );

			if(OOSSDto.getLNumFolio()!=null)cstmt.setLong(11, OOSSDto.getLNumFolio().longValue()); else cstmt.setNull(11, java.sql.Types.NUMERIC );
			if(OOSSDto.getINumCuotas()!=null)cstmt.setInt(12, OOSSDto.getINumCuotas().intValue()); else cstmt.setNull(12, java.sql.Types.NUMERIC );
			if(OOSSDto.getLNumProceso()!=null)cstmt.setLong(13, OOSSDto.getLNumProceso().longValue()); else cstmt.setNull(13, java.sql.Types.NUMERIC );
			if(OOSSDto.getDFecAnulacion()!=null)cstmt.setDate(14, OOSSDto.getDFecAnulacion()); else cstmt.setNull(14, java.sql.Types.DATE );
			if(OOSSDto.getSCatTributaria()!=null)cstmt.setString(15, OOSSDto.getSCatTributaria()); else cstmt.setNull(15, java.sql.Types.VARCHAR );
			if(OOSSDto.getSCodEstado()!=null)cstmt.setString(16, OOSSDto.getSCodEstado()); else cstmt.setNull(16, java.sql.Types.VARCHAR );
			if(OOSSDto.getDFecProgramacion()!=null)cstmt.setDate(17, OOSSDto.getDFecProgramacion()); else cstmt.setNull(17, java.sql.Types.DATE );
			if(OOSSDto.getSClaseServActivar()!=null)cstmt.setString(18, OOSSDto.getSClaseServActivar()); else cstmt.setNull(18, java.sql.Types.VARCHAR );
			if(OOSSDto.getSClaseServDesactivar()!=null)cstmt.setString(19, OOSSDto.getSClaseServDesactivar()); else cstmt.setNull(19, java.sql.Types.VARCHAR );
			if(OOSSDto.getIIndPortable()!=null)cstmt.setInt(20, OOSSDto.getIIndPortable().intValue()); else cstmt.setNull(20, java.sql.Types.NUMERIC );
			
			if(OOSSDto.getSComentario()!=null)cstmt.setString(21, OOSSDto.getSComentario()); else cstmt.setNull(21, java.sql.Types.VARCHAR );
			
			cstmt.registerOutParameter(22, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			genericoOOSSDto.setNumOS(cstmt.getLong(22));
			genericoOOSSDto.setCodError(cstmt.getLong(23));
			genericoOOSSDto.setDesEvento(cstmt.getString(24));
			genericoOOSSDto.setCodEvento(cstmt.getLong(25));
			codError = cstmt.getLong(23);
			msgError = cstmt.getString(24);
			numEvento = cstmt.getLong(25);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			if(codError!=0)
			{
				throw new GeneralException("ERR.09590",9590,global.getValor("ERR.09590"));
			}
			
			
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.09590",9590,global.getValor("ERR.09590"));
			}else throw (GeneralException)e;	

		}finally{
			logger.debug("Cerrando conexiones...",nombreClase);
			try {
				if (rs != null) rs.close(); 
				if (cstmt != null) cstmt.close();
				if (conn!=null && !conn.isClosed())	conn.close();	
			} catch (SQLException e) {
				logger.error("ERROR: ", nombreClase);
				logger.error("SQLException[" + e + "]",nombreClase);
			}
		}
		logger.info("inscribeOOSS():Fin",nombreClase);
		return genericoOOSSDto;
	}
}
