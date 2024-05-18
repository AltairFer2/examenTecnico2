const express = require('express');
const router = express.Router();
const { check } = require('express-validator');

const userController = require('../controllers/userController');
const authMiddleware = require('../middleware/authMiddleware');

router.post(
    '/register',
    [
        check('name', 'El nombre es requerido').not().isEmpty(),
        check('email', 'Por favor, incluye un email válido').isEmail(),
        check('password', 'Por favor ingresa una contraseña de al menos 8 carácteres').isLength({ min: 8 })
    ],
    userController.register
);

router.post(
    '/login',
    [
        check('email', 'Por favor, incluye un email válido').isEmail(),
        check('password', 'Por favor ingrese una contraseña').exists()
    ],
    userController.login
);

router.get('/profile', authMiddleware, userController.getUserProfile);

router.put('/:id', authMiddleware, userController.updateUserProfile);

router.delete('/:id', authMiddleware, userController.deleteUser);

router.get('/', authMiddleware, userController.getUsers);


module.exports = router;
