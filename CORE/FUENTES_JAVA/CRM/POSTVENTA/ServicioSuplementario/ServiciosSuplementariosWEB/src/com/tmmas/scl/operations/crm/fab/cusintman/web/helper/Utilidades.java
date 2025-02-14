package com.tmmas.scl.operations.crm.fab.cusintman.web.helper;

import java.io.Serializable;

import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoToDTO;
import com.tmmas.scl.operations.frmkooss.web.dto.TiposDescuentoDTO;
import java.util.List; 
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import javax.servlet.http.HttpServletRequest;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ReglasSSDTO;
import java.text.DecimalFormat;

public class Utilidades implements Serializable{

	
	// ----------------------------------------------------------------------------
	// Este metodo devuelve un blanco si el texto de parametro es nulo.
	// Usado en la capa de presentacion para evitarnos comparaciones.
	static public String devuelveBlanco(String texto)	{
		
		if (texto != null)
			if (!texto.equals("null")) return texto;
			else
				return "";
		
		return "";
	}	// devuelveBlanco
	
	// ----------------------------------------------------------------------------
	static public String eliminaCaracterdeCadena(char inVal,String cadena){
		String retValue;
		retValue=cadena.replace(inVal,' ');
		retValue=eliminaEspaciosCadena(retValue);
		return retValue;
	}
	
	static public String eliminaEspaciosCadena(String cadena){
		String retValue="";
		for (int x=0; x < cadena.length(); x++) {
			  if (cadena.charAt(x) != ' ')
				  retValue += cadena.charAt(x);
			}
		return retValue;
	}
	
//	 ---------------------------------------------------------------------------------------------------------------------------------
	
	static public String generaMatrizTipDescMan(HttpServletRequest request)	{
			
		StringBuffer texto = new StringBuffer();
		
    	// Creo el array de los tipos de descuentos manuales
    	List lista = (List) request.getAttribute("tipDescuentosList");
    	TiposDescuentoDTO[] tablaTipDesMan = (TiposDescuentoDTO[])lista.toArray();
    	texto.append("\n <script languaje='javascript'>");
    	texto.append("\n");
    	texto.append("\n tablaTipDesMan = new Array(");

    	for (int desc=0; desc < tablaTipDesMan.length; desc++)	{
    		texto.append("\n ['"+ tablaTipDesMan[desc].getCodTipoDescuento() + "','" + tablaTipDesMan[desc].getDescTipoDescuento() + "']");
        	// Si no es el ultimo elemento le agrego el separador para delimitar el elemento del array
        	if (desc < tablaTipDesMan.length-1) texto.append(",");
    	} // for

    	texto.append(");");
    	texto.append("\n\n </script>");
		
    	return texto.toString();
    	
	} // generaMatrizTipDescMan
		
// ---------------------------------------------------------------------------------------------------------------------------------

	static public String generaMatrizCargos(HttpSession session)	{
		
        TablaCargosDTO [] tablaCargos = null;
    	CargosForm cargosForm = null;
    	StringBuffer texto = new StringBuffer();

    	// El formbean de cargos esta en sesion
    	cargosForm = (CargosForm) session.getAttribute("CargosForm");
    	// Tomo la tabla con todos los cargos que se levantaron en el action
    	tablaCargos = cargosForm.getTablaCargos();
		
		String descAutoManual = new String();
    	String descripcion = new String();
    	String cantidad = new String();
    	String importeTotal = new String();
    	String tipoDescuentoAut = new String();
    	String descuentoUnitarioAut = new String();
    	String txtVecTipDescMan = new String();
    	String saldo = new String();
    	String moneda = new String();
		
    	texto.append("\n <script languaje='javascript'>");
    	texto.append("\n\n tablaCargos = new Array(");
        	for (int fila=0; fila < tablaCargos.length; fila++)	{
	        	// Tipo de descuento, A=Automatico - M=Manual
	        		descAutoManual = tablaCargos[fila].getAutManDes();
	        	// Descripcion del cargo
		        	descripcion = tablaCargos[fila].getDescripcion();
	        	// Cantidad de unidades para este cargo
		        	cantidad = tablaCargos[fila].getCantidad();
	        	// Importe total del cargo
		        	importeTotal = tablaCargos[fila].getImporteTotal();
	        	// Tipo de descuento automatico (porcentaje o monto)
	    	    	tipoDescuentoAut = tablaCargos[fila].getTipoDescuentoAut();
	        	// Valor del descuento automatico 
	    	    	descuentoUnitarioAut = tablaCargos[fila].getDescuentoUnitarioAut();
	        	// Saldo del cargo
	        		saldo = tablaCargos[fila].getSaldo();
	        	// Descripcion de la moneda
        		 	moneda = tablaCargos[fila].getMoneda();
	        
        		 	texto.append("\n ['"+ descAutoManual + "','" + descripcion + "','" + cantidad + "','" + importeTotal + "','" + 
	        	              	tipoDescuentoAut + "','" + descuentoUnitarioAut + "','" + txtVecTipDescMan + "','" + saldo + "','" + moneda + "']");
	        	
	        	// Si no es el ultimo elemento le agrego el separador para delimitar el elemento del array
	        	if (fila < tablaCargos.length-1) texto.append(",");
        	} // for
        texto.append("\n );");
        texto.append("\n\n </script>");
		
        return texto.toString();
        
	} // generaMatrizCargos
	
//---------------------------------------------------------------------------------------------------------------------------------

	static public String pintaTablaCargos(HttpSession session)	{
		
        TablaCargosDTO [] tablaCargos = null;
    	CargosForm cargosForm = null;
    	StringBuffer texto = new StringBuffer();

    	// El formbean de cargos esta en sesion
    	cargosForm = (CargosForm) session.getAttribute("CargosForm");
    	// Tomo la tabla con todos los cargos que se levantaron en el action
    	tablaCargos = cargosForm.getTablaCargos();
    
    	// Recorro la tabla para armar la tabla de cargos para visualizarla
        for (int fila=0; fila < tablaCargos.length; fila++)	{
        	texto.append("\n <tr>");        		
        	texto.append("\n <td class='textoFilasTabla'>");
        	texto.append("\n <input type='checkbox' name='selectedValorCheck' id='selectedValorCheck" + String.valueOf(fila) + "'");
        	texto.append("\n </td>");
        	
        	texto.append("\n <td class='textoFilasTabla'>" + tablaCargos[fila].getAutManDes());
        	texto.append("\n <td class='textoFilasTabla'>" + tablaCargos[fila].getDescripcion());
        	texto.append("\n <td class='textoDerechaFilasTabla'>" + tablaCargos[fila].getCantidad());
        	texto.append("\n 	<input type='hidden' name='importeTotalOriginal'>");
        	texto.append("\n 	<input type='hidden' name='tipoDescuentoOriginal' id='tipoDescuentoOriginal'>");
        	texto.append("\n </td>");
        	
    	} // for
    	
    	return texto.toString();
        
	} // pintaTablaCargos

//	---------------------------------------------------------------------------------------------------------------------------------	
	
	static public String generaMatricesServSup(HttpServletRequest request)	{
		
		StringBuffer texto = new StringBuffer();
		
		texto.append("\n\n // guarda el numero de la fila para despues volver al color original");
		texto.append("\n var filaSel = 0;");
		texto.append("\n// Armado on the fly de la matriz de reglas de validacion");
		texto.append("\nreglas = new Array(");

		ReglasSSDTO listaReglas[] = null;
		try	{
			listaReglas = (ReglasSSDTO[]) request.getAttribute("reglasValidacion");
			
			for (int fila=0; fila < listaReglas.length; fila++)	{
				texto.append("['" + Utilidades.devuelveBlanco(listaReglas[fila].getCodServicio()) + "','" + String.valueOf(listaReglas[fila].getTipoRelacion()) + "','" +  Utilidades.devuelveBlanco(listaReglas[fila].getCodServDef()) + "']");
				if (fila < listaReglas.length-1) texto.append(",");
			} // for
		} // try
		catch(Exception ex)	{
		}
	
		texto.append(");");		
		
		// ------------------------------------------------------------------------------------------------------------------------
	
		texto.append("\n// Armado on the fly de la matriz");
		texto.append("\nlistaServiciosAct = new Array(");

		SSuplementarioDTO listaAct[] = null;
		try	{
			listaAct = (SSuplementarioDTO[]) request.getAttribute("listaServiciosAct");
			
			for (int fila=0; fila < listaAct.length; fila++)	{
				texto.append("['" + Utilidades.devuelveBlanco(listaAct[fila].getCod_servicio()) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaAct[fila].getCod_servsupl())) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaAct[fila].getCod_nivel())) + "']");
				if (fila < listaAct.length-1) texto.append(",");
			} // for
		} // try
		catch(Exception ex)	{
		}
		
		texto.append(");");		

		// ------------------------------------------------------------------------------------------------------------------------
		
		texto.append("\n// Armado on the fly de la matriz");
		texto.append("\nlistaServiciosDef = new Array(");

		SSuplementarioDTO listaDef[] = null;
		try	{
			listaDef = (SSuplementarioDTO[]) request.getAttribute("listaServiciosDef");
			
			for (int fila=0; fila < listaDef.length; fila++)	{
				texto.append("['" + Utilidades.devuelveBlanco(listaDef[fila].getCod_servicio()) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaDef[fila].getCod_servsupl())) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaDef[fila].getCod_nivel())) + "']");
				if (fila < listaDef.length-1) texto.append(",");
			} // for
		} // try
		catch(Exception ex)	{
		}
		
		texto.append(");");		

		// ------------------------------------------------------------------------------------------------------------------------

		texto.append("\n\n\n");
		texto.append("\n// Armado on the fly de la matriz");
		texto.append("\nlistaServiciosDisp = new Array(");

		SSuplementarioDTO listaDisp[] = null;
		try	{
			listaDisp = (SSuplementarioDTO[]) request.getAttribute("listaServiciosDisp");
			
			for (int fila=0; fila < listaDisp.length; fila++)	{
				texto.append("['" + Utilidades.devuelveBlanco(listaDisp[fila].getCod_servicio()) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaDisp[fila].getCod_servsupl())) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaDisp[fila].getCod_nivel())) + "']" );
				if (fila < listaDisp.length-1) texto.append(",");
			} // for
		} // try
		catch(Exception ex)	{
		}
			
		texto.append(");");		

		// ------------------------------------------------------------------------------------------------------------------------
		
		texto.append("\n\n\n");
		texto.append("\n// Armado on the fly de la matriz de todos los servicios para la verificacion de grupo");
		texto.append("\nlistaTodosServicios = new Array(");

		try	{
			for (int fila=0; fila < listaAct.length; fila++)	{
				texto.append("['" + Utilidades.devuelveBlanco(listaAct[fila].getCod_servicio()) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaAct[fila].getCod_servsupl())) + "','A','" +  Utilidades.devuelveBlanco(String.valueOf(listaAct[fila].getDes_servicio())) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaAct[fila].getCod_nivel())) + "']" );
				if (fila < listaAct.length-1) texto.append(",");
			} // for
	
			for (int fila=0; fila < listaDisp.length; fila++)	{
				// Agrega un separador de elemento para continuar con los elementos del otro for
				if ((fila==0) && (listaAct.length >0))
					texto.append(",");
				
				texto.append("['" + Utilidades.devuelveBlanco(listaDisp[fila].getCod_servicio()) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaDisp[fila].getCod_servsupl())) + "','D','" +  Utilidades.devuelveBlanco(String.valueOf(listaDisp[fila].getDes_servicio())) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaDisp[fila].getCod_nivel())) + "']" );
				if (fila < listaDisp.length-1) texto.append(",");
			} // for
		} // try
		catch(Exception ex)	{
		}
	
		texto.append(");");		
		
    	return texto.toString();
    	
	} // generaMatricesServSup
	
//	---------------------------------------------------------------------------------------------------------------------------------

	static public String generaTablaServDisp(HttpServletRequest request)	{
		
	StringBuffer texto = new StringBuffer();
	try{
		
		HttpSession session = request.getSession(false);
		
		String parametroDecimal = String.valueOf(session.getAttribute("parametroDecimal"));
		String patron= getNumeroDecimales(parametroDecimal);
		
		SSuplementarioDTO listaServiciosDisp[] = null;
		listaServiciosDisp = (SSuplementarioDTO[]) request.getAttribute("listaServiciosDisp");

		texto.append("\n <input type='hidden' id='lengthServDisp' name='lengthServDisp' value='" + String.valueOf(listaServiciosDisp.length) + "'/>");
		
		DecimalFormat twoPlaces = new DecimalFormat("0." + rep('0',  Integer.parseInt(parametroDecimal) ));
		 
		String tarifass = new String();
		String tarifafa = new String();
		
		for (int cont=0; cont < listaServiciosDisp.length; cont++)	{
			/*tarifass = twoPlaces.format(listaServiciosDisp[cont].getImp_tarifa_ss());
			tarifafa = twoPlaces.format(listaServiciosDisp[cont].getImp_tarifa_fa());*/
			tarifass=getFormatoDecimal(listaServiciosDisp[cont].getImp_tarifa_ss(),patron);
			tarifafa=getFormatoDecimal(listaServiciosDisp[cont].getImp_tarifa_fa(),patron);
			texto.append("\n <tr class='textoFilasTabla' id='fila" + String.valueOf(cont) + "TblServDisp'>");
			texto.append("\n 	<td id='col1fila" + String.valueOf(cont) + "TblServDisp'><center><input type=checkbox onclick=\"clickServicio('D',this)\" name='idSelDisp" + String.valueOf(cont) + "' value='" + listaServiciosDisp[cont].getCod_servicio() + "'/></center></td>");
			texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDisp[cont].getCod_servicio())) + "</td>");
			texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDisp[cont].getCod_servsupl())) + "</td>");                    
			texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDisp[cont].getCod_nivel())) + "</td>");                             
			texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosDisp[cont].getDes_servicio()) + "</td>");
			texto.append("\n      <td class='textoDerechaFilasTabla'> &nbsp;&nbsp;&nbsp;" + tarifass + "</td>");
			texto.append("\n      <td class='textoDerechaFilasTabla'> &nbsp;&nbsp;&nbsp;" + tarifafa + "</td>");
			texto.append("\n </tr>");
		} // for
	}
	catch(Exception e){
		e.printStackTrace();
		
	}
		
    	return texto.toString();
    	
	} // generaTablaServDisp
	
//	---------------------------------------------------------------------------------------------------------------------------------

	static public String generaTablaServAct(HttpServletRequest request)	{
		
		StringBuffer texto = new StringBuffer();
		HttpSession session = request.getSession(false);
		
		String parametroDecimal = String.valueOf(session.getAttribute("parametroDecimal"));
		String patron= getNumeroDecimales(parametroDecimal);
		SSuplementarioDTO listaServiciosAct[] = null;
		listaServiciosAct = (SSuplementarioDTO[]) request.getAttribute("listaServiciosAct");
	
		DecimalFormat twoPlaces = new DecimalFormat("0." + rep('0',  Integer.parseInt(parametroDecimal) ));
		 
		String tarifass = new String();
		String tarifafa = new String();

		texto.append("\n <input type='hidden' id='lengthServAct' name='lengthServAct' value='" + String.valueOf(listaServiciosAct.length) + "'/>");
		
		for (int cont=0; cont < listaServiciosAct.length; cont++)	{
			/*tarifass = twoPlaces.format(listaServiciosAct[cont].getImp_tarifa_ss());
			tarifafa = twoPlaces.format(listaServiciosAct[cont].getImp_tarifa_fa());*/
			tarifass=getFormatoDecimal(listaServiciosAct[cont].getImp_tarifa_ss(),patron);
			tarifafa=getFormatoDecimal(listaServiciosAct[cont].getImp_tarifa_fa(),patron);
			
			texto.append("\n <tr class='textoFilasTabla'>");
			texto.append("\n <td><center><input type=checkbox checked onclick=\"clickServicio('A',this)\"  name='idSelAct" + String.valueOf(cont) + "' value='" + listaServiciosAct[cont].getCod_servicio() + "'/></center></td>");
			texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosAct[cont].getCod_servicio())) + "</td>");
			texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosAct[cont].getCod_servsupl())) + "</td>");
			texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosAct[cont].getCod_nivel())) + "</td>");                                                 
			texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosAct[cont].getDes_servicio()) + "</td>");
			texto.append("\n    <td class='textoDerechaFilasTabla'> &nbsp;&nbsp;&nbsp;" + tarifass + "</td>");
			texto.append("\n    <td class='textoDerechaFilasTabla'> &nbsp;&nbsp;&nbsp;" + tarifass + "</td>");

			texto.append("\n </tr>");
		} // for
		
    	return texto.toString();
    	
	} // generaTablaServAct
	
//	---------------------------------------------------------------------------------------------------------------------------------

	static public String generaTablaServDefault(HttpServletRequest request)	{
		
		StringBuffer texto = new StringBuffer();
		HttpSession session = request.getSession(false);
		SSuplementarioDTO listaServiciosDef[] = null;
		listaServiciosDef = (SSuplementarioDTO[]) request.getAttribute("listaServiciosDef");
		String parametroDecimal = String.valueOf(session.getAttribute("parametroDecimal"));
		String patron= getNumeroDecimales(parametroDecimal);
		
	
		for (int cont=0; cont < listaServiciosDef.length; cont++)	{
			String tarifass=getFormatoDecimal(listaServiciosDef[cont].getImp_tarifa_ss(),patron);
			String tarifafa=getFormatoDecimal(listaServiciosDef[cont].getImp_tarifa_fa(),patron);
			texto.append("\n <tr class='textoFilasTabla'>");
			texto.append("\n <td><center><input type=checkbox checked=checked disabled=disabled></center></td>");
			texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDef[cont].getCod_servicio())) + "</td>");
			texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDef[cont].getCod_servsupl())) + "</td>");
			texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDef[cont].getCod_nivel())) + "</td>");                                                 
			texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosDef[cont].getDes_servicio()) + "</td>");
			texto.append("\n    <td class='textoDerechaFilasTabla'> &nbsp;&nbsp;&nbsp;" + tarifass+ "</td>");
			texto.append("\n    <td class='textoDerechaFilasTabla'> &nbsp;&nbsp;&nbsp;" + tarifafa+ "</td>");

			texto.append("\n </tr>");
		} // for
		
    	return texto.toString();
    	
	} // generaTablaServAct
	
//	---------------------------------------------------------------------------------------------------------------------------------
//	HGG 26/06/08	
	static public String generaTablaservBBContratados(HttpServletRequest request)	{
		
		StringBuffer texto = new StringBuffer();
		SSuplementarioDTO[] servBBContratados = (SSuplementarioDTO[])request.getAttribute("servBBContratados");

		if (request.getAttribute("tieneServBBContratados").toString().equals("SI"))	{
			texto.append("servBBContratados = new Array(");

				for (int fila=0; fila < servBBContratados.length; fila++)	{
					texto.append("'" + servBBContratados[fila].getCod_servicio() + "'");
					if (fila < servBBContratados.length-1) texto.append(",");
				} // for

			texto.append(");");
		} // if
	
    	return texto.toString();
    	
	} // generaTablaservBBContratados
	
//	---------------------------------------------------------------------------------------------------------------------------------
	public final static String rep ( char c, int count )
	{
	char[] s = new char[ count ];
	for ( int i = 0; i < count; i++ )
	{
	s[ i ] = c;
	}
	return new String( s ).intern();
	} // end rep
	
//	---------------------------------------------------------------------------------------------------------------------------------
	private final static String getFormatoDecimal(float importe, String patron){
		String retValue=null;
		
		
		try{
			DecimalFormat df= new DecimalFormat(patron);
			retValue=df.format(Double.parseDouble(String.valueOf(importe)));
			
		}
		catch(Exception e){
			e.printStackTrace();
			retValue="0.00";
		}
		return retValue;
	}
	private final static String getNumeroDecimales(String numDecimales){
		String patron="0.";
		int posiciones=Integer.parseInt(numDecimales);
		for (int i=0;i<posiciones;i++)
		{
			patron=patron+"0";
		}
		return patron;
	}
}	
