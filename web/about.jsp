<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Luxury Hotel</title>
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
            padding: 100px 20px;
            text-align: center;
        }

        .page-header h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            font-weight: 700;
        }

        .page-header p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto;
        }

        .about-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 80px 20px;
        }

        .about-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
            margin-bottom: 5rem;
        }

        .about-section:nth-child(even) {
            direction: rtl;
        }

        .about-section:nth-child(even) > * {
            direction: ltr;
        }

        .about-text h2 {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            color: #333;
        }

        .about-text p {
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
            color: #666;
        }

        .about-image {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .about-image img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .about-image:hover img {
            transform: scale(1.05);
        }

        .personal-info {
            background: #f8f9fa;
            padding: 60px 20px;
            margin-top: 4rem;
        }

        .personal-content {
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
        }

        .personal-content h2 {
            font-size: 2.5rem;
            margin-bottom: 2rem;
            color: #333;
        }

        .owner-card {
            background: white;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            margin-top: 2rem;
        }

        .owner-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin: 0 auto 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: white;
        }

        .owner-details h3 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .owner-details p {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 1rem;
        }

        .contact-info {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #667eea;
            font-weight: 500;
        }

        .stats {
            background: #333;
            color: white;
            padding: 60px 20px;
        }

        .stats-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            text-align: center;
        }

        .stat-item h3 {
            font-size: 3rem;
            color: #667eea;
            margin-bottom: 0.5rem;
        }

        .stat-item p {
            font-size: 1.2rem;
            color: #ccc;
        }

        @media (max-width: 768px) {
            .about-section {
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .page-header h1 {
                font-size: 2.5rem;
            }

            .contact-info {
                flex-direction: column;
                gap: 1rem;
            }

            .nav-links {
                display: none;
            }
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
                <li><a href="about.jsp" class="active">About Us</a></li>
                <li><a href="reservation.jsp">Reservations</a></li>
                <!--<li><a href="#contact">Contact</a></li>-->
            </ul>
        </div>
    </nav>

    <header class="page-header">
        <h1>About Our Hotel</h1>
        <p>Discover the story behind our commitment to exceptional hospitality and luxury experiences</p>
    </header>

    <main class="about-content">
        <section class="about-section">
            <div class="about-text">
                <h2>Our Story</h2>
                <p>Our luxury hotel has been a beacon of hospitality excellence for over three decades. What started as a vision to create the perfect blend of comfort and elegance has evolved into one of the most prestigious hotels in the region.</p>
                <p>We pride ourselves on providing personalized service, world-class amenities, and unforgettable experiences that create lasting memories for our guests from around the world.</p>
            </div>
            <div class="about-image">
                <img src="https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=600&h=400&fit=crop" alt="Hotel History">
            </div>
        </section>

        <section class="about-section">
            <div class="about-text">
                <h2>Our Mission</h2>
                <p>To exceed our guests' expectations by providing exceptional service, luxurious accommodations, and memorable experiences in an atmosphere of warmth and hospitality.</p>
                <p>We are committed to continuous innovation while maintaining the timeless values of genuine care, attention to detail, and respect for our guests, employees, and community.</p>
            </div>
            <div class="about-image">
                <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=600&h=400&fit=crop" alt="Hotel Mission">
            </div>
        </section>

        <section class="about-section">
            <div class="about-text">
                <h2>Our Vision</h2>
                <p>To be recognized as the leading luxury hotel destination, setting new standards in hospitality excellence and creating extraordinary experiences that inspire and delight our guests.</p>
                <p>We envision a future where every guest leaves with cherished memories and a desire to return to our exceptional haven of luxury and comfort.</p>
            </div>
            <div class="about-image">
                <img src="https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=600&h=400&fit=crop" alt="Hotel Vision">
            </div>
        </section>
    </main>

    <section class="personal-info">
        <div class="personal-content">
            <h2>Meet the Owner</h2>
            <div class="owner-card">
                <div class="owner-image">
                    <i class="fas fa-user"></i>
                </div>
                <div class="owner-details">
                    <h3>Manav Gyani</h3>
                    <p>Founder & Managing Director</p>
                    <p>With over 5 years of experience in the hospitality industry, Manav brings a passion for excellence and a vision for creating extraordinary guest experiences. His dedication to quality and innovation has made our hotel a premier destination for travelers worldwide.</p>
                    
                    <div class="contact-info">
                        <div class="contact-item">
                            <i class="fas fa-envelope"></i>
                            <span>manavgyani79@gmail.com</span>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-phone"></i>
                            <span>+91 8200913455</span>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Vadodara , Gujarat</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="stats">
        <div class="stats-container">
            <div class="stat-item">
                <h3>500+</h3>
                <p>Luxury Rooms</p>
            </div>
            <div class="stat-item">
                <h3>50,000+</h3>
                <p>Happy Guests</p>
            </div>
            <div class="stat-item">
                <h3>5+</h3>
                <p>Years of Excellence</p>
            </div>
            <div class="stat-item">
                <h3>98%</h3>
                <p>Guest Satisfaction</p>
            </div>
        </div>
    </section>
</body>
</html>

