package com.tmmas.cl.scl.ss911correofax.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.ss911correofax.bo.helper.Global;
import com.tmmas.cl.scl.ss911correofax.dao.interfaces.ServSupl911CorreoFaxDAOIT;
import com.tmmas.cl.scl.ss911correofax.dto.CodigosDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ContactoAbonadoTT;
import com.tmmas.cl.scl.ss911correofax.dto.DireccionDTO;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoTO;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.ss911correofax.dto.DireccionNegocioWebDTO;

public class ServSupl911CorreoFaxDAO extends ConnectionDAO implements ServSupl911CorreoFaxDAOIT{

	protected Logger logger=Logger.getLogger(this.getClass());
	protected Global global=Global.getInstance();
	
	
	private Connection getConection()
		throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}// fin getConection
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}// fin getSQLDatosAbonado
		
	
	private String getSql(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	
	private String getSQLgetParametroGeneral() {
		StringBuffer call = new StringBuffer();									
		call.append("		BEGIN  ");
		call.append("		  VE_intermediario_PG.VE_obtiene_valor_parametro_PR( ?, ?, ?, ?, ?, ?, ?); ");		
		call.append("		END;  ");
		return call.toString(); 		 		
	}		
	
	public void insertGaContactoAbonadoTO(GaContactoAbonadoToDTO entrada)
		throws GeneralException
	{
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.info("Inicio:insertGaContactoAbonadoTO");
			
			String call = getSQLDatos("GA_SERV911CORREOFAX_PG","GA_INSERT_GACONTACTO_PR",17);

			logger.info("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,entrada.getNumAbonado());
			logger.info("Numero Abonado:" + entrada.getNumAbonado());
			cstmt.setString(2,entrada.getCodServicio());
			logger.info("Cod. Servicio:" + entrada.getCodServicio());
			cstmt.setLong(3,entrada.getNumContacto());
			logger.info("Num. Contacto:" + entrada.getNumContacto());
			cstmt.setString(4,entrada.getNombreContacto());
			logger.info("Nombre Contacto:" + entrada.getNombreContacto());
			cstmt.setString(5,entrada.getApellido1Contacto());
			logger.info("Apellido1:"+entrada.getApellido1Contacto());
			cstmt.setString(6,entrada.getApellido2Contacto());
			logger.info("Apellido2:" + entrada.getApellido2Contacto());
			cstmt.setString(7,entrada.getCodParentesco());
			logger.info("Cod. Parentesco:" + entrada.getCodParentesco());
			cstmt.setLong(8,entrada.getCodDireccion());
			logger.info("Cod. DIreccion:" + entrada.getCodDireccion());
			cstmt.setString(9,entrada.getPlacaVehicular());
			logger.info("Placa:" + entrada.getPlacaVehicular());
			cstmt.setString(10,entrada.getColorVehiculo());
			logger.info("Color vehiculo:" + entrada.getColorVehiculo());
			cstmt.setLong(11,entrada.getAnioVehiculo());
			logger.info("Anio Vehiculo:" + entrada.getAnioVehiculo());
			cstmt.setString(12,entrada.getObservacion());
			logger.info("Observacion:" + entrada.getObservacion());
			cstmt.setString(13,entrada.getNomUsuarora());
			logger.info("NomUsuarora:" + entrada.getNomUsuarora());
			cstmt.setLong(14,entrada.getTelefono());
			logger.info("Telefono:" + entrada.getTelefono());
			
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			
			logger.info("Inicio:insertGaContactoAbonadoTO:execute");			
			cstmt.execute();			
			logger.info("Fin:insertGaContactoAbonadoTO:execute");

			codError=cstmt.getInt(15);
			msgError = cstmt.getString(16);
			numEvento=cstmt.getInt(17);
			
			if (codError != 0) {
				logger.error("Ocurrió un error al insertar el contacto del abonado");
				if (logger.isDebugEnabled()) {
					logger.info("Codigo de Error[" + codError + "]");
					logger.info("Mensaje de Error[" + msgError + "]");
					logger.info("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al insertar el contacto del abonado", String
								.valueOf(codError), numEvento, msgError);
			}
			
		} catch (GeneralException e) {
			logger.error("Ocurrió un error al insertar el contacto del abonado",e);
			if (logger.isDebugEnabled()) {
				logger.info("Codigo de Error[" + codError + "]");
				logger.info("Mensaje de Error[" + msgError + "]");
				logger.info("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar el contacto del abonado",e);
			throw new GeneralException("Ocurrió un error al insertar el contacto del abonado");
		} finally {
				logger.info("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.info("SQLException", e);
		  }
		}

		logger.info("Fin:insertGaContactoAbonadoTO");		
	}
	
	/**
	 * Obtiene lista de codigos
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CodigosDTO[] getListCodigos(CodigosDTO entrada) 
		throws GeneralException
	{
		logger.debug("Inicio:getListCodigos()");
		CodigosDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatos("VE_alta_cliente_PG","VE_getListGedCodigos_PR",7);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoModulo());
			cstmt.setString(2,entrada.getTabla());
			cstmt.setString(3,entrada.getColumna());
			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListCodigos:execute");
			cstmt.execute();
			logger.debug("Fin:getListCodigos:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar lista de codigos");
				throw new GeneralException(
						"Ocurrió un error al recuperar lista de codigos", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando lista de codigos");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					CodigosDTO datosgeneralesDTO = new CodigosDTO();
					datosgeneralesDTO.setCodigoValor(rs.getString(1));
					datosgeneralesDTO.setDescripcionValor(rs.getString(2));
					
					lista.add(datosgeneralesDTO);
				}				
				resultado =(CodigosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), CodigosDTO.class);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar lista de codigos",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getListCodigos()");
		return resultado;
	}// fin getListCodigos

	public ContactoAbonadoTT[] obtenerListaContactos(ContactoAbonadoTT abonadoTT) throws GeneralException {
		logger.debug("Inicio:obtenerListaContactos()");
		// System.out.println("Inicio:obtenerListaContactos()");
		ContactoAbonadoTT[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		try {
			conn = getConection();
			String call = getSQLDatos("GA_SERV911CORREOFAX_PG","GA_GET_GACANTAC_GEDIRECC_PR",6);

			logger.debug("sql[" + call + "]");
			// System.out.println("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,abonadoTT.getNumAbonado());
			cstmt.setString(2,abonadoTT.getCodServicio());
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:obtenerListaContactos:execute");
			// System.out.println("Inicio:obtenerListaContactos:execute");
			cstmt.execute();
			logger.debug("Fin:obtenerListaContactos:execute");
			// System.out.println("Fin:obtenerListaContactos:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			// System.out.println("Codigo de Error[" + codError + "]");
			// System.out.println("Mensaje de Error[" + msgError + "]");
			// System.out.println("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar lista de conactos");
				throw new GeneralException(
						"Ocurrió un error al recuperar lista de contactos", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando lista de contactos");
				// System.out.println("Recuperando lista de contactos");
				ArrayList conTactList = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);				
				while (rs.next()) {
					// System.out.println("RS");
					GaContactoAbonadoToDTO contactoAbonadoToDTOs = new GaContactoAbonadoToDTO();
					DireccionDTO direccionDTO = new DireccionDTO();			
					ContactoAbonadoTT contactoAbonadoTT = new ContactoAbonadoTT();

					// num_abonado
					contactoAbonadoTT.setNumAbonado(abonadoTT.getNumAbonado());
					contactoAbonadoToDTOs.setNumAbonado(rs.getLong(1));
					// cod_servicio
					contactoAbonadoToDTOs.setCodServicio(rs.getString(2));
					// num_contacto
					contactoAbonadoToDTOs.setNumContacto(Long.parseLong(rs.getString(3).trim()));
					// nombre_contacto
					contactoAbonadoToDTOs.setNombreContacto(rs.getString(4));
					// apellido1_contacto
					contactoAbonadoToDTOs.setApellido1Contacto(rs.getString(5));
					// apellido2_contacto
					contactoAbonadoToDTOs.setApellido2Contacto(rs.getString(6));
					// cod_parentesco
					contactoAbonadoToDTOs.setCodParentesco(rs.getString(7));
					// cod_direccion
					contactoAbonadoToDTOs.setCodDireccion(Long.parseLong(rs.getString(8).trim()));
					// placa_vehicular
					contactoAbonadoToDTOs.setPlacaVehicular(rs.getString(9));
					// color_vehiculo
					contactoAbonadoToDTOs.setColorVehiculo(rs.getString(10));
					// anio_vehiculo
					contactoAbonadoToDTOs.setAnioVehiculo(Long.parseLong(rs.getString(11).trim()));
					// observacion
					contactoAbonadoToDTOs.setObservacion(rs.getString(12));
					// ind_vigente
					contactoAbonadoToDTOs.setIndVigente(rs.getString(13));
					// fec_modificacion
					contactoAbonadoToDTOs.setFecModificacion(new Timestamp(rs.getDate(14).getTime()));
					// nom_usuaora
					contactoAbonadoToDTOs.setNomUsuarora(rs.getString(15));
					
					//num_telefono
					contactoAbonadoToDTOs.setTelefono(rs.getLong(16));
					// cod_provincia
					direccionDTO.setCodProvincia(rs.getString(17));
					//des_provincia
					direccionDTO.setDesProvincia(rs.getString(18));
					// cod_region
					direccionDTO.setCodRegion(rs.getString(19));
					//des_region
					direccionDTO.setDesRegion(rs.getString(20));
					// cod_ciudad
					direccionDTO.setCodCiudad(rs.getString(21));
					//des_ciudad
					direccionDTO.setDesCiudad(rs.getString(22));
					// cod_comuna
					direccionDTO.setCodComuna(rs.getString(23));
					//des_comuna
					direccionDTO.setDesComuna(rs.getString(24));
					// nom_calle
					direccionDTO.setNomCalle(rs.getString(25));
					// num_calle
					direccionDTO.setNumCalle(rs.getString(26));
					// num_piso
					direccionDTO.setNumPiso(rs.getString(27));
					// num_casilla
					direccionDTO.setNumCasilla(rs.getString(28));
					// obs_direccion
					direccionDTO.setObsDireccion(rs.getString(29));
					// des_direc1
					direccionDTO.setDesDirec1(rs.getString(30));
					// des_direc2
					direccionDTO.setDesDirec2(rs.getString(31));
					// cod_pueblo
					direccionDTO.setCodPueblo(rs.getString(32));
					//des_pueblo
					direccionDTO.setDesPueblo(rs.getString(33));
					// cod_estado
					direccionDTO.setCodEstado(rs.getString(34));
					//des_estado
					direccionDTO.setDesEstado(rs.getString(35));
					// zip
					direccionDTO.setZip(rs.getString(36));
					// cod_tipocalle
					direccionDTO.setCodTipoCalle(rs.getString(37));
					
					contactoAbonadoTT.setNumAbonado(abonadoTT.getNumAbonado());
					contactoAbonadoTT.setContactoAbonadoToDTOs(contactoAbonadoToDTOs);
					direccionDTO.setCodDireccion(contactoAbonadoToDTOs.getCodDireccion());
					contactoAbonadoTT.setDireccionDTO(direccionDTO);
					conTactList.add(contactoAbonadoTT);
				}				
				logger.debug(" conTactList.size() = "+conTactList.size());
				// System.out.println(" conTactList.size() =
				// "+conTactList.size());
				resultado =(ContactoAbonadoTT[]) ArrayUtl.copiaArregloTipoEspecifico(conTactList.toArray(), ContactoAbonadoTT.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Ocurrió un error al recuperar lista de contactos",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtenerListaContactos()");
		return resultado;
	}
	
	public void deleteInsertPvContactoAbonadoTT(ContactoAbonadoTT[] entrada)throws GeneralException {
		logger.info("Inicio:deleteInsertPvContactoAbonadoTT");
		if (entrada.length>0) {
			ContactoAbonadoTT abonadoTT = entrada[0];
			//deletePvContactoAbonadoTT(abonadoTT);
		}
	
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;	
		CallableStatement cstmt = null;
		try {

			conn = getConection();
			String call = getSQLDatos("GA_SERV911CORREOFAX_PG","GA_INSERT_CONTACTOABONADOTT_PR",33);

			logger.info("sql[" + call + "]");	
			cstmt = conn.prepareCall(call);

			for (int i = 0; i < entrada.length; i++) {
				ContactoAbonadoTT contactoAbonadoTT = entrada[i];
				
				// EN_NUM_ABONADO
				logger.info("NUM_ABONADO: " +contactoAbonadoTT.getNumAbonado());
				cstmt.setLong(1,contactoAbonadoTT.getNumAbonado());      
				// EV_COD_SERVICIO
				logger.info("COD_SERVICIO: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getCodServicio());
				cstmt.setString(2,contactoAbonadoTT.getContactoAbonadoToDTOs().getCodServicio());       
				// EN_NUM_CONTACTO
				logger.info("NUM_CONTACTO: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getNumContacto());
				cstmt.setLong(3,contactoAbonadoTT.getContactoAbonadoToDTOs().getNumContacto());        
				// EV_NOMBRE_CONTACTO
				logger.info("NOMBRE_CONTACTO: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getNombreContacto());				
				if (contactoAbonadoTT.getContactoAbonadoToDTOs().getNombreContacto()!=null && !contactoAbonadoTT.getContactoAbonadoToDTOs().getNombreContacto().equals("")){
					cstmt.setString(4,contactoAbonadoTT.getContactoAbonadoToDTOs().getNombreContacto());
				}else{
					cstmt.setNull(4, java.sql.Types.VARCHAR); 
				}
				
				// EV_APELLIDO1_CONTACTO
				logger.info("APELLIDO1_CONTACTO: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getApellido1Contacto());
				cstmt.setString(5,contactoAbonadoTT.getContactoAbonadoToDTOs().getApellido1Contacto());
				// EV_APELLIDO2_CONTACTO
				String apell2=contactoAbonadoTT.getContactoAbonadoToDTOs().getApellido2Contacto();
				logger.info("APELLIDO2_CONTACTO: " +apell2 ); 
				cstmt.setString(6,apell2);
				// EV_COD_PARENTESCO
				logger.info("COD_PARENTESCO: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getCodParentesco());
				cstmt.setString(7,contactoAbonadoTT.getContactoAbonadoToDTOs().getCodParentesco()); 
				// EN_COD_DIRECCION
				logger.info("COD_DIRECCION: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getCodDireccion());
				cstmt.setLong(8,contactoAbonadoTT.getContactoAbonadoToDTOs().getCodDireccion());  
				// EV_PLACA_VEHICULAR
				logger.info("PLACA_VEHICULAR: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getPlacaVehicular());
				cstmt.setString(9,contactoAbonadoTT.getContactoAbonadoToDTOs().getPlacaVehicular());
				// EV_COLOR_VEHICULO
				logger.info("COLOR_VEHICULO: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getColorVehiculo());
				cstmt.setString(10,contactoAbonadoTT.getContactoAbonadoToDTOs().getColorVehiculo());    
				// EN_ANIO_VEHICULO
				logger.info("ANIO_VEHICULO: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getAnioVehiculo());
				cstmt.setLong(11,contactoAbonadoTT.getContactoAbonadoToDTOs().getAnioVehiculo());
				// EV_OBSERVACION
				logger.info("OBSERVACION: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getObservacion());
				cstmt.setString(12,contactoAbonadoTT.getContactoAbonadoToDTOs().getObservacion());    
				// EV_IND_VIGENTE
				logger.info("IND_VIGENTE: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getIndVigente());
				cstmt.setString(13,contactoAbonadoTT.getContactoAbonadoToDTOs().getIndVigente());
				// EV_NOM_USUAORA
				logger.info("NOM_USUAORA: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getNomUsuarora());				
				if (contactoAbonadoTT.getContactoAbonadoToDTOs().getNombreContacto()!=null && !contactoAbonadoTT.getContactoAbonadoToDTOs().getNombreContacto().equals("")){
					cstmt.setString(14,contactoAbonadoTT.getContactoAbonadoToDTOs().getNomUsuarora());
				}else{
					cstmt.setNull(14, java.sql.Types.VARCHAR); 
				}
				// EV_COD_PROVINCIA
				logger.info("COD_PROVINCIA: " + contactoAbonadoTT.getDireccionDTO().getCodProvincia());
				cstmt.setString(15,contactoAbonadoTT.getDireccionDTO().getCodProvincia());
				// EV_COD_REGION
				logger.info("COD_REGION: " + contactoAbonadoTT.getDireccionDTO().getCodRegion());
				cstmt.setString(16,contactoAbonadoTT.getDireccionDTO().getCodRegion());
				// EV_COD_CIUDAD
				logger.info("COD_CIUDAD: " + contactoAbonadoTT.getDireccionDTO().getCodCiudad());
				cstmt.setString(17,contactoAbonadoTT.getDireccionDTO().getCodCiudad());
				// EV_COD_COMUNA
				logger.info("COD_COMUNA: " + contactoAbonadoTT.getDireccionDTO().getCodComuna());
				cstmt.setString(18,contactoAbonadoTT.getDireccionDTO().getCodComuna());
				// EV_NOM_CALLE
				logger.info("NOM_CALLE: " + contactoAbonadoTT.getDireccionDTO().getNomCalle());
				cstmt.setString(19,contactoAbonadoTT.getDireccionDTO().getNomCalle());
				// EV_NUM_CALLE
				logger.info("NUM_CALLE: " + contactoAbonadoTT.getDireccionDTO().getNumCalle());
				cstmt.setString(20,contactoAbonadoTT.getDireccionDTO().getNumCalle());
				// EV_NUM_PISO
				logger.info("NUM_PISO: " + contactoAbonadoTT.getDireccionDTO().getNumPiso());
				cstmt.setString(21,contactoAbonadoTT.getDireccionDTO().getNumPiso());
				// EV_NUM_CASILLA
				logger.info("NUM_CASILLA: " + contactoAbonadoTT.getDireccionDTO().getNumCasilla());
				cstmt.setString(22,contactoAbonadoTT.getDireccionDTO().getNumCasilla());
				// EV_OBS_DIRECCION
				logger.info("OBS_DIRECCION: " + contactoAbonadoTT.getDireccionDTO().getObsDireccion());
				cstmt.setString(23,contactoAbonadoTT.getDireccionDTO().getObsDireccion());
				// EV_DES_DIREC1
				logger.info("DES_DIREC1: " + contactoAbonadoTT.getDireccionDTO().getDesDirec1());
				cstmt.setString(24,contactoAbonadoTT.getDireccionDTO().getDesDirec1());
				// EV_DES_DIREC2
				logger.info("DES_DIREC2: " + contactoAbonadoTT.getDireccionDTO().getDesDirec2());
				cstmt.setString(25,contactoAbonadoTT.getDireccionDTO().getDesDirec2());
				// EV_COD_PUEBLO
				logger.info("COD_PUEBLO: " + contactoAbonadoTT.getDireccionDTO().getCodPueblo());
				cstmt.setString(26,contactoAbonadoTT.getDireccionDTO().getCodPueblo());
				// EV_COD_ESTADO
				logger.info("COD_ESTADO: " + contactoAbonadoTT.getDireccionDTO().getCodEstado());
				cstmt.setString(27,contactoAbonadoTT.getDireccionDTO().getCodEstado());
				// EV_ZIP
				logger.info("ZIP : " + contactoAbonadoTT.getDireccionDTO().getZip());
				cstmt.setString(28,contactoAbonadoTT.getDireccionDTO().getZip());
				// EV_COD_TIPOCALLE
				logger.info("COD_TIPOCALLE: " + contactoAbonadoTT.getDireccionDTO().getCodTipoCalle());
				cstmt.setString(29,contactoAbonadoTT.getDireccionDTO().getCodTipoCalle());
				// EN_NUM_TELEFONO
				logger.info("NUM_TELEFONO: " + contactoAbonadoTT.getContactoAbonadoToDTOs().getTelefono());
				cstmt.setLong(30,contactoAbonadoTT.getContactoAbonadoToDTOs().getTelefono());
				
				cstmt.registerOutParameter(31, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(32, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(33, java.sql.Types.NUMERIC);
				
				logger.info("Inicio:insertGaContactoAbonadoTO:execute");			
				cstmt.execute();			
				logger.info("Fin:insertGaContactoAbonadoTO:execute");
	
				codError=cstmt.getInt(31);
				msgError = cstmt.getString(32);
				numEvento=cstmt.getInt(33);
				
				if (codError != 0) {
					logger.error("Ocurrió un error al insertar el contacto del abonado");
					if (logger.isDebugEnabled()) {
						logger.info("Codigo de Error[" + codError + "]");
						logger.info("Mensaje de Error[" + msgError + "]");
						logger.info("Numero de Evento[" + numEvento + "]");
					}
					throw new GeneralException(
							"Ocurrió un error al insertar el contacto del abonado", String
									.valueOf(codError), numEvento, msgError);
				}			
				
			}
			
		} catch (GeneralException e) {
			logger.error("Ocurrió un error al insertar el contacto del abonado",e);
			if (logger.isDebugEnabled()) {
				logger.info("Codigo de Error[" + codError + "]");
				logger.info("Mensaje de Error[" + msgError + "]");
				logger.info("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar el contacto del abonado",e);
			throw new GeneralException("Ocurrió un error al insertar el contacto del abonado");
		} finally {
				logger.info("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.info("SQLException", e);
		  }
		}

	logger.info("Fin:deleteInsertPvContactoAbonadoTT");		
}	
	
	public void deletePvContactoAbonadoTT(ContactoAbonadoTT contactoAbonadoTT)throws GeneralException {
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;	
		CallableStatement cstmt = null;
		try {
			logger.info("Inicio:deleteInsertPvContactoAbonadoTT");
			conn = getConection();
			String callDelete = getSQLDatos("GA_SERV911CORREOFAX_PG","PV_DELETE_CONTACTOABONADOTT_PR",5);
			logger.info("sql[" + callDelete + "]");
		
			cstmt = conn.prepareCall(callDelete);
			logger.info("NUM_ABONADO: " +contactoAbonadoTT.getNumAbonado());
			logger.info("COD_SERVICIO: " +contactoAbonadoTT.getCodServicio());
			cstmt.setLong(1,contactoAbonadoTT.getNumAbonado());
			cstmt.setString(2,contactoAbonadoTT.getCodServicio());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.info("Inicio:deleteInsertPvContactoAbonadoTT:execute");			
			cstmt.execute();			
			logger.info("Fin:deleteInsertPvContactoAbonadoTT:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);			
			
			if (codError != 0) {
				logger.error("Ocurrió un error al intentar los contactos del abonado "+contactoAbonadoTT.getNumAbonado());
				if (logger.isDebugEnabled()) {
					logger.info("Codigo de Error[" + codError + "]");
					logger.info("Mensaje de Error[" + msgError + "]");
					logger.info("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al eliminar intentar los contactos del abonado "+contactoAbonadoTT.getNumAbonado(), String
								.valueOf(codError), numEvento, msgError);
			}			
	} catch (GeneralException e) {
		logger.error("Ocurrió un error al intentar eliminar los contactos del abonado "+contactoAbonadoTT.getNumAbonado(),e);
		if (logger.isDebugEnabled()) {
			logger.info("Codigo de Error[" + codError + "]");
			logger.info("Mensaje de Error[" + msgError + "]");
			logger.info("Numero de Evento[" + numEvento + "]");
		}
		throw(e);
	} catch (Exception e) {
		logger.error("Ocurrió un error al intentar eliminar los contactos del abonado "+contactoAbonadoTT.getNumAbonado(),e);
		throw new GeneralException("Ocurrió un error al intentar eliminar los contactos del abonado "+contactoAbonadoTT.getNumAbonado());
	} finally {
			logger.info("Cerrando conexiones...");
    try {
    	cstmt.close();
		if (!conn.isClosed()) {
			conn.close();
		}
	  } catch (SQLException e) {
			logger.info("SQLException", e);
	  }
	}

	logger.info("Fin:deletePvContactoAbonadoTT");		
	}

	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrogeneral) 	throws GeneralException	{
		
		logger.debug("getParametroGeneral():start");
		ParametrosGeneralesDTO retValue = new ParametrosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLgetParametroGeneral();
		try {
		
			conn = getConection();
			logger.debug("sql[" + call + "]");
			// System.out.println("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,parametrogeneral.getNombreparametro());
			cstmt.setString(2, parametrogeneral.getCodigomodulo());
			cstmt.setString(3, parametrogeneral.getCodigoproducto());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
            

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError [" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError [" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
		

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener parametro general.");
				if (logger.isDebugEnabled()) {
					logger.info("Codigo de Error[" + codError + "]");
					logger.info("Mensaje de Error[" + msgError + "]");
					logger.info("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException("Ocurrió un error al obtener parametro general.", numEvento, msgError);
			}	
			
			retValue.setNombreparametro(parametrogeneral.getNombreparametro());
			retValue.setCodigomodulo(parametrogeneral.getCodigomodulo());
			retValue.setCodigoproducto(parametrogeneral.getCodigoproducto());
			retValue.setValorparametro(cstmt.getString(4));
              
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener parametro general.");
				if (logger.isDebugEnabled()) {
					logger.info("Codigo de Error[" + codError + "]");
					logger.info("Mensaje de Error[" + msgError + "]");
					logger.info("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al obtener parametro general.", numEvento, msgError);
			}			
	} catch (GeneralException e) {
		logger.error("Ocurrió un error al obtener parametro general.",e);
		if (logger.isDebugEnabled()) {
			logger.info("Codigo de Error[" + codError + "]");
			logger.info("Mensaje de Error[" + msgError + "]");
			logger.info("Numero de Evento[" + numEvento + "]");
		}
		throw(e);
	} catch (Exception e) {
		logger.error("Ocurrió un error al obtener parametro general.",e);
		throw new GeneralException("Ocurrió un error al obtener parametro general.");
	} finally {
			logger.info("Cerrando conexiones...");
    try {
    	cstmt.close();
		if (!conn.isClosed()) {
			conn.close();
		}
	  } catch (SQLException e) {
			logger.info("SQLException", e);
	  }
	}
		
		logger.debug("getParametroGeneral():end");
		return retValue;

	}// fin getParametroGeneral
	

	
	// ---------------------------------------------------------------------------------------------------------------------------------------
	/**
	 * Inserta direccion
	 * @author Héctor Hermosilla
	 * @param entrada
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void setDireccion(DireccionNegocioWebDTO entrada) throws GeneralException	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:setDireccion");
			
			String call = getSql("VE_servicios_direcciones_PG","VE_inserta_direccion_PR",19);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,Integer.parseInt(entrada.getCodigo()));
			
			cstmt.setString(2,entrada.getCodMunicipio());
			logger.debug("entrada.provincia/municipio:" + entrada.getCodMunicipio());
			cstmt.setString(3,entrada.getCodDepartamento());
			logger.debug("entrada.getRegion/departamento:" + entrada.getCodDepartamento());
			cstmt.setString(4,entrada.getCodZonaDistrito());
			logger.debug("entrada.getCiudad:" + entrada.getCodZonaDistrito());

			cstmt.setString(5,entrada.getCodZonaDistrito());			
			cstmt.setString(6,entrada.getNombreCalle());
			cstmt.setString(7,entrada.getNumeroCalle());
			cstmt.setString(8,null);			
			cstmt.setString(9,null);			
			cstmt.setString(10,entrada.getObservacionDireccion());
			cstmt.setString(11,entrada.getLocBarrio());
			logger.debug("entrada.getComuna:" + entrada.getLocBarrio());
			cstmt.setString(12,null);
			cstmt.setString(13,null);
			cstmt.setString(14,null);
			cstmt.setString(15,entrada.getCodigoPostalDireccion());
			cstmt.setString(16,entrada.getCodSiglaDomicilio());

			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:setDireccion:execute");
			cstmt.execute();
			logger.debug("Fin:setDireccion:execute");
			
			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			if (codError !=0){
				logger.error("Ocurrió un error al insertar la direccion");
				throw new GeneralException(
						"Ocurrió un error al insertar la direccion", String
								.valueOf(codError), numEvento, msgError);
			}
			
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar la direccion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof GeneralException ) throw (GeneralException) e;			
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
		logger.debug("Fin:setDireccion");
		
	}//fin setDireccion
	
	// ---------------------------------------------------------------------------------------------------------------------------------------		
	
	private String getSQLGaContTHDelGaContTO_DelDireccion()
	{
		StringBuffer call = new StringBuffer();
			call.append(" "+
				"	BEGIN "+
					"	 GA_SERV911CORREOFAX_PG.PV_TRATAMIENTOSS_911FAX_PR(?,? );"+
				"	END; ");
					
		
		return call.toString();
	}
	public void setGaContTHDelGaContTO_DelDireccion(GaContactoAbonadoTO gaContactoAbonadoTO)throws GeneralException
	{
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;	
			CallableStatement cstmt = null;
			try {
				logger.info("Inicio:setGaContTHDelGaContTO_DelDireccion");
				conn = getConection();
				String callDelete = getSQLGaContTHDelGaContTO_DelDireccion();
				logger.info("sql[" + callDelete + "]");
			
				cstmt = conn.prepareCall(callDelete);
				logger.info("NUM_ABONADO: " +gaContactoAbonadoTO.getNumAbonado());
				logger.info("Usuario: " +gaContactoAbonadoTO.getNomUsuarora());
				cstmt.setLong(1,gaContactoAbonadoTO.getNumAbonado());
				cstmt.setString(2,gaContactoAbonadoTO.getNomUsuarora());
				/*cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);*/
				
				logger.info("Inicio:setGaContTHDelGaContTO_DelDireccion:execute");			
				cstmt.execute();			
				logger.info("Fin:setGaContTHDelGaContTO_DelDireccion:execute");
	
				codError=0;//cstmt.getInt(3);
				msgError =""; //cstmt.getString(4);
				numEvento=0;//cstmt.getInt(5);			
				
				if (codError != 0) {
					logger.error("Ocurrió un error al eliminar los contactos del Abonado : "+gaContactoAbonadoTO.getNumAbonado());
					if (logger.isDebugEnabled()) {
						logger.info("Codigo de Error[" + codError + "]");
						logger.info("Mensaje de Error[" + msgError + "]");
						logger.info("Numero de Evento[" + numEvento + "]");
					}
					throw new GeneralException(
							"Ocurrió un error al eliminar los contactos del Abonado :"+gaContactoAbonadoTO.getNumAbonado(), String
									.valueOf(codError), numEvento, msgError);
				}			
		} catch (GeneralException e) {
			logger.error("Ocurrió un error al eliminar los contactos del Abonado : "+gaContactoAbonadoTO.getNumAbonado(),e);
			if (logger.isDebugEnabled()) {
				logger.info("Codigo de Error[" + codError + "]");
				logger.info("Mensaje de Error[" + msgError + "]");
				logger.info("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al eliminar los contactos del Abonado : "+gaContactoAbonadoTO.getNumAbonado(),e);
			throw new GeneralException("Ocurrió un error al eliminar los contactos del Abonado : "+gaContactoAbonadoTO.getNumAbonado());
		} finally {
				logger.info("Cerrando conexiones...");
			    try {
			    	cstmt.close();
					if (!conn.isClosed()) {
						conn.close();
					}
				  } catch (SQLException e) {
						logger.info("SQLException", e);
				  }
		}
	
		logger.info("Fin:setGaContTHDelGaContTO_DelDireccion");	
		}
	
}