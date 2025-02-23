/**
 * ScoreClienteServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package scorecliente;

public class ScoreClienteServiceLocator extends org.apache.axis.client.Service implements scorecliente.ScoreClienteService {

    public ScoreClienteServiceLocator() {
    }


    public ScoreClienteServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public ScoreClienteServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for ScoreCliente
    private java.lang.String ScoreCliente_address = "http://10.34.0.80:9080/scoreclientegt/services/ScoreCliente";

    public java.lang.String getScoreClienteAddress() {
        return ScoreCliente_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String ScoreClienteWSDDServiceName = "ScoreCliente";

    public java.lang.String getScoreClienteWSDDServiceName() {
        return ScoreClienteWSDDServiceName;
    }

    public void setScoreClienteWSDDServiceName(java.lang.String name) {
        ScoreClienteWSDDServiceName = name;
    }

    public scorecliente.ScoreCliente getScoreCliente() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(ScoreCliente_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getScoreCliente(endpoint);
    }

    public scorecliente.ScoreCliente getScoreCliente(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            scorecliente.ScoreClienteSoapBindingStub _stub = new scorecliente.ScoreClienteSoapBindingStub(portAddress, this);
            _stub.setPortName(getScoreClienteWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setScoreClienteEndpointAddress(java.lang.String address) {
        ScoreCliente_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (scorecliente.ScoreCliente.class.isAssignableFrom(serviceEndpointInterface)) {
                scorecliente.ScoreClienteSoapBindingStub _stub = new scorecliente.ScoreClienteSoapBindingStub(new java.net.URL(ScoreCliente_address), this);
                _stub.setPortName(getScoreClienteWSDDServiceName());
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
        if ("ScoreCliente".equals(inputPortName)) {
            return getScoreCliente();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://scorecliente", "ScoreClienteService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://scorecliente", "ScoreCliente"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("ScoreCliente".equals(portName)) {
            setScoreClienteEndpointAddress(address);
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
