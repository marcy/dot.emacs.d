(load "~/.emacs.d/site-lisp/mozc.el")
(setq default-input-method "japanese-mozc")
(setq mozc-helper-program-name "mozc_emacs_helper")

(require 'ac-mozc)
(define-key ac-mode-map (kbd "C-c C-SPC") 'ac-complete-mozc)
