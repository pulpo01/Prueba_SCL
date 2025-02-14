package com.tmmas.cl.scl.migracionmasiva.validaciones;

import com.tmmas.cl.scl.migracionmasiva.dto.WSDatosEntradaDTO;
import com.tmmas.cl.scl.migracionmasiva.dto.WSDatosSalidaDTO;
import com.tmmas.cl.scl.migracionmasiva.helper.GlobalProperties;
import com.tmmas.cl.scl.migracionmasiva.helper.LoggerHelper;

public class Validaciones {
	 private final LoggerHelper logger = LoggerHelper.getInstance();
	 private final String nombreClase = this.getClass().getName();
	 GlobalProperties global = GlobalProperties.getInstance();
	public WSDatosSalidaDTO validaciones(WSDatosEntradaDTO datosEntradaDTO){
		WSDatosSalidaDTO resp=null;
		
		resp=validaNulo(datosEntradaDTO);
		if(resp!=null){
			return resp;
		}
	
		resp=validaLargo(datosEntradaDTO);
		if(resp!=null){
			return resp;
		}

		resp=validaTipo(datosEntradaDTO);
		if(resp!=null){
			return resp;
		}
	
		return null;
	}

	public WSDatosSalidaDTO validaLargo(WSDatosEntradaDTO datosEntradaDTO){
		WSDatosSalidaDTO salida=null;
		if(datosEntradaDTO.getCodCliente().length()>8){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10001");
			salida.setDescError("Largo de código de cliente mayor a lo permitido.");
			return salida;
		}

		if(datosEntradaDTO.getCodPlanTarif().length()>3){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10011");
			salida.setDescError("Largo de código de plan tarifario mayor a lo permitido.");
			return salida;
		}

		if(datosEntradaDTO.getImei().length()>25){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10021");
			salida.setDescError("Largo de número de serie mayor a lo permitido.");
			return salida;
		}

		if(datosEntradaDTO.getIndProcedencia().length()>1){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10031");
			salida.setDescError("Largo de indicador de procedencia mayor a lo permitido.");
			return salida;
		}

		if(datosEntradaDTO.getNomUsuario().length()>30){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10041");
			salida.setDescError("Largo de nombre de usuario mayor a lo permitido.");
			return salida;
		}

		if(datosEntradaDTO.getNumCelular().length()>15){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10051");
			salida.setDescError("Largo de número celular mayor a lo permitido.");
			return salida;
		}
		
		if(datosEntradaDTO.getSaldo().length()>255){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10061");
			salida.setDescError("Largo de saldo mayor a lo permitido.");
			return salida;
		}

		return null;
	}
	public WSDatosSalidaDTO validaTipo(WSDatosEntradaDTO datosEntradaDTO){
		WSDatosSalidaDTO salida=null;

		if(!datosEntradaDTO.getIndProcedencia().equals("E")&&!datosEntradaDTO.getIndProcedencia().equals("I")){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10101");
			salida.setDescError("El indicador de procedencia debe ser E o I.");
			return salida;
		}

		if(!isNumeric(datosEntradaDTO.getCodCliente())){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10111");
			salida.setDescError("Formato código cliente erroneo.");
			return salida;
		}

		if(!numerico(datosEntradaDTO.getImei())){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10121");
			salida.setDescError("Formato número serie erroneo.");
			return salida;
		}

		if(!isNumeric(datosEntradaDTO.getNumCelular())){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10131");
			salida.setDescError("Formato número celular erroneo.");
			return salida;
		}
		
		if(!isNumeric(datosEntradaDTO.getSaldo())){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10141");
			salida.setDescError("Formato saldo erroneo.");
			return salida;
		}
		return null;
	}

	public WSDatosSalidaDTO validaNulo(WSDatosEntradaDTO datosEntradaDTO){
		System.out.println("Validando Nulo");
		WSDatosSalidaDTO salida=null;
		if(null==datosEntradaDTO.getCodCliente()){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10201");
			salida.setDescError("Codigo Cliente no debe ser nulo");
			return salida;
		}
		if(null==datosEntradaDTO.getCodPlanTarif()){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10202");
			salida.setDescError("El Código del plan no debe ser nulo.");
			return salida;
		}
		if(null==datosEntradaDTO.getImei()){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10203");
			salida.setDescError("El número de serie no debe ser nulo.");
			return salida;
		}
		if(null==datosEntradaDTO.getIndProcedencia()){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10201");
			salida.setDescError("El indicador de procedencia debe ser E o I.");
			return salida;
		}
		if(null==datosEntradaDTO.getNomUsuario()){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10101");
			salida.setDescError("El nombre usuario no debe ser nulo.");
			return salida;
		}
		if(null==datosEntradaDTO.getNumCelular()){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10101");
			salida.setDescError("El número celular no debe ser nulo.");
			return salida;
		}
		if(null==datosEntradaDTO.getSaldo()){
			salida= new WSDatosSalidaDTO();
			salida.setCodError("10101");
			salida.setDescError("El salo no debe ser nulo.");
			return salida;
		}
		return null;
	}

	private static boolean isNumeric(String cadena){
		try {
			Long.parseLong(cadena);
			return true;
		} catch (NumberFormatException nfe){
			return false;
		}
	}
	
	private static boolean numerico(String cadena){
		String cadena1= cadena.substring(0, cadena.length()/2);
		String cadena2= cadena.substring(cadena.length()/2,cadena.length()-1 );
		
		if(isNumeric(cadena1)&&isNumeric(cadena2)){
			return true;
		}
		
		return false;
	}
}
