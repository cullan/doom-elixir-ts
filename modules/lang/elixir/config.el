;;; lang/elixir/config.el -*- lexical-bindinG

(after! projectile
  (add-to-list 'projectile-project-root-files "mix.exs"))

;;
;;; Packages

(use-package! elixir-ts-mode
  :defer t
  :init
  ;; Disable default smartparens config. There are too many pairs; we only want
  ;; a subset of them (defined below).
  (provide 'smartparens-elixir)
  :config
  ;; ...and only complete the basics
  (sp-with-modes 'elixir-ts-mode
    (sp-local-pair "do" "end"
                   :when '(("RET" "<evil-ret>"))
                   :unless '(sp-in-comment-p sp-in-string-p)
                   :post-handlers '("||\n[i]"))
    (sp-local-pair "do " " end" :unless '(sp-in-comment-p sp-in-string-p))
    (sp-local-pair "fn " " end" :unless '(sp-in-comment-p sp-in-string-p)))

  (set-ligatures! 'elixir-ts-mode
    ;; Functional
    :def "def"
    :lambda "fn"
    ;; :src_block "do"
    ;; :src_block_end "end"
    ;; Flow
    :not "!"
    :in "in" :not-in "not in"
    :and "and" :or "or"
    :for "for"
    :return "return" :yield "use")

  (when (modulep! +lsp)
    (add-hook 'elixir-ts-mode-local-vars-hook #'lsp! 'append)
    (add-hook 'heex-ts-mode #'lsp 'append)
    (after! lsp-mode
      (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]_build\\'")
      (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\deps\\'")
      (setq lsp-language-id-configuration
            (append lsp-language-id-configuration
                    '((elixir-ts-mode . "elixir")
                      (heex-ts-mode . "elixir"))))))

  ;; run elixir credo after lsp
  (when (and (modulep! +lsp) (modulep! :checkers syntax))
    (add-hook! 'elixir-ts-mode-local-vars-hook :append
      (add-hook! 'flycheck-mode-hook :local
        (flycheck-add-next-checker 'lsp '(warning . elixir-credo)))))

  (after! highlight-numbers
    (puthash 'elixir-ts-mode
             "\\_<-?[[:digit:]]+\\(?:_[[:digit:]]\\{3\\}\\)*\\_>"
             highlight-numbers-modelist)))


(when (modulep! :checkers syntax)
  (after! flycheck
    (flycheck-define-checker elixir-credo
      "An Elixir checker for static code analysis using Credo.
See `http://credo-ci.org/'."
      :command ("mix" "credo"
                (option-flag "--strict" flycheck-elixir-credo-strict)
                "--format" "flycheck"
                "--read-from-stdin" source-original)
      :standard-input t
      :working-directory flycheck-credo--working-directory
      :enabled flycheck-credo--working-directory
      :error-patterns
      ((info line-start
             (file-name) ":" line (optional ":" column) ": "
             (or "F" "R" "C")  ": " (message) line-end)
       (warning line-start
                (file-name) ":" line (optional ":" column) ": "
                (or "D" "W")  ": " (message) line-end))
      :modes elixir-ts-mode)

    (add-to-list 'flycheck-checkers 'elixir-credo t)))


(use-package! elixir-format
  :config
  (map! :after elixir-ts-mode
        :localleader
        :map elixir-ts-mode-map
        "f" #'elixir-format))


(use-package! exunit
  :hook (elixir-ts-mode . exunit-mode)
  :init
  (map! :after elixir-ts-mode
        :localleader
        :map elixir-ts-mode-map
        :prefix ("t" . "test")
        "a" #'exunit-verify-all
        "r" #'exunit-rerun
        "v" #'exunit-verify
        "T" #'exunit-toggle-file-and-test
        "t" #'exunit-toggle-file-and-test-other-window
        "s" #'exunit-verify-single))
