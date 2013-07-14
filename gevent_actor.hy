;; Implementation of http://sdiehl.github.io/gevent-tutorial/#actors in hy
;;; (c) 2013 Joar Wandborg, licenced under CC0
;; <http://creativecommons.org/publicdomain/zero/1.0/>
(import gevent)
(import [gevent [Greenlet]])
(import [gevent.queue [Queue]])

(defclass Actor [Greenlet]
  [
    [--init--
      (fn [self]
        ;; Call the superclass' init
        (.--init-- Greenlet self)

        (setv self.inbox (Queue))
        None)] ;; --init-- must return None

    [receive
      (fn [self message]
        ;; Define in subclass
        (raise (NotImplemented)))]

    [_run
      (fn [self]
        (setv self.running True)
        (while self.running
          (setv message (self.inbox.get))
          (self.receive message)))]
      ])

(defclass Pinger [Actor]
  [
    [receive
      (fn [self message]
        (print message)
        (pong.inbox.put "ping")
        (gevent.sleep 0))]
  ])

(defclass Ponger [Actor]
  [
    [receive
      (fn [self message]
        (print message)
        (ping.inbox.put "pong")
        (gevent.sleep 0))]
  ])

(if (= __name__ "__main__")
  (do
    (setv ping (Pinger))
    (setv pong (Ponger))
    (.start ping)
    (.start pong)
    (.put ping.inbox "start")
    (gevent.joinall [ping pong])))
