package mx.com.sistemas.SCATD.controller;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import mx.com.sistemas.SCATD.procedimientos.ProcessObtainLog;


@Controller
public class ControllerSaldo {

	@Autowired
	ProcessObtainLog processObtainLog;
	
	public ProcessObtainLog getProcessObtainLog() {
		return processObtainLog;
	}

	public void setProcessObtainLog(ProcessObtainLog processObtainLog) {
		this.processObtainLog = processObtainLog;
	}

	private static final Logger logger 	   = Logger.getLogger(ControllerSaldo.class);
	public Properties propiedadesGenerales = new Properties();;
	java.lang.String sMessageLog           = null;
	
	@RequestMapping(value="/getInfoSaldo")
	public ModelAndView getInfoSaldo(HttpServletRequest request){
		
		Map<String,Object> mResponse = new HashMap<String, Object>();
		int resultadoOperacion = 0;
		String descripcionResultado = "";
		
		
		
		try 
		{
			getProcessObtainLog().CrearLogger();
			
			propiedadesGenerales.load(new FileReader("c:\\propiedades.ini"));
			
			descripcionResultado = "EXITO";
			resultadoOperacion   = 1;
		} 
		catch (FileNotFoundException e) 
		{
			logger.warn(sMessageLog+ " FileNotFoundException => " + ExceptionUtils.getStackTrace(e));
			
			descripcionResultado = "ERROR";
			resultadoOperacion   = -1;
		} 
		catch (IOException e) 
		{
			logger.warn(sMessageLog+ " IOException => " + ExceptionUtils.getStackTrace(e));
			
			descripcionResultado = "ERROR";
			resultadoOperacion   = -1;
		} 
		catch (Exception e) 
		{
			logger.warn(sMessageLog+ " Exception => " + ExceptionUtils.getStackTrace(e));
			
			descripcionResultado = "ERROR";
			resultadoOperacion   = -1;
		}
		
		sMessageLog 			= propiedadesGenerales != null && 
								  propiedadesGenerales.getProperty("messageLog") != null ? 
								  propiedadesGenerales.getProperty("messageLog") : "";
		
		logger.info(sMessageLog);
		logger.info( sMessageLog + " [getInfoSaldo] :: inicio");
		
		
		
		
		mResponse.put("resultadoOperacion", resultadoOperacion);
		mResponse.put("descripResultOper", descripcionResultado);
		mResponse.put("respuestaPeticion", "");
			
		logger.info( sMessageLog + " [getInfoSaldo] :: Finaliza, RESPONSE => " + mResponse);
		logger.info( sMessageLog);
		
		return new ModelAndView("home",mResponse);
	}
	
}
