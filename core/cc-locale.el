;;; cc-locale.el

;; Author: Chris Chen
;; Maintainer: Chris Chen

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

;;; Code:

(setq calendar-chinese-all-holidays-flag t)

;; Fonts
(prefer-coding-system 'utf-8)

(set-face-attribute 'default nil
		    :font "Hack" :height cc/default-font-size)

(set-face-attribute 'fixed-pitch nil
		    :font "WenQuanyi Micro Hei Mono" :height cc/default-font-size)

(set-face-attribute 'variable-pitch nil
		    :font "Hack"
		    :height cc/default-variable-font-size
		    :weight 'regular)

(set-fontset-font t 'emoji
		  (font-spec :family "Noto Color Emoji" :height cc/default-font-size))

(set-fontset-font t 'han
		  (font-spec :family "WenQuanyi Micro Hei Mono" :height cc/default-font-size))

(provide 'cc-locale)

;;; cc-locale.el ends here
