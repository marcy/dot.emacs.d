;; auto complete
(when (require 'auto-complete nil t)
  (global-auto-complete-mode t)
  (setq ac-dwim nil)
  ;(set-face-background 'ac-selection-face "steelblue")
  ;(set-face-background 'ac-menu-face "skyblue")
  (setq ac-auto-start t)
  (global-set-key "\M-/" 'ac-start)
  (setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer))
  (add-hook 'ruby-mode-hook
            (lambda ()
              (require 'rcodetools)
              (make-local-variable 'ac-omni-completion-sources)
              (setq ac-omni-completion-sources '(("\\.\\=" . (ac-source-rcodetools)))))))

(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)