;;; ============================================================
;;; *scratch*バッファを kill できないように
;;; ============================================================
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    (set-buffer (get-buffer-create "*scratch*")) ; "*scratch*" を作成して
    (funcall initial-major-mode)        ; buffer-list に放り込む
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))
(defun my-buffer-name-list ()
  (mapcar (function buffer-name) (buffer-list)))
;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
(add-hook 'kill-buffer-query-functions
          (function (lambda ()
                      (if (string= "*scratch*" (buffer-name))
                          (progn (my-make-scratch 0) nil)
                        t))))
(add-hook 'after-save-hook     ;; *scratch* バッファの内容を保存したら
          (function (lambda () ;; *scratch* バッファを新しく作る
                      (unless (member "*scratch*" (my-buffer-name-list))
                        (my-make-scratch 1)))))
