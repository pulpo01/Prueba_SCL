/**
 * ConceptoDireccionDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com;

public class ConceptoDireccionDTO  implements java.io.Serializable {
    private java.lang.String caption;

    private int codigoConcepto;

    private dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DatosDireccionDTO[] datosDireccionDTO;

    private java.lang.Integer identificadorConcepto;

    private int largoMaximo;

    private java.lang.String nombreColumna;

    private int posicion;

    private java.lang.String tipoControl;

    private int valorPorDefecto;

    private boolean obligatoriedad;

    public ConceptoDireccionDTO() {
    }

    public ConceptoDireccionDTO(
           java.lang.String caption,
           int codigoConcepto,
           dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DatosDireccionDTO[] datosDireccionDTO,
           java.lang.Integer identificadorConcepto,
           int largoMaximo,
           java.lang.String nombreColumna,
           int posicion,
           java.lang.String tipoControl,
           int valorPorDefecto,
           boolean obligatoriedad) {
           this.caption = caption;
           this.codigoConcepto = codigoConcepto;
           this.datosDireccionDTO = datosDireccionDTO;
           this.identificadorConcepto = identificadorConcepto;
           this.largoMaximo = largoMaximo;
           this.nombreColumna = nombreColumna;
           this.posicion = posicion;
           this.tipoControl = tipoControl;
           this.valorPorDefecto = valorPorDefecto;
           this.obligatoriedad = obligatoriedad;
    }


    /**
     * Gets the caption value for this ConceptoDireccionDTO.
     * 
     * @return caption
     */
    public java.lang.String getCaption() {
        return caption;
    }


    /**
     * Sets the caption value for this ConceptoDireccionDTO.
     * 
     * @param caption
     */
    public void setCaption(java.lang.String caption) {
        this.caption = caption;
    }


    /**
     * Gets the codigoConcepto value for this ConceptoDireccionDTO.
     * 
     * @return codigoConcepto
     */
    public int getCodigoConcepto() {
        return codigoConcepto;
    }


    /**
     * Sets the codigoConcepto value for this ConceptoDireccionDTO.
     * 
     * @param codigoConcepto
     */
    public void setCodigoConcepto(int codigoConcepto) {
        this.codigoConcepto = codigoConcepto;
    }


    /**
     * Gets the datosDireccionDTO value for this ConceptoDireccionDTO.
     * 
     * @return datosDireccionDTO
     */
    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DatosDireccionDTO[] getDatosDireccionDTO() {
        return datosDireccionDTO;
    }


    /**
     * Sets the datosDireccionDTO value for this ConceptoDireccionDTO.
     * 
     * @param datosDireccionDTO
     */
    public void setDatosDireccionDTO(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DatosDireccionDTO[] datosDireccionDTO) {
        this.datosDireccionDTO = datosDireccionDTO;
    }

    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DatosDireccionDTO getDatosDireccionDTO(int i) {
        return this.datosDireccionDTO[i];
    }

    public void setDatosDireccionDTO(int i, dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DatosDireccionDTO _value) {
        this.datosDireccionDTO[i] = _value;
    }


    /**
     * Gets the identificadorConcepto value for this ConceptoDireccionDTO.
     * 
     * @return identificadorConcepto
     */
    public java.lang.Integer getIdentificadorConcepto() {
        return identificadorConcepto;
    }


    /**
     * Sets the identificadorConcepto value for this ConceptoDireccionDTO.
     * 
     * @param identificadorConcepto
     */
    public void setIdentificadorConcepto(java.lang.Integer identificadorConcepto) {
        this.identificadorConcepto = identificadorConcepto;
    }


    /**
     * Gets the largoMaximo value for this ConceptoDireccionDTO.
     * 
     * @return largoMaximo
     */
    public int getLargoMaximo() {
        return largoMaximo;
    }


    /**
     * Sets the largoMaximo value for this ConceptoDireccionDTO.
     * 
     * @param largoMaximo
     */
    public void setLargoMaximo(int largoMaximo) {
        this.largoMaximo = largoMaximo;
    }


    /**
     * Gets the nombreColumna value for this ConceptoDireccionDTO.
     * 
     * @return nombreColumna
     */
    public java.lang.String getNombreColumna() {
        return nombreColumna;
    }


    /**
     * Sets the nombreColumna value for this ConceptoDireccionDTO.
     * 
     * @param nombreColumna
     */
    public void setNombreColumna(java.lang.String nombreColumna) {
        this.nombreColumna = nombreColumna;
    }


    /**
     * Gets the posicion value for this ConceptoDireccionDTO.
     * 
     * @return posicion
     */
    public int getPosicion() {
        return posicion;
    }


    /**
     * Sets the posicion value for this ConceptoDireccionDTO.
     * 
     * @param posicion
     */
    public void setPosicion(int posicion) {
        this.posicion = posicion;
    }


    /**
     * Gets the tipoControl value for this ConceptoDireccionDTO.
     * 
     * @return tipoControl
     */
    public java.lang.String getTipoControl() {
        return tipoControl;
    }


    /**
     * Sets the tipoControl value for this ConceptoDireccionDTO.
     * 
     * @param tipoControl
     */
    public void setTipoControl(java.lang.String tipoControl) {
        this.tipoControl = tipoControl;
    }


    /**
     * Gets the valorPorDefecto value for this ConceptoDireccionDTO.
     * 
     * @return valorPorDefecto
     */
    public int getValorPorDefecto() {
        return valorPorDefecto;
    }


    /**
     * Sets the valorPorDefecto value for this ConceptoDireccionDTO.
     * 
     * @param valorPorDefecto
     */
    public void setValorPorDefecto(int valorPorDefecto) {
        this.valorPorDefecto = valorPorDefecto;
    }


    /**
     * Gets the obligatoriedad value for this ConceptoDireccionDTO.
     * 
     * @return obligatoriedad
     */
    public boolean isObligatoriedad() {
        return obligatoriedad;
    }


    /**
     * Sets the obligatoriedad value for this ConceptoDireccionDTO.
     * 
     * @param obligatoriedad
     */
    public void setObligatoriedad(boolean obligatoriedad) {
        this.obligatoriedad = obligatoriedad;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ConceptoDireccionDTO)) return false;
        ConceptoDireccionDTO other = (ConceptoDireccionDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.caption==null && other.getCaption()==null) || 
             (this.caption!=null &&
              this.caption.equals(other.getCaption()))) &&
            this.codigoConcepto == other.getCodigoConcepto() &&
            ((this.datosDireccionDTO==null && other.getDatosDireccionDTO()==null) || 
             (this.datosDireccionDTO!=null &&
              java.util.Arrays.equals(this.datosDireccionDTO, other.getDatosDireccionDTO()))) &&
            ((this.identificadorConcepto==null && other.getIdentificadorConcepto()==null) || 
             (this.identificadorConcepto!=null &&
              this.identificadorConcepto.equals(other.getIdentificadorConcepto()))) &&
            this.largoMaximo == other.getLargoMaximo() &&
            ((this.nombreColumna==null && other.getNombreColumna()==null) || 
             (this.nombreColumna!=null &&
              this.nombreColumna.equals(other.getNombreColumna()))) &&
            this.posicion == other.getPosicion() &&
            ((this.tipoControl==null && other.getTipoControl()==null) || 
             (this.tipoControl!=null &&
              this.tipoControl.equals(other.getTipoControl()))) &&
            this.valorPorDefecto == other.getValorPorDefecto() &&
            this.obligatoriedad == other.isObligatoriedad();
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
        if (getCaption() != null) {
            _hashCode += getCaption().hashCode();
        }
        _hashCode += getCodigoConcepto();
        if (getDatosDireccionDTO() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getDatosDireccionDTO());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getDatosDireccionDTO(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getIdentificadorConcepto() != null) {
            _hashCode += getIdentificadorConcepto().hashCode();
        }
        _hashCode += getLargoMaximo();
        if (getNombreColumna() != null) {
            _hashCode += getNombreColumna().hashCode();
        }
        _hashCode += getPosicion();
        if (getTipoControl() != null) {
            _hashCode += getTipoControl().hashCode();
        }
        _hashCode += getValorPorDefecto();
        _hashCode += (isObligatoriedad() ? Boolean.TRUE : Boolean.FALSE).hashCode();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(ConceptoDireccionDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ConceptoDireccionDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("caption");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "Caption"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoConcepto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CodigoConcepto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("datosDireccionDTO");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DatosDireccionDTO"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DatosDireccionDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("identificadorConcepto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "IdentificadorConcepto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("largoMaximo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "LargoMaximo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreColumna");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "NombreColumna"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("posicion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "Posicion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipoControl");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "TipoControl"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("valorPorDefecto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ValorPorDefecto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("obligatoriedad");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "Obligatoriedad"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        elemField.setNillable(false);
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
