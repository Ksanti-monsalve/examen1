USE centro_salud;

-- Insertar datos de prueba en Medicos
INSERT INTO Medicos (nombre, apellido, tipo, especialidad, fecha_contratacion) VALUES
('Juan', 'Pérez', 'titular', 'Cardiología', '2020-01-15'),
('María', 'Gómez', 'interino', 'Pediatría', '2021-03-10'),
('Carlos', 'López', 'sustituto', 'Dermatología', '2022-05-20'),
('Ana', 'Martínez', 'titular', 'Ginecología', '2019-07-05'),
('Luis', 'Rodríguez', 'interino', 'Oftalmología', '2020-09-12'),
('Elena', 'Fernández', 'sustituto', 'Neurología', '2021-11-18'),
('Pedro', 'Sánchez', 'titular', 'Traumatología', '2018-02-28'),
('Sofia', 'Ramírez', 'interino', 'Psiquiatría', '2022-04-15'),
('Miguel', 'Torres', 'sustituto', 'Urología', '2020-06-30'),
('Laura', 'Jiménez', 'titular', 'Endocrinología', '2017-10-22');

-- Insertar datos de prueba en Empleados
INSERT INTO Empleados (nombre, apellido, tipo, fecha_contratacion) VALUES
('Rosa', 'Díaz', 'ATS', '2019-01-10'),
('Antonio', 'Morales', 'auxiliar_enfermeria', '2020-03-15'),
('Carmen', 'Ortiz', 'celador', '2021-05-20'),
('Javier', 'Ruiz', 'administrativo', '2018-07-05'),
('Isabel', 'Hernández', 'ATS', '2020-09-12'),
('Francisco', 'Gutiérrez', 'auxiliar_enfermeria', '2021-11-18'),
('Dolores', 'Álvarez', 'celador', '2019-02-28'),
('Manuel', 'Domínguez', 'administrativo', '2022-04-15'),
('Pilar', 'Vázquez', 'ATS', '2020-06-30'),
('Rafael', 'Castro', 'auxiliar_enfermeria', '2017-10-22');

-- Insertar datos de prueba en Pacientes
INSERT INTO Pacientes (nombre, apellido, fecha_nacimiento) VALUES
('Alberto', 'Núñez', '1985-01-15'),
('Beatriz', 'Romero', '1990-03-10'),
('Cristina', 'Rubio', '1975-05-20'),
('David', 'Molina', '1982-07-05'),
('Eva', 'Delgado', '1995-09-12'),
('Fernando', 'Ortega', '1988-11-18'),
('Gabriela', 'Moreno', '1970-02-28'),
('Hugo', 'Guerrero', '1992-04-15'),
('Irene', 'Santos', '1980-06-30'),
('Jorge', 'Iglesias', '1993-10-22'),
('Karla', 'Cabrera', '1987-12-05'),
('Luis', 'Vega', '1978-01-20'),
('Mónica', 'Campos', '1991-03-25'),
('Nicolás', 'Reyes', '1984-05-30'),
('Olga', 'Herrera', '1976-07-15'),
('Pablo', 'Medina', '1994-09-10'),
('Quirina', 'Cortés', '1989-11-05'),
('Roberto', 'Paredes', '1979-12-20'),
('Sara', 'León', '1996-02-15'),
('Tomás', 'Aguilar', '1983-04-10');

-- Insertar datos de prueba en Horarios
INSERT INTO Horarios (id_medico, dia_semana, hora_inicio, hora_fin) VALUES
(1, 'lunes', '09:00:00', '13:00:00'),
(1, 'miercoles', '09:00:00', '13:00:00'),
(2, 'martes', '10:00:00', '14:00:00'),
(2, 'jueves', '10:00:00', '14:00:00'),
(3, 'viernes', '11:00:00', '15:00:00'),
(4, 'lunes', '08:00:00', '12:00:00'),
(4, 'martes', '08:00:00', '12:00:00'),
(5, 'miercoles', '14:00:00', '18:00:00'),
(6, 'jueves', '15:00:00', '19:00:00'),
(7, 'viernes', '09:00:00', '13:00:00'),
(8, 'lunes', '10:00:00', '14:00:00'),
(9, 'martes', '11:00:00', '15:00:00'),
(10, 'miercoles', '12:00:00', '16:00:00');

-- Insertar datos de prueba en Sustituciones
INSERT INTO Sustituciones (id_medico_sustituto, id_medico_sustituido, fecha_inicio, fecha_fin) VALUES
(3, 1, '2023-06-01', '2023-06-15'),
(6, 4, '2023-07-01', '2023-07-10'),
(9, 7, '2023-08-01', '2023-08-20'),
(3, 2, '2023-09-01', NULL),  -- Sustitución actual sin fecha fin
(6, 5, '2023-10-01', '2023-10-05');

-- Insertar datos de prueba en Vacaciones_Medicos
INSERT INTO Vacaciones_Medicos (id_medico, fecha_inicio, fecha_fin, tipo) VALUES
(1, '2023-07-01', '2023-07-15', 'planificada'),
(1, '2023-07-01', '2023-07-15', 'disfrutada'),
(2, '2023-08-01', '2023-08-10', 'planificada'),
(3, '2023-09-01', '2023-09-05', 'disfrutada'),
(4, '2023-10-01', '2023-10-10', 'planificada'),
(5, '2023-11-01', '2023-11-05', 'disfrutada'),
(6, '2023-12-01', '2023-12-10', 'planificada'),
(7, '2024-01-01', '2024-01-15', 'planificada'),
(8, '2024-02-01', '2024-02-05', 'disfrutada'),
(9, '2024-03-01', '2024-03-10', 'planificada'),
(10, '2024-04-01', '2024-04-05', 'disfrutada');

-- Insertar datos de prueba en Vacaciones_Empleados
INSERT INTO Vacaciones_Empleados (id_empleado, fecha_inicio, fecha_fin, tipo) VALUES
(1, '2023-07-01', '2023-07-15', 'planificada'),
(1, '2023-07-01', '2023-07-15', 'disfrutada'),
(2, '2023-08-01', '2023-08-10', 'planificada'),
(3, '2023-09-01', '2023-09-05', 'disfrutada'),
(4, '2023-10-01', '2023-10-10', 'planificada'),
(5, '2023-11-01', '2023-11-05', 'disfrutada'),
(6, '2023-12-01', '2023-12-10', 'planificada'),
(7, '2024-01-01', '2024-01-15', 'planificada'),
(8, '2024-02-01', '2024-02-05', 'disfrutada'),
(9, '2024-03-01', '2024-03-10', 'planificada'),
(10, '2024-04-01', '2024-04-05', 'disfrutada');

-- Insertar datos de prueba en Asignaciones
INSERT INTO Asignaciones (id_paciente, id_medico, fecha_asignacion) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-01-05'),
(3, 3, '2023-01-10'),
(4, 4, '2023-01-15'),
(5, 5, '2023-01-20'),
(6, 6, '2023-01-25'),
(7, 7, '2023-01-30'),
(8, 8, '2023-02-01'),
(9, 9, '2023-02-05'),
(10, 10, '2023-02-10'),
(11, 1, '2023-02-15'),
(12, 2, '2023-02-20'),
(13, 3, '2023-02-25'),
(14, 4, '2023-03-01'),
(15, 5, '2023-03-05'),
(16, 6, '2023-03-10'),
(17, 7, '2023-03-15'),
(18, 8, '2023-03-20'),
(19, 9, '2023-03-25'),
(20, 10, '2023-03-30');
