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

-- DIAGRAMA DIMENSIONAL

CREATE TABLE Dim_Tiempo_Reservas (
    PK_Tiempo INT PRIMARY KEY IDENTITY(1,1),
    fecha_completa DATE UNIQUE,
    mes INT,
    trimestre INT,
    anio INT
);

CREATE TABLE Dim_Cliente_Reservas (
    PK_Cliente INT PRIMARY KEY IDENTITY(1,1),
    nombre_cliente VARCHAR(255),
    direccion_cliente VARCHAR(255),
    tipo_cliente VARCHAR(255),
    UNIQUE (nombre_cliente, direccion_cliente) 
);

CREATE TABLE Dim_Viaje_Reservas (
    PK_Viaje INT PRIMARY KEY IDENTITY(1,1),
    descripcion_viaje VARCHAR(255),
    nombre_destino VARCHAR(255),
    nombre_pais VARCHAR(255),
    UNIQUE (descripcion_viaje, nombre_destino, nombre_pais)
);

CREATE TABLE Dim_Agencia_Reservas (
    PK_Agencia INT PRIMARY KEY IDENTITY(1,1),
    nombre_agencia VARCHAR(255) UNIQUE,
    nombre_operador VARCHAR(255)
);

CREATE TABLE Fact_Reservas (
    FK_Tiempo INT,
    FK_Cliente INT,
    FK_Viaje INT,
    FK_Agencia INT,
    cantidad_reservas INT DEFAULT 1,
    PRIMARY KEY (FK_Tiempo, FK_Cliente, FK_Viaje, FK_Agencia),
    FOREIGN KEY (FK_Tiempo) REFERENCES Dim_Tiempo_Reservas(PK_Tiempo),
    FOREIGN KEY (FK_Cliente) REFERENCES Dim_Cliente_Reservas(PK_Cliente),
    FOREIGN KEY (FK_Viaje) REFERENCES Dim_Viaje_Reservas(PK_Viaje),
    FOREIGN KEY (FK_Agencia) REFERENCES Dim_Agencia_Reservas(PK_Agencia)
);
