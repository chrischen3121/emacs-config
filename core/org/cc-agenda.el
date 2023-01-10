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

(setq cc/org-todo-file
      (expand-file-name cc/org-todo-filename cc/agenda-home-dir)
      cc/org-quicknotes-file
      (expand-file-name cc/org-quicknotes-filename cc/agenda-home-dir)
      cc/org-journal-file
      (expand-file-name cc/org-journal-filename cc/agenda-home-dir)
      cc/org-habits-file
      (expand-file-name cc/org-habits-filename cc/agenda-home-dir))

(add-to-list 'recentf-exclude cc/org-todo-file)
(add-to-list 'recentf-exclude cc/org-quicknotes-file)
(add-to-list 'recentf-exclude cc/org-journal-file)
(add-to-list 'recentf-exclude cc/org-habits-file)


(use-package org
  :init
  (which-key-add-key-based-replacements "C-c a" "agenda")
  (which-key-add-keymap-based-replacements org-mode-map "C-c C-x" "org commands")
  :custom
  (org-agenda-files (directory-files-recursively cc/agenda-home-dir ".org$"))
  ;; org-capture
  (org-default-notes-file (expand-file-name cc/org-captured-filename cc/agenda-home-dir))
  (org-capture-templates
   '(("q" "Quick Notes" entry
      (file+datetree cc/org-quicknotes-file)
      "* %?\nEntered on %U\n  %a\n"
      :empty-lines 1
      :kill-buffer t)
     ("p" "Project" entry
      (file+headline cc/org-todo-file "Projects")
      "* TODO %?%^g\n  %U\n" :empty-lines 1)
     ("b" "Book" entry
      (file+headline cc/org-todo-file "Books")
      "* TODO %?%^g\n  %U\n" :empty-lines 1)
     ("c" "Course" entry
      (file+headline cc/org-todo-file "Courses")
      "* TODO %?%^g\n  %U\n" :empty-lines 1)
     ("w" "Work" entry
      (file+headline cc/org-todo-file "Work")
      "* TODO %?%^g\n  %U\n" :empty-lines 1)
     ("m" "Meeting" entry
      (file+olp cc/org-todo-file "Work" "Meetings")
      "* TODO %^t %? \n"
      :clock-in :clock-resume
      :empty-lines 1)
     ("j" "Journal" entry
      (file+olp+datetree cc/org-journal-file)
	 "\n* %<%I:%M %p> - Journal\n%?\n"
	 :empty-lines 1
	 :kill-buffer t)
     ))
  (org-refile-targets '((nil :level . 1)
			(org-agenda-files :level . 1)))
  ;; todo keywords
  (org-export-with-todo-keywords nil)
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "HOLD(h@)"  "|" "DONE(d!)" "CANCELED(c)")))
  (org-todo-keyword-faces '(("TODO" . "dark salmon")
			    ("NEXT" . "light blue")
			    ("HOLD" . "medium purple")
			    ("DONE" . "light green")
			    ("CANCELED" .  "dark gray")))
  ;; clock configuration
  (org-deadline-warning-days 5)
  (org-clock-out-remove-zero-time-clocks t)
  (org-clock-out-when-done t)
  (org-log-done 'time)
  (org-log-into-drawer t)
  ;; agenda configuration
  (org-tag-alist '(("Learning" . ?l)
		   ("ML" . ?L)
		   ("Hobby" . ?h)
		   ("Housekeeping" . ?k)
		   ("English" . ?e)
		   ("Child" . ?c)
		   ("CS" . ?s)
		   ("Finance" . ?f)
		   ("CPP" . ?+)
		   ("Python" . ?p)
		   ("Math" . ?M)
		   ("Frontend" . ?F)
		   ("Backend" . ?b)
		   ("Database" . ?d)))
  (org-agenda-custom-commands
   '(;; Daily dashboard
     ("d" "Dashboard"
      ((agenda "" ((org-deadline-warning-days 5)
		   (org-agenda-span 3)
		   (org-agenda-repeating-timestamp-show-all t)))
       (todo "NEXT"
	     ((org-agenda-overriding-header "Next Tasks")
	      (org-agenda-sorting-strategy '(priority-up effort-down))))
       (stuck "") ; review stuck projects as designated by org-stuck-projects
       ))

     ;; Weekly review
     ("r" "Weekly Review"
      ((agenda "" ((org-deadline-warning-days 15)
		   (org-agenda-span 7)
		   (org-agenda-sorting-strategy '(priority-up effort-down))))
       (stuck "")
       (todo "DONE")))

     ;; tags-todo
     ("g" "GTD Tagged Agenda"
      ((tags-todo "Work")
       (tags-todo "Learning")
       (tags-todo "Project")
       (tags-todo "Child")
       (tags-todo "English"))
      nil)

     ;; Upcoming deadlines
     ("D" "Upcoming Deadlines" agenda ""
      ((org-agenda-entry-types '(:deadline))
       (org-agenda-span 1)
       (org-deadline-warning-days 90)
       (org-agenda-time-grid nil)))

     ;; Archive search
     ("A" "Archive search" search ""
      ((org-agenda-files (directory-files-recursively cc/agenda-home-dir ".org_archive$"))))

     ;; effort
     ("t" "Effort Table" todo "DONE"
      ((org-columns-default-format-for-agenda
	"%10CATEGORY %15ITEM(TASK) %2PRIORITY %SCHEDULED %DEADLINE %5EFFORT(ESTIMATED){:} %5CLOCKSUM(SPENT) %TAGS")
       (org-agenda-view-columns-initially t)
       (org-agenda-span 30)))

     ;; Low-effort next actions
     ("e" tags-todo "+TODO=\"NEXT\"+Effort<30&+Effort>0"
      ((org-agenda-overriding-header "Low Effort Tasks")
       (org-agenda-max-todos 15)
       (org-agenda-files org-agenda-files)))))
  (org-agenda-start-with-log-mode t)
  :config
  (require 'org-agenda)
  (which-key-add-keymap-based-replacements org-agenda-mode-map "C-c C-x" "agenda commands")
  (advice-add 'org-refile :after 'org-save-all-org-buffers) ; Save Org buffers after refiling!
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)
  :bind
  (("C-c a a" . org-agenda)
   ("C-c a l" . org-agenda-list)
   ("C-c a c" . org-capture)
   :map org-mode-map
   ("C-c a r" . org-archive-subtree)
   ("C-c a i" . org-clock-in)
   ("C-c a o" . org-clock-out)
   ("C-c a e" . org-set-effort)
   ("C-c a E" . org-clock-modify-effort-estimate)
   ("C-c a q" . org-clock-cancel)
   ("C-c a j" . org-clock-goto)
   :map org-agenda-mode-map
   ;; Hints:
   ;; a: archive I: clockin O: clockout e: set-effort
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
