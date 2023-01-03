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
(defconst 1MB 1048576)
(defconst 20MB 20971520)
(defconst 30MB 31457280)
(defconst 50MB 52428800)

(defun cc/defer-garbage-collection ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun cc/restore-garbage-collection ()
  (run-at-time 1 nil (lambda ()
                       (setq gc-cons-threshold 30MB))))

(add-hook 'emacs-startup-hook #'cc/restore-garbage-collection)
(add-hook 'minibuffer-setup-hook #'cc/defer-garbage-collection)
(add-hook 'minibuffer-exit-hook #'cc/restore-garbage-collection)

;; lsp-mode's performance suggest
(setq read-process-output-max 1MB)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)

;; Garbage collection is a big contributor to startup times.
(cc/defer-garbage-collection)

;; Don't use precious startup time checking mtime on elisp bytecode.
(setq load-prefer-newer noninteractive)


(when (getenv-internal "DEBUG")
  (setq init-file-debug t debug-on-error t))

;;; early-init.el ends here
