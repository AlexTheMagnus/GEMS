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
    (slot hardness (type NUMBER) (default ?DERIVE NONE) (range 0 10))
    (slot density (type NUMBER) (default ?DERIVE NONE))
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
(defmodule MENU (import MAIN ?ALL) (import MINERALS ?ALL) (export ?ALL))

(deffacts MINERALS::addTarget
    (mineral (name target))
)

(deffunction MENU::printMenu (?option)
    (printout t crlf)

    (if (eq ?option 0)  then
        (printout t "   1. Add restriction" crlf)
        (printout t "   2. Filter minerals" crlf)
        (printout t "   0. Exit" crlf)
    )
    (if (eq ?option 1) then
        (printout t "   1. Specify color" crlf)
        (printout t "   2. Specify hardness" crlf)
        (printout t "   3. Specify density" crlf)
        (printout t "   4. Specify diaphaneity" crlf)
    )
    (printout t crlf)
    (printout t "your option: ")
)

(deffunction MENU::printMenuRestriction (?option)
    (printout t crlf)

    (if (eq ?option color)  then
        (printout t "Specify the color of the mineral: ")
    )
    (if (eq ?option hardness) then
        (printout t "Specify the hardness of the mineral [0-10]: ")
    )
    (if (eq ?option density) then
        (printout t "Specify the density of the mineral: ")
    )
    (if (eq ?option diaphaneity) then
        (printout t "Specify the diaphaneity of the mineral" crlf)
        (printout t crlf)
        (printout t "   1. transparent" crlf)
        (printout t "   2. translucent" crlf)
        (printout t "   3. opaque" crlf)
        (printout t crlf)
        (printout t "your option: ")
    )
)

(deffunction MENU::getColorFromUser ()
    (return (read))
)

(deffunction MENU::getDensityFromUser ()
    (return (read))
)

(deffunction MENU::getHardnessFromUser ()
    (return (read))
)

(deffunction MENU::getDiaphaneityFromUser ()
    (return (read))
)

;###############################################################################


(defrule MENU::mainMenu
    ?f1<-(menu mainMenu)
    =>
    (retract ?f1)
    (printMenu 0)
    
    (assert
        (menu option (read))
    )
)

(defrule MENU::exit
    ?f1<-(menu option 0)
    =>
    (retract ?f1)
    (exit)
)


(defrule MENU::menuAddRestriction
    ?f1<-(menu option 1)
    =>
    (retract ?f1)
    (printMenu 1)
    (assert
        (menu AddRestriction (read))
    )
)


;###############################################################################


(defrule MENU::AddRestrictionColor
    ?f1<-(menu AddRestriction 1)
    ?target<-(mineral (name target))
    =>
    (retract ?f1)
    (printMenuRestriction color)
    (modify ?target
        (color (getColorFromUser))
    )
)

(defrule MENU::AddRestrictionHardness
    ?f1<-(menu AddRestriction 2)
    ?target<-(mineral (name target))
    =>
    (retract ?f1)
    (printMenuRestriction color)
    (modify ?target
        (hardness (getHardnessFromUser))
    )
)

(defrule MENU::AddRestrictionDensity
    ?f1<-(menu AddRestriction 3)
    ?target<-(mineral (name target))
    =>
    (retract ?f1)
    (printMenuRestriction color)
    (modify ?target
        (hardness (getDensityFromUser))
    )
)


(defrule MENU::AddRestrictionDiaphaneity
    ?f1<-(menu AddRestriction 4)
    ?target<-(mineral (name target))
    =>
    (retract ?f1)
    (printMenuRestriction diaphaneity)
    (modify ?target
        (hardness (getDiaphaneityFromUser))
    )
)


;###############################################################################
;############################  EXPERT MODULE  ##################################
;###############################################################################
(defmodule EXPERT (import MINERALS ?ALL) (export ?ALL))

(defrule test
    (mineral (name target))
    =>
    (facts)
)
