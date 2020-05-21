package mx.com.sistemas.SCATD.interfaces.modelo;

import java.util.List;

public interface ISaldosModelo {
	public List<String> getInfoSaldos();
	public List<String> getInfoSaldo();
	public List<String> retirarSaldo();
	public List<String> depositarSaldo();
}
