
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
import javax.swing.JOptionPane;
import org.brayantoyom.bean.Productos;
import org.brayantoyom.bean.Proveedores;
import org.brayantoyom.bean.TipoProducto;
import org.brayantoyom.db.Conexion;
import org.brayantoyom.system.Main;

public class ProductoController implements Initializable {

    private Main escenarioPrincipal;

    private enum operaciones {
        AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, REPORTE, NINGUNO
    }
    private operaciones tipoDeOperaciones = operaciones.NINGUNO;
    private ObservableList<Productos> listaProductos;
    private ObservableList<TipoProducto> listaTipoProducto;
    private ObservableList<Proveedores> listaProveedores;

    @FXML
    private TextField txtcodigoProducto;

    @FXML
    private TextField txtDescProducto;

    @FXML
    private TextField txtPrecioUnitario;

    @FXML
    private TextField txtPrecioDocena;

    @FXML
    private TextField txtPrecioMayor;

    @FXML
    private TextField txtExistencia;

    @FXML
    private ComboBox cmbcodigoTipoProducto;

    @FXML
    private ComboBox cmbcodigoProveedor;

    @FXML
    private TableColumn colcodigoProducto;

    @FXML
    private TableColumn colDescripProducto;

    @FXML
    private TableColumn colPrecioUnitario;

    @FXML
    private TableColumn colPrecioDocena;

    @FXML
    private TableColumn colPrecioMayor;

    @FXML
    private TableColumn colExistencia;

    @FXML
    private TableColumn colcodigoTipoProducto;

    @FXML
    private TableColumn colcodigoProveedor;
    
    @FXML
    private TableView tblProductos;

    @FXML
    private Button btnAgregar;

    @FXML
    private Button btnEditar;
    
    @FXML
    private Button btnEliminar;

    @FXML
    private Button btnReportes;

    @FXML
    private Button btnRegresar;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        cargarDatos();
        cmbcodigoTipoProducto.setItems(getTipoProductos());
        cmbcodigoProveedor.setItems(getProveedores());
    }

    public void cargarDatos() {
        tblProductos.setItems(getProductos());
        colcodigoProducto.setCellValueFactory(new PropertyValueFactory<Productos, String>("codigotProducto"));
        colDescripProducto.setCellValueFactory(new PropertyValueFactory<Productos, String>("descripProducto"));
        colPrecioUnitario.setCellValueFactory(new PropertyValueFactory<Productos, Double>("precioUnitario"));
        colPrecioDocena.setCellValueFactory(new PropertyValueFactory<Productos, Double>("precioDocena"));
        colPrecioMayor.setCellValueFactory(new PropertyValueFactory<Productos, Double>("precioMayor"));
        colExistencia.setCellValueFactory(new PropertyValueFactory<Productos, Integer>("existencia"));
        colcodigoTipoProducto.setCellValueFactory(new PropertyValueFactory<Productos, Integer>("codigoTipoProducto"));
        colcodigoProveedor.setCellValueFactory(new PropertyValueFactory<Productos, Integer>("codigoProveedor"));
    }

    public void seleccionarElementos() {
        txtcodigoProducto.setText((((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoProducto()));
        txtDescProducto.setText((((Productos) tblProductos.getSelectionModel().getSelectedItem()).getDescripProducto()));
        txtPrecioUnitario.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioUnitario()));
        txtPrecioDocena.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioDocena()));
        txtPrecioMayor.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioMayor()));
        txtExistencia.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getExistencia()));
        cmbcodigoTipoProducto.getSelectionModel().select(buscarTipoProducto(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoTipoProducto()));
        cmbcodigoProveedor.getSelectionModel().select(buscarProveedores(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoProveedor()));
    }

    public TipoProducto buscarTipoProducto(int codigoTipoProducto) {
        TipoProducto resultado = null;
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_buscarTipoProducto(?)}");
            procedimiento.setInt(1, codigoTipoProducto);
            ResultSet registro = procedimiento.executeQuery();
            while (registro.next()) {
                resultado = new TipoProducto(registro.getInt("codigoTipoProducto"),
                        registro.getString("descripcion")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultado;
    }

    public Proveedores buscarProveedores(int codigoProveedor) {
        Proveedores resultado = null;
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_buscarProveedor(?)}");
            procedimiento.setInt(1, codigoProveedor);
            ResultSet registro = procedimiento.executeQuery();
            while (registro.next()) {
                resultado = new Proveedores(registro.getInt("codigoProveedor"),
                        registro.getString("nombresProveedor"),
                        registro.getString("apellidosProveedor"),
                        registro.getString("NITProveedor"),
                        registro.getString("telefonoProveedor"),
                        registro.getString("direccionProveedor"),
                        registro.getString("correoProveedor"),
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

    public ObservableList<Productos> getProductos() {
        ArrayList<Productos> lista = new ArrayList<Productos>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_listarProductos()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Productos(resultado.getString("codigoProducto"),
                        resultado.getString("descripcProducto"),
                        resultado.getDouble("precioUnitario"),
                        resultado.getDouble("precioDocena"),
                        resultado.getDouble("existencia"),
                        resultado.getInt("existencia"),
                        resultado.getInt("codigoTipoProducto"),
                        resultado.getInt("codigoProveedor")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaProductos = FXCollections.observableList(lista);
    }
    
    public ObservableList<TipoProducto> getTipoProductos() {
        ArrayList<TipoProducto> lista = new ArrayList<>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_listarTipoProducto()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new TipoProducto(resultado.getInt("codigoTipoProducto"),
                        resultado.getString("descripcion")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaTipoProducto = FXCollections.observableList(lista);
    }

    public ObservableList<Proveedores> getProveedores() {
        ArrayList<Proveedores> lista = new ArrayList<>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_listarProveedores()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Proveedores(resultado.getInt("codigoProveedor"),
                        resultado.getString("nombresProveedor"),
                        resultado.getString("apellidosProveedor"),
                        resultado.getString("NITProveedor"),
                        resultado.getString("telefonoProveedor"),
                        resultado.getString("direccionProveedor"),
                        resultado.getString("correoProveedor"),
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

    public void desactivarControles() {
        txtcodigoProducto.setEditable(false);
        txtDescProducto.setEditable(false);
        txtPrecioUnitario.setEditable(false);
        txtPrecioDocena.setEditable(false);
        txtPrecioMayor.setEditable(false);
        txtExistencia.setEditable(false);
        cmbcodigoTipoProducto.setDisable(true);
        cmbcodigoProveedor.setDisable(true);
    }

    public void activarControles() {
        txtcodigoProducto.setEditable(true);
        txtDescProducto.setEditable(true);
        txtPrecioUnitario.setEditable(true);
        txtPrecioDocena.setEditable(true);
        txtPrecioMayor.setEditable(true);
        txtExistencia.setEditable(true);
        cmbcodigoTipoProducto.setDisable(false);
        cmbcodigoProveedor.setDisable(false);
    }

    public void limpiarControles() {
        txtcodigoProducto.clear();
        txtDescProducto.clear();
        txtPrecioUnitario.clear();
        txtPrecioDocena.clear();
        txtPrecioMayor.clear();
        txtExistencia.clear();
        tblProductos.getSelectionModel().getSelectedItem();
        cmbcodigoTipoProducto.getSelectionModel().getSelectedItem();
        cmbcodigoProveedor.getSelectionModel().getSelectedItem();

    }

    @FXML
    private void Agregar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                activarControles();
                btnAgregar.setText("Guardar");
                btnEliminar.setText("Cancelar");
                btnEditar.setDisable(true);
                btnReportes.setDisable(true);
                tipoDeOperaciones = operaciones.ACTUALIZAR;
                break;
            case ACTUALIZAR:
                Guardar();
                desactivarControles();
                limpiarControles();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReportes.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
                cargarDatos();
                break;
        }
    }

    public void Guardar() {
        Productos registro = new Productos();
        registro.setCodigoProducto(txtcodigoProducto.getText());
        registro.setDescripProducto(txtDescProducto.getText());
        registro.setPrecioUnitario(Double.parseDouble(txtPrecioUnitario.getText()));
        registro.setPrecioDocena(Double.parseDouble(txtPrecioDocena.getText()));
        registro.setPrecioMayor(Double.parseDouble(txtPrecioMayor.getText()));
        registro.setExistencia(Integer.parseInt(txtExistencia.getText()));
        registro.setCodigoTipoProducto((((TipoProducto) cmbcodigoTipoProducto.getSelectionModel().getSelectedItem()).getCodigoTipoProducto()));
        registro.setCodigoProveedor(((Proveedores) cmbcodigoProveedor.getSelectionModel().getSelectedItem()).getCodigoProveedor());
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{Call sp_agregarProductos(?,?,?,?,?,?,?,?)}");
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
    
    public void Actualizar() {
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ActualizarProductos(?,?,?,?,?,?,?,?)}");
            Productos registro = (Productos) tblProductos.getSelectionModel().getSelectedItem();
            registro.setDescripProducto(txtDescProducto.getText());
            registro.setPrecioUnitario(Double.parseDouble(txtPrecioUnitario.getText()));
            registro.setPrecioDocena(Double.parseDouble(txtPrecioDocena.getText()));
            registro.setPrecioMayor(Double.parseDouble(txtPrecioMayor.getText()));
            registro.setExistencia(Integer.parseInt(txtExistencia.getText()));
            registro.setCodigoTipoProducto((((TipoProducto) cmbcodigoTipoProducto.getSelectionModel().getSelectedItem()).getCodigoTipoProducto()));
            registro.setCodigoProveedor(((Proveedores) cmbcodigoProveedor.getSelectionModel().getSelectedItem()).getCodigoProveedor());
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

    @FXML
    private void Editar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                if (tblProductos.getSelectionModel().getSelectedItem() != null) {
                    btnEditar.setText("Actualizar");
                    btnReportes.setText("Cancelar");
                    btnAgregar.setDisable(true);
                    btnEliminar.setDisable(true);
                    activarControles();
                    txtcodigoProducto.setEditable(false);
                    tipoDeOperaciones = operaciones.ACTUALIZAR;
                } else {
                    JOptionPane.showConfirmDialog(null, "Primero seleccione un producto para eliminar");
                }
                break;
            case ACTUALIZAR:
                Actualizar();
                btnEditar.setText("Editar");
                btnReportes.setText("Reporte");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                desactivarControles();
                limpiarControles();
                tipoDeOperaciones = operaciones.NINGUNO;
                cargarDatos();
                break;
        }
    }

    @FXML
    private void Eliminar() {
        switch (tipoDeOperaciones) {
            case ACTUALIZAR:
                desactivarControles();
                limpiarControles();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(true);
                btnReportes.setDisable(true);
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
            default:
                if (tblProductos.getSelectionModel().getSelectedItem() != null) {
                    int respuesta = JOptionPane.showConfirmDialog(null, "Seguro de la eliminación?",
                            "Eliminar Producto", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if (respuesta == JOptionPane.YES_NO_OPTION) {
                        try {
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_eliminarProductos(?)}");
                            procedimiento.setString(1, ((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoProducto());
                            procedimiento.execute();
                            listaProductos.remove(tblProductos.getSelectionModel().getSelectedItem());
                            limpiarControles();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    JOptionPane.showMessageDialog(null, "Primero seleccione un producto a eliminar");
                }
        }
    }

    @FXML
    private void Reporte() {
        switch (tipoDeOperaciones) {
            case ACTUALIZAR:
                desactivarControles();
                limpiarControles();
                btnReportes.setText("Reporte");
                btnEditar.setText("Editar");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
            case NINGUNO:
                break;
        }
    }

    public Main getEscenarioPrincipal() {
        return escenarioPrincipal;
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
