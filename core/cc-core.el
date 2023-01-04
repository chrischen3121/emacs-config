(require 'cc-vars)

(require 'cc-packages)

;; Emacs cache
(setq user-emacs-directory "~/.cache/emacs")
(use-package no-littering)

(require 'cc-locale)
(require 'cc-better-defaults)
(require 'cc-ivy-counsel)
(require 'cc-dev)

(provide 'cc-core)
