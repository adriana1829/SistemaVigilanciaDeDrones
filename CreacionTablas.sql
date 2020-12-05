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
