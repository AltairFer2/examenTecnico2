const express = require('express');
const router = express.Router();
const fileController = require('../controllers/fileController');
const authMiddleware = require('../middleware/authMiddleware');

router.post('/upload', authMiddleware, fileController.uploadFile, fileController.saveFileRecord);
router.get('/', authMiddleware, fileController.getFiles);

module.exports = router;
