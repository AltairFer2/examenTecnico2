const express = require('express');
const router = express.Router();
const { check } = require('express-validator');

const employeeController = require('../controllers/employeeController');
const authMiddleware = require('../middleware/authMiddleware');

// Ruta para crear un nuevo empleado
router.post(
    '/',
    [
        authMiddleware,
        check('nombre', 'El nombre es obligatorio').not().isEmpty(),
        check('correo', 'Incluye un correo válido').isEmail(),
        check('rfc', 'El RFC debe tener 13 caracteres').isLength({ min: 13, max: 13 })
    ],
    employeeController.createEmployee
);

router.get('/', authMiddleware, employeeController.getAllEmployees);

router.get('/:id', authMiddleware, employeeController.getEmployeeById);

router.put(
    '/:id',
    [
        authMiddleware,
        check('nombre', 'El nombre es obligatorio').not().isEmpty(),
        check('correo', 'Incluye un correo válido').isEmail()
    ],
    employeeController.updateEmployee
);

router.delete('/:id', authMiddleware, employeeController.deleteEmployee);

module.exports = router;
