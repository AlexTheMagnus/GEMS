;###############################################################################
;#############################  MAIN MODULE  ###################################
;###############################################################################
(defmodule MAIN (export ?ALL))


(deffacts MAIN::initialFacts
    (module menu)
)


(defrule MAIN::PassToModuleMenu
    ?f1<-(module menu)
    =>
    (retract ?f1)
    (printout t "focusing menu" crlf)
    (assert (menu mainMenu))
    (focus MENU)
    (assert (module expert))
)


(defrule MAIN::PassToModuleExpert
    ?f1<-(module expert)
    =>
    (retract ?f1)
    (printout t "focusing expert" crlf)
    (focus EXPERT)
    (assert (module menu))
)


;###############################################################################
;###########################  MINERALS MODULE  #################################
;###############################################################################
(defmodule MINERALS (export ?ALL))

(deftemplate MINERALS::mineral
    (slot name (type SYMBOL))
    (multislot color (type SYMBOL))
    (slot hardness (type NUMBER) (range 0 10))
    (slot density (type NUMBER))
    (multislot diaphaneity (allowed-symbols transparent translucent opaque))
    (slot streak (type SYMBOL))
)
;Implementar busqueda por dureza y densidad con cota de error de 0.1

(deffacts MINERALS::minerals
    (mineral (name emerald) (color green) (hardness 7.5) (density 2.7) (diaphaneity transparent translucent opaque) (streak white))
    (mineral (name diamond) (color yellow brown green blue white colorless) (hardness 10) (density 3.5) (diaphaneity transparent translucent) (streak colorless))
    (mineral (name quartz) (color white pink black colorless red green blue violet) (hardness 7) (density 2.65) (diaphaneity transparent translucent opaque) (streak white))
    (mineral (name tourmaline) (color red pink yellow brown green blue white black colorless) (hardness 7) (density 3.1) (diaphaneity translucent opaque) (streak white))
    (mineral (name topaz) (color red pink yellow brown blue violet white colorless) (hardness 8) (density 3.5) (diaphaneity transparent) (streak white))
    (mineral (name zircon) (color yellow brown green violet white colorless) (hardness 7) (density 4.7) (diaphaneity transparent translucent opaque) (streak white))
    (mineral (name jade) (color red pink yellow brown green blue violet white black colorless) (hardness 7) (density 3.3) (diaphaneity translucent opaque) (streak white))
    (mineral (name opal) (color red pink yellow brown white black colorless) (hardness 6) (density 2.5) (diaphaneity transparent translucent opaque) (streak white))
    (mineral (name turquoise) (color blue) (hardness 5.5) (density 2.5) (diaphaneity transparent translucent opaque) (streak white))
    
)








;###############################################################################
;#############################  MENU MODULE  ###################################
;###############################################################################
(defmodule MENU (import MAIN ?ALL) (export ?ALL))

(defrule MENU::mainMenu
    ?f1<-(menu mainMenu)
    =>
    (retract ?f1)
    (printout t "1 añadir restricción" crlf)
    (printout t "cualquier otra cosa será interpretado como salir" crlf)
    (printout t "tu opcion: ")
    (assert
        (menu option (read))
    )
)

(defrule MENU::addRestricion
    ?f1<-(menu option 1)
    =>
    (retract ?f1)
    (printout t "menu para añadir restriccion" crlf)
    (return)
)







;###############################################################################
;############################  EXPERT MODULE  ##################################
;###############################################################################
(defmodule EXPERT (import MINERALS ?ALL) (export ?ALL))

(defrule test
    (mineral (name emerald) (color green) (hardness 7.5) (density 2.7) (diaphaneity transparent translucent))
    =>
    (printout t "hay munerales!" crlf)
)
