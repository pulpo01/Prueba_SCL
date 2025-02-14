/**
 * WsStructuraActivacionLineaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.quiosco.spnsclwscommon.scl.cl.tmmas.com;

public class WsStructuraActivacionLineaDTO  implements java.io.Serializable {
    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAntecedentesVentaDTO antecedentesVenta;

    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraLineaDTO[] lineas;

    public WsStructuraActivacionLineaDTO() {
    }

    public WsStructuraActivacionLineaDTO(
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAntecedentesVentaDTO antecedentesVenta,
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraLineaDTO[] lineas) {
           this.antecedentesVenta = antecedentesVenta;
           this.lineas = lineas;
    }


    /**
     * Gets the antecedentesVenta value for this WsStructuraActivacionLineaDTO.
     * 
     * @return antecedentesVenta
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAntecedentesVentaDTO getAntecedentesVenta() {
        return antecedentesVenta;
    }


    /**
     * Sets the antecedentesVenta value for this WsStructuraActivacionLineaDTO.
     * 
     * @param antecedentesVenta
     */
    public void setAntecedentesVenta(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAntecedentesVentaDTO antecedentesVenta) {
        this.antecedentesVenta = antecedentesVenta;
    }


    /**
     * Gets the lineas value for this WsStructuraActivacionLineaDTO.
     * 
     * @return lineas
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraLineaDTO[] getLineas() {
        return lineas;
    }


    /**
     * Sets the lineas value for this WsStructuraActivacionLineaDTO.
     * 
     * @param lineas
     */
    public void setLineas(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraLineaDTO[] lineas) {
        this.lineas = lineas;
    }

    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraLineaDTO getLineas(int i) {
        return this.lineas[i];
    }

    public void setLineas(int i, dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraLineaDTO _value) {
        this.lineas[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsStructuraActivacionLineaDTO)) return false;
        WsStructuraActivacionLineaDTO other = (WsStructuraActivacionLineaDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.antecedentesVenta==null && other.getAntecedentesVenta()==null) || 
             (this.antecedentesVenta!=null &&
              this.antecedentesVenta.equals(other.getAntecedentesVenta()))) &&
            ((this.lineas==null && other.getLineas()==null) || 
             (this.lineas!=null &&
              java.util.Arrays.equals(this.lineas, other.getLineas())));
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
        if (getAntecedentesVenta() != null) {
            _hashCode += getAntecedentesVenta().hashCode();
        }
        if (getLineas() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getLineas());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getLineas(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsStructuraActivacionLineaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraActivacionLineaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("antecedentesVenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "AntecedentesVenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraAntecedentesVentaDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("lineas");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Lineas"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraLineaDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
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
