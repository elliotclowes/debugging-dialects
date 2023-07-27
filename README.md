# debugging-dialects

- ## Pages
    - Homepage.
    - Register page.
        - Chose teacher/student signup option.
            - Teacher register page.
                - Ask them their profile picture, qualifications, biography.
            - Student register page.
    - Student Dashboard.
    - They can click ‘start chatting’ and their automatically paired. If they have a favourite they’re paired with them.
        - Shows currently online teachers.
            - If there’s a teacher who they’ve previously chatted with who’s online then they’re at the top.
            - Button to see teacher profile.
            - When teacher is selected it goes to chat page.
        - Flashcard links:
            - ‘Learn websites flashcards’
            - ‘Learn my flashcards’
    - Teacher dashboard
        - NOTE: we need to notify teacher of new chat.
        - If first time teacher we say: “We’re currently pairing you with a student. Stand by.”
        - Current earnings.
        - Previous chats.
        - Update profile.
    - Chat page.
    - Login
    - Register
    - Chat history page
        - a page for each chat
    - Flashcards
        - Auto-generated flashcard page.
        - Student created flashcard page.
        - Student flashcard creation page
    - Teacher account page
    - Student account page
- ## Technology
    - **Front-end**
        - HTML, CSS, Javascript.
        - React.
        - Vite.
    - **Back-end**
        - PostgreSQL
        - Express.js
        - Node.js
        - http://Socket.IO
        - Passport.js?
        - bcrypt
- ## Overview
    - **Chat**: Two people chat in English.
        - There are two types of users:
            - Teachers
                - Teachers are paid per word/sentence.
            - Students
                - Students pay £5/mo.
    - **Flashcards**: Student is shown flashcards for learning language.
- ## MVP
    - **Chat**
        - Teacher and student can chat in real time.
        - How many words/sentences the student writes is stored so teacher can be paid.
        - Student can get translations of words inside the chat.
    - **Flashcards**
        - Three types of cards:
            - Front/back.
            - Cloze.
            - Audio.
        - Student gets points for answering flashcards.
        - Cards have levels of 1-50 based on difficulty.
        - Student is shown flashcards based on their current level.
        - When the user answers all the flashcards for a particular level they level up and are only shown the new level (i.e. after answering all the flashcards for level 1 they go to level 2 and are only shown flashcards for level 2 from then on).
        - They mark them as 'Easy', 'Medium' or 'Hard'. The flashcard is shown to them again based on their answer (if 'easy' it's not shown for a while, if 'hard' it's shown again soon).
        - Student can create their own flashcards.
            - This is a separate page and a separate table.
        - Student can delete their own flashcards.
- ## Nice to have
    - **Chat**
        - User can get a definition of a word.
            - [Free Dictionary API](https://dictionaryapi.dev/)
            - [WordsAPI](https://www.wordsapi.com/)
        - Student can rate teacher.
        - Teacher can rate student.
        - Student can schedule a chat with a teacher.
        - Student can get the English translated back into their home language.
        - Student is asked to speak a paragraph in English. The teacher then grades them out 1-10.
        - Student can speak in their mother tongue and get it translated into English.
        - What the teacher writes can be translated into the student mother tongue and played to them as audio.
        - Teacher can talk to more than one student at once.
        - Teacher/student is given ideas on what they can talk about.
    - **Flashcards**
        - Levels: when student answers a certain amount of points they 'level up'.
        - Flashcards can be generated by AI.
        - Teacher can create and assign flashcards for their students.
        - After a user answers a flashcard and the answer is shown it is played back to them.
        - User leaderboard based on who's answered the most flashcards for the week.
        - Tables
- ## Tables
    - **student**
        - student_id
        - username
        - password
        - email
        - student_name
        - student_level
        - student_rating
        - joined_date
    - **teacher**
        - teacher_id
        - username
        - password
        - email
        - is_verified
        - teacher_name
        - teacher_profile_image
        - teacher_home_language
        - teacher_qualifications
        - teacher_biography
        - teacher_rating
        - joined_date
    - **ratings**
        - rating_id
        - reviewed_by_user_id
        - review_of_user_id
        - rating
        - date
    - **chats**
        - chat_id
        - student_id
        - teacher_id
        - started_on
    - **chat_messages**
        - message_id
        - chat_id
        - sender_id
        - message
        - word_count
        - send_at
    - **flashcards**
        - flashcard_id
        - type
            - normal
            - cloze
            - audio
        - level
    - **flashcards_review_history**
        - review_id
        - card_id
        - user_id
        - review_date
        - review_result
    - **user_flashcards**
        - flashcard_id
        - user_id
        - front
        - back
        - created_at
    - **user_flashcards_review_history**
        - review_id
        - card_id
        - user_id
        - review_date
        - review_result
