/**
 * WsListadoCiudadesOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsListadoCiudadesOutDTO  extends dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO  implements java.io.Serializable {
    private dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO[] ciudadDTOs;

    public WsListadoCiudadesOutDTO() {
    }

    public WsListadoCiudadesOutDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO[] ciudadDTOs) {
        super(
            codError,
            mensajseError);
        this.ciudadDTOs = ciudadDTOs;
    }


    /**
     * Gets the ciudadDTOs value for this WsListadoCiudadesOutDTO.
     * 
     * @return ciudadDTOs
     */
    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO[] getCiudadDTOs() {
        return ciudadDTOs;
    }


    /**
     * Sets the ciudadDTOs value for this WsListadoCiudadesOutDTO.
     * 
     * @param ciudadDTOs
     */
    public void setCiudadDTOs(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO[] ciudadDTOs) {
        this.ciudadDTOs = ciudadDTOs;
    }

    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO getCiudadDTOs(int i) {
        return this.ciudadDTOs[i];
    }

    public void setCiudadDTOs(int i, dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO _value) {
        this.ciudadDTOs[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsListadoCiudadesOutDTO)) return false;
        WsListadoCiudadesOutDTO other = (WsListadoCiudadesOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.ciudadDTOs==null && other.getCiudadDTOs()==null) || 
             (this.ciudadDTOs!=null &&
              java.util.Arrays.equals(this.ciudadDTOs, other.getCiudadDTOs())));
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
        if (getCiudadDTOs() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getCiudadDTOs());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getCiudadDTOs(), i);
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
        new org.apache.axis.description.TypeDesc(WsListadoCiudadesOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoCiudadesOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ciudadDTOs");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CiudadDTOs"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CiudadDTO"));
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
