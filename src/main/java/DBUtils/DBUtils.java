package DBUtils;


import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;


import org.postgresql.util.PSQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * @author Vaibhav Verma
 *
 */
public class DBUtils {
	static DBUtils db;
	static ComboPooledDataSource dataSource;

	private synchronized static ComboPooledDataSource getDataSource() throws PropertyVetoException {
		ComboPooledDataSource cpds = new ComboPooledDataSource();
		try {
			cpds.setJdbcUrl(DBProperties.getProperty("DB_URL"));
			cpds.setUser(DBProperties.getProperty("USER"));
			cpds.setPassword(DBProperties.getProperty("PASS"));
			cpds.setDriverClass("org.postgresql.Driver");
			// Optional Settings
			cpds.setInitialPoolSize(10);
			cpds.setMinPoolSize(10);
			cpds.setAcquireIncrement(5);
			cpds.setMaxPoolSize(20);
			cpds.setMaxStatements(100);
		} catch (Exception e) {
			cpds.setJdbcUrl("jdbc:postgresql://db.talentify.in/sales");
			cpds.setUser("postgres");
			cpds.setPassword("cx6ac54nmgGtLD1y");
			cpds.setDriverClass("org.postgresql.Driver");
			// Optional Settings
			cpds.setInitialPoolSize(5);
			cpds.setMinPoolSize(5);
			cpds.setAcquireIncrement(5);
			cpds.setMaxPoolSize(20);
			cpds.setMaxStatements(100);
		}

		return cpds;
	}

	public static DBUtils getInstance() {
		try {
			if (db == null) {
				db = new DBUtils();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return db;
	}

	private DBUtils() throws PropertyVetoException {
		dataSource = getDataSource();
	}

	public int insertIntoDB(String sqlQuery) {
		System.out.println(sqlQuery);
		int retrunIndex = 0;
		Connection connection = null;
		Statement pstmt = null;
		try {
			connection = dataSource.getConnection();
			pstmt = connection.createStatement();

			pstmt.executeUpdate(sqlQuery);
		} catch (SQLException se) {
			System.out.println(sqlQuery);
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					connection.close();
			} catch (SQLException se) {
			}
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return retrunIndex;
	}
	
	public int insertIntoDBPS(String sqlQuery, HashMap<String, String> updateMap) {
		System.out.println(sqlQuery);
		int retrunIndex = 0;
		Connection connection = null;
		try {
			PreparedStatement pstmt= connection.prepareStatement(sqlQuery);
			connection = dataSource.getConnection();
			int i=1;
			for (String key : updateMap.keySet()) {
				pstmt.setString(i,updateMap.get(key));
				i++;
			}
			
			pstmt.executeUpdate(sqlQuery);
		} catch (SQLException se) {
			System.out.println(sqlQuery);
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return retrunIndex;
	}

	public int insertIntoDBWithGeneratedKey(String sqlQuery) {
		System.out.println(sqlQuery);
		int retrunIndex = 0;
		Connection connection = null;
		Statement pstmt = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			pstmt = connection.createStatement();
			resultSet = pstmt.executeQuery(sqlQuery);
			resultSet.next();
			retrunIndex = resultSet.getInt(1);
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					connection.close();
			} catch (SQLException se) {
			}
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		System.err.println(retrunIndex);
		return retrunIndex;
	}

	public ArrayList<HashMap<String, String>> executeQuery(StackTraceElement[] stackTraceElements, String sqlQuery) {
		long now = System.currentTimeMillis();
		ArrayList<HashMap<String, String>> table = new ArrayList<HashMap<String, String>>();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet resultSet = null;
		System.out.println("["+stackTraceElements[1].getClassName() + "." + stackTraceElements[1].getMethodName() + ":"
				+ stackTraceElements[1].getLineNumber() + "]--->" + sqlQuery);

		try {
			connection = dataSource.getConnection();
			pstmt = connection.prepareStatement(sqlQuery);
			resultSet = pstmt.executeQuery();
			ResultSetMetaData rsmd = resultSet.getMetaData();

			ArrayList<String> columnnames = new ArrayList<String>();
			for (int i = 1; i <= rsmd.getColumnCount(); i++) {

				columnnames.add(rsmd.getColumnName(i));
			}

			while (resultSet.next()) {
				HashMap<String, String> row = new HashMap<String, String>();
				for (String columnName : columnnames) {
					String first = resultSet.getString(columnName);
					row.put(columnName, first);
				}
				table.add(row);
			}
		} catch (PSQLException psqe) {
			System.out.println("Problem running this query ->" + sqlQuery);
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					connection.close();
			} catch (SQLException se) {
			}
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		if ((System.currentTimeMillis() - now) > 1000)
			System.out.println("Exxceptionally long time (" + (System.currentTimeMillis() - now) + ") taken for query ->"
					+ sqlQuery);
		return table;
	}
	
	
	public int updateObject(String sqlQuery, HashMap<Integer, Object> data) {
		int retrunIndex = 0;

		System.out.println(sqlQuery);
		Connection connection = null;
		PreparedStatement pstmt = null;
		try {
			connection = dataSource.getConnection();
			pstmt = connection.prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);
			;
			for (Integer index : data.keySet()) {
				if (data.get(index) != null) {
					switch (data.get(index).getClass().getName().toString()) {
					case "java.lang.Integer":
						pstmt.setInt(index, Integer.parseInt(data.get(index).toString()));
						break;
					case "java.lang.String":
						pstmt.setString(index, data.get(index).toString());
						break;
					case "java.lang.Float":
						pstmt.setFloat(index, Float.parseFloat(data.get(index).toString()));
						break;
					case "java.lang.Boolean":
						pstmt.setBoolean(index, Boolean.parseBoolean(data.get(index).toString()));
						break;
					default:
						pstmt.setString(index, data.get(index).toString());
						break;
					}
				} else {
					pstmt.setObject(index, null);
				}

			}
			retrunIndex = pstmt.executeUpdate();

			if (sqlQuery.toLowerCase().contains("insert") && retrunIndex > 0) {
				java.sql.ResultSet generatedKeys = pstmt.getGeneratedKeys();
				if (generatedKeys.next()) {
					retrunIndex = generatedKeys.getInt(1);
				}
			} else {
				retrunIndex = 0;
			}

		} catch (SQLException se) {
			System.out.println(sqlQuery);
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					connection.close();
			} catch (SQLException se) {
			}
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return retrunIndex;

	}

}