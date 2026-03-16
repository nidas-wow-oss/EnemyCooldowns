# Enemy Cooldowns — Enhanced Edition

**Author:** Nidhaus  
**Game:** World of Warcraft 3.3.5a (WotLK)  
**Server:** Warmane Blackrock  

---

## About

Addon de PvP que trackea los cooldowns enemigos en tiempo real. Tomé como base el addon original **Enemy Cooldowns** y lo rehice casi por completo: corregí bugs, reescribí el core, y agregué un menú de configuración completo que el original no tenía.

---

## Features

- Trackea cooldowns de todas las clases (raciales, trinkets, defensivos, interrupts, CC, movilidad)
- Maneja resets de cooldowns (Preparation, Cold Snap, Metamorphosis)
- Menú de configuración in-game (`/ecd`) con tema azul y sliders estilo NUF
- Layout configurable: iconos por columna, espaciado X/Y, separación entre grupos, escala global
- Fuentes configurables para nombres y timers (con outline y tamaño)
- Colores por tiempo restante (>10s, ≤10s, ≤3s) con color picker
- Orden de cooldowns: por uso reciente, tiempo restante ascendente/descendente
- Activar/desactivar por zona: Arena, Battleground, Mundo
- Toggle de cooldown swipe overlay
- Botón Reset All que restaura todo a defaults sin necesidad de /reload
- Localización: inglés por defecto, español incluido (auto-detecta el cliente)
- Limpieza automática de memoria (GUIDs inactivos)

---

## Comandos

| Comando | Qué hace |
|---------|----------|
| `/ecd` | Abrir configuración |
| `/ecd lock` | Bloquear posición |
| `/ecd unlock` | Desbloquear y mostrar handle |
| `/ecd reset` | Resetear posición |
| `/ecd resetall` | Resetear TODA la configuración |

---

## Instalación

Copiar la carpeta `EnemyCooldowns` en `Interface/AddOns/` y reiniciar el juego.

---

## Créditos

- **Base:** Enemy Cooldowns (autor original desconocido)
- **Enhanced edition:** Nidhaus
