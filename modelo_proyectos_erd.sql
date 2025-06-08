-- DIAGRAMA FISICO

CREATE TABLE CLIENTE_PROY (
    ID_Cliente INT PRIMARY KEY,
    cliente VARCHAR(255),
    telefono VARCHAR(50)
);

CREATE TABLE PROYECTO (
    ID_Proyecto INT PRIMARY KEY,
    proyecto VARCHAR(255),
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE_PROY(ID_Cliente)
);

CREATE TABLE EMPRESA (
    ID_Empresa INT PRIMARY KEY,
    empresa VARCHAR(255)
);

CREATE TABLE RESPONSABLE (
    ID_Responsable INT PRIMARY KEY,
    responsable VARCHAR(255),
    ID_Empresa INT,
    FOREIGN KEY (ID_Empresa) REFERENCES EMPRESA(ID_Empresa)
);

CREATE TABLE PAIS_PROY (
    ID_Pais INT PRIMARY KEY,
    pais VARCHAR(255)
);

CREATE TABLE LOCALIDAD (
    ID_Localidad INT PRIMARY KEY,
    localidad VARCHAR(255),
    ID_Pais INT,
    FOREIGN KEY (ID_Pais) REFERENCES PAIS_PROY(ID_Pais)
);

CREATE TABLE PAQUETE_TRABAJO (
    ID_Paquete_Trabajo INT PRIMARY KEY,
    fecha DATE,
    costos DECIMAL(10,2),
    ID_Proyecto INT,
    ID_Responsable INT,
    ID_Localidad INT,
    proyecto_colaborador_responsable_localidad VARCHAR(MAX),
    FOREIGN KEY (ID_Proyecto) REFERENCES PROYECTO(ID_Proyecto),
    FOREIGN KEY (ID_Responsable) REFERENCES RESPONSABLE(ID_Responsable),
    FOREIGN KEY (ID_Localidad) REFERENCES LOCALIDAD(ID_Localidad)
);
