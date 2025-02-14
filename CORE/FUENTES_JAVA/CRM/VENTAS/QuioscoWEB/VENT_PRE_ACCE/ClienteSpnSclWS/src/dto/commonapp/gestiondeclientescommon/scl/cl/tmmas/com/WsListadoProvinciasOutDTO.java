/**
 * WsListadoProvinciasOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsListadoProvinciasOutDTO  extends dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO  implements java.io.Serializable {
    private dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO[] provinciaDTOs;

    public WsListadoProvinciasOutDTO() {
    }

    public WsListadoProvinciasOutDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO[] provinciaDTOs) {
        super(
            codError,
            mensajseError);
        this.provinciaDTOs = provinciaDTOs;
    }


    /**
     * Gets the provinciaDTOs value for this WsListadoProvinciasOutDTO.
     * 
     * @return provinciaDTOs
     */
    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO[] getProvinciaDTOs() {
        return provinciaDTOs;
    }


    /**
     * Sets the provinciaDTOs value for this WsListadoProvinciasOutDTO.
     * 
     * @param provinciaDTOs
     */
    public void setProvinciaDTOs(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO[] provinciaDTOs) {
        this.provinciaDTOs = provinciaDTOs;
    }

    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO getProvinciaDTOs(int i) {
        return this.provinciaDTOs[i];
    }

    public void setProvinciaDTOs(int i, dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO _value) {
        this.provinciaDTOs[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsListadoProvinciasOutDTO)) return false;
        WsListadoProvinciasOutDTO other = (WsListadoProvinciasOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.provinciaDTOs==null && other.getProvinciaDTOs()==null) || 
             (this.provinciaDTOs!=null &&
              java.util.Arrays.equals(this.provinciaDTOs, other.getProvinciaDTOs())));
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
        if (getProvinciaDTOs() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getProvinciaDTOs());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getProvinciaDTOs(), i);
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
        new org.apache.axis.description.TypeDesc(WsListadoProvinciasOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoProvinciasOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("provinciaDTOs");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ProvinciaDTOs"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ProvinciaDTO"));
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
