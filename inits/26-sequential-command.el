;;; ==================================================================
;;; http://d.hatena.ne.jp/rubikitch/20090219/sequential_command
;;; 同じコマンドを連続実行することで挙動を変える（行頭→先頭など） sequential-command.el
;;; ==================================================================
(require 'sequential-command-config)
(global-set-key "\C-a" 'seq-home)
(global-set-key "\C-e" 'seq-end)
(when (require 'org nil t)
  (define-key org-mode-map "\C-a" 'org-seq-home)
  (define-key org-mode-map "\C-e" 'org-seq-end))
(define-key esc-map "u" 'seq-upcase-backward-word)
(define-key esc-map "c" 'seq-capitalize-backward-word)
(define-key esc-map "l" 'seq-downcase-backward-word)
