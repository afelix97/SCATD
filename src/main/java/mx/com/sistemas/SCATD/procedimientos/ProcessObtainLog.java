package mx.com.sistemas.SCATD.procedimientos;

import java.io.FileOutputStream;
import java.util.Properties;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;


public class ProcessObtainLog{
	
	private static final Logger logger   = Logger.getLogger(ProcessObtainLog.class);
	public Properties propiedadesGenerales = new Properties();
	/*
	 * (non-Javadoc)
	 * @see org.apache.camel.Processor#process(org.apache.camel.Exchange)
	 * 
	 * class create to build MessageLog to be used along application 
	 * 
	 * Eduardo Cota
	 * 13 nov 2018
	 */
	@SuppressWarnings("deprecation")
	public void CrearLogger() throws Exception {
		
		propiedadesGenerales 					= new Properties();
		java.lang.String sMessageLog 			= "::[SCATD]:: ";
		
		propiedadesGenerales.put("messageLog", sMessageLog);
		
		logger.info(sMessageLog + " LogMensaje listo");
		
		
		
		try {
			logger.info(sMessageLog+ " Guardando Propiedades");
			propiedadesGenerales.save(new FileOutputStream("c:\\SCATD.propiedades.ini"), sMessageLog + "Propiedades ProcessObtainLog " );
			Thread.sleep(2000);
		} catch (Exception e) {
			logger.warn(sMessageLog+ " Exception => " + ExceptionUtils.getStackTrace(e));
		}
		
	}
}
