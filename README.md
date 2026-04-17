#  Business Catalog App (Flutter + Supabase)


A simple yet functional **business catalog mobile application** built with Flutter, designed for small/local businesses to showcase products and receive orders via WhatsApp.

This project serves as a **real-world MVP (Minimum Viable Product)** with authentication, admin control, and backend integration.



##  Features

###  Authentication

* Email & password login/signup
* Session handling using Supabase Auth
* Email-based admin access control

###  Product System

* View product list with image, name, and price
* Product details with description
* Clean and responsive UI (mobile-focused)

###  Admin Panel

* Accessible only by a specific admin email
* Add new products
* Delete existing products
* Simple product management interface

###  Security

* Row Level Security (RLS) policies enabled
* Controlled database access via Supabase

###  Ordering System

* Direct order via WhatsApp using URL launcher
* No complex payment integration (kept simple for MVP)

###  CI/CD

* GitHub Actions pipeline
* Automated build checks
* APK build support



##  Tech Stack

* **Frontend:** Flutter (Dart)
* **Backend:** Supabase
* **Database:** PostgreSQL (via Supabase)
* **Auth:** Supabase Authentication
* **CI/CD:** GitHub Actions
* **State Management:** (add if used, e.g., Riverpod / setState)





##  Environment Setup

1. Create a project in Supabase
2. Enable Email Authentication
3. Create required tables:

### `profiles`

* id (uuid)
* username (text)

### `products`

* id (uuid)
* name (text)
* description (text)
* image_url (text)
* price (numeric)

4. Configure RLS policies accordingly


##  Future Improvements

* Product image upload (Supabase Storage)
* Edit product feature in admin panel
* Search & filtering
* Better state management
* Push notifications


##  Purpose

This project:

* Building an usable app for a small and local commercial FB page.
* FB page link: https://www.facebook.com/share/1Dwze9mQ3C/
  

##  Contribution

Feel free to fork and improve this project.

