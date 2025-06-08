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

