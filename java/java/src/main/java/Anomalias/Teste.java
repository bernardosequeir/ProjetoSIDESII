package Anomalias;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Teste {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		SimpleDateFormat timeFormatISO = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 try {
			 Date date = timeFormatISO.parse("1998-12-0 14:4:00");
			 Timestamp stamp =  new Timestamp(date.getTime());
			 System.out.println(stamp);
			// System.out.println(dataHoraMedicao);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
