# Security Folder Documentation (src/main/java/com/steel/backend/security)

This folder contains the full security stack: configuration, JWT support, and Spring Security integration.

## Files Overview

### 1) SecurityConfig.java
- **Purpose**: Central security configuration for HTTP requests and authentication.
- **Key Configurations**:
  - `@EnableMethodSecurity` enables `@PreAuthorize` annotations.
  - Stateless sessions via `SessionCreationPolicy.STATELESS`.
  - CSRF disabled (safe for stateless APIs).
  - Whitelists Swagger endpoints and `POST /api/auth/**` for login.
  - All other endpoints require authentication.
  - Registers `JwtAuthenticationFilter` before `UsernamePasswordAuthenticationFilter`.
  - Declares `PasswordEncoder` (BCrypt) and `DaoAuthenticationProvider` beans.
- **Flow**: Incoming request → security filter chain → JWT filter → controller.

### 2) JwtAuthenticationFilter.java
- **Purpose**: Extracts and validates JWTs from the `Authorization` header.
- **Flow**:
  1. Read `Authorization` header and check `Bearer <token>` prefix.
  2. Use `JwtService` to extract username from token.
  3. Load `UserDetails` via `UserDetailsService`.
  4. Validate token (`JwtService.isTokenValid`).
  5. Populate `SecurityContext` with authenticated user and authorities.
  6. Pass control to next filter.
- **Why OncePerRequestFilter**: Ensures each request is processed exactly once in the chain.

### 3) JwtService.java
- **Purpose**: Encapsulates token generation and validation logic.
- **Key Methods**:
  - `generateToken(username, extraClaims)` — Issues HS256-signed tokens with expiration.
  - `extractUsername(token)` / `extractClaim(token)` — Parses and reads claims.
  - `isTokenValid(token, username)` — Confirms subject + expiry.
- **Configuration**:
  - Reads `app.jwt.secret` and `app.jwt.expiration-ms` from `application.yml`.
  - Uses JJWT, with Base64-decoded secret and HMAC-SHA256 signing.

### 4) UserDetailsServiceImpl.java
- **Purpose**: Bridges application users to Spring Security's `UserDetails`.
- **Behavior**:
  - Loads `User` by username via `UserRepository`.
  - Wraps into `UserDetailsImpl` for authorities mapping.

### 5) UserDetailsImpl.java
- **Purpose**: Adapts the domain `User` to Spring's `UserDetails`.
- **Authorities Mapping**:
  - Converts `Set<RoleType>` into `ROLE_<NAME>` authorities.
  - Supports `ADMIN`, `MANAGER`, `STAFF` roles.
- **Account Flags**: All set to `true` (non-expired, non-locked, etc.).

## Request Authentication Flow
```
Client → Authorization: Bearer <JWT> → JwtAuthenticationFilter →
UserDetailsService → SecurityContext → Controller
```

## Notes
- Ensure the JWT secret is a strong Base64 string.
- Token expiry is enforced; clients should refresh tokens appropriately.
- Keep Swagger whitelisted for easier debugging and demos.



