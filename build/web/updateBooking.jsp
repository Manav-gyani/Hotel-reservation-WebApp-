<%-- 
    Document   : updateBooking
    Created on : 15 Aug 2025, 1:12:33 pm
    Author     : Manav
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.hotel.dao.*, com.hotel.model.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Booking - Luxury Hotel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background: #f8f9fa;
        }

        .container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 0 20px;
        }

        .header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .header h1 {
            color: #667eea;
            margin-bottom: 0.5rem;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: #6c757d;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            margin-bottom: 2rem;
            transition: background 0.3s ease;
        }

        .back-btn:hover {
            background: #5a6268;
        }

        .booking-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f1f3f4;
        }

        .booking-id {
            font-size: 1.2rem;
            font-weight: 700;
            color: #667eea;
        }

        .booking-status {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            background: #d4edda;
            color: #155724;
        }

        .booking-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .detail-item h4 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .detail-item p {
            color: #666;
            font-size: 1.1rem;
        }

        .update-form {
            background: #f8f9fa;
            padding: 2rem;
            border-radius: 10px;
            margin-top: 2rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #333;
        }

        .form-group input,
        .form-group textarea {
            padding: 12px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .alert {
            padding: 1rem 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            font-weight: 500;
        }

        .alert-error {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }

        .no-bookings {
            text-align: center;
            padding: 3rem;
            color: #666;
        }

        .no-bookings i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: #ccc;
        }

        @media (max-width: 768px) {
            .booking-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .booking-details {
                grid-template-columns: 1fr;
            }
            
            .btn-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-edit"></i> Update Your Booking</h1>
            <p>Modify your reservation details</p>
        </div>

        <a href="reservation.jsp" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Reservations
        </a>

        <%
            String email = request.getParameter("email");
            String updateAction = request.getParameter("updateAction");
            
            if (email != null && !email.trim().isEmpty()) {
                try {
                    CustomerDAO customerDAO = new CustomerDAO();
                    Customer customer = customerDAO.getCustomerByEmail(email);
                    
                    if (customer != null) {
                        BookingDAO bookingDAO = new BookingDAO();
                        List<Booking> bookings = bookingDAO.getBookingsByCustomerId(customer.getCustomerId());
                        
                        if (!bookings.isEmpty()) {
                            for (Booking booking : bookings) {
        %>
                                <div class="booking-card">
                                    <div class="booking-header">
                                        <div class="booking-id">Booking #<%= booking.getBookingId() %></div>
                                        <div class="booking-status status-confirmed"><%= booking.getBookingStatus() %></div>
                                    </div>
                                    
                                    <div class="booking-details">
                                        <div class="detail-item">
                                            <h4>Room</h4>
                                            <p><%= booking.getRoom().getRoomType() %> - #<%= booking.getRoom().getRoomNumber() %></p>
                                        </div>
                                        <div class="detail-item">
                                            <h4>Check-in</h4>
                                            <p><%= booking.getCheckInDate() %></p>
                                        </div>
                                        <div class="detail-item">
                                            <h4>Check-out</h4>
                                            <p><%= booking.getCheckOutDate() %></p>
                                        </div>
                                        <div class="detail-item">
                                            <h4>Total Amount</h4>
                                            <p>$<%= String.format("%.2f", booking.getTotalAmount()) %></p>
                                        </div>
                                    </div>
                                    
                                    <div class="update-form">
                                        <h3>Update Booking Details</h3>
                                        <form action="processUpdate.jsp" method="post">
                                            <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                                            
                                            <div class="form-grid">
                                                <div class="form-group">
                                                    <label for="firstName">First Name</label>
                                                    <input type="text" name="firstName" value="<%= customer.getFirstName() %>" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="lastName">Last Name</label>
                                                    <input type="text" name="lastName" value="<%= customer.getLastName() %>" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="phone">Phone</label>
                                                    <input type="tel" name="phone" value="<%= customer.getPhone() %>" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="checkInDate">New Check-in Date</label>
                                                    <input type="date" name="checkInDate" value="<%= booking.getCheckInDate() %>" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="checkOutDate">New Check-out Date</label>
                                                    <input type="date" name="checkOutDate" value="<%= booking.getCheckOutDate() %>" required>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label for="address">Address</label>
                                                <textarea name="address" rows="3"><%= customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label for="specialRequests">Special Requests</label>
                                                <textarea name="specialRequests" rows="3"><%= booking.getSpecialRequests() != null ? booking.getSpecialRequests() : "" %></textarea>
                                            </div>
                                            
                                            <div class="btn-group">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save"></i> Update Booking
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
        <%
                            }
                        } else {
        %>
                            <div class="booking-card">
                                <div class="no-bookings">
                                    <i class="fas fa-calendar-times"></i>
                                    <h3>No Bookings Found</h3>
                                    <p>We couldn't find any active bookings for this email address.</p>
                                </div>
                            </div>
        <%
                        }
                    } else {
        %>
                        <div class="alert alert-error">
                            No customer found with email: <%= email %>
                        </div>
        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
        %>
                    <div class="alert alert-error">
                        Error retrieving booking information: <%= e.getMessage() %>
                    </div>
        <%
                }
            }
        %>
    </div>
</body>
</html>