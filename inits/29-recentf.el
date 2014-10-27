;;; ==================================================================
;;; recentf-mode 最近使ったファイルを保存
;;;       (M-x recentf-open-filesで開く)
;;; ==================================================================
(recentf-mode)
;; (define-key ctl-x-map "O" 'recentf-open-files)
(setq recentf-max-menu-items 200)
(setq recentf-max-saved-items 3000)
