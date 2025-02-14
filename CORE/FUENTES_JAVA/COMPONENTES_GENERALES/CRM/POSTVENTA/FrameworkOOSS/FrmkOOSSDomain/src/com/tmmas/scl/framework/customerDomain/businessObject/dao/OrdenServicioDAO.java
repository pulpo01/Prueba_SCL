/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 31/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.OrdenServicioDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CausaExcepcionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CausaExcepcionListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConvertActAboDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DireccionOficinaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PenalizacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PlanBatchDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RangoAntiguedadDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ServCuentaSegDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.TipIdentDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.TipIdentListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerOrderException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ServicioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;

public class OrdenServicioDAO extends ConnectionDAO implements
		OrdenServicioDAOIT {

	private final Logger logger = Logger.getLogger(OrdenServicioDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLObtenerParametroGeneral() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   so_param PV_GED_PARAMETROS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_param.NOM_PARAMETRO := ?;");
		call.append("   so_param.COD_MODULO := ?;");
		call.append("   so_param.COD_PRODUCTO := ?;");
		call.append("   PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR( so_param, ?, ?, ?);");
		call.append("		? := so_param.VAL_PARAMETRO;");
		call.append("		? := so_param.DES_PARAMETRO;");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLregistraNivelOoss() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_registro_nivel PV_REGIST_NIVEL_MODIF_QT := PV_INICIA_ESTRUCTURAS_PG.PV_REGIST_NIVEL_MODIF_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_registro_nivel.TIP_SUBJETO := ?;");
		call.append("   eo_registro_nivel.NUM_ABONADO := ?;");
		call.append("   eo_registro_nivel.COD_CLIENTE := ?;");
		call.append("   eo_registro_nivel.COD_TIPMODI := ?;");		
		call.append("   PV_ORDEN_SERVICIO_PG.PV_REGIST_NIVEL_MODIFI_PR( eo_registro_nivel, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}

	private String getSQLregistraCambPlanBatch() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_orden_servicio PV_ORDEN_SERVICIO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_ORDEN_SERVICIO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_orden_servicio.CODACT_AL := ?;");
		call.append("   eo_orden_servicio.CODACT_BA := ?;");
		call.append("   eo_orden_servicio.IDSECUENCIA := ?;");
		call.append("   eo_orden_servicio.USUARIO := ?;");
		call.append("   eo_orden_servicio.COD_OS := ?;");	
		call.append("   eo_orden_servicio.NUM_ABONADO := ?;");	
		call.append("   eo_orden_servicio.PERIODOFACT := ?;");	
		call.append("   eo_orden_servicio.COD_PLANTARIF := ?;");
		call.append("   eo_orden_servicio.FEC_VENCIMIENTO := ?;");	
		call.append("   eo_orden_servicio.COD_ACTABO := ?;");	
		call.append("   eo_orden_servicio.NUM_OSF := ?;");
		call.append("   eo_orden_servicio.COD_PRODUCTO := ?;");
		call.append("   eo_orden_servicio.NUM_MOVIMIENTO := ?;");
		call.append("   eo_orden_servicio.COD_CAUSA_EXC := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_REGISTR_CAMB_PLAN_BATCH_PR( eo_orden_servicio, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}
	
	private String getSQLvalidaRestriccionComerOoss() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_restricciones PV_VAL_RESTR_COMER_OS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_VAL_RESTR_COMER_OS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_restricciones.NUM_TRANSACCION := ?;");
		call.append("   eo_restricciones.COD_EVENTO := ?;");
		call.append("   eo_restricciones.PROGRAMA := ?;");
		call.append("   eo_restricciones.COD_ACTUACION := ?;");
		call.append("   eo_restricciones.NUM_ABONADO := ?;");
		call.append("   eo_restricciones.PROCESO := ?;");
		call.append("   eo_restricciones.COD_CLIENTE := ?;");
		call.append("   eo_restricciones.COD_MODGENER := ?;");
		call.append("   eo_restricciones.NUM_VENTA := ?;");
		call.append("   eo_restricciones.COD_OOSS := ?;");
		call.append("   eo_restricciones.COD_VENDEDOR := ?;");
		call.append("   eo_restricciones.DESACTIVACION_SS := ?;");
		call.append("   eo_restricciones.PLAN_DESTINO := ?;");
		call.append("   eo_restricciones.COD_USO := ?;");
		call.append("   eo_restricciones.COD_CUENTA_ORIGEN := ?;");
		call.append("   eo_restricciones.COD_CUENTA_DESTINO := ?;");
		call.append("   eo_restricciones.COD_CLIENTE_DESTINO := ?;");
		call.append("   eo_restricciones.TIPO_PLAN := ?;");
		call.append("   eo_restricciones.TIPO_PLAN_DESTINO := ?;");
		call.append("   eo_restricciones.NUM_CICLO := ?;");
		call.append("   eo_restricciones.FECHA_SISTEMA := ?;");
		call.append("   eo_restricciones.RESTRICCION_AUXILIAR := ?;");
		call.append("   eo_restricciones.COD_MODULO := ?;");
		call.append("   eo_restricciones.COD_TAREA := ?;");
		call.append("   eo_restricciones.COD_CENTRAL := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_VAL_RESTRIC_COMER_OOSS_PR( eo_restricciones, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}	
		
	private String getSQLanulaOossPendPlan() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_orden_servicio PV_IORSERV_QT := PV_INICIA_ESTRUCTURAS_PG.PV_IORSERV_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_orden_servicio.COD_CLIENTE := ?;");
		call.append("   eo_orden_servicio.NUM_ABONADO := ?;");
		call.append("   eo_orden_servicio.COD_PLANTARIF := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_ANULAOoSS_PENDPLAN_PR( eo_orden_servicio, ?, ?, ?);");
		call.append("   				? := eo_orden_servicio.COD_PLANTARIF_NUEVO;");		
		call.append("   				? := eo_orden_servicio.NUM_OS;");
		call.append("   				? := eo_orden_servicio.CODIGO;");
		call.append("   				? := eo_orden_servicio.MENSAJE;");
		call.append(" END;");
		return call.toString();		
	}	

	private String getSQLvalidaOossPendPlan() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_orden_servicio PV_VALIDAOoSS_PENDPLAN_QT := PV_INICIA_ESTRUCTURAS_PG.PV_VALIDAOoSS_PENDPLAN_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_orden_servicio.COD_CLIENTE := ?;");
		call.append("   eo_orden_servicio.NUM_ABONADO := ?;");
		call.append("   eo_orden_servicio.COD_OS := ?;");
		call.append("   eo_orden_servicio.COD_PLANTARIF := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_VALIDAOoSS_PENDPLAN_PR( eo_orden_servicio, ?, ?, ?);");
		call.append("   			? := eo_orden_servicio.COD_PLANTARIF_NUEVO;");
		call.append("   			? := eo_orden_servicio.NUM_OS;");
		call.append("   			? := eo_orden_servicio.CODIGO;");
		call.append("   			? := eo_orden_servicio.MENSAJE;");
		call.append(" END;");
		return call.toString();		
	}	

	private String getSQLobtenerConversionOOSS() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_orden_servicio PV_ORDEN_SERVICIO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_ORDEN_SERVICIO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_orden_servicio.COD_OS := ?;");
		call.append("   eo_orden_servicio.COMBINATORIA := ?;");		
		call.append("   PV_ORDEN_SERVICIO_PG.PV_OBTENER_CONVERSION_PR( eo_orden_servicio,?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLobtenerSecuencia() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_secuencia PV_SECUENCIA_QT := PV_INICIA_ESTRUCTURAS_PG.PV_SECUENCIA_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_secuencia.NOM_SECUENCIA := ?;");
		call.append("   PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR( eo_secuencia, ?, ?, ?);");
		call.append("   			? := eo_secuencia.NUM_SECUENCIA ;");
		call.append(" END;");
		return call.toString();		
	}	
	
	private String getSQLobtenerParametrosSimples() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   so_param PV_GED_PARAMETROS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_param.NOM_PARAMETRO := ?;");
		call.append("   so_param.COD_MODULO := ?;");
		call.append("   PV_GENERALES_PG.PV_OBTIENE_GED_PARAM_SIMPL_PR( so_param, ?, ?, ?);");
		call.append("		? := so_param.VALOR_NUMERICO;");
		call.append("		? := so_param.VALOR_TEXTO;");
		call.append("		? := so_param.VALOR_FECHA;");
		call.append("		? := so_param.VALOR_DOMINIO;");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLobtenerTiposDeIdentidad()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append(" GE_TIPIDENT_PG.GE_OBTENER_S_PR( ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();	
	}
	
	private String getSQLactualizarComentPvIorserv()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_ordenServicio PV_IORSERV_QT := PV_INICIA_ESTRUCTURAS_PG.PV_IORSERV_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_ordenServicio.COMENTARIO := ?;");
		call.append("   eo_ordenServicio.NUM_OS := ?;");
		call.append("   eo_ordenServicio.NUM_OS_ORIGEN := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_ACT_COMENT_PVIORSERV_PR( eo_ordenServicio, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLvalidarPortabilidad()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.COD_USO := ?;");
		call.append("   eo_abonado.COD_TECNOLOGIA := ?;");
		call.append("   eo_abonado.COD_ACTABO := ?;");
		call.append("   		? := PV_ORDEN_SERVICIO_PG.PV_VALIDAR_PORTABILIDAD_FN( eo_abonado, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLobtenerConverActAbo()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_param PV_ACTABO_TIPLAN_QT:= PV_INICIA_ESTRUCTURAS_PG.PV_ACTABO_TIPLAN_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_param.COD_ACTABO := ?;");
		call.append("   so_param.COD_TIPLAN := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_OBTENER_CONVERT_ACTABO_PR( so_param, ?, ?, ?);");
		call.append("   	? := so_param.COD_ACTABO_HOM;");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLvalidarServiciosDuplicados()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.TIP_TERMINAL := ?;");
		call.append("   eo_abonado.COD_PLANTARIF := ?;");
		call.append("   eo_abonado.COD_TECNOLOGIA := ?;");
		call.append("   eo_abonado.COD_CENTRAL := ?;");
		call.append("       ? := PV_ORDEN_SERVICIO_PG.PV_VALIDAR_SERV_DUPL_FN( eo_abonado, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLbajaSSPrepago()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.NUM_ABONADO := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_BAJA_SS_PREPAGO_PR( eo_abonado, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLbajaRegTarif()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.COD_CLIENTE := ?;");
		call.append("   eo_abonado.NUM_ABONADO := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_BAJA_REG_TARIF_PR( eo_abonado, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLobtenerGrupoNivelContratado()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_param GA_SERVSUPLABO_QT:= PV_INICIA_ESTRUCTURAS_PG.GA_SERVSUPLABO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_param.NUM_ABONADO := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_OBT_GRUPO_NIVELCONT_PR( so_param, ?, ?, ?);");
		call.append("   		? := so_param.GRUPO_NIVEL;");		
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLinsertarTransacabo(){
		{
			StringBuffer call = new StringBuffer();
			call.append(" BEGIN ");
			call.append("   PV_ORDEN_SERVICIO_PG.PV_INSERTAR_TRASACABO_PR( ?, ?, ?, ?);");
			call.append(" END;");		
			return call.toString();		
		}		
	}

	private String getSQLregistrarOOSSEnLinea() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
 		call.append("   SO_OOSS_ONLINE GE_OOSS_EN_LINEA_QT :=PV_INICIA_ESTRUCTURAS_PG.GE_OOSS_EN_LINEA_QT_FN; ");
		call.append(" BEGIN ");
		call.append("   so_ooss_online.num_os:=?;  ");
		call.append("   so_ooss_online.cod_os:=?;  ");
		call.append("   so_ooss_online.cod_producto:=?;  ");
		call.append("   so_ooss_online.tip_inter:=?;  ");
		call.append(" 	so_ooss_online.cod_inter:=?;  ");
		call.append("   so_ooss_online.usuario:=?; ");
		call.append("   so_ooss_online.fecha:=?;  ");
		call.append("   so_ooss_online.comentario:=?;  ");
		call.append("   so_ooss_online.num_movimiento:=?; "); 
		call.append("   so_ooss_online.cod_estado:=?;  ");
		call.append("   so_ooss_online.cod_modulo:=?;  ");
		call.append(" 	so_ooss_online.id_gestor :=?; ");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_REGISTRA_OOSS_ENLINEA_PR ( SO_OOSS_ONLINE, ?,?,? ); ");
		call.append(" 	END; "); 
	
		return call.toString();		
	}
	
	// INI P-MIX-09003 OCB
	private String getSQLActualizaRenova() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_registro_renova PV_IORSERV_QT := PV_INICIA_ESTRUCTURAS_PG.PV_IORSERV_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_registro_renova.NUM_OS_ORIGEN := ?;");
		call.append("   eo_registro_renova.NUM_OS := ?;");
		call.append("   eo_registro_renova.NUM_ABONADO := ?;");
		call.append("   eo_registro_renova.COD_OS := ?;");
		call.append("   PV_CONFIG_RENOVACION_PG.PV_RENOVAWEB_PR( eo_registro_renova, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}
	// FIN P-MIX-09003 OCB
	private String getSQLobtenerRangoAntiguedad() {
		StringBuffer call = new StringBuffer();	
		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.NUM_SERIE := ?;");
		call.append("   eo_abonado.CAUSA_BAJA := ?;");
		call.append("   eo_abonado.FECHA_ALTA := ?;");
		call.append("   eo_abonado.FECHA_PRORROGA := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_RANGO_ANTIGUEDAD_PR( eo_abonado, ?, ?, ?);");
		call.append("   		? := eo_abonado.RANGO_ANTIGUEDAD;");
		call.append(" END;");
		return call.toString();
	
	}
	
	private String getSQLobtenerVendedor() {
		StringBuffer call = new StringBuffer();	
		call.append(" DECLARE ");
		call.append("   so_procesos  GE_PROCESOS_QT := PV_INICIA_ESTRUCTURAS_PG.GE_PROCESOS_QT_FN;");
		call.append("   so_descuento VE_DESCUENTO_VEN_QT := PV_INICIA_ESTRUCTURAS_PG.VE_DESCUENTO_VEN_QT_FN;");
		call.append(" 	retorno BOOLEAN; ");
		call.append(" BEGIN ");
		call.append("   so_procesos.USUARIO := ?;");
		call.append("   retorno := VE_VENDEDORES_SB_PG.ve_rec_codvendedorusuario_fn( so_procesos, so_descuento, ?, ?, ?);");
		call.append("   		? := so_procesos.CODIGO;");
		call.append("   		? := so_procesos.COD_OFICINA;");
		call.append("   		? := so_procesos.COD_TIPCOMIS;");
		call.append(" END;");
		return call.toString();
		
	}
	
	private String getSQLobtenerDescuentoVendedor() {
		StringBuffer call = new StringBuffer();	
		call.append(" DECLARE ");
		call.append("   so_procesos  GE_PROCESOS_QT := PV_INICIA_ESTRUCTURAS_PG.GE_PROCESOS_QT_FN;");
		call.append("   so_descuento VE_DESCUENTO_VEN_QT := PV_INICIA_ESTRUCTURAS_PG.VE_DESCUENTO_VEN_QT_FN;");
		call.append(" 	retorno BOOLEAN; ");
		call.append(" BEGIN ");
		call.append("   so_procesos.CODIGO := ?;");
		call.append("   retorno := VE_VENDEDORES_SB_PG.ve_rec_descuento_vendedor_fn( so_procesos, so_descuento, ?, ?, ?);");
		call.append("   		? := so_descuento.IND_CREADTO;");
		call.append("   		? := so_descuento.PRC_NEWDTO_INF;");
		call.append("   		? := so_descuento.PRC_NEWDTO_SUP;");
		call.append(" END;");
		return call.toString();

	}
	
	private String getSQLobtenerPenalizacion(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_param GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_param.NUM_ABONADO := ?;");
		call.append("   so_param.FEC_FINCONTRA := ?;");
		call.append("   so_param.MODALIDAD_DE_PAGO := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_OBTENER_CODPENALIZA_PR( so_param, ?, ?, ?);");
		call.append("   	? := so_param.TIPO_INDEMNIZACION;");
		call.append("   	? := so_param.COD_PEN_CONTRA;");
		call.append("   	? := so_param.AFECTO_INDEM;");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLregistrarVenta(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_venta GA_VENTA_QT := PV_INICIA_ESTRUCTURAS_PG.GA_VENTA_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_venta.num_venta := ?;");
		call.append("   so_venta.cod_producto := ?;");
		call.append("   so_venta.cod_oficina := ?;");
		call.append("   so_venta.cod_tipcomis := ?;");
		call.append("   so_venta.cod_vendedor := ?;");
		call.append("   so_venta.cod_vendedor_agente := ?;");
		call.append("   so_venta.num_unidades := ?;");
		call.append("   so_venta.fec_venta := ?;");
		call.append("   so_venta.cod_region := ?;");
		call.append("   so_venta.cod_provincia := ?;");
		call.append("   so_venta.cod_ciudad := ?;");
		call.append("   so_venta.ind_estventa := ?;");
		call.append("   so_venta.ind_pasocob := ?;");
		call.append("   so_venta.ind_tipventa := ?;");
		call.append("   so_venta.cod_cliente := ?;");
		call.append("   so_venta.cod_modventa := ?;");
		call.append("   so_venta.cod_cuota := ?;");
		call.append("   so_venta.nom_usuar_vta := ?;");
		call.append("   so_venta.ind_venta := ?;");
		call.append("   so_venta.tip_foliacion := ?;");
		call.append("   so_venta.cod_tipdocum := ?;");
		call.append("   so_venta.cod_plaza := ?;");
		call.append("   so_venta.cod_operadora := ?;");
		call.append("   VE_VENDEDORES_SB_PG.ve_reg_venta_prebilling_pr( so_venta, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLobtenerDireccionOficina(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_direccion GE_DIRECCION_QT := PV_INICIA_ESTRUCTURAS_PG.GE_DIRECCION_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_direccion.COD_OFICINA := ?;");
		call.append("   VE_VENDEDORES_SB_PG.ve_rec_direccion_vendedor_pr ( so_direccion, ?, ?, ?);");
		call.append("   	? := so_direccion.COD_REGION;");
		call.append("   	? := so_direccion.COD_PROVINCIA;");
		call.append("   	? := so_direccion.COD_CIUDAD;");
		call.append("   	? := so_direccion.COD_PLAZA;");
		call.append(" END;");		
		return call.toString();	
	}
	
	private String getSQLobtenerVendedorRaiz(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_param  GE_PROCESOS_QT := PV_INICIA_ESTRUCTURAS_PG.GE_PROCESOS_QT_FN;");
		call.append(" 	retorno BOOLEAN; ");
		call.append(" BEGIN ");
		call.append("   so_param.CODIGO := ?;");
		call.append("   	retorno := VE_VENDEDORES_SB_PG.ve_recupera_codvenderaiz_fn ( so_param, ?, ?, ?);");
		call.append("   	? := so_param.CODIGO;");
		call.append(" END;");		
		return call.toString();	
	}

	private String getSQLobtenerOperadora(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_param  GE_PROCESOS_QT := PV_INICIA_ESTRUCTURAS_PG.GE_PROCESOS_QT_FN;");
		call.append(" 	retorno VARCHAR2(5); ");
		call.append(" BEGIN ");
		call.append("   	retorno := Fn_Obtiene_OperCliente ( ?);");
		call.append("   	? := retorno;");
		call.append(" END;");		
		return call.toString();	
	}
	
	private String getSQLtratarServCtaSeg() {
		StringBuffer call = new StringBuffer();	
		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.NUM_ABONADO := ?;");
		call.append("   eo_abonado.COD_ACTABO := ?;");
		call.append("   eo_abonado.COD_TECNOLOGIA := ?;");
		call.append("   eo_abonado.NUM_CELULAR := ?;");
		call.append("   eo_abonado.TIP_TERMINAL := ?;");
		call.append("   eo_abonado.COD_CENTRAL := ?;");
		call.append("   eo_abonado.PERFIL_ABONADO := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_GENERASS_CTASEG_CENTRAL_PR( eo_abonado, ?, ?, ?);");
		call.append("   		? := eo_abonado.CLASE_SERVICIO;");
		call.append(" END;");
		return call.toString();
	
	}

	private String getSQLobtenerTipoContrato() {
		StringBuffer call = new StringBuffer();	
		call.append(" BEGIN ");
		call.append("   PV_SERVICIOS_POSVENTA_PG.VE_con_tipocontrato_PR ( ?,?,?,?,?,?,?);");
		call.append(" END;");
		return call.toString();
	}
	
	private String getSQLregistrarMovControlada()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.NUM_ABONADO := ?;");
		call.append("   eo_abonado.COD_ACTABO := ?;");
		call.append("   eo_abonado.NUM_SERIE := ?;");
		call.append("   eo_abonado.TIPMOV := ?;");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_bRegMovCControlada_PR( eo_abonado, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}

	private String getSQLobtenerModalidadPago() {
		StringBuffer call = new StringBuffer();	
		call.append(" BEGIN ");
		call.append("   PV_SERVICIOS_POSVENTA_PG.VE_con_modalidadpago_PR ( ?,?,?,?,?,?);");
		call.append(" END;");
		return call.toString();
	}

	private String getSQLobtenerInfoVendedor() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_vendedor VE_VENDEDOR_QT := PV_INICIA_ESTRUCTURAS_PG.VE_VENDEDOR_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_vendedor.COD_VENDEDOR := ?;");
		call.append("   VE_VENDEDORES_SB_PG.ve_obtener_vendedor_pr( so_vendedor, ?, ?, ?);");
		call.append("   		? := so_vendedor.NOM_VENDEDOR;");		
		call.append(" END;");		
		return call.toString();	
	}
	
	private String getSQLObtenerCausaExcepcion() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append("   PV_ORDEN_SERVICIO_PG.PV_CAUSA_DE_EXCEPCION_PR( ?, ?, ?, ?);");		
		call.append(" END;");		
		return call.toString();	
	}
	
	/**
	 * Registra OOSS a nivel abonado o a nivel cliente
	 * 
	 * @param registro
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */	
	public CausaExcepcionListDTO obtenerCausaExcepcion() throws CustomerOrderException {
		logger.debug("obtenerCausaExcepcion():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;	
		Connection conn = null;
		CallableStatement cstmt = null;
		CausaExcepcionListDTO retorno = new CausaExcepcionListDTO();
		
		String call = getSQLObtenerCausaExcepcion();
		try {
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			
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
				logger.error(" Ocurrió un error al obtener las Causas de Excepcion");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			logger.debug("Recuperando data...");
			ResultSet rs = (ResultSet) cstmt.getObject(1);
			ArrayList lista = new ArrayList(); 
			while(rs.next()){
				CausaExcepcionDTO causaExcepcion = new CausaExcepcionDTO();
				causaExcepcion.setCodCausa(rs.getInt(1));
				causaExcepcion.setDesCausa(rs.getString(2));
				lista.add(causaExcepcion);
			}
			if(lista.size()>0){
				CausaExcepcionDTO [] arregloCausa = new CausaExcepcionDTO[lista.size()];
				for(int i = 0;i<lista.size();i++){
					arregloCausa[i] = (CausaExcepcionDTO)lista.get(i);
				}
				retorno.setListaCausas(arregloCausa);
			}
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener las Causas de Excepcion", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener las Causas de Excepcion",e);
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
		logger.debug("obtenerCausaExcepcion():end");
		return retorno;

	}
	

	/**
	 * Registra OOSS a nivel abonado o a nivel cliente
	 * 
	 * @param registro
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */	
	public RetornoDTO registraNivelOoss(RegistroNivelOOSSDTO registro)
			throws CustomerOrderException {
		logger.debug("registraNivelOoss():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistraNivelOoss();
		try {
			
			logger.debug("registro.getTipSujeto()[" + registro.getTipSujeto() + "]");		
			logger.debug("registro.getCodCliente()[" + registro.getCodCliente() + "]");
			logger.debug("registro.getNumAbonado()[" + registro.getNumAbonado() + "]");
			logger.debug("registro.getCodTipMod()[" + registro.getCodTipMod() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, registro.getTipSujeto());
			cstmt.setLong(2, registro.getNumAbonado());
			cstmt.setLong(3, registro.getCodCliente());
			cstmt.setString(4, registro.getCodTipMod());
			
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
				logger.error(" Ocurrió un error al registrar nivel abonado / cliente");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			

			logger.debug("Recuperando data...");
			
			respuesta = new RetornoDTO();
			respuesta.setDescripcion(msgError);

		
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar nivel abonado / cliente", e);
			throw new CustomerOrderException("Ocurrió un error general al registrar nivel abonado / cliente",e);
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
		logger.debug("registraNivelOoss():end");
		return respuesta;

	}

	/**
	 * Registra en batch postventa
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */	
	public RetornoDTO registraCambPlanBatch(PlanBatchDTO param) throws CustomerOrderException{
		logger.debug("registraCambPlanBatch():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistraCambPlanBatch();
		try {
		
			logger.debug("param.getCodActAl()[" + param.getCodActAl() + "]");
			logger.debug("param.getCodActBa()[" + param.getCodActBa() + "]");
			logger.debug("param.getIdSecuencia()[" + param.getIdSecuencia() + "]");
			logger.debug("param.getUsuario()[" + param.getUsuario() + "]");
			logger.debug("param.getCodOOSS()[" + param.getCodOOSS() + "]");
			logger.debug("param.getNumAbonado()[" + param.getNumAbonado() + "]");
			logger.debug("param.getPeriodoFact()[" + param.getPeriodoFact() + "]");
			logger.debug("param.getCodPlanTarif()[" + param.getCodPlanTarif() + "]");
			logger.debug("param.getFecVencimiento()[" + param.getFecVencimiento() + "]");
			logger.debug("param.getCodActAbo()[" + param.getCodActAbo() + "]");
			logger.debug("param.getNumOSF()[" + param.getNumOSF() + "]");
			logger.debug("param.getCodProducto()[" + param.getCodProducto() + "]");
			logger.debug("param.getNumMovimiento()[" + param.getNumMovimiento());
			logger.debug("param.getCodCausaExc()[" + param.getCodCausaExc());
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
		
			cstmt.setString(1, param.getCodActAl()); //CODACT_AL
			cstmt.setString(2, param.getCodActBa()); //CODACT_BA
			cstmt.setLong(3, param.getIdSecuencia()); //IDSECUENCIA
			cstmt.setString(4, param.getUsuario()); //USUARIO
			cstmt.setString(5, param.getCodOOSS()); //COD_OS
			cstmt.setLong(6, param.getNumAbonado()); //NUM_ABONADO
			cstmt.setInt(7, param.getPeriodoFact()); //PERIODOFACT
			cstmt.setString(8, param.getCodPlanTarif()); //COD_OS
			cstmt.setString(9, param.getFecVencimiento()); //FEC_VENCIMIENTO
			cstmt.setString(10, param.getCodActAbo()); //COD_ACTABO
			cstmt.setLong(11, param.getNumOSF()); //NUM_OSF
			cstmt.setInt(12, param.getCodProducto()); //COD_PRODUCTO
			cstmt.setLong(13, param.getNumMovimiento()); //NUM_MOVIMENTO
			cstmt.setInt(14, param.getCodCausaExc()); //COD_CAUSA_EXC
			
			
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(15);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(16);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(17);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error en registro batch postventa");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
		
			respuesta = new RetornoDTO();
			respuesta.setCodigo(String.valueOf(codError));
			respuesta.setDescripcion(msgError);
		
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error en registro batch postventa", e);
			throw new CustomerOrderException("Ocurrió un error en registro batch postventa",e);
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
		logger.debug("registraCambPlanBatch():end");
		return respuesta;		
	}
	
	/**
	 * Valida restricciones de postventa
	 * 
	 * @param restricciones
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */	
	public RetornoDTO validaRestriccionComerOoss(RestriccionesDTO restricciones) throws CustomerOrderException{
		logger.debug("validaRestriccionComerOoss():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidaRestriccionComerOoss();
		try {
		
			logger.debug("restricciones.getIdSecuencia()[" + restricciones.getIdSecuencia() + "]");
			logger.debug("restricciones.getCodEvento()[" + restricciones.getCodEvento() + "]");
			logger.debug("restricciones.getPrograma()[" + restricciones.getPrograma() + "]");
			logger.debug("restricciones.getCodActuacion()[" + restricciones.getCodActuacion() + "]");
			logger.debug("restricciones.getNumAbonado()[" + restricciones.getNumAbonado() + "]");
			logger.debug("restricciones.getProceso()[" + restricciones.getProceso() + "]");
			logger.debug("restricciones.getCodCliente()[" + restricciones.getCodCliente() + "]");
			logger.debug("restricciones.getCodModGener()[" + restricciones.getCodModGener() + "]");
			logger.debug("restricciones.getCodVenta()[" + restricciones.getNumVenta() + "]");
			logger.debug("restricciones.getCodOOSS()[" + restricciones.getCodOOSS() + "]");
			logger.debug("restricciones.getCodVendedor()[" + restricciones.getCodVendedor() + "]");
			logger.debug("restricciones.getDesactivacionSS()[" + restricciones.getDesactivacionSS() + "]");
			logger.debug("restricciones.getPlanDestino()[" + restricciones.getPlanDestino() + "]");
			logger.debug("restricciones.getCodUso()[" + restricciones.getCodUso() + "]");
			logger.debug("restricciones.getCodCuentaOrigen()[" + restricciones.getCodCuentaOrigen() + "]");
			logger.debug("restricciones.getCodCuentaDestino()[" + restricciones.getCodCuentaDestino() + "]");
			logger.debug("restricciones.getCodClienteDestino()[" + restricciones.getCodClienteDestino() + "]");
			logger.debug("restricciones.getTipoPlan()[" + restricciones.getTipoPlan() + "]");
			logger.debug("restricciones.getTipoPlanDestino()[" + restricciones.getTipoPlanDestino() + "]");
			logger.debug("restricciones.getNumCiclo()[" + restricciones.getNumCiclo() + "]");
			logger.debug("restricciones.getFechaSistema()[" + restricciones.getFechaSistema() + "]");
			logger.debug("restricciones.getRestriccionAux()[" + restricciones.getRestriccionAux() + "]");
			logger.debug("restricciones.getCodModulo()[" + restricciones.getCodModulo() + "]");
			logger.debug("restricciones.getCodTarea()[" + restricciones.getCodTarea() + "]");
			logger.debug("restricciones.getCodCentral()[" + restricciones.getCodCentral() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, restricciones.getIdSecuencia()); //NUM_TRANSACCION
			cstmt.setString(2, restricciones.getCodEvento()); //COD_EVENTO
			cstmt.setString(3, restricciones.getPrograma()); //PROGRAMA
			cstmt.setString(4, restricciones.getCodActuacion()); //COD_ACTUACION
			cstmt.setLong(5, restricciones.getNumAbonado()); //NUM_ABONADO
			cstmt.setString(6, restricciones.getProceso()); //PROCESO
			cstmt.setLong(7, restricciones.getCodCliente()); //COD_CLIENTE
			cstmt.setString(8, restricciones.getCodModGener()); //COD_MODGENER
			cstmt.setLong(9, restricciones.getNumVenta()); //NUM_VENTA
			cstmt.setString(10, restricciones.getCodOOSS()); //COD_OOSS
			cstmt.setString(11, restricciones.getCodVendedor()); //COD_VENDEDOR
			cstmt.setInt(12, restricciones.getDesactivacionSS()); //DESACTIVACION_SS
			cstmt.setString(13, restricciones.getPlanDestino()); //PLAN_DESTINO
			cstmt.setInt(14, restricciones.getCodUso()); //COD_USO
			cstmt.setLong(15, restricciones.getCodCuentaOrigen()); //COD_CUENTA_ORIGEN
			cstmt.setLong(16, restricciones.getCodCuentaDestino()); //COD_CUENTA_DESTINO
			cstmt.setLong(17, restricciones.getCodClienteDestino()); //COD_CLIENTE_DESTINO
			cstmt.setString(18, restricciones.getTipoPlan()); //TIPO_PLAN
			cstmt.setString(19, restricciones.getTipoPlanDestino()); //TIPO_PLAN_DESTINO
			cstmt.setLong(20, restricciones.getNumCiclo()); //NUM_CICLO
			long fechaLong = (restricciones.getFechaSistema()!=null?restricciones.getFechaSistema().getTime():0);
			cstmt.setDate(21, new java.sql.Date(fechaLong)); //FECHA_SISTEMA
			cstmt.setString(22, restricciones.getRestriccionAux()); //RESTRICCION_AUXILIAR
			cstmt.setString(23, restricciones.getCodModulo()); //COD_MODULO
			cstmt.setInt(24, restricciones.getCodTarea()); //COD_TAREA
			cstmt.setInt(25, restricciones.getCodCentral()); //COD_CENTRAL
			
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(27, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(28, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(26);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(27);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(28);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al validar restricciones de postventa");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
		
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al validar restricciones de postventa", e);
			throw new CustomerOrderException("Ocurrió un error al validar restricciones de postventa",e);
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
		logger.debug("validaRestriccionComerOoss():end");
		return retorno;			
	}
	
	/**
	 * Anula solicitud en Proceso producto de un cambio de ciclo
	 * 
	 * @param ordenServicio
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */	
	public IOOSSDTO anulaOossPendPlan(IOOSSDTO ordenServicio) throws CustomerOrderException{
		logger.debug("anulaOossPendPlan():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		IOOSSDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLanulaOossPendPlan();
		try {
		
			logger.debug("ordenServicio.getCodCliente()[" + ordenServicio.getCodCliente() + "]");
			logger.debug("ordenServicio.getNumAbonado()[" + ordenServicio.getNumAbonado() + "]");
			logger.debug("ordenServicio.getCodPlanTarif()[" + ordenServicio.getCodPlanTarif() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, ordenServicio.getCodCliente()); //COD_CLIENTE
			cstmt.setLong(2, ordenServicio.getNumAbonado() );  //NUM_ABONADO
			cstmt.setString(3, ordenServicio.getCodPlanTarif()); //COD_PLANTARIF
			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //COD_PLANTARIF_NUEVO
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC); //NUM_OS		
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC); //CODIGO		
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC); //MENSAJE		
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error al anular solicitud");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String codPlanTarifNuevo = cstmt.getString(7);
			logger.debug("codPlanTarifNuevo[" + codPlanTarifNuevo + "]");
			long numOs = cstmt.getLong(8);
			logger.debug("numOs[" + numOs + "]");
			
			String codigo = cstmt.getString(9);
			logger.debug("codigo[" + codigo + "]");
			
			String mensaje = cstmt.getString(10);
			logger.debug("mensaje[" + mensaje + "]");
			
			retorno = ordenServicio;
			retorno.setCodPlanTarifNuevo(codPlanTarifNuevo);
			retorno.setNumOs(numOs);
			retorno.setCodigo(codigo);
			retorno.setMensaje(mensaje);
		
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al anular solicitud", e);
			throw new CustomerOrderException("Ocurrió un error al anular solicitud",e);
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
		logger.debug("anulaOossPendPlan():end");
		return retorno;			
	}

	/**
	 * Valida los cambios de plan pendientes a ciclo
	 * 
	 * @param ordenServicio
	 * @return ValidaOOSSDTO
	 * @throws CustomerOrderException
	 */
	public ValidaOOSSDTO validaOossPendPlan(ValidaOOSSDTO ordenServicio) throws CustomerOrderException{
		logger.debug("validaOossPendPlan():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ValidaOOSSDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidaOossPendPlan();
		try {
		
			logger.debug("ordenServicio.getCodCliente()[" + ordenServicio.getCodCliente() + "]");
			logger.debug("ordenServicio.getNumAbonado()[" + ordenServicio.getNumAbonado() + "]");
			logger.debug("ordenServicio.getCodOS()[" + ordenServicio.getCodOS() + "]");
			logger.debug("ordenServicio.getCodPlanTarif()[" + ordenServicio.getCodPlanTarif() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, ordenServicio.getCodCliente()); //COD_CLIENTE
			cstmt.setLong(2, ordenServicio.getNumAbonado()); //NUM_ABONADO
			cstmt.setString(3, ordenServicio.getCodOS()); //COD_OS
			cstmt.setString(4, ordenServicio.getCodPlanTarif()); //COD_PLANTARIF
		
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);			
		
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //COD_PLANTARIF_NUEVO
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC); //NUM_OS
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); //CODIGO
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); //MENSAJE
			
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
				logger.error(" Ocurrió un error al validar cambios de plan pendiente a ciclo");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String codPlanTarifNuevo = cstmt.getString(8);
			logger.debug("codPlanTarifNuevo[" + codPlanTarifNuevo + "]");

			long numOS = cstmt.getLong(9);
			logger.debug("numOS[" + numOS + "]");
			
			String codigo = cstmt.getString(10);
			logger.debug("codigo[" + codigo + "]");
			
			String mensaje = cstmt.getString(11);
			logger.debug("mensaje[" + mensaje + "]");
			
			retorno = ordenServicio;
			retorno.setCodPlanTarifNuevo(codPlanTarifNuevo);
			retorno.setNumOS(numOS);
			retorno.setCodigo(codigo);
			retorno.setMensaje(mensaje);
		
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al validar cambios de plan pendiente a ciclo", e);
			throw new CustomerOrderException("Ocurrió un error general al validar cambios de plan pendiente a ciclo",e);
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
		logger.debug("validaOossPendPlan():end");
		return retorno;				
	}
	
	/**
	 * Obtiene informacion de parámetros de la tabla GED_PARAMETROS
	 * 
	 * @param param
	 * @return ParametroDTO
	 * @throws CustomerOrderException
	 */
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws CustomerOrderException{	
		logger.debug("obtenerParametrosGenerales():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ParametroDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLObtenerParametroGeneral();

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("param.getNomParametro()[" + param.getNomParametro() + "]");
			logger.debug("param.getCodModulo()[" + param.getCodModulo() + "]");	
			logger.debug("param.getCodProducto()[" + param.getCodProducto() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, param.getNomParametro());
			cstmt.setString(2, param.getCodModulo());
			cstmt.setInt(3, param.getCodProducto());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //VAL_PARAMETRO
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //DES_PARAMETRO
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al recuperar parametro general");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			String valor = cstmt.getString(7);
			logger.debug("valor[" + valor + "]");
			
			String descripcion = cstmt.getString(8);
			logger.debug("descripcion[" + descripcion + "]");	
			
			respuesta = param;
			respuesta.setValor(valor);
			respuesta.setDescripcion(descripcion);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar parametro general", e);
			throw new CustomerOrderException("Ocurrió un error general al recuperar parametro general",e);
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
		logger.debug("obtenerParametrosGenerales():end");
		return respuesta;
	}
	
	/**
	 * Obtiene informacion de la orden de servicio
	 * 
	 * @param param
	 * @return ConversionDTO
	 * @throws CustomerOrderException
	 */
	public ConversionListDTO obtenerConversionOOSS(ConversionDTO param) throws CustomerOrderException{
		logger.debug("obtenerConversionOOSS():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ConversionListDTO conversionList = null;
		ConversionDTO[] registros = null;
		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerConversionOOSS();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("param.getCodOOSS()[" + param.getCodOOSS() + "]");
			logger.debug("param.getCodTipModi()[" + param.getCodTipModi() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, param.getCodOOSS());
			cstmt.setString(2, param.getCodTipModi());
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);	
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener información de la orden de servicio");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			logger.debug("object="+cstmt.getObject(3));
			ResultSet rs = (ResultSet) cstmt.getObject(3);
			
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				ConversionDTO conversion = new ConversionDTO();

				conversion.setCodOSAnt(rs.getLong(1));
				logger.debug("CodOsAnt[" + conversion.getCodOSAnt() + "]");
				conversion.setCodActuacion(rs.getString(2));
				logger.debug("CodActuacion[" + conversion.getCodActuacion() + "]");
				conversion.setEvento(rs.getString(3));
				logger.debug("Evento[" + conversion.getEvento() + "]");
				conversion.setCodActuacionWeb(rs.getString(4));
				logger.debug("CodActuacionWeb[" + conversion.getCodActuacionWeb() + "]");
				
				lista.add(conversion);
			}
			registros = (ConversionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), ConversionDTO.class);
			conversionList = new ConversionListDTO();
			conversionList.setRegistros(registros);			
			rs.close();			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al obtener información de la orden de servicio", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener información de la orden de servicio",e);
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
		logger.debug("obtenerConversionOOSS():end");
		return conversionList;		
	}

	/**
	 * Recupera valor de una secuencia
	 * 
	 * @param secuencia
	 * @return SecuenciaDTO
	 * @throws CustomerOrderException
	 */
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws CustomerOrderException{
		logger.debug("obtenerSecuencia():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SecuenciaDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerSecuencia();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("secuencia.getNomSecuencia()[" + secuencia.getNomSecuencia() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, secuencia.getNomSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //NUM_SECUENCIA
			
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
				logger.error(" Ocurrió un error al obtener el número de secuencia");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			long numSecuencia = cstmt.getLong(5);
			logger.debug("numSecuencia[" + numSecuencia + "]");
			
			respuesta = secuencia;
			respuesta.setNumSecuencia(numSecuencia);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al obtener el número de secuencia", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener el número de secuencia",e);
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
		logger.debug("obtenerSecuencia():end");
		return respuesta;	
	}
	
	/**
	 * Obtiene informacion de parámetros de la tabla ...
	 * 
	 * @param param
	 * @return ParametroDTO
	 * @throws CustomerOrderException
	 */
	public ParametroDTO obtenerParametrosSimples(ParametroDTO param) throws CustomerOrderException{
		logger.debug("obtenerParametrosSimples():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ParametroDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerParametrosSimples();

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("param.getNomParametro()[" + param.getNomParametro() + "]");
			logger.debug("param.getCodModulo()[" + param.getCodModulo() + "]");	
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, param.getNomParametro());
			cstmt.setString(2, param.getCodModulo());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC); //VALOR_NUMERICO
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //VALOR_TEXTO
			cstmt.registerOutParameter(8, java.sql.Types.DATE); //VALOR_FECHA
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); //VALOR_DOMINIO
			
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
				logger.error(" Ocurrió un error al recuperar parametros simples");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			float valorNum = cstmt.getFloat(6);
			logger.debug("valorNum[" + valorNum + "]");
			
			String valor = cstmt.getString(7);
			logger.debug("valor[" + valor + "]");
			
			java.sql.Date valorFec = cstmt.getDate(8);
			logger.debug("valorFec[" + valorFec + "]");	
			
			String valorDominio = cstmt.getString(9);
			logger.debug("valorDom[" + valorDominio + "]");	
			
			respuesta = param;
			respuesta.setValorNum(valorNum);
			respuesta.setValor(valor);
			
			java.util.Date fecha = null;
			try{
				fecha = new java.util.Date(valorFec.getTime());
			}catch(Exception e){}
			
			respuesta.setValorFecha(fecha);
			respuesta.setValorDominio(valorDominio);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar parametros simples", e);
			throw new CustomerOrderException("Ocurrió un error general al recuperar parametros simples",e);
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
		logger.debug("obtenerParametrosSimples():end");
		return respuesta;
		
	}
	/**
	 * obtener Tipos De Identidad, obtiene datos tabla tip_ident
	 * 
	 * @param param
	 * @return ParametroDTO
	 * @throws CustomerOrderException
	 */
	public TipIdentListDTO obtenerTiposDeIdentidad()  throws CustomerOrderException{
		logger.debug("obtenerTiposDeIdentidad():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		TipIdentListDTO tipIdentList = new TipIdentListDTO();		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerTiposDeIdentidad();

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
	
			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			
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
				logger.error(" Ocurrió un error al recuperar parametros simples");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
		
			ArrayList retornoPL=new ArrayList();
			TipIdentDTO dto=null;
			TipIdentDTO[] dtoList=null;
			ResultSet rs=(ResultSet)cstmt.getObject(1);
			
			while(rs.next())
			{
				dto=new TipIdentDTO();
				
				dto.setCodTipIdent(rs.getString("COD_TIPIDENT")!=null?rs.getString("COD_TIPIDENT"):"");
				dto.setDescTipIdent(rs.getString("DES_TIPIDENT")!=null?rs.getString("DES_TIPIDENT"):"");
				retornoPL.add(dto);				
			}
			dtoList=(TipIdentDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoPL.toArray(), TipIdentDTO.class);
			tipIdentList.setTipIdentDTO(dtoList);
			
		 } catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Tipos De Identidad", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener Tipos De Identidad",e);
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
		logger.debug("obtenerTiposDeIdentidad():end");
		return tipIdentList;
	}
	
	/**
	 * Actualiza comentario
	 * 
	 * @param os
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */
	public RetornoDTO actualizarComentPvIorserv(IOOSSDTO os) throws CustomerOrderException{
		logger.debug("actualizarComentPvIorserv():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizarComentPvIorserv();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("os.getComentario()[" + os.getComentario() + "]");
			logger.debug("os.getNumOs()[" + os.getNumOs() + "]");
			logger.debug("os.getNumOsOrigen()[" + os.getNumOsOrigen() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, os.getComentario()); //COMENTARIO
			cstmt.setLong(2, os.getNumOs()); //NUM_OS
			cstmt.setLong(3, os.getNumOsOrigen()); //NUM_OS_ORIGEN
			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener al actualizar comentario");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al actualizar comentario", e);
			throw new CustomerOrderException("Ocurrió un error general al actualizar comentario",e);
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
		logger.debug("actualizarComentPvIorserv():end");
		return retorno;		
	}
	
	/**
	 * Valida portabilidad
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */
	public RetornoDTO validarPortabilidad(AbonadoDTO abonado) throws CustomerOrderException{
		logger.debug("validarPortabilidad():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidarPortabilidad();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("abonado.getCodUso()[" + abonado.getCodUso() + "]");
			logger.debug("abonado.getCodTecnologia()[" + abonado.getCodTecnologia() + "]");
			logger.debug("abonado.getCodActAbo()[" + abonado.getCodActAbo() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, abonado.getCodUso()); //COD_USO
			cstmt.setString(2, abonado.getCodTecnologia()); //COD_TECNOLOGIA
			cstmt.setString(3, abonado.getCodActAbo()); //COD_ACTABO
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); //RESULTADO
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
				logger.error(" Ocurrió un error al validar portabilidad");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String res = cstmt.getString(4);
			logger.debug("res[" + res + "]");
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			retorno.setResultado(res.equalsIgnoreCase("TRUE")?true:false);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al validar portabilidad", e);
			throw new CustomerOrderException("Ocurrió un error general al validar portabilidad",e);
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
		logger.debug("validarPortabilidad():end");
		return retorno;		
	}
	
	/**
	 * Obtener codActAbo homologo
	 * 
	 * @param param
	 * @return ConvertActAboDTO
	 * @throws CustomerOrderException
	 */
	public ConvertActAboDTO obtenerConverActAbo(ConvertActAboDTO param) throws CustomerOrderException{
		logger.debug("obtenerConverActAbo():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ConvertActAboDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerConverActAbo();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("param.getCodActAbo()[" + param.getCodActAbo() + "]");
			logger.debug("param.getCodTipPlan()[" + param.getCodTipPlan() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, param.getCodActAbo() ); //COD_ACTABO
			cstmt.setString(2, param.getCodTipPlan()); //COD_TIPLAN
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); //COD_ACTABO_HOM

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
				logger.error(" Ocurrió un error al obtener codActAbo homologo");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String codActAboHom = cstmt.getString(6);
			logger.debug("codActAboHom[" + codActAboHom + "]");
			
			retorno = param;
			retorno.setCodActAboHom(codActAboHom);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener codActAbo homologo", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener codActAbo homologo",e);
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
		logger.debug("obtenerConverActAbo():end");
		return retorno;				
	}
	
	/**
	 * Valida servicios duplicados
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */
	public RetornoDTO validarServiciosDuplicados(AbonadoDTO abonado) throws CustomerOrderException{
		logger.debug("validarServiciosDuplicados():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidarServiciosDuplicados();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("abonado.getCodTipoTerminal()[" + abonado.getCodTipoTerminal() + "]");
			logger.debug("abonado.getCodPlanTarif()[" + abonado.getCodPlanTarif() + "]");
			logger.debug("abonado.getCodTecnologia()[" + abonado.getCodTecnologia() + "]");
			logger.debug("abonado.getCodCentral()[" + abonado.getCodCentral() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, abonado.getCodTipoTerminal() ); //TIP_TERMINAL
			cstmt.setString(2, abonado.getCodPlanTarif() ); //COD_PLANTARIF
			cstmt.setString(3, abonado.getCodTecnologia() ); //COD_TECNOLOGIA
			cstmt.setInt(4, abonado.getCodCentral() ); //COD_CENTRAL
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); //RESULTADO
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);


			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(6);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al validar servicios duplicados");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String res = cstmt.getString(5);
			logger.debug("res[" + res + "]");
			
			retorno = new RetornoDTO();
			retorno.setResultado(res.equalsIgnoreCase("TRUE")?true:false);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al validar servicios duplicados", e);
			throw new CustomerOrderException("Ocurrió un error general al validar servicios duplicados",e);
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
		logger.debug("validarServiciosDuplicados():end");
		return retorno;		
	}
	
	/**
	 * Actualiza baja en GA_SERVSUPLABO
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */
	public RetornoDTO bajaSSPrepago(AbonadoDTO abonado) throws CustomerOrderException{
		logger.debug("bajaSSPrepago():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLbajaSSPrepago();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado()+ "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, abonado.getNumAbonado() ); //NUM_ABONADO
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);


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
				logger.error(" Ocurrió un error al actualizar baja prepago");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al actualizar baja prepago", e);
			throw new CustomerOrderException("Ocurrió un error general al actualizar baja prepago",e);
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
		logger.debug("bajaSSPrepago():end");
		return retorno;			
	}
	
	/**
	 * Actualiza baja en GA_INTARCEL
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */
	public RetornoDTO bajaRegTarif(AbonadoDTO abonado) throws CustomerOrderException{
		logger.debug("bajaRegTarif():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLbajaRegTarif();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("abonado.getCodCliente()[" + abonado.getCodCliente()+ "]");
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado()+ "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, abonado.getCodCliente() ); //COD_CLIENTE
			cstmt.setLong(2, abonado.getNumAbonado() ); //NUM_ABONADO
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
				logger.error(" Ocurrió un error al actualizar baja en ga_intarcel");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al actualizar baja en ga_intarcel", e);
			throw new CustomerOrderException("Ocurrió un error general al actualizar baja en ga_intarcel",e);
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
		logger.debug("bajaRegTarif():end");
		return retorno;
	}
	
	/**
	 * Obtiene grupo nivel de GA_SERVSUPLABO
	 * 
	 * @param abonado
	 * @return ServicioDTO
	 * @throws CustomerOrderException
	 */
	public ServicioDTO obtenerGrupoNivelContratado(AbonadoDTO abonado) throws CustomerOrderException{
		logger.debug("obtenerGrupoNivelContratado():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ServicioDTO servicio = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerGrupoNivelContratado();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado()+ "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, abonado.getNumAbonado() ); //NUM_ABONADO
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);//GRUPO_NIVEL
			
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
				logger.error(" Ocurrió un error al obtener grupo nivel de GA_SERVSUPLABO");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String servicios = cstmt.getString(5);
			logger.debug("servicios[" + servicios + "]");
			
			servicio = new ServicioDTO();
			servicio.setCadenaServicio(servicios);
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener grupo nivel de GA_SERVSUPLABO", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener grupo nivel de GA_SERVSUPLABO",e);
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
		logger.debug("obtenerGrupoNivelContratado():end");
		return servicio;		
	}
	
	/**
	 * Inserta registro en GA_TRANSACABO
	 * @param numSecuencia
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */
	public RetornoDTO insertarTransacabo(SecuenciaDTO secuencia) throws CustomerOrderException{
		logger.debug("insertarTransacabo():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLinsertarTransacabo();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("numSecuencia[" + secuencia.getNumSecuencia()+ "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, secuencia.getNumSecuencia() );
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
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
				logger.error(" Ocurrió un error al insertar registro en GA_TRANSACABO");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al insertar registro en GA_TRANSACABO", e);
			throw new CustomerOrderException("Ocurrió un error general al insertar registro en GA_TRANSACABO",e);
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
		logger.debug("insertarTransacabo():end");
		return retorno;		
	}	
	
	
	/**
	 * Registra OOSS en Linea
	 * 
	 * @param registro
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */	
	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO registro) throws CustomerOrderException {
		logger.debug("registrarOOSSEnLinea():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistrarOOSSEnLinea();
		try {
			logger.debug("call [" +call + "]");
			
			logger.debug("registro.getNumOs() [" +registro.getNumOs() + "]");
			logger.debug("registro.getCodOs() [" +registro.getCodOS() + "]"); 
			logger.debug("registro.getCodProducto() [" +registro.getCodProducto() + "]"); 
			logger.debug("registro.getTipInter() [" +registro.getTipInter() + "]"); 
			logger.debug("registro.getCodInter() [" +registro.getCodInter() + "]"); 
			logger.debug("registro.getUsuario() [" +registro.getUsuario() + "]");
			logger.debug("registro.getFecha() [" +registro.getFecha() + "]"); 
			logger.debug("registro.getComentario() [" +registro.getComentario() + "]"); 
			logger.debug("registro.getNumMovimiento() [" +registro.getNumMovimiento() + "]"); 
			logger.debug("registro.getCodEstado() [" +registro.getCodEstado() + "]"); 
			logger.debug("registro.getCodModulo() [" +registro.getCodModulo() + "]"); 
			logger.debug("registro.getIndGestor () [" +registro.getIndGestor() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, registro.getNumOs()); 
			cstmt.setString(2, registro.getCodOS());  
			cstmt.setInt(3, registro.getCodProducto()); 
			cstmt.setInt(4, registro.getTipInter());  
			cstmt.setLong(5, registro.getCodInter());  
			cstmt.setString(6, registro.getUsuario());
			//java.sql.Date fecha = null;	try{	fecha = new java.sql.Date(registro.getFecha().getTime());	}catch(Exception e){}
			/*java.sql.Date toDateOOSS=new java.sql.Date(registro.getFecha().getTime());
			cstmt.setDate(7,toDateOOSS);*/
			//Formatting formatting =new Formatting();
			String fechaOSS=Formatting.dateTime(registro.getFecha(),"dd MMM yyyy HH:mm:ss");
			cstmt.setString(7,fechaOSS);
			cstmt.setString(8, registro.getComentario()); 
			//cstmt.setLong(9, registro.getNumMovimiento());
			
			if(registro.getNumMovimiento()==0)
				cstmt.setNull(9, java.sql.Types.NUMERIC);// (9, String.valueOf(null));
			else
				cstmt.setLong(9, registro.getNumMovimiento());
			cstmt.setInt(10, registro.getCodEstado());  
			cstmt.setString(11, registro.getCodModulo());  
			cstmt.setInt(12, registro.getIndGestor()); 
			
			
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(13);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(14);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(15);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al insertar la orden de servicio en linea");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			

			logger.debug("Recuperando data...");
			
			respuesta = new RetornoDTO();
			respuesta.setDescripcion(msgError);

		
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general  al insertar la orden de servicio en linea", e);
			throw new CustomerOrderException("Ocurrió un error general al insertar la orden de servicio en linea",e);
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
		logger.debug("registrarOOSSEnLinea():end");
		return respuesta;

	}
	
	/**
	 * Actualiza renovacion
	 * 
	 * @param param
	 * @return RangoAntiguedadDTO
	 * @throws CustomerOrderException
	 */	
	public RetornoDTO actualizaRenova(RegistrarRenovaDTO registro) throws CustomerOrderException{
		logger.debug("actualizaRenova():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLActualizaRenova();
		try {
			
			
			logger.debug("registro.getNumOsRenova()    [" +registro.getNumOsRenova() + "]");
			logger.debug("registro.getNumOs()          [" +registro.getNumOs() + "]");
			logger.debug("registro.getNumAbonado()     [" +registro.getNumAbonado() + "]");
			logger.debug("registro.getCodOS()          [" +registro.getCodOS() + "]");

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, registro.getNumOsRenova()); 
			cstmt.setLong(2, registro.getNumOs()); 
			cstmt.setLong(3, registro.getNumAbonado()); 
			cstmt.setString(4, registro.getCodOS());
			
			
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); 
			
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
				logger.error(" Ocurrió un error al actualizar la renovación");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			respuesta = new RetornoDTO();
			respuesta.setCodigo("0");
			respuesta.setDescripcion(msgError);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al actualizar la renovacion", e);
			throw new CustomerOrderException("Ocurrió un error general al actualizar la renovacion",e);
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
		logger.debug("actualizaRenova():end");
		return respuesta;
	}
	
	
	/**
	 * Obtiene rango antiguedad
	 * 
	 * @param param
	 * @return RangoAntiguedadDTO
	 * @throws CustomerOrderException
	 */	
	public RangoAntiguedadDTO obtenerRangoAntiguedad(RangoAntiguedadDTO param) throws CustomerOrderException{
		logger.debug("obtenerRangoAntiguedad():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RangoAntiguedadDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerRangoAntiguedad();
		try {
			
			logger.debug("param.getNumSerie()      [" +param.getNumSerie() + "]");
			logger.debug("param.getCodCausaBaja()  [" +param.getCodCausaBaja() + "]");
			logger.debug("param.getFechaAlta()     [" +param.getFechaAlta() + "]");
			logger.debug("param.getFechaProrroga() [" +param.getFechaProrroga() + "]");

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, param.getNumSerie()); //NUM_SERIE
			cstmt.setString(2, param.getCodCausaBaja()); //COD_CAUSA
			java.sql.Date fechaAlta = null;	try{	fechaAlta = new java.sql.Date(param.getFechaAlta().getTime());	}catch(Exception e){}
			cstmt.setDate(3, fechaAlta); //FECHA_ALTA
			java.sql.Date fechaProrroga = null;	try{	fechaProrroga = new java.sql.Date(param.getFechaProrroga().getTime());	}catch(Exception e){}
			cstmt.setDate(4, fechaProrroga); //FECHA_PRORROGA
			
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //RANGO_ANTIGUEDAD
			
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
				logger.error(" Ocurrió un error al obtener rango antiguedad");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			

			logger.debug("Recuperando data...");
			String rangoAntiguedad =  cstmt.getString(8);
			logger.debug("rangoAntiguedad[" + rangoAntiguedad + "]");
			
			respuesta = new RangoAntiguedadDTO();
			respuesta.setRangoAntiguedad(rangoAntiguedad);

			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener rango antiguedad", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener rango antiguedad",e);
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
		logger.debug("obtenerRangoAntiguedad():end");
		return respuesta;
	}
	
	/**
	 * Obtiene codigo y oficina de vendedor
	 * 
	 * @param usuario
	 * @return UsuarioDTO
	 * @throws CustomerOrderException
	 */	
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws CustomerOrderException{
		logger.debug("obtenerVendedor():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		UsuarioDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerVendedor();
		try {
			
			logger.debug("usuario.getNombre() [" + usuario.getNombre()+ "]");

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, usuario.getNombre()); //USUARIO
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //CODIGO
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); //COD_OFICINA
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //COD_TIPCOMIS
			
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
				logger.error(" Ocurrió un error al obtener codigo vendedor");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}

			logger.debug("Recuperando data...");
			int codigo = cstmt.getInt(5);
			logger.debug("codigo[" + codigo + "]");
			
			String codOficina = cstmt.getString(6);
			logger.debug("codOficina[" + codOficina + "]");
			
			String codTipComis = cstmt.getString(7);
			logger.debug("codTipComis[" + codTipComis + "]");
		
			respuesta = usuario;
			respuesta.setCodigo(codigo);
			respuesta.setCodOficina(codOficina);
			respuesta.setCodTipComis(codTipComis);
		
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener codigo vendedor", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener codigo vendedor",e);
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
		logger.debug("obtenerVendedor():end");
		return respuesta;		
	}
	
	/**
	 * Obtiene informacion de descuento para el vendedor
	 * 
	 * @param vendedor
	 * @return DescuentoVendedorDTO
	 * @throws CustomerOrderException
	 */	
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor) throws CustomerOrderException{
		logger.debug("obtenerDescuentoVendedor():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DescuentoVendedorDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerDescuentoVendedor();
		try {
			logger.debug("call[" + call+ "]");
			logger.debug("vendedor.getCodVendedor() [" + vendedor.getCodVendedor()+ "]");

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1, vendedor.getCodVendedor()); //CODIGO
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //IND_CREADTO
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC); //PRC_NEWDTO_INF
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC); //PRC_NEWDTO_SUP
			
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
				logger.error(" Ocurrió un error al obtener información de descuento del vendedor");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
	
			logger.debug("Recuperando data...");
			int  indCreaDescuento= cstmt.getInt(5);
			logger.debug("indCreaDescuento[" + indCreaDescuento + "]");
			int  rangoInfPorcDescuento= cstmt.getInt(6);
			logger.debug("rangoInfPorcDescuento[" + rangoInfPorcDescuento + "]");
			int  rangoSupPorcDescuento= cstmt.getInt(7);
			logger.debug("rangoSupPorcDescuento[" + rangoSupPorcDescuento + "]");
			
			respuesta = vendedor;
			respuesta.setIndCreaDescuento(indCreaDescuento);
			respuesta.setRangoInfPorcDescuento(rangoInfPorcDescuento);
			respuesta.setRangoSupPorcDescuento(rangoSupPorcDescuento);
		
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener información de descuento del vendedor", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener información de descuento del vendedor",e);
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
		logger.debug("obtenerDescuentoVendedor():end");
		return respuesta;		
	}
	
	/**
	 * Obtiene penalizacion
	 * 
	 * @param penalizacion
	 * @return PenalizacionDTO
	 * @throws CustomerOrderException
	 */
	public PenalizacionDTO obtenerPenalizacion(PenalizacionDTO penalizacion) throws CustomerOrderException{
		logger.debug("obtenerPenalizacion():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PenalizacionDTO retornoPenalizacion = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerPenalizacion();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("penalizacion.getNumAbonado()       "+penalizacion.getNumAbonado());
			logger.debug("penalizacion.getFecFinContrato()   "+penalizacion.getFecFinContrato());
			logger.debug("penalizacion.getModalidadPago()    "+penalizacion.getModalidadPago());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, penalizacion.getNumAbonado() ); //NUM_ABONADO
			java.sql.Date fecFinContra = null;	try{	fecFinContra = new java.sql.Date(penalizacion.getFecFinContrato().getTime());	}catch(Exception e){}
			cstmt.setDate(2, fecFinContra); //FEC_FINCONTRA
			cstmt.setInt(3, penalizacion.getModalidadPago()); //MODALIDAD_DE_PAGO
			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); // TIPO_INDEMNIZACION
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC); // COD_PEN_CONTRA
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); // AFECTO_INDEM
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener penalizacion");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String tipoIndemnizacion = cstmt.getString(7);
			logger.debug("tipoIndemnizacion[" + tipoIndemnizacion + "]");
			long codPenalizacion = cstmt.getLong(8);
			logger.debug("codPenalizacion[" + codPenalizacion + "]");
			String afectoIndem = cstmt.getString(9);
			logger.debug("afectoIndem[" + afectoIndem + "]");
			
			retornoPenalizacion = new PenalizacionDTO();
			retornoPenalizacion.setTipoIndemizacion(tipoIndemnizacion);
			retornoPenalizacion.setCodPenalizacion(codPenalizacion);
			retornoPenalizacion.setAfectoIndemiza(afectoIndem);
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener penalizacion", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener penalizacion",e);
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
		logger.debug("obtenerPenalizacion():end");
		return retornoPenalizacion;		
	}

	/**
	 * Regitra venta
	 * 
	 * @param venta
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws CustomerOrderException{
		logger.debug("registrarVenta():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistrarVenta();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("venta.getNumVenta()     [" + venta.getNumVenta() + "]");
			logger.debug("venta.getCodProducto()  [" + venta.getCodProducto() + "]");
			logger.debug("venta.getCodOficina()   [" + venta.getCodOficina() + "]");
			logger.debug("venta.getCodTipComis()  [" + venta.getCodTipComis() + "]");
			logger.debug("venta.getCodVendedor()  [" + venta.getCodVendedor() + "]");
			logger.debug("venta.getCodVendAgente()[" + venta.getCodVendedorAgente() + "]");
			logger.debug("venta.getNumUnidades()  [" + venta.getNumUnidades() + "]");
			logger.debug("venta.getFecVenta()     [" + venta.getFecVenta() + "]");
			logger.debug("venta.getCodRegion()    [" + venta.getCodRegion() + "]");
			logger.debug("venta.getCodProvincia() [" + venta.getCodProvincia() + "]");
			logger.debug("venta.getCodProvincia() [" + venta.getCodCiudad() + "]");
			logger.debug("venta.getIndEstVenta()  [" + venta.getIndEstVenta() + "]");
			logger.debug("venta.getIndPasoCob()   [" + venta.getIndPasoCob() + "]");
			logger.debug("venta.getIndTipVenta()  [" + venta.getIndTipVenta() + "]");
			logger.debug("venta.getCodCliente()   [" + venta.getCodCliente()+ "]");
			logger.debug("venta.getCodModVenta()  [" + venta.getCodModVenta()+ "]");
			logger.debug("venta.getCodCuota()     [" + venta.getCodCuota()+ "]");
			logger.debug("venta.getNomUsuarVenta()[" + venta.getNomUsuarioVenta()+ "]");
			logger.debug("venta.getIndVenta()     [" + venta.getIndVenta()+ "]");
			logger.debug("venta.getTipFoliacion() [" + venta.getTipFoliacion()+ "]");
			logger.debug("venta.getCodTipDocumen()[" + venta.getCodTipDocumento()+ "]");
			logger.debug("venta.getCodPlaza()     [" + venta.getCodPlaza()+ "]");
			logger.debug("venta.getCodOperadora() [" + venta.getCodOperadora()+ "]");

			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,venta.getNumVenta() );
			cstmt.setInt(2,venta.getCodProducto() );
			cstmt.setString(3,venta.getCodOficina() );
			cstmt.setString(4,venta.getCodTipComis() );
			cstmt.setInt(5,venta.getCodVendedor() );
			cstmt.setInt(6,venta.getCodVendedorAgente() );
			cstmt.setInt(7,venta.getNumUnidades() );
			//java.sql.Date fecVenta = null;	try{	fecVenta = new java.sql.Date(venta.getFecVenta().getTime());	}catch(Exception e){}
			cstmt.setTimestamp(8,new Timestamp(venta.getFecVenta().getTime()) );
			cstmt.setString(9,venta.getCodRegion() );
			cstmt.setString(10,venta.getCodProvincia() );
			cstmt.setString(11,venta.getCodCiudad() );
			cstmt.setString(12,venta.getIndEstVenta() );
			cstmt.setInt(13,venta.getIndPasoCob() );
			cstmt.setInt(14,venta.getIndTipVenta() );
			cstmt.setLong(15,venta.getCodCliente() );
			cstmt.setInt(16,venta.getCodModVenta() );
			cstmt.setString(17,venta.getCodCuota() );
			cstmt.setString(18,venta.getNomUsuarioVenta() );
			cstmt.setString(19,venta.getIndVenta() );
			cstmt.setString(20,venta.getTipFoliacion() );
			cstmt.setInt(21,venta.getCodTipDocumento() );
			cstmt.setString(22,venta.getCodPlaza() );
			cstmt.setString(23,venta.getCodOperadora() );
			
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(24);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(25);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(26);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al registrar venta");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
		
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar venta", e);
			throw new CustomerOrderException("Ocurrió un error general al registrar venta",e);
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
		logger.debug("registrarVenta():end");
		return retorno;				
	}
	/**
	 * Obtiene direccion de oficina de vendedor
	 * 
	 * @param codOficina
	 * @return DireccionOficinaDTO
	 * @throws CustomerOrderException
	 */
	public DireccionOficinaDTO obtenerDireccionOficina(String codOficina) throws CustomerOrderException{
		logger.debug("obtenerDireccionOficina():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DireccionOficinaDTO direccion = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerDireccionOficina();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("codOficina = "+codOficina);

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, codOficina); //COD_OFICINA
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); // COD_REGION
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); // COD_PROVINCIA
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); // COD_CIUDAD
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); // COD_PLAZA
			
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
				logger.error(" Ocurrió un error al obtener dirección de oficina");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String codRegion = cstmt.getString(5);
			logger.debug("codRegion[" + codRegion + "]");
			String codProvincia = cstmt.getString(6);
			logger.debug("codProvincia[" + codProvincia + "]");
			String codCiudad = cstmt.getString(7);
			logger.debug("codCiudad[" + codCiudad + "]");
			String codPlaza = cstmt.getString(8);
			logger.debug("codPlaza[" + codPlaza + "]");
			
			direccion = new DireccionOficinaDTO();
			direccion.setCodOficina(codOficina);
			direccion.setCodRegion(codRegion);
			direccion.setCodProvincia(codProvincia);
			direccion.setCodCiudad(codCiudad);
			direccion.setCodPlaza(codPlaza);
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener dirección de oficina", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener dirección de oficina",e);
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
		logger.debug("obtenerDireccionOficina():end");
		return direccion;		
		
	}
	
	/**
	 * Obtiene codigo de vendedor raiz
	 * 
	 * @param codVendedor
	 * @return codVendedorRaiz
	 * @throws CustomerOrderException
	 */	
	public Integer obtenerVendedorRaiz(Integer codVendedor) throws CustomerOrderException{
		logger.debug("obtenerVendedorRaiz():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Integer codigoVendedorRaiz = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerVendedorRaiz();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			logger.debug("codVendedor = "+codVendedor);

			cstmt = conn.prepareCall(call);
			cstmt.setInt(1, codVendedor.intValue()); //CODIGO
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); // CODIGO
			
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
				logger.error(" Ocurrió un error al obtener codigo de vendedor raiz");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			codigoVendedorRaiz = new Integer(cstmt.getInt(5));
			logger.debug("codigoVendedorRaiz[" + codigoVendedorRaiz + "]");
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener codigo de vendedor raiz", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener codigo de vendedor raiz",e);
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
		logger.debug("obtenerVendedorRaiz():end");
		return codigoVendedorRaiz;		
	}
	
	/**
	 * Obtiene codigo de operadora
	 * 
	 * @param codCliente
	 * @return codOperadora
	 * @throws CustomerOrderException
	 */	
	public String obtenerOperadora(Long codCliente) throws CustomerOrderException{
		logger.debug("obtenerOperadora():start");

		String codOperadora = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerOperadora();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			logger.debug("codCliente = "+codCliente);
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, codCliente.longValue()); //COD_CLIENTE
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR); // COD_OPERADORA
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando data...");
			codOperadora = cstmt.getString(2);
			logger.debug("codOperadora[" + codOperadora + "]");
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener código de operadora", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener código de operadora",e);
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
		logger.debug("obtenerOperadora():end");
		return codOperadora;	
	}
	/**
	 * Obtiene clase servicio
	 * 
	 * @param param
	 * @return ServCuentaSegDTO
	 * @throws CustomerOrderException
	 */	
	public ServCuentaSegDTO tratarServCtaSeg(ServCuentaSegDTO param) throws CustomerOrderException{
		logger.debug("tratarServCtaSeg():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ServCuentaSegDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLtratarServCtaSeg();
		try {
			
			logger.debug("param.getNumAbonado()      :"+param.getNumAbonado());
			logger.debug("param.getCodActAbo()       :"+param.getCodActAbo());
			logger.debug("param.getCodTecnologia()   :"+param.getCodTecnologia());
			logger.debug("param.getNumCelular()      :"+param.getNumCelular());
			logger.debug("param.getCodTipoTerminal() :"+param.getCodTipoTerminal());
			logger.debug("param.getCodCentral()      :"+param.getCodCentral());
			logger.debug("param.getPerfilAbonado()   :"+param.getPerfilAbonado());

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, param.getNumAbonado()); //NUM_ABONADO
			cstmt.setString(2, param.getCodActAbo()); //COD_ACTABO
			cstmt.setString(3, param.getCodTecnologia()); //COD_TECNOLOGIA
			cstmt.setLong(4, param.getNumCelular()); //NUM_CELULAR
			cstmt.setString(5, param.getCodTipoTerminal()); //TIP_TERMINAL
			cstmt.setInt(6, param.getCodCentral()); //COD_CENTRAL
			cstmt.setString(7, param.getPerfilAbonado()); //PERFIL_ABONADO
						
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); //CLASE_SERVICIO
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(8);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(9);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(10);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener clase de servicio");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			

			logger.debug("Recuperando data...");
			String claseServicio =  cstmt.getString(11);
			logger.debug("claseServicio[" + claseServicio + "]");
			
			respuesta = new ServCuentaSegDTO();
			respuesta.setClaseServicio(claseServicio);
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error(" Ocurrió un error al obtener clase de servicio", e);
			throw new CustomerOrderException(" Ocurrió un error al obtener clase de servicio",e);
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
		logger.debug("tratarServCtaSeg():end");
		return respuesta;
	}
	/**
	 * Obtiene tipo de contrato
	 * 
	 * @param contrato
	 * @return ContratoDTO
	 * @throws CustomerOrderException
	 */	
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws CustomerOrderException{
		logger.debug("obtenerTipoContrato():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ContratoDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerTipoContrato();
		try {
			logger.debug("contrato.getCodProducto() :" + contrato.getCodProducto());
			logger.debug("contrato.getCodigoTipoContrato() :" + contrato.getCodigoTipoContrato());

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1, contrato.getCodProducto()); //COD_PRODUCTO
			cstmt.setString(2, contrato.getCodigoTipoContrato()); //COD_TIPCONTRATO
			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //DES_TIPCONTRATO
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //IND_COMODATO
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
				logger.error(" Ocurrió un error al obtener tipo contrato");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			

			logger.debug("Recuperando data...");
			String desTipContrato =  cstmt.getString(3);
			logger.debug("desTipContrato[" + desTipContrato + "]");
			int indComodato =  cstmt.getInt(4);
			logger.debug("indComodato[" + indComodato + "]");
			
			respuesta = new ContratoDTO();
			respuesta.setDescripcionTipoContrato(desTipContrato);
			respuesta.setIndComodato(indComodato);
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error(" Ocurrió un error al obtener tipo contrato", e);
			throw new CustomerOrderException(" Ocurrió un error al obtener tipo contrato",e);
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
		logger.debug("obtenerTipoContrato():end");
		return respuesta;		
	}
	
	/**
	 * Registrar Mov. Controlada
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws CustomerOrderException
	 */
	public RetornoDTO registrarMovControlada(AbonadoDTO abonado) throws CustomerOrderException{
		logger.debug("registrarMovControlada():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistrarMovControlada();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado() + "]");
			logger.debug("abonado.getCodActAbo()[" + abonado.getCodActAbo() + "]");
			logger.debug("abonado.abonado.getNumSerie()[" + abonado.getNumSerie() + "]");
			logger.debug("abonado.abonado.getTipMov()[" + abonado.getTipMov() + "]");
			
			logger.debug("call="+call);
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, abonado.getNumAbonado()); //NUM_ABONADO
			cstmt.setString(2, abonado.getCodActAbo()); //COD_ACTABO
			cstmt.setString(3, abonado.getNumSerie()); //NUM_SERIE
			cstmt.setInt(4, abonado.getTipMov()); //TIPMOV
			
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
				logger.error(" Ocurrió un error al validar Mov. controlada");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al validar Mov. controlada", e);
			throw new CustomerOrderException("Ocurrió un error general al validar Mov. controlada",e);
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
		logger.debug("registrarMovControlada():end");
		return retorno;		
	}
	
	/**
	 * Obtiene modalidad de pago
	 * 
	 * @param modalidad
	 * @return ModalidadPagoDTO
	 * @throws CustomerOrderException
	 */
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws CustomerOrderException{
		logger.debug("obtenerModalidadPago():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ModalidadPagoDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerModalidadPago();
		try {
			logger.debug("modalidad.getCodigoModalidadPago() :" + modalidad.getCodigoModalidadPago());
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, modalidad.getCodigoModalidadPago()); //COD_MODVENTA
			
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR); //DES_MODVENTA
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC); //IND_CUOTAS
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);			
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener modalidad de pago");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			

			logger.debug("Recuperando data...");
			String desModalidadVenta =  cstmt.getString(2);
			logger.debug("desModalidadVenta[" + desModalidadVenta + "]");
			int indCuotas =  cstmt.getInt(3);
			logger.debug("indCuotas[" + indCuotas + "]");
			
			respuesta = new ModalidadPagoDTO();
			respuesta.setDescripcionModalidadPago(desModalidadVenta);
			respuesta.setIndicadorCuotas(indCuotas);
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error(" Ocurrió un error al obtener modalidad de pago", e);
			throw new CustomerOrderException(" Ocurrió un error al obtener modalidad de pago",e);
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
		logger.debug("obtenerModalidadPago():end");
		return respuesta;				
	}
	/**
	 * Obtiene información del vendedor
	 * 
	 * @param vendedor
	 * @return VendedorDTO
	 * @throws CustomerOrderException
	 */
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws CustomerOrderException{
		logger.debug("obtenerVendedor():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		VendedorDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerInfoVendedor();
		try {
			logger.debug("vendedor.getCodigoVendedor() :" + vendedor.getCodigoVendedor());
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, vendedor.getCodigoVendedor()); //COD_VENDEDOR
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);//NOM_VENDEDOR
			
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
				logger.error(" Ocurrió un error al obtener información de vendedor");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			

			logger.debug("Recuperando data...");
			String nombreVendedor =  cstmt.getString(5);
			logger.debug("nombreVendedor[" + nombreVendedor + "]");
			
			respuesta = vendedor;
			respuesta.setNombreVendedor(nombreVendedor);
			
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error(" Ocurrió un error al obtener información de vendedor", e);
			throw new CustomerOrderException(" Ocurrió un error al obtener información de vendedor",e);
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
		logger.debug("obtenerVendedor():end");
		return respuesta;		
	}
	
	protected String getSQL(String nombrePackage, String nombrePL, int cantParametros) {
		StringBuffer b = new StringBuffer("{call " + nombrePackage.toUpperCase() + "." + nombrePL.toUpperCase() + "(");
		for (int i = 1; i <= cantParametros; i++) {
			b.append("?");
			b.append(i < cantParametros ? "," : "");
		}
		return b.append(")}").toString();
	}

	/**
	 * Guarda Carta asociada a la OS en la tabla CI_CARTAS
	 * 
	 * @author JIB
	 * @param dto
	 * @param numOS
	 * @return
	 * @throws CustomerOrderException
	 * 
	 * Incidencia 155633: Genera la carta pero no la graba en la tabla
	 * CI_CARTAS.
	 * 
	 */
	public boolean registrarCarta(CartaGeneralDTO dto, long numOS) throws CustomerOrderException {
		logger.info("registrarCarta():inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		final String nombrePackage = "PV_ORDEN_SERVICIO_PG";
		final String nombrePL = "PV_REGISTRAR_CARTA_PR";
		final int cantParametros = 6;

		final String mensajeError = "Ocurrió un error al registrar carta";
		try {
			final String call = getSQL(nombrePackage, nombrePL, cantParametros);
			logger.debug("call [" + call + "]");
			int i = 1;
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			cstmt.setLong(i++, numOS);
			cstmt.setString(i++, dto.getCodOOSS());
			cstmt.setString(i++, dto.getTexCarta());
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerOrderException(String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (CustomerOrderException e) {
			logger.error("CustomerOrderException");
			logger.error("log error[" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			throw new CustomerOrderException(mensajeError, e);
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
			}
			catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.error("SQLException [" + e + "]");
			}
		}
		logger.info("registrarCarta():fin");
		return true;
	}
	
}
