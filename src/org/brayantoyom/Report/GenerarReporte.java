
package org.brayantoyom.Report;

import java.io.InputStream;
import java.util.Map;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.view.JasperViewer;
import org.brayantoyom.db.Conexion;

public class GenerarReporte {
    public static void mostrarReporte(String nombreReporte, String titulo, Map parametro) {
        InputStream reporte = GenerarReporte.class.getResourceAsStream(nombreReporte);
        try {
            JasperReport reporteMaster = (JasperReport) JRLoader.loadObject(reporte);
            JasperPrint reporteView = JasperFillManager.fillReport(reporteMaster, parametro, Conexion.getInstance().getConexion());
            JasperViewer visor = new JasperViewer(reporteView);
            visor.setTitle(titulo);
            visor.setVisible(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

