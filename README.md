# Keycloak Neumorphic Theme Setup with Docker

This repository contains a complete setup for Keycloak with a beautiful neumorphic (soft UI) login theme that provides a modern, elegant interface with soft shadows and depth effects.

## 📁 Project Structure

```
/workspace/
├── Dockerfile                    # Custom Keycloak image with theme
├── docker-compose.yml           # Docker Compose configuration
├── my-theme/                    # Custom Keycloak theme
│   ├── theme.properties         # Theme configuration
│   └── login/
│       ├── templates/
│       │   └── login.ftl        # Custom login template
│       └── resources/
│           ├── css/
│           │   └── styles.css   # Custom styles
│           └── img/
│               ├── custom-image.png    # Your custom image (replace this)
│               └── logo-placeholder.svg # Placeholder image
└── README.md                    # This file
```

## 🚀 Quick Start

### 1. Build the Docker Image

```bash
# Build the custom Keycloak image
docker build -t keycloak-custom .
```

### 2. Run with Docker Compose

```bash
# Start Keycloak with the custom theme
docker-compose up -d

# View logs
docker-compose logs -f keycloak
```

### 3. Access Keycloak

- **Admin Console**: http://localhost:8080/admin
- **Username**: `admin`
- **Password**: `admin123`

## 🎨 Theme Features

### Neumorphic Design Elements

- **Soft Shadows**: Beautiful inset and outset shadow effects
- **Dark Color Scheme**: Professional dark theme with cyan accents
- **Animated Toggle**: Smooth "Remember Me" toggle animation
- **Rounded Corners**: Modern 32px border radius for inputs and buttons
- **Gradient Effects**: Subtle gradients for depth and dimension

### Customization Options

1. **Color Variables**: Modify CSS custom properties in `styles.css`:
   ```css
   :root {
     --textColor: #f6f5f7;      /* Main text color */
     --textOffColor: #7c858d;   /* Secondary text */
     --baseColor: #23333f;      /* Background color */
     --secColor: #11f7e2;       /* Accent color (cyan) */
   }
   ```

2. **Shadow Intensity**: Adjust shadow values for different depth effects
3. **Border Radius**: Modify border-radius values for different corner styles

### Supported Image Formats

- PNG (recommended for logos with transparency)
- JPG/JPEG (good for photos)
- SVG (scalable vector graphics)
- WebP (modern format with good compression)

### Image Recommendations

- **Logo**: 200x100px or similar aspect ratio
- **Background**: 1920x1080px or larger
- **File size**: Keep under 500KB for best performance

## 🔧 Enabling the Theme in Keycloak

### 1. Access Admin Console

1. Go to http://localhost:8080/admin
2. Login with admin credentials
3. Select your realm (or create a new one)

### 2. Configure Theme

1. Go to **Realm Settings** → **Themes**
2. Set **Login Theme** to `my-theme`
3. Click **Save**

### 3. Test the Theme

1. Go to **Clients** → **account-console**
2. Click **Open Endpoints** → **Account Console**
3. You should see your custom theme with the uploaded image

## 🛠️ Development Tips

### Hot Reloading (Development)

For development, you can mount the entire theme directory:

```yaml
# In docker-compose.yml
volumes:
  - ./my-theme:/opt/keycloak/themes/my-theme
```

This allows you to modify theme files without rebuilding the image.

### Caching Issues

If you don't see changes immediately:

1. **Clear browser cache** (Ctrl+F5 or Cmd+Shift+R)
2. **Check browser developer tools** for 404 errors
3. **Restart the container**:
   ```bash
   docker-compose restart keycloak
   ```

### File Permissions

If you encounter permission issues:

```bash
# Fix permissions for the theme directory
sudo chown -R 1000:1000 my-theme/
```

## 📝 Customization Options

### Modifying the Login Template

Edit `my-theme/login/templates/login.ftl` to:
- Change the layout
- Add new form fields
- Modify the image display logic
- Add custom HTML elements

### Styling Changes

Edit `my-theme/login/resources/css/styles.css` to:
- Change colors and fonts
- Modify layout and spacing
- Add animations
- Implement responsive design

### Theme Configuration

Edit `my-theme/theme.properties` to:
- Change theme metadata
- Add supported locales
- Configure theme inheritance

## 🔍 Troubleshooting

### Common Issues

1. **Image not displaying**:
   - Check file path in `login.ftl`
   - Verify image exists in `img/` directory
   - Check browser console for 404 errors

2. **Theme not applying**:
   - Verify theme is enabled in realm settings
   - Check theme name matches exactly
   - Restart Keycloak container

3. **Styling issues**:
   - Clear browser cache
   - Check CSS syntax
   - Verify file permissions

4. **Docker build fails**:
   - Check Dockerfile syntax
   - Verify all theme files exist
   - Check file permissions

### Debug Mode

Enable debug logging in Keycloak:

```bash
# Add to docker-compose.yml environment
- KC_LOG_LEVEL=DEBUG
```

### Useful Commands

```bash
# View container logs
docker-compose logs -f keycloak

# Access container shell
docker-compose exec keycloak /bin/bash

# Rebuild and restart
docker-compose down
docker-compose build --no-cache
docker-compose up -d

# Clean up
docker-compose down -v
docker system prune -a
```

## 🔒 Security Considerations

1. **Change default admin credentials** in production
2. **Use environment variables** for sensitive data
3. **Enable HTTPS** in production
4. **Regular security updates** of the base Keycloak image

## 📚 Additional Resources

- [Keycloak Documentation](https://www.keycloak.org/documentation)
- [Keycloak Theme Development](https://www.keycloak.org/docs/latest/server_development/#_themes)
- [FreeMarker Template Language](https://freemarker.apache.org/docs/)

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This project is open source and available under the [MIT License](LICENSE).