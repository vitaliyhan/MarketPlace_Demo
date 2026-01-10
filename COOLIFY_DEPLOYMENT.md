# Coolify Deployment Guide for Marketplace Demo

This guide will help you deploy your Spring Boot marketplace application to Coolify using Docker.

## Prerequisites

1. **Coolify Server**: You need access to a Coolify server
2. **Git Repository**: Your code should be pushed to a Git repository (GitHub, GitLab, etc.)
3. **Domain**: Optional but recommended for production

## Step 1: Push Your Code to Git

Make sure your code is pushed to a Git repository:

```bash
git add .
git commit -m "Add Docker support for Coolify deployment"
git push origin main
```

## Step 2: Create a New Project in Coolify

1. Log in to your Coolify dashboard
2. Click "Create Project"
3. Choose your Git provider and select your repository
4. Configure the project settings

## Step 3: Configure Environment Variables

In your Coolify project settings, add the following environment variables:

### Required Variables
```
PORT=8080
DATABASE_URL=jdbc:postgresql://db:5432/mktplace
DB_USERNAME=postgres
DB_PASSWORD=your_secure_password_here
DDL_AUTO=update
```

### Optional Variables
```
SHOW_SQL=false
LOG_LEVEL=INFO
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_SMTP_AUTH=true
MAIL_SMTP_STARTTLS=true
```

## Step 4: Database Setup

### Option A: Use Coolify's Built-in PostgreSQL
1. In Coolify, go to your project → Databases
2. Create a new PostgreSQL database
3. Note the connection details (they'll be auto-configured)

### Option B: External Database
If using an external PostgreSQL database, update the `DATABASE_URL` accordingly.

## Step 5: Deploy Configuration

1. **Build Settings**:
   - Build Pack: `Docker`
   - Dockerfile Path: `./Dockerfile` (leave default)
   - **Note**: The Dockerfile builds the JAR from source code during the build process, not using any pre-existing JAR files

2. **Port Configuration**:
   - Internal Port: `8081`
   - Exposed Port: `80` or `443` (depending on SSL)

3. **Health Check**:
   - Health Check Path: `/actuator/health` (if you add Spring Boot Actuator)

## Step 6: Deploy

1. Click "Deploy" in Coolify
2. Monitor the build logs for any issues
3. Once deployed, your application will be available at the generated URL

## Local Development with Docker

For local testing before deploying to Coolify:

### Start the Application
```bash
# Build and start with docker-compose (connects to your external database)
docker-compose up --build

# Or build image manually and run (connects to your external database)
docker build -t mktplace .
docker run --env-file .env -p 8081:8081 mktplace
```

**Note**: The Docker build process compiles the application from source code each time. The application connects to your existing external PostgreSQL database using the connection details from `.env`.

### Access the Application
- Local: http://localhost:8081
- Coolify: Your Coolify domain

## Troubleshooting

### Common Issues

1. **Database Connection Failed**:
   - Check DATABASE_URL format: `jdbc:postgresql://host:port/database`
   - Verify database credentials
   - Ensure database is running and accessible

2. **Port Already in Use**:
   - Change PORT environment variable
   - Update EXPOSE in Dockerfile if needed

3. **Build Fails**:
   - Check Maven dependencies
   - Ensure Java 21 is available in Docker
   - Verify Dockerfile syntax

4. **Application Won't Start**:
   - Check application logs in Coolify
   - Verify all required environment variables are set
   - Check database connectivity

### Checking Logs

In Coolify dashboard:
1. Go to your project
2. Click on the deployment
3. View build logs and runtime logs

## Security Considerations

1. **Database Password**: Use a strong, unique password
2. **Environment Variables**: Never commit secrets to Git
3. **HTTPS**: Enable SSL/TLS in Coolify for production
4. **Firewall**: Configure Coolify security settings appropriately

## File Structure

After following this guide, your project should have:

```
MarketPlace_Demo/
├── Dockerfile                    # Docker build configuration
├── docker-compose.yml           # Local development setup
├── .dockerignore               # Files to exclude from Docker build
├── env.example                 # Environment variables template
├── pom.xml                     # Maven configuration
├── src/                        # Source code
├── COOLIFY_DEPLOYMENT.md       # This deployment guide
└── ...
```

## Need Help?

- Check Coolify documentation: https://coolify.io/docs
- Review Docker best practices: https://docs.docker.com/develop/dev-best-practices/
- Spring Boot deployment: https://docs.spring.io/spring-boot/docs/current/reference/html/deployment.html