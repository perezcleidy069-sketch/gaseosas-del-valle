
# gaseosas-del-valle-s.a.

# Sistema de Gestión de Base de Datos - Gaseosas del Valle S.A.

## Descripción del Proyecto
**Gaseosas del Valle S.A.** es una empresa distribuidora autorizada de bebidas gaseosas con sede principal en Girón y en planes de expansión hacia Bucaramanga y Piedecuesta. 

El objetivo principal de este proyecto es migrar la gestión de inventario y ventas desde hojas de cálculo hacia un **Sistema de Base de Datos Relacional en MySQL**. Esta solución elimina la pérdida de datos y falta de trazabilidad, automatizando el control de stock, auditorías de precios y cálculos de impuestos.

---

## Modelo Entidad-Relación (E-R)

El modelo soporta relaciones 1:N y N:N (mediante la tabla intermedia `detalle_pedidos`):

```mermaid
erDiagram
    DEPARTAMENTOS ||--|{ MUNICIPIOS : "contiene"
    MUNICIPIOS ||--|{ CLIENTES : "ubica"
    MUNICIPIOS ||--|{ SEDES : "ubica"
    ENCARGADOS ||--|| SEDES : "dirige"
    CATEGORIA ||--|{ PRODUCTOS : "agrupa"
    PRODUCTOS ||--|{ AUDITORIA_PRECIOS : "registra"
    CLIENTES ||--|{ PEDIDOS : "realiza"
    SEDES ||--|{ PEDIDOS : "despacha"
    PEDIDOS ||--|{ DETALLE_PEDIDOS : "contiene"
    PRODUCTOS ||--|{ DETALLE_PEDIDOS : "incluye"
