;;; lang
(setenv "LANG" "C")
(setenv "LC_TIME" "C")
(setenv "LC_MESSAGE" "C")
(setenv "LC_CTYPE" "C")
(setenv "LC_MONETARY" "C")
(set-language-environment "Japanese")

;;; utf8
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
;(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;; my name, email
(setq user-full-name "Masashi Oyamada")
(setq user-mail-address "masashi.oyamada@gmail.com")

;; metaタグの内容で文字コードを自動判別しないように設定
(setq auto-coding-functions nil)

;;; server mode で起動
(load-library "server")(server-start)
(defalias 'exit 'save-buffers-kill-emacs)

;;; ==================================================================
;;;  スクリプトを保存する時，自動的に chmod +x を行なうようにする
;;; ==================================================================
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
        (let ((name (buffer-file-name)))
          (or (equal ?. (string-to-char (file-name-nondirectory name)))
              (let ((mode (file-modes name)))
                (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                (message (concat "Wrote " name " (+x)"))))))))
(add-hook 'after-save-hook 'make-file-executable)
