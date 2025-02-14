/**
 * WsLineaOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsLineaOutDTO  implements java.io.Serializable {
    private java.lang.String numAboando;

    private java.lang.String numCelular;

    private java.lang.String numImei;

    private java.lang.String numSerie;

    public WsLineaOutDTO() {
    }

    public WsLineaOutDTO(
           java.lang.String numAboando,
           java.lang.String numCelular,
           java.lang.String numImei,
           java.lang.String numSerie) {
           this.numAboando = numAboando;
           this.numCelular = numCelular;
           this.numImei = numImei;
           this.numSerie = numSerie;
    }


    /**
     * Gets the numAboando value for this WsLineaOutDTO.
     * 
     * @return numAboando
     */
    public java.lang.String getNumAboando() {
        return numAboando;
    }


    /**
     * Sets the numAboando value for this WsLineaOutDTO.
     * 
     * @param numAboando
     */
    public void setNumAboando(java.lang.String numAboando) {
        this.numAboando = numAboando;
    }


    /**
     * Gets the numCelular value for this WsLineaOutDTO.
     * 
     * @return numCelular
     */
    public java.lang.String getNumCelular() {
        return numCelular;
    }


    /**
     * Sets the numCelular value for this WsLineaOutDTO.
     * 
     * @param numCelular
     */
    public void setNumCelular(java.lang.String numCelular) {
        this.numCelular = numCelular;
    }


    /**
     * Gets the numImei value for this WsLineaOutDTO.
     * 
     * @return numImei
     */
    public java.lang.String getNumImei() {
        return numImei;
    }


    /**
     * Sets the numImei value for this WsLineaOutDTO.
     * 
     * @param numImei
     */
    public void setNumImei(java.lang.String numImei) {
        this.numImei = numImei;
    }


    /**
     * Gets the numSerie value for this WsLineaOutDTO.
     * 
     * @return numSerie
     */
    public java.lang.String getNumSerie() {
        return numSerie;
    }


    /**
     * Sets the numSerie value for this WsLineaOutDTO.
     * 
     * @param numSerie
     */
    public void setNumSerie(java.lang.String numSerie) {
        this.numSerie = numSerie;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsLineaOutDTO)) return false;
        WsLineaOutDTO other = (WsLineaOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.numAboando==null && other.getNumAboando()==null) || 
             (this.numAboando!=null &&
              this.numAboando.equals(other.getNumAboando()))) &&
            ((this.numCelular==null && other.getNumCelular()==null) || 
             (this.numCelular!=null &&
              this.numCelular.equals(other.getNumCelular()))) &&
            ((this.numImei==null && other.getNumImei()==null) || 
             (this.numImei!=null &&
              this.numImei.equals(other.getNumImei()))) &&
            ((this.numSerie==null && other.getNumSerie()==null) || 
             (this.numSerie!=null &&
              this.numSerie.equals(other.getNumSerie())));
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
        if (getNumAboando() != null) {
            _hashCode += getNumAboando().hashCode();
        }
        if (getNumCelular() != null) {
            _hashCode += getNumCelular().hashCode();
        }
        if (getNumImei() != null) {
            _hashCode += getNumImei().hashCode();
        }
        if (getNumSerie() != null) {
            _hashCode += getNumSerie().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsLineaOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsLineaOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numAboando");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumAboando"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numCelular");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumCelular"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numImei");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumImei"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numSerie");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumSerie"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
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
