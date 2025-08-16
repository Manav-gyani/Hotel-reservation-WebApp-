/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hotel.model;
import java.sql.Date;
import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private int customerId;
    private int roomId;
    private Date checkInDate;
    private Date checkOutDate;
    private double totalAmount;
    private String bookingStatus;
    private Timestamp bookingDate;
    private String specialRequests;
    
    // Additional fields for joins
    private Room room;
    private Customer customer;
    
    // Constructors
    public Booking() {}
    
    // Getters and Setters
    public int getBookingId() {
        return bookingId; 
    }
    public void setBookingId(int bookingId) { 
        this.bookingId = bookingId; 
    }
    
    public int getCustomerId() {
        return customerId; 
    }
    public void setCustomerId(int customerId) { 
        this.customerId = customerId; 
    }
    
    public int getRoomId() { 
        return roomId; 
    }
    public void setRoomId(int roomId) { 
        this.roomId = roomId; 
    }
    
    public Date getCheckInDate() { 
        return checkInDate; 
    }
    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate; 
    }
    
    public Date getCheckOutDate() { 
        return checkOutDate; 
    }
    public void setCheckOutDate(Date checkOutDate) { 
        this.checkOutDate = checkOutDate;
    }
    
    public double getTotalAmount() { 
        return totalAmount; 
    }
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount; 
    }
    
    public String getBookingStatus() { 
        return bookingStatus; 
    }
    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }
    
    public Timestamp getBookingDate() { 
        return bookingDate; 
    }
    public void setBookingDate(Timestamp bookingDate) { 
        this.bookingDate = bookingDate; 
    }
    
    public String getSpecialRequests() {
        return specialRequests;
    }
    public void setSpecialRequests(String specialRequests) { 
        this.specialRequests = specialRequests; 
    }
    
    public Room getRoom() { 
        return room; 
    }
    public void setRoom(Room room) { 
        this.room = room; 
    }
    
    public Customer getCustomer() { 
        return customer; 
    }
    public void setCustomer(Customer customer) { 
        this.customer = customer; 
    }
}

