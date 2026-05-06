package co.sena.cimm.adso.saludboyaca.model;

import java.sql.Time;
import java.time.LocalDateTime;


public class Citas {
    
    
    private int id;
    private int id_paciente;
    private int id_medico;
    private int id_especialidad;
    private LocalDateTime fecha_cita;
    private Time hora_cita;
    private String motivo;
    private String estado;
    private String observaciones;
    private LocalDateTime fecha_registro;
    private int id_registrado_por;
    
    private String nombre_paciente;

    public Citas() {
    }

    public Citas(int id, int id_paciente, int id_medico, int id_especialidad, LocalDateTime fecha_cita, Time hora_cita, String motivo, String estado, String observaciones, LocalDateTime fecha_registro, int id_registrado_por) {
        this.id = id;
        this.id_paciente = id_paciente;
        this.id_medico = id_medico;
        this.id_especialidad = id_especialidad;
        this.fecha_cita = fecha_cita;
        this.hora_cita = hora_cita;
        this.motivo = motivo;
        this.estado = estado;
        this.observaciones = observaciones;
        this.fecha_registro = fecha_registro;
        this.id_registrado_por = id_registrado_por;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_paciente() {
        return id_paciente;
    }

    public void setId_paciente(int id_paciente) {
        this.id_paciente = id_paciente;
    }

    public int getId_medico() {
        return id_medico;
    }

    public void setId_medico(int id_medico) {
        this.id_medico = id_medico;
    }

    public int getId_especialidad() {
        return id_especialidad;
    }

    public void setId_especialidad(int id_especialidad) {
        this.id_especialidad = id_especialidad;
    }

    public LocalDateTime getFecha_cita() {
        return fecha_cita;
    }

    public void setFecha_cita(LocalDateTime fecha_cita) {
        this.fecha_cita = fecha_cita;
    }

    public Time getHora_cita() {
        return hora_cita;
    }

    public void setHora_cita(Time hora_cita) {
        this.hora_cita = hora_cita;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public LocalDateTime getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(LocalDateTime fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    public int getId_registrado_por() {
        return id_registrado_por;
    }

    public void setId_registrado_por(int id_registrado_por) {
        this.id_registrado_por = id_registrado_por;
    }

    public String getNombre_paciente() {
        return nombre_paciente;
    }

    public void setNombre_paciente(String nombre_paciente) {
        this.nombre_paciente = nombre_paciente;
    }
    
    
}
