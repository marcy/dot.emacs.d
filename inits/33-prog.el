;;; ==================================================================
;;;             css
;;; ==================================================================
(setq cssm-indent-level 2)
(setq cssm-indent-function #'cssm-c-style-indenter) ;; インデントをまともに

(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(add-to-list 'auto-mode-alist '("\\.css$" . scss-mode))

;; インデント幅を2にする
;; コンパイルは compass watchで行うので自動コンパイルをオフ
(defun scss-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil)
   )
  )
(add-hook 'scss-mode-hook
          '(lambda() (scss-custom)))

;;; ==================================================================
;;;             markdown
;;; ==================================================================
(setq auto-mode-alist (append
                       auto-mode-alist
                       (list
                        '("\\.md" . markdown-mode)
                        '("\\.markdown" . markdown-mode)
                        )))

;;; ==================================================================
;;;             c
;;; ==================================================================
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; カーソルの位置にデバッグ用のprintfを挿入 (C-c d)
(defun my-insert-printf-debug ()
  (interactive)
  (insert-string "printf(\"%s %s:%d\\n\", __func__, __FILE__, __LINE__);")
  (indent-according-to-mode))
(add-hook 'c-mode-hook
          (function (lambda ()
                      (define-key c-mode-map (kbd "C-c d") 'my-insert-printf-debug))))

(add-hook 'c++-mode-hook
          '(lambda()
             (setq indent-tabs-mode t)
             (setq indent-level 4)
             (setq c++-indent 4)
             (indent-tabs-mode nil)
             (setq tab-width 4)))

;;; ==================================================================
;;;           javascript
;;; ==================================================================
(setq js-indent-level 2)

;;; ==================================================================
;;;             coffee
;;; ==================================================================
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;;; ==================================================================
;;;             ruby
;;; ==================================================================
;; from http://d.hatena.ne.jp/akm/20080605#1212644489
(require 'ruby-mode)
(defun ruby-mode-set-encoding () ())

(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append
       (list (cons "\\.rb$" 'ruby-mode))
       (list (cons "\\.rake$" 'ruby-mode))
       (list (cons "\\.racc$" 'ruby-mode))
       (list (cons "\\.jbuilder$" 'ruby-mode))
       (list (cons "Gemfile" 'ruby-mode))
       (list (cons "Capfile" 'ruby-mode))
       (list (cons "Rakefile" 'ruby-mode))
       auto-mode-alist))
(setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")

;; ruby-modeのインデントを改良する
(setq ruby-deep-indent-paren-style nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; --------------------------------------------------
;; ruby-end
;; endや括弧などを自動挿入する
;; http://blog.livedoor.jp/ooboofo3/archives/53748087.html
;; --------------------------------------------------
(require 'ruby-end)
(add-hook 'ruby-mode-hook
  '(lambda ()
    (abbrev-mode 1)
    (electric-pair-mode t)
    (electric-indent-mode t)
    (electric-layout-mode t)))

;; --------------------------------------------------
;; ruby-block
;; endにカーソルを合わせると、そのendに対応する行をハイライトする
;; --------------------------------------------------
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; シンボルをハイライト表示
;(require 'auto-highlight-symbol-config)
(require 'highlight-symbol)
(setq highlight-symbol-colors '("DarkOrange" "DodgerBlue1" "DeepPink1"))

(global-set-key (kbd "") 'highlight-symbol-at-point)

;; --------------------------------------------------
;;         rspec
;; --------------------------------------------------
(require 'rspec-mode)
(eval-after-load 'rspec-mode
  '(rspec-install-snippets))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rubocop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rubocop)
(add-hook 'ruby-mode-hook 'rubocop-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flycheck-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-hook 'after-init-hook #'global-flycheck-mode)
(require 'flycheck)
(add-hook 'ruby-mode-hook 'flycheck-mode)
(flycheck-define-checker ruby-rubocop
  "A Ruby syntax and style checker using the RuboCop tool.

See URL `http://batsov.com/rubocop/'."
  :command ("rubocop" "--format" "emacs" "--silent"
            (config-file "--config" flycheck-rubocoprc)
            source)
  :error-patterns
  ((warning line-start
            (file-name) ":" line ":" column ": " (or "C" "W") ": " (message)
            line-end)
   (error line-start
          (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
          line-end))
  :modes (enh-ruby-mode motion-mode))

;;; ==================================================================
;;;                go
;;; ==================================================================
(require 'go-mode)
(add-hook 'go-mode-hook
      '(lambda ()
         (setq tab-width 2)
         (setq standard-indent 2)
         (setq indent-tabs-mode nil)
         ))
