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
    student_home_language VARCHAR(255),
    student_rating INTEGER,
    student_level INTEGER DEFAULT 1
);

CREATE TABLE teachers (
    teacher_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    teacher_name VARCHAR(255),
    teacher_profile_image TEXT,
    teacher_biography TEXT,
    teacher_home_language VARCHAR(255),
    qualifications VARCHAR(255),
    teacher_rating INTEGER,
    earnings INTEGER,
    is_verified BOOLEAN
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
    level INTEGER
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

-- Insert English flashcards data
INSERT INTO flashcards (type, level)
VALUES
    ('Normal', 1),
    ('Normal', 2),
    ('Normal', 3);

INSERT INTO flashcards_normal (flashcard_id, title, front, back)
VALUES
    (1, 'English Greeting', 'Hello', 'Hi'),
    (2, 'English Question', 'How are you?', 'I am fine, thank you.'),
    (3, 'English Farewell', 'Goodbye', 'See you later.');

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
