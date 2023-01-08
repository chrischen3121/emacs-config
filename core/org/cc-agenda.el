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

(setq org-agenda-files
      (directory-files-recursively cc/agenda-home-dir ".org$")
      org-deadline-warning-days 3
      org-clock-out-remove-zero-time-clocks t
      org-clock-out-when-done t
      org-agenda-start-with-log-mode t
      org-log-done 'time
      org-log-into-drawer t)

(provide 'cc-agenda)

;;; cc-agenda.el ends here
