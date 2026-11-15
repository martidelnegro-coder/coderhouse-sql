-- ==========================================================
-- PRE-ENTREGA 4: Consultas SQL de negocio - Proyecto RetailPro
-- ==========================================================

-- Indicamos explícitamente la base de datos en la que trabajamos (según tu SSMS)
USE Ventas_Tech_DB;
GO

-- ----------------------------------------------------------
-- Consulta 1 — Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio agrupados por mes.
-- ----------------------------------------------------------
SELECT 
		MONTH(fecha_venta) AS mes,
		SUM(cantidad*precio_unitario) AS total_facturado,
		COUNT(id_venta) AS cantidad_pedidos,
		AVG(cantidad*precio_unitario) AS ticket_promedio
FROM Ventas
GROUP BY MONTH(fecha_venta);

-- ----------------------------------------------------------
-- Consulta 2 — Ranking de productos
-- ----------------------------------------------------------
SELECT TOP 5
		id_producto,
		SUM(cantidad) AS total_unidades_vendidas,
		SUM(Cantidad*precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- ----------------------------------------------------------
-- Consulta 3 — Clientes recurrentes
-- ----------------------------------------------------------
SELECT 
		id_cliente,
		COUNT(id_venta) AS cantidad_pedidos,
		SUM(cantidad*precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(id_venta)>1;

-- ----------------------------------------------------------
-- Consulta 4 — Productos por encima/por debajo del promedio
-- ----------------------------------------------------------
WITH FacturacionPorProducto AS (
	SELECT
		id_producto,
		SUM(cantidad*precio_unitario) AS total_facturado_producto
		FROM ventas
		GROUP BY id_producto
),
PromedioGeneral AS (
	SELECT AVG(total_facturado_producto) AS promedio_total
	FROM FacturacionPorProducto
)
SELECT 
	f.id_producto,
	f.total_facturado_producto,
	CASE 
		WHEN f.total_facturado_producto > p.promedio_total THEN 'Por encima'
		ELSE 'Por debajo'
	END AS rendimiento_producto
FROM FacturacionPorProducto f
CROSS JOIN PromedioGeneral p;

-- ==========================================================
-- BLOQUE DE CIERRE: 3 Hallazgos concretos del negocio
-- ==========================================================
/*
   1. La facturación total se concentra fuertemente en un grupo reducido de productos destacados en el ranking, traccionando el ticket promedio mensual.
   2. Se evidencian clientes recurrentes con múltiples transacciones, lo que marca métricas interesantes de fidelización en el canal comercial.
   3. Existe una marcada brecha comercial entre los artículos de mayor rotación y aquellos que quedan por debajo del promedio de facturación, lo que sugiere revisar la estrategia de stock y ofertas.
*/