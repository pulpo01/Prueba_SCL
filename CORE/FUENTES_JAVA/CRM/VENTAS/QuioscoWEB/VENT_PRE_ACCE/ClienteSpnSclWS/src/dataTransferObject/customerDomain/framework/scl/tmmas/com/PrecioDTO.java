/**
 * PrecioDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dataTransferObject.customerDomain.framework.scl.tmmas.com;

public class PrecioDTO  implements java.io.Serializable {
    private java.lang.String codigoConcepto;

    private dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosMigracionDTO datosAnexos;

    private java.lang.String descripcionConcepto;

    private java.lang.String fechaAplicacion;

    private java.lang.String indicadorAutMan;

    private float monto;

    private dataTransferObject.customerDomain.framework.scl.tmmas.com.MonedaDTO unidad;

    private java.lang.String valorMaximo;

    private java.lang.String valorMinimo;

    public PrecioDTO() {
    }

    public PrecioDTO(
           java.lang.String codigoConcepto,
           dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosMigracionDTO datosAnexos,
           java.lang.String descripcionConcepto,
           java.lang.String fechaAplicacion,
           java.lang.String indicadorAutMan,
           float monto,
           dataTransferObject.customerDomain.framework.scl.tmmas.com.MonedaDTO unidad,
           java.lang.String valorMaximo,
           java.lang.String valorMinimo) {
           this.codigoConcepto = codigoConcepto;
           this.datosAnexos = datosAnexos;
           this.descripcionConcepto = descripcionConcepto;
           this.fechaAplicacion = fechaAplicacion;
           this.indicadorAutMan = indicadorAutMan;
           this.monto = monto;
           this.unidad = unidad;
           this.valorMaximo = valorMaximo;
           this.valorMinimo = valorMinimo;
    }


    /**
     * Gets the codigoConcepto value for this PrecioDTO.
     * 
     * @return codigoConcepto
     */
    public java.lang.String getCodigoConcepto() {
        return codigoConcepto;
    }


    /**
     * Sets the codigoConcepto value for this PrecioDTO.
     * 
     * @param codigoConcepto
     */
    public void setCodigoConcepto(java.lang.String codigoConcepto) {
        this.codigoConcepto = codigoConcepto;
    }


    /**
     * Gets the datosAnexos value for this PrecioDTO.
     * 
     * @return datosAnexos
     */
    public dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosMigracionDTO getDatosAnexos() {
        return datosAnexos;
    }


    /**
     * Sets the datosAnexos value for this PrecioDTO.
     * 
     * @param datosAnexos
     */
    public void setDatosAnexos(dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosMigracionDTO datosAnexos) {
        this.datosAnexos = datosAnexos;
    }


    /**
     * Gets the descripcionConcepto value for this PrecioDTO.
     * 
     * @return descripcionConcepto
     */
    public java.lang.String getDescripcionConcepto() {
        return descripcionConcepto;
    }


    /**
     * Sets the descripcionConcepto value for this PrecioDTO.
     * 
     * @param descripcionConcepto
     */
    public void setDescripcionConcepto(java.lang.String descripcionConcepto) {
        this.descripcionConcepto = descripcionConcepto;
    }


    /**
     * Gets the fechaAplicacion value for this PrecioDTO.
     * 
     * @return fechaAplicacion
     */
    public java.lang.String getFechaAplicacion() {
        return fechaAplicacion;
    }


    /**
     * Sets the fechaAplicacion value for this PrecioDTO.
     * 
     * @param fechaAplicacion
     */
    public void setFechaAplicacion(java.lang.String fechaAplicacion) {
        this.fechaAplicacion = fechaAplicacion;
    }


    /**
     * Gets the indicadorAutMan value for this PrecioDTO.
     * 
     * @return indicadorAutMan
     */
    public java.lang.String getIndicadorAutMan() {
        return indicadorAutMan;
    }


    /**
     * Sets the indicadorAutMan value for this PrecioDTO.
     * 
     * @param indicadorAutMan
     */
    public void setIndicadorAutMan(java.lang.String indicadorAutMan) {
        this.indicadorAutMan = indicadorAutMan;
    }


    /**
     * Gets the monto value for this PrecioDTO.
     * 
     * @return monto
     */
    public float getMonto() {
        return monto;
    }


    /**
     * Sets the monto value for this PrecioDTO.
     * 
     * @param monto
     */
    public void setMonto(float monto) {
        this.monto = monto;
    }


    /**
     * Gets the unidad value for this PrecioDTO.
     * 
     * @return unidad
     */
    public dataTransferObject.customerDomain.framework.scl.tmmas.com.MonedaDTO getUnidad() {
        return unidad;
    }


    /**
     * Sets the unidad value for this PrecioDTO.
     * 
     * @param unidad
     */
    public void setUnidad(dataTransferObject.customerDomain.framework.scl.tmmas.com.MonedaDTO unidad) {
        this.unidad = unidad;
    }


    /**
     * Gets the valorMaximo value for this PrecioDTO.
     * 
     * @return valorMaximo
     */
    public java.lang.String getValorMaximo() {
        return valorMaximo;
    }


    /**
     * Sets the valorMaximo value for this PrecioDTO.
     * 
     * @param valorMaximo
     */
    public void setValorMaximo(java.lang.String valorMaximo) {
        this.valorMaximo = valorMaximo;
    }


    /**
     * Gets the valorMinimo value for this PrecioDTO.
     * 
     * @return valorMinimo
     */
    public java.lang.String getValorMinimo() {
        return valorMinimo;
    }


    /**
     * Sets the valorMinimo value for this PrecioDTO.
     * 
     * @param valorMinimo
     */
    public void setValorMinimo(java.lang.String valorMinimo) {
        this.valorMinimo = valorMinimo;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof PrecioDTO)) return false;
        PrecioDTO other = (PrecioDTO) obj;
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
            ((this.datosAnexos==null && other.getDatosAnexos()==null) || 
             (this.datosAnexos!=null &&
              this.datosAnexos.equals(other.getDatosAnexos()))) &&
            ((this.descripcionConcepto==null && other.getDescripcionConcepto()==null) || 
             (this.descripcionConcepto!=null &&
              this.descripcionConcepto.equals(other.getDescripcionConcepto()))) &&
            ((this.fechaAplicacion==null && other.getFechaAplicacion()==null) || 
             (this.fechaAplicacion!=null &&
              this.fechaAplicacion.equals(other.getFechaAplicacion()))) &&
            ((this.indicadorAutMan==null && other.getIndicadorAutMan()==null) || 
             (this.indicadorAutMan!=null &&
              this.indicadorAutMan.equals(other.getIndicadorAutMan()))) &&
            this.monto == other.getMonto() &&
            ((this.unidad==null && other.getUnidad()==null) || 
             (this.unidad!=null &&
              this.unidad.equals(other.getUnidad()))) &&
            ((this.valorMaximo==null && other.getValorMaximo()==null) || 
             (this.valorMaximo!=null &&
              this.valorMaximo.equals(other.getValorMaximo()))) &&
            ((this.valorMinimo==null && other.getValorMinimo()==null) || 
             (this.valorMinimo!=null &&
              this.valorMinimo.equals(other.getValorMinimo())));
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
        if (getDatosAnexos() != null) {
            _hashCode += getDatosAnexos().hashCode();
        }
        if (getDescripcionConcepto() != null) {
            _hashCode += getDescripcionConcepto().hashCode();
        }
        if (getFechaAplicacion() != null) {
            _hashCode += getFechaAplicacion().hashCode();
        }
        if (getIndicadorAutMan() != null) {
            _hashCode += getIndicadorAutMan().hashCode();
        }
        _hashCode += new Float(getMonto()).hashCode();
        if (getUnidad() != null) {
            _hashCode += getUnidad().hashCode();
        }
        if (getValorMaximo() != null) {
            _hashCode += getValorMaximo().hashCode();
        }
        if (getValorMinimo() != null) {
            _hashCode += getValorMinimo().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(PrecioDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "PrecioDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoConcepto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "CodigoConcepto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("datosAnexos");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "DatosAnexos"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "AtributosMigracionDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionConcepto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "DescripcionConcepto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fechaAplicacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "FechaAplicacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorAutMan");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "IndicadorAutMan"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("monto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Monto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("unidad");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Unidad"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "MonedaDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("valorMaximo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "ValorMaximo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("valorMinimo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "ValorMinimo"));
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
