local _, engine = ...

local locale = GetLocale()
if locale ~= "esES" and locale ~= "esMX" then return end

local L = engine.L

-- Mensajes del addon
L["ADDON_LOADED"]       = "|cff4fc3f7[Enemy Cooldowns]|r Cargado! Usa /ecd"
L["ADDON_ENABLED"]      = "|cff4fc3f7[Enemy Cooldowns]|r Activado"
L["ADDON_DISABLED"]     = "|cff4fc3f7[Enemy Cooldowns]|r Desactivado"
L["FRAME_LOCKED"]       = "|cff4fc3f7[Enemy Cooldowns]|r Frame bloqueado"
L["FRAME_UNLOCKED"]     = "|cff4fc3f7[Enemy Cooldowns]|r Frame desbloqueado - Arrastra para mover"
L["POSITION_RESET"]     = "|cff4fc3f7[Enemy Cooldowns]|r Posicion reseteada"

-- Ayuda de comandos
L["CMD_HEADER"]         = "|cff4fc3f7[Enemy Cooldowns]|r Comandos:"
L["CMD_CONFIG"]         = "  /ecd config - Abrir configuracion"
L["CMD_LOCK"]           = "  /ecd lock - Bloquear frame"
L["CMD_UNLOCK"]         = "  /ecd unlock - Desbloquear frame"
L["CMD_RESET"]          = "  /ecd reset - Resetear posicion"
L["CMD_TEST"]           = "  /ecd test - Activar/desactivar modo test (30 cooldowns de prueba)"
L["TEST_MODE_BTN"]      = "Modo Test"
L["FIXED_GROUPS"]       = "Posiciones fijas"
L["FIXED_GROUPS_TIP"]   = "Mantiene el grupo de cooldowns de cada enemigo en su lugar al cambiar de target (sin reordenar)."
L["TEST_ON"]            = "|cff4fc3f7[Enemy Cooldowns]|r Modo test ACTIVADO"
L["TEST_OFF"]           = "|cff4fc3f7[Enemy Cooldowns]|r Modo test DESACTIVADO"

-- Titulos de secciones (sin color codes, config.lua aplica SetTextColor)
L["CONFIG_TITLE"]       = "Enemy Cooldowns"
L["SECTION_POSITION"]   = "Posicion del Frame"
L["SECTION_LAYOUT"]     = "Layout"
L["SECTION_PLAYER_NAME"]= "Fuente de Nombres"
L["SECTION_TIMER"]      = "Temporizadores"
L["SECTION_ZONES"]      = "Activar en:"

-- Botones
L["LOCK_FRAME"]         = "Bloquear Frame"
L["UNLOCK_FRAME"]       = "Desbloquear Frame"
L["RESET_POSITION"]     = "Resetear Posicion"
L["RESET_ALL"]          = "Resetear Todo"
L["ALL_RESET"]          = "Configuracion reseteada a valores por defecto"
L["CMD_RESETALL"]       = "  /ecd resetall - Resetear toda la configuracion"

-- Checkboxes
L["SHOW_ENEMY_NAMES"]   = "Mostrar nombres de enemigos"
L["COLOR_BY_TIME"]      = "Color segun tiempo restante"
L["SHOW_CD_SWIPE"]      = "Mostrar reloj de cooldown"

-- Labels
L["FONT"]               = "Fuente:"
L["STYLE"]              = "Estilo:"
L["CD_SORT_ORDER"]      = "Orden:"

-- Sliders (NUF-style: titulo centrado, valor se muestra aparte debajo)
L["ICONS_PER_COLUMN"]   = "Iconos / Columna"
L["ICON_SPACING"]       = "Espacio Y"
L["COLUMN_SPACING"]     = "Espacio X"
L["GROUP_SPACING"]      = "Espacio Grupo"
L["SCALE"]              = "Escala"
L["FONT_SIZE"]          = "Tam. Fuente"

-- Color pickers
L["COLOR_NORMAL"]       = "Normal (>10s):"
L["COLOR_WARNING"]      = "Alerta (<=10s):"
L["COLOR_URGENT"]       = "Urgente (<=3s):"

-- Zonas
L["ZONE_ARENA"]         = "Arena"
L["ZONE_BATTLEGROUND"]  = "Battleground"
L["ZONE_WORLD"]         = "Mundo"

-- Modos de orden
L["SORT_CAST"]          = "Orden de uso (reciente)"
L["SORT_REMAIN_ASC"]    = "Restante (menor a mayor)"
L["SORT_REMAIN_DESC"]   = "Restante (mayor a menor)"

-- Misc
L["UNKNOWN"]            = "Desconocido"