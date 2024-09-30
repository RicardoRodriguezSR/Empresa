create database Empresa
USE Empresa;

CREATE TABLE AreasEmpresa (
    AreaID INT PRIMARY KEY IDENTITY(1,1), 
    NombreArea NVARCHAR(100) NOT NULL, 
    Descripcion NVARCHAR(250), 
    Departamento NVARCHAR(100), 
    Responsable NVARCHAR(100),
    FechaCreacion DATETIME DEFAULT GETDATE(), 
    Estado BIT DEFAULT 1 
);


INSERT INTO AreasEmpresa (NombreArea, Descripcion, Departamento, Responsable, Estado)
VALUES 
('Administraci�n y Finanzas', 'Gestiona las finanzas y los recursos administrativos de la empresa', 'Finanzas', 'Carlos P�rez', 1),
('Ventas', 'Se encarga de la comercializaci�n de productos y servicios', 'Comercial', 'Ana G�mez', 1),
('Marketing', 'Desarrolla estrategias de marketing y publicidad', 'Comercial', 'Laura Mart�nez', 1),
('Producci�n', 'Coordina la fabricaci�n de productos', 'Operaciones', 'Jorge Rodr�guez', 1),
('Log�stica', 'Gestiona el almacenamiento y distribuci�n de productos', 'Operaciones', 'Mario Fern�ndez', 1),
('Recursos Humanos', 'Administra el personal de la empresa y sus necesidades', 'Administrativo', 'Claudia Ram�rez', 1),
('Tecnolog�a de la Informaci�n', 'Mantiene la infraestructura tecnol�gica de la empresa', 'Soporte', 'David L�pez', 1),
('Atenci�n al Cliente', 'Gestiona las relaciones con los clientes y resuelve incidencias', 'Comercial', 'Paula Garc�a', 1),
('Investigaci�n y Desarrollo', 'Desarrolla nuevos productos y mejora los existentes', 'Innovaci�n', 'Luis Torres', 1),
('Legal y Compliance', 'Asegura el cumplimiento normativo y gestiona asuntos legales', 'Administrativo', 'Isabel D�az', 1);


CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY IDENTITY(1,1), 
    NombreEmpleado NVARCHAR(100) NOT NULL, 
    Edad INT NOT NULL, 
    CorreoElectronico NVARCHAR(100) NOT NULL, 
    AreaID INT, 
    FOREIGN KEY (AreaID) REFERENCES AreasEmpresa(AreaID) 
);

INSERT INTO Empleados (NombreEmpleado, Edad, CorreoElectronico, AreaID)
VALUES 
('Carlos L�pez', 34, 'carlos.lopez@example.com', 1), 
('Ana Ram�rez', 28, 'ana.ramirez@example.com', 2), 
('Laura Fern�ndez', 30, 'laura.fernandez@example.com', 3), 
('Jorge Salazar', 45, 'jorge.salazar@example.com', 4), 
('Mario Torres', 37, 'mario.torres@example.com', 5), 
('Claudia Soto', 29, 'claudia.soto@example.com', 6), 
('David Estrada', 40, 'david.estrada@example.com', 7), 
('Paula Mart�nez', 32, 'paula.martinez@example.com', 8), 
('Luis Castillo', 38, 'luis.castillo@example.com', 9), 
('Isabel Ruiz', 41, 'isabel.ruiz@example.com', 10); 

select * from Empleados

select * from AreasEmpresa

CREATE PROCEDURE InsertarAreaEmpresa
    @NombreArea NVARCHAR(100),
    @Descripcion NVARCHAR(250) = NULL, 
    @Departamento NVARCHAR(100) = NULL, 
    @Responsable NVARCHAR(100) = NULL, 
    @Estado BIT = 1 -- 
AS
BEGIN
    
    BEGIN TRANSACTION;

   
    BEGIN TRY
        INSERT INTO AreasEmpresa (NombreArea, Descripcion, Departamento, Responsable, Estado)
        VALUES (@NombreArea, @Descripcion, @Departamento, @Responsable, @Estado);

       
        COMMIT TRANSACTION;

        PRINT '�rea insertada exitosamente';
    END TRY
    BEGIN CATCH
        
        ROLLBACK TRANSACTION;

        
        PRINT 'Error al insertar el �rea: ' + ERROR_MESSAGE();
    END CATCH
END;

EXEC InsertarAreaEmpresa 
    @NombreArea = 'Desarrollo de Negocios',
    @Descripcion = 'Desarrollo de estrategias para el crecimiento del negocio',
    @Departamento = 'Comercial',
    @Responsable = 'Mar�a P�rez',
    @Estado = 1;

CREATE PROCEDURE CrearNuevaArea
    @NombreArea NVARCHAR(100),
    @Descripcion NVARCHAR(250) = NULL, 
    @Departamento NVARCHAR(100) = NULL, 
    @Responsable NVARCHAR(100) = NULL, 
    @Estado BIT = 1 
AS
BEGIN
    
    BEGIN TRANSACTION;

    
    BEGIN TRY
        INSERT INTO AreasEmpresa (NombreArea, Descripcion, Departamento, Responsable, Estado)
        VALUES (@NombreArea, @Descripcion, @Departamento, @Responsable, @Estado);

        
        COMMIT TRANSACTION;

        PRINT 'Nueva �rea creada exitosamente';
    END TRY
    BEGIN CATCH
       
        ROLLBACK TRANSACTION;

        
        PRINT 'Error al crear el �rea: ' + ERROR_MESSAGE();
    END CATCH
END;

EXEC CrearNuevaArea 
    @NombreArea = 'Desarrollo de Negocios',
    @Descripcion = 'Desarrollo de estrategias para el crecimiento del negocio',
    @Departamento = 'Comercial',
    @Responsable = 'Mar�a P�rez',
    @Estado = 1;


CREATE PROCEDURE ActualizarAreaEmpresa
    @AreaID INT, 
    @NombreArea NVARCHAR(100), 
    @Descripcion NVARCHAR(250) = NULL, 
    @Departamento NVARCHAR(100) = NULL, 
    @Responsable NVARCHAR(100) = NULL, 
    @Estado BIT = 1 
AS
BEGIN
   
    BEGIN TRANSACTION;

   
    BEGIN TRY
        UPDATE AreasEmpresa
        SET 
            NombreArea = @NombreArea,
            Descripcion = @Descripcion,
            Departamento = @Departamento,
            Responsable = @Responsable,
            Estado = @Estado
        WHERE AreaID = @AreaID;

      
        COMMIT TRANSACTION;

        PRINT '�rea actualizada exitosamente';
    END TRY
    BEGIN CATCH
       
        ROLLBACK TRANSACTION;

        PRINT 'Error al actualizar el �rea: ' + ERROR_MESSAGE();
    END CATCH
END;

EXEC ActualizarAreaEmpresa 
    @AreaID = 3, 
    @NombreArea = 'Marketing Digital',
    @Descripcion = 'Desarrolla estrategias digitales para marketing y publicidad',
    @Departamento = 'Comercial',
    @Responsable = 'Laura Mart�nez',
    @Estado = 1;

CREATE PROCEDURE LeerAreasEmpresa
    @AreaID INT = NULL, 
    @Estado BIT = NULL 
AS
BEGIN
   
    BEGIN TRY
        SELECT 
            AreaID,
            NombreArea,
            Descripcion,
            Departamento,
            Responsable,
            FechaCreacion,
            Estado
        FROM AreasEmpresa
        WHERE 
            (@AreaID IS NULL OR AreaID = @AreaID) 
            AND (@Estado IS NULL OR Estado = @Estado); 
        
        PRINT 'Consulta realizada exitosamente';
    END TRY
    BEGIN CATCH
        
        PRINT 'Error al realizar la consulta: ' + ERROR_MESSAGE();
    END CATCH
END;

EXEC LeerAreasEmpresa;
EXEC LeerAreasEmpresa @AreaID = 3;
EXEC LeerAreasEmpresa @Estado = 1;
EXEC LeerAreasEmpresa @AreaID = 3, @Estado = 1;

CREATE PROCEDURE CambiarEstadoArea
    @AreaID INT 
AS
BEGIN
   
    BEGIN TRANSACTION;

    
    BEGIN TRY
        
        IF EXISTS (SELECT 1 FROM AreasEmpresa WHERE AreaID = @AreaID AND Estado = 1)
        BEGIN
            
            UPDATE AreasEmpresa
            SET Estado = 0
            WHERE AreaID = @AreaID;

           
            COMMIT TRANSACTION;

            PRINT 'El estado del �rea se ha cambiado a inactivo exitosamente.';
        END
        ELSE
        BEGIN
            
            ROLLBACK TRANSACTION;

            PRINT 'El �rea especificada no existe o ya est� inactiva.';
        END
    END TRY
    BEGIN CATCH
        
        ROLLBACK TRANSACTION;

        
        PRINT 'Error al cambiar el estado del �rea: ' + ERROR_MESSAGE();
    END CATCH
END;

EXEC CambiarEstadoArea @AreaID = 12;

CREATE PROCEDURE EliminarArea2
    @AreaID INT 
AS
BEGIN
    
    BEGIN TRANSACTION;

    
    BEGIN TRY
        
        IF EXISTS (SELECT 1 FROM AreasEmpresa WHERE AreaID = @AreaID AND Estado = 1)
        BEGIN
            
            UPDATE AreasEmpresa
            SET Estado = 0
            WHERE AreaID = @AreaID;

            
            COMMIT TRANSACTION;

            PRINT 'El �rea ha sido marcada como inactiva exitosamente.';
        END
        ELSE
        BEGIN
           
            ROLLBACK TRANSACTION;

            PRINT 'El �rea especificada no existe o ya est� inactiva.';
        END
    END TRY
    BEGIN CATCH
       
        ROLLBACK TRANSACTION;

       
        PRINT 'Error al eliminar el �rea: ' + ERROR_MESSAGE();
    END CATCH
END;


EXEC EliminarArea2 @AreaID = 3; 

---empleados

CREATE PROCEDURE InsertarEmpleado
    @NombreEmpleado NVARCHAR(100),
    @Edad INT,
    @CorreoElectronico NVARCHAR(100),
    @AreaID INT
AS
BEGIN
    
    BEGIN TRANSACTION;

    
    BEGIN TRY
        
        IF EXISTS (SELECT 1 FROM AreasEmpresa WHERE AreaID = @AreaID AND Estado = 1)
        BEGIN
            
            INSERT INTO Empleados (NombreEmpleado, Edad, CorreoElectronico, AreaID)
            VALUES (@NombreEmpleado, @Edad, @CorreoElectronico, @AreaID);

            
            COMMIT TRANSACTION;

            PRINT 'El empleado ha sido insertado exitosamente.';
        END
        ELSE
        BEGIN
            
            ROLLBACK TRANSACTION;

            PRINT 'El �rea especificada no existe o no est� activa.';
        END
    END TRY
    BEGIN CATCH
       
        ROLLBACK TRANSACTION;

        
        PRINT 'Error al insertar el empleado: ' + ERROR_MESSAGE();
    END CATCH
END;

EXEC InsertarEmpleado 
    @NombreEmpleado = 'Carmen Landa', 
    @Edad = 29, 
    @CorreoElectronico = 'carmen.landa@example.com', 
    @AreaID = 10; 


CREATE PROCEDURE LeerEmpleados
AS
BEGIN
    SET NOCOUNT ON; 
    SELECT * FROM Empleados; 
END;

EXEC LeerEmpleados;

CREATE PROCEDURE LeerEmpleadoPorID
    @EmpleadoID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM Empleados
    WHERE EmpleadoID = @EmpleadoID; 
END;

EXEC LeerEmpleadoPorID @EmpleadoID = 10;

CREATE PROCEDURE ActualizarEmpleado
    @EmpleadoID INT,
    @NombreEmpleado NVARCHAR(100),
    @Edad INT,
    @CorreoElectronico NVARCHAR(100),
    @AreaID INT
AS
BEGIN
    SET NOCOUNT ON; 

    UPDATE Empleados
    SET 
        NombreEmpleado = @NombreEmpleado,
        Edad = @Edad,
        CorreoElectronico = @CorreoElectronico,
        AreaID = @AreaID
    WHERE 
        EmpleadoID = @EmpleadoID; 
END;

EXEC ActualizarEmpleado 
    @EmpleadoID = 1, 
    @NombreEmpleado = 'Carlos L�pez P�rez', 
    @Edad = 35, 
    @CorreoElectronico = 'carlos.lopez.perez@example.com', --
    @AreaID = 1; 

CREATE PROCEDURE EliminarEmpleado
    @EmpleadoID INT
AS
BEGIN
    SET NOCOUNT ON; 

    
    ALTER TABLE Empleados NOCHECK CONSTRAINT ALL;

    
    DELETE FROM Empleados
    WHERE EmpleadoID = @EmpleadoID;

    
    ALTER TABLE Empleados CHECK CONSTRAINT ALL;
END;


EXEC EliminarEmpleado 
    @EmpleadoID = 1; 

	
SELECT E.EmpleadoID, E.NombreEmpleado, E.Edad, E.CorreoElectronico, A.NombreArea FROM Empleados E
INNER JOIN AreasEmpresa A ON E.AreaID = A.AreaID;

SELECT * FROM AreasEmpresa;