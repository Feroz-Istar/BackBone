package DBUtils;

import java.io.InputStream;
import java.util.Properties;

public class DBProperties {
	public static Properties configProperties;
	static {
		try {
			InputStream inputStream = DBProperties.class.getClassLoader().getResourceAsStream("db.properties");
			//InputStream inputStream = new FileInputStream(new File("/root/vaibhav/appie/appie/db.properties"));
			configProperties = new Properties();
			configProperties.load(inputStream);
		} catch (Exception e) {
			System.out.println("Could not load the file");
			e.printStackTrace();
		}
	}

	public static String getProperty(String key) {
		return (String) configProperties.get(key);
	}
}