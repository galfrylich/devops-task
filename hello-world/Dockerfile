FROM python:3.9-alpine

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the working directory in the container
WORKDIR /app

# Copy the application code to the container
COPY app.py /app

# Install Flask (and other dependencies if needed)
RUN pip install --no-cache-dir flask

# Change ownership of the application files to the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose the port your Flask app will run on
EXPOSE 5000

# Set the command to run the application
CMD ["python", "app.py"]
