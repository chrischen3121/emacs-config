;;; cc-org.el --- Org-Mode Configuration

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

;;; Hints:
;;
;; C-c C-l -- Insert a link
;; C-c C-o -- Open link at point
;; C-x n s, C-x n w -- Narrow buffer
;; C-c / -- Search in an outline tree and fold others as much as possible
;; M-S-RET -- Add TODO outlines or add items with a checkbox
;; C-c - -- Cycle bullets (-, +, *, ...)
;; C-c m i -- Create IDs
;; C-c m p -- org-toggle-inline-images
;; C-c ; -- Toggle the "COMMENT" keyword
;; ====== Tags ==========
;; C-c C-q -- Set a tag
;; M-x org-agenda m/M -- Match tags (only TODO)
;; ====== Properties ========
;; C-c C-x p -- Set a property
;; C-c C-c d -- Remove a property
;; ====== Timestamps ========
;; C-c . -- Set a timestamp
;; S-LEFT/S-Right -- Change by one day
;; ====== Footnotes =========
;; C-c f prefix
;; C-c C-c -- jump between definition and reference

;; +strike-through+
;; =============================
;; Here is an small example
;;  : Some example from a text file.
;; =============================
;; #+INCLUDE: "~/.emacs" src emacs-lisp
;;

;;; Code:

(defun cc/org-set-backends ()
  (setq-local company-backends
              '((company-capf company-yasnippet company-ispell
                              :separate)))
  (setq-local company-minimum-prefix-length 2))

(defun cc/org-mode-hook-function ()
  (flyspell-mode-on)
  (org-indent-mode -1)
  (variable-pitch-mode 1)
  (auto-fill-mode -1)
  (visual-line-mode 1)
  (cc/org-set-backends))

(use-package org
  :commands org-mode
  :hook
  (org-mode . cc/org-mode-hook-function)
  :custom
  (org-ellipsis " ▾")
  ;; (org-hide-emphasis-markers t)
  :bind
  (:map org-mode-map
   ("M-S-<return>" . org-table-copy-down)
   ("S-<return>" . org-insert-todo-heading)
   ("C-c m s" . org-insert-structure-template) ; or C-c C-, by default
   ("C-c m p" . org-set-property)
   ("C-c m P" . org-set-property-and-value)
   ("C-c C-f" . nil) ; conflict with recentf-open-files
   )
  :config
  (which-key-add-keymap-based-replacements org-mode-map "C-c \"" "org-plot")
  (dolist (face '((org-level-1 . 1.3)
          (org-level-2 . 1.15)
          (org-level-3 . 1.1)
          (org-level-4 . 1.0)
          (org-level-5 . 1.0)
          (org-level-6 . 1.0)
          (org-level-7 . 1.0)
          (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Hack" :weight 'bold :height (cdr face)))

  ;; org-babel structure template
  ;; Tips: C-c C-c to execute src block
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)))
  (setq org-confirm-babel-evaluate nil)
  ;; (require 'org-tempo) ; use '<s' TAB to add a src block
  (dolist (lang '(("py" . "src python") ; default :results value
          ("pyo" . "src python :results output")
          ("cpp" . "src cpp")
          ("bash" . "src bash")
          ("elisp" . "src emacs-lisp")))
    (add-to-list 'org-structure-template-alist lang)))


(require 'org-indent)
;; Ensure that anything that should be fixed-pitch in Org files appears that way
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-table nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
;; (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

;; Hint: M-x describe-face org- TAB

;; visual-fill-mode
(use-package visual-fill-column
  :custom
  (visual-fill-column-width 100)
  ;; (visual-fill-column-center-text t)
  :hook (visual-line-mode . visual-fill-column-mode))

;; anki-editor
(use-package
  anki-editor
  :after org
  :ensure-system-package anki
  :custom
  (anki-editor-create-decks t)
  :init (which-key-add-keymap-based-replacements org-mode-map "C-c m a" "anki-editor")
  :bind
  (:map org-mode-map
   ("C-c m a p" . anki-editor-push-notes)
   ("C-c m a i" . anki-editor-insert-note)
   ("C-c m a c" . anki-editor-cloze-dwim)))

;; TODO:
;; org-transclusion
;; org-tree-slide
;; org-babel-tangle

(use-package
  pdf-tools
  :custom
  (pdf-view-display-size 'fit-page)
  (pdf-view-resize-factor 1.1)
  (pdf-annot-activate-created-annotations t)
  (pdf-view-use-scaling t)
  (pdf-view-use-imagemagick nil)
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-loader-install)
  :bind
  (:map pdf-annot-minor-mode-map
        ("C-c h" . pdf-annot-add-highlight-markup-annotation)
        ("C-c t" . pdf-annot-add-text-annotation)
        ("C-c d" . pdf-annot-delete)
        ))

(provide 'cc-org)

;;; cc-org.el ends here
