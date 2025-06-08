-- DIAGRAMA	DIMENSIONAL

CREATE TABLE Dim_Tiempo_Envios (
    PK_Tiempo INT PRIMARY KEY IDENTITY(1,1),
    fecha_completa DATE UNIQUE,
    mes INT,
    anio INT
);

CREATE TABLE Dim_Grupo_Envios (
    PK_Grupo INT PRIMARY KEY IDENTITY(1,1),
    nombre_grupo VARCHAR(255) UNIQUE
);

CREATE TABLE Dim_GrupoCentroCosto_Envios (
    PK_GrupoCentroCosto INT PRIMARY KEY IDENTITY(1,1),
    nombre_grupo_centro_costo VARCHAR(255) UNIQUE
);

CREATE TABLE Dim_ModoTransporte_Envios (
    PK_ModoTransporte INT PRIMARY KEY IDENTITY(1,1),
    descripcion_modo_transporte VARCHAR(255) UNIQUE
);

CREATE TABLE Dim_Destino_Envios (
    PK_Destino INT PRIMARY KEY IDENTITY(1,1),
    nombre_destino VARCHAR(255),
    nombre_pais VARCHAR(255),
    UNIQUE (nombre_destino, nombre_pais)
);

CREATE TABLE Dim_Lote_Envios (
    PK_Lote INT PRIMARY KEY IDENTITY(1,1),
    identificador_lote VARCHAR(255) UNIQUE,
    peso_lote DECIMAL(10,2)
);

CREATE TABLE Fact_Envios (
    FK_Tiempo INT,
    FK_Grupo INT,
    FK_GrupoCentroCosto INT,
    FK_ModoTransporte INT,
    FK_Destino INT,
    FK_Lote INT,
    costos_envio DECIMAL(10,2),
    PRIMARY KEY (FK_Tiempo, FK_Grupo, FK_GrupoCentroCosto, FK_ModoTransporte, FK_Destino, FK_Lote),
    FOREIGN KEY (FK_Tiempo) REFERENCES Dim_Tiempo_Envios(PK_Tiempo),
    FOREIGN KEY (FK_Grupo) REFERENCES Dim_Grupo_Envios(PK_Grupo),
    FOREIGN KEY (FK_GrupoCentroCosto) REFERENCES Dim_GrupoCentroCosto_Envios(PK_GrupoCentroCosto),
    FOREIGN KEY (FK_ModoTransporte) REFERENCES Dim_ModoTransporte_Envios(PK_ModoTransporte),
    FOREIGN KEY (FK_Destino) REFERENCES Dim_Destino_Envios(PK_Destino),
    FOREIGN KEY (FK_Lote) REFERENCES Dim_Lote_Envios(PK_Lote)
);
