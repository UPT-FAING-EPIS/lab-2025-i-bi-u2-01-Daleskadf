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
