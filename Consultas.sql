-- Consultas
-- Primera consulta
SELECT DRON_ID AS DRON, DRON_NOMBRE AS DRON_ACTIVO
FROM DRON inner join DRON_HORA
ON DRON.DRON_ID = DRON_HORA.DR_DRON_ID INNER JOIN HORA
ON DRON_HORA.DR_HORA_ID = HORA.HORA_ID
WHERE HORA_FIN - now()::TIME > '00:00' AND HORA_INICIO <= now()::TIME;

-- Segunda consukta
SELECT DRON_ID, DRON_NOMBRE AS DRON, SISTEMA_NOMBRE
FROM DRON 
INNER JOIN SISTEMA ON DRON.DR_SISTEMA_ID = SISTEMA.SISTEMA_ID
WHERE SISTEMA_ID='DR01';

--- Tercera consulta
SELECT DRON_ID, DRON_NOMBRE, HORA_INICIO AS HORA_INICIO, 
HORA_FIN AS HORA_FIN, HORA_FIN - now()::TIME::INTERVAL AS TIEMPO_PARA_BAJAR_A_CARGAR
FROM DRON INNER JOIN DRON_HORA ON
DRON.DRON_ID = DRON_HORA.DR_DRON_ID INNER JOIN HORA ON
DRON_HORA.DR_HORA_ID = HORA.HORA_ID
WHERE HORA_FIN - now()::TIME > '00:00';

--- Cuarta consulta
SELECT DRON_NOMBRE, COUNT (DRON_NOMBRE) AS CANTIDAD
FROM DRON INNER JOIN DRON_HORA ON
DRON.DRON_ID = DRON_HORA.DR_DRON_ID INNER JOIN HORA ON
DRON_HORA.DR_HORA_ID = HORA.HORA_ID
WHERE HORA_FIN - now()::TIME < '00:00' 
GROUP BY DRON_NOMBRE;

-- Mostrar varios datos
SELECT DRON_ID,DRON_NOMBRE AS DRON, SISTEMA_NOMBRE
FROM DRON 
INNER JOIN SISTEMA ON DRON.dr_SISTEMA_ID = SISTEMA.SISTEMA_ID
WHERE dr_SISTEMA_ID = SISTEMA_ID; 
