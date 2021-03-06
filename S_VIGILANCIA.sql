
-- Tabla CLIENTE
CREATE TABLE CLIENTE(
    CLIENTE_ID varchar(4) PRIMARY KEY NOT NULL,
    CLIENTE_NOMBREYAPELLIDO varchar(30) NULL,
    CLIENTE_CI varchar(10) NULL,
    CLIENTE_DIRECCION varchar(30) NULL,
    CLIENTE_TELEFONO varchar(10) NULL
);

-- Tabla HORA
CREATE TABLE HORA(
    HORA_ID varchar(4) PRIMARY KEY NOT NULL,
    HORA_INICIO time NULL,
    HORA_FIN time NULL
);

-- Tabla SISTEMA
CREATE TABLE SISTEMA(
    SISTEMA_ID varchar(4) PRIMARY KEY NOT NULL,
    SISTEMA_NOMBRE varchar(10) NULL
);

-- Tabla DRON
CREATE TABLE DRON (
    DRON_ID varchar(4)  PRIMARY KEY NOT NULL,
    DR_SISTEMA_ID varchar(4) NULL,
    DR_CLIENTE_ID varchar(4) NULL,
    DRON_NOMBRE varchar(30) NULL,
    DRON_PESO varchar(10) NULL,
    DRON_ALCANCE varchar(10) NULL,
    DRON_CAMARA varchar(10) NULL,



    CONSTRAINT FK_DRON_SISTEMA_D_SISTEMA FOREIGN KEY (DR_SISTEMA_ID)
    REFERENCES SISTEMA (SISTEMA_ID)
    ON DELETE restrict ON UPDATE restrict,

    CONSTRAINT FK_DRON_CLIENTE_D_CLIENTE FOREIGN KEY (DR_CLIENTE_ID)
    REFERENCES CLIENTE (CLIENTE_ID)
    ON DELETE restrict ON UPDATE restrict
);

-- Tabla MOVIMIENTO
CREATE TABLE MOVIMIENTO (
    MOVIMIENTO_ID varchar(4) PRIMARY KEY NOT NULL,
    MOVI_DRON_ID varchar(4) NULL,
    MOVI_FECHA date NULL,
    MOVI_HORA time NULL,
    MOVI_UBICACION varchar(30),
    MOVI_DESCRIPCION varchar(30),

    CONSTRAINT FK_MOVI_DRON_D_DRON FOREIGN KEY (MOVI_DRON_ID)
    REFERENCES DRON (DRON_ID)
    ON DELETE restrict ON UPDATE restrict
);
-- Tabla DRON_HORA
CREATE TABLE DRON_HORA (
    DR_DRON_ID varchar (4) NOT NULL,
    DR_HORA_ID varchar(4)  NOT NULL,

    CONSTRAINT FK_DRON_HOR_DRON_HORA_DRON FOREIGN KEY (DR_DRON_ID)
    REFERENCES DRON (DRON_ID)
    ON DELETE restrict ON UPDATE restrict,

    CONSTRAINT FK_DRON_HOR_DRON_HORA_HORA FOREIGN KEY (DR_HORA_ID)
    REFERENCES HORA (HORA_ID)
    ON DELETE restrict ON UPDATE restrict
);



--Insertar datos
INSERT INTO CLIENTE VALUES('O1','Mia Anthonella Flores Ochoa','1315727139','Calle 13 av. 21','0983861783')

INSERT INTO SISTEMA VALUES('DR01','Tethered');
INSERT INTO SISTEMA VALUES('DR02','Básico');

INSERT INTO DRON VALUES('0001','DR01','O1','DJI Matrice 300 RTK','9kg','15km','FPV');
INSERT INTO DRON VALUES('0002','DR02','O1','DJI Matrice 300 RTK','9kg','15km','FPV');
INSERT INTO DRON VALUES('0003','DR01','O1','DJI Matrice 300 RTK','9kg','15km','FPV');
INSERT INTO DRON VALUES('0004','DR01','O1','DJI Mavic 2 Enterprise','905g','9km','M2ED');
INSERT INTO DRON VALUES('0005','DR02','O1','DJI Mavic 2 Enterprise','905g','9km','M2ED');
INSERT INTO DRON VALUES('0006','DR02','O1','DJI Mavic 2 Pro','907g','7km','L1D-20c');
INSERT INTO DRON VALUES('0007','DR02','O1','DJI Mavic 2 Pro','907g','7km','L1D-20c');

INSERT INTO HORA VALUES('1','13:00:00','13:50:00');
INSERT INTO HORA VALUES('2','13:50:00','14:40:00');
INSERT INTO HORA VALUES('3','14:40:00','15:50:00');
INSERT INTO HORA VALUES('4','15:50:00','16:40:00');


INSERT INTO MOVIMIENTO VALUES('ABC','0004','2/12/2020','03:40:00','Parque Central','Actividad inusal al oeste');
INSERT INTO MOVIMIENTO VALUES('DEF','0005','3/12/2020','16:35:00','Municipio','Actividad inusal al norte');
INSERT INTO MOVIMIENTO VALUES('GHI','0005','4/12/2020','05:10:00','Palacio de Justicia','Actividad inusal al sur');
INSERT INTO MOVIMIENTO VALUES('JKL','0006','5/12/2020','23:40:00','Municipo','Actividad inusal al norte');



INSERT INTO DRON_HORA VALUES('0001','1');
INSERT INTO DRON_HORA VALUES('0002','1');
INSERT INTO DRON_HORA VALUES('0003','2');
INSERT INTO DRON_HORA VALUES('0004','3');
INSERT INTO DRON_HORA VALUES('0005','3');
INSERT INTO DRON_HORA VALUES('0006','4');
INSERT INTO DRON_HORA VALUES('0007','4');

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
WHERE HORA_FIN - now()::TIME > '00:00' AND HORA_INICIO <= now()::TIME;

--- Cuarta consulta
SELECT DRON_NOMBRE, COUNT (DRON_NOMBRE) AS CANTIDAD
FROM DRON INNER JOIN DRON_HORA ON
DRON.DRON_ID = DRON_HORA.DR_DRON_ID INNER JOIN HORA ON
DRON_HORA.DR_HORA_ID = HORA.HORA_ID
WHERE HORA_FIN - now()::TIME<= '00:00' OR now()::TIME < HORA_INICIO
GROUP BY DRON_NOMBRE;

-- Quinta consulta

SELECT DRON_NOMBRE AS NOMBRE,MOVI_FECHA AS FECHA,MOVI_HORA AS HORA,
MOVI_UBICACION AS UBICACION,MOVI_DESCRIPCION AS DESCRIPCION
FROM DRON INNER JOIN MOVIMIENTO ON
DRON.DRON_ID = MOVIMIENTO.MOVI_DRON_ID
WHERE DRON_ID = MOVI_DRON_ID; 

-- Mostrar varios datos
SELECT DRON_ID,DRON_NOMBRE AS DRON, SISTEMA_NOMBRE
FROM DRON 
INNER JOIN SISTEMA ON DRON.dr_SISTEMA_ID = SISTEMA.SISTEMA_ID
WHERE dr_SISTEMA_ID = SISTEMA_ID; 
