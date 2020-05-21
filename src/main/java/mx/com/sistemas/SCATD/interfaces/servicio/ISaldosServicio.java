package mx.com.sistemas.SCATD.interfaces.servicio;

import java.util.List;

public interface ISaldosServicio {
	public List<String> getInfoSaldos();
	public List<String> getInfoSaldo();
	public List<String> retirarSaldo();
	public List<String> depositarSaldo();
}
