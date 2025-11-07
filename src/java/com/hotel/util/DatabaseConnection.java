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
            Properties props = new Properties();
            FileInputStream fis = new FileInputStream("C:/Users/Manav/OneDrive/Documents/NetBeansProjects/HotelReservationSystem/dbconfig.properties");
            props.load(fis);

            String url = props.getProperty("db.url");
            String user = props.getProperty("db.username");
            String password = props.getProperty("db.password");

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


