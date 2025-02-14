package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DatosClienteDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.helper.Global;

public class ClienteDAO extends ConnectionDAO{
	private Global global = Global.getInstance();	
	private static Category cat = Category.getInstance(ClienteDAO.class);

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
	
	private String getSQLDatosAbonado(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosAbonado

	public DatosClienteDTO clientePorNumeroCelular (long numeroCelular)throws GeneralException{		
		cat.info("DatosClienteDTO():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		DatosClienteDTO datosClienteDTO = new DatosClienteDTO();
		datosClienteDTO.setDireccionDTO(new DireccionDTO());
		datosClienteDTO.setCliente(new ClienteDTO());
		
		
		try
		{			
			String call = getSQLDatosAbonado("ve_clientes_pg", "ve_rec_datos_cliente_pr", 33);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, numeroCelular);
			cat.debug("numeroCelular: " + numeroCelular);
			
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
//			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); DES_REGION CSR-11002
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
//			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR); DES_PROVINCIA CSR-11002
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
//			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR); DES_CIUDAD CSR-11002
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
//			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR); DES_COMUNA CSR-11002
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			//INICIO CSR-11002 
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR); //NUM_PISO 
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR); //NUM_CASILLA
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR); //OBS_DIRECCION
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR); //DES_DIREC1
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR); //DES_DIREC2
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR); //COD_PUEBLO
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR); //COD_ESTADO
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR); //COD_TIPOCALLE
			//FIN CSR-11002
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR); //zip
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(27, java.sql.Types.NUMERIC); //COD_CATEGORIA_CAMBIO
			cstmt.registerOutParameter(28, java.sql.Types.VARCHAR); //DES_CATEGORIA_CAMBIO
			cstmt.registerOutParameter(29, java.sql.Types.VARCHAR); //COD_CREDITICIA
			cstmt.registerOutParameter(30, java.sql.Types.VARCHAR); //DES_CREDITICIA
			cstmt.registerOutParameter(31, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(32, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(33, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getInt(31);
			msgError = cstmt.getString(32);
			numEvento = cstmt.getInt(33);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar datos del cliente");
				throw new GeneralException(
						msgError, String.valueOf(codError), numEvento, msgError);
			}else{
				datosClienteDTO.setCodigoTipIdentif(cstmt.getString(2));
				datosClienteDTO.setDescipcionTipIdentif(cstmt.getString(3));
				datosClienteDTO.setNumIdent(cstmt.getString(4));
				datosClienteDTO.setNomCliente(cstmt.getString(5));
				datosClienteDTO.setApellidoPaterno(cstmt.getString(6));
				datosClienteDTO.setApellidoMaterno(cstmt.getString(7));
				datosClienteDTO.setCodCategoria(cstmt.getInt(8));
				datosClienteDTO.setDescripcionCategoria(cstmt.getString(9));
				datosClienteDTO.getDireccionDTO().setCodigoRegion(cstmt.getString(10));
				cat.debug("CodigoRegion: " + cstmt.getString(10));
//				datosClienteDTO.getDireccionDTO().setDescripcionRegion(cstmt.getString(11)); CSR-11002
				datosClienteDTO.getDireccionDTO().setCodigoProvincia(cstmt.getString(11));
				cat.debug("CodigoProvincia: " + cstmt.getString(11));
//				datosClienteDTO.getDireccionDTO().setDescripcionProvincia(cstmt.getString(13)); CSR-11002
				datosClienteDTO.getDireccionDTO().setCodigoCiudad(cstmt.getString(12));
				cat.debug("CodigoCiudad: " + cstmt.getString(12));
//				datosClienteDTO.getDireccionDTO().setDescripcionCiudad(cstmt.getString(15)); CSR-11002
				datosClienteDTO.getDireccionDTO().setCodigoComuna(cstmt.getString(13));
				cat.debug("CodigoComuna: " + cstmt.getString(13));
//				datosClienteDTO.getDireccionDTO().setDescripcionComuna(cstmt.getString(17)); CSR-11002
				datosClienteDTO.getDireccionDTO().setNombreCalle(cstmt.getString(14));
				cat.debug("NombreCalle: " + cstmt.getString(14));
				datosClienteDTO.getDireccionDTO().setNumeroCalle(cstmt.getString(15));
				cat.debug("NumeroCalle: " + cstmt.getString(15));
//				INICIO CSR-11002 
				datosClienteDTO.getDireccionDTO().setNumPiso(cstmt.getString(16)); //NUM_PISO
				cat.debug("NumPiso: " + cstmt.getString(16));
				datosClienteDTO.getDireccionDTO().setNumCasilla(cstmt.getString(17)); //NUM_CASILLA
				cat.debug("NumCasilla: " + cstmt.getString(17));
				datosClienteDTO.getDireccionDTO().setObsDireccion(cstmt.getString(18)); //OBS_DIRECCION
				cat.debug("ObsDireccion: " + cstmt.getString(18));
				datosClienteDTO.getDireccionDTO().setDesDirec1(cstmt.getString(19)); //DES_DIREC1
				cat.debug("DesDirec1: " + cstmt.getString(19));
				datosClienteDTO.getDireccionDTO().setDesDirec2(cstmt.getString(20)); //DES_DIREC2
				cat.debug("DesDirec2: " + cstmt.getString(20));
				datosClienteDTO.getDireccionDTO().setCodPueblo(cstmt.getString(21)); //COD_PUEBLO
				cat.debug("CodPueblo: " + cstmt.getString(21));
				datosClienteDTO.getDireccionDTO().setCodEstado(cstmt.getString(22)); //COD_ESTADO
				cat.debug("CodEstado: " + cstmt.getString(22));
				datosClienteDTO.getDireccionDTO().setCodTipoCalle(cstmt.getString(23)); //COD_TIPOCALLE
				cat.debug("CodTipoCalle: " + cstmt.getString(23));
//				FIN CSR-11002
				datosClienteDTO.getDireccionDTO().setZip(cstmt.getString(24));
				cat.debug("Zip: " + cstmt.getString(24));
				datosClienteDTO.getCliente().setCodCliente(cstmt.getInt(25));
				datosClienteDTO.getCliente().setCodCuenta(cstmt.getInt(26));
				datosClienteDTO.setCodCategoriaCambio(String.valueOf(cstmt.getInt(27))); //COD_CATEGORIA_CAMBIO
				datosClienteDTO.setDesCategoriaCambio(cstmt.getString(28));	//DES_CATEGORIA_CAMBIO
				datosClienteDTO.setCodCrediticia(cstmt.getString(29));
				datosClienteDTO.setDesCrediticia(cstmt.getString(30));
				datosClienteDTO.setCodError(codError);
				datosClienteDTO.setMsgError(msgError);
				datosClienteDTO.setNumEvento(numEvento);			
			}		
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar datos del cliente",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar datos del cliente",e);

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
		cat.info("DatosClienteDTO():Fin");
		return datosClienteDTO;
	}
	
	public IdentificadorCivilDTO[] getTiposIdentificacion()throws GeneralException{		
		
		cat.info("getTiposIdentificación():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		IdentificadorCivilDTO[] identificadorCivilDTOs = null;
		ArrayList list = new ArrayList();
		
		
		try
		{			
			//INI-01 (AL) String call = getSQLDatosAbonado("ve_servicios_venta_pg", "ve_list_tip_ident_pr", 4);			
			String call = getSQLDatosAbonado("ve_servicios_venta_quiosco_pg", "ve_list_tip_ident_pr", 4);
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);

			if (codError != 0) {								
				cat.error("Ocurrió un error al recuperar tipos de identificación");
				throw new GeneralException(
						msgError, String.valueOf(codError), numEvento, msgError);
			}else{
				ResultSet rs = (ResultSet)cstmt.getObject(1);
				IdentificadorCivilDTO civilDTO = null;
				while(rs.next()){
					 civilDTO = new IdentificadorCivilDTO();
					 civilDTO.setCodigoTipIdentif(rs.getString(1));
					 civilDTO.setDescripcionTipIdentif(rs.getString(2));
					 list.add(civilDTO);
					
				}
				
				identificadorCivilDTOs =(IdentificadorCivilDTO[]) ArrayUtl.copiaArregloTipoEspecifico(list.toArray(), IdentificadorCivilDTO.class);
			}		
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar datos del cliente",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar datos del cliente",e);

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
		cat.info("identificadorCivilDTO():Fin");
		return identificadorCivilDTOs;
		
		
	}
}
