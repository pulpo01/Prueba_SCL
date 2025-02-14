<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" isErrorPage="true" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/fmt.tld" prefix="fmt"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>

<html:html>
<head>
   <title>Pagina de error global</title>
   <style type="text/css">
       h2{background:darkblue;color:white}
       h3{background:darkblue;color:white}
   </style>
<link href="css/mas.css" rel="stylesheet" type="text/css" />   
</head>
<body>

<div align="center">
   <c:choose>
      <c:when test="${not empty pageContext.exception}">
         <c:set var="problemType">JSP Exception</c:set>
         <c:set var="appException" value="${pageContext.exception}"/> 
         <c:set var="causeException" value="${appException.cause}"/>
      </c:when>
      <c:when test="${not empty requestScope['javax.servlet.
                                                 error.exception']}">
         <c:set var="problemType">Servlet Exception</c:set>
         <c:set var="appException" value="${requestScope['javax.servlet.error.exception']}"/> 
         <c:set var="causeException" value="${appException.rootCause}"/>
      </c:when>
      <c:when test="${not empty requestScope['org.apache.struts.action.EXCEPTION']}">
         <c:set var="problemType">Struts Exception</c:set>
         <c:set var="appException" value="${requestScope['org.apache.struts.action.EXCEPTION']}"/>
         <c:set var="causeException" value="${appException.cause}"/>
      </c:when>
      <c:otherwise>
         <c:set var="problemType">Error del server no identificado</c:set>
      </c:otherwise>
   </c:choose>
      <!-- end determine error -->

<!-- start framework -->
<table cellpadding="0" cellspacing="0" border="0" width="750">
    <tr>
        <td valign="top" colspan="2">    
         <table cellpadding="4" cellspacing="0" border="0" 
          width="100%">
            <tr valign="top">
               <td>
                  <!-- start user review -->    
                  <table cellpadding="4" cellspacing="0" border="0" width="100%">
                     <tr>
                        <td height="14" colspan="2"  class="textcaminohormigas"><img src="img/px_trans.jpg" alt="  " width="20" height="1" />
                        <STRONG>Problema de Sistema</STRONG>
                        </td>
                     </tr>
                  </table>
                  <table cellpadding="2" cellspacing="1" border="0" 
                  width="80%">
                     <tr>
                        <td colspan="2">
                        	Un error de sistema ha ocurrido. Si el problema persiste, 
                        	por favor contacte al administrador.
                        </td>
                     </tr>
                     <tr><td colspan="2">
                           <html:errors/>
                     </td></tr>
                     <tr valign="top">
                        <td>
                           <b>Tipo de problema</b>
                           <br/><c:out value="${problemType}"/>
                        </td>
                        <td>
                           <b>Detalle del problema</b>
                           <c:if test="${not empty
                            requestScope['javax.servlet.error.message']}">
                            <br/>
                           <c:out value=
                             "${requestScope['javax.servlet.error.message']}"
                           />
                           </c:if>
                           <c:if test="${not empty appException}">
                              <br/><c:out value="${appException.message}"/>
                              &nbsp;
                           </c:if>
                        </td>
                     </tr>
                     <c:if test="${not empty causeException}">
                     <tr>
                        <td>
                           <b>Causado por</b>
                           <br/><c:out value="${causeException}"/>
                        </td>
                        <td>
                           <b>Detalles de la causa</b>
                           <br/><c:out value="${causeException.message}"/>
                           &nbsp;
                        </td>
                     </tr>
                     </c:if>
                  </table>
                  <table id="showDetailsLinkDiv" style="{display:inline}"
                       cellpadding="2" cellspacing="1" border="0" width="80%">
                     <tr>
                        <td align="left">
                           [ <a href="javascript:showDetails( )">
                             Mostrar detalles</a> ]
                        </td>
                     </tr>
                  </table>
                  <table id="hideDetailsLinkDiv" style="{display:none}"
                       cellpadding="2" cellspacing="1" border="0" width="80%">
                     <tr>
                        <td align="left">
                           [ <a href="javascript:hideDetails( )">
                             Ocultar detalles</a> ]
                        </td>
                     </tr>
                  </table>
              <!-- begin details -->
                  <div id="stackTraceDiv" style="{display:none}">
                  <c:if test="${not empty appException}">
                     <p></p>
                     <table cellpadding="4" cellspacing="0" 
                            border="0" width="100%">
                        <tr>
                           <td>
                                 <h3>Stack Trace</h3>
                           </td>
                        </tr>
                     </table>
                     <b><c:out value="${appException}"/></b>
                     <br/>
                     <table align="center" cellpadding="0" cellspacing="0"
                            border="0" width="90%" class="pod">
                        <c:forEach var="stackItem" 
                                 items="${appException.stackTrace}">
                           <tr><td><c:out value="${stackItem}"/></td></tr>
                         </c:forEach>
                     </table>
                  </c:if>
                  <c:if test="${not empty causeException}">
                     <p></p>
                     <table cellpadding="4" cellspacing="0" 
                            border="0" width="100%">
                        <tr>
                           <td>
                                 <h3>Causa de  Stack Trace</h3>
                           </td>
                        </tr>
                     </table>
                     <b><c:out value="${causeException}"/></b>
                     <br/>
                     <table align="center" cellpadding="0" cellspacing="0"
                           border="0" width="90%" class="pod">
                        <c:forEach var="stackItem"
                             items="${causeException.stackTrace}">
                           <tr><td><c:out value="${stackItem}"/></td></tr>
                         </c:forEach>
                     </table>
                  </c:if>
                  </div>
              <!-- end details -->
               </td>
            </tr>
         </table>
         </td>
    </tr>
</table>
      
   <script language="javascript">
      function showDetails( ) {
        document.getElementById("showDetailsLinkDiv").style.display = "none";
        document.getElementById("hideDetailsLinkDiv").style.display = "inline";
        document.getElementById("stackTraceDiv").style.display = "inline";
      }
      function hideDetails( ) {
        document.getElementById("showDetailsLinkDiv").style.display = "inline";
        document.getElementById("hideDetailsLinkDiv").style.display = "none";
        document.getElementById("stackTraceDiv").style.display = "none";
      }
      
      var win = parent
      if (win!=null)  win.fncActDesacMenu(false);
      
   </script>

</div>
</body>
</html:html>