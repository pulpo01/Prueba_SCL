/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 01/06/2007	     	Elizabeth Vera        				Versión Inicial
 * 26/07/2007           Raúl Lozano                       ObtenerListaAbonados(fec_AcepVenta,cod_uso)
 */
package com.tmmas.scl.framework.customerDomain.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dao.interfaces.AbonadoDAOIT;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.customerDomain.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;

public class AbonadoDAO extends ConnectionDAO implements AbonadoDAOIT {

	private final Logger logger = Logger.getLogger(AbonadoDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLobtenerDatosUsuario() {
		StringBuffer call = new StringBuffer();
		
		call.append("		DECLARE "); 
		call.append("		    SEO_DAT_ABO PV_DATOS_ABO_QT := NEW PV_DATOS_ABO_QT;");
		call.append("		BEGIN  ");
		call.append("		  SEO_DAT_ABO.NUM_ABONADO := ?; "); 
		call.append("		  PV_CAMBIO_SERIE_SB_PG.PV_REC_INFO_ABONADO_PR ( SEO_DAT_ABO, ?, ?, ? ); ");
		call.append("		  ? := SEO_DAT_ABO.nom_usuario; ");
		call.append("		  ? := SEO_DAT_ABO.nom_apellido1; ");
		call.append("		  ? := SEO_DAT_ABO.nom_apellido2; ");
		call.append("		  ? := SEO_DAT_ABO.des_equipo; ");
		call.append("		  ? := SEO_DAT_ABO.num_serie; ");
		call.append("		  ? := SEO_DAT_ABO.des_procequi; ");
		call.append("		  ? := SEO_DAT_ABO.des_terminal; ");
		call.append("		  ? := SEO_DAT_ABO.des_modventa; ");
		call.append("		  ? := SEO_DAT_ABO.num_seriemec; ");
		call.append("		  ? := SEO_DAT_ABO.ind_propiedad; ");
		call.append("		  ? := SEO_DAT_ABO.des_uso; ");
		call.append("		  ? := SEO_DAT_ABO.ind_procequi; ");
		call.append("	   	  ? := SEO_DAT_ABO.ind_cuotas; ");
		call.append("		  ? := SEO_DAT_ABO.cod_modventa; ");
		call.append("		  ? := SEO_DAT_ABO.des_tipcontrato; ");
		call.append("		  ? := SEO_DAT_ABO.cod_tiplan; ");
		call.append("		  ? := SEO_DAT_ABO.num_imei; ");
		call.append("		  ? := SEO_DAT_ABO.cod_tipcontrato; ");
		call.append("		  ? := SEO_dat_abo.cod_plantarif; ");					
		call.append("		  ? := SEO_dat_abo.num_contrato; ");
		call.append("		  ? := SEO_dat_abo.num_anexo; ");		
		call.append("		  ? := SEO_dat_abo.cod_region; ");
		call.append("		  ? := SEO_dat_abo.cod_provincia; ");
		call.append("		  ? := SEO_dat_abo.cod_ciudad; ");
		call.append("		  ? := SEO_dat_abo.cod_cliente; ");
		call.append("		  ? := SEO_dat_abo.num_celular; ");
		call.append("		  ? := SEO_dat_abo.cod_tecnologia; ");
		call.append("		  ? := SEO_dat_abo.fec_alta; "); 		
		call.append("		  ? := SEO_dat_abo.tip_plantarif; ");
		call.append("		  ? := SEO_dat_abo.tip_terminal; ");
		call.append("		  ? := SEO_dat_abo.cod_situacion; ");				
		call.append("		  ? := SEO_dat_abo.des_situacion; ");
		call.append("		  ? := SEO_dat_abo.cod_articulo; ");
		call.append("		END;  ");
		return call.toString(); 		 		
	}

	private String getSQLobtenerDatosAbonado() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE ");
		call
		.append("   so_abonado GA_ABONADO2_QT := NEW GA_ABONADO2_QT;");
		call.append(" BEGIN ");
		call.append("   so_abonado.NUM_ABONADO := ?;");
		call.append("   PV_DATOS_ABONADO2_PG.PV_OBTIENE_DATOS_ABONADO_PR( so_abonado, ?, ?, ?);");
		call.append("		? := so_abonado.COD_CLIENTE;");
		call.append("		? := so_abonado.NUM_ABONADO;");
		call.append("		? := so_abonado.NUM_CELULAR;");
		call.append("		? := so_abonado.NUM_SERIE;");
		call.append("		? := so_abonado.NUM_SIMCARD;");
		call.append("		? := so_abonado.COD_TECNOLOGIA;");
		call.append("		? := so_abonado.COD_SITUACION;");
		call.append("		? := so_abonado.DES_SITUACION;");
		call.append("		? := so_abonado.TIP_PLANTARIF;");
		call.append("		? := so_abonado.DES_TIPPLANTARIF;");
		call.append("		? := so_abonado.COD_PLANTARIF;");
		call.append("		? := so_abonado.DES_PLANTARIF;");
		call.append("		? := so_abonado.COD_CICLO;");
		call.append("		? := so_abonado.COD_LIMCONSUMO;");
		call.append("		? := so_abonado.DES_LIMCONSUMO;");
		call.append("		? := so_abonado.COD_PLANSERV;");
		call.append("		? := so_abonado.COD_TIPLAN;");
		call.append("		? := so_abonado.DES_TIPLAN;");
		call.append("		? := so_abonado.COD_TIPCONTRATO;");
		call.append("		? := so_abonado.FECHA_ALTA;");
		call.append("		? := so_abonado.FEC_FINCONTRA;");
		call.append("		? := so_abonado.IND_EQPRESTADO;");
		call.append("		? := so_abonado.FECHA_PRORROGA;");
		call.append("		? := so_abonado.FLG_RANGO;");
		call.append("		? := so_abonado.IMP_CARGOBASICO;");
		call.append("		? := so_abonado.COD_CENTRAL;");
		call.append("		? := so_abonado.COD_USO;");		
		call.append("		? := so_abonado.COD_VENDEDOR;");

		call.append(" END;");

		return call.toString();
	}

	public String getSQLgetPlanTarifarioDefault(){
		StringBuffer call =new StringBuffer();
		call.append("BEGIN ");
		call.append("	PV_ACTCAMBIOS_OFVIRTUAL_PG.PV_RECPLANTARIFDES_PR (?,?,?,?,?,?,?);");
		call.append("END; ");
		
		return call.toString();
	}

	public String getSQLobtenerCeldaAbonado(){
		StringBuffer call =new StringBuffer();
		call.append("BEGIN ");
		call.append("	PV_DATOS_ABONADO2_PG.PV_OBTIENE_CELDA_ABONADO_PR (?,?,?,?,?);");
		call.append("END; ");
		
		return call.toString();
	}
	
	private String getSQLobtenerDatosAbonado2() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE ");
        call.append("   SO_Cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
        call.append(" BEGIN ");
		call.append("   SO_Cliente.cod_cliente := ?;");
		call.append("   PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_ABOCLIE2_PR(?, SO_Cliente, ?, ?, ?);");
		call.append("		? := SO_Cliente.cod_plantarif;");
		call.append("		? := SO_Cliente.des_plantarif;");
		call.append("		? := SO_Cliente.tip_terminal;");
		call.append("		? := SO_Cliente.des_terminal;");
		call.append("		? := SO_Cliente.cod_cargobasico;");
		call.append("		? := SO_Cliente.des_cargobasico;");
		call.append("		? := SO_Cliente.cod_limconsumo;");
		call.append("		? := SO_Cliente.des_limconsumo;");
		call.append("		? := SO_Cliente.cod_tiplan;");
		call.append("		? := SO_Cliente.des_tiplan;");
		call.append("		? := SO_Cliente.imp_cargobasico;");
		call.append("		? := SO_Cliente.ind_familiar;");
//		call.append("		? := SO_Cliente.cod_empresa;");
//		call.append("		? := SO_Cliente.flg_rango;");
//		call.append("		? := SO_Cliente.cod_ciclo;");
//		call.append("		? := SO_Cliente.cod_cuenta;");
//		call.append("		? := SO_Cliente.des_cuenta;");
//		call.append("		? := SO_Cliente.tip_plantarif;");
//		call.append("		? := so_cliente.des_tipplantarif;");
//		call.append("		? := SO_Cliente.cod_tipident;");
//		call.append("		? := SO_Cliente.num_ident;");
//		call.append("		? := SO_Cliente.tip_cuenta;");
//		call.append("		? := SO_Cliente.FECHA_PRORROGA;");
//		call.append("		? := SO_Cliente.FLG_RANGO;");
//		call.append("		? := SO_Cliente.IMP_CARGOBASICO;");
//		call.append("		? := SO_Cliente.COD_CENTRAL;");
//		call.append("		? := SO_Cliente.COD_USO;");		
//		call.append("		? := SO_Cliente.COD_VENDEDOR;");

		call.append(" END;");

		return call.toString();
	}	

	
	/**
	 * Recupera el codigo de celada del abonado
	 * 
	 * @param abonado
	 * @return String
	 * @throws CustomerException
	 */

	public String obtenerCeldaAbonado(long numAbonado)	throws CustomerException {

		logger.debug("obtenerCeldaAbonado():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String respuesta = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLobtenerCeldaAbonado();
		String codCelda = null;
		try {
			
			logger.debug("Parámetros de entrada");
			logger.debug("numAbonado[" + numAbonado + "]");

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, numAbonado);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);	
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
				.error(" Ocurrió un error al recuperar la celda del abonado.");
				throw new CustomerException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			codCelda = cstmt.getString(2);
			logger.debug("codCelda[" + codCelda + "]");
		} catch (CustomerException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error al recuperar la celda del abonado.",
					e);
			throw new CustomerException(
					"Ocurrió un error al recuperar la celda del abonado.",
					e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerCeldaAbonado():end");
		return codCelda;
		
	} // obtenerCeldaAbonado

	/**
	 * Recupera la informacion del abonado
	 * 
	 * @param abonado
	 * @return AbonadoDTO
	 * @throws ProductException
	 */

	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado)
	throws CustomerException {

		logger.debug("obtenerDatosAbonado():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO respuesta = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLobtenerDatosAbonado();
		try {
			
			logger.debug("Parámetros de entrada");
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado()+ "]");

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, abonado.getNumAbonado());

			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); // COD_CLIENTE
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC); // NUM_ABONADO
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC); // NUM_CELULAR
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); // NUM_SERIE
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); // NUM_SIMCARD
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); // COD_TECNOLOGIA
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); // COD_SITUACION
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR); // DES_SITUACION
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR); // TIP_PLANTARIF
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR); // DES_TIPPLANTARIF
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR); // COD_PLANTARIF
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR); // DES_PLANTARIF
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR); // COD_CICLO
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR); // COD_LIMCONSUMO
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR); // DES_LIMCONSUMO
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR); // COD_PLANSERV
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR); // COD_TIPLAN
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR); // DES_TIPLAN
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR); // COD_TIPCONTRATO
			cstmt.registerOutParameter(24, java.sql.Types.DATE); // FECHA_ALTA
			cstmt.registerOutParameter(25, java.sql.Types.DATE); // FEC_FINCONTRA
			cstmt.registerOutParameter(26, java.sql.Types.VARCHAR); // IND_EQPRESTADO
			cstmt.registerOutParameter(27, java.sql.Types.DATE); // FECHA_PRORROGA
			cstmt.registerOutParameter(28, java.sql.Types.NUMERIC); // FLG_RANGO
			cstmt.registerOutParameter(29, java.sql.Types.NUMERIC); // IMP_CARGOBASICO
			cstmt.registerOutParameter(30, java.sql.Types.NUMERIC); // COD_CENTRAL
			cstmt.registerOutParameter(31, java.sql.Types.NUMERIC); // COD_USO
			cstmt.registerOutParameter(32, java.sql.Types.NUMERIC); // COD_VENDEDOR			

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
				.error(" Ocurrió un error al recuperar los datos del abonado");
				throw new CustomerException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			long codCliente = cstmt.getLong(5);
			logger.debug("codCliente[" + codCliente + "]");

			long numAbonado = cstmt.getLong(6);
			logger.debug("numAbonado[" + numAbonado + "]");

			long numCelular = cstmt.getLong(7);
			logger.debug("numCelular[" + numCelular + "]");

			String numSerie = cstmt.getString(8);
			logger.debug("numSerie[" + numSerie + "]");

			String numSimcard = cstmt.getString(9);
			logger.debug("numSimcard[" + numSimcard + "]");

			String codTecnologia = cstmt.getString(10);
			logger.debug("codTecnologia[" + codTecnologia + "]");

			String codSituacion = cstmt.getString(11);
			logger.debug("codSituacion[" + codSituacion + "]");

			String desSituacion = cstmt.getString(12);
			logger.debug("desSituacion[" + desSituacion + "]");

			String tipPlanTarif = cstmt.getString(13);
			logger.debug("tipPlanTarif[" + tipPlanTarif + "]");

			String desTipPlanTarif = cstmt.getString(14);
			logger.debug("desTipPlanTarif[" + desTipPlanTarif + "]");

			String codPlanTarif = cstmt.getString(15);
			logger.debug("codPlanTarif[" + codPlanTarif + "]");

			String desPlanTarif = cstmt.getString(16);
			logger.debug("desPlanTarif[" + desPlanTarif + "]");

			int codCiclo = cstmt.getInt(17);
			logger.debug("codCiclo[" + codCiclo + "]");

			String codLimConsumo = cstmt.getString(18);
			logger.debug("codLimConsumo[" + codLimConsumo + "]");

			String desLimConsumo = cstmt.getString(19);
			logger.debug("desLimConsumo[" + desLimConsumo + "]");

			String codPlanServ = cstmt.getString(20);
			logger.debug("codPlanServ[" + codPlanServ + "]");

			String codTiplan = cstmt.getString(21);
			logger.debug("codTiplan[" + codTiplan + "]");

			String desTiplan = cstmt.getString(22);
			logger.debug("desTiplan[" + desTiplan + "]");

			String codTipContrato = cstmt.getString(23);
			logger.debug("codTipContrato[" + codTipContrato + "]");

			Date fechaAlta = cstmt.getDate(24);
			logger.debug("fechaAlta[" + fechaAlta + "]");

			Date fechaFinContrato = cstmt.getDate(25);
			logger.debug("fechaFinContrato[" + fechaFinContrato + "]");

			String indEqPrestado = cstmt.getString(26);
			logger.debug("indEqPrestado[" + indEqPrestado + "]");

			Date fechaProrroga = cstmt.getDate(27);
			logger.debug("fechaProrroga[" + fechaProrroga + "]");

			int flgRango = cstmt.getInt(28);
			logger.debug("flgRango[" + flgRango + "]");

			String impCargoBasico = cstmt.getString(29);
			logger.debug("impCargoBasico[" + impCargoBasico + "]");
			
			int codCentral = cstmt.getInt(30);
			logger.debug("codCentral[" + codCentral + "]");
		
			String codUso= cstmt.getString(31);
			logger.debug("codUso[" + codUso + "]");

			long codVendedor= cstmt.getLong(32);
			logger.debug("codVendedor[" + codVendedor + "]");

			respuesta = new AbonadoDTO();
			respuesta.setCodCliente(codCliente);
			respuesta.setNumAbonado(numAbonado);
			respuesta.setNumCelular(numCelular);
			respuesta.setNumSerie(numSerie);
			respuesta.setSimCard(numSimcard);
			respuesta.setCodTecnologia(codTecnologia);
			respuesta.setCodSituacion(codSituacion);
			respuesta.setDesSituacion(desSituacion);
			respuesta.setCodTipoPlanTarif(tipPlanTarif);
			respuesta.setDesTipoPlanTarif(desTipPlanTarif);
			respuesta.setCodPlanTarif(codPlanTarif);
			respuesta.setDesPlanTarif(desPlanTarif);
			respuesta.setCodCiclo(codCiclo);
			respuesta.setLimiteConsumo(codLimConsumo);
			respuesta.setDesLimiteConsumo(desLimConsumo);
			respuesta.setCodPlanServ(codPlanServ);
			respuesta.setCodTipPlan(codTiplan);
			respuesta.setDesTipPlan(desTiplan);
			respuesta.setCodTipContrato(codTipContrato);
			respuesta.setFecFinContrato(fechaFinContrato);
			respuesta.setFecAlta(fechaAlta);
			respuesta.setFecProrroga(fechaProrroga);
			respuesta.setIndEqPrestado(indEqPrestado);
			respuesta.setFlgRango(flgRango);
			respuesta.setImpCargoBasico(impCargoBasico);
			respuesta.setCodCentral(codCentral);
			respuesta.setCodUso(codUso);
			respuesta.setCodVendedor(codVendedor);			

		} catch (CustomerException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al recuperar los datos del abonado",
					e);
			throw new CustomerException(
					"Ocurrió un error general al recuperar los datos del abonado",
					e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerDatosAbonado():end");
		return respuesta;
	}


	public UsuarioAbonadoDTO obtenerDatosUsuarioCelular(UsuarioAbonadoDTO usuarioAbonado)
	throws CustomerException {

		logger.debug("obtenerDatosUsuarioCelular():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLobtenerDatosUsuario();
		try {
			logger.debug("Parámetros de entrada");
			logger.debug("abonado.getNumAbonado()[" + usuarioAbonado.getNum_abonado()+ "]");

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, usuarioAbonado.getNum_abonado());
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);	
			
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
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			
			
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(27, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(28, java.sql.Types.VARCHAR);					
			cstmt.registerOutParameter(29, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(30, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(31, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(32, java.sql.Types.DATE);			
			cstmt.registerOutParameter(33, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(34, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(35, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(36, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(37, java.sql.Types.VARCHAR);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
                      			          		
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
				.error(" Ocurrió un error al obtener los Datos del Usuario del Celular");
				throw new CustomerException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");


			usuarioAbonado.setNom_usuario(cstmt.getString(5));
			usuarioAbonado.setNom_apellido1(cstmt.getString(6));
			usuarioAbonado.setNom_apellido2(cstmt.getString(7));
			usuarioAbonado.setDes_equipo(cstmt.getString(8));
			usuarioAbonado.setNum_serie(cstmt.getString(9));
			usuarioAbonado.setDes_procequi(cstmt.getString(10));
			usuarioAbonado.setDes_terminal(cstmt.getString(11));
			usuarioAbonado.setDes_modventa(cstmt.getString(12));
			usuarioAbonado.setNum_seriemec(cstmt.getString(13));
			usuarioAbonado.setInd_propiedad(cstmt.getString(14));
			usuarioAbonado.setDes_uso(cstmt.getString(15));
			usuarioAbonado.setInd_procequi(cstmt.getString(16));
			usuarioAbonado.setInd_cuotas(cstmt.getInt(17));
			usuarioAbonado.setCod_modventa(cstmt.getInt(18));
			usuarioAbonado.setDes_tipcontrato(cstmt.getString(19));
			usuarioAbonado.setCod_tiplan(cstmt.getString(20));
			usuarioAbonado.setNum_imei(cstmt.getString(21));
			usuarioAbonado.setCodTipContrato(cstmt.getString(22));			
			usuarioAbonado.setCodPlantarif(cstmt.getString(23));					
			usuarioAbonado.setNumContrato(cstmt.getString(24));
			usuarioAbonado.setNumAnexo(cstmt.getString(25));						
			usuarioAbonado.setCod_cliente(cstmt.getLong(29));
			usuarioAbonado.setNum_celular(cstmt.getLong(30));
			usuarioAbonado.setCod_tecnologia(cstmt.getString(31));
			usuarioAbonado.setFec_alta(cstmt.getDate(32));			
			usuarioAbonado.setTip_plantarif(cstmt.getString(33));
			usuarioAbonado.setTip_terminal(cstmt.getString(34));
			usuarioAbonado.setCod_situacion(cstmt.getString(35));
			usuarioAbonado.setDes_situacion(cstmt.getString(36));
			String codArt=cstmt.getString(37)==null||"".equals(cstmt.getString(37))?"0":cstmt.getString(37);
			usuarioAbonado.setCodArtEquipo(Long.parseLong(codArt));
						
		} catch (CustomerException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error al obtener los Datos del Usuario del Celular",
					e);
			System.out.println("Message"+e.getMessage());
			System.out.println("Message"+e.getStackTrace());
			throw new CustomerException(
					"Ocurrió un error al obtener los Datos del Usuario del Celular",
					e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerDatosUsuarioCelular():end");
		return usuarioAbonado;
	}
	
	
	public UsuarioAbonadoDTO getPlanTarifarioDefault(UsuarioAbonadoDTO usuarioAbonadoDTO)throws CustomerException{
		logger.debug("getPlanTarifarioDefault():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLgetPlanTarifarioDefault();
		try {
			logger.debug("Parámetros de entrada");
			logger.debug("codPlanTarifario[" + usuarioAbonadoDTO.getCodPlantarif() + "]");
			logger.debug("codTecnologia[" + usuarioAbonadoDTO.getCod_tecnologia()+ "]");
			logger.debug("codTecnologia Destino["+usuarioAbonadoDTO.getCodTecDestino()+"]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, usuarioAbonadoDTO.getCodPlantarif());
			cstmt.setString(2, usuarioAbonadoDTO.getCod_tecnologia());
			cstmt.setString(3, usuarioAbonadoDTO.getCodTecDestino());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);	
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al recuperar los datos del vendedor");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}

			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			
			usuarioAbonadoDTO.setNuevoPlanTarif(cstmt.getString(4));
			
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar los datos del vendedor", e);
			throw new CustomerException("Ocurrió un error general al recuperar los datos del vendedor",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerInformacionUsuario():end");
		return usuarioAbonadoDTO;
	}

	/**
	 * Obtiene los datos del abonado para las OOSS Aviso y Anulacion de Siniestro.
	 * Package: PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_ABOCLIENTE2_PR
	 * @param abonado del tipo AbonadoDTO
	 * @return AbonadoDTO
	 * @throws CustomerException
	 * @author Santiago Ventura
	 * @date 15-04-2010 
	 */	
	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws CustomerException {
		logger.debug("obtenerDatosAbonado():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO respuesta = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLobtenerDatosAbonado2();
		try {
			logger.debug("CALL####: "+call);
			logger.debug("Parámetros de entrada");
			logger.debug("abonado.getCodCliente()[" + abonado.getCodCliente()+ "]");
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado()+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, abonado.getCodCliente());
			cstmt.setLong(2, abonado.getNumAbonado());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			
						
			//"SO_Cliente.cod_plantarif COD_PLANTARIF VARCHAR2(3),
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); // COD_PLANTARIF
			//"SO_Cliente.des_plantarif DES_PLANTARIF VARCHAR2(30),
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); // DES_PLANTARIF
			//"SO_Cliente.tip_terminal TIP_TERMINAL VARCHAR2(1),
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); // TIP_TERMINAL
			//"SO_Cliente.des_terminal DES_TERMINAL VARCHAR2(15),
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); // des_terminal
			//"SO_Cliente.cod_cargobasico COD_CARGOBASICO VARCHAR2(3),
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); // COD_CARGOBASICO
			//"SO_Cliente.des_cargobasico DES_CARGOBASICO VARCHAR2(30),
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); // des_cargobasico
			//"SO_Cliente.cod_limconsumo COD_LIMCONSUMO VARCHAR2(3),
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR); // cod_limconsumo
			//"SO_Cliente.des_limconsumo DES_LIMCONSUMO VARCHAR2(30),
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR); // des_limconsumo
			//"SO_Cliente.cod_tiplan COD_TIPLAN VARCHAR2(5),
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR); // COD_TIPLAN			
			//"SO_Cliente.des_tiplan DES_TIPLAN VARCHAR2(30),
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR); // DES_TIPLAN			
			//"SO_Cliente.imp_cargobasico IMP_CARGOBASICO NUMBER(12,4),
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC); // IMP_CARGOBASICO			
			//"SO_Cliente.ind_familiar IND_FAMILIAR NUMBER(1),
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC); // ind_familiar
			//"SO_Cliente.cod_empresa COD_EMPRESA NUMBER(8),
			//cstmt.registerOutParameter(18, java.sql.Types.NUMERIC); // cod_empresa
			//"SO_Cliente.flg_rango FLG_RANGO NUMBER(1),
			//cstmt.registerOutParameter(19, java.sql.Types.NUMERIC); // flg_rango
			//"SO_Cliente.cod_ciclo COD_CICLO NUMBER(2),
			//cstmt.registerOutParameter(20, java.sql.Types.NUMERIC); // cod_ciclo
			//"SO_Cliente.cod_cuenta COD_CUENTA NUMBER(8),
			//cstmt.registerOutParameter(21, java.sql.Types.NUMERIC); // cod_cuenta
			//"SO_Cliente.des_cuenta DES_CUENTA VARCHAR2(50),
			//cstmt.registerOutParameter(22, java.sql.Types.VARCHAR); // des_cuenta
			//"SO_Cliente.tip_plantarif TIP_PLANTARIF VARCHAR2(1),
			//cstmt.registerOutParameter(23, java.sql.Types.VARCHAR); // TIP_PLANTARIF
			//"so_cliente.des_tipplantarif DES_TIPPLANTARIF VARCHAR2(15),
			//cstmt.registerOutParameter(24, java.sql.Types.VARCHAR); // DES_TIPPLANTARIF
			//"SO_Cliente.cod_tipident COD_TIPIDENT VARCHAR2(2),
			//cstmt.registerOutParameter(25, java.sql.Types.VARCHAR); // cod_tipident
			//"SO_Cliente.num_ident NUM_IDENT VARCHAR2(20),
			//cstmt.registerOutParameter(26, java.sql.Types.VARCHAR); // num_ident
			//"SO_Cliente.tip_cuenta TIP_CUENTA VARCHAR2(1),		
			//cstmt.registerOutParameter(27, java.sql.Types.VARCHAR); // tip_cuenta							

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
				.error(" Ocurrió un error al recuperar los datos del abonado");
				throw new CustomerException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			
			respuesta = new AbonadoDTO();
			respuesta.setNumAbonado(abonado.getNumAbonado());

			String cod_plantarif = cstmt.getString(6);
			logger.debug("cod_plantarif[" + cod_plantarif + "]");
			respuesta.setCodPlanTarif(cod_plantarif);

			String des_plantarif = cstmt.getString(7);
			logger.debug("des_plantarif[" + des_plantarif + "]");
			respuesta.setDesPlanTarif(des_plantarif);
			
			String tip_terminal = cstmt.getString(8);
			logger.debug("tip_terminal[" + tip_terminal + "]");
			//FALTA ATRIBUTO
			
			String des_terminal = cstmt.getString(9);
			logger.debug("des_terminal[" + des_terminal + "]");
			respuesta.setDesTipoTerminal(des_terminal);

			String cod_cargobasico = cstmt.getString(10);
			logger.debug("cod_cargobasico[" + cod_cargobasico + "]");
			respuesta.setCodCargoBasico(cod_cargobasico);

			String des_cargobasico = cstmt.getString(11);
			logger.debug("des_cargobasico[" + des_cargobasico + "]");
			respuesta.setDesCargoBasico(des_cargobasico);

			String cod_limconsumo = cstmt.getString(12);
			logger.debug("cod_limconsumo[" + cod_limconsumo + "]");
			//FALTA ATRIBUTO			

			String des_limconsumo = cstmt.getString(13);
			logger.debug("des_limconsumo[" + des_limconsumo + "]");
			respuesta.setDesLimiteConsumo(des_limconsumo);

			String cod_tiplan = cstmt.getString(14);
			logger.debug("cod_tiplan[" + cod_tiplan + "]");
			respuesta.setCodTipPlan(cod_tiplan);

			String des_tiplan = cstmt.getString(15);
			logger.debug("des_tiplan[" + des_tiplan + "]");
			respuesta.setDesTipPlan(des_tiplan);

			String imp_cargobasico = cstmt.getString(16);
			logger.debug("imp_cargobasico[" + imp_cargobasico + "]");
			respuesta.setImpCargoBasico(imp_cargobasico);

			String ind_familiar = cstmt.getString(17);
			logger.debug("ind_familiar[" + ind_familiar + "]");
//
//			String cod_empresa = cstmt.getString(18);
//			logger.debug("numSimcard[" + cod_empresa + "]");
//			respuesta.setCodEmpresa(cod_empresa);
//			
//			String flg_rangocod_empresa = cstmt.getString(19);
//			logger.debug("flg_rangocod_empresa[" + flg_rangocod_empresa + "]");
//			respuesta.setFlgRango(Integer.parseInt(flg_rangocod_empresa));
//
//			String cod_ciclo = cstmt.getString(20);
//			logger.debug("cod_ciclo[" + cod_ciclo + "]");
//			respuesta.setCodCiclo(Integer.parseInt(cod_ciclo));
//
//			String cod_cuenta = cstmt.getString(21);
//			logger.debug("cod_cuenta[" + cod_cuenta + "]");
//			respuesta.setCodCuenta(Integer.parseInt(cod_cuenta));
//
//			String des_cuenta = cstmt.getString(22);
//			logger.debug("des_cuenta[" + des_cuenta + "]");
//			//FALTA ATRIBUTO			
//
//			String tip_plantarif = cstmt.getString(23);
//			logger.debug("tip_plantarif[" + tip_plantarif + "]");
//			//FALTA ATRIBUTO			
//
//			String des_tipplantarif = cstmt.getString(24);
//			logger.debug("des_tipplantarif[" + des_tipplantarif + "]");
//			respuesta.setDesTipoPlanTarif(des_tipplantarif);
//
//			String cod_tipident = cstmt.getString(25);
//			logger.debug("cod_tipident[" + cod_tipident + "]");
//			//FALTA ATRIBUTO			
//
//			String num_ident = cstmt.getString(26);
//			logger.debug("num_ident[" + num_ident + "]");
//			//FALTA ATRIBUTO			
//			
//			String tip_cuenta = cstmt.getString(27);
//			logger.debug("tip_cuenta[" + tip_cuenta + "]");
//			//FALTA ATRIBUTO			

		} catch (CustomerException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar los datos del abonado",	e);
			throw new CustomerException("Ocurrió un error general al recuperar los datos del abonado",e);
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerDatosAbonado():end");
		return respuesta;
	}
}
