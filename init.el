;;; Commentary:
;;

;;; Code:

(when (version< emacs-version "28.1")
  (error
   "Requires GNUEmacs 28.1 or newer"))

;; define username
(defvar username (getenv (if (equal system-type 'windows-nt) "USERNAME" "USER")))

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "mycustom.el"))
(load custom-file 'noerror 'nomessage)

(defvar core-dir (expand-file-name "core" user-emacs-directory))
(defvar languages-dir (expand-file-name "languages" user-emacs-directory))

(message "Loading core modules...")
(add-to-list 'load-path core-dir)
(require 'cc-core)

(message "Loading language modules...")
(add-to-list 'load-path languages-dir)
(require 'cc-langs)

;;; init.el ends here
