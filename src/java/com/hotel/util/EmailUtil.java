/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hotel.util;


import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailUtil {
    private static final String SMTP_HOST = "smtp.gmail.com"; // Change as needed
    private static final String SMTP_PORT = "587";
    private static final String EMAIL = "23bca.manavgyani@gmail.com"; // Change to your email
    private static final String PASSWORD = "mxduvqwkytdzkqtu"; // Use App Password for Gmail
    
//    public static boolean sendCancellationConfirmation(String toEmail, String customerName, 
//                                                        String roomType,String checkIn,String checkOut
//                                                            , int bookingId){
//         try {
//            Properties props = new Properties();
//            props.put("mail.smtp.auth", "true");
//            props.put("mail.smtp.starttls.enable", "true");
//            props.put("mail.smtp.host", SMTP_HOST);
//            props.put("mail.smtp.port", SMTP_PORT);
//            props.put("mail.smtp.starttls.required", "true");
//        
//        
//        // Add timeouts to avoid hanging
//            props.put("mail.smtp.connectiontimeout", "10000"); // 10 seconds
//            props.put("mail.smtp.timeout", "10000");
//            props.put("mail.smtp.writetimeout", "10000");
//            props.put("mail.debug", "true");
//            
//            Session session = Session.getInstance(props, new Authenticator() {
//                @Override
//                protected PasswordAuthentication getPasswordAuthentication() {
//                    return new PasswordAuthentication(EMAIL, PASSWORD);
////                       return super.getPasswordAuthentication(EMAIL,PASSWORD);
//                }
//            });
//            
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(EMAIL));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
//             message.setSubject("Hotel Booking Cancellation - Cancellation #" + bookingId);
//             
//             String htmlContent = String.format(
//                "<html><body style='font-family: Arial, sans-serif;'>" +
//                "<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>" +
//                "<h2 style='color: #2c3e50; text-align: center;'>Booking Cancellation</h2>" +
//                "<div style='background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;'>" +
//                "<h3>Dear %s,</h3>" +
//                "<p>Thank you for choosing our hotel! Your booking has been cancelled as per your request.</p>" +
//                "<div style='background: white; padding: 15px; border-radius: 5px; margin: 15px 0;'>" +
//                "<h4 style='color: #2c3e50; margin-top: 0;'>Booking Details:</h4>" +
//                "<p><strong>Booking ID:</strong> %d</p>" +
//                "<p><strong>Room Type:</strong> %s</p>" +
//                "<p><strong>Check-in Date:</strong> %s</p>" +
//                "<p><strong>Check-out Date:</strong> %s</p>" +
//                "</div>" +
//                "<p>We look forward to welcoming you!</p>" +
//                "<p>Best regards,<br>Hotel Management Team</p>" +
//                "</div></div></body></html>",
//                customerName, bookingId, roomType, checkIn, checkOut
//            );
//            
//            message.setContent(htmlContent, "text/html");
//            Transport.send(message);
//             return true;
//         }catch(Exception e){
//                e.printStackTrace();
//                return false;
//         }
//    }
    
    public static boolean sendBookingConfirmation(String toEmail, String customerName, 
                                                 String roomType, String checkIn, String checkOut, 
                                                 double totalAmount, int bookingId) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.starttls.required", "true");
        
        
        // Add timeouts to avoid hanging
            props.put("mail.smtp.connectiontimeout", "10000"); // 10 seconds
            props.put("mail.smtp.timeout", "10000");
            props.put("mail.smtp.writetimeout", "10000");
            props.put("mail.debug", "true");
            
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL, PASSWORD);
//                       return super.getPasswordAuthentication(EMAIL,PASSWORD);
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Hotel Booking Confirmation - Booking #" + bookingId);
            
            String htmlContent = String.format(
                "<html><body style='font-family: Arial, sans-serif;'>" +
                "<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>" +
                "<h2 style='color: #2c3e50; text-align: center;'>Booking Confirmation</h2>" +
                "<div style='background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;'>" +
                "<h3>Dear %s,</h3>" +
                "<p>Thank you for choosing our hotel! Your booking has been confirmed.</p>" +
                "<div style='background: white; padding: 15px; border-radius: 5px; margin: 15px 0;'>" +
                "<h4 style='color: #2c3e50; margin-top: 0;'>Booking Details:</h4>" +
                "<p><strong>Booking ID:</strong> %d</p>" +
                "<p><strong>Room Type:</strong> %s</p>" +
                "<p><strong>Check-in Date:</strong> %s</p>" +
                "<p><strong>Check-out Date:</strong> %s</p>" +
                "<p><strong>Total Amount:</strong> $%.2f</p>" +
                "</div>" +
                "<p>We look forward to welcoming you!</p>" +
                "<p>Best regards,<br>Hotel Management Team</p>" +
                "</div></div></body></html>",
                customerName, bookingId, roomType, checkIn, checkOut, totalAmount
            );
            
            message.setContent(htmlContent, "text/html");
            Transport.send(message);
            return true;
            
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}