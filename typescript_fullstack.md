# Coding Challenge - TypeScript - Fullstack Assessment

# The eCommerce Product Management

## Instructions

Create a fullstack TypeScript application for showing and managing available products on a webstore.

The project should be structured as a **monorepo** with separate backend and frontend applications (e.g. `apps/api`, `apps/web`) and, optionally, shared packages (e.g. `packages/types`) for typed contracts between them.

## Requirements

### General

Language: **TypeScript** (strict mode enabled)

Monorepo: Organize the project with a clear separation between backend and frontend applications.

### Backend

Framework: Use a modern TypeScript backend framework such as **NestJS**, **Hono**, **Express**, or similar.

Database: **PostgreSQL**

Expose a **RESTful API** for all product operations. The API should follow standard REST conventions and return well-structured JSON responses.

### Frontend

Framework: Use **React**, **Next.js**, or a comparable modern frontend framework.

Styling is up to you, but keep it readable, usable, and responsive.

Consume the backend API to display and manage products. Shared TypeScript types or interfaces between frontend and backend are encouraged.

### Product Entity

A product in the ecommerce context should at least have:
- **Name**
- **Picture** (URL or uploaded image)
- **Price**
- A list of up to **10 attributes** (e.g. color, size, material, etc.)

### Infrastructure

Create a **Docker Compose** configuration for running the full solution (backend, frontend, and database).

## Views

**Product Show View:**
- Display all active products.
- Show name, picture, price, and attributes.

**Product Management View:**
- Allow adding new products.
- Allow deactivating and re-activating products.
- Deactivated products should no longer appear in the Product Show View.

Authentication and private/public handling of the views are not part of the assessment. It's something that would be built in the future.

## Time Constraint

Try to keep your development to around **5 hours**. We want to see your work, but we also don't want to take up a ton of your time. Use judgement on what will help showcase your skills appropriately.

If you run out of time, it is okay to not implement all of the requested features in the challenge.

## Evaluation Criteria

**TypeScript & Code Quality**
- Proper use of TypeScript strict mode, type annotations, interfaces, and generics where appropriate. Avoid `any`.
- Clean, maintainable code structure with clear separation of concerns.

**Backend Best Practices**
- Well-designed RESTful API with proper HTTP methods, status codes, and error handling.
- Good use of the chosen framework's conventions (e.g. modules, controllers, services, middleware).
- Input validation and data sanitization.

**Database Schema & Relationships**
- Clear PostgreSQL schema design with proper use of relationships (e.g. one-to-many for products and attributes).
- Use of migrations and seeders.

**Frontend**
- Component-based architecture with reusable components.
- Clean state management and API integration.
- Responsive, readable, and usable interface.

**Typed Contracts**
- Shared or consistent TypeScript types/interfaces between frontend and backend (e.g. shared package, matching DTOs, or equivalent approach).

**Docker & Documentation**
- Docker Compose runs the full stack (API, frontend, database) with a single command.
- README with clear setup instructions and any design decisions or trade-offs.

**Automated Testing (Bonus)**
- Unit, integration, or end-to-end tests demonstrating testing best practices.

## How to Submit

Please make your code public and send a link to the GitHub repository.
