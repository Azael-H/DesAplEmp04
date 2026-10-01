USE Neptuno
GO

CREATE OR ALTER PROCEDURE dbo.usp_Productos_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idproducto,
           nombreProducto,
           idProveedor,
           idCategoria,
           cantidadPorUnidad,
           precioUnidad,
           unidadesEnExistencia,
           unidadesEnPedido,
           nivelNuevoPedido,
           suspendido,
           categoriaProducto
    FROM dbo.productos
    ORDER BY idproducto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Categorias_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idcategoria,
           nombrecategoria,
           descripcion,
           Activo,
           CodCategoria
    FROM dbo.categorias
    ORDER BY idcategoria;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Proveedores_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT *
    FROM dbo.proveedores
    ORDER BY idProveedor;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Proveedores_BuscarPorContactoCiudad
    @nombrecontacto VARCHAR(30) = '',
    @ciudad VARCHAR(15) = ''
AS
BEGIN
    SET NOCOUNT ON;
    SELECT *
    FROM dbo.proveedores
    WHERE ISNULL(nombrecontacto, '') LIKE '%' + ISNULL(@nombrecontacto, '') + '%'
      AND ISNULL(ciudad, '') LIKE '%' + ISNULL(@ciudad, '') + '%'
    ORDER BY idProveedor;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_DetallesPedidos_PorFechas
    @fechaInicio DATE,
    @fechaFin DATE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT d.idpedido,
           p.FechaPedido,
           p.IdCliente,
           d.idproducto,
           d.preciounidad,
           d.cantidad,
           d.descuento,
           d.preciounidad * d.cantidad AS subtotal
    FROM dbo.detallesdepedidos d
    INNER JOIN dbo.Pedidos p ON d.idpedido = p.IdPedido
    WHERE p.FechaPedido BETWEEN @fechaInicio AND @fechaFin
    ORDER BY p.FechaPedido, d.idpedido;
END
GO
