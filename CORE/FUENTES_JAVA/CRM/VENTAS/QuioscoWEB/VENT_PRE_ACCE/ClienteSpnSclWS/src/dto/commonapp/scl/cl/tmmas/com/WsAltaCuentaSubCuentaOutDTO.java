/**
 * WsAltaCuentaSubCuentaOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsAltaCuentaSubCuentaOutDTO  implements java.io.Serializable {
    private java.lang.String codigoCuenta;

    private dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] errores;

    private java.lang.String resultadoTransaccion;

    public WsAltaCuentaSubCuentaOutDTO() {
    }

    public WsAltaCuentaSubCuentaOutDTO(
           java.lang.String codigoCuenta,
           dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] errores,
           java.lang.String resultadoTransaccion) {
           this.codigoCuenta = codigoCuenta;
           this.errores = errores;
           this.resultadoTransaccion = resultadoTransaccion;
    }


    /**
     * Gets the codigoCuenta value for this WsAltaCuentaSubCuentaOutDTO.
     * 
     * @return codigoCuenta
     */
    public java.lang.String getCodigoCuenta() {
        return codigoCuenta;
    }


    /**
     * Sets the codigoCuenta value for this WsAltaCuentaSubCuentaOutDTO.
     * 
     * @param codigoCuenta
     */
    public void setCodigoCuenta(java.lang.String codigoCuenta) {
        this.codigoCuenta = codigoCuenta;
    }


    /**
     * Gets the errores value for this WsAltaCuentaSubCuentaOutDTO.
     * 
     * @return errores
     */
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] getErrores() {
        return errores;
    }


    /**
     * Sets the errores value for this WsAltaCuentaSubCuentaOutDTO.
     * 
     * @param errores
     */
    public void setErrores(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] errores) {
        this.errores = errores;
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO getErrores(int i) {
        return this.errores[i];
    }

    public void setErrores(int i, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO _value) {
        this.errores[i] = _value;
    }


    /**
     * Gets the resultadoTransaccion value for this WsAltaCuentaSubCuentaOutDTO.
     * 
     * @return resultadoTransaccion
     */
    public java.lang.String getResultadoTransaccion() {
        return resultadoTransaccion;
    }


    /**
     * Sets the resultadoTransaccion value for this WsAltaCuentaSubCuentaOutDTO.
     * 
     * @param resultadoTransaccion
     */
    public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
        this.resultadoTransaccion = resultadoTransaccion;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsAltaCuentaSubCuentaOutDTO)) return false;
        WsAltaCuentaSubCuentaOutDTO other = (WsAltaCuentaSubCuentaOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoCuenta==null && other.getCodigoCuenta()==null) || 
             (this.codigoCuenta!=null &&
              this.codigoCuenta.equals(other.getCodigoCuenta()))) &&
            ((this.errores==null && other.getErrores()==null) || 
             (this.errores!=null &&
              java.util.Arrays.equals(this.errores, other.getErrores()))) &&
            ((this.resultadoTransaccion==null && other.getResultadoTransaccion()==null) || 
             (this.resultadoTransaccion!=null &&
              this.resultadoTransaccion.equals(other.getResultadoTransaccion())));
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
        if (getCodigoCuenta() != null) {
            _hashCode += getCodigoCuenta().hashCode();
        }
        if (getErrores() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getErrores());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getErrores(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getResultadoTransaccion() != null) {
            _hashCode += getResultadoTransaccion().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsAltaCuentaSubCuentaOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsAltaCuentaSubCuentaOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCuenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoCuenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("errores");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Errores"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RetornoDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("resultadoTransaccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "ResultadoTransaccion"));
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
