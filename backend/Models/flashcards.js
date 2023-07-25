const db = require('../database/db');
const sm2 = require('../utils/sm2');

const Flashcard = {
  // Get a flashcard by its ID
  getById: async (id) => {
    try {
      const flashcard = await db.query('SELECT * FROM flashcards WHERE flashcard_id = $1', [id]);

      if (flashcard.rows.length > 0) {
        return flashcard.rows[0];
      } else {
        return { error: "Flashcard not found" };
      }
    } catch (err) {
      console.error(err);
      return { error: err.message };
    }
  },

  // Get all due flashcards for a user by user's ID
  getDueFlashcards: async (userId, level) => {
    try {
      const result = await db.query(`
        SELECT 
          flashcards.*,
          flashcards_normal.*,
          flashcards_review_history.next_review_date
        FROM flashcards 
        LEFT JOIN flashcards_normal ON flashcards.flashcard_id = flashcards_normal.flashcard_id
        LEFT JOIN flashcards_review_history ON flashcards.flashcard_id = flashcards_review_history.card_id
        WHERE flashcards.level = $1
          AND (flashcards_review_history.user_id = $2 
               OR flashcards_review_history.user_id IS NULL)
        ORDER BY flashcards_review_history.next_review_date DESC
      `, [level, userId]);
      
      return result.rows;
    } catch (err) {
      console.error(err);
      return { error: err.message };
    }
  },

  // Get a flashcard's review by card ID and user ID
  getReview: async (card_id, user_id) => {
    try {
      const review = await db.query('SELECT * FROM flashcards_review_history WHERE card_id = $1 AND user_id = $2', [card_id, user_id]);

      if (review.rows.length > 0) {
        return review.rows[0];
      } else {
        return { error: "Flashcard review not found" };
      }
    } catch (err) {
      console.error(err);
      return { error: err.message };
    }
  },

  // Update a flashcard's review by card ID, user ID, and review data
  updateReview: async (card_id, user_id, review) => {
    try {
      const result = await db.query(
        'UPDATE flashcards_review_history SET next_review_date = $1, ease_factor = $2, repetitions = $3 WHERE card_id = $4 AND user_id = $5 RETURNING *', 
        [review.nextReviewDate, review.newEaseFactor, review.repetition, card_id, user_id]
      );

      return result.rows[0];
    } catch (err) {
      console.error(err);
      return { error: err.message };
    }
  },
};

module.exports = Flashcard;
