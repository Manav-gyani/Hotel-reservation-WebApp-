/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */


document.addEventListener('DOMContentLoaded', function() {
            console.log('Hotel Reservation System Initialized');

            // Smooth scrolling function with enhanced animation
            function scrollToSection(sectionId, animationClass = 'fade-in') {
                const targetSection = document.getElementById(sectionId);
                if (targetSection) {
                    // First scroll to the section
                    targetSection.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                    
                    // Hide all other sections
                    hideAllSections();
                    
                    // Show target section with animation
                    setTimeout(() => {
                        targetSection.classList.add('active');
                        targetSection.classList.add(animationClass);
                        
                        // Add highlight effect
                        targetSection.classList.add('highlight-section');
                        setTimeout(() => {
                            targetSection.classList.remove('highlight-section');
                        }, 2000);
                        
                        // Remove animation class after animation completes
                        setTimeout(() => {
                            targetSection.classList.remove(animationClass);
                        }, 600);
                    }, 100);
                }
            }

            // Hide all form sections
            function hideAllSections() {
                const sections = document.querySelectorAll('.form-section');
                sections.forEach(section => {
                    section.classList.remove('active');
                    section.classList.remove('fade-in', 'slide-in', 'bounce-in');
                });
            }

            // Show success message
            function showSuccessMessage(message) {
                const successDiv = document.getElementById('successMessage');
                successDiv.querySelector('p').textContent = message;
                successDiv.classList.add('show');
                
                // Hide after 4 seconds
                setTimeout(() => {
                    successDiv.classList.remove('show');
                }, 4000);
                
                // Scroll to top to show message
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            }

            // Book New Room Button Handler
            const bookButton = document.getElementById('bookNewRoomBtn');
            if (bookButton) {
                bookButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('Book New Room clicked');
                    
                    // Add loading state
                    const originalText = this.innerHTML;
                    this.innerHTML = originalText + '<span class="loading"></span>';
                    this.disabled = true;
                    
                    setTimeout(() => {
                        this.innerHTML = originalText;
                        this.disabled = false;
                        scrollToSection('booking-form-section', 'fade-in');
                        setupDateValidation();
                    }, 500);
                });
            }

            // Update Details Button Handler
            const updateButton = document.getElementById('updateDetailsBtn');
            if (updateButton) {
                updateButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('Update Details clicked');
                    
                    const originalText = this.innerHTML;
                    this.innerHTML = originalText + '<span class="loading"></span>';
                    this.disabled = true;
                    
                    setTimeout(() => {
                        this.innerHTML = originalText;
                        this.disabled = false;
                        scrollToSection('update-form-section', 'slide-in');
                    }, 500);
                });
            }

            // Cancel Booking Button Handler
            const cancelButton = document.getElementById('cancelBookingBtn');
            if (cancelButton) {
                cancelButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('Cancel Booking clicked');
                    
                    const originalText = this.innerHTML;
                    this.innerHTML = originalText + '<span class="loading"></span>';
                    this.disabled = true;
                    
                    setTimeout(() => {
                        this.innerHTML = originalText;
                        this.disabled = false;
                        scrollToSection('cancel-section', 'bounce-in');
                    }, 500);
                });
            }

            // Form Submission Handlers
            
            // Booking Form
            const bookingForm = document.getElementById('bookingForm');
            if (bookingForm) {
                bookingForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    console.log('Booking form submitted');
                    
                    // Simulate processing
                    const submitBtn = this.querySelector('.submit-btn');
                    submitBtn.innerHTML = 'Processing... <span class="loading"></span>';
                    submitBtn.disabled = true;
                    
                    // Here you would normally send data to your server
                    setTimeout(() => {
                        submitBtn.innerHTML = 'Confirm Booking';
                        submitBtn.disabled = false;
                        
                        // Hide form and show success message
                        hideAllSections();
                        showSuccessMessage('Room booked successfully! Confirmation email sent.');
                        
                        // Reset form
                        this.reset();
                    }, 2000);
                });
            }

            // Update Form
            const updateForm = document.getElementById('updateForm');
            if (updateForm) {
                updateForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    console.log('Update form submitted');
                    
                    const submitBtn = this.querySelector('.submit-btn');
                    submitBtn.innerHTML = 'Updating... <span class="loading"></span>';
                    submitBtn.disabled = true;
                    
                    setTimeout(() => {
                        submitBtn.innerHTML = 'Update Booking';
                        submitBtn.disabled = false;
                        
                        hideAllSections();
                        showSuccessMessage('Booking updated successfully!');
                        this.reset();
                    }, 2000);
                });
            }

            // Cancel Confirmation Handlers
            const confirmCancelBtn = document.getElementById('confirmCancel');
            const keepBookingBtn = document.getElementById('keepBooking');

            if (confirmCancelBtn) {
                confirmCancelBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    const bookingId = document.getElementById('cancelBookingId').value;
                    
                    if (!bookingId.trim()) {
                        alert('Please enter your booking ID');
                        return;
                    }
                    
                    this.innerHTML = 'Cancelling... <span class="loading"></span>';
                    this.disabled = true;
                    
                    setTimeout(() => {
                        this.innerHTML = 'Yes, Cancel Booking';
                        this.disabled = false;
                        
                        hideAllSections();
                        showSuccessMessage('Booking cancelled successfully. Refund will be processed within 3-5 business days.');
                        document.getElementById('cancelBookingId').value = '';
                    }, 2000);
                });
            }

            if (keepBookingBtn) {
                keepBookingBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    hideAllSections();
                    showSuccessMessage('Great! Your booking has been kept active.');
                });
            }

            // Date validation for booking form
            function setupDateValidation() {
                const checkinInput = document.getElementById('checkin');
                const checkoutInput = document.getElementById('checkout');
                
                if (checkinInput && checkoutInput) {
                    // Set minimum date to today
                    const today = new Date().toISOString().split('T')[0];
                    checkinInput.min = today;
                    
                    checkinInput.addEventListener('change', function() {
                        const checkinDate = new Date(this.value);
                        const minCheckout = new Date(checkinDate);
                        minCheckout.setDate(minCheckout.getDate() + 1);
                        
                        checkoutInput.min = minCheckout.toISOString().split('T')[0];
                        
                        if (checkoutInput.value && new Date(checkoutInput.value) <= checkinDate) {
                            checkoutInput.value = '';
                        }
                    });
                }
            }

            // Initialize date validation on page load
            setupDateValidation();

            // Close sections when clicking outside
            document.addEventListener('click', function(e) {
                if (e.target.classList.contains('form-section')) {
                    // Optional: Close form when clicking on the background
                    // hideAllSections();
                }
            });

            console.log('All event listeners attached successfully');
        });