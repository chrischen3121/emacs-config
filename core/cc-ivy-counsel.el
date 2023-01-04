(use-package swiper
  :commands swiper)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-backward-delete-char)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode 1))

;; counsel
(use-package
  counsel
  :bind (:map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :init (counsel-mode 1))

;; helpful
(use-package
  helpful
  :after counsel
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind (:map counsel-mode-map
	 ([remap describe-key] . helpful-key)
	 ([remap describe-symbol] . helpful-symbol)
	 ([remap describe-command] . helpful-command)
	 :map emacs-lisp-mode-map ("C-c d" . helpful-at-point)))

(use-package ivy-rich
  :after (ivy counsel)
  :init
  (ivy-rich-mode 1))

;; Improved Candidate Sorting with prescient.el
(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; to have sorting remembered across sessions!
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(provide 'cc-ivy-counsel)
