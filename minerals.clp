(deftemplate mineral
    (slot name (type SYMBOL))
    (multislot color (type SYMBOL))
    (slot hardness (type NUMBER) (range 0 10))
    (slot density (type NUMBER))
    (multislot diaphaneity (allowed-symbols transparent translucent opaque))
)

(deffacts minerals
    (mineral (name emerald) (color green) (hardness 7.5) (density 2.7) (diaphaneity transparent translucent))
)
