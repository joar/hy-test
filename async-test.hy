;; gevent greenlets
;; (c) 2013 Joar Wandborg, licenced under CC0
;; <http://creativecommons.org/publicdomain/zero/1.0/>

(import [gevent [joinall spawn sleep]])
(import [random [randint]])

(defn sleep-then-print [&rest args &optional pid]
  "
  Sleep (gevent) for somethime between 0.1 to 5 seconds
  Args
   - pid: The process id
  "
  (setv sleep-time
    (*
      (randint 100 5000)
      0.001))

  (print
    (.format "pid: {1} - Will sleep for {0} seconds" sleep-time pid))

  (sleep sleep-time) ; gevent.sleep

  (print (.format "Slept for {0} seconds" sleep-time))

  sleep-time)

(if (= __name__ "__main__")
 (do
  (joinall
    (list-comp  ; Generate the processes
      (spawn (lambda [pid]
        (do
          (kwapply (sleep-then-print)
            {"pid" pid}))) x)
      (x (range 0 10))))))
