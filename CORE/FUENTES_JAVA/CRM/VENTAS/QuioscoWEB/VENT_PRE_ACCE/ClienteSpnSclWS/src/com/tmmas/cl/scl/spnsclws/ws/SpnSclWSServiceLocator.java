/**
 * SpnSclWSServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.tmmas.cl.scl.spnsclws.ws;

public class SpnSclWSServiceLocator extends org.apache.axis.client.Service implements com.tmmas.cl.scl.spnsclws.ws.SpnSclWSService {

    public SpnSclWSServiceLocator() {
    }


    public SpnSclWSServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public SpnSclWSServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for SpnSclWSSoapPort
    private java.lang.String SpnSclWSSoapPort_address = "http://127.0.0.1:7001/SpnSclWS/SpnSclWS";

    public java.lang.String getSpnSclWSSoapPortAddress() {
        return SpnSclWSSoapPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SpnSclWSSoapPortWSDDServiceName = "SpnSclWSSoapPort";

    public java.lang.String getSpnSclWSSoapPortWSDDServiceName() {
        return SpnSclWSSoapPortWSDDServiceName;
    }

    public void setSpnSclWSSoapPortWSDDServiceName(java.lang.String name) {
        SpnSclWSSoapPortWSDDServiceName = name;
    }

    public com.tmmas.cl.scl.spnsclws.ws.SpnSclWS getSpnSclWSSoapPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SpnSclWSSoapPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSpnSclWSSoapPort(endpoint);
    }

    public com.tmmas.cl.scl.spnsclws.ws.SpnSclWS getSpnSclWSSoapPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.tmmas.cl.scl.spnsclws.ws.SpnSclWSServiceSoapBindingStub _stub = new com.tmmas.cl.scl.spnsclws.ws.SpnSclWSServiceSoapBindingStub(portAddress, this);
            _stub.setPortName(getSpnSclWSSoapPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSpnSclWSSoapPortEndpointAddress(java.lang.String address) {
        SpnSclWSSoapPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.tmmas.cl.scl.spnsclws.ws.SpnSclWS.class.isAssignableFrom(serviceEndpointInterface)) {
                com.tmmas.cl.scl.spnsclws.ws.SpnSclWSServiceSoapBindingStub _stub = new com.tmmas.cl.scl.spnsclws.ws.SpnSclWSServiceSoapBindingStub(new java.net.URL(SpnSclWSSoapPort_address), this);
                _stub.setPortName(getSpnSclWSSoapPortWSDDServiceName());
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
        if ("SpnSclWSSoapPort".equals(inputPortName)) {
            return getSpnSclWSSoapPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "SpnSclWSService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "SpnSclWSSoapPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("SpnSclWSSoapPort".equals(portName)) {
            setSpnSclWSSoapPortEndpointAddress(address);
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
