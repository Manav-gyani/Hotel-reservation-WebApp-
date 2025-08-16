<%-- 
    Document   : processUpdate
    Created on : 15 Aug 2025, 1:14:38 pm
    Author     : Manav
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.sql.Date ,java.text.*, java.util.*, com.hotel.dao.*, com.hotel.model.*" %>
<%
    String message = "";
    String messageType = "error";
    
    try {
        // Get form parameters
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String checkInStr = request.getParameter("checkInDate");
        String checkOutStr = request.getParameter("checkOutDate");
        String specialRequests = request.getParameter("specialRequests");
        
        // Parse dates
        Date checkInDate = Date.valueOf(checkInStr);
        Date checkOutDate = Date.valueOf(checkOutStr);
        
        // Update customer information
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = new Customer();
        customer.setCustomerId(customerId);
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setPhone(phone);
        customer.setAddress(address);
        
        boolean customerUpdated = customerDAO.updateCustomer(customer);
        
        // Get booking to calculate new total
        BookingDAO bookingDAO = new BookingDAO();
        Booking existingBooking = bookingDAO.getBookingById(bookingId);
        
        if (existingBooking != null) {
            // Calculate new total amount
            long diffInMillies = checkOutDate.getTime() - checkInDate.getTime();
            long diffInDays = diffInMillies / (1000 * 60 * 60 * 24);
            double totalAmount = diffInDays * existingBooking.getRoom().getPrice();
            
            // Update booking
            Booking booking = new Booking();
            booking.setBookingId(bookingId);
            booking.setCheckInDate(checkInDate);
            booking.setCheckOutDate(checkOutDate);
            booking.setTotalAmount(totalAmount);
            booking.setSpecialRequests(specialRequests);
            
            boolean bookingUpdated = bookingDAO.updateBooking(booking);
            
            if (customerUpdated && bookingUpdated) {
                message = "Booking updated successfully! Booking ID: " + bookingId;
                messageType = "success";
            } else {
                message = "Failed to update booking. Please try again.";
            }
        } else {
            message = "Booking not found.";
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        message = "Error updating booking: " + e.getMessage();
    }
    
    // Redirect back to reservation page with message
    session.setAttribute("message", message);
    session.setAttribute("messageType", messageType);
    response.sendRedirect("reservation.jsp");
%>

