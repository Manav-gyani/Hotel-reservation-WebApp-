/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hotel.dao;


import com.hotel.model.Room;
import com.hotel.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {
    
    public List<Room> getAllAvailableRooms() throws SQLException {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE is_available = TRUE ORDER BY price";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setPrice(rs.getDouble("price"));
                room.setCapacity(rs.getInt("capacity"));
                room.setAmenities(rs.getString("amenities"));
                room.setAvailable(rs.getBoolean("is_available"));
                room.setImageUrl(rs.getString("image_url"));
                rooms.add(room);
            }
        }
        return rooms;
    }
    
    public Room getRoomById(int roomId) throws SQLException {
        String sql = "SELECT * FROM rooms WHERE room_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, roomId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setPrice(rs.getDouble("price"));
                room.setCapacity(rs.getInt("capacity"));
                room.setAmenities(rs.getString("amenities"));
                room.setAvailable(rs.getBoolean("is_available"));
                room.setImageUrl(rs.getString("image_url"));
                return room;
            }
        }
        return null;
    }
    
    public boolean updateRoomAvailability(int roomId, boolean isAvailable) throws SQLException {
        String sql = "UPDATE rooms SET is_available = ? WHERE room_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setBoolean(1, isAvailable);
            pstmt.setInt(2, roomId);
            
            return pstmt.executeUpdate() > 0;
        }
    }
}