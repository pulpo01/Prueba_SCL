package com.tmmas.cl.scl.altacliente.presentacion.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoValidacionAjaxDTO;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosTributariosForm;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;

public class DatosTributariosAJAX {
	private final Logger logger = Logger.getLogger(DatosTributariosAJAX.class);
	private Global global = Global.getInstance();
	
	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();
	
	public RetornoValidacionAjaxDTO validarIdentificador(String tipoIdentif,String numIdentif){
		logger.debug("obtenerCiclosFacturacion:inicio()");
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();
		NumeroIdentificacionDTO param = new NumeroIdentificacionDTO();
		retorno.setValido(true);
		try{
			param.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			param.setCorrelativo(Long.valueOf(global.getValor("param.identificador.correlativo")));
			param.setTipoIdentif(tipoIdentif);
			param.setNumIdentif(numIdentif);
			param = delegate.validarIdentificador(param);
			retorno.setIdentificadorFormateado(param.getFormatoNIT());
		}catch(Exception e){
			retorno.setValido(false);
		}
		logger.debug("obtenerCiclosFacturacion:fin()");
		return retorno;	
	}
	/*
	 * Copia la direccion indicada en origen a la direccion indicada en destino
	 * */
	public void copiarDireccion(String origen, String destino){
		logger.debug("copiarDireccion:inicio()");

		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);
		if (!validarSesion(session)){
			return;
		}
		DatosTributariosForm datosTributariosForm = (DatosTributariosForm)session.getAttribute("DatosTributariosForm");
		if (datosTributariosForm!=null){//carga direccion
			FormularioDireccionDTO direccionOrigen = null;
			FormularioDireccionDTO direccionDestino = new FormularioDireccionDTO();
			
			if (origen.equals("PERS")) direccionOrigen = datosTributariosForm.getDireccionPersonalForm();
			else if (origen.equals("FACT")) direccionOrigen = datosTributariosForm.getDireccionFacturacionForm();
			else if (origen.equals("CORR")) direccionOrigen = datosTributariosForm.getDireccionCorrespondenciaForm();
			
			direccionDestino.setCOD_REGION(direccionOrigen.getCOD_REGION());
			direccionDestino.setCOD_PROVINCIA(direccionOrigen.getCOD_PROVINCIA());
			direccionDestino.setCOD_CIUDAD(direccionOrigen.getCOD_CIUDAD());
			direccionDestino.setCOD_COMUNA(direccionOrigen.getCOD_COMUNA());
			direccionDestino.setCOD_TIPOCALLE(direccionOrigen.getCOD_TIPOCALLE());
			direccionDestino.setNOM_CALLE(direccionOrigen.getNOM_CALLE());
			direccionDestino.setNUM_CALLE(direccionOrigen.getNUM_CALLE());
			direccionDestino.setOBS_DIRECCION(direccionOrigen.getOBS_DIRECCION());
			direccionDestino.setZIP(direccionOrigen.getZIP());
			direccionDestino.setDES_DIREC1(direccionOrigen.getDES_DIREC1());
			direccionDestino.setDES_DIREC2(direccionOrigen.getDES_DIREC2());			
			direccionDestino.setDescripcionCOD_REGION(direccionOrigen.getDescripcionCOD_REGION());
			direccionDestino.setDescripcionCOD_PROVINCIA(direccionOrigen.getDescripcionCOD_PROVINCIA());
			direccionDestino.setDescripcionCOD_CIUDAD(direccionOrigen.getDescripcionCOD_CIUDAD());
			direccionDestino.setDescripcionCOD_COMUNA(direccionOrigen.getDescripcionCOD_COMUNA());
			direccionDestino.setDescripcionCOD_TIPOCALLE(direccionOrigen.getDescripcionCOD_TIPOCALLE());
			direccionDestino.setDescripcionZIP(direccionOrigen.getDescripcionZIP());
			direccionDestino.setDireccionReplicada(true);
			
			if (destino.equals("PERS")) datosTributariosForm.setDireccionPersonalForm(direccionDestino);
			else if (destino.equals("FACT")) datosTributariosForm.setDireccionFacturacionForm(direccionDestino);
			else if (destino.equals("CORR")) datosTributariosForm.setDireccionCorrespondenciaForm(direccionDestino);
			
		}
		logger.debug("copiarDireccion:fin()");
	}
	
	private boolean validarSesion(HttpSession sesion){

		if (sesion == null)	return false;
			
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal"); 
		if (sessionData == null) return false;
		
		return true;
	}		
}
