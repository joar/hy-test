(defn decorator [func]
    (defn internal-wrapper [x y]
        (* 20 (func x y))))

(with-decorator decorator
    (defn test [x y]
        (* x y )))

(print (test 1 2))
