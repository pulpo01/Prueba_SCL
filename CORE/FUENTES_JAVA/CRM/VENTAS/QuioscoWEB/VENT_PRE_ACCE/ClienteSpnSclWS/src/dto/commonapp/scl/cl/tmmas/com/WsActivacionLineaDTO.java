/**
 * WsActivacionLineaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsActivacionLineaDTO  implements java.io.Serializable {
    private dto.commonapp.scl.cl.tmmas.com.WsAntecedentesVentaInDTO antecedentesVenta;

    private dto.commonapp.scl.cl.tmmas.com.WsLineaInDTO[] lineas;

    public WsActivacionLineaDTO() {
    }

    public WsActivacionLineaDTO(
           dto.commonapp.scl.cl.tmmas.com.WsAntecedentesVentaInDTO antecedentesVenta,
           dto.commonapp.scl.cl.tmmas.com.WsLineaInDTO[] lineas) {
           this.antecedentesVenta = antecedentesVenta;
           this.lineas = lineas;
    }


    /**
     * Gets the antecedentesVenta value for this WsActivacionLineaDTO.
     * 
     * @return antecedentesVenta
     */
    public dto.commonapp.scl.cl.tmmas.com.WsAntecedentesVentaInDTO getAntecedentesVenta() {
        return antecedentesVenta;
    }


    /**
     * Sets the antecedentesVenta value for this WsActivacionLineaDTO.
     * 
     * @param antecedentesVenta
     */
    public void setAntecedentesVenta(dto.commonapp.scl.cl.tmmas.com.WsAntecedentesVentaInDTO antecedentesVenta) {
        this.antecedentesVenta = antecedentesVenta;
    }


    /**
     * Gets the lineas value for this WsActivacionLineaDTO.
     * 
     * @return lineas
     */
    public dto.commonapp.scl.cl.tmmas.com.WsLineaInDTO[] getLineas() {
        return lineas;
    }


    /**
     * Sets the lineas value for this WsActivacionLineaDTO.
     * 
     * @param lineas
     */
    public void setLineas(dto.commonapp.scl.cl.tmmas.com.WsLineaInDTO[] lineas) {
        this.lineas = lineas;
    }

    public dto.commonapp.scl.cl.tmmas.com.WsLineaInDTO getLineas(int i) {
        return this.lineas[i];
    }

    public void setLineas(int i, dto.commonapp.scl.cl.tmmas.com.WsLineaInDTO _value) {
        this.lineas[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsActivacionLineaDTO)) return false;
        WsActivacionLineaDTO other = (WsActivacionLineaDTO) obj;
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
        new org.apache.axis.description.TypeDesc(WsActivacionLineaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsActivacionLineaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("antecedentesVenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "AntecedentesVenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsAntecedentesVentaInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("lineas");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Lineas"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsLineaInDTO"));
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
