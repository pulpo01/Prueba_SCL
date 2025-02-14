/**
 * OutAbonadoPortadoDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondeabonados.scl.cl.tmmas.com;

public class OutAbonadoPortadoDTO  extends dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO  implements java.io.Serializable {
    private long indPortado;

    private java.lang.String resultadoTransaccion;

    public OutAbonadoPortadoDTO() {
    }

    public OutAbonadoPortadoDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           long indPortado,
           java.lang.String resultadoTransaccion) {
        super(
            codError,
            mensajseError);
        this.indPortado = indPortado;
        this.resultadoTransaccion = resultadoTransaccion;
    }


    /**
     * Gets the indPortado value for this OutAbonadoPortadoDTO.
     * 
     * @return indPortado
     */
    public long getIndPortado() {
        return indPortado;
    }


    /**
     * Sets the indPortado value for this OutAbonadoPortadoDTO.
     * 
     * @param indPortado
     */
    public void setIndPortado(long indPortado) {
        this.indPortado = indPortado;
    }


    /**
     * Gets the resultadoTransaccion value for this OutAbonadoPortadoDTO.
     * 
     * @return resultadoTransaccion
     */
    public java.lang.String getResultadoTransaccion() {
        return resultadoTransaccion;
    }


    /**
     * Sets the resultadoTransaccion value for this OutAbonadoPortadoDTO.
     * 
     * @param resultadoTransaccion
     */
    public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
        this.resultadoTransaccion = resultadoTransaccion;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof OutAbonadoPortadoDTO)) return false;
        OutAbonadoPortadoDTO other = (OutAbonadoPortadoDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            this.indPortado == other.getIndPortado() &&
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
        int _hashCode = super.hashCode();
        _hashCode += new Long(getIndPortado()).hashCode();
        if (getResultadoTransaccion() != null) {
            _hashCode += getResultadoTransaccion().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(OutAbonadoPortadoDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "OutAbonadoPortadoDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indPortado");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "IndPortado"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("resultadoTransaccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ResultadoTransaccion"));
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
