const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
    const token = req.header('Authorization') ? req.header('Authorization').split(' ')[1] : null;

    if (!token) {
        return res.status(401).json({ msg: 'No hay token, autorización denegada' });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded.user;
        next();
    } catch (err) {
        console.error('Error al verificar el token:', err.message);
        res.status(401).json({ msg: 'El token no es válido', error: err.message });
    }
};

module.exports = authMiddleware;
