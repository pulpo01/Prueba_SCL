<%@ page contentType="text/xml; charset=ISO-8859-1" language="java" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>

<abonados>
	<logic:iterate id="listaClientesRelacionados" indexId="idx" name="lista" type="com.tmmas.scl.doblecuenta.form.FacturacionDTO">
		<listaClientesRelacionados>			
			<codigo_Abonado><bean:write name="listaClientesRelacionados" property="codigoAbonado"/></codigo_Abonado>
			<numero_Celular><bean:write name="listaClientesRelacionados" property="numeroCelular"/></numero_Celular>
			<desc_Abonado><bean:write name="listaClientesRelacionados" property="descAbonado"/></desc_Abonado>
			<cod_Clien_Asociado><bean:write name="listaClientesRelacionados" property="codClienAsociado"/></cod_Clien_Asociado>			
			<desc_Clien_Asociado><bean:write name="listaClientesRelacionados" property="descClienAsociado"/></desc_Clien_Asociado>
			<codigo_Concepto><bean:write name="listaClientesRelacionados" property="codigoConcepto"/></codigo_Concepto>
			<desc_Concepto><bean:write name="listaClientesRelacionados" property="descConcepto"/></desc_Concepto>
			<valor_1><bean:write name="listaClientesRelacionados" property="valor"/></valor_1>
			<num_Secuencia_Detalle><bean:write name="listaClientesRelacionados" property="numSecuenciaDetalle"/></num_Secuencia_Detalle>
		</listaClientesRelacionados>
	</logic:iterate>
</abonados>
