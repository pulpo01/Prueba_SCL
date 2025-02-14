/**
 * WsDireccionesOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsDireccionesOutDTO  implements java.io.Serializable {
    private java.lang.String[] codigosDirecciones;

    private dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] errores;

    private java.lang.String resultadoTransaccion;

    public WsDireccionesOutDTO() {
    }

    public WsDireccionesOutDTO(
           java.lang.String[] codigosDirecciones,
           dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] errores,
           java.lang.String resultadoTransaccion) {
           this.codigosDirecciones = codigosDirecciones;
           this.errores = errores;
           this.resultadoTransaccion = resultadoTransaccion;
    }


    /**
     * Gets the codigosDirecciones value for this WsDireccionesOutDTO.
     * 
     * @return codigosDirecciones
     */
    public java.lang.String[] getCodigosDirecciones() {
        return codigosDirecciones;
    }


    /**
     * Sets the codigosDirecciones value for this WsDireccionesOutDTO.
     * 
     * @param codigosDirecciones
     */
    public void setCodigosDirecciones(java.lang.String[] codigosDirecciones) {
        this.codigosDirecciones = codigosDirecciones;
    }

    public java.lang.String getCodigosDirecciones(int i) {
        return this.codigosDirecciones[i];
    }

    public void setCodigosDirecciones(int i, java.lang.String _value) {
        this.codigosDirecciones[i] = _value;
    }


    /**
     * Gets the errores value for this WsDireccionesOutDTO.
     * 
     * @return errores
     */
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] getErrores() {
        return errores;
    }


    /**
     * Sets the errores value for this WsDireccionesOutDTO.
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
     * Gets the resultadoTransaccion value for this WsDireccionesOutDTO.
     * 
     * @return resultadoTransaccion
     */
    public java.lang.String getResultadoTransaccion() {
        return resultadoTransaccion;
    }


    /**
     * Sets the resultadoTransaccion value for this WsDireccionesOutDTO.
     * 
     * @param resultadoTransaccion
     */
    public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
        this.resultadoTransaccion = resultadoTransaccion;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsDireccionesOutDTO)) return false;
        WsDireccionesOutDTO other = (WsDireccionesOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigosDirecciones==null && other.getCodigosDirecciones()==null) || 
             (this.codigosDirecciones!=null &&
              java.util.Arrays.equals(this.codigosDirecciones, other.getCodigosDirecciones()))) &&
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
        if (getCodigosDirecciones() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getCodigosDirecciones());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getCodigosDirecciones(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
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
        new org.apache.axis.description.TypeDesc(WsDireccionesOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDireccionesOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigosDirecciones");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigosDirecciones"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
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
