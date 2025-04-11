# Event Booking System

## Description

This is a Ruby on Rails API-based event booking system. It allows **event organizers** to manage their events and **customers** to book tickets. The app also sends email-like notifications (via Sidekiq jobs) on booking confirmations and event updates.

> ✅ Live API base URL: [`https://my-rails-api-zpd2.onrender.com`](https://my-rails-api-zpd2.onrender.com)

---

## Features

- ✅ Event management (Create, Update, Delete) for Event Organizers
- ✅ Event viewing for both Customers and Organizers
- ✅ Customers can book event tickets
- ✅ Background jobs (via Sidekiq) for sending notifications
- ✅ JWT-based authentication with Devise for secure access

---

## Prerequisites

- Ruby 3.2.2 or higher
- Rails 8.0.2 or higher
- PostgreSQL (or SQLite for local)
- Redis (for Sidekiq)
- Node.js + Yarn (if you’re adding frontend later)

---

## Setup Instructions (Local)

### 1. Clone the Repository

```bash
git clone https://github.com/jsingh0026/event-booking-ror
cd event-booking-ror
```

### 2. Install Dependencies

```bash
bundle install
```

### 3. Setup the Database

```bash
rails db:create
rails db:migrate
rails db:seed  # Optional seed data
```

### 4. Run Redis (for Sidekiq)

```bash
brew services start redis   # macOS
redis-server                # Or start manually
```

### 5. Start Rails API Server

```bash
rails server
```

Now open: [http://localhost:3000](http://localhost:3000)

### 6. Start Sidekiq

```bash
bundle exec sidekiq
```

---

## API Testing with Postman

A ready-to-use Postman collection is available.

- 📥 [Import this collection](#) (replace with your download link)
- 🔐 Use JWT tokens as global variables for `Authorization` headers
- 🎯 Environment-ready with base URL and auth variables
