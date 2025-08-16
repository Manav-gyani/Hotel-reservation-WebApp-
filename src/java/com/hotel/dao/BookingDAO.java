/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hotel.dao;

import com.hotel.model.Booking;
import com.hotel.model.Room;
import com.hotel.model.Customer;
import com.hotel.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    
    public int createBooking(Booking booking) throws SQLException {
        String sql = "INSERT INTO bookings (customer_id, room_id, check_in_date, check_out_date, total_amount, special_requests) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, booking.getCustomerId());
            pstmt.setInt(2, booking.getRoomId());
            pstmt.setDate(3, booking.getCheckInDate());
            pstmt.setDate(4, booking.getCheckOutDate());
            pstmt.setDouble(5, booking.getTotalAmount());
            pstmt.setString(6, booking.getSpecialRequests());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        }
        return -1;
    }
    
    public List<Booking> getBookingsByCustomerId(int customerId) throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, r.room_number, r.room_type, r.price, c.first_name, c.last_name, c.email " +
                    "FROM bookings b " +
                    "JOIN rooms r ON b.room_id = r.room_id " +
                    "JOIN customers c ON b.customer_id = c.customer_id " +
                    "WHERE b.customer_id = ? AND b.booking_status != 'CANCELLED' " +
                    "ORDER BY b.booking_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Booking booking = mapBookingFromResultSet(rs);
                bookings.add(booking);
            }
        }
        return bookings;
    }
    
    public Booking getBookingById(int bookingId) throws SQLException {
        String sql = "SELECT b.*, r.room_number, r.room_type, r.price, c.first_name, c.last_name, c.email " +
                    "FROM bookings b " +
                    "JOIN rooms r ON b.room_id = r.room_id " +
                    "JOIN customers c ON b.customer_id = c.customer_id " +
                    "WHERE b.booking_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookingId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapBookingFromResultSet(rs);
            }
        }
        return null;
    }
    
    public boolean updateBooking(Booking booking) throws SQLException {
        String sql = "UPDATE bookings SET check_in_date=?, check_out_date=?, total_amount=?, special_requests=? WHERE booking_id=?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setDate(1, booking.getCheckInDate());
            pstmt.setDate(2, booking.getCheckOutDate());
            pstmt.setDouble(3, booking.getTotalAmount());
            pstmt.setString(4, booking.getSpecialRequests());
            pstmt.setInt(5, booking.getBookingId());
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    public boolean cancelBooking(int bookingId) throws SQLException {
        String sql = "UPDATE bookings SET booking_status = 'CANCELLED' WHERE booking_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookingId);
            return pstmt.executeUpdate() > 0;
        }
    }
    
    private Booking mapBookingFromResultSet(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setCustomerId(rs.getInt("customer_id"));
        booking.setRoomId(rs.getInt("room_id"));
        booking.setCheckInDate(rs.getDate("check_in_date"));
        booking.setCheckOutDate(rs.getDate("check_out_date"));
        booking.setTotalAmount(rs.getDouble("total_amount"));
        booking.setBookingStatus(rs.getString("booking_status"));
        booking.setBookingDate(rs.getTimestamp("booking_date"));
        booking.setSpecialRequests(rs.getString("special_requests"));
        
        // Map room details
        Room room = new Room();
        room.setRoomId(rs.getInt("room_id"));
        room.setRoomNumber(rs.getString("room_number"));
        room.setRoomType(rs.getString("room_type"));
        room.setPrice(rs.getDouble("price"));
        booking.setRoom(room);
        
        // Map customer details
        Customer customer = new Customer();
        customer.setCustomerId(rs.getInt("customer_id"));
        customer.setFirstName(rs.getString("first_name"));
        customer.setLastName(rs.getString("last_name"));
        customer.setEmail(rs.getString("email"));
        booking.setCustomer(customer);
        
        return booking;
    }
}
