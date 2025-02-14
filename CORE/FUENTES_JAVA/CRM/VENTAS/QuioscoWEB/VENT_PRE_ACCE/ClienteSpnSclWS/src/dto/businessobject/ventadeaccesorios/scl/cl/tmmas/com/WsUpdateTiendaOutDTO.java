/**
 * WsUpdateTiendaOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com;

public class WsUpdateTiendaOutDTO  implements java.io.Serializable {
    private int codError;

    private java.lang.String msgError;

    private int numEvento;

    public WsUpdateTiendaOutDTO() {
    }

    public WsUpdateTiendaOutDTO(
           int codError,
           java.lang.String msgError,
           int numEvento) {
           this.codError = codError;
           this.msgError = msgError;
           this.numEvento = numEvento;
    }


    /**
     * Gets the codError value for this WsUpdateTiendaOutDTO.
     * 
     * @return codError
     */
    public int getCodError() {
        return codError;
    }


    /**
     * Sets the codError value for this WsUpdateTiendaOutDTO.
     * 
     * @param codError
     */
    public void setCodError(int codError) {
        this.codError = codError;
    }


    /**
     * Gets the msgError value for this WsUpdateTiendaOutDTO.
     * 
     * @return msgError
     */
    public java.lang.String getMsgError() {
        return msgError;
    }


    /**
     * Sets the msgError value for this WsUpdateTiendaOutDTO.
     * 
     * @param msgError
     */
    public void setMsgError(java.lang.String msgError) {
        this.msgError = msgError;
    }


    /**
     * Gets the numEvento value for this WsUpdateTiendaOutDTO.
     * 
     * @return numEvento
     */
    public int getNumEvento() {
        return numEvento;
    }


    /**
     * Sets the numEvento value for this WsUpdateTiendaOutDTO.
     * 
     * @param numEvento
     */
    public void setNumEvento(int numEvento) {
        this.numEvento = numEvento;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsUpdateTiendaOutDTO)) return false;
        WsUpdateTiendaOutDTO other = (WsUpdateTiendaOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.codError == other.getCodError() &&
            ((this.msgError==null && other.getMsgError()==null) || 
             (this.msgError!=null &&
              this.msgError.equals(other.getMsgError()))) &&
            this.numEvento == other.getNumEvento();
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        _hashCode += getCodError();
        if (getMsgError() != null) {
            _hashCode += getMsgError().hashCode();
        }
        _hashCode += getNumEvento();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsUpdateTiendaOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsUpdateTiendaOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("msgError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "MsgError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numEvento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "NumEvento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
