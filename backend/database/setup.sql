DROP TABLE IF EXISTS user_flashcards_review_history;
DROP TABLE IF EXISTS user_flashcards;
DROP TABLE IF EXISTS flashcards_review_history;
DROP TABLE IF EXISTS flashcards;
DROP TABLE IF EXISTS chat_messages;
DROP TABLE IF EXISTS chats;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS qualifications;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
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
    student_level INTEGER DEFAULT 1,
    student_home_language VARCHAR(255),
    student_rating INTEGER
);

CREATE TABLE teachers (
    teacher_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    teacher_name VARCHAR(255),
    teacher_profile_image TEXT,
    teacher_home_language VARCHAR(255),
    qualifications VARCHAR(255),
    teacher_biography TEXT,
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

CREATE TABLE flashcards_cloze (
    flashcard_id INTEGER REFERENCES flashcards(flashcard_id),
    title VARCHAR(70),
    content_with_cloze TEXT,
    PRIMARY KEY (flashcard_id, title)
);

CREATE TABLE flashcards_audio (
    flashcard_id INTEGER REFERENCES flashcards(flashcard_id),
    title VARCHAR(70),
    audio_url TEXT,
    PRIMARY KEY (flashcard_id, title)
);

CREATE TABLE flashcards_review_history (
    review_id SERIAL PRIMARY KEY,
    card_id INTEGER REFERENCES flashcards(flashcard_id),
    user_id INTEGER REFERENCES users(user_id),
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    review_result BOOLEAN,
    next_review_date TIMESTAMP,
    score INTEGER
);

CREATE TABLE user_flashcards (
    flashcard_id INTEGER REFERENCES flashcards(flashcard_id),
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
    review_result BOOLEAN,
    next_review_date TIMESTAMP,
    score INTEGER
);

CREATE TABLE user_flashcards_normal (
    flashcard_id INTEGER REFERENCES flashcards(flashcard_id),
    title VARCHAR(70),
    front TEXT,
    back TEXT,
    PRIMARY KEY (flashcard_id, title)
);

CREATE TABLE user_flashcards_cloze (
    flashcard_id INTEGER REFERENCES flashcards(flashcard_id),
    title VARCHAR(70),
    content_with_cloze TEXT,
    PRIMARY KEY (flashcard_id, title)
);

CREATE TABLE user_flashcards_audio (
    flashcard_id INTEGER REFERENCES flashcards(flashcard_id),
    title VARCHAR(70),
    audio_url TEXT,
    PRIMARY KEY (flashcard_id, title)
);




INSERT INTO users (username, password, email, role)
VALUES
    ('john_doe', 'password123', 'john@example.com', 'student'),
    ('jane_smith', 'testpass456', 'jane@example.com', 'student'),
    ('teacher_test', 'test', 'admin@example.com', 'teacher');


INSERT INTO students (student_name, student_home_language, student_rating)
VALUES
    ('Alice', 'English', 4),
    ('Bob', 'Spanish', 3),
    ('Eve', 'French', 5);


INSERT INTO teachers (teacher_name, teacher_home_language, teacher_rating, is_verified)
VALUES
    ('Michael', 'English', 4.5, true),
    ('Sophia', 'Spanish', 4.2, true),
    ('David', 'French', 4.8, false);


INSERT INTO ratings (reviewed_by_user_id, review_of_user_id, rating)
VALUES
    (1, 2, 4),
    (2, 1, 3),
    (3, 1, 5);


INSERT INTO chats (student_id, teacher_id, total_words)
VALUES
    (1, 1, 120),
    (2, 3, 85),
    (3, 2, 150);


INSERT INTO chat_messages (chat_id, sender_id, message, word_count)
VALUES
    (1, 1, 'Hi there!', 2),
    (1, 1, 'How are you?', 3),
    (2, 3, 'Hello!', 1);


INSERT INTO flashcards (type, level)
VALUES
    ('Normal', 1),
    ('Cloze', 2),
    ('Audio', 3);


INSERT INTO flashcards_normal (flashcard_id, title, front, back)
VALUES
    (1, 'English Greeting', 'Hello', 'Hi'),
    (2, 'Spanish Greeting', 'Hola', 'Hola'),
    (3, 'French Greeting', 'Bonjour', 'Bonjour');


INSERT INTO flashcards_cloze (flashcard_id, title, content_with_cloze)
VALUES
    (4, 'English Cloze', 'This is [blank] example.'),
    (5, 'Spanish Cloze', '¿[blank] está?'),
    (6, 'French Cloze', 'C\'est [blank].');

INSERT INTO flashcards_audio (flashcard_id, title, audio_url)
VALUES
    (7, 'English Audio', 'http://example.com/english.mp3'),
    (8, 'Spanish Audio', 'http://example.com/spanish.mp3'),
    (9, 'French Audio', 'http://example.com/french.mp3');

INSERT INTO flashcards_review_history (card_id, user_id, review_result, score, next_review_date)
VALUES
    (1, 1, true, 4, '2023-08-01 10:00:00'),
    (2, 2, true, 3, '2023-08-02 14:30:00'),
    (3, 3, true, 5, '2023-08-03 12:15:00');


INSERT INTO user_flashcards (flashcard_id, user_id, front, back)
VALUES
    (1, 1, 'Hello', 'Hi'),
    (2, 2, 'Hola', 'Hola'),
    (3, 3, 'Bonjour', 'Bonjour');


INSERT INTO user_flashcards_review_history (card_id, user_id, review_result, score, next_review_date)
VALUES
    (1, 1, true, 4, '2023-08-01 10:00:00'),
    (2, 2, true, 3, '2023-08-02 14:30:00'),
    (3, 3, true, 5, '2023-08-03 12:15:00');


INSERT INTO user_flashcards_normal (flashcard_id, title, front, back)
VALUES
    (4, 'English Cloze', 'This is [blank] example.', 'This is an example.'),
    (5, 'Spanish Cloze', '¿[blank] está?', '¿Cómo está?'),
    (6, 'French Cloze', 'C\'est [blank].', 'C\'est bon.');


INSERT INTO user_flashcards_cloze (flashcard_id, title, content_with_cloze)
VALUES
    (7, 'English Audio', 'This is [blank] audio.'),
    (8, 'Spanish Audio', '¿[blank] está?'),
    (9, 'French Audio', 'C\'est [blank].');


INSERT INTO user_flashcards_audio (flashcard_id, title, audio_url)
VALUES
    (7, 'English Audio', 'http://example.com/user_english.mp3'),
    (8, 'Spanish Audio', 'http://example.com/user_spanish.mp3'),
    (9, 'French Audio', 'http://example.com/user_french.mp3');
