;;; cc-core.el --- Core Configuration

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

(require 'cc-var-define)
(require 'cc-packages)

;; Emacs cache
(setq user-emacs-directory "~/.cache/emacs")
(use-package no-littering
  :demand t)

(require 'cc-locale)
(require 'cc-themes)
(require 'cc-better-defaults)
(require 'cc-ivy-counsel)

(add-to-list 'load-path (expand-file-name "cc-org" core-dir))
(require 'cc-org)
(require 'cc-pdf-note)
(require 'cc-agenda)
(require 'cc-org-publish)
(require 'cc-org-roam)

(require 'cc-hydra) ; TODO:
(require 'cc-dev)

(provide 'cc-core)

;;; cc-core.el ends here
