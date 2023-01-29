;; -*- no-byte-compile: t; -*-
;;; lang/elixir/packages.el

;; +elixir.el

(package! elixir-ts-mode :pin "4c823af9be5739eacff203f0e3f331b7d754c340")
(package! exunit :pin "0715c2dc2dca0b56c61330eda0690f90cca5f98b")
(package! elixir-format
  :recipe (:host github :repo "elixir-editors/emacs-elixir" :files ("elixir-format.el"))
  :pin "e0d0466d83ec80ddb412bb1473908a21baad1ec3")
