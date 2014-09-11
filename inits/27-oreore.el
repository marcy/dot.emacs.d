;; カレントバッファ全部 evernote へ
(defun toevernote ()
  (interactive)
  (shell-command (concat "/Users/masashi_oyamada/Dropbox/bin/toevernote.rb " (buffer-file-name))))
