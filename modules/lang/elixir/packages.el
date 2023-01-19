;; -*- no-byte-compile: t; -*-
;;; lang/elixir/packages.el

;; +elixir.el

(package! elixir-ts-mode :pin "c9aef25863433f14f569afaa0cb907b269a1e79d")
(package! exunit :pin "0715c2dc2dca0b56c61330eda0690f90cca5f98b")
(package! elixir-format
  :recipe (:host github :repo "elixir-editors/emacs-elixir" :files ("elixir-format.el"))
  :pin "e0d0466d83ec80ddb412bb1473908a21baad1ec3")
