;;; keybind
(define-key global-map "\C-h" 'delete-backward-char) ; C-h で BS
(global-set-key "\C-ch" 'help-for-help)              ; C-ch でヘルプ
(define-key global-map "\C-c;" 'comment-region)      ; コメントアウト
(define-key global-map "\C-c:" 'uncomment-region)    ; コメント解除
(define-key global-map "\C-c\C-u" 'universal-argument)

;; ファイル保存時に行末の空行消す
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; goto-line
(define-key global-map "\C-xl" 'goto-line)

;; バッファ自動再読み込み
(global-auto-revert-mode 1)

;; emacs-server
(global-set-key (kbd "C-x C-c") 'server-edit)
