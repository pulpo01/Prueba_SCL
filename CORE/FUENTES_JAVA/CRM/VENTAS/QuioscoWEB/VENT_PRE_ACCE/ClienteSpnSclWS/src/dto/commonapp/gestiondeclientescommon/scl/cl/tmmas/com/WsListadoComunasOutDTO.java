/**
 * WsListadoComunasOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsListadoComunasOutDTO  extends dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO  implements java.io.Serializable {
    private dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ComunaSPNDTO[] comunaSPNDTOs;

    public WsListadoComunasOutDTO() {
    }

    public WsListadoComunasOutDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ComunaSPNDTO[] comunaSPNDTOs) {
        super(
            codError,
            mensajseError);
        this.comunaSPNDTOs = comunaSPNDTOs;
    }


    /**
     * Gets the comunaSPNDTOs value for this WsListadoComunasOutDTO.
     * 
     * @return comunaSPNDTOs
     */
    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ComunaSPNDTO[] getComunaSPNDTOs() {
        return comunaSPNDTOs;
    }


    /**
     * Sets the comunaSPNDTOs value for this WsListadoComunasOutDTO.
     * 
     * @param comunaSPNDTOs
     */
    public void setComunaSPNDTOs(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ComunaSPNDTO[] comunaSPNDTOs) {
        this.comunaSPNDTOs = comunaSPNDTOs;
    }

    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ComunaSPNDTO getComunaSPNDTOs(int i) {
        return this.comunaSPNDTOs[i];
    }

    public void setComunaSPNDTOs(int i, dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ComunaSPNDTO _value) {
        this.comunaSPNDTOs[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsListadoComunasOutDTO)) return false;
        WsListadoComunasOutDTO other = (WsListadoComunasOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.comunaSPNDTOs==null && other.getComunaSPNDTOs()==null) || 
             (this.comunaSPNDTOs!=null &&
              java.util.Arrays.equals(this.comunaSPNDTOs, other.getComunaSPNDTOs())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = super.hashCode();
        if (getComunaSPNDTOs() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getComunaSPNDTOs());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getComunaSPNDTOs(), i);
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
        new org.apache.axis.description.TypeDesc(WsListadoComunasOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoComunasOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("comunaSPNDTOs");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ComunaSPNDTOs"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ComunaSPNDTO"));
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
