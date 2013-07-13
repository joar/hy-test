;; Implementation of http://www.dabeaz.com/coroutines/coroutine.py in hy
;; (c) 2013 Joar Wandborg, licenced under CC0
;; <http://creativecommons.org/publicdomain/zero/1.0/>

(defn coroutine [func]
    (defn start [&rest args]
          (setv cr (apply func args))
          (.next cr)
          cr))

(with-decorator coroutine
    (defn grep [pattern]
        (print (.format "Looking for {0}" pattern))

        (while True
           (setv line (yield))
           (print (.format "Received '{0}'" line))

        (if (in pattern line)
            (print (.format "-!- Match found: {0}" line))))))

(if (= __name__ "__main__")
    (do
        (setv g (grep "python"))
        (.send g "Yeah, but no, but yeah, but no")
        (.send g "A series of tubes")
        (.send g "python generators rock!")
        (.send g "monty python!")))
