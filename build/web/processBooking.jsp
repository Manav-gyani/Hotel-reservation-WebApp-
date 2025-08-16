<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.sql.Date, java.text.*, java.util.*, com.hotel.dao.*, com.hotel.model.*, com.hotel.util.*" %>
<%
    String message = "";
    String messageType = "error";
    
    try {
        // Get form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String checkInStr = request.getParameter("checkInDate");
        String checkOutStr = request.getParameter("checkOutDate");
        String specialRequests = request.getParameter("specialRequests");
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        double roomPrice = Double.parseDouble(request.getParameter("roomPrice"));
         
        // Parse dates
        Date checkInDate = Date.valueOf(checkInStr);
        Date checkOutDate = Date.valueOf(checkOutStr);
        
        // Calculate total amount
        long diffInMillies = checkOutDate.getTime() - checkInDate.getTime();
        long diffInDays = diffInMillies / (1000 * 60 * 60 * 24);
        double totalAmount = diffInDays * roomPrice;
        
        // Create or get customer
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByEmail(email);
        int customerId;
        
        if (customer == null) {
            // Create new customer
            customer = new Customer(firstName, lastName, email, phone, address);
            customerId = customerDAO.createCustomer(customer);
        } else {
            // Update existing customer
            customer.setFirstName(firstName);
            customer.setLastName(lastName);
            customer.setPhone(phone);
            customer.setAddress(address);
            customerDAO.updateCustomer(customer);
            customerId = customer.getCustomerId();
        }
        
        // Create booking
        Booking booking = new Booking();
        booking.setCustomerId(customerId);
        booking.setRoomId(roomId);
        booking.setCheckInDate(checkInDate);
        booking.setCheckOutDate(checkOutDate);
        booking.setTotalAmount(totalAmount);
        booking.setSpecialRequests(specialRequests);
        
        BookingDAO bookingDAO = new BookingDAO();
        int bookingId = bookingDAO.createBooking(booking);
        
        if (bookingId > 0) {
            // Update room availability
            RoomDAO roomDAO = new RoomDAO();
            roomDAO.updateRoomAvailability(roomId, false);
            
            // Get room details for email
            Room room = roomDAO.getRoomById(roomId);
            
            // Send confirmation email
            boolean emailSent = EmailUtil.sendBookingConfirmation(
                email, 
                firstName + " " + lastName,
                room.getRoomType(),
                checkInStr,
                checkOutStr,
                totalAmount,
                bookingId
            );
            
            if (emailSent) {
                message = "Booking confirmed successfully! Confirmation email sent to " + email + ". Booking ID: " + bookingId;
            } else {
                message = "Booking confirmed successfully! Booking ID: " + bookingId + " (Email notification failed - please contact us)";
            }
            messageType = "success";
        } else {
            message = "Failed to create booking. Please try again.";
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        message = "Error processing booking: " + e.getMessage();
    }
    
    // Redirect back to reservation page with message
    session.setAttribute("message", message);
    session.setAttribute("messageType", messageType);
    response.sendRedirect("reservation.jsp");
%>
