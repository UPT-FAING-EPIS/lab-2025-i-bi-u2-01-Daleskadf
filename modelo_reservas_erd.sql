-- DIAGRAMA FISICO

CREATE TABLE TIPO (
    ID_Tipo INT PRIMARY KEY,
    tipo VARCHAR(255)
);

CREATE TABLE CLIENTE (
    ID_Cliente INT PRIMARY KEY,
    cliente VARCHAR(255),
    direccion VARCHAR(255),
    ID_Tipo INT,
    FOREIGN KEY (ID_Tipo) REFERENCES TIPO(ID_Tipo)
);

CREATE TABLE PAIS_VIAJE ( 
    ID_Pais INT PRIMARY KEY,
    pais VARCHAR(255)
);

CREATE TABLE DESTINO_VIAJE ( 
    ID_Destino INT PRIMARY KEY,
    destino VARCHAR(255),
    ID_Pais INT,
    FOREIGN KEY (ID_Pais) REFERENCES PAIS_VIAJE(ID_Pais)
);

CREATE TABLE VIAJE (
    ID_Viaje INT PRIMARY KEY,
    descripcion VARCHAR(255),
    ID_Destino INT,
    FOREIGN KEY (ID_Destino) REFERENCES DESTINO_VIAJE(ID_Destino)
);

CREATE TABLE OPERADOR (
    ID_Operador INT PRIMARY KEY,
    operador VARCHAR(255)
);

CREATE TABLE AGENCIA_DE_VIAJES (
    ID_Agencia INT PRIMARY KEY,
    agencia_de_viajes VARCHAR(255),
    ID_Operador INT,
    FOREIGN KEY (ID_Operador) REFERENCES OPERADOR(ID_Operador)
);

CREATE TABLE RESERVA (
    ID_Reserva INT PRIMARY KEY,
    fecha DATE,
    ID_Cliente INT,
    ID_Viaje INT,
    ID_Agencia INT,
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente),
    FOREIGN KEY (ID_Viaje) REFERENCES VIAJE(ID_Viaje),
    FOREIGN KEY (ID_Agencia) REFERENCES AGENCIA_DE_VIAJES(ID_Agencia)
);