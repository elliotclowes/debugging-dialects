DROP TABLE IF EXISTS flashcards_normal CASCADE;
DROP TABLE IF EXISTS user_flashcards_normal CASCADE;
DROP TABLE IF EXISTS user_flashcards_review_history CASCADE;
DROP TABLE IF EXISTS user_flashcards CASCADE;
DROP TABLE IF EXISTS flashcards_review_history CASCADE;
DROP TABLE IF EXISTS flashcards CASCADE;
DROP TABLE IF EXISTS chat_messages CASCADE;
DROP TABLE IF EXISTS chats CASCADE;
DROP TABLE IF EXISTS ratings CASCADE;
DROP TABLE IF EXISTS qualifications CASCADE;
DROP TABLE IF EXISTS teachers CASCADE;
DROP TABLE IF EXISTS students CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TYPE IF EXISTS review_result;

CREATE TABLE users (
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    token CHAR(36),
    email VARCHAR(255) UNIQUE NOT NULL,
    role VARCHAR(20) NOT NULL,
    joined_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE students (
    student_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    student_name VARCHAR(255),
    student_home_language VARCHAR(255) DEFAULT 'English',
    student_rating INTEGER,
    student_level INTEGER DEFAULT 1
);

CREATE TABLE teachers (
    teacher_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    teacher_name VARCHAR(255),
    teacher_profile_image TEXT DEFAULT 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
    teacher_biography TEXT,
    teacher_home_language VARCHAR(255),
    qualifications VARCHAR(255),
    teacher_rating INTEGER,
    earnings INTEGER,
    is_verified BOOLEAN DEFAULT false
);

CREATE TABLE ratings (
    rating_id SERIAL PRIMARY KEY,
    reviewed_by_user_id INTEGER REFERENCES users(user_id),
    review_of_user_id INTEGER REFERENCES users(user_id),
    rating INTEGER,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE chats (
    chat_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    teacher_id INTEGER REFERENCES teachers(teacher_id),
    started_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_words INTEGER
);

CREATE TABLE chat_messages (
    message_id SERIAL PRIMARY KEY,
    chat_id INTEGER REFERENCES chats(chat_id),
    sender_id INTEGER REFERENCES users(user_id),
    message TEXT,
    word_count INTEGER,
    send_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE flashcards (
    flashcard_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    level INTEGER,
    language VARCHAR(50) NOT NULL DEFAULT 'English'
);

CREATE TABLE flashcards_normal (
    flashcard_id INTEGER REFERENCES flashcards(flashcard_id),
    title VARCHAR(70),
    front TEXT,
    back TEXT,
    PRIMARY KEY (flashcard_id, title)
);

CREATE TYPE review_result AS ENUM ('Easy', 'Good', 'Hard', 'Wrong');

CREATE TABLE flashcards_review_history (
    review_id SERIAL PRIMARY KEY,
    card_id INTEGER REFERENCES flashcards(flashcard_id),
    user_id INTEGER REFERENCES users(user_id),
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    review_result review_result,
    next_review_date TIMESTAMP,
    ease_factor REAL DEFAULT 2.5,
    repetitions INTEGER DEFAULT 0
);

CREATE TABLE user_flashcards (
    flashcard_id INTEGER REFERENCES flashcards(flashcard_id) UNIQUE,
    user_id INTEGER REFERENCES users(user_id),
    front TEXT,
    back TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (flashcard_id, user_id)
);

CREATE TABLE user_flashcards_review_history (
    review_id SERIAL PRIMARY KEY,
    card_id INTEGER REFERENCES user_flashcards(flashcard_id),
    user_id INTEGER REFERENCES users(user_id),
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    review_result review_result,
    next_review_date TIMESTAMP,
    ease_factor REAL DEFAULT 2.5, 
    repetitions INTEGER DEFAULT 0
);

CREATE TABLE user_flashcards_normal (
    flashcard_id INTEGER REFERENCES flashcards(flashcard_id),
    title VARCHAR(70),
    front TEXT,
    back TEXT,
    PRIMARY KEY (flashcard_id, title)
);

INSERT INTO flashcards (type, level, language)
VALUES
    ('Normal', 1, 'English'),
    ('Normal', 2, 'Spanish'),
    ('Normal', 3, 'French'),
    ('Normal', 4, 'German'),
    ('Normal', 5, 'English'),
    ('Normal', 6, 'Spanish'),
    ('Normal', 7, 'French'),
    ('Normal', 8, 'German'),
    ('Normal', 9, 'English'),
    ('Normal', 10, 'Spanish'),
    ('Normal', 11, 'French'),
    ('Normal', 12, 'German'),
    ('Normal', 13, 'English'),
    ('Normal', 14, 'Spanish'),
    ('Normal', 15, 'French'),
    ('Normal', 16, 'German'),
    ('Normal', 17, 'English'),
    ('Normal', 18, 'Spanish'),
    ('Normal', 19, 'French'),
    ('Normal', 20, 'German'),
    ('Normal', 21, 'English'),
    ('Normal', 22, 'Spanish'),
    ('Normal', 23, 'French'),
    ('Normal', 24, 'German'),
    ('Normal', 25, 'English'),
    ('Normal', 26, 'Spanish'),
    ('Normal', 27, 'French'),
    ('Normal', 28, 'German'),
    ('Normal', 29, 'English'),
    ('Normal', 30, 'Spanish'),
    ('Normal', 31, 'French'),
    ('Normal', 32, 'German'),
    ('Normal', 33, 'English');

INSERT INTO flashcards_normal (flashcard_id, title, front, back)
VALUES
    (1, 'English Greeting', 'Hello', 'Hi'),
    (2, 'English Question', 'How are you?', 'I am fine, thank you.'),
    (3, 'English Farewell', 'Goodbye', 'See you later.'),
    (4, 'English Colors', 'Red', 'The color of blood.'),
    (5, 'English Numbers', 'One', 'The first number.'),
    (6, 'English Days', 'Monday', 'The first day of the week.'),
    (7, 'English Family', 'Mother', 'A female parent.'),
    (8, 'English Animals', 'Dog', 'A loyal pet.'),
    (9, 'English Food', 'Apple', 'A round fruit.'),
    (10, 'English Time', 'Clock', 'A device that tells time.'),
    (11, 'English Weather', 'Sunny', 'Bright and clear skies.'),
    (12, 'English Sports', 'Football', 'A popular team sport.'),
    (13, 'English Clothes', 'Shirt', 'An upper body garment.'),
    (14, 'English Body', 'Head', 'The upper part of the body.'),
    (15, 'English Transport', 'Car', 'A four-wheeled vehicle.'),
    (16, 'English Jobs', 'Doctor', 'A medical professional.'),
    (17, 'English School', 'Teacher', 'An educator.'),
    (18, 'English Nature', 'Tree', 'A tall plant with a trunk.'),
    (19, 'English Technology', 'Computer', 'An electronic device.'),
    (20, 'English Travel', 'Airport', 'A place for flights.'),
    (21, 'English Hobbies', 'Reading', 'An enjoyable activity.'),
    (22, 'English Music', 'Guitar', 'A musical instrument.'),
    (23, 'English Movies', 'Action', 'Exciting films.'),
    (24, 'English Art', 'Painting', 'A visual form of expression.'),
    (25, 'English Science', 'Chemistry', 'Study of matter and reactions.'),
    (26, 'English Space', 'Astronaut', 'A person who travels to space.'),
    (27, 'English History', 'Ancient Egypt', 'An ancient civilization.'),
    (28, 'English Geography', 'Mountain', 'A high landform.'),
    (29, 'English Culture', 'Tradition', 'Customs handed down.'),
    (30, 'English Literature', 'Novel', 'A fictional book.'),
    (31, 'English Grammar', 'Verb', 'An action word.'),
    (32, 'English Vocabulary', 'Synonym', 'A word with similar meaning.'),
    (33, 'English Phrases', 'Common Idioms', 'Expressions with figurative meanings.');

-- Insert dummy user data (you can add more users as needed)
INSERT INTO users (username, password, email, role)
VALUES
    ('john_doe', 'password123', 'john@example.com', 'student'),
    ('jane_smith', 'testpass456', 'jane@example.com', 'student'),
    ('teacher_test', 'test', 'admin@example.com', 'teacher');

-- Insert dummy student data (you can add more students as needed)
INSERT INTO students (student_name, student_rating)
VALUES
    ('Alice', 4),
    ('Bob', 3),
    ('Eve', 5);

-- Insert dummy teacher data (you can add more teachers as needed)
INSERT INTO teachers (teacher_name, teacher_profile_image, teacher_biography, teacher_rating, earnings, is_verified)
VALUES
    ('Michael', '', 'English teacher with experience in teaching conversational English.', 4.5, 1500, true),
    ('Sophia', '', 'Experienced English teacher offering tailored lessons.', 4.2, 1800, true),
    ('David', '', 'Passionate about teaching English to learners of all levels.', 4.8, 2000, false);

-- Insert dummy chat data (you can add more chats as needed)
INSERT INTO chats (student_id, teacher_id, total_words)
VALUES
    (1, 1, 120),
    (2, 3, 85),
    (3, 2, 150);

-- Insert dummy chat messages data (you can add more messages as needed)
INSERT INTO chat_messages (chat_id, sender_id, message, word_count)
VALUES
    (1, 1, 'Hi there!', 2),
    (1, 1, 'How are you?', 3),
    (2, 3, 'Hello!', 1);

INSERT INTO flashcards_review_history (card_id, user_id, review_result, next_review_date, ease_factor, repetitions)
VALUES
    (1, 1, 'Easy', '2023-08-01 12:00:00', 2.5, 1),
    (2, 1, 'Hard', '2023-08-02 12:00:00', 2.3, 2);

INSERT INTO user_flashcards (flashcard_id, user_id, front, back)
VALUES
    (1, 1, 'Hello', 'Hi'),
    (2, 1, 'How are you?', 'I am fine, thank you.'),
    (3, 2, 'Goodbye', 'See you later.');

INSERT INTO user_flashcards_review_history (card_id, user_id, review_result, next_review_date, ease_factor, repetitions)
VALUES
    (1, 1, 'Easy', '2023-08-01 12:00:00', 2.5, 1),
    (2, 1, 'Hard', '2023-08-02 12:00:00', 2.3, 2),
    (3, 2, 'Good', '2023-08-03 12:00:00', 2.7, 3);
