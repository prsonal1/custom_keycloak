FROM quay.io/keycloak/keycloak:21.1.2

# Set environment variables for admin user
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin123

# Copy custom theme to Keycloak themes directory
COPY my-theme/ /opt/keycloak/themes/my-theme/

# Create directory for custom images (mounted as volume)
RUN mkdir -p /opt/keycloak/themes/my-theme/login/resources/img

# Set proper permissions
RUN chown -R keycloak:keycloak /opt/keycloak/themes/my-theme/

# Expose port
EXPOSE 8080

# Start Keycloak in development mode
CMD ["start-dev"]