;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

;; 個人設定
(setq auto-save-default nil)

(leaf doom-themes
  :ensure t
  :config
  (load-theme 'doom-molokai t))

;; <ddskk>
(leaf ddskk
  :ensure t
  :bind
    (("C-x C-j" . skk-mode)
     ("C-x j"   . skk-auto-fill-mode))
  :custom
  (skk-japanese-message-and-error . t)
  (skk-show-japanese-menu . t))
(setq default-input-method "japanese-skk")
;; </ddskk>
