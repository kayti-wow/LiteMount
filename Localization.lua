--[[----------------------------------------------------------------------------

  LiteMount/Localization.lua

  LiteMount translations into other languages.

  Copyright 2011-2020 Mike Battersby

----------------------------------------------------------------------------]]--

local _, LM = ...

--@debug@
if LibDebug then LibDebug() end
--@end-debug@

-- Vim reformatter from curseforge "Global Strings" export.
-- %s/^\(L\..*\) = \(.*\)/\=printf('%-24s= %s', submatch(1), submatch(2))/

LM.Localize = setmetatable({ }, {__index=function (t,k) return k end})

local L = LM.Localize

local locale = GetLocale()

-- Automatic / Blizzard --------------------------------------------------------

L.CUSTOM1               = CUSTOM .. " 1"
L.CUSTOM2               = CUSTOM .. " 2"
L.FAVORITES             = FAVORITES
L.LM_PRIORITY_DESC0     = NEVER


-- :r! sh fetchlocale.sh -------------------------------------------------------

-- enUS / enGB / Default -------------------------------------------------------

L.FLOAT                 = "Float"
L.FLY                   = "Fly"
L.LM_ADVANCED_EXP       = "These settings allow you to customize the actions run by each of the LiteMount key bindings. Please read the documentation at the URL below before changing anything."
L.LM_AUTHOR             = "Author"
L.LM_COMBAT_MACRO_EXP   = "If enabled, this macro will be run instead of the default combat actions if LiteMount is activated while you are combat."
L.LM_COPY_TARGETS_MOUNT = "Try to copy target's mount."
L.LM_CURRENT_SETTINGS   = "Current Settings"
L.LM_DEBUGGING_DISABLED = "Debugging disabled."
L.LM_DEBUGGING_ENABLED  = "Debugging enabled."
L.LM_DEFAULT_SETTINGS   = "Default Settings"
L.LM_DELETE_FLAG        = "Delete Flag"
L.LM_DELETE_PROFILE     = "Delete Profile"
L.LM_DISABLE_NEW_MOUNTS = "Automatically disable newly added mounts."
L.LM_DISABLING_MOUNT    = "Disabling active mount: %s"
L.LM_ENABLE_DEBUGGING   = "Enable debugging messages."
L.LM_ENABLING_MOUNT     = "Enabling active mount: %s"
L.LM_ERR_BAD_ACTION     = "Bad action '%s' in action list."
L.LM_ERR_BAD_CONDITION  = "Bad condition '%s' in action list."
L.LM_EVERY_D_MINUTES    = "Every %d minutes"
L.LM_EVERY_D_SECONDS    = "Every %d seconds"
L.LM_EVERY_TIME         = "Every time"
L.LM_EXPORT_PROFILE     = "Export Profile"
L.LM_EXPORT_PROFILE_EXP = "Cut-and-paste the text below into a file to save this profile. You can restore it again with 'Import Profile'."
L.LM_FLAGS              = "Flags"
L.LM_HELP_TRANSLATE     = "Help translate LiteMount into your language. Thank you."
L.LM_HIDDEN             = "Hidden"
L.LM_IMPORT_PROFILE     = "Import Profile"
L.LM_IMPORT_PROFILE_EXP = "Paste a previously exported profile into the box below to import it as the entered name."
L.LM_MACRO_EXP          = "This macro will be run if LiteMount is unable to find a usable mount. This might be because you are indoors, or are moving and don't know any instant-cast mounts."
L.LM_NEW_FLAG           = "New Flag"
L.LM_NEW_PROFILE        = "New Profile"
L.LM_PRIORITY           = "Priority"
L.LM_PRIORITY_DESC1     = "Normal"
L.LM_PRIORITY_DESC2     = "More often"
L.LM_PRIORITY_DESC3     = "A lot more often"
L.LM_PROFILES           = "Profiles"
L.LM_RANDOM_PERSISTENCE = "How often to select a new random mount"
L.LM_RENAME_FLAG        = "Rename Flag"
L.LM_REPORT_BUG         = "Report Bug"
L.LM_REPORT_BUG_EXP     = "To report a bug in LiteMount, please describe the bug at the top of the field below, then cut-and-paste the entire text into the Create Issue form at this URL:"
L.LM_RESET_PROFILE      = "Reset Profile"
L.LM_SETTINGS_TAGLINE   = "Simple and reliable random mount summoning."
L.LM_TRANSLATORS        = "Translators"
L.LM_WARN_REPLACE_COND  = "The [%s] action list condition has been replaced by [%s] due to Blizzard changes."
L.RUN                   = "Run"
L.SWIM                  = "Swim"
L.WALK                  = "Walk"

-- deDE ------------------------------------------------------------------------

if locale == "deDE" then
L.FLOAT                 = "Wasserwandeln"
L.FLY                   = "Fliegen"
L.LM_ADVANCED_EXP       = "Mit diesen Einstellungen können Sie die Aktionen anpassen, die von den einzelnen LiteMount-Tastenbindungen ausgeführt werden. Bitte lesen Sie die Dokumentation unter der folgenden URL, bevor Sie etwas ändern."
L.LM_AUTHOR             = "Autor"
L.LM_COMBAT_MACRO_EXP   = "Bei Aktivierung wird dieses Makro anstelle von normalen Kampfhandlungen benutzt, wenn LiteMount im Kampf verwendet wird."
L.LM_COPY_TARGETS_MOUNT = "Versuche, das Reittier deines Ziels zu kopieren."
L.LM_CURRENT_SETTINGS   = "Aktuelle Einstellungen"
L.LM_DEBUGGING_DISABLED = "Fehlersuche aus"
L.LM_DEBUGGING_ENABLED  = "Fehlersuche ein"
L.LM_DEFAULT_SETTINGS   = "Standardeinstellungen"
L.LM_DELETE_FLAG        = "Markierung löschen"
L.LM_DELETE_PROFILE     = "Profil löschen"
L.LM_DISABLE_NEW_MOUNTS = "Deaktiviere automatisch im Reittierführer neu entdeckte (aber noch nicht erlernte) Reittiere."
L.LM_DISABLING_MOUNT    = "Deaktiviere aktuelles Reittier: %s"
L.LM_ENABLE_DEBUGGING   = "Debug-Meldungen aktivieren."
L.LM_ENABLING_MOUNT     = "Aktiviere aktuelles Reittier: %s"
L.LM_ERR_BAD_ACTION     = "Schlechte Aktion '%s' in der Aktionsliste."
L.LM_ERR_BAD_CONDITION  = "Schlechte Bedingung '%s' in der Aktionsliste."
L.LM_EVERY_D_MINUTES    = "alle %d Minuten"
L.LM_EVERY_D_SECONDS    = "alle %d Sekunden"
L.LM_EVERY_TIME         = "jedes Mal"
L.LM_FLAGS              = "Markierungen"
L.LM_HELP_TRANSLATE     = "Hilf dabei, LiteMount in deine Sprache zu übersetzen. Danke."
L.LM_HIDDEN             = "Versteckt"
L.LM_MACRO_EXP          = "Dieses Makro wird ausgeführt, wenn LiteMount kein nutzbares Reittier findet. Dies kann passieren, wenn du dich in Gebäuden aufhältst oder läufst und keine spontan wirkbaren Reittiere hast."
L.LM_NEW_FLAG           = "Markierung hinzufügen"
L.LM_NEW_PROFILE        = "Neues Profil"
L.LM_PRIORITY           = "Priorität"
L.LM_PRIORITY_DESC1     = "Normal"
L.LM_PRIORITY_DESC2     = "Öfter"
L.LM_PRIORITY_DESC3     = "Viel öfter"
L.LM_PROFILES           = "Profile"
L.LM_RANDOM_PERSISTENCE = "Wie oft soll ein neues zufälliges Reittier ausgewählt werden"
L.LM_RENAME_FLAG        = "Markierung umbenennen"
L.LM_REPORT_BUG         = "Bug melden"
L.LM_RESET_PROFILE      = "Profil zurücksetzen"
L.LM_SETTINGS_TAGLINE   = "Einfaches und zuverlässiges Beschwören von zufälligen Reittieren."
L.LM_TRANSLATORS        = "Übersetzer"
L.LM_WARN_REPLACE_COND  = "Die Bedingung der [%s] -Aktionsliste wurde aufgrund von Blizzard-Änderungen durch [%s] ersetzt."
L.RUN                   = "Rennen"
L.SWIM                  = "Schwimmen"
L.WALK                  = "Laufen"
end

-- esES / esMX -----------------------------------------------------------------

if locale == "esES" or locale == "esMX" then
L.FLOAT                 = "Flotador"
L.FLY                   = "Volar"
L.LM_ADVANCED_EXP       = "Estas configuraciones le permiten personalizar las acciones ejecutadas por cada uno de los acciones clave de LiteMount. Lea la documentación en la URL a continuación antes de cambiar cualquier cosa."
L.LM_AUTHOR             = "Auto"
L.LM_COMBAT_MACRO_EXP   = "Si está habilitado, esta macro se ejecutará en lugar de las acciones de combate predeterminadas si LiteMount se activa mientras estás en combate."
L.LM_COPY_TARGETS_MOUNT = "Intenta copiar la montura del objetivo."
L.LM_CURRENT_SETTINGS   = "Configuraciones actuales"
L.LM_DEBUGGING_DISABLED = "Depuración desactivada."
L.LM_DEBUGGING_ENABLED  = "Depuración activada."
L.LM_DEFAULT_SETTINGS   = "Configuración por defecto"
L.LM_DELETE_FLAG        = "Borrar un marbete"
L.LM_DELETE_PROFILE     = "Borrar un perfil"
L.LM_DISABLE_NEW_MOUNTS = "Deshabilitar automáticamente las monturas recién agregados."
L.LM_DISABLING_MOUNT    = "Desactivar la montura activa: %s"
L.LM_ENABLE_DEBUGGING   = "Activar los mensajes de depuración."
L.LM_ENABLING_MOUNT     = "Activando el montaje activo: %s"
L.LM_ERR_BAD_ACTION     = "Mala acción '%s' en la lista de acciones."
L.LM_ERR_BAD_CONDITION  = "Mala estado '%s' en la lista de acciones."
L.LM_EVERY_D_MINUTES    = "Cada %d minutos"
L.LM_EVERY_D_SECONDS    = "Cada %d segundos"
L.LM_EVERY_TIME         = "Cada vez"
L.LM_FLAGS              = "Marbetes"
L.LM_HELP_TRANSLATE     = "Ayuda a traducir LiteMount a tu idioma. Gracias."
L.LM_HIDDEN             = "Ocultada"
L.LM_MACRO_EXP          = "Esta macro se ejecutará si LiteMount no puede encontrar una montura utilizable. Esto podría deberse a que está en el interior, o se está moviendo, y no conoce ningún montaje instantáneo."
L.LM_NEW_FLAG           = "Crear un marbete"
L.LM_NEW_PROFILE        = "Crear un perfil"
L.LM_PRIORITY           = "Prioridad"
L.LM_PRIORITY_DESC1     = "Normal"
L.LM_PRIORITY_DESC2     = "Más a menudo"
L.LM_PRIORITY_DESC3     = "Mucho más a menudo"
L.LM_PROFILES           = "Perfiles"
L.LM_RANDOM_PERSISTENCE = "Con qué frecuencia seleccionar una nueva montura aleatoria"
L.LM_RENAME_FLAG        = "Cambiar un marbete"
L.LM_REPORT_BUG         = "Informar un error"
L.LM_RESET_PROFILE      = "Reiniciar perfil"
L.LM_SETTINGS_TAGLINE   = "Invocación de monturas aleatorio simple y confiable."
L.LM_TRANSLATORS        = "Traductores"
L.LM_WARN_REPLACE_COND  = "La condición de la lista de acciones [%s] ha sido reemplazada por [%s] debido a los cambios de Blizzard."
L.RUN                   = "Correr"
L.SWIM                  = "Nadar"
L.WALK                  = "Caminar"
end

-- frFR ------------------------------------------------------------------------

if locale == "frFR" then
L.FLOAT                 = "Flotte"
L.FLY                   = "Vol"
L.LM_ADVANCED_EXP       = "Ces paramètres vous permettent de customiser les actions lancées par chacun des raccourcis de LiteMount. Veillez à lire la documentation jointe à l’URL ci-dessous avant de changer quoique ce soit."
L.LM_AUTHOR             = "Auteur"
L.LM_COMBAT_MACRO_EXP   = "Si cochée, cette macro sera lancée à la place de l'action de combat par défaut si LiteMount est actif lorsque vous êtes en combat."
L.LM_COPY_TARGETS_MOUNT = "Essaye de copier la monture de la cible."
L.LM_CURRENT_SETTINGS   = "Réglages actuels"
L.LM_DEBUGGING_DISABLED = "Débogage désactivé."
L.LM_DEBUGGING_ENABLED  = "Débogage activé."
L.LM_DEFAULT_SETTINGS   = "Réglages par défaut"
L.LM_DELETE_FLAG        = "Supprimer le Tag"
L.LM_DELETE_PROFILE     = "Effacer le profil"
L.LM_DISABLE_NEW_MOUNTS = "Désactive automatiquement les montures nouvellement ajoutées."
L.LM_DISABLING_MOUNT    = "Désactivation de la monture courante: %s"
L.LM_ENABLE_DEBUGGING   = "Activer les messages de débogage."
L.LM_ENABLING_MOUNT     = "Activation de la monture courante: %s"
L.LM_ERR_BAD_ACTION     = "Mauvaise action '%s' dans la liste d'actions."
L.LM_ERR_BAD_CONDITION  = "Mauvaise condition '%s' dans la liste des actions."
L.LM_EVERY_D_MINUTES    = "Toutes les %d minutes"
L.LM_EVERY_D_SECONDS    = "Toutes les %d secondes"
L.LM_EVERY_TIME         = "À chaque fois"
L.LM_EXPORT_PROFILE     = "Exporter un profil"
L.LM_EXPORT_PROFILE_EXP = "Coupez-collez le texte ci-dessous dans un fichier pour enregistrer ce profil. Vous pouvez le restaurer à nouveau avec «Importer un profil»."
L.LM_FLAGS              = "Tags"
L.LM_HELP_TRANSLATE     = "Aidez a traduire LiteMount dans votre langue. Merci."
L.LM_HIDDEN             = "Masquée"
L.LM_IMPORT_PROFILE     = "Importer un profil"
L.LM_IMPORT_PROFILE_EXP = "Collez un profil précédemment exporté dans la case ci-dessous pour l'importer sous le nom saisi."
L.LM_MACRO_EXP          = "Cette macro sera exécutée si LiteMount ne trouve pas de monture utilisable. Cela peut arriver si vous êtes en intérieur, ou si vous bougez et n'avez pas de monture instantanée."
L.LM_NEW_FLAG           = "Nouveau Tag"
L.LM_NEW_PROFILE        = "Créer un profil"
L.LM_PRIORITY           = "Priorité"
L.LM_PRIORITY_DESC1     = "Normal"
L.LM_PRIORITY_DESC2     = "Plus souvent"
L.LM_PRIORITY_DESC3     = "Beaucoup plus souvent"
L.LM_PROFILES           = "Profils"
L.LM_RANDOM_PERSISTENCE = "À quelle fréquence sélectionner une nouvelle monture aléatoire"
L.LM_RENAME_FLAG        = "Renommer le Tag"
L.LM_REPORT_BUG         = "Signaler un bug"
L.LM_RESET_PROFILE      = "Réinitialiser le profil"
L.LM_SETTINGS_TAGLINE   = "Invocation simple et fiable de monture aléatoire."
L.LM_TRANSLATORS        = "Traducteurs"
L.LM_WARN_REPLACE_COND  = "La condition de la liste d'actions [%s] a été remplacée par [%s] en raison de changements de Blizzard."
L.RUN                   = "Cours"
L.SWIM                  = "Nage"
L.WALK                  = "Marche"
end

-- itIT ------------------------------------------------------------------------

if locale == "itIT" then
L.FLOAT                 = "Float"
L.FLY                   = "Vola"
L.LM_ADVANCED_EXP       = "Queste impostazioni consentono di personalizzare le azioni di ciascun binding di chiavi LiteMount.\" Leggere la documentazione all'URL sottostante prima di modificare qualsiasi cosa."
L.LM_AUTHOR             = "Autore"
L.LM_COMBAT_MACRO_EXP   = "Se abilitato, questa macro verrà eseguita al posto delle azioni di combattimento predefinite se LiteMount viene attivato mentre sei in combattimento."
L.LM_COPY_TARGETS_MOUNT = "Prova a copiare la cavalcatura del bersaglio."
L.LM_CURRENT_SETTINGS   = "Impostazioni attuali"
L.LM_DEBUGGING_DISABLED = "Debug disabilitato."
L.LM_DEBUGGING_ENABLED  = "Debug abilitato."
L.LM_DEFAULT_SETTINGS   = "Impostazioni predefinite"
L.LM_DELETE_FLAG        = "Cancella un'etichetta"
L.LM_DELETE_PROFILE     = "Cancella un Profilo"
L.LM_DISABLE_NEW_MOUNTS = "Disattiva automaticamente i cavalcature appena aggiunti."
L.LM_DISABLING_MOUNT    = "Disabilitazione del cavalcatura attivo: %s"
L.LM_ENABLE_DEBUGGING   = "Attiva messaggi di debug."
L.LM_ENABLING_MOUNT     = "Abilitazione del cavalcatura attivo: %s"
L.LM_ERR_BAD_ACTION     = "Azione non valida '%s' nella lista di azioni."
L.LM_ERR_BAD_CONDITION  = "Cattiva condizione '%s' nella lista di azioni."
L.LM_EVERY_D_MINUTES    = "Ogni %d minuti"
L.LM_EVERY_D_SECONDS    = "Ogni %d secondi"
L.LM_EVERY_TIME         = "Ogni volta"
L.LM_FLAGS              = "Etichette"
L.LM_HELP_TRANSLATE     = "Aiuta a tradurre LiteMount nella tua lingua. Grazie."
L.LM_HIDDEN             = "Nascosta"
L.LM_MACRO_EXP          = "Questa macro verrà eseguita se LiteMount non riesce a trovare un cavalcatura utilizzabile. Ciò potrebbe essere dovuto al fatto che sei al chiuso o ti stai muovendo e non conosci alcun cavalcature istantaneo."
L.LM_NEW_FLAG           = "Crea un'etichetta"
L.LM_NEW_PROFILE        = "Crea un profilo"
L.LM_PRIORITY           = "Priorità"
L.LM_PRIORITY_DESC1     = "Normale"
L.LM_PRIORITY_DESC2     = "Più spesso"
L.LM_PRIORITY_DESC3     = "Molto più spesso"
L.LM_PROFILES           = "Profili"
L.LM_RANDOM_PERSISTENCE = "Quante volte selezionare un nuovo cavalcature casuale"
L.LM_RENAME_FLAG        = "Rinominare un'etichetta"
L.LM_REPORT_BUG         = "Segnala errore"
L.LM_RESET_PROFILE      = "Reimposta Profilo"
L.LM_SETTINGS_TAGLINE   = "Evoca a cavalcatura casuale semplice e affidabile."
L.LM_TRANSLATORS        = "Traduttore"
L.LM_WARN_REPLACE_COND  = "Il [s%] condizione lista di azioni è stata sostituita da [%s] a causa di cambiamenti Blizzard."
L.RUN                   = "Esegui"
L.SWIM                  = "Swim"
L.WALK                  = "Cammina"
end

-- koKR ------------------------------------------------------------------------

if locale == "koKR" then
L.FLOAT                 = "수면 보행"
L.FLY                   = "비행"
L.LM_ADVANCED_EXP       = "이 설정을 통해 각 LiteMount 키 바인딩이 실행하는 작업을 사용자 정의 할 수 있습니다. 아무 것도 변경하기 전에 아래 URL의 설명서를 읽어보십시오."
L.LM_AUTHOR             = "저자"
L.LM_COMBAT_MACRO_EXP   = "활성화하면 당신이 전투 중일때 LiteMount가 활성화되면 기본 전투 행동 대신 이 매크로가 실행됩니다."
L.LM_COPY_TARGETS_MOUNT = "대상의 탈것을 따라하도록 시도합니다."
L.LM_CURRENT_SETTINGS   = "현재 설정"
L.LM_DEBUGGING_DISABLED = "디버깅이 비활성화되었습니다."
L.LM_DEBUGGING_ENABLED  = "디버깅이 활성화되었습니다."
L.LM_DEFAULT_SETTINGS   = "기본 설정"
L.LM_DELETE_FLAG        = "조건 삭제"
L.LM_DELETE_PROFILE     = "프로필 삭제"
L.LM_DISABLE_NEW_MOUNTS = "새로 추가된 탈것을 자동으로 비활성합니다."
L.LM_DISABLING_MOUNT    = "현재 탈것 비활성: %s"
L.LM_ENABLE_DEBUGGING   = "디버깅 메시지를 출력합니다."
L.LM_ENABLING_MOUNT     = "현재 탈것 활성화: %s"
L.LM_ERR_BAD_ACTION     = "작업 목록의 작업 '%s' 이 (가) 잘못되었습니다."
L.LM_ERR_BAD_CONDITION  = "작업 목록의 조건 '%s' 이 (가) 잘못되었습니다."
L.LM_EVERY_D_MINUTES    = "%d 분마다"
L.LM_EVERY_D_SECONDS    = "%d 초마다"
L.LM_EVERY_TIME         = "매번"
L.LM_FLAGS              = "조건"
L.LM_HELP_TRANSLATE     = "당신의 언어로 LiteMount 번역을 도와주세요. 감사합니다."
L.LM_HIDDEN             = "숨겨진"
L.LM_MACRO_EXP          = "LiteMount가 사용 가능한 탈것을 찾을 수 없을 때 실행될 매크로입니다. 실내에 있거나 이동 중이면서 즉시 시전 탈것이 없을 때 사용 됩니다."
L.LM_NEW_FLAG           = "조건 생성"
L.LM_NEW_PROFILE        = "새로운 프로필"
L.LM_PRIORITY           = "우선 순위"
L.LM_PRIORITY_DESC1     = "표준"
L.LM_PRIORITY_DESC2     = "더 자주"
L.LM_PRIORITY_DESC3     = "훨씬 더 자주"
L.LM_PROFILES           = "프로필"
L.LM_RANDOM_PERSISTENCE = "새로운 무작위 탈것을 선택하는 빈도입니다"
L.LM_RENAME_FLAG        = "조건 이름 바꾸기"
L.LM_REPORT_BUG         = "버그 신고"
L.LM_RESET_PROFILE      = "프로필 초기화"
L.LM_SETTINGS_TAGLINE   = "간단하게 믿을 수 있는 무작위 탈것을 소환합니다."
L.LM_TRANSLATORS        = "번역가"
L.LM_WARN_REPLACE_COND  = "블리자드 변경으로 인해 [%s] 작업 목록 조건이 [%s] (으)로 바뀌 었습니다."
L.RUN                   = "지상"
L.SWIM                  = "수중"
L.WALK                  = "걷기"
end

-- ptBR ------------------------------------------------------------------------

if locale == "ptBR" then
L.FLOAT                 = "Flutuar"
L.FLY                   = "Voar"
L.LM_ADVANCED_EXP       = "Essas configurações permitem personalizar as ações executadas por cada uma das teclas de atalho do LiteMount. Por favor, leia a documentação no URL abaixo antes de alterar qualquer coisa."
L.LM_AUTHOR             = "Autor"
L.LM_COMBAT_MACRO_EXP   = "Se habilitada, esta macro será executada em vez das ações de combate padrão se o LiteMount for ativado enquanto você estiver em combate."
L.LM_COPY_TARGETS_MOUNT = "Tentra copiar a montaria do alvo."
L.LM_CURRENT_SETTINGS   = "Configuração Atual"
L.LM_DEBUGGING_DISABLED = "Depuração desativada."
L.LM_DEBUGGING_ENABLED  = "Depuração ativada."
L.LM_DEFAULT_SETTINGS   = "Configuração Padrão"
L.LM_DELETE_FLAG        = "Remover um rótulo"
L.LM_DELETE_PROFILE     = "Remover um Perfil"
L.LM_DISABLE_NEW_MOUNTS = "Desativar automaticamente montarias recém-adicionadas."
L.LM_DISABLING_MOUNT    = "Desativando a montaria ativa: %s"
L.LM_ENABLE_DEBUGGING   = "Permite mensagens de depuração."
L.LM_ENABLING_MOUNT     = "Ativando a montaria ativa: %s"
L.LM_ERR_BAD_ACTION     = "Má ação '%s' na lista de ações."
L.LM_ERR_BAD_CONDITION  = "Condição ruim '%s' na lista de ações."
L.LM_EVERY_D_MINUTES    = "A cada %d minutos"
L.LM_EVERY_D_SECONDS    = "A cada %d segundos"
L.LM_EVERY_TIME         = "Cada vez"
L.LM_FLAGS              = "Rótulos"
L.LM_HELP_TRANSLATE     = "Ajude a traduzir o LiteMount para o seu idioma. Obrigado."
L.LM_HIDDEN             = "Oculta"
L.LM_MACRO_EXP          = "Esta macro será executada se o LiteMount não conseguir encontrar uma montaria utilizável. Isso pode ser porque você está dentro de casa, ou está se movendo e não conhece nenhuma montaria instantânea."
L.LM_NEW_FLAG           = "Crie um rótulo"
L.LM_NEW_PROFILE        = "Cria um perfil"
L.LM_PRIORITY           = "Prioridade"
L.LM_PRIORITY_DESC1     = "Normal"
L.LM_PRIORITY_DESC2     = "Mais frequentemente"
L.LM_PRIORITY_DESC3     = "Com muito mais frequência"
L.LM_PROFILES           = "Perfis"
L.LM_RANDOM_PERSISTENCE = "Com que frequência selecionar uma nova montaria aleatória"
L.LM_RENAME_FLAG        = "Renomear um rótulo"
L.LM_REPORT_BUG         = "Reportar erro"
L.LM_RESET_PROFILE      = "Resetar Perfil"
L.LM_SETTINGS_TAGLINE   = "Montarias aleatórias simples e confiáveis."
L.LM_TRANSLATORS        = "Tradutores"
L.LM_WARN_REPLACE_COND  = "A condição da lista de ações [%s] foi substituída por [%s] devido a alterações da Blizzard."
L.RUN                   = "Correr"
L.SWIM                  = "Nadar"
L.WALK                  = "Andar"
end

-- ruRU ------------------------------------------------------------------------

if locale == "ruRU" then
L.FLOAT                 = "плавучий"
L.FLY                   = "летающий"
L.LM_ADVANCED_EXP       = "Эти настройки позволяют настраивать действия, выполняемые каждым из привязок клавиш LiteMount. Прочтите документацию по URL-адресу ниже, прежде чем что-либо менять."
L.LM_AUTHOR             = "Aвтор"
L.LM_COMBAT_MACRO_EXP   = "Если этот параметр включен, этот макрос будет запускаться вместо боевых действий по умолчанию, если LiteMount активируется во время боя."
L.LM_COPY_TARGETS_MOUNT = "Попробуйте скопировать транспорт цели."
L.LM_CURRENT_SETTINGS   = "текущие настройки"
L.LM_DEBUGGING_DISABLED = "Отладка отключена."
L.LM_DEBUGGING_ENABLED  = "Отладка включена."
L.LM_DEFAULT_SETTINGS   = "Настройки по умолчанию"
L.LM_DELETE_FLAG        = "удалить тег"
L.LM_DELETE_PROFILE     = "Удалить профиль"
L.LM_DISABLE_NEW_MOUNTS = "Автоматически отключать недавно добавленные транспорт."
L.LM_DISABLING_MOUNT    = "Отключение активного транспорт: %s"
L.LM_ENABLE_DEBUGGING   = "Включить отладочную информацию"
L.LM_ENABLING_MOUNT     = "Включение активного транспорт: %s"
L.LM_ERR_BAD_ACTION     = "Плохое действие «%s» в списке действий."
L.LM_ERR_BAD_CONDITION  = "Плохое состояние «%s» в списке действий."
L.LM_EVERY_D_MINUTES    = "Каждые %d минут"
L.LM_EVERY_D_SECONDS    = "Каждые %d секунд"
L.LM_EVERY_TIME         = "Каждый раз"
L.LM_FLAGS              = "теги"
L.LM_HELP_TRANSLATE     = "Помогите перевести LiteMount на ваш язык. Спасибо."
L.LM_HIDDEN             = "скрытый"
L.LM_MACRO_EXP          = "Этот макрос будет запущен, если LiteMount не сможет найти пригодное для использования транспорт. Это может быть из-за того, что вы находитесь в помещении или двигаетесь и не знаете никаких транспорт с мгновенным литом."
L.LM_NEW_FLAG           = "создать тег"
L.LM_NEW_PROFILE        = "Новый профиль"
L.LM_PRIORITY           = "приоритет"
L.LM_PRIORITY_DESC1     = "Нормальный"
L.LM_PRIORITY_DESC2     = "Почаще"
L.LM_PRIORITY_DESC3     = "Гораздо чаще"
L.LM_PROFILES           = "Профили"
L.LM_RANDOM_PERSISTENCE = "Как часто выбирается новый случайный транспорт"
L.LM_RENAME_FLAG        = "Переименовать тег"
L.LM_REPORT_BUG         = "Сообщение об ошибке"
L.LM_RESET_PROFILE      = "Сброс профиль"
L.LM_SETTINGS_TAGLINE   = "Простое и надежное случайное монтирование."
L.LM_TRANSLATORS        = "Переводчики"
L.LM_WARN_REPLACE_COND  = "Условие списка [% s] заменено на [% s] из-за изменений Blizzard."
L.RUN                   = "беговой"
L.SWIM                  = "плавательный"
L.WALK                  = "ходячий"
end

-- zhCN ------------------------------------------------------------------------

if locale == "zhCN" then
L.FLOAT                 = "浮动"
L.FLY                   = "飞"
L.LM_ADVANCED_EXP       = "这些设置允许您自定义每个LiteMount键绑定运行的操作。在更改任何内容之前，请阅读以下URL中的文档。"
L.LM_AUTHOR             = "作者"
L.LM_COMBAT_MACRO_EXP   = "如启用，LiteMount被激活并且当你在战斗中，该宏会被运行替代默认战斗动作。"
L.LM_COPY_TARGETS_MOUNT = "尝试复制目标的坐骑。"
L.LM_CURRENT_SETTINGS   = "当前的设置"
L.LM_DEBUGGING_DISABLED = "调试已禁用"
L.LM_DEBUGGING_ENABLED  = "调试已启用"
L.LM_DEFAULT_SETTINGS   = "默认设置"
L.LM_DELETE_FLAG        = "删除标签"
L.LM_DELETE_PROFILE     = "删除一个配置文件"
L.LM_DISABLE_NEW_MOUNTS = "自动禁用新添加的坐骑。"
L.LM_DISABLING_MOUNT    = "禁用活动挂载：％s"
L.LM_ENABLE_DEBUGGING   = "启用调试消息。"
L.LM_ENABLING_MOUNT     = "启用活动安坐骑：％s"
L.LM_ERR_BAD_ACTION     = "动作列表中的错误动作'%s'。"
L.LM_ERR_BAD_CONDITION  = "行动清单中的错误条件'％s'。"
L.LM_EVERY_D_MINUTES    = "每%d分钟"
L.LM_EVERY_D_SECONDS    = "每%d秒"
L.LM_EVERY_TIME         = "每一次"
L.LM_FLAGS              = "标签"
L.LM_HELP_TRANSLATE     = "帮助将LiteMount翻译成您的语言。谢谢。"
L.LM_HIDDEN             = "隐"
L.LM_MACRO_EXP          = "如果LiteMount不能找到可用的坐骑会用到此宏，这可能是因为你在室内，或者正在移动中，并且不会任何瞬发坐骑。"
L.LM_NEW_FLAG           = "创建一个标签"
L.LM_NEW_PROFILE        = "新建一个配置文件"
L.LM_PRIORITY           = "优先"
L.LM_PRIORITY_DESC1     = "正常"
L.LM_PRIORITY_DESC2     = "更经常"
L.LM_PRIORITY_DESC3     = "更多的时候"
L.LM_PROFILES           = "配置文件"
L.LM_RANDOM_PERSISTENCE = "多久选择一次新的随机坐骑"
L.LM_RENAME_FLAG        = "重命名标记"
L.LM_REPORT_BUG         = "提交Bug"
L.LM_RESET_PROFILE      = "重置配置文件"
L.LM_SETTINGS_TAGLINE   = "简单可靠的随机召唤坐骑坐骑。"
L.LM_TRANSLATORS        = "译者"
L.LM_WARN_REPLACE_COND  = "由于暴雪的变化，[％s]动作列表条件已被[％s]取代。"
L.RUN                   = "跑"
L.SWIM                  = "游"
L.WALK                  = "步行"
end

-- zhTW ------------------------------------------------------------------------

if locale == "zhTW" then
L.FLOAT                 = "水上"
L.FLY                   = "飛行"
L.LM_ADVANCED_EXP       = "這些設定允許你為每一個LiteMount的按鍵綁定自定義行動。請在更改任何內容之前閱讀以下URL中的文件資料。"
L.LM_AUTHOR             = "作者"
L.LM_COMBAT_MACRO_EXP   = "如果啟用，此巨集將替代預設的戰鬥行動，如果LiteMount已啟用並且你在戰鬥中。"
L.LM_COPY_TARGETS_MOUNT = "嘗試複製目標的坐騎。"
L.LM_CURRENT_SETTINGS   = "目前的設定"
L.LM_DEBUGGING_DISABLED = "禁用除錯模式。"
L.LM_DEBUGGING_ENABLED  = "啟用除錯模式。"
L.LM_DEFAULT_SETTINGS   = "預設設定"
L.LM_DELETE_FLAG        = "刪除標籤"
L.LM_DELETE_PROFILE     = "刪除一個設定檔"
L.LM_DISABLE_NEW_MOUNTS = "自動禁用新增的坐騎。"
L.LM_DISABLING_MOUNT    = "禁用召喚中的坐騎：%s"
L.LM_ENABLE_DEBUGGING   = "啟用除錯訊息。"
L.LM_ENABLING_MOUNT     = "啟用召喚中的坐騎：%s"
L.LM_ERR_BAD_ACTION     = "動作列表中出現動作錯誤：'%s'。"
L.LM_ERR_BAD_CONDITION  = "動作列表中出現狀態錯誤：'%s'。"
L.LM_EVERY_D_MINUTES    = "每%d分鐘"
L.LM_EVERY_D_SECONDS    = "每%d秒"
L.LM_EVERY_TIME         = "每次"
L.LM_EXPORT_PROFILE     = "導出設定檔"
L.LM_FLAGS              = "標籤"
L.LM_HELP_TRANSLATE     = "協助將LiteMount翻譯成你的語言。謝謝。"
L.LM_HIDDEN             = "隱"
L.LM_IMPORT_PROFILE     = "導入設定檔"
L.LM_MACRO_EXP          = "如果LiteMount無法找到一個可召喚的坐騎，此巨集將被執行。這有可能是由於你在室內，或在移動中並且沒有任何可瞬間召喚的坐騎。"
L.LM_NEW_FLAG           = "新增標籤"
L.LM_NEW_PROFILE        = "新建一個設定檔"
L.LM_PRIORITY           = "優先"
L.LM_PRIORITY_DESC1     = "正常"
L.LM_PRIORITY_DESC2     = "更經常"
L.LM_PRIORITY_DESC3     = "更多的時候"
L.LM_PROFILES           = "設定檔"
L.LM_RANDOM_PERSISTENCE = "多久選擇一次新的隨坐騎"
L.LM_RENAME_FLAG        = "重新命名標籤"
L.LM_REPORT_BUG         = "提交Bug"
L.LM_RESET_PROFILE      = "重置設定檔"
L.LM_SETTINGS_TAGLINE   = "簡單可靠召喚隨機坐騎。"
L.LM_TRANSLATORS        = "譯者"
L.LM_WARN_REPLACE_COND  = "基於暴雪的改動，[%s]動作列表狀態已被[%s]取代。"
L.RUN                   = "陸地"
L.SWIM                  = "水中"
L.WALK                  = "走路"
end
