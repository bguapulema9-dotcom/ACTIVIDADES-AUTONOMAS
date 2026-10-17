-- Configuramos el nivel de aislamiento Read Committed
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Consulta la tabla de Asignaturas (espera hasta que se libere el bloque)
SELECT * FROM Asignaturas WHERE asignaturas_id = 1;