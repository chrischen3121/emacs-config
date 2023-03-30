;;; cc-var-define.el --- Define Variables

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

(defcustom cc/default-font-size 180
  "Adjust this font size for your system."
  :type 'integer
  :group 'cc-config)

(defcustom cc/default-variable-font-size 180
  "Adjust this font size for your system."
  :type 'integer
  :group 'cc-config)

(defcustom cc/frame-transparency '(90 . 90)
  "Make frame transparency overridable."
  :type '(cons integer integer)
  :group 'cc-config)

(defcustom cc/agenda-home-dir "~/TODOs"
  "Agenda home directory"
  :type 'string
  :group 'cc-agenda-config)

(defcustom cc/org-quicknotes-filename "quicknotes.org"
  "Agenda quicknotes filename"
  :type 'string
  :group 'cc-agenda-config)

(defcustom cc/org-todo-filename "todo.org"
  "Agenda todo filename"
  :type 'string
  :group 'cc-agenda-config)

(defcustom cc/org-journal-filename "journal.org"
  "Agenda journal filename"
  :type 'string
  :group 'cc-agenda-config)

(defcustom cc/org-habits-filename "habits.org"
  "Agenda habits filename"
  :type 'string
  :group 'cc-agenda-config)

(defcustom cc/org-roam-directory "~/second-brain/pages"
  "org roam home directory"
  :type 'string
  :group 'cc-org-roam)

(defcustom cc/org-roam-dailies-directory "~/second-brain/journals"
  "org roam dailies directory"
  :type 'string
  :group 'cc-org-roam)

(defcustom cc/org-roam-db-location "~/second-brain/org-roam.db"
  "org roam db directory"
  :type 'string
  :group 'cc-org-roam)

(defcustom cc/org-roam-graph-viewer "google-chrome-stable"
  "executable to view org roam graph"
  :type 'string
  :group 'cc-org-roam)

(defcustom cc/zotero-bibtex-bib-file "~/Zotero/bibtex.bib"
  "zotero bibtex bib file"
  :type 'string
  :group 'cc-org-roam)

(defcustom cc/org-roam-reference-directory "~/second-brain/pages/references"
  "org roam reference directory"
  :type 'string
  :group 'cc-org-roam)

(provide 'cc-var-define)

;;; cc-var-define.el ends here
