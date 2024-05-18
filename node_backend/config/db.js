const mongoose = require('mongoose');
require('dotenv').config();

const dbURI = process.env.MONGODB_URI;

const connectDB = async () => {
    try {
        await mongoose.connect(dbURI, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
            useCreateIndex: true,
            useFindAndModify: false
        });
        console.log('MongoDB conectado con éxito');
    } catch (err) {
        console.error('Error al conectar con BD, código:', err.message);
        process.exit(1);
    }
};

module.exports = connectDB;
