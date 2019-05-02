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
    (assert (module menu))
)



;###############################################################################
;###########################  MINERALS MODULE  #################################
;###############################################################################
(defmodule MINERALS (export ?ALL))

(deftemplate MINERALS::mineral
    (slot name (type SYMBOL) (default notDefined))
    (multislot color (type SYMBOL) (default notDefined))
    (slot hardness (type NUMBER) (range -1 10) (default -1))
    (slot density (type NUMBER) (default -1))
    (multislot diaphaneity (allowed-symbols transparent translucent opaque notDefined) (default notDefined))
    (slot streak (type SYMBOL) (default notDefined))
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
    (mineral (name amethyst) (color violet) (hardness 7) (density 2.66) (diaphaneity transparent translucent) (streak white))
    (mineral (name sapphire) (color blue) (hardness 9) (density 3.98) (diaphaneity transparent translucent opaque) (streak white))
    (mineral (name ruby) (color red pink) (hardness 9) (density 4.02) (diaphaneity transparent translucent) (streak white))
    (mineral (name apatite) (color white yellow green red blue) (hardness 5) (density 3.19) (diaphaneity transparent translucent) (streak white))
    (mineral (name lazulite) (color blue green) (hardness 5.75) (density 3.1) (diaphaneity translucent opaque) (streak white))
    (mineral (name azurite) (color blue) (hardness 3.75) (density 3.83) (diaphaneity transparent translucent) (streak blue))
    (mineral (name malachite) (color green) (hardness 7.5) (density 3.8) (diaphaneity translucent opaque) (streak green))
    (mineral (name pyrite) (color yellow brown) (hardness 6.25) (density 4.9) (diaphaneity opaque) (streak black))
    (mineral (name magnetite) (color black) (hardness 6) (density 5.15) (diaphaneity opaque) (streak black))
    (mineral (name spinel) (color red pink blue violet green brown black colourless) (hardness 7.8) (density 3.64) (diaphaneity transparent translucent opaque) (streak white))
    (mineral (name alexandrite) (color blue red green yellow pink violet) (hardness 8.5) (density 3.72) (diaphaneity transparent translucent) (streak white))
    (mineral (name jasper) (color red brown yellow green) (hardness 7) (density 2.65) (diaphaneity opaque) (streak white))
    (mineral (name agate) (color white blue red green yellow brown pink violet black) (hardness 6.75) (density 2.62) (diaphaneity translucent) (streak white))
    (mineral (name kryptonite) (color green) (hardness 10) (density 2.41) (diaphaneity transparent) (streak green))
    (mineral (name lapislazuli) (color blue violet) (hardness 5.25) (density 2.4) (diaphaneity translucent opaque) (streak blue))
    (mineral (name peridot) (color green yellow) (hardness 6.75) (density 3.34) (diaphaneity transparent translucent) (streak white))
    (mineral (name garnet) (color red green yellow black brown) (hardness 7) (density 3.7) (diaphaneity transparent translucent) (streak white))
)







;###############################################################################
;#############################  MENU MODULE  ###################################
;###############################################################################
(defmodule MENU (import MAIN ?ALL) (import MINERALS ?ALL) (export ?ALL))

(defglobal ?*response* = nil)

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
        (printout t "   5. Specify streak" crlf)
    )
    (printout t crlf)
    (printout t "your option: ")
)

(deffunction MENU::printMenuRestriction (?option)
    (printout t crlf)

    (if (eq ?option color) then
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
    (if (eq ?option streak) then
        (printout t "Specify the color of the streak: ")
    )
)

;###############################################################################

(deffunction isColor(?color)
    (if (eq ?color black) then (return true))
    (if (eq ?color blue) then (return true))
    (if (eq ?color brown) then (return true))
    (if (eq ?color colorless) then (return true))
    (if (eq ?color green) then (return true))
    (if (eq ?color pink) then (return true))
    (if (eq ?color red) then (return true))
    (if (eq ?color violet) then (return true))
    (if (eq ?color white) then (return true))
    (if (eq ?color yellow) then (return true))
    (return false)
)

;###############################################################################

(deffunction MENU::getColorFromUser ()
    (bind ?*response* (read))
    (if (neq (isColor ?*response*) true) then
        (printout t "invalid color, please, type a correct color: ")
        (return (getColorFromUser))
    )
    (return  ?*response*)
)

(deffunction MENU::getDensityFromUser ()
    (bind ?*response* (read))
    (if (< 0 ?*response*) then
        (return  ?*response*)
    )
    (printout t "invalid density, please, type a correct density: ")
    (return (getDensityFromUser))
)

(deffunction MENU::getHardnessFromUser ()
    (bind ?*response* (read))
    (if (and
            (<= 0 ?*response*)
            (>= 10 ?*response*)
        ) then
        (return  ?*response*)
    )
    (printout t "invalid hardness, please, type a correct hardness [0-10]: ")
    (return (getHardnessFromUser))
)

(deffunction MENU::getDiaphaneityFromUser ()
    (bind ?*response* (read))
    (if (and
            (<= 1 ?*response*)
            (>= 3 ?*response*)
        ) then
        (if (eq ?*response* 1) then (return transparent))
        (if (eq ?*response* 2) then (return translucent))
        (if (eq ?*response* 3) then (return opaque))
    )
    (printout t "invalid option, please, type a correct diaphaneity: ")
    (return (getDiaphaneityFromUser))
)


(deffunction MENU::getStreakFromUser ()
    (bind ?*response* (read))
    (if (neq (isColor ?*response*) true) then
        (printout t "invalid color, please, type a correct streak color: ")
        (return (getStreakFromUser))
    )
    (return  ?*response*)
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


(defrule MENU::menuExpert
    ?f1<-(menu option 2)
    =>
    (retract ?f1)
    (printout t "focusing expert" crlf)
    (focus EXPERT)
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
    (printMenuRestriction hardness)
    (modify ?target
        (hardness (getHardnessFromUser))
    )
)

(defrule MENU::AddRestrictionDensity
    ?f1<-(menu AddRestriction 3)
    ?target<-(mineral (name target))
    =>
    (retract ?f1)
    (printMenuRestriction density)
    (modify ?target
        (density (getDensityFromUser))
    )
)


(defrule MENU::AddRestrictionDiaphaneity
    ?f1<-(menu AddRestriction 4)
    ?target<-(mineral (name target))
    =>
    (retract ?f1)
    (printMenuRestriction diaphaneity)
    (modify ?target
        (diaphaneity (getDiaphaneityFromUser))
    )
)

(defrule MENU::AddRestrictionStreak
    ?f1<-(menu AddRestriction 5)
    ?target<-(mineral (name target))
    =>
    (retract ?f1)
    (printMenuRestriction streak)
    (modify ?target
        (streak (getStreakFromUser))
    )
)



;###############################################################################
;############################  EXPERT MODULE  ##################################
;###############################################################################
(defmodule EXPERT (import MINERALS ?ALL) (export ?ALL))

(defglobal ?*hardnessError* = 0.3)
(defglobal ?*densityError* = 0.1)

;###############################################################################

(deffunction EXPERT::isInArray (?element $?vector)
    (if (eq 0 (length$ $?vector)) then
        (return false)
    )
    (if (eq ?element (nth$ 1 $?vector)) then
        (return true)
    )
    (return (isInArray ?element (rest$ $?vector)))
)

;###############################################################################

(deffunction EXPERT::isSameColor (?targetColor $?color)
    ; target hardness has its default value, not filtering by this field
    (if (eq ?targetColor notDefined) then (return true))
    (return (isInArray ?targetColor $?color))
)

(deffunction EXPERT::isSameHardness (?targetHardness ?hardness)
    ; target hardness has its default value, not filtering by this field
    (if (eq ?targetHardness -1) then (return true))
    
    (if (> ?*hardnessError* (abs (- ?targetHardness ?hardness)))
        then (return true)
    )
    (return false)
)

(deffunction EXPERT::isSameDensity (?targetDensity ?density)
    ; target density has its default value, not filtering by this field
    (if (eq ?targetDensity -1) then (return true))
    (if (> ?*densityError* (abs (- ?targetDensity ?density)))
        then (return true)
    )
    (return false)
)

(deffunction EXPERT::isSameDiaphaneity (?targetDiaphaneity $?diaphaneity)
    ; target diaphaneity has its default value, not filtering by this field
    (if (eq ?targetDiaphaneity notDefined) then (return true))
    (return (isInArray ?targetDiaphaneity $?diaphaneity))
)

(deffunction EXPERT::isSameStreak (?targetStreak $?streak)
    ; target streak has its default value, not filtering by this field
    (if (eq ?targetStreak notDefined) then (return true))
    (return (isInArray ?targetStreak $?streak))
)

;###############################################################################

(defrule EXPERT::showFilteringBy
    ?target<-(mineral
                (name target)
                (color ?targetColor)
                (hardness ?targetHardness)
                (density ?targetDensity)
                (diaphaneity ?targetDiaphaneity)
                (streak ?targetStreak)
             )
    =>
    (printout t "" crlf)
    (printout t "filtering by:" crlf)
    (if (neq ?targetColor notDefined) then
        (printout t "   color: "?targetColor crlf)
    )
    (if (neq ?targetHardness -1) then
        (printout t "   hardness: "?targetHardness crlf)
    )
    (if (neq ?targetDensity -1) then
        (printout t "   density: "?targetDensity crlf)
    )
    (if (neq ?targetDiaphaneity notDefined) then
        (printout t "   diaphaneity: "?targetDiaphaneity crlf)
    )
    (if (neq ?targetStreak notDefined) then
        (printout t "   streak: "?targetStreak crlf)
    )
    (if (and
            (and
                (eq ?targetColor notDefined)
                (eq ?targetHardness -1)
            )
            (and
                (eq ?targetDensity -1)
                (and
                    (eq ?targetDiaphaneity notDefined)
                    (eq ?targetStreak notDefined)
                )
            )
        )
        then
        (printout t "   nothing."crlf)
    )
    
    (printout t "" crlf)
)




(defrule EXPERT::testMineral
    ?target<-(mineral
                (name target)
                (color ?targetColor)
                (hardness ?targetHardness)
                (density ?targetDensity)
                (diaphaneity ?targetDiaphaneity)
                (streak ?targetStreak)
             )
    ?mineral<-(mineral
                (name ?name)
                (color $?color)
                (hardness ?hardness)
                (density ?density)
                (diaphaneity $?diaphaneity)
                (streak ?streak)
              )
    (test (neq ?name target))
    (test (eq true (isSameColor ?targetColor $?color)))
    (test (eq true (isSameHardness ?targetHardness ?hardness)))
    (test (eq true (isSameDensity ?targetDensity ?density)))
    (test (eq true (isSameDiaphaneity ?targetDiaphaneity $?diaphaneity)))
    (test (eq true (isSameStreak ?targetStreak ?streak)))
    =>
    (printout t "match with "?name crlf)
)
