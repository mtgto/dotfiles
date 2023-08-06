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
(leaf leaf
  :custom
  ((inhibit-splash-screen . t)
   (initial-scratch-message . nil)
   (auto-save-default . nil)
   (tool-bar-mode . nil)
   (menu-bar-mode . nil))
   :config
   (define-key key-translation-map (kbd "C-h") (kbd "<DEL>")))

(leaf *line-number
  :if (version<= "27.0.0" emacs-version)
  :custom
  (display-line-numbers-width-start . t)
  :config
  (global-display-line-numbers-mode t))

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
