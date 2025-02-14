/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 23/02/2007     Roberto P&eacute;rez Varas      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

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
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCicloFactInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCicloFactOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCicloFactOutDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DetalleFacturaVO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.InfoFacturaDTO;

public class FacturacionDAO extends ConnectionDAO{

	private static Category cat = Category.getInstance(FacturacionDAO.class);
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

	private String getSQLFacturacion(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLFacturacion

	/**
	 * Obtiene Lista de ciclos de postpago
	 * @param cicloFactDTO 
	 * @return WsListCicloFactOutDTO
	 * @throws GeneralException
	 */
	public WsListCicloFactOutDTO getListadoCiclosPostPago(WsCicloFactInDTO cicloFactDTO) throws GeneralException{
		//RSIS21
		WsListCicloFactOutDTO resultado = null;
		WsCicloFactOutDTO[] ciclosFact = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getListadoCiclosPostPago()");
			resultado = new WsListCicloFactOutDTO();
			//INI-01 (AL) String call = getSQLFacturacion("FA_Servicios_Facturacion_PG","FA_getListCiclosPostPago_PR",5);
			String call = getSQLFacturacion("FA_SERVICIOS_FACT_QUIOSCO_PG","FA_getListCiclosPostPago_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,cicloFactDTO.getCodCiclo());
			cat.debug("cicloFactDTO.getCodCiclo() [" + cicloFactDTO.getCodCiclo() + "]");
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListadoCiclosPostPago:execute");
			cstmt.execute();
			cat.debug("Fin:getListadoCiclosPostPago:execute");

			codError  = cstmt.getInt(3);
			msgError  = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener lista de ciclos de post pago");
				resultado.setResultadoTransaccion(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						"Ocurrió un error al obtener lista de ciclos de post pago", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando lista de ciclos de post pago");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					WsCicloFactOutDTO cicloFactRS = new WsCicloFactOutDTO();
					cicloFactRS.setCodCiclo(rs.getInt(1));
					cicloFactRS.setDesCiclo(rs.getString(2));
					lista.add(cicloFactRS);
				}
				rs.close();
				ciclosFact =(WsCicloFactOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), WsCicloFactOutDTO.class);
				resultado.setWsCicloFactArrOutDTO(ciclosFact);
				cat.debug("lista de ciclos de post pago");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw (e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener lista de ciclos de post pago",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error [" + codError +  "]");
				cat.debug("Mensaje de Error[" + msgError +  "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error al obtener lista de ciclos de post pago",e);
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
		cat.debug("Fin:getListadoCiclosPostPago()");
		return resultado;
	}//fin getListadoCiclosPostPago

	/**
	 * Obtiene Lista de ciclos de postpago
	 * @param cicloFactDTO 
	 * @return WsListCicloFactOutDTO
	 * @throws GeneralException
	 */
	public void udpInterfazDeFacturación(GaVentasDTO gaVentas) throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:udpGaIntarcel()");

			//INI-01 (AL) String call = getSQLFacturacion("Ve_Servicios_Venta_Pg","VE_actualiza_facturacion_PR",13);
			String call = getSQLFacturacion("Ve_Servicios_Venta_Quiosco_Pg","VE_actualiza_facturacion_PR",13);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			/*EV_cod_estadoc         IN VARCHAR2
	          EV_cod_estproc	 	  IN VARCHAR2
			  EV_cod_catribdoc       IN VARCHAR2
	          EV_num_folio	 	      IN VARCHAR2
	          EV_pref_plaza	 	  IN VARCHAR2
	          EV_fec_vencimiento	  IN VARCHAR2
	          EV_nom_usuaelim	 	  IN VARCHAR2
	          EV_cod_causaelim	 	  IN VARCHAR2
	          EV_num_proceso	 	  IN VARCHAR2
	          EV_num_venta	 		  IN VARCHAR2
              SN_cod_retorno     	  OUT NOCOPY ge_errores_pg.CodError
              SV_mens_retorno    	  OUT NOCOPY ge_errores_pg.MsgError
	          SN_num_evento */


			cstmt.setString(1, "100");
			cstmt.setString(2, "3");
			cstmt.setString(3, null);
			cstmt.setString(4, null);
			cstmt.setString(5, null);
			cstmt.setString(6, null);
			cstmt.setString(7, null);
			cstmt.setString(8, null);
			cstmt.setString(9, null);
			cstmt.setString(10, gaVentas.getNumVenta().toString());
			cat.debug("gaVentas.getNumVenta().toString() ["+gaVentas.getNumVenta().toString()+"]");
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			cat.debug("Inicio:udpGaIntarcel:execute");
			cstmt.execute();
			cat.debug("Fin:udpGaIntarcel:execute");

			codError  = cstmt.getInt(11);
			msgError  = cstmt.getString(12);
			numEvento = cstmt.getInt(13);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error en udpGaIntarcel");				
				throw new GeneralException(
						"Ocurrió un error en udpGaIntarcel", String
						.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;

		} catch (Exception e) {
			cat.error("Ocurrió un error en udpGaIntarcel",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error [" + codError +  "]");
				cat.debug("Mensaje de Error[" + msgError +  "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error en udpGaIntarcel" ,e);
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
		cat.debug("Fin:udpGaIntarcel()");		
	}//fin getListadoCiclosPostPago	


	public InfoFacturaDTO getInforCargos(String numVenta, String numProceso) throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;

		DetalleFacturaVO[] detallesFactura = null;
		InfoFacturaDTO  InfoFactura = new InfoFacturaDTO();

		try {
			cat.debug("Inicio:getInforCargos()");

			String call = getSQLFacturacion("ve_cargos_pg","ve_obtiene_info_cargos_pr",17);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);


		     
			
			cstmt.setString(1, numVenta);
			cat.debug("numVenta ["+numVenta+"]");
			cstmt.setString(2, numProceso);
			cat.debug("numProceso ["+numProceso+"]");
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, OracleTypes.CURSOR);
			
			//Inicio Inc. 177348 - 06/11/2011 -  FADL
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			//Fin Inc. 177348 - 06/11/2011 -  FADL 
			
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);

			boolean ciclo = true;
            int cantidad = 0; 
			while(ciclo){

				cat.debug("Inicio:getInforCargos:execute");
				cstmt.execute();
				cat.debug("Fin:getInforCargos:execute");			

				codError  = cstmt.getInt(15);
				msgError  = cstmt.getString(16);
				numEvento = cstmt.getInt(17);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				

				if (codError != 111768 && !cstmt.getString(7).equals("0") && !cstmt.getString(3).equals("")){
					cat.debug("Fin Ciclo");
					cat.debug("Codigo de Error[" + cstmt.getString(6) + "]");
					cat.debug("Codigo de Error[" + cstmt.getString(3) + "]");
					ciclo = false;
				}else{
					cantidad = cantidad + 1;
					Thread.sleep(2000);
					if (codError == 0){
						((ResultSet)cstmt.getObject(9)).close();
					}
					cat.debug("Espera 2000 milesegundo los datos");
					cat.debug("cantidad ["+cantidad+"]");
					if (cantidad == 90){
						codError = 99999999;
						ciclo = false;
					}
					
					
					
				}
			}
			
			
			cat.debug("Despues del ciclo");
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			ArrayList lista = new ArrayList();			

			if (codError != 0 && codError != 99999999 ) {
				cat.error("Ocurrió un error en udpGaIntarcel");				
				throw new GeneralException(
						"Ocurrió un error en udpGaIntarcel", String
						.valueOf(codError), numEvento, msgError);
			}else if (codError == 99999999){
				
				InfoFactura.setTotalCargos(cstmt.getString(3));				
				cat.error("InfoFactura.setTotalCargos ["+InfoFactura.getTotalCargos()+"]");
				InfoFactura.setTotalITBM(cstmt.getString(4));
				cat.error("InfoFactura.setTotalITBM ["+InfoFactura.getTotalITBM()+"]");
				InfoFactura.setTotalISC(cstmt.getString(5));
				cat.error("InfoFactura.setTotalISC ["+InfoFactura.getTotalISC()+"]");
				InfoFactura.setTotalAPagar(cstmt.getString(6));
				cat.error("InfoFactura.setTotalAPagar ["+InfoFactura.getTotalAPagar()+"]");
				InfoFactura.setNumFolio("0");
				cat.error("InfoFactura.setNumFolio ["+InfoFactura.getNumFolio()+"]");
				InfoFactura.setPrefPlaza("0");												
				cat.error("InfoFactura.setPrefPlaza ["+InfoFactura.getPrefPlaza()+"]");
				
				DetalleFacturaVO DetalleFactura = new DetalleFacturaVO();
				lista.add(DetalleFactura);			
				detallesFactura = (DetalleFacturaVO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DetalleFacturaVO.class);
				InfoFactura.setLisdetalleFactura(detallesFactura);				
				
			}else{

				InfoFactura.setTotalCargos(cstmt.getString(3));				
				cat.error("InfoFactura.setTotalCargos ["+InfoFactura.getTotalCargos()+"]");
				InfoFactura.setTotalITBM(cstmt.getString(4));
				cat.error("InfoFactura.setTotalITBM ["+InfoFactura.getTotalITBM()+"]");
				InfoFactura.setTotalISC(cstmt.getString(5));
				cat.error("InfoFactura.setTotalISC ["+InfoFactura.getTotalISC()+"]");
				InfoFactura.setTotalAPagar(cstmt.getString(6));
				cat.error("InfoFactura.setTotalAPagar ["+InfoFactura.getTotalAPagar()+"]");
				InfoFactura.setNumFolio(cstmt.getString(7));
				cat.error("InfoFactura.setNumFolio ["+InfoFactura.getNumFolio()+"]");
				InfoFactura.setPrefPlaza(cstmt.getString(8));
				cat.error("InfoFactura.setPrefPlaza ["+InfoFactura.getPrefPlaza()+"]");


				ResultSet rs = (ResultSet) cstmt.getObject(9);
				
				cat.error("************************************ Inicio Detalle de Factura ************************************");
				while (rs.next()) {												
					DetalleFacturaVO DetalleFactura = new DetalleFacturaVO();

					DetalleFactura.setDescripArticulo(rs.getString(1));
					cat.error("DetalleFactura.setDescripArticulo ["+DetalleFactura.getDescripArticulo()+"]");
					DetalleFactura.setNumCantidad(String.valueOf(rs.getInt(2)));
					cat.error("DetalleFactura.setNumCantidad ["+DetalleFactura.getNumCantidad()+"]");
					DetalleFactura.setNumCelular("");
					cat.error("DetalleFactura.setNumCelular ["+DetalleFactura.getNumCelular()+"]");
					DetalleFactura.setSerieArticulo(rs.getString(3));
					cat.error("DetalleFactura.getSerieArticulo ["+DetalleFactura.getSerieArticulo()+"]");
					DetalleFactura.setPrecioUnitario(Float.valueOf(rs.getFloat(4)));
					cat.error("DetalleFactura.getPrecioUnitario ["+DetalleFactura.getPrecioUnitario()+"]");
					DetalleFactura.setDescuentoPrecio(rs.getDouble(5));
					
					
					lista.add(DetalleFactura);
				}
				
				//Inicio Inc. 177348 - 06/11/2011 -  FADL
				InfoFactura.setImpCruzRoja(cstmt.getString(10));				
				cat.error("InfoFactura.setImpCruzRoja ["+InfoFactura.getImpCruzRoja()+"]");
				InfoFactura.setImpNum911(cstmt.getString(11));				
				cat.error("InfoFactura.setImpNum911 ["+InfoFactura.getImpNum911()+"]");
				InfoFactura.setImpVenta(cstmt.getString(12));				
				cat.error("InfoFactura.setImpVenta ["+InfoFactura.getImpVenta()+"]");
				InfoFactura.setDescuentoTotal(cstmt.getString(13));				
				cat.error("InfoFactura.setDescuentoTotal ["+InfoFactura.getDescuentoTotal()+"]");
				InfoFactura.setNumSerie(cstmt.getString(14));				
				cat.error("InfoFactura.setNumSerie ["+InfoFactura.getNumSerie()+"]");
				//Fin Inc. 177348 - 06/11/2011 -  FADL
				
				cat.error("************************************ Fin Detalle de Factura ************************************");
				rs.close();

				detallesFactura = (DetalleFacturaVO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DetalleFacturaVO.class);
				InfoFactura.setLisdetalleFactura(detallesFactura);				

			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;

		} catch (Exception e) {
			cat.error("Ocurrió un error en udpGaIntarcel",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error [" + codError +  "]");
				cat.debug("Mensaje de Error[" + msgError +  "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error en udpGaIntarcel" ,e);
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
		cat.debug("Fin:getInforCargos()");
		return InfoFactura;		
	}//fin getInforCargos	

}//fin FacturacionDAO
