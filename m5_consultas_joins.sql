-- ==========================================================
-- PRE-ENTREGA 5: Consultas con JOINs y UNION ALL - Proyecto RetailPro
-- ==========================================================

-- Indicamos la base de datos con la que trabajamos
USE Ventas_Tech_DB;
GO

-- ----------------------------------------------------------
-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Propósito: Combinar las tablas principales para generar una vista enriquecida 
-- orientada a la fuente de datos principal del dashboard en Power BI.
-- ----------------------------------------------------------
SELECT 
    v.fecha_venta,
    v.id_venta,
    c.id_cliente,
    c.nombre,
    p.nombre_producto,
    p.id_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto;

-- ----------------------------------------------------------
-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Propósito: Detectar clientes registrados que nunca han realizado compras, para que CRM los contacte.
-- ----------------------------------------------------------
SELECT 
    c.id_cliente,
    c.nombre,
    c.email,       
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v 
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: No hay clientes registrados en la base que todavía no hayan concretado una transacción.

-- ---------------------------------------------------------
-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Propósito: Identificar artículos del catálogo que no tienen movimiento de ventas,
-- para que se puedan tomar decisiones respecto al stock.
-- ----------------------------------------------------------
SELECT 
    p.id_producto,
    p.nombre_producto,
    p.id_categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v 
    ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

-- Hallazgo: todos los productos tienen movimientos de venta. 

-- ----------------------------------------------------------
-- Consulta 4 — Consolidado por canal (UNION ALL)
-- Propósito: Simular y comparar el volumen de ventas entre dos canales 
-- utilizando columnas literales de texto generadas manualmente.
-- ----------------------------------------------------------
SELECT 
        canal, 
        SUM(total) AS total_canal
FROM (
    SELECT 
        fecha_venta, 
        cantidad * precio_unitario AS total, 
        'Online' AS canal
    FROM ventas 
    WHERE cantidad > 1 

    UNION ALL
    
    SELECT 
            fecha_venta, 
            cantidad * precio_unitario AS total, 
            'Presencial' AS canal
    FROM ventas 
    WHERE cantidad = 1
) AS consolidado
GROUP BY canal;

-- Hallazgo: El canal online concentra la mayor parte de la facturación total (4.674 frente a 1.770 del presencial), 
-- lo que indica una fuerte preferencia de los clientes por las compras digitales.