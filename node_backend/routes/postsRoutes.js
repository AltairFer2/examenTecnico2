const express = require('express');
const router = express.Router();

const postController = require('../controllers/postController');
const authMiddleware = require('../middleware/authMiddleware');  // Asumiendo que deseas proteger estas rutas

router.get('/posts', authMiddleware, postController.getPosts);

router.get('/posts/:id', authMiddleware, postController.getPostById);

router.post('/posts', authMiddleware, postController.createPost);

router.put('/posts/:id', authMiddleware, postController.updatePost);

router.delete('/posts/:id', authMiddleware, postController.deletePost);

module.exports = router;
