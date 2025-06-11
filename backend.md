# Backend Coding Challenge

You are tasked with designing and implementing a RESTful API for managing a simple blogging platform. The core functionality of this platform includes managing blog posts and their
associated comments.

## Requirements:
### Data Models:
 - Create two data models: BlogPost and Comment. A BlogPost has a title and content, and each BlogPost can have multiple Comment objects associated with it.

### API Endpoints:
 - Implement the following API endpoints:
   - GET /api/posts: This endpoint should return a list of all blog posts, including their titles and the number of comments associated with each post.
   - POST /api/posts: Create a new blog post.
   - GET /api/posts/{id}: Retrieve a specific blog post by its ID, including its title, content, and a list of associated comments.
   - POST /api/posts/{id}/comments: Add a new comment to a specific blog post.

## Challenge Submission

Please send an email to the hiring manager including a Github link to the code you created at your earliest convenience. Bear in mind that the code should be production ready but it's ok to not
complete it in full. Please don't dedicate more than 4 hours to work on this project.
Please add a README with instructions to run it, and what would be your next steps if you had more time available.
