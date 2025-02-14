/**
 * ConsultaService.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package consultas;

public interface ConsultaService extends javax.xml.rpc.Service {
    public java.lang.String getConsultaAddress();

    public consultas.Consulta getConsulta() throws javax.xml.rpc.ServiceException;

    public consultas.Consulta getConsulta(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
