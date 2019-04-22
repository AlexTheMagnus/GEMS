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
(defmodule EXPERT (export ?ALL))
