/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package co.sena.cimm.adso.saludboyaca.dao;

/**
 *
 * @author julia
 */
public interface OTPTokenDAO {
    boolean insertar (int idUsuario, String token);
    boolean validar (int idUsuario, String token);
    boolean marcarComoUsado (int idUsuario, String token);
}
