/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author marcin
 */
public class DBconnection {

    public static Connection getMySQLConnection(String name) {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/" + name;
            connection = DriverManager.getConnection(url, "root", "admin");

            if (connection.equals(null)) {
                System.out.println("connection was failed");
            } else {
                System.out.println("connected successfully");
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return connection;
    }
}
