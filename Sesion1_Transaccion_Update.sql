-- Inicia la transaccion explicita
BEGIN TRANSACTION;

-- Actualizacion de prueba en la tabla de Asignaturas
UPDATE Asignaturas
SET cupos_disponibles = cupos_disponibles
WHERE asignaturas_id =1;

-- Sin COMMIT ni ROLLBACK.(Mantiene el bloque activo)

-- Cancelamos la transaccion y liberacion de bloqueos
ROLLBACK;