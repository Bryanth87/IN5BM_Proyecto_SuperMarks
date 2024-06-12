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
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javax.swing.JOptionPane;
import org.brayantoyom.bean.Proveedores;
import org.brayantoyom.db.Conexion;
import org.brayantoyom.system.Main;

public class ProveedoresController implements Initializable {

    private Main escenarioPrincipal;
    private enum operaciones { AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, NINGUNO }
    private operaciones tipoDeOperaciones = operaciones.NINGUNO;

    @FXML
    ObservableList<Proveedores> listaProveedores;

    @FXML
    private Button btnRegresar;
    
    @FXML
    private TextField txtCodigoProveedor;

    @FXML
    private TextField txtNITProveedor;

    @FXML
    private TextField txtNombresProveedor;

    @FXML
    private TextField txtApellidosProveedor;

    @FXML
    private TextField txtDireccionProveedor;

    @FXML
    private TextField txtRazonSocial;

    @FXML
    private TextField txtContactoPrincipal;
    
    @FXML
    private TextField txtPaginaWeb;
    
    @FXML
    private TableView tblProveedores;

    @FXML
    private TableColumn colCodigoProveedor;

    @FXML
    private TableColumn colNITProveedor;

    @FXML
    private TableColumn colNombresProveedor;

    @FXML
    private TableColumn colApellidosProveedor;

    @FXML
    private TableColumn colDireccionProveedor;

    @FXML
    private TableColumn colRazonSocial;

    @FXML
    private TableColumn colContactoPrincipal;
    
    @FXML
    private TableColumn colPaginaWeb;

    @FXML
    private Button btnAgregar;

    @FXML
    private Button btnEliminar;

    @FXML
    private Button btnEditar;

    @FXML
    private Button btnReportes;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        cargarDatos();
    }

    public void cargarDatos() {
        tblProveedores.setItems(getProveedores());
        colCodigoProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, Integer>("codigoProveedor"));
        colNITProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, String>("NITProveedor"));
        colNombresProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, String>("nombresProveedor"));
        colApellidosProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, String>("apellidosProveedor"));
        colDireccionProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, String>("direccionProveedor"));
        colRazonSocial.setCellValueFactory(new PropertyValueFactory<Proveedores, String>("razonSocial"));
        colContactoPrincipal.setCellValueFactory(new PropertyValueFactory<Proveedores, String>("contactoPrincipal"));
        colPaginaWeb.setCellValueFactory(new PropertyValueFactory<Proveedores, String>("paginaWeb"));
    }

    public void seleccionarElemento() {
        txtCodigoProveedor.setText(String.valueOf(((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getCodigoProveedor()));
        txtNITProveedor.setText(String.valueOf(((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getNITProveedor()));
        txtNombresProveedor.setText(String.valueOf(((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getNombresProveedor()));
        txtApellidosProveedor.setText(String.valueOf(((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getApellidosProveedor()));
        txtDireccionProveedor.setText(String.valueOf(((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getDireccionProveedor()));
        txtRazonSocial.setText(String.valueOf(((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getRazonSocial()));
        txtContactoPrincipal.setText(String.valueOf(((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getContactoPrincipal()));
        txtPaginaWeb.setText(String.valueOf(((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getPaginaWeb()));
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

    public void Agregar() {
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
                cargarDatos();
                limpiarControles();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReportes.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
        }
    }

    public void Guardar() {
        Proveedores registro = new Proveedores();
        registro.setCodigoProveedor(Integer.parseInt(txtCodigoProveedor.getText()));
        registro.setNITProveedor(txtNITProveedor.getText());
        registro.setNombresProveedor(txtNombresProveedor.getText());
        registro.setApellidosProveedor(txtApellidosProveedor.getText());
        registro.setDireccionProveedor(txtDireccionProveedor.getText());
        registro.setRazonSocial(txtRazonSocial.getText());
        registro.setContactoPrincipal(txtContactoPrincipal.getText());
        registro.setPaginaWeb(txtPaginaWeb.getText());
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_agregarProveedores(?, ?, ?, ?, ?, ?, ?, ?)}");
            procedimiento.setInt(1, registro.getCodigoProveedor());
            procedimiento.setString(2, registro.getNITProveedor());
            procedimiento.setString(3, registro.getNombresProveedor());
            procedimiento.setString(4, registro.getApellidosProveedor());
            procedimiento.setString(5, registro.getDireccionProveedor());
            procedimiento.setString(6, registro.getRazonSocial());
            procedimiento.setString(7, registro.getContactoPrincipal());
            procedimiento.setString(8, registro.getPaginaWeb());
            procedimiento.execute();
            listaProveedores.add(registro);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
     public void Reporte() {
        switch (tipoDeOperaciones) {
            case ACTUALIZAR:
                desactivarControles();
                limpiarControles();
                btnEditar.setText("Editar");
                btnReportes.setText("Reporte");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
        }
    }


    public void Eliminar() {
        switch (tipoDeOperaciones) {
            case ACTUALIZAR:
                desactivarControles();
                limpiarControles();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReportes.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
            default:
                if (tblProveedores.getSelectionModel().getSelectedItem() != null) {
                    int respuesta = JOptionPane.showConfirmDialog(null, "Confirmar la eliminacion del registro",
                            "Eliminar Proveedores", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if (respuesta == JOptionPane.YES_OPTION) {
                        try {
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_eliminarProveedores(?)}");
                            procedimiento.setInt(1, ((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getCodigoProveedor());
                            procedimiento.execute();
                            listaProveedores.remove(tblProveedores.getSelectionModel().getSelectedItem());
                            limpiarControles();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    JOptionPane.showMessageDialog(null, "Debe de seleccionar un proveedor para eliminar");
                }
        }
    }

    public void Editar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                if (tblProveedores.getSelectionModel().getSelectedItem() != null) {
                    btnEditar.setText("Actualizar");
                    btnReportes.setText("Cancelar");
                    btnAgregar.setDisable(true);
                    btnEliminar.setDisable(true);
                    activarControles();
                    txtCodigoProveedor.setEditable(false);
                    tipoDeOperaciones = operaciones.ACTUALIZAR;
                } else {
                    JOptionPane.showMessageDialog(null, "Debe de seleccionar un proveedor para editar");
                }
                break;
            case ACTUALIZAR:
                Actualizar();
                btnEditar.setText("Editar");
                btnReportes.setText("Reporte");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
                cargarDatos();
                break;
        }
    }

    public void Actualizar() {
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_actualizarProveedores(?, ?, ?, ?, ?, ?, ?, ?)}");
            Proveedores registro = (Proveedores) tblProveedores.getSelectionModel().getSelectedItem();
            registro.setCodigoProveedor(Integer.parseInt(txtCodigoProveedor.getText()));
            registro.setNITProveedor(txtNITProveedor.getText());
            registro.setNombresProveedor(txtNombresProveedor.getText());
            registro.setApellidosProveedor(txtApellidosProveedor.getText());
            registro.setDireccionProveedor(txtDireccionProveedor.getText());
            registro.setRazonSocial(txtRazonSocial.getText());
            registro.setContactoPrincipal(txtContactoPrincipal.getText());
            registro.setPaginaWeb(txtPaginaWeb.getText());
            procedimiento.setInt(1, registro.getCodigoProveedor());
            procedimiento.setString(2, registro.getNITProveedor());
            procedimiento.setString(3, registro.getNombresProveedor());
            procedimiento.setString(4, registro.getApellidosProveedor());
            procedimiento.setString(5, registro.getDireccionProveedor());
            procedimiento.setString(6, registro.getRazonSocial());
            procedimiento.setString(7, registro.getContactoPrincipal());
            procedimiento.setString(8, registro.getPaginaWeb());
            procedimiento.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void desactivarControles() {
        txtCodigoProveedor.setEditable(false);
        txtNITProveedor.setEditable(false);
        txtNombresProveedor.setEditable(false);
        txtApellidosProveedor.setEditable(false);
        txtDireccionProveedor.setEditable(false);
        txtRazonSocial.setEditable(false);
        txtContactoPrincipal.setEditable(false);
        txtPaginaWeb.setEditable(false);
    }

    public void activarControles() {
        txtCodigoProveedor.setEditable(true);
        txtNITProveedor.setEditable(true);
        txtNombresProveedor.setEditable(true);
        txtApellidosProveedor.setEditable(true);
        txtDireccionProveedor.setEditable(true);
        txtRazonSocial.setEditable(true);
        txtContactoPrincipal.setEditable(true);
        txtPaginaWeb.setEditable(true);
    }

    public void limpiarControles() {
        txtCodigoProveedor.clear();
        txtNITProveedor.clear();
        txtNombresProveedor.clear();
        txtApellidosProveedor.clear();
        txtDireccionProveedor.clear();
        txtRazonSocial.clear();
        txtContactoPrincipal.clear();
        txtPaginaWeb.clear();
    }

    public void regresarMenuPrincipal(ActionEvent event) {
        escenarioPrincipal.menuPrincipalView();
    }

    public void setEscenarioPrincipal(Main escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
}
