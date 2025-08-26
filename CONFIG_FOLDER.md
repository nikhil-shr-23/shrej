# Config Folder Documentation (src/main/java/com/steel/backend/config)

This folder contains application configuration and bootstrapping utilities.

## Files Overview

### 1) OpenApiConfig.java
- **Purpose**: Configures Swagger/OpenAPI for API documentation and interactive testing.
- **Key Elements**:
  - Defines OpenAPI metadata (title, description, version) and UI settings.
  - Enables Swagger UI at `/swagger-ui/index.html` and OpenAPI JSON at `/v3/api-docs`.
  - May configure groupings, packages to scan, and custom schemas if needed.
- **Why it exists**: Provides a standardized, always-up-to-date contract for the REST API and makes it easy to explore/test endpoints.
- **Interactions**:
  - Used by springdoc-openapi to auto-generate documentation from controller annotations.
  - Whitelisted by security config so docs are publicly accessible.

### 2) DataSeeder.java
- **Purpose**: Seeds initial data for development/demo environments.
- **Key Elements**:
  - Inserts baseline entities (e.g., default users with roles; optional sample products/clients/suppliers).
  - Uses repositories (UserRepository, ProductRepository, etc.) to persist data.
  - Encodes passwords via `BCryptPasswordEncoder` before saving.
- **Why it exists**: Ensures the application is usable on first run (login possible; example data available).
- **Interactions**:
  - Depends on repositories from `repository/` and entities from `model/`.
  - Works with `security/` for password hashing and roles.

## Design Notes
- Configuration classes are small, single-responsibility components discovered by Spring via classpath scanning.
- Keep environment-specific behavior behind profiles (e.g., only seed in `dev`).
- Expose only what’s necessary (e.g., do not leak secrets in OpenAPI descriptions).
