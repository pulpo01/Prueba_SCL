/**
 * SSuplementariosDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondeabonados.scl.cl.tmmas.com;

public class SSuplementariosDTO  implements java.io.Serializable {
    private java.lang.String codConceptoActiva;

    private java.lang.String codConceptoMensual;

    private java.lang.String codigoNivel;

    private java.lang.String codigoServSupl;

    private java.lang.String codigoServicio;

    private java.lang.String descripcionServicioS;

    private java.lang.String duracion;

    private java.lang.String importeActiva;

    private java.lang.String tarifaMensual;

    public SSuplementariosDTO() {
    }

    public SSuplementariosDTO(
           java.lang.String codConceptoActiva,
           java.lang.String codConceptoMensual,
           java.lang.String codigoNivel,
           java.lang.String codigoServSupl,
           java.lang.String codigoServicio,
           java.lang.String descripcionServicioS,
           java.lang.String duracion,
           java.lang.String importeActiva,
           java.lang.String tarifaMensual) {
           this.codConceptoActiva = codConceptoActiva;
           this.codConceptoMensual = codConceptoMensual;
           this.codigoNivel = codigoNivel;
           this.codigoServSupl = codigoServSupl;
           this.codigoServicio = codigoServicio;
           this.descripcionServicioS = descripcionServicioS;
           this.duracion = duracion;
           this.importeActiva = importeActiva;
           this.tarifaMensual = tarifaMensual;
    }


    /**
     * Gets the codConceptoActiva value for this SSuplementariosDTO.
     * 
     * @return codConceptoActiva
     */
    public java.lang.String getCodConceptoActiva() {
        return codConceptoActiva;
    }


    /**
     * Sets the codConceptoActiva value for this SSuplementariosDTO.
     * 
     * @param codConceptoActiva
     */
    public void setCodConceptoActiva(java.lang.String codConceptoActiva) {
        this.codConceptoActiva = codConceptoActiva;
    }


    /**
     * Gets the codConceptoMensual value for this SSuplementariosDTO.
     * 
     * @return codConceptoMensual
     */
    public java.lang.String getCodConceptoMensual() {
        return codConceptoMensual;
    }


    /**
     * Sets the codConceptoMensual value for this SSuplementariosDTO.
     * 
     * @param codConceptoMensual
     */
    public void setCodConceptoMensual(java.lang.String codConceptoMensual) {
        this.codConceptoMensual = codConceptoMensual;
    }


    /**
     * Gets the codigoNivel value for this SSuplementariosDTO.
     * 
     * @return codigoNivel
     */
    public java.lang.String getCodigoNivel() {
        return codigoNivel;
    }


    /**
     * Sets the codigoNivel value for this SSuplementariosDTO.
     * 
     * @param codigoNivel
     */
    public void setCodigoNivel(java.lang.String codigoNivel) {
        this.codigoNivel = codigoNivel;
    }


    /**
     * Gets the codigoServSupl value for this SSuplementariosDTO.
     * 
     * @return codigoServSupl
     */
    public java.lang.String getCodigoServSupl() {
        return codigoServSupl;
    }


    /**
     * Sets the codigoServSupl value for this SSuplementariosDTO.
     * 
     * @param codigoServSupl
     */
    public void setCodigoServSupl(java.lang.String codigoServSupl) {
        this.codigoServSupl = codigoServSupl;
    }


    /**
     * Gets the codigoServicio value for this SSuplementariosDTO.
     * 
     * @return codigoServicio
     */
    public java.lang.String getCodigoServicio() {
        return codigoServicio;
    }


    /**
     * Sets the codigoServicio value for this SSuplementariosDTO.
     * 
     * @param codigoServicio
     */
    public void setCodigoServicio(java.lang.String codigoServicio) {
        this.codigoServicio = codigoServicio;
    }


    /**
     * Gets the descripcionServicioS value for this SSuplementariosDTO.
     * 
     * @return descripcionServicioS
     */
    public java.lang.String getDescripcionServicioS() {
        return descripcionServicioS;
    }


    /**
     * Sets the descripcionServicioS value for this SSuplementariosDTO.
     * 
     * @param descripcionServicioS
     */
    public void setDescripcionServicioS(java.lang.String descripcionServicioS) {
        this.descripcionServicioS = descripcionServicioS;
    }


    /**
     * Gets the duracion value for this SSuplementariosDTO.
     * 
     * @return duracion
     */
    public java.lang.String getDuracion() {
        return duracion;
    }


    /**
     * Sets the duracion value for this SSuplementariosDTO.
     * 
     * @param duracion
     */
    public void setDuracion(java.lang.String duracion) {
        this.duracion = duracion;
    }


    /**
     * Gets the importeActiva value for this SSuplementariosDTO.
     * 
     * @return importeActiva
     */
    public java.lang.String getImporteActiva() {
        return importeActiva;
    }


    /**
     * Sets the importeActiva value for this SSuplementariosDTO.
     * 
     * @param importeActiva
     */
    public void setImporteActiva(java.lang.String importeActiva) {
        this.importeActiva = importeActiva;
    }


    /**
     * Gets the tarifaMensual value for this SSuplementariosDTO.
     * 
     * @return tarifaMensual
     */
    public java.lang.String getTarifaMensual() {
        return tarifaMensual;
    }


    /**
     * Sets the tarifaMensual value for this SSuplementariosDTO.
     * 
     * @param tarifaMensual
     */
    public void setTarifaMensual(java.lang.String tarifaMensual) {
        this.tarifaMensual = tarifaMensual;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof SSuplementariosDTO)) return false;
        SSuplementariosDTO other = (SSuplementariosDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codConceptoActiva==null && other.getCodConceptoActiva()==null) || 
             (this.codConceptoActiva!=null &&
              this.codConceptoActiva.equals(other.getCodConceptoActiva()))) &&
            ((this.codConceptoMensual==null && other.getCodConceptoMensual()==null) || 
             (this.codConceptoMensual!=null &&
              this.codConceptoMensual.equals(other.getCodConceptoMensual()))) &&
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
              this.duracion.equals(other.getDuracion()))) &&
            ((this.importeActiva==null && other.getImporteActiva()==null) || 
             (this.importeActiva!=null &&
              this.importeActiva.equals(other.getImporteActiva()))) &&
            ((this.tarifaMensual==null && other.getTarifaMensual()==null) || 
             (this.tarifaMensual!=null &&
              this.tarifaMensual.equals(other.getTarifaMensual())));
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
        if (getCodConceptoActiva() != null) {
            _hashCode += getCodConceptoActiva().hashCode();
        }
        if (getCodConceptoMensual() != null) {
            _hashCode += getCodConceptoMensual().hashCode();
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
        if (getImporteActiva() != null) {
            _hashCode += getImporteActiva().hashCode();
        }
        if (getTarifaMensual() != null) {
            _hashCode += getTarifaMensual().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(SSuplementariosDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "SSuplementariosDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codConceptoActiva");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CodConceptoActiva"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codConceptoMensual");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CodConceptoMensual"));
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
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("importeActiva");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ImporteActiva"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tarifaMensual");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "TarifaMensual"));
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
