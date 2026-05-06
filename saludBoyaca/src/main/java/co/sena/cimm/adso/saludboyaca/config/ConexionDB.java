package co.sena.cimm.adso.saludboyaca.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {


    private static final String HOST = "trolley.proxy.rlwy.net";
    private static final String PUERTO = "55290";
    private static final String DATABASE = "railway";

    private static final String URL = "jdbc:mysql://" + HOST + ":" + PUERTO + "/" + DATABASE 
            + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    private static final String USUARIO = "root";
    private static final String PASSWORD = "EzvoJQPIeHhRuNcPMqyLJejZwwssWwNs";

    public static Connection getConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection(URL, USUARIO, PASSWORD);

        } catch (ClassNotFoundException e) {
            throw new SQLException("Error: No se encontró el driver de MySQL", e);
        } catch (SQLException e) {
            throw new SQLException("Error de conexión MySQL: " + e.getMessage(), e);
        }
    }
}