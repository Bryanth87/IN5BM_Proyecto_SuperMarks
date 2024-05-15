package org.brayantoyom.bean;

public class TipoProducto {

    private int IDTipoProducto;
    private String descripcion;

    public TipoProducto() {
    }

    public TipoProducto(int IDTipoProducto, String descripcion) {
        this.IDTipoProducto = IDTipoProducto;
        this.descripcion = descripcion;
    }

    public int getIDTipoProducto() {
        return IDTipoProducto;
    }

    public void setIDTipoProducto(int IDTipoProducto) {
        this.IDTipoProducto = IDTipoProducto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
