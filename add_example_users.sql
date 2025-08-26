-- Add Example Users to Steel Backend Database
-- All passwords are: Password123! (BCrypt hashed)

-- 1. Executive Team
INSERT INTO users (username, password) VALUES ('sarah.johnson', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'sarah.johnson'), 'ADMIN');

-- 2. Sales Team
INSERT INTO users (username, password) VALUES ('mike.chen', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'mike.chen'), 'MANAGER');

INSERT INTO users (username, password) VALUES ('emily.rodriguez', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'emily.rodriguez'), 'STAFF');

-- 3. Inventory Team
INSERT INTO users (username, password) VALUES ('david.kumar', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'david.kumar'), 'MANAGER');

INSERT INTO users (username, password) VALUES ('lisa.thompson', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'lisa.thompson'), 'STAFF');

-- 4. Supplier Relations
INSERT INTO users (username, password) VALUES ('robert.wilson', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'robert.wilson'), 'MANAGER');

-- 5. Finance Team
INSERT INTO users (username, password) VALUES ('jennifer.lee', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'jennifer.lee'), 'ADMIN');

-- 6. Operations Team
INSERT INTO users (username, password) VALUES ('carlos.martinez', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'carlos.martinez'), 'STAFF');

INSERT INTO users (username, password) VALUES ('amanda.foster', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'amanda.foster'), 'STAFF');
