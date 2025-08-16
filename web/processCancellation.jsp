<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.hotel.dao.*, com.hotel.model.*, com.hotel.util.*" %>
<%@ page import="javax.mail.*, javax.mail.internet.*, java.util.Properties" %>

<%
    String message = "";
    String messageType = "error";
    
        // Get parameters from the form
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String customerEmail = request.getParameter("customerEmail");
        String customerName = request.getParameter("customerName");
        String roomType = request.getParameter("roomType");
        String checkInDate = request.getParameter("checkInDate");
        String checkOutDate = request.getParameter("checkOutDate");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        
        BookingDAO bookingDAO = new BookingDAO();
        RoomDAO roomDAO = new RoomDAO();
        
        // Cancel the booking
        boolean cancelled = bookingDAO.cancelBooking(bookingId);
        
        if (cancelled) {
            // Make room available again
            roomDAO.updateRoomAvailability(roomId, true);
            
            // Send cancellation email
            boolean emailSent = sendCancellationEmail(customerName, customerEmail, 
                                                    bookingId, roomType, checkInDate, 
                                                    checkOutDate, totalAmount);
            
            if (emailSent) {
                message = "Booking #" + bookingId + " has been successfully cancelled. Confirmation email sent to " + customerEmail + ". The room is now available for other guests.";
            } else {
                message = "Booking #" + bookingId + " has been successfully cancelled. The room is now available for other guests. (Email notification failed - please contact us)";
            }
            messageType = "success";
        } else {
            message = "Failed to cancel booking. Please contact our support team.";
        }
        
    
    
    // Redirect back to reservation page with message
    session.setAttribute("message", message);
    session.setAttribute("messageType", messageType);
    response.sendRedirect("reservation.jsp");
%>
<%! boolean sendCancellationEmail(String customerName, String customerEmail, int bookingId,String roomType, String checkInDate, String checkOutDate, double totalAmount) {
    try {
        // Email configuration - UPDATE THESE WITH YOUR SMTP SETTINGS
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        
        // Email credentials - REPLACE WITH YOUR EMAIL AND APP PASSWORD
        final String senderEmail = "23bca.manavgyani@gmail.com";
        final String senderPassword = "shrftcvdldlavwas";
        
        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });
        
        // Create email message
        Message emailMessage = new MimeMessage(mailSession);
        emailMessage.setFrom(new InternetAddress(senderEmail, "Luxury Hotel"));
        emailMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(customerEmail));
        emailMessage.setSubject("Booking Cancellation Confirmation - #" + bookingId);
        
        // Calculate refund amount (80% refund policy)
        double refundAmount = totalAmount * 0.8;
        
        // Email content
        String emailContent = createCancellationEmailContent(customerName, bookingId, roomType, checkInDate, checkOutDate, totalAmount, refundAmount);
        emailMessage.setContent(emailContent, "text/html; charset=utf-8");
        
        // Send email
        Transport.send(emailMessage);
        return true;
        
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }

}
String createCancellationEmailContent(String customerName, int bookingId, String roomType,
                                     String checkInDate, String checkOutDate, double totalAmount, double refundAmount) {
    return "<!DOCTYPE html>" +
           "<html><head><style>" +
           "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 20px; }" +
           ".container { max-width: 600px; margin: 0 auto; border: 1px solid #ddd; border-radius: 10px; overflow: hidden; }" +
           ".header { background: linear-gradient(135deg, #dc3545, #c82333); color: white; padding: 30px; text-align: center; }" +
           ".header h1 { margin: 0; font-size: 28px; }" +
           ".content { padding: 30px; }" +
           ".booking-details { background-color: #f8f9fa; padding: 20px; margin: 20px 0; border-radius: 8px; border-left: 4px solid #dc3545; }" +
           ".booking-details h3 { color: #dc3545; margin-top: 0; }" +
           ".detail-row { display: flex; justify-content: space-between; margin: 10px 0; padding: 8px 0; border-bottom: 1px solid #eee; }" +
           ".detail-row:last-child { border-bottom: none; }" +
           ".detail-label { font-weight: bold; color: #333; }" +
           ".detail-value { color: #666; }" +
           ".refund-info { background-color: #d4edda; padding: 20px; margin: 20px 0; border-radius: 8px; border-left: 4px solid #28a745; }" +
           ".refund-info h3 { color: #155724; margin-top: 0; }" +
           ".policy-box { background-color: #fff3cd; padding: 15px; margin: 20px 0; border-radius: 8px; border-left: 4px solid #ffc107; }" +
           ".policy-box h4 { color: #856404; margin-top: 0; }" +
           ".policy-box ul { margin: 10px 0; padding-left: 20px; }" +
           ".footer { text-align: center; padding: 20px; color: #666; font-size: 12px; background-color: #f8f9fa; }" +
           ".contact-info { margin: 20px 0; padding: 15px; background-color: #e9ecef; border-radius: 8px; }" +
           "</style></head><body>" +
           "<div class='container'>" +
           "<div class='header'>" +
           "<h1>Booking Cancellation Confirmed</h1>" +
           "<p style='margin: 10px 0 0 0; opacity: 0.9;'>Your reservation has been successfully cancelled</p>" +
           "</div>" +
           "<div class='content'>" +
           "<p>Dear " + customerName + ",</p>" +
           "<p>We have successfully processed your booking cancellation request. We're sorry to see you won't be staying with us on this occasion.</p>" +
           
           "<div class='booking-details'>" +
           "<h3>Cancelled Booking Details</h3>" +
           "<div class='detail-row'><span class='detail-label'>Booking ID:</span><span class='detail-value'>#" + bookingId + "</span></div>" +
           "<div class='detail-row'><span class='detail-label'>Room Type:</span><span class='detail-value'>" + roomType + "</span></div>" +
           "<div class='detail-row'><span class='detail-label'>Check-in Date:</span><span class='detail-value'>" + checkInDate + "</span></div>" +
           "<div class='detail-row'><span class='detail-label'>Check-out Date:</span><span class='detail-value'>" + checkOutDate + "</span></div>" +
           "<div class='detail-row'><span class='detail-label'>Original Amount:</span><span class='detail-value'>$" + String.format("%.2f", totalAmount) + "</span></div>" +
           "<div class='detail-row'><span class='detail-label'>Cancellation Date:</span><span class='detail-value'>" + new java.text.SimpleDateFormat("MMM dd, yyyy").format(new java.util.Date()) + "</span></div>" +
           "</div>" +
           
           "<div class='refund-info'>" +
           "<h3>Refund Information</h3>" +
           "<div class='detail-row'><span class='detail-label'>Refund Amount:</span><span class='detail-value' style='color: #28a745; font-weight: bold; font-size: 18px;'>$" + String.format("%.2f", refundAmount) + "</span></div>" +
           "<p style='margin: 15px 0 0 0;'>Your refund will be processed within 5-7 business days to your original payment method.</p>" +
           "</div>" +
           
           "<div class='policy-box'>" +
           "<h4>Our Cancellation Policy</h4>" +
           "<ul>" +
           "<li>Free cancellation up to 24 hours before check-in</li>" +
           "<li>80% refund for cancellations made within policy</li>" +
           "<li>Refunds are processed within 5-7 business days</li>" +
           "<li>No additional fees for cancellations</li>" +
           "</ul>" +
           "</div>" +
           
           "<div class='contact-info'>" +
           "<h4 style='margin-top: 0; color: #495057;'>Need Help?</h4>" +
           "<p style='margin: 5px 0;'>If you have any questions about your cancellation or refund, our customer service team is here to help:</p>" +
           "<p style='margin: 5px 0;'><strong>Phone:</strong> +91 9173936174</p>" +
           "<p style='margin: 5px 0;'><strong>Email:</strong> support@luxuryhotel.com</p>" +
           "<p style='margin: 5px 0;'><strong>Hours:</strong> 24/7 Customer Support</p>" +
           "</div>" +
           
           "<p>We hope to welcome you back to Luxury Hotel in the future. Thank you for choosing us.</p>" +
           "<p>Best regards,<br><strong>The Luxury Hotel Team</strong></p>" +
           "</div>" +
           "<div class='footer'>" +
           "<p>This is an automated email confirmation. Please do not reply to this message.</p>" +
           "<p style='margin: 5px 0;'>Luxury Hotel | 123 Premium Street, City, State 12345</p>" +
           "<p style='margin: 5px 0;'>© 2024 Luxury Hotel. All rights reserved.</p>" +
           "</div>" +
           "</div></body></html>";
}
%>