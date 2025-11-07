/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.hotel.util;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
public class DatabaseConnection {
 private static Connection conn = null;
    
//    static {
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            Properties props = new Properties();
//            FileInputStream fis = new FileInputStream("dbconfig.properties");
//            props.load(fis);
//    
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
    
    public static Connection getConnection() throws SQLException {
         if (conn != null) return conn;
        try {
//            Properties props = new Properties();
//            FileInputStream fis = new FileInputStream("build/web/dbconfig.properties");
//            props.load(fis);

            final String url = "jdbc:mysql://sql.freedb.tech:3306/freedb_hotel_db?useSSL=false&allowPublicKeyRetrieval=true";
            final String user = "freedb_freedb_hotel";
            final String password = "VfPuM*Gequb7K?&";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Database connected successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
//        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}


