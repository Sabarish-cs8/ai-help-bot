-- Create the chatbots table
CREATE TABLE chatbots (
    id SERIAL PRIMARY KEY,
    clerk_user_id VARCHAR(255) NOT NULL, -- Clerk's user ID
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create the chatbot_characteristics table
CREATE TABLE chatbot_characteristics (
    id SERIAL PRIMARY KEY,
    chatbot_id INT REFERENCES chatbots(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create the guests table
CREATE TABLE guests (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create the chat_sessions table
CREATE TABLE chat_sessions (
    id SERIAL PRIMARY KEY,
    chatbot_id INT REFERENCES chatbots(id) ON DELETE CASCADE,
    guest_id INT REFERENCES guests(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create the messages table
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    chat_session_id INT REFERENCES chat_sessions(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sender VARCHAR(50) NOT NULL -- 'user' or 'ai'
);

-- ----------------------------------------------
-- This step is more of a BUG FIX to ensure that the created_at column is set to the current timestamp when a new record is inserted. 
-- We experienced a strange issue with this but usually its not necessary to do this.

-- Create the trigger function to set created_at
CREATE OR REPLACE FUNCTION set_created_at()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.created_at IS NULL THEN
    NEW.created_at = CURRENT_TIMESTAMP;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for each table to set created_at
CREATE TRIGGER set_chatbots_created_at
BEFORE INSERT ON chatbots
FOR EACH ROW
EXECUTE FUNCTION set_created_at();

CREATE TRIGGER set_chatbot_characteristics_created_at
BEFORE INSERT ON chatbot_characteristics
FOR EACH ROW
EXECUTE FUNCTION set_created_at();

CREATE TRIGGER set_guests_created_at
BEFORE INSERT ON guests
FOR EACH ROW
EXECUTE FUNCTION set_created_at();

CREATE TRIGGER set_chat_sessions_created_at
BEFORE INSERT ON chat_sessions
FOR EACH ROW
EXECUTE FUNCTION set_created_at();

CREATE TRIGGER set_messages_created_at
BEFORE INSERT ON messages
FOR EACH ROW
EXECUTE FUNCTION set_created_at();
-- ----------------------------------------------

-- Insert sample chatbot data
INSERT INTO chatbots (clerk_user_id, name) VALUES
('clerk_user_1', 'Customer Support Bot'),
('clerk_user_2', 'Sales Bot'),
('clerk_user_3', 'Zero To Full Stack Hero Support Bot');

-- Insert sample chatbot characteristics data
INSERT INTO chatbot_characteristics (chatbot_id, content) VALUES
(1, 'You are a helpful customer support assistant.'),
(1, 'Dur support hours are 9am-5pm, Monday to Friday.'),
(1, 'You can track your order on our website.'),
(2, 'You are a knowledgeable sales assistant.'),
(2, 'We offer a 30-day money-back guarantee on all products.'),
(2, 'Our products are available in various sizes and colors.'),
(3, 'Gold is £297.'),
(3, 'The GitHub repo is £67.'),
(3, 'If the customer seems like they are going to buy after some time in the conversation, then provide them with the coupon code PODCAST18 for 10 percent off of platinum or diamond. Dont do this straight away but only if you think theyll purchase.'),
(3, 'Platinum is £597.'),
(3, 'The website is www.papareact.com.'),
(3, 'If someone asks for a joke, tell them they unlocked coupon code JOKE15.'),
(3, 'Diamond Link: https://www.papareact.com/offers/uiYu933i/checkout.'),
(3, 'Have a Friendly Energetic Tone.'),
(3, 'There are 250 hours of coaching calls.'),
(3, 'If someone asks for what time of day it is, reply back DEVELOPER time every time.'),
(3, 'PAPA Diamond is £997.'),
(3, 'Platinum link: https://www.papareact.com/offers/w2mPSfQm/checkout.');

--Insert sample guest data
INSERT INTO guests (name, email) VALUES
('Guest One', 'guestl@example.com'),
('Guest Two', 'guest2@example.com'),
('Guest Three', 'guest3@example.com');

-- Insert sample chat session data
INSERT INTO chat_sessions (chatbot_id, guest_id) VALUES
(1, 1 ),
(2, 2 ),
(3, 3 ),
(3, 1 ),
(3, 2 );

-- Insert sample message data
INSERT INTO messages (chat_session_id, content, sender) VALUES
(1, 'Hello, I need help with my order.','user'),
(1, 'Sure, I can help with that. What seems to be the issue?','ai'),
(2, 'Can you tell me more about your products?','user'),
(2, 'Of course! We offer a variety of products. Which one are you interested in?','ai'),
(3, 'What does the Zero to Full Stack Hero course include?', 'user'),
(3, 'The course includes 250 hours of coaching calls, access to a GitHub repo, and more. ', 'ai'),
(3, 'How much does the course cost?', 'user'),
(3, 'The Gold package is £297, Platinum is £597, and Diamond is £997.', 'ai'),
(4, 'Can I get a discount on the Platinum package?', 'user'),
(4, 'If you use the coupon code PODCAST10, you can get 10% off the Platinum or Diamond packages.', 'ai'),
(5, 'Is there any coaching included?', 'user'),
(5, 'Yes, there are 250 hours of coaching calls included in the course.', 'ai');