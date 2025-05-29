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

-- DIAGRAMA DIMENSIONAL

CREATE TABLE Dim_Tiempo_Proyectos (
    PK_Tiempo INT PRIMARY KEY IDENTITY(1,1),
    fecha_completa DATE UNIQUE,
    dia INT,
    mes INT,
    anio INT
);

CREATE TABLE Dim_Proyecto_Proyectos (
    PK_Proyecto INT PRIMARY KEY IDENTITY(1,1),
    nombre_proyecto VARCHAR(255) UNIQUE,
    nombre_cliente VARCHAR(255),
    telefono_cliente VARCHAR(50)
);

CREATE TABLE Dim_Responsable_Proyectos (
    PK_Responsable INT PRIMARY KEY IDENTITY(1,1),
    nombre_responsable VARCHAR(255) UNIQUE,
    nombre_empresa VARCHAR(255)
);

CREATE TABLE Dim_Localidad_Proyectos (
    PK_Localidad INT PRIMARY KEY IDENTITY(1,1),
    nombre_localidad VARCHAR(255),
    nombre_pais VARCHAR(255),
    UNIQUE(nombre_localidad, nombre_pais)
);

CREATE TABLE Fact_PaquetesTrabajo (
    FK_Tiempo INT,
    FK_Proyecto INT,
    FK_Responsable INT,
    FK_Localidad INT,
    costos_paquete_trabajo DECIMAL(10,2),
    cantidad_paquetes_trabajo INT DEFAULT 1,
    PRIMARY KEY (FK_Tiempo, FK_Proyecto, FK_Responsable, FK_Localidad), 
    FOREIGN KEY (FK_Tiempo) REFERENCES Dim_Tiempo_Proyectos(PK_Tiempo),
    FOREIGN KEY (FK_Proyecto) REFERENCES Dim_Proyecto_Proyectos(PK_Proyecto),
    FOREIGN KEY (FK_Responsable) REFERENCES Dim_Responsable_Proyectos(PK_Responsable),
    FOREIGN KEY (FK_Localidad) REFERENCES Dim_Localidad_Proyectos(PK_Localidad)
);

