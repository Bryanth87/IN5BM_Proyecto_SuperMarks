package org.brayantoyom.Controller;

import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javax.swing.JOptionPane;
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
    private TextField txtCodigoProd;
    @FXML
    private TextField txtDescPro;
    @FXML
    private TextField txtPrecioUPro;
    @FXML
    private TextField txtPrecioDPro;
    @FXML
    private TextField txtPrecioMPro;
    @FXML
    private TextField txtExistenciaPro;
    @FXML
    private ComboBox<TipoProducto> cmbCodigoTipoP;
    @FXML
    private ComboBox<Proveedores> cmbCodProvPro;
    @FXML
    private TableColumn<Productos, String> colCodProd;
    @FXML
    private TableColumn<Productos, String> colDescProd;
    @FXML
    private TableColumn<Productos, Double> colPrecioU;
    @FXML
    private TableColumn<Productos, Double> colPrecioD;
    @FXML
    private TableColumn<Productos, Double> colPrecioM;
    @FXML
    private TableColumn<Productos, Integer> colExistencia;
    @FXML
    private TableColumn<Productos, Integer> colCodTipoProd;
    @FXML
    private TableColumn<Productos, Integer> colCodProv;
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
    @FXML
    private ImageView imgAgregar;
    @FXML
    private ImageView imgEliminar;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargarDatos();
        cmbCodigoTipoP.setItems(getTipoProducto());
        cmbCodProvPro.setItems(getProveedores());
    }

    public void cargarDatos() {
        tblProductos.setItems(getProducto());
        colCodProd.setCellValueFactory(new PropertyValueFactory<>("codigoProducto"));
        colDescProd.setCellValueFactory(new PropertyValueFactory<>("descripProducto"));
        colPrecioU.setCellValueFactory(new PropertyValueFactory<>("precioUnitario"));
        colPrecioD.setCellValueFactory(new PropertyValueFactory<>("precioDocena"));
        colPrecioM.setCellValueFactory(new PropertyValueFactory<>("precioMayor"));
        colExistencia.setCellValueFactory(new PropertyValueFactory<>("existencia"));
        colCodTipoProd.setCellValueFactory(new PropertyValueFactory<>("codigoTipoProducto"));
        colCodProv.setCellValueFactory(new PropertyValueFactory<>("codigoProveedor"));
    }

    public void seleccionarElementos() {
        txtCodigoProd.setText(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoProducto());
        txtDescPro.setText(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getDescripProducto());
        txtPrecioUPro.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioUnitario()));
        txtPrecioDPro.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioDocena()));
        txtPrecioMPro.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioMayor()));
        txtExistenciaPro.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getExistencia()));
        cmbCodigoTipoP.getSelectionModel().select(buscarTipoProducto(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoTipoProducto()));
        cmbCodProvPro.getSelectionModel().select(buscarProveedores(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoProveedor()));
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
                btnAgregar.setText("Guardar");
                btnEliminar.setText("Cancelar");
                btnEditar.setDisable(true);
                btnReporte.setDisable(true);
                tipoDeOperaciones = operaciones.ACTUALIZAR;
                break;
            case ACTUALIZAR:
                Guardar();
                desactivarControles();
                cargarDatos();
                limpiarControles();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("eliminar");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                imgAgregar.setImage(new Image("/org/danieltuy/images/Agregar.png"));
                imgEliminar.setImage(new Image("/org/danieltuy/images/Eliminar.png"));
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
        }
    }

    public void Guardar() {
        Productos registro = new Productos();
        registro.setCodigoProducto(txtCodigoProd.getText());
        registro.setDescripProducto(txtDescPro.getText());
        registro.setPrecioUnitario(Double.parseDouble(txtPrecioUPro.getText()));
        registro.setPrecioDocena(Double.parseDouble(txtPrecioDPro.getText()));
        registro.setPrecioMayor(Double.parseDouble(txtPrecioMPro.getText()));
        registro.setExistencia(Integer.parseInt(txtExistenciaPro.getText()));
        registro.setCodigoTipoProducto(((TipoProducto) cmbCodigoTipoP.getSelectionModel().getSelectedItem()).getCodigoTipoProducto());
        registro.setCodigoProveedor(((Proveedores) cmbCodProvPro.getSelectionModel().getSelectedItem()).getCodigoProveedor());
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_AgregarProducto(?,?,?,?,?,?,?,?)}");
            procedimiento.setString(1, registro.getCodigoProducto());
            procedimiento.setString(2, registro.getDescripProducto());
            procedimiento.setDouble(3, registro.getPrecioUnitario());
            procedimiento.setDouble(4, registro.getPrecioDocena());
            procedimiento.setDouble(5, registro.getPrecioMayor());
            procedimiento.setInt(6, registro.getExistencia());
            procedimiento.setInt(7, registro.getCodigoTipoProducto());
            procedimiento.setInt(8, registro.getCodigoProveedor());
            procedimiento.execute();
            listaProductos.add(registro);
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
                        PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_EliminarProducto(?)}");
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
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ActualizarProducto(?,?,?,?,?,?,?,?)}");
            Productos registro = (Productos) tblProductos.getSelectionModel().getSelectedItem();
            registro.setDescripProducto(txtDescPro.getText());
            registro.setPrecioUnitario(Double.parseDouble(txtPrecioUPro.getText()));
            registro.setPrecioDocena(Double.parseDouble(txtPrecioDPro.getText()));
            registro.setPrecioMayor(Double.parseDouble(txtPrecioMPro.getText()));
            registro.setExistencia(Integer.parseInt(txtExistenciaPro.getText()));
            registro.setCodigoTipoProducto(((TipoProducto) cmbCodigoTipoP.getSelectionModel().getSelectedItem()).getCodigoTipoProducto());
            registro.setCodigoProveedor(((Proveedores) cmbCodProvPro.getSelectionModel().getSelectedItem()).getCodigoProveedor());
            procedimiento.setString(1, registro.getCodigoProducto());
            procedimiento.setString(2, registro.getDescripProducto());
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
        txtCodigoProd.setEditable(false);
        txtDescPro.setEditable(false);
        txtPrecioUPro.setEditable(false);
        txtPrecioDPro.setEditable(false);
        txtPrecioMPro.setEditable(false);
        txtExistenciaPro.setEditable(false);
        cmbCodigoTipoP.setDisable(true);
        cmbCodProvPro.setDisable(true);
    }

    public void activarControles() {
        txtCodigoProd.setEditable(true);
        txtDescPro.setEditable(true);
        txtPrecioUPro.setEditable(true);
        txtPrecioDPro.setEditable(true);
        txtPrecioMPro.setEditable(true);
        txtExistenciaPro.setEditable(true);
        cmbCodigoTipoP.setDisable(false);
        cmbCodProvPro.setDisable(false);
    }

    public void limpiarControles() {
        txtCodigoProd.clear();
        txtDescPro.clear();
        txtPrecioUPro.clear();
        txtPrecioDPro.clear();
        txtPrecioMPro.clear();
        txtExistenciaPro.clear();
        cmbCodigoTipoP.getSelectionModel().clearSelection();
        cmbCodProvPro.getSelectionModel().clearSelection();
    }

    public void regresarMenuPrincipal() {
        escenarioPrincipal.menuPrincipalView();
    }

    public void setEscenarioPrincipal(Main escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
}
