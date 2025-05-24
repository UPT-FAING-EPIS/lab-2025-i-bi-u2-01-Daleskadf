-- DIAGRAMA FISICO

CREATE TABLE GRUPO (
    ID_Grupo INT PRIMARY KEY,
    grupo VARCHAR(255)
);

CREATE TABLE PAIS (
    ID_Pais INT PRIMARY KEY,
    pais VARCHAR(255)
);

CREATE TABLE MODO_TRANSPORTE (
    ID_Modo_Transporte INT PRIMARY KEY,
    modo_transporte VARCHAR(255)
);

CREATE TABLE GRUPO_CENTRO_COSTO (
    ID_Grupo_Centro_Costo INT PRIMARY KEY,
    grupo_de_centro_de_costos VARCHAR(255)
);

CREATE TABLE CENTRO_COSTO (
    ID_Centro_Costo INT PRIMARY KEY,
    centro_costo VARCHAR(255),
    responsable VARCHAR(255),
    ID_Grupo_Centro_Costo INT,
    FOREIGN KEY (ID_Grupo_Centro_Costo) REFERENCES GRUPO_CENTRO_COSTO(ID_Grupo_Centro_Costo)
);

CREATE TABLE LOTE (
    ID_Lote INT PRIMARY KEY,
    lote VARCHAR(255),
    peso DECIMAL(10,2),
    tarifa_exportacion DECIMAL(10,2),
    tarifa_importacion DECIMAL(10,2),
    ID_Grupo INT,
    ID_Pais_Origen INT,
    FOREIGN KEY (ID_Grupo) REFERENCES GRUPO(ID_Grupo),
    FOREIGN KEY (ID_Pais_Origen) REFERENCES PAIS(ID_Pais)
);

CREATE TABLE DESTINO (
    ID_Destino INT PRIMARY KEY,
    destino VARCHAR(255),
    ID_Pais INT,
    FOREIGN KEY (ID_Pais) REFERENCES PAIS(ID_Pais)
);

CREATE TABLE ENVIO (
    ID_Envio INT PRIMARY KEY,
    fecha DATE,
    costos DECIMAL(10,2),
    ID_Lote INT,
    ID_Centro_Costo INT,
    ID_Modo_Transporte INT,
    ID_Destino INT,
    FOREIGN KEY (ID_Lote) REFERENCES LOTE(ID_Lote),
    FOREIGN KEY (ID_Centro_Costo) REFERENCES CENTRO_COSTO(ID_Centro_Costo),
    FOREIGN KEY (ID_Modo_Transporte) REFERENCES MODO_TRANSPORTE(ID_Modo_Transporte),
    FOREIGN KEY (ID_Destino) REFERENCES DESTINO(ID_Destino)
);


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
