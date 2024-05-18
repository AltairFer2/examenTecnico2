const Employee = require('../models/Employee');

exports.createEmployee = async (req, res) => {
    const { nombre, correo, rfc, domicilioFiscal, curp, numeroSeguridadSocial, fechaInicioLaboral, tipoContrato, departamento, puesto, salarioDiario, salario, claveEntidad, estado } = req.body;
    try {
        const newEmployee = new Employee({
            nombre,
            correo,
            rfc,
            domicilioFiscal,
            curp,
            numeroSeguridadSocial,
            fechaInicioLaboral,
            tipoContrato,
            departamento,
            puesto,
            salarioDiario,
            salario,
            claveEntidad,
            estado
        });
        await newEmployee.save();
        res.json(newEmployee);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

exports.getAllEmployees = async (req, res) => {
    try {
        const employees = await Employee.find();
        res.json(employees);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

exports.getEmployeeById = async (req, res) => {
    try {
        const employee = await Employee.findById(req.params.id);
        if (!employee) return res.status(404).json({ msg: 'Empleado no encontrado' });
        res.json(employee);
    } catch (err) {
        console.error(err.message);
        if (err.kind === 'ObjectId') {
            return res.status(404).json({ msg: 'Empleado no encontrado' });
        }
        res.status(500).send('Error de Server');
    }
};

exports.updateEmployee = async (req, res) => {
    const { nombre, correo, rfc, domicilioFiscal, curp, numeroSeguridadSocial, fechaInicioLaboral, tipoContrato, departamento, puesto, salarioDiario, salario, claveEntidad, estado } = req.body;
    try {
        const employee = await Employee.findById(req.params.id);
        if (!employee) return res.status(404).json({ msg: 'Empleado no encontrado' });

        const updateFields = { nombre, correo, rfc, domicilioFiscal, curp, numeroSeguridadSocial, fechaInicioLaboral, tipoContrato, departamento, puesto, salarioDiario, salario, claveEntidad, estado };
        const updatedEmployee = await Employee.findByIdAndUpdate(req.params.id, { $set: updateFields }, { new: true });

        res.json(updatedEmployee);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

exports.deleteEmployee = async (req, res) => {
    try {
        const employee = await Employee.findById(req.params.id);
        if (!employee) return res.status(404).json({ msg: 'Empleado no encontrado' });

        await employee.remove();
        res.json({ msg: 'Empleado eliminado' });
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};
