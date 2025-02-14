<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<body >

   <div id="div911" style="display:none;">
	
	<table id="tbleBody" width="100%">
      <td colspan="2">
      <table width="100%">
      	<tr>
      		<td class="amarillo" >
      			<h1><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
	       	Datos Adicionales de Contacto
      			</h1>
      			
      		</td>
      	</tr>
      </table>
      <fieldset style="border: 1px solid rgb(0, 0, 160);">
      		
      		    <legend class="textoSubTitulo">
      		    	Informaci&oacute;n Adicional de Contacto </legend>
      		  <table  width="100%" >  
      		    <tbody>
      		       <td width="70%">
      		    	 <p>
      		    	 	</p><fieldset style="border: 1px solid rgb(0, 0, 160);">
      		    	 	 <legend>Personal</legend>
      		    	 	    <table > 
	      		    	 	    <tr>
			      		    	   <td width="5%" align="right" >Nombres:</td>
			      		    	   <td width="5%" align="left" class="textointroblanco"><html:text    property="nombreContacto" ></html:text></td>
			      		    	   <td width="25%" align="right" >Primer Apellido:</td>
								   <td width="5%" align="left class="textointroblanco""><html:text   property="apellido1Contacto" ></html:text></td>
								   <td width="25%" align="right" >Segundo Apellido:</td>
								   <td width="5%" align="left class="textointroblanco""><html:text   property="apellido2Contacto" ></html:text></td>
								
			      		    	  </tr>
			      		    	 <tr>
			      		    	 <td align="right" width="20%">N&deg; Contacto:</td>
					       			<td align="left"  width="5%" class="textointroblanco"><html:text   property="numContacto" ></html:text></td>
			      		    		
								   <td width="20%" align="right" >Parentesco:</td>
					       			<td width="15%" align="left class="textointroblanco""><html:text   property="parentesco" ></html:text></td>
								</tr>
								
								
      		    	 	    </table>
      		    	 	</fieldset>
      		       </td>
				   <td width="10%">
      		    	 <p>
      		    	 	</p><fieldset style="border: 1px solid rgb(0, 0, 160);">
      		    	 	 <legend>Direcci&oacute;n</legend>
      		    	 	    <table  > 
      		    	 	    	<tr>
					       			<td width="50%" align="right" >Tipo:</td>
					       			<td width="50%" align="left"><html:select property="codTipDireccion"  onchange="openwindowDireccion()">
					       										      <option value="">
																		<logic:iterate name="tipoDireccionLista" id="codTipDireccion" scope="request" type="com.tmmas.cl.scl.ss911correofax.dto.TipDireccion911CorreoFaxDTO">
																				<html:option value=""><bean:write name="codTipDireccion" property="desTipDireccion"/></html:option>
																		</logic:iterate>
						       										  </html:select>
					       										   </td>
					       		</tr>
					       		<tr>
					       			<td width="50%" align="right" >C&oacute;digo:</td>
					       			<td width="50%" align="left" class="textointroblanco"><html:text tabindex="1"  property="codDireccion" ></html:text></td>
					       		</tr>
					       		
      		    	 	    </table>
      		    	 	</fieldset>
      		    	</td>	
      		    
				   <td width="20%">
      		    	  <p>
      		    	 	</p><fieldset style="border: 1px solid rgb(0, 0, 160);">
      		    	 	 <legend>Veh&iacute;culo</legend>
      		    	 	    <table> 
      		    	 	        
      		    	 	        <tr>
					       			<td width="10%" align="right" >Placa:</td>
					       			<td width="10%" align="left" class="textointroblanco"><html:text maxlength="6"   property="placaVehicular" ></html:text></td>
					       			<td width="10%" align="right" >A&ntilde;o:</td>
					       			<td width="2%" align="left" class="textointroblanco"><html:text  maxlength="4"  property="anioVehiculo" onkeypress="onlyInteger();" ></html:text></td>
					       		
					       		</tr>
					       		<tr> 
					       			<td width="10%" align="right" >Color:</td>
					       			<td width="10%" align="left" class="textointroblanco"><html:text   property="colorVehiculo" ></html:text></td>
					       		</tr>
					       		
					       		
      		    	 	    </table>
      		    	 	    
      		    	 	</fieldset>
      		    	 	
      		    	 	
      		    	</td>
      		    	<tr>
      		    	   <td> </td> 
      		    	  <td colspan="2">
      		    	  <p>
      		    	 	</p><fieldset style="border: 1px solid rgb(0, 0, 160);">
      		    	 	 <legend>Observaciones</legend>
      		    	 	    <table> 
      		    	 	        
      		    	 	        <tr>
					       			
					       			<td width="100%" align="justify"><html:textarea   rows ="2%"cols="100%"   property="observacion" ></html:textarea></td>
					       		
					       		</tr>
					       		
					       		
					       		
      		    	 	    </table>
      		    	 	    
      		    	 	</fieldset>
      		    	 	
      		    	 	
      		    	</td>
      		    	</tr>
      		    	<p></p>	
      		    </tbody>
      		    
      		    	    
      		 </table>   
      		 
     </fieldset>
      
    
     <p></p>
      
      	<table width="100%" >
      	
      		<tr>
      		  
      			
      			<td colspan="1" class="amarillo">
      					 <table width="100%"  id="tablaVisualizacion" border="0">
      					 	
					       	<thead id="idTHeadListar" align="center" class="textoColumnaTabla" >
					       		<td>Item </td>
					       		<td>Nombres </td>
					       		<td>Apellidos </td>
					       		<td>Parentesco</td>
					       		<td>N&uacute;mero  </td>
					       		<td>Tipo </td>
					       		<td>C&oacute;digo </td>
					       		<td>Placa  </td>
					       		<td>Color</td>
					       		<td>A&ntilde;o</td>
					       		<td>Observaci&oacute;n</td>
					       	  <tr>
					       	    <td colspan="1"></td>
					       		<td colspan="1"></td>
					       		<td colspan="1"></td>
					       		<td colspan="1"></td>
					       		<td>Contacto </td>
					       		<td>Direcci&oacute;n </td>
					       		<td>Direcci&oacute;n</td>
					       		<td>Vehicular </td>
					       		<td></td>
					       		<td></td>
					       		<td></td>
					       	  </tr> 	
      					 	</thead>
					       	<tbody id="idTBodyListar" >
					       	   <tr>
					       		<!-- td><html:html><input type="checkbox" align="middle" id="selCheck_0" onclick="checkFila(this);"></html:html></td>
					       		<td><html:html>Pedro Pablo </html:html></td>
					       		<td><html:html>Puente Piedra </html:html></td>
					       		<td><html:html>Familiar</html:html></td>
					       		<td><html:html>666-666 </html:html></td>
					       		<td><html:html>Comercial </html:html></td>
					       		<td><html:html>3333</html:html></td>
					       		<td><html:html>690-GUA</html:html> </td>
					       		<td><html:html>AZUL</html:html></td>
					       		<td><html:html>1969</html:html></td>
					       		<td><html:html>Servicio 911 Activado para este contacto</html:html></td-->
					       	   </tr>
					       	   <tr>
					       	   </tr>
					       	</tbody>
					     </table>
					      			
      				
      			</td>
      		</tr>
      		
      	</table>
      	</fieldset>
      </td>
     </table>
     </div>
     
     <div id="divFax" style="inline:none">
     	<table>
     		
     	</table>
     
     </div>
     
   </body>
