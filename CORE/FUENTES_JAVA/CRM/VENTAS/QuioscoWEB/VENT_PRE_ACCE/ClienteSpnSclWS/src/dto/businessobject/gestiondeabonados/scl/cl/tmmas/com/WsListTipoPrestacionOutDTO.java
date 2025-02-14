/**
 * WsListTipoPrestacionOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondeabonados.scl.cl.tmmas.com;

public class WsListTipoPrestacionOutDTO  extends dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO  implements java.io.Serializable {
    private dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.TipoPrestacionDTO[] tipoPrestacionDTO;

    public WsListTipoPrestacionOutDTO() {
    }

    public WsListTipoPrestacionOutDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.TipoPrestacionDTO[] tipoPrestacionDTO) {
        super(
            codError,
            mensajseError);
        this.tipoPrestacionDTO = tipoPrestacionDTO;
    }


    /**
     * Gets the tipoPrestacionDTO value for this WsListTipoPrestacionOutDTO.
     * 
     * @return tipoPrestacionDTO
     */
    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.TipoPrestacionDTO[] getTipoPrestacionDTO() {
        return tipoPrestacionDTO;
    }


    /**
     * Sets the tipoPrestacionDTO value for this WsListTipoPrestacionOutDTO.
     * 
     * @param tipoPrestacionDTO
     */
    public void setTipoPrestacionDTO(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.TipoPrestacionDTO[] tipoPrestacionDTO) {
        this.tipoPrestacionDTO = tipoPrestacionDTO;
    }

    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.TipoPrestacionDTO getTipoPrestacionDTO(int i) {
        return this.tipoPrestacionDTO[i];
    }

    public void setTipoPrestacionDTO(int i, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.TipoPrestacionDTO _value) {
        this.tipoPrestacionDTO[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsListTipoPrestacionOutDTO)) return false;
        WsListTipoPrestacionOutDTO other = (WsListTipoPrestacionOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.tipoPrestacionDTO==null && other.getTipoPrestacionDTO()==null) || 
             (this.tipoPrestacionDTO!=null &&
              java.util.Arrays.equals(this.tipoPrestacionDTO, other.getTipoPrestacionDTO())));
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
        if (getTipoPrestacionDTO() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getTipoPrestacionDTO());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getTipoPrestacionDTO(), i);
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
        new org.apache.axis.description.TypeDesc(WsListTipoPrestacionOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsListTipoPrestacionOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipoPrestacionDTO");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "TipoPrestacionDTO"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "TipoPrestacionDTO"));
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
