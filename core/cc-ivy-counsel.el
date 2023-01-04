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

(use-package
  counsel
  :bind (:map minibuffer-local-map
	      ("C-r" . 'counsel-minibuffer-history))
  :init (counsel-mode 1))

(use-package ivy-rich
  :after (ivy counsel)
  :init
  (ivy-rich-mode 1))

(provide 'cc-ivy-counsel)
