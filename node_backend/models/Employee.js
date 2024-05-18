const mongoose = require('mongoose');

const employeeSchema = new mongoose.Schema({
    nombre: { type: String, required: true },
    correo: { type: String, required: true },
    rfc: { type: String, required: true, unique: true },
    domicilioFiscal: { type: String, required: true },
    curp: { type: String, required: true, unique: true },
    numeroSeguridadSocial: { type: String, required: true },
    fechaInicioLaboral: { type: Date, required: true },
    tipoContrato: { type: String, required: true },
    departamento: { type: String, required: true },
    puesto: { type: String, required: true },
    salarioDiario: { type: Number, required: true },
    salario: { type: Number, required: true },
    claveEntidad: { type: String, required: true },
    estado: {
        type: String,
        enum: ['Aguascalientes', 'Baja California', 'Baja California Sur', 'Campeche', 'Chiapas', 'Chihuahua', 'Ciudad de México', 'Coahuila', 'Colima', 'Durango', 'Estado de México', 'Guanajuato', 'Guerrero', 'Hidalgo', 'Jalisco', 'Michoacán', 'Morelos', 'Nayarit', 'Nuevo León', 'Oaxaca', 'Puebla', 'Querétaro', 'Quintana Roo', 'San Luis Potosí', 'Sinaloa', 'Sonora', 'Tabasco', 'Tamaulipas', 'Tlaxcala', 'Veracruz', 'Yucatán', 'Zacatecas'],
        required: true
    }
}, { timestamps: true });

module.exports = mongoose.model('Employee', employeeSchema);
