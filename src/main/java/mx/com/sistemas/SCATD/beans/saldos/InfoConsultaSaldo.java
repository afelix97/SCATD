package mx.com.sistemas.SCATD.beans.saldos;

public class InfoConsultaSaldo {
	private String nombre;
	private String apellido;
	private String saldo;
	
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public String getSaldo() {
		return saldo;
	}
	public void setSaldo(String saldo) {
		this.saldo = saldo;
	}
	
	@Override
	public String toString() {
		return "InfoConsultaSaldo [nombre=" + nombre + ", apellido=" + apellido + ", saldo=" + saldo + "]";
	}
}
