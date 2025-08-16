<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.hotel.dao.*, com.hotel.model.*" %>

<%
    RoomDAO roomDAO = new RoomDAO();
    List<Room> availableRooms = new ArrayList<>();
    BookingDAO bookingDAO = new BookingDAO();
    CustomerDAO customerDAO = new CustomerDAO();
    
    try {
        availableRooms = roomDAO.getAllAvailableRooms();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    String action = request.getParameter("action");
    String message = "";
    String messageType = "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Reservations - Luxury Hotel</title>
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

        .navbar {
            background: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 1rem 2rem;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: #667eea;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-links a:hover, .nav-links a.active {
            color: #667eea;
        }

        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 20px;
            text-align: center;
        }

        .page-header h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            font-weight: 700;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .action-btn {
            background: white;
            border: none;
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            text-decoration: none;
            color: inherit;
        }

        .action-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .action-btn i {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: block;
        }

        .action-btn.book { color: #28a745; }
        .action-btn.update { color: #17a2b8; }
        .action-btn.cancel { color: #dc3545; }

        .action-btn h3 {
            font-size: 1.4rem;
            margin-bottom: 0.5rem;
        }

        .content-section {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            display: none;
        }

        .content-section.active {
            display: block;
        }

        .rooms-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .room-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .room-card:hover {
            transform: translateY(-5px);
        }

        .room-image {
            height: 200px;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .room-price {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 600;
        }

        .room-content {
            padding: 1.5rem;
        }

        .room-content h3 {
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .room-amenities {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .book-room-btn {
            width: 100%;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .book-room-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
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
        .form-group select,
        .form-group textarea {
            padding: 12px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .submit-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .alert {
            padding: 1rem 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            font-weight: 500;
        }

        .alert-success {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }

        .alert-error {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }

        .booking-list {
            margin-top: 2rem;
        }

        .booking-item {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border-left: 4px solid #667eea;
        }

        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .booking-id {
            font-weight: 700;
            color: #667eea;
        }

        .booking-status {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-confirmed {
            background: #d4edda;
            color: #155724;
        }

          .modal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            backdrop-filter: blur(5px);
            overflow-y: auto;
            padding: 20px 0;
        }

             .modal-content {
            background: white;
            margin: 0 auto;
            padding: 2rem;
            border-radius: 15px;
            width: 90%;
            max-width: 600px;
            position: relative;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-height: 90vh;
            overflow-y: auto;
            animation: modalSlideIn 0.3s ease-out;
        }
          @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
        
        /* Prevent body scroll when modal is open */
        body.modal-open {
            overflow: hidden;
            height: 100vh;
        }

        .close {
            position: absolute;
            right: 1rem;
            top: 1rem;
            font-size: 1.5rem;
            cursor: pointer;
            color: #999;
        }

        .close:hover {
            color: #333;
        }

        @media (max-width: 768px) {
            .action-buttons {
                grid-template-columns: 1fr;
            }
            
            .rooms-grid {
                grid-template-columns: 1fr;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .booking-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .nav-links {
                display: none;
            }
        }
        
        html {
            scroll-behavior: smooth;
        }
        
        /* Enhanced button styles */
        .action-btn {
            padding: 12px 24px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: bold;
            margin: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        
        .book-btn {
            background: linear-gradient(45deg, #28a745, #20c997);
            color: white;
        }
        
        .update-btn {
            background: linear-gradient(45deg, #ffc107, #fd7e14);
            color: white;
        }
        
        .cancel-btn {
            background: linear-gradient(45deg, #dc3545, #e83e8c);
            color: white;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.3);
        }
        
        /* Section highlighting */
        .highlight-section {
            background: linear-gradient(90deg, #f0f8ff, #e6f3ff);
            border-left: 4px solid #007bff;
            padding: 20px;
            transition: all 0.5s ease;
        }
        
        /* Form animations */
        .fade-in {
            animation: fadeIn 0.5s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Success message */
        .success-message {
            background: #28a745;
            color: white;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            display: none;
            text-align: center;
        }
        
        .success-message.show {
            display: block;
            animation: fadeIn 0.5s ease;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-content">
            <div class="logo">
                <i class="fas fa-hotel"></i> Luxury Hotel
            </div>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="about.jsp">About Us</a></li>
                <li><a href="reservation.jsp" class="active">Reservations</a></li>
                
            </ul>
        </div>
    </nav>

    <header class="page-header">
        <h1>Room Reservations</h1>
        <p>Book your perfect stay with us</p>
    </header>

    <div class="container">
        <% if (!message.isEmpty()) { %>
            <div class="alert <%= messageType.equals("success") ? "alert-success" : "alert-error" %>">
                <%= message %>
            </div>
        <% } %>
    </div>
    
    </div>
    <div class="action-buttons">
            <div class="action-btn book" onclick="showSection('booking-section'); scrollToBooking();">
                <i class="fas fa-calendar-plus"></i>
                <h3>New Room Booking</h3>
                <p>Book a new room for your stay</p>
            </div>
            <div class="action-btn update" onclick="showSection('update-section'); scrollToUpdate();">
                <i class="fas fa-edit"></i>
                <h3>Update Details</h3>
                <p>Modify your existing booking</p>
            </div>
            <div class="action-btn cancel" onclick="showSection('cancel-section'); scrollToCancel();">
                <i class="fas fa-times-circle"></i>
                <h3>Cancel Booking</h3>
                <p>Cancel your room reservation</p>
            </div>
        </div>

        <!-- New Room Booking Section -->
        <div id="booking-section" class="content-section">
            <h2><i class="fas fa-bed"></i> Available Rooms</h2>
            <div class="rooms-grid">
                <% for (Room room : availableRooms) { %>
                    <div class="room-card">
                        <div class="room-image" style="background-image: url('<%= room.getImageUrl() %>')">
                            <div class="room-price">$<%= String.format("%.2f", room.getPrice()) %>/night</div>
                        </div>
                        <div class="room-content">
                            <h3><%= room.getRoomType() %> - Room #<%= room.getRoomNumber() %></h3>
                            <div class="room-amenities">
                                <i class="fas fa-users"></i> Up to <%= room.getCapacity() %> guests<br>
                                <i class="fas fa-concierge-bell"></i> <%= room.getAmenities() %>
                            </div>
                            <button class="book-room-btn" onclick="selectRoom(<%= room.getRoomId() %>, '<%= room.getRoomType() %>', <%= room.getPrice() %>)">
                                Select This Room
                            </button>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>

        <!-- Update Booking Section -->
        <div id="update-section" class="content-section">
            <h2><i class="fas fa-edit"></i> Update Booking Details</h2>
            <form action="updateBooking.jsp" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="search-email">Enter Your Email</label>
                        <input type="email" id="search-email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <button type="submit" class="submit-btn">Find My Bookings</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Cancel Booking Section -->
        <div id="cancel-section" class="content-section">
            <h2><i class="fas fa-times-circle"></i> Cancel Room Booking</h2>
            <form action="cancelBooking.jsp" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="cancel-email">Enter Your Email</label>
                        <input type="email" id="cancel-email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <button type="submit" class="submit-btn">Find Bookings to Cancel</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Booking Modal -->
    <div id="bookingModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Complete Your Booking</h2>
            <form action="processBooking.jsp" method="post">
                <input type="hidden" id="selectedRoomId" name="roomId">
                <input type="hidden" id="roomPrice" name="roomPrice">
                
                <div class="form-group">
                    <label>Selected Room</label>
                    <input type="text" id="selectedRoom" readonly>
                </div>
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="firstName">First Name *</label>
                        <input type="text" id="firstName" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name *</label>
                        <input type="text" id="lastName" name="lastName" required>
                    </div>
                </div>
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number *</label>
                        <input type="tel" id="phone" name="phone" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address" rows="3"></textarea>
                </div>
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="checkIn">Check-in Date *</label>
                        <input type="date" id="checkIn" name="checkInDate" required>
                    </div>
                    <div class="form-group">
                        <label for="checkOut">Check-out Date *</label>
                        <input type="date" id="checkOut" name="checkOutDate" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="specialRequests">Special Requests</label>
                    <textarea id="specialRequests" name="specialRequests" rows="3" placeholder="Any special requests or preferences..."></textarea>
                </div>
                
                <div class="form-group">
                    <label>Total Amount: $<span id="totalAmount">0.00</span></label>
                </div>
                
                <button type="submit" class="submit-btn">
                    <i class="fas fa-credit-card"></i> Complete Booking
                </button>
                <div id="successMessage" class="success-message">
                Operation completed successfully!
                </div>
            </form>
        </div>
    </div>
<script>
    let selectedRoomPrice = 0;

    // Utility function to hide all sections
    function hideAllSections() {
        document.querySelectorAll('.content-section').forEach(section => {
            section.classList.remove('active');
        });
    }

    // Generic scroll function
    function scrollToSection(sectionId) {
        const section = document.getElementById(sectionId);
        if (section) {
            section.scrollIntoView({ behavior: 'smooth' });
        }
    }

    // Specific scroll functions
    function scrollToBooking() {
        showSection('booking-section');
        setTimeout(() => scrollToSection('booking-section'), 100);
    }

    function scrollToUpdate() {
        showSection('update-section');
        setTimeout(() => scrollToSection('update-section'), 100);
    }

    function scrollToCancel() {
        showSection('cancel-section');
        setTimeout(() => scrollToSection('cancel-section'), 100);
    }

    function showSection(sectionId) {
        hideAllSections();
        const targetSection = document.getElementById(sectionId);
        if (targetSection) {
            targetSection.classList.add('active');
        }
    }

    function selectRoom(roomId, roomType, price) {
        selectedRoomPrice = price;
        
        // Check if elements exist before setting values
        const selectedRoomIdInput = document.getElementById('selectedRoomId');
        const roomPriceInput = document.getElementById('roomPrice');
        const selectedRoomInput = document.getElementById('selectedRoom');
        const modal = document.getElementById('bookingModal');
        
        if (selectedRoomIdInput) selectedRoomIdInput.value = roomId;
        if (roomPriceInput) roomPriceInput.value = price;
        if (selectedRoomInput) selectedRoomInput.value = roomType;
        
        if (modal) {
            modal.style.display = 'block';
            document.body.classList.add('modal-open');
        }
        
        calculateTotal();
    }

    function closeModal() {
        const modal = document.getElementById('bookingModal');
        if (modal) {
            modal.style.display = 'none';
            document.body.classList.remove('modal-open');
        }
    }

    function calculateTotal() {
        const checkInInput = document.getElementById('checkIn');
        const checkOutInput = document.getElementById('checkOut');
        const totalAmountElement = document.getElementById('totalAmount');
        
        if (!checkInInput || !checkOutInput || !totalAmountElement) return;
        
        const checkIn = checkInInput.value;
        const checkOut = checkOutInput.value;
        
        if (checkIn && checkOut) {
            const startDate = new Date(checkIn);
            const endDate = new Date(checkOut);
            const timeDiff = endDate.getTime() - startDate.getTime();
            const dayDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
            
            if (dayDiff > 0) {
                const total = dayDiff * selectedRoomPrice;
                totalAmountElement.textContent = total.toFixed(2);
            } else {
                totalAmountElement.textContent = '0.00';
            }
        }
    }

    // Initialize date inputs and event listeners
    function initializeDateInputs() {
        const checkInInput = document.getElementById('checkIn');
        const checkOutInput = document.getElementById('checkOut');
        
        if (checkInInput && checkOutInput) {
            const today = new Date().toISOString().split('T')[0];
            checkInInput.min = today;
            checkOutInput.min = today;
            
            checkInInput.addEventListener('change', function() {
                const checkInDate = new Date(this.value);
                checkInDate.setDate(checkInDate.getDate() + 1);
                checkOutInput.min = checkInDate.toISOString().split('T')[0];
                calculateTotal();
            });
            
            checkOutInput.addEventListener('change', calculateTotal);
        }
    }

    // Modal click outside handler
    function initializeModalHandler() {
        window.onclick = function(event) {
            const modal = document.getElementById('bookingModal');
            if (modal && event.target === modal) {
                closeModal();
            }
        };
    }

    // Initialize everything when DOM is loaded
    document.addEventListener('DOMContentLoaded', function() {
        showSection('booking-section');
        initializeDateInputs();
        initializeModalHandler();
        
        // Add event listeners for navigation buttons if they exist
        const bookingBtn = document.getElementById('bookingBtn');
        const updateBtn = document.getElementById('updateBtn');
        const cancelBtn = document.getElementById('cancelBtn');
        
        if (bookingBtn) bookingBtn.addEventListener('click', scrollToBooking);
        if (updateBtn) updateBtn.addEventListener('click', scrollToUpdate);
        if (cancelBtn) cancelBtn.addEventListener('click', scrollToCancel);
    });
</script>

</body>
</html>
