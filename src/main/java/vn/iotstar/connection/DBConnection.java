package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "ShoppingServiceMVC";
    private final String portNumber = "1433";
    private final String instance = "SQLEXPRESS"; // Instance SQL Server 2022 Express trên máy bạn
    private final String userID = "sa";
    private final String password = "1234@a$"; // Mật khẩu sa đã kiểm tra thành công

    public Connection getConnection() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        try {
            // Ưu tiên kết nối qua cổng TCP 1433
            String url = "jdbc:sqlserver://" + serverName + ":" + portNumber
                    + ";encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
            return DriverManager.getConnection(url, userID, password);
        } catch (Exception ex) {
            // Dự phòng kết nối qua instanceName
            String fallbackUrl = "jdbc:sqlserver://" + serverName + ";instanceName=" + instance
                    + ";encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
            return DriverManager.getConnection(fallbackUrl, userID, password);
        }
    }

    // Hàm test kết nối trực tiếp
    public static void main(String[] args) {
        try {
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            if (conn != null) {
                System.out.println("Kết nối CSDL SQL Server 2022 thành công!");
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Lỗi kết nối CSDL: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
