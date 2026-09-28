# Node.js Backend Assignment – Authentication & Protected APIs

## Objective

Build a REST API using **Node.js** and **PostgreSQL** that implements user authentication, JWT-based authorization, password hashing, ORM-based database operations, and database migrations.

The application should contain:

* User Registration API
* User Login API
* Protected Insert API
* Protected Get API
* JWT Authentication & Authorization
* Password Hashing
* PostgreSQL Database
* ORM
* Database Migrations
* Postman Collection

---

## Technology Requirements

Use the following technologies:

* **Node.js**
* **Express.js**
* **PostgreSQL**
* Any Node.js ORM such as:

  * Sequelize
  * TypeORM
  * Prisma
* **Database Migrations**
* **JWT (JSON Web Token)**
* **bcrypt / bcryptjs** for password hashing
* **Postman** for API testing

Do not store plain-text passwords in the database.

---

# Task

Create a backend application with authentication and a protected resource.

The application should have two database entities/tables:

1. `users`
2. `products`

You may use another meaningful resource instead of `products`, such as `posts`, `tasks`, `notes`, etc.

---

# Database Structure

## Users Table

Create the `users` table using a migration.

Suggested fields:

| Field      | Type           | Requirement      |
| ---------- | -------------- | ---------------- |
| id         | Integer / UUID | Primary Key      |
| name       | String         | Required         |
| email      | String         | Required, Unique |
| password   | String         | Required, Hashed |
| created_at | Timestamp      | Required         |
| updated_at | Timestamp      | Required         |

---

## Products Table

Create the `products` table using a migration.

Suggested fields:

| Field       | Type           | Requirement          |
| ----------- | -------------- | -------------------- |
| id          | Integer / UUID | Primary Key          |
| name        | String         | Required             |
| description | Text           | Optional             |
| price       | Decimal        | Required             |
| user_id     | Integer / UUID | Foreign Key to users |
| created_at  | Timestamp      | Required             |
| updated_at  | Timestamp      | Required             |

Each product must belong to the authenticated user who created it.

---

# API Requirements

## 1. Register User

### Endpoint

`POST /api/auth/register`

### Request Body

```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

### Requirements

* Validate required fields.
* Email must be unique.
* Validate email format.
* Password should have a reasonable minimum length.
* Hash the password using `bcrypt` or `bcryptjs` before saving it.
* Never return the hashed password in the API response.
* Return an appropriate error if the email is already registered.

### Example Success Response

```json
{
  "message": "User registered successfully",
  "data": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com"
  }
}
```

---

# 2. Login User

### Endpoint

`POST /api/auth/login`

### Request Body

```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

### Requirements

* Check whether the user exists.
* Compare the supplied password with the hashed password stored in PostgreSQL.
* Generate a JWT after successful authentication.
* JWT should contain sufficient information to identify the user.
* JWT must have an expiry time.
* JWT secret must come from an environment variable.

### Example Success Response

```json
{
  "message": "Login successful",
  "token": "JWT_TOKEN_HERE"
}
```

Return an appropriate HTTP status code and message for invalid credentials.

---

# 3. Insert Product – Protected API

### Endpoint

`POST /api/products`

### Authorization

This endpoint must require a JWT.

The token should be passed using:

```text
Authorization: Bearer <JWT_TOKEN>
```

### Request Body

```json
{
  "name": "Wireless Keyboard",
  "description": "Mechanical wireless keyboard",
  "price": 2500
}
```

### Requirements

* Verify the JWT using authentication middleware.
* Reject requests without a valid token.
* Extract the authenticated user's ID from the JWT.
* Save the product against the authenticated user.
* `user_id` should not be manually accepted from the client.
* Validate required fields before inserting the record.

### Example Success Response

```json
{
  "message": "Product created successfully",
  "data": {
    "id": 1,
    "name": "Wireless Keyboard",
    "description": "Mechanical wireless keyboard",
    "price": 2500,
    "user_id": 1
  }
}
```

---

# 4. Get Products – Protected API

### Endpoint

`GET /api/products`

### Authorization

```text
Authorization: Bearer <JWT_TOKEN>
```

### Requirements

* The API must be protected using JWT authentication middleware.
* Return only the products belonging to the currently authenticated user.
* A user must not be able to access another user's products.

### Example Success Response

```json
{
  "message": "Products fetched successfully",
  "data": [
    {
      "id": 1,
      "name": "Wireless Keyboard",
      "description": "Mechanical wireless keyboard",
      "price": 2500
    }
  ]
}
```

---

# Authentication & Authorization

Create reusable authentication middleware.

The middleware should:

1. Read the `Authorization` header.
2. Extract the Bearer token.
3. Verify the JWT.
4. Handle expired or invalid tokens.
5. Extract the authenticated user's information.
6. Attach the authenticated user information to the request.
7. Allow the request to continue only when authentication is successful.

The following APIs should be public:

```text
POST /api/auth/register
POST /api/auth/login
```

The following APIs should be protected:

```text
POST /api/products
GET /api/products
```

---

# ORM Requirements

All database operations must be performed through an ORM.

Raw SQL should not be used for normal CRUD operations.

Define proper ORM models/entities for:

* User
* Product

Configure the relationship so that:

```text
User has many Products
Product belongs to User
```

---

# Migration Requirements

Database tables must be created using migrations.

At minimum, create migrations for:

```text
users
products
```

The project should support commands for:

```bash
Run migrations
Rollback migrations
```

Do not require the evaluator to manually create tables in PostgreSQL.

---

# Environment Variables

Sensitive configuration must be stored using environment variables.

Example `.env.example`:

```env
PORT=3000

DB_HOST=localhost
DB_PORT=5432
DB_NAME=assignment_db
DB_USER=postgres
DB_PASSWORD=your_password

JWT_SECRET=your_jwt_secret
JWT_EXPIRES_IN=1h
```

Do not commit the actual `.env` file containing secrets.

---

# Validation & Error Handling

Implement appropriate validation and error handling.

Handle cases such as:

* Missing required fields
* Invalid email
* Duplicate email
* Invalid password
* Invalid login credentials
* Missing JWT
* Invalid JWT
* Expired JWT
* Invalid product data
* Database errors
* Resource not found

Use appropriate HTTP status codes such as:

```text
200 - Success
201 - Created
400 - Bad Request
401 - Unauthorized
403 - Forbidden
404 - Not Found
409 - Conflict
500 - Internal Server Error
```

API responses should follow a consistent structure.

Example:

```json
{
  "message": "Readable message",
  "data": {}
}
```

For errors:

```json
{
  "message": "Error message"
}
```

---

# Suggested Project Structure

A clean project structure is expected.

Example:

```text
src/
├── config/
│   └── database.js
├── controllers/
│   ├── auth.controller.js
│   └── product.controller.js
├── middleware/
│   └── auth.middleware.js
├── models/
│   ├── user.model.js
│   └── product.model.js
├── migrations/
├── routes/
│   ├── auth.routes.js
│   └── product.routes.js
├── services/
├── utils/
└── app.js

server.js
.env.example
package.json
README.md
```

The exact structure may differ, but the code should maintain proper separation of concerns.

---

# Postman Requirements

Create and submit a **Postman Collection** containing all four APIs:

```text
1. Register User
2. Login User
3. Insert Product
4. Get Products
```

The collection should demonstrate the complete flow:

```text
Register
   ↓
Login
   ↓
Receive JWT
   ↓
Create Product using JWT
   ↓
Get Products using JWT
```

Preferably store the JWT in a Postman collection/environment variable and reuse it for protected APIs.

---

# README Requirements

Include a `README.md` containing:

* Project overview
* Technology stack
* Prerequisites
* Installation steps
* PostgreSQL database setup
* Environment variable configuration
* Migration commands
* How to start the server
* API documentation
* Postman testing instructions

Example setup flow:

```bash
git clone <repository-url>

cd <project-folder>

npm install

cp .env.example .env

# Configure PostgreSQL credentials

npm run migration:run

npm run dev
```

Commands may vary depending on the ORM selected.

---

# Expected API Flow

```text
POST /api/auth/register
        |
        v
User created with hashed password
        |
        v
POST /api/auth/login
        |
        v
Password verification
        |
        v
JWT generated
        |
        v
POST /api/products
Authorization: Bearer JWT
        |
        v
Product created for authenticated user
        |
        v
GET /api/products
Authorization: Bearer JWT
        |
        v
Return products belonging to authenticated user
```

---

# Evaluation Criteria

The assignment will be evaluated based on:

### Functionality

* Registration works correctly.
* Login works correctly.
* Passwords are securely hashed.
* JWT is generated and verified correctly.
* Protected APIs cannot be accessed without authentication.
* Insert API works correctly.
* Get API returns the correct user's records.

### Database

* PostgreSQL is used.
* ORM is correctly configured.
* Migrations are implemented.
* Relationships between tables are correctly defined.

### Code Quality

* Clean and readable code.
* Proper folder structure.
* Reusable middleware.
* Separation of routes, controllers, models, and business logic.
* Proper use of async/await.
* Proper error handling.
* No sensitive credentials hardcoded in the source code.

### API Quality

* Appropriate HTTP status codes.
* Proper request validation.
* Consistent API responses.
* Correct authorization behavior.

### Documentation

* README is complete.
* `.env.example` is provided.
* Postman Collection is provided.
* Setup instructions work correctly.

---

# Bonus Points

The following are optional but will be considered additional positives:

* Request validation using Joi, Zod, Yup, or express-validator
* Centralized error handling middleware
* Refresh token implementation
* API pagination
* Search/filter support
* Docker setup
* Swagger/OpenAPI documentation
* Unit/integration tests
* Proper logging
* ESLint/Prettier configuration

---

# Submission

Submit:

```text
1. Git repository URL
2. README.md
3. .env.example (do not commit original credentials)
4. Database migrations
5. Postman Collection JSON
```

The application should run locally after installing dependencies, configuring PostgreSQL credentials, and executing the migrations.

## Important

The evaluator should **not need to manually create database tables or manually insert records** for the application to work. Database schema creation must be handled through migrations.
