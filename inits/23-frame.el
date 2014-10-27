(column-number-mode 1)          ; カーソルの位置が何文字目かを表示する
(line-number-mode 1)            ; カーソルの位置が何行目かを表示する

(unless (eq window-system nil)
  (progn
    (menu-bar-mode nil)        ; メニューバーなし
    (tool-bar-mode -1)         ; ツールバーなし
    (set-scroll-bar-mode nil)  ; スクロールバーなし
    ))

;; color
(show-paren-mode t)                     ; 括弧に色
(setq show-paren-style 'parenthesis)
(global-font-lock-mode t)               ; 字に色

;;; リージョンの色
(transient-mark-mode t)                 ; リージョンに色
;(set-face-background 'region "SkyBlue")
;(set-face-foreground 'region "black")

;;; 右端で折り返さない
(setq truncate-lines nil)

;; 分割したウィンドウでも右端で折り返さない
(setq truncate-partial-width-windows nil)

;;; タブではなくスペースを使う
(setq-default indent-tabs-mode nil)

;;; カレント行をハイライトする際の色
(require 'highlight-current-line)
(highlight-current-line-on t)
;; To customize the background color
(set-face-background 'highlight-current-line-face "gray18")

;;; ============================================================
;;;    Cocoa Emacsのフォントセットを定義
;;; ============================================================
;; Fonts
(when (eq window-system 'ns)
  (let ((my-font-height 120)
        (my-font (cond
                  (nil "Monaco")  ;; XCode 3.1 で使っているフォント
                  (t "Menlo")     ;; XCode 3.2 で使ってるフォント
                  ))
        (my-font-ja "Hiragino Maru Gothic Pro"))
    (setq mac-allow-anti-aliasing t)

    ;; フォントサイズの微調節 (12ptで合うように)
    (setq face-font-rescale-alist
          '(("^-apple-hiragino.*" . 1.2)
            (".*osaka-bold.*" . 1.2)
            (".*osaka-medium.*" . 1.2)
            (".*courier-bold-.*-mac-roman" . 1.0)
            (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
            (".*monaco-bold-.*-mac-roman" . 0.9)
            ("-cdac$" . 1.3)))

    ;; デフォルトフォント設定
    (when my-font
      (set-face-attribute 'default nil :family my-font :height my-font-height)
      ;;(set-frame-font (format "%s-%d" my-font (/ my-font-height 10)))
      )

    ;; 日本語文字に別のフォントを指定
    (when my-font-ja
      (let ((fn (frame-parameter nil 'font))
            (rg "iso10646-1"))
        (set-fontset-font fn 'katakana-jisx0201 `(,my-font-ja . ,rg))
        (set-fontset-font fn 'japanese-jisx0208 `(,my-font-ja . ,rg))
        (set-fontset-font fn 'japanese-jisx0212 `(,my-font-ja . ,rg))))))

;;; ============================================================
;;;             frame
;;; ============================================================
(when (eq window-system 'ns)
  ;; 透明に
  (set-frame-parameter nil 'alpha '(90 75)))

;;; ============================================================
;;;               replace-colorthemes
;;; ============================================================
;; https://github.com/emacs-jp/replace-colorthemes
(add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/replace-colorthemes"))
(load-theme 'dark-laptop t t)
(enable-theme 'dark-laptop)
