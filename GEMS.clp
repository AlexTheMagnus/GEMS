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
)

(deffacts MINERALS::minerals
    (mineral (name emerald) (color green) (hardness 7.5) (density 2.7) (diaphaneity transparent translucent))
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
