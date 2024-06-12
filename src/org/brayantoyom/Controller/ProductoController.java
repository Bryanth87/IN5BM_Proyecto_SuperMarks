package org.brayantoyom.Controller;

import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javax.swing.JOptionPane;
import org.brayantoyom.Report.GenerarReporte;
import org.brayantoyom.bean.Productos;
import org.brayantoyom.bean.Proveedores;
import org.brayantoyom.bean.TipoProducto;
import org.brayantoyom.db.Conexion;
import org.brayantoyom.system.Main;

public class ProductoController implements Initializable {

    private Main escenarioPrincipal;
    private enum operaciones {
        AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, NINGUNO
    }
    private operaciones tipoDeOperaciones = operaciones.NINGUNO;
    private ObservableList<Productos> listaProductos;
    private ObservableList<Proveedores> listaProveedores;
    private ObservableList<TipoProducto> listaTipoProducto;

    @FXML
    private TextField txtCodigoProducto;
    @FXML
    private TextField txtDescProducto;
    @FXML
    private TextField txtPrecioUnitario;
    @FXML
    private TextField txtPrecioDocena;
    @FXML
    private TextField txtPrecioMayor;
    @FXML
    private TextField txtExistencias;
    @FXML
    private ComboBox<TipoProducto> cmbCodigoTipoProducto;
    @FXML
    private ComboBox<Proveedores> cmbCodProveedor;
    @FXML
    private TableColumn<Productos, String> colCodigoProd;
    @FXML
        private TableColumn<Productos, String> colDescripProd;
    @FXML
    private TableColumn<Productos, Double> colPrecioUnitario;
    @FXML
    private TableColumn<Productos, Double> colPrecioDocena;
    @FXML
    private TableColumn<Productos, Double> colPrecioMayor;
    @FXML
    private TableColumn<Productos, Integer> colExistencias;
    @FXML
    private TableColumn<Productos, Integer> colCodTipoProducto;
    @FXML
    private TableColumn<Productos, Integer> colCodProveedor;
    @FXML
    private TableView<Productos> tblProductos;
    @FXML
    private Button btnAgregar;
    @FXML
    private Button btnEditar;
    @FXML
    private Button btnEliminar;
    @FXML
    private Button btnReporte;
    @FXML
    private Button btnRegresar;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargarDatos();
        cmbCodigoTipoProducto.setItems(getTipoProducto());
        cmbCodProveedor.setItems(getProveedores());
    }

    public void cargarDatos() {
        tblProductos.setItems(getProducto());
        colCodigoProd.setCellValueFactory(new PropertyValueFactory<>("codigoProducto"));
        colDescripProd.setCellValueFactory(new PropertyValueFactory<>("descripcionProducto"));
        colPrecioUnitario.setCellValueFactory(new PropertyValueFactory<>("precioUnitario"));
        colPrecioDocena.setCellValueFactory(new PropertyValueFactory<>("precioDocena"));
        colPrecioMayor.setCellValueFactory(new PropertyValueFactory<>("precioMayor"));
        colExistencias.setCellValueFactory(new PropertyValueFactory<>("existencia"));
        colCodTipoProducto.setCellValueFactory(new PropertyValueFactory<>("codigoTipoProducto"));
        colCodProveedor.setCellValueFactory(new PropertyValueFactory<>("codigoProveedor"));
    }

    public void seleccionarElementos() {
        txtCodigoProducto.setText(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoProducto());
        txtDescProducto.setText(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getDescripcionProducto());
        txtPrecioUnitario.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioUnitario()));
        txtPrecioDocena.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioDocena()));
        txtPrecioMayor.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioMayor()));
        txtExistencias.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getExistencia()));
        cmbCodigoTipoProducto.getSelectionModel().select(buscarTipoProducto(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoTipoProducto()));
        cmbCodProveedor.getSelectionModel().select(buscarProveedores(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoProveedor()));
    }

    public TipoProducto buscarTipoProducto(int codigoTipoProducto) {
        TipoProducto resultado = null;
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_buscarTipoProducto(?)}");
            procedimiento.setInt(1, codigoTipoProducto);
            ResultSet registro = procedimiento.executeQuery();
            while (registro.next()) {
                resultado = new TipoProducto(registro.getInt("codigoTipoProducto"), registro.getString("descripcion"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultado;
    }

    public Proveedores buscarProveedores(int codigoProveedor) {
        Proveedores resultado = null;
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_buscarProveedores(?)}");
            procedimiento.setInt(1, codigoProveedor);
            ResultSet registro = procedimiento.executeQuery();
            while (registro.next()) {
                resultado = new Proveedores(
                        registro.getInt("codigoProveedor"),
                        registro.getString("NITProveedor"),
                        registro.getString("nombresProveedor"),
                        registro.getString("apellidosProveedor"),
                        registro.getString("direccionProveedor"),
                        registro.getString("razonSocial"),
                        registro.getString("contactoPrincipal"),
                        registro.getString("paginaWeb")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultado;
    }

    public ObservableList<Productos> getProducto() {
        ArrayList<Productos> lista = new ArrayList<>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_listarProductos()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Productos(
                        resultado.getString("codigoProducto"),
                        resultado.getString("descripcionProducto"),
                        resultado.getDouble("precioUnitario"),
                        resultado.getDouble("precioDocena"),
                        resultado.getDouble("precioMayor"),
                        resultado.getInt("existencia"),
                        resultado.getInt("codigoTipoProducto"),
                        resultado.getInt("codigoProveedor")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaProductos = FXCollections.observableArrayList(lista);
    }

    public ObservableList<Proveedores> getProveedores() {
        ArrayList<Proveedores> lista = new ArrayList<>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_listarProveedores()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Proveedores(
                        resultado.getInt("codigoProveedor"),
                        resultado.getString("NITProveedor"),
                        resultado.getString("nombresProveedor"),
                        resultado.getString("apellidosProveedor"),
                        resultado.getString("direccionProveedor"),
                        resultado.getString("razonSocial"),
                        resultado.getString("contactoPrincipal"),
                        resultado.getString("paginaWeb")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaProveedores = FXCollections.observableList(lista);
    }

    public ObservableList<TipoProducto> getTipoProducto() {
        ArrayList<TipoProducto> lista = new ArrayList<>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_listarTipoProducto()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new TipoProducto(resultado.getInt("codigoTipoProducto"), resultado.getString("descripcion")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaTipoProducto = FXCollections.observableList(lista);
    }

public void Agregar() {
    switch (tipoDeOperaciones) {
        case NINGUNO:
            activarControles();
            limpiarControles();
            btnAgregar.setText("Guardar");
            btnEliminar.setText("Cancelar");
            btnEditar.setDisable(true);
            btnReporte.setDisable(true);
            tipoDeOperaciones = operaciones.ACTUALIZAR;
            break;
        case ACTUALIZAR:
            if (validarEntradas()) {
                Guardar();
                desactivarControles();
                limpiarControles();
                cargarDatos();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
            } else {
                JOptionPane.showMessageDialog(null, "Por favor, complete todos los campos.");
            }
            break;
    }
}

private boolean validarEntradas() {
    return !txtCodigoProducto.getText().isEmpty() &&
           !txtDescProducto.getText().isEmpty() &&
           !txtPrecioUnitario.getText().isEmpty() &&
           !txtPrecioDocena.getText().isEmpty() &&
           !txtPrecioMayor.getText().isEmpty() &&
           !txtExistencias.getText().isEmpty() &&
           cmbCodigoTipoProducto.getSelectionModel().getSelectedItem() != null &&
           cmbCodProveedor.getSelectionModel().getSelectedItem() != null;
}

   public void Guardar() {
    Productos registro = new Productos();
    registro.setCodigoProducto(txtCodigoProducto.getText());
    registro.setDescripcionProducto(txtDescProducto.getText());
    registro.setPrecioUnitario(Double.parseDouble(txtPrecioUnitario.getText()));
    registro.setPrecioDocena(Double.parseDouble(txtPrecioDocena.getText()));
    registro.setPrecioMayor(Double.parseDouble(txtPrecioMayor.getText()));
    registro.setExistencia(Integer.parseInt(txtExistencias.getText()));
    registro.setCodigoTipoProducto(((TipoProducto) cmbCodigoTipoProducto.getSelectionModel().getSelectedItem()).getCodigoTipoProducto());
    registro.setCodigoProveedor(((Proveedores) cmbCodProveedor.getSelectionModel().getSelectedItem()).getCodigoProveedor());
    try {
        PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_agregarProductos(?,?,?,?,?,?,?,?)}");
        procedimiento.setString(1, registro.getCodigoProducto());
        procedimiento.setString(2, registro.getDescripcionProducto());
        procedimiento.setDouble(3, registro.getPrecioUnitario());
        procedimiento.setDouble(4, registro.getPrecioDocena());
        procedimiento.setDouble(5, registro.getPrecioMayor());
        procedimiento.setInt(6, registro.getExistencia());
        procedimiento.setInt(7, registro.getCodigoTipoProducto());
        procedimiento.setInt(8, registro.getCodigoProveedor());
        procedimiento.execute();
        listaProductos.add(registro);
        System.out.println("Producto agregado: " + registro);
    } catch (Exception e) {
        e.printStackTrace();
    }
}


    public void Eliminar() {
        if (tipoDeOperaciones == operaciones.ACTUALIZAR) {
            desactivarControles();
            limpiarControles();
            btnAgregar.setText("Agregar");
            btnEliminar.setText("Eliminar");
            btnEditar.setDisable(false);
            btnReporte.setDisable(false);
            tipoDeOperaciones = operaciones.NINGUNO;
        } else {
            tipoDeOperaciones = operaciones.ELIMINAR;
            if (tblProductos.getSelectionModel().getSelectedItem() != null) {
                int respuesta = JOptionPane.showConfirmDialog(null, "¿Está seguro de eliminar el registro?", "Eliminar Producto", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                if (respuesta == JOptionPane.YES_OPTION) {
                    try {
                        PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_eliminarProductos(?)}");
                        procedimiento.setString(1, ((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoProducto());
                        procedimiento.execute();
                        listaProductos.remove(tblProductos.getSelectionModel().getSelectedIndex());
                        limpiarControles();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } else {
                JOptionPane.showMessageDialog(null, "Debe seleccionar un elemento");
            }
        }
    }
    
    public void Reporte() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                imprimirReportes();
                break;
            case ACTUALIZAR:
                desactivarControles();
                limpiarControles();
                btnEditar.setText("Editar");
                btnReporte.setText("Reporte");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
        }
    }
    
        public void imprimirReportes(){
        Map parametros = new HashMap();
        parametros.put("codigoCliente", null);
        GenerarReporte.mostrarReporte("ReporteProducto.jasper", "Reporte de los Productos", parametros);
    }


    public void Editar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                if (tblProductos.getSelectionModel().getSelectedItem() != null) {
                    btnEditar.setText("Actualizar");
                    btnReporte.setText("Cancelar");
                    tipoDeOperaciones = operaciones.ACTUALIZAR;
                    btnAgregar.setDisable(true);
                    btnEliminar.setDisable(true);
                    activarControles();
                } else {
                    JOptionPane.showMessageDialog(null, "Debe seleccionar un elemento");
                }
                break;
            case ACTUALIZAR:
                Actualizar();
                btnEditar.setText("Editar");
                btnReporte.setText("Reporte");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                cargarDatos();
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
        }
    }

    public void Actualizar() {
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_actualizarProductos(?,?,?,?,?,?,?,?)}");
            Productos registro = (Productos) tblProductos.getSelectionModel().getSelectedItem();
            registro.setDescripcionProducto(txtDescProducto.getText());
            registro.setPrecioUnitario(Double.parseDouble(txtPrecioUnitario.getText()));
            registro.setPrecioDocena(Double.parseDouble(txtPrecioDocena.getText()));
            registro.setPrecioMayor(Double.parseDouble(txtPrecioMayor.getText()));
            registro.setExistencia(Integer.parseInt(txtExistencias.getText()));
            registro.setCodigoTipoProducto(((TipoProducto) cmbCodigoTipoProducto.getSelectionModel().getSelectedItem()).getCodigoTipoProducto());
            registro.setCodigoProveedor(((Proveedores) cmbCodProveedor.getSelectionModel().getSelectedItem()).getCodigoProveedor());
            procedimiento.setString(1, registro.getCodigoProducto());
            procedimiento.setString(2, registro.getDescripcionProducto());
            procedimiento.setDouble(3, registro.getPrecioUnitario());
            procedimiento.setDouble(4, registro.getPrecioDocena());
            procedimiento.setDouble(5, registro.getPrecioMayor());
            procedimiento.setInt(6, registro.getExistencia());
            procedimiento.setInt(7, registro.getCodigoTipoProducto());
            procedimiento.setInt(8, registro.getCodigoProveedor());
            procedimiento.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void desactivarControles() {
        txtCodigoProducto.setEditable(false);
        txtDescProducto.setEditable(false);
        txtPrecioUnitario.setEditable(false);
        txtPrecioDocena.setEditable(false);
        txtPrecioMayor.setEditable(false);
        txtExistencias.setEditable(false);
        cmbCodigoTipoProducto.setDisable(true);
        cmbCodProveedor.setDisable(true);
    }

    public void activarControles() {
        txtCodigoProducto.setEditable(true);
        txtDescProducto.setEditable(true);
        txtPrecioUnitario.setEditable(true);
        txtPrecioDocena.setEditable(true);
        txtPrecioMayor.setEditable(true);
        txtExistencias.setEditable(true);
        cmbCodigoTipoProducto.setDisable(false);
        cmbCodProveedor.setDisable(false);
    }

    public void limpiarControles() {
        txtCodigoProducto.clear();
        txtDescProducto.clear();
        txtPrecioUnitario.clear();
        txtPrecioDocena.clear();
        txtPrecioMayor.clear();
        txtExistencias.clear();
        cmbCodigoTipoProducto.getSelectionModel().clearSelection();
        cmbCodProveedor.getSelectionModel().clearSelection();
    }

    public void setEscenarioPrincipal(Main escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }

    @FXML
    public void handleButtonAction(ActionEvent event) {
        if (event.getSource() == btnRegresar) {
            escenarioPrincipal.menuPrincipalView();
        }
    }
}
