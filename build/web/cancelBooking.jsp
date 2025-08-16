<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.hotel.dao.*, com.hotel.model.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cancel Booking - Luxury Hotel</title>
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
            color: #dc3545;
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
            border-left: 4px solid #dc3545;
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

        .cancellation-warning {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 8px;
            padding: 1.5rem;
            margin: 2rem 0;
            color: #856404;
        }

        .cancellation-warning h4 {
            margin-bottom: 1rem;
            color: #dc3545;
        }

        .cancellation-warning ul {
            margin-left: 1.5rem;
            margin-bottom: 1rem;
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

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
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
            <h1><i class="fas fa-times-circle"></i> Cancel Your Booking</h1>
            <p>Cancel your room reservation</p>
        </div>

        <a href="reservation.jsp" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Reservations
        </a>

        <%
            String email = request.getParameter("email");
            
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
                                            <h4>Guest Name</h4>
                                            <p><%= customer.getFullName() %></p>
                                        </div>
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
                                        <div class="detail-item">
                                            <h4>Booking Date</h4>
                                            <p><%= booking.getBookingDate() %></p>
                                        </div>
                                    </div>
                                    
                                    <div class="cancellation-warning">
                                        <h4><i class="fas fa-exclamation-triangle"></i> Cancellation Policy</h4>
                                        <ul>
                                            <li>Free cancellation up to 24 hours before check-in</li>
                                            <li>Cancellations within 24 hours are subject to one night charge</li>
                                            <li>No-shows will be charged the full amount</li>
                                            <li>Refunds will be processed within 5-7 business days</li>
                                        </ul>
                                        <p><strong>Are you sure you want to cancel this booking?</strong></p>
                                    </div>
                                    
                                    <div class="btn-group">
                                        <form action="processCancellation.jsp" method="post" style="display: inline;">
                                            <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                            <input type="hidden" name="roomId" value="<%= booking.getRoomId() %>">
                                            <!-- ADD THESE HIDDEN FIELDS FOR EMAIL -->
                                            <input type="hidden" name="customerEmail" value="<%= customer.getEmail() %>">
                                            <input type="hidden" name="customerName" value="<%= customer.getFullName() %>">
                                            <input type="hidden" name="roomType" value="<%= booking.getRoom().getRoomType() %>">
                                            <input type="hidden" name="checkInDate" value="<%= booking.getCheckInDate() %>">
                                            <input type="hidden" name="checkOutDate" value="<%= booking.getCheckOutDate() %>">
                                            <input type="hidden" name="totalAmount" value="<%= booking.getTotalAmount() %>">
                                            
                                            <button type="submit" class="btn btn-danger" onclick="return confirm('Are you absolutely sure you want to cancel this booking? This action cannot be undone.')">
                                                <i class="fas fa-times"></i> Yes, Cancel Booking
                                            </button>
                                        </form>
                                        <a href="reservation.jsp" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i> Keep Booking
                                        </a>
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