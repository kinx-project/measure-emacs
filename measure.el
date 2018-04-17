(require 'xelb)
(require 'xcb-xkb)

;; no-op
(defun enable-caps-post-self-insert ())

(setq caps-conn
      (let ((conn (xcb:connect ":0")))
	;; Initialize XKB
	(if (= 0 (slot-value (xcb:get-extension-data conn 'xcb:xkb)
			     'present))
	    (error "XKB not supported"))
	(xcb:+request-unchecked conn
	    (make-instance 'xcb:xkb:UseExtension
			   :wantedMajor 1
			   :wantedMinor 0))
	(xcb:flush conn)
	conn))

;; actually enable caps lock
(defun enable-caps-post-self-insert ()
  (xcb:+request caps-conn
      (make-instance 'xcb:xkb:LatchLockState
		     :deviceSpec xcb:xkb:ID:UseCoreKbd
		     :affectModLocks 2 ;; which mods are affected?
		     :modLocks 2       ;; modifier values
		     :lockGroup 0
		     :groupLock 0
		     :affectModLatches 0
		     :latchGroup 0
		     :groupLatch 0))
  (xcb:flush caps-conn))

;; enable caps lock on each character press (buffer-local hook, use in a scratch
;; buffer)
(add-hook 'post-self-insert-hook 'enable-caps-post-self-insert nil t)
