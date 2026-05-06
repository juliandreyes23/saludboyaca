/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.config.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author julia
 */
public class OTPTokenDAOImpl implements OTPTokenDAO{

    @Override
    public boolean insertar(int idUsuario, String token) {
        String sql = "INSERT INTO otp_tokens (id_usuario, codigo, fecha_gen, expira_en, usado) "
                + "VALUES (?, ?, NOW(), DATE_ADD(NOW(), INTERVAL 10 MINUTE), 0)";
        try (Connection con = ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setString(2, token);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean validar(int idUsuario, String token) {
        String sql = "SELECT id FROM otp_tokens "
                + "WHERE id_usuario = ? AND codigo = ? AND usado = 0 AND expira_en > NOW()";
        try (Connection con = ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setString(2, token);
            try(ResultSet rs = ps.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean marcarComoUsado(int idUsuario, String token) {
        String sql = "UPDATE otp_tokens SET usado = 1 "
                + "WHERE id_usuario = ? AND codigo = ? AND usado = 0";
        
        try (Connection con =ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setString(2, token);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
}
