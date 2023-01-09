;;; cc-agenda.el --- Org Agenda Configuration

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
(use-package org
  :init
  (which-key-add-key-based-replacements "C-c a" "agenda")
  (which-key-add-keymap-based-replacements org-mode-map "C-c C-x" "org commands")
  :custom
  (org-agenda-files (directory-files-recursively cc/agenda-home-dir ".org$"))
  ;; org-capture
  (org-default-notes-file (expand-file-name "captured.org" cc/agenda-home-dir))
  (org-capture-templates '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
			    "* TODO %?\n %U\n")))
  (org-refile-targets '((nil :level . 1)
			(org-agenda-files :level . 1)))
  ;; todo keywords
  (org-export-with-todo-keywords nil)
  ;; TODO: to confirm
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "HOLD(h@)"  "|" "DONE(d!)" "CANCELED(c)")
		       (sequence "REPORT(r)" "REVIEW(v)" "WAIT(w@/!)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)" "CANCELED(c@)")))
  (org-todo-keyword-faces '(("TODO" . "dark salmon")
			    ("NEXT" . "light blue")
			    ("HOLD" . "medium purple")
			    ("DONE" . "light green")
			    ("CANCELED" .  "dark gray")
			    ("REPORT" .  "dark salmon")
			    ("WAIT" .  "medium purple")
			    ("BUG" .  "salmon")
			    ("KNOWNCAUSE" .  "dark green")
			    ("FIXED" . "dark green")))
  ;; TODO: to confirm
  (org-todo-state-tags-triggers
   '(("HOLD" ("NEXT") ("HOLD" . t))
     ("NEXT" ("HOLD") ("NEXT" . t))
     ("DONE" ("HOLD") ("NEXT"))
     ("TODO" ("NEXT") ("HOLD"))))
  ;; clock configuration
  (org-deadline-warning-days 5)
  (org-clock-out-remove-zero-time-clocks t)
  (org-clock-out-when-done t)
  (org-log-done 'time)
  (org-log-into-drawer t)
  ;; agenda configuration
  (org-tag-alist '(("Work" . ?w)
		   ("Learning" . ?l)
		   ("Hobby" . ?h)
		   ("Housekeeping" . ?k)
		   ("English" . ?e)
		   ("Child" . ?c)
		   ("CS" . ?s)
		   ("Finance" . ?f)
		   ("Routine" . ?r)
		   ("CPP" . ?+)
		   ("Python" . ?p)
		   ("Math" . ?m)
		   ("Frontend" . ?F)
		   ("Backend" . ?b)
		   ("Database" . ?d)
		   ("ML" . ?M)
		   ("Project" . ?P)
		   ("Coursera" . ?C)
		   ("Geekbang" . ?G)
		   ("Udacity" . ?U)))
  (org-agenda-start-with-log-mode t)
  :config
  (require 'org-agenda)
  (which-key-add-keymap-based-replacements org-agenda-mode-map "C-c C-x" "agenda commands")
  :bind
  (("C-c a a" . org-agenda)
   ("C-c a l" . org-agenda-list)
   ("C-c a c" . org-capture)
   :map org-mode-map
   ("C-c a r" . org-archive-subtree-default)
   ("C-c a i" . org-clock-in)
   ("C-c a o" . org-clock-out)
   ("C-c a e" . org-clock-modify-effort-estimate)
   ("C-c a q" . org-clock-cancel)
   ("C-c a j" . org-clock-goto)
   :map org-agenda-mode-map
   ("C" . org-agenda-columns)))

;; org-superstar
(use-package
  org-superstar
  :custom
  (org-superstar-special-todo-items t)
  (org-superstar-todo-bullet-alist
   '(("TODO" . 9744)
     ("DONE" . 9745)
     ("CANCELED" . ?✘)
     ("NEXT" . 9744)
     ("HOLD" . ?☎)
     ("WAIT" . ?☎)
     ("REPORT" . 9744)
     ("REVIEW" . 9744)
     ("BUG" . ?⚠)
     ("KNOWNCAUSE" . ?⭗)
     ("FIXED" . 9745)))
  :hook (org-mode . org-superstar-mode))

;; TODO: org-super-agenda: agenda groups

(provide 'cc-agenda)

;;; cc-agenda.el ends here
