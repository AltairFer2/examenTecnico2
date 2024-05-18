const express = require('express');
const router = express.Router();
const { check } = require('express-validator');

const authController = require('../controllers/authController');

router.post(
    '/register',
    [
        check('name', 'El Nombre es necesario').not().isEmpty(),
        check('email', 'Por favor, incluye un email válido').isEmail(),
        check('rfc', 'El RFC requiere 13 carácteres').isLength({ min: 13, max: 13 }),
        check('password', 'Por favor ingresa una contraseña de al menos 8 carácteres').isLength({ min: 8 })
    ],
    authController.register
);

router.post(
    '/login',
    [
        check('email', 'Por favor, incluye un email válido').isEmail(),
        check('password', 'Por favor ingrese una contraseña').exists()
    ],
    authController.login
);

module.exports = router;
