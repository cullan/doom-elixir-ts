;; -*- no-byte-compile: t; -*-
;;; lang/elixir/packages.el

;; +elixir.el

;; https://github.com/wkirschbaum/elixir-ts-mode
(package! elixir-ts-mode :pin "23fc038fa783aa0e4d03139c39b98789f439378b")
;; https://github.com/ananthakumaran/exunit.el
(package! exunit :pin "e008c89e01e5680473278c7e7bab42842e294e4d")
;; https://github.com/elixir-editors/emacs-elixir
(package! elixir-format
  :recipe (:host github :repo "elixir-editors/emacs-elixir" :files ("elixir-format.el"))
  :pin "00d6580a040a750e019218f9392cf9a4c2dac23a")
