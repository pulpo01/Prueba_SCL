/**
 * WsAgregaEliminaSSInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondeabonados.scl.cl.tmmas.com;

public class WsAgregaEliminaSSInDTO  implements java.io.Serializable {
    private java.lang.String codigoConcepto;

    private java.lang.String codigoNivel;

    private java.lang.String codigoServSupl;

    private java.lang.String codigoServicio;

    private java.lang.String descripcionServicioS;

    private java.lang.String duracion;

    public WsAgregaEliminaSSInDTO() {
    }

    public WsAgregaEliminaSSInDTO(
           java.lang.String codigoConcepto,
           java.lang.String codigoNivel,
           java.lang.String codigoServSupl,
           java.lang.String codigoServicio,
           java.lang.String descripcionServicioS,
           java.lang.String duracion) {
           this.codigoConcepto = codigoConcepto;
           this.codigoNivel = codigoNivel;
           this.codigoServSupl = codigoServSupl;
           this.codigoServicio = codigoServicio;
           this.descripcionServicioS = descripcionServicioS;
           this.duracion = duracion;
    }


    /**
     * Gets the codigoConcepto value for this WsAgregaEliminaSSInDTO.
     * 
     * @return codigoConcepto
     */
    public java.lang.String getCodigoConcepto() {
        return codigoConcepto;
    }


    /**
     * Sets the codigoConcepto value for this WsAgregaEliminaSSInDTO.
     * 
     * @param codigoConcepto
     */
    public void setCodigoConcepto(java.lang.String codigoConcepto) {
        this.codigoConcepto = codigoConcepto;
    }


    /**
     * Gets the codigoNivel value for this WsAgregaEliminaSSInDTO.
     * 
     * @return codigoNivel
     */
    public java.lang.String getCodigoNivel() {
        return codigoNivel;
    }


    /**
     * Sets the codigoNivel value for this WsAgregaEliminaSSInDTO.
     * 
     * @param codigoNivel
     */
    public void setCodigoNivel(java.lang.String codigoNivel) {
        this.codigoNivel = codigoNivel;
    }


    /**
     * Gets the codigoServSupl value for this WsAgregaEliminaSSInDTO.
     * 
     * @return codigoServSupl
     */
    public java.lang.String getCodigoServSupl() {
        return codigoServSupl;
    }


    /**
     * Sets the codigoServSupl value for this WsAgregaEliminaSSInDTO.
     * 
     * @param codigoServSupl
     */
    public void setCodigoServSupl(java.lang.String codigoServSupl) {
        this.codigoServSupl = codigoServSupl;
    }


    /**
     * Gets the codigoServicio value for this WsAgregaEliminaSSInDTO.
     * 
     * @return codigoServicio
     */
    public java.lang.String getCodigoServicio() {
        return codigoServicio;
    }


    /**
     * Sets the codigoServicio value for this WsAgregaEliminaSSInDTO.
     * 
     * @param codigoServicio
     */
    public void setCodigoServicio(java.lang.String codigoServicio) {
        this.codigoServicio = codigoServicio;
    }


    /**
     * Gets the descripcionServicioS value for this WsAgregaEliminaSSInDTO.
     * 
     * @return descripcionServicioS
     */
    public java.lang.String getDescripcionServicioS() {
        return descripcionServicioS;
    }


    /**
     * Sets the descripcionServicioS value for this WsAgregaEliminaSSInDTO.
     * 
     * @param descripcionServicioS
     */
    public void setDescripcionServicioS(java.lang.String descripcionServicioS) {
        this.descripcionServicioS = descripcionServicioS;
    }


    /**
     * Gets the duracion value for this WsAgregaEliminaSSInDTO.
     * 
     * @return duracion
     */
    public java.lang.String getDuracion() {
        return duracion;
    }


    /**
     * Sets the duracion value for this WsAgregaEliminaSSInDTO.
     * 
     * @param duracion
     */
    public void setDuracion(java.lang.String duracion) {
        this.duracion = duracion;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsAgregaEliminaSSInDTO)) return false;
        WsAgregaEliminaSSInDTO other = (WsAgregaEliminaSSInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoConcepto==null && other.getCodigoConcepto()==null) || 
             (this.codigoConcepto!=null &&
              this.codigoConcepto.equals(other.getCodigoConcepto()))) &&
            ((this.codigoNivel==null && other.getCodigoNivel()==null) || 
             (this.codigoNivel!=null &&
              this.codigoNivel.equals(other.getCodigoNivel()))) &&
            ((this.codigoServSupl==null && other.getCodigoServSupl()==null) || 
             (this.codigoServSupl!=null &&
              this.codigoServSupl.equals(other.getCodigoServSupl()))) &&
            ((this.codigoServicio==null && other.getCodigoServicio()==null) || 
             (this.codigoServicio!=null &&
              this.codigoServicio.equals(other.getCodigoServicio()))) &&
            ((this.descripcionServicioS==null && other.getDescripcionServicioS()==null) || 
             (this.descripcionServicioS!=null &&
              this.descripcionServicioS.equals(other.getDescripcionServicioS()))) &&
            ((this.duracion==null && other.getDuracion()==null) || 
             (this.duracion!=null &&
              this.duracion.equals(other.getDuracion())));
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
        if (getCodigoConcepto() != null) {
            _hashCode += getCodigoConcepto().hashCode();
        }
        if (getCodigoNivel() != null) {
            _hashCode += getCodigoNivel().hashCode();
        }
        if (getCodigoServSupl() != null) {
            _hashCode += getCodigoServSupl().hashCode();
        }
        if (getCodigoServicio() != null) {
            _hashCode += getCodigoServicio().hashCode();
        }
        if (getDescripcionServicioS() != null) {
            _hashCode += getDescripcionServicioS().hashCode();
        }
        if (getDuracion() != null) {
            _hashCode += getDuracion().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsAgregaEliminaSSInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsAgregaEliminaSSInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoConcepto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CodigoConcepto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoNivel");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CodigoNivel"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoServSupl");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CodigoServSupl"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoServicio");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CodigoServicio"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionServicioS");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "DescripcionServicioS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("duracion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "Duracion"));
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
