-- Creamos la base de datos de matriculacionuniversitaria
CREATE DATABASE MatriculacionuniversitariaDB;
GO

USE MatriculacionuniversitariaDB;
GO

-- Creamos la tabla llamada Estudiantes
CREATE TABLE Estudiantes (
estudiante_id INT PRIMARY KEY IDENTITY(1,1),
nombre VARCHAR(100) NOT NULL,
cedula VARCHAR(15) NOT NULL UNIQUE,
facultad VARCHAR(50) NOT NULL
);

-- Creamos la tabla llamada Asignaturas
CREATE TABLE Asignaturas (
asignaturas_id INT PRIMARY KEY IDENTITY(1,1),
nombre_materia VARCHAR(100) NOT NULL,
docente VARCHAR(100) NOT NULL,
cupos_disponibles INT NOT NULL CHECK (cupos_disponibles >=0)
);

-- Creamos la tabla llamada Registros_Matricula
CREATE TABLE Registros_Matricula (
registro_id INT PRIMARY KEY IDENTITY(1,1),
estudiante_id INT FOREIGN KEY REFERENCES Estudiantes(estudiante_id),
asignatura_id INT FOREIGN KEY REFERENCES Asignaturas(asignaturas_id),
fecha_registro DATETIME DEFAULT GETDATE(),
ESTADO varchar(20) check (estado in ('CONFIRMADA', 'PENDIENTE')) 
);

-- Ponemos los datos del Estudiante
INSERT INTO Estudiantes (nombre, cedula, facultad)
VALUES
('Danielita', '0603126199', 'Enfermeria'),
('Alejandro', '0650151525', 'Ingenieria');

-- Ponemos los datos de Asignaturas
INSERT INTO Asignaturas (nombre_materia, docente, cupos_disponibles)
VALUES
('Nutricion', 'Dr Brayan Guapulema',5),
('Administracion de Base de Datoa', 'Ing Raquel Moyano',5);

-- Ponemos los datos de los Resgistros_Matricula
INSERT INTO Registros_Matricula (estudiante_id, asignatura_id, estado)
VALUES
(1, 1, 'PENDIENTE'),
(2, 2, 'cONFIRMADA');

-- Seleccionamos las tablas que hemos creado
SELECT * from Estudiantes
SELECT * from Asignaturas
SELECT * from Registros_Matricula;


-- Intentan matricularse en varias materias si aqui falla la ultima todo se revierte
BEGIN TRANSACTION;

-- Debemos actualizar el cupo de la Materia 1 (Exito)
UPDATE Asignaturas
SET cupos_disponibles = cupos_disponibles - 1
WHERE asignaturas_id = 1;

-- Debemos actualizar el cupo de la Materia 2 (Exito)
UPDATE Asignaturas
SET cupos_disponibles = cupos_disponibles - 1
WHERE asignaturas_id = 2;

-- Error: intentamos actualizar una Materia con un ID que no exista (provocara el fallo)
UPDATE Asignaturas
SET cupos_disponibles = cupos_disponibles - 1
WHERE asignaturas_id = 999;

-- Ejecuto el ROLLBACK para deshacer los cambios de la smaterias 1 y 2
ROLLBACK;

-- Verificamos que los cupos volvieron al estado original
SELECT * FROM Asignaturas;
