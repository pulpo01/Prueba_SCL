/**
 * ConsultaServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package consultas;

public class ConsultaServiceLocator extends org.apache.axis.client.Service implements consultas.ConsultaService {

    public ConsultaServiceLocator() {
    }


    public ConsultaServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public ConsultaServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for Consulta
    private java.lang.String Consulta_address = "http://10.34.0.80:9080/scoreclientegt/services/Consulta";

    public java.lang.String getConsultaAddress() {
        return Consulta_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String ConsultaWSDDServiceName = "Consulta";

    public java.lang.String getConsultaWSDDServiceName() {
        return ConsultaWSDDServiceName;
    }

    public void setConsultaWSDDServiceName(java.lang.String name) {
        ConsultaWSDDServiceName = name;
    }

    public consultas.Consulta getConsulta() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(Consulta_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getConsulta(endpoint);
    }

    public consultas.Consulta getConsulta(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            consultas.ConsultaSoapBindingStub _stub = new consultas.ConsultaSoapBindingStub(portAddress, this);
            _stub.setPortName(getConsultaWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setConsultaEndpointAddress(java.lang.String address) {
        Consulta_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (consultas.Consulta.class.isAssignableFrom(serviceEndpointInterface)) {
                consultas.ConsultaSoapBindingStub _stub = new consultas.ConsultaSoapBindingStub(new java.net.URL(Consulta_address), this);
                _stub.setPortName(getConsultaWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("Consulta".equals(inputPortName)) {
            return getConsulta();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://consultas", "ConsultaService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://consultas", "Consulta"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("Consulta".equals(portName)) {
            setConsultaEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
