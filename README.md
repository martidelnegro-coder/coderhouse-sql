# RetailPro — Proyecto de Análisis de Datos Comerciales

**RetailPro** es un proyecto de análisis de datos desarrollado sobre la base **`Ventas_Tech_DB`** en **SQL Server** (SQL Server Management Studio), orientado a responder preguntas clave de negocio, evaluar clientes y productos, consolidar información mediante `JOINs` y `UNION ALL` y preparar bases/vistas para análisis y visualización en **Power BI**.

## Descripción y objetivo del proyecto
El proyecto busca transformar datos transaccionales de ventas en información accionable para el seguimiento comercial y la gestión de catálogo/clientes:
- **Resumen ejecutivo mensual:** seguimiento de facturación total, cantidad de pedidos y ticket promedio por mes.
- **Ranking de productos:** identificación de los productos con mayor facturación y volumen de unidades vendidas.
- **Clientes recurrentes:** detección de clientes con múltiples compras y su gasto acumulado.
- **Rendimiento frente al promedio:** clasificación de productos (`Por encima` / `Por debajo`) respecto del promedio general de facturación por producto.
- **Cruces y consolidados (`JOINs` y `UNION ALL`):** generación de vista base enriquecida (`INNER JOIN`), detección de clientes o productos sin ventas (`LEFT JOIN`) y comparativas consolidadas (`UNION ALL`).

## Base de datos y modelo (`Ventas_Tech_DB`)
La base de datos **`Ventas_Tech_DB`** incluye las siguientes tablas principales bajo el esquema `dbo`:
- `dbo.categorias`
- `dbo.clientes` (incluye `id_cliente`, `nombre`, `email`, `ciudad`, `fecha_registro`)
- `dbo.productos` (incluye `id_producto` PK `int`, `nombre_producto` `varchar(100)`, `id_categoria` FK `int`, `precio` `decimal(10,2)`, `stock` `int`, `activo` `bit`)
- `dbo.ventas` (incluye `id_venta` PK `int`, `fecha_venta`, `id_cliente`, `id_producto`, `cantidad`, `precio_unitario`)

## Herramientas utilizadas
- **SQL Server / T-SQL** y **SQL Server Management Studio (SSMS):** modelado, consulta y validación de datos en `Ventas_Tech_DB`.
- **Git / GitHub:** control de versiones y documentación del repositorio.
- **Power BI:** consumo de datos y vistas orientadas a tableros y reportes analíticos.

## Estructura del repositorio
- `m4_consultas_negocio.sql`: consultas de negocio (resumen ejecutivo mensual, top 5 de productos por facturación, clientes recurrentes y rendimiento de productos frente al promedio).
- `m5_consultas_joins.sql`: consultas con `INNER JOIN` (vista base), `LEFT JOIN` (clientes y productos sin ventas) y `UNION ALL` (consolidado por canal simulado).
- `README.md`: documentación general del proyecto, modelo, archivos y guía de ejecución.

## Cómo ejecutar los scripts SQL en orden
1. Abrí **SQL Server Management Studio (SSMS)** y conectate a tu instancia de **SQL Server**.
2. Verificá que exista la base de datos **`Ventas_Tech_DB`** con las tablas `dbo.categorias`, `dbo.clientes`, `dbo.productos` y `dbo.ventas`.
3. Abrí y ejecutá **`m4_consultas_negocio.sql`** (contiene `USE Ventas_Tech_DB;`) para obtener el resumen mensual, el top 5 de productos, los clientes recurrentes y el análisis frente al promedio.
4. Abrí y ejecutá **`m5_consultas_joins.sql`** (contiene `USE Ventas_Tech_DB;`) para ejecutar la consulta base con `INNER JOIN`, los controles con `LEFT JOIN` y el consolidado con `UNION ALL`.

## Principales hallazgos y consideraciones técnicas
- En la corrida actual de `m4_consultas_negocio.sql` se observa el mes `3` con `6444.00` de facturación total, `10` pedidos y `644.400000` de ticket promedio, con fuerte aporte de facturación en los `id_producto` `1` (`3600.00` en `3` unidades) y `3` (`1350.00` en `3` unidades), mientras el `id_producto` `2` destaca en unidades (`13`) con `364.00` facturados, y los clientes `1` a `5` registran `2` pedidos cada uno.
- En `m5_consultas_joins.sql`, los controles con `LEFT JOIN` muestran sin registros faltantes en la base actual y el consolidado con `UNION ALL` separa por reglas de cantidad (`cantidad > 1` como `'Online'` y `cantidad = 1` como `'Presencial'`), lo que corresponde a una simulación del ejercicio y no a un campo real de canal de venta.
