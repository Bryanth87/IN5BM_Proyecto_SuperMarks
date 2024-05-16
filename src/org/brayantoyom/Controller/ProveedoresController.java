
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


public class ProveedoresController implements Initializable{
    
    private int op;
    private ObservableList<Proveedores> listaProveedores;
    private Main escenarioPrincipal;

    private enum operaciones {
        AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, NINGUNO
    }
    private operaciones tipoDeOperaciones = operaciones.NINGUNO;
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
    private TextField txtTelefonoProveedor;
    
    @FXML
    private TextField txtCorreoProveedor;

    @FXML
    private TableView tblProveedores;

    @FXML
    private TableColumn colCodigoProveedor;

    @FXML
    private TableColumn colNITProveedor;

    @FXML 
    private TableColumn colTelefonoProveedor;
    
    @FXML
    private TableColumn colCorreoProveedor;
    
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
        colNombresProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, Integer>("nombresProveedor"));
        colApellidosProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, Integer>("apellidosProveedor"));
        colNITProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, Integer>("NITProveedor"));
        colTelefonoProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, Integer>("telefonoProveedor"));
        colDireccionProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, Integer>("direccionProveedor"));
        colCorreoProveedor.setCellValueFactory(new PropertyValueFactory<Proveedores, Integer>("correoProveedor"));
        colRazonSocial.setCellValueFactory(new PropertyValueFactory<Proveedores, Integer>("razonSocial"));
        colContactoPrincipal.setCellValueFactory(new PropertyValueFactory<Proveedores, Integer>("contactoPrincipal"));
        colPaginaWeb.setCellValueFactory(new PropertyValueFactory<Proveedores, Integer>("paginaWeb"));
    }

    public void seleccionarElementos() {
        txtCodigoProveedor.setText(String.valueOf(((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getCodigoProveedor()));
        txtNombresProveedor.setText((((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getNombresProveedor()));
        txtApellidosProveedor.setText((((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getApellidosProveedor()));
        txtNITProveedor.setText((((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getNITProveedor()));
        txtTelefonoProveedor.setText((((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getTelefonoProveedor()));
        txtDireccionProveedor.setText((((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getDireccionProveedor()));
        txtCorreoProveedor.setText((((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getCorreoProveedor()));
        txtRazonSocial.setText((((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getRazonSocial()));
        txtContactoPrincipal.setText((((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getContactoPrincipal()));
        txtPaginaWeb.setText((((Proveedores) tblProveedores.getSelectionModel().getSelectedItem()).getPaginaWeb()));
    }

    public ObservableList<Proveedores> getProveedores() {
        ArrayList<Proveedores> lista = new ArrayList<>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarProveedores()}");
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
                guardar();
                desactivarControles();
                limpiarControles();
                cargarDatos();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReportes.setDisable(false);
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
                btnEditar.setDisable(true);
                btnReportes.setDisable(true);
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
            default:
                if (tblProveedores.getSelectionModel().getSelectedItem() != null) {
                    int respuesta = JOptionPane.showConfirmDialog(null, "Confirmar la eliminacion de registro",
                            "Eliminar Proveedores", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if (respuesta == JOptionPane.YES_NO_OPTION) {
                        try {
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_EliminarProveedor(?)}");
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
                    JOptionPane.showConfirmDialog(null, "Debe de seleccionar un proveedor para editar");
                }
                break;
            case ACTUALIZAR:
                actualizar();
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

    public void Reporte() {
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

    public void guardar() {
        Proveedores registro = new Proveedores();
        registro.setCodigoProveedor(Integer.parseInt(txtCodigoProveedor.getText()));
        registro.setNombresProveedor(txtNombresProveedor.getText());
        registro.setApellidosProveedor(txtApellidosProveedor.getText());
        registro.setNITProveedor(txtNITProveedor.getText());
        registro.setTelefonoProveedor(txtTelefonoProveedor.getText());
        registro.setDireccionProveedor(txtDireccionProveedor.getText());
        registro.setCorreoProveedor(txtCorreoProveedor.getText());
        registro.setRazonSocial(txtRazonSocial.getText());
        registro.setContactoPrincipal(txtContactoPrincipal.getText());
        registro.setPaginaWeb(txtPaginaWeb.getText());
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_AgregarProveedor(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            procedimiento.setInt(1, registro.getCodigoProveedor());
            procedimiento.setString(2, registro.getNombresProveedor());
            procedimiento.setString(3, registro.getApellidosProveedor());
            procedimiento.setString(4, registro.getNITProveedor());
            procedimiento.setString(5, registro.getTelefonoProveedor());
            procedimiento.setString(6, registro.getDireccionProveedor());
            procedimiento.setString(7, registro.getCorreoProveedor());
            procedimiento.setString(8, registro.getRazonSocial());
            procedimiento.setString(9, registro.getContactoPrincipal());
            procedimiento.setString(10, registro.getPaginaWeb());
            procedimiento.execute();
            listaProveedores.add(registro);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void actualizar() {
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ActualizarProveedores(?,?,?,?,?,?,?,?,?,?)}");
            Proveedores registro = (Proveedores) tblProveedores.getSelectionModel().getSelectedItem();
            registro.setNombresProveedor(txtNombresProveedor.getText());
            registro.setApellidosProveedor(txtApellidosProveedor.getText());
            registro.setNITProveedor(txtNITProveedor.getText());
            registro.setTelefonoProveedor(txtTelefonoProveedor.getText());
            registro.setDireccionProveedor(txtDireccionProveedor.getText());
            registro.setCorreoProveedor(txtCorreoProveedor.getText());
            registro.setRazonSocial(txtRazonSocial.getText());
            registro.setContactoPrincipal(txtContactoPrincipal.getText());
            registro.setPaginaWeb(txtPaginaWeb.getText());
            procedimiento.setInt(1, registro.getCodigoProveedor());
            procedimiento.setString(2, registro.getNombresProveedor());
            procedimiento.setString(3, registro.getApellidosProveedor());
            procedimiento.setString(4, registro.getNITProveedor());
            procedimiento.setString(5, registro.getTelefonoProveedor());
            procedimiento.setString(6, registro.getDireccionProveedor());
            procedimiento.setString(7, registro.getCorreoProveedor());
            procedimiento.setString(8, registro.getRazonSocial());
            procedimiento.setString(9, registro.getContactoPrincipal());
            procedimiento.setString(10, registro.getPaginaWeb());
            procedimiento.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void desactivarControles() {
        txtCodigoProveedor.setEditable(false);
        txtNombresProveedor.setEditable(false);
        txtApellidosProveedor.setEditable(false);
        txtNITProveedor.setEditable(false);
        txtTelefonoProveedor.setEditable(false);
        txtDireccionProveedor.setEditable(false);
        txtCorreoProveedor.setEditable(false);
        txtRazonSocial.setEditable(false);
        txtContactoPrincipal.setEditable(false);
        txtPaginaWeb.setEditable(false);
    }

    public void activarControles() {
        txtCodigoProveedor.setEditable(true);
        txtNombresProveedor.setEditable(true);
        txtApellidosProveedor.setEditable(true);
        txtNITProveedor.setEditable(true);
        txtTelefonoProveedor.setEditable(true);
        txtDireccionProveedor.setEditable(true);
        txtCorreoProveedor.setEditable(true);
        txtRazonSocial.setEditable(true);
        txtContactoPrincipal.setEditable(true);
        txtPaginaWeb.setEditable(true);
    }

    public void limpiarControles() {
        txtCodigoProveedor.clear();
        txtNombresProveedor.clear();
        txtApellidosProveedor.clear();
        txtNITProveedor.clear();
        txtTelefonoProveedor.clear();
        txtDireccionProveedor.clear();
        txtCorreoProveedor.clear();
        txtRazonSocial.clear();
        txtContactoPrincipal.clear();
        txtPaginaWeb.clear();
    }

    public Main getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Main escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
    @FXML
    public void handleButtonAction(ActionEvent event){
        if(event.getSource() == btnRegresar){
            escenarioPrincipal.menuPrincipalView();
        }
    }
}
