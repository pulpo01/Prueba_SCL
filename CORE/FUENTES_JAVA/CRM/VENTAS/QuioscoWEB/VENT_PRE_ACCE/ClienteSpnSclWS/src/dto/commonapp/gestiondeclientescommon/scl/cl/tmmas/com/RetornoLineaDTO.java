/**
 * RetornoLineaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class RetornoLineaDTO  implements java.io.Serializable {
    private java.lang.String codError;

    private java.lang.String mensajseError;

    private java.lang.String numLinea;

    public RetornoLineaDTO() {
    }

    public RetornoLineaDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           java.lang.String numLinea) {
           this.codError = codError;
           this.mensajseError = mensajseError;
           this.numLinea = numLinea;
    }


    /**
     * Gets the codError value for this RetornoLineaDTO.
     * 
     * @return codError
     */
    public java.lang.String getCodError() {
        return codError;
    }


    /**
     * Sets the codError value for this RetornoLineaDTO.
     * 
     * @param codError
     */
    public void setCodError(java.lang.String codError) {
        this.codError = codError;
    }


    /**
     * Gets the mensajseError value for this RetornoLineaDTO.
     * 
     * @return mensajseError
     */
    public java.lang.String getMensajseError() {
        return mensajseError;
    }


    /**
     * Sets the mensajseError value for this RetornoLineaDTO.
     * 
     * @param mensajseError
     */
    public void setMensajseError(java.lang.String mensajseError) {
        this.mensajseError = mensajseError;
    }


    /**
     * Gets the numLinea value for this RetornoLineaDTO.
     * 
     * @return numLinea
     */
    public java.lang.String getNumLinea() {
        return numLinea;
    }


    /**
     * Sets the numLinea value for this RetornoLineaDTO.
     * 
     * @param numLinea
     */
    public void setNumLinea(java.lang.String numLinea) {
        this.numLinea = numLinea;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof RetornoLineaDTO)) return false;
        RetornoLineaDTO other = (RetornoLineaDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codError==null && other.getCodError()==null) || 
             (this.codError!=null &&
              this.codError.equals(other.getCodError()))) &&
            ((this.mensajseError==null && other.getMensajseError()==null) || 
             (this.mensajseError!=null &&
              this.mensajseError.equals(other.getMensajseError()))) &&
            ((this.numLinea==null && other.getNumLinea()==null) || 
             (this.numLinea!=null &&
              this.numLinea.equals(other.getNumLinea())));
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
        if (getCodError() != null) {
            _hashCode += getCodError().hashCode();
        }
        if (getMensajseError() != null) {
            _hashCode += getMensajseError().hashCode();
        }
        if (getNumLinea() != null) {
            _hashCode += getNumLinea().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(RetornoLineaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RetornoLineaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("mensajseError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "MensajseError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numLinea");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumLinea"));
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
