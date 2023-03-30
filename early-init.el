;;; early-init.el --- bootstrapper

;; Author: chrischen
;; Maintainer: chrischen

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;

;;; Code:

;; Prevent any garbage collection from happening during load time.
(defconst cc/1mb (* 1024 1024))
(defconst cc/100mb (* 100 cc/1mb))

(defun cc/defer-garbage-collection ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun cc/restore-garbage-collection ()
  (run-at-time 1 nil (lambda ()
               (setq gc-cons-threshold cc/100mb))))


(defun cc/display-startup-time ()
  (message "Loaded in %s with %d gc. Happy Hacking! 🎉💻🤖🔧"
       (format "%.2f seconds"
           (float-time
            (time-subtract after-init-time before-init-time)))
       gcs-done))

(add-hook 'emacs-startup-hook #'cc/restore-garbage-collection)
(add-hook 'emacs-startup-hook #'cc/display-startup-time)
(add-hook 'minibuffer-setup-hook #'cc/defer-garbage-collection)
(add-hook 'minibuffer-exit-hook #'cc/restore-garbage-collection)

;; Garbage collection is a big contributor to startup times.
(cc/defer-garbage-collection)

;; lsp-mode's performance suggest
(setq read-process-output-max cc/1mb)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)

;; Don't use precious startup time checking mtime on elisp bytecode.
(setq load-prefer-newer noninteractive)

(when (getenv-internal "DEBUG")
  (setq init-file-debug t debug-on-error t))

;;; early-init.el ends here
