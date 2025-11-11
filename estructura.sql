CREATE DATABASE IF NOT EXISTS centro_salud;
USE centro_salud;


CREATE TABLE Medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    tipo ENUM('titular', 'interino', 'sustituto') NOT NULL,
    especialidad VARCHAR(50),
    fecha_contratacion DATE NOT NULL
);


CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    tipo ENUM('ATS', 'auxiliar_enfermeria', 'celador', 'administrativo') NOT NULL,
    fecha_contratacion DATE NOT NULL
);

CREATE TABLE Pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

CREATE TABLE Horarios (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT NOT NULL,
    dia_semana ENUM('lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo') NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico) ON DELETE CASCADE
);


CREATE TABLE Sustituciones (
    id_sustitucion INT AUTO_INCREMENT PRIMARY KEY,
    id_medico_sustituto INT NOT NULL,
    id_medico_sustituido INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    FOREIGN KEY (id_medico_sustituto) REFERENCES Medicos(id_medico) ON DELETE CASCADE,
    FOREIGN KEY (id_medico_sustituido) REFERENCES Medicos(id_medico) ON DELETE CASCADE
);


CREATE TABLE Vacaciones_Medicos (
    id_vacacion INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    tipo ENUM('planificada', 'disfrutada') NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico) ON DELETE CASCADE
);


CREATE TABLE Vacaciones_Empleados (
    id_vacacion INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    tipo ENUM('planificada', 'disfrutada') NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado) ON DELETE CASCADE
);


CREATE TABLE Asignaciones (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    fecha_asignacion DATE NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente) ON DELETE CASCADE,
    FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico) ON DELETE CASCADE
);

