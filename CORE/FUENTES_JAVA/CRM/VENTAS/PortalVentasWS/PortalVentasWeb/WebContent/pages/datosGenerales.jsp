<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>




<c:set var="customer" value="${sessionScope.CustomerOrder}"></c:set>
	<script>document.getElementById("nombreCliente").value = "<c:out value="${customer.names}"/>";</script>
<c:choose>
	<c:when test="${customer.datosdeCliente}">
					<tr height="3px">
					</tr>	
					<tr>
						<td width=30% class="amarilloInfClie"><strong>C&oacute;digo de Cliente</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
						<td width=65% class="amarilloInfClie"><c:out value="${customer.code}"/></td>
					</tr>								
					<tr>
						<td width=30% class="amarilloInfClie"><strong>Nombre de Cliente</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
						<td width=65% class=amarilloInfClie><c:out value="${customer.names}"/></td>
					</tr>
					<tr>
						<td width=30% class="amarilloInfClie"><strong>Plan Tarifario</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
						<td width=65% class="amarilloInfClie"><c:out value="${customer.desPlanRate}"/></td>
					</tr>
					<!--
					<tr>
						<td width=30% class="amarilloInfClie"><strong>N&uacute;mero de OS</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
						<td width=65% class="amarilloInfClie"><c:out value="${customer.numeroOrdenServicio}"/></td>
					</tr>
					-->
	</c:when>
	<c:when test="${!customer.datosdeCliente}">
					<tr>
						<td width=30% class="amarilloInfClie"><strong>C&oacute;digo de Cliente</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
						<td width=65% class="amarilloInfClie"><c:out value="${customer.code}"/></td>
					</tr>								
					<tr>
						<td width=30% class="amarilloInfClie"><strong>Nombre de Cliente</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
						<td width=65% class="amarilloInfClie"><c:out value="${customer.names}"/></td>
					</tr>
					<!--
					<tr>
						<td width=30% class="amarilloInfClie"><strong><span class="fondoFilaInformacionTitulo"><strong>N&uacute;mero</strong></span> de Abonado</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
						<td width=65% class="amarilloInfClie"><c:out value="${customer.numeroAbonado}"/></td>
					</tr>
					<tr>
						<td width=30% class="amarilloInfClie"><strong>Plan Tarifario</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
						<td width=65% class="amarilloInfClie"><c:out value="${customer.desPlanRateAbonado}"/></td>
					</tr>
					<tr>
						<td width=30% class="amarilloInfClie"><strong>N&uacute;mero de OS</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
						<td width=65% class="amarilloInfClie"><c:out value="${customer.numeroOrdenServicio}"/></td>
					</tr>
					<tr>
						<td width=30% class="amarilloInfClie"><strong>N&uacutemero de Celular</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
					    <td width=65% class="amarilloInfClie">"SE DEBE ELIMINAR ESTE CAMPO EN LA VENTA????"</td>
					</tr>	
					-->				
	</c:when>	

</c:choose>				