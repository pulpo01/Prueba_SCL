/**
 * WsOutSSuplementariosDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondeabonados.scl.cl.tmmas.com;

public class WsOutSSuplementariosDTO  extends dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO  implements java.io.Serializable {
    private java.lang.String resultadoTransaccion;

    private dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.SSuplementariosDTO[] serviciosSuplementarios;

    public WsOutSSuplementariosDTO() {
    }

    public WsOutSSuplementariosDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           java.lang.String resultadoTransaccion,
           dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.SSuplementariosDTO[] serviciosSuplementarios) {
        super(
            codError,
            mensajseError);
        this.resultadoTransaccion = resultadoTransaccion;
        this.serviciosSuplementarios = serviciosSuplementarios;
    }


    /**
     * Gets the resultadoTransaccion value for this WsOutSSuplementariosDTO.
     * 
     * @return resultadoTransaccion
     */
    public java.lang.String getResultadoTransaccion() {
        return resultadoTransaccion;
    }


    /**
     * Sets the resultadoTransaccion value for this WsOutSSuplementariosDTO.
     * 
     * @param resultadoTransaccion
     */
    public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
        this.resultadoTransaccion = resultadoTransaccion;
    }


    /**
     * Gets the serviciosSuplementarios value for this WsOutSSuplementariosDTO.
     * 
     * @return serviciosSuplementarios
     */
    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.SSuplementariosDTO[] getServiciosSuplementarios() {
        return serviciosSuplementarios;
    }


    /**
     * Sets the serviciosSuplementarios value for this WsOutSSuplementariosDTO.
     * 
     * @param serviciosSuplementarios
     */
    public void setServiciosSuplementarios(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.SSuplementariosDTO[] serviciosSuplementarios) {
        this.serviciosSuplementarios = serviciosSuplementarios;
    }

    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.SSuplementariosDTO getServiciosSuplementarios(int i) {
        return this.serviciosSuplementarios[i];
    }

    public void setServiciosSuplementarios(int i, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.SSuplementariosDTO _value) {
        this.serviciosSuplementarios[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsOutSSuplementariosDTO)) return false;
        WsOutSSuplementariosDTO other = (WsOutSSuplementariosDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.resultadoTransaccion==null && other.getResultadoTransaccion()==null) || 
             (this.resultadoTransaccion!=null &&
              this.resultadoTransaccion.equals(other.getResultadoTransaccion()))) &&
            ((this.serviciosSuplementarios==null && other.getServiciosSuplementarios()==null) || 
             (this.serviciosSuplementarios!=null &&
              java.util.Arrays.equals(this.serviciosSuplementarios, other.getServiciosSuplementarios())));
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
        if (getResultadoTransaccion() != null) {
            _hashCode += getResultadoTransaccion().hashCode();
        }
        if (getServiciosSuplementarios() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getServiciosSuplementarios());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getServiciosSuplementarios(), i);
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
        new org.apache.axis.description.TypeDesc(WsOutSSuplementariosDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsOutSSuplementariosDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("resultadoTransaccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ResultadoTransaccion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("serviciosSuplementarios");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ServiciosSuplementarios"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "SSuplementariosDTO"));
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
