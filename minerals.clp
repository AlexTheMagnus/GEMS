(deftemplate mineral
    (slot name (type SYMBOL))
    (multislot color (type SYMOL))
    (slot hardness (type NUMBER) (range 0 10))
    (slot density (type NUMBER))
    (multislot diaphaneity (allowed-symbols transparent translucent opaque))
)

(deffacts minerals
)
