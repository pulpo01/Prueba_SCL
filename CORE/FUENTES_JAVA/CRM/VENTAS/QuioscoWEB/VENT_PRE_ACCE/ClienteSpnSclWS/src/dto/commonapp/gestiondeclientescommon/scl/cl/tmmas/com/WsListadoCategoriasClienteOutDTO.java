/**
 * WsListadoCategoriasClienteOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsListadoCategoriasClienteOutDTO  extends dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO  implements java.io.Serializable {
    private dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.ClienteDTO[] clienteDTOs;

    public WsListadoCategoriasClienteOutDTO() {
    }

    public WsListadoCategoriasClienteOutDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.ClienteDTO[] clienteDTOs) {
        super(
            codError,
            mensajseError);
        this.clienteDTOs = clienteDTOs;
    }


    /**
     * Gets the clienteDTOs value for this WsListadoCategoriasClienteOutDTO.
     * 
     * @return clienteDTOs
     */
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.ClienteDTO[] getClienteDTOs() {
        return clienteDTOs;
    }


    /**
     * Sets the clienteDTOs value for this WsListadoCategoriasClienteOutDTO.
     * 
     * @param clienteDTOs
     */
    public void setClienteDTOs(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.ClienteDTO[] clienteDTOs) {
        this.clienteDTOs = clienteDTOs;
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.ClienteDTO getClienteDTOs(int i) {
        return this.clienteDTOs[i];
    }

    public void setClienteDTOs(int i, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.ClienteDTO _value) {
        this.clienteDTOs[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsListadoCategoriasClienteOutDTO)) return false;
        WsListadoCategoriasClienteOutDTO other = (WsListadoCategoriasClienteOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.clienteDTOs==null && other.getClienteDTOs()==null) || 
             (this.clienteDTOs!=null &&
              java.util.Arrays.equals(this.clienteDTOs, other.getClienteDTOs())));
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
        if (getClienteDTOs() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getClienteDTOs());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getClienteDTOs(), i);
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
        new org.apache.axis.description.TypeDesc(WsListadoCategoriasClienteOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoCategoriasClienteOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("clienteDTOs");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ClienteDTOs"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ClienteDTO"));
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
