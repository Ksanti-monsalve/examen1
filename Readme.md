
### Entidades Principales

- **Médicos**: Información de médicos titulares, interinos y sustitutos.
- **Empleados**: Información de empleados no médicos (ATS, auxiliares, celadores, administrativos).
- **Pacientes**: Información básica de pacientes.
- **Horarios**: Horarios de consulta de los médicos.
- **Sustituciones**: Registros de sustituciones entre médicos.
- **Vacaciones**: Vacaciones planificadas y disfrutadas para médicos y empleados.
- **Asignaciones**: Relación entre pacientes y médicos asignados.

## Consultas

A continuación se presentan las consultas SQL solicitadas, con explicaciones de su lógica y relación con la estructura de la base de datos.

1. **Número de pacientes atendidos por cada médico**

```sql
SELECT m.nombre, m.apellido, COUNT(a.id_paciente) AS num_pacientes
FROM Medicos m
LEFT JOIN Asignaciones a ON m.id_medico = a.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido
ORDER BY num_pacientes DESC;
```

2. **Total de días de vacaciones planificadas y disfrutadas por cada empleado**

```sql
SELECT e.nombre, e.apellido,
       SUM(CASE WHEN v.tipo = 'planificada' THEN DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1 ELSE 0 END) AS dias_planificados,
       SUM(CASE WHEN v.tipo = 'disfrutada' THEN DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1 ELSE 0 END) AS dias_disfrutados
FROM Empleados e
LEFT JOIN Vacaciones_Empleados v ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado, e.nombre, e.apellido;
```

3. **Médicos con mayor cantidad de horas de consulta en la semana**

```sql
SELECT m.nombre, m.apellido, SUM(TIMESTAMPDIFF(HOUR, h.hora_inicio, h.hora_fin)) AS horas_semanales
FROM Medicos m
JOIN Horarios h ON m.id_medico = h.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido
ORDER BY horas_semanales DESC
LIMIT 5;
```

4. **Número de sustituciones realizadas por cada médico sustituto**

```sql
SELECT m.nombre, m.apellido, COUNT(s.id_sustitucion) AS num_sustituciones
FROM Medicos m
JOIN Sustituciones s ON m.id_medico = s.id_medico_sustituto
GROUP BY m.id_medico, m.nombre, m.apellido
ORDER BY num_sustituciones DESC;
```

5. **Número de médicos que están actualmente en sustitución**

```sql
SELECT COUNT(DISTINCT s.id_medico_sustituto) AS medicos_en_sustitucion
FROM Sustituciones s
WHERE s.fecha_fin IS NULL OR s.fecha_fin >= CURDATE();
```

6. **Horas totales de consulta por médico por día de la semana**

```sql
SELECT m.nombre, m.apellido, h.dia_semana, SUM(TIMESTAMPDIFF(HOUR, h.hora_inicio, h.hora_fin)) AS horas_totales
FROM Medicos m
JOIN Horarios h ON m.id_medico = h.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido, h.dia_semana
ORDER BY m.nombre, m.apellido, FIELD(h.dia_semana, 'lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo');
```

7. **Médico con mayor cantidad de pacientes asignados**

```sql
SELECT m.nombre, m.apellido, COUNT(a.id_paciente) AS num_pacientes
FROM Medicos m
LEFT JOIN Asignaciones a ON m.id_medico = a.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido
ORDER BY num_pacientes DESC
LIMIT 1;
```

Encuentra el médico con más pacientes asignados.

8. **Empleados con más de 10 días de vacaciones disfrutadas**

```sql
SELECT e.nombre, e.apellido, SUM(DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1) AS dias_disfrutados
FROM Empleados e
JOIN Vacaciones_Empleados v ON e.id_empleado = v.id_empleado
WHERE v.tipo = 'disfrutada'
GROUP BY e.id_empleado, e.nombre, e.apellido
HAVING dias_disfrutados > 10;
```

Filtra empleados con más de 10 días de vacaciones disfrutadas.

9. **Médicos que actualmente están realizando una sustitución**

```sql
SELECT DISTINCT m.nombre, m.apellido
FROM Medicos m
JOIN Sustituciones s ON m.id_medico = s.id_medico_sustituto
WHERE s.fecha_fin IS NULL OR s.fecha_fin >= CURDATE();
```

Lista médicos actualmente en sustitución.

10. **Promedio de horas de consulta por médico por día de la semana**

```sql
SELECT h.dia_semana, AVG(TIMESTAMPDIFF(HOUR, h.hora_inicio, h.hora_fin)) AS promedio_horas
FROM Horarios h
GROUP BY h.dia_semana
ORDER BY FIELD(h.dia_semana, 'lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo');
```

Calcula el promedio de horas por día de la semana.

11. **Empleados con mayor número de pacientes atendidos por los médicos bajo su supervisión**

Esta consulta requiere una relación de supervisión que no está modelada en la base de datos actual. Se asumiría una tabla adicional para supervisión.

```sql
-- Nota: Esta consulta requiere una tabla de supervisión no implementada
-- Ejemplo hipotético:
SELECT e.nombre, e.apellido, COUNT(DISTINCT a.id_paciente) AS pacientes_supervisados
FROM Empleados e
JOIN Supervision sup ON e.id_empleado = sup.id_supervisor
JOIN Medicos m ON sup.id_medico = m.id_medico
JOIN Asignaciones a ON m.id_medico = a.id_medico
GROUP BY e.id_empleado, e.nombre, e.apellido
ORDER BY pacientes_supervisados DESC;
```

12. **Médicos con más de 5 pacientes y total de horas de consulta en la semana**

```sql
SELECT m.nombre, m.apellido, COUNT(a.id_paciente) AS num_pacientes, SUM(TIMESTAMPDIFF(HOUR, h.hora_inicio, h.hora_fin)) AS horas_semanales
FROM Medicos m
LEFT JOIN Asignaciones a ON m.id_medico = a.id_medico
LEFT JOIN Horarios h ON m.id_medico = h.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido
HAVING num_pacientes > 5
ORDER BY num_pacientes DESC, horas_semanales DESC;
```

Filtra médicos con más de 5 pacientes y muestra horas semanales.

13. **Total de días de vacaciones planificadas y disfrutadas por cada tipo de empleado**

```sql
SELECT e.tipo,
       SUM(CASE WHEN v.tipo = 'planificada' THEN DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1 ELSE 0 END) AS dias_planificados,
       SUM(CASE WHEN v.tipo = 'disfrutada' THEN DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1 ELSE 0 END) AS dias_disfrutados
FROM Empleados e
LEFT JOIN Vacaciones_Empleados v ON e.id_empleado = v.id_empleado
GROUP BY e.tipo;
```

Agrupa por tipo de empleado.

14. **Total de pacientes por cada tipo de médico**

```sql
SELECT m.tipo, COUNT(a.id_paciente) AS total_pacientes
FROM Medicos m
LEFT JOIN Asignaciones a ON m.id_medico = a.id_medico
GROUP BY m.tipo;
```

Cuenta pacientes por tipo de médico.

15. **Total de horas de consulta por médico y día de la semana**

```sql
SELECT m.nombre, m.apellido, h.dia_semana, SUM(TIMESTAMPDIFF(HOUR, h.hora_inicio, h.hora_fin)) AS horas_totales
FROM Medicos m
JOIN Horarios h ON m.id_medico = h.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido, h.dia_semana
ORDER BY m.nombre, m.apellido, FIELD(h.dia_semana, 'lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo');
```

Similar a la consulta 6.

16. **Número de sustituciones por tipo de médico**

```sql
SELECT m.tipo, COUNT(s.id_sustitucion) AS num_sustituciones
FROM Medicos m
LEFT JOIN Sustituciones s ON m.id_medico = s.id_medico_sustituto
GROUP BY m.tipo;
```

Cuenta sustituciones por tipo de médico.

17. **Total de pacientes por médico y por especialidad**

```sql
SELECT m.nombre, m.apellido, m.especialidad, COUNT(a.id_paciente) AS total_pacientes
FROM Medicos m
LEFT JOIN Asignaciones a ON m.id_medico = a.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido, m.especialidad
ORDER BY m.especialidad, total_pacientes DESC;
```

Agrupa por médico y especialidad.

18. **Empleados y médicos con más de 20 días de vacaciones planificadas**

```sql
SELECT 'Empleado' AS tipo_persona, e.nombre, e.apellido, SUM(DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1) AS dias_planificados
FROM Empleados e
JOIN Vacaciones_Empleados v ON e.id_empleado = v.id_empleado
WHERE v.tipo = 'planificada'
GROUP BY e.id_empleado, e.nombre, e.apellido
HAVING dias_planificados > 20

UNION ALL

SELECT 'Médico' AS tipo_persona, m.nombre, m.apellido, SUM(DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1) AS dias_planificados
FROM Medicos m
JOIN Vacaciones_Medicos v ON m.id_medico = v.id_medico
WHERE v.tipo = 'planificada'
GROUP BY m.id_medico, m.nombre, m.apellido
HAVING dias_planificados > 20;
```

Combina empleados y médicos con más de 20 días planificados.

19. **Médicos con el mayor número de pacientes actualmente en sustitución**

```sql
SELECT m.nombre, m.apellido, COUNT(a.id_paciente) AS pacientes_en_sustitucion
FROM Medicos m
JOIN Sustituciones s ON m.id_medico = s.id_medico_sustituto
JOIN Asignaciones a ON s.id_medico_sustituido = a.id_medico
WHERE s.fecha_fin IS NULL OR s.fecha_fin >= CURDATE()
GROUP BY m.id_medico, m.nombre, m.apellido
ORDER BY pacientes_en_sustitucion DESC;
```

Cuenta pacientes de médicos sustituidos actualmente.

20. **Total de horas de consulta por especialidad y día de la semana**

```sql
SELECT m.especialidad, h.dia_semana, SUM(TIMESTAMPDIFF(HOUR, h.hora_inicio, h.hora_fin)) AS horas_totales
FROM Medicos m
JOIN Horarios h ON m.id_medico = h.id_medico
GROUP BY m.especialidad, h.dia_semana
ORDER BY m.especialidad, FIELD(h.dia_semana, 'lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo');
```

Agrupa horas por especialidad y día.
