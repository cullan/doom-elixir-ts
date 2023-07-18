;; -*- no-byte-compile: t; -*-
;;; lang/elixir/packages.el

;; +elixir.el

(package! elixir-ts-mode :pin "6862c3c2bcaf4df48fb105eee6d8a443d19f0c5c")
(package! exunit :pin "0715c2dc2dca0b56c61330eda0690f90cca5f98b")
(package! elixir-format
  :recipe (:host github :repo "elixir-editors/emacs-elixir" :files ("elixir-format.el"))
  :pin "00d6580a040a750e019218f9392cf9a4c2dac23a")
