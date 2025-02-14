/**
 * WsListadoRegionesOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsListadoRegionesOutDTO  extends dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO  implements java.io.Serializable {
    private dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO[] regionDTOs;

    public WsListadoRegionesOutDTO() {
    }

    public WsListadoRegionesOutDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO[] regionDTOs) {
        super(
            codError,
            mensajseError);
        this.regionDTOs = regionDTOs;
    }


    /**
     * Gets the regionDTOs value for this WsListadoRegionesOutDTO.
     * 
     * @return regionDTOs
     */
    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO[] getRegionDTOs() {
        return regionDTOs;
    }


    /**
     * Sets the regionDTOs value for this WsListadoRegionesOutDTO.
     * 
     * @param regionDTOs
     */
    public void setRegionDTOs(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO[] regionDTOs) {
        this.regionDTOs = regionDTOs;
    }

    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO getRegionDTOs(int i) {
        return this.regionDTOs[i];
    }

    public void setRegionDTOs(int i, dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO _value) {
        this.regionDTOs[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsListadoRegionesOutDTO)) return false;
        WsListadoRegionesOutDTO other = (WsListadoRegionesOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.regionDTOs==null && other.getRegionDTOs()==null) || 
             (this.regionDTOs!=null &&
              java.util.Arrays.equals(this.regionDTOs, other.getRegionDTOs())));
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
        if (getRegionDTOs() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getRegionDTOs());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getRegionDTOs(), i);
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
        new org.apache.axis.description.TypeDesc(WsListadoRegionesOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoRegionesOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("regionDTOs");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RegionDTOs"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "RegionDTO"));
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
