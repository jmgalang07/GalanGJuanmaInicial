package es.albarregas.beans;

import java.time.LocalDate;

public class Usuario {

    private String nombre;
    private LocalDate fechaNacimiento;
    private int numHijos;
    private double salario;

    // Constructor vacío
    public Usuario() {
    }

    // Constructor con parámetros
    public Usuario(String nombre, LocalDate fechaNacimiento, int numHijos, double salario) {
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
        this.numHijos = numHijos;
        this.salario = salario;
    }

    // Getters y Setters
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public int getNumHijos() {
        return numHijos;
    }

    public void setNumHijos(int numHijos) {
        this.numHijos = numHijos;
    }

    public double getSalario() {
        return salario;
    }

    public void setSalario(double salario) {
        this.salario = salario;
    }
}
