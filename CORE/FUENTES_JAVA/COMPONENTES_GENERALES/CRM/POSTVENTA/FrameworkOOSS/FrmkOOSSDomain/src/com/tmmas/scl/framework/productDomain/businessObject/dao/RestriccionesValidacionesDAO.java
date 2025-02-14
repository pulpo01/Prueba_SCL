/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 07/06/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.RestriccionesValidacionesDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroServiciosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroServiciosListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ValidaServiciosDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;

public class RestriccionesValidacionesDAO extends ConnectionDAO implements
RestriccionesValidacionesDAOIT {

	private final Logger logger = Logger.getLogger(RestriccionesValidacionesDAO.class);

	private final Global global = Global.getInstance();

	private String getSQLvalidaServicioActDesc() {

		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");		
		call.append("   eo_param PV_VALIDA_SERV_ACTDEC_QT := PV_INICIA_ESTRUCTURAS_PG.PV_VALIDA_SERV_ACTDEC_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_param.NUM_MOVIMIENTO := ?;");
		call.append("   eo_param.COD_ACTABO := ?;");
		call.append("   eo_param.COD_PRODUCTO := ?;");
		call.append("   eo_param.COD_TECNOLOGIA := ?;");
		call.append("   eo_param.TIP_PANTALLA := ?;");
		call.append("   eo_param.COD_CONCEPTO := ?;");
		call.append("   eo_param.COD_MODULO := ?;");
		call.append("   eo_param.COD_PLANTARIF_NUE := ?;");
		call.append("   eo_param.COD_PLANTARIF_ANT := ?;");
		call.append("   eo_param.TIP_ABONADO := ?;");
		call.append("   eo_param.COD_OS := ?;");
		call.append("   eo_param.COD_CLIENTE := ?;");
		call.append("   eo_param.NUM_ABONADO := ?;");
		call.append("   eo_param.IND_FACTUR := ?;");
		call.append("   eo_param.COD_PLANSERV := ?;");
		call.append("   eo_param.COD_OPERACION := ?;");
		call.append("   eo_param.COD_TIPCONTRATO := ?;");
		call.append("   eo_param.TIP_CELULAR := ?;");
		call.append("   eo_param.NUM_MESES := ?;");
		call.append("   eo_param.COD_ANTIGUEDAD := ?;");
		call.append("   eo_param.COD_CICLO := ?;");
		call.append("   eo_param.NUM_CELULAR := ?;");
		call.append("   eo_param.TIP_SERVICIO := ?;");
		call.append("   eo_param.COD_PLANCOM := ?;");
		call.append("   eo_param.PARAM1_MENS := ?;");
		call.append("   eo_param.PARAM2_MENS := ?;");
		call.append("   eo_param.PARAM3_MENS := ?;");
		call.append("   eo_param.COD_ARTICULO := ?;");
		call.append("   eo_param.COD_CAUSA := ?;");
		call.append("   eo_param.COD_CAUSA_NUE := ?;");
		call.append("   eo_param.COD_VEND := ?;");
		call.append("   eo_param.COD_CATEGORIA := ?;");
		call.append("   eo_param.COD_MODVENTA := ?;");
		call.append("   eo_param.COD_CAUSINIE := ?;");
		call.append("   PV_RESTRIC_VALIDACIONES_PG.PV_VALIDA_SERV_ACTDEC_PR( eo_param, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	

	/**
	 * Valida servicios a activar y desactivar
	 * 
	 * @param param
	 * @return RegistroServiciosListDTO
	 * @throws ProductSpecificationException
	 */	
	public RegistroServiciosListDTO validaServicioActDesc(ValidaServiciosDTO param)
	throws ProductSpecificationException {
		logger.debug("validaServicioActDesc():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RegistroServiciosListDTO serviciosList = null;
		RegistroServiciosDTO[] servicios = null;

		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLvalidaServicioActDesc();
		try {

			logger.debug("param.getNumMovimiento()[" + param.getNumMovimiento() + "]");
			logger.debug("param.getCodActAbo()[" + param.getCodActAbo() + "]");
			logger.debug("param.getCodProducto()[" + param.getCodProducto() + "]");
			logger.debug("param.getCodTecnologia()[" + param.getCodTecnologia() + "]");
			logger.debug("param.getTipPantalla()[" + param.getTipPantalla() + "]");
			logger.debug("param.getCodConcepto()[" + param.getCodConcepto() + "]");
			logger.debug("param.getCodModulo()[" + param.getCodModulo() + "]");
			logger.debug("param.getCodPlanTarifNue()[" + param.getCodPlanTarifNue() + "]");
			logger.debug("param.getCodPlanTarifAnt()[" + param.getCodPlanTarifAnt() + "]");
			logger.debug("param.getTipAbonado()[" + param.getTipAbonado() + "]");
			logger.debug("param.getCodOS()[" + param.getCodOS() + "]");
			logger.debug("param.getCodCliente()[" + param.getCodCliente() + "]");
			logger.debug("param.getIndFactur()[" + param.getIndFactur() + "]");
			logger.debug("param.getCodPlanServ()[" + param.getCodPlanServ() + "]");
			logger.debug("param.getCodOperacion()[" + param.getCodOperacion() + "]");
			logger.debug("param.getCodTipContrato()[" + param.getCodTipContrato() + "]");
			logger.debug("param.getTipCelular()[" + param.getTipCelular() + "]");
			logger.debug("param.getNumMeses()[" + param.getNumMeses() + "]");
			logger.debug("param.getCodAntiguedad()[" + param.getCodAntiguedad() + "]");
			logger.debug("param.getCodCiclo()[" + param.getCodCiclo() + "]");
			logger.debug("param.getNumCelular()[" + param.getNumCelular() + "]");
			logger.debug("param.getTipServicio()[" + param.getTipServicio() + "]");
			logger.debug("param.getCodPlanCom()[" + param.getCodPlanCom() + "]");
			logger.debug("param.getParam1Mens()[" + param.getParam1Mens() + "]");
			logger.debug("param.getParam2Mens()[" + param.getParam2Mens() + "]");
			logger.debug("param.getParam3Mens()[" + param.getParam3Mens() + "]");
			logger.debug("param.getCodArticulo()[" + param.getCodArticulo() + "]");
			logger.debug("param.getCodCausa()[" + param.getCodCausa() + "]");
			logger.debug("param.getCodCausaNue()[" + param.getCodCausaNue() + "]");
			logger.debug("param.getCodVend()[" + param.getCodVend() + "]");
			logger.debug("param.getCodCategoria()[" + param.getCodCategoria() + "]");
			logger.debug("param.getCodModVenta()[" + param.getCodModVenta() + "]");
			logger.debug("param.getCodCausinie()[" + param.getCodCausinie() + "]");

			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, param.getNumMovimiento()); //NUM_MOVIMIENTO
			cstmt.setString(2, param.getCodActAbo()); //COD_ACTABO
			cstmt.setInt(3, param.getCodProducto()); //COD_PRODUCTO
			cstmt.setString(4, param.getCodTecnologia()); //COD_TECNOLOGIA
			cstmt.setInt(5, param.getTipPantalla()); //TIP_PANTALLA
			cstmt.setInt(6, param.getCodConcepto()); //COD_CONCEPTO
			cstmt.setString(7, param.getCodModulo()); //COD_MODULO
			cstmt.setString(8, param.getCodPlanTarifNue()); //COD_PLANTARIF_NUE
			cstmt.setString(9, param.getCodPlanTarifAnt()); //COD_PLANTARIF_ANT
			cstmt.setInt(10, param.getTipAbonado()); //TIP_ABONADO
			cstmt.setString(11, param.getCodOS()); //COD_OS
			cstmt.setLong(12, param.getCodCliente()); //COD_CLIENTE
			cstmt.setLong(13, param.getNumAbonado()); //NUM_ABONADO
			cstmt.setInt(14, param.getIndFactur()); //IND_FACTUR
			cstmt.setString(15, param.getCodPlanServ()); //COD_PLANSERV
			cstmt.setString(16, param.getCodOperacion()); //COD_OPERACION
			cstmt.setString(17, param.getCodTipContrato()); //COD_TIPCONTRATO
			cstmt.setString(18, param.getTipCelular()); //TIP_CELULAR
			cstmt.setInt(19, param.getNumMeses()); //NUM_MESES
			cstmt.setString(20, param.getCodAntiguedad()); //COD_ANTIGUEDAD
			cstmt.setInt(21, param.getCodCiclo()); //COD_CICLO
			cstmt.setLong(22, param.getNumCelular()); //NUM_CELULAR
			cstmt.setInt(23, param.getTipServicio()); //TIP_SERVICIO
			cstmt.setInt(24, param.getCodPlanCom()); //COD_PLANCOM
			cstmt.setString(25, param.getParam1Mens()); //PARAM1_MENS
			cstmt.setString(26, param.getParam2Mens()); //PARAM2_MENS
			cstmt.setString(27, param.getParam3Mens()); //PARAM3_MENS
			cstmt.setInt(28, param.getCodArticulo()); //COD_ARTICULO
			cstmt.setString(29, param.getCodCausa()); //COD_CAUSA
			cstmt.setString(30, param.getCodCausaNue()); //COD_CAUSA_NUE
			cstmt.setInt(31, param.getCodVend()); //COD_VEND
			cstmt.setString(32, param.getCodCategoria()); //COD_CATEGORIA
			cstmt.setInt(33, param.getCodModVenta()); //COD_MODVENTA
			cstmt.setString(34, param.getCodCausinie()); //COD_CAUSINIE

			cstmt.registerOutParameter(35, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(36, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(37, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(38, java.sql.Types.NUMERIC);			

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(36);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(37);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(38);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error al validar servicios");
				throw new ProductSpecificationException(String.valueOf(codError),numEvento, msgError);
			}

			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(35);
			ArrayList lista = new ArrayList();
			String cadenaServiciosActDes = "";
			while (rs.next()) {
				RegistroServiciosDTO registro = new RegistroServiciosDTO();

				registro.setNumMovimiento(rs.getLong(1));
				registro.setCodActAbo(rs.getString(2));
				registro.setIndFactur(rs.getString(3));
				registro.setDesServ(rs.getString(4));
				registro.setNumUnidades(rs.getInt(5));
				registro.setCodConcepto(rs.getInt(6));
				registro.setImpCargo(rs.getFloat(7));
				registro.setCodArticulo(rs.getInt(8));
				registro.setCodBodega(rs.getInt(9));
				registro.setNumSerie(rs.getString(10));
				registro.setIndEquipo(rs.getString(11));
				registro.setCodCliente(rs.getLong(12));
				registro.setNumAbonado(rs.getLong(13));
				registro.setTipDto(rs.getString(14));
				registro.setValDto(rs.getFloat(15));
				registro.setCodConceptoDTO(rs.getInt(16));
				registro.setNumCelular(rs.getLong(17));
				registro.setCodPlanCom(rs.getInt(18));
				registro.setClaseServiciosAct(rs.getString(19));
				registro.setClaseServiciosDes(rs.getString(20));
				registro.setParam1_mens(rs.getString(21));
				registro.setParam2_mens(rs.getString(22));
				registro.setParam3_mens(rs.getString(23));
				registro.setClaseServicios(rs.getString(24));
				registro.setDesMoneda(rs.getString(25));
				registro.setCodMoneda(rs.getString(26));
				registro.setCodCiclo(rs.getInt(27));
				registro.setFacCont(rs.getInt(28));
				registro.setPDesc(rs.getInt(29));
				registro.setValMin(rs.getFloat(30));
				registro.setValMax(rs.getFloat(31));
				registro.setCodError(rs.getInt(32));
				registro.setDesError(rs.getString(33));

				logger.debug("NumMovimiento[" + registro.getNumMovimiento() + "]");
				logger.debug("CodActAbo[" + registro.getCodActAbo() + "]");
				logger.debug("IndFactur[" + registro.getIndFactur() + "]");
				logger.debug("DesServ[" + registro.getDesServ() + "]");
				logger.debug("NumUnidades[" + registro.getNumUnidades() + "]");
				logger.debug("CodConcepto[" + registro.getCodConcepto() + "]");
				logger.debug("ImpCargo[" + registro.getImpCargo() + "]");
				logger.debug("CodArticulo[" + registro.getCodArticulo() + "]");
				logger.debug("CodBodega[" + registro.getCodBodega() + "]");
				logger.debug("NumSerie([" + registro.getNumSerie() + "]");
				logger.debug("IndEquipo[" + registro.getIndEquipo() + "]");
				logger.debug("CodCliente[" + registro.getCodCliente() + "]");
				logger.debug("NumAbonado[" + registro.getNumAbonado() + "]");
				logger.debug("TipDto[" + registro.getTipDto() + "]");
				logger.debug("ValDto[" + registro.getValDto() + "]");
				logger.debug("CodConceptoDTO[" + registro.getCodConceptoDTO() + "]");
				logger.debug("NumCelular[" + registro.getNumCelular() + "]");
				logger.debug("CodPlanCom[" + registro.getCodPlanCom() + "]");
				logger.debug("ClaseServiciosAct[" + registro.getClaseServiciosAct() + "]");
				logger.debug("ClaseServiciosDes[" + registro.getClaseServiciosDes() + "]");
				logger.debug("Param1_mens[" + registro.getParam1_mens() + "]");
				logger.debug("Param2_mens[" + registro.getParam2_mens() + "]");
				logger.debug("Param3_mens[" + registro.getParam3_mens() + "]");
				logger.debug("ClaseServicios[" + registro.getClaseServicios() + "]");
				logger.debug("DesMoneda[" + registro.getDesMoneda() + "]");
				logger.debug("CodMoneda[" + registro.getCodMoneda() + "]");
				logger.debug("CodCiclo[" + registro.getCodCiclo() + "]");
				logger.debug("FacCont[" + registro.getFacCont() + "]");
				logger.debug("PDesc[" + registro.getPDesc() + "]");
				logger.debug("ValMin[" + registro.getValMin() + "]");
				logger.debug("ValMax[" + registro.getValMax() + "]");
				logger.debug("CodError[" + registro.getCodError() + "]");
				logger.debug("DesError[" + registro.getDesError() + "]");
				lista.add(registro);
				cadenaServiciosActDes = registro.getClaseServicios();
			}

			servicios = (RegistroServiciosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), RegistroServiciosDTO.class);
			serviciosList = new RegistroServiciosListDTO();
			serviciosList.setServicios(servicios);		
			serviciosList.setClaseServicios(cadenaServiciosActDes);

			rs.close();

		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al validar servicios", e);
			throw new ProductSpecificationException("Ocurrió un error general al validar servicios",e);
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
		logger.debug("validaServicioActDesc():end");
		return serviciosList;
	}

}
