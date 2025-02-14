package com.tmmas.cl.scl.portalventas.web.helper;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ReglaSSDTO;

public class Utilidades implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(Utilidades.class);

	// ----------------------------------------------------------------------------
	// Este metodo devuelve un blanco si el texto de parametro es nulo.
	// Usado en la capa de presentacion para evitarnos comparaciones.
	static public String devuelveBlanco(String texto) {

		if (texto != null)
			if (!texto.equals("null"))
				return texto;
			else
				return "";

		return "";
	} // devuelveBlanco

	// ----------------------------------------------------------------------------
	static public String eliminaCaracterdeCadena(char inVal, String cadena) {
		String retValue;
		retValue = cadena.replace(inVal, ' ');
		retValue = eliminaEspaciosCadena(retValue);
		return retValue;
	}

	static public String eliminaEspaciosCadena(String cadena) {
		String retValue = "";
		for (int x = 0; x < cadena.length(); x++) {
			if (cadena.charAt(x) != ' ')
				retValue += cadena.charAt(x);
		}
		return retValue;
	}

	//	 ---------------------------------------------------------------------------------------------------------------------------------

	static public String generaMatrizTipDescMan(HttpServletRequest request) {

		StringBuffer texto = new StringBuffer();

		// Creo el array de los tipos de descuentos manuales
		List lista = (List) request.getAttribute("tipDescuentosList");
		//TiposDescuentoDTO[] tablaTipDesMan = (TiposDescuentoDTO[])lista.toArray();    	
		texto.append("\n <script languaje='javascript'>");
		texto.append("\n");
		texto.append("\n tablaTipDesMan = new Array(");

		/*for (int desc=0; desc < tablaTipDesMan.length; desc++)	{
		 texto.append("\n ['"+ tablaTipDesMan[desc].getCodTipoDescuento() + "','" + tablaTipDesMan[desc].getDescTipoDescuento() + "']");
		 // Si no es el ultimo elemento le agrego el separador para delimitar el elemento del array
		 if (desc < tablaTipDesMan.length-1) texto.append(",");
		 } // for*/

		texto.append(");");
		texto.append("\n\n </script>");

		return texto.toString();

	} // generaMatrizTipDescMan

	// ---------------------------------------------------------------------------------------------------------------------------------

	static public String generaMatrizCargos(HttpSession session) {

		StringBuffer texto = new StringBuffer();
		/* TablaCargosDTO [] tablaCargos = null;
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
		 texto.append("\n\n </script>");*/

		return texto.toString();

	} // generaMatrizCargos

	//---------------------------------------------------------------------------------------------------------------------------------

	static public String pintaTablaCargos(HttpSession session) {

		StringBuffer texto = new StringBuffer();

		/*     TablaCargosDTO [] tablaCargos = null;
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
		 texto.append("\n <td class='textoFilasTabla' style='text-align:right;'>" + tablaCargos[fila].getCantidad());
		 texto.append("\n 	<input type='hidden' name='importeTotalOriginal'>");
		 texto.append("\n 	<input type='hidden' name='tipoDescuentoOriginal' id='tipoDescuentoOriginal'>");
		 texto.append("\n </td>");
		 
		 } // for*/

		return texto.toString();

	} // pintaTablaCargos

	//	---------------------------------------------------------------------------------------------------------------------------------	

	static public String generaMatricesServSup(HttpServletRequest request) {

		StringBuffer texto = new StringBuffer();

		texto.append("\n\n // guarda el numero de la fila para despues volver al color original");
		texto.append("\n var filaSel = 0;");
		texto.append("\n// Armado on the fly de la matriz de reglas de validacion");
		texto.append("\nreglas = new Array(");

		ReglaSSDTO listaReglas[] = null;
		try {
			listaReglas = (ReglaSSDTO[]) request.getAttribute("reglasValidacion");

			for (int fila = 0; fila < listaReglas.length; fila++) {
				texto.append("['" + Utilidades.devuelveBlanco(listaReglas[fila].getCodServicio()) + "','"
						+ String.valueOf(listaReglas[fila].getTipoRelacion()) + "','"
						+ Utilidades.devuelveBlanco(listaReglas[fila].getCodServDef()) + "']");
				if (fila < listaReglas.length - 1)
					texto.append(",");
			} // for
		} // try
		catch (Exception ex) {
		}

		//texto.append("['" + Utilidades.devuelveBlanco("01") + "','" + String.valueOf("R1") + "','" +  Utilidades.devuelveBlanco("02") + "']");

		texto.append(");");
		System.out.println("texto:" + texto);

		// ------------------------------------------------------------------------------------------------------------------------

		//texto.append("\n// Armado on the fly de la matriz");
		//texto.append("\nlistaServiciosAct = new Array(");

		/*SSuplementarioDTO listaAct[] = null;
		 try	{
		 listaAct = (SSuplementarioDTO[]) request.getAttribute("listaServiciosAct");
		 
		 for (int fila=0; fila < listaAct.length; fila++)	{
		 texto.append("['" + Utilidades.devuelveBlanco(listaAct[fila].getCod_servicio()) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaAct[fila].getCod_servsupl())) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaAct[fila].getCod_nivel())) + "']");
		 if (fila < listaAct.length-1) texto.append(",");
		 } // for
		 } // try
		 catch(Exception ex)	{
		 }*/

		/*		texto.append("['" + Utilidades.devuelveBlanco("02") + "','" + Utilidades.devuelveBlanco(String.valueOf("01")) + "','" + Utilidades.devuelveBlanco(String.valueOf("02")) + "']");
		 
		 texto.append(");");		

		 // ------------------------------------------------------------------------------------------------------------------------
		 
		 texto.append("\n// Armado on the fly de la matriz");
		 texto.append("\nlistaServiciosDef = new Array(");*/

		/*SSuplementarioDTO listaDef[] = null;
		 try	{
		 listaDef = (SSuplementarioDTO[]) request.getAttribute("listaServiciosDef");
		 
		 for (int fila=0; fila < listaDef.length; fila++)	{
		 texto.append("['" + Utilidades.devuelveBlanco(listaDef[fila].getCod_servicio()) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaDef[fila].getCod_servsupl())) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaDef[fila].getCod_nivel())) + "']");
		 if (fila < listaDef.length-1) texto.append(",");
		 } // for
		 } // try
		 catch(Exception ex)	{
		 }*/

		/*texto.append(");");		

		 // ------------------------------------------------------------------------------------------------------------------------

		 texto.append("\n\n\n");
		 texto.append("\n// Armado on the fly de la matriz");
		 texto.append("\nlistaServiciosDisp = new Array(");*/

		/*SSuplementarioDTO listaDisp[] = null;
		 try	{
		 listaDisp = (SSuplementarioDTO[]) request.getAttribute("listaServiciosDisp");
		 
		 for (int fila=0; fila < listaDisp.length; fila++)	{
		 texto.append("['" + Utilidades.devuelveBlanco(listaDisp[fila].getCod_servicio()) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaDisp[fila].getCod_servsupl())) + "','" + Utilidades.devuelveBlanco(String.valueOf(listaDisp[fila].getCod_nivel())) + "']" );
		 if (fila < listaDisp.length-1) texto.append(",");
		 } // for
		 } // try
		 catch(Exception ex)	{
		 }*/

		/*texto.append(");");		

		 // ------------------------------------------------------------------------------------------------------------------------
		 
		 texto.append("\n\n\n");
		 texto.append("\n// Armado on the fly de la matriz de todos los servicios para la verificacion de grupo");
		 texto.append("\nlistaTodosServicios = new Array(");*/

		/*try	{
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
		 }*/

		//texto.append(");");		
		return texto.toString();

	} // generaMatricesServSup

	//	---------------------------------------------------------------------------------------------------------------------------------

	static public String generaTablaServDisp(HttpServletRequest request) {

		StringBuffer texto = new StringBuffer();

		//	SSuplementarioDTO listaServiciosDisp[] = null;
		//listaServiciosDisp = (SSuplementarioDTO[]) request.getAttribute("listaServiciosDisp");

		//texto.append("\n <input type='hidden' id='lengthServDisp' name='lengthServDisp' value='" + String.valueOf(listaServiciosDisp.length) + "'/>");

		//for (int cont=0; cont < listaServiciosDisp.length; cont++)	{
		/*texto.append("\n <tr class='textoFilasTabla' id='fila" + String.valueOf(cont) + "TblServDisp'>");
		 texto.append("\n 	<td id='col1fila" + String.valueOf(cont) + "TblServDisp'><center><input type=checkbox onclick=\"clickServicio('D',this)\" name='idSelDisp" + String.valueOf(cont) + "' value='" + listaServiciosDisp[cont].getCod_servicio() + "'/></center></td>");
		 texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDisp[cont].getCod_servicio())) + "</td>");
		 texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDisp[cont].getCod_servsupl())) + "</td>");                    
		 texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDisp[cont].getCod_nivel())) + "</td>");                             
		 texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosDisp[cont].getDes_servicio()) + "</td>");
		 texto.append("\n      <td class='textoFilasTabla' align='center'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDisp[cont].getImp_tarifa_ss())) + "</td>");
		 texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosDisp[cont].getDes_moneda_ss()) + "</td>");			
		 texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDisp[cont].getImp_tarifa_fa())) + "</td>");
		 texto.append("\n      <td class='textoFilasTabla' align='center'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosDisp[cont].getDes_moneda_fa()) + "</td>");
		 texto.append("\n </tr>");*/
		//} // for
		texto.append("\n <tr class='textoFilasTabla' id='fila" + String.valueOf(1) + "TblServDisp'>");
		texto.append("\n 	<td id='col1fila" + String.valueOf(1)
				+ "TblServDisp'><center><input type=checkbox onclick=\"clickServicio('D',this)\" name='idSelDisp"
				+ String.valueOf(1) + "' value='" + "01" + "'/></center></td>");
		texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco(String.valueOf("01")) + "</td>");
		texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco(String.valueOf("02")) + "</td>");
		texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco(String.valueOf("03")) + "</td>");
		texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco("des")
				+ "</td>");
		texto.append("\n      <td class='textoFilasTabla' align='center'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco(String.valueOf("1000")) + "</td>");
		texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco("des moneda") + "</td>");
		texto.append("\n      <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco(String.valueOf("2000")) + "</td>");
		texto.append("\n      <td class='textoFilasTabla' align='center'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco("des moneda") + "</td>");
		texto.append("\n </tr>");

		return texto.toString();

	} // generaTablaServDisp

	//	---------------------------------------------------------------------------------------------------------------------------------

	static public String generaTablaServAct(HttpServletRequest request) {

		StringBuffer texto = new StringBuffer();

		/*	SSuplementarioDTO listaServiciosAct[] = null;
		 listaServiciosAct = (SSuplementarioDTO[]) request.getAttribute("listaServiciosAct");
		 
		 texto.append("\n <input type='hidden' id='lengthServAct' name='lengthServAct' value='" + String.valueOf(listaServiciosAct.length) + "'/>");
		 
		 for (int cont=0; cont < listaServiciosAct.length; cont++)	{
		 texto.append("\n <tr class='textoFilasTabla'>");
		 texto.append("\n <td><center><input type=checkbox checked onclick=\"clickServicio('A',this)\"  name='idSelAct" + String.valueOf(cont) + "' value='" + listaServiciosAct[cont].getCod_servicio() + "'/></center></td>");
		 texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosAct[cont].getCod_servicio())) + "</td>");
		 texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosAct[cont].getCod_servsupl())) + "</td>");
		 texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosAct[cont].getCod_nivel())) + "</td>");                                                 
		 texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosAct[cont].getDes_servicio()) + "</td>");
		 texto.append("\n    <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosAct[cont].getImp_tarifa_ss())) + "</td>");
		 texto.append("\n    <td class='textoFilasTabla' align='center'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosAct[cont].getDes_moneda_ss()) + "</td>");			
		 texto.append("\n    <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosAct[cont].getImp_tarifa_fa())) + "</td>");
		 texto.append("\n    <td class='textoFilasTabla' align='center'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosAct[cont].getDes_moneda_fa()) + "</td>");

		 texto.append("\n </tr>");
		 } // for*/

		return texto.toString();

	} // generaTablaServAct

	//	---------------------------------------------------------------------------------------------------------------------------------

	static public String generaTablaServDefault(HttpServletRequest request) {

		StringBuffer texto = new StringBuffer();

		/*SSuplementarioDTO listaServiciosDef[] = null;
		 listaServiciosDef = (SSuplementarioDTO[]) request.getAttribute("listaServiciosDef");
		 
		 for (int cont=0; cont < listaServiciosDef.length; cont++)	{
		 texto.append("\n <tr class='textoFilasTabla'>");
		 texto.append("\n <td><center><input type=checkbox checked=checked disabled=disabled></center></td>");
		 texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDef[cont].getCod_servicio())) + "</td>");
		 texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDef[cont].getCod_servsupl())) + "</td>");
		 texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDef[cont].getCod_nivel())) + "</td>");                                                 
		 texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosDef[cont].getDes_servicio()) + "</td>");
		 texto.append("\n    <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDef[cont].getImp_tarifa_ss())) + "</td>");
		 texto.append("\n    <td class='textoFilasTabla' align='center'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosDef[cont].getDes_moneda_ss()) + "</td>");			
		 texto.append("\n    <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(String.valueOf(listaServiciosDef[cont].getImp_tarifa_fa())) + "</td>");
		 texto.append("\n    <td class='textoFilasTabla' align='center'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco(listaServiciosDef[cont].getDes_moneda_fa()) + "</td>");

		 texto.append("\n </tr>");
		 } // for*/

		texto.append("\n <tr class='textoFilasTabla'>");
		texto.append("\n <td><center><input type=checkbox checked=checked disabled=disabled></center></td>");
		texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco(String.valueOf("02")) + "</td>");
		texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco(String.valueOf("02")) + "</td>");
		texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco(String.valueOf("03")) + "</td>");
		texto.append("\n 	<td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;" + Utilidades.devuelveBlanco("des servicio")
				+ "</td>");
		texto.append("\n    <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco(String.valueOf("1000")) + "</td>");
		texto.append("\n    <td class='textoFilasTabla' align='center'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco("des moneda") + "</td>");
		texto.append("\n    <td class='textoFilasTabla'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco(String.valueOf("2000")) + "</td>");
		texto.append("\n    <td class='textoFilasTabla' align='center'> &nbsp;&nbsp;&nbsp;"
				+ Utilidades.devuelveBlanco("des moneda") + "</td>");

		texto.append("\n </tr>");

		return texto.toString();

	} // generaTablaServAct

	//	---------------------------------------------------------------------------------------------------------------------------------
	//	HGG 26/06/08	
	static public String generaTablaservBBContratados(HttpServletRequest request) {

		StringBuffer texto = new StringBuffer();
		/*SSuplementarioDTO[] servBBContratados = (SSuplementarioDTO[])request.getAttribute("servBBContratados");

		 if (request.getAttribute("tieneServBBContratados").toString().equals("SI"))	{
		 texto.append("servBBContratados = new Array(");

		 for (int fila=0; fila < servBBContratados.length; fila++)	{
		 texto.append("'" + servBBContratados[fila].getCod_servicio() + "'");
		 if (fila < servBBContratados.length-1) texto.append(",");
		 } // for

		 texto.append(");");
		 } // if*/

		return texto.toString();

	} // generaTablaservBBContratados

	public static boolean emptyOrNull(String v) {
		if (v == null || v.trim().equals("")) {
			return true;
		}
		return false;
	}

	public static boolean emptyOrNull(Date v) {
		if (v == null) {
			return true;
		}
		return false;
	}

	public static boolean notEmpty(String v) {
		return !emptyOrNull(v);
	}

	public static String concatenar(String s1, String s2) {
		StringBuffer b = new StringBuffer();
		if (!Utilidades.emptyOrNull(s1)) {
			b.append(s1);
		}
		if (!Utilidades.emptyOrNull(s2)) {
			b.append(" ");
			b.append(s2);
		}
		return b.toString();
	}

	public static String concatenar(String s1, String s2, String s3) {
		return concatenar(concatenar(s1, s2), s3);
	}

	public static ArrayList getArrayRangoInclusiveHasta(int desde, int hasta) {
		if (desde > hasta) {
			return null;
		}
		int rango = hasta - desde + 1;
		ArrayList r = new ArrayList();
		for (int i = 0; i < rango; i++) {
			r.add(new Integer(i + desde).toString());
		}
		return r;
	}

	public static ArrayList getRangoMeses() {
		return getArrayRangoInclusiveHasta(1, 12);
	}

	public static ArrayList getRangoAnios() {
		final Calendar hoy = Calendar.getInstance();
		return getArrayRangoInclusiveHasta(hoy.get(Calendar.YEAR), hoy.get(Calendar.YEAR) + 20);
	}

	private static String capitalizarPalabra(String s) {
		if (s.length() == 0)
			return s;
		return s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
	}

	public static String capitalizar(String s) {
		StringBuffer b = new StringBuffer();
		final String[] words = s.split("\\s");
		for (int i = 0; i < words.length; i++) {
			String string = words[i];
			b.append(capitalizarPalabra(string));
			if (i < words.length - 1) {
				b.append(" ");
			}
		}
		return b.toString();
	}

	/**
	 * @author JIB
	 * @param formFile
	 * @param bytes
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static void grabarArchivo(byte[] bytes, String nombreArchivo) throws FileNotFoundException, IOException {
		logger.info("grabarArchivo, inicio");
		logger.debug("nombreArchivo [" + nombreArchivo + "]");
		File f = new File(nombreArchivo);
		FileOutputStream fis = new FileOutputStream(f);
		fis.write(bytes);
		fis.flush();
		fis.close();
		logger.info("grabarArchivo, fin");
	}

	/**
	 * @author JIB
	 * @param nombreArchivo
	 * @return
	 * 
	 */
	public static boolean borrarArchivo(String nombreArchivo) {
		logger.info("borrarArchivo, inicio");
		logger.debug("nombreArchivo [" + nombreArchivo + "]");
		boolean r = false;
		File f = new File(nombreArchivo);
		r = f.delete();
		logger.info("borrarArchivo, fin");
		return r;
	}

} 
