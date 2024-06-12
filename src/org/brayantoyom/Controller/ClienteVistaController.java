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
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javax.swing.JOptionPane;
import org.brayantoyom.Report.GenerarReporte;
import org.brayantoyom.bean.Clientes;
import org.brayantoyom.db.Conexion;
import org.brayantoyom.system.Main;

public class ClienteVistaController implements Initializable {

    private int op;
    private Main escenarioPrincipal;

    private enum operaciones {
        AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, NINGUNO
    }

    private ObservableList<Clientes> listaClientes;
    private operaciones tipoDeOperaciones = operaciones.NINGUNO;

    @FXML
    private Button btnRegresar;
    @FXML
    private TextField txtCodigoCliente;

    @FXML
    private TextField txtNombreCliente;

    @FXML
    private TextField txtApellidoCliente;

    @FXML
    private TextField txtNitCliente;

    @FXML
    private TextField txtDireccionCliente;

    @FXML
    private TextField txtTelefonoCliente;

    @FXML
    private TextField txtCorreoCliente;

    @FXML
    private TableView tblClientes;

    @FXML
    private TableColumn colCodigoCliente;

    @FXML
    private TableColumn colNitCliente;

    @FXML
    private TableColumn colApellidoCliente;

    @FXML
    private TableColumn colNombreCliente;

    @FXML
    private TableColumn colDireccionCliente;

    @FXML
    private TableColumn colTelefonoCliente;

    @FXML
    private TableColumn colCorreoCliente;

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
        tblClientes.setItems(getClientes());
        colCodigoCliente.setCellValueFactory(new PropertyValueFactory<Clientes, Integer>("codigoCliente"));
        colNombreCliente.setCellValueFactory(new PropertyValueFactory<Clientes, Integer>("nombresClientes"));
        colApellidoCliente.setCellValueFactory(new PropertyValueFactory<Clientes, Integer>("apellidosCliente"));
        colNitCliente.setCellValueFactory(new PropertyValueFactory<Clientes, Integer>("NITCliente"));
        colTelefonoCliente.setCellValueFactory(new PropertyValueFactory<Clientes, Integer>("telefonoCliente"));
        colDireccionCliente.setCellValueFactory(new PropertyValueFactory<Clientes, Integer>("direccionCliente"));
        colCorreoCliente.setCellValueFactory(new PropertyValueFactory<Clientes, Integer>("correoCliente"));
    }

    public void seleccionarElementos() {
        txtCodigoCliente.setText(String.valueOf(((Clientes) tblClientes.getSelectionModel().getSelectedItem()).getCodigoCliente()));
        txtNombreCliente.setText((((Clientes) tblClientes.getSelectionModel().getSelectedItem()).getNombresClientes()));
        txtApellidoCliente.setText((((Clientes) tblClientes.getSelectionModel().getSelectedItem()).getNombresClientes()));
        txtNitCliente.setText((((Clientes) tblClientes.getSelectionModel().getSelectedItem()).getNITCliente()));
        txtTelefonoCliente.setText((((Clientes) tblClientes.getSelectionModel().getSelectedItem()).getTelefonoCliente()));
        txtDireccionCliente.setText((((Clientes) tblClientes.getSelectionModel().getSelectedItem()).getDireccionCliente()));
        txtCorreoCliente.setText((((Clientes) tblClientes.getSelectionModel().getSelectedItem()).getCorreoCliente()));
    }

    public ObservableList<Clientes> getClientes() {
        ArrayList<Clientes> lista = new ArrayList<>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_listarClientes()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Clientes(resultado.getInt("codigoCliente"),
                        resultado.getString("nombresClientes"),
                        resultado.getString("apellidosCliente"),
                        resultado.getString("NITCliente"),
                        resultado.getString("telefonoCliente"),
                        resultado.getString("direccionCliente"),
                        resultado.getString("correoCliente")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaClientes = FXCollections.observableList(lista);
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

    public void Guardar() {
        Clientes registro = new Clientes();
        registro.setCodigoCliente(Integer.parseInt(txtCodigoCliente.getText()));
        registro.setNombresClientes(txtNombreCliente.getText());
        registro.setApellidosCliente(txtApellidoCliente.getText());
        registro.setNITCliente(txtNitCliente.getText());
        registro.setTelefonoCliente(txtTelefonoCliente.getText());
        registro.setDireccionCliente(txtDireccionCliente.getText());
        registro.setCorreoCliente(txtCorreoCliente.getText());
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_agregarClientes(?, ?, ?, ?, ?, ?, ?)}");
            procedimiento.setInt(1, registro.getCodigoCliente());
            procedimiento.setString(2, registro.getNombresClientes());
            procedimiento.setString(3, registro.getApellidosCliente());
            procedimiento.setString(4, registro.getNITCliente());
            procedimiento.setString(5, registro.getTelefonoCliente());
            procedimiento.setString(6, registro.getDireccionCliente());
            procedimiento.setString(7, registro.getCorreoCliente());
            procedimiento.execute();
            listaClientes.add(registro);
        } catch (Exception e) {
            e.printStackTrace();
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
                if (tblClientes.getSelectionModel().getSelectedItem() != null) {
                    int respuesta = JOptionPane.showConfirmDialog(null, "Confirmar la eliminacion de registro",
                            "Eliminar Clientes", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if (respuesta == JOptionPane.YES_NO_OPTION) {
                        try {
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_eliminarClientes(?)}");
                            procedimiento.setInt(1, ((Clientes) tblClientes.getSelectionModel().getSelectedItem()).getCodigoCliente());
                            procedimiento.execute();
                            listaClientes.remove(tblClientes.getSelectionModel().getSelectedItem());
                            limpiarControles();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    JOptionPane.showMessageDialog(null, "Primero seleccione un cliente para eliminar");
                }
        }
    }

    public void Editar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                if (tblClientes.getSelectionModel().getSelectedItem() != null) {
                    btnEditar.setText("Actualizar");
                    btnReportes.setText("Cancelar");
                    btnAgregar.setDisable(true);
                    btnEliminar.setDisable(true);
                    activarControles();
                    txtCodigoCliente.setEditable(false);
                    tipoDeOperaciones = operaciones.ACTUALIZAR;
                } else {
                    JOptionPane.showConfirmDialog(null, "Primero selccione un cliente para editar");
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
                imprimirReportes();
                break;
        }
    }
    
        public void imprimirReportes(){
        Map parametros = new HashMap();
        parametros.put("codigoCliente", null);
        GenerarReporte.mostrarReporte("ReporteCliente.jasper", "Reporte de los Clientes", parametros);
    }

    public void Actualizar() {
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_actualizarClientes(?,?,?,?,?,?,?)}");
            Clientes registro = (Clientes) tblClientes.getSelectionModel().getSelectedItem();
            registro.setNombresClientes(txtNombreCliente.getText());
            registro.setApellidosCliente(txtApellidoCliente.getText());
            registro.setNITCliente(txtNitCliente.getText());
            registro.setTelefonoCliente(txtTelefonoCliente.getText());
            registro.setDireccionCliente(txtDireccionCliente.getText());
            registro.setCorreoCliente(txtCorreoCliente.getText());
            procedimiento.setInt(1, registro.getCodigoCliente());
            procedimiento.setString(2, registro.getNombresClientes());
            procedimiento.setString(3, registro.getApellidosCliente());
            procedimiento.setString(4, registro.getNITCliente());
            procedimiento.setString(5, registro.getTelefonoCliente());
            procedimiento.setString(6, registro.getDireccionCliente());
            procedimiento.setString(7, registro.getCorreoCliente());
            procedimiento.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void desactivarControles() {
        txtCodigoCliente.setEditable(false);
        txtNombreCliente.setEditable(false);
        txtApellidoCliente.setEditable(false);
        txtDireccionCliente.setEditable(false);
        txtNitCliente.setEditable(false);
        txtTelefonoCliente.setEditable(false);
        txtCorreoCliente.setEditable(false);
    }

    public void activarControles() {
        txtCodigoCliente.setEditable(true);
        txtNombreCliente.setEditable(true);
        txtApellidoCliente.setEditable(true);
        txtDireccionCliente.setEditable(true);
        txtNitCliente.setEditable(true);
        txtTelefonoCliente.setEditable(true);
        txtCorreoCliente.setEditable(true);
    }

    public void limpiarControles() {
        txtCodigoCliente.clear();
        txtNombreCliente.clear();
        txtApellidoCliente.clear();
        txtDireccionCliente.clear();
        txtNitCliente.clear();
        txtTelefonoCliente.clear();
        txtCorreoCliente.clear();
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
