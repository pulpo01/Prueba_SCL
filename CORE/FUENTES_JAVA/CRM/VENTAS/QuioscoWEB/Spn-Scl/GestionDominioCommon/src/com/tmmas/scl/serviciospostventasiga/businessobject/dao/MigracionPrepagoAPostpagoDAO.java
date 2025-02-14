package com.tmmas.scl.serviciospostventasiga.businessobject.dao;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.serviciospostventasiga.businessobject.dao.helper.ConnectionHelper;
import com.tmmas.scl.serviciospostventasiga.businessobject.dao.helper.DAOHelper;
import com.tmmas.scl.serviciospostventasiga.common.helper.Global;
import com.tmmas.scl.serviciospostventasiga.common.helper.ServiciosPostVentaSigaLoggerHelper;
import com.tmmas.scl.serviciospostventasiga.transport.AbonadoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.AbonadoVtaDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ClienteSIGADTO;
import com.tmmas.scl.serviciospostventasiga.transport.DatosGeneralesDTO;
import com.tmmas.scl.serviciospostventasiga.transport.DireccionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.EquipoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.EquipoVtaDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MovimientoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.OOSSDTO;
import com.tmmas.scl.serviciospostventasiga.transport.PlanesIndemnizacionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.PlanesServiciosDTO;
import com.tmmas.scl.serviciospostventasiga.transport.PlanesTarifariosDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ServiciosSuplementariosDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ServiciosSuplementariosVtaDTO;
import com.tmmas.scl.serviciospostventasiga.transport.TipoContratoSIGADTO;
import com.tmmas.scl.serviciospostventasiga.transport.UsosLineaVO;
import com.tmmas.scl.serviciospostventasiga.transport.UsuarioSIGADTO;
import com.tmmas.scl.serviciospostventasiga.transport.ValorPlanDTO;
import com.tmmas.scl.serviciospostventasiga.transport.VentaDTO;

public class MigracionPrepagoAPostpagoDAO extends ConnectionDAO {

	ServiciosPostVentaSigaLoggerHelper logger = ServiciosPostVentaSigaLoggerHelper.getInstance();
	private String nombreClase = this.getClass().getName();
	Global global = Global.getInstance();
	ConnectionHelper coneccion = new ConnectionHelper();
	DAOHelper daoHelper = new DAOHelper();
//	private Connection getConection() throws IntegracionSIGAException {
//	Connection conn = null;
//	try {
//	conn = getConnectionFromWLSInitialContext(global
//	.getJndiForDataSource());
//	} catch (Exception e1) {
//	conn = null;
//	//cat.error(" No se pudo obtener una conexión ", e1);
//	throw new IntegracionSIGAException("-2129",0,"No se pudo obtener una conexión");
//	}

//	return conn;
//	}

	
	
	

	
	public void getUsuarioPrepago(UsuarioSIGADTO usuarioSIGADTO) throws GeneralException{
		logger.info("getusuarioPrepago():Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBT_USUA_DATPREPAGO_PR", 23);
			cstmt = conn.prepareCall(call);

			cstmt.setInt(1, Integer.parseInt(usuarioSIGADTO.getNumAbonado()));
			System.out.println("num_Abonado prepago " +  usuarioSIGADTO.getNumAbonado()) ;
			cstmt.setInt(2, Integer.parseInt(usuarioSIGADTO.getClienteSIGADTO().getCodigoCliente()));
			System.out.println("codCliente postpago " +  usuarioSIGADTO.getClienteSIGADTO().getCodigoCliente()) ;
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(9, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(10, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(11, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(12, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(13, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(14, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(15, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(16, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(17, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(18, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(19, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(20, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(21);
			msgError = cstmt.getString(22);
			numEvento = cstmt.getInt(23);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{

				ClienteSIGADTO clienteSIGADTO = new ClienteSIGADTO();
				usuarioSIGADTO.setCodigoUsuario(new Long(cstmt.getString(3)).longValue());
				clienteSIGADTO.setNombreCliente(cstmt.getString(4));
				clienteSIGADTO.setNombreApellido1(cstmt.getString(5));
				clienteSIGADTO.setCodigoTipoIdentificacion(cstmt.getString(6));
				clienteSIGADTO.setNumeroIdentificacion(cstmt.getString(7));
				clienteSIGADTO.setIndSituacion(cstmt.getString(8));
				System.out.println("getUsuarioPrepago -- clienteSIGADTO.getIndSituacion: " + clienteSIGADTO.getIndSituacion());
				clienteSIGADTO.setNombreApellido2(cstmt.getString(9));
				clienteSIGADTO.setFechaNacimiento(cstmt.getString(10));
				clienteSIGADTO.setIndicadorEstadoCivil(cstmt.getString(11));
				clienteSIGADTO.setIndicadorSexo(cstmt.getString(12));
				usuarioSIGADTO.setNomEmpresa(cstmt.getString(13));
				usuarioSIGADTO.setCodActemp(cstmt.getString(14));
				usuarioSIGADTO.setCodOcupacion(cstmt.getString(15));
				usuarioSIGADTO.setNumPerCargo(cstmt.getString(16));
				usuarioSIGADTO.setImpBruto(cstmt.getString(17));
				clienteSIGADTO.setCodigoCuenta(cstmt.getString(18));
				System.out.println("codigo cuenta prepago "+ clienteSIGADTO.getCodigoCuenta());
				clienteSIGADTO.setCodigoSubCuenta(cstmt.getString(19));
				clienteSIGADTO.setCodigoCliente(cstmt.getString(20));
				usuarioSIGADTO.setClienteSIGADTO(clienteSIGADTO);
				
			}else{
				throw new GeneralException("ERR.01180 ",numEvento,global.getValor("ERR.01180 "));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01180",numEvento,global.getValor("ERR.01180"));
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
		logger.info("getDatosSerSupl():Fin",nombreClase);
		logger.info("getusuarioPrepago():fin",nombreClase);
	}
	
	
	public void getDatosSerSupl(ServiciosSuplementariosVtaDTO ss) throws GeneralException{

		logger.info("getDatosSerSupl():Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_CONS_DAT_SS_PR", 8);
			cstmt = conn.prepareCall(call);

			cstmt.setInt(1, ss.getCodServSuplabo().intValue());
			logger.debug(" ss.getCodServSuplabo()"+  ss.getCodServSuplabo(), nombreClase);
			System.out.println(" ss.getCodServSuplabo()=["+  ss.getCodServSuplabo() + "]");
			cstmt.setInt(2, ss.getCodNivel().intValue());
			logger.debug(" ss.getCodNivel()"+  ss.getCodNivel(), nombreClase);
			System.out.println(" ss.getCodNivel()=["+  ss.getCodNivel() + "]");
			cstmt.setString(3, ss.getCodActabo());
			logger.debug(" ss.getCodActabo()"+  ss.getCodActabo(), nombreClase);
			System.out.println(" ss.getCodActabo()=["+  ss.getCodActabo() + "]");

			
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
//				ss.setCodServicio(new Long(cstmt.getLong(4)));
				ss.setCodServicio(cstmt.getString(4));
				logger.debug(" ss.getCodServicio()"+  ss.getCodServicio(), nombreClase);
				System.out.println(" ss.getCodServicio()"+  ss.getCodServicio());
				ss.setCodConcepto(new Long(cstmt.getLong(5)));
				logger.debug(" ss.getCodConcepto()"+  ss.getCodConcepto(), nombreClase);
				System.out.println(" ss.getCodConcepto()"+  ss.getCodConcepto());
			}else{
				throw new GeneralException("ERR.01178",numEvento,global.getValor("ERR.01178"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01178",numEvento,global.getValor("ERR.01178"));
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
		logger.info("getDatosSerSupl():Fin",nombreClase);
	}
	
	public void inscribeOOSS(OOSSDTO ooss) throws GeneralException{
		logger.info("inscribeOOSS():Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_INSCRIBE_OOSS_PR", 11);
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, ooss.getCodOOSS());
			cstmt.setString(2, ooss.getProducto());
			cstmt.setString(3, ooss.getTipInter());
			cstmt.setString(4, ooss.getCodInter());
			cstmt.setString(5, ooss.getNomUsuario());
			cstmt.setString(6, ooss.getComentario());
			cstmt.setString(7, ooss.getCodModulo());
			
			cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

			cstmt.execute(); 

			codError = cstmt.getString(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				ooss.setNroOOSS(String.valueOf(cstmt.getLong(8)));
			}else{
				throw new GeneralException("ERR.09590",numEvento,global.getValor("ERR.09590"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.09590",numEvento,global.getValor("ERR.09590"));
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
		
	}
	
	public UsosLineaVO getUsosLinea(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getUsosLinea():Inicio",nombreClase);
		UsosLineaVO uLinea = new UsosLineaVO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_USOSLINEA_PR", 5);
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, abonadoVtaDTO.getUsoLinea());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
					rs = (ResultSet)cstmt.getObject(2);
					if(rs.next())
					{
						uLinea.setCodUso(new Integer(rs.getInt(1)));
						uLinea.setDesUso(rs.getString(2));
						uLinea.setIndRestplan(new Integer(rs.getInt(3)));
					}
			}else{
				throw new GeneralException("ERR.0001",numEvento,global.getValor("ERR.0001"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.0001",numEvento,global.getValor("ERR.0001"));
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
		logger.info("getUsosLinea():Fin",nombreClase);
		return uLinea;
	}

	/**
	 * Obtiene listado de planes tarifarios
	 * @param abonadoVtaDTO
	 * @return
	 * @throws GeneralException
	 */
	public void getDatosAbonado(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getDatosAbonado():Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		try{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_DATOS_ABONADO_PR", 11);
			cstmt = conn.prepareCall(call);

			System.out.println("1 abonadoVtaDTO.getNumCelular(): [" + abonadoVtaDTO.getNumCelular() + "]");
			cstmt.setLong(1, abonadoVtaDTO.getNumCelular());
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);//oracle.jdbc.driver.OracleTypes.CURSOR
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);//oracle.jdbc.driver.OracleTypes.CURSOR
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);


			if("0".equals(codError))
			{
				abonadoVtaDTO.setCodUso(new Integer(cstmt.getInt(2)).toString());
				System.out.println("abonadoVtaDTO.getCodUso(): [" + abonadoVtaDTO.getCodUso() + "]");
				
				abonadoVtaDTO.setCodTecnologia(cstmt.getString(3));
				System.out.println("abonadoVtaDTO.getCodTecnologia(): [" + abonadoVtaDTO.getCodTecnologia() + "]");
				
				abonadoVtaDTO.setCodPlanTarif(cstmt.getString(4));
				System.out.println("abonadoVtaDTO.getCodPlanTarif(): [" + abonadoVtaDTO.getCodPlanTarif() + "]");
				
				abonadoVtaDTO.setIndPortado(new Integer(cstmt.getInt(5)));
				System.out.println("abonadoVtaDTO.getIndPortado(): [" + abonadoVtaDTO.getIndPortado() + "]");
				
				abonadoVtaDTO.setNumAbonado(new Long(cstmt.getLong(6)));
				System.out.println("abonadoVtaDTO.getNumAbonado(): [" + abonadoVtaDTO.getNumAbonado() + "]");
				
				abonadoVtaDTO.setNumMinMdn(cstmt.getString(7));
				System.out.println("abonadoVtaDTO.getNumMinMdn(): [" + abonadoVtaDTO.getNumMinMdn() + "]");
				
				abonadoVtaDTO.setCodCentral(new Integer(cstmt.getInt(8)));
				System.out.println("abonadoVtaDTO.getCodCentral(): [" + abonadoVtaDTO.getCodCentral() + "]");
			}
			else
			{
				throw new GeneralException("ERR.01126",numEvento,global.getValor("ERR.01126"));
			}

		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01126",numEvento,global.getValor("ERR.01126"));
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
		logger.info("getDatosAbonado():Fin",nombreClase);
	}

	/**
	 * Obtiene listado de planes tarifarios
	 * @param abonadoVtaDTO
	 * @return
	 * @throws GeneralException
	 */
	public PlanesTarifariosDTO getPLanesTarifarios()throws GeneralException
	{
		logger.info("getPLanesTarifarios():Inicio",nombreClase);
		PlanesTarifariosDTO planes = new PlanesTarifariosDTO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_OBTIENE_PLANTARIFARIO_PR(?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_PLANTARIFARIO_PR", 4);
			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);

			if("0".equals(codError))
			{
				try
				{
					rs = (ResultSet)cstmt.getObject(1);
					while(rs.next())
					{
						planes.setCodPlantarif(rs.getString(1));
						planes.setDesPlanTarif(rs.getString(2));
						planes.setLimConsumo(new Integer(rs.getInt(3)));
						planes.setCodCargoBasico(rs.getString(4));
						planes.setNumABonados(new Integer(rs.getInt(5)));
						planes.setIndFamiliar(new Integer(rs.getInt(6)));
						planes.setIndProporcs(new Integer(rs.getInt(7)));
						planes.setIndCargoHabil(new Integer(rs.getInt(8)));
						planes.setNumDiasExpira(new Integer(rs.getInt(9)));
						planes.setCodUso(new Integer(rs.getInt(10)));
					}
					rs.close();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
			else
			{
				throw new GeneralException("ERR.01152",numEvento,global.getValor("ERR.01152"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01152",numEvento,global.getValor("ERR.01152"));
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
		return planes;
	}

	/**
	 * Retorna los planes de  servicios
	 * @param abonadoVtaDTO
	 * @return
	 * @throws GeneralException
	 */
	public PlanesServiciosDTO getPlanesServ(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getPlanesServ():Inicio",nombreClase);
		PlanesServiciosDTO planes = new PlanesServiciosDTO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_PLANSERV_PR", 5);
			cstmt = conn.prepareCall(call);
			System.out.println("abonadoVtaDTO.getCodPlanTarif() para consultar  planServ: "+abonadoVtaDTO.getCodPlanTarif());
			cstmt.setString(1, abonadoVtaDTO.getCodPlanTarif());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				try
				{
					rs = (ResultSet)cstmt.getObject(2);
					if(rs.next())
					{
						System.out.println("trae datos");
						planes.setCodPlanServ(rs.getString(1));
						System.out.println("planes.setCodPlanServ(rs.getString(1)): "+rs.getString(1));
						planes.setDesPlanServ(rs.getString(2));
						System.out.println("planes.setDesPlanServ(rs.getString(2)): "+rs.getString(2));						
					}
					else
					{
						throw new GeneralException("ERR.01151 ",numEvento,global.getValor("ERR.01151 "));
					}
					rs.close();
				}
				catch(GeneralException e)
				{
					e.printStackTrace();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01151",numEvento,global.getValor("ERR.01151"));
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
		logger.info("getPlanesServ():Fin",nombreClase);
		return planes;
	}

	//obtiene los planes de indemnizacion
	public PlanesIndemnizacionDTO getPlanesIndem()throws GeneralException
	{
		logger.info("getPlanesIndem():Inicio",nombreClase);
		PlanesIndemnizacionDTO planes = new PlanesIndemnizacionDTO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_PLANINDEMNIZA_PR", 4);
			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);

			if("0".equals(codError))
			{
				try
				{
					rs = (ResultSet)cstmt.getObject(1);
					if(rs.next())
					{
						planes.setCodPlanIndemnizacion(new Integer(rs.getInt(1)));
						planes.setDesPlanIndemnizacion(rs.getString(2));
					}
					else
					{
						throw new GeneralException("ERR.01150",numEvento,global.getValor("ERR.01150"));
					}
					rs.close();
				}
				catch(GeneralException e)
				{
					e.printStackTrace();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01150",numEvento,global.getValor("ERR.01150"));
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
		logger.info("getPlanesIndem():Fin",nombreClase);
		return planes;
		
	}

	//obtiene imei
	public void obtieneImei(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("obtieneImei():Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_IMEI_PR", 5);
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, abonadoVtaDTO.getNumCelular());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setNumSerieTerminal(cstmt.getString(2));
				System.out.println("Num serie terminal: "+abonadoVtaDTO.getNumSerieTerminal());
			}
			else
			{
				throw new GeneralException("ERR.01157",numEvento,global.getValor("ERR.01157"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01157",numEvento,global.getValor("ERR.01157"));
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
		logger.info("obtieneImei():Fin",nombreClase);
	}

	/**
	 * Obtiene el numero de serie
	 * @param numCelular
	 * @return
	 * @throws GeneralException
	 */
	public void obtieneSerie(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("obtieneSerie():Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_NUM_SERIE_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("abonadoVtaDTO.getNumCelular(): " + abonadoVtaDTO.getNumCelular(), nombreClase);
			cstmt.setLong(1, abonadoVtaDTO.getNumCelular());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			if("0".equals(codError))
			{
				abonadoVtaDTO.setNumSerieSimcard(cstmt.getString(2));
			}
			else
			{
				throw new GeneralException("ERR.01159",numEvento,global.getValor("ERR.01159"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01159",numEvento,global.getValor("ERR.01159"));
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
		logger.info("obtieneSerie():Fin",nombreClase);
	}

	/**
	 * Obtiene codigo de articulo del terminal
	 * @param numSerie
	 * @return
	 * @throws GeneralException
	 */
	public Integer getCodArticulo(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getCodArticulo():Inicio",nombreClase);
		Integer codArticulo = null;
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_COD_ARTICULO_PR", 5);
			cstmt = conn.prepareCall(call);
			System.out.println("IMEI: " + abonadoVtaDTO.getNumImei());
			logger.debug("abonadoVtaDTO.getNumImei(): " + abonadoVtaDTO.getNumImei(), nombreClase);
			System.out.println("IMEI PARA CONSULTAR NUMERO DE SERIE: "+abonadoVtaDTO.getNumImei());
			cstmt.setString(1, abonadoVtaDTO.getNumImei());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			System.out.println("codError: " + codError);
			System.out.println("msgError: " + msgError);
			System.out.println("numEvento: " + numEvento);

			if("0".equals(codError))
			{
				Long articulo = new Long(cstmt.getLong(2));
				abonadoVtaDTO.setCodigoArticuloTerminal(new Integer(articulo.intValue()));
			}
			else
			{
				throw new GeneralException("ERR.01129",numEvento,global.getValor("ERR.01129"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01129",numEvento,global.getValor("ERR.01129"));
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
		logger.info("getCodArticulo():Fin",nombreClase);
		return codArticulo;
	}

	/**
	 * Obtiene datos del equipo (simcard o celular)
	 * @author mwn50746
	 * @param equipoDTO
	 * @throws GeneralException
	 */
	public void getDatosEquipo(EquipoDTO equipoDTO)throws GeneralException
	{
		//MODIFICAR
		System.out.println("getDatosEquipo(): Inicio");
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_DATOS_EQUIPO_PR", 9);
			cstmt = conn.prepareCall(call);

			System.out.println("equipoDTO.getCodArticulo(): [" + equipoDTO.getCodArticulo() + "]");
			cstmt.setInt(1, equipoDTO.getCodArticulo().intValue());
			
			System.out.println("equipoDTO.getNumCelular(): [" + equipoDTO.getNumCelular() + "]");
			cstmt.setLong(2, equipoDTO.getNumCelular().longValue());
			
			System.out.println("equipoDTO.getEquipo(): [" + equipoDTO.getEquipo() + "]");
			cstmt.setString(3, equipoDTO.getEquipo());
			
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);

			logger.debug("codError: " + codError, nombreClase);
			logger.debug("msgError: " + msgError, nombreClase);
			logger.debug("numEvento: " + numEvento, nombreClase);
			
			System.out.println("codError: " + codError);
			System.out.println("msgError: " + msgError);
			System.out.println("numEvento: " + numEvento);

			if("0".equals(codError))
			{
				equipoDTO.setFabricante(cstmt.getString(4));
				System.out.println("equipoDTO.getFabricante()"+equipoDTO.getFabricante());
				equipoDTO.setModelo(cstmt.getString(5));
				System.out.println("equipoDTO.getModelo()"+equipoDTO.getModelo());
				equipoDTO.setCodTipStock(new Integer(cstmt.getInt(6)));
				System.out.println("equipoDTO.getCodTipStock()"+equipoDTO.getCodTipStock());
			}
			else
			{
				throw new GeneralException("ERR.01139",numEvento,global.getValor("ERR.01139"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01139",numEvento,global.getValor("01139"));
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
		System.out.println("getDatosEquipo(): Fin");
	}

	
	public ServiciosSuplementariosDTO[] getServSuplementarios(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getServSuplementarios(): Inicio",nombreClase);

		ServiciosSuplementariosDTO[] arrayServSupl = null;
		ArrayList servicios = null;
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_SERVSUP_PR", 6);
			cstmt = conn.prepareCall(call);
			logger.debug("abonadoVtaDTO.getCodPlanTarif(): " + abonadoVtaDTO.getCodPlanTarif(),nombreClase);
			System.out.println("abonadoVtaDTO.getCodPlanTarif(): " + abonadoVtaDTO.getCodPlanTarif());
			cstmt.setString(1, abonadoVtaDTO.getCodPlanTarif());
			
			logger.debug("abonadoVtaDTO.getCodigoArticulo(): " + abonadoVtaDTO.getCodigoArticulo(),nombreClase);
			System.out.println("abonadoVtaDTO.getCodigoArticulo(): " + abonadoVtaDTO.getCodigoArticulo());
			cstmt.setBigDecimal(2, abonadoVtaDTO.getCodigoArticulo()!=null?new BigDecimal(abonadoVtaDTO.getCodigoArticulo().intValue()):null);
			
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(4);
			msgError = cstmt.getString(5);
			numEvento= cstmt.getInt(6);
			logger.debug("codError: " + codError,nombreClase);
			System.out.println("codError: " + codError);
			logger.debug("msgError: " + msgError,nombreClase);
			System.out.println("msgError: " + msgError);
			logger.debug("numEvento: " + numEvento,nombreClase);
			System.out.println("numEvento: " + numEvento);

			if("0".equals(codError))
			{
				rs = (ResultSet)cstmt.getObject(3);
				servicios = new ArrayList();
				while(rs.next())
				{
					logger.debug("Obtengo servicios", nombreClase);
					ServiciosSuplementariosDTO servSupl = new ServiciosSuplementariosDTO();
					
					servSupl.setCodServicio(rs.getString(1));
					logger.debug("getCodServicio: "+servSupl.getCodServicio(), nombreClase);
					System.out.println("getCodServicio: "+servSupl.getCodServicio());
					
					servSupl.setCodServSupl(rs.getString(2));
					logger.debug("getCodServSupl: "+servSupl.getCodServSupl(), nombreClase);
					System.out.println("getCodServSupl: "+servSupl.getCodServSupl());
					
					servSupl.setCodNivel(rs.getInt(3));
					logger.debug("getCodNivel: "+servSupl.getCodNivel(), nombreClase);
					System.out.println("getCodNivel: "+servSupl.getCodNivel());
					
					servSupl.setCodConcepto1(new Integer(rs.getInt(4)));
					logger.debug("getCodConcepto1: "+servSupl.getCodConcepto1(), nombreClase);
					System.out.println("getCodConcepto1: "+servSupl.getCodConcepto1() + "\n");
					
					servicios.add(servSupl);

				}
				arrayServSupl = ((ServiciosSuplementariosDTO[])servicios.toArray(new ServiciosSuplementariosDTO[servicios.size()]));
			}
			else
			{
				throw new GeneralException("ERR.01154",numEvento,global.getValor("ERR.01154"));
			}

		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01154",numEvento,global.getValor("ERR.01154"));
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
		logger.info("consultaAbonadoPospago():Fin",nombreClase);
		return arrayServSupl;
	}
	
	
	//obtiene los servicios suplementarios
	public ServiciosSuplementariosDTO getCadenaServSuplementarios(AbonadoVtaDTO abonadoDTO, String tipoAbonado)throws GeneralException
	{
		logger.info("getCadenaServSuplementarios(): Inicio",nombreClase);

		ServiciosSuplementariosDTO ServSupl = new ServiciosSuplementariosDTO();		
		String codError = null;
		String msgError = null;
		String accionAct = null;
		String accionDes = null;
		String formatoDes = null;
		String central = null;
		if("nuevo".equals(tipoAbonado)){
			 accionAct = "1";
			 accionDes = "0";
			 formatoDes = "1";
			 central = "0";
		}
		else{
			 accionAct = "3";
			 accionDes = "1";
			 formatoDes = "0";
			 central = "2";	
		}
		
		String estado = null;
		String proc = null;
		String tabla = null;
		String sVAct = null;
		String SVCode = null;
		String SVErrm = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "pv_cadenass_actdes_abo_pr ", 14);
			cstmt = conn.prepareCall(call);
			logger.debug("abonadoDTO.getNumAbonado(): " + abonadoDTO.getNumAbonado(),nombreClase);
			cstmt.setLong(1, abonadoDTO.getNumAbonado().longValue());
			System.out.println("ABONADO PARA CONSULTAR CADENA : "+abonadoDTO.getNumAbonado().longValue());
			cstmt.setString(2, accionAct);
			cstmt.setString(3, accionDes);
			cstmt.setString(4, formatoDes);
			cstmt.setString(5, central);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.execute();

			codError = cstmt.getString(13);
			msgError = cstmt.getString(9);
			numEvento= cstmt.getInt(10);
			estado = cstmt.getString(7);
			proc = cstmt.getString(8);
			tabla = cstmt.getString(11);
			sVAct = cstmt.getString(12);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);

			if("0".equals(codError))
			{
				ServSupl.setCadenaSS(cstmt.getString(6));
				System.out.println("CADENA DEVUELTA : "+ServSupl.getCadenaSS());
			}
			else
			{
				throw new GeneralException("ERR.01171",numEvento,global.getValor("ERR.01171"));
			}

		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01171",numEvento,global.getValor("ERR.01171"));
			}else throw (GeneralException)e;	

		}finally{
			logger.debug("Cerrando conexiones...",nombreClase);
			try {
				if (cstmt != null) cstmt.close();
				if (conn!=null && !conn.isClosed())	conn.close();	
			} catch (SQLException e) {
				logger.error("ERROR: ", nombreClase);
				logger.error("SQLException[" + e + "]",nombreClase);
			}
		}
		logger.info("getServSuplementarios():Fin",nombreClase);
		return ServSupl;
	}

	/**
	 * Obtiene oficina principal
	 * @author mwn50746
	 * @param abonadoVtaDTO
	 * @throws GeneralException
	 */
	public void getOficinaPrincipal(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getOficinaPrincipal(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		DireccionDTO direccion = abonadoVtaDTO.getDireccionDTO();
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_OBTIENE_OFICINA_PR(?,?,?,?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_OFICINA_PR", 7);
			cstmt = conn.prepareCall(call);

			logger.debug("abonadoVtaDTO.getCodRegion(): " + direccion.getCodRegion(),nombreClase);
			System.out.println("abonadoVtaDTO.getCodRegion(): " + direccion.getCodRegion());
			cstmt.setString(1, direccion.getCodRegion());
			logger.debug("abonadoVtaDTO.getCodProvincia(): " + direccion.getCodProvincia(),nombreClase);
			System.out.println("abonadoVtaDTO.getCodProvincia(): " + direccion.getCodProvincia());
			cstmt.setString(2, direccion.getCodProvincia());
			logger.debug("abonadoVtaDTO.getCodCiudad(): " + direccion.getCodCiudad(),nombreClase);
			System.out.println("abonadoVtaDTO.getCodCiudad(): " + direccion.getCodCiudad());
			cstmt.setString(3, direccion.getCodCiudad());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);


			cstmt.execute();

			codError = cstmt.getString(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);

			if("0".equals(codError))
			{
				abonadoVtaDTO.setCodOficina(cstmt.getString(4));			}
			else
			{
				throw new GeneralException("ERR.01149",numEvento,global.getValor("ERR.01149"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01149",numEvento,global.getValor("ERR.01149"));
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
		logger.info("getOficinaPrincipal(): Fin",nombreClase);
	}

	/**
	 * Obtiene fecha de fin de contrato
	 * @author mwn50746
	 * @param tipoContratoSIGADTO
	 * @throws GeneralException
	 */
	public void getFechaFinContrato(TipoContratoSIGADTO tipoContratoSIGADTO)throws GeneralException
	{
		logger.info("getFechaFinContrato(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_FECHA_FINCONTRATO_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("tipoContratoSIGADTO.getNumMeses(): " + tipoContratoSIGADTO.getNumMeses(),nombreClase);
			cstmt.setBigDecimal(1, tipoContratoSIGADTO.getNumMeses()!=null?new BigDecimal(tipoContratoSIGADTO.getNumMeses().intValue()):null);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();
			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				tipoContratoSIGADTO.setFecFinContrato(cstmt.getString(2));
			}
			else
			{
				throw new GeneralException("ERR.01143",numEvento,global.getValor("ERR.01143"));
			}

		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01143",numEvento,global.getValor("ERR.01143"));
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
		logger.info("getFechaFinContrato(): Fin",nombreClase);
	}

	/**
	 * Obtiene el numero del abonado nuevo
	 * @author mwn50746
	 * @param tipoContratoSIGADTO
	 * @throws GeneralException
	 */
	public void getNumAbonado(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getNumAbonado(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;	

		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		try
		{

			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_NUM_ABONADO_PR", 4);
			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);

			if("0".equals(codError))
			{
				abonadoVtaDTO.setNumAbonado(new Long(cstmt.getLong(1)));
			}
			else
			{
				throw new GeneralException("ERR.01145",numEvento,global.getValor("ERR.01145"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01145",numEvento,global.getValor("ERR.01145"));
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
		logger.info("getNumAbonado(): Fin",nombreClase);
	}

	/**
	 * obtiene fecha cumplimiento
	 * @author mwn50746
	 * @param tipoContratoSIGADTO
	 * @throws GeneralException
	 */
	public void getFechaCumplimiento(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getFechaCumplimiento(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_FECHA_CUMPLIMIENTO_PR", 4);
			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.execute();

			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setFecCumplimen(cstmt.getString(1));
			}
			else
			{
				throw new GeneralException("ERR.01142",numEvento,global.getValor("ERR.01142"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01142",numEvento,global.getValor("ERR.01142"));
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
		logger.info("getFechaCumplimiento(): Fin",nombreClase);

	}





	/**
	 * Obtiene prefijo del numero de celular
	 * @author mwn50746
	 * @param tipoContratoSIGADTO
	 * @throws GeneralException
	 */
	public void getPrefijo(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getPrefijo(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn=null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_PREFIJO_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("abonadoVtaDTO.getNumCelular(): " + abonadoVtaDTO.getNumCelular(),nombreClase);
			cstmt.setLong(1, abonadoVtaDTO.getNumCelular());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setPrefijo(new Integer(cstmt.getInt(2)));
			}
			else
			{
				throw new GeneralException("ERR.01153",numEvento,global.getValor("ERR.01153"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01153",numEvento,global.getValor("ERR.01153"));
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
		logger.info("getFechaCumplimiento(): Fin",nombreClase);

	}

	/**
	 * Obtiene código de subalm
	 * @author mwn50746
	 * @param tipoContratoSIGADTO
	 * @throws GeneralException
	 */
	public void getSubalm(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getSubalm(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);

			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_SUBALM_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("abonadoVtaDTO.getNumCelular(): " + abonadoVtaDTO.getNumCelular(),nombreClase);
			cstmt.setLong(1, abonadoVtaDTO.getNumCelular());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();
			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setCodCelda(cstmt.getString(2));
			}
			else
			{
				throw new GeneralException("ERR.01155",numEvento,global.getValor("ERR.01155"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01155",numEvento,global.getValor("ERR.01155"));
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
		logger.info("getSubalm(): Fin",nombreClase);
	}

	//inserta abonado en abocel (postpago)
	public void insertaAbonado(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("insertaAbonado(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);

			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_IN_ga_abocel_PR", 83);
			cstmt = conn.prepareCall(call);
			System.out.println("01 abonadoVtaDTO.getNumAbonado(): [" + abonadoVtaDTO.getNumAbonado() + "]");
			cstmt.setLong(1, abonadoVtaDTO.getNumAbonado().longValue());
			
			System.out.println("02 abonadoVtaDTO.getNumCelular(): [" + abonadoVtaDTO.getNumCelular() + "]");
			cstmt.setLong(2, abonadoVtaDTO.getNumCelular());
			
			System.out.println("03 String.valueOf(1): [" + String.valueOf(1) + "]");
			cstmt.setString(3, String.valueOf(1));//properties
			
			System.out.println("04 abonadoVtaDTO.getCodCliente(): [" + abonadoVtaDTO.getCodCliente() + "]");
			cstmt.setLong(4, abonadoVtaDTO.getCodCliente());
			
			System.out.println("05 abonadoVtaDTO.getCodCuenta(): [" + abonadoVtaDTO.getCodCuenta() + "]");
			cstmt.setLong(5, abonadoVtaDTO.getCodCuenta().longValue());
			
			System.out.println("06 abonadoVtaDTO.getCodSubCuenta(): [" + abonadoVtaDTO.getCodSubCuenta() + "]");
			cstmt.setString(6, abonadoVtaDTO.getCodSubCuenta());
			
			System.out.println("07 abonadoVtaDTO.getCodUsuario(): [" + abonadoVtaDTO.getCodUsuario() + "]");
			cstmt.setLong(7, abonadoVtaDTO.getCodUsuario());
			
			System.out.println("08 abonadoVtaDTO.getCodRegion(): [" + abonadoVtaDTO.getDireccionDTO().getCodRegion() + "]");
			cstmt.setString(8, abonadoVtaDTO.getDireccionDTO().getCodRegion());
			
			System.out.println("09 abonadoVtaDTO.getCodProvincia(): [" + abonadoVtaDTO.getDireccionDTO().getCodProvincia() + "]");
			cstmt.setString(9, abonadoVtaDTO.getDireccionDTO().getCodProvincia());
			
			System.out.println("10 abonadoVtaDTO.getCodCiudad(): [" + abonadoVtaDTO.getDireccionDTO().getCodCiudad() + "]");
			cstmt.setString(10, abonadoVtaDTO.getDireccionDTO().getCodCiudad());
			
			System.out.println("11 abonadoVtaDTO.getCodCelda(): [" + abonadoVtaDTO.getCodCelda() + "]");
			cstmt.setString(11, abonadoVtaDTO.getCodCelda());
			
			System.out.println("12 abonadoVtaDTO.getCodCentral(): [" + abonadoVtaDTO.getCodCentral() + "]");
			cstmt.setInt(12, abonadoVtaDTO.getCodCentral().intValue());
			
			System.out.println("13 abonadoVtaDTO.getCodUso(): [" + abonadoVtaDTO.getCodUso() + "]");
			cstmt.setInt(13, Integer.parseInt(abonadoVtaDTO.getCodUso()));
			
			System.out.println("14 abonadoVtaDTO.getCodSituacion(): [" + abonadoVtaDTO.getCodSituacion() + "]");
			cstmt.setString(14, abonadoVtaDTO.getCodSituacion());
			
			System.out.println("15 abonadoVtaDTO.getIndProcAlta(): [" + abonadoVtaDTO.getIndProcAlta() + "]");
			cstmt.setString(15, abonadoVtaDTO.getIndProcAlta());
			
			System.out.println("16 abonadoVtaDTO.getIndProcEqTerminal(): [" + abonadoVtaDTO.getIndProcEqTerminal() + "]");
			cstmt.setString(16, abonadoVtaDTO.getIndProcEqTerminal());
			
			System.out.println("17 abonadoVtaDTO.getCodVendedor(): [" + abonadoVtaDTO.getCodVendedor() + "]");
			cstmt.setLong(17, abonadoVtaDTO.getCodVendedor());
			
			System.out.println("18 abonadoVtaDTO.getCodVendedorAgente(): [" + abonadoVtaDTO.getCodVendedorAgente() + "]");
			cstmt.setLong(18, abonadoVtaDTO.getCodVendedorAgente());
			
			System.out.println("19 abonadoVtaDTO.getTipPlantarif(): [" + abonadoVtaDTO.getTipPlantarif() + "]");
			cstmt.setString(19, abonadoVtaDTO.getTipPlantarif());			
			
			System.out.println("20 abonadoVtaDTO.getTipTerminal(): [" + abonadoVtaDTO.getTipTerminal() + "]");
			cstmt.setString(20, abonadoVtaDTO.getTipTerminal());
			
			System.out.println("21 abonadoVtaDTO.getCodPlanTarif(): [" + abonadoVtaDTO.getCodPlanTarif() + "]");
			cstmt.setString(21, abonadoVtaDTO.getCodPlanTarif());
			
			System.out.println("22 abonadoVtaDTO.getCodCargoBasico(): [" + abonadoVtaDTO.getCodCargoBasico() + "]");
			cstmt.setString(22, abonadoVtaDTO.getCodCargoBasico());
			
			System.out.println("23 abonadoVtaDTO.getCodPlanServ(): [" + abonadoVtaDTO.getCodPlanServ() + "]");
			cstmt.setString(23, abonadoVtaDTO.getCodPlanServ());
			
			System.out.println("24 abonadoVtaDTO.getCodLimConsumo(): [" + abonadoVtaDTO.getCodLimConsumo() + "]");
			cstmt.setString(24, abonadoVtaDTO.getCodLimConsumo());
			
			System.out.println("25 abonadoVtaDTO.getNumSerieSimcard(): [" + abonadoVtaDTO.getNumSerieSimcard() + "]");
			cstmt.setString(25, abonadoVtaDTO.getNumSerieSimcard());
			
			System.out.println("26 abonadoVtaDTO.getNumSerieHex(): [" + abonadoVtaDTO.getNumSerieHex() + "]");
			cstmt.setString(26, abonadoVtaDTO.getNumSerieHex());
			
			System.out.println("27 abonadoVtaDTO.getNomUsuarOra(): [" + abonadoVtaDTO.getNomUsuarOra() + "]");
			cstmt.setString(27, abonadoVtaDTO.getNomUsuarOra());
			
			//System.out.println("28 abonadoVtaDTO.getFecAlta(): [" + abonadoVtaDTO.getFecAlta() + "]");
			//cstmt.setString(28, abonadoVtaDTO.getFecAlta());
			
			System.out.println("28 abonadoVtaDTO.getNumPerContrato(): [" + abonadoVtaDTO.getNumPerContrato() + "]");
			cstmt.setInt(28, abonadoVtaDTO.getNumPerContrato());
			
			System.out.println("29 abonadoVtaDTO.getCodigoEstado(): [" + abonadoVtaDTO.getCodigoEstado() + "]");
			cstmt.setString(29, abonadoVtaDTO.getCodigoEstado());
			
			System.out.println("30 abonadoVtaDTO.getNumSerieMec(): [" + abonadoVtaDTO.getNumSerieMec() + "]");
			cstmt.setString(30, abonadoVtaDTO.getNumSerieMec());
			
			System.out.println("31 null");
			cstmt.setString(31, null);
			
			System.out.println("32 abonadoVtaDTO.getCodEmpresa(): [" + abonadoVtaDTO.getNumAbonado() + "]");
			cstmt.setString(32, null); //no aplica para empresa

			System.out.println("33 abonadoVtaDTO.getCodGrpSrv(): [" + abonadoVtaDTO.getCodGrpSrv() + "]");
			cstmt.setString(33, abonadoVtaDTO.getCodGrpSrv());
			
			System.out.println("34 abonadoVtaDTO.getIndSuperTel(): [" + abonadoVtaDTO.getIndSuperTel() + "]");
			cstmt.setInt(34, abonadoVtaDTO.getIndSuperTel());
			
			System.out.println("35 abonadoVtaDTO.getNumTeleFija(): [" + abonadoVtaDTO.getNumTeleFija() + "]");
			cstmt.setString(35, abonadoVtaDTO.getNumTeleFija());
			
			System.out.println("36 null");
			cstmt.setString(36, null);
			
			System.out.println("37 null");
			cstmt.setString(37, null);
			
			System.out.println("38 abonadoVtaDTO.getIndPrepago(): [" + abonadoVtaDTO.getIndPrepago() + "]");
			cstmt.setInt(38, abonadoVtaDTO.getIndPrepago());
			
			System.out.println("39 abonadoVtaDTO.getIndPlexSys(): [" + abonadoVtaDTO.getIndPlexSys() + "]");
			cstmt.setInt(39, abonadoVtaDTO.getIndPlexSys());
			
			System.out.println("40 abonadoVtaDTO.getCodCentralPlex(): [" + abonadoVtaDTO.getCodCentralPlex() + "]");
			cstmt.setInt(40, abonadoVtaDTO.getCodCentralPlex());
			
			System.out.println("41 abonadoVtaDTO.getNumCelularPlex(): [" + abonadoVtaDTO.getNumCelularPlex() + "]");
			cstmt.setLong(41, abonadoVtaDTO.getNumCelularPlex());
			
			System.out.println("42 abonadoVtaDTO.getNumVenta(): [" + abonadoVtaDTO.getNumVenta() + "]");
			cstmt.setLong(42, abonadoVtaDTO.getNumVenta());
			
			System.out.println("43 abonadoVtaDTO.getCodModVenta(): [" + abonadoVtaDTO.getCodModVenta() + "]");
			cstmt.setLong(43, abonadoVtaDTO.getCodModVenta());
			
			System.out.println("44 abonadoVtaDTO.getCodTipContrato(): [" + abonadoVtaDTO.getCodTipContrato() + "]");
			cstmt.setString(44, abonadoVtaDTO.getCodTipContrato());
			
			System.out.println("45 abonadoVtaDTO.getNumContrato(): [" + abonadoVtaDTO.getNumContrato() + "]");
			cstmt.setString(45, abonadoVtaDTO.getNumContrato());
			
			System.out.println("46 abonadoVtaDTO.getNumAnexo(): [" + abonadoVtaDTO.getNumAnexo() + "]");
			cstmt.setString(46, abonadoVtaDTO.getNumAnexo());
			
			System.out.println("47 abonadoVtaDTO.getFecCumPlan(): [" + abonadoVtaDTO.getFecCumPlan() + "]");
			cstmt.setString(47, abonadoVtaDTO.getFecCumPlan());
			
			//System.out.println("48 abonadoVtaDTO.getCodCredMor(): [" + abonadoVtaDTO.getCodCredMor() + "]");
			//cstmt.setInt(48, abonadoVtaDTO.getCodCredMor().intValue());
			
			//System.out.println("49 abonadoVtaDTO.getCodCredCon(): [" + abonadoVtaDTO.getCodCredCon() + "]");
			//cstmt.setInt(49, abonadoVtaDTO.getCodCredCon().intValue());
			
			System.out.println("48 abonadoVtaDTO.getCodCiclo(): [" + abonadoVtaDTO.getCodCiclo() + "]");
			cstmt.setInt(48, abonadoVtaDTO.getCodCiclo().intValue());
			
			System.out.println("49 abonadoVtaDTO.getCodFactur(): [" + abonadoVtaDTO.getCodFactur() + "]");
			cstmt.setInt(49, abonadoVtaDTO.getCodFactur());// revisar dato
			
			System.out.println("50 abonadoVtaDTO.getIndSuspen(): [" + abonadoVtaDTO.getIndSuspen() + "]");
			cstmt.setInt(50, abonadoVtaDTO.getIndSuspen());
			
			System.out.println("51 abonadoVtaDTO.getIndReHabi(): [" + abonadoVtaDTO.getIndReHabi() + "]");
			cstmt.setInt(51, abonadoVtaDTO.getIndReHabi());
			
			System.out.println("52 abonadoVtaDTO.getInsGuias(): [" + abonadoVtaDTO.getInsGuias() + "]");
			cstmt.setInt(52, abonadoVtaDTO.getInsGuias());
			
			System.out.println("53 abonadoVtaDTO.getFecFinContra(): [" + abonadoVtaDTO.getFecFinContra() + "]");
			cstmt.setString(53, abonadoVtaDTO.getFecFinContra());
			
			System.out.println("54 abonadoVtaDTO.getFecRecDocu(): [" + abonadoVtaDTO.getFecRecDocu() + "]");
			cstmt.setString(54, abonadoVtaDTO.getFecRecDocu());
			
			System.out.println("55 abonadoVtaDTO.getFecCumplimen(): [" + abonadoVtaDTO.getFecCumplimen() + "]");
			cstmt.setString(55, abonadoVtaDTO.getFecCumplimen());
			
			System.out.println("56 abonadoVtaDTO.getFecAcepVenta(): [" + abonadoVtaDTO.getFecAcepVenta() + "]");
			cstmt.setString(56, abonadoVtaDTO.getFecAcepVenta());
			
			System.out.println("57 abonadoVtaDTO.getFecActCen(): [" + abonadoVtaDTO.getFecActCen() + "]");
			cstmt.setString(57, abonadoVtaDTO.getFecActCen());
			
			System.out.println("58 abonadoVtaDTO.getFecBaja(): [" + abonadoVtaDTO.getFecBaja() + "]");
			cstmt.setString(58, abonadoVtaDTO.getFecBaja());
			
			System.out.println("59 abonadoVtaDTO.getFecBajaCen(): [" + abonadoVtaDTO.getFecBajaCen() + "]");
			cstmt.setString(59, abonadoVtaDTO.getFecBajaCen());
			
			System.out.println("60 abonadoVtaDTO.getFecUltMod(): [" + abonadoVtaDTO.getFecUltMod() + "]");
			cstmt.setString(60, abonadoVtaDTO.getFecUltMod());
			///INC 148385
			//System.out.println("61 abonadoVtaDTO.getCodCausaBaja(): [" + abonadoVtaDTO.getCodCausaBaja() + "]");
			//cstmt.setString(61, abonadoVtaDTO.getCodCausaBaja());
			System.out.println("61 abonadoVtaDTO.getCodCausaBaja(): [null]");
			cstmt.setString(61, null);
			logger.info("61 abonadoVtaDTO.getCodCausaBaja(): [null]",nombreClase);
			// FIN 148385
			System.out.println("62 abonadoVtaDTO.getNumPersonal(): [" + abonadoVtaDTO.getNumPersonal() + "]");
			cstmt.setString(62, abonadoVtaDTO.getNumPersonal());
			
			System.out.println("63 abonadoVtaDTO.getIndSeguro(): [" + abonadoVtaDTO.getIndSeguro() + "]");
			cstmt.setInt(63, abonadoVtaDTO.getIndSeguro());
			
			System.out.println("64 abonadoVtaDTO.getClaseServicio(): [" + abonadoVtaDTO.getClaseServicio() + "]");
			cstmt.setString(64, abonadoVtaDTO.getClaseServicio());
			
			System.out.println("65 abonadoVtaDTO.getPerfilAbonado(): [" + abonadoVtaDTO.getPerfilAbonado() + "]");
			cstmt.setString(65, abonadoVtaDTO.getPerfilAbonado());
			
			//System.out.println("66 abonadoVtaDTO.getNumMin(): [" + abonadoVtaDTO.getNumMin() + "]");
			//cstmt.setString(66, abonadoVtaDTO.getNumMin());
			
			System.out.println("66 abonadoVtaDTO.codVendealer(): [" + abonadoVtaDTO.getCodVendealer() + "]");
			cstmt.setString(66, String.valueOf(abonadoVtaDTO.getCodVendealer()));
			
			System.out.println("67 null");
			cstmt.setString(67, null);
			
			System.out.println("68 abonadoVtaDTO.getCodPassword(): [" + abonadoVtaDTO.getCodPassword() + "]");
			cstmt.setString(68, abonadoVtaDTO.getCodPassword());
			
			System.out.println("69 abonadoVtaDTO.getIndPassword(): [" + abonadoVtaDTO.getIndPassword() + "]");
			cstmt.setString(69, abonadoVtaDTO.getIndPassword());
			
			System.out.println("70 abonadoVtaDTO.getCodAfinidad(): [" + abonadoVtaDTO.getCodAfinidad() + "]");
			cstmt.setInt(70, abonadoVtaDTO.getCodAfinidad());
			
			System.out.println("71 abonadoVtaDTO.getFecProrroga(): [" + abonadoVtaDTO.getFecProrroga() + "]");
			cstmt.setString(71, abonadoVtaDTO.getFecProrroga());
			
			System.out.println("72 abonadoVtaDTO.getIndComodato(): [" + abonadoVtaDTO.getIndComodato() + "]");
			cstmt.setString(72,abonadoVtaDTO.getIndComodato());			
			
			System.out.println("73 abonadoVtaDTO.getFlgContDigi(): [" + abonadoVtaDTO.getFlgContDigi() + "]");
			cstmt.setString(73, abonadoVtaDTO.getFlgContDigi());
			
			System.out.println("74 abonadoVtaDTO.getFecAltanTras(): [" + abonadoVtaDTO.getFecAltanTras() + "]");
			cstmt.setString(74, abonadoVtaDTO.getFecAltanTras());
			
			System.out.println("75 abonadoVtaDTO.getCodIndemnizacion(): [" + abonadoVtaDTO.getCodIndemnizacion() + "]");
			cstmt.setInt(75, abonadoVtaDTO.getCodIndemnizacion());
			
			System.out.println("76 abonadoVtaDTO.getNumImei(): [" + abonadoVtaDTO.getNumImei() + "]");
			cstmt.setString(76, abonadoVtaDTO.getNumImei());
			
			System.out.println("77 abonadoVtaDTO.getCodTecnologia(): [" + abonadoVtaDTO.getCodTecnologia() + "]");
			cstmt.setString(77, abonadoVtaDTO.getCodTecnologia());
			
			System.out.println("78 abonadoVtaDTO.getNumMinMdn(): [" + abonadoVtaDTO.getNumMinMdn() + "]");
			cstmt.setString(78, abonadoVtaDTO.getNumMinMdn());
			
			System.out.println("79 abonadoVtaDTO.getFecActivacion(): [" + abonadoVtaDTO.getFecActivacion() + "]");
			cstmt.setString(79, abonadoVtaDTO.getFecActivacion());
			
			System.out.println("80 abonadoVtaDTO.getCodOficinaPrincipal(): [" + abonadoVtaDTO.getCodOficinaPrincipal() + "]");
			cstmt.setString(80, abonadoVtaDTO.getCodOficinaPrincipal());

			cstmt.registerOutParameter(81, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(82, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(83, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(81);
			msgError = cstmt.getString(82);
			numEvento = cstmt.getInt(83);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			System.out.println("codError: " + codError);
			System.out.println("msgError: " + msgError);
			System.out.println("numEvento: " + numEvento);
			if (codError.equals("0")) 
			{
				//abonado.setNumAbonado(abonadoVtaDTO.getNumAbonado());
			}
			else
			{
				throw new GeneralException(	"ERR.01117",numEvento,global.getValor("ERR.01117"));
			}


		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01117",numEvento,global.getValor("ERR.01117"));
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
		logger.info("insertaAbonado(): Fin",nombreClase);

	}

	/**
	 * Inserta el Equipo
	 * @param equipoVtaDTO
	 * @throws GeneralException
	 */
	public void insertaEquipo(EquipoVtaDTO equipoVtaDTO)throws GeneralException
	{
		System.out.println("insertaEquipo(): Inicio");
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_IN_GA_EQUIPABOSER_PR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_IN_GA_EQUIPABOSER_PR", 31);
			cstmt = conn.prepareCall(call);
			
			System.out.println(" 1 equipoVtaDTO.getNumAbonado(): [" + equipoVtaDTO.getNumAbonado() + "]");
			cstmt.setLong(1, equipoVtaDTO.getNumAbonado().longValue());
			
			System.out.println(" 2 equipoVtaDTO.getNumSerie(): [" + equipoVtaDTO.getNumSerie() + "]");
			cstmt.setString(2, equipoVtaDTO.getNumSerie());
			
			System.out.println(" 3 equipoVtaDTO.getCodProducto(): [" + equipoVtaDTO.getCodProducto() + "]");
			cstmt.setLong(3, equipoVtaDTO.getCodProducto().longValue());
			
			System.out.println(" 4 equipoVtaDTO.getIndProcequi(): [" + equipoVtaDTO.getIndProcequi() + "]");
			cstmt.setString(4, equipoVtaDTO.getIndProcequi());
			
			System.out.println(" 5 equipoVtaDTO.getFechaAlta(): [" + equipoVtaDTO.getFechaAlta() + "]");
			cstmt.setString(5, equipoVtaDTO.getFechaAlta());
			
			System.out.println(" 6 equipoVtaDTO.getIndPropiedad(): [" + equipoVtaDTO.getIndPropiedad() + "]");
			cstmt.setString(6, equipoVtaDTO.getIndPropiedad());
			
			String bodega = null;
			if (equipoVtaDTO.getCodBodega() != null){
				bodega = String.valueOf(equipoVtaDTO.getCodBodega());
			}
			System.out.println(" 7 equipoVtaDTO.getCodBodega(): [" + bodega + "]");
			cstmt.setString(7, bodega);
			
			System.out.println(" 8 equipoVtaDTO.getTipStock(): [" + equipoVtaDTO.getTipStock() + "]");
			cstmt.setString(8, equipoVtaDTO.getTipStock());
			
			System.out.println(" 9 equipoVtaDTO.getCodArticulo(): [" + equipoVtaDTO.getCodArticulo() + "]");
			cstmt.setLong(9, equipoVtaDTO.getCodArticulo().longValue());
			
			System.out.println("10 equipoVtaDTO.getIndEquiacc(): [" + equipoVtaDTO.getIndEquiacc() + "]");
			cstmt.setString(10, equipoVtaDTO.getIndEquiacc());
			
			System.out.println("11 equipoVtaDTO.getCodModVenta(): [" + equipoVtaDTO.getCodModVenta() + "]");
			cstmt.setString(11, equipoVtaDTO.getCodModVenta());
			
			System.out.println("12 equipoVtaDTO.getTipTerminal(): [" + equipoVtaDTO.getTipTerminal() + "]");
			cstmt.setString(12, equipoVtaDTO.getTipTerminal());
			
			System.out.println("13 equipoVtaDTO.getCodUso(): [" + equipoVtaDTO.getCodUso() + "]");
			cstmt.setLong(13, equipoVtaDTO.getCodUso().longValue());
			
			System.out.println("14 equipoVtaDTO.getCodCuota(): [" + equipoVtaDTO.getCodCuota() + "]");
			cstmt.setString(14, equipoVtaDTO.getCodCuota());
			
			System.out.println("15 equipoVtaDTO.getCodEstado(): [" + equipoVtaDTO.getCodEstado() + "]");
			cstmt.setString(15, equipoVtaDTO.getCodEstado());
			
			System.out.println("16 equipoVtaDTO.getCapCode(): [" + equipoVtaDTO.getCapCode() + "]");
			cstmt.setString(16, equipoVtaDTO.getCapCode());
			
			System.out.println("17 equipoVtaDTO.getCodProtocolo(): [" + equipoVtaDTO.getCodProtocolo() + "]");
			cstmt.setString(17, equipoVtaDTO.getCodProtocolo());
			
			System.out.println("18 equipoVtaDTO.getNumVelocidad(): [" + equipoVtaDTO.getNumVelocidad() + "]");
			cstmt.setString(18, equipoVtaDTO.getNumVelocidad());
			
			System.out.println("19 equipoVtaDTO.getCodFrecuencia(): [" + equipoVtaDTO.getCodFrecuencia() + "]");
			cstmt.setString(19, equipoVtaDTO.getCodFrecuencia());
			
			System.out.println("20 equipoVtaDTO.getCodVersion(): [" + equipoVtaDTO.getCodVersion() + "]");
			cstmt.setString(20, equipoVtaDTO.getCodVersion());
			
			System.out.println("21 equipoVtaDTO.getNumSerieMec(): [" + equipoVtaDTO.getNumSerieMec() + "]");
			cstmt.setString(21, equipoVtaDTO.getNumSerieMec());
			
			System.out.println("22 equipoVtaDTO.getDesEquipo(): [" + equipoVtaDTO.getDesEquipo() + "]");
			cstmt.setString(22, equipoVtaDTO.getDesEquipo());
			
			System.out.println("23 equipoVtaDTO.getCodPaquete(): [" + equipoVtaDTO.getCodPaquete() + "]");
			cstmt.setString(23, equipoVtaDTO.getCodPaquete());
			
			System.out.println("24 equipoVtaDTO.getNumMovimiento(): [" + equipoVtaDTO.getNumMovimiento() + "]");
			cstmt.setString(24, null); //no hay movimiento en logistica
			
			System.out.println("25 equipoVtaDTO.getCodCausa(): [" + equipoVtaDTO.getCodCausa() + "]");
			cstmt.setString(25, equipoVtaDTO.getCodCausa());
			
			System.out.println("26 equipoVtaDTO.getIndEqPrestado(): [" + equipoVtaDTO.getIndEqPrestado() + "]");
			cstmt.setString(26, equipoVtaDTO.getIndEqPrestado());
			
			System.out.println("27 equipoVtaDTO.getNumImei(): [" + equipoVtaDTO.getNumImei() + "]");
			cstmt.setString(27, String.valueOf(equipoVtaDTO.getNumImei()));
			
			System.out.println("28 equipoVtaDTO.getCodTecnologia(): [" + equipoVtaDTO.getCodTecnologia() + "]");
			cstmt.setString(28, equipoVtaDTO.getCodTecnologia());
			
			cstmt.registerOutParameter(29, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(30, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(31, java.sql.Types.NUMERIC);

			cstmt.execute();
			codError = cstmt.getString(29);
			msgError = cstmt.getString(30);
			numEvento = cstmt.getInt(31);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if (!"0".equalsIgnoreCase(codError))
			{
				throw new GeneralException("ERR.01118",numEvento,global.getValor("ERR.01118"));
			}					
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01118",numEvento,global.getValor("ERR.01118"));
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
		logger.info("insertaEquipo(): Fin",nombreClase);
	}

	/**
	 * Inserta servicios suplementarios
	 * @param serviciosSuplementariosVtaDTO
	 * @throws GeneralException
	 */
	public void insertaServSupl(ServiciosSuplementariosVtaDTO serviciosSuplementariosVtaDTO)throws GeneralException
	{
		logger.info("insertaServSupl(): Fin",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;

		Connection conn = null;
//		conn = getConection();
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_IN_GA_SERVSUPLABO_PR(?,?,?,?,?,?,?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_IN_GA_SERVSUPLABO_PR", 10);
			cstmt = conn.prepareCall(call);
			logger.debug("serviciosSuplementariosVtaDTO.getNumAbonado(): " + serviciosSuplementariosVtaDTO.getNumAbonado(),nombreClase);
			System.out.println("serviciosSuplementariosVtaDTO.getNumAbonado(): " + serviciosSuplementariosVtaDTO.getNumAbonado());
			cstmt.setLong(1, serviciosSuplementariosVtaDTO.getNumAbonado().longValue());
			
			logger.debug("serviciosSuplementariosVtaDTO.getCodServicio(): " + serviciosSuplementariosVtaDTO.getCodServicio(),nombreClase);
//			cstmt.setLong(2, serviciosSuplementariosVtaDTO.getCodServicio().longValue());
			System.out.println("serviciosSuplementariosVtaDTO.getCodServicio(): " + serviciosSuplementariosVtaDTO.getCodServicio());
			cstmt.setString(2, serviciosSuplementariosVtaDTO.getCodServicio());
			
			logger.debug("serviciosSuplementariosVtaDTO.getNumTerminal(): " + serviciosSuplementariosVtaDTO.getNumTerminal(),nombreClase);
			System.out.println("serviciosSuplementariosVtaDTO.getNumTerminal(): " + serviciosSuplementariosVtaDTO.getNumTerminal());
			cstmt.setString(3, serviciosSuplementariosVtaDTO.getNumTerminal());
			
			logger.debug("serviciosSuplementariosVtaDTO.getCodServSuplabo(): " + serviciosSuplementariosVtaDTO.getCodServSuplabo(),nombreClase);
			System.out.println("serviciosSuplementariosVtaDTO.getCodServSuplabo(): " + serviciosSuplementariosVtaDTO.getCodServSuplabo());
			cstmt.setLong(4, serviciosSuplementariosVtaDTO.getCodServSuplabo().longValue());
			
			logger.debug("serviciosSuplementariosVtaDTO.getCodConcepto(): " + serviciosSuplementariosVtaDTO.getCodConcepto(),nombreClase);
			System.out.println("serviciosSuplementariosVtaDTO.getCodConcepto(): " + serviciosSuplementariosVtaDTO.getCodConcepto());
			cstmt.setLong(5, serviciosSuplementariosVtaDTO.getCodConcepto().longValue());
			
			logger.debug("serviciosSuplementariosVtaDTO.getCodNivel(): " + serviciosSuplementariosVtaDTO.getCodNivel(),nombreClase);
			System.out.println("serviciosSuplementariosVtaDTO.getCodNivel(): " + serviciosSuplementariosVtaDTO.getCodNivel());
			cstmt.setLong(6, serviciosSuplementariosVtaDTO.getCodNivel().longValue());
			
			logger.debug("serviciosSuplementariosVtaDTO.getUsuario(): " + serviciosSuplementariosVtaDTO.getUsuario(),nombreClase);
			System.out.println("serviciosSuplementariosVtaDTO.getUsuario(): " + serviciosSuplementariosVtaDTO.getUsuario());
			cstmt.setString(7, serviciosSuplementariosVtaDTO.getUsuario());
			
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			cstmt.execute();
			codError = cstmt.getString(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			logger.debug("codError: " + codError,nombreClase);
			System.out.println("codError: " + codError);
			logger.debug("msgError: " + msgError,nombreClase);
			System.out.println("msgError: " + msgError);
			logger.debug("numEvento: " + numEvento,nombreClase);
			System.out.println("numEvento: " + numEvento + "\n");
			if(!"0".equalsIgnoreCase(codError))
			{
				throw new GeneralException("ERR.01120",numEvento,global.getValor("ERR.01120"));
			}

		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01120",numEvento,global.getValor("ERR.01120"));
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
		logger.info("insertaServSupl(): Fin",nombreClase);
	}

	/**
	 * Inserta venta
	 * @param serviciosSuplementariosVtaDTO
	 * @throws GeneralException
	 */
	public void insertaVenta(VentaDTO ventaDTO)throws GeneralException
	{
		logger.info("insertaVenta(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_IN_GA_VENTAS_PR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_IN_GA_VENTAS_PR", 25);
			cstmt = conn.prepareCall(call);
			
			System.out.println(" 1 ventaDTO.getNumVenta(): " + ventaDTO.getNumVenta());
			cstmt.setLong(1, ventaDTO.getNumVenta().longValue());
			
			System.out.println(" 2 ventaDTO.getCodOficina(): " + ventaDTO.getCodOficina());
			cstmt.setString(2, ventaDTO.getCodOficina()); 
			
			System.out.println(" 3 ventaDTO.getCodVendedor(): " + ventaDTO.getCodVendedor());
			cstmt.setLong(3, ventaDTO.getCodVendedor().longValue());
			
			System.out.println(" 4 ventaDTO.getCodVendedorAgente(): " + ventaDTO.getCodVendedorAgente());
			cstmt.setLong(4, ventaDTO.getCodVendedorAgente().longValue());
			
			System.out.println(" 5 ventaDTO.getCodRegion(): " + ventaDTO.getCodRegion());
			cstmt.setString(5, ventaDTO.getCodRegion());
			
			System.out.println(" 6 ventaDTO.getCodProvincia(): " + ventaDTO.getCodProvincia());
			cstmt.setString(6, ventaDTO.getCodProvincia());
			
			System.out.println(" 7 ventaDTO.getCodCiudad(): " + ventaDTO.getCodCiudad());
			cstmt.setString(7, ventaDTO.getCodCiudad()); 
			
			System.out.println(" 8 ventaDTO.getImpVenta(): " + ventaDTO.getImpVenta());
			cstmt.setLong(8, ventaDTO.getImpVenta().longValue());
			
			System.out.println(" 9 ventaDTO.getIndEstVenta(): " + ventaDTO.getIndEstVenta());
			cstmt.setString(9, ventaDTO.getIndEstVenta());
			
			System.out.println("10 ventaDTO.getTipContrato(): " + ventaDTO.getTipContrato());
			cstmt.setString(10, ventaDTO.getTipContrato());
			
			System.out.println("11 ventaDTO.getCodCliente(): " + ventaDTO.getCodCliente());
			cstmt.setLong(11, ventaDTO.getCodCliente().longValue());
			
			System.out.println("12 ventaDTO.getModVenta(): " + ventaDTO.getModVenta());
			cstmt.setString(12, ventaDTO.getModVenta()); 
			
			System.out.println("13 ventaDTO.getCodMoneda(): " + ventaDTO.getCodMoneda());
			cstmt.setString(13, ventaDTO.getCodMoneda());
			
			System.out.println("14 ventaDTO.getNumContrato(): " + ventaDTO.getNumContrato());
			cstmt.setString(14, ventaDTO.getNumContrato());
			
			System.out.println("15 ventaDTO.getIndOfiter(): " + ventaDTO.getIndOfiter());
			cstmt.setString(15, ventaDTO.getIndOfiter());
			
			System.out.println("16 ventaDTO.getNomUsuarVta(): " + ventaDTO.getNomUsuarVta());
			cstmt.setString(16, ventaDTO.getNomUsuarVta());
			
			System.out.println("17 ventaDTO.getTipFoliacion(): " + ventaDTO.getTipFoliacion());
			cstmt.setString(17, ventaDTO.getTipFoliacion()); 
			
			System.out.println("18 ventaDTO.getCodTipDoc(): " + ventaDTO.getCodTipDoc());
			cstmt.setString(18, ventaDTO.getCodTipDoc());
			
			System.out.println("19 ventaDTO.getCodPlaza(): " + ventaDTO.getCodPlaza());
			cstmt.setString(19, ventaDTO.getCodPlaza());
			
			System.out.println("20 ventaDTO.getCodOperadora(): " + ventaDTO.getCodOperadora());
			cstmt.setString(20, ventaDTO.getCodOperadora());
			
			System.out.println("21 ventaDTO.getChkDicom(): " + ventaDTO.getChkDicom());
			cstmt.setString(21, ventaDTO.getChkDicom());
			
			System.out.println("22 ventaDTO.getCodVenDealer(): " + ventaDTO.getCodVenDealer());
			cstmt.setString(22, ventaDTO.getCodVenDealer());
			
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);

			cstmt.execute();
			codError = cstmt.getString(23);
			msgError = cstmt.getString(24);
			numEvento = cstmt.getInt(25);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if (!"0".equalsIgnoreCase(codError)){
				throw new GeneralException("ERR.01121",numEvento,global.getValor("ERR.01121"));
			}			
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01121",numEvento,global.getValor("01121"));
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
		logger.info("insertaServSupl(): Fin",nombreClase);
	}
	/**
	 * Obtiene numero de venta
	 * @param ventaDTO
	 * @throws GeneralException
	 */
	public void getNumVenta(VentaDTO ventaDTO)throws GeneralException
	{
		logger.info("getNumVenta(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
//		conn = getConection();
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_NUM_VENTA_PR(?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_NUM_VENTA_PR", 4);
			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); 

			cstmt.execute();
			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			if("0".equals(codError)){
				ventaDTO.setNumVenta(new Long(cstmt.getLong(1)));
			}else{
				throw new GeneralException("ERR.01148",numEvento,global.getValor("ERR.01148"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01148",numEvento,global.getValor("ERR.01148"));
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
		logger.info("getNumVenta(): Fin",nombreClase);
	}

	/**
	 * Obtiene impuesto
	 * @param ventaDTO
	 * @throws GeneralException
	 */
	public void obtieneImpuesto(VentaDTO ventaDTO)throws GeneralException
	{
		logger.info("obtieneImpuesto(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_PCT_IVA_PR", 4);
			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); 


			cstmt.execute();
			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			
			if("0".equals(codError)){
				ventaDTO.setImpVenta(new Long(cstmt.getLong(1)));
			}else{
				throw new GeneralException("ERR.01148",numEvento,global.getValor("ERR.01148"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01148",numEvento,global.getValor("ERR.01148"));
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
		logger.info("obtieneImpuesto(): Fin",nombreClase);
	}
	/**
	 * Obtiene datos del abonado
	 * @param ventaDTO
	 * @throws GeneralException
	 */
	public void getAbonado(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getAbonado(): Inicio",nombreClase);
		AbonadoDTO abonado = new AbonadoDTO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_OBTIENE_PCT_IVA_PR(?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_DATOS_ABONADO_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("abonadoVtaDTO.getNumCelular(): " + abonadoVtaDTO.getNumCelular(),nombreClase);
			cstmt.setLong(1, abonadoVtaDTO.getNumCelular());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			if("0".equals(codError))
			{
				rs  = (ResultSet)cstmt.getObject(2);
				if(rs.next())
				{
					abonado.setCodPlanTarif(rs.getString(3));
					abonado.setIndPortado(new Integer(rs.getInt(4)));
				}
			}
			else
			{
				throw new GeneralException("ERR.01126",numEvento,global.getValor("ERR.01126"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01126",numEvento,global.getValor("ERR.01126"));
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
		logger.info("getAbonado(): Fin",nombreClase);
	}
	/**
	 * Obtiene numero de meses del contrato
	 * @param tipoContratoSIGADTO
	 * @throws GeneralException
	 */
	public void getNumMeses(TipoContratoSIGADTO tipoContratoSIGADTO)throws GeneralException
	{
		logger.info("getNumMeses(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_MESES_CONTRATO_PR", 5);
			cstmt = conn.prepareCall(call);
		
			logger.debug("tipoContratoSIGADTO.getCodTipContrato(): " + tipoContratoSIGADTO.getCodTipContrato(),nombreClase);
			cstmt.setString(1, tipoContratoSIGADTO.getCodTipContrato());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			
			if("0".equals(codError))
			{
				tipoContratoSIGADTO.setNumMeses(new Integer(cstmt.getInt(2)));
			}
			else
			{
				throw new GeneralException("ERR.01147",numEvento,global.getValor("ERR.01147"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01147",numEvento,global.getValor("ERR.01147"));
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
		logger.info("getNumMeses(): Fin",nombreClase);
	}

	/**
	 * Inserta movimiento
	 * @param movimientoDTO
	 * @throws GeneralException
	 */
	public void insertaMovimiento(MovimientoDTO movimientoDTO)throws GeneralException
	{
		logger.info("insertaMovimiento(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_IN_ICC_MOVIMIENTO_PR", 14);
			cstmt = conn.prepareCall(call);
			/*logger.debug("movimientoDTO.getNumAbonado(): " + movimientoDTO.getNumAbonado(),nombreClase);
			cstmt.setLong(1, movimientoDTO.getNumAbonado().longValue());
			logger.debug("movimientoDTO.getNomUsuario(): " + movimientoDTO.getNomUsuario(),nombreClase);
			cstmt.setString(2, movimientoDTO.getNomUsuario());
			logger.debug("movimientoDTO.getCodCentral(): " + movimientoDTO.getCodCentral(),nombreClase);
			cstmt.setLong(3, movimientoDTO.getCodCentral().longValue());
			logger.debug("movimientoDTO.getNumCelular(): " + movimientoDTO.getNumCelular(),nombreClase);
			cstmt.setLong(4, movimientoDTO.getNumCelular().longValue());
			logger.debug("movimientoDTO.getNumSerie(): " + movimientoDTO.getNumSerie(),nombreClase);
			cstmt.setLong(5, movimientoDTO.getNumSerie().longValue());
			logger.debug("movimientoDTO.getCodActabo(): " + movimientoDTO.getCodActabo(),nombreClase);
			cstmt.setString(6, movimientoDTO.getCodActabo());
			logger.debug("movimientoDTO.getNumImei(): " + movimientoDTO.getNumImei(),nombreClase);*/
			
			System.out.println("01 movimientoDTO.getNumAbonado()=[" + movimientoDTO.getNumAbonado() + "]");
			cstmt.setLong(1, movimientoDTO.getNumAbonado().longValue());
			
			System.out.println("02 movimientoDTO.getNomUsuario()=[" + movimientoDTO.getNomUsuario() + "]");
			cstmt.setString(2, movimientoDTO.getNomUsuario());
			
			System.out.println("03 movimientoDTO.getCodCentral()=[" + movimientoDTO.getCodCentral() + "]");
			cstmt.setLong(3, movimientoDTO.getCodCentral().longValue());
			
			System.out.println("04 movimientoDTO.getNumCelular()=[" + movimientoDTO.getNumCelular() + "]");
			cstmt.setLong(4, movimientoDTO.getNumCelular().longValue());
			
			System.out.println("05 movimientoDTO.getNumSerie()=[" + movimientoDTO.getNumSerie() + "]");
			cstmt.setLong(5, movimientoDTO.getNumSerie().longValue());
			
			System.out.println("06 movimientoDTO.getCodActabo()=[" + movimientoDTO.getCodActabo() + "]");
			cstmt.setString(6, movimientoDTO.getCodActabo());
			System.out.println("07 movimientoDTO.getNumImei()=[" + movimientoDTO.getNumImei() + "]");
			cstmt.setLong(7, movimientoDTO.getNumImei().longValue());
			
			System.out.println("08 movimientoDTO.getCodServSupl()=[" + movimientoDTO.getCodServSupl() + "]");
			cstmt.setString(8, movimientoDTO.getCodServSupl());
			
			System.out.println("09 movimientoDTO.getCarga()=[" + movimientoDTO.getCarga() + "]");
			if(movimientoDTO.getCarga() == null){
				cstmt.setNull(9, java.sql.Types.NUMERIC);
			}else{
				cstmt.setLong(9,movimientoDTO.getCarga().longValue());
			}
			
			System.out.println("10 movimientoDTO.getPlan()=[" + movimientoDTO.getPlan() + "]");
			cstmt.setString(10, movimientoDTO.getPlan());
			
			System.out.println("11 movimientoDTO.getValorPlan()=[" + movimientoDTO.getValorPlan() + "]");
			cstmt.setString(11, movimientoDTO.getValorPlan());
			
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(12);
			msgError = cstmt.getString(13);
			numEvento = cstmt.getInt(14);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			System.out.println("codError: " + codError);
			System.out.println("msgError: " + msgError);
			System.out.println("numEvento: " + numEvento);
			
			if("1".equalsIgnoreCase(codError)){			
				throw new GeneralException("ERR.000021",numEvento,global.getValor("ERR.000021"));
			} else if(!"0".equalsIgnoreCase(codError)){
				throw new GeneralException("ERR.01119",numEvento,global.getValor("ERR.01119"));
			}
			
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01119",numEvento,global.getValor("ERR.01119"));
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
		logger.info("insertaMovimiento(): Fin",nombreClase);
	}

	/**
	 * Valida que el numero no se encuentre asociado a un abonado
	 * @param numCelular
	 * @return
	 * @throws GeneralException
	 */
	public Boolean numeroSinAbonado(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("numeroSinAbonado(): Inicio",nombreClase);
		Boolean retorno = null;
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_VALIDA_NUMERO_PR(?,?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_VALIDA_NUMERO_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("abonadoVtaDTO.getNumCelular(): " + abonadoVtaDTO.getNumCelular(),nombreClase);
			cstmt.setLong(1, abonadoVtaDTO.getNumCelular());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				if(cstmt.getInt(2) == 0)
				{
					retorno = new Boolean(false);
				}
				else
				{
					retorno = new Boolean(true);
				}
			}
			else
			{
				throw new GeneralException("ERR.01156",numEvento,global.getValor("ERR.01156"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01156",numEvento,global.getValor("ERR.01156"));
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
		logger.info("numeroSinAbonado(): Fin",nombreClase);
		return retorno;
	}

	/**
	 * Obtiene codigo ciclo
	 * @param abonadoVtaDTO
	 * @throws GeneralException
	 */
	public void getCodCiclo(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getCodCiclo(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_COD_CICLO_PR", 5);
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, abonadoVtaDTO.getCodCliente());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			if("0".equals(codError))
			{
				abonadoVtaDTO.setCodCiclo(new Integer(cstmt.getInt(2)));
			}
			else
			{
				throw new GeneralException("ERR.01132",numEvento,global.getValor("ERR.01132"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01132",numEvento,global.getValor("ERR.01132"));
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
		logger.info("getCodCiclo(): Fin",nombreClase);
	}

	/**
	 * Obtiene datos generales para la migracion
	 * @param numIdentCliente
	 * @return
	 * @throws GeneralException
	 */
	public void getDatos(DatosGeneralesDTO datosGeneralesDTO) throws GeneralException
	{
		logger.info("getDatos(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_DATOS_GENERALES_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("datosGeneralesDTO.getNumIdent(): " + datosGeneralesDTO.getNumIdent(),nombreClase);
			cstmt.setString(1, datosGeneralesDTO.getNumIdent());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError));
			{
				rs = (ResultSet)cstmt.getObject(2);
				if(rs.next())
				{
					datosGeneralesDTO.setNumSolicitud(new Long(rs.getLong(1)));
					datosGeneralesDTO.setValCantTerminales(new Long(rs.getLong(2)));
					datosGeneralesDTO.setCodOficina(rs.getString(3));
					datosGeneralesDTO.setCodTipComis(rs.getString(4));
					datosGeneralesDTO.setCodVendedor(rs.getString(5));
					datosGeneralesDTO.setCodVendedorAgente(rs.getString(6));
					datosGeneralesDTO.setCodVendedorDealer(rs.getString(7));
					datosGeneralesDTO.setCodPlanTarif(rs.getString(8));
					datosGeneralesDTO.setCodEstado(rs.getString(9));
					datosGeneralesDTO.setValCantVendidos(rs.getString(10));
				}
				else
				{
					throw new GeneralException("ERR.01138",numEvento,global.getValor("ERR.01138"));
				}
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01138",numEvento,global.getValor("ERR.01138"));
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
		logger.info("getDatos(): Fin",nombreClase);
	}

	/**
	 * Obtiene codigo de cuenta
	 * @param abonadoVtaDTO
	 * @throws GeneralException
	 */
	public void getCodCuenta(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		
		logger.info("getCodCuenta(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_CUENTA_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("abonadoVtaDTO.getCodCliente(): " + abonadoVtaDTO.getCodCliente(),nombreClase);
			cstmt.setLong(1, abonadoVtaDTO.getCodCliente());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setCodCuenta(new Long(cstmt.getLong(2)));
			}
			else
			{
				throw new GeneralException("ERR.01132",numEvento,global.getValor("ERR.01132"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01132",numEvento,global.getValor("ERR.01132"));
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
		logger.info("getCodCuenta(): Fin",nombreClase);
	}

	/**
	 * Obtiene direccion de la cuenta
	 * @param abonadoVtaDTO
	 * @throws GeneralException
	 */
	public void getDireccion(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getDireccion(): Inicio",nombreClase);
		
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_COD_DIRECCION_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("abonadoVtaDTO.getCodCliente(): " + abonadoVtaDTO.getCodCliente(),nombreClase);
			cstmt.setLong(1, abonadoVtaDTO.getCodCliente());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			if("0".equals(codError))
			{
				rs = (ResultSet)cstmt.getObject(2);
				if(rs.next())
				{
					DireccionDTO direccionDTO = new DireccionDTO();
					direccionDTO.setCodRegion(rs.getString(1));
					direccionDTO.setCodProvincia(rs.getString(2));
					direccionDTO.setCodCiudad(rs.getString(3));
					abonadoVtaDTO.setDireccionDTO(direccionDTO);
				}
				else
				{
					throw new GeneralException("ERR.01141",numEvento,global.getValor("ERR.01141"));
				}

			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01141",numEvento,global.getValor("ERR.01141"));
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
		logger.info("getDireccion(): Inicio",nombreClase);
	}

	/**
	 * Obtiene cargo basico asociado al plan tarifario
	 * @param abonadoVtaDTO
	 * @throws GeneralException
	 */
	public void getCargoBasico(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getCargoBasico(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_VALIDA_NUMERO_PR(?,?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_CARGOBASICO_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("abonadoVtaDTO.getCodPlanTarif(): " + abonadoVtaDTO.getCodPlanTarif(),nombreClase);
			cstmt.setString(1, abonadoVtaDTO.getCodPlanTarif());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setCodCargoBasico(cstmt.getString(2));
			}
			else
			{
				throw new GeneralException("ERR.01128",numEvento,global.getValor("ERR.01128"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01128",numEvento,global.getValor("ERR.01128"));
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
		logger.info("getCargoBasico(): Fin",nombreClase);
	}

	/**
	 * Obtiene codigo de vendedor
	 * @param abonadoVtaDTO
	 * @throws GeneralException
	 */
	public void getCodVendedor(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getCodVendedor(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_COD_VENDEDOR_PR", 7);
			cstmt = conn.prepareCall(call);

			System.out.println("abonadoVtaDTO.getNomUsuarOra(): " + abonadoVtaDTO.getNomUsuarOra());
			cstmt.setString(1, abonadoVtaDTO.getNomUsuarOra());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); //codError
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); //msgError
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC); //evento

			cstmt.execute();

			codError = cstmt.getString(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setCodVendedor(cstmt.getLong(2));
				abonadoVtaDTO.setCodVendedorAgente(cstmt.getLong(3));
				abonadoVtaDTO.setCodVendealer(cstmt.getLong(4));
				
				System.out.println("abonadoVtaDTO.getCodVendedor(): " + abonadoVtaDTO.getCodVendedor());
				System.out.println("abonadoVtaDTO.getCodVendedorAgente(): " + abonadoVtaDTO.getCodVendedorAgente());
				System.out.println("abonadoVtaDTO.getCodVendealer(): " + abonadoVtaDTO.getCodVendealer());
			}
			else
			{
				throw new GeneralException("ERR.01137",numEvento,global.getValor("ERR.01137"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01137",numEvento,global.getValor("ERR.01137"));
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
		logger.info("getCodVendedor(): Fin",nombreClase);
	}

	//OBTIENE EL LIMITE DE CONSUMO
	public void getCodLimCons(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getCodLimCons(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_VALIDA_NUMERO_PR(?,?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_LIMCONSUMO_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("abonadoVtaDTO.getCodPlanTarif(): " + abonadoVtaDTO.getCodPlanTarif(),nombreClase);
			cstmt.setString(1, abonadoVtaDTO.getCodPlanTarif());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			
			System.out.println("codError: " + codError);
			System.out.println("msgError: " + msgError);
			System.out.println("numEvento: " + numEvento);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setCodLimConsumo(cstmt.getString(2));
			}
			else
			{
				throw new GeneralException("ERR.01134",numEvento,global.getValor("ERR.01134"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01134",numEvento,global.getValor("ERR.01134"));
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
		logger.info("getCodLimCons(): Fin",nombreClase);
	}

	/**
	 * Obtiene 
	 * @param numCelular
	 * @param numSerie
	 * @return
	 * @throws GeneralException
	 */
	public void getCodBodega(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getCodBodega(): Inicio",nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_BODEGA_PR", 8);
			cstmt = conn.prepareCall(call);
			
			logger.debug("abonadoVtaDTO.getNumCelular(): " + abonadoVtaDTO.getNumCelular(),nombreClase);
			System.out.println("abonadoVtaDTO.getNumCelular(): "+abonadoVtaDTO.getNumCelular());
			cstmt.setLong(1, abonadoVtaDTO.getNumCelular());
			logger.debug("abonadoVtaDTO.getNumImei(): " + abonadoVtaDTO.getNumImei(),nombreClase);
			System.out.println("abonadoVtaDTO.getNumImei(): " + abonadoVtaDTO.getNumImei());
			cstmt.setString(2, abonadoVtaDTO.getNumImei());
			logger.debug("abonadoVtaDTO.getCodBodegaTerminal(): " + abonadoVtaDTO.getCodBodegaTerminal(),nombreClase);
			System.out.println("abonadoVtaDTO.getCodBodegaTerminal(): " + abonadoVtaDTO.getCodBodegaTerminal());
			cstmt.setString(3, abonadoVtaDTO.getCodBodegaTerminal());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			System.out.println("codError: " + codError);
			System.out.println("msgError: " + msgError);
			System.out.println("numEvento: " + numEvento);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setCodigoBodega(new Long(cstmt.getLong(4)).toString());
				abonadoVtaDTO.setDesBodega(cstmt.getString(5));
			}
			else
			{
				throw new GeneralException("ERR.01131",numEvento,global.getValor("ERR.01131"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01131",numEvento,global.getValor("ERR.01131"));
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
		logger.info("getCodBodega(): Fin",nombreClase);
	}

	//obtiene cod plaza y subalm asociado a la direccion
	public void getCodPlaza(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getCodPlaza(): Inicio", nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_PLAZA_SUBALM_PR", 5);
			cstmt = conn.prepareCall(call);

//			System.out.println("abonadoVtaDTO.getDireccionDTO().getCodRegion()" + abonadoVtaDTO.getDireccionDTO().getCodRegion());
//			cstmt.setString(1, abonadoVtaDTO.getDireccionDTO().getCodRegion());
//			System.out.println("abonadoVtaDTO.getDireccionDTO().getCodProvincia()"+abonadoVtaDTO.getDireccionDTO().getCodProvincia());
//			cstmt.setString(2, abonadoVtaDTO.getDireccionDTO().getCodProvincia());
//			System.out.println("abonadoVtaDTO.getDireccionDTO().getCodCiudad()"+ abonadoVtaDTO.getDireccionDTO().getCodCiudad());
//			cstmt.setString(3, abonadoVtaDTO.getDireccionDTO().getCodCiudad());
//			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
//			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
//			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
//			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
//			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cstmt.setLong(1, abonadoVtaDTO.getCodCliente());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				abonadoVtaDTO.getDireccionDTO().setCodPlaza(cstmt.getString(2));
				System.out.println("abonadoVtaDTO.getDireccionDTO().getCodPlaza()" + abonadoVtaDTO.getDireccionDTO().getCodPlaza());
			}
			else
			{
				throw new GeneralException("ERR.01136",numEvento,global.getValor("ERR.01136"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01136",numEvento,global.getValor("ERR.01136"));
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
		logger.info("getCodPlaza(): Fin", nombreClase);
	}

	/**
	 * Obtiene valor parametro.
	 * @param datosGeneralesDTO
	 * @throws GeneralException
	 */
	public void obtieneParametro(DatosGeneralesDTO datosGeneralesDTO)throws GeneralException
	{
		logger.info("obtieneParametro(): Inicio", nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
//		conn = getConection();
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_VALIDA_NUMERO_PR(?,?,?,?,?);");
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "PV_obtiene_valor_parametro_PR", 7);
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, datosGeneralesDTO.getNomParametro());
			cstmt.setString(2, datosGeneralesDTO.getCodModulo());
			cstmt.setString(3, datosGeneralesDTO.getCodProducto());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				datosGeneralesDTO.setValorParametro(cstmt.getString(4));
				if(datosGeneralesDTO.getValorParametro() == null || datosGeneralesDTO.getValorParametro() == " ")
				{
					throw new GeneralException("ERR.01114",numEvento,global.getValor("ERR.01114"));
				}
			}
			else if(codError == "1")
			{
				throw new GeneralException("ERR.01113",numEvento,global.getValor("ERR.01113"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.0000",numEvento,global.getValor("ERR.0000"));
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
		logger.info("obtieneParametro(): Fin", nombreClase);
	}

	

	//obtiene secuencia para numConrtato
	public void getNumContrato(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("getNumContrato(): Inicio", nombreClase);
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_OBTIENE_NUM_CONTRATO_PR", 4);
			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setNumContrato(cstmt.getString(1));
			}
			else
			{
				throw new GeneralException("ERR.01146",numEvento,global.getValor("ERR.01146"));
			}
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01146",numEvento,global.getValor("ERR.01146"));
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
		logger.info("getNumContrato(): Fin", nombreClase);
	}


	

	




	public void obtencionDatosCliente(ClienteSIGADTO clienteSIGADTO) throws GeneralException{
		logger.info("obtencionDatosCliente(): inicio", nombreClase);
		Connection conn = null;
		String codError = null;
		String msgError = null;
		int numEvento=0;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			conn = this.getConnectionFromWLSInitialContext(jndi);
			//String call = recupera_pr("VE_VALIDA_NUMERO_PR(?,?,?,?,?);");
			//INI-01 (AL) String call = this.coneccion.getPackageBD("VE_crea_linea_venta_PG", "VE_obtiene_datos_cliente_PR", 22);
			String call = this.coneccion.getPackageBD("VE_crea_linea_venta_quiosco_PG", "VE_obtiene_datos_cliente_PR", 22);
			cstmt = conn.prepareCall(call);

			logger.debug("codCliente : "+clienteSIGADTO.getCodigoCliente(), nombreClase);
			cstmt.setBigDecimal(1, clienteSIGADTO.getCodigoCliente()!=null?new BigDecimal(clienteSIGADTO.getCodigoCliente()):null);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(20);
			msgError = cstmt.getString(21);
			numEvento = cstmt.getInt(22);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);

			clienteSIGADTO.setCodigoCuenta(cstmt.getString(2));
			System.out.println("Cod Cuenta obtenido : "+clienteSIGADTO.getCodigoCuenta());
			clienteSIGADTO.setCodigoSubCuenta(cstmt.getString(3));
			clienteSIGADTO.setNombreCliente(cstmt.getString(4));
			clienteSIGADTO.setNombreApellido1(cstmt.getString(5));
			clienteSIGADTO.setNumeroIdentificacion(cstmt.getString(6));
			clienteSIGADTO.setCodigoTipoIdentificacion(cstmt.getString(7));
			clienteSIGADTO.setNombreApellido2(cstmt.getString(8));
			clienteSIGADTO.setFechaNacimiento(cstmt.getString(9));
			clienteSIGADTO.setIndicadorEstadoCivil(cstmt.getString(10));
			clienteSIGADTO.setIndicadorSexo(cstmt.getString(11));
			clienteSIGADTO.setCodigoActividad(cstmt.getString(12));
			clienteSIGADTO.setCodRegion(cstmt.getString(13));
			clienteSIGADTO.setCodCiudad(cstmt.getString(14));
			clienteSIGADTO.setCodProvincia(cstmt.getString(15));
			clienteSIGADTO.setCodigoCelda(cstmt.getString(16));
			clienteSIGADTO.setCodigoCalidadCliente(cstmt.getString(17));
			clienteSIGADTO.setIndFactur(cstmt.getInt(18));
			clienteSIGADTO.setCodigoCiclo(cstmt.getInt(19));



		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.0000",numEvento,global.getValor("ERR.0000"));
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
		logger.info("obtencionDatosCliente(): fin", nombreClase);

	}



	public void creaUsuario(UsuarioSIGADTO usuarioSIGADTO)
	throws GeneralException
	{
		logger.info("creaUsuario():inicio", nombreClase);
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		ResultSet rs = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;
		usuarioSIGADTO.setExitoCreacionUsuario(false);

		try {
			
			conn = this.getConnectionFromWLSInitialContext(jndi);
		    //INI-01 (AL) String call = this.coneccion.getPackageBD("VE_crea_linea_venta_PG",
			String call = this.coneccion.getPackageBD("VE_crea_linea_venta_quiosco_PG",
					"VE_IN_ga_usuarios_PR", 25);

			//System.out.println("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, usuarioSIGADTO.getCodigoUsuario());
			System.out.println("Codigo Usuario:" + usuarioSIGADTO.getCodigoUsuario());
			
			System.out.println("Cuenta Cliente:" + usuarioSIGADTO.getClienteSIGADTO().getCodigoCuenta());
			cstmt.setLong(2, Long.parseLong(usuarioSIGADTO.getClienteSIGADTO().getCodigoCuenta()));
			
			
			cstmt.setString(3, usuarioSIGADTO.getClienteSIGADTO().getCodigoSubCuenta());
			System.out.println("Sub cuenta:" + usuarioSIGADTO.getClienteSIGADTO().getCodigoSubCuenta());
			
			cstmt.setString(4, usuarioSIGADTO.getClienteSIGADTO().getNombreCliente());
			System.out.println("Nombre Cliente:" + usuarioSIGADTO.getClienteSIGADTO().getNombreCliente());
			
			cstmt.setString(5, usuarioSIGADTO.getClienteSIGADTO().getNombreApellido1());
			System.out.println("apellido1:"+ usuarioSIGADTO.getClienteSIGADTO().getNombreApellido1());
			
			cstmt.setString(6, usuarioSIGADTO.getClienteSIGADTO().getNombreApellido2());
			System.out.println("apellido2:"+ usuarioSIGADTO.getClienteSIGADTO().getNombreApellido2());
			
			cstmt.setString(7, usuarioSIGADTO.getClienteSIGADTO().getNumeroIdentificacion());
			System.out.println("numero iden:" + usuarioSIGADTO.getClienteSIGADTO().getNumeroIdentificacion());
			
			cstmt.setString(8, usuarioSIGADTO.getClienteSIGADTO().getCodigoTipoIdentificacion());
			System.out.println("tipo iden:" + usuarioSIGADTO.getClienteSIGADTO().getCodigoTipoIdentificacion());
			
//			cstmt.setString(9, usuarioSIGADTO.getClienteSIGADTO().getIndSituacion());
//			System.out.println("estado:" + usuarioSIGADTO.getClienteSIGADTO().getIndSituacion());
			if("BA".equals(usuarioSIGADTO.getClienteSIGADTO().getIndSituacion())){
				cstmt.setString(9, "C");
			} else {
				cstmt.setString(9, usuarioSIGADTO.getClienteSIGADTO().getIndSituacion());
			}
			
			cstmt.setString(10, usuarioSIGADTO.getClienteSIGADTO().getFechaNacimiento());
			System.out.println("fecha nacimiento:" + usuarioSIGADTO.getClienteSIGADTO().getFechaNacimiento());
			String estadoCivil = usuarioSIGADTO.getClienteSIGADTO().getIndicadorEstadoCivil();
			estadoCivil = estadoCivil == null ? "X" : estadoCivil.toUpperCase().trim();
			cstmt.setString(11, estadoCivil);
			String indSexo = usuarioSIGADTO.getClienteSIGADTO().getIndicadorSexo();
			indSexo = indSexo == null ? "X" : indSexo.toUpperCase().trim();
			cstmt.setString(12, indSexo);
			cstmt.setString(13, usuarioSIGADTO.getClienteSIGADTO().getCodigoActividad());
			cstmt.setString(14, null);
			cstmt.setString(15, null);
			cstmt.setString(16, null);
			cstmt.setString(17, null);
			cstmt.setString(18, null);
			cstmt.setString(19, null);
			cstmt.setString(20, null);
			cstmt.setString(21, null);
			cstmt.setString(22, null);
			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);
			
			logger.info("Inicio:creaUsuario:execute", nombreClase);
//			cat.debug("INGRESO A USUARIODAO antes exec");
			cstmt.execute();
//			cat.debug("INGRESO A USUARIODAO despues exec");
			logger.info("Fin:creaUsuario:execute", nombreClase);

			codError = cstmt.getInt(23);
			msgError = cstmt.getString(24);
			numEvento = cstmt.getInt(25);
		
			System.out.println("codError: " + codError);
			System.out.println("msgError: " + msgError);
			System.out.println("numEvento: " + numEvento);
			if (!"0".equalsIgnoreCase(String.valueOf(codError))){
				throw new GeneralException("ERR.01163",numEvento,global.getValor("ERR.01163"));
			}

		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01163",numEvento,global.getValor("ERR.01163"));
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

		logger.info("creaUsuario():fin", nombreClase);
	}

	public void obtencionEstadoIncompletoUsuario(UsuarioSIGADTO usuarioSIGADTO) throws GeneralException{
		logger.info("obtencionEstadoIncompletoUsuario(): fin", nombreClase);
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		String estadoIncompletoUsuario = null;
		String codOperadora = null;
		ResultSet rs = null;

		JndiForDataSource jndi = new JndiForDataSource();
		
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));

		CallableStatement cstmt = null;


		try {
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"PV_OBT_IND_SITUACION_CLI_PR", 6);

			Long codCliente = new Long(usuarioSIGADTO.getClienteSIGADTO().getCodigoCliente());
			
			logger.info("sql[" + call + "]", nombreClase);
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, codCliente.longValue());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cstmt.execute();
			
			estadoIncompletoUsuario = cstmt.getString(2);
			codOperadora = cstmt.getString(3);
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);

			if(estadoIncompletoUsuario == null || " ".equals(estadoIncompletoUsuario))
			{
				throw new GeneralException("ERR.01167",numEvento,global.getValor("ERR.01167"));
			}
			usuarioSIGADTO.getClienteSIGADTO().setIndSituacion(cstmt.getString(2));
			System.out.println("obtencionEstadoIncompletoUsuario -- usuarioSIGADTO.getIndSituacion: " + usuarioSIGADTO.getClienteSIGADTO().getIndSituacion());
			usuarioSIGADTO.setCodOperadora(codOperadora);

		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01167",numEvento,global.getValor("ERR.01167"));
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
		logger.info("obtencionEstadoIncompletoUsuario(): fin", nombreClase);
	}





	public void obtencionCodUsuario(UsuarioSIGADTO usuarioSIGADTO) throws GeneralException{
		logger.info("obtencionCodUsuario(): Inicio", nombreClase);
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		long codUsuario = 0L;
		ResultSet rs = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;


		try {
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"PV_REC_SECUENCIA_PR", 5);

			logger.info("sql[" + call + "]", nombreClase);
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, global.getValor("OOSS.Migracion.prepago.pospago.seq.Usuario"));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();

			codUsuario = cstmt.getLong(2);
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError: " + codError,nombreClase);
			logger.debug("msgError: " + msgError,nombreClase);
			logger.debug("numEvento: " + numEvento,nombreClase);

			if (!"0".equalsIgnoreCase(String.valueOf(codError)))
				throw new GeneralException("ERR.01167",numEvento,global.getValor("ERR.01167"));
				
			usuarioSIGADTO.setCodigoUsuario(codUsuario);
			
		}catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01167",numEvento,global.getValor("ERR.01167"));
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
		logger.info("obtencionCodUsuario(): fin", nombreClase);
	}
	
	public void obtencionCodCred(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		logger.info("obtencionCodCred(): Inicio", nombreClase);
		
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		ResultSet rs = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"VE_OBTIENE_COD_CRED_PR", 6);

			logger.info("sql[" + call + "]", nombreClase);
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, abonadoVtaDTO.getCodCalClien());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getString(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			if("0".equals(codError))
			{
				abonadoVtaDTO.setCodCredCon(new Integer(cstmt.getInt(2)));
				abonadoVtaDTO.setCodCredMor(new Integer(cstmt.getInt(3)));
			}
			else
			{
				throw new GeneralException("ERR.01162",numEvento,global.getValor("ERR.01162"));
			}
		}
		catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01162",numEvento,global.getValor("ERR.01162"));
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
		logger.info("obtencionCodCred(): fin", nombreClase);
	}
	
	
	public String obtencionSSPorDefecto(String codActabo)throws GeneralException
	{
		logger.info("obtencionSSPorDefecto(): Inicio", nombreClase);
		
		String cadena = null;
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		ResultSet rs = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"VE_OBTIENE_SS_POR_DEFECTO", 5);

			logger.info("sql[" + call + "]", nombreClase);
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,codActabo);
			logger.debug(" codActabo: "+  codActabo, nombreClase);
			System.out.println("codActabo: "+ codActabo);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			if("0".equals(codError))
			{
				cadena=cstmt.getString(2);
				logger.debug(" cadena: "+  cadena, nombreClase);
				System.out.println("cadena: "+ cadena);
			}
			else
			{
				throw new GeneralException("ERR.01177",numEvento,global.getValor("ERR.01177"));
			}
		}
		catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01177",numEvento,global.getValor("ERR.01177"));
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
		logger.info("obtencionSSPorDefecto(): fin", nombreClase);
		return cadena;
	}
	
	
	public void inscripcionDirecciones(AbonadoVtaDTO abonadoVtaDTO)
	throws GeneralException{
		logger.info("inscripcionDirecciones(): Inicio", nombreClase);
		System.out.println("inscripcionDirecciones(): Inicio ");
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		ResultSet rs = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		
		try {
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"VE_INS_DIRECC_PR", 6);

			logger.info("sql[" + call + "]", nombreClase);
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,abonadoVtaDTO.getNumCelular());
			System.out.println("getNumCelular: "+abonadoVtaDTO.getNumCelular());
			cstmt.setLong(2,abonadoVtaDTO.getCodCliente());
			System.out.println("getCodCliente: "+abonadoVtaDTO.getCodCliente());
			cstmt.setLong(3,abonadoVtaDTO.getCodUsuario());
			System.out.println("getCodUsuario: "+abonadoVtaDTO.getCodUsuario());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getString(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			System.out.println("codError: "+codError);
			System.out.println("msgError: "+msgError);
			System.out.println("numEvento: "+numEvento);
			
			if (!"0".equalsIgnoreCase(String.valueOf(codError))){
				throw new GeneralException("ERR.01181",numEvento,global.getValor("ERR.01181"));
			}
			
		} catch (Exception e) {
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01181",numEvento,global.getValor("ERR.01181"));
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
		System.out.println("inscripcionDirecciones(): fin ");
		logger.info("inscripcionDirecciones(): fin", nombreClase);
	}
	
	
	/**
	 * Metodo que obtiene el valor del plan
	 * @param valorPlanDTO
	 * @return
	 * @throws GeneralException
	 */
	public String obtencionValorPlan(ValorPlanDTO valorPlanDTO)throws GeneralException
	{
		logger.info("obtencionValorPlan(): Inicio", nombreClase);
		
		String codError = null;
		String msgError = null;
		String valorPlan = null;
		int numEvento = 0;
		Connection conn = null;
		ResultSet rs = null;
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		CallableStatement cstmt = null;
		
		try
		{
			conn = this.getConnectionFromWLSInitialContext(jndi);
			String call = this.coneccion.getPackageBD("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"VE_CONS_VALOR_PLAN_PR", 10);

			logger.info("sql[" + call + "]", nombreClase);
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, valorPlanDTO.getCodPlanTarif());
			logger.debug("valorPlanDTO.getCodPlanTarif(): "+ valorPlanDTO.getCodPlanTarif(), nombreClase);
			System.out.println("valorPlanDTO.getCodPlanTarif(): "+ valorPlanDTO.getCodPlanTarif());
			cstmt.setInt(2, Integer.parseInt(valorPlanDTO.getCodCiclo()));
			logger.debug("valorPlanDTO.getCodCiclo(): "+ valorPlanDTO.getCodCiclo(), nombreClase);
			System.out.println("valorPlanDTO.getCodCiclo(): "+ valorPlanDTO.getCodCiclo());
			cstmt.setInt(3, Integer.parseInt(valorPlanDTO.getCodCliente()));
			logger.debug("valorPlanDTO.getCodCliente(): "+ valorPlanDTO.getCodCliente(), nombreClase);
			System.out.println("valorPlanDTO.getCodCliente(): "+ valorPlanDTO.getCodCliente());
			cstmt.setInt(4, Integer.parseInt(valorPlanDTO.getNumAbonado()));
			logger.debug("valorPlanDTO.getNumAbonado(): "+ valorPlanDTO.getNumAbonado(), nombreClase);
			System.out.println("valorPlanDTO.getNumAbonado(): "+ valorPlanDTO.getNumAbonado());
			cstmt.setString(5, valorPlanDTO.getCatImpClie());
			logger.debug("valorPlanDTO.getCatImpClie(): "+ valorPlanDTO.getCatImpClie(), nombreClase);
			System.out.println("valorPlanDTO.getCatImpClie(): "+ valorPlanDTO.getCatImpClie());
			cstmt.setString(6, valorPlanDTO.getCodOficina());
			logger.debug("valorPlanDTO.getCodOficina(: )"+ valorPlanDTO.getCodOficina(), nombreClase);
			System.out.println("valorPlanDTO.getCodOficina(): "+ valorPlanDTO.getCodOficina());
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getString(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			System.out.println("codError: "+codError);
			System.out.println("msgError: "+msgError);
			System.out.println("numEvento: "+numEvento);
			if("0".equals(codError))
			{
				valorPlan = cstmt.getString(7);
				//valorPlan = omitirComa(valorPlan);
					
				logger.debug("valorPlan: "+ valorPlan, nombreClase);
				System.out.println("valorPlan: "+ valorPlan);
				
			}
			else
			{
				throw new GeneralException("ERR.01122",numEvento,global.getValor("ERR.01122"));
			}
		}
		catch(Exception e){
			if (!(e instanceof GeneralException)) {
				logger.error("ERROR:", nombreClase);
				logger.error("Codigo de Error[" + codError + "]",nombreClase);
				logger.error("Mensaje de Error[" + msgError + "]",nombreClase);
				logger.error("Numero de Evento[" + numEvento + "]",nombreClase);
				e.printStackTrace();
				throw new GeneralException("ERR.01122",numEvento,global.getValor("ERR.01122"));
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
		logger.info("obtencionValorPlan(): fin", nombreClase);
		return valorPlan;
	}
	
	private static String omitirComa(String input)
	{
		int p = input.indexOf(",");
		
		if(p!=-1)
		{
			String[] str = input.split(",");
			
			return str[0]+"."+str[1];
		}
				
		return input;
	}
	
}
