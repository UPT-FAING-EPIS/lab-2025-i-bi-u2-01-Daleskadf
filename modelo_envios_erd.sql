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
