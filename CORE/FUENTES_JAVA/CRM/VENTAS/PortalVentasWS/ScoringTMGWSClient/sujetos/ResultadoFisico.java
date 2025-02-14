/**
 * ResultadoFisico.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package sujetos;

public class ResultadoFisico  implements java.io.Serializable {
    private java.lang.String mensaje;

    private java.lang.String referencia;

    private java.lang.String clasificacion;

    private java.lang.String punteo;

    private java.lang.String documentosRequeridos;

    private java.lang.String documentosOpcionales;

    public ResultadoFisico() {
    }

    public ResultadoFisico(
           java.lang.String mensaje,
           java.lang.String referencia,
           java.lang.String clasificacion,
           java.lang.String punteo,
           java.lang.String documentosRequeridos,
           java.lang.String documentosOpcionales) {
           this.mensaje = mensaje;
           this.referencia = referencia;
           this.clasificacion = clasificacion;
           this.punteo = punteo;
           this.documentosRequeridos = documentosRequeridos;
           this.documentosOpcionales = documentosOpcionales;
    }


    /**
     * Gets the mensaje value for this ResultadoFisico.
     * 
     * @return mensaje
     */
    public java.lang.String getMensaje() {
        return mensaje;
    }


    /**
     * Sets the mensaje value for this ResultadoFisico.
     * 
     * @param mensaje
     */
    public void setMensaje(java.lang.String mensaje) {
        this.mensaje = mensaje;
    }


    /**
     * Gets the referencia value for this ResultadoFisico.
     * 
     * @return referencia
     */
    public java.lang.String getReferencia() {
        return referencia;
    }


    /**
     * Sets the referencia value for this ResultadoFisico.
     * 
     * @param referencia
     */
    public void setReferencia(java.lang.String referencia) {
        this.referencia = referencia;
    }


    /**
     * Gets the clasificacion value for this ResultadoFisico.
     * 
     * @return clasificacion
     */
    public java.lang.String getClasificacion() {
        return clasificacion;
    }


    /**
     * Sets the clasificacion value for this ResultadoFisico.
     * 
     * @param clasificacion
     */
    public void setClasificacion(java.lang.String clasificacion) {
        this.clasificacion = clasificacion;
    }


    /**
     * Gets the punteo value for this ResultadoFisico.
     * 
     * @return punteo
     */
    public java.lang.String getPunteo() {
        return punteo;
    }


    /**
     * Sets the punteo value for this ResultadoFisico.
     * 
     * @param punteo
     */
    public void setPunteo(java.lang.String punteo) {
        this.punteo = punteo;
    }


    /**
     * Gets the documentosRequeridos value for this ResultadoFisico.
     * 
     * @return documentosRequeridos
     */
    public java.lang.String getDocumentosRequeridos() {
        return documentosRequeridos;
    }


    /**
     * Sets the documentosRequeridos value for this ResultadoFisico.
     * 
     * @param documentosRequeridos
     */
    public void setDocumentosRequeridos(java.lang.String documentosRequeridos) {
        this.documentosRequeridos = documentosRequeridos;
    }


    /**
     * Gets the documentosOpcionales value for this ResultadoFisico.
     * 
     * @return documentosOpcionales
     */
    public java.lang.String getDocumentosOpcionales() {
        return documentosOpcionales;
    }


    /**
     * Sets the documentosOpcionales value for this ResultadoFisico.
     * 
     * @param documentosOpcionales
     */
    public void setDocumentosOpcionales(java.lang.String documentosOpcionales) {
        this.documentosOpcionales = documentosOpcionales;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ResultadoFisico)) return false;
        ResultadoFisico other = (ResultadoFisico) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.mensaje==null && other.getMensaje()==null) || 
             (this.mensaje!=null &&
              this.mensaje.equals(other.getMensaje()))) &&
            ((this.referencia==null && other.getReferencia()==null) || 
             (this.referencia!=null &&
              this.referencia.equals(other.getReferencia()))) &&
            ((this.clasificacion==null && other.getClasificacion()==null) || 
             (this.clasificacion!=null &&
              this.clasificacion.equals(other.getClasificacion()))) &&
            ((this.punteo==null && other.getPunteo()==null) || 
             (this.punteo!=null &&
              this.punteo.equals(other.getPunteo()))) &&
            ((this.documentosRequeridos==null && other.getDocumentosRequeridos()==null) || 
             (this.documentosRequeridos!=null &&
              this.documentosRequeridos.equals(other.getDocumentosRequeridos()))) &&
            ((this.documentosOpcionales==null && other.getDocumentosOpcionales()==null) || 
             (this.documentosOpcionales!=null &&
              this.documentosOpcionales.equals(other.getDocumentosOpcionales())));
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
        if (getMensaje() != null) {
            _hashCode += getMensaje().hashCode();
        }
        if (getReferencia() != null) {
            _hashCode += getReferencia().hashCode();
        }
        if (getClasificacion() != null) {
            _hashCode += getClasificacion().hashCode();
        }
        if (getPunteo() != null) {
            _hashCode += getPunteo().hashCode();
        }
        if (getDocumentosRequeridos() != null) {
            _hashCode += getDocumentosRequeridos().hashCode();
        }
        if (getDocumentosOpcionales() != null) {
            _hashCode += getDocumentosOpcionales().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(ResultadoFisico.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://sujetos", "ResultadoFisico"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("mensaje");
        elemField.setXmlName(new javax.xml.namespace.QName("", "mensaje"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("referencia");
        elemField.setXmlName(new javax.xml.namespace.QName("", "referencia"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("clasificacion");
        elemField.setXmlName(new javax.xml.namespace.QName("", "clasificacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("punteo");
        elemField.setXmlName(new javax.xml.namespace.QName("", "punteo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("documentosRequeridos");
        elemField.setXmlName(new javax.xml.namespace.QName("", "documentosRequeridos"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("documentosOpcionales");
        elemField.setXmlName(new javax.xml.namespace.QName("", "documentosOpcionales"));
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
