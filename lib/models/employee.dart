class Employee {
  String id;
  String nombre;
  String correo;
  String rfc;
  String domicilioFiscal;
  String curp;
  int numeroSeguridadSocial; // Cambiado a int
  String fechaInicioLaboral;
  String tipoContrato;
  String departamento;
  String puesto;
  int salarioDiario;
  int salario;
  int claveEntidad; // Cambiado a int
  String estado;

  Employee({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.rfc,
    required this.domicilioFiscal,
    required this.curp,
    required this.numeroSeguridadSocial, // Cambiado a int
    required this.fechaInicioLaboral,
    required this.tipoContrato,
    required this.departamento,
    required this.puesto,
    required this.salarioDiario,
    required this.salario,
    required this.claveEntidad, // Cambiado a int
    required this.estado,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'] ?? '',
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      rfc: json['rfc'] ?? '',
      domicilioFiscal: json['domicilioFiscal'] ?? '',
      curp: json['curp'] ?? '',
      numeroSeguridadSocial: json['numeroSeguridadSocial'] ?? 0, // Cambiado a int
      fechaInicioLaboral: json['fechaInicioLaboral'] ?? '',
      tipoContrato: json['tipoContrato'] ?? '',
      departamento: json['departamento'] ?? '',
      puesto: json['puesto'] ?? '',
      salarioDiario: json['salarioDiario'] ?? '',
      salario: json['salario'] ?? '',
      claveEntidad: json['claveEntidad'] ?? 0, // Cambiado a int
      estado: json['estado'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'rfc': rfc,
      'domicilioFiscal': domicilioFiscal,
      'curp': curp,
      'numeroSeguridadSocial': numeroSeguridadSocial, // Cambiado a int
      'fechaInicioLaboral': fechaInicioLaboral,
      'tipoContrato': tipoContrato,
      'departamento': departamento,
      'puesto': puesto,
      'salarioDiario': salarioDiario,
      'salario': salario,
      'claveEntidad': claveEntidad, // Cambiado a int
      'estado': estado,
    };
  }
}
